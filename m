Return-Path: <netdev+bounces-77130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015088704DC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB11F22F6E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87D347F46;
	Mon,  4 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T+KGnJln"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1847A57
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564944; cv=none; b=oX3MpPd6iBoYY6i06mtBj7Is4DP0FTIDZiSs8Z6FQBEquQFXZ6l6Ur33xshKfCvMhVZlV+N/uXAlZfhs7+9RspSuwUJ9hqjeBfCyP8zO2KlJRaphw6VRYTB0gSqmUfhBF84tPMpa31B+8B/ozOMsRilnMCyb25+7ffPFHNqBrrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564944; c=relaxed/simple;
	bh=3Qz2RgeDyogBWtpCM5wyCsGug+gamoS1p5n9kdjTkIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tH21aar4SCFxpRs/QpsVRrQw92KLQ7Sfv+T8e+/NquNLBfNcHLegbghVRJibP+3rH+Wss5gj+sSDo2EcpWVOdxwRnR2LGMJpnbO4F98grgWMbiA6nTMzvJfq02gXZxalqOiaDxjWd5rPPDAMlY8jZ3L7c7fwMm+1KEk52HjkeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T+KGnJln; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a36126ee41eso700199566b.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564940; x=1710169740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loVIzJtKVUJ+czZw38qBnvIJfOnW7awabrSXGXY4rcQ=;
        b=T+KGnJln64Gl6iJXjjFrqiFGCr9Re6B2BvqeiBaxKW6QyA54bI6kQiifS0isYPGkGF
         UWGw8yHPMcVxzjL7gT5cnAB2mVCWfzlcoDK5zTVLyUjU6p72SpLKMKW1ZFCkDT/oFoCq
         ZF1WhhuZt4KTJY3CvTvykuAlAVY0j9r8QzE3OgBKbDHMHyo9fu2a4RQ6uHbibi3bJM0w
         Jh4r/7Bdg5zcTdSIWTmyQDwJn0InNz3i8rUHjB8nifc6reCOuu4ApjaHW1Ghw8dO/jkD
         Vw5JEvJ5N5IVwJ1wlDV7bebNH092Q2ot7t41UAz1tYo7WGia0WcIQtJGwYRwDg5OHQtL
         KHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564940; x=1710169740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loVIzJtKVUJ+czZw38qBnvIJfOnW7awabrSXGXY4rcQ=;
        b=bFiVbHMq8v4rcepOaBUsrSN9Pc3PvmMi5PXaLsNaRrjWUUKoJWVuwVkv/Dh0lxgvZl
         oW4+XL3DV3UTNUIZoEoR7G0a01YzBevsKd+dpQB3nYJOHH5Tj/4Vqtefo7JQf3CT8zu0
         L5ipHY5ipYn9Vd3dfKSlP9qqNC5jpf4xy6veWgpWssdu1lYA1S0r3n23bdzIhZqBYAz+
         dfmDDnKKk/HYxoo9s86t/YfMGN6A82Z6lLBN3yOuMTV+/vOj64F2c2DPL/zIN8DGv/7Q
         gWmKGI7PYZR5qDwC9k382ROE1u+pXc5rIwuTsIZcAfj4ItGswYzwFoB0ZDOezXBc7QWO
         gFSw==
X-Gm-Message-State: AOJu0YzrEVQRNCm+vtuWG0fGbwh4q+WsbUZmfb2+5A66exDdGEjRI/7p
	7Idh/2fJT2YDmK2pwUF56VpPt8u4xsfkCRNh03gAn5No4nD+GheDzr0+57mj//XqBlwUldLYHK7
	WGRw=
X-Google-Smtp-Source: AGHT+IGWpr0baxdQPfrYVmjSOiDXqtCH+gHmot0GOF1aLG5Sey/zXoRdbn1IraeMflPcSY7vW1O09w==
X-Received: by 2002:a17:906:4ec6:b0:a45:57b5:4a7a with SMTP id i6-20020a1709064ec600b00a4557b54a7amr1237608ejv.37.1709564939982;
        Mon, 04 Mar 2024 07:08:59 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:08:59 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Date: Mon,  4 Mar 2024 16:08:54 +0100
Message-ID: <20240304150914.11444-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces basic netlink support with
registration/unregistration functionalities and stub pre/post-doit.

More importantly it introduces the UAPI header file that contains
the attributes that are inteded to be used by the netlink API
implementation.

