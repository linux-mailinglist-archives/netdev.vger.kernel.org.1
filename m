Return-Path: <netdev+bounces-77129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2158704DB
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D561F22F78
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088947A67;
	Mon,  4 Mar 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F8bqgnde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C508F4654D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564943; cv=none; b=U+SAtvZAiDeLhKkKV78W9yC7Ue165ft4ZyL87afZLPPrc8Vj88a1UkCGrHhtTEPTcr8eUI+zw1rr2qvNRNbMNmOMJmaBYG3y9zwtxmETP6EZ2YVcijAb/AR84Vyh/ib3CGm+O6DK+4ea/yZex6mRJeTu+ldpdO4AXI5617Oyi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564943; c=relaxed/simple;
	bh=LejPdGKXSYpaRVZj2v1ippZZw5v+GBXbgNZmkZpibkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4FIMflE4TEGGKSSBOE6kiWNqvJxC6Fjs5UdZsup4gTVZ0rR58V1XAjMFvUeVBf1mqqz+giSNOWy/1sSPnqoVyGfx/0vQRd0cxKZ5Zn5SOHSXiBGq+Vxr6bxdS5WPaebD2cN60A4dt+gg+I9itvfpGJHOEriI2fxjfelDbK2OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F8bqgnde; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso1047469866b.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564939; x=1710169739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVnYGjAh/H/+oOnUxj3PJ2YjU6vgBW09PyLG/MpYAaY=;
        b=F8bqgndelpA2jl+akt7nrhTFMMy6GvTA4UCU1rAOf9N2W0DzjBLhMMR4kJxNg99ZZY
         G/DWlkttXHwrZuovFI1qmNuYxyvZO1i/hkGj8Xexqa5rGXZ6XjLqmtlpdMLxZxPqTYkL
         EPpLMBOMamxJsShpPJM7jyHrP5q66liJy8LN2w64tCGewrcLDEqH1B+6+wirWH3y/OwO
         dxXNSQFrh0Ujj6mbtg4o8eLulJlK91L4l96Qs7OUSJkslq/ztsZC0RtccsjARWWDCpZu
         2rpd/ZUFkZB0dZeyohWssC7unTFkYMM/piahVUU2KeL8jumK7hv7nHebNR6JZPhrQLMb
         tOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564939; x=1710169739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVnYGjAh/H/+oOnUxj3PJ2YjU6vgBW09PyLG/MpYAaY=;
        b=q3uo5CGofSantz1oG50dACVuRSl2wnalQvE2ODiM8j3mMLXrdBVWC4HMM+la6LBzrL
         Qd6agPRJv3zLVwECQYvsh9PaxkxNGXwqLj8YSiV3MpFWc8fpGKZBBg7YncIGwHpjy3tl
         J9X6BF5+HInpjmGVXmDdIPbF6BcpNEomLc0q+hJKBVarpFi/UorIk1eYwC6flgKzmbUv
         XVyomCpXC2Mp9Nu6k3DH/CJ6KYIcTh8yg6bwq+gZ5Cypa3GoWK3Ui/mvPsGHzOVpllZO
         go7CF3m4lKxIAuuKWcfdc5S11v0o0PNplT4TucclH76i9S4OGUw2wTXv+8gi76QkAMUM
         IalQ==
X-Gm-Message-State: AOJu0YwKQbERcMMQFxTJ4O2WtZxiSzuOP6QiNbAZ4iuMa6ynTMafR2kC
	HBO71Eac/Bz4hEWBQoS0lsCLkmquX0UlyOoDcfLNPPh8906qh+JnhqW1PJ/zbiOOHYx/FXDGVoG
	H9kE=
X-Google-Smtp-Source: AGHT+IEFOdWs+puRQ3nYW2y/vpciMc4DnSXiFOtdC5Lm1mLJbXZdrhbICLpALIRN6ah2KZTZaI0rXA==
X-Received: by 2002:a17:906:ca4a:b0:a44:2cc3:2ba8 with SMTP id jx10-20020a170906ca4a00b00a442cc32ba8mr8764326ejb.27.1709564938601;
        Mon, 04 Mar 2024 07:08:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:08:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 02/22] net: introduce OpenVPN Data Channel Offload (ovpn)
Date: Mon,  4 Mar 2024 16:08:53 +0100
Message-ID: <20240304150914.11444-3-antonio@openvpn.net>
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

OpenVPN is a userspace software existing since around 2005 that allows
users to create secure tunnels.

