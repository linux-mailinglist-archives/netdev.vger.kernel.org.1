Return-Path: <netdev+bounces-116099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A58949175
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E1D1C23A8E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC141D54F9;
	Tue,  6 Aug 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0oIYBFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3B1D54EB;
	Tue,  6 Aug 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950930; cv=none; b=WX8L5YtcU5e+zdwEfkKxfqo6JBeprd7il/74ysLIgkUpvVqOOyZSFJAum562GddIFlQOIF025l+K9xlKzCJ3MSgkItT18GeaLBXE7xe97XozMKP+5ykrkvz+Pqdekeg+Q48DTDFPqW6qylHGfIZQobYuZXYAkpnPxRxt+eMTer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950930; c=relaxed/simple;
	bh=WmMvoB68U8Wc4O3qdg22EDFbwce9VHJjnsUkElzQmSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulL/8istfAKCbCzSOjTjJuFZQcg/5Ivg4wWNHjeaRCvDw8xq5pLuBw2fL17HRiQ5TiKEn25i1ZJXc26ivG3vy5/EkftzMHFBeSoGuhz07u+h03RX1i4S6lw6b4mD+FI4WJ+HyCMPpqieDCK2n53n9WZxImmIuxDVlYu1EStLjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0oIYBFb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso993128a12.1;
        Tue, 06 Aug 2024 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950926; x=1723555726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9bw0YKI65JJ5pW22paW2wmKi5k1PnotCTNp69g0vuI=;
        b=S0oIYBFbJ8doFLVFh+3toku49DV1UffKHw3scmvHcuy3QH6ZIKZMXhVB5JQblJpn8P
         k/fKGnogqaM9md8iNOyfTOenMqrY+W8RyeVPJD8YvkvMIpYQEyvkgc2iqw+EXSwZiyo7
         b7DOWgDHRue1UrAKAWvqdSzTUqOBp8p0Cy34YFZpIw1qs+RGShl48iryz5OsAImHT9OE
         410QFh8V7DwwNpL2I7yvN5CVty9PxDunIrq0tZl7AevE5ARHDyNR23xLXa6jeR8joakV
         y/mYMLe9wBNNCQ74jtV7mpOljGztjJcooSUAdHLyhzBs+YMYg9vDXs3j1cMw1zKwfnpW
         kVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950926; x=1723555726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9bw0YKI65JJ5pW22paW2wmKi5k1PnotCTNp69g0vuI=;
        b=ctqwymgCqPClQd4+4RitQB/UYotZxDo2VMXZyUm4tWSZqrJcd/139BrStEoz68ZNVG
         ahQaFGVOrNlF80pxt0iwGWr0Lj+bxwfUMeNud048Ha05bplmX9nrQb9lrXBUed2UN9mH
         0Wq9ZYsgPSsTSVsdd9Aich2id9El7NsmVkj5zbqhYTMxYOqegCz2JZ9iYHIwe35atpYA
         OAf58RgfP2heDuGlXtQtSt+MCVBN0NZp21BAI5+GK+FfnM1myJwLdjMk7hYfkxyFSBji
         8Tcc61aHmTJWx1DuQT3OeuQjxZ1v8rKbKagVPpVywvhvlFKwOMANXPcAQdfHrlykHhkI
         Y5vA==
X-Forwarded-Encrypted: i=1; AJvYcCUKurWunJBqNrsoaHjRnc59uc6xWRiIkT/7bI8noyoK653DrB/Fuq9+YQxPc0nKCjJaf6hVjq8oaY/RrF0bUMJXcR3/SsWRo/ORUr21waUNZfc0Tx7URQmtM2uynpsGOE2GuFAtzbxczb6mXSHCnpOQH08iW2/Rlav/KnkaC4WaLQ==
X-Gm-Message-State: AOJu0YyNlJHlQoc2eUCfJBsdZp+hM3IfElkbAOFbPBxYWVckLYkAjmYW
	uoojtBuHNnY8FugtgVp1VRpqescjRDgOOhcJ/8Yg1HzZ984gul0Y
