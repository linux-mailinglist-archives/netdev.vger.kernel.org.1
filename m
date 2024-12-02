Return-Path: <netdev+bounces-148117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C301C9E0658
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829C3283A28
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED9208969;
	Mon,  2 Dec 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="G9O3OVrs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6CE205AA8
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152083; cv=none; b=Dn00cZSQZs6UKNEN78hcvsBz20Laq+Cvvdm8k4hEUWTZGm7EmgtYq03C+DbQgq4b665lSTPA8cSjTjGNXdtAeigaHs0y3Pfakglls8CIGCs6wmoLBi5w/6x8oU9paG1LhygUwgDs1/dolTPHeGNAyRQl4wS0Ip+FjBI3SmAqyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152083; c=relaxed/simple;
	bh=8aJ3PfQubjODk4QdgG6fySgSnEM3R8Ru+ZvI0tMVZEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcFzQnz+YhrEP1B/8HvLdzG1rzBIP0gbfJPk2D781OoWPEKFzqoxuUXJv5eFHKo0/A2dR3qSKnMeGwMh/BM4xJtfJIKBYjiKJPMS0yrZ2s7Muv/xlvBUV9EgcJazg9SulhxU/RitLQCRVoXj38oiqPiCXKBlQzkLCVS6crukT70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=G9O3OVrs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso3505142f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152079; x=1733756879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZNS2/ZN6evv6701XGrZ2MdmYKbPXjFP4nK7Mh9RrRY=;
        b=G9O3OVrsY8IhVYK46RKQBE1v3qfiYCUgym2X34tFnuX3whxrl7Ev00UlxsrPw0TYO6
         1AaPvljzN1f1xNShNwXeQvyDXN3BoaHNifpOwVs2QL3sVbth6RFayHBFQaGl4sjifSga
         r5D8QL4yCmT+ZgEkU+4dAo8v4kZIb05fcLxiNH4GNO/YpLv4WsMAAAbl2FFMg26lgZBA
         tEtneC3v3e9ljT1uxpus2qz4R66piunz7hcElap5QNZttEidI66euyyKWWkezEXL8GR7
         v2/EDJ/bWdKX8nsg9ippiPYzsdDrcZ8ZHyjYuo3m59DHNnNu5Q/bLmFlOwWUKIMVvGq7
         3ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152079; x=1733756879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZNS2/ZN6evv6701XGrZ2MdmYKbPXjFP4nK7Mh9RrRY=;
        b=wrCzpNtR1oCgmWlg0L2sx7Nig6ZJQF0sNgTqIdz6XSrOxjxBR2970ZHpKuWPNG6XWE
         rc35z0ylvATyiNGcK3kygup+xFR+l79uW0bI8zIUTfOBjhBs70bJABzNft69AsoYgdss
         5LWlpqsSGMPhlmn6nhlcn0bSJ0ST4DOMPohXRYKSuUDrXb2Ld3H1uE0j4v6q/cUaGkMm
         MuY337aKyuV8pZmrWAfHD2f4Ts7W/oU3ON3mplLkIWqr6zd64JBApmnjH8luvELezbjA
         8ou09L/Po5aM9Y5230W6M92coXWEG65xKloM641PabMejJyzbQiPsud3uzWspHaNID4d
         Qpyw==
X-Forwarded-Encrypted: i=1; AJvYcCUqQQcAbm7YxBqEyvqsRxf3iPhtfqKnI7rzsnA2CexTz5Oik21fB40ZuyJv/uzjjDiiPRiphmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5NaHtN6fPor1rM57qU+5wzVihOusyaL8znoqQBjG6hzDd/vu
	oUA1UGFojCrTLEfFbDf8LoELVf+JP7KVYSUZ78rMwVRX/kXE4t6S1569x/2K9lg=
X-Gm-Gg: ASbGncuVJOy8nlZZBOd53N2y0uKpGEXx4SowjuYxvL+Z/XORNmLMN+Vb5kARvNPWbm4
	PHws+DxPjoh0z6bSDG5sqf9Z1c//ZTDn6dm6wQp6y7XvW3gKjyGekuvZ+bET40EkA+edYoS1i8L
	S1Tv6IASytAYR31CHUt1mwt83qQ6jydLK1OMt89Bfo1J+gr2Kpw8XqtBF5IGbTZNccJ1CP4wibl
	V/xdD2Y+AGmI63r0yPhGx+OaC7Qg+q2pNYcZDS40br7h5VuUJ53W+rNiNl8
X-Google-Smtp-Source: AGHT+IHSnqLJQu2Fp+dL3jkAzAIGSEWl/u2QnuAX+3XIpqNEtUiiayDht5OnE7pH7RFTb2/MBsIdeQ==
X-Received: by 2002:a05:6000:18ac:b0:385:df59:1158 with SMTP id ffacd0b85a97d-385df591402mr17446395f8f.53.1733152076487;
        Mon, 02 Dec 2024 07:07:56 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:07:55 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:21 +0100
