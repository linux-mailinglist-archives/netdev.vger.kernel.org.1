Return-Path: <netdev+bounces-114503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB3942C09
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026101C22D12
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C41AD3E7;
	Wed, 31 Jul 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Au/2/W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC11AC429;
	Wed, 31 Jul 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422065; cv=none; b=ov/CFFFJk0wB8n1seroO3XaUlXTaDiGV7xOOgokdv9YhDDDuZpV9AUsbRov1mE7g5JFfQ4t7+9vSa7WTOc9ltUDvYmiNOZ0KD7T/6q5bad7TAnnRdhEZIROO1sk8c4j4rz+Ay5SNDEJ72dbPniMJbwBzXqv9AJDwVmFqWkAHOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422065; c=relaxed/simple;
	bh=njutdzAmXk9uHToXKqCBo2PRfv8kPIV7SO0dqnHd/Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqGr5vmcqpklnnbZO7MODShi+efC4DzD6vB2eKL4Ve38kJtICyHK2RhJdulVXR638QnDH+Ysv92TQjx/fV9FktOskE2RICio8ytNdbJwMHE5bOFyRVaqBfXoRe6F/vm+AaKVlNGIHJDyz9OuBcyBHf9o3voogx/bJPivBjs6pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4Au/2/W; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so700737966b.0;
        Wed, 31 Jul 2024 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422062; x=1723026862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7kFiZURtEQ2k6BXwI0rXSHgwvGZFX9E3/aYRIy4da8=;
        b=e4Au/2/WKqgxy32rYGjqWuK3TdOvSYGVA7W09PI9VOjgUOQZbJ0SObaRfSWo0Pwt/5
         LIimGzwraYeZZwa+UNd9cQD8m0TCNPl5fCDKcPDJxiKjT0B9Lr76VidcUj2bAPzyfpOz
         Up1wA/29Er/xinTGWXgreBFGfLf3jCZMpRKzsuLfAymZiV41WKbCPrWM00g46AM6zrdp
         fkALRsa94Gbg/BuQ+0m5RW8ZPSCR952rTvxDKqWzM8qP6hurQ80b6rMB80RlLIG0orjP
         uP6S5eax1wZFFq7Apuv1TEfzkRgIIYWu4ms1fSoQiXUn8/R6MEc9wZKQcmvAVJ9yYBfF
         96SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422062; x=1723026862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7kFiZURtEQ2k6BXwI0rXSHgwvGZFX9E3/aYRIy4da8=;
        b=Jn52eItwlwApPlOtD5+CzknQTzlpSovZ/dWr4/brMetFkQCQ9rF7NyUKLIYc33Gy4Y
         lA66AX0pLMdO3e+PwjCFUmkSzIVh6L9YMOV8Tn2zBlRrOeAJdUrinG67B/+iY3p5NzK1
         MHf/peaDN9gpr+cZ1VX3OSeGZUaldDJXrQF5SIAb0IiOSOVj7ORhTlGXPMmcq1MQt891
         ba+vee9zpx17KvfPq1XlnqVR+VZnclKYBn1ERE+JUY9pBOZWookHNw4h7VM/KlqPv2oo
         fqhiPDpbKnVxEEbc0n3zSdDlfioUIVzT0cR3wTAFTbLC1nRd0YsE7ktcINcSfoHFnPJ8
         kUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG0cgQDWhC6bRTFhdfpd0CWjIUIX/GwoUIXafpNCipN63A9lhNqSKQLjEM5Z+T3ur6nNpk4nCDAsvqS2XlKpS+afmuUQQl
X-Gm-Message-State: AOJu0YxEU0Tz4wd3eMopRWNYMLf7nDf9PFuX1OwZ2Rosm7ppYo+DBBgQ
	CfiyT64AC9ErtVlV5eGCNFDSqUlHKFtMh0CoHo0UPFjftHuWd+2mxEioD01eksE=
X-Google-Smtp-Source: AGHT+IFBhmv1d14eI6rgQ42K+GoLmMLgfdbvddLFGHNmnBz0MWoTvzX4Ohu+HxDoyM+ZlQsl0WGDjA==
X-Received: by 2002:a17:907:3f8d:b0:a77:e55a:9e89 with SMTP id a640c23a62f3a-a7d4016100emr834628866b.52.1722422061591;
        Wed, 31 Jul 2024 03:34:21 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:21 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 2/5] net: dsa: microchip: move KSZ9477 WoL functions to ksz_common
Date: Wed, 31 Jul 2024 12:34:00 +0200
Message-ID: <20240731103403.407818-3-vtpieter@gmail.com>
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

Move KSZ9477 WoL functions to ksz_common, in preparation for adding
KSZ87xx family support.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz9477.c    | 181 -------------------------
 drivers/net/dsa/microchip/ksz_common.c | 181 +++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 181 deletions(-)

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
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..41f89e2c6b2d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3740,6 +3740,44 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
 		dev->dev_ops->get_wol(dev, port, wol);
 }
 
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
@@ -3751,6 +3789,149 @@ static int ksz_set_wol(struct dsa_switch *ds, int port,
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
+static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
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
-- 
2.43.0


