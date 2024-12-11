Return-Path: <netdev+bounces-151217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D50C9ED892
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4186282D4C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED41F0E3A;
	Wed, 11 Dec 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UxvWcadD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C71D89F5
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952769; cv=none; b=aHUql67ie+u99kZoZPlvgP5BWuWukSXCwSw+ROBQW8GbepOsUd+x/xwzP8fl1eKdr6J+n28PDUyAsEKWaWYkQBy3R7K2WRf0T1f119iayP7Nm5VORQkcG7m3Ticq0t42Vp1WF0qQAReMQh4gXYqTLyDLALg3ey+14f45COQfUdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952769; c=relaxed/simple;
	bh=AKaW79GTNK8iaHuX9LJnUkKG5HdqRsGm8LzCYmG0KX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5V4vFxw2M/RajpCNsMlHHq/hD/ckehsLUprUdSgHZTldBv39DU7BZdjZx/usaaO0kcmCYKP3A7tqmPQ0nDxf/FnOcVoLr73fWpi+tfn5wfjjoxBEcMO3w8Fbl5lrh3kjt9MmZErE04GqlAerhEEJut6VrDSFpvaIvfxs5x1ulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UxvWcadD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43622267b2eso4340935e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952765; x=1734557565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YOpfArEDwBDIsIiAUOlCwE0mvp9zRjNmm9YvnXq6gQ=;
        b=UxvWcadDL3Kn5W/9TqaZWNE7/CPmGacbIRHWurkkyPYFCbnRQDVjdCez0VS1D4ec43
         d7iUQ1eBKfezY3zYXqP5iAxhoslBmSihkpMN8cB2Ya7pdBit8xcAbPWBELbCLg9NI16r
         A2Wcg5EvlomzaRPpxLAy+OB+TYtxZOC3M+iPb9G2oKGAbAkrhEaSgGgg1CyvaIjDzlOq
         HUx5yd5GrrOEaeYieptKLp/awUFA2xoHUe8U/BTwo81nJ36jbxayVj6+IWs+Ryfr4ibe
         ofyldpCWPGcJjQcuee+xFBusX/XnMIUFicnYKQ5NGhfkGrM0tiENOZCH7txk1B6sZxsW
         pS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952765; x=1734557565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YOpfArEDwBDIsIiAUOlCwE0mvp9zRjNmm9YvnXq6gQ=;
        b=jjeG/6NuriYwhgENj8/ABOUttXddkUiUoqUKt+3aPczLNu7uLQDXFur61Ro6RLznwH
         8PffkS7xMcCiU0EfsBnXKnj3VQGvJ4+2X5vZjHKvqsCpi4uxietFiHXplKEFUKJdMn8E
         EtPtFaG48xI3dg3lzIEUbX/YRgH2kIhlxBc6WjniVYp+jGVBlO1i53VYCJH8AZlzlrbr
         wQrktlHrsqrFULkTjr1JW5Jdxhzq4utFmqBjnaEPSD3Dmx/9nKL39IXKSLQFCLb9nC3m
         5Xq3d5u9hjuwFUgA5La0JNV855dtOuVcE/9c+6i4EdtAFINaizBc/3d82H/2nE6Q0ZJb
         IO9Q==
X-Gm-Message-State: AOJu0Yw23/rT+/l0Z8IwMCziiyWOdT5eIHRuuYdtRVcJthul2cynG4Ai
	ZJ1PaYaNvNEl+5kYr2n/T9LQT/dEvsOY3LcgdVa4WQDtvh6yrYwYv7T2XAO4iEU=
X-Gm-Gg: ASbGnctdYimlyrNrEi/pdsTP+am09bMiFTv3Q7iXIA18h1mXLJirP+DBFNBZMo+RsE1
	5ZKxAkJS+swmNhlYYssIa4ymYL7jNK5bPX92UGG4fckEADR87drXINg8pcdu6TNEX/ep+VAo4qw
	dZiFjCGjBjavx6O311bkZWYmIuI59GZfXFuxaEE8LoOPTvFCtkkvgCLOg+elJi8lP+U3F26YhFk
	mfAe7pEYcUxtQcm/J8DsA2EV8w0WQBJeO1mbnHSq134b834w8greQIjuUoAdQZMmw==
