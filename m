Return-Path: <netdev+bounces-42158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84A7CD6FB
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BFB211D0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7815ACE;
	Wed, 18 Oct 2023 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BF156F0
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:51:32 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FEC6;
	Wed, 18 Oct 2023 01:51:31 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qt2H1-0006Jp-1f; Wed, 18 Oct 2023 10:51:27 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net-next 1/7] netfilter: xt_mangle: only check verdict part of return value
Date: Wed, 18 Oct 2023 10:51:05 +0200
Message-ID: <20231018085118.10829-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018085118.10829-1-fw@strlen.de>
References: <20231018085118.10829-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These checks assume that the caller only returns NF_DROP without
any errno embedded in the upper bits.

This is fine right now, but followup patches will start to propagate
such errors to allow kfree_skb_drop_reason() in the called functions,
those would then indicate 'errno << 8 | NF_STOLEN'.

To not break things we have to mask those parts out.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/netfilter/iptable_mangle.c  | 9 +++++----
 net/ipv6/netfilter/ip6table_mangle.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/netfilter/iptable_mangle.c b/net/ipv4/netfilter/iptable_mangle.c
index 3abb430af9e6..385d945d8ebe 100644
--- a/net/ipv4/netfilter/iptable_mangle.c
+++ b/net/ipv4/netfilter/iptable_mangle.c
@@ -36,12 +36,12 @@ static const struct xt_table packet_mangler = {
 static unsigned int
 ipt_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
 {
-	unsigned int ret;
+	unsigned int ret, verdict;
 	const struct iphdr *iph;
-	u_int8_t tos;
 	__be32 saddr, daddr;
-	u_int32_t mark;
+	u32 mark;
 	int err;
+	u8 tos;
 
 	/* Save things which could affect route */
 	mark = skb->mark;
@@ -51,8 +51,9 @@ ipt_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 	tos = iph->tos;
 
 	ret = ipt_do_table(priv, skb, state);
+	verdict = ret & NF_VERDICT_MASK;
 	/* Reroute for ANY change. */
-	if (ret != NF_DROP && ret != NF_STOLEN) {
+	if (verdict != NF_DROP && verdict != NF_STOLEN) {
 		iph = ip_hdr(skb);
 
 		if (iph->saddr != saddr ||
diff --git a/net/ipv6/netfilter/ip6table_mangle.c b/net/ipv6/netfilter/ip6table_mangle.c
index a88b2ce4a3cb..8dd4cd0c47bd 100644
--- a/net/ipv6/netfilter/ip6table_mangle.c
+++ b/net/ipv6/netfilter/ip6table_mangle.c
@@ -31,10 +31,10 @@ static const struct xt_table packet_mangler = {
 static unsigned int
 ip6t_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *state)
 {
-	unsigned int ret;
 	struct in6_addr saddr, daddr;
-	u_int8_t hop_limit;
-	u_int32_t flowlabel, mark;
+	unsigned int ret, verdict;
+	u32 flowlabel, mark;
+	u8 hop_limit;
 	int err;
 
 	/* save source/dest address, mark, hoplimit, flowlabel, priority,  */
@@ -47,8 +47,9 @@ ip6t_mangle_out(void *priv, struct sk_buff *skb, const struct nf_hook_state *sta
 	flowlabel = *((u_int32_t *)ipv6_hdr(skb));
 
 	ret = ip6t_do_table(priv, skb, state);
+	verdict = ret & NF_VERDICT_MASK;
 
-	if (ret != NF_DROP && ret != NF_STOLEN &&
+	if (verdict != NF_DROP && verdict != NF_STOLEN &&
 	    (!ipv6_addr_equal(&ipv6_hdr(skb)->saddr, &saddr) ||
 	     !ipv6_addr_equal(&ipv6_hdr(skb)->daddr, &daddr) ||
 	     skb->mark != mark ||
-- 
2.41.0


