Return-Path: <netdev+bounces-202833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C138CAEF2E9
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF291885763
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4F272E59;
	Tue,  1 Jul 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T0TUCdNy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC525A351
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361152; cv=none; b=osfu5M1/tHbL8V6FOdNCtDOP31dHJoHfvbj7De8i7AcaO2vpQoV1VaGETZXbICB4aTLIBxSVTOBOS65/HENHGlCqJdR2RBrcwY+MVD0yASpz13G/Hyubjd0iZ4xh/6wzv7cs7uGd12e5H0YNIR256zhzZu0v9yzBEjkomDPs4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361152; c=relaxed/simple;
	bh=yHKDJoD7laWufs1kIc14KN/Zp/spSV8pLZwN0NdHLNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ7A7Kg7Z0kQd63aHU1o7VnZrhM5yh5JqHgBUGnVDbhNcAqftSHbO7Kr71kAYBHj4jKHCiUsDNXPwfQAC+9VqilES5Xc/brqFkCg/c5ZF4I9bH1k5CydPLXZ1oU8alvMriIMNOQQKuGB21IIUMwCq/4/QszS+xvhKOSsk2egbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T0TUCdNy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747fc7506d4so2636977b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751361149; x=1751965949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPXzUgP2yhw1ayDkGwHNnqS4B/QCSTyOWqjyZ1UF5ww=;
        b=T0TUCdNyfm/70h1P0GQfYm/He70/EqmYy8C1zqnHRM0/qCZ/ZjFVSQCZO0kTAQYGue
         C3WQ06QSOytVfZ0YWs2NNggiOqwtyQMDfZrPy1racTXF0EKH28Cg5kkkxIBX4J7VRxBm
         FP1XmAP5bFqyCRbEt1j/lBHCuTM0vw4ZaqtiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361149; x=1751965949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPXzUgP2yhw1ayDkGwHNnqS4B/QCSTyOWqjyZ1UF5ww=;
        b=rkzRPaBpLfLnbrJt432tzDE4l4FdAtZH32ptZkAZHJDhK6OYn48stnO5QBZxsuPQ+Y
         PsxG00IuQQWmIWo4V3SHakKaLmIZg55pF8RGj2IQLZD7T8yziP1W4lz3GBiF7a+Co2Ns
         ESv76qTaKx6zOcAB/MK60hiBFCKWxmzvVJvuzG5lamI63yjTX6nyIfZSTP6aJ71ZIyL+
         6s1NAmDgr7OLYqi6Pv7uNyL4p62nzBzh9HcjioCE2OOyiBxm0IXLPxnXu4A2cuWi/0KL
         /D9I+QpeNmJwBHzNKIs03mMZvC2O/Kd0tDJUtPDHdkw5RMB4s+1N9AEKGLbx+dUx1/JB
         YUNg==
X-Gm-Message-State: AOJu0YzshPT6Mh0R+1kqWLOsBMZT1wy8EETfxxtgwHl36Zdjqq8PZFVU
	K31yjwjX266tz1mKe37PaZidnz6t0R2b7Wkr2ffO1ugVNmGYyI5Y20N72voBrA2tvA==
X-Gm-Gg: ASbGncth238GczCtuvSckQQiKaJPBdAHAwbPVEEa3B73s9F2FABvL7XuDDspOGzZMmG
	m5pn3cy2cavyLSwK9xovPlbjHaLeMqvgn8olXY8x3cbe/7X94KV9+qzrQ6corvdCoMk6UxxdGvq
	ou9I5S/CID5ZpxWIhAKEdUmbetUsYp+P7zxkAZ4VXrHtiVrzIe/XKivF9ENmDUQXFv7/VUqoYig
	n7X36zwyWASKBUlwA06eOt7SERKfhigyxe4IS/T5PTLwQd7AB6fA6oQ0gPyOpVb9sLGZSoKmGg+
	tPjAUPv0wtXz8t+nBOmGtmEuZX7X3W10Ib2pO3K6IBxLhbELvIrPlY1C9OnK8N7xtVxeV1YhUJH
	xCL6Pg32E5CmVkD/87KPWZE3AQgSpBZmbe/nyWLo=
