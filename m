Return-Path: <netdev+bounces-237865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79768C50F8C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCEA3B3AB3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB30F29A310;
	Wed, 12 Nov 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mG5A75ym"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-37.consmr.mail.ne1.yahoo.com (sonic313-37.consmr.mail.ne1.yahoo.com [66.163.185.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313D2DE6F8
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932972; cv=none; b=oybhYMU231POoyag0aJESJpondl7RMg0PVjdf6N/aHOvmIF4zACIGteNDyAK6f+nbZnf316Lb+71AKwOp2b9QPlTSIHaicyTT2zwCKQpxToSc3gvEidLsl4DXkZHNioYOoYmDR3ecIbuaNJa1PT0mphlIj3qpFTTjO3hIlQgRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932972; c=relaxed/simple;
	bh=FJ9nezoljcH6bJrG7DRhyYjCaf+CWvhmI5tHhgjZi3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9RvMO37uY/m61bsrcnTnQRHQY1FqnjribPYe8socLl6fRJQWbozul/KY3skjrO9ViEWQjHqIEru4ZD9jFzrfUsIw6KC/MrwEo16a3x5mkPfjO+IfQahJL7KzfD9mDJly1d+5bsQXoHTPnehGBkJiAPQHvO5F6zVd4Eu6C2IHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mG5A75ym; arc=none smtp.client-ip=66.163.185.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932970; bh=j4A8y06gXvqyJ7fZUja3vPONKRIymmQ9ew1Vv/+6Bm8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mG5A75ym3hY8C0+p7lDo8046/nNdV0a/8a31wNCLsYAW2PC7ADhMes7QYxb5cejlFI7hSZOg+fvjRJneAVEokrVWfQ41ABA76yU2w+7llbuqnfp+/LvhES4k3tn50wQJI8cpmBjngCITIsB+ImkykPs5P2r0t+CSOuk0Ywwnr3RstjQ0gX3K02e92v1Xop7Uw5FO+9wCVKJD4mJUndTzP86PbNZMv/8QZVc319qSKLDiIPqvFWMiuJFvT5tHh+8dSfP6wRJ2Rk//5v7DAB0IIUn3xkeJ8LldsFaA/M9Z885MZg0g3447ieim39YU90b4gMK37ry9myChVU623BUQqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762932970; bh=Pj+fvZWlavOExASbIw6on5YxVmftWPalVliS+ZJVbmt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rasS3kV9TQMYVZWwENnG9g+A2wPAJbk6wc5PPzK+SyfFGJA4zSoiSdDxCaMLVJwI6PSryvzp+oJZDxl31tvxdutoAPr9+5bNIuqAEWHQFozd+TyPgHJtyduJBGyNThZJZGelwbOltRi5qMNYy4qC95GmpH4rEmEW3/g0IozhtnkAJOOq8zS3MLlGyxU0DEZbvZh2uu7QRqY3YG6QIU9TBvk64v8LNEneymepKOiBgbcZs0yV3Jnn6qk2ewfpAdoQPuf1gLt/M/XyqlSZ/oqILRjZp4a30zoUlCQ4lHLN5/5QUfLiJXI6Brw1SSzgOcZv6Rdap6ygTZ1o5RqQirwSkg==
