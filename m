Return-Path: <netdev+bounces-77131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B78704DD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703622866D4
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2176C47F59;
	Mon,  4 Mar 2024 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bWZ8ss4R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349845C1C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564945; cv=none; b=Uo/68f5atRb72pQHBqFt7Kx+t6MqRoPvEMFiQ6Wn6YNGNoS/Azb5NR2Zg0jyaeatmk90pWrUlHFxoZ/nQ+x9KZPaP4ktAIp9Sn10vpjS0whEPzxkSmMZ/m91cNenLwlyPchKBhnhHlIARhUG6ZMavGS5bHbW6nqu0r4npMSkmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564945; c=relaxed/simple;
	bh=ZcEqLE/I2egWgLBrpMjltpTiwCypzImBK7nWy+2P8Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp3M+Q0ZUW0eHnijd97LyYKB29Wkf0oGv09x7o47bmbVOy0C8XMHz0uoDUKzLPLk1PwPfdm1wIi1cXpw+4XFgg5mlw3jaorzRkn9zpfRXZRs0bvuLz9fs9WYbfWi/VROIpBMyG1HWKg/HRjuXipHep/eErYHYf9/tA91CoK3eck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bWZ8ss4R; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36126ee41eso700201366b.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564941; x=1710169741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qfulve2RLjNeOP22Z6WHnv/Qiw7P1DNJvkthojvc+Q=;
        b=bWZ8ss4RQ3uq/3TAJHdQaEndyBR1rfVRXCTRCkn8SoS+CH0BHI9JUntxsBY0CtQ+8l
         zC/TuFyCkiaoUPhQpVbfyKB5H6Nh4MPP98+Ax6MbeARWCccTfAh+rzaRcYsky5f2H26W
         52sYkfWyuDDVEpfb53qR6TYYQ7BLWrtPbELr3GLjzlDpps62w+OT9HHYHVP+Dm+v+u7k
         BOQUwEtzZZjXXu4kBOqxwJixSGivCn1taQNA5r29YZIZI6vZg131WTWcg0I3ML4Nqyyx
         nbw9nIRdKO8OPs8SyfH+U33H3JYgMGTTU+QTTaSSl+JS0u64DYtTZMuJ4mm7XB97CmG+
         09Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564941; x=1710169741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qfulve2RLjNeOP22Z6WHnv/Qiw7P1DNJvkthojvc+Q=;
        b=Nb+1Aazyyg3Acz3d21cYZUOofuRWoYfENvHvsDozp/X7opTwC69T4elQ/ClQ+mTcIr
         RHziMUnUIngV5lIfsM5VfSNUBcLJ1zqMBe7E+WpV+YEuafWVIv2uYviB2viAn1tjVJY/
         wi64EFVeS/zoEeMvYA462QecILY/ioH7u0GC+71Il18/rAPYAneQYxM73vgknwlZmt7i
         Mc+obuq77E0RruYsw+V8t8QPqZv9KGgLB3nUO22sxYLjf4ACY1UAHGRSZ9vi61N5AY7J
         B/zStpNItvf+E86z1IsfNZxgwICuLTRcJGt4CfPBtVtzp1VIyjixVN4AxKuxXAC2NHY7
         StvQ==
X-Gm-Message-State: AOJu0YzxLUUbgyUzayR0Ht2Jy0DMRC+XE0KlWFOCZFlBFS5FRrolUuCl
	dN+e8/tjOe+30VamD+Xsp6KvAThEcjOmFs8rAcMW1VzFjggfHk9PNM+pMXrfxNKgR4x8c6j281g
	DpqI=
X-Google-Smtp-Source: AGHT+IGyHsEOugtlxgGzr2vgoyPjgGrlB8QfRzux90fm3aFI4o1NUJRt2YGse4SsBotJvCQGqM/nbg==
X-Received: by 2002:a17:906:f0d0:b0:a44:4fbd:a8fd with SMTP id dk16-20020a170906f0d000b00a444fbda8fdmr7032133ejb.10.1709564941280;
        Mon, 04 Mar 2024 07:09:01 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:00 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 04/22] ovpn: add basic interface creation/destruction/management routines
Date: Mon,  4 Mar 2024 16:08:55 +0100
Message-ID: <20240304150914.11444-5-antonio@openvpn.net>
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

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c         |  26 +++++++++
 drivers/net/ovpn/io.h         |   1 +
 drivers/net/ovpn/main.c       | 107 ++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/ovpnstruct.h |  16 +++++
 4 files changed, 150 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a1e19402e36d..b283449ba479 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -8,11 +8,37 @@
  */
 
 #include "io.h"
+#include "ovpnstruct.h"
+#include "netlink.h"
 
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 
 
