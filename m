Return-Path: <netdev+bounces-203431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC046AF5E8A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2F5212AC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470962EAB98;
	Wed,  2 Jul 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="wvmHP0qR"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB652D46CE;
	Wed,  2 Jul 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473568; cv=none; b=DYgbcgsqccwdK6ykUcZW74+gqa3Zx8kVWe8fyGvMjse/RActQH6uHRmQU4rr7G0KJW9t/xJC4WDZTtmxZ5E2HOCdjtaiHE90kAeGbMKS0kIIBISJ/RIN+V67u+yYdP5Jbvd8Am2qhtoQIGAv88x2suIa/xVI8VPs5qCXcA5OwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473568; c=relaxed/simple;
	bh=EveluqZwHcrw48ysBefLkzdfXQWm7QNTxqR3qvDzoJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tG41o4Txd/5pKS0TrKbhfiOIKGVSGmSf3P2DeO7twklOPJnZnyagiP0NwnCyTjp9MAsTlhlsegZW9tH1mDVC76NFoo2NfkJ+3V2DQ7AlJRgAVyQlIMgZDRPbDZp3614/ATeADUiuBYdd2Ls9WjzD0OgxRp0CVdhq4QB4Khg6ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=wvmHP0qR; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xLCVjYPDAueSJ87L89YSo6AkJv42KzlPhgAtjaMQpgA=; b=wvmHP0qREdi6kpJwRpV7p+LHC2
	ocHz6noDACd4LVZNYbPYp3ke//vwyXW6DrDv9P4lGkF3D/9rWy4fWSayILbKNhid+RQkEn/OnygTY
	ZydzNw68eQ2PmBJiPLEbySxqwXhDTa0ID7rJW8ZrA2pKiDeadHNNfdj7DUpFMI/RSKvHs7pI5RDRJ
	W93PXdCNYUW48gD2pW2QCcglv+O0+MlBCKAMX0NRc2bj9Ho04heoWn55Z3YRg7fj/AY/xUpa1ZdEj
	SX8+NbaJ7l8Cf2NSNWrEULpbDMaXL7wXJE4GIbgXd/o/SiEU2FCq1AxMXxsXJMWIy5fUJCKbqHTrI
	tdxte2mA==;
Received: from [122.175.9.182] (port=39304 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uX0HZ-00000004Tbr-477t;
	Wed, 02 Jul 2025 12:26:02 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	s.hauer@pengutronix.de,
	m-karicheri2@ti.com,
	glaroque@baylibre.com,
	afd@ti.com,
	saikrishnag@marvell.com,
	m-malladi@ti.com,
	jacob.e.keller@intel.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	horms@kernel.org,
	s-anna@ti.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v10 10/11] net: ti: prueth: Adds support for PRUETH on AM33x and AM43x SOCs
Date: Wed,  2 Jul 2025 21:54:49 +0530
Message-Id: <20250702162450.1674937-11-parvathi@couthit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702140633.1612269-1-parvathi@couthit.com>
References: <20250702140633.1612269-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

Adds support for AM335x and AM437x datasets. Dual-EMAC and Switch mode
firmware elf file to switch between protocols at run time.

Added API hooks for IEP module (legacy 32-bit model) to support
timestamping requests from application.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c     | 61 ++++++++++++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 32 ++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 031a6be6a4e3..d0850722814e 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -1006,6 +1006,59 @@ static const struct icss_iep_plat_data am57xx_icss_iep_plat_data = {
 	.config = &am654_icss_iep_regmap_config,
 };
 