X-Google-Smtp-Source: AGHT+IFQcd1BE7vo27+/yjaJEWzRgbxdJVlzAKIzgj/kM5PNNK08ESXr4cgocdUscWF0VTn600qXJQ==
X-Received: by 2002:a05:600c:a011:b0:434:f623:a004 with SMTP id 5b1f17b1804b1-4361c3a157cmr38297335e9.16.1733952764727;
        Wed, 11 Dec 2024 13:32:44 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:32:44 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:05 +0100
Subject: [PATCH net-next v15 01/22] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-1-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 steffen.klassert@secunet.com, antony.antony@secunet.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8900; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=AKaW79GTNK8iaHuX9LJnUkKG5HdqRsGm8LzCYmG0KX8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUk3/GOnD8wgh/SN3KLiHOtmYzoahy4Bgrit
 CUatDnZU7WJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJAAKCRALcOU6oDjV
 h+ExB/9RyEsq/Fi2UkzoBnLrJzwL52BdyLnp0l7GRSjndUQWwidxxuCFTF+rS9Os48StaZzCde9
 GFMtMMlE0UdYYBj9KqJZq/Nc+d3yX4tAF31sooCjNHWULJDpxQyyBLezcBxYNw5jJJGNfIv/nop
 +9QcMo/d6wMuhPZstW3xclzjOTXSyaliTKcF6SQQ13/iQbamF5aO5hZAuL724du/s6iiaqBOc3l
 ZypouaNSp3DNXRRRCB4ZOpH8FDExYW9cCklT9GMbCcoc8WhOLRUtC8IDG0iRCUG/vphhvwqiDg6
 7q2mQn6tyF91iTxah2jTULOE9u5KbU0e0iW8f5/eSy59H7qC
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

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

Both UDP and TCP sockets are supported.

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
 MAINTAINERS               |   8 ++++
 drivers/net/Kconfig       |   7 +++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  10 +++++
 drivers/net/ovpn/main.c   | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af35519be3200af339a11d994cda60b177b091be..18747e90f9ff580cb068c265c8fe3cccf7e05615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17555,6 +17555,14 @@ F:	arch/openrisc/
 F:	drivers/irqchip/irq-ompic.c
 F:	drivers/irqchip/irq-or1k-*
 
+OPENVPN DATA CHANNEL OFFLOAD
+M:	Antonio Quartulli <antonio@openvpn.net>
+L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
+L:	netdev@vger.kernel.org
+S:	Supported
+T:	git https://github.com/OpenVPN/linux-kernel-ovpn.git
+F:	drivers/net/ovpn/
+
 OPENVSWITCH
 M:	Pravin B Shelar <pshelar@ovn.org>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1fd5acdc73c6af0e1a861867039c3624fc618e25..a7c5c166f9ced748d73843f81efb802072e15434 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,13 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	help
+	  This module enhances the performance of the OpenVPN userspace software
+	  by offloading the data channel processing to kernelspace.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5fde479e9b30ad736be402d880dee..5152b3330e28da7eaec821018a26c973bb33ce0c 100644
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
index 0000000000000000000000000000000000000000..ae19cf445b29367da680e226f06a341c42c892c2
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,10 @@
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
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..72c56e73771cdece22e50645b29c79962f06caf3
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,112 @@
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
+#include <net/rtnetlink.h>
+
+static const struct net_device_ops ovpn_netdev_ops = {
+};
+
+/**
+ * ovpn_dev_is_valid - check if the netdevice is of type 'ovpn'
+ * @dev: the interface to check
+ *
+ * Return: whether the netdevice is of type 'ovpn'
+ */
+static bool ovpn_dev_is_valid(const struct net_device *dev)
+{
+	return dev->netdev_ops == &ovpn_netdev_ops;
+}
+
+static int ovpn_newlink(struct net *src_net, struct net_device *dev,
+			struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct rtnl_link_ops ovpn_link_ops = {
+	.kind = "ovpn",
+	.netns_refund = false,
+	.newlink = ovpn_newlink,
+	.dellink = unregister_netdevice_queue,
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
+MODULE_DESCRIPTION("OpenVPN data channel offload (ovpn)");
+MODULE_AUTHOR("(C) 2020-2024 OpenVPN, Inc.");
+MODULE_LICENSE("GPL");

-- 
2.45.2