X-Google-Smtp-Source: AGHT+IHQFBQsVITBptXjIo37uHZKCljUTfn9V777LG4wPRLMoR59hiz7CQaxJ86WsKJ9q9uMtGJk+Q==
X-Received: by 2002:aa7:d552:0:b0:5b6:d0f1:2947 with SMTP id 4fb4d7f45d1cf-5b7f57f4238mr10692274a12.34.1722950926341;
        Tue, 06 Aug 2024 06:28:46 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::102:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm5910172a12.53.2024.08.06.06.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:28:46 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 4/5] net: dsa: microchip: add WoL support for KSZ87xx family
Date: Tue,  6 Aug 2024 15:25:56 +0200
Message-ID: <20240806132606.1438953-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806132606.1438953-1-vtpieter@gmail.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ87xx family of switches. This code was tested
with a KSZ8794 chip.

Implement ksz_common usage of the new device-tree property
'microchip,pme-active-high'.

Make use of the now generalized ksz_common WoL functions, adding an
additional interrupt register write for KSZ87xx. Add helper functions
to convert from PME (port) read/writes to indirect register
read/writes in the dedicated ksz8795 sources.  Add initial
configuration during (port) setup as per KSZ9477.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8.h       |  3 +
 drivers/net/dsa/microchip/ksz8795.c    | 94 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c | 24 +++++--
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 4 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index ae43077e76c3..e1c79ff97123 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -54,6 +54,9 @@ int ksz8_reset_switch(struct ksz_device *dev);
 int ksz8_switch_init(struct ksz_device *dev);
 void ksz8_switch_exit(struct ksz_device *dev);
 int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
+int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value);
+int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data);
+int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data);
 void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d27b9c36d73f..a01079297a8c 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -38,6 +38,20 @@ static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
 			   bits, set ? bits : 0);
 }
 
+/**
+ * ksz8_ind_write8 - EEE/ACL/PME indirect register write
+ * @dev: The device structure.
+ * @table: Function & table select, register 110.
+ * @addr: Indirect access control, register 111.
+ * @data: The data to be written.
+ *
+ * This function performs an indirect register write for EEE, ACL or
+ * PME switch functionalities. Both 8-bit registers 110 and 111 are
+ * written at once with ksz_write16, using the serial multiple write
+ * functionality.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
 static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 {
 	const u16 *regs;
@@ -58,6 +72,59 @@ static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 	return ret;
 }
 
+/**
+ * ksz8_ind_read8 - EEE/ACL/PME indirect register read
+ * @dev: The device structure.
+ * @table: Function & table select, register 110.
+ * @addr: Indirect access control, register 111.
+ * @val: The value read.
+ *
+ * This function performs an indirect register read for EEE, ACL or
+ * PME switch functionalities. Both 8-bit registers 110 and 111 are
+ * written at once with ksz_write16, using the serial multiple write
+ * functionality.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+static int ksz8_ind_read8(struct ksz_device *dev, u8 table, u16 addr, u8 *val)
+{
+	const u16 *regs;
+	u16 ctrl_addr;
+	int ret = 0;
+
+	regs = dev->info->regs;
+
+	mutex_lock(&dev->alu_mutex);
+
+	ctrl_addr = IND_ACC_TABLE(table | TABLE_READ) | addr;
+	ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+	if (!ret)
+		ret = ksz_read8(dev, regs[REG_IND_BYTE], val);
+
+	mutex_unlock(&dev->alu_mutex);
+
+	return ret;
+}
+
+int ksz8_pme_write8(struct ksz_device *dev, u32 reg, u8 value)
+{
+	return ksz8_ind_write8(dev, (u8)(reg >> 8), (u8)(reg), value);
+}
+
+int ksz8_pme_pread8(struct ksz_device *dev, int port, int offset, u8 *data)
+{
+	u8 table = (u8)(offset >> 8 | (port + 1));
+
+	return ksz8_ind_read8(dev, table, (u8)(offset), data);
+}
+
+int ksz8_pme_pwrite8(struct ksz_device *dev, int port, int offset, u8 data)
+{
+	u8 table = (u8)(offset >> 8 | (port + 1));
+
+	return ksz8_ind_write8(dev, table, (u8)(offset), data);
+}
+
 int ksz8_reset_switch(struct ksz_device *dev)
 {
 	if (ksz_is_ksz88x3(dev)) {
@@ -1545,6 +1612,7 @@ static void ksz8795_cpu_interface_select(struct ksz_device *dev, int port)
 
 void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
+	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
 	const u32 *masks;
 	int queues;
@@ -1575,6 +1643,13 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 		member = BIT(dsa_upstream_port(ds, port));
 
 	ksz8_cfg_port_member(dev, port, member);
+
+	/* Disable all WoL options by default. Otherwise
+	 * ksz_switch_macaddr_get/put logic will not work properly.
+	 * CPU port 4 has no WoL functionality.
+	 */
+	if (ksz_is_ksz87xx(dev) && !cpu_port)
+		ksz8_pme_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
 static void ksz88x3_config_rmii_clk(struct ksz_device *dev)
