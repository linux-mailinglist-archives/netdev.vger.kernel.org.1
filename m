Return-Path: <netdev+bounces-249518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF9D1A698
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A80C3099F99
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36934D3B6;
	Tue, 13 Jan 2026 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FkdPse6Q"
X-Original-To: netdev@vger.kernel.org
Received: from sonic310-51.consmr.mail.ne1.yahoo.com (sonic310-51.consmr.mail.ne1.yahoo.com [66.163.186.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D134CFAD
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322936; cv=none; b=ccYfjWMWiKlRMjze6hV5O+3LWEzEQqHq2MxAvcb3dvbV5AzBqhggB7KFII422Hycn1g8BPvmiz+e7fpS9I2fm9/nKIhrIvCfZOQig72eg4vO8PeulnShIifE4yR7PMTGt2RewXDFIjnP6wUXTMsv5JpWZlYbDkXPBCqWTJkDXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322936; c=relaxed/simple;
	bh=E+djNUif7Iym9G/PQBhkEorSfJFiQFqgjzxIrggXbO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFohmIxNXBJpO+LnvUbp11hsSd//8c0DpWDpqtkj9+z4MYGba3ToEkytMsdxgehEiv3XJW4V/EwoWDmvvnZld5D7hrLzTSZF3CHfCxPG+DGEW5abrX0pmvBlBZFnQVTjC1Vj49GI/MNJdP5BQiUC33AZSobIsanbKkpOKjbIb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FkdPse6Q; arc=none smtp.client-ip=66.163.186.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322934; bh=uv7NoJaYsMJxsHMc6hwtikXbQapKcs9MxJCdKOgcdKw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FkdPse6QnbJ2HfXng4sveMyNQg4Y7bW7k6DK9BRivcWwcvKZKap//2EgQdqmV6w4Dqq8eKZ3rzUN4IsEfWg0YpXadVow5eHOtsYhwnIMWV44nIXuQ8mn2TE0oErLeUqScy1pX3GgwxtUcQng6y/168zE9EZKAtdeW0BGvYTAR0K9rTx/kBteu2fGvO8UUyn04BAWajhaXMjUdIZmMh+eX7l3xStBoWUvaRAWQfPlv8Y6Udwoup/X0zdpYENHsay48QVFPnVBx6RZj3O55Du5bKMZTJ0W0qEDtPW75DGLbd1zepDC8TMD5uwDAjBdsKSAkHg5jjwzWu1Kh6t8ED543A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768322934; bh=yk1jzwSrYSoGDAqSLzvqhCtHTTxwoMk+ClYs6XAhkhT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SYLss16P5dvzvhY/gfZNaSuICi4jAm2JX9wtZRcxC7soBE5RL3QSrfyMCUePF9QUZRCk/ijyzdaV49ah5sQzvywiOwSpI7S998YIwEAdS8SVPwUNvHnIsukEDp+YVWN42S1TSF+9oubG5qXJBNBPLA6Qw6qgsyhmSpKs3Un7zuw3/88jiinIIZoXVI9HhXd35O71WB4+qIZVt/229p8KYeuubK/Xdr/MdSM1ucz0wIa/nOj1nKQoZRK6b+lnjB4oTimksaY9jvs7PF+opmgAuzlH2gW+MlDINU1aE+v6xicS73TT438GlIq9lAuCdpXCl/kJngt6pXainN2AsiE9Tg==
X-YMail-OSG: 15NhMKgVM1mRolPsNHVdKBzSVFX1Quw7JvfhyNuW2OQdZn7nMtRJUvNOzPFtka6
 aQV5lf0PfSy3S1bNbQjvdb5QRCdEZiXy3cl7jsn552yc1nh6TcaGY2IldY1vTLlAn.l_HyVy66Td
 P_airEU2M9ZwpJjd2LGYW1I8KRIIcyox9z8qkI87y_yBRnsUcXc7dcDgcJfX5SDiyEZk2fdb39hD
 8PxS0JKOWVs86zz1GcBlQ1Enk_Fvvxn0L86eIo4ktF2iXA5KzfTEvrPmaoeMgV3zS1vsCWa4yQ75
 xCSwYidZYBs5X6BA65MS4NSEtdC0peZam.6GZD2z6RoFaFcijbtzLtyAdEjqmejepSZAKaMMiqVq
 XoPu6pNGwvkwRedH7iYjsVopvhsaKpEQIB0i_FqUqpEk.1sXWFKH.HBM.x4OAMweXCotFC_ecxQA
 LW64JLiUXn23fflPBn3SFPDJ05qxjKGZBdIyr8fB..lmvsp63uRACQlhGHSrTzlWn.wQRHXlRFYD
 P_r5jd6C_YMnHO7kEGBeJD9TDedVgkme.tLZiPENGhfPkhTYmvoLxtbuxsvD359B6p9vifJWzzdb
 .bqpyou5ydi5sUqbuwv4j_p37yLU9mDibH3E6.OyJm8brvHgH8cvDjaBTASK0VqAQMZ.7zaEvPnJ
 2d_Lapr0K6sVK4XaQtKo82RjZBMNeQIves1LbgeWKD6diWTaUXXaf5bixUaXVoCdykQC1_THQW8g
 rANhb7tx5Q6JAAAeDGwProTaEW8PvgjC257d_I1A7UUwugiUTlKMbGsxNnrYnG5Ez9ozzCwo3SUe
 ZutTKcF.JERLCSWMgFytRLhOdCJZckM_4Mz1tEuHyawkCyaHE02ECoWKgAL40fwgaeGNMHKERpIs
 ZPAb1Ck3SmF4NTi0ScPeGYUzpUzNEY9o6mq8Y2OBavjHXqIDL9BK2Wz5y681TyTcYDMiHKShuab.
 sfZaQfaeXTu3hey6Hf02KQmHObRAiDT2c5NG.sosReO8oXva9vq9oMTqLJqkFeiDAweZcVMdAqTF
 ozBi7CnZRG.BIUYLuloalxK3muulTlvgscn7r5hqEVAfKsgB5BJgcP3UWJVyR6j0osg7A6811cFK
 cYecnIxbulET6G3SZs2t6AeNVN4sQphxg3Q9KOlXsWrFqsng7s1Rxhj3eEZTY_wxoh41M1LLGZ_Y
 GjLd3bwWqwjfx3hQuxceUJBa6111jLPGON52yulJxHhwQCJvr7AfWE35M6D0UJFiUWVhSwzmFdb_
 q9xrUf2oTcz17W702XaNQF7vx9trdbaBhRM_ijodv8ypTOHaHaHsdTqfCeD2HiLqrGd7bX2uLbAz
 mjMUKdWK6e78g5qs5OxfR.EgY.H_nC.jsDLu5OSB96RtyKw__iM0e.JFIef_xV4DpgE1850KKnwF
 Wbb8mA3zuQyqkgAg1I3wKapDkFpoxeYAEsE3F_DzFmCOSdKeFFlVxlM2pl7n.Z8VBhIt2gJMVBm0
 7RO6Z31s6g3bKsEO5ZHPaEqI.ueUicurteYKiP9poWpthlo5oLj3IdxmlDYQiJzDWcqEYk1JJIY7
 OumAZcptm_WHcZNjI1THvVyBxLZYMNIgh71U0ZKQZLsTHhhQ2NwdzCQKw0BHWDi1QXhU39cAPItH
 S0KEoVYlrZJf66wbokqwJ7YjNZbQFAqKc8BRCd1MjYBNF_tnYbdaqpEF5w1NoRYCi07dl557luQ0
 xudjgjEzKGdEn4Jl_PPWnQpdiYvf1rMjYdA4f.yEWmAMSGddPpykPVPaKJPKd8.o6RAal1tE5uT3
 KCelHCI.DgYD5M.2jeIc1ipF0xpZc6cLpbzd5JBa4pwgDuGJ6.BCpLpUOmnanLInbd2OVlBiPHvY
 ytbhiWd0buOVeRkDfYegntJh4HOOIw4rWS5dsumrJcrfjaI9PhKDzNq7oGk0M3Qd51.grBjpsijD
 CZmqnY75QaGdTJDE_V7rf3s8VcTgKF1xt7uxQ1YJsEUQi1r36nFV5mW0yrnk3vF3jXddyJjJfUql
 .nG8.vQVKHz6WxSsIczGAmSO4iq0hMNze1R48WgSo4asCLKhPwi6C3EsNhh5pqBzfCWvEUK1VluP
 mGioFa89vJTPTmZsYhaJulQFeq6RHYzReTd4OjkJJ1jBJ66hPwpOpCwaoz.a.RvqlNnalaRzPscN
 ecQztnMwyCwOamI6Ha16QQbnB7.Rl5o17O64WfFygK5Z5OOsi8f2s6B9UvL1ZKsz6e1kPqyUE68D
 STuIQGGu5zShviwXjvgrEAV8d6dg-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0a448aea-794d-4bb9-afe9-076b2be80b7e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:48:54 +0000
Received: by hermes--production-ir2-6fcf857f6f-9ndng (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ae45f0023da4d2f517b44dd167b3090b;
          Tue, 13 Jan 2026 16:36:43 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 09/11] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Tue, 13 Jan 2026 17:36:12 +0100
Message-ID: <20260113163614.6212-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113162954.5948-1-mmietus97@yahoo.com>
References: <20260113162954.5948-1-mmietus97@yahoo.com>
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
 net/sctp/ipv6.c     | 5 ++---
 net/sctp/protocol.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 38fd1cf3148f..8c28441009fa 100644
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
@@ -264,7 +264,6 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
-	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ff18ed0a65ff..8a00bb0a8ae5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1038,7 +1038,7 @@ static int sctp_inet_supported_addrs(const struct sctp_sock *opt,
 /* Wrapper routine that calls the ip transmit routine. */
 static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1056,7 +1056,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	SCTP_INC_STATS(sock_net(sk), SCTP_MIB_OUTSCTPPACKS);
 
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		return __ip_queue_xmit(sk, skb, &t->fl, dscp);
 	}
 
@@ -1074,7 +1074,6 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
-	dst_release(dst);
 	return 0;
 }
 
-- 
2.51.0


