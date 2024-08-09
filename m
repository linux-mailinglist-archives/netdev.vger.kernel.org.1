Return-Path: <netdev+bounces-117309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283BB94D868
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7112811AD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388B816B725;
	Fri,  9 Aug 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Cdq54nOQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9B16849C;
	Fri,  9 Aug 2024 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238535; cv=none; b=DBDiNBXmtCD4GrRqrq/KNLt7dXXriO0eNIjK4W30IbH0Av3Y+iFNk2X0EzW9u6Lm/Jl5hP10qciq9b9ycttieozyA80ybEA6yGokX7+c30QazlDj7lOplTEQhzXXJ+Y223tA2R1bBsXk+PedJyr3dCty+qLsABvWhexxNB6dY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238535; c=relaxed/simple;
	bh=y3H0JRDBFcVQDW3l3zuPU+Q5Mmwp7oZzz8JkUDu+pCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arnwxLpHLaoQHPwm0HN19D6V8VS7GwQ18ctmitfV+pVgk2q5K0EPay2IthQtGRQMOG4PkuYQdDX8sdGLUGb1Xx7au9RkK2DYIa3q+6bMIjWHIeeN3YTiL54mU2LcJOAoGdXQ+X8EXSHDXmquK08fpRXoYTd10Kg21wd/yN7V0Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Cdq54nOQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723238533; x=1754774533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3H0JRDBFcVQDW3l3zuPU+Q5Mmwp7oZzz8JkUDu+pCU=;
  b=Cdq54nOQtImuRxqdCxH2i6PD1aNetvXxD9J3Jr5yxdLpcyvux4VHFO6R
   8aMjIByTtdwtDjTsP+kws9WIz5pV8eZl+7qWrtIatIpjTro0bHmv0ZNi9
   H80o6VoDTlrs3sdhYtZv6GhFH/Qn/+vpZaGkfOrFbLKtvrNU4KsaHQ3iQ
   gmNdUDjCgdKN36SQEXyNr9WheEWFnk2MRvq1yJ4AbHKPMUY3DCQomiw8r
   BWCzJfEe9MMA6hlpIindAMPZJtDJufqkdKJpDi/VRR44uU5sJgsmAsPgx
   jcqwWoKaqJVl1YGCBdH5Ifo+1BG7ezXT4JLrvTo+vBY3Vn3rDdZ6IHkGS
   Q==;
X-CSE-ConnectionGUID: fVgutDEfQ6+TQCfyHCdg8Q==
X-CSE-MsgGUID: yByz1uuoRCihDYOE2mJMRQ==
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="30985761"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2024 14:22:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Aug 2024 14:21:43 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 9 Aug 2024 14:21:43 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh@kernel.org>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut
	<marex@denx.de>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net-next v3 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Fri, 9 Aug 2024 14:21:42 -0700
Message-ID: <20240809212142.3575-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809212142.3575-1-Tristram.Ha@microchip.com>
References: <20240809212142.3575-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
shares some registers and functions in those switches already
implemented in the KSZ DSA driver.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8795.c         |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c      | 130 +++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      |  20 ++-
 drivers/net/dsa/microchip/ksz_spi.c         |  15 ++-
 include/linux/platform_data/microchip-ksz.h |   2 +
 5 files changed, 170 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d27b9c36d73f..ac5da38bab36 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -121,6 +121,8 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
 	case KSZ8830_CHIP_ID:
+	case KSZ8895_CHIP_ID:
+	case KSZ8864_CHIP_ID:
 		return ksz8863_change_mtu(dev, frame_size);
 	}
 
@@ -317,7 +319,7 @@ static void ksz8863_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 		    u64 *dropped, u64 *cnt)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev))
 		ksz8863_r_mib_pkt(dev, port, addr, dropped, cnt);
 	else
 		ksz8795_r_mib_pkt(dev, port, addr, dropped, cnt);
@@ -325,7 +327,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
 
 void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev))
 		return;
 
 	/* enable the port for flush/freeze function */
