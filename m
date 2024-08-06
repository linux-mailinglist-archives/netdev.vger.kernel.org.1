Return-Path: <netdev+bounces-116097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EBA94916D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA771F256B9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DFC1D27A0;
	Tue,  6 Aug 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPW5H1Xe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8F1D1F4E;
	Tue,  6 Aug 2024 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950918; cv=none; b=lYcV7ZJbB7Cg0BngKUId8+Zy4S461yUzysIplIaSM/9VGhNUCN33oogozzMSTDnQmzSEG+ECSmqSE46+WMUBKV8ooDqYk28LwoRl0GFyxgP+BQGyAvhS7X9MwbwbswHxufy2KGw8ho6T+86DvKEqAWdVDnmMwPO0SXAfWXpi5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950918; c=relaxed/simple;
	bh=Frwqk6NSEs7lG01B9dEfQKQl8UB9zNOVLB5mcyrHtOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnRYpMNw5vBYKjJ2Yg7HQl25moK29y8DfvW+FketP9dAmYVpD2oTlN9iY+Lsc7vYrfLF4aMp90dJxyI0V2ZPmGDORT1S6aF6U2YORPwqTIwRa4w6/WCBqe0RmzS5WwpHdLA2uzaaz1n/nVhg2BjD0UhWdwTGORq9y4E/mkBvK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPW5H1Xe; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso992878a12.1;
        Tue, 06 Aug 2024 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950915; x=1723555715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8UI01DTINAyVuDQJb9qJI6xEuB4xVDUsc3vnutKq5Q=;
        b=VPW5H1XeVP8TUJwyT4gHCPfo7VSW65+egiMg+WaUZoS0ZV4JJ9KcPR9oMh7kxTD8A2
         QR4JdZN25kHzcYJdIM5gt4eVyTJixfTE37rQADn4WPWp1AbrGL8ymKy1jWn5zt8E+Mlh
         ZzvK3zcoBz9uVgP9Ro+U/0ACDokG/GOV1zJ+bigCoQLrq9ngmbzLg96PKHbozaxDlh0U
         pQtfyBpT/F+zE0LHIbYa8FyC/yRC88ZJPDVVIyYq7YcG2O0splgfKoeVgI6bXdDNkcVS
         unjiK/kiopOZxu1x+3XavUrDtCwyZi849I5CccRRm9X7qQ0X9vcgT4TTMQVulsDMu6/F
         hNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950915; x=1723555715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8UI01DTINAyVuDQJb9qJI6xEuB4xVDUsc3vnutKq5Q=;
        b=gs4dECIMlT6kJhprE8TDg2K/YXoJK1ehelb8IM6010tjrJaxjFy7tn+qdx71nvNDAC
         Lab4QohcvlDarSyu5r/YBDi2NpbtvQ7w1LkA0si9BVRGEBLD/mJMaD3+nDwT1rOGv/Ew
         HhADS0Ks4qzrkRvArwJlPrN9uoJmJVncf5mV2xlVuiMGQ1Gd5hus6s+VI/YLMsPT8Uxd
         Kvy12xfegT8Y+KoZYU8fwDhVeSb9putMwIGtOZNG+JMkMaHLsgEkL5xW44SR/WQJ2TIp
         r7Cg6fk5YFuY4sZCpzhDe9bsJ+skcFShvK3q1ypvUFbt8gywILKW/x+gGlR7TEZGotC/
         UdcA==
X-Forwarded-Encrypted: i=1; AJvYcCWl5LKGWcN7Xrlt/0LIVGDFlfrpFSVbpgLjfmhAFobgJpoZk8jh20A1YyXwgre04XEhIh4wS0vGOO5DGAsgh0gu2AT52aByNYv5Vej6bi90pupF+5Jf2KfVoQQaYg3YAKgHG2L55eFrlEnso29+D4PUem5egJuJSoUHH8CqKOEf4w==
X-Gm-Message-State: AOJu0Ywio+99LqfFLw4mXWZcRQFvEQXuJY2FDQkk0vENN7wL7pd6KsG4
	axIgdC69ek52Xbuegr3BrZu37Cicyb2LTj6FEGclsx7ir4Q3xslx
