Return-Path: <netdev+bounces-110842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE392E904
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F6028838C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68C15D5C7;
	Thu, 11 Jul 2024 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqX/3Vl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87314387F;
	Thu, 11 Jul 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703680; cv=none; b=EAKk1wALj5n/yLtaj17FdHw/nAHKM1ufN7T4JSmgj+7C0epZyY+Nt0NFjcAo3aa1Ql4cZkWLV5W4jG7KxslWzhzdzZdlERV7FppIIQbY5700w4rCCwB/2FHlTrvZKzS4bVIKKJ6w6ti1mV7vfo8tUNUYILJiwlvdG7i/E4uwiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703680; c=relaxed/simple;
	bh=kMnDnHC6peKRuh1EGNmjeyJ26izdf2QlJfUQUmJcaUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMnlx9nSirsaQl1MQPM/FxmMKOyYtrqiis/xUfBQTxgEvIRJUs1CAKL51K3oxP+VQqy2AL92dMpaKRjrlxIzgNAlBd5r/l9xMhK2e6nFNUZdZW9kfoVsWwg3kOLXHw55/ZdSc5DLs/DVusV1cdtogp7cJk815dKvcGlG7pd+CrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqX/3Vl7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36796a9b636so418077f8f.2;
        Thu, 11 Jul 2024 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703677; x=1721308477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4OCWGJiZF/0bRCpKNuOlysMxuhgiQ6tCE4ubqby34g=;
        b=KqX/3Vl7t/wfJiIkMeaOuc4F5ljj+3VBLqx6OlOgiKeNis12UeJGKbYZiV99dk6YQx
         kGZZwBrryKOcNiZ4wGe8sl03bx/DwMOXiNsJ4AqGj8O26SVgN951mN5yMMTqv7P75x3q
         fTap7QeV8N5y8peXy6D3XI3ofelfq7oklIn8HWACoWETCzkBRyiR9PbRAhO1FQIHYeDZ
         dgqEsFgc65BP/a2zhR0+WClMxDOFXXPIK3yxtwDqLDYf37OFn8Kl0ZnAPSjAuniaVmax
         58l/LD5683xFslQKVeQ2F5epmwvBNju9xg3+U3Z26sDOXclMuTqIFoBbAm+/ndOpbIqc
         +Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703677; x=1721308477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4OCWGJiZF/0bRCpKNuOlysMxuhgiQ6tCE4ubqby34g=;
        b=v8wCELUXNNsWj/nNhyl+1h3OLEMjYL2bxRiRCX2CMEV1YzKEswG1W++uyrixjQqmG1
         54Ws5C1FDKcFn2cXM9zr5eQRoW9iEWmqszz1tVtp8/Ls96KJlQWJYWZCZDcW1tF/3pSd
         3aZcETdq+kG36+KpGYsNa+1LXrRQqJMURBhMTK8vAfnsGiDb+Blt8ZHw69K1MkrjvuqJ
         5SdW5/vE/AuWxSUZCGrWEKbzb+yF2QJqKhbpiBuvRbO09Iu3V4t2PWNiyG8Rbc5te2w4
         uBAvIt3myvLtAtSWzR1eP4s48XOGRtqP/XWN96nIjycuvWuPLfLnDiml2LZRIF80pwmq
         RsZg==
X-Forwarded-Encrypted: i=1; AJvYcCXPwUQ//Q5J7N8c5uV2wxtSw0MAlZjyB1X17NXG2/vquZYpaNx0OFPs7Qup8QJfa5QheoLtyEUk/osqfGbF0jsgsamKOo9rOjosfFSERd9StTJ9ApmrHLLLT0DHssHqr1Ep4WSp
X-Gm-Message-State: AOJu0Yy/iwTZxzT7U0Ijlvc2y5/GtUXLPZ0TW7L7KMZq0WZ8S/ZT5YUu
	UrBvBXXVKAxhpKHJVN302s5rfb04n1h7Y+r/touqL8nRc3KAk6BC
X-Google-Smtp-Source: AGHT+IFLRQKrYhYC/sTj1Qavq3fPHiBPSsbJARrF8r320pwtNbFg+4Jo4N9/rNMW6J7a5CZjYkRDLQ==
X-Received: by 2002:a5d:6288:0:b0:367:9ab5:2c80 with SMTP id ffacd0b85a97d-367cead86f8mr5141333f8f.57.1720703676389;
        Thu, 11 Jul 2024 06:14:36 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0694sm7768958f8f.66.2024.07.11.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:14:36 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	gnault@redhat.com,
	jbenc@redhat.com,
	b.galvani@gmail.com,
	martin.lau@kernel.org,
	daniel@iogearbox.net,
	aahila@google.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v3 1/2] net: vxlan: enable local address bind for vxlan sockets
