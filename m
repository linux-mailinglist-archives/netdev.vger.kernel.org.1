Return-Path: <netdev+bounces-111929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100619342A5
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 21:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825ED1F230D6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14833997;
	Wed, 17 Jul 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI4aUz+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240B1B5A4;
	Wed, 17 Jul 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721245074; cv=none; b=N1gVpp7pbofiQ0oTnIxWJyCrzqvh7QBK0c04m1+7y7tpkOk1zOHoZB1SBZH0rvNEwz00qbGDIYRZTozYJDU4pN4GRHQDSu/Jnoq4cd59nP3zSRxse6Amn409rB6ujZq3JaFbBi6X9fIcyjUB4rvpgbqcAjGZ7iaX7i9UtBslz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721245074; c=relaxed/simple;
	bh=Cxdfl5SZYIz7AINxAAAZry96BVr3NH1SKP2MJvA8wKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIAZKvH9FQhpVw/pKNkwkSO/EwH1EuemULoqa0yb7bkKI6zqeUF9iHwgWYnOvySjuydsoB/UyDHUfNgMcwGlWphTuPHsr+3M7OawIbRfentpqOB61cyS38VymZmohxhOvi6hRkHPFs8Bwlt4n/M3ueQoPxqwl4gsyOEw63nGiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI4aUz+N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so6760a12.2;
        Wed, 17 Jul 2024 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721245070; x=1721849870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBrxusy9Bt9tWm0IlxqJAZIoNJ5X7fosvSwGTdlLGeM=;
        b=PI4aUz+NJt9W0tA+j8CH2MrIlyBeQCNkUXWVp4irDF2BKAderNPHPXh+HZezoBk2SD
         e9hQpFnw5B8BT1RQEyz2KFgcwdXnCDtLYNDgFsaYwE/8xjlAvJY75wOGHH0zBO+d3z1n
         7hkHg0epoFTYmCluK190grdX0/AOSeOTxTNklsg1UAClAL+chu6QfyQ6E87CqHRmNBNc
         GkrOa+iR+oBIoBjRgCBtR4eTwMG9VLe9Y+EyezSDk8bX/1A6f4vKVjclCmNWygQ6DW8i
         NA4X7RLbr4L1GPkNVnsfVVl5gulTu1TNN2yPtt1oj+0NKhHgNE2lbmxvBA0IcNrY038Y
         SSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721245070; x=1721849870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBrxusy9Bt9tWm0IlxqJAZIoNJ5X7fosvSwGTdlLGeM=;
        b=Wb/lenHOCimCLRhF8PuxDgPekZSNDbCXaMm0iRkk6YieROntwc+MoJ2VxFevidUGEj
         RkUZmfjMFNO//VsLOki518oJpQxYlRMloN9CEW/eHs2B7Us4NOzDFIIbsuGoo0r9I5+V
         y2c0L+EEQEBYS8jQvQgzdJqg1HUNDl4TQb7/nrEk9t5IFjxEUQUCYh+uZh7QzfRVNZGF
         9/0xg1KmJn0NMHxmziAi5F23l5k5XcHyvNPwiFIGqKVd7v8+1zmMn5kLR8ukvNr/MbQe
         s+xkTsxUc0UsW5ZVcFfaD7980gTNei0hRE4lWw74n8v33K3QbBZyDBhJCz0sLcPetjDg
         2tXA==
X-Forwarded-Encrypted: i=1; AJvYcCVoQfhAHob6F3FlrpFKNSubtAVS2crLI3ZqZ76MB20Sk6P2XtLyyzm9UAYg4swPUBrUbCtX9XXnv15eiY25ItujZUkfkBKe
X-Gm-Message-State: AOJu0YwR9ATCDdNRa8MD5HYvcio+GzI5iVBz7o64eP5Kx08Yrcwh+KFi
	R7V4nHxWCnibPlKbJ7AsgSDDIcJ1hWDp/0Geof0J87cIRif83nE5wXfpIXq/
