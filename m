Return-Path: <netdev+bounces-114504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47327942C0A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F247D2837F4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E61AD9CF;
	Wed, 31 Jul 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRlP5rR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C61AC442;
	Wed, 31 Jul 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422066; cv=none; b=gdSDN49U2w7GAQVqtkpweDKJUYciMn2i4la+G3kFxK0ugf1HJI3Q4CfxMAqPaMBitwSj2p4P+iTW2lgPDvplROEmVFehDEXMqd/akdmKLzMB17PTDJlWnDka9608552RoiIWYiBLI+CKaD2Vo9UD58cC7P0rNKzsPTOKaQ8mIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422066; c=relaxed/simple;
	bh=shQAxURtObxQF2nmVVSMuLETLoLLe+vY1CQbbZjBe58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ8p3N+KnBerDALP5r7TPZY1p0qKalN3g7bb+17raGz3N2t37rIqMy7YkEzbNbN1bHuRtu2Ex3T1wCdf+DihQ453g52fFUgv8SMniZnmdoMs9iMpRKf98aa4EwCntBfcNlrSezzpYEyzvRhNjsXtRG+uz7oYWn7ljUBJHAtlwFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRlP5rR2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so9328128a12.3;
        Wed, 31 Jul 2024 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422062; x=1723026862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4dFelj6i6c61Qb4LmI4Gp6oBM5ubDua8A0L3kUdVr4=;
        b=RRlP5rR2UrOwVnDVuBa+61J0DjgDFi8DRdNT9ge+GH5oYqF0ne/pKdu+JC/cxLlgfV
         4XW6luYa3N7fq5lSed2A+SKthIwUoC6GbZ3WFVm+tsv+zCzoj6dZ73yPNgKa+tl6SQK8
         TjTvl1pfXpaaWL64APSX50DcxiFGeJ359JaOxljE5JvIj/VIfnFd4FulxN5fqilgTJqR
         nvaprX97HT5oSVyoOCvhR0mRiTbWjfxhA3sMcN/3MPSx6BESTbvkcYhRH3BRuIO5Uil8
         QHirtwcA9V8WXayR+2mlGFsvA78v6UBZsJkFfq/gXES7lXAdFxkAKGa0IjUM37E5Ryl0
         Dp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422062; x=1723026862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4dFelj6i6c61Qb4LmI4Gp6oBM5ubDua8A0L3kUdVr4=;
        b=EZKgaGbDbM7G0lhuw2tVMnP+CB9ftMOxtvXZHvwKG8OW3+O8nrkJ7YLbOne54xmqt6
         MDIUyxCj3SSJF1uadPSIMlJyaXH2tIEueHuGt56EhIdzVDzfrL1hNLvdfZznfE4F6GBw
         np0wXaHT2Ut6BEMA3J+eGabafgO5ouUDaC5Pqasmb/DrssgONDIDY1sQ8Hc/XyJYpTFF
         Lazz2xYijUqvIzLgzthWUIEbDTJCSuflMTme5REsJRugoEQ4czM2keAsulPEGrX8cePh
         F8z3EFC5Uq9JIBLZF6G9rQ5/UofurTSyV0QXJNbgmcYyjgYhsG0YjXLSKrD9ZQZHixJN
         zJ+w==
X-Forwarded-Encrypted: i=1; AJvYcCUcvJhVKJ43hqOa1VnD/lyK3LA9g/g10fqD3YHsmCa6U5rD9HyufMY6iclgBJmyLqXm25SM9l5Fl6HOF/gIDv7SeM4E9O6Q
X-Gm-Message-State: AOJu0YxoqNnCDd4+OmN8yrPbFFiNBpbnHBgCyfVaneLnOHqGWIOcZ87O
	4hsigCIkoLaAyDGyf/uN2vrtmDsG80kRAYhbFnc9ihIXYJmbf2id5cG774KPIHs=
