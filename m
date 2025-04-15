Return-Path: <netdev+bounces-182700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E2A89BD3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5157D440B48
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722DC2918E2;
	Tue, 15 Apr 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Mn79UTy3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46029114B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715850; cv=none; b=lPF7aC6pXHiA9gE+TisXdKi5aqPmbYSSotaxpe7WVIW7dsw0pUihXCrXuQJRY82ixbYZXAHeF2R0eZ5UhQbEAvB5IcwIgiiZASv4Hl7mSvGYLxTK/GXo4NVVqnKG0eu6eJ+miG9AYZySTLjagW/I5Y5TT8WBMrwFjZo6GT07LnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715850; c=relaxed/simple;
	bh=+sdUNBYAIaOPKO7/M/Re2Rd/06mEdrQrQD3O5KXjTaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOm/rIvMMmIJ4BRKrUuuV53GMnnPkmf+q7yuL9rQA/vaAUgdVQHGJeojBAW3xrzvNBgPxwvGmM2fZceRLrHf5nje29/4t3vLae0U41KlSZjvEHvic7r54G69ShbMUz4pp8pYxruGq2F5r0sYHXy891mouFKwg94JAHEu0fGNd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Mn79UTy3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3467197f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744715846; x=1745320646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3Mem/u9ngNOMSXPpHg0rOlZxWoz94Gysx025QaiVhE=;
        b=Mn79UTy3pxKa7/W3gz3RT7az/0IYdAG+9ihv7e0HvRNhagQ1Q/EtzmnCYmU5H3gZyk
         JTTWGN4/0I7VTdypfpnhCXNi6uIgnHrnR7pCiipZ/SoJRw7j+OS3tyhbrPVcj56QrpeM
         QZyStu29Bst5L0gpR6/5OwH+dCwsNfgmjXMNgXHMwRMP6NcrOEJVaJui5YRpdTbQE6tc
         3rz+fTvf3BcWoROFDcI72RsJBGTg0yNBbdtqCYl4+m3ljKO1bxbf9K485YNYeVVqJmoh
         ScR7PkT5LfZ3uC4wBz6ScEiE9IGeJcYGZkJl2E/UOxfzS86RB+CLbIySczIH/vvMi4NW
         fFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744715846; x=1745320646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3Mem/u9ngNOMSXPpHg0rOlZxWoz94Gysx025QaiVhE=;
        b=L5il65eCyVKnGiZPQw1apmd1tUR0YLNzztBoXa7PcCyEFGyWIa8SWSUeV3Jbc8wEZA
         CEw3WU8yZk56Rtj709cIZZjLAV5WSdhLMx8EOJqnSvrCUSioODQOjSaAlO1XN9d3r5e9
         IaHqAgZYax6wCWW2Bct1Yt4IB8CpG7klgnDXPFHOp20wZi1jaAzpLNtBLJARoW0By1af
         m8ervOIoOkCZb068/Y6kQse7W4PL3kWacBMMfUjiD1MUc6ZWv+lw/xFqnUgMGMzwBVuh
         EEjVIIHXj20cFvUQPPnzE0/66YDX5YREu1Bus0URhTcOThrkCnfZtzHr781y2osiEU/8
         Tslw==
X-Gm-Message-State: AOJu0Yw6kCnzfdvFWjTRa6FHxsKHH5TNhf/+OU5AIlXBKZWwMLeCsKXQ
	si4MY3Z+YMjdxnhE/pjkSz5nJWDH216yKX5KDsvd/iBI2HavyQpTg8LtG7GTqJIcnSGTGKvBL2k
	n/EZc2FyI4fD7SZvbmTyGhcsGj9g1L8qGSz8Ajh2mGmrzwX8=
X-Gm-Gg: ASbGncvSp8X1x9QtHudiyrnwd6Jtz0yjsAHzODl5veN9nVLWAx9OwEuuyAZtiZ0U7Qo
	dI7gwVnvR3OaWD1bV4ucFI8VlekVzexwOc10L/VHWpoK1eLsC9+GZKBrEaZ+4cxDmsrCxW5MIZj
	MU5j2sv/qXZ5vVGe2KO5Do45Sx1Et4uK0HsVNZi5AGOrF74a5g3XqoIo3S6ieT4l3/8o/hR16A8
	+mLyajbt/tTZMcHKugk+ImbLK8TAeTUFfAl8mYiLjo6kqPE0NN8MP52+rWhcoob/9D+NXvDkmEz
	3AD729LibGz3gIVnBDacupkPPYPLryDfnwA8y+Px77jGDyZJ
X-Google-Smtp-Source: AGHT+IEXRW4m6izOB+65hbWIIVmzVu6In3hyug9OS3P5k8LIBFCajnpODOm4PVSbrunAlFdl8Q3Z3w==
X-Received: by 2002:a5d:6daa:0:b0:39c:310a:f87e with SMTP id ffacd0b85a97d-39ea51f59eamr13884142f8f.16.1744715845909;
        Tue, 15 Apr 2025 04:17:25 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d26bsm210836255e9.22.2025.04.15.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:17:25 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 15 Apr 2025 13:17:18 +0200
Subject: [PATCH net-next v26 01/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-b4-ovpn-v26-1-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7427; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=+sdUNBYAIaOPKO7/M/Re2Rd/06mEdrQrQD3O5KXjTaI=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn/kBByUR6q2+HMwb9r98ZMcuzw3sfD3/mJm2z8
 ayNee1Gi82JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/5AQQAKCRALcOU6oDjV
 h601CACfYxNgV/JgNxiU125KmJ63E6nkaBxJjuXOoMRyi7qw0gDu/0jIja5Ss7/TgForHJ/D5Ur
 0gr+kVi9A2Xolu6AGA+5PfUiU5CvXVlyHyunLezPiZczLCTlXZkNSI7yty1YrJ8ZPOwlyCXgk6u
 0AOsxtSPv0X96HE3zfT5AUxliPOul2JBlnxq6A80sD/6GuEq/LVwawO/Og25cN783Ps11YEfDI5
 o+tIoF8W6iGGHm2JB/iGyx1VRENPkpO94EhAYKRUTRJJbkdcROdjILvUqQqntTjnph71dAxX0LG
 h7eBu0qPs8TUg/omGhMLyDzmAB4JWJRVaQLQCRQSIbQNnrz3
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
 MAINTAINERS               |  8 ++++++++
 drivers/net/Kconfig       |  8 ++++++++
 drivers/net/Makefile      |  1 +
 drivers/net/ovpn/Makefile | 10 +++++++++
 drivers/net/ovpn/main.c   | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1248443035f437b903dafa739cf0cea30b71f785..d0d77f43c5af370a895b1056f21988daa0389c78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,14 @@ F:	arch/openrisc/
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
index 0000000000000000000000000000000000000000..d5d4ac8da6d78e18960e18cd5f8d522185900542
--- /dev/null
+++ b/drivers/net/ovpn/main.c
@@ -0,0 +1,52 @@
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
+static int __init ovpn_init(void)
+{
+	int err = rtnl_link_register(&ovpn_link_ops);
+
+	if (err) {
+		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static __exit void ovpn_cleanup(void)
+{
+	rtnl_link_unregister(&ovpn_link_ops);
+
+	rcu_barrier();
+}
+
+module_init(ovpn_init);
+module_exit(ovpn_cleanup);
+
+MODULE_DESCRIPTION("OpenVPN data channel offload (ovpn)");
+MODULE_AUTHOR("Antonio Quartulli <antonio@openvpn.net>");
+MODULE_LICENSE("GPL");

-- 
2.49.0