X-Google-Smtp-Source: AGHT+IHKv8JxERvaMdboGp/XvM1xTPDNh3IfHrERTDVDf6o93ZYU8Ikj75D5+FdPSdIIvk9SuS+xmw==
X-Received: by 2002:a05:6402:50cd:b0:57c:c3aa:6c68 with SMTP id 4fb4d7f45d1cf-5a05bcc70admr2525224a12.20.1721245070384;
        Wed, 17 Jul 2024 12:37:50 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::101:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59f7464d40asm3080535a12.68.2024.07.17.12.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:37:50 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH 2/4] net: dsa: microchip: ksz8795: add Wake on LAN support
Date: Wed, 17 Jul 2024 21:37:23 +0200
Message-ID: <20240717193725.469192-3-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717193725.469192-2-vtpieter@gmail.com>
References: <20240717193725.469192-1-vtpieter@gmail.com>
 <20240717193725.469192-2-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add WoL support for KSZ8795 family of switches. This code was tested
with a KSZ8794 chip.

KSZ8795 family of switches supports multiple PHY events:
- wake on Link Up
- wake on Energy Detect.
- wake on Magic Packet.
Since current UAPI can't differentiate between Link Up and Energy
Detect, map these to WAKE_PHY.

Strongly based on existing KSZ9477 code but there's too many
differences, such as the indirect register access, to generalize this
code to ksz_common. Some registers names have been changed to increase
standardization between those code bases.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz8.h        |   5 +
 drivers/net/dsa/microchip/ksz8795.c     | 220 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz8795_reg.h |  13 +-
 drivers/net/dsa/microchip/ksz_common.c  |   5 +
 drivers/net/dsa/microchip/ksz_common.h  |   1 +
 5 files changed, 239 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index ae43077e76c3..4cece61181e9 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -59,5 +59,10 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
 int ksz8_all_queues_split(struct ksz_device *dev, int queues);
