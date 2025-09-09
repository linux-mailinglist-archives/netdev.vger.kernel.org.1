Return-Path: <netdev+bounces-221069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E288B4A172
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B8D1B24EDA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8732EBB89;
	Tue,  9 Sep 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eezxNFSS"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-47.consmr.mail.ne1.yahoo.com (sonic306-47.consmr.mail.ne1.yahoo.com [66.163.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81756244687
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396779; cv=none; b=U9JafkSW50gAJGZho/cPktoW+0wEOM8qxIxhDVqo90vkKdN4LRSV7FVjQ/xKb7barh8dVZSFGZC5gaToGMmxSBYMjc1ZEloWjww61aebiaoV85SDQZofFwgsYnEeEDTsncb7Pna3ug0ATlscBlFh0/1LMNCif6SzbDzhIfcAN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396779; c=relaxed/simple;
	bh=lZxSpP6bc+yrLhDlPDYG+Ew03JLZO/PQomcPSncCcDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLhdHv1gAKUZ2FdGxLjY1wTiJ3xeW+n3yWeOff0umoQOaLA3MlN+3zXweJq6Il3AO/LqHaNJGDdOMUr9n82rGT0OtxZj9KitLnPkL4I8kajhWzeiL1yrkZDZqWu8xLn5yI5GGr54z+W0aIW97vruQ3CrXx7K4Vn5YNF1hcgmP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eezxNFSS; arc=none smtp.client-ip=66.163.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757396775; bh=hOCx3exMi/gEZlRMsfu6f3yZal5ZMUNsmvImqwmEt+8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eezxNFSSm0vYfiZPP41VwVM+rVV3LAW14cyrSwOKkshsS9LF71CCUNTbJTWll1U7xOHeAqY1nqT00k7+sRfFBNC9n4ErkUHq4WX4EtVWUbFMFCrYjM8WA0Ss/k2V7ajpI+rlm29sOJIamQxq2pORZ2pCHe03b5kmsUt4BBLCLl9DdAcDcqsI8vI5ALnpW6qk+P8GwO3wJ9KqEZ+9nQaDulmi1LQ4t+7e/WSqsZtGUsiEI8Uv7EApp/rxaXSFT403+0sa+A7O5u7py+CQF/TTeu4H6mt6Inbo0C/v2+5Ef1yJqJjP7GayrhRiSw+reVa2+fwT6PpqMptdRkTh/5QQig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757396775; bh=0cltzLa/h0RdEzApNryMKQV7IIq0YDVWEM3Z/8Y2rm9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IKUIfkKXvQPkInk7wmOJUDcGg569Yc30Ve9xB7vx/RRkuq41JpiS2mXN0MoTFmSbsyx5KJuIZPI5ANOK7AkYTcUu51wA+C0/pemKNjyQX2GG3Wna1EnYiRqqdLRLr+XVt0tF6gTf0ODTBWBabqsAzVmsSsm0srTi7FlSWfN6VwAaEQYTCV3QBgb3fKgPqhTpMU6UJqwRZzIgTo0yiUryb9UQa9muTUkBrEQgaXWY69hhx9MSrNJbbGfk2Ko1suu7dUiqgBCi9Xv9n4S5coNqIZb/kQJVsuB9MHRfUcOR9jMeJMf6n4eZWsd1P59QhL0d5DYNu/XC1j5inIamsKHk8Q==
