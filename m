Return-Path: <netdev+bounces-212906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4942B22783
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBBB56811E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4527FB15;
	Tue, 12 Aug 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYfvLOIx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C726CE3F;
	Tue, 12 Aug 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003162; cv=none; b=rMFAeDPQRjes/sagqdRhzWeoJG8BkrBempmg0iFYKVmoYEIHsF9LR6j62ny6P70USA+gBs1PTi/JwRWHD7YWwLOQTPAVxXUDu3FfdO9dyGN3InET2eR/l5Y+luh1LI5xrDY24Ph6vrbZmny/8UU501i073Le3tGQDMSurtVKnOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003162; c=relaxed/simple;
	bh=7ldexyZGaQqNiSJVVv+r85+DH70yYKn6oTCSONEu6IE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7EPj41M1QbFsuX95uHHjmDSZcZ34SU2RFXiFfE15plCTxKxUFHI9+CucZk5X76Y2QtNHgCcSItvJVSWFtgUl1qERlfABDLZbRaGrEL2b1l0w51AcSeJfvBMzWT5Ht4OHslOJikCGS5NO/f0nb3hha/aB42M9q6+xVSKnX1Muco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYfvLOIx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso2936020f8f.0;
        Tue, 12 Aug 2025 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003159; x=1755607959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfeYt6RZMhwHOfr3jVLM4IaLd8jRzoz2lGRzWWlWxT0=;
        b=QYfvLOIx0Fh0yupQzWSnSrDbPpBdHTDmdRVAs11jzgE+G8x60eOsz3jeyUft+MzwR9
         nRMUaBgMDjSdEegz0Wu/Y7oqtCt3XLZDuGXgHw7I5ICPcJlCpdQOoJLG7gKFB7zUVeD2
         y5a5g4yRB/WJMomYhM+fPPFRUImAvqV0YIJSfMQUnoO/8D1W8LM0VWKVRZTwx+dxW6dM
         iJFZrYgf7HH0xqIv913bnCmPWRFzJqA+Rqe6zvwjjR9jjuNq7QIcnMQj3GiTwVf1uEU5
         trGclP4WGwNne9dKGh/53pwYK3wZlAn4tQIr38aHxnJClBqnRBEiSjroXhi9BTO+VklN
         Zt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003159; x=1755607959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfeYt6RZMhwHOfr3jVLM4IaLd8jRzoz2lGRzWWlWxT0=;
        b=bSaTaVC6fMuFISFpA5qLLayUFxGFc9+GQvvpUMUYEszLlO6YZw1ksi3Ek6b4/E/CQI
         rEUVOAHRXXW+8Y0vD4ZeLt+It1SSRCm0mjOWj3b6NmDq0EC/vLO89IX1haLU58XokHpa
         RleafCHs2io0nknx1Bg3tj4P6g6ArSqMzVBJts/kbR1FOJIHqV5Olpfck6DCoE4PyEFf
         hoGo/VxTMXcDXNlNq4BmeBT28SOva+kAi16DPVCsoy8asR2Z5cuo65yPpzmgmkgETA9W
         pv2LH+K1uE3MOqxEZAcRq2Fbqtgpb/q1dv+dcGnsqjYpsru+hRUt2x4qTtu8ZXiTVhqJ
         3YYw==
X-Forwarded-Encrypted: i=1; AJvYcCVwG8hOXKjZCXs4afpWu1K8EikthrmvlyfVhW2xONQh5pY2cxnf8VQOiNLm2ca3OpgQkeLLl84oPSvlHGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY12KE+apD+S2OmHBFIufkyVQySXKJrb+UlKAFXLrSQsjycsjg
	xy5NOqZdFSHF9noQ/6vm9Qa8Y5dMhjjp/4qhsR9ZyXKT1jz95qyjeaEAyhyku2eoN7UHJg==