X-Google-Smtp-Source: AGHT+IEyKsQYGznSxl3WVlLekkpnyIGIspd/ssaUyT4P+DgA/rfVAkCqtUk4UZ7r1HfaYMJITkE9WA==
X-Received: by 2002:a05:6402:18c:b0:5af:c82a:7f6d with SMTP id 4fb4d7f45d1cf-5b7f3faf475mr9975005a12.20.1722950914292;
        Tue, 06 Aug 2024 06:28:34 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::102:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm5910172a12.53.2024.08.06.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:28:33 -0700 (PDT)
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
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 2/5] net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
Date: Tue,  6 Aug 2024 15:25:54 +0200
Message-ID: <20240806132606.1438953-3-vtpieter@gmail.com>
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

Move KSZ9477 WoL functions to ksz_common, in preparation for adding
KSZ87xx family support.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz9477.c     | 181 ------------------------
 drivers/net/dsa/microchip/ksz9477.h     |   5 -
 drivers/net/dsa/microchip/ksz9477_reg.h |  12 --
 drivers/net/dsa/microchip/ksz_common.c  | 181 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h  |  19 +++
 5 files changed, 200 insertions(+), 198 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 425e20daf1e9..071d953a17e9 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -56,187 +56,6 @@ int ksz9477_change_mtu(struct ksz_device *dev, int port, int mtu)
 				  REG_SW_MTU_MASK, frame_size);
 }
 
-/**
- * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
- * @dev: The device structure.
- * @port: The port number.
- *
- * This function reads the PME (Power Management Event) status register of a
- * specified port to determine the wake reason. If there is no wake event, it
- * returns early. Otherwise, it logs the wake reason which could be due to a
- * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
- * is then cleared to acknowledge the handling of the wake event.
- *
- * Return: 0 on success, or an error code on failure.
- */
-static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
-{
-	u8 pme_status;
-	int ret;
-
-	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
-	if (ret)
-		return ret;
-
-	if (!pme_status)
-		return 0;
-
-	dev_dbg(dev->dev, "Wake event on port %d due to:%s%s%s\n", port,
-		pme_status & PME_WOL_MAGICPKT ? " \"Magic Packet\"" : "",
-		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
-		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
-
-	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
-}
-
-/**
- * ksz9477_get_wol - Get Wake-on-LAN settings for a specified port.
- * @dev: The device structure.
- * @port: The port number.
- * @wol: Pointer to ethtool Wake-on-LAN settings structure.
- *
- * This function checks the PME Pin Control Register to see if  PME Pin Output
- * Enable is set, indicating PME is enabled. If enabled, it sets the supported
- * and active WoL flags.
- */
-void ksz9477_get_wol(struct ksz_device *dev, int port,
-		     struct ethtool_wolinfo *wol)
-{
-	u8 pme_ctrl;
-	int ret;
-
-	if (!dev->wakeup_source)
-		return;
-
-	wol->supported = WAKE_PHY;
-
-	/* Check if the current MAC address on this port can be set
-	 * as global for WAKE_MAGIC support. The result may vary
-	 * dynamically based on other ports configurations.
-	 */
-	if (ksz_is_port_mac_global_usable(dev->ds, port))
-		wol->supported |= WAKE_MAGIC;
-
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
-	if (ret)
-		return;
-
-	if (pme_ctrl & PME_WOL_MAGICPKT)
-		wol->wolopts |= WAKE_MAGIC;
-	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
-		wol->wolopts |= WAKE_PHY;
-}
-
-/**
- * ksz9477_set_wol - Set Wake-on-LAN settings for a specified port.
- * @dev: The device structure.
- * @port: The port number.
- * @wol: Pointer to ethtool Wake-on-LAN settings structure.
- *
- * This function configures Wake-on-LAN (WoL) settings for a specified port.
- * It validates the provided WoL options, checks if PME is enabled via the
- * switch's PME Pin Control Register, clears any previous wake reasons,
- * and sets the Magic Packet flag in the port's PME control register if
- * specified.
- *
- * Return: 0 on success, or other error codes on failure.
- */
-int ksz9477_set_wol(struct ksz_device *dev, int port,
-		    struct ethtool_wolinfo *wol)
-{
-	u8 pme_ctrl = 0, pme_ctrl_old = 0;
-	bool magic_switched_off;
-	bool magic_switched_on;
-	int ret;
-
-	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
-		return -EINVAL;
-
-	if (!dev->wakeup_source)
-		return -EOPNOTSUPP;
-
-	ret = ksz9477_handle_wake_reason(dev, port);
-	if (ret)
-		return ret;
-
-	if (wol->wolopts & WAKE_MAGIC)
-		pme_ctrl |= PME_WOL_MAGICPKT;
-	if (wol->wolopts & WAKE_PHY)
-		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
-
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl_old);
-	if (ret)
-		return ret;
-
-	if (pme_ctrl_old == pme_ctrl)
-		return 0;
-
-	magic_switched_off = (pme_ctrl_old & PME_WOL_MAGICPKT) &&
-			    !(pme_ctrl & PME_WOL_MAGICPKT);
-	magic_switched_on = !(pme_ctrl_old & PME_WOL_MAGICPKT) &&
-			    (pme_ctrl & PME_WOL_MAGICPKT);
-
-	/* To keep reference count of MAC address, we should do this
-	 * operation only on change of WOL settings.
-	 */
-	if (magic_switched_on) {
-		ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
-		if (ret)
-			return ret;
-	} else if (magic_switched_off) {
-		ksz_switch_macaddr_put(dev->ds);
-	}
-
-	ret = ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
-	if (ret) {
-		if (magic_switched_on)
-			ksz_switch_macaddr_put(dev->ds);
-		return ret;
-	}
-
-	return 0;
-}
-
-/**
- * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while
- *                            considering Wake-on-LAN (WoL) settings.
- * @dev: The switch device structure.
- * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
- *               enabled on any port.
- *
- * This function prepares the switch device for a safe shutdown while taking
- * into account the Wake-on-LAN (WoL) settings on the user ports. It updates
- * the wol_enabled flag accordingly to reflect whether WoL is active on any
- * port.
- */
-void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
-{
-	struct dsa_port *dp;
-	int ret;
-
-	*wol_enabled = false;
-
-	if (!dev->wakeup_source)
-		return;
-
-	dsa_switch_for_each_user_port(dp, dev->ds) {
-		u8 pme_ctrl = 0;
-
-		ret = ksz_pread8(dev, dp->index, REG_PORT_PME_CTRL, &pme_ctrl);
-		if (!ret && pme_ctrl)
-			*wol_enabled = true;
-
-		/* make sure there are no pending wake events which would
-		 * prevent the device from going to sleep/shutdown.
-		 */
-		ksz9477_handle_wake_reason(dev, dp->index);
-	}
-
-	/* Now we are save to enable PME pin. */
-	if (*wol_enabled)
-		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
-}
-
 static int ksz9477_wait_vlan_ctrl_ready(struct ksz_device *dev)
 {
 	unsigned int val;
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index 239a281da10b..d2166b0d881e 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -60,11 +60,6 @@ void ksz9477_switch_exit(struct ksz_device *dev);
 void ksz9477_port_queue_split(struct ksz_device *dev, int port);
 void ksz9477_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr);
 void ksz9477_hsr_leave(struct dsa_switch *ds, int port, struct net_device *hsr);
