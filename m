Return-Path: <netdev+bounces-222517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C7B54B52
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231C63AE7A4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DA2F3C31;
	Fri, 12 Sep 2025 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="al6DQyxI"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A382DC791
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677513; cv=none; b=NwaWmzak8ryz9D4wLAYqMkiw1fcsLMWMphdnIHf9aoDcM/xZwoTwzxlvpIzmaTWOJnsoNRH1Fb0zn1q6q3CfgxMcZxRmbuECfQvtZYj+y3bH7+bFK8Aj2aZ8kAuLjc+J5CFfJg/xv7WAtoNMc3JHPWaZ0n0KNNjo3/383nfXRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677513; c=relaxed/simple;
	bh=lZxSpP6bc+yrLhDlPDYG+Ew03JLZO/PQomcPSncCcDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pk4l2xaeZpySgW2xT+dY2qk8Irs+RRz7SxlKw28ma/9cK719HkWHnrsoR8vUk365xNtaLwFrdkMULpiUdBjSB3pX1o68rUv7iu6/ATnQzOzFBIEejFsuAg16atRHGrfzY8ATSnSLc/wTBSaATyGOBwKmay7yiN07+0NCDYP7IeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=al6DQyxI; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757677510; bh=hOCx3exMi/gEZlRMsfu6f3yZal5ZMUNsmvImqwmEt+8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=al6DQyxIgm5jX9CJoZN6/Shihzz7bJ2P3cZjR//pA3Culr8jgisIIQ7AcKSQiWluOLJ/aX1nrzEQNE39ZVNAnla+6dQVSgR3aXSBGvyn8carp+snNzzC+dao7ha0GMdSNffM/5yWwsGT9Af0Jw/8/VLy+S5IrO27LyBP00upOmCooIP8Gw4xAz0gECz016VFe3X832YEzUg+tt1jZU0VO0ah1W7mFmvIUEZdMZx0lFolwwtCOnZpt6IaVgucUxDmLEqU0hGl3eNNbbdcDuxudfE0Y9AimXaDlNXhMzhHEqEcF5tx9v42guDOrV/pJGPq6YzsaxUnNR0IyW+3AUhr2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757677510; bh=9JkiZoW6deyCjsWlQaLj3VSSdwwok/TE0e0aoWnV9xb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=e8gDXmmcFaetN6XJ/o5whJ4O7g2S/PgUn+4XM4wAxqLEWuNPc2pPiJObYaLAEiz7q/Hl2SUAeznB+Kh9UCvsVKXJBaUC8KV3lAoeEQoudIeZ0ZBN4F6mT/jyL4g/Vj0E2H4RsL2/DXi0T477SQInirPt5zlNEpfLba4G80VfuSs9KVC5gV16eCD6hMzdViEq44GWjVaxjT/iEwfdJ+MRnNu6WXzHpF8eXYy6ZlpdWOAxasd9i1xpOtC+HXeS9wdG02Y/qkugO086p074Epzr3bshpcgzR6WTcmubhvNys9ifT0ZgEhmePInif0u34MDbG5nj81gjW6un760jTaEw8w==