X-Gm-Gg: ASbGncuGl6n1PKKrQ5cd6xWCnNMN0uo7hI3oM38/W6uk47FaiSnYzHC+Zl3HDHwlQ8B
	g6ZPaN4/C/KRl6Xbz0gYwWnDvpJsKaDHj6GLp5HE2285jardM0UzGyInMaEGINO2BELQW6ih87L
	6Vj+mdr0LmvSQ1/XBX0HKfX7qPBbjRZaP1vjbssr8sxwp53QihgRbbft0xB4RRD0HBVCDFlCldS
	zFZ0IEefjMN2rw+hpovwB5+D4dIyLTsMY9Hq0NbJ6j6HLIo8w0i6VuMoxrQ2tPrNbGu1uq1SMTS
	wz9/x0r3q43CWsXX807PcPCelZl0BTLC13oVMjDuEVowSnJm4dp7YJP15vvFS4HCEx64jXL5cNN
	lUiPQ0mSvgcfH+7aR5CDo/LY42Mp0PTdL6NrcEI/y4Cwp
X-Google-Smtp-Source: AGHT+IH4WV0vfZ3Y+zm8p8nUH4oeT6EItJT22//9sHmF3GmoHywcuAuZJTgt+J3VH5i/jdcHrqjwUA==
X-Received: by 2002:a05:6000:2381:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3b910fd9b92mr2787856f8f.16.1755003158550;
        Tue, 12 Aug 2025 05:52:38 -0700 (PDT)
Received: from localhost ([45.10.155.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm45723889f8f.45.2025.08.12.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:52:38 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	dsahern@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	jacob.e.keller@intel.com,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	martin.lau@kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 3/5] net: vxlan: bind vxlan sockets to their local address if configured
Date: Tue, 12 Aug 2025 14:51:53 +0200
Message-Id: <20250812125155.3808-4-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125155.3808-1-richardbgobert@gmail.com>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bind VXLAN sockets to the local addresses if the IFLA_VXLAN_LOCALBIND
option is set. This is the new default.

Change vxlan_find_sock to search for the socket using the listening
address.

This is implemented by copying the VXLAN local address to the udp_port_cfg
passed to udp_sock_create. The freebind option is set because VXLAN
interfaces may be UP before their outgoing interface is.

This fixes multiple VXLAN selftests that fail because of that race.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c | 59 ++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 15fe9d83c724..12da9595436e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -78,18 +78,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 }
 
 /* Find VXLAN socket based on network namespace, address family, UDP port,
- * enabled unshareable flags and socket device binding (see l3mdev with
- * non-default VRF).
+ * bound address, enabled unshareable flags and socket device binding
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
+		if (flags & VXLAN_F_LOCALBIND) {
+			if (family == AF_INET &&
+			    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
+				continue;
+#if IS_ENABLED(CONFIG_IPV6)
+			else if (family == AF_INET6 &&
+				 ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+					       &saddr->sin6.sin6_addr) != 0)
+				continue;
+#endif
+		}
+
+		if (inet->inet_sport == port &&
 		    vxlan_get_sk_family(vs) == family &&
 		    vs->flags == flags &&
 		    vs->sock->sk->sk_bound_dev_if == ifindex)
@@ -141,11 +157,12 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
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
 
@@ -2309,7 +2326,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   vxlan->cfg.flags, &vxlan->cfg.saddr);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
@@ -3508,8 +3525,9 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
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
@@ -3526,6 +3544,20 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 		udp_conf.family = AF_INET;
 	}
 
+	if (flags & VXLAN_F_LOCALBIND) {
+		if (ipv6) {
+#if IS_ENABLED(CONFIG_IPV6)
+			memcpy(&udp_conf.local_ip6.s6_addr32,
+			       &addr->sin6.sin6_addr.s6_addr32,
+			       sizeof(addr->sin6.sin6_addr.s6_addr32));
+#endif
+		} else {
+			udp_conf.local_ip.s_addr = addr->sin.sin_addr.s_addr;
+		}
+
+		udp_conf.freebind = 1;
+	}
+
 	udp_conf.local_udp_port = port;
 	udp_conf.bind_ifindex = ifindex;
 
@@ -3541,7 +3573,8 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 /* Create new listen socket if needed */
 static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
-					      int ifindex)
+					      int ifindex,
+					      union vxlan_addr *addr)
 {
 	struct vxlan_sock *vs;
 	struct socket *sock;
@@ -3557,7 +3590,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex, addr);
 	if (IS_ERR(sock)) {
 		kfree(vs);
 		return ERR_CAST(sock);
@@ -3610,7 +3643,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		rcu_read_lock();
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
 				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
+				     l3mdev_index, &vxlan->cfg.saddr);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			rcu_read_unlock();
 			return -EBUSY;
@@ -3620,7 +3653,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
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