-void ksz9477_get_wol(struct ksz_device *dev, int port,
-		     struct ethtool_wolinfo *wol);
-int ksz9477_set_wol(struct ksz_device *dev, int port,
-		    struct ethtool_wolinfo *wol);
-void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled);
 
 int ksz9477_port_acl_init(struct ksz_device *dev, int port);
 void ksz9477_port_acl_free(struct ksz_device *dev, int port);
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index d5354c600ea1..04235c22bf40 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -38,11 +38,6 @@
 #define SWITCH_REVISION_S		4
 #define SWITCH_RESET			0x01
 
-#define REG_SW_PME_CTRL			0x0006
-
-#define PME_ENABLE			BIT(1)
-#define PME_POLARITY			BIT(0)
-
 #define REG_GLOBAL_OPTIONS		0x000F
 
 #define SW_GIGABIT_ABLE			BIT(6)
@@ -807,13 +802,6 @@
 #define REG_PORT_AVB_SR_1_TYPE		0x0008
 #define REG_PORT_AVB_SR_2_TYPE		0x000A
 
-#define REG_PORT_PME_STATUS		0x0013
-#define REG_PORT_PME_CTRL		0x0017
-
-#define PME_WOL_MAGICPKT		BIT(2)
-#define PME_WOL_LINKUP			BIT(1)
-#define PME_WOL_ENERGY			BIT(0)
-
 #define REG_PORT_INT_STATUS		0x001B
 #define REG_PORT_INT_MASK		0x001F
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..6ff39243443f 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3740,6 +3740,77 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
 		dev->dev_ops->get_wol(dev, port, wol);
 }
 
