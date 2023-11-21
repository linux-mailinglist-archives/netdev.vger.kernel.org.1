Return-Path: <netdev+bounces-49642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295A7F2D32
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A42B21A62
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E014A9B2;
	Tue, 21 Nov 2023 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEC7126;
	Tue, 21 Nov 2023 04:28:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1r5Ps5-0005Da-El; Tue, 21 Nov 2023 13:28:53 +0100
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: lorenzo@kernel.org,
	<netdev@vger.kernel.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 8/8] netfilter: nf_tables: permit duplicate flowtable mappings
Date: Tue, 21 Nov 2023 13:27:51 +0100
Message-ID: <20231121122800.13521-9-fw@strlen.de>
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

The core ensures that no duplicate mapping (net_device x is always
assigned to exactly one flowtable, or none at all) exists.

Only exception: its assigned to a flowtable that is going away
in this transaction.

Therefore relax the existing check to permit the duplicate
entry, it is only temporary.

The existing entry will shadow the new one until the transaction
is committed (old entry is removed) or aborted (new entry is removed).

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_offload.c | 36 +++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 9ec7aa4ad2e5..b6503fd45871 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -49,13 +49,14 @@ static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
 {
 	unsigned long key = (unsigned long)dev;
 	struct flow_offload_xdp *cur;
+	bool duplicate = false;
 	int err = 0;
 
 	mutex_lock(&nf_xdp_hashtable_lock);
 	hash_for_each_possible(nf_xdp_hashtable, cur, hnode, key) {
 		if (key != cur->net_device_addr)
 			continue;
-		err = -EEXIST;
+		duplicate = true;
 		break;
 	}
 
@@ -67,7 +68,20 @@ static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
 			new->net_device_addr = key;
 			new->ft = ft;
 
-			hash_add_rcu(nf_xdp_hashtable, &new->hnode, key);
+			if (duplicate) {
+				u32 index = hash_min(key, HASH_BITS(nf_xdp_hashtable));
+
+				/* nf_tables_api.c makes sure that only a single flowtable
+				 * has this device.
+				 *
+				 * Only exception: the flowtable is about to be removed.
+				 * Thus we tolerate the duplicated entry, the 'old' entry
+				 * will be unhashed after the transaction completes.
+				 */
+				hlist_add_tail_rcu(&new->hnode, &nf_xdp_hashtable[index]);
+			} else {
+				hash_add_rcu(nf_xdp_hashtable, &new->hnode, key);
+			}
 		} else {
 			err = -ENOMEM;
 		}
@@ -80,7 +94,8 @@ static int nf_flowtable_by_dev_insert(struct nf_flowtable *ft,
 	return err;
 }
 
-static void nf_flowtable_by_dev_remove(const struct net_device *dev)
+static void nf_flowtable_by_dev_remove(const struct nf_flowtable *ft,
+				       const struct net_device *dev)
 {
 	unsigned long key = (unsigned long)dev;
 	struct flow_offload_xdp *cur;
@@ -92,6 +107,17 @@ static void nf_flowtable_by_dev_remove(const struct net_device *dev)
 		if (key != cur->net_device_addr)
 			continue;
 
+		/* duplicate entry, happens when current transaction
+		 * removes flowtable f1 and adds flowtable f2, where both
+		 * have *dev assigned to them.
+		 *
+		 * nf_tables_api.c makes sure that at most one
+		 * flowtable,dev pair with 'xdp' flag enabled can exist
+		 * in the same generation.
+		 */
+		if (cur->ft != ft)
+			continue;
+
 		hash_del_rcu(&cur->hnode);
 		kfree_rcu(cur, rcuhead);
 		found = true;
@@ -1280,7 +1306,7 @@ static int nf_flow_offload_xdp_setup(struct nf_flowtable *flowtable,
 	case FLOW_BLOCK_BIND:
 		return nf_flowtable_by_dev_insert(flowtable, dev);
 	case FLOW_BLOCK_UNBIND:
-		nf_flowtable_by_dev_remove(dev);
+		nf_flowtable_by_dev_remove(flowtable, dev);
 		return 0;
 	}
 
@@ -1297,7 +1323,7 @@ static void nf_flow_offload_xdp_cancel(struct nf_flowtable *flowtable,
 
 	switch (cmd) {
 	case FLOW_BLOCK_BIND:
-		nf_flowtable_by_dev_remove(dev);
+		nf_flowtable_by_dev_remove(flowtable, dev);
 		return;
 	case FLOW_BLOCK_UNBIND:
 		/* We do not re-bind in case hw offload would report error
-- 
2.41.0


