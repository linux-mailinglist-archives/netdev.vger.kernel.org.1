Return-Path: <netdev+bounces-173916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA51A5C385
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E2C177C33
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCBE25D1E4;
	Tue, 11 Mar 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="cl9Kr6AM"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A25CC90
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702417; cv=none; b=uDoziI66iVXauc5as5m/GAsSLYs3s+f+glLQgISKII/u1gppQn6gBlzE1ne50llF1EXVdOnvOkrd1J2vvmU66DrpzwMD8aX3nzjjlI8Wk8FerJcicSPXc1apSb+dHDp6SP0G7ZD2NRSgLitMdPRKKmAZTJQekpaMPCAnV/aXOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702417; c=relaxed/simple;
	bh=KFgCFw/LWwTzp8SbprShaHvu4zYYjLIH7cETMYihSLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mu2ya/mYr/2p4wYSpncqKCgzMgM6dERxWViQo/i/3k9fKXVJQOjdJ5OS0N2M2tIzwWeyd1aTJlAYa2rRcp1CSXR7wb/9DnXdDVxXUI2SeqTGlukaQiRjwWfKu+dDk1ngku0hFKZSuDm0VtURM5MU9P8WsPAciHIxKeSpg0FOBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=cl9Kr6AM; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 3325D200E1C5;
	Tue, 11 Mar 2025 15:13:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 3325D200E1C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741702413;
	bh=joi1SxIg0EYF9PYUiqdc6TliGocUm6BPu1aURxPOhC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cl9Kr6AMw1ec4VX2kFBoUQL75HB6j6xP7Txw8RfdElD2V66v/LOd2JJ59IbX6jGjF
	 YiQcRamcUNLJMR6oSmk0fWn9wRvHYlZ2wlahWF+vEcmtSGuXpkKPRuwoMvanlgH537
	 2y1UwdTlaCUeMOzZ2JijISgQpIx4ssUkra8WbtN1oEmJJh+4DZoCC3Og9EOPV9F+2d
	 lukn0U0JhmJr4RKukjo8EtPSvFWj4I+vKrSl64cEsuA27nPEg5hNSkZ3H/MWWtAt7Y
	 OG9F8iYTiM9SlrdgQucAffoBvJY3eIXl8s2qgt1H/XHHcOO7hWFT2WZuiH+QDD8Epc
	 TPJcoFpo5xt5g==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	David Lebrun <dlebrun@google.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 4/7] net: ipv6: seg6_local: fix lwtunnel_input() loop
Date: Tue, 11 Mar 2025 15:12:35 +0100
Message-Id: <20250311141238.19862-5-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311141238.19862-1-justin.iurman@uliege.be>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the lwtunnel_input() reentry loop in seg6_local when the destination
is the same after transformation. Some configurations leading to this
may be considered pathological, but we don't want the kernel to crash
even for these ones. This patch DOES NOT solve the crash reported in
[1], it'll be addressed separately as it's a different issue.

  [1] https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/

