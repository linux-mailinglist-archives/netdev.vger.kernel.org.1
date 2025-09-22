Return-Path: <netdev+bounces-225243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B2B90706
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CD7188D4C4
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AF3009E3;
	Mon, 22 Sep 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NBdPvu5c"
X-Original-To: netdev@vger.kernel.org
Received: from sonic302-21.consmr.mail.ne1.yahoo.com (sonic302-21.consmr.mail.ne1.yahoo.com [66.163.186.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19C27A45C
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541099; cv=none; b=h6rgH+fwusL6X+p6/wz/tHFKzxitkg/mXmEzk2ttP58XS0KcQQfznXLUmYxdYNPTLtXixoas2geGbdZI7tOxiIUea7LpA1xRRzANI24N7tXigAojOKfU1V5YprPYIOL9O3tKt5+kKsarjwG3JcAFfZNBIV1OEX9Ixwpce87Dm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541099; c=relaxed/simple;
	bh=Rfw5qX3FbBRu1+mWR15vZTTyEJFavdS3p3fBubxmHC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl/hAkT9fsuhwM1FzUuTfchAi7MuFDKrSWJe+2ZPoiJUHNpbeZ4mbPTVQJhNOIgw6hn8jTjYqom7MJosacdq7LZO9jUBuXbCFuA/7a/p2UyyqoYDrW5RRt861JoasLvtx18inIq9fDKQ1eEtRBZ/HcXWnt8Mg0ZdyKq3U98iBsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NBdPvu5c; arc=none smtp.client-ip=66.163.186.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758541095; bh=F/CrqXPhav1we8hfen578C8Cgg6tKMJWqu5+DcM9bjU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NBdPvu5cOd0+rCFiL+FacgzOVC+aUHjkBt6uF4f4nb9bKnt9Yd6jI9u+EMoQWNk3wDjPROq9wjvvbCja5D9pbAfKfTdOCFrVhv2Ht4WYzOwI5irGPvYNBOu0gcKjRy5EWAAsXDhqkGl4LI4lTsunMnsIZjsOL5ZkpNbYe6afp0IHZoj+Rge6XkNEBq/LfZV70tNdSrL4e/+aUELuPovu65KTfQCnmwwxv2jxeh1U6rUlbsEZKYs85HQ6XgIYTknG01bOJ/qgZNhXXchrX4M0UdBYAcDchb5SApT0aBNVLyts65j0zeuRQ8VcCco+lHh9O/tN3z1m/RX0J6cstIOW0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758541095; bh=el6NnC+C7PvzYEtlpsQyCBftMbokC1Tuy9BCl8ePyWg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oO3sR/z0M9wdppO4kxbxfXNftzH4gnSpl0o4Y75O2uYfGTIqyjGtvGz6DlEllF3rDz/MjIw2TzFvYGgOzoW12X+AsyXhpb9/4kBCLqXdCNy42zl9XW+gZONTvk+T4W95FRRzO5MK0EUBuxCNWRyTj372UY0srjlbMgOc4qVxxzCLYQZum1cHDlrDXbVtYO8KtMiOPoEmUvTDl8ylQ+7YWEfYCAEVeEE47m2O4z6gC7UHW2j7VeAa5Jleym65IPrF2tgBng7KmjfijSPUauimYotte3g75WxuDRjfGbhtMd+pNWK1zS1OZqEKbJPr14iFteAAK2oLK6JqP64wWWOSkw==
X-YMail-OSG: X52VvukVM1kDIdEIlckeH3xnZ5yKNdZ2hkGgdBkcfU8E2HL41K13U.8SaHASK8O
 pmkoWfocFvIj7U_yIhhILXTjPa1ff5GdAQZxmfROH29yqhlSJ0FdqzoN52meNEacdJ9GxRfgVbaB
 qVLnW_1n4jG8rDuPw1zaLrkDHjNpzOVbEN8hknV7vlBYKEtG9K922CPztSXFlt4Q7druI5LAMCQr
 MGlLiRmp12EaJFaMGPJbfxu_FVZUW44.tEJKhPaErhTDl_i.WJ3RoG5dpCddhvIC5utKjSLlLE6V
 AHuYspu28zYwYnFo6iWoqxlGQVr1NFpFq7DpIxvv.ZNjjIV0cmFJ.EhqMY0aqWg0H8r.z.uHneBW
 q3iKi5eqlBa8SZ9PE0s_EF735WnWIZRkaNzukqo2ukcipD3B39xd2pkAaCRXriL3GKnEKt0.ki8m
 ZJfWiwU0F1WfdFljYIdHFhCyPobIvvQybHEG4_P2pp9mgAanXioHipBJT9BhO9QFowRuYdr8Cxwu
 Qe.BKEVpqAxp6_SGtVaztCUGLBJrEdQQKlRt6xXm1a3H0bDN1utdQ68yTQRKHWysyRUO_5WHihar
 xawpSaxliX2aGL4273082Rmv2r_3ja4HkTt.HHV7MEoVN42NrDEjFI2Njrz0KdBSBXP38a5kTjxC
 3nQ1hxbUf_VzdGpYSqd2IE9LtGK0nn4.iqjDyx.uLa6AnFCdcIQ4UT8J3deymzuh2WGqPZRtiCP2
 o23hZhzT23cS61gVlg6ZaRQZzWsllkLmp8KQmsQDoZPuchYsc2xIETkcslY0npVb_vmca8euzGM9
 afMk7cQB_PCX4dKM8vB3XP4vMV19LTYxKW4Yc5tkIo0uWtRdA5PbTwtUefmc7qMJzQd9s2XnfDR9
 AzD8tNDZaDK0gW1FRJ_26de05HIkbI_iDzbekHbdONBL29pisUeI2MXt67iK9WddrqSg3ZpTNIsk
 eZLOJkqItzG2CeHHz0yhh0Qn8RpjXP7gyggj9lubJSOc5H3XJwOuA1cRk3.KVSQht2RNVeGt3aX1
 Ie1HO2JnZEhHw7ShRnMidfCEY4GEfU.46plYDtykxmGacg5KFZYKn2ciE15d9ffeRj1.2Ecxvrd6
 4gEQguXRutcgBZZ2MxGCyXNPqUyfR8jIfR7qc4mty4bqPq2A_EUBB.xSPAUx1ld.uSbJXRzkX66u
 4UVCIizzPBFW.rMV92ZMa.QaIeLCiMkTA7KGGf5h7LvJkb3scAiT53roytd_PxgJZI41cqPrzcYy
 O5E7_FWYHe8UK1kC6n307wJqHdjxRi1dmtXkxPOz2X1z83LTEZdfvK.riI.WlCZ7oL3TleS6XeHq
 ZDvP5JRQbFlqezbxBcpqBFjTKbbYw7ndt1lV8U2Bzv9FeGsW8oo14BhahfMuR_SlGm5ta85CUlLb
 EM6C.Ep3_KY.Q96_o6mS.9KP2_1zT0WRzXjZ601hYbjxOO5G0oD6pg2mjC1c0E4EGpCdVtoA1Z_N
 F3LXe0LDrrR9mLOYgfW0vs0SPBwwT_g_no0ekCQIGwfgzZRlZljxjWEQ713z1qKBsKOCeGd.fpE6
 RUv0fzl1_il2QQ4JYM905F73GISpIIyRNSRWptgOlWhOuaSkwA.0JpfGtLPQRWi_KfBAX.578lJy
 KrRWEp96E59nRle5sK8b8_jnX3I8ZeAH7wpno2Fhi9g8T2Ba4thcgKpwBxbxXSnfVcFKMnaes1ul
 jrBPT9GnWRdwE.Qfqt0YKDQIV05W6ddmdR5lFw_5_pNV7n6h8XYSIZlwrimnybS0fc3y7IaBpuu.
 XZNrdjWjWCsVJO9bUPPS0rm.fDE3vmBv.h3WvQKnVkZLgNQWiZZSEf80Ay3TP3B08muJevTKi.HG
 rvDiOatvI_rwSbUwydyTKgntP1abwVOZqmydducLD7_ppdW.kSByxntJVrBt_rLNnV3XUEu62ahr
 2U2ndh4Zk05Y.lQSIjws8otJ1uah3wxT72RnQql39XVbuaLhg8e4UY05WzqdK03TNXyJoz7Y98WK
 i6IXAVmaTjW1NijRBrmXCyHcz7P2SW6kG6HGC2O2VMAVMGF2H4Oxjk8685aB4HzNtz6DJ5afHsHC
 M3ENKnsr5uMeIBE4tJOiR.mFpmVWG2DXqJXkJuyhqk_MUM1_Npagk.o7y568.vFL7wtP57lxXwoj
 mSKKCsHOHluaHg9IikWxqbiLFxAhcqF.SH9Cjv0tnq.WvJw--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0f9b02dc-6fd8-4eb9-aa3c-3c63d1b058ab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Sep 2025 11:38:15 +0000
Received: by hermes--production-ir2-74585cff4f-4sjhz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca5bfbd718d89396be3325d48d68935b;
          Mon, 22 Sep 2025 11:07:29 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v3 2/3] net: tunnel: implement noref flows in udp_tunnel{,6}_xmit_skb
Date: Mon, 22 Sep 2025 13:06:21 +0200
Message-ID: <20250922110622.10368-3-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922110622.10368-1-mmietus97@yahoo.com>
References: <20250922110622.10368-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases where udp_tunnel{,6}_xmit_skb is called inside a
RCU read-side critical section, we can avoid referencing
the dst_entry.

Implement noref variants for udp_tunnel{,6}_xmit_skb and
iptunnel_xmit to be used in noref flows.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 include/net/ip_tunnels.h   |  3 +++
 include/net/udp_tunnel.h   | 13 ++++++++++
 net/ipv4/ip_tunnel_core.c  | 34 +++++++++++++++++++------
 net/ipv4/udp_tunnel_core.c | 29 +++++++++++++++++++---
 net/ipv6/ip6_udp_tunnel.c  | 51 ++++++++++++++++++++++++++++++--------
 5 files changed, 109 insertions(+), 21 deletions(-)

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
index 9acef2fbd2fd..b35e0267e318 100644
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
@@ -145,6 +149,15 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  __be16 src_port, __be16 dst_port, bool nocheck,
 			  u16 ip6cb_flags);
 