+/**
+ * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ *
+ * This function reads the PME (Power Management Event) status register of a
+ * specified port to determine the wake reason. If there is no wake event, it
+ * returns early. Otherwise, it logs the wake reason which could be due to a
+ * "Magic Packet", "Link Up", or "Energy Detect" event. The PME status register
+ * is then cleared to acknowledge the handling of the wake event.
+ *
+ * Return: 0 on success, or an error code on failure.
+ */
+int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
+{
+	u8 pme_status;
+	int ret;
+
+	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
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
+	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
+}
+
+/**
+ * ksz9477_get_wol - Get Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function checks the PME Pin Control Register to see if  PME Pin Output
+ * Enable is set, indicating PME is enabled. If enabled, it sets the supported
+ * and active WoL flags.
+ */
+void ksz9477_get_wol(struct ksz_device *dev, int port,
+		     struct ethtool_wolinfo *wol)
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
+	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
+	if (ret)
+		return;
+
+	if (pme_ctrl & PME_WOL_MAGICPKT)
+		wol->wolopts |= WAKE_MAGIC;
+	if (pme_ctrl & (PME_WOL_LINKUP | PME_WOL_ENERGY))
+		wol->wolopts |= WAKE_PHY;
+}
+
 static int ksz_set_wol(struct dsa_switch *ds, int port,
 		       struct ethtool_wolinfo *wol)
 {
@@ -3751,6 +3822,116 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ksz9477_set_wol - Set Wake-on-LAN settings for a specified port.
+ * @dev: The device structure.
+ * @port: The port number.
+ * @wol: Pointer to ethtool Wake-on-LAN settings structure.
+ *
+ * This function configures Wake-on-LAN (WoL) settings for a specified port.
+ * It validates the provided WoL options, checks if PME is enabled via the
+ * switch's PME Pin Control Register, clears any previous wake reasons,
+ * and sets the Magic Packet flag in the port's PME control register if
+ * specified.
+ *
+ * Return: 0 on success, or other error codes on failure.
+ */
+int ksz9477_set_wol(struct ksz_device *dev, int port,
+		    struct ethtool_wolinfo *wol)
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
+	ret = ksz9477_handle_wake_reason(dev, port);
+	if (ret)
+		return ret;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		pme_ctrl |= PME_WOL_MAGICPKT;
+	if (wol->wolopts & WAKE_PHY)
+		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
+
+	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl_old);
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
+	ret = ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
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
+ * port.
+ */
+void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+{
+	struct dsa_port *dp;
+	int ret;
+
+	*wol_enabled = false;
+
+	if (!dev->wakeup_source)
+		return;
+
+	dsa_switch_for_each_user_port(dp, dev->ds) {
+		u8 pme_ctrl = 0;
+
+		ret = ksz_pread8(dev, dp->index, REG_PORT_PME_CTRL, &pme_ctrl);
+		if (!ret && pme_ctrl)
+			*wol_enabled = true;
+
+		/* make sure there are no pending wake events which would
+		 * prevent the device from going to sleep/shutdown.
+		 */
+		ksz9477_handle_wake_reason(dev, dp->index);
+	}
+
+	/* Now we are save to enable PME pin. */
+	if (*wol_enabled)
+		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
+}
+
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
 				    const unsigned char *addr)
 {
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..e35caca96f89 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -391,6 +391,12 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack);
 void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
+int ksz9477_handle_wake_reason(struct ksz_device *dev, int port);
+void ksz9477_get_wol(struct ksz_device *dev, int port,
+		     struct ethtool_wolinfo *wol);
+int ksz9477_set_wol(struct ksz_device *dev, int port,
+		    struct ethtool_wolinfo *wol);
+void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
@@ -695,6 +701,19 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define P_MII_MAC_MODE			BIT(2)
 #define P_MII_SEL_M			0x3
 
+/* KSZ9477, KSZ8795 Wake-on-LAN (WoL) masks */
+#define REG_PORT_PME_STATUS		0x0013
+#define REG_PORT_PME_CTRL		0x0017
+
+#define PME_WOL_MAGICPKT		BIT(2)
+#define PME_WOL_LINKUP			BIT(1)
+#define PME_WOL_ENERGY			BIT(0)
+
+#define REG_SW_PME_CTRL			0x0006
+
+#define PME_ENABLE			BIT(1)
+#define PME_POLARITY			BIT(0)
+
 /* Interrupt */
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
-- 
2.43.0


