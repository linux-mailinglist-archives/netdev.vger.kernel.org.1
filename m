Return-Path: <netdev+bounces-205160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A634BAFDA0A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC54E6A41
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06168248873;
	Tue,  8 Jul 2025 21:38:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD41A8F84
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010722; cv=none; b=IhxePZevnTDIaVlY+ygEiDaC/U1Es6fCKr2zeq5OQNDPlJxBLG8XMv+i7YcvAGDORbSEp5oyuTH0rIbR+DfTPLLalfzdbLWPqyi5OD6ib/TkNiLeXumGzR4y4XY0SYeTgh6dEO9Lkm/cFm7NXtgkaTB1iO0icQswqkqAFfP8zQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010722; c=relaxed/simple;
	bh=gk7SdnH0m594hiq2YHB5W/1bk5XazUOKZ1a9xzPLvKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxXAQyPVd5ukSLBS8iKO9ZqHu965gWYgMXFoAvCKNW/R3lepQinU6AaYI0+mCcn3xwwJglGtAg8IVPpLjc2lkCWWKf3X5c/MKSznr0UKshlRjQHupOhkg1wpMncKOTuLIUWe7G08JArKXTx2NfCou+jOFSwumd7EaExvZ3O6fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a71d9208so3465557a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010720; x=1752615520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34rec4syakuvjqwkrbm7VPWSe/HsAtOoydmesvqT3vI=;
        b=ZODr6NzA9FJkAWk1Nmw4rJCvEuqwTispYl3ac2bGt1L3qoeHt6R7hWE5Lp6aS6XYkZ
         kC3mWGdh4RbL42OlIXjzUWyPz6ReSO+rtejPYAXJ32fMe7bNoCCvYtJl2k+DBY9DgT1U
         oE4CXFnZAWEVifmuCW44Gpfvpv2MEgyrG3ZXSp4yViKXFppbxrct4Fv1t/ksjYtjZtzr
         rnCsriKDO3eWTTAf/tAv9UShLYuCwAWdE3K2x5W3k6v9NyKkiuRkVHQoUXo8CaxXmCxY
         +SWRdPBTlOBeFAMv5G8ZTa7qAUPF0A9GhNhcsBRHupqQIeudFaWfgel7zxqIJDkWHXuw
         fq/A==
X-Gm-Message-State: AOJu0Yy4u7bJhV6pCu+GKuNIwsndhY9gj7BN3Ev0Gk6s4MvRUlxxIF66
	d810RzZM/3ydEOmF0yktZFViHbwL2/zkBfds9VEBXJrxjOhTbYhWFAkL6QRN
X-Gm-Gg: ASbGncuClHwPBsK0UKGQA3uGUxxD9gxdN4Zsb6N35b+GU53dQHzmOdyCVcga7wHR041
	M7GmfTCowjtnZoEJBCHQSupOhj2Viw9fWHC+I93esVs3JJHu1xAWKF0DK0Vevv+WkWETYCP8vzV
	rw35iWCHrooPXqEaGgnc6yUJKZmhlIdHxWtoxTm6ywyq3oNerWX7M5ZgXdv/kw1eFfPlLX0cQdm
	XW7DyVmn4r+3lJb0T1lj7MaA4FAX2ZyYNUwEl9h9Y1WXc0LDlWaPtFzexjowpfgoi+yK36BQhx7
	zgO+KWXAtJiI1poMPHkW2Ho/afXe4em0ujgEvlMmSWR6ML+od2+GsM32NwkvbXYDYKvb/MOp9+m
	Uc6tGAJhmkI+282tCbhAW3p0=
X-Google-Smtp-Source: AGHT+IFL4t00beaDKI8lWCsO/4y2bFJaKtx0JxjMx33ti2jEFMyRORicPgr6fqvfSPnbpO1aZBW0ZQ==
X-Received: by 2002:a05:6a21:689:b0:220:b03a:64ff with SMTP id adf61e73a8af0-2260c04d3b2mr22513445637.42.1752010720105;
        Tue, 08 Jul 2025 14:38:40 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38ee63003bsm11117176a12.62.2025.07.08.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:39 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 6/8] net: s/dev_get_flags/netif_get_flags/
Date: Tue,  8 Jul 2025 14:38:27 -0700
Message-ID: <20250708213829.875226-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708213829.875226-1-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

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
index 454cf4bb513b..184e2e80ec2a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4195,7 +4195,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
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
index 3cf882a16805..2ac88dd868ae 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9427,12 +9427,12 @@ void dev_set_rx_mode(struct net_device *dev)
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
 
@@ -9455,7 +9455,7 @@ unsigned int dev_get_flags(const struct net_device *dev)
 
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
index c75901e50a0c..73de15bd6df8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2038,7 +2038,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm->__ifi_pad = 0;
 	ifm->ifi_type = READ_ONCE(dev->type);
 	ifm->ifi_index = READ_ONCE(dev->ifindex);
-	ifm->ifi_flags = dev_get_flags(dev);
+	ifm->ifi_flags = netif_get_flags(dev);
 	ifm->ifi_change = change;
 
 	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
@@ -5227,7 +5227,7 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
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
index a2f04992f579..a5f3c8459758 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -2087,7 +2087,7 @@ int fib_sync_up(struct net_device *dev, unsigned char nh_flags)
 		return 0;
 
 	if (nh_flags & RTNH_F_DEAD) {
-		unsigned int flags = dev_get_flags(dev);
+		unsigned int flags = netif_get_flags(dev);
 
 		if (flags & (IFF_RUNNING | IFF_LOWER_UP))
 			nh_flags |= RTNH_F_LINKDOWN;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index e808801ab9b8..29118c43ebf5 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3884,7 +3884,7 @@ static int nh_netdev_event(struct notifier_block *this,
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
2.50.0