X-YMail-OSG: Hi7xHn4VM1lWwJpUL7iUppOCJOwlcBxP_AHQZlltUot5kOTiyJ7iqP3AKQwOo88
 aTkeVZNX84YaeQpYtX6_mVfWW0jJtTY2x_MF70nrM8.HXW17E_4MOFi1G.2lCTYnZUDKEXKw_LWI
 rSdqXf_nax0mPcf_s4p6LqPUCEKtIO6VEI2qc_VijTr5I2sIrdCwDnKP6wHo0DJwq2ucE6I1t2K_
 J0V.vZJkcX5.wPecMd8zvgSvUgJLHJzvzsZupSkTcHO3UkZfLEpBTtHtIv3kZP7UB.j.Ou5u5_51
 oBZ6HsWkJVqK4yYQIeCmfaczMluS4.y7Ls6PGy2T6wdznxZvEW9ptRMu9ZuZQ6K30GFp2rYul1TS
 iF4yQrpNumuGnwzB31p7oq1RBxJN1w6gBrui.XLz2k.ikL7_whjDbAppYxXqfu3RZyyjlqovFb.j
 5VhM9hGibIY8Ry4N99TFWGs6LX_BgJ9Q9FoQgVyP6vDO2PC2F1K5uiHc8TiwU1VYPUBiZqUFUE5F
 i9IcpbTG.AqR71kvZc0HbBa3n48QDQQG7n0MU3N2d1x5BaY9QMiwX.OomJUkgz456tT8x.kjB72K
 PKtMQGd3tPzolfl26g5Yhx1m4bAEryiSOW8_vpMqOP6c8KJvQUgOShfj4hhtY8wM1limZRBvfkqX
 Y.7sYbkY_sxrUICCdDXQmCAQS14d1eRFHZrYbKKV07WSXxNvj7FdAPab7R5guc7YZ3yhU7s_0v4c
 G4KpGV54waoOvbGoMN8Nnj.mY6z_FpncfBVI6p2UniJlAQcHAZcX7OEVNF0_QP3w3Nzgiw4lSf5.
 XsKw.yrwSJ1iEjb6k5yDZai3EffFvZ6Z3mDzibEmGeOwddR2ar1WSAfNxaLB3QR9kEzjAo3JPCcp
 gD1tWwR3DT9mjo2QxcmlPv6VWGdrqe7goESBQu_uGmLN8Q5wC5hd5k856zcaTnsUN.VNHgLiDQ9s
 6_nBiEOKtQaOYqzlgOcxL7rKXsoFvH4GVUfh9aLhk1LDitmtN3qHr3bZ7iBUmoWsUaxdHOXQig5K
 utvkFlzfkM.mcohK.Oal8AJ_cFwMLAlHhd2WwWAFDPqG9c6KPN1NV.jWyow9h9rIRQ_.M.gMU2vU
 _rDn8pFtsGLbpClDOgh1ElBNm.5LZiJgY0BH2vDfVYuDEVxTA5JWMMEmtbyn1LzEOY8_xQtqXHUq
 ajpsZIglnP_CRbZRN4JRKpGaO1AcVlx_MECIMp8A4nR4I772Xv4A_nDCXBbB1iyxOoWk9GAeG.vN
 bfZtjI6Gunu.geXcR_rRv9QTi0qwzUEQXlfTGqFwPZJZ_CasKQVlKDwWmZj40pYXWz.UF14x7AX3
 WsOIs2UQ4Lb2TRpVaGIwMyzcbr9DPVMRw5d0BVAPrhnmucagwd7LBHW2GB1T.ba0IJTDyo8VA_Lq
 DCAZuEkdgBE7Mvv96PqsxyQQR7UjY1lpOenjdHaQdKOj0Gx0iUSZ4tLbMHIu5cJHfDyPZ.GICgzJ
 .zoKgM32acXRcgClNo7xtyezjz5KMkt.9C79OoEyRhmo6pKsrPlEF4BBSWemY7_.vqcdoQCuO3Ob
 pIGzBWBWJjO8kFWJUlKEPwVulFAWLiiYIeb2HxNvxABe2dQjyBZJXvMs98bJG0b0a7NdhSh4kPWe
 fG.JVjdHmzHJS0WEeYMWKYvsN_UKfMraOQgBAgcFROfkRqEI8oK1wsay.lNv6APmhzYtVQD8h.3p
 mj1T_yf421E5Kon0Q7x8s8xSoVi43T7WbUQjToz3Qn9Mu3bqkf203LNyOzVtN0KZIa5LLa0VHyJr
 uaFWhdcpOyvmGUB3iGS1qBReD9gZdPwRa71y3UltEq4L2EEt0M.0H0ZohZrqVF.40E.r8ShTZbvV
 rJp2EyeyPkhm6PepLnHh6VE7VHBR8iARr.8kwS9KP.n_UuBdFinNTl4pSnff50lD.9e_Tk_pdPyA
 gCBBX903E8q8_pW3bMHFVLv7B5_WKkb8R3vgg2mQ9UNUIyx5Cy9F_fhlE_BJsyXs8Dmlh8qKyXxs
 DI14MiavyzIC7du8vSKRx3Eh6wpSxhk6mE4Zipuof2y1fkR8TichjHbpFacIewPmIdO2.0tipOUX
 medwGZRwhUuxTMJvA5wOYz5m2xas777YPMjbePhZyKpSTeXhUpZb78OCaLNQfmvkii15D8Fst8Vd
 GJjjhmK9AmRyCweHRrMta76eTGvUCD7cpIFD4DS_lfJJMPsctmuB73IsJERubfFok2eombVCzuwE
 IBoAeJTg4PCVI3z9JddMztgt43Urr2mw-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 62d1d2b7-215b-4acb-9b94-2ddb985e0dda
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Sep 2025 05:46:15 +0000
Received: by hermes--production-ir2-7d8c9489f-9tl65 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 06aa482699b918a59f317ba4e6d13960;
          Tue, 09 Sep 2025 05:44:07 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next 2/3] net: tunnel: implement noref flows in udp_tunnel_xmit_skb
Date: Tue,  9 Sep 2025 07:43:32 +0200
Message-ID: <20250909054333.12572-3-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909054333.12572-1-mmietus97@yahoo.com>
References: <20250909054333.12572-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases where udp_tunnel_xmit_skb is called inside a RCU read-side
critical section, we can avoid referencing the dst_entry.

