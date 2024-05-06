Return-Path: <netdev+bounces-93560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CE8BC545
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7611F214B0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914B3FBBF;
	Mon,  6 May 2024 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Xn0OKYy4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E638F91
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958138; cv=none; b=O4utf30FZRCfrWPycMkK0ep1W4JuuvW1gXkK/mWujvqvFj2yQ9go0MY9VSq3CQ4GWprFAxUPJN3P9MSNSa/mUDMY2M8EbtohtYuoCO5SnzaX7GRBm3XXWs2Qd29TcsfPkYNzXPSD1HBeaLvqXvfEXqdsyMRxiumbmI5wrMm4cTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958138; c=relaxed/simple;
	bh=G4ieedQfQLnLfV0wkTa7he9U9XBB9TiEWzVJ416jehk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hte0hsNGGPWR4qMJyYKmAHgyEwll9m+i05KIXZPqRpSGhdzGd/4Ejk+MNksvnA+vDbGDih1xyQ4N8ukdF5SGCBfH49puNnDZDvuHT+K0+jlO+QSNrLOVOsQ4/v5zaF+XLhH3EoqQJhTInRpBScjzu8+0WCIlc9nyqx5F3fQGVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Xn0OKYy4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ecd60bb16so5469595e9.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958133; x=1715562933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZLfGWog8YC+qxvfecefrWl2+Wl4f3117ue31NpnI5M=;
        b=Xn0OKYy4sH6oOyJBlTZRbavE4HABkfjKqK7O0cuOulqLlshOmMQ9uJDQJ8P0LpDjbb
         9/UJSTlmM6zEUFR0p7BnUooT6y9YdpFWXIbSOhTwdf7V4VFy3T8vjn9fqMc403G65u2I
         RbaCFQYgrGy0HpHZB/CgtmYbaJICd9i+2Y8V8FdDxHbOmf+B4IMHtvVOMMUqwg3GBpOI
         eNnmpZeB+cw5w3ugRHtDOMCVsxVs4UQAWugWG5nZWzFCzFRgPeefbp2lyLNIkuKg91/5
         Rm9Ao7LtO/Zv0Jvbu83hWUVnnDom8jwjvipzQOr/Yp0osQXc2aBkU+18Xi9fSCJgvWLy
         jHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958133; x=1715562933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZLfGWog8YC+qxvfecefrWl2+Wl4f3117ue31NpnI5M=;
        b=i36yTmHjqBgw991BcoK201MJZBcvMdYwFDqq7v1px+IQyYuLO56VPPfjIU0dWncM5Y
         vzcZzMPELbd+tGxaQuHDoGhCkZ/zj+sArjxSr+Cf0Jfrzoi6WKK7GUWsvHSnSOn+38Qz
         YYk7wsXcXVYQ81y1kjzUylMcBlOPsWL+H374kpjd19ar4A8mu0znhAwUgmj7+Tfvy8SD
         XnLueDxXu4y1sI4AEmyhJEO9pvIogU6IzLg3t3Z2VThyh/niCc+uSiaIy0+Kzn3SRIfP
         V80FaiEPREFz8ybBq5EVCA0MHQy02o2CJdGTEnkv1GJVSZgBUd0qSGIcH+2TM+VsMq3u
         LeMw==
X-Gm-Message-State: AOJu0Yxo9DxvE7YBX9ooRyoD3aWjxgUzp9YIybUbJjOlYvnpS57A0eGG
	LqIdsAP+t93tJj3KF/4PMQTCogg3iGJWfs1mEbEmEATSHdU0C7Ov7aqdXOFFK9xTcmVoBCouVZj
	p
X-Google-Smtp-Source: AGHT+IEDwCu+QfeB9ER59nU4wVT/liIFLJPkyKXnn5XMTp4I/UEqHSDGmO0w78kQP5zvRyA6/ymSRg==
X-Received: by 2002:a05:600c:1e09:b0:418:a706:3209 with SMTP id ay9-20020a05600c1e0900b00418a7063209mr9352752wmb.31.1714958133581;
        Sun, 05 May 2024 18:15:33 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:33 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 04/24] ovpn: add basic interface creation/destruction/management routines
Date: Mon,  6 May 2024 03:16:17 +0200
Message-ID: <20240506011637.27272-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic infrastructure for handling ovpn interfaces.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  20 ++++
 drivers/net/ovpn/io.h         |   7 ++
 drivers/net/ovpn/main.c       | 183 +++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/main.h       |  31 ++++++
 drivers/net/ovpn/ovpnstruct.h |   8 ++
 drivers/net/ovpn/packet.h     |  40 ++++++++
 6 files changed, 285 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ovpn/packet.h

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index ad3813419c33..338e99dfe886 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -11,6 +11,26 @@
 #include <linux/skbuff.h>
 
 #include "io.h"