@@ -343,7 +345,8 @@ void ksz8_port_init_cnt(struct ksz_device *dev, int port)
 	struct ksz_port_mib *mib = &dev->ports[port].mib;
 	u64 *dropped;
 
-	if (!ksz_is_ksz88x3(dev)) {
+	/* For KSZ8795 family. */
+	if (ksz_is_ksz87xx(dev)) {
 		/* flush all enabled port MIB counters */
 		ksz_cfg(dev, REG_SW_CTRL_6, BIT(port), true);
 		ksz_cfg(dev, REG_SW_CTRL_6, SW_MIB_COUNTER_FLUSH, true);
@@ -542,11 +545,11 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 			shifts[STATIC_MAC_FWD_PORTS];
 	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
 
-	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+	/* KSZ8795/KSZ8895 family switches have STATIC_MAC_TABLE_USE_FID and
 	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
 	 * static MAC table compared to doing write.
 	 */
-	if (ksz_is_ksz87xx(dev))
+	if (!ksz_is_ksz88x3(dev))
 		data_hi >>= 1;
 	alu->is_static = true;
 	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
@@ -1617,7 +1620,8 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	for (i = 0; i < dev->phy_port_cnt; i++) {
 		p = &dev->ports[i];
 
-		if (!ksz_is_ksz88x3(dev)) {
+		/* For KSZ8795 family. */
+		if (ksz_is_ksz87xx(dev)) {
 			ksz_pread8(dev, i, regs[P_REMOTE_STATUS], &remote);
 			if (remote & KSZ8_PORT_FIBER_MODE)
 				p->fiber = 1;
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 1491099528be..8751578b7e38 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2,7 +2,7 @@
 /*
  * Microchip switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/delay.h>
@@ -477,6 +477,61 @@ static const u8 ksz8795_shifts[] = {
 	[DYNAMIC_MAC_SRC_PORT]		= 24,
 };
 
+static const u16 ksz8895_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x68,
+	[REG_IND_CTRL_0]		= 0x6E,
+	[REG_IND_DATA_8]		= 0x70,
+	[REG_IND_DATA_CHECK]		= 0x72,
+	[REG_IND_DATA_HI]		= 0x71,
+	[REG_IND_DATA_LO]		= 0x75,
+	[REG_IND_MIB_CHECK]		= 0x75,
+	[P_FORCE_CTRL]			= 0x0C,
+	[P_LINK_STATUS]			= 0x0E,
+	[P_LOCAL_CTRL]			= 0x0C,
+	[P_NEG_RESTART_CTRL]		= 0x0D,
+	[P_REMOTE_STATUS]		= 0x0E,
+	[P_SPEED_STATUS]		= 0x09,
+	[S_TAIL_TAG_CTRL]		= 0x0C,
+	[P_STP_CTRL]			= 0x02,
+	[S_START_CTRL]			= 0x01,
+	[S_BROADCAST_CTRL]		= 0x06,
+	[S_MULTICAST_CTRL]		= 0x04,
+};
+
+static const u32 ksz8895_masks[] = {
+	[PORT_802_1P_REMAPPING]		= BIT(7),
+	[SW_TAIL_TAG_ENABLE]		= BIT(1),
+	[MIB_COUNTER_OVERFLOW]		= BIT(7),
+	[MIB_COUNTER_VALID]		= BIT(6),
+	[VLAN_TABLE_FID]		= GENMASK(6, 0),
+	[VLAN_TABLE_MEMBERSHIP]		= GENMASK(11, 7),
+	[VLAN_TABLE_VALID]		= BIT(12),
+	[STATIC_MAC_TABLE_VALID]	= BIT(21),
+	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
+	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
+	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
+	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
+	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
+	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
+	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
+	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
+	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
+};
+
+static const u8 ksz8895_shifts[] = {
+	[VLAN_TABLE_MEMBERSHIP_S]	= 7,
+	[VLAN_TABLE]			= 13,
+	[STATIC_MAC_FWD_PORTS]		= 16,
+	[STATIC_MAC_FID]		= 24,
+	[DYNAMIC_MAC_ENTRIES_H]		= 3,
+	[DYNAMIC_MAC_ENTRIES]		= 29,
+	[DYNAMIC_MAC_FID]		= 16,
+	[DYNAMIC_MAC_TIMESTAMP]		= 27,
+	[DYNAMIC_MAC_SRC_PORT]		= 24,
+};
+
 static const u16 ksz8863_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x70,
 	[REG_IND_CTRL_0]		= 0x79,
@@ -1343,6 +1398,61 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy = {true, true, true, true, false},
 	},
 
+	[KSZ8895] = {
+		.chip_id = KSZ8895_CHIP_ID,
+		.dev_name = "KSZ8895",
+		.num_vlans = 4096,
+		.num_alus = 0,
+		.num_statics = 32,
+		.cpu_ports = 0x10,	/* can be configured as cpu port */
+		.port_cnt = 5,		/* total cpu and user ports */
+		.num_tx_queues = 4,
+		.num_ipms = 4,
+		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
+		.mib_names = ksz88xx_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz8895_regs,
+		.masks = ksz8895_masks,
+		.shifts = ksz8895_shifts,
+		.supports_mii = {false, false, false, false, true},
+		.supports_rmii = {false, false, false, false, true},
+		.internal_phy = {true, true, true, true, false},
+	},
+
+	[KSZ8864] = {
+		/* WARNING
+		 * =======
+		 * KSZ8864 is similar to KSZ8895, except the first port
+		 * does not exist.
+		 *           external  cpu
+		 * KSZ8864   1,2,3      4
+		 * KSZ8895   0,1,2,3    4
+		 * port_cnt is configured as 5, even though it is 4
+		 */
+		.chip_id = KSZ8864_CHIP_ID,
+		.dev_name = "KSZ8864",
+		.num_vlans = 4096,
+		.num_alus = 0,
+		.num_statics = 32,
+		.cpu_ports = 0x10,	/* can be configured as cpu port */
+		.port_cnt = 5,		/* total cpu and user ports */
+		.num_tx_queues = 4,
+		.num_ipms = 4,
+		.ops = &ksz8_dev_ops,
+		.phylink_mac_ops = &ksz8_phylink_mac_ops,
+		.mib_names = ksz88xx_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz8895_regs,
+		.masks = ksz8895_masks,
+		.shifts = ksz8895_shifts,
+		.supports_mii = {false, false, false, false, true},
+		.supports_rmii = {false, false, false, false, true},
+		.internal_phy = {false, true, true, true, false},
+	},
+
 	[KSZ8830] = {
 		.chip_id = KSZ8830_CHIP_ID,
 		.dev_name = "KSZ8863/KSZ8873",
@@ -2893,9 +3003,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 	struct ksz_device *dev = ds->priv;
 	enum dsa_tag_protocol proto = DSA_TAG_PROTO_NONE;
 
-	if (dev->chip_id == KSZ8795_CHIP_ID ||
-	    dev->chip_id == KSZ8794_CHIP_ID ||
-	    dev->chip_id == KSZ8765_CHIP_ID)
+	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ8830_CHIP_ID ||
@@ -3011,6 +3119,8 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8830_CHIP_ID:
+	case KSZ8895_CHIP_ID:
+	case KSZ8864_CHIP_ID:
 		return KSZ8863_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
 	case KSZ8563_CHIP_ID:
 	case KSZ8567_CHIP_ID:
@@ -3368,6 +3478,18 @@ static int ksz_switch_detect(struct ksz_device *dev)
 		else
 			return -ENODEV;
 		break;
+	case KSZ8895_FAMILY_ID:
+		if (id2 == KSZ8895_CHIP_ID_95 ||
+		    id2 == KSZ8895_CHIP_ID_95R)
+			dev->chip_id = KSZ8895_CHIP_ID;
+		else
+			return -ENODEV;
+		ret = ksz_read8(dev, REG_KSZ8864_CHIP_ID, &id4);
+		if (ret)
+			return ret;
+		if (id4 & SW_KSZ8864)
+			dev->chip_id = KSZ8864_CHIP_ID;
+		break;
 	default:
 		ret = ksz_read32(dev, REG_CHIP_ID0, &id32);
 		if (ret)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..ad8723233a33 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip switch driver common header
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ_COMMON_H
@@ -199,6 +199,8 @@ enum ksz_model {
 	KSZ8795,
 	KSZ8794,
 	KSZ8765,
+	KSZ8895,
+	KSZ8864,
 	KSZ8830,
 	KSZ9477,
 	KSZ9896,
@@ -624,9 +626,16 @@ static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 	return dev->chip_id == KSZ8830_CHIP_ID;
 }
 
+static inline bool ksz_is_8895_family(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8895_CHIP_ID ||
+	       dev->chip_id == KSZ8864_CHIP_ID;
+}
+
 static inline bool is_ksz8(struct ksz_device *dev)
 {
-	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev);
+	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev) ||
+	       ksz_is_8895_family(dev);
 }
 
 static inline int is_lan937x(struct ksz_device *dev)
@@ -655,6 +664,7 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define SW_FAMILY_ID_M			GENMASK(15, 8)
 #define KSZ87_FAMILY_ID			0x87
 #define KSZ88_FAMILY_ID			0x88
+#define KSZ8895_FAMILY_ID		0x95
 
 #define KSZ8_PORT_STATUS_0		0x08
 #define KSZ8_PORT_FIBER_MODE		BIT(7)
@@ -663,6 +673,12 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define KSZ87_CHIP_ID_94		0x6
 #define KSZ87_CHIP_ID_95		0x9
 #define KSZ88_CHIP_ID_63		0x3
+#define KSZ8895_CHIP_ID_95		0x4
+#define KSZ8895_CHIP_ID_95R		0x6
+
+/* KSZ8895 specific register */
+#define REG_KSZ8864_CHIP_ID		0xFE
+#define SW_KSZ8864			BIT(7)
 
 #define SW_REV_ID_M			GENMASK(7, 4)
 
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 8e8d83213b04..11d27df710fd 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -2,7 +2,7 @@
 /*
  * Microchip ksz series register access through SPI
  *
- * Copyright (C) 2017 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  *	Tristram Ha <Tristram.Ha@microchip.com>
  */
 
@@ -60,6 +60,9 @@ static int ksz_spi_probe(struct spi_device *spi)
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
 		regmap_config = ksz8795_regmap_config;
+	else if (chip->chip_id == KSZ8895_CHIP_ID ||
+		 chip->chip_id == KSZ8864_CHIP_ID)
+		regmap_config = ksz8863_regmap_config;
 	else
 		regmap_config = ksz9477_regmap_config;
 
@@ -132,6 +135,14 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,ksz8795",
 		.data = &ksz_switch_chips[KSZ8795]
 	},
+	{
+		.compatible = "microchip,ksz8895",
+		.data = &ksz_switch_chips[KSZ8895]
+	},
+	{
+		.compatible = "microchip,ksz8864",
+		.data = &ksz_switch_chips[KSZ8864]
+	},
 	{
 		.compatible = "microchip,ksz8863",
 		.data = &ksz_switch_chips[KSZ8830]
@@ -200,6 +211,8 @@ static const struct spi_device_id ksz_spi_ids[] = {
 	{ "ksz8765" },
 	{ "ksz8794" },
 	{ "ksz8795" },
+	{ "ksz8895" },
+	{ "ksz8864" },
 	{ "ksz8863" },
 	{ "ksz8873" },
 	{ "ksz9477" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 8c659db4da6b..4b366b17391d 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -27,6 +27,8 @@ enum ksz_chip_id {
 	KSZ8795_CHIP_ID = 0x8795,
 	KSZ8794_CHIP_ID = 0x8794,
 	KSZ8765_CHIP_ID = 0x8765,
+	KSZ8895_CHIP_ID = 0x8895,
+	KSZ8864_CHIP_ID = 0x8864,
 	KSZ8830_CHIP_ID = 0x8830,
 	KSZ9477_CHIP_ID = 0x00947700,
 	KSZ9896_CHIP_ID = 0x00989600,
-- 
2.34.1