Subject: [PATCH net-next v12 03/22] ovpn: add basic interface
 creation/destruction/management routines
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-3-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9741; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=8aJ3PfQubjODk4QdgG6fySgSnEM3R8Ru+ZvI0tMVZEc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1lE7nOaSqmbATxbL2jm1JxfRk4485d9TBfw
 BvepeKY2GCJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZQAKCRALcOU6oDjV
 hynGB/9stphzTwMV8HRudFyL9j7rZsNxIt8lHRL0gWcVF5fjnPEKSD0oxa0IxGlCangCKkh4Ed0
 6Yvl6bTlzveKg6arEhnKNN9GQ0KT0eok6rczLs867PKuNAX0L3INb1aIDxLfd7j6XDrXRB+vRmt
 kSCnfUVWEoVTbP0qD3HZYhRsM8WAZ99M3rtOYZU0Zmg2D3UxYit7mPAlQsJ33mUeocLY2gwM7P7
 sWrKrbDB9Bz0BCyulRxeGbqoJ0Nj9EqjmySomLA+JrySEWqQDyBOnjGar3w4LxEY3o9OJ0yTCXI
 qLzYEn10yDHOTyVdLyNb3z9IFQ8j3p/4Kyk/6AtjLk9TTlmM
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Add basic infrastructure for handling ovpn interfaces.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile     |   1 +
 drivers/net/ovpn/io.c         |  22 +++++++++
 drivers/net/ovpn/io.h         |  24 ++++++++++
 drivers/net/ovpn/main.c       | 102 +++++++++++++++++++++++++++++++++++++++---
 drivers/net/ovpn/ovpnstruct.h |   6 +++
 drivers/net/ovpn/proto.h      |  38 ++++++++++++++++
 include/uapi/linux/if_link.h  |  15 +++++++
 7 files changed, 203 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 19305a39e57eede2dc391aa0423702c5321649a6..201dc001419f1d99ae95c0ee0f96e68f8a4eac16 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -8,5 +8,6 @@
 
 obj-$(CONFIG_OVPN) := ovpn.o
 ovpn-y += main.o
+ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
new file mode 100644
index 0000000000000000000000000000000000000000..ad3813419c33cbdfe7e8ad6f5c8b444a3540a69f
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
index 0000000000000000000000000000000000000000..a90537e9af6c0d2f38da229bdc2d8c639f2d11d1
--- /dev/null
+++ b/drivers/net/ovpn/io.h
@@ -0,0 +1,24 @@
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
+/* DATA_V2 header size with AEAD encryption */
+#define OVPN_HEAD_ROOM (OVPN_OPCODE_SIZE + OVPN_NONCE_WIRE_SIZE +	   \
+			16 /* AEAD TAG length */ +			   \
+			max(sizeof(struct udphdr), sizeof(struct tcphdr)) +\
+			max(sizeof(struct ipv6hdr), sizeof(struct iphdr)))
+
+/* max padding required by encryption */
+#define OVPN_MAX_PADDING 16
+
+netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
+
+#endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3475dab4b40f3edd882e05dbdf8badd03d7c78a3..60954c5b2b9254db1d24d01ac383935765c7ce5b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,14 +10,42 @@
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <net/ip.h>
 #include <net/rtnetlink.h>
-#include <uapi/linux/ovpn.h>
+#include <uapi/linux/if_arp.h>
 
 #include "ovpnstruct.h"
 #include "main.h"
 #include "netlink.h"
