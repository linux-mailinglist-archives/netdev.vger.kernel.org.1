Return-Path: <netdev+bounces-141695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249969BC0D3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563331C214F6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076121FDF90;
	Mon,  4 Nov 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE6VkgpO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481D1FCF47;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759116; cv=none; b=lchwhcrmrgBdCOgqUaXtXE+l+of5IOYsZ2eVQqmC0R5Agrtg+6OPUmDTVJzUjDJ06kEylGjqXFe02aNf+2wBwoUDwozeKIEoVVzHQFmr+5uMhrBVNuIPxak47mQn28CAWS3cz0qsCF9NxjkXOkTWQuvMihwf0uBFmi3/QaAQjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759116; c=relaxed/simple;
	bh=t8LdalTXMa1hMyG/HEIou8Mbhh3UNooPWYNcodwJrLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpchemshszR2Ci4r8WEVvM9f7arpCUGNoq4yRVku27nlWBBkW2FPbvQT4iLGU1wseVKV767h7byH0htDeMGq+o4IRZ/2He1U0xehUlTTpSYRLEq1U5KmF8NWMbczfbwkmHgNsLkqZr8a9ouz2SnXS3dTlJiaFF99deDiE0JzcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE6VkgpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD2BC4CED4;
	Mon,  4 Nov 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730759116;
	bh=t8LdalTXMa1hMyG/HEIou8Mbhh3UNooPWYNcodwJrLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fE6VkgpO0EJ5UVsluOpCaxrp4Iccd4DcWVFZ8tAgY6N8eaic8cF3keLhmZfcQqXbk
	 k36a727ttGeiv1hAyUU6BFsDkHZU2oZsyzondJkEdhR89vjMphrH+oQgAtR8GUznYO
	 QCteJgNg2km0gBOkVYAbG9DhJtvREC8nGIBas3EXJaMiPIsmN6Z9KgFoHFmhwFrNU4
	 tYbbu198aOrK5qt1imC46Lo9YVW0dX5Cflvor66mnGXS/lqd4o35Op76/Iz4emJQwA
	 fwriPA6fRW6SzRUN4cpS55itJpbqCDTtMBtAq82RGs9UJZK57H9g6Qw1g6dvH3Qxl7
	 wd2/Q/Rh7ie3Q==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RFC 1/5] Revert "net: dev: Convert sa_data to flexible array in struct sockaddr"
Date: Mon,  4 Nov 2024 14:25:03 -0800
Message-Id: <20241104222513.3469025-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104221450.work.053-kees@kernel.org>
References: <20241104221450.work.053-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3783; i=kees@kernel.org; h=from:subject; bh=t8LdalTXMa1hMyG/HEIou8Mbhh3UNooPWYNcodwJrLQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmangd3Oq4K12PYOsMyKNBCieXFlA8vXn/bX1OSyLQ0+ +XmDfbsHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABOJLWZkeC0j9rX+0O/NG/2m 1wSaLjrVs96Ue+HN3/FzH026vYCB5SgjwwTthb1TTfMEfqzeapSw3k6a+VW5lfLp/xExh57lnP0 0nQcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This reverts commit b5f0de6df6dce8d641ef58ef7012f3304dffb9a1.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/socket.h |  5 +----
 net/core/dev.c         |  2 +-
 net/core/dev_ioctl.c   |  2 +-
 net/ipv4/arp.c         |  2 +-
 net/packet/af_packet.c | 10 +++++-----
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..7f597e5b2dc8 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -34,10 +34,7 @@ typedef __kernel_sa_family_t	sa_family_t;
 
 struct sockaddr {
 	sa_family_t	sa_family;	/* address family, AF_xxx	*/
-	union {
-		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
-		DECLARE_FLEX_ARRAY(char, sa_data);
-	};
+	char		sa_data[14];	/* 14 bytes of protocol address	*/
 };
 
 struct linger {
diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..582466a0176a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9123,7 +9123,7 @@ EXPORT_SYMBOL(dev_set_mac_address_user);
 
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
-	size_t size = sizeof(sa->sa_data_min);
+	size_t size = sizeof(sa->sa_data);
 	struct net_device *dev;
 	int ret = 0;
 
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 473c437b6b53..462c0ab81bd8 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -541,7 +541,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		if (ifr->ifr_hwaddr.sa_family != dev->type)
 			return -EINVAL;
 		memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-		       min(sizeof(ifr->ifr_hwaddr.sa_data_min),
+		       min(sizeof(ifr->ifr_hwaddr.sa_data),
 			   (size_t)dev->addr_len));
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 		return 0;
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 11c1519b3699..3a97efe1587b 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1185,7 +1185,7 @@ static int arp_req_get(struct net *net, struct arpreq *r)
 
 	read_lock_bh(&neigh->lock);
 	memcpy(r->arp_ha.sa_data, neigh->ha,
-	       min(dev->addr_len, sizeof(r->arp_ha.sa_data_min)));
+	       min(dev->addr_len, sizeof(r->arp_ha.sa_data)));
 	r->arp_flags = arp_state_to_flags(neigh);
 	read_unlock_bh(&neigh->lock);
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a705ec214254..aa5e368a744a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3352,7 +3352,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 			    int addr_len)
 {
 	struct sock *sk = sock->sk;
-	char name[sizeof(uaddr->sa_data_min) + 1];
+	char name[sizeof(uaddr->sa_data) + 1];
 
 	/*
 	 *	Check legality
@@ -3363,8 +3363,8 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	/* uaddr->sa_data comes from the userspace, it's not guaranteed to be
 	 * zero-terminated.
 	 */
-	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data_min));
-	name[sizeof(uaddr->sa_data_min)] = 0;
+	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data));
+	name[sizeof(uaddr->sa_data)] = 0;
 
 	return packet_do_bind(sk, name, 0, 0);
 }
@@ -3649,11 +3649,11 @@ static int packet_getname_spkt(struct socket *sock, struct sockaddr *uaddr,
 		return -EOPNOTSUPP;
 
 	uaddr->sa_family = AF_PACKET;
-	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data_min));
+	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(sock_net(sk), READ_ONCE(pkt_sk(sk)->ifindex));
 	if (dev)
-		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data_min));
+		strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
 	rcu_read_unlock();
 
 	return sizeof(*uaddr);
-- 
2.34.1