@@ -1790,7 +1865,8 @@ int ksz8_enable_stp_addr(struct ksz_device *dev)
 int ksz8_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
-	int i;
+	const u16 *regs = dev->info->regs;
+	int i, ret = 0;
 
 	ds->mtu_enforcement_ingress = true;
 
@@ -1829,7 +1905,21 @@ int ksz8_setup(struct dsa_switch *ds)
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
 		ksz8_r_vlan_entries(dev, i);
 
-	return ksz8_handle_global_errata(ds);
+	/* Make sure PME (WoL) is not enabled. If requested, it will
+	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
+	 * do not like PME events changes before shutdown. PME only
+	 * available on KSZ87xx family.
+	 */
+	if (ksz_is_ksz87xx(dev)) {
+		ret = ksz8_pme_write8(dev, regs[REG_SW_PME_CTRL], 0);
+		if (!ret)
+			ret = ksz_rmw8(dev, REG_INT_ENABLE, INT_PME, 0);
+	}
+
+	if (!ret)
+		return ksz8_handle_global_errata(ds);
+	else
+		return ret;
 }
 
 void ksz8_get_caps(struct ksz_device *dev, int port,
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index d8b8c17f979c..c2079e39fbd5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -307,6 +307,9 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
 	.change_mtu = ksz8_change_mtu,
+	.pme_write8 = ksz8_pme_write8,
+	.pme_pread8 = ksz8_pme_pread8,
+	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
@@ -423,6 +426,9 @@ static const u16 ksz8795_regs[] = {
 	[S_MULTICAST_CTRL]		= 0x04,
 	[P_XMII_CTRL_0]			= 0x06,
 	[P_XMII_CTRL_1]			= 0x06,
+	[REG_SW_PME_CTRL]		= 0x8003,
+	[REG_PORT_PME_STATUS]		= 0x8003,
+	[REG_PORT_PME_CTRL]		= 0x8007,
 };
 
 static const u32 ksz8795_masks[] = {
@@ -3789,7 +3795,7 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
 	u8 pme_ctrl;
 	int ret;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
 	if (!dev->wakeup_source)
@@ -3842,7 +3848,7 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return -EOPNOTSUPP;
 
 	if (!dev->wakeup_source)
@@ -3908,12 +3914,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 {
 	const struct ksz_dev_ops *ops = dev->dev_ops;
 	const u16 *regs = dev->info->regs;
+	u8 pme_pin_en = PME_ENABLE;
 	struct dsa_port *dp;
 	int ret;
 
 	*wol_enabled = false;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
 	if (!dev->wakeup_source)
@@ -3934,8 +3941,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	}
 
 	/* Now we are save to enable PME pin. */
-	if (*wol_enabled)
-		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], PME_ENABLE);
+	if (*wol_enabled) {
+		if (dev->pme_active_high)
+			pme_pin_en |= PME_POLARITY;
+		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], pme_pin_en);
+		if (ksz_is_ksz87xx(dev))
+			ksz_write8(dev, KSZ8795_REG_INT_EN, KSZ8795_INT_PME_MASK);
+	}
 }
 
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
@@ -4645,6 +4657,8 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+		dev->pme_active_high = of_property_read_bool(dev->dev->of_node,
+							     "microchip,pme-active-high");
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c60c218afa64..c0b93825726d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -174,6 +174,7 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 	bool wakeup_source;
+	bool pme_active_high;
 
 	struct vlan_table *vlan_cache;
 
@@ -712,6 +713,9 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define PME_ENABLE			BIT(1)
 #define PME_POLARITY			BIT(0)
 
+#define KSZ8795_REG_INT_EN		0x7D
+#define KSZ8795_INT_PME_MASK		BIT(4)
+
 /* Interrupt */
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
-- 
2.43.0