+int ovpn_struct_init(struct net_device *dev)
+{
+	struct ovpn_struct *ovpn = netdev_priv(dev);
+	int err;
+
+	memset(ovpn, 0, sizeof(*ovpn));
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
+	err = security_tun_dev_alloc_security(&ovpn->security);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /* Send user data to the network
  */
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
diff --git a/drivers/net/ovpn/io.h b/drivers/net/ovpn/io.h
index 0a076d14f721..e7728718c8a9 100644
--- a/drivers/net/ovpn/io.h
+++ b/drivers/net/ovpn/io.h
@@ -14,6 +14,7 @@
 
 struct sk_buff;
 
+int ovpn_struct_init(struct net_device *dev);
 netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev);
 
 #endif /* _NET_OVPN_OVPN_H_ */
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3769f99cfe6f..1be0fd50c356 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -10,15 +10,20 @@
 #include "main.h"
 #include "netlink.h"
 #include "io.h"
+#include "ovpnstruct.h"
+#include "packet.h"
 
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
+#include <linux/lockdep.h>
 #include <linux/net.h>
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <linux/version.h>
+#include <net/ip.h>
+#include <uapi/linux/if_arp.h>
 #include <uapi/linux/ovpn.h>
 
 
@@ -28,6 +33,16 @@
 #define DRV_DESCRIPTION	"OpenVPN data channel offload (ovpn)"
 #define DRV_COPYRIGHT	"(C) 2020-2024 OpenVPN, Inc."
 
+static LIST_HEAD(dev_list);
+
+static void ovpn_struct_free(struct net_device *net)
+{
+	struct ovpn_struct *ovpn = netdev_priv(net);
+
+	security_tun_dev_free_security(ovpn->security);
+	free_percpu(net->tstats);
+}
+
 /* Net device open */
 static int ovpn_net_open(struct net_device *dev)
 {
@@ -62,28 +77,120 @@ static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_get_stats64        = dev_get_tstats64,
 };
 
+static void ovpn_setup(struct net_device *dev)
+{
+	/* compute the overhead considering AEAD encryption */
+	const int overhead = sizeof(u32) + NONCE_WIRE_SIZE + 16 + sizeof(struct udphdr) +
+			     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
+
+	netdev_features_t feat = NETIF_F_SG | NETIF_F_LLTX |
+				 NETIF_F_HW_CSUM | NETIF_F_RXCSUM | NETIF_F_GSO |
+				 NETIF_F_GSO_SOFTWARE | NETIF_F_HIGHDMA;
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
+int ovpn_iface_create(const char *name, enum ovpn_mode mode, struct net *net)
+{
+	struct net_device *dev;
+	struct ovpn_struct *ovpn;
+	int ret;
+
+	dev = alloc_netdev(sizeof(struct ovpn_struct), name, NET_NAME_USER, ovpn_setup);
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
+		netdev_dbg(dev, "cannot register interface %s: %d\n", dev->name, ret);
+		rtnl_unlock();
+		goto err;
+	}
+	rtnl_unlock();
+
+	return ret;
+
+err:
+	free_netdev(dev);
+	return ret;
+}
+
+void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
+{
+	ASSERT_RTNL();
+
+	netif_carrier_off(ovpn->dev);
+
+	list_del(&ovpn->dev_list);
+	ovpn->registered = false;
+
+	if (unregister_netdev)
+		unregister_netdevice(ovpn->dev);
+
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
 		/* add device to internal list for later destruction upon unregistration */
+		list_add(&ovpn->dev_list, &dev_list);
+		ovpn->registered = true;
 		break;
 	case NETDEV_UNREGISTER:
 		/* can be delivered multiple times, so check registered flag, then
 		 * destroy the interface
 		 */
+		if (!ovpn->registered)
+			return NOTIFY_DONE;
+
+		ovpn_iface_destruct(ovpn, false);
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
index 932eb90953e0..c2cdfd6f84b3 100644
--- a/drivers/net/ovpn/ovpnstruct.h
+++ b/drivers/net/ovpn/ovpnstruct.h
@@ -10,11 +10,27 @@
 #ifndef _NET_OVPN_OVPNSTRUCT_H_
 #define _NET_OVPN_OVPNSTRUCT_H_
 
+#include <uapi/linux/ovpn.h>
 #include <linux/netdevice.h>
+#include <linux/types.h>
 
 /* Our state per ovpn interface */
 struct ovpn_struct {
 	struct net_device *dev;
+
+	/* whether this device is still registered with netdev or not */
+	bool registered;
+
+	/* device operation mode (i.e. P2P, MP) */
+	enum ovpn_mode mode;
+
+	unsigned int max_tun_queue_len;
+
+	netdev_features_t set_features;
+
+	void *security;
+
+	struct list_head dev_list;
 };
 
 #endif /* _NET_OVPN_OVPNSTRUCT_H_ */
-- 
2.43.0


