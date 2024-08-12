Return-Path: <netdev+bounces-117615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C59294E8EB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A8228251F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206316D9C5;
	Mon, 12 Aug 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNDMpiy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415316D9BB;
	Mon, 12 Aug 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452673; cv=none; b=r+AkMAq44bkU4wu8f2tvYC3g6vPjN0WSWp/ifeO+Ca54OyQ1kMLEWo6E/D18fjFxXXJEPhdw1nk5Jz+puTXpeVjfwJbZzSj90Q+HkBAENVZsnNOnvXptWuIPs8rcg37JPHH1S+GJGe6hOKJoWt2/9LGy248LLxEce/bAVC26d6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452673; c=relaxed/simple;
	bh=yVbLiwXp3y3vlxhRVcrg1Am12yF0nslL3Naf9OUa0cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkQ4mANRNfChxld6s4k/xhRnkn9KuXYIhXZQ14DZidoQbW2jjX3qvcQXVY0rHNU64klzO3wM2azEnFed8nPZdJ/gldlVUCst4z8xlXSCPHiykOefkDK8dbVR/Ca+DovtEDsn6woMBn6yhU2IA5FeHGn0uYazlxOQi/rWGVrnew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNDMpiy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so4762086a12.0;
        Mon, 12 Aug 2024 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452670; x=1724057470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAqVEaOgKR65yWeYLOQFhIc3DZnyI4OyFbvhtsEiZV0=;
        b=FCNDMpiys1Yt9ti0xHiRWnyqWGBO6Ez1aEo8hqW1ZqZRHh4c5Upf00RT+Xgk65VPcZ
         HzNkQZThVzfKVfy9IAmQ8vX9PtcqVVF3xQaGf7SiFqZiDKVTvOCvSNKclfCIdYwRqqgD
         ZGUfPZe9TturIjhANYpAJZLhJWv01PwyAOVhExNPS1MDLTdhWgFosy832NQjXwnnrvjO
         7iBDATG6xN0SIdyuNVXateCEf1X/blSsILx4+sHWtihYMy02WsSiwc0s2cUeTIjTcCWv
         rRahBRZKv8KgzeSxXg3JpYnMrNxwep7adZE0xRTf0t8wGb/hJEmMr6Nid1kb5GSFl7Rr
         dKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452670; x=1724057470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAqVEaOgKR65yWeYLOQFhIc3DZnyI4OyFbvhtsEiZV0=;
        b=lTdR+WM4ohh+PcNOcbGULWLw2NG2DAeQ1baUVt3u0oaHl1I0/UYnua1PsMUhEmv3ii
         s4+ag1nui9OZeP0h7x218Pwk7Q4ZhGZbM/+NFx+/cmJcnMFAGXX6byFgXYbuFjbfkdgt
         BthMp9yiOs2opRlM0Yh7lUl2RA02Mks4S6EBI00iiO3HAQALcjhJiHbfrotG+c4oWVcd
         L29RLrbPgFWWbe0YT7oeeHV5fajkkgJVUFH3KcWvB/qm8FYiMpvoG55pHE3IuxdCmdzQ
         LweNFbsq9RNXsJi2KJw/ZD7Fnm8cxhPLELpLD4UemFU91dvxDAiETU/guxX5PtBQhNnp
         as+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkCkqB3jE4ij4T7H50/YkcWRIJlCnQ2GBm/m6HYnfoKJ1erFYBuFLOKbS+GBWxgvHc7oF7wSHJmmxzzrfYyzR+EY3Yv4oJkush3cdJCybfFW2401D0BRyx6kF+i1hDkH2ftdVfRyvdabxNvd3nbRg87iuGh4IjnWy4MokE2h4VWQ==
X-Gm-Message-State: AOJu0Yy3/Q1bJlrD+5j6KCgZCY4Ufh7IQGMfmtO6UH2qOROmunbMwNrj
	ATJxJ1S4UVGslc0JIU75sk2/AauYhR4ruqxEfIm2oJ0fzurNt4JA