X-Google-Smtp-Source: AGHT+IEDcE4RLNQAWy6wq7+wguO/7/Ck2/SP9eTCWAzVaV1zsDTPAJC4yUUzFNzrHGQJ7+x/8ECTKw==
X-Received: by 2002:a05:6a21:7316:b0:220:82c7:309c with SMTP id adf61e73a8af0-220a129c4a9mr28272547637.7.1751361149297;
        Tue, 01 Jul 2025 02:12:29 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e30201c1sm8893603a12.22.2025.07.01.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:12:28 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v3 10/10] bng_en: Add a network device
Date: Tue,  1 Jul 2025 14:35:08 +0000
Message-ID: <20250701143511.280702-11-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701143511.280702-1-vikas.gupta@broadcom.com>
References: <20250701143511.280702-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a network device with netdev features enabled.
Some features are enabled based on the capabilities
advertised by the firmware. Add the skeleton of minimal
netdev operations. Additionally, initialize the parameters
for rings (TX/RX/Completion).

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  12 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   9 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  33 +++
 .../net/ethernet/broadcom/bnge/bnge_ethtool.h |   9 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 268 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  | 206 ++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   3 +
 8 files changed, 543 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 10df05b6695e..6142d9c57f49 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -7,4 +7,6 @@ bng_en-y := bnge_core.o \
 	    bnge_hwrm.o \
 	    bnge_hwrm_lib.o \
 	    bnge_rmem.o \
-	    bnge_resc.o
+	    bnge_resc.o \
+	    bnge_netdev.o \
+	    bnge_ethtool.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index cef66c1e9006..a1795302c15a 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -65,6 +65,7 @@ enum {
 	BNGE_EN_ROCE_V2					= BIT_ULL(1),
 	BNGE_EN_STRIP_VLAN				= BIT_ULL(2),
 	BNGE_EN_SHARED_CHNL				= BIT_ULL(3),
+	BNGE_EN_UDP_GSO_SUPP				= BIT_ULL(4),
 };
 
 #define BNGE_EN_ROCE		(BNGE_EN_ROCE_V1 | BNGE_EN_ROCE_V2)
