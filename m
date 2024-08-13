Return-Path: <netdev+bounces-118089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B649095078D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6931C21ED5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85CE19E7E6;
	Tue, 13 Aug 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWPJPX1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45719E7DB;
	Tue, 13 Aug 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559311; cv=none; b=c5e5XOLj/HUa3Zj8qCUhtJNZ2PMG/cfPEgpRhCfeZ6o5f0Wa1IhGVsA0GyIbKX0XoMDNwbCRviBM/w91wcQgtnwebd+/IVbOuMf2Lu+EvHjSngshrO/xLeceZtnygE1fh9Vu/CQyHPp0ysijcHo4xrnCTtwWiPbN5A9qxUqw/Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559311; c=relaxed/simple;
	bh=yVbLiwXp3y3vlxhRVcrg1Am12yF0nslL3Naf9OUa0cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJ7WvX+mI8Xfg52Elg28HZgyyN3w2hT3sHT+/HggZ80G311su0IJDaHONatG/WxqZm46eqoEN/z1MCmhGdGyrfbyDHU/Fhtv0impAolmj05X7IDx0XC8jk5BCDZBGJD87+gX7PJq+EJB9cvvyp0FA9FJgK8pdWKJk++W2Se+9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWPJPX1P; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso7659982e87.2;
        Tue, 13 Aug 2024 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559307; x=1724164107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAqVEaOgKR65yWeYLOQFhIc3DZnyI4OyFbvhtsEiZV0=;
        b=HWPJPX1PRkJpvsacc7f01+vuXv7gE+EyyD96x0lYooAZlUMIutOkew0pq5jYT9ftOk
         RMroX/FpA+AsZDO8NYbzVZn7jcnylfaCjd517YArNSvAxFx00+WiBvuLBWhm6Qgyc4KL
         3jTP0iNX8BlW/dTC8aduzSugH+IaruivfB6TOWelfWwS386yfqqHD3T1fT2lgjWxgOHp
         p+J/CJ/Ungjmwu+dF+mQ7ad0Iu7qH/GelMuWn8uNmgw4vFEG12J/oMtl3t12fwETvmBI
         uh0QCwqKcmFvCOnu1unUAve3sK8XNU4HnEtv4k1o4E8wwNqaHzz3tdlcLruumX3mwqAA
         XUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559307; x=1724164107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAqVEaOgKR65yWeYLOQFhIc3DZnyI4OyFbvhtsEiZV0=;
        b=TBcW7lJkHesB1yKqr5zwfwFI9Bb892zksgm6lZrHOSMhpQoZNqQf3PMSdP6luUpMUP
         ior3O4a2Cn9n8Lu62nCKMfe+yM/jDmNdVmtF0ynmCtd4Nw+55FZlauv4GkYvjdNLLGIs
         zCaFX40tsJ2NXzi/3Qlhtly6x7TH4fhIvUTQCitDfjE189VUkjf42MDsMpNkoeE1VeBT
         l0IAfTLeClu9jbElnuvbktUbDLaDBPw/vquSSixINkrA7oW9dWu3eo8l3DjqTUI4kotZ
         n+/wJwr3+Cha6YUCjjW79UlG8T7rJqiij4FsS/JAkYqG6HiUc45oJCDtrH13Nu5TDl/x
         kVCg==
X-Forwarded-Encrypted: i=1; AJvYcCU0zBxgHH82i6slotdCEHgusyuh62u5BT179NLJnU4T97Xy2P5mOQjv39b3Kfq+nuACdt46MWKf@vger.kernel.org, AJvYcCUEFzYeRnS79o1gxlLYhNjhNi6DSHt/nFf1kPTwmgsi8MHNIdCkl3xABBg7OkIFaxObsrr7Pkf0oIEJ@vger.kernel.org, AJvYcCW7f2r8Et+wJvMjnXI9VrYc1O+jqA2PSLBJJ2DFABuW521CLKXOya23Cu0fDaCPyLyu9hzGRjMXCLy0u224@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4Hl4FkEHa3fb2cN31klkPALKtV43Xnbz71JGgTEtLjg8N9vB
	+JWsFJ2/Z1LHt+0dIQiojZkcBUkTXyIuwvDWgW27b45PIX0uPk3X
X-Google-Smtp-Source: AGHT+IFmHts7nEJrOvIgkaMkVVsoM3T09zp80+4QEjs3fHee7KM5MSmWUZmmMvz/fAVkr+5Io7DoCQ==
X-Received: by 2002:a05:6512:234a:b0:52e:9ac6:a20f with SMTP id 2adb3069b0e04-53213693d9amr2791728e87.37.1723559306918;
        Tue, 13 Aug 2024 07:28:26 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:26 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/6] net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
Date: Tue, 13 Aug 2024 16:27:37 +0200
Message-ID: <20240813142750.772781-4-vtpieter@gmail.com>
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