X-YMail-OSG: JnAdo2oVM1mN0OqDLmR5gaglMmx8KeC5hCvpizUCTMjAv0EPrJsysxZ3BKjYcIz
 4bOEwjTozrhvCHIXSuZbgg6muj00r3ytwu5cjlGbUGqKcgsEEAn9ZaDCMKJD.YK2N9Rg23hb9q7f
 WO.fQBib8ZUBUua7giPRhVc86gZhO..WNqS4sxlVPGGB6pI8fWsSCpBu.HzRCQ_EvrldpyHNIyRM
 ip_ukjWUa9HmncvsfwyxKBGtmc6oTjJ3y865FAIgooqj65otmvxbNQUJcc6ZxOChDzfOozKPYc9q
 XMO7Mpf6EzxTvy_Pe.x3Fp37z6dm4dOGST05rz5Iy3yvMITcOMnjwP3sNIDHb1q6Wpt6R5Y0OBsN
 YpuvDYDWJXtZDALVzTvOuUvqNGxkvHrPHpdaTYt3MF47nPhXyeEuvBLgeQm3vKeyXxzSrHBWraXi
 L_Fr8DOrJkOZs1K4Lp1zKR7mocyYzELA6WMXnQ3pyPoaqOMgKLsSmxr._ixEh9.qSxHHkrsUo2De
 z1RQCkKcI6rle8lEyDPYijc2XzwuwmggBoYVITVcfoQAqkMehPkFTID6HcJtyC8m10RUpwX7XzL.
 NBVyeFXDJUxgSqB2qH75Lyeb2J468PONhiGOEO7pQQPnVScNmKD3uE7Lk1aRMPQ5.gNDB_4rQi.8
 ANI8zVFCVRfZ3F2V5sNgzoyCCOebsXekPXvHxKWOEzyPWtXew.xVEwMO1AKN1MxeVufwhLIY2nMJ
 L.xVaJpaQiBAj1ltAcEYALxzCc863HZ8qHxDyVS1eFDzcw0t_GQSk2zehKSwJsYPHH6jBgdEYscM
 CSBJexgUOr0SSEQlUNrN0Stfgbw9DI5P4.V2T9hkpUDQZLu8qEOFSNqTowAxo1OarepImD5C2_VI
 nJcIhSWfPDn4G2UjydaCzVmsezvKDnEPyHGdCSk7K5v4qFdHsiUzWXG36LnoXbAjxx7geM7jXpgh
 qdOOC1OnAApuV50g_7pfKeyb_crguQqt48G5KdOv5ZB9PtkunHKUV4Ezdctr9T1rHwS4hVjC0zQ0
 X6LjNhYUrSnGjKphHA_cfe_qNd.iSLZZTdUMeWGmb23pCu9JdehktsEWwVGrtbRD1ES2DYSwOFHM
 gvMrUW_Vf5K0D5jpxj6u1SLBSjPkmWKtW1fNrjFnj12i2JaC6yMwcT6325kuMLsZlXkmgxyuREbx
 hQQ63Q8g9neQ9UPlthxDE_26qpxjDZf.C0DqZI0VzCulkOONxgjfUhAi7nGJ7u4Y9OeRVaqsJzwS
 _4T1z0pCoc9HCwkMuFMLeinv.FA8wcma1IaGrReZtsiqc.bz0WO6vCj2_3vMjSdyAcYTw9ATz.yD
 1wuoxE_e9P6Dqxn66JG8CK.dGOxlv2boYssyX6QYDnlJNBZIAeqL1h_wzf9LFjY1iE3gzKa0cbgL
 lHYvlFAWx9P6KjAbym_WbGfsANarDsbhYjifcSkjjoNj346NeXiKf9CxVtt.YV8cuwOfov8pf1I8
 9vGyzE4RouLc_TGaAAsvGmRSSLd1nV_Xu8ZEeddhpe4UhqrPJYPJM_U10aM_5VuPnJh9XlFMk0Ms
 9tIMobZTy0_9C2Xcd2I.FvZJW7ZDZnRUHujXdBJSTNeHlzJoDLAcUUt9yR698MR2Rge8cJg6ZOJR
 .KVgHxQX3PCKXt8t1fHxQf.jxXgBCaUyX4IUHK8gshzP2oTkgfkTi25ltwCHxatJqlxFzKOkEpU.
 UnRUy3DDfqTvt6T.h.XgQMwf0IgqrlbLI6noTkbFw95Cf2WkKf_yF6CZvSWkvy1zOdxk3hpBoHRs
 jQXnK8hbuQlSAI_8N5FTY7YKc.yn49dMDwIzcPEjMf7L9AG7eeNlrNTSNroXQfWTH7bC9rQVWA0f
 EWR_LHbMIgvRUe7uWylSy1VhXI0sYl9m5R9tUtPRf6TDipu61f6Z76yq7skzXM2yXi9Skt7GHt4K
 yzooLZKGVRavykDxRbAjacp52V1Miliv.0uYBLUL9XIwLvQHOVCubfDVlVshc2pKlttam4crg_GU
 UtXTul4BrHRm4VT0ru95y2gkc5wZMXulGpxYRQg.z8UFm_3QjlULTVuuUN83p4peT.EAd_8Jkl7q
 dye2GUOAkbbX7gvhYQPUZ0x1xYWEYWyPFGfMWGRxYFyhqnq7bqobRfB7DJDsvkB.3Ii_tWuZd4tK
 .41i.vBcfi_bbnl0qH0B_jB1SDNRgNxGsmnY2O2QyjH8NvihwGAI-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 1a3c935b-93fc-4057-a8bb-bf9bf1fce931
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Sep 2025 11:45:10 +0000
Received: by hermes--production-ir2-7d8c9489f-pnggd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 93cda13a9625b3ea865113cded111022;
          Fri, 12 Sep 2025 11:24:53 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	antonio@openvpn.net,
	kuba@kernel.org
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v2 2/3] net: tunnel: implement noref flows in udp_tunnel_xmit_skb
Date: Fri, 12 Sep 2025 13:24:19 +0200
Message-ID: <20250912112420.4394-3-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912112420.4394-1-mmietus97@yahoo.com>
References: <20250912112420.4394-1-mmietus97@yahoo.com>
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


