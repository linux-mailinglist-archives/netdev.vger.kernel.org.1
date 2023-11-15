Return-Path: <netdev+bounces-48166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31677ECABF
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9FB1F28410
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48913BB48;
	Wed, 15 Nov 2023 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75A0710CE;
	Wed, 15 Nov 2023 10:45:23 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 6/6] netfilter: nf_tables: split async and sync catchall in two functions
Date: Wed, 15 Nov 2023 19:45:14 +0100
Message-Id: <20231115184514.8965-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231115184514.8965-1-pablo@netfilter.org>
References: <20231115184514.8965-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

list_for_each_entry_safe() does not work for the async case which runs
under RCU, therefore, split GC logic for catchall in two functions
instead, one for each of the sync and async GC variants.

The catchall sync GC variant never sees a _DEAD bit set on ever, thus,
this handling is removed in such case, moreover, allocate GC sync batch
via GFP_KERNEL.

Fixes: 93995bf4af2c ("netfilter: nf_tables: remove catchall element in GC sync path")
Reported-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 55 +++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index debea1c67701..c0a42989b982 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9680,16 +9680,14 @@ void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
 	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
 }
 
-static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
-						  unsigned int gc_seq,
-						  bool sync)
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq)
 {
-	struct nft_set_elem_catchall *catchall, *next;
+	struct nft_set_elem_catchall *catchall;
 	const struct nft_set *set = gc->set;
-	struct nft_elem_priv *elem_priv;
 	struct nft_set_ext *ext;
 
-	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
+	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
 		if (!nft_set_elem_expired(ext))
@@ -9699,35 +9697,42 @@ static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
 
 		nft_set_elem_dead(ext);
 dead_elem:
-		if (sync)
-			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
-		else
-			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
-
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
 		if (!gc)
 			return NULL;
 
-		elem_priv = catchall->elem;
-		if (sync) {
-			nft_setelem_data_deactivate(gc->net, gc->set, elem_priv);
-			nft_setelem_catchall_destroy(catchall);
-		}
-
-		nft_trans_gc_elem_add(gc, elem_priv);
+		nft_trans_gc_elem_add(gc, catchall->elem);
 	}
 
 	return gc;
 }
 
-struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
-						 unsigned int gc_seq)
-{
-	return nft_trans_gc_catchall(gc, gc_seq, false);
-}
-
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
-	return nft_trans_gc_catchall(gc, 0, true);
+	struct nft_set_elem_catchall *catchall, *next;
+	const struct nft_set *set = gc->set;
+	struct nft_elem_priv *elem_priv;
+	struct nft_set_ext *ext;
+
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net));
+
+	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+
+		if (!nft_set_elem_expired(ext))
+			continue;
+
+		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
+		if (!gc)
+			return NULL;
+
+		elem_priv = catchall->elem;
+		nft_setelem_data_deactivate(gc->net, gc->set, elem_priv);
+		nft_setelem_catchall_destroy(catchall);
+		nft_trans_gc_elem_add(gc, elem_priv);
+	}
+
+	return gc;
 }
 
 static void nf_tables_module_autoload_cleanup(struct net *net)
-- 
2.30.2


