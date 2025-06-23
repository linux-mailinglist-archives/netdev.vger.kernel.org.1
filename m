Return-Path: <netdev+bounces-200312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70741AE4807
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B7D1882DF9
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C7275AE0;
	Mon, 23 Jun 2025 15:08:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABC275AF6
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691306; cv=none; b=B+5/vgFt4+MobXC8ok3F2diYJg6AOmmMx/zg4ccV1Kj1hriep0AWQRYRvQ+59za0QXk4JV6f/GIunt7ztRSoNbM25K4335G3BfHSaYeporABlT7kdrDbvbWM9tY27//FF3HPudBpfDz0zdVrSFNCRa5w6mC29k+oSN6jL+0Nw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691306; c=relaxed/simple;
	bh=nkd/lhUk+HLREs8SL2Am8wPVpoYHkyYtwuwIeePsdJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+agPb8aN5zS+zxrinXN0m28YVWSbn/8lOx7QkEe0AbO0GpRxWrbNIvTwggKvAg4SxD7QcbDfy8t9JK8NnmEggPF+6a7zMaVibT6X8F1cjL7R3AaCr6iP5FipkOJtHWmQ06FqRhgueMKUkxia3rKyOShls6hXQtQKMx6pIHZSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c3d06de3so5107304b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691304; x=1751296104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QGPLB0UXNer/9hf1A7Dplr1vvaKCCKsCvn06X3sUvs=;
        b=uHkObR5ckJLR1KB6b+qRl6Kvu1ExpddXOgqA2Hzu1IXRxaJvv30ChddOD+l43Vfhtg
         EsVbQfoQd6pGHz6+M8MpPjDU1h2I4sDfsL7gejNVZxxnyP5i/G7pA/pOkpTu1Az9qwLD
         MPiuBQ/YGuF7IHb0RyqrLNizxJSWU3po7i8Mdi186cLDJTaH8lxJx7T2KFPqSj4hDBF+
         jw244DFJ7n+nCehKU6i/NHgecwOD2vbt1qkjeNvUYGRWk1CE6qKJaU8XlMuU9+gEPUch
         +uT9cuT8xqQuzforoSYkmLBoa0HC6/sMEVk937G7ferotINoYHm7FG21JuGZ3xRMBr8Y
         UOQQ==
X-Gm-Message-State: AOJu0Yz0qJOGTzvoSr5SiZm2niT+XAPd84FabAG0if7HuemFNEV/DGpJ
	9G8BN5mS04oUxVRJr/vEcxzx7Jy58V5JabUSqb66yDHafcXEB6G4cIRknazL
X-Gm-Gg: ASbGncsjJTqUyT1gVrJrxhHnle5w+7wxS55ZO6I8S6psZf0lFXg6DscHbBJjdceZn8t
	gj3cw/I4DG+PkeHQ8SMYfRn9fgUB2VL2Ws4JyyC31bGo7PdEEOyKLZyfzN2oEyy172Dos0U3E27
	cGDCSjdn72wGAePxTY25AW2vIsj/TxLDYBl6JQygS0GWCoewbxeDXt4ReysqutpPJ2UQr6F9HO0
	l07aL0SJ9xq9UWZW4ArjLYj0w+bUi50+mgaKV+9GA4NtlJyg/F0//n/hsN3uLTjnjYujngz8eMc
	NdQMP2gCnCecxlHG7iisoJhCTqCoyiH3demzUxn/xyGz0FDMSFH7uWrjOEZs1OqOs3D1vJl4i9w
	MvU0cNYZDai+06m115E+ynrk=
X-Google-Smtp-Source: AGHT+IFh+N0at5h56NU7EOyup+1vyU10/+/okFVcnXSBDQnJRnn35z21jcbJdbkQ0MwveabACLb65g==
X-Received: by 2002:a05:6a20:5481:b0:1f5:9024:3254 with SMTP id adf61e73a8af0-22026e13463mr21902118637.6.1750691303704;
        Mon, 23 Jun 2025 08:08:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a6743c5sm8651403b3a.143.2025.06.23.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:23 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 6/8] net: s/dev_get_flags/netif_get_flags/
