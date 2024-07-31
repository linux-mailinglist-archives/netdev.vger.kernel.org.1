Return-Path: <netdev+bounces-114505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C32942C0C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795FA1C2321E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB91AD9DD;
	Wed, 31 Jul 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8L5ogCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED21A8C0C;
	Wed, 31 Jul 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422066; cv=none; b=GbxIFif5lTqoVkhj+YBr9vFkdE4zmvPkMK5gOQ9H0FZOvLAlZQxHNiYQd5Ptk0PMF7Rru/opOPp9reYn6HJq5MEfTT+si5PLlZS4P02bRVrPQ7+uElnRXgqWr8+5bEy6z+s3XV4UKX0Y9RJUPuDXrJF+H2XmWJzDVHsWQSxAsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422066; c=relaxed/simple;
	bh=yDH4Bsjg/RtmJcPOiV89UQcWprC1s5pnRTk6ElHf9Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNAyYRkx+9OWSyiKTJhL+r3R0fjNro8fSIbiWDO2c8To3Ku9lgrC0DGUl/IBowZT5YR5iresVj7gEtt25WpCfK5Cgl8US2Ampj7rlLx+ozcGiStwnfogcjOjTyMZqnoryZ0+UFZoD0s4K2AS06KiT+X4u/qM5ftF9UP/jtPX/kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8L5ogCa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9e25008aso735479966b.0;
        Wed, 31 Jul 2024 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422063; x=1723026863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yx7z6YHRCHQ0GpltuRt0NVqpjHgJTOjWN1OtVJ6pBc=;
        b=V8L5ogCaTFArgfbshYDtQbCR9PraClkX5D9LNBTxdH5lUUvn1/nxhujjcSbmoQauL2
         2ZD42iCTd6u8V/tzz8/eR6exf5e5c/rdZIuYqVYyBWZmLWZ4nPvtn3tlrC3/QipCq/ME
         mt7oouRzNusiCdfWQbwHVSg1ToYORTgn3bY2WzcnxZ6phuQJILHwXMZSUAGuIpqPqIus
         4POVU0UaoTAPt2C9Do60BV8TSWCNt5gZzQ21Cy7ln60Ywrg8O1y0tQUNwQ00+8VaWCso
         yxhsc5dJFcweLxgNk2yczwgTdoCu6Gt2mCEtALIiruQCwaBu0B7D4BYpUkEWAodTkhIn
         MnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422063; x=1723026863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yx7z6YHRCHQ0GpltuRt0NVqpjHgJTOjWN1OtVJ6pBc=;
        b=qipekOjsz+ARvgMWEoX7Qj19asezeaKSAebMZutk+w6iX3oVCK4o85c1YskdT09E7i
         uSr8BCcWUM3k1bYMmYKSYziZN/ArYpdb/ESpLzaDb8CGxehIbf6Djebabzvhwde+lPCn
         3PCxVUVVtl/Ot2RQebd9NeOeiq7G7RA14fFTYE6j+E8EL4/DxtbjamCWh7jr2c74xcbM
         L6f7X+6gkujutnWEiPcYN7x8tPuHfQa//kXzcsvD6szfwIF1jj3hVAX6tsRBIaOrcl/c
         Pfk5lla5t1DORNbHNIXJhBvNBtOFnJCC2GhmKQ3Ndcyk9RtoS/p+iJF6hCrLGJWBbfbs
         PkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW/oZsrTzGM5950Am3S8qqwG7+MrC2E/iMQ2J4MXrRinSJqiGObVaX5p3uS0qa4waeDjuOQJ2mAPeIloHD7sASESX3h+lE
X-Gm-Message-State: AOJu0YzRymmFDhM/VK6c3nKH3tUtGbcb/3TMXFJIV6ADqK3N8Pi/yIUR
	zZpmurSK1sD0n40R0SKe2ZfKFiBhd8jm8Qy5sX6z9mmfxI4CAau3QSvS6mHblAs=