X-Google-Smtp-Source: AGHT+IFsJYPOcuI9ydZlawcyXDRr+gzVVU6hupBESisC03Reo7S1FXKAvetY+JSNWP8Ka/in0CtA5w==
X-Received: by 2002:a05:6402:2708:b0:5a3:5218:5d80 with SMTP id 4fb4d7f45d1cf-5bd0a5f9e5emr6587249a12.21.1723452669805;
        Mon, 12 Aug 2024 01:51:09 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f517dsm2094761a12.4.2024.08.12.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:51:09 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/5] net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
Date: Mon, 12 Aug 2024 10:49:34 +0200
Message-ID: <20240812084945.578993-4-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812084945.578993-1-vtpieter@gmail.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Generalize KSZ9477 WoL functions at ksz_common. Move dedicated registers
and generic masks to existing structures & defines for that purpose.

Introduction of PME (port) read/write helper functions, which happen
to be the generic read/write for KSZ9477 but not for the incoming
KSZ87xx patch.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz9477.c    |  16 ++--
 drivers/net/dsa/microchip/ksz_common.c | 113 +++++++++++++------------
 drivers/net/dsa/microchip/ksz_common.h |  30 +++----
 3 files changed, 81 insertions(+), 78 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 4defa7c03176..741b4f2dd8d2 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1024,6 +1024,7 @@ void ksz9477_port_queue_split(struct ksz_device *dev, int port)
 
 void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
+	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
 	u16 data16;
 	u8 member;
@@ -1068,12 +1069,12 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	ksz9477_port_acl_init(dev, port);
 
 	/* clear pending wake flags */
-	ksz9477_handle_wake_reason(dev, port);
+	ksz_handle_wake_reason(dev, port);
 
 	/* Disable all WoL options by default. Otherwise
 	 * ksz_switch_macaddr_get/put logic will not work properly.
 	 */
-	ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, 0);
+	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
 }
 
 void ksz9477_config_cpu_port(struct dsa_switch *ds)
@@ -1170,6 +1171,7 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	int ret = 0;
 
 	ds->mtu_enforcement_ingress = true;
@@ -1200,13 +1202,11 @@ int ksz9477_setup(struct dsa_switch *ds)
 	/* enable global MIB counter freeze function */
 	ksz_cfg(dev, REG_SW_MAC_CTRL_6, SW_MIB_COUNTER_FREEZE, true);
 
-	/* Make sure PME (WoL) is not enabled. If requested, it will be
-	 * enabled by ksz9477_wol_pre_shutdown(). Otherwise, some PMICs do not
-	 * like PME events changes before shutdown.
+	/* Make sure PME (WoL) is not enabled. If requested, it will
+	 * be enabled by ksz_wol_pre_shutdown(). Otherwise, some PMICs
+	 * do not like PME events changes before shutdown.
 	 */
-	ksz_write8(dev, REG_SW_PME_CTRL, 0);
-
-	return 0;
+	return ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
 }
 
 u32 ksz9477_get_port_addr(int port, int offset)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7afe958d0e21..e2a9a652c41a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -348,9 +348,9 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.mdb_add = ksz9477_mdb_add,
 	.mdb_del = ksz9477_mdb_del,
 	.change_mtu = ksz9477_change_mtu,
-	.get_wol = ksz9477_get_wol,
-	.set_wol = ksz9477_set_wol,
-	.wol_pre_shutdown = ksz9477_wol_pre_shutdown,
+	.pme_write8 = ksz_write8,
+	.pme_pread8 = ksz_pread8,
+	.pme_pwrite8 = ksz_pwrite8,
 	.config_cpu_port = ksz9477_config_cpu_port,
 	.tc_cbs_set_cinc = ksz9477_tc_cbs_set_cinc,
 	.enable_stp_addr = ksz9477_enable_stp_addr,