+#include "ovpnstruct.h"
+#include "netlink.h"
+
+int ovpn_struct_init(struct net_device *dev)
+{
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+	int err;
+
+	ovpn->dev = dev;
+
+	err = ovpn_nl_init(ovpn);
+	if (err < 0)
+		return err;
+
+	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+	if (!dev->tstats)
+		return -ENOMEM;
+
+	return 0;
+}
 
 /* Send user data to the network
  */
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index aa259be66441..61a2485e16b5 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -10,6 +10,13 @@
 #ifndef _NET_OVPN_OVPN_H_
 #define _NET_OVPN_OVPN_H_
 
+/**
+ * ovpn_struct_init - Initialize the netdevice private area
+ * @dev: the device to initialize
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 33c0b004ce16..584cd7286aff 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,47 +10,195 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/version.h>
+#include <net/ip.h>
+#include <uapi/linux/if_arp.h>
 #include <uapi/linux/ovpn.h>
 
 #include "ovpnstruct.h"
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
+#include "packet.h"
 
 /* Driver info */
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
 #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
 
+static LIST_HEAD(dev_list);
+
+static void ovpn_struct_free(struct net_device *net)
+{
+	struct ovpn_struct *ovpn = netdev_priv(net);
+
+	rtnl_lock();
+	list_del(&ovpn->dev_list);
+	rtnl_unlock();
+
+	free_percpu(net->tstats);
+}
+
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
+
+	if (dev_v4) {
+		/* disable redirects as Linux gets confused by ovpn handling
+		 * same-LAN routing
+		 */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+	}
+
+	netif_tx_start_all_queues(dev);
+	return 0;
+}
+
+static int ovpn_net_stop(struct net_device *dev)
+{
+	netif_tx_stop_all_queues(dev);
+	return 0;
+}
+
+static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
+	.ndo_stop		= ovpn_net_stop,
+	.ndo_start_xmit		= ovpn_net_xmit,
+	.ndo_get_stats64        = dev_get_tstats64,
+};
+
 bool ovpn_dev_is_valid(const struct net_device *dev)
 {
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_setup(struct net_device *dev)
+{
+	/* compute the overhead considering AEAD encryption */
+	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 +
+			     sizeof(struct udphdr) +
+			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
+
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_LLTX |
+				 NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
+				 NETIF_F_HIGHDMA;
+
+	dev->needs_free_netdev = true;
+
+	dev->netdev_ops = &ovpn_netdev_ops;
+
+	dev->priv_destructor = ovpn_struct_free;
+
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->mtu = ETH_DATA_LEN - overhead;
+	dev->min_mtu = IPV4_MIN_MTU;
+	dev->max_mtu = IP_MAX_MTU - overhead;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->needed_headroom = OVPN_HEAD_ROOM;
+	dev->needed_tailroom = OVPN_MAX_PADDING;
+}
+
+struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
+				     struct net *net)
+{
+	struct ovpn_struct *ovpn;
+	struct net_device *dev;
+	int ret;
+
+	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER,
+			   ovpn_setup);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev_net_set(dev, net);
+
+	ret = ovpn_struct_init(dev);
+	if (ret < 0)
+		goto err;
+
+	ovpn = netdev_priv(dev);
+	ovpn->mode = mode;
+
+	rtnl_lock();
+
+	ret = register_netdevice(dev);
+	if (ret < 0) {
+		netdev_err(dev, "cannot register interface: %d\n", ret);
+		rtnl_unlock();
+		goto err;
+	}
+
+	list_add(&ovpn->dev_list, &dev_list);
+	rtnl_unlock();
+
+	/* turn carrier explicitly off after registration, this way state is
+	 * clearly defined
+	 */
+	netif_carrier_off(dev);
+
+	return dev;
+
+err:
+	free_netdev(dev);
+	return ERR_PTR(ret);
+}
+
+void ovpn_iface_destruct(struct ovpn_struct *ovpn)
+{
+	ASSERT_RTNL();
+
+	netif_carrier_off(ovpn->dev);
+
+	ovpn->registered = false;
+
+	unregister_netdevice(ovpn->dev);
+	synchronize_net();
+}
+
 static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ovpn_struct *ovpn;
 
 	if (!ovpn_dev_is_valid(dev))
 		return NOTIFY_DONE;
 
+	ovpn = netdev_priv(dev);
+
 	switch (state) {
 	case NETDEV_REGISTER:
-		/* add device to internal list for later destruction upon
-		 * unregistration
-		 */
+		ovpn->registered = true;
 		break;
 	case NETDEV_UNREGISTER:
+		/* twiddle thumbs on netns device moves */
+		if (dev->reg_state != NETREG_UNREGISTERING)
+			break;
+
 		/* can be delivered multiple times, so check registered flag,
 		 * then destroy the interface
 		 */
+		if (!ovpn->registered)
+			return NOTIFY_DONE;
+
+		ovpn_iface_destruct(ovpn);
 		break;
 	case NETDEV_POST_INIT:
 	case NETDEV_GOING_DOWN:
 	case NETDEV_DOWN:
 	case NETDEV_UP:
 	case NETDEV_PRE_UP:
+		break;
 	default:
 		return NOTIFY_DONE;
 	}
