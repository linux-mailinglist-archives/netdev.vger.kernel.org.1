Return-Path: <netdev+bounces-128620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF90897AA17
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F0C1C22BF0
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1A219FC;
	Tue, 17 Sep 2024 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="C86Je7pg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288717753
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535286; cv=none; b=cqV/7xQ8nMqRDKOw08atpXUFnSIjbDdMDfCPmIp0MSZXEsrkKKZdraWQXlK/e0214NDhE/yx8nq5Ncku3W+mdHRNZsuRzpkMO1kvFrEjvUKWbG7EIP53sjFRKugSltI6Ub9Z2SNHoUWb7UxYL137D8/tpI8shMr6w0Ah4mbzbqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535286; c=relaxed/simple;
	bh=Xh6guHdMZ9Yk+qjPc0aHeXaI5BMZQaHbCBqNZ4cQdns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFW9Aq5d5R81h5qNkn96vE+MgSsfCoEfSP522/jOpOXHxXIy6OaXPRY3zs7aBvQpL9tj44B0EB5DLb7h5lU8sXQcbu2BJ22pHgFezh9BVNuKjN1gvBkdS1lUc86mW+4iDYZxNdvVPYe9xHAnbPZnkbyy+fLLCAgK+QdqJ2ollFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=C86Je7pg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so43170505e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535281; x=1727140081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJmh/mcGbdk1yhKTqSf8/1orrpm8RG97dt1j/gIZ7As=;
        b=C86Je7pgjhGCL0mxFMn8DzAOQUCn70efETjCvZO1rQE32R0Qz0MJf6UaU0/I+HfBOr
         B9Wf65MRd0h9b1Mb783bZXA0WKFH4o1fJ+lPG7pNjLTd5I0y/P/k9G2oOB1ooWHxH65y
         U5t4Iwlu91+tsYaSAs/uNev2/ryJN0BbEjupG2cAGLRVMYtFZybapvp5raHVpst3Zuhw
         6ZMcsPAIyUSG0c9/YaJWmvaCZQGc7lFfZplVBaqS/m27eKOHsQWbN3fC4ahdjNIqS28c
         8NUEKZ1g/NJ2TO6lRwen0hLlZvDeQh4BDQK+G4esGdVEy2Qr+6L2bcucBjU22G8gazrr
         POzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535281; x=1727140081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJmh/mcGbdk1yhKTqSf8/1orrpm8RG97dt1j/gIZ7As=;
        b=L5l7eEPRElDxCNwyqbT+zWd0UN0in7YQ9X1fAv++VNSHXuI+f/iold8veqQAyttSNR
         fCh77OSv5PtBed1psLQlXBwXPBSNERrWACIPdouhv2MZQGKPNqNYQe6PT0YHfb2BQexY
         Lr11DnYOSzohhnAU/psLwvWArdygn74ToYUu7rbgLlU1mZuinPPBseBjfMVZMos5/LYl
         cWz/Otg7sKtgvLlik6stWFbO78hxKeWbZWkl6uLO5M0ZD4kFqkIA45qdLvb7rcB8CU0c
         PkTXGPYDNKG3aXR5Z9CtKfXheoFbg+wDCg4xze6L8U8sv/jObr+ROHEGpGvkkFZhNjVX
         C/dQ==
X-Gm-Message-State: AOJu0YyASVRDhU3tMnmfMOK2Ii5oq0E7nkdDz4tFIYIZzuN2dvIdr9Vc
	GeGGh047v2w3Rn1cfv7jrHsR84RuOCp50h7S5k/DxrDkMiCYN7rI9MnAXsR7qzusmeKFG9DHS8h
	J
X-Google-Smtp-Source: AGHT+IGY5SYhjZz7WWY4VigRLAGypaNyAMtwCbhrbCjIPhX8oiwY7oQroq9fG9mjxI7k2O6iT1k3UA==
X-Received: by 2002:adf:b30e:0:b0:374:c33d:377b with SMTP id ffacd0b85a97d-378c2d5a7ddmr9923074f8f.45.1726535281226;
        Mon, 16 Sep 2024 18:08:01 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:00 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com
