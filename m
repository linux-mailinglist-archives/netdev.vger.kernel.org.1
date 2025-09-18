Return-Path: <netdev+bounces-213222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85343B24246
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D429A881231
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9702EBB99;
	Wed, 13 Aug 2025 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Phale/Mb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cXMaq0Ln"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758362D9EE4;
	Wed, 13 Aug 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068935; cv=none; b=ljza+9Z+nWTQ7CfD1XaPYp96S9uQen62szvAZgRu2FkrDRckKemZ1iT3D8hjdBKffykL/OXqucuojIfHfQUyAn8bItWz45xzh6e3aOO77eQ/Bsd90k1Unq6O8QsYnF3QjoML57rQ7J8yA5JQ4eRGTu/lwv4k37XvmQBF6CvfWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068935; c=relaxed/simple;
	bh=xusUdxirR3thFba7PTMWiDMN9RAlGl6SuvZ3UjghQ/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JEHu/gyct1GLTXd6V34gahtl3M/o4GOl13Fwgmzs0fi8dkw5uwv0nPbp31wX3hMdGBN3CgPTpQNz+N2f9yAWU0orzdbVB1d50o83hCGUEieXEjUQhpizazCTSy+dPwxukdcLrXiMVjUTYL7JFY7H2xK6UXJhkRR3g5jrGkMRRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Phale/Mb; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=cXMaq0Ln; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c1zxZ5XySz9sxK;
	Wed, 13 Aug 2025 09:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kszpmmfqBgJhU7Lvca3YQOyUxT8nvHx54321xIrjuWg=;
	b=Phale/MbJXGFBHK/rzwugs/T0y6LYOw0wuVKbXssEG6gdr6Br+VjhL8OxuV5Ovp6pHRCo+
	1px6qgqOknHsv2BW5Dh6QQfAJnsVXizV11v/CvHnSG1u9wmGm6MjprW4H4P3l9PfeQrpfr
	KzgIWzyDDkTSp87Eot7RCsSnJzL3eKJ3ROhw/u0Z4HOJMdZdh+T94RVqttJ9zkqfN7cNGv
	E8micvUh2eXDmrU/NwNZkmWQr5OAQ02J+FTO7t6L937HxsGqH8aHjoShwjzb4bGSRcDL8O
	gXGrZXPs2hWyGWH2wLFhRc9v/i4kU8RSZu8CfyDAN+P/R2kLng1NFz1SwuiiOA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1755068928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kszpmmfqBgJhU7Lvca3YQOyUxT8nvHx54321xIrjuWg=;
	b=cXMaq0LnN91haUcp/67FXnqQqooJ1qH6m3+JwjXmooAx4zYmit6Hed6uRa2HbnxV+t6DyM
	uTViF5KtLgk/Fndw4v7T8crpCokCZzTsJ3z9tWJEXbkDeBbKx18RciYsdzIjW8VPPSGLAr
	zzdO3gioNJ72n+NR3LWptPnHEfWtpJaiV++g7U1A9a61TGdpMV+JiJUmt+KvwyQ3bqbBOS
	ipDIIRyqVkEiAzcdXnEPCN1nQZOTzpFKEMXaoCMAPjm05UyeKlYLl9RX2LTRtiPrXfM9rD
	FAqKPC51vRbt7MNlXjZDJS+QDiPoDisS9zLYukdvhlgZjsBOW3S2RqHkMRBsrw==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v18 6/7] net: mtip: Extend the L2 switch driver with management operations
Date: Wed, 13 Aug 2025 09:07:54 +0200
Message-Id: <20250813070755.1523898-7-lukasz.majewski@mailbox.org>
In-Reply-To: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
References: <20250813070755.1523898-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jea7ptzcu6htzur96bj465ojzbu9ymwz
X-MBO-RS-ID: 6b9b40e565680a97917

This patch provides function necessary for manging the L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>

---
Changes for v13:
- New patch - created by excluding some code from large (i.e. v12 and
  earlier) MTIP driver

