Return-Path: <netdev+bounces-106075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360BB9148AD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEF1C23498
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E170813B58E;
	Mon, 24 Jun 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YPK+fmZw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30813B584
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228593; cv=none; b=Qb12aRPvrctWFIDrqSLD3Tv5LmjF0xyaFCvDDvwfr9J4EtnSsirrdqCsI/uXxXDUs7e9d9l6G1uRsj2LuCbDu7zS4Fxt42cnU7SvrwLB2G6BT+WSGjAOXsijm3L8/RCChe/XHTvxNCmPIPAS4a5g3vL2HCM1GFlCbeQVnNTAxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228593; c=relaxed/simple;
	bh=Di8da+TnhS5LXMTJyHJYwomTSq+vMRfnSAE1Ubk18p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuIBm4cF49GIrHwh12DMEUbi7VyYSLgFH9yogfDF9aR0ecAfpkrufn/ETpBRUj43ZrPOSM/Yc7GTr0J9QPwq4aIgHSQGrwWsJkanJ2iYglYhMyRwB+cDpeIBfVgEGub7tlcHQt9K8anzWttSovKWk6Fshb0U+/Kc/h9UxfWmN5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YPK+fmZw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-363826fbcdeso3024965f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228589; x=1719833389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhvHu5vxX/csRBKy1Xj1ppiC6Zt49H0mymM+BzER8JY=;
        b=YPK+fmZwbyfa6Z32Q19O5WVeDx79aeAR4VTzmUHOkshpYluHpfcyZvb3CtSS2Wp/+d
         FShvAYHu5ZrKANXFDYsSQqLeCAfBMSIRjp/CQQCX4rou/qTJXlckk1ukeMbAlCwrlzST
         DtwolFZmWV9RCYPzq5yW7FT7epQtSfLyeVKJBvHW9ehb4So9c3D3x54YBN3uiUNQTrKm
         VMtEObLwh/ZhkFXIsZCOeLo9gk9FsWwzcPC7JssjTAVfbkKWr97GL4FUx0STROJSLDXm
         qQ39sE2Osk+C+0G6BEJ0qcOabE5cnZIq1TgOUItU2UarzKq89IeD7p2YO036rNtfE8iW
         V/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228589; x=1719833389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhvHu5vxX/csRBKy1Xj1ppiC6Zt49H0mymM+BzER8JY=;
        b=pHWbJD6ggFXNvIbyHRWA0K5YJAkIMK5hioGpkaq2VrIR8D9UXMbSo9o6moOWD2WbH/
         fDZyzsRu5sDYHeDufbZdwZHOThugs5vkVwLijwDb2AkoZSs83M0e9jn4nl1iMiir4dk5
         SGNmsk30i3mbR94tcww2SUqzgUq/kZsCokiO+uyt/a7eBI05P2ljhqtxSWcyzpHCJym2
         by3jOcn4XnCSFNREN+Cjd2C5wkCu9lLItjGSIbZ7xnS0q+szCmDi5iSWf9yJ1p+IcVaC
         cBN6jxecU2mDnf3Qhp/3LcvnMOWHwQ76aG5uwmJV+Gt16DTdDTq/u5KC9mlY+CZwmk1S
         7yfA==
X-Gm-Message-State: AOJu0YzclWvAWudVBttURKLP6M7o5gLlgPhCGFf5ywGPRNeUfUuqtBDp
	F0KBLYgf3ZGSK03NJktBp6bNPOJ6Sx1Ert2shwbUJxvTqZBP978NeHtYpFiBysUplM2BLR10lDG
	M
X-Google-Smtp-Source: AGHT+IHupiD8OngaEIZUqa6ecGeAE/Fq3yYKiBNIxtSmtfydAollQMsc7ZU07gY0GiFW26f+5EoLxQ==
X-Received: by 2002:a5d:4112:0:b0:362:41a4:974a with SMTP id ffacd0b85a97d-366e7a52149mr2901411f8f.66.1719228589414;
        Mon, 24 Jun 2024 04:29:49 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:49 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 05/25] ovpn: add basic interface creation/destruction/management routines
Date: Mon, 24 Jun 2024 13:31:02 +0200
Message-ID: <20240624113122.12732-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
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
 drivers/net/ovpn/main.c       | 162 +++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/main.h       |  10 +++
 drivers/net/ovpn/ovpnstruct.h |   8 ++
 drivers/net/ovpn/packet.h     |  40 +++++++++
 4 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ovpn/packet.h

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 7c35697cb596..7e3e9963d2fc 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,19 +10,62 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
 #include <linux/version.h>
+#include <net/ip.h>
 #include <net/rtnetlink.h>
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
 
+/**
+ * ovpn_struct_init - Initialize the netdevice private area
+ * @dev: the device to initialize
+ * @mode: device operation mode (i.e. p2p, mp, ..)
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_struct_init(struct net_device *dev, enum ovpn_mode mode)
+{
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+
+	ovpn->dev = dev;
+	ovpn->mode = mode;
+
+	return 0;
+}
+
+static void ovpn_struct_free(struct net_device *net)
+{
+}
+
+static int ovpn_net_open(struct net_device *dev)
+{
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
+};
+
 /**
  * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
  * @dev: the interface to check
@@ -41,30 +84,143 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.kind = OVPN_FAMILY_NAME,
 };
 
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
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	dev->netdev_ops = &ovpn_netdev_ops;
+	dev->rtnl_link_ops = &ovpn_link_ops;
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
+				     struct net *net)
+{
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
+	ret = ovpn_struct_init(dev, mode);
+	if (ret < 0)
+		goto err;
+
+	rtnl_lock();
+	ret = register_netdevice(dev);
+	if (ret < 0) {
+		netdev_err(dev, "cannot register interface: %d\n", ret);
+		rtnl_unlock();
+		goto err;
+	}
+	/* turn carrier explicitly off after registration, this way state is
+	 * clearly defined
+	 */
+	netif_carrier_off(dev);
+	rtnl_unlock();
+
+	return dev;
+
+err:
+	free_netdev(dev);
+	return ERR_PTR(ret);
+}
+
+/**
+ * ovpn_iface_destruct - tear down netdevice
+ * @ovpn: the ovpn instance objected related to the interface to tear down
+ *
+ * This function takes care of tearing down an ovpn device and can be invoked
+ * internally or upon UNREGISTER netdev event
+ */
+void ovpn_iface_destruct(struct ovpn_struct *ovpn)
+{
+	ASSERT_RTNL();
+
+	netif_carrier_off(ovpn->dev);
+
+	ovpn->registered = false;
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
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
index a3215316c49b..4dfcba9deb59 100644
--- a/drivers/net/ovpn/main.h
+++ b/drivers/net/ovpn/main.h
@@ -10,6 +10,16 @@
 #ifndef _NET_OVPN_MAIN_H_
 #define _NET_OVPN_MAIN_H_
 
+struct net_device *ovpn_iface_create(const char *name, enum ovpn_mode mode,
+				     struct net *net);
+void ovpn_iface_destruct(struct ovpn_struct *ovpn);
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
2.44.2