Subject: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel Offload (ovpn)
Date: Tue, 17 Sep 2024 03:07:12 +0200
Message-ID: <20240917010734.1905-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
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

Cc: steffen.klassert@secunet.com
Cc: antony.antony@secunet.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 MAINTAINERS               |   7 +++
 drivers/net/Kconfig       |  14 +++++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  11 ++++
 drivers/net/ovpn/io.c     |  22 ++++++++
 drivers/net/ovpn/io.h     |  15 ++++++
 drivers/net/ovpn/main.c   | 109 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/main.h   |  15 ++++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 195 insertions(+)
 create mode 100644 drivers/net/ovpn/Makefile
 create mode 100644 drivers/net/ovpn/io.c
 create mode 100644 drivers/net/ovpn/io.h
 create mode 100644 drivers/net/ovpn/main.c
 create mode 100644 drivers/net/ovpn/main.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fcd6f802a5..53b6350d95be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17263,6 +17263,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
 
+OPENVPN DATA CHANNEL OFFLOAD
+M:	Antonio Quartulli <antonio@openvpn.net>
+L:	openvpn-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ovpn/
+
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..0055bcd2356c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,20 @@ config WIREGUARD_DEBUG
 
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
+	select STREAM_PARSER
+	help
+	  This module enhances the performance of the OpenVPN userspace software
+	  by offloading the data channel processing to kernelspace.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5..5152b3330e28 100644
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
index 000000000000..53fb197027d7
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
+obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += main.o
+ovpn-y += io.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
new file mode 100644
index 000000000000..ad3813419c33
--- /dev/null
+++ b/drivers/net/ovpn/io.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+#include "io.h"
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
index 000000000000..aa259be66441
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,15 @@
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
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+
+#endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 000000000000..8a90319e4600
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/version.h>
+#include <net/rtnetlink.h>
+
+#include "main.h"
+#include "io.h"
+
+/* Driver info */
+#define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
+#define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
+
+/**
+ * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
+ * @dev: the interface to check
+ *
+ * Return: whether the netdevice is of type 'ovpn'
+ */
+bool ovpn_dev_is_valid(const struct net_device *dev)
+{
+	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
+}
+
+/* we register with rtnl to let core know that ovpn is a virtual driver and
+ * therefore ifaces should be destroyed when exiting a netns
+ */
+static struct rtnl_link_ops ovpn_link_ops = {
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
+		/* add device to internal list for later destruction upon
+		 * unregistration
+		 */
+		break;
+	case NETDEV_UNREGISTER:
+		/* can be delivered multiple times, so check registered flag,
+		 * then destroy the interface
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
+	err = rtnl_link_register(&ovpn_link_ops);
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		goto unreg_netdev;
+	}
+
+	return 0;
+
+unreg_netdev:
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+	return err;
+}
+
+static __exit void ovpn_cleanup(void)
+{
+	rtnl_link_unregister(&ovpn_link_ops);
+	unregister_netdevice_notifier(&ovpn_netdev_notifier);
+
+	rcu_barrier();
+}
+
+module_init(ovpn_init);
+module_exit(ovpn_cleanup);
+
+MODULE_DESCRIPTION(DRV_DESCRIPTION);
+MODULE_AUTHOR(DRV_COPYRIGHT);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ovpn/main.h b/drivers/net/ovpn/main.h
new file mode 100644
index 000000000000..a3215316c49b
--- /dev/null
+++ b/drivers/net/ovpn/main.h
@@ -0,0 +1,15 @@
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
+bool ovpn_dev_is_valid(const struct net_device *dev);
+
+#endif /* _NET_OVPN_MAIN_H_ */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index 1a0fe8b151fb..f9f8ffddfd0c 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -43,5 +43,6 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */
 
 #endif /* _UAPI_LINUX_UDP_H */
-- 
2.44.2


