Return-Path: <netdev+bounces-207837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CEAB08C56
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5667B5E99
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A232BD022;
	Thu, 17 Jul 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4QKO+0W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6229B8D2;
	Thu, 17 Jul 2025 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753304; cv=none; b=jEfcG1cebWEBXEKvaoTaWhwWbAsY271t74Lso3R0ISUHV7JXYM/9JeCZQ2vD8V4sSxyXmk/q0dx1ohCnwNdwNjhssMNlxChqyWxMsl1UOpNEuAiSdBknrF6Da1Bt+KegyJc8FRHHMyz6WGaja9csYs9JuD8+PwZ5bqQeBQ3DXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753304; c=relaxed/simple;
	bh=ck2YVulw2iEuywaFnIjCn2hm4WJu8P7vguDe3iMiTS4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbzO4einziPJBhqZO/vaF17u9B40GRcO/N4BfXX20xKeSDx+9P3HzbJ51pMb6KRRJR7Ba8tkQL1y3c6AlpF2yt+KqJS88eSOrf3X5CAy0FKpt72OLkhEq+ukD4kYEghFAnnAeSHGTf18CtB2wXuGZ3Dm5MwrLslFhfanuxlHKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4QKO+0W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234c5b57557so7139895ad.3;
        Thu, 17 Jul 2025 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752753302; x=1753358102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKKOfH1gpvJ1IeaYm9TchsbmE2xV2KT6bJpFjZntGC4=;
        b=m4QKO+0WwX8Hl1pSVsgdLhwM+9VYD6kq9r1KOqqtqvDS08DefRhAQTXeNKXWJmAIcj
         GO4HnqX3z8TIpjlsR564mhKBSMiDjO7M2YGIZ2P45OrWmpgE5LnBBzpxBkmfVbT9zekq
         cDI0rrfNUMW6nAr2hSB8emg8PqiHVYiN8Xf2wlfc77wg9VcrpSwgiv10tmsl1lRMiRr/
         j+J4EX7SeccYoGXdQBHyvSOv/xlCaBhv1C8934xg98692OtvBBR17XICaERnpAUIWEBc
         Hd0LWgfVDbog+sulpEDVi6j9BbppNbns12T81UwioLlsM2kxTQg+Kuniia/ubZXaXP0S
         agIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753302; x=1753358102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKKOfH1gpvJ1IeaYm9TchsbmE2xV2KT6bJpFjZntGC4=;
        b=XLG+u/+7KGGypg13WcQ96w5P7OX1ggdN4EP2uZbHYix9NbeMXQydB5w1nbWe4iqaXa
         0qj7vzWMXmAozaXffBPh0saJCLToAeMKyDwzmWwoSUfktd3yJxBXOD3cjZ4YTM8JSUnU
         QAO6jxuPXq9bwLhvhHM+tWeyrVcXaHP/bUFZ076FFXS/e+4FfB023Ec0ioQeMfr6itPX
         9T0qhTepUTylYqKSYD53h8RvcJJhKrK4Fa2MDRYgHatHSVwoveKfpEKguS/n1PhZb0Nx
         9ktbwUk5fVV+Ac+DLoCp+v3O4+M1k00Y3skaoekpwJ0/LwiAwpFcAkxY7OOXNZlwi2pO
         UkfA==
X-Forwarded-Encrypted: i=1; AJvYcCVQlJE5UpjjCQpiiD2R8v8Fzu3aIzp1wACqHSUMrWqjVYsPRVp6IIcZIapfW8bH2ajawQfPdi/5npmLUHU=@vger.kernel.org, AJvYcCXzCGzpxkk8CxgNyZSDvrPFOnfujvrpNIpMbAqNbDl8FmSNNS1igzQHoiX+l4ZZ09S0Azi/INtV@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXbjoA0xrSAkTcukbm548I6QxkCx8v1cTfXjjPi2eeSAyjDgd
	hNvhbvSpc3rtF9WPmpC0ruWDMBUJYviVmSS3hwax3MIBtUKPkRyJb4sz