So far OpenVPN has implemented all operations in userspace, which
implies several back and forth between kernel and user land in order to
process packets (encapsulate/decapsulate, encrypt/decrypt, rerouting..).

With `ovpn` we intend to move the fast path (data channel) entirely
in kernel space and thus improve user measured throughput over the
tunnel.

`ovpn` is implemented as a simple virtual network device driver, that
can be manipulated by means of the standard RTNL APIs. A device of kind
`ovpn` allows only IPv4/6 traffic and can be of type:
* P2P (peer-to-peer): any packet sent over the interface will be
  encapsulated and transmitted to the other side (typical OpenVPN
  client or peer-to-peer behaviour);
* P2MP (point-to-multipoint): packets sent over the interface are
  transmitted to peers based on existing routes (typical OpenVPN
  server behaviour).

After the interface has been created, OpenVPN in userspace can
configure it using a new Netlink API. Specifically it is possible
to manage peers and their keys.

The OpenVPN control channel is multiplexed over the same transport
socket by means of OP codes. Anything that is not DATA_V2 (OpenVPN
OP code for data traffic) is sent to userspace and handled there.
This way the `ovpn` codebase is kept as compact as possible while
focusing on handling data traffic only (fast path).

Any OpenVPN control feature (like cipher negotiation, TLS handshake,
rekeying, etc.) is still fully handled by the userspace process.

When userspace establishes a new connection with a peer, it first
performs the handshake and then passes the socket to the `ovpn` kernel
module, which takes ownership. From this moment on `ovpn` will handle
data traffic for the new peer.
When control packets are received on the link, they are forwarded to
userspace through the same transport socket they were received on, as
userspace is still listening to them.

Some events (like peer deletion) are sent to a Netlink multicast group.

Although it wasn't easy to convince the community, `ovpn` implements
only a limited number of the data-channel features supported by the
userspace program.

Each feature that made it to `ovpn` was attentively vetted to
avoid carrying too much legacy along with us (and to give a clear cut to
old and probalby-not-so-useful features).

Notably, only encryption using AEAD ciphers (specifically
ChaCha20Poly1305 and AES-GCM) was implemented. Supporting any other
cipher out there was not deemed useful.

Both UDP and TCP sockets ae supported.

As explained above, in case of P2MP mode, OpenVPN will use the main system
routing table to decide which packet goes to which peer. This implies
that no routing table was re-implemented in the `ovpn` kernel module.

This kernel module can be enabled by selecting the CONFIG_OVPN entry
in the networking drivers section.

NOTE: this first patch introduces the very basic framework only.
Features are then added patch by patch, however, although each patch
will compile and possibly not break at runtime, only after having
applied the full set it is expected to see the ovpn module fully working.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS               |   8 +++
 drivers/net/Kconfig       |  13 +++++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  11 ++++
 drivers/net/ovpn/io.c     |  23 ++++++++
 drivers/net/ovpn/io.h     |  19 ++++++
 drivers/net/ovpn/main.c   | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/main.h   |  38 ++++++++++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 232 insertions(+)
 create mode 100644 drivers/net/ovpn/Makefile
 create mode 100644 drivers/net/ovpn/io.c
 create mode 100644 drivers/net/ovpn/io.h
 create mode 100644 drivers/net/ovpn/main.c
 create mode 100644 drivers/net/ovpn/main.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e5f7c20e30..5ded5e931622 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16529,6 +16529,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
 
+OPENVPN DATA CHANNEL OFFLOAD
+M:	Antonio Quartulli <antonio@openvpn.net>
+L:	openvpn-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ovpn/
+F:	include/uapi/linux/ovpn.h
+
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8ca0bc223b30..66ddfd758a40 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	select NET_UDP_TUNNEL
+	select DST_CACHE
+	select CRYPTO
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_CHACHA20POLY1305
+	help
+	  This module enhances the performance of the OpenVPN userspace software
+	  by offloading the data channel processing to kernelspace.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 7cab36f94782..a0b33e7c29ad 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_IPVLAN) += ipvlan/
 obj-$(CONFIG_IPVTAP) += ipvlan/
 obj-$(CONFIG_DUMMY) += dummy.o
 obj-$(CONFIG_WIREGUARD) += wireguard/
+obj-$(CONFIG_OVPN) += ovpn/
 obj-$(CONFIG_EQUALIZER) += eql.o
 obj-$(CONFIG_IFB) += ifb.o
 obj-$(CONFIG_MACSEC) += macsec.o
diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
new file mode 100644
index 000000000000..7b8b1d0ff9b4
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ovpn -- OpenVPN data channel offload in kernel space
+#
+# Copyright (C) 2020-2024 OpenVPN, Inc.
+#
+# Author:	Antonio Quartulli <antonio@openvpn.net>
+
+obj-$(CONFIG_OVPN) += ovpn.o
+ovpn-y += main.o
+ovpn-y += io.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
new file mode 100644
index 000000000000..a1e19402e36d
--- /dev/null
+++ b/drivers/net/ovpn/io.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "io.h"
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+
+/* Send user data to the network
+ */
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	skb_tx_error(skb);
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
+}
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
new file mode 100644
index 000000000000..0a076d14f721
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPN_H_
+#define _NET_OVPN_OVPN_H_
+
+#include <linux/netdevice.h>
+
+struct sk_buff;
+
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+
+#endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 000000000000..25964eb89aac
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include "main.h"
+#include "io.h"
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/net.h>
+#include <linux/inetdevice.h>
+#include <linux/netdevice.h>
+#include <linux/version.h>
+
+
+/* Driver info */
+#define DRV_NAME	"ovpn"
+#define DRV_VERSION	OVPN_VERSION
+#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
+#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
+
+/* Net device open */
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
+
+	if (dev_v4) {
+		/* disable redirects as Linux gets confused by ovpn handling same-LAN routing */
+		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+	}
+
+	netif_tx_start_all_queues(dev);
+	return 0;
+}
+
+/* Net device stop -- called prior to device unload */
+static int ovpn_net_stop(struct net_device *dev)
+{
+	netif_tx_stop_all_queues(dev);
+	return 0;
+}
+
+bool ovpn_dev_is_valid(const struct net_device *dev)
+{
+	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
+}
+
+static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
+	.ndo_stop		= ovpn_net_stop,
+	.ndo_start_xmit		= ovpn_net_xmit,
+	.ndo_get_stats64        = dev_get_tstats64,
+};
+
+static int ovpn_netdev_notifier_call(struct notifier_block *nb,
+				     unsigned long state, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
+	if (!ovpn_dev_is_valid(dev))
+		return NOTIFY_DONE;
+
+	switch (state) {
+	case NETDEV_REGISTER:
+		/* add device to internal list for later destruction upon unregistration */
+		break;
+	case NETDEV_UNREGISTER:
+		/* can be delivered multiple times, so check registered flag, then
+		 * destroy the interface
+		 */
+		break;
+	case NETDEV_POST_INIT:
+	case NETDEV_GOING_DOWN:
+	case NETDEV_DOWN:
+	case NETDEV_UP:
+	case NETDEV_PRE_UP:
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ovpn_netdev_notifier = {
+	.notifier_call = ovpn_netdev_notifier_call,
+};
+
+static int __init ovpn_init(void)
+{
+	int err = register_netdevice_notifier(&ovpn_netdev_notifier);
+
+	if (err) {
+		pr_err("ovpn: can't register netdevice notifier: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static __exit void ovpn_cleanup(void)
+{
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+}
+
+module_init(ovpn_init);
+module_exit(ovpn_cleanup);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_AUTHOR(DRV_COPYRIGHT);
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
new file mode 100644
index 000000000000..cc624116e2f9
--- /dev/null
+++ b/drivers/net/ovpn/main.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_MAIN_H_
+#define _NET_OVPN_MAIN_H_
+
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/printk.h>
+#include <linux/udp.h>
+
+#ifndef OVPN_VERSION
+#define OVPN_VERSION "3.0.0"
+#endif
+
+struct net_device;
+struct ovpn_struct;
+enum ovpn_mode;
+
+bool ovpn_dev_is_valid(const struct net_device *dev);
+int ovpn_iface_create(const char *name, enum ovpn_mode mode, struct net *net);
+void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_device);
+
+#define SKB_HEADER_LEN                                       \
+	(max(sizeof(struct iphdr), sizeof(struct ipv6hdr)) + \
+	 sizeof(struct udphdr) + NET_SKB_PAD)
+
+#define OVPN_HEAD_ROOM ALIGN(16 + SKB_HEADER_LEN, 4)
+#define OVPN_MAX_PADDING 16
+#define OVPN_QUEUE_LEN 1024
+
+#endif /* _NET_OVPN_MAIN_H_ */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 4828794efcf8..0dd94757127f 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -43,5 +43,6 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */
 
 #endif /* _UAPI_LINUX_UDP_H */
-- 
2.43.0


