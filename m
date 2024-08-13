Return-Path: <netdev+bounces-118025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E36F9504E3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FF31F23A7C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4021993AD;
	Tue, 13 Aug 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="CcbI1BG+"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79F19925A;
	Tue, 13 Aug 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552058; cv=none; b=CNdLv5VZ8zJ71X/oQ1Rza1hOIF7kqRtcKBdCKRG161t1fBXvQyKWS1tahXUkT3jYKne/0ih41feL+52bXPgDfvz4YaCbIkLV2C3VfjJaSCJyuQFphJsz4utgsuaHsD5dSIwZVnb3a4lBy6RNNmB5p0Gq0+7nDvPiar/3M1upe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552058; c=relaxed/simple;
	bh=8giQF0MUDg03YqcjAIko6TALGoP9+RAlqYtNgl76qKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+LsuoJv0XUC+zeyTTbADmOQwu7GK3nxtTesdqf4SBJRvURLTY22mwY6uEpDcoeKn8DnW/H8Fyo2JTTpwjXQrXwPcuYcDz1rsZjPwjV1GbdT94QhbwGzuemAc07rrpFcPelB7X4X7o12lxcTyRuxhCrmsbhlrmK2f5khXRwP1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=CcbI1BG+; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 588AA200BBBC;
	Tue, 13 Aug 2024 14:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 588AA200BBBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723552054;
	bh=Z2yMU/+cvNKgxHEiq6fSk0grkFSKcLZQnf5Y5krrpPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcbI1BG+O71wUS529tLppnQUtK+OFVQwSrOeCjLtdL+pr1BxEqfAdaqN4JUl+sjwg
	 Ujn4u/EKyVz7ttixlpjvV++rN6ms5Ua0SKxmNtlbxCoFwEqcNBrxjqzd15jzqHturo
	 TL3URTIJ4Gp3dQbY2Q6KQch7UxW5SyGTB3B9XqFMoM9Pr1WlB/VQObc6VU7YWZ6bgl
	 c3ziHM3WTivyV4BLibUV2k/PypWsvTsDMahgJfr/96sr/2qiXk1svZc8gTe2kwlFMg
	 +3UzdmKaYSUXbyLd9ckVagdX2Olz9Xo0+NrJ4f7CQCqjHtUy2YPmclDQSPgWGDeXcA
	 f/+gkoZHYDL6w==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v2 2/2] net: ipv6: ioam6: new feature tunsrc
Date: Tue, 13 Aug 2024 14:27:23 +0200
Message-Id: <20240813122723.22169-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813122723.22169-1-justin.iurman@uliege.be>
References: <20240813122723.22169-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
"encap") mode of ioam6. Just like seg6 already does, except it is
attached to a route. The "tunsrc" is optional: when not provided (by
default), the automatic resolution is applied. Using "tunsrc" when
possible has a benefit: performance. See the comparison:
 - before (= "encap" mode): https://ibb.co/bNCzvf7
 - after (= "encap" mode with "tunsrc"): https://ibb.co/PT8L6yq

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/uapi/linux/ioam6_iptunnel.h |  7 ++++
 net/ipv6/ioam6_iptunnel.c           | 57 +++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
index 38f6a8fdfd34..6cdbd0da7ad8 100644
--- a/include/uapi/linux/ioam6_iptunnel.h
+++ b/include/uapi/linux/ioam6_iptunnel.h
@@ -50,6 +50,13 @@ enum {
 	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
 	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
 
+	/* Tunnel src address.
+	 * For encap,auto modes.
+	 * Optional (automatic if
+	 * not provided).
+	 */
+	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
+
 	__IOAM6_IPTUNNEL_MAX,
 };
 
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cd2522f04edf..15c20e37809f 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -42,6 +42,8 @@ struct ioam6_lwt {
 	struct ioam6_lwt_freq freq;
 	atomic_t pkt_cnt;
 	u8 mode;
+	bool has_tunsrc;
+	struct in6_addr tunsrc;
 	struct in6_addr tundst;
 	struct ioam6_lwt_encap tuninfo;
 };
@@ -72,6 +74,7 @@ static const struct nla_policy ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
 	[IOAM6_IPTUNNEL_MODE]	= NLA_POLICY_RANGE(NLA_U8,
 						   IOAM6_IPTUNNEL_MODE_MIN,
 						   IOAM6_IPTUNNEL_MODE_MAX),