+void ksz8_get_wol(struct ksz_device *dev, int port,
+		  struct ethtool_wolinfo *wol);
+int ksz8_set_wol(struct ksz_device *dev, int port,
+		 struct ethtool_wolinfo *wol);
+void ksz8_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled);
 
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d27b9c36d73f..49081e9a8cb0 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -58,6 +58,26 @@ static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 	return ret;
 }
 
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
 int ksz8_reset_switch(struct ksz_device *dev)
 {
 	if (ksz_is_ksz88x3(dev)) {
@@ -127,6 +147,200 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ksz8_handle_wake_reason - Handle wake reason on a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ *
+ * This function reads the PME (Power Management Event) status register of a
+ * specified port to determine the wake reason. If there is no wake event, it
+ * returns early. Otherwise, it logs the wake reason which could be due to a
+ * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
+ * is then cleared to acknowledge the handling of the wake event; followed by
+ * clearing the global Interrupt Status Register.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+static int ksz8_handle_wake_reason(struct ksz_device *dev, int port)
+{
+	u8 pme_status;
+	int ret;
+
+	ret = ksz8_ind_read8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_STATUS, &pme_status);
+	if (ret)
+		return ret;
+
+	if (!pme_status)
+		return 0;
+
+	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
+		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
+		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
+		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
+
+	ret = ksz8_ind_write8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_STATUS, pme_status);
+	if (ret)
+		return ret;
+
+	ksz_read8(dev, REG_INT_STATUS, &pme_status);
+	return ksz_write8(dev, REG_INT_STATUS, pme_status && INT_PME);
+}
+
+/**
+ * ksz8_get_wol - Get Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function checks the PME 'wakeup-source' property from the
+ * device tree. If enabled, it sets the supported and active WoL
+ * flags.
+ */
+void ksz8_get_wol(struct ksz_device *dev, int port,
+		  struct ethtool_wolinfo *wol)
+{
+	u8 pme_ctrl;
+	int ret;
+
+	if (!dev->wakeup_source)
+		return;
+
+	wol->supported = WAKE_PHY;
+
+	/* Check if the current MAC address on this port can be set
+	 * as global for WAKE_MAGIC support. The result may vary
+	 * dynamically based on other ports configurations.
+	 */
+	if (ksz_is_port_mac_global_usable(dev->ds, port))
+		wol->supported |= WAKE_MAGIC;
+
+	ret = ksz8_ind_read8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_CTRL, &pme_ctrl);
+	if (ret)
+		return;
+
+	if (pme_ctrl & PME_WOL_MAGICPKT)
+		wol->wolopts |= WAKE_MAGIC;
+	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
+		wol->wolopts |= WAKE_PHY;
+}
+
+/**
+ * ksz8_set_wol - Set Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function configures Wake-on-LAN (WoL) settings for a specified port.
+ * It validates the provided WoL options, checks if PME is enabled via the
+ * switch's device tree property, clears any previous wake reasons,
+ * and sets the Magic Packet flag in the port's PME control register if
+ * specified.
+ *
+ * Return: 0 on success, or other error codes on failure.
+ */
+int ksz8_set_wol(struct ksz_device *dev, int port,
+		 struct ethtool_wolinfo *wol)
+{
+	u8 pme_ctrl = 0, pme_ctrl_old = 0;
+	bool magic_switched_off;
+	bool magic_switched_on;
+	int ret;
+
+	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
+	if (!dev->wakeup_source)
+		return -EOPNOTSUPP;
+
+	ret = ksz8_handle_wake_reason(dev, port);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		pme_ctrl |= PME_WOL_MAGICPKT;
+	if (wol->wolopts & WAKE_PHY)
+		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
+
+	ret = ksz8_ind_read8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_CTRL, &pme_ctrl_old);
+	if (ret)
+		return ret;
+
+	if (pme_ctrl_old == pme_ctrl)
+		return 0;
+
+	magic_switched_off = (pme_ctrl_old & PME_WOL_MAGICPKT) &&
+			    !(pme_ctrl & PME_WOL_MAGICPKT);
+	magic_switched_on = !(pme_ctrl_old & PME_WOL_MAGICPKT) &&
+			    (pme_ctrl & PME_WOL_MAGICPKT);
+
+	/* To keep reference count of MAC address, we should do this
+	 * operation only on change of WOL settings.
+	 */
+	if (magic_switched_on) {
+		ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
+		if (ret)
+			return ret;
+	} else if (magic_switched_off) {
+		ksz_switch_macaddr_put(dev->ds);
+	}
+
+	ret = ksz8_ind_write8(dev, TABLE_PME_PORT(port), REG_IND_PORT_PME_CTRL, pme_ctrl);
+	if (ret) {
+		if (magic_switched_on)
+			ksz_switch_macaddr_put(dev->ds);
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while
+ *                            considering Wake-on-LAN (WoL) settings.
+ * @dev: The switch device structure.
+ * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
+ *               enabled on any port.
+ *
+ * This function prepares the switch device for a safe shutdown while taking
+ * into account the Wake-on-LAN (WoL) settings on the user ports. It updates
+ * the wol_enabled flag accordingly to reflect whether WoL is active on any
+ * port. It also sets the PME output pin enable with the polarity specified
+ * through the device-tree.
+ */
+void ksz8_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+{
+	struct dsa_port *dp;
+	int ret;
+	u8 pme_pin_en = SW_PME_OUTPUT_ENABLE;
+
+	*wol_enabled = false;
+
+	if (!dev->wakeup_source)
+		return;
+
+	dsa_switch_for_each_user_port(dp, dev->ds) {
+		u8 pme_ctrl = 0;
+
+		ret = ksz8_ind_read8(dev, TABLE_PME_PORT(dp->index),
+				     REG_IND_PORT_PME_CTRL, &pme_ctrl);
+		if (!ret && pme_ctrl)
+			*wol_enabled = true;
+
+		/* make sure there are no pending wake events which would
+		 * prevent the device from going to sleep/shutdown.
+		 */
+		ksz8_handle_wake_reason(dev, dp->index);
+	}
+
+	/* Now we are save to enable PME pin. */
+	if (*wol_enabled) {
+		if (dev->pme_active_high)
+			pme_pin_en |= SW_PME_ACTIVE_HIGH;
+		ksz8_ind_write8(dev, TABLE_PME, REG_IND_GLOB_PME_CTRL, pme_pin_en);
+		ksz_write8(dev, REG_INT_ENABLE, INT_PME);
+	}
+}
+
 static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
 	u8 mask_4q, mask_2q;
@@ -1829,6 +2043,12 @@ int ksz8_setup(struct dsa_switch *ds)
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
 		ksz8_r_vlan_entries(dev, i);
 
+	/* Make sure PME (WoL) is not enabled. If requested, it will be
+	 * enabled by ksz8_wol_pre_shutdown(). Otherwise, some PMICs do not
+	 * like PME events changes before shutdown.
+	 */
+	ksz_write8(dev, REG_INT_ENABLE, 0);
+
 	return ksz8_handle_global_errata(ds);
 }
 
