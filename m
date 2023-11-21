Return-Path: <netdev+bounces-49639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176C27F2D2D
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EC0282981
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0264A9A3;
	Tue, 21 Nov 2023 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B457197;
	Tue, 21 Nov 2023 04:28:42 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1r5Prt-0005CT-7q; Tue, 21 Nov 2023 13:28:41 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: lorenzo@kernel.org,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 5/8] netfilter: nf_tables: reject flowtable hw offload for same device
Date: Tue, 21 Nov 2023 13:27:48 +0100
Message-ID: <20231121122800.13521-6-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121122800.13521-1-fw@strlen.de>
References: <20231121122800.13521-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing check is not sufficient, as it only considers flowtables
within the same table.

In case of HW offload, we need check all flowtables that exist in
the same net namespace.

We can skip flowtables that are slated for removal (not active
in next gen).

Ideally this check would supersede the existing one, but this is
probably too risky and might prevent existing configs from working.

As is, you can do all of the following:

table ip t { flowtable f { devices = { lo  } } }
table ip6 t { flowtable f { devices = { lo  } } }
table inet t { flowtable f { devices = { lo  } } }

... but IMO this should not be possible in the first place.

Disable this for HW offload.

This is related to XDP flowtable work, the idea is to keep a small
hashtable that has a 'struct net_device := struct nf_flowtable' map.

This mapping must be unique.  The idea is to add a "XDP OFFLOAD"
flag to nftables api and then have this function run for 'xdp offload'
case too.

This is useful, because it would permit the "xdp offload" hashtable
to tolerate duplicate keys -- they would only occur during transactional
updates, e.g. a flush of the current table combined with atomic reload.

Without this change, the nf_flowtable core cannot tell when flowtable
is a real duplicate, or just a temporary artefact of the
two-phase-commit protocol (i.e., the clashing entry is queued for removal).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e779e275d694..7437b997ca7e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8189,6 +8189,37 @@ static void nft_unregister_flowtable_net_hooks(struct net *net,
 	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
 }
 
+static bool nft_flowtable_offload_clash(struct net *net,
+					const struct nft_hook *hook,
+					struct nft_flowtable *flowtable)
+{
+	const struct nftables_pernet *nft_net;
+	struct nft_flowtable *existing_ft;
+	const struct nft_table *table;
+
+	/* No offload requested, no need to validate */
+	if (!nf_flowtable_hw_offload(flowtable->ft))
+		return false;
+
+	nft_net = nft_pernet(net);
+
+	list_for_each_entry(table, &nft_net->tables, list) {
+		list_for_each_entry(existing_ft, &table->flowtables, list) {
+			const struct nft_hook *hook2;
+
+			if (!nft_is_active_next(net, existing_ft))
+				continue;
+
+			list_for_each_entry(hook2, &existing_ft->hook_list, list) {
+				if (hook->ops.dev == hook2->ops.dev)
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int nft_register_flowtable_net_hooks(struct net *net,
 					    struct nft_table *table,
 					    struct list_head *hook_list,
@@ -8199,6 +8230,11 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 	int err, i = 0;
 
 	list_for_each_entry(hook, hook_list, list) {
+		if (nft_flowtable_offload_clash(net, hook, flowtable)) {
+			err = -EEXIST;
+			goto err_unregister_net_hooks;
+		}
+
 		list_for_each_entry(ft, &table->flowtables, list) {
 			if (!nft_is_active_next(net, ft))
 				continue;
-- 
2.41.0