X-Google-Smtp-Source: AGHT+IFOzfWfsW6jhyg75QTkvg7n0B854WoDvmkyeltDqsgvmz/+o6PI+nF48JvOUQOzg+yCeqFLvA==
X-Received: by 2002:a17:907:9694:b0:a77:cb8b:7a2d with SMTP id a640c23a62f3a-a7d4016612fmr1084721366b.49.1722422063133;
        Wed, 31 Jul 2024 03:34:23 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:22 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 4/5] net: dsa: microchip: add WoL support for KSZ87xx family
Date: Wed, 31 Jul 2024 12:34:02 +0200
Message-ID: <20240731103403.407818-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731103403.407818-1-vtpieter@gmail.com>
References: <20240731103403.407818-1-vtpieter@gmail.com>
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
 drivers/net/dsa/microchip/ksz8795.c    | 86 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.c | 29 ++++++---
 drivers/net/dsa/microchip/ksz_common.h |  4 ++
 4 files changed, 115 insertions(+), 7 deletions(-)

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
index d27b9c36d73f..8fe423044109 100644
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
@@ -1790,6 +1865,7 @@ int ksz8_enable_stp_addr(struct ksz_device *dev)
 int ksz8_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	int i;
 
 	ds->mtu_enforcement_ingress = true;
@@ -1829,6 +1905,16 @@ int ksz8_setup(struct dsa_switch *ds)
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
 		ksz8_r_vlan_entries(dev, i);
 
+	/* Make sure PME (WoL) is not enabled. If requested, it will
+	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
+	 * do not like PME events changes before shutdown. PME only
+	 * available on KSZ87xx family.
+	 */
+	if (ksz_is_ksz87xx(dev)) {
+		ksz8_pme_write8(dev, regs[REG_SW_PME_CTRL], 0);
+		ksz_rmw8(dev, REG_INT_ENABLE, INT_PME, 0);
+	}
+
 	return ksz8_handle_global_errata(ds);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e5358da8cbeb..02595ac10934 100644
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
@@ -3752,7 +3758,7 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
 	u8 pme_ctrl;
 	int ret;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
 	if (!dev->wakeup_source)
@@ -3805,7 +3811,7 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return -EOPNOTSUPP;
 
 	if (!dev->wakeup_source)
@@ -3905,13 +3911,15 @@ int ksz_handle_wake_reason(struct ksz_device *dev, int port)
  */
 static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 {
+	const struct ksz_dev_ops *ops = dev->dev_ops;
 	const u16 *regs = dev->info->regs;
+	u8 pme_pin_en = PME_ENABLE;
 	struct dsa_port *dp;
 	int ret;
 
 	*wol_enabled = false;
 
-	if (!is_ksz9477(dev))
+	if (!is_ksz9477(dev) && !ksz_is_ksz87xx(dev))
 		return;
 
 	if (!dev->wakeup_source)
@@ -3920,8 +3928,8 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	dsa_switch_for_each_user_port(dp, dev->ds) {
 		u8 pme_ctrl = 0;
 
-		ret = dev->dev_ops->pme_pread8(dev, dp->index,
-					       regs[REG_PORT_PME_CTRL], &pme_ctrl);
+		ret = ops->pme_pread8(dev, dp->index,
+				      regs[REG_PORT_PME_CTRL], &pme_ctrl);
 		if (!ret && pme_ctrl)
 			*wol_enabled = true;
 
@@ -3932,8 +3940,13 @@ static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 	}
 
 	/* Now we are save to enable PME pin. */
-	if (*wol_enabled)
-		dev->dev_ops->pme_write8(dev, regs[REG_SW_PME_CTRL], PME_ENABLE);
+	if (*wol_enabled) {
+		if (dev->pme_active_high)
+			pme_pin_en |= PME_POLARITY;
+		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], pme_pin_en);
+		if (ksz_is_ksz87xx(dev))
+			ksz_write8(dev, KSZ8795_REG_INT_EN, KSZ8795_INT_PME_MASK);
+	}
 }
 
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
@@ -4643,6 +4656,8 @@ int ksz_switch_register(struct ksz_device *dev)
 
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