+void udp_tunnel6_xmit_skb_noref(struct dst_entry *dst,
+				struct sock *sk, struct sk_buff *skb,
+				struct net_device *dev,
+				const struct in6_addr *saddr,
+				const struct in6_addr *daddr,
+				__u8 prio, __u8 ttl, __be32 label,
+				__be16 src_port, __be16 dst_port,
+				bool nocheck, u16 ip6cb_flags);
+
 void udp_tunnel_sock_release(struct socket *sock);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
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
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..d262d0a0a178 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,14 +74,16 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			  struct sk_buff *skb,
-			  struct net_device *dev,
-			  const struct in6_addr *saddr,
-			  const struct in6_addr *daddr,
-			  __u8 prio, __u8 ttl, __be32 label,
-			  __be16 src_port, __be16 dst_port, bool nocheck,
-			  u16 ip6cb_flags)
+static void __udp_tunnel6_xmit_skb(struct dst_entry *dst,
+				   struct sock *sk,
+				   struct sk_buff *skb,
+				   struct net_device *dev,
+				   const struct in6_addr *saddr,
+				   const struct in6_addr *daddr,
+				   __u8 prio, __u8 ttl, __be32 label,
+				   __be16 src_port, __be16 dst_port,
+				   bool nocheck,
+				   u16 ip6cb_flags)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -95,8 +97,6 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	uh->len = htons(skb->len);
 