+static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ICSS_IEP_GLOBAL_CFG_REG ... ICSS_IEP_CAPTURE_STAT_REG:
+	case ICSS_IEP_CAP6_RISE_REG0:
+	case ICSS_IEP_CMP_CFG_REG ... ICSS_IEP_CMP0_REG0:
+	case ICSS_IEP_CMP8_REG0 ... ICSS_IEP_SYNC_START_REG:
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static const struct regmap_config am335x_icss_iep_regmap_config = {
+	.name = "icss iep",
+	.reg_stride = 1,
+	.reg_write = icss_iep_regmap_write,
+	.reg_read = icss_iep_regmap_read,
+	.writeable_reg = am335x_icss_iep_valid_reg,
+	.readable_reg = am335x_icss_iep_valid_reg,
+};
+
+static const struct icss_iep_plat_data am335x_icss_iep_plat_data = {
+	.flags = 0,
+	.reg_offs = {
+		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
+		[ICSS_IEP_COMPEN_REG] = 0x08,
+		[ICSS_IEP_COUNT_REG0] = 0x0C,
+		[ICSS_IEP_CAPTURE_CFG_REG] = 0x10,
+		[ICSS_IEP_CAPTURE_STAT_REG] = 0x14,
+
+		[ICSS_IEP_CAP6_RISE_REG0] = 0x30,
+
+		[ICSS_IEP_CAP7_RISE_REG0] = 0x38,
+
+		[ICSS_IEP_CMP_CFG_REG] = 0x40,
+		[ICSS_IEP_CMP_STAT_REG] = 0x44,
+		[ICSS_IEP_CMP0_REG0] = 0x48,
+
+		[ICSS_IEP_CMP8_REG0] = 0x88,
+		[ICSS_IEP_SYNC_CTRL_REG] = 0x100,
+		[ICSS_IEP_SYNC0_STAT_REG] = 0x108,
+		[ICSS_IEP_SYNC1_STAT_REG] = 0x10C,
+		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x110,
+		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x114,
+		[ICSS_IEP_SYNC1_DELAY_REG] = 0x118,
+		[ICSS_IEP_SYNC_START_REG] = 0x11C,
+	},
+	.config = &am335x_icss_iep_regmap_config,
+};
+
 static const struct of_device_id icss_iep_of_match[] = {
 	{
 		.compatible = "ti,am654-icss-iep",
@@ -1015,6 +1068,14 @@ static const struct of_device_id icss_iep_of_match[] = {
 		.compatible = "ti,am5728-icss-iep",
 		.data = &am57xx_icss_iep_plat_data,
 	},
+	{
+		.compatible = "ti,am3356-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
+	{
+		.compatible = "ti,am4376-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, icss_iep_of_match);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 3fc895a2e355..ab9b764084f7 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -2122,6 +2122,10 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	}
 
 	prueth->ocmc_ram_size = OCMC_RAM_SIZE;
+	/* Decreased by 8KB to address the reserved region for AM33x */
+	if (prueth->fw_data->driver_data == PRUSS_AM33XX)
+		prueth->ocmc_ram_size = (SZ_64K - SZ_8K);
+
 	prueth->mem[PRUETH_MEM_OCMC].va =
 			(void __iomem *)gen_pool_alloc(prueth->sram_pool,
 						       prueth->ocmc_ram_size);
@@ -2365,6 +2369,32 @@ static const struct dev_pm_ops prueth_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(icssm_prueth_suspend, icssm_prueth_resume)
 };
 
+/* AM335x SoC-specific firmware data */
+static struct prueth_private_data am335x_prueth_pdata = {
+	.driver_data = PRUSS_AM33XX,
+	.fw_pru[PRUSS_PRU0] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am335x-pru0-prueth-fw.elf",
+	},
+	.fw_pru[PRUSS_PRU1] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am335x-pru1-prueth-fw.elf",
+	},
+};
+
+/* AM437x SoC-specific firmware data */
+static struct prueth_private_data am437x_prueth_pdata = {
+	.driver_data = PRUSS_AM43XX,
+	.fw_pru[PRUSS_PRU0] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am437x-pru0-prueth-fw.elf",
+	},
+	.fw_pru[PRUSS_PRU1] = {
+		.fw_name[PRUSS_ETHTYPE_EMAC] =
+			"ti-pruss/am437x-pru1-prueth-fw.elf",
+	},
+};
+
 /* AM57xx SoC-specific firmware data */
 static struct prueth_private_data am57xx_prueth_pdata = {
 	.driver_data = PRUSS_AM57XX,
@@ -2380,6 +2410,8 @@ static struct prueth_private_data am57xx_prueth_pdata = {
 
 static const struct of_device_id prueth_dt_match[] = {
 	{ .compatible = "ti,am57-prueth", .data = &am57xx_prueth_pdata, },
+	{ .compatible = "ti,am4376-prueth", .data = &am437x_prueth_pdata, },
+	{ .compatible = "ti,am3359-prueth", .data = &am335x_prueth_pdata, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, prueth_dt_match);
-- 
2.34.1