Fixes: 140f04c33bbc ("ipv6: sr: implement several seg6local actions")
Fixes: 891ef8dd2a8d ("ipv6: sr: implement additional seg6local actions")
Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Fixes: 664d6f86868b ("seg6: add support for the SRv6 End.DT4 behavior")
Cc: David Lebrun <dlebrun@google.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: Mathieu Xhonneux <m.xhonneux@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/seg6_local.c | 85 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index ac1dbd492c22..15485010cdfb 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -378,8 +378,16 @@ static void seg6_next_csid_advance_arg(struct in6_addr *addr,
 static int input_action_end_finish(struct sk_buff *skb,
 				   struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
+
 	seg6_lookup_nexthop(skb, NULL, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 }
 
@@ -418,8 +426,16 @@ static int end_next_csid_core(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_x_finish(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
+
 	seg6_lookup_nexthop(skb, &slwt->nh6, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 }
 
@@ -825,6 +841,7 @@ static int input_action_end_x(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	struct ipv6_sr_hdr *srh;
 
 	srh = get_and_validate_srh(skb);
@@ -835,6 +852,12 @@ static int input_action_end_t(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 	seg6_lookup_nexthop(skb, NULL, slwt->table);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
@@ -902,11 +925,11 @@ static int input_action_end_dx2(struct sk_buff *skb,
 static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	struct in6_addr *nhaddr = NULL;
 	struct seg6_local_lwt *slwt;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwtunnel(lwtst);
 
 	/* The inner packet is not associated to any local interface,
 	 * so we do not call netif_rx().
@@ -919,6 +942,12 @@ static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 
 	seg6_lookup_nexthop(skb, nhaddr, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 }
 
@@ -953,13 +982,13 @@ static int input_action_end_dx6(struct sk_buff *skb,
 static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
-	struct dst_entry *orig_dst = skb_dst(skb);
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	enum skb_drop_reason reason;
 	struct seg6_local_lwt *slwt;
 	struct iphdr *iph;
 	__be32 nhaddr;
 
-	slwt = seg6_local_lwtunnel(orig_dst->lwtstate);
+	slwt = seg6_local_lwtunnel(lwtst);
 
 	iph = ip_hdr(skb);
 
@@ -973,6 +1002,12 @@ static int input_action_end_dx4_finish(struct net *net, struct sock *sk,
 		return -EINVAL;
 	}
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 }
 
@@ -1174,6 +1209,7 @@ static struct sk_buff *end_dt_vrf_core(struct sk_buff *skb,
 static int input_action_end_dt4(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	enum skb_drop_reason reason;
 	struct iphdr *iph;
 
@@ -1197,6 +1233,12 @@ static int input_action_end_dt4(struct sk_buff *skb,
 	if (unlikely(reason))
 		goto drop;
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
@@ -1255,6 +1297,8 @@ static int seg6_end_dt6_build(struct seg6_local_lwt *slwt, const void *cfg,
 static int input_action_end_dt6(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
+
 	if (!decap_and_validate(skb, IPPROTO_IPV6))
 		goto drop;
 
@@ -1279,6 +1323,12 @@ static int input_action_end_dt6(struct sk_buff *skb,
 	 */
 	seg6_lookup_any_nexthop(skb, NULL, 0, true);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 legacy_mode:
@@ -1287,6 +1337,12 @@ static int input_action_end_dt6(struct sk_buff *skb,
 
 	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
@@ -1327,6 +1383,7 @@ static int input_action_end_dt46(struct sk_buff *skb,
 /* push an SRH on top of the current one */
 static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	struct ipv6_sr_hdr *srh;
 	int err = -EINVAL;
 
@@ -1342,6 +1399,12 @@ static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 
 	seg6_lookup_nexthop(skb, NULL, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
@@ -1353,6 +1416,7 @@ static int input_action_end_b6(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 static int input_action_end_b6_encap(struct sk_buff *skb,
 				     struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	struct ipv6_sr_hdr *srh;
 	int err = -EINVAL;
 
@@ -1373,6 +1437,12 @@ static int input_action_end_b6_encap(struct sk_buff *skb,
 
 	seg6_lookup_nexthop(skb, NULL, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
@@ -1411,6 +1481,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
 static int input_action_end_bpf(struct sk_buff *skb,
 				struct seg6_local_lwt *slwt)
 {
+	struct lwtunnel_state *lwtst = skb_dst(skb)->lwtstate;
 	struct seg6_bpf_srh_state *srh_state;
 	struct ipv6_sr_hdr *srh;
 	int ret;
@@ -1457,6 +1528,12 @@ static int input_action_end_bpf(struct sk_buff *skb,
 	if (ret != BPF_REDIRECT)
 		seg6_lookup_nexthop(skb, NULL, 0);
 
+	/* avoid lwtunnel_input() reentry loop when destination is the same
+	 * after transformation
+	 */
+	if (lwtst == skb_dst(skb)->lwtstate)
+		return lwtst->orig_input(skb);
+
 	return dst_input(skb);
 
 drop:
-- 
2.34.1