-	skb_dst_set(skb, dst);
-
 	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
 
 	__skb_push(skb, sizeof(*ip6h));
@@ -111,8 +111,39 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	ip6tunnel_xmit(sk, skb, dev, ip6cb_flags);
 }
+
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck,
+			  u16 ip6cb_flags)
+{
+	skb_dst_set(skb, dst);
+	__udp_tunnel6_xmit_skb(dst, sk, skb, dev, saddr, daddr,
+			       prio, ttl, label, src_port, dst_port,
+			       nocheck, ip6cb_flags);
+}
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
+void udp_tunnel6_xmit_skb_noref(struct dst_entry *dst,
+				struct sock *sk, struct sk_buff *skb,
+				struct net_device *dev,
+				const struct in6_addr *saddr,
+				const struct in6_addr *daddr,
+				__u8 prio, __u8 ttl, __be32 label,
+				__be16 src_port, __be16 dst_port,
+				bool nocheck, u16 ip6cb_flags)
+{
+	skb_dst_set_noref(skb, dst);
+	__udp_tunnel6_xmit_skb(dst, sk, skb, dev, saddr, daddr,
+			       prio, ttl, label, src_port, dst_port,
+			       nocheck, ip6cb_flags);
+}
+EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb_noref);
+
 /**
  *      udp_tunnel6_dst_lookup - perform route lookup on UDP tunnel
  *      @skb: Packet for which lookup is done
-- 
2.51.0