Changes for v14 - v18:
- None
---
 .../net/ethernet/freescale/mtipsw/Makefile    |   2 +-
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  |  31 ++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  23 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c | 443 ++++++++++++++++++
 4 files changed, 498 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

diff --git a/drivers/net/ethernet/freescale/mtipsw/Makefile b/drivers/net/ethernet/freescale/mtipsw/Makefile
index bd8ffb30939a..a99aaf6ddfb2 100644
--- a/drivers/net/ethernet/freescale/mtipsw/Makefile
+++ b/drivers/net/ethernet/freescale/mtipsw/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_FEC_MTIP_L2SW) += nxp-mtipl2sw.o
-nxp-mtipl2sw-objs := mtipl2sw.o
+nxp-mtipl2sw-objs := mtipl2sw.o mtipl2sw_mgnt.o
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 0f7d2f479161..4c9776fc5382 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -474,8 +474,35 @@ static void mtip_config_switch(struct switch_enet_private *fep)
 
 	writel(0, fep->hwp + ESW_BKLR);
 
+	/* Do NOT disable learning */
+	mtip_port_learning_config(fep, 0, 0, 0);
+	mtip_port_learning_config(fep, 1, 0, 0);
+	mtip_port_learning_config(fep, 2, 0, 0);
+
+	/* Disable blocking */
+	mtip_port_blocking_config(fep, 0, 0);
+	mtip_port_blocking_config(fep, 1, 0);
+	mtip_port_blocking_config(fep, 2, 0);
+
 	writel(MCF_ESW_IMR_TXF | MCF_ESW_IMR_RXF,
 	       fep->hwp + ESW_IMR);
+
+	mtip_port_enable_config(fep, 0, 1, 1);
+	mtip_port_enable_config(fep, 1, 1, 1);
+	mtip_port_enable_config(fep, 2, 1, 1);
+
+	mtip_port_broadcast_config(fep, 0, 1);
+	mtip_port_broadcast_config(fep, 1, 1);
+	mtip_port_broadcast_config(fep, 2, 1);
+
+	/* Disable multicast receive on port 0 (MGNT) */
+	mtip_port_multicast_config(fep, 0, 0);
+	mtip_port_multicast_config(fep, 1, 1);
+	mtip_port_multicast_config(fep, 2, 1);
+
+	/* Setup VLANs to provide port separation */
+	if (!fep->br_offload)
+		mtip_switch_en_port_separation(fep);
 }
 
 static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
@@ -564,6 +591,10 @@ static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
 
 	skb_tx_timestamp(skb);
 
+	/* For port separation - force sending via specified port */
+	if (!fep->br_offload && port != 0)
+		mtip_forced_forward(fep, port, 1);
+
 	/* Trigger transmission start */
 	writel(MCF_ESW_TDAR_X_DES_ACTIVE, fep->hwp + ESW_TDAR);
 
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
index 8a3cce976476..7e5373823d43 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
@@ -621,6 +621,29 @@ static inline int mtip_get_time(void)
 
 #define MTIP_PORT_FORWARDING_INIT 0xFF
 
+/* Switch Management functions */
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port);
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en);
+int mtip_port_multicast_config(struct switch_enet_private *fep, int port,
+			       bool enable);
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode);
+void mtip_switch_en_port_separation(struct switch_enet_private *fep);
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep);
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, bool enable);
+int mtip_forced_forward(struct switch_enet_private *fep, int port, bool enable);
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      bool disable, bool irq_adj);
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      bool enable);
 bool mtip_is_switch_netdev_port(const struct net_device *ndev);
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    bool tx_en, bool rx_en);
 void mtip_clear_atable(struct switch_enet_private *fep);
 #endif /* __MTIP_L2SWITCH_H_ */
diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
new file mode 100644
index 000000000000..2178b3d02d57
--- /dev/null
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  L2 switch Controller driver for MTIP block - switch MGNT
+ *
+ *  Copyright (C) 2025 DENX Software Engineering GmbH
+ *  Lukasz Majewski <lukma@denx.de>
+ *
+ *  Based on a previous work by:
+ *
+ *  Copyright 2010-2012 Freescale Semiconductor, Inc.
+ *  Alison Wang (b18965@freescale.com)
+ *  Jason Jin (Jason.jin@freescale.com)
+ *
+ *  Copyright (C) 2010-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Shrek Wu (B16972@freescale.com)
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+
+#include "mtipl2sw.h"
+
+int mtip_vlan_input_process(struct switch_enet_private *fep,
+			    int port, int mode, unsigned short port_vlanid,
+			    int vlan_verify_en, int vlan_domain_num,
+			    int vlan_domain_port)
+{
+	/* Only modes from 1 to 4 are valid*/
+	if (mode < 0 || mode > 4) {
+		dev_err(&fep->pdev->dev,
+			"%s: VLAN input processing mode (%d) not supported\n",
+			__func__, mode);
+		return -EINVAL;
+	}
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_verify_en == 1 &&
+	    (vlan_domain_num < 0 || vlan_domain_num > 32)) {
+		dev_err(&fep->pdev->dev, "%s: Domain out of range\n", __func__);
+		return -EINVAL;
+	}
+
+	writel(FIELD_PREP(MCF_ESW_PID_VLANID_MASK, port_vlanid),
+	       fep->hwp + ESW_PID(port));
+	if (port == 0) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P0,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN0,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM0_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	} else if (port == 1) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P1,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN1,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM1_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	} else if (port == 2) {
+		if (vlan_verify_en == 1)
+			writel(FIELD_PREP(MCF_ESW_VRES_VLANID_MASK,
+					  port_vlanid) | MCF_ESW_VRES_P2,
+			       fep->hwp + ESW_VRES(vlan_domain_num));
+
+		writel(readl(fep->hwp + ESW_VIMEN) | MCF_ESW_VIMEN_EN2,
+		       fep->hwp + ESW_VIMEN);
+		writel(readl(fep->hwp + ESW_VIMSEL) |
+		       FIELD_PREP(MCF_ESW_VIMSEL_IM2_MASK, mode),
+		       fep->hwp + ESW_VIMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_vlan_output_process(struct switch_enet_private *fep, int port,
+			     int mode)
+{
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (port == 0) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM0_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	} else if (port == 1) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM1_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	} else if (port == 2) {
+		writel(readl(fep->hwp + ESW_VOMSEL) |
+		       FIELD_PREP(MCF_ESW_VOMSEL_OM2_MASK, mode),
+		       fep->hwp + ESW_VOMSEL);
+	}
+
+	return 0;
+}
+
+int mtip_set_vlan_verification(struct switch_enet_private *fep, int port,
+			       int vlan_domain_verify_en,
+			       int vlan_discard_unknown_en)
+{
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	if (vlan_domain_verify_en == 1) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_VV2,
+			       fep->hwp + ESW_VLANV);
+	} else if (vlan_domain_verify_en == 0) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_VV2,
+			       fep->hwp + ESW_VLANV);
+	}
+
+	if (vlan_discard_unknown_en == 1) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) | MCF_ESW_VLANV_DU2,
+			       fep->hwp + ESW_VLANV);
+	} else if (vlan_discard_unknown_en == 0) {
+		if (port == 0)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU0,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 1)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU1,
+			       fep->hwp + ESW_VLANV);
+		else if (port == 2)
+			writel(readl(fep->hwp + ESW_VLANV) & ~MCF_ESW_VLANV_DU2,
+			       fep->hwp + ESW_VLANV);
+	}
+
+	dev_dbg(&fep->pdev->dev, "%s: ESW_VLANV %#x\n", __func__,
+		readl(fep->hwp + ESW_VLANV));
+
+	return 0;
+}
+
+int mtip_port_multicast_config(struct switch_enet_private *fep,
+			       int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_DMCR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			reg |= MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			reg |= MCF_ESW_DMCR_P2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_DMCR_P0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_DMCR_P1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_DMCR_P2;
+	}
+
+	writel(reg, fep->hwp + ESW_DMCR);
+	return 0;
+}
+
+/* enable or disable port n tx or rx
+ * tx_en 0 disable port n tx
+ * tx_en 1 enable  port n tx
+ * rx_en 0 disable port n rx
+ * rx_en 1 enable  port n rx
+ */
+int mtip_port_enable_config(struct switch_enet_private *fep, int port,
+			    bool tx_en, bool rx_en)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_PER);
+	if (tx_en) {
+		if (port == 0)
+			reg |= MCF_ESW_PER_TE0;
+		else if (port == 1)
+			reg |= MCF_ESW_PER_TE1;
+		else if (port == 2)
+			reg |= MCF_ESW_PER_TE2;
+	} else {
+		if (port == 0)
+			reg &= (~MCF_ESW_PER_TE0);
+		else if (port == 1)
+			reg &= (~MCF_ESW_PER_TE1);
+		else if (port == 2)
+			reg &= (~MCF_ESW_PER_TE2);
+	}
+
+	if (rx_en) {
+		if (port == 0)
+			reg |= MCF_ESW_PER_RE0;
+		else if (port == 1)
+			reg |= MCF_ESW_PER_RE1;
+		else if (port == 2)
+			reg |= MCF_ESW_PER_RE2;
+	} else {
+		if (port == 0)
+			reg &= (~MCF_ESW_PER_RE0);
+		else if (port == 1)
+			reg &= (~MCF_ESW_PER_RE1);
+		else if (port == 2)
+			reg &= (~MCF_ESW_PER_RE2);
+	}
+
+	writel(reg, fep->hwp + ESW_PER);
+	return 0;
+}
+
+void mtip_switch_en_port_separation(struct switch_enet_private *fep)
+{
+	u32 reg;
+
+	mtip_vlan_input_process(fep, 0, 3, 0x10, 1, 0, 0);
+	mtip_vlan_input_process(fep, 1, 3, 0x11, 1, 1, 0);
+	mtip_vlan_input_process(fep, 2, 3, 0x12, 1, 2, 0);
+
+	reg = readl(fep->hwp + ESW_VRES(0));
+	writel(reg | MCF_ESW_VRES_P1 | MCF_ESW_VRES_P2,
+	       fep->hwp + ESW_VRES(0));
+
+	reg = readl(fep->hwp + ESW_VRES(1));
+	writel(reg | MCF_ESW_VRES_P0, fep->hwp + ESW_VRES(1));
+
+	reg = readl(fep->hwp + ESW_VRES(2));
+	writel(reg | MCF_ESW_VRES_P0, fep->hwp + ESW_VRES(2));
+
+	dev_dbg(&fep->pdev->dev, "%s: VRES0: 0x%x\n",
+		__func__, readl(fep->hwp + ESW_VRES(0)));
+	dev_dbg(&fep->pdev->dev, "%s: VRES1: 0x%x\n", __func__,
+		readl(fep->hwp + ESW_VRES(1)));
+	dev_dbg(&fep->pdev->dev, "%s: VRES2: 0x%x\n", __func__,
+		readl(fep->hwp + ESW_VRES(2)));
+
+	mtip_set_vlan_verification(fep, 0, 1, 0);
+	mtip_set_vlan_verification(fep, 1, 1, 0);
+	mtip_set_vlan_verification(fep, 2, 1, 0);
+
+	mtip_vlan_output_process(fep, 0, 2);
+	mtip_vlan_output_process(fep, 1, 2);
+	mtip_vlan_output_process(fep, 2, 2);
+}
+
+void mtip_switch_dis_port_separation(struct switch_enet_private *fep)
+{
+	writel(0, fep->hwp + ESW_PID(0));
+	writel(0, fep->hwp + ESW_PID(1));
+	writel(0, fep->hwp + ESW_PID(2));
+
+	writel(0, fep->hwp + ESW_VRES(0));
+	writel(0, fep->hwp + ESW_VRES(1));
+	writel(0, fep->hwp + ESW_VRES(2));
+
+	writel(0, fep->hwp + ESW_VIMEN);
+	writel(0, fep->hwp + ESW_VIMSEL);
+	writel(0, fep->hwp + ESW_VLANV);
+	writel(0, fep->hwp + ESW_VOMSEL);
+}
+
+int mtip_port_broadcast_config(struct switch_enet_private *fep,
+			       int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_DBCR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			reg |= MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			reg |= MCF_ESW_DBCR_P2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_DBCR_P0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_DBCR_P1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_DBCR_P2;
+	}
+
+	writel(reg, fep->hwp + ESW_DBCR);
+	return 0;
+}
+
+/* The frame is forwarded to the forced destination ports.
+ * It only replace the MAC lookup function,
+ * all other filtering(eg.VLAN verification) act as normal
+ */
+int mtip_forced_forward(struct switch_enet_private *fep, int port, bool enable)
+{
+	u32 reg = 0;
+
+	if (port & ~GENMASK(1, 0)) {
+		dev_err(&fep->pdev->dev,
+			"%s: Forced forward for port(s): 0x%x not supported!\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	/* Enable Forced forwarding for port(s) */
+	reg |= FIELD_PREP(MCF_ESW_P0FFEN_FD_MASK, port & GENMASK(1, 0));
+
+	if (enable)
+		reg |= MCF_ESW_P0FFEN_FEN;
+	else
+		reg &= ~MCF_ESW_P0FFEN_FEN;
+
+	writel(reg, fep->hwp + ESW_P0FFEN);
+	return 0;
+}
+
+int mtip_port_learning_config(struct switch_enet_private *fep, int port,
+			      bool disable, bool irq_adj)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_BKLR);
+	if (disable) {
+		if (irq_adj)
+			writel(readl(fep->hwp + ESW_IMR) & ~MCF_ESW_IMR_LRN,
+			       fep->hwp + ESW_IMR);
+
+		if (port == 0)
+			reg |= MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			reg |= MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			reg |= MCF_ESW_BKLR_LD2;
+	} else {
+		if (irq_adj)
+			writel(readl(fep->hwp + ESW_IMR) | MCF_ESW_IMR_LRN,
+			       fep->hwp + ESW_IMR);
+
+		if (port == 0)
+			reg &= ~MCF_ESW_BKLR_LD0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_BKLR_LD1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_BKLR_LD2;
+	}
+
+	writel(reg, fep->hwp + ESW_BKLR);
+	dev_dbg(&fep->pdev->dev, "%s ESW_BKLR %#x, ESW_IMR %#x\n", __func__,
+		readl(fep->hwp + ESW_BKLR), readl(fep->hwp + ESW_IMR));
+
+	return 0;
+}
+
+int mtip_port_blocking_config(struct switch_enet_private *fep, int port,
+			      bool enable)
+{
+	u32 reg = 0;
+
+	if (port < 0 || port > 2) {
+		dev_err(&fep->pdev->dev, "%s: Port (%d) not supported\n",
+			__func__, port);
+		return -EINVAL;
+	}
+
+	reg = readl(fep->hwp + ESW_BKLR);
+	if (enable) {
+		if (port == 0)
+			reg |= MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			reg |= MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			reg |= MCF_ESW_BKLR_BE2;
+	} else {
+		if (port == 0)
+			reg &= ~MCF_ESW_BKLR_BE0;
+		else if (port == 1)
+			reg &= ~MCF_ESW_BKLR_BE1;
+		else if (port == 2)
+			reg &= ~MCF_ESW_BKLR_BE2;
+	}
+
+	writel(reg, fep->hwp + ESW_BKLR);
+	return 0;
+}
-- 
2.39.5


