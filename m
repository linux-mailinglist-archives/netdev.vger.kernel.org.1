Return-Path: <netdev+bounces-118090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FFC950791
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A151F22186
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018AD19E831;
	Tue, 13 Aug 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg9zZZ0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A19E7ED;
	Tue, 13 Aug 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559313; cv=none; b=tJNAgPbizONiDfgN3TbS3QnMnnwuOZKV5Ntu8BYWoIqYorS3sCWuAmQbwXnIEsaem8KBNaCt+uQGNQehOFujjGNJ46/urNgYImQnQwRCtOt0sNw/QtayNTJ9Oy8kq8soTQbL4CZ3LGIEqe4uMnR7VDAWeHVOp1RxiZy/0K4Hzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559313; c=relaxed/simple;
	bh=aoGG5sVhLE9ME+bAQqIWjm3N0qUkcvEkfW51zHhShbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnG2FFt8PK7quxZ4ax3X5Op8JtBp/LaTdl2RpuWL1W4QKnveDlq8iwCLgvvXwmywpEGxdD1kc4E/SZdGrLyDZtbYCKlFg8O2MRx5JZwh/y9V1zIFZorls6JfUjyGsCadYDoYkPJV4msEXS8BPHjpEX0xoiuDuBsOGpb29JxOWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg9zZZ0m; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so613832666b.3;
        Tue, 13 Aug 2024 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559310; x=1724164110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0dC3mF4X+wKSKxy8Scoq+dO1j2v1I2jrAKLTICnCSQ=;
        b=Mg9zZZ0mT6oRIhx3yr4YGljUYhmrsr6eHiiTSqq2Tbn2wrSMCNY7M+iMFI75VW1o4W
         gpduQZLHAfKNx99PEaHPEMd+aEweoz2EBM+CeLiNVgfQHZ7IYfisfMWYuvsNrdDp4gW+
         rMHWyItMMtaECROAANLDBhValVI8dXAojdbs6E/Qul11UkS3JkuPFMkAP5+xpgC+4DJK
         HWFLgOfCiWDvkZMHZlGKeHAx2aDwS1xVUBrQ0Ll9DsLssWcmp6plucnqRXji7egAucm2
         H4RHw6Co7Oyc2yW2IfIwvWnFd5SaCafZwk82JoXnXp5gwfMnVMShQMx3kTNt77VC3MYr
         CNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559310; x=1724164110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0dC3mF4X+wKSKxy8Scoq+dO1j2v1I2jrAKLTICnCSQ=;
        b=Y9IP1Su7oseYkjSp++UHSPTYVdDmDDXocgtoOlHoEozX6QgfUtO79E8Hg5gTjL1p5x
         abxgxMJ/fjTuVcXNe/BkPFbX6Xcl4TaehDSNzub78UqUs4aCuTdToc9S36TM0+8QLj7f
         EwEzfu0H6JCMXJiyQbYHKwy3lLYXO+PSVVBd4Cb6RBrHnQk1HarG0mKcvBfYaiaG8jzg
         +fswHspTfSbc1S3186lKHsBZRgpeSvcqtO9QozKBMoDckrZ1+JVIDD1ZJyXIp5BewQ9h
         K2YWKCHkoSRTCx/HHaOIjjrTEPjliQ0OTolRJcZhrAmXjO2MwK6cQgle3tJx50VbyoFp
         cd+g==
X-Forwarded-Encrypted: i=1; AJvYcCXd930sCNs/8GyX64O5iCO+4XHWFj0Il6ogexdXSsq9ZwkmysG9RaBtHWwWu4eFLoCzDEJEBL3Zv/K/F4PdTjt34hq1uT1tCY370KBckpmywOjcboJry2aVbbspBQMQqXJeX9AdyIivICR9k4ZF71nkUzl+ds240/TyvT1iaMUBbA==
X-Gm-Message-State: AOJu0YyFPYqw7sjJaCODSMbB9PHJKVoLKb7ROM+DctN8ZN5WDSb5NJJT
	Ul5eztXKxTjUlGW+OfsK1Tsg94YzyjXukk7o+GJ9d7uHtxgWKRki
X-Google-Smtp-Source: AGHT+IFA6BhJG7vhjo4kdg2AtCol8rorDrXM/i88Cmwb6T7MB1q26CSxLmuqfH8jG08vTL+EjGApTg==
X-Received: by 2002:a17:907:3f9d:b0:a72:6849:cb0f with SMTP id a640c23a62f3a-a80ed2d6dd7mr264198766b.62.1723559310026;
        Tue, 13 Aug 2024 07:28:30 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:29 -0700 (PDT)
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
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v6 4/6] net: dsa: microchip: add WoL support for KSZ87xx family
Date: Tue, 13 Aug 2024 16:27:38 +0200
Message-ID: <20240813142750.772781-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813142750.772781-1-vtpieter@gmail.com>
References: <20240813142750.772781-1-vtpieter@gmail.com>
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
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.h       |  3 +
 drivers/net/dsa/microchip/ksz8795.c    | 94 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c | 24 +++++--
 drivers/net/dsa/microchip/ksz_common.h |  6 +-
 4 files changed, 119 insertions(+), 8 deletions(-)

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
index e2a9a652c41a..3f3230d181d8 100644
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
@@ -3800,7 +3806,7 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
 	u8 pme_ctrl;
 	int ret;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
 	if (!dev->wakeup_source)
@@ -3853,7 +3859,7 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return -EOPNOTSUPP;
 
 	if (!dev->wakeup_source)
@@ -3919,12 +3925,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
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
@@ -3945,8 +3952,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	}
 
 	/* Now we are save to enable PME pin. */
-	if (*wol_enabled)
-		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], PME_ENABLE);
+	if (*wol_enabled) {
+		if (dev->pme_active_high)
+			pme_pin_en |= PME_POLARITY;
+		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], pme_pin_en);
+		if (ksz_is_ksz87xx(dev))
+			ksz_write8(dev, KSZ87XX_REG_INT_EN, KSZ87XX_INT_PME_MASK);
+	}
 }
 
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
@@ -4661,6 +4673,8 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+		dev->pme_active_high = of_property_read_bool(dev->dev->of_node,
+							     "microchip,pme-active-high");
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index c60c218afa64..8094d90d6ca4 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -174,6 +174,7 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 	bool wakeup_source;
+	bool pme_active_high;
 
 	struct vlan_table *vlan_cache;
 
@@ -704,7 +705,7 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define P_MII_MAC_MODE			BIT(2)
 #define P_MII_SEL_M			0x3
 
-/* KSZ9477, KSZ8795 Wake-on-LAN (WoL) masks */
+/* KSZ9477, KSZ87xx Wake-on-LAN (WoL) masks */
 #define PME_WOL_MAGICPKT		BIT(2)
 #define PME_WOL_LINKUP			BIT(1)
 #define PME_WOL_ENERGY			BIT(0)
@@ -712,6 +713,9 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define PME_ENABLE			BIT(1)
 #define PME_POLARITY			BIT(0)
 
+#define KSZ87XX_REG_INT_EN		0x7D
+#define KSZ87XX_INT_PME_MASK		BIT(4)
+
 /* Interrupt */
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
-- 
2.43.0


