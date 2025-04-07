Return-Path: <netdev+bounces-179896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62659A7EDCB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B44F175126
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC7154C0D;
	Mon,  7 Apr 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EP9bigrc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28E21B191
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055229; cv=none; b=m6zCbQyKfuqAnFdRioqkGb+oOS1U4GO4ZExZ9LH6PxZswhajAkfasR07o5e3DcAzixL6UmApegnomRv/lW2swVtR2WT7tdv9YgPG4z4hDkrhnSnaDqGNxADwt4O+JABiSvGWFSnmOEesnJlMq/Zd83z4w5baSrzV5Hxgwc9drk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055229; c=relaxed/simple;
	bh=xi4J6CWP/ZJ7AVl6/k/aPYNgDgroNtJxiMwJyqRFTs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9LUB0mXSr6K5HpqsgLTEH8q99eUcWcl8e+0MUpBPhiPWzrn1+eSCQh/oAtl2IjgB+YlnfA+p33URx7QnTeiLXwMwxADmBUKY8byfV1Xcbvb7k2X3xNGtmFX81w2NcnDVOoSGtcXKzjVX/iMuqqK2PcSmWlAU1mNSitXkruG5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EP9bigrc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso44497015e9.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055225; x=1744660025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmuA+jArRaTvh0sKSVRCeQZBt5HnwlVzlklVTQVVmJI=;
        b=EP9bigrcqP/0mtYXMOvhHhglE4D+lG1MnKctX7pItVQGpULqAg6pjU4cOGN/chTC3n
         aVrWcwyyKz4dJek0fFJsiCesFjEfYNEHwLU8ezxpDvuHS6v+WHHcaqHr0ENNVOZH0sOT
         rB8l5tsnvpWY1jm244EpkFSeT2dgI8e56ZTUiExC7I/+GO2MXLbZfg+NF0E1VLIKBWOT
         8B+DVolA8zI8hlHqa713yHKp050IcKQ4yH/04m5zUvLb0sZCUjp/gUuGfllgFQP9tkLA
         De4bt/r7uPK3jn/O7aKd4kxFUAIDLgADLfwyhSwR1tif4ON0u4+xP20n2Q6jKoKPE7dB
         vm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055225; x=1744660025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmuA+jArRaTvh0sKSVRCeQZBt5HnwlVzlklVTQVVmJI=;
        b=ZxzbnpgfERgdhBWGzMtFx8e+jYzIhuQxFqjmSYjgmxcKCgk27b3iauErL2i2ALftLP
         LH0Lm+IpLuQZ+n7MVmUNav8LF8XbTZBm8PsSecO78k19u6VtWeXsp4laNiwnnY9hA/Q7
         ux7YilJetiOUIA8TrUWLkCxnvIxbo9DdXNjrmu37pHFT3qOLGQuJfRMa1DAz3IDprUau
         2D1IbKi8fmpXDsmX53Zm1kYFc4kjX9++uoe/tZdkF/CKvlXKsyAcrVLsoGpPkT7BekX0
         z9txAZcu7z2RdymJxDLaMUTAc/B3bYO9DQHIXYf1Yj5V7ocGcVlQy+m3Gn+p6PP5Ridu
         G2sw==
X-Gm-Message-State: AOJu0YxBeJDtGT6VHNRVKeB/sfEhKHmeJ5ZsExE2oZEfRhAvkyPXRDIo
	Hhb0+RS0hkMQ7it9h6mIroEcefTSZL01k7fYDifHGUfmm0X24YFKdU4sb/87tOdObj4R0YXkW2V
	Sxp8bCr6E7uclOIrwJlE020tWtMQljwjML6x1e/+THFaboq0=
X-Gm-Gg: ASbGncvruD5F4C3chke4yjRyNZOVS3t4zsiu0tTKkSh7VtkTm89qEV/R3DyVidhaWCd
	kT9YBOZhhtR2Fki9KGUOJYFArTIFe5kNn/RuJhMv2q1qKgf2m/L5cHyGN/d3W21KSGiHL+mGFAP
	EmE5DKpeJfSVMejmfxCRv29m/wQr+mlP8aBuXVaUzcBBBi1RJya9t4bvuPyBlkxjlnaOoatzcxP
	SyndIGXTBk36qC2UW1F6PtLg1KWcAISSalis6mUaGPBiQj/aW1Y2oTq/xmnBRrrhOdKbawvWylq
	Iq9EJySvOyrwCB8+i8p251AphReuN3hBT0Mlm8jGPg==