@@ -539,6 +539,9 @@ static const u16 ksz9477_regs[] = {
 	[S_MULTICAST_CTRL]		= 0x0331,
 	[P_XMII_CTRL_0]			= 0x0300,
 	[P_XMII_CTRL_1]			= 0x0301,
+	[REG_SW_PME_CTRL]		= 0x0006,
+	[REG_PORT_PME_STATUS]		= 0x0013,
+	[REG_PORT_PME_CTRL]		= 0x0017,
 };
 
 static const u32 ksz9477_masks[] = {
@@ -3742,17 +3745,8 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
 	}
 }
 
-static void ksz_get_wol(struct dsa_switch *ds, int port,
-			struct ethtool_wolinfo *wol)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (dev->dev_ops->get_wol)
-		dev->dev_ops->get_wol(dev, port, wol);
-}
-
 /**
- * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
+ * ksz_handle_wake_reason - Handle wake reason on a specified port.
  * @dev: The device structure.
  * @port: The port number.
  *
@@ -3764,12 +3758,15 @@ static void ksz_get_wol(struct dsa_switch *ds, int port,
  *
  * Return: 0 on success, or an error code on failure.
  */
-int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
+int ksz_handle_wake_reason(struct ksz_device *dev, int port)
 {
+	const struct ksz_dev_ops *ops = dev->dev_ops;
+	const u16 *regs = dev->info->regs;
 	u8 pme_status;
 	int ret;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
+	ret = ops->pme_pread8(dev, port, regs[REG_PORT_PME_STATUS],
+			      &pme_status);
 	if (ret)
 		return ret;
 
@@ -3781,25 +3778,31 @@ int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
 		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
 		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
 
-	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
+	return ops->pme_pwrite8(dev, port, regs[REG_PORT_PME_STATUS],
+				pme_status);
 }
 
 /**
- * ksz9477_get_wol - Get Wake-on-LAN settings for a specified port.
- * @dev: The device structure.
+ * ksz_get_wol - Get Wake-on-LAN settings for a specified port.
+ * @ds: The dsa_switch structure.
  * @port: The port number.
  * @wol: Pointer to ethtool Wake-on-LAN settings structure.
  *
- * This function checks the PME Pin Control Register to see if  PME Pin Output
- * Enable is set, indicating PME is enabled. If enabled, it sets the supported
- * and active WoL flags.
+ * This function checks the device PME wakeup_source flag and chip_id.
+ * If enabled and supported, it sets the supported and active WoL
+ * flags.
  */
-void ksz9477_get_wol(struct ksz_device *dev, int port,
-		     struct ethtool_wolinfo *wol)
+static void ksz_get_wol(struct dsa_switch *ds, int port,
+			struct ethtool_wolinfo *wol)
 {
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	u8 pme_ctrl;
 	int ret;
 
+	if (!is_ksz9477(dev))
+		return;
+
 	if (!dev->wakeup_source)
 		return;
 
@@ -3812,7 +3815,8 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 	if (ksz_is_port_mac_global_usable(dev->ds, port))
 		wol->supported |= WAKE_MAGIC;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
+	ret = dev->dev_ops->pme_pread8(dev, port, regs[REG_PORT_PME_CTRL],
+				       &pme_ctrl);
 	if (ret)
 		return;
 
@@ -3822,35 +3826,26 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 		wol->wolopts |= WAKE_PHY;
 }
 