Date: Mon, 23 Jun 2025 08:08:12 -0700
Message-ID: <20250623150814.3149231-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain netif vs dev semantics.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 fs/smb/server/smb2pdu.c               |  2 +-
 include/linux/netdevice.h             |  2 +-
 net/8021q/vlan.c                      |  2 +-
 net/bridge/br_netlink.c               |  2 +-
 net/core/dev.c                        | 10 +++++-----
 net/core/dev_ioctl.c                  |  2 +-
 net/core/rtnetlink.c                  |  4 ++--
 net/ipv4/fib_frontend.c               |  2 +-
 net/ipv4/fib_semantics.c              |  2 +-
 net/ipv4/nexthop.c                    |  2 +-
 net/ipv6/addrconf.c                   |  2 +-
 net/mpls/af_mpls.c                    |  6 +++---
 net/wireless/wext-core.c              |  2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2331e698a65b..4f86b56fee26 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -65,7 +65,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 	attr->state = ib_get_curr_port_state(ndev);
 	if (attr->state == IB_PORT_ACTIVE)
 		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
-	else if (dev_get_flags(ndev) & IFF_UP)
+	else if (netif_get_flags(ndev) & IFF_UP)
 		attr->phys_state = IB_PORT_PHYS_STATE_POLLING;
 	else
 		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index fafa86273f12..b837535d2bfc 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7847,7 +7847,7 @@ static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
 		if (!ksmbd_find_netdev_name_iface_list(netdev->name))
 			continue;
 
-		flags = dev_get_flags(netdev);
+		flags = netif_get_flags(netdev);
 		if (!(flags & IFF_RUNNING))
 			continue;
 ipv6_retry:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0de01d2e115b..2444cbdc16a8 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4202,7 +4202,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 			       struct kernel_hwtstamp_config *kernel_cfg,
 			       struct netlink_ext_ack *extack);
 int dev_ethtool(struct net *net, struct ifreq *ifr, void __user *userdata);