For convience, packet.h is also added containing some macros about
the OpenVPN packet format.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile     |   1 +
 drivers/net/ovpn/main.c       |  15 +++
 drivers/net/ovpn/netlink.c    | 229 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h    |  18 +++
 drivers/net/ovpn/ovpnstruct.h |  20 +++
 drivers/net/ovpn/packet.h     |  42 +++++++
 include/uapi/linux/ovpn.h     | 174 ++++++++++++++++++++++++++
 7 files changed, 499 insertions(+)
 create mode 100644 drivers/net/ovpn/netlink.c
 create mode 100644 drivers/net/ovpn/netlink.h
 create mode 100644 drivers/net/ovpn/ovpnstruct.h
 create mode 100644 drivers/net/ovpn/packet.h
 create mode 100644 include/uapi/linux/ovpn.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 7b8b1d0ff9b4..7e406a69892a 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -9,3 +9,4 @@
 obj-$(CONFIG_OVPN) += ovpn.o
 ovpn-y += main.o
 ovpn-y += io.o
+ovpn-y += netlink.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 25964eb89aac..3769f99cfe6f 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -8,8 +8,10 @@
  */
 
 #include "main.h"
+#include "netlink.h"
 #include "io.h"
 
+#include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -17,6 +19,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/version.h>
+#include <uapi/linux/ovpn.h>
 
 
 /* Driver info */
@@ -101,12 +104,23 @@ static int __init ovpn_init(void)
 		return err;
 	}
 
+	err = ovpn_nl_register();
+	if (err) {
+		pr_err("ovpn: can't register netlink family: %d\n", err);
+		goto unreg_netdev;
+	}
+
 	return 0;
+
+unreg_netdev:
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+	return err;
 }
 
 static __exit void ovpn_cleanup(void)
 {
 	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+	ovpn_nl_unregister();
 }
 
 module_init(ovpn_init);