Date: Thu, 11 Jul 2024 15:14:10 +0200
Message-Id: <20240711131411.10439-2-richardbgobert@gmail.com>
In-Reply-To: <20240711131411.10439-1-richardbgobert@gmail.com>
References: <20240711131411.10439-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for binding to a local address in vxlan sockets.
It achieves this by using vxlan_addr union to represent a local address
to bind to, and copying it to udp_port_cfg in vxlan_create_sock.

Also change vxlan_find_sock to search the socket based on listening address.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 55 ++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ba59e92ab941..b6e34e037d4b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -72,22 +72,35 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 }
 
 /* Find VXLAN socket based on network namespace, address family, UDP port,
- * enabled unshareable flags and socket device binding (see l3mdev with
- * non-default VRF).
+ * bounded address, enabled unshareable flags and socket device binding
+ * (see l3mdev with non-default VRF).
  */
 static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
-					  __be16 port, u32 flags, int ifindex)
+					  __be16 port, u32 flags, int ifindex,
+					  union vxlan_addr *saddr)
 {
 	struct vxlan_sock *vs;
 
 	flags &= VXLAN_F_RCV_FLAGS;
 
 	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
-		if (inet_sk(vs->sock->sk)->inet_sport == port &&
+		struct sock *sk = vs->sock->sk;
+		struct inet_sock *inet = inet_sk(sk);
+
+		if (inet->inet_sport == port &&
 		    vxlan_get_sk_family(vs) == family &&
 		    vs->flags == flags &&
-		    vs->sock->sk->sk_bound_dev_if == ifindex)
-			return vs;
+		    vs->sock->sk->sk_bound_dev_if == ifindex) {
+			if (family == AF_INET &&
+			    inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr)
+				return vs;
+#if IS_ENABLED(CONFIG_IPV6)
+			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+					       &saddr->sin6.sin6_addr) == 0)
+				return vs;
+#endif
+		}
+
 	}
 	return NULL;
 }
@@ -135,11 +148,12 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 /* Look up VNI in a per net namespace table */
 static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
 					__be32 vni, sa_family_t family,
-					__be16 port, u32 flags)
+					__be16 port, u32 flags,
+					union vxlan_addr *saddr)
 {
 	struct vxlan_sock *vs;
 
-	vs = vxlan_find_sock(net, family, port, flags, ifindex);
+	vs = vxlan_find_sock(net, family, port, flags, ifindex, saddr);
 	if (!vs)
 		return NULL;
 
@@ -2315,7 +2329,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   vxlan->cfg.flags, &vxlan->cfg.saddr);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
@@ -3503,8 +3517,9 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
 	.get_link_ksettings	= vxlan_get_link_ksettings,
 };
 
-static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-					__be16 port, u32 flags, int ifindex)
+static struct socket *vxlan_create_sock(struct net *net, bool ipv6, __be16 port,
+					u32 flags, int ifindex,
+					union vxlan_addr *addr)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -3517,8 +3532,17 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 		udp_conf.use_udp6_rx_checksums =
 		    !(flags & VXLAN_F_UDP_ZERO_CSUM6_RX);
 		udp_conf.ipv6_v6only = 1;
+#if IS_ENABLED(CONFIG_IPV6)
+		memcpy(&udp_conf.local_ip6.s6_addr32,
+		       &addr->sin6.sin6_addr.s6_addr32,
+		       sizeof(addr->sin6.sin6_addr.s6_addr32));
+#endif
 	} else {
 		udp_conf.family = AF_INET;
+		udp_conf.local_ip.s_addr = addr->sin.sin_addr.s_addr;
+		memcpy(&udp_conf.local_ip.s_addr,
+		       &addr->sin.sin_addr.s_addr,
+		       sizeof(addr->sin.sin_addr.s_addr));
 	}
 
 	udp_conf.local_udp_port = port;
@@ -3536,7 +3560,8 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 /* Create new listen socket if needed */
 static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
-					      int ifindex)
+					      int ifindex,
+					      union vxlan_addr *addr)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_sock *vs;
@@ -3551,7 +3576,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex, addr);
 	if (IS_ERR(sock)) {
 		kfree(vs);
 		return ERR_CAST(sock);
@@ -3605,7 +3630,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		spin_lock(&vn->sock_lock);
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
 				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
+				     l3mdev_index, &vxlan->cfg.saddr);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			spin_unlock(&vn->sock_lock);
 			return -EBUSY;
@@ -3615,7 +3640,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 	if (!vs)
 		vs = vxlan_socket_create(vxlan->net, ipv6,
 					 vxlan->cfg.dst_port, vxlan->cfg.flags,
-					 l3mdev_index);
+					 l3mdev_index, &vxlan->cfg.saddr);
 	if (IS_ERR(vs))
 		return PTR_ERR(vs);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.36.1