@@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier = {
 	.notifier_call = ovpn_netdev_notifier_call,
 };
 
+static void ovpn_netns_pre_exit(struct net *net)
+{
+	struct ovpn_struct *ovpn;
+
+	rtnl_lock();
+	list_for_each_entry(ovpn, &dev_list, dev_list) {
+		if (dev_net(ovpn->dev) != net)
+			continue;
+
+		ovpn_iface_destruct(ovpn);
+	}
+	rtnl_unlock();
+}
+
+static struct pernet_operations ovpn_pernet_ops = {
+	.pre_exit = ovpn_netns_pre_exit
+};
+
 static int __init ovpn_init(void)
 {
 	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
@@ -71,14 +237,22 @@ static int __init ovpn_init(void)
 		return err;
 	}
 
+	err = register_pernet_device(&ovpn_pernet_ops);
+	if (err) {
+		pr_err("ovpn: can't register pernet ops: %d\n", err);
+		goto unreg_netdev;
+	}
+
 	err = ovpn_nl_register();
 	if (err) {
 		pr_err("ovpn: can't register netlink family: %d\n", err);
-		goto unreg_netdev;
+		goto unreg_pernet;
 	}
 
 	return 0;
 
+unreg_pernet:
+	unregister_pernet_device(&ovpn_pernet_ops);
 unreg_netdev:
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 	return err;
@@ -87,6 +261,7 @@ static int __init ovpn_init(void)
 static __exit void ovpn_cleanup(void)
 {
 	ovpn_nl_unregister();
+	unregister_pernet_device(&ovpn_pernet_ops);
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
 }
 
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index 380adb593d0c..21d6bfb27d67 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -10,6 +10,30 @@
 #ifndef _NET_OVPN_MAIN_H_
 #define _NET_OVPN_MAIN_H_
 
+/**
+ * ovpn_iface_create - create and initialize a new 'ovpn' netdevice
+ * @name: the name of the new device
+ * @mode: the OpenVPN mode to set this device to
+ * @net: the netns this device should be created in
+ *
+ * A new netdevice is created and registered.
+ * Its private area is initialized with an empty ovpn_struct object.
+ *
+ * Return: a pointer to the new device on success or a negative error code
+ *         otherwise
+ */
+struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
+				     struct net *net);
+
+/**
+ * ovpn_iface_destruct - tear down netdevice
+ * @ovpn: the ovpn instance objected related to the interface to tear down
+ *
+ * This function takes care of tearing down an ovpn device and can be invoked
+ * internally or upon UNREGISTER netdev event
+ */
+void ovpn_iface_destruct(struct ovpn_struct *ovpn);
+
 /**
  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
  * @dev: the interface to check
@@ -18,4 +42,11 @@
  */
 bool ovpn_dev_is_valid(const struct net_device *dev);
 
+#define SKB_HEADER_LEN                                       \
+	(max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
+	 sizeof(struct udphdr) + NET_SKB_PAD)
+
+#define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
+#define OVPN_MAX_PADDING 16
+
 #endif /* _NET_OVPN_MAIN_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index ff248cad1401..ee05b8a2c61d 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,12 +10,20 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <uapi/linux/ovpn.h>
+
 /**
  * struct ovpn_struct - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
+ * @dev_list: entry for the module wide device list
  */
 struct ovpn_struct {
 	struct net_device *dev;
+	bool registered;
+	enum ovpn_mode mode;
+	struct list_head dev_list;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
new file mode 100644
index 000000000000..7ed146f5932a
--- /dev/null
+++ b/drivers/net/ovpn/packet.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_PACKET_H_
+#define _NET_OVPN_PACKET_H_
+
+/* When the OpenVPN protocol is ran in AEAD mode, use
+ * the OpenVPN packet ID as the AEAD nonce:
+ *
+ *    00000005 521c3b01 4308c041
+ *    [seq # ] [  nonce_tail   ]
+ *    [     12-byte full IV    ] -> NONCE_SIZE
+ *    [4-bytes                   -> NONCE_WIRE_SIZE
+ *    on wire]
+ */
+
+/* OpenVPN nonce size */
+#define NONCE_SIZE 12
+
+/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
+ * size of the AEAD Associated Data (AD) sent over the wire
+ * and is normally the head of the IV
+ */
+#define NONCE_WIRE_SIZE (NONCE_SIZE - sizeof(struct ovpn_nonce_tail))
+
+/* Last 8 bytes of AEAD nonce
+ * Provided by userspace and usually derived from
+ * key material generated during TLS handshake
+ */
+struct ovpn_nonce_tail {
+	u8 u8[OVPN_NONCE_TAIL_SIZE];
+};
+
+#endif /* _NET_OVPN_PACKET_H_ */
-- 
2.43.2