-static int ksz_set_wol(struct dsa_switch *ds, int port,
-		       struct ethtool_wolinfo *wol)
-{
-	struct ksz_device *dev = ds->priv;
-
-	if (dev->dev_ops->set_wol)
-		return dev->dev_ops->set_wol(dev, port, wol);
-
-	return -EOPNOTSUPP;
-}
-
 /**
- * ksz9477_set_wol - Set Wake-on-LAN settings for a specified port.
- * @dev: The device structure.
+ * ksz_set_wol - Set Wake-on-LAN settings for a specified port.
+ * @ds: The dsa_switch structure.
  * @port: The port number.
  * @wol: Pointer to ethtool Wake-on-LAN settings structure.
  *
- * This function configures Wake-on-LAN (WoL) settings for a specified port.
- * It validates the provided WoL options, checks if PME is enabled via the
- * switch's PME Pin Control Register, clears any previous wake reasons,
- * and sets the Magic Packet flag in the port's PME control register if
+ * This function configures Wake-on-LAN (WoL) settings for a specified
+ * port. It validates the provided WoL options, checks if PME is
+ * enabled and supported, clears any previous wake reasons, and sets
+ * the Magic Packet flag in the port's PME control register if
  * specified.
  *
  * Return: 0 on success, or other error codes on failure.
  */
-int ksz9477_set_wol(struct ksz_device *dev, int port,
-		    struct ethtool_wolinfo *wol)
+static int ksz_set_wol(struct dsa_switch *ds, int port,
+		       struct ethtool_wolinfo *wol)
 {
 	u8 pme_ctrl = 0, pme_ctrl_old = 0;
+	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	bool magic_switched_off;
 	bool magic_switched_on;
 	int ret;
@@ -3858,10 +3853,13 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
 
+	if (!is_ksz9477(dev))
+		return -EOPNOTSUPP;
+
 	if (!dev->wakeup_source)
 		return -EOPNOTSUPP;
 
-	ret = ksz9477_handle_wake_reason(dev, port);
+	ret = ksz_handle_wake_reason(dev, port);
 	if (ret)
 		return ret;
 
@@ -3870,7 +3868,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	if (wol->wolopts & WAKE_PHY)
 		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl_old);
+	ret = dev->dev_ops->pme_pread8(dev, port, regs[REG_PORT_PME_CTRL],
+				       &pme_ctrl_old);
 	if (ret)
 		return ret;
 
@@ -3893,7 +3892,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 		ksz_switch_macaddr_put(dev->ds);
 	}
 
-	ret = ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
+	ret = dev->dev_ops->pme_pwrite8(dev, port, regs[REG_PORT_PME_CTRL],
+					pme_ctrl);
 	if (ret) {
 		if (magic_switched_on)
 			ksz_switch_macaddr_put(dev->ds);
@@ -3904,8 +3904,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 }
 
 /**
- * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while
- *                            considering Wake-on-LAN (WoL) settings.
+ * ksz_wol_pre_shutdown - Prepares the switch device for shutdown while
+ *                        considering Wake-on-LAN (WoL) settings.
  * @dev: The switch device structure.
  * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
  *               enabled on any port.
@@ -3915,32 +3915,38 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
  * the wol_enabled flag accordingly to reflect whether WoL is active on any
  * port.
  */
