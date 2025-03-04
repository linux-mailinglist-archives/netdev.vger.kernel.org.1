Return-Path: <netdev+bounces-171436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C6A4CFF9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06763AD4DC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6CA481A3;
	Tue,  4 Mar 2025 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NsmqHn0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08811CAF
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048472; cv=none; b=uJTEokOFrcpUyV+nS4HJDonrEpx5oS3zVHJXCPe9tlxomyyXix/yeMYsXau1tG0YrKFNk6HvuxpNkuJt/mQ7UlHSmViopsyX9m0EAcft9wfltN0cIB56qBVAWzLlxUY3lBWrJ0kHJTrR4sW0pLZMvOIZsDQLfTEoIWHw5VzEs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048472; c=relaxed/simple;
	bh=LpjOQ2tRzlOG8HNUiXbYbnRagyaMkmcP838UEU360XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAsjqVUvE9ahVi73JP6+GZ/4KDKBCUu6uivHwtR624bpjWZqeLmDlrg0Gtkk7CCjIvoPmMR1rtbbkNzcnJMvxMTQkKXDBTNS/XXlMrB4JAsWFgQVmj7O8y/nDi5KDH5ai4cbtT4XWZZ+KaDaZ6KxoI3i+Wwss8xIk+9SALmT1SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NsmqHn0N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4705797f8f.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 16:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048468; x=1741653268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ySEldS6Rwsy/mZlylLMkoOhEgTMlnQVDP1zMklqIeU=;
        b=NsmqHn0NvahueBkCtmvGq6Ehb3PGpkZ77VuThJzu5a1Wd8HJrE7icb/qytZVysrhBk
         zhb6zZR0TXw4pmoYCNlY1JTkpmtVXwhwnExBxxehFFdl1+nbv/qp8UhK02qY7LVQ/63f
         EwEwFrRFrcb4z7kYBKGpNuUhMAQisOTQ0ZX6x1FNAy8RuTaSFnc+i9XxxaW+YDOdPJ77
         nBQIK71DnNiNEVBHjS1/TGZz3BcK0W+Jv3Lu+6GLBAOv4jRUsAR5iJISlqvqBg2MjLtB
         v10c+er/OGYlThCkCqZraXI1QUArajsY5KmBQtY8NWrfU7NlVXtCEl8K1LgraFQvLkfh
         XEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048468; x=1741653268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ySEldS6Rwsy/mZlylLMkoOhEgTMlnQVDP1zMklqIeU=;
        b=jsEwFtkqFRMrxVHkOTuVBmbXhpqXxqqLaHJimsgIvrl9kk8EJ8hFx6HZKpwsb2uuxn
         HCu3MMqu93XHarCaBMIz5TIifVpAsOcIMnbVbFR43q/qR+QAmm9k3AP8t6aQqwcLbEYj
         kzqk/PSvUFzNOBD69V/Yf2AUYOL+fyqIsaku5oeZeIJ9IFVufcFYN6UaME01v+CIVhct
         Gl7N9eX5/yrbhXBFf6yGgltBQ7qnaYU/DcK5mLeuEEcZZA1NDKUfSnUCJ8l0vBmpb+HZ
         Xwl8ECbhFSK1B2+NaranzcFfv7HBjxsrnBbPnzCaTNsC7IOdTAI0TVmQkbfgeNTLtZV7
         qa+Q==
X-Gm-Message-State: AOJu0Yw6qPkgjOQqrhU57WQiy0hCWRrtSDlF3pYYp9mnPNPSEnO7lfqW
	tq0dAEXApvBdcCMvOz9/oYFnwWPqjaNI0Mkda0vNGB3/5KaDINUOGSpg42xRkmM=
X-Gm-Gg: ASbGncv3Ot4wPj6URr1VXBmBltV9whzT/nB7P21H7gtI5kv94788lE0TzqwzwuF6jtS
	aXaVjJGOILIcrcOVy3uhmRA7B6JpJ+MyhxrqrvEKEj6KDbGIS0nWhpnkll7yjDVqCnQlPebp0Pi
	Te+IX3giYDRjnV5uRr1kT5Bkbuij+ugmQ2vAKFTYftq2mVG7SldYGXBXJooIdd2NWYCm7151qno
	4NachGJP/geBz0gdhjk+G6lv2NEUnHy1jbNJPwXjybgBV4fRMIuZkQMxr/b+WjJWyZgKPztnLeT
	d/a5degJmCyPixMPNYVNpNPPLettiWtARZ9fEQQ6Sg==
X-Google-Smtp-Source: AGHT+IHxTJC3JOXNUkwkqFK8GNViVsGWvJOLwoX0cWqU91lOp2zGoOA2iQbRhdSIuk98AItUrdLmWA==
X-Received: by 2002:a05:6000:1543:b0:390:ef45:1a37 with SMTP id ffacd0b85a97d-390ef451caemr12408568f8f.55.1741048468084;
        Mon, 03 Mar 2025 16:34:28 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:27 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:31 +0100
Subject: [PATCH v21 01/24] net: introduce OpenVPN Data Channel Offload
 (ovpn)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-1-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=LpjOQ2tRzlOG8HNUiXbYbnRagyaMkmcP838UEU360XE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqO4N82GoBRWeeWhkcCsEJ9cyLiYL7AsyCUR
 AdQStdwh9mJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjgAKCRALcOU6oDjV
 hxcUB/9Tld55AqcnOeqUhKTZAvyCdNgiw0rN1d/zKU/3qUuXMNUtVifulu87OOURE9hsb+62hgX
 EI4j5iUsapXohlXOBzU6Dv5WgjUhF9iCvJQVUJe3VFtm6gKcmcK50W4HV4kEa835yJAPbutzdc2
 hyChrsR2xZ2g9skGvp4dxKvNN9Y5CUmirhHwPSH2KEbbP4c74BENvzXLqljIaH5UsRGUDSPAT3e
 fW7FuDHlZ/7JoPpJGC0D4xG2f5fQkGJV6Cq8U0aYtFM4wAfuwFe5n/m8qf3HErsBWElpMezFd2Q
 VXwTOHWuAwVgwBPIztcUJ8CSRS0G0+8MI8sR9k+kM85aPU10
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
index 7078199fcebf2d22bc722f0f7654e98f7b94fa6c..7a96fd7ac9bcf09a81542a69e7d8b9102a31c4e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17749,6 +17749,14 @@ F:	arch/openrisc/
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
index 1fd5acdc73c6af0e1a861867039c3624fc618e25..2ace5e27c37ed3bad2e0000775cd172cb6de3225 100644
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
2.45.3