X-Google-Smtp-Source: AGHT+IEVEeWQbCs1YfGKSWEF3Ktqvnh9M7Vc7HbxzRiJiNlIIgLGFSy8Mrwji2Y6+ma3iyNJHkw8ag==
X-Received: by 2002:a17:907:3f1f:b0:a7a:a801:12b3 with SMTP id a640c23a62f3a-a7d400afc30mr1030967266b.40.1722422062354;
        Wed, 31 Jul 2024 03:34:22 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb807dsm751930766b.201.2024.07.31.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:34:22 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v2 3/5] net: dsa: microchip: generalize KSZ9477 WoL functions at ksz_common
Date: Wed, 31 Jul 2024 12:34:01 +0200
Message-ID: <20240731103403.407818-4-vtpieter@gmail.com>
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

Generalize KSZ9477 WoL functions at ksz_common. Move dedicated registers
and generic masks to existing structures & defines for that purpose.

Introduction of PME (port) read/write helper functions, which happen
to be the generic read/write for KSZ9477 but not for the incoming
KSZ87xx patch.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz9477.c     |  14 +--
 drivers/net/dsa/microchip/ksz9477.h     |   5 --
 drivers/net/dsa/microchip/ksz9477_reg.h |  12 ---
 drivers/net/dsa/microchip/ksz_common.c  | 109 ++++++++++++------------
 drivers/net/dsa/microchip/ksz_common.h  |  27 ++++--
 5 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 071d953a17e9..a454a2e14a6b 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1007,6 +1007,7 @@ void ksz9477_port_queue_split(struct ksz_device *dev, int port)
 
 void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 {
+	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
 	u16 data16;
 	u8 member;
@@ -1051,12 +1052,12 @@ void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
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
@@ -1153,6 +1154,7 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 int ksz9477_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	const u16 *regs = dev->info->regs;
 	int ret = 0;
 
 	ds->mtu_enforcement_ingress = true;
@@ -1183,11 +1185,11 @@ int ksz9477_setup(struct dsa_switch *ds)
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
+	ksz_write8(dev, regs[REG_SW_PME_CTRL], 0);
 
 	return 0;
 }
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
index 41f89e2c6b2d..e5358da8cbeb 100644
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
@@ -3731,31 +3734,27 @@ static int ksz_setup_tc(struct dsa_switch *ds, int port,
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
 
@@ -3768,7 +3767,8 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
 	if (ksz_is_port_mac_global_usable(dev->ds, port))
 		wol->supported |= WAKE_MAGIC;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl);
+	ret = dev->dev_ops->pme_pread8(dev, port, regs[REG_PORT_PME_CTRL],
+				       &pme_ctrl);
 	if (ret)
 		return;
 
@@ -3778,35 +3778,26 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
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
@@ -3814,10 +3805,13 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
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
 
@@ -3826,7 +3820,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 	if (wol->wolopts & WAKE_PHY)
 		pme_ctrl |= PME_WOL_LINKUP | PME_WOL_ENERGY;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_CTRL, &pme_ctrl_old);
+	ret = dev->dev_ops->pme_pread8(dev, port, regs[REG_PORT_PME_CTRL],
+				       &pme_ctrl_old);
 	if (ret)
 		return ret;
 
@@ -3849,7 +3844,8 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 		ksz_switch_macaddr_put(dev->ds);
 	}
 
-	ret = ksz_pwrite8(dev, port, REG_PORT_PME_CTRL, pme_ctrl);
+	ret = dev->dev_ops->pme_pwrite8(dev, port, regs[REG_PORT_PME_CTRL],
+					pme_ctrl);
 	if (ret) {
 		if (magic_switched_on)
 			ksz_switch_macaddr_put(dev->ds);
@@ -3860,7 +3856,7 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
 }
 
 /**
- * ksz9477_handle_wake_reason - Handle wake reason on a specified port.
+ * ksz_handle_wake_reason - Handle wake reason on a specified port.
  * @dev: The device structure.
  * @port: The port number.
  *
@@ -3872,12 +3868,14 @@ int ksz9477_set_wol(struct ksz_device *dev, int port,
  *
  * Return: 0 on success, or an error code on failure.
  */