X-Google-Smtp-Source: AGHT+IGfGfBmq38yJN+HIzpfc4Ci5cHT/kHvnrUJLcP0BzmQ6CLjH9sgqKsFclxUcVkvO1bXCWVQkQ==
X-Received: by 2002:a05:600c:444b:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43ecf8f2a65mr125492255e9.15.1744055225053;
        Mon, 07 Apr 2025 12:47:05 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:04 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:09 +0200
Subject: [PATCH net-next v25 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-1-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8914; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=xi4J6CWP/ZJ7AVl6/k/aPYNgDgroNtJxiMwJyqRFTs0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu0HT0djCeEoMCkDxvxlq1ZnzFdW+gdp/G7r
 lyrBIaf9gyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtAAKCRALcOU6oDjV
 hz7zB/45VEtBB1odHefc8hQeU2w6eXjDFuY40DGg/TVM+BNIjDHDC8ydiIVFx+TR1LpGpPSMMIt
 MAYivLdiMikffcdpX4Go21Oxn3vjFXDFl8TQ+d5SPZlNxR0UfZTl8uAZvSW9GNfudRYGFjp/1Jl
 YqCpLAra8IlDWVvbwZhgw2GZpXszkV2PrSrqxzOKPUhGtFaVAtoCb1WKZgLALKYxOxsF59wYWvg
 /ArLEef2Uz4VDccnQCAnS0bTed6rJBu+JdH9JnGaEvd+cQ6pWmantG5oLNkFHmkO4Z0tz1upCqF
 ekOTnLt5QPeZNxAAd9oFsyLa2zkS6tvpgYwS5tHxgmnQN1ER
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
 drivers/net/Kconfig       |   8 ++++
 drivers/net/Makefile      |   1 +
 drivers/net/ovpn/Makefile |  10 +++++
 drivers/net/ovpn/main.c   | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c5c2e2c127877a8283793637b0e935ceec27aff..599e821b64131e0b63f5f14be1a62e9ff570063a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18130,6 +18130,14 @@ F:	arch/openrisc/
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
 M:	Aaron Conole <aconole@redhat.com>
 M:	Eelco Chaudron <echaudro@redhat.com>
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 271520510b5fc6866bbf4fc6a0d728d110e6b5e4..5fbe25ae1e11e558aa9aaa857cf110127e459854 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -115,6 +115,14 @@ config WIREGUARD_DEBUG
 
 	  Say N here unless you know what you're doing.
 
+config OVPN
+	tristate "OpenVPN data channel offload"
+	depends on NET && INET
+	depends on IPV6 || !IPV6
+	help
+	  This module enhances the performance of the OpenVPN userspace software
+	  by offloading the data channel processing to kernelspace.
+
 config EQUALIZER
 	tristate "EQL (serial line load balancing) support"
 	help
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 75333251a01a87e18d6c1bc9eec97b96b571b77b..73bc63ecd65ff45c9458a31d7f67447b37e18cdb 100644
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
index 0000000000000000000000000000000000000000..876800ebaa21a5f758ddf60f637801710437f70e
--- /dev/null
+++ b/drivers/net/ovpn/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# ovpn -- OpenVPN data channel offload in kernel space
+#
+# Copyright (C) 2020-2025 OpenVPN, Inc.
+#
+# Author:	Antonio Quartulli <antonio@openvpn.net>
+
+obj-$(CONFIG_OVPN) := ovpn.o
+ovpn-y += main.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
new file mode 100644
index 0000000000000000000000000000000000000000..e816e8fbbfeff1086a55c858b1941b7d82d7aba6
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
+static int ovpn_newlink(struct net_device *dev,
+			struct rtnl_newlink_params *params,
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
+MODULE_AUTHOR("(C) 2020-2025 OpenVPN, Inc.");
+MODULE_LICENSE("GPL");

-- 
2.49.0