+	[IOAM6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IOAM6_IPTUNNEL_DST]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(
 					sizeof(struct ioam6_trace_hdr)),
@@ -144,6 +147,11 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	else
 		mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
 
+	if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
+		NL_SET_ERR_MSG(extack, "no tunnel src expected in inline mode");
+		return -EINVAL;
+	}
+
 	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE) {
 		NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
 		return -EINVAL;
@@ -178,6 +186,23 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
 	ilwt->freq.n = freq_n;
 
 	ilwt->mode = mode;
+
+	if (!tb[IOAM6_IPTUNNEL_SRC]) {
+		ilwt->has_tunsrc = false;
+	} else {
+		ilwt->has_tunsrc = true;
+		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);
+
+		if (ipv6_addr_any(&ilwt->tunsrc)) {
+			dst_cache_destroy(&ilwt->cache);
+			kfree(lwt);
+
+			NL_SET_ERR_MSG_ATTR(extack, tb[IOAM6_IPTUNNEL_SRC],
+					    "invalid tunnel source address");
+			return -EINVAL;
+		}
+	}
+
 	if (tb[IOAM6_IPTUNNEL_DST])
 		ilwt->tundst = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_DST]);
 
@@ -257,6 +282,8 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 			  struct ioam6_lwt_encap *tuninfo,
+			  bool has_tunsrc,
+			  struct in6_addr *tunsrc,
 			  struct in6_addr *tundst)
 {
 	struct dst_entry *dst = skb_dst(skb);
@@ -286,8 +313,13 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdr->nexthdr = NEXTHDR_HOP;
 	hdr->payload_len = cpu_to_be16(skb->len - sizeof(*hdr));
 	hdr->daddr = *tundst;
-	ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
-			   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
+
+	if (has_tunsrc) {
+		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
+	} else {
+		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
+	}
 
 	skb_postpush_rcsum(skb, hdr, len);
 
@@ -329,7 +361,9 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	case IOAM6_IPTUNNEL_MODE_ENCAP:
 do_encap:
 		/* Encapsulation (ip6ip6) */
-		err = ioam6_do_encap(net, skb, &ilwt->tuninfo, &ilwt->tundst);
+		err = ioam6_do_encap(net, skb, &ilwt->tuninfo,
+				     ilwt->has_tunsrc, &ilwt->tunsrc,
+				     &ilwt->tundst);
 		if (unlikely(err))
 			goto drop;
 
@@ -415,6 +449,13 @@ static int ioam6_fill_encap_info(struct sk_buff *skb,
 		goto ret;
 
 	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (ilwt->has_tunsrc) {
+			err = nla_put_in6_addr(skb, IOAM6_IPTUNNEL_SRC,
+					       &ilwt->tunsrc);
+			if (err)
+				goto ret;
+		}
+
 		err = nla_put_in6_addr(skb, IOAM6_IPTUNNEL_DST, &ilwt->tundst);
 		if (err)
 			goto ret;
@@ -436,8 +477,12 @@ static int ioam6_encap_nlsize(struct lwtunnel_state *lwtstate)
 		  nla_total_size(sizeof(ilwt->mode)) +
 		  nla_total_size(sizeof(ilwt->tuninfo.traceh));
 
-	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE)
+	if (ilwt->mode != IOAM6_IPTUNNEL_MODE_INLINE) {
+		if (ilwt->has_tunsrc)
+			nlsize += nla_total_size(sizeof(ilwt->tunsrc));
+
 		nlsize += nla_total_size(sizeof(ilwt->tundst));
+	}
 
 	return nlsize;
 }
@@ -452,8 +497,12 @@ static int ioam6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	return (ilwt_a->freq.k != ilwt_b->freq.k ||
 		ilwt_a->freq.n != ilwt_b->freq.n ||
 		ilwt_a->mode != ilwt_b->mode ||
+		ilwt_a->has_tunsrc != ilwt_b->has_tunsrc ||
 		(ilwt_a->mode != IOAM6_IPTUNNEL_MODE_INLINE &&
 		 !ipv6_addr_equal(&ilwt_a->tundst, &ilwt_b->tundst)) ||
+		(ilwt_a->mode != IOAM6_IPTUNNEL_MODE_INLINE &&
+		 ilwt_a->has_tunsrc &&
+		 !ipv6_addr_equal(&ilwt_a->tunsrc, &ilwt_b->tunsrc)) ||
 		trace_a->namespace_id != trace_b->namespace_id);
 }
 
-- 
2.34.1