X-YMail-OSG: kmSPQE8VM1lKhGSFkoyh2PkM35E.lzP144lTjMtQoa9Mv3OqUCqN48Alk1Pk0e9
 C2w8p5monLHxFRdCbUPiJeom.fCIimJpWNxFjgFWvB.5hYGxF.mlqRAL.j.8wMBuFUHxDV.lJ9RF
 sYoeTZV.D0q9aurRmuA9BbPIw5TGWfyU9Z1aPu0_KRcqWsnmiQelepjozoEicBg0oe2Zhx0G4gze
 g5jCYgZjVWP7advNWPHXB615LxzONXKclnz4f9saHEZqh2uDcbH7RbZMOktxGzvsjjKdePynmG8M
 BuAH6ep5y4bEdCh3k6J_pgo4v160YUHhQB6GZIzyUOD9O1d..mmPDBbFrmFHMx3xkW9OxOADvvd8
 AE940BtwijxPwdaVjpH8AQ.Yn4Kk6aHXzwPvxWQQTEmquyYWsdJtkVlcRVxymljok0Tg8fJktQJg
 6SncYR5KZdz8FVagqqaAC0prmLvyFO3sXH5HuP1TFsafNlDWeO1ZAR_6Vvjjv4r1P6d.6L1D1Gts
 vUM_hMtRMopaqTobttL.8yIBTnheb7SD4.vMum22JLVMUY0bdBXKr6K10p7WbTlPp8gPk3hB0Gw5
 QiGCholmuYNPD3I9M0H70.XKnZhBpsvZmG_tF1f0Hb5oZCUAU7hiNtKlnxdKL2uAP1fWjWUTg_vy
 CJEIWfkr4pwVasmVybnylWqs.WUwV8mCSNlSA5avuA8KMjPbHiPnHLj5AL48sNNTPOa6eE__ygFT
 wIb6lENIqL2ENAQiGxEbmXYfFXI8nM8k7IryVys_pT0Cs6Sa_GD3pd87wTFnv1oKd9ZbX5vIB7PM
 M5Om2XxhrCBMyHu40wWm9COUL19hiGHwvaGqfy5uhu3yNbRyZPYyWdQOM76XUosRhEb9kzIFFF4j
 EDjoJjLRIwwubY5GbMiJB6nevdDwYRCvINw7VjE4epfQJQ.v4n.dmCtoRoERn4ln77lUDfdI0brH
 WOxB.5KRb6joPUK93UfS9nzP7htXy6o44wMJkTaomvUj.ZR7gunLIwioyOBtbHmQT_dhSwqaDnu.
 yHKxWJn.PYywWj2UWyeYgWgFTLAXHAbyorMgxZMQluAyRrbCW9vkpEfT5BoyXRMF9L8NnsEHjRAZ
 tBgBgjgPNS5LvzJfAFIrkvd4H18wEEEZd3zR3RtBiWP7nzspHjIFgHE1e75NsPIqu5sKovWwOqJf
 CFE9dEtH.hJPDQdB_0v9gp9.y5sx6p_87GmKNpsvkWuopIMzYHoEt2uMAZkjTqmGPCb4J.vMNM2D
 UVhzTIglRdQfGPYfP57eiJ6w44K1KrQJqilai4hGq9TI1.1tilVIQ1s6LuOyxz5o1AvN_MOgsaW2
 cJiqOOB6LO7Vuwc4MRgjAL4VVJWn51GTVFJbYdr7HE_qXq5kM1hlUuYJP.9BKf5WSQi.orowY7XO
 KIfmfnA8SbfdbMJbFlwhkqn6S2jSCmqQfQ1_kcRPGSSk2ZTtwqIZHdnHRrLXxLcz6saA9kThWIuU
 MwXA3xrGP9h7iNmchTSycKG7C74PkUZYXEyja7023bqnuygdUnVD5zUkb9YJogfsuUGIKWtvTq0U
 uqOod1GPQmOHC8bubFhDUtPFLZrq_wx7W6sH7lyrPDw.ZWcC2YzoEMkkodtmm9I.Ybq.w2up_hPU
 QLBrElj4ELrBpp5hCOCM9FIR.kn0oxHogDJIqwQxpnR7tBECai_cR0LtsH_bIR4oU.oBvjUjI8Sm
 yGzKOhzolw2cE4tdeM3fJ.MA96ob0h_eQYB2N_7zYLInw1JA9RNMSx4ir4Q.DDBKUD0mfc5KCDA2
 qCvAp6sHHXaJt248k2k4Y8qUzhxceFT3wfAHSFw3jHn9EFuWFhenStcCL2nQX2SVep0r5SkrZqZ2
 IHuLV1FieDF66OQKAXx0429_wJj3_UuEuPfvV2s_Me3.SJ2AoTMyhko0ykSdHVLn12oF_.iuAh1c
 LI6V.LbFk9EWIKWw9Gi4cUXvC58bKxcmO7CV54Z2kPaMNnJtDIrcMH_KVNZEWZ6gryamKAonVNFa
 b4wraFX_BJACyPlrGg3aQqpMWl1NbtydwhrCZCKpLfJBTwIaOxya4uYuLD3HxRqlHWvKLvlC7ivD
 TULx5mj.kykG1f1yrMJ0LLJs9AIlZO9rKpuQ.9jGto3RBxrRGrUm5Bvk3g.XtvMZeBH26JjvZNQW
 59PxRUcaokk6VZBvs9s305K5vTjwIjTtLxhiR9VY6upWPxj2hLZwFaUrbn8iuMZCTJlcARhIO0du
 vaCYZRsGk_5E-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 78798e26-151c-496c-a4c0-96acf4ad503f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:36:10 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-gtwf2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8a3972250952fefb5c72bc783ca56e47;
          Wed, 12 Nov 2025 07:34:08 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 14/14] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Wed, 12 Nov 2025 08:33:24 +0100
Message-ID: <20251112073324.5301-5-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112072720.5076-1-mmietus97@yahoo.com>
References: <20251112072720.5076-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_v{4,6}_xmit unnecessarily clone the dst from the transport when
sending an encapsulated skb.

Reduce this overhead by avoiding the refcount increment introduced by
cloning the dst.

Since t->dst is already assumed to be valid throughout both functions,
it's safe to use the dst without incrementing the refcount.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/sctp/ipv6.c     | 6 +++---
 net/sctp/protocol.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 53a6d3adf452..7b1dbd9aa565 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -219,7 +219,7 @@ int sctp_udp_v6_err(struct sock *sk, struct sk_buff *skb)
 
 static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi6 *fl6 = &t->fl.u.ip6;
 	struct sock *sk = skb->sk;
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -243,7 +243,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
 		int res;
 
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		rcu_read_lock();
 		res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
 			       rcu_dereference(np->opt),
@@ -261,7 +261,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	udp_tunnel6_xmit_skb(dst_to_dstref(dst), sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+	udp_tunnel6_xmit_skb(dst_to_dstref_noref(dst), sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	return 0;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 77c16318f62e..04990727c1b0 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1070,7 +1070,7 @@ static int sctp_inet_supported_addrs(const struct sctp_sock *opt,
 /* Wrapper routine that calls the ip transmit routine. */
 static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1088,7 +1088,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	SCTP_INC_STATS(sock_net(sk), SCTP_MIB_OUTSCTPPACKS);
 
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		return __ip_queue_xmit(sk, skb, &t->fl, dscp);
 	}
 
@@ -1102,7 +1102,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
-	udp_tunnel_xmit_skb(dst_to_dstref(dst), sk, skb, fl4->saddr,
+	udp_tunnel_xmit_skb(dst_to_dstref_noref(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
-- 
2.51.0