Implement noref variants for udp_tunnel_xmit_skb and iptunnel_xmit to be
used in noref flows.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/ip_tunnels.h   |  3 +++
 include/net/udp_tunnel.h   |  4 ++++
 net/ipv4/ip_tunnel_core.c  | 34 +++++++++++++++++++++++++++-------
 net/ipv4/udp_tunnel_core.c | 29 +++++++++++++++++++++++++----
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 8cf1380f3656..6dcea237bf21 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -604,6 +604,9 @@ static inline int iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		   __be32 src, __be32 dst, u8 proto,
 		   u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
+void iptunnel_xmit_noref(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+			 __be32 src, __be32 dst, u8 proto,
+			 u8 tos, u8 ttl, __be16 df, bool xnet, u16 ipcb_flags);
 struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
 					     gfp_t flags);
 int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..033098ebf789 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -135,6 +135,10 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags);
+void udp_tunnel_xmit_skb_noref(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
+			       __be32 src, __be32 dst, __u8 tos, __u8 ttl,
+			       __be16 df, __be16 src_port, __be16 dst_port,
+			       bool xnet, bool nocheck, u16 ipcb_flags);
 
 void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  struct sk_buff *skb,
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index cc9915543637..8b03fb380397 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -47,10 +47,10 @@ const struct ip6_tnl_encap_ops __rcu *
 		ip6tun_encaps[MAX_IPTUN_ENCAP_OPS] __read_mostly;
 EXPORT_SYMBOL(ip6tun_encaps);
 
-void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
-		   __be32 src, __be32 dst, __u8 proto,
-		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
-		   u16 ipcb_flags)
+static void __iptunnel_xmit(struct sock *sk, struct rtable *rt,
+			    struct sk_buff *skb, __be32 src, __be32 dst,
+			    __u8 proto, __u8 tos, __u8 ttl, __be16 df,
+			    u16 ipcb_flags)
 {
 	int pkt_len = skb->len - skb_inner_network_offset(skb);
 	struct net *net = dev_net(rt->dst.dev);
@@ -58,10 +58,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
-	skb_scrub_packet(skb, xnet);
-
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
@@ -89,8 +86,31 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 		iptunnel_xmit_stats(dev, pkt_len);
 	}
 }
+
+void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+		   __be32 src, __be32 dst, __u8 proto,
+		   __u8 tos, __u8 ttl, __be16 df, bool xnet,
+		   u16 ipcb_flags)
+{
+	skb_scrub_packet(skb, xnet);
+	skb_dst_set(skb, &rt->dst);
+
+	__iptunnel_xmit(sk, rt, skb, src, dst, proto, tos, ttl, df, ipcb_flags);
+}
 EXPORT_SYMBOL_GPL(iptunnel_xmit);
 
+void iptunnel_xmit_noref(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
+			 __be32 src, __be32 dst, __u8 proto,
+			 __u8 tos, __u8 ttl, __be16 df, bool xnet,
+			 u16 ipcb_flags)
+{
+	skb_scrub_packet(skb, xnet);
+	skb_dst_set_noref(skb, &rt->dst);
+
+	__iptunnel_xmit(sk, rt, skb, src, dst, proto, tos, ttl, df, ipcb_flags);
+}
+EXPORT_SYMBOL_GPL(iptunnel_xmit_noref);
+
 int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
 			   __be16 inner_proto, bool raw_proto, bool xnet)
 {
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index fce945f23069..c0e9007cf081 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -170,10 +170,9 @@ void udp_tunnel_notify_del_rx_port(struct socket *sock, unsigned short type)
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_notify_del_rx_port);
 
-void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb,
-			 __be32 src, __be32 dst, __u8 tos, __u8 ttl,
-			 __be16 df, __be16 src_port, __be16 dst_port,
-			 bool xnet, bool nocheck, u16 ipcb_flags)
+static void udp_tunnel_add_hdr(struct sk_buff *skb, __be32 src,
+			       __be32 dst, __be16 src_port,
+			       __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 
@@ -188,12 +187,34 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
 	udp_set_csum(nocheck, skb, src, dst, skb->len);
+}
+
+void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk,
+			 struct sk_buff *skb, __be32 src, __be32 dst,
+			 __u8 tos, __u8 ttl, __be16 df, __be16 src_port,
+			 __be16 dst_port, bool xnet, bool nocheck,
+			 u16 ipcb_flags)
+{
+	udp_tunnel_add_hdr(skb, src, dst, src_port, dst_port, nocheck);
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
+void udp_tunnel_xmit_skb_noref(struct rtable *rt, struct sock *sk,
+			       struct sk_buff *skb, __be32 src, __be32 dst,
+			       __u8 tos, __u8 ttl, __be16 df, __be16 src_port,
+			       __be16 dst_port, bool xnet, bool nocheck,
+			       u16 ipcb_flags)
+{
+	udp_tunnel_add_hdr(skb, src, dst, src_port, dst_port, nocheck);
+
+	iptunnel_xmit_noref(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df,
+			    xnet, ipcb_flags);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb_noref);
+
 void udp_tunnel_sock_release(struct socket *sock)
 {
 	rcu_assign_sk_user_data(sock->sk, NULL);
-- 
2.51.0