+#include "io.h"
+#include "proto.h"
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
 
 static const struct net_device_ops ovpn_netdev_ops = {
+	.ndo_open		= ovpn_net_open,
+	.ndo_stop		= ovpn_net_stop,
+	.ndo_start_xmit		= ovpn_net_xmit,
+};
+
+static const struct device_type ovpn_type = {
+	.name = OVPN_FAMILY_NAME,
+};
+
+static const struct nla_policy ovpn_policy[IFLA_OVPN_MAX + 1] = {
+	[IFLA_OVPN_MODE] = NLA_POLICY_RANGE(NLA_U8, OVPN_MODE_P2P,
+					    OVPN_MODE_MP),
 };
 
 /**
@@ -31,16 +59,69 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_setup(struct net_device *dev)
+{
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
+				 NETIF_F_GSO | NETIF_F_GSO_SOFTWARE |
+				 NETIF_F_HIGHDMA;
+
+	dev->needs_free_netdev = true;
+
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	dev->netdev_ops = &ovpn_netdev_ops;
+
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->mtu = ETH_DATA_LEN - OVPN_HEAD_ROOM;
+	dev->min_mtu = IPV4_MIN_MTU;
+	dev->max_mtu = IP_MAX_MTU - OVPN_HEAD_ROOM;
+
+	dev->type = ARPHRD_NONE;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	dev->lltx = true;
+	dev->features |= feat;
+	dev->hw_features |= feat;
+	dev->hw_enc_features |= feat;
+
+	dev->needed_headroom = ALIGN(OVPN_HEAD_ROOM, 4);
+	dev->needed_tailroom = OVPN_MAX_PADDING;
+
+	SET_NETDEV_DEVTYPE(dev, &ovpn_type);
+}
+
 static int ovpn_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	return -EOPNOTSUPP;
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	enum ovpn_mode mode = OVPN_MODE_P2P;
+
+	if (data && data[IFLA_OVPN_MODE]) {
+		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
+		netdev_dbg(dev, "setting device mode: %u\n", mode);
+	}
+
+	ovpn->dev = dev;
+	ovpn->mode = mode;
+
+	/* turn carrier explicitly off after registration, this way state is
+	 * clearly defined
+	 */
+	netif_carrier_off(dev);
+
+	return register_netdevice(dev);
 }
 
 static struct rtnl_link_ops ovpn_link_ops = {
 	.kind = "ovpn",
 	.netns_refund = false,
+	.priv_size = sizeof(struct ovpn_priv),
+	.setup = ovpn_setup,
+	.policy = ovpn_policy,
+	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
 	.dellink = unregister_netdevice_queue,
 };
@@ -49,26 +130,37 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ovpn_priv *ovpn;
 
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
+		netif_carrier_off(dev);
+		ovpn->registered = false;
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
diff --git a/drivers/net/ovpn/ovpnstruct.h b/drivers/net/ovpn/ovpnstruct.h
index b4e37e922fe5a5659e030174f1e42b3935967ca0..312bc22199383fed0746335fde3339646bb68b2b 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -11,15 +11,21 @@
 #define _NET_OVPN_OVPNSTRUCT_H_
 
 #include <net/net_trackers.h>
+#include <uapi/linux/if_link.h>
+#include <uapi/linux/ovpn.h>
 
 /**
  * struct ovpn_priv - per ovpn interface state
  * @dev: the actual netdev representing the tunnel
  * @dev_tracker: reference tracker for associated dev
+ * @registered: whether dev is still registered with netdev or not
+ * @mode: device operation mode (i.e. p2p, mp, ..)
  */
 struct ovpn_priv {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	bool registered;
+	enum ovpn_mode mode;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
diff --git a/drivers/net/ovpn/proto.h b/drivers/net/ovpn/proto.h
new file mode 100644
index 0000000000000000000000000000000000000000..00bb3725ac7ab7040c97eb012c2639b2d6967de1
--- /dev/null
+++ b/drivers/net/ovpn/proto.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ *		James Yonan <james@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_PROTO_H_
+#define _NET_OVPN_PROTO_H_
+
+/* When the OpenVPN protocol is ran in AEAD mode, use
+ * the OpenVPN packet ID as the AEAD nonce:
+ *
+ *    00000005 521c3b01 4308c041
+ *    [seq # ] [  nonce_tail   ]
+ *    [     12-byte full IV    ] -> OVPN_NONCE_SIZE
+ *    [4-bytes                   -> OVPN_NONCE_WIRE_SIZE
+ *    on wire]
+ */
+
+/* nonce size (96bits) as required by AEAD ciphers */
+#define OVPN_NONCE_SIZE			12
+/* last 8 bytes of AEAD nonce: provided by userspace and usually derived
+ * from key material generated during TLS handshake
+ */
+#define OVPN_NONCE_TAIL_SIZE		8
+
+/* OpenVPN nonce size reduced by 8-byte nonce tail -- this is the
+ * size of the AEAD Associated Data (AD) sent over the wire
+ * and is normally the head of the IV
+ */
+#define OVPN_NONCE_WIRE_SIZE (OVPN_NONCE_SIZE - OVPN_NONCE_TAIL_SIZE)
+
+#define OVPN_OPCODE_SIZE		4 /* DATA_V2 opcode size */
+
+#endif /* _NET_OVPN_PROTO_H_ */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2575e0cd9b482e78984ca6528dd7d4a24f03e290..9914f8963060ba6db56fc379c3016458002bc93f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1976,4 +1976,19 @@ enum {
 
 #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
 
+/* OVPN section */
+
+enum ovpn_mode {
+	OVPN_MODE_P2P,
+	OVPN_MODE_MP,
+};
+
+enum {
+	IFLA_OVPN_UNSPEC,
+	IFLA_OVPN_MODE,
+	__IFLA_OVPN_MAX,
+};
+
+#define IFLA_OVPN_MAX	(__IFLA_OVPN_MAX - 1)
+
 #endif /* _UAPI_LINUX_IF_LINK_H */

-- 
2.45.2


