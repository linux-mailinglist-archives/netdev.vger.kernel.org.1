Return-Path: <netdev+bounces-39591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6A7BFFC8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCED8281CB7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B85D250F8;
	Tue, 10 Oct 2023 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DCE24C7D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:19 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC388B7;
	Tue, 10 Oct 2023 07:54:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7g-0001Pt-2c; Tue, 10 Oct 2023 16:54:12 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 6/8] netfilter: conntrack: simplify nf_conntrack_alter_reply
Date: Tue, 10 Oct 2023 16:53:36 +0200
Message-ID: <20231010145343.12551-7-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010145343.12551-1-fw@strlen.de>
References: <20231010145343.12551-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

nf_conntrack_alter_reply doesn't do helper reassignment anymore.
Remove the comments that make this claim.

Furthermore, remove dead code from the function and place ot
in nf_conntrack.h.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack.h | 14 ++++++++++----
 net/netfilter/nf_conntrack_core.c    | 18 ------------------
 net/netfilter/nf_conntrack_helper.c  |  7 +------
 3 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 4085765c3370..cba3ccf03fcc 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -160,10 +160,6 @@ static inline struct net *nf_ct_net(const struct nf_conn *ct)
 	return read_pnet(&ct->ct_net);
 }
 
-/* Alter reply tuple (maybe alter helper). */
-void nf_conntrack_alter_reply(struct nf_conn *ct,
-			      const struct nf_conntrack_tuple *newreply);
-
 /* Is this tuple taken? (ignoring any belonging to the given
    conntrack). */
 int nf_conntrack_tuple_taken(const struct nf_conntrack_tuple *tuple,
@@ -284,6 +280,16 @@ static inline bool nf_is_loopback_packet(const struct sk_buff *skb)
 	return skb->dev && skb->skb_iif && skb->dev->flags & IFF_LOOPBACK;
 }
 
+static inline void nf_conntrack_alter_reply(struct nf_conn *ct,
+					    const struct nf_conntrack_tuple *newreply)
+{
+	/* Must be unconfirmed, so not in hash table yet */
+	if (WARN_ON(nf_ct_is_confirmed(ct)))
+		return;
+
+	ct->tuplehash[IP_CT_DIR_REPLY].tuple = *newreply;
+}
+
 #define nfct_time_stamp ((u32)(jiffies))
 
 /* jiffies until ct expires, 0 if already expired */
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 9f6f2e643575..124136b5a79a 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2042,24 +2042,6 @@ nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_in);
 
-/* Alter reply tuple (maybe alter helper).  This is for NAT, and is
-   implicitly racy: see __nf_conntrack_confirm */
-void nf_conntrack_alter_reply(struct nf_conn *ct,
-			      const struct nf_conntrack_tuple *newreply)
-{
-	struct nf_conn_help *help = nfct_help(ct);
-
-	/* Should be unconfirmed, so not in hash table yet */
-	WARN_ON(nf_ct_is_confirmed(ct));
-
-	nf_ct_dump_tuple(newreply);
-
-	ct->tuplehash[IP_CT_DIR_REPLY].tuple = *newreply;
-	if (ct->master || (help && !hlist_empty(&help->expectations)))
-		return;
-}
-EXPORT_SYMBOL_GPL(nf_conntrack_alter_reply);
-
 /* Refresh conntrack for this many jiffies and do accounting if do_acct is 1 */
 void __nf_ct_refresh_acct(struct nf_conn *ct,
 			  enum ip_conntrack_info ctinfo,
diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index f22691f83853..4ed5878cb25b 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -194,12 +194,7 @@ int __nf_ct_try_assign_helper(struct nf_conn *ct, struct nf_conn *tmpl,
 	struct nf_conntrack_helper *helper = NULL;
 	struct nf_conn_help *help;
 
-	/* We already got a helper explicitly attached. The function
-	 * nf_conntrack_alter_reply - in case NAT is in use - asks for looking
-	 * the helper up again. Since now the user is in full control of
-	 * making consistent helper configurations, skip this automatic
-	 * re-lookup, otherwise we'll lose the helper.
-	 */
+	/* We already got a helper explicitly attached (e.g. nft_ct) */
 	if (test_bit(IPS_HELPER_BIT, &ct->status))
 		return 0;
 
-- 
2.41.0