-static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
+int ksz_handle_wake_reason(struct ksz_device *dev, int port)
 {
+	const u16 *regs = dev->info->regs;
 	u8 pme_status;
 	int ret;
 
-	ret = ksz_pread8(dev, port, REG_PORT_PME_STATUS, &pme_status);
+	ret = dev->dev_ops->pme_pread8(dev, port, regs[REG_PORT_PME_STATUS],
+				       &pme_status);
 	if (ret)
 		return ret;
 
@@ -3889,11 +3887,12 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
 		pme_status & PME_WOL_LINKUP ? " \"Link Up\"" : "",
 		pme_status & PME_WOL_ENERGY ? " \"Energy detect\"" : "");
 
-	return ksz_pwrite8(dev, port, REG_PORT_PME_STATUS, pme_status);
+	return dev->dev_ops->pme_pwrite8(dev, port, regs[REG_PORT_PME_STATUS],
+					 pme_status);
 }
 
 /**
- * ksz9477_wol_pre_shutdown - Prepares the switch device for shutdown while
+ * ksz_wol_pre_shutdown - Prepares the switch device for shutdown while
  *                            considering Wake-on-LAN (WoL) settings.
  * @dev: The switch device structure.
  * @wol_enabled: Pointer to a boolean which will be set to true if WoL is
@@ -3904,32 +3903,37 @@ static int ksz9477_handle_wake_reason(struct ksz_device *dev, int port)
  * the wol_enabled flag accordingly to reflect whether WoL is active on any
  * port.
  */
-void ksz9477_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
+static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
 {
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
+		ret = dev->dev_ops->pme_pread8(dev, dp->index,
+					       regs[REG_PORT_PME_CTRL], &pme_ctrl);
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
+		dev->dev_ops->pme_write8(dev, regs[REG_SW_PME_CTRL], PME_ENABLE);
 }
 
 static int ksz_port_set_mac_address(struct dsa_switch *ds, int port,
@@ -4237,8 +4241,7 @@ void ksz_switch_shutdown(struct ksz_device *dev)
 {
 	bool wol_enabled = false;
 
-	if (dev->dev_ops->wol_pre_shutdown)
-		dev->dev_ops->wol_pre_shutdown(dev, &wol_enabled);
+	ksz_wol_pre_shutdown(dev, &wol_enabled);
 
 	if (dev->dev_ops->reset && !wol_enabled)
 		dev->dev_ops->reset(dev);
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 5f0a628b9849..c60c218afa64 100644
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
@@ -391,6 +394,7 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack);
 void ksz_switch_macaddr_put(struct dsa_switch *ds);
 void ksz_switch_shutdown(struct ksz_device *dev);
+int ksz_handle_wake_reason(struct ksz_device *dev, int port);
 
 /* Common register access functions */
 static inline struct regmap *ksz_regmap_8(struct ksz_device *dev)
@@ -629,6 +633,11 @@ static inline bool is_ksz8(struct ksz_device *dev)
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
@@ -695,6 +704,14 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define P_MII_MAC_MODE			BIT(2)
 #define P_MII_SEL_M			0x3
 
+/* KSZ9477, KSZ8795 Wake-on-LAN (WoL) masks */
+#define PME_WOL_MAGICPKT		BIT(2)
+#define PME_WOL_LINKUP			BIT(1)
+#define PME_WOL_ENERGY			BIT(0)
+
+#define PME_ENABLE			BIT(1)
+#define PME_POLARITY			BIT(0)
+
 /* Interrupt */
 #define REG_SW_PORT_INT_STATUS__1	0x001B
 #define REG_SW_PORT_INT_MASK__1		0x001F
-- 
2.43.0


