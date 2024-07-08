Return-Path: <netdev+bounces-109833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8A92A0BE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27EB1F21F56
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF37D41C;
	Mon,  8 Jul 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdjt7ATR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485D78C7A;
	Mon,  8 Jul 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437154; cv=none; b=ZHmWtdME1nn+BkRzM2IggBGHrPH6X9Qvu5k16tUA0v1q6KzYT8UuKEayH9uQsXzxwlS/UBhkBc9PfyA1IskGuU1hW/zD2INcx3bBbyZHizgyVXiai0235V7tXYI8NFrC4PdkwgrC1Xuqc+MKgtdvSNyJSV1LEe26OcvSmUJjhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437154; c=relaxed/simple;
	bh=VEFci7G3mi27EkLeUb3e/qP1b7/BHoJueoxhrKr5Kz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANDLacsgd4segftEjAH0/ymbbPkBhum74CgxV+dsk04SemKiCkB1p5r7q75ZUBVrVXztmvq6ZMeKO/0jYbxzruQhM9VD1Qd0g9JIBXmACeX2aKi7aLLXltkjAn8UrXBRvO8dZrzc9Xukzf7+/EZk+vcc/VjXOiee/4VdmGwInrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdjt7ATR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42662d80138so9329575e9.1;
        Mon, 08 Jul 2024 04:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720437151; x=1721041951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67s+ZSx6ByUI7UoMub4pm9dbcCqqG+tRs453oQ/o2Ck=;
        b=Vdjt7ATRYynViLI0f2PyTpMn7Izjlj4ahVE85tpxy/Sy0/t53IZHr05V+fAX3pjgz/
         tx5w8fkQ3Qwt5CaagMWJsCEOHRn+siY0YGhFrEBgLzxRy0ip1ryax8wE0Ue+dLSvEaVL
         NN1/6cN0aarUnUiIey2bB3rgqvg75+O+LepyXW7Yf9rOWXmn0WbgKENz20FlIesaxHID
         Wh52kDBDN2l26odm7a1vc8LIv64+Os0sDrVsaaKTauzUDv0X299/kU93xHdhsuC7Vsjp
         Prh9lKugv1i2yWDyRD3bZ9JWFuHbfuPsVWltPKoIgbOlOPkXdGv3T5SAUJRAvvu2uTIL
         rffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437151; x=1721041951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67s+ZSx6ByUI7UoMub4pm9dbcCqqG+tRs453oQ/o2Ck=;
        b=Wa/658vs4qi65c5Y001OtfZKA3E8qTTIo4rq0fH3+Qg4jUrHl9wiiPiS2Mxp0OSBcB
         mmiVI8WB0eA48G2oJkpEkhJC946ufl9dJyJ8t8vyDLQiymo3ajgi3AHp6SIG0G2ALY22
         j3JPau8ZwP39I9C1NIPGKngLfQrpLY9mC30SMS2sfvFGRKKJFKOK/g88t8J5EzuNZnF0
         Uaj+zB0NOeB+RCmtKK0pfUBBoFjg8sikBzHPIrNxap60E8/1uac8YAUnss8rrKuU5A/z
         aJSzeNE7odICH6G7YWot7DA2vAH5zB3peHnbcMmmjuoWnlCdVsDbIKSThW707MXp0qGZ
         9mRw==
X-Forwarded-Encrypted: i=1; AJvYcCW5Go9pfrwZd4Ip/c4oCH8o4a0Bi3putPD9xYL4uB8gaF3og6A8oO64xIfSSQqmKeBXEcEUvHDU/H/QEC7qh8JDJiJPuWjVTPOl5N6gfmyg/T/S5A9xbVPV4FyD5kTDaVevdtR9
X-Gm-Message-State: AOJu0YzjPeZOmsilGf6SI9xesFA5hs6MCq2XGjX71al44IDteBFW8Kpx
	iAjLjGWPh5pGsRVBSOnb8+1tZ0WKDLfCvJd9ZC2Hir/YMIyOs4HK
X-Google-Smtp-Source: AGHT+IHvxMYWTt4oM+sQxpQaUbQzBb7+SnG4kUH7vMNebJuTXEGJzWapIYqX1KgomK8Od/ks70Kuvw==
X-Received: by 2002:a05:600c:1ca8:b0:426:59fe:ac2d with SMTP id 5b1f17b1804b1-42659feacddmr51745885e9.32.1720437151132;
        Mon, 08 Jul 2024 04:12:31 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36799a54215sm11149661f8f.68.2024.07.08.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:12:30 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 1/2] net: vxlan: enable local address bind for vxlan sockets
Date: Mon,  8 Jul 2024 13:11:02 +0200
Message-Id: <20240708111103.9742-2-richardbgobert@gmail.com>
In-Reply-To: <20240708111103.9742-1-richardbgobert@gmail.com>
References: <20240708111103.9742-1-richardbgobert@gmail.com>
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

Also change vxlan_find_sock to search the socket based on the listening address.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 53 ++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ba59e92ab941..9a797147beb7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -72,22 +72,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 }
 
 /* Find VXLAN socket based on network namespace, address family, UDP port,
- * enabled unshareable flags and socket device binding (see l3mdev with
- * non-default VRF).
+ * bounded address, enabled unshareable flags and socket device binding
+ * (see l3mdev with non-default VRF).
  */
 static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
-					  __be16 port, u32 flags, int ifindex)
+					  __be16 port, u32 flags, int ifindex, union vxlan_addr *saddr)
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
+			if (family == AF_INET && inet->inet_rcv_saddr == saddr->sin.sin_addr.s_addr) {
+				return vs;
+			}
+#if IS_ENABLED(CONFIG_IPV6)
+			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr, &saddr->sin6.sin6_addr) == 0)
+				return vs;
+			}
+#endif
+		}
+
 	}
 	return NULL;
 }
@@ -135,11 +147,11 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
 /* Look up VNI in a per net namespace table */
 static struct vxlan_dev *vxlan_find_vni(struct net *net, int ifindex,
 					__be32 vni, sa_family_t family,
-					__be16 port, u32 flags)
+					__be16 port, u32 flags, union vxlan_addr *saddr)
 {
 	struct vxlan_sock *vs;
 
-	vs = vxlan_find_sock(net, family, port, flags, ifindex);
+	vs = vxlan_find_sock(net, family, port, flags, ifindex, saddr);
 	if (!vs)
 		return NULL;
 
@@ -2315,7 +2327,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   vxlan->cfg.flags, &vxlan->cfg.saddr);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
@@ -3503,8 +3515,9 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
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
@@ -3517,8 +3530,17 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
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
@@ -3536,7 +3558,8 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 /* Create new listen socket if needed */
 static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
-					      int ifindex)
+					      int ifindex,
+					      union vxlan_addr *addr)
 {
 	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_sock *vs;
@@ -3551,7 +3574,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex, addr);
 	if (IS_ERR(sock)) {
 		kfree(vs);
 		return ERR_CAST(sock);
@@ -3605,7 +3628,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		spin_lock(&vn->sock_lock);
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
 				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
+				     l3mdev_index, &vxlan->cfg.saddr);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			spin_unlock(&vn->sock_lock);
 			return -EBUSY;
@@ -3615,7 +3638,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
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