X-Gm-Gg: ASbGncsfDjlAhu9vlqQAzcKdxkeHj4gKGDUVnZJRk5mXDzn9nj6CBEpFRaKAShWNlDR
	ZtXOxGoapBx3L3UWm7EENVgyOLAwDGr9YpqAB+d0o5lkdXjtOE7p1xpydPAGIUCjXrM3FiWspua
	9gxAL5tqc9aCaUHR5QPMP+uEFy8sIOkR3XNoYVgLny97a4aXZrTJ61KyNSPUnUo0qnvDdMxGCpL
	cDwwRlaY9DIuq1Ba+JOeDO3DFb+gmxniAY+86g/Ejw+3lHU891xxF+ytcO/9bdodyp7htKeZHHy
	jx51LRJQ+Phok4l4jbuAQ2n95jLyVp/qGuZQ5skViT5s3/Aj+H/+W1A+TXhrGeOdD++Ij3S85A7
	iBcG9sU7wEA==
X-Google-Smtp-Source: AGHT+IG5JOx3+z3jkn908wqvYEyARJGcTd4Wq+0SCyTrlBlZpZYwXr4OLdseMQuOeZWlGbwLIQfOxA==
X-Received: by 2002:a17:903:2a83:b0:237:cadf:9aac with SMTP id d9443c01a7336-23e2572ff8amr99070035ad.29.1752753301937;
        Thu, 17 Jul 2025 04:55:01 -0700 (PDT)
Received: from localhost ([45.84.137.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433d4a8sm142372375ad.169.2025.07.17.04.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:55:01 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	petrm@nvidia.com,
	menglong8.dong@gmail.com,
	richardbgobert@gmail.com,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/4] net: vxlan: bind vxlan sockets to their local address
Date: Thu, 17 Jul 2025 13:54:11 +0200
Message-Id: <20250717115412.11424-4-richardbgobert@gmail.com>
In-Reply-To: <20250717115412.11424-1-richardbgobert@gmail.com>
References: <20250717115412.11424-1-richardbgobert@gmail.com>
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
 drivers/net/vxlan/vxlan_core.c | 58 ++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 667ff17c4569..cc22844fcc4c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -78,18 +78,33 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
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
+			else if (ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
+					       &saddr->sin6.sin6_addr) != 0)
+				continue;
+#endif
+		}
+
+		if (inet->inet_sport == port &&
 		    vxlan_get_sk_family(vs) == family &&
 		    vs->flags == flags &&
 		    vs->sock->sk->sk_bound_dev_if == ifindex)
@@ -141,11 +156,12 @@ static struct vxlan_dev *vxlan_vs_find_vni(struct vxlan_sock *vs,
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
 
@@ -2309,7 +2325,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   vxlan->cfg.flags, &vxlan->cfg.saddr);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
@@ -3508,8 +3524,9 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
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
@@ -3526,6 +3543,20 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
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
 
@@ -3541,7 +3572,8 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 /* Create new listen socket if needed */
 static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
-					      int ifindex)
+					      int ifindex,
+					      union vxlan_addr *addr)
 {
 	struct vxlan_sock *vs;
 	struct socket *sock;
@@ -3557,7 +3589,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex, addr);
 	if (IS_ERR(sock)) {
 		kfree(vs);
 		return ERR_CAST(sock);
@@ -3610,7 +3642,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
 		rcu_read_lock();
 		vs = vxlan_find_sock(vxlan->net, ipv6 ? AF_INET6 : AF_INET,
 				     vxlan->cfg.dst_port, vxlan->cfg.flags,
-				     l3mdev_index);
+				     l3mdev_index, &vxlan->cfg.saddr);
 		if (vs && !refcount_inc_not_zero(&vs->refcnt)) {
 			rcu_read_unlock();
 			return -EBUSY;
@@ -3620,7 +3652,7 @@ static int __vxlan_sock_add(struct vxlan_dev *vxlan, bool ipv6)
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