diff --git a/drivers/net/dsa/microchip/ksz8795_reg.h b/drivers/net/dsa/microchip/ksz8795_reg.h
index 69566a5d9cda..884e899145dd 100644
--- a/drivers/net/dsa/microchip/ksz8795_reg.h
+++ b/drivers/net/dsa/microchip/ksz8795_reg.h
@@ -337,6 +337,7 @@
 #define TABLE_EEE			(TABLE_EEE_V << TABLE_EXT_SELECT_S)
 #define TABLE_ACL			(TABLE_ACL_V << TABLE_EXT_SELECT_S)
 #define TABLE_PME			(TABLE_PME_V << TABLE_EXT_SELECT_S)
+#define TABLE_PME_PORT(port)		(TABLE_PME | (u8)((port) + 1))
 #define TABLE_LINK_MD			(TABLE_LINK_MD << TABLE_EXT_SELECT_S)
 #define TABLE_READ			BIT(4)
 #define TABLE_SELECT_S			2
@@ -359,8 +360,6 @@
 #define REG_IND_DATA_1			0x77
 #define REG_IND_DATA_0			0x78
 
-#define REG_IND_DATA_PME_EEE_ACL	0xA0
-
 #define REG_INT_STATUS			0x7C
 #define REG_INT_ENABLE			0x7D
 
@@ -589,12 +588,16 @@
 
 /* PME */
 
+#define REG_IND_GLOB_PME_CTRL		0x3
+#define REG_IND_PORT_PME_STATUS		0x3
+#define REG_IND_PORT_PME_CTRL		0x7
+
 #define SW_PME_OUTPUT_ENABLE		BIT(1)
 #define SW_PME_ACTIVE_HIGH		BIT(0)
 
-#define PORT_MAGIC_PACKET_DETECT	BIT(2)
-#define PORT_LINK_UP_DETECT		BIT(1)
-#define PORT_ENERGY_DETECT		BIT(0)
+#define PME_WOL_MAGICPKT		BIT(2)
+#define PME_WOL_LINKUP			BIT(1)
+#define PME_WOL_ENERGY			BIT(0)
 
 /* ACL */
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..61403898c1f4 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -307,6 +307,9 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.init = ksz8_switch_init,
 	.exit = ksz8_switch_exit,
 	.change_mtu = ksz8_change_mtu,
+	.get_wol = ksz8_get_wol,
+	.set_wol = ksz8_set_wol,
+	.wol_pre_shutdown = ksz8_wol_pre_shutdown,
 };
 
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
@@ -4459,6 +4462,8 @@ int ksz_switch_register(struct ksz_device *dev)
 
 		dev->wakeup_source = of_property_read_bool(dev->dev->of_node,
 							   "wakeup-source");
+		dev->pme_active_high = of_property_read_bool(dev->dev->of_node,
+							     "microchip,pme-active-high");
 	}
 
 	ret = dsa_register_switch(dev->ds);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..1d7f2f18ee1f 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -174,6 +174,7 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 	bool wakeup_source;
+	bool pme_active_high;
 
 	struct vlan_table *vlan_cache;
 
-- 
2.43.0