@@ -89,6 +90,7 @@ struct bnge_queue_info {
 struct bnge_dev {
 	struct device	*dev;
 	struct pci_dev	*pdev;
+	struct net_device	*netdev;
 	u64	dsn;
 #define BNGE_VPD_FLD_LEN	32
 	char		board_partno[BNGE_VPD_FLD_LEN];
@@ -198,6 +200,16 @@ static inline bool bnge_is_roce_en(struct bnge_dev *bd)
 
 static inline bool bnge_is_agg_reqd(struct bnge_dev *bd)
 {
+	if (bd->netdev) {
+		struct bnge_net *bn = netdev_priv(bd->netdev);
+
+		if (bn->priv_flags & BNGE_NET_EN_TPA ||
+		    bn->priv_flags & BNGE_NET_EN_JUMBO)
+			return true;
+		else
+			return false;
+	}
+
 	return true;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 24babc8b9d35..68da656f2894 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -302,10 +302,17 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_config_uninit;
 	}
 
+	rc = bnge_netdev_alloc(bd, max_irqs);
+	if (rc)
+		goto err_free_irq;
+
 	pci_save_state(pdev);
 
 	return 0;
 
+err_free_irq:
+	bnge_free_irqs(bd);
+
 err_config_uninit:
 	bnge_net_uninit_dflt_config(bd);
 
@@ -331,6 +338,8 @@ static void bnge_remove_one(struct pci_dev *pdev)
 {
 	struct bnge_dev *bd = pci_get_drvdata(pdev);
 
+	bnge_netdev_free(bd);
+
 	bnge_free_irqs(bd);
 
 	bnge_net_uninit_dflt_config(bd);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
new file mode 100644
index 000000000000..569371c1b4f2
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/unaligned.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <net/devlink.h>
+#include <linux/ethtool.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
+
+#include "bnge.h"
+#include "bnge_ethtool.h"
+
+static void bnge_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
+	strscpy(info->fw_version, bd->fw_ver_str, sizeof(info->fw_version));
+	strscpy(info->bus_info, pci_name(bd->pdev), sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops bnge_ethtool_ops = {
+	.get_drvinfo		= bnge_get_drvinfo,
+};
+
+void bnge_set_ethtool_ops(struct net_device *dev)
+{
+	dev->ethtool_ops = &bnge_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h
new file mode 100644
index 000000000000..21e96a0976d5
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_ethtool.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_ETHTOOL_H_
+#define _BNGE_ETHTOOL_H_
+
+void bnge_set_ethtool_ops(struct net_device *dev);
+
+#endif /* _BNGE_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
new file mode 100644
index 000000000000..02254934f3d0
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <asm/byteorder.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/if.h>
+#include <net/ip.h>
+#include <linux/skbuff.h>
+
+#include "bnge.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_ethtool.h"
+
+static netdev_tx_t bnge_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static int bnge_open(struct net_device *dev)
+{
+	return 0;
+}
+
+static int bnge_close(struct net_device *dev)
+{
+	return 0;
+}
+
+static const struct net_device_ops bnge_netdev_ops = {
+	.ndo_open		= bnge_open,
+	.ndo_stop		= bnge_close,
+	.ndo_start_xmit		= bnge_start_xmit,
+};
+
+static void bnge_init_mac_addr(struct bnge_dev *bd)
+{
+	eth_hw_addr_set(bd->netdev, bd->pf.mac_addr);
+}
+
+static void bnge_set_tpa_flags(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+
+	bn->priv_flags &= ~BNGE_NET_EN_TPA;
+
+	if (bd->netdev->features & NETIF_F_LRO)
+		bn->priv_flags |= BNGE_NET_EN_LRO;
+	else if (bd->netdev->features & NETIF_F_GRO_HW)
+		bn->priv_flags |= BNGE_NET_EN_GRO;
+}
+
+static void bnge_init_l2_fltr_tbl(struct bnge_net *bn)
+{
+	int i;
+
+	for (i = 0; i < BNGE_L2_FLTR_HASH_SIZE; i++)
+		INIT_HLIST_HEAD(&bn->l2_fltr_hash_tbl[i]);
+	get_random_bytes(&bn->hash_seed, sizeof(bn->hash_seed));
+}
+
+void bnge_set_ring_params(struct bnge_dev *bd)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	u32 ring_size, rx_size, rx_space, max_rx_cmpl;
+	u32 agg_factor = 0, agg_ring_size = 0;
+
+	/* 8 for CRC and VLAN */
+	rx_size = SKB_DATA_ALIGN(bn->netdev->mtu + ETH_HLEN + NET_IP_ALIGN + 8);
+
+	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
+	ring_size = bn->rx_ring_size;
+	bn->rx_agg_ring_size = 0;
+	bn->rx_agg_nr_pages = 0;
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA)
+		agg_factor = min_t(u32, 4, 65536 / BNGE_RX_PAGE_SIZE);
+
+	bn->priv_flags &= ~BNGE_NET_EN_JUMBO;
+	if (rx_space > PAGE_SIZE) {
+		u32 jumbo_factor;
+
+		bn->priv_flags |= BNGE_NET_EN_JUMBO;
+		jumbo_factor = PAGE_ALIGN(bn->netdev->mtu - 40) >> PAGE_SHIFT;
+		if (jumbo_factor > agg_factor)
+			agg_factor = jumbo_factor;
+	}
+	if (agg_factor) {
+		if (ring_size > BNGE_MAX_RX_DESC_CNT_JUM_ENA) {
+			ring_size = BNGE_MAX_RX_DESC_CNT_JUM_ENA;
+			netdev_warn(bn->netdev, "RX ring size reduced from %d to %d due to jumbo ring\n",
+				    bn->rx_ring_size, ring_size);
+			bn->rx_ring_size = ring_size;
+		}
+		agg_ring_size = ring_size * agg_factor;
+
+		bn->rx_agg_nr_pages = bnge_adjust_pow_two(agg_ring_size,
+							  RX_DESC_CNT);
+		if (bn->rx_agg_nr_pages > MAX_RX_AGG_PAGES) {
+			u32 tmp = agg_ring_size;
+
+			bn->rx_agg_nr_pages = MAX_RX_AGG_PAGES;
+			agg_ring_size = MAX_RX_AGG_PAGES * RX_DESC_CNT - 1;
+			netdev_warn(bn->netdev, "RX agg ring size %d reduced to %d.\n",
+				    tmp, agg_ring_size);
+		}
+		bn->rx_agg_ring_size = agg_ring_size;
+		bn->rx_agg_ring_mask = (bn->rx_agg_nr_pages * RX_DESC_CNT) - 1;
+
+		rx_size = SKB_DATA_ALIGN(BNGE_RX_COPY_THRESH + NET_IP_ALIGN);
+		rx_space = rx_size + NET_SKB_PAD +
+			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	}
+
+	bn->rx_buf_use_size = rx_size;
+	bn->rx_buf_size = rx_space;
+
+	bn->rx_nr_pages = bnge_adjust_pow_two(ring_size, RX_DESC_CNT);
+	bn->rx_ring_mask = (bn->rx_nr_pages * RX_DESC_CNT) - 1;
+
+	ring_size = bn->tx_ring_size;
+	bn->tx_nr_pages = bnge_adjust_pow_two(ring_size, TX_DESC_CNT);
+	bn->tx_ring_mask = (bn->tx_nr_pages * TX_DESC_CNT) - 1;
+
+	max_rx_cmpl = bn->rx_ring_size;
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA)
+		max_rx_cmpl += bd->max_tpa_v2;
+	ring_size = max_rx_cmpl * 2 + agg_ring_size + bn->tx_ring_size;
+	bn->cp_ring_size = ring_size;
+
+	bn->cp_nr_pages = bnge_adjust_pow_two(ring_size, CP_DESC_CNT);
+	if (bn->cp_nr_pages > MAX_CP_PAGES) {
+		bn->cp_nr_pages = MAX_CP_PAGES;
+		bn->cp_ring_size = MAX_CP_PAGES * CP_DESC_CNT - 1;
+		netdev_warn(bn->netdev, "completion ring size %d reduced to %d.\n",
+			    ring_size, bn->cp_ring_size);
+	}
+	bn->cp_bit = bn->cp_nr_pages * CP_DESC_CNT;
+	bn->cp_ring_mask = bn->cp_bit - 1;
+}
+
+int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
+{
+	struct net_device *netdev;
+	struct bnge_net *bn;
+	int rc;
+
+	netdev = alloc_etherdev_mqs(sizeof(*bn), max_irqs * BNGE_MAX_QUEUE,
+				    max_irqs);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, bd->dev);
+	bd->netdev = netdev;
+
+	netdev->netdev_ops = &bnge_netdev_ops;
+
+	bnge_set_ethtool_ops(netdev);
+
+	bn = netdev_priv(netdev);
+	bn->netdev = netdev;
+	bn->bd = bd;
+
+	netdev->min_mtu = ETH_ZLEN;
+	netdev->max_mtu = bd->max_mtu;
+
+	netdev->hw_features = NETIF_F_IP_CSUM |
+			      NETIF_F_IPV6_CSUM |
+			      NETIF_F_SG |
+			      NETIF_F_TSO |
+			      NETIF_F_TSO6 |
+			      NETIF_F_GSO_UDP_TUNNEL |
+			      NETIF_F_GSO_GRE |
+			      NETIF_F_GSO_IPXIP4 |
+			      NETIF_F_GSO_UDP_TUNNEL_CSUM |
+			      NETIF_F_GSO_GRE_CSUM |
+			      NETIF_F_GSO_PARTIAL |
+			      NETIF_F_RXHASH |
+			      NETIF_F_RXCSUM |
+			      NETIF_F_GRO;
+
+	if (bd->flags & BNGE_EN_UDP_GSO_SUPP)
+		netdev->hw_features |= NETIF_F_GSO_UDP_L4;
+
+	if (BNGE_SUPPORTS_TPA(bd))
+		netdev->hw_features |= NETIF_F_LRO;
+
+	netdev->hw_enc_features = NETIF_F_IP_CSUM |
+				  NETIF_F_IPV6_CSUM |
+				  NETIF_F_SG |
+				  NETIF_F_TSO |
+				  NETIF_F_TSO6 |
+				  NETIF_F_GSO_UDP_TUNNEL |
+				  NETIF_F_GSO_GRE |
+				  NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				  NETIF_F_GSO_GRE_CSUM |
+				  NETIF_F_GSO_IPXIP4 |
+				  NETIF_F_GSO_PARTIAL;
+
+	if (bd->flags & BNGE_EN_UDP_GSO_SUPP)
+		netdev->hw_enc_features |= NETIF_F_GSO_UDP_L4;
+
+	netdev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM |
+				       NETIF_F_GSO_GRE_CSUM;
+
+	netdev->vlan_features = netdev->hw_features | NETIF_F_HIGHDMA;
+	if (bd->fw_cap & BNGE_FW_CAP_VLAN_RX_STRIP)
+		netdev->hw_features |= BNGE_HW_FEATURE_VLAN_ALL_RX;
+	if (bd->fw_cap & BNGE_FW_CAP_VLAN_TX_INSERT)
+		netdev->hw_features |= BNGE_HW_FEATURE_VLAN_ALL_TX;
+
+	if (BNGE_SUPPORTS_TPA(bd))
+		netdev->hw_features |= NETIF_F_GRO_HW;
+
+	netdev->features |= netdev->hw_features | NETIF_F_HIGHDMA;
+
+	if (netdev->features & NETIF_F_GRO_HW)
+		netdev->features &= ~NETIF_F_LRO;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
+	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
+	if (bd->tso_max_segs)
+		netif_set_tso_max_segs(netdev, bd->tso_max_segs);
+
+	bn->rx_ring_size = BNGE_DEFAULT_RX_RING_SIZE;
+	bn->tx_ring_size = BNGE_DEFAULT_TX_RING_SIZE;
+
+	bnge_set_tpa_flags(bd);
+	bnge_set_ring_params(bd);
+
+	bnge_init_l2_fltr_tbl(bn);
+	bnge_init_mac_addr(bd);
+
+	rc = register_netdev(netdev);
+	if (rc) {
+		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
+		goto err_netdev;
+	}
+
+	return 0;
+
+err_netdev:
+	free_netdev(netdev);
+	return rc;
+}
+
+void bnge_netdev_free(struct bnge_dev *bd)
+{
+	struct net_device *netdev = bd->netdev;
+
+	unregister_netdev(netdev);
+	free_netdev(netdev);
+	bd->netdev = NULL;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
new file mode 100644
index 000000000000..96b77e44b552
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_NETDEV_H_
+#define _BNGE_NETDEV_H_
+
+#include "../bnxt/bnxt_hsi.h"
+
+struct tx_bd {
+	__le32 tx_bd_len_flags_type;
+	#define TX_BD_TYPE					(0x3f << 0)
+	#define TX_BD_TYPE_SHORT_TX_BD				(0x00 << 0)
+	#define TX_BD_TYPE_LONG_TX_BD				(0x10 << 0)
+	#define TX_BD_FLAGS_PACKET_END				(1 << 6)
+	#define TX_BD_FLAGS_NO_CMPL				(1 << 7)
+	#define TX_BD_FLAGS_BD_CNT				(0x1f << 8)
+	#define TX_BD_FLAGS_BD_CNT_SHIFT			8
+	#define TX_BD_FLAGS_LHINT				(3 << 13)
+	#define TX_BD_FLAGS_LHINT_SHIFT				13
+	#define TX_BD_FLAGS_LHINT_512_AND_SMALLER		(0 << 13)
+	#define TX_BD_FLAGS_LHINT_512_TO_1023			(1 << 13)
+	#define TX_BD_FLAGS_LHINT_1024_TO_2047			(2 << 13)
+	#define TX_BD_FLAGS_LHINT_2048_AND_LARGER		(3 << 13)
+	#define TX_BD_FLAGS_COAL_NOW				(1 << 15)
+	#define TX_BD_LEN					(0xffff << 16)
+	#define TX_BD_LEN_SHIFT					16
+	u32 tx_bd_opaque;
+	__le64 tx_bd_haddr;
+} __packed;
+
+struct rx_bd {
+	__le32 rx_bd_len_flags_type;
+	#define RX_BD_TYPE					(0x3f << 0)
+	#define RX_BD_TYPE_RX_PACKET_BD				0x4
+	#define RX_BD_TYPE_RX_BUFFER_BD				0x5
+	#define RX_BD_TYPE_RX_AGG_BD				0x6
+	#define RX_BD_TYPE_16B_BD_SIZE				(0 << 4)
+	#define RX_BD_TYPE_32B_BD_SIZE				(1 << 4)
+	#define RX_BD_TYPE_48B_BD_SIZE				(2 << 4)
+	#define RX_BD_TYPE_64B_BD_SIZE				(3 << 4)
+	#define RX_BD_FLAGS_SOP					(1 << 6)
+	#define RX_BD_FLAGS_EOP					(1 << 7)
+	#define RX_BD_FLAGS_BUFFERS				(3 << 8)
+	#define RX_BD_FLAGS_1_BUFFER_PACKET			(0 << 8)
+	#define RX_BD_FLAGS_2_BUFFER_PACKET			(1 << 8)
+	#define RX_BD_FLAGS_3_BUFFER_PACKET			(2 << 8)
+	#define RX_BD_FLAGS_4_BUFFER_PACKET			(3 << 8)
+	#define RX_BD_LEN					(0xffff << 16)
+	#define RX_BD_LEN_SHIFT					16
+	u32 rx_bd_opaque;
+	__le64 rx_bd_haddr;
+};
+
+struct tx_cmp {
+	__le32 tx_cmp_flags_type;
+	#define CMP_TYPE					(0x3f << 0)
+	#define CMP_TYPE_TX_L2_CMP				0
+	#define CMP_TYPE_TX_L2_COAL_CMP				2
+	#define CMP_TYPE_TX_L2_PKT_TS_CMP			4
+	#define CMP_TYPE_RX_L2_CMP				17
+	#define CMP_TYPE_RX_AGG_CMP				18
+	#define CMP_TYPE_RX_L2_TPA_START_CMP			19
+	#define CMP_TYPE_RX_L2_TPA_END_CMP			21
+	#define CMP_TYPE_RX_TPA_AGG_CMP				22
+	#define CMP_TYPE_RX_L2_V3_CMP				23
+	#define CMP_TYPE_RX_L2_TPA_START_V3_CMP			25
+	#define CMP_TYPE_STATUS_CMP				32
+	#define CMP_TYPE_REMOTE_DRIVER_REQ			34
+	#define CMP_TYPE_REMOTE_DRIVER_RESP			36
+	#define CMP_TYPE_ERROR_STATUS				48
+	#define CMPL_BASE_TYPE_STAT_EJECT			0x1aUL
+	#define CMPL_BASE_TYPE_HWRM_DONE			0x20UL
+	#define CMPL_BASE_TYPE_HWRM_FWD_REQ			0x22UL
+	#define CMPL_BASE_TYPE_HWRM_FWD_RESP			0x24UL
+	#define CMPL_BASE_TYPE_HWRM_ASYNC_EVENT			0x2eUL
+	#define TX_CMP_FLAGS_ERROR				(1 << 6)
+	#define TX_CMP_FLAGS_PUSH				(1 << 7)
+	u32 tx_cmp_opaque;
+	__le32 tx_cmp_errors_v;
+	#define TX_CMP_V					(1 << 0)
+	#define TX_CMP_ERRORS_BUFFER_ERROR			(7 << 1)
+	#define TX_CMP_ERRORS_BUFFER_ERROR_NO_ERROR		0
+	#define TX_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT		2
+	#define TX_CMP_ERRORS_BUFFER_ERROR_INVALID_STAG		4
+	#define TX_CMP_ERRORS_BUFFER_ERROR_STAG_BOUNDS		5
+	#define TX_CMP_ERRORS_ZERO_LENGTH_PKT			(1 << 4)
+	#define TX_CMP_ERRORS_EXCESSIVE_BD_LEN			(1 << 5)
+	#define TX_CMP_ERRORS_DMA_ERROR				(1 << 6)
+	#define TX_CMP_ERRORS_HINT_TOO_SHORT			(1 << 7)
+	__le32 sq_cons_idx;
+	#define TX_CMP_SQ_CONS_IDX_MASK				0x00ffffff
+};
+
+struct bnge_sw_tx_bd {
+	struct sk_buff		*skb;
+	DEFINE_DMA_UNMAP_ADDR(mapping);
+	DEFINE_DMA_UNMAP_LEN(len);
+	struct page		*page;
+	u8			is_ts_pkt;
+	u8			is_push;
+	u8			action;
+	unsigned short		nr_frags;
+	union {
+		u16		rx_prod;
+		u16		txts_prod;
+	};
+};
+
+struct bnge_sw_rx_bd {
+	void			*data;
+	u8			*data_ptr;
+	dma_addr_t		mapping;
+};
+
+struct bnge_sw_rx_agg_bd {
+	struct page		*page;
+	unsigned int		offset;
+	dma_addr_t		mapping;
+};
+
+#define BNGE_RX_COPY_THRESH     256
+
+#define BNGE_HW_FEATURE_VLAN_ALL_RX	\
+		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
+#define BNGE_HW_FEATURE_VLAN_ALL_TX	\
+		(NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_STAG_TX)
+
+enum {
+	BNGE_NET_EN_GRO		= BIT(0),
+	BNGE_NET_EN_LRO		= BIT(1),
+	BNGE_NET_EN_JUMBO	= BIT(2),
+};
+
+#define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
+
+struct bnge_net {
+	struct bnge_dev		*bd;
+	struct net_device	*netdev;
+
+	u32			priv_flags;
+
+	u32			rx_ring_size;
+	u32			rx_buf_size;
+	u32			rx_buf_use_size; /* usable size */
+	u32			rx_agg_ring_size;
+	u32			rx_copy_thresh;
+	u32			rx_ring_mask;
+	u32			rx_agg_ring_mask;
+	u16			rx_nr_pages;
+	u16			rx_agg_nr_pages;
+
+	u32			tx_ring_size;
+	u32			tx_ring_mask;
+	u16			tx_nr_pages;
+
+	/* NQs and Completion rings */
+	u32			cp_ring_size;
+	u32			cp_ring_mask;
+	u32			cp_bit;
+	u16			cp_nr_pages;
+
+#define BNGE_L2_FLTR_HASH_SIZE	32
+#define BNGE_L2_FLTR_HASH_MASK	(BNGE_L2_FLTR_HASH_SIZE - 1)
+	struct hlist_head	l2_fltr_hash_tbl[BNGE_L2_FLTR_HASH_SIZE];
+	u32			hash_seed;
+	u64			toeplitz_prefix;
+};
+
+#define BNGE_DEFAULT_RX_RING_SIZE	511
+#define BNGE_DEFAULT_TX_RING_SIZE	511
+
+int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs);
+void bnge_netdev_free(struct bnge_dev *bd);
+void bnge_set_ring_params(struct bnge_dev *bd);
+
+#if (BNGE_PAGE_SHIFT == 16)
+#define MAX_RX_PAGES_AGG_ENA	1
+#define MAX_RX_PAGES		4
+#define MAX_RX_AGG_PAGES	4
+#define MAX_TX_PAGES		1
+#define MAX_CP_PAGES		16
+#else
+#define MAX_RX_PAGES_AGG_ENA	8
+#define MAX_RX_PAGES		32
+#define MAX_RX_AGG_PAGES	32
+#define MAX_TX_PAGES		8
+#define MAX_CP_PAGES		128
+#endif
+
+#define BNGE_RX_PAGE_SIZE		(1 << BNGE_RX_PAGE_SHIFT)
+
+#define RX_DESC_CNT			(BNGE_PAGE_SIZE / sizeof(struct rx_bd))
+#define TX_DESC_CNT			(BNGE_PAGE_SIZE / sizeof(struct tx_bd))
+#define CP_DESC_CNT			(BNGE_PAGE_SIZE / sizeof(struct tx_cmp))
+#define SW_RXBD_RING_SIZE		(sizeof(struct bnge_sw_rx_bd) * RX_DESC_CNT)
+#define HW_RXBD_RING_SIZE		(sizeof(struct rx_bd) * RX_DESC_CNT)
+#define SW_RXBD_AGG_RING_SIZE		(sizeof(struct bnge_sw_rx_agg_bd) * RX_DESC_CNT)
+#define SW_TXBD_RING_SIZE		(sizeof(struct bnge_sw_tx_bd) * TX_DESC_CNT)
+#define HW_TXBD_RING_SIZE		(sizeof(struct tx_bd) * TX_DESC_CNT)
+#define HW_CMPD_RING_SIZE		(sizeof(struct tx_cmp) * CP_DESC_CNT)
+#define BNGE_MAX_RX_DESC_CNT		(RX_DESC_CNT * MAX_RX_PAGES - 1)
+#define BNGE_MAX_RX_DESC_CNT_JUM_ENA	(RX_DESC_CNT * MAX_RX_PAGES_AGG_ENA - 1)
+#define BNGE_MAX_RX_JUM_DESC_CNT	(RX_DESC_CNT * MAX_RX_AGG_PAGES - 1)
+#define BNGE_MAX_TX_DESC_CNT		(TX_DESC_CNT * MAX_TX_PAGES - 1)
+
+#endif /* _BNGE_NETDEV_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
index b39fd1a7a81b..54ef1c7d8822 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_resc.h
@@ -4,6 +4,9 @@
 #ifndef _BNGE_RESC_H_
 #define _BNGE_RESC_H_
 
+#include "bnge_netdev.h"
+#include "bnge_rmem.h"
+
 struct bnge_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
-- 
2.47.1