-void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 {
+	const struct ksz_dev_ops *ops = dev->dev_ops;
+	const u16 *regs = dev->info->regs;
 	struct dsa_port *dp;
 	int ret;
 
 	*wol_enabled = false;
 
+	if (!is_ksz9477(dev))
+		return;
+
 	if (!dev->wakeup_source)
 		return;
 
 	dsa_switch_for_each_user_port(dp, dev->ds) {
 		u8 pme_ctrl = 0;
 
-		ret = ksz_pread8(dev, dp->index, REG_PORT_PME_CTRL, &pme_ctrl);
+		ret = ops->pme_pread8(dev, dp->index,
+				      regs[REG_PORT_PME_CTRL], &pme_ctrl);
 		if (!ret && pme_ctrl)
 			*wol_enabled = true;
 
 		/* make sure there are no pending wake events which would
 		 * prevent the device from going to sleep/shutdown.
 		 */
-		ksz9477_handle_wake_reason(dev, dp->index);
+		ksz_handle_wake_reason(dev, dp->index);
 	}
 
 	/* Now we are save to enable PME pin. */
 	if (*wol_enabled)
-		ksz_write8(dev, REG_SW_PME_CTRL, PME_ENABLE);
+		ops->pme_write8(dev, regs[REG_SW_PME_CTRL], PME_ENABLE);
 }
 
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
@@ -4253,8 +4259,7 @@ void ksz_switch_shutdown(struct ksz_device *dev)
 {
 	bool wol_enabled = false;
 
-	if (dev->dev_ops->wol_pre_shutdown)
-		dev->dev_ops->wol_pre_shutdown(dev, &wol_enabled);
+	ksz_wol_pre_shutdown(dev, &wol_enabled);
 
 	if (dev->dev_ops->reset && !wol_enabled)
 		dev->dev_ops->reset(dev);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index e35caca96f89..c60c218afa64 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -235,6 +235,9 @@ enum ksz_regs {
 	S_MULTICAST_CTRL,
 	P_XMII_CTRL_0,
 	P_XMII_CTRL_1,
+	REG_SW_PME_CTRL,
+	REG_PORT_PME_STATUS,
+	REG_PORT_PME_CTRL,
 };
 
 enum ksz_masks {
@@ -354,6 +357,11 @@ struct ksz_dev_ops {
 	void (*get_caps)(struct ksz_device *dev, int port,
 			 struct phylink_config *config);
 	int (*change_mtu)(struct ksz_device *dev, int port, int mtu);
+	int (*pme_write8)(struct ksz_device *dev, u32 reg, u8 value);
+	int (*pme_pread8)(struct ksz_device *dev, int port, int offset,
+			  u8 *data);
+	int (*pme_pwrite8)(struct ksz_device *dev, int port, int offset,
+			   u8 data);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
 	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,
@@ -363,11 +371,6 @@ struct ksz_dev_ops {
 				    int duplex, bool tx_pause, bool rx_pause);
 	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
 	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
-	void (*get_wol)(struct ksz_device *dev, int port,
-			struct ethtool_wolinfo *wol);
-	int (*set_wol)(struct ksz_device *dev, int port,
-		       struct ethtool_wolinfo *wol);
-	void (*wol_pre_shutdown)(struct ksz_device *dev, bool *wol_enabled);
 	void (*config_cpu_port)(struct dsa_switch *ds);
 	int (*enable_stp_addr)(struct ksz_device *dev);
 	int (*reset)(struct ksz_device *dev);
@@ -391,12 +394,7 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack);
 void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
-int ksz9477_handle_wake_reason(struct ksz_device *dev, int port);
-void ksz9477_get_wol(struct ksz_device *dev, int port,
-		     struct ethtool_wolinfo *wol);
-int ksz9477_set_wol(struct ksz_device *dev, int port,
-		    struct ethtool_wolinfo *wol);
-void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled);
+int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
@@ -635,6 +633,11 @@ static inline bool is_ksz8(struct ksz_device *dev)
 	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev);
 }
 
+static inline bool is_ksz9477(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ9477_CHIP_ID;
+}
+
 static inline int is_lan937x(struct ksz_device *dev)
 {
 	return dev->chip_id == LAN9370_CHIP_ID ||
@@ -702,15 +705,10 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define P_MII_SEL_M			0x3
 
 /* KSZ9477, KSZ8795 Wake-on-LAN (WoL) masks */
-#define REG_PORT_PME_STATUS		0x0013
-#define REG_PORT_PME_CTRL		0x0017
-
 #define PME_WOL_MAGICPKT		BIT(2)
 #define PME_WOL_LINKUP			BIT(1)
 #define PME_WOL_ENERGY			BIT(0)
 
-#define REG_SW_PME_CTRL			0x0006
-
 #define PME_ENABLE			BIT(1)
 #define PME_POLARITY			BIT(0)
 
-- 
2.43.0