@@ -116,3 +130,4 @@ MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS_GENL_FAMILY(OVPN_NL_NAME);
diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
new file mode 100644
index 000000000000..2e855ce145e7
--- /dev/null
+++ b/drivers/net/ovpn/netlink.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "main.h"
+#include "io.h"
+#include "netlink.h"
+#include "ovpnstruct.h"
+#include "packet.h"
+
+#include <uapi/linux/ovpn.h>
+
+#include <linux/netdevice.h>
+#include <linux/netlink.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+#include <net/genetlink.h>
+#include <uapi/linux/in.h>
+#include <uapi/linux/in6.h>
+
+/** The ovpn netlink family */
+static struct genl_family ovpn_nl_family;
+
+enum ovpn_nl_multicast_groups {
+	OVPN_MCGRP_PEERS,
+};
+
+static const struct genl_multicast_group ovpn_nl_mcgrps[] = {
+	[OVPN_MCGRP_PEERS] = { .name = OVPN_NL_MULTICAST_GROUP_PEERS },
+};
+
+/** KEYDIR policy. Can be used for configuring an encryption and a decryption key */
+static const struct nla_policy ovpn_nl_policy_keydir[NUM_OVPN_A_KEYDIR] = {
+	[OVPN_A_KEYDIR_CIPHER_KEY] = NLA_POLICY_MAX_LEN(U8_MAX),
+	[OVPN_A_KEYDIR_NONCE_TAIL] = NLA_POLICY_EXACT_LEN(NONCE_TAIL_SIZE),
+};
+
+/** KEYCONF policy */
+static const struct nla_policy ovpn_nl_policy_keyconf[NUM_OVPN_A_KEYCONF] = {
+	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_RANGE(NLA_U8, __OVPN_KEY_SLOT_FIRST,
+						 NUM_OVPN_KEY_SLOT - 1),
+	[OVPN_A_KEYCONF_KEY_ID] = { .type = NLA_U8 },
+	[OVPN_A_KEYCONF_CIPHER_ALG] = { .type = NLA_U16 },
+	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
+	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_nl_policy_keydir),
+};
+
+/** PEER policy */
+static const struct nla_policy ovpn_nl_policy_peer[NUM_OVPN_A_PEER] = {
+	[OVPN_A_PEER_ID] = { .type = NLA_U32 },
+	[OVPN_A_PEER_SOCKADDR_REMOTE] = NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
+	[OVPN_A_PEER_SOCKET] = { .type = NLA_U32 },
+	[OVPN_A_PEER_VPN_IPV4] = { .type = NLA_U32 },
+	[OVPN_A_PEER_VPN_IPV6] = NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[OVPN_A_PEER_LOCAL_IP] = NLA_POLICY_MAX_LEN(sizeof(struct in6_addr)),
+	[OVPN_A_PEER_LOCAL_PORT] = NLA_POLICY_MAX_LEN(sizeof(u16)),
+	[OVPN_A_PEER_KEEPALIVE_INTERVAL] = { .type = NLA_U32 },
+	[OVPN_A_PEER_KEEPALIVE_TIMEOUT] = { .type = NLA_U32 },
+	[OVPN_A_PEER_DEL_REASON] = NLA_POLICY_RANGE(NLA_U8, __OVPN_DEL_PEER_REASON_FIRST,
+						    NUM_OVPN_DEL_PEER_REASON - 1),
+	[OVPN_A_PEER_KEYCONF] = NLA_POLICY_NESTED(ovpn_nl_policy_keyconf),
+};
+
+/** Generic message container policy */
+static const struct nla_policy ovpn_nl_policy[NUM_OVPN_A] = {
+	[OVPN_A_IFINDEX] = { .type = NLA_U32 },
+	[OVPN_A_IFNAME] = NLA_POLICY_MAX_LEN(IFNAMSIZ),
+	[OVPN_A_MODE] = NLA_POLICY_RANGE(NLA_U8, __OVPN_MODE_FIRST,
+					 NUM_OVPN_MODE - 1),
+	[OVPN_A_PEER] = NLA_POLICY_NESTED(ovpn_nl_policy_peer),
+};
+
+/**
+ * ovpn_get_dev_from_attrs() - retrieve the netdevice a netlink message is targeting
+ */
+static struct net_device *
+ovpn_get_dev_from_attrs(struct net *net, struct nlattr **attrs)
+{
+	struct net_device *dev;
+	int ifindex;
+
+	if (!attrs[OVPN_A_IFINDEX])
+		return ERR_PTR(-EINVAL);
+
+	ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	if (!ovpn_dev_is_valid(dev))
+		goto err_put_dev;
+
+	return dev;
+
+err_put_dev:
+	dev_put(dev);
+
+	return ERR_PTR(-EINVAL);
+}
+
+/**
+ * ovpn_pre_doit() - Prepare ovpn genl doit request
+ * @ops: requested netlink operation
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
+static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			 struct genl_info *info)
+{
+	struct net *net = genl_info_net(info);
+	struct net_device *dev;
+
+	/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
+	 * just expects an IFNAME, while all the others expect an IFINDEX
+	 */
+	if (info->genlhdr->cmd == OVPN_CMD_NEW_IFACE) {
+		if (!info->attrs[OVPN_A_IFNAME]) {
+			GENL_SET_ERR_MSG(info, "no interface name specified");
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	dev = ovpn_get_dev_from_attrs(net, info->attrs);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	info->user_ptr[0] = netdev_priv(dev);
+
+	return 0;
+}
+
+/**
+ * ovpn_post_doit() - complete ovpn genl doit request
+ * @ops: requested netlink operation
+ * @skb: Netlink message with request data
+ * @info: receiver information
+ */
+static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
+			   struct genl_info *info)
+{
+	struct ovpn_struct *ovpn;
+
+	ovpn = info->user_ptr[0];
+	/* in case of OVPN_CMD_NEW_IFACE, there is no pre-stored device */
+	if (ovpn)
+		dev_put(ovpn->dev);
+}
+
+static const struct genl_small_ops ovpn_nl_ops[] = {
+};
+
+static struct genl_family ovpn_nl_family __ro_after_init = {
+	.hdrsize = 0,
+	.name = OVPN_NL_NAME,
+	.version = 1,
+	.maxattr = NUM_OVPN_A + 1,
+	.policy = ovpn_nl_policy,
+	.netnsok = true,
+	.pre_doit = ovpn_pre_doit,
+	.post_doit = ovpn_post_doit,
+	.module = THIS_MODULE,
+	.small_ops = ovpn_nl_ops,
+	.n_small_ops = ARRAY_SIZE(ovpn_nl_ops),
+	.mcgrps = ovpn_nl_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(ovpn_nl_mcgrps),
+};
+
+/**
+ * ovpn_nl_notify() - react to openvpn userspace process exit
+ */
+static int ovpn_nl_notify(struct notifier_block *nb, unsigned long state,
+			  void *_notify)
+{
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ovpn_nl_notifier = {
+	.notifier_call = ovpn_nl_notify,
+};
+
+/**
+ * ovpn_nl_init() - perform any ovpn specific netlink initialization
+ */
+int ovpn_nl_init(struct ovpn_struct *ovpn)
+{
+	return 0;
+}
+
+/**
+ * ovpn_nl_register() - register the ovpn genl nl family
+ */
+int __init ovpn_nl_register(void)
+{
+	int ret;
+
+	ret = genl_register_family(&ovpn_nl_family);
+	if (ret) {
+		pr_err("ovpn: genl_register_family() failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = netlink_register_notifier(&ovpn_nl_notifier);
+	if (ret) {
+		pr_err("ovpn: netlink_register_notifier() failed: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	genl_unregister_family(&ovpn_nl_family);
+	return ret;
+}
+
+/**
+ * ovpn_nl_unregister() - unregister the ovpn genl netlink family
+ */
+void ovpn_nl_unregister(void)
+{
+	netlink_unregister_notifier(&ovpn_nl_notifier);
+	genl_unregister_family(&ovpn_nl_family);
+}
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
new file mode 100644
index 000000000000..eb7f234842ef
--- /dev/null
+++ b/drivers/net/ovpn/netlink.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_NETLINK_H_
+#define _NET_OVPN_NETLINK_H_
+
+struct ovpn_struct;
+
+int ovpn_nl_init(struct ovpn_struct *ovpn);
+int ovpn_nl_register(void);
+void ovpn_nl_unregister(void);
+
+#endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
new file mode 100644
index 000000000000..932eb90953e0
--- /dev/null
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTRUCT_H_
+#define _NET_OVPN_OVPNSTRUCT_H_
+
+#include <linux/netdevice.h>
+
+/* Our state per ovpn interface */
+struct ovpn_struct {
+	struct net_device *dev;
+};
+
+#endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
new file mode 100644
index 000000000000..0c6c6165c63c
--- /dev/null
+++ b/drivers/net/ovpn/packet.h
@@ -0,0 +1,42 @@
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
+/* When the OpenVPN protocol is run in AEAD mode, use
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
+/* amount of bytes of the nonce received from user space */
+#define NONCE_TAIL_SIZE 8
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
+	u8 u8[NONCE_TAIL_SIZE];
+};
+
+#endif /* _NET_OVPN_PACKET_H_ */
diff --git a/include/uapi/linux/ovpn.h b/include/uapi/linux/ovpn.h
new file mode 100644
index 000000000000..56ba5bae6522
--- /dev/null
+++ b/include/uapi/linux/ovpn.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: (GPL-2.0-only WITH Linux-syscall-note) OR MIT */
+/*
+ *  OpenVPN data channel accelerator
+ *
+ *  Copyright (C) 2019-2023 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _UAPI_LINUX_OVPN_H_
+#define _UAPI_LINUX_OVPN_H_
+
+#define OVPN_NL_NAME "ovpn"
+
+#define OVPN_NL_MULTICAST_GROUP_PEERS "peers"
+
+/**
+ * enum ovpn_nl_commands - supported netlink commands
+ */
+enum ovpn_nl_commands {
+	/**
+	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors
+	 */
+	OVPN_CMD_UNSPEC = 0,
+	/**
+	 * @OVPN_CMD_NEW_IFACE: create a new OpenVPN interface
+	 */
+	OVPN_CMD_NEW_IFACE,
+	/**
+	 * @OVPN_CMD_DEL_IFACE: delete an existing OpenVPN interface
+	 */
+	OVPN_CMD_DEL_IFACE,
+	/**
+	 * @OVPN_CMD_SET_PEER: create or update a peer
+	 */
+	OVPN_CMD_SET_PEER,
+	/**
+	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
+	 */
+	OVPN_CMD_GET_PEER,
+	/**
+	 * @OVPN_CMD_DEL_PEER: remove a peer
+	 */
+	OVPN_CMD_DEL_PEER,
+	/**
+	 * @OVPN_CMD_SET_KEY: create or update an existing key in the specified key slot
+	 */
+	OVPN_CMD_SET_KEY,
+	/**
+	 * @OVPN_CMD_SWAP_KEYS: swap keys stored in primary and secondary slots
+	 */
+	OVPN_CMD_SWAP_KEYS,
+	/**
+	 * @OVPN_CMD_DEL_KEY: delete the key stored in the specified key slot
+	 */
+	OVPN_CMD_DEL_KEY,
+};
+
+enum ovpn_cipher_alg {
+	/**
+	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
+	 */
+	OVPN_CIPHER_ALG_NONE = 0,
+	/**
+	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
+	 */
+	OVPN_CIPHER_ALG_AES_GCM,
+	/**
+	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
+	 */
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+};
+
+enum ovpn_del_peer_reason {
+	__OVPN_DEL_PEER_REASON_FIRST,
+	OVPN_DEL_PEER_REASON_TEARDOWN = __OVPN_DEL_PEER_REASON_FIRST,
+	OVPN_DEL_PEER_REASON_USERSPACE,
+	OVPN_DEL_PEER_REASON_EXPIRED,
+	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+
+	/* new attrs above this line */
+	NUM_OVPN_DEL_PEER_REASON
+};
+
+enum ovpn_key_slot {
+	__OVPN_KEY_SLOT_FIRST = 0,
+	OVPN_KEY_SLOT_PRIMARY = __OVPN_KEY_SLOT_FIRST,
+	OVPN_KEY_SLOT_SECONDARY,
+
+	/* new attrs above this line */
+	NUM_OVPN_KEY_SLOT
+};
+
+enum ovpn_mode {
+	__OVPN_MODE_FIRST = 0,
+	OVPN_MODE_P2P = __OVPN_MODE_FIRST,
+	OVPN_MODE_MP,
+
+	/* new attrs above this line */
+	NUM_OVPN_MODE
+};
+
+enum ovpn_nl_stats_attrs {
+	OVPN_A_STATS_UNSPEC = 0,
+	OVPN_A_STATS_BYTES,
+	OVPN_A_STATS_PACKETS,
+
+	/* new attrs above this line */
+	NUM_OVPN_A_STATS
+};
+
+enum ovpn_nl_attrs {
+	OVPN_A_UNSPEC = 0,
+	OVPN_A_IFINDEX,
+	OVPN_A_IFNAME,
+	OVPN_A_MODE,
+	OVPN_A_PEER,
+
+	/* new attrs above this line */
+	NUM_OVPN_A
+};
+
+enum ovpn_nl_peer_attrs {
+	OVPN_A_PEER_UNSPEC = 0,
+	OVPN_A_PEER_ID,
+	OVPN_A_PEER_RX_STATS,
+	OVPN_A_PEER_TX_STATS,
+	OVPN_A_PEER_SOCKADDR_REMOTE,
+	OVPN_A_PEER_SOCKET,
+	OVPN_A_PEER_VPN_IPV4,
+	OVPN_A_PEER_VPN_IPV6,
+	OVPN_A_PEER_LOCAL_IP,
+	OVPN_A_PEER_LOCAL_PORT,
+	OVPN_A_PEER_KEEPALIVE_INTERVAL,
+	OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+	OVPN_A_PEER_DEL_REASON,
+	OVPN_A_PEER_KEYCONF,
+	OVPN_A_PEER_VPN_RX_BYTES,
+	OVPN_A_PEER_VPN_TX_BYTES,
+	OVPN_A_PEER_VPN_RX_PACKETS,
+	OVPN_A_PEER_VPN_TX_PACKETS,
+	OVPN_A_PEER_LINK_RX_BYTES,
+	OVPN_A_PEER_LINK_TX_BYTES,
+	OVPN_A_PEER_LINK_RX_PACKETS,
+	OVPN_A_PEER_LINK_TX_PACKETS,
+
+	/* new attrs above this line */
+	NUM_OVPN_A_PEER
+};
+
+enum ovpn_nl_keyconf_attrs {
+	OVPN_A_KEYCONF_UNSPEC = 0,
+	OVPN_A_KEYCONF_SLOT,
+	OVPN_A_KEYCONF_KEY_ID,
+	OVPN_A_KEYCONF_CIPHER_ALG,
+	OVPN_A_KEYCONF_ENCRYPT_DIR,
+	OVPN_A_KEYCONF_DECRYPT_DIR,
+
+	/* new attrs above this line */
+	NUM_OVPN_A_KEYCONF
+};
+
+enum ovpn_nl_keydir_attrs {
+	OVPN_A_KEYDIR_UNSPEC = 0,
+	OVPN_A_KEYDIR_CIPHER_KEY,
+	OVPN_A_KEYDIR_NONCE_TAIL,
+
+	/* new attrs above this line */
+	NUM_OVPN_A_KEYDIR
+};
+
+#endif /* _UAPI_LINUX_OVPN_H_ */
-- 
2.43.0


