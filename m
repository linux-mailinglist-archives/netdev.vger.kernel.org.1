Return-Path: <netdev+bounces-117764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1064394F1B9
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD64282170
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8818754D;
	Mon, 12 Aug 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUWIAAcA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07020187339;
	Mon, 12 Aug 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476648; cv=none; b=XEc0CsmrsNI9CPLeoFGV18baMWJ8ZwebZkMN5t9+7CaV+dAQebxR/bJjmhKTKmKoARfjUS87K74IeCP+uK28bJPt85v48FYznjTvp2mdsh5mYGaGaFuJ6dB3QFF+RSLvoN9NK/NL4xMVzJLrJpZ7cxmbGmEH4mLGqpPevldkHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476648; c=relaxed/simple;
	bh=aoGG5sVhLE9ME+bAQqIWjm3N0qUkcvEkfW51zHhShbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOPEDlNTcrzsGi+YpH/ripFD9lzBvxf92+j0dIuZyU5HAjDrN+nq63KPMBA11vbVDVyNj5fMiT1rcCoTH8fojC76nSdX9Aa8l3ej3sA7ZKHHdhpjCuF2q7AKcP5/Opm1J2AqJDcA9TNtofT26VHMhvkZHQY9M2q3yw+H3k/YI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUWIAAcA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso5016556a12.0;
        Mon, 12 Aug 2024 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476644; x=1724081444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0dC3mF4X+wKSKxy8Scoq+dO1j2v1I2jrAKLTICnCSQ=;
        b=PUWIAAcAFQNu91REBHJXO72QDWP4lP5L0IGl1c2QmiHn1JlJsVWCJMsXBS+TRH4UpT
         AZyNlhOqBgijbzeq19KrpIJB0MCW9sPRl/JhW4XmkbLdWvPYmvTtpqlHokbc7uK7JiqN
         qgNAc4fhqtZty1qFtUubnx0UhXYnXDWk+CZ3HJOkYrXvUd9VdOjOBaegfE0NMRfX+pX2
         /Hg9b2ZWdsxE73ZIka9fnbGcEoClflIVXilgDLIl57fCtMOaFjbkvicBSP99mYAA/9PV
         UGfhvIIa4SMfdz7/Ot5hx9spEk20dG/25Fcl6QHbSI0S9M63/6NoHp8tCIUp5M1rc+vH
         1YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476644; x=1724081444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0dC3mF4X+wKSKxy8Scoq+dO1j2v1I2jrAKLTICnCSQ=;
        b=ky/ATqGwv+ehdDynwruJIXZoPdYzZcQFK1wXGCJYDgSn6D6RVcCRq26cJNr/ZTsmkA
         H4FEJvxa2x3YAd90+U5k6CqulsYlLx/uupO7KpSe/WiKQdcoulBQOuIQC+GrtkItWeNz
         8I5Rzu/IfTQBoTzRXu65RiwJTXxn/WIaWGOKIwkc0LtEVtk78ffGx5FH8E0EtX0UbFl2
         pRwQ/RG1QapKgePr/mof6orm2i7rGHyp7uY8YbD7Nmx3E2A7Jthahfe8vTzRtvGeWVME
         +1u0xKzIjt/hw3Kn+qZvAq4/30k09weQHofaT1K7cIM2YdxolRj+LGvjATOPCGAd3PYi
         IU1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFAVrwP6PrrXpHI++URTEgr0gdMs3NFmmyKQfyoZKd1Xax3G0Zp+h7BnRU+5nt0L5Vvs0HDKtygLFry9fDocRqmzwYc9oJsKkXdwZpOemm3S9vlFjwYuLXSX5PkWPO8cyZcDpGKeD7nxUxIAuL2MnoHDVaPhpQZqr1usDUpPsyhw==
X-Gm-Message-State: AOJu0Yy3YPw1NJm9juYjSyqoh/KlFaIbWrKvTHjcNlPLXhdbSfYsQLFH
	tNNGO7OK8CEp9v02HefuDYaHRASmIrTOTBjw6RSi4wmBZ6hE7Ig8CKegUCPlVzz/dg==
X-Google-Smtp-Source: AGHT+IGc7Ax6Rx/zx7X/Z5EkMCe3vExcPsgjvqIe734zHii7qlFLAVkadO98nekw6OtHVqAmpi/Grg==
X-Received: by 2002:a05:6402:d06:b0:5a2:2654:7fd1 with SMTP id 4fb4d7f45d1cf-5bd44c78c9bmr398115a12.36.1723476644075;
        Mon, 12 Aug 2024 08:30:44 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2192535a12.46.2024.08.12.08.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:30:43 -0700 (PDT)
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
Subject: [PATCH net-next v5 4/6] net: dsa: microchip: add WoL support for KSZ87xx family
Date: Mon, 12 Aug 2024 17:29:55 +0200
Message-ID: <20240812153015.653044-5-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812153015.653044-1-vtpieter@gmail.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
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