-unsigned int dev_get_flags(const struct net_device *);
+unsigned int netif_get_flags(const struct net_device *dev);
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		       struct netlink_ext_ack *extack);
 int netif_change_flags(struct net_device *dev, unsigned int flags,
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 06908e37c3d9..df19a9c0c9d9 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -459,7 +459,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 	case NETDEV_UP:
 		/* Put all VLANs for this dev in the up state too.  */
 		vlan_group_for_each_dev(grp, i, vlandev) {
-			flgs = dev_get_flags(vlandev);
+			flgs = netif_get_flags(vlandev);
 			if (flgs & IFF_UP)
 				continue;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6e337937d0d7..4e2d53b27221 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -479,7 +479,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
 	hdr->__ifi_pad = 0;
 	hdr->ifi_type = dev->type;
 	hdr->ifi_index = dev->ifindex;
-	hdr->ifi_flags = dev_get_flags(dev);
+	hdr->ifi_flags = netif_get_flags(dev);
 	hdr->ifi_change = 0;
 
 	if (nla_put_string(skb, IFLA_IFNAME, dev->name) ||
diff --git a/net/core/dev.c b/net/core/dev.c
index 4ad8ea83b125..19463bc692ea 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9426,12 +9426,12 @@ void dev_set_rx_mode(struct net_device *dev)
 }
 
 /**
- *	dev_get_flags - get flags reported to userspace
- *	@dev: device
+ * netif_get_flags() - get flags reported to userspace
+ * @dev: device
  *
- *	Get the combination of flag bits exported through APIs to userspace.
+ * Get the combination of flag bits exported through APIs to userspace.
  */
-unsigned int dev_get_flags(const struct net_device *dev)
+unsigned int netif_get_flags(const struct net_device *dev)
 {
 	unsigned int flags;
 
@@ -9454,7 +9454,7 @@ unsigned int dev_get_flags(const struct net_device *dev)
 
 	return flags;
 }
-EXPORT_SYMBOL(dev_get_flags);
+EXPORT_SYMBOL(netif_get_flags);
 
 int __dev_change_flags(struct net_device *dev, unsigned int flags,
 		       struct netlink_ext_ack *extack)
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ceb2d63a818a..9c0ad7f4b5d8 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -147,7 +147,7 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
 
 	switch (cmd) {
 	case SIOCGIFFLAGS:	/* Get interface flags */
-		ifr->ifr_flags = (short) dev_get_flags(dev);
+		ifr->ifr_flags = (short)netif_get_flags(dev);
 		return 0;
 
 	case SIOCGIFMETRIC:	/* Get the metric on the interface
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 94c449bad59e..776a25562dea 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2036,7 +2036,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm->__ifi_pad = 0;
 	ifm->ifi_type = READ_ONCE(dev->type);
 	ifm->ifi_index = READ_ONCE(dev->ifindex);
-	ifm->ifi_flags = dev_get_flags(dev);
+	ifm->ifi_flags = netif_get_flags(dev);
 	ifm->ifi_change = change;
 
 	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
@@ -5225,7 +5225,7 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 	ifm->__ifi_pad = 0;
 	ifm->ifi_type = dev->type;
 	ifm->ifi_index = dev->ifindex;
-	ifm->ifi_flags = dev_get_flags(dev);
+	ifm->ifi_flags = netif_get_flags(dev);
 	ifm->ifi_change = 0;
 
 
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index fd1e1507a224..6e1b94796f67 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1524,7 +1524,7 @@ static int fib_netdev_event(struct notifier_block *this, unsigned long event, vo
 		fib_disable_ip(dev, event, false);
 		break;
 	case NETDEV_CHANGE:
-		flags = dev_get_flags(dev);
+		flags = netif_get_flags(dev);
 		if (flags & (IFF_RUNNING | IFF_LOWER_UP))
 			fib_sync_up(dev, RTNH_F_LINKDOWN);
 		else
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index d643bd1a0d9d..5d7481c874ec 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2093,7 +2093,7 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 		return 0;
 
 	if (nh_flags & RTNH_F_DEAD) {
-		unsigned int flags = dev_get_flags(dev);
+		unsigned int flags = netif_get_flags(dev);
 
 		if (flags & (IFF_RUNNING | IFF_LOWER_UP))
 			nh_flags |= RTNH_F_LINKDOWN;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 4397e89d3123..74b6f3763bde 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3885,7 +3885,7 @@ static int nh_netdev_event(struct notifier_block *this,
 		nexthop_flush_dev(dev, event);
 		break;
 	case NETDEV_CHANGE:
-		if (!(dev_get_flags(dev) & (IFF_RUNNING | IFF_LOWER_UP)))
+		if (!(netif_get_flags(dev) & (IFF_RUNNING | IFF_LOWER_UP)))
 			nexthop_flush_dev(dev, event);
 		break;
 	case NETDEV_CHANGEMTU:
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9c297974d3a6..7087e9912f11 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6081,7 +6081,7 @@ static int inet6_fill_ifinfo(struct sk_buff *skb, struct inet6_dev *idev,
 	hdr->ifi_type = dev->type;
 	ifindex = READ_ONCE(dev->ifindex);
 	hdr->ifi_index = ifindex;
-	hdr->ifi_flags = dev_get_flags(dev);
+	hdr->ifi_flags = netif_get_flags(dev);
 	hdr->ifi_change = 0;
 
 	iflink = dev_get_iflink(dev);
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 47d7dfd9ad09..25c88cba5c48 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -706,7 +706,7 @@ static int mpls_nh_assign_dev(struct net *net, struct mpls_route *rt,
 	} else {
 		unsigned int flags;
 
-		flags = dev_get_flags(dev);
+		flags = netif_get_flags(dev);
 		if (!(flags & (IFF_RUNNING | IFF_LOWER_UP)))
 			nh->nh_flags |= RTNH_F_LINKDOWN;
 	}
@@ -1616,14 +1616,14 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 			return notifier_from_errno(err);
 		break;
 	case NETDEV_UP:
-		flags = dev_get_flags(dev);
+		flags = netif_get_flags(dev);
 		if (flags & (IFF_RUNNING | IFF_LOWER_UP))
 			mpls_ifup(dev, RTNH_F_DEAD | RTNH_F_LINKDOWN);
 		else
 			mpls_ifup(dev, RTNH_F_DEAD);
 		break;
 	case NETDEV_CHANGE:
-		flags = dev_get_flags(dev);
+		flags = netif_get_flags(dev);
 		if (flags & (IFF_RUNNING | IFF_LOWER_UP)) {
 			mpls_ifup(dev, RTNH_F_DEAD | RTNH_F_LINKDOWN);
 		} else {
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index bea70eb6f034..c32a7c6903d5 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -431,7 +431,7 @@ static struct nlmsghdr *rtnetlink_ifinfo_prep(struct net_device *dev,
 	r->__ifi_pad = 0;
 	r->ifi_type = dev->type;
 	r->ifi_index = dev->ifindex;
-	r->ifi_flags = dev_get_flags(dev);
+	r->ifi_flags = netif_get_flags(dev);
 	r->ifi_change = 0;	/* Wireless changes don't affect those flags */
 
 	if (nla_put_string(skb, IFLA_IFNAME, dev->name))
-- 
2.49.0


