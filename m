Return-Path: <netdev+bounces-195936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023AAD2D43
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D583B170961
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784425C813;
	Tue, 10 Jun 2025 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i8V7WiJr"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063251D9A5F;
	Tue, 10 Jun 2025 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533124; cv=none; b=u0ONJFAdNKivd/iwncVlQp2kuEysF4cGaJmAzWtDnopfv4SUdT7Xb0dUn/EWxWLNLgOLhCcUZySWKZP8KbmGfcYirxjCVHu/t/MF75i0Bt/736X+LKn5qE7HmV04VeB1xXDkNhAUuwS7L0r4FydQHiknval3qPX4/O5EoiQkU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533124; c=relaxed/simple;
	bh=olB7IMxsuPf/+i2W8t89XJdhZ/M+Z7Ut4muWZIEK9I0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpURcxexbdl/l3IGjnhAJzmAmFJl/JcTFMEtreGUYwR3jjLDGEs3t1OIpJbOU2sxTJEAfVlOWIbHOTQcsoSa+6eCMGyx6CYDNrGYDJ0IzVP0YEIc8RdCFiexkYqupv4+ieEg6Ra8sDMIJqREJ9qjciZRmBeRLx3uYwA6r2oJsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i8V7WiJr; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A5P66r964855;
	Tue, 10 Jun 2025 00:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749533106;
	bh=iXGCraI3dMXLMKMBKMUFIsijA30YWJGhnIbm1wFE2Ms=;
	h=From:To:CC:Subject:Date;
	b=i8V7WiJriePP3Qn/bmxvh4m2N4+rEAF3/37BnYxpqXrbkOQrK0pw7vJwjNVQ7VQk0
	 XFG78R7CtYZRDW4eubzDh1y8Gtthfz6rJ8ogMQqW/3JjWTfLf7Se/I2rjKFy+j07Q3
	 Bv2MIn7bKX9jBrOCUSe2HvC17OgVeEmgzGL4455E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A5P6g6022632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 10 Jun 2025 00:25:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 00:25:05 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 00:25:05 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A5P5VI2837585;
	Tue, 10 Jun 2025 00:25:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 55A5P4ql009298;
	Tue, 10 Jun 2025 00:25:04 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg-prueth: Read firmware-names from device tree
Date: Tue, 10 Jun 2025 10:55:01 +0530
Message-ID: <20250610052501.3444441-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Refactor the way firmware names are handled for the ICSSG PRUETH driver.
Instead of using hardcoded firmware name arrays for different modes (EMAC,
SWITCH, HSR), the driver now reads the firmware names from the device tree
property "firmware-name". Only the EMAC firmware names are specified in the
device tree property. The firmware names for all other supported modes are
generated dynamically based on the EMAC firmware names by replacing
substrings (e.g., "eth" with "sw" or "hsr") as appropriate.

This improves flexibility and allows firmware names to be customized via
the device tree, reducing the need for code changes when firmware names
change for different platforms.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 135 +++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  12 +-
 2 files changed, 102 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 86fc1278127c..a1e013b0a0eb 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -125,45 +125,6 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct icssg_firmwares icssg_hsr_firmwares[] = {
-	{
-		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
-	},
-	{
-		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
-	}
-};
-
-static struct icssg_firmwares icssg_switch_firmwares[] = {
-	{
-		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu0-prusw-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru0-prusw-fw.elf",
-	},
-	{
-		.pru = "ti-pruss/am65x-sr2-pru1-prusw-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu1-prusw-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru1-prusw-fw.elf",
-	}
-};
-
-static struct icssg_firmwares icssg_emac_firmwares[] = {
-	{
-		.pru = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
-	},
-	{
-		.pru = "ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
-		.rtu = "ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
-		.txpru = "ti-pruss/am65x-sr2-txpru1-prueth-fw.elf",
-	}
-};
-
 static int prueth_start(struct rproc *rproc, const char *fw_name)
 {
 	int ret;
@@ -186,11 +147,11 @@ static int prueth_emac_start(struct prueth *prueth)
 	int ret, slice;
 
 	if (prueth->is_switch_mode)
-		firmwares = icssg_switch_firmwares;
+		firmwares = prueth->icssg_switch_firmwares;
 	else if (prueth->is_hsr_offload_mode)
-		firmwares = icssg_hsr_firmwares;
+		firmwares = prueth->icssg_hsr_firmwares;
 	else
-		firmwares = icssg_emac_firmwares;
+		firmwares = prueth->icssg_emac_firmwares;
 
 	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
 		ret = prueth_start(prueth->pru[slice], firmwares[slice].pru);
@@ -1632,6 +1593,87 @@ static void prueth_unregister_notifiers(struct prueth *prueth)
 	unregister_netdevice_notifier(&prueth->prueth_netdevice_nb);
 }
 
+static void icssg_read_firmware_names(struct device_node *np,
+				      struct icssg_firmwares *fw)
+{
+	int i;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		of_property_read_string_index(np, "firmware-name", i * 3 + 0,
+					      &fw[i].pru);
+		of_property_read_string_index(np, "firmware-name", i * 3 + 1,
+					      &fw[i].rtu);
+		of_property_read_string_index(np, "firmware-name", i * 3 + 2,
+					      &fw[i].txpru);
+	}
+}
+
+/* icssg_firmware_name_replace - Replace a substring in firmware name
+ * @dev: device pointer for memory allocation
+ * @src: source firmware name string
+ * @from: substring to replace
+ * @to: replacement substring
+ *
+ * Return: a newly allocated string with the replacement, or the original
+ * string if replacement is not possible.
+ */
+static const char *icssg_firmware_name_replace(struct device *dev,
+					       const char *src,
+					       const char *from,
+					       const char *to)
+{
+	size_t prefix, from_len, to_len, total;
+	const char *p = strstr(src, from);
+	char *buf;
+
+	if (!p)
+		return src; /* fallback: no replacement, use original */
+
+	prefix = p - src;
+	from_len = strlen(from);
+	to_len = strlen(to);
+	total = strlen(src) - from_len + to_len + 1;
+
+	buf = devm_kzalloc(dev, total, GFP_KERNEL);
+	if (!buf)
+		return src; /* fallback: allocation failed, use original */
+
+	strscpy(buf, src, prefix + 1);
+	strscpy(buf + prefix, to, to_len + 1);
+	strscpy(buf + prefix + to_len, p + from_len, total - prefix - to_len);
+
+	return buf;
+}
+
+/**
+ * icssg_mode_firmware_names - Generate firmware names for a specific mode
+ * @dev: device pointer for logging and context
+ * @src: source array of firmware name structures
+ * @dst: destination array to store updated firmware name structures
+ * @from: substring in firmware names to be replaced
+ * @to: substring to replace @from in firmware names
+ *
+ * Iterates over all MACs and replaces occurrences of the @from substring
+ * with @to in the firmware names (pru, rtu, txpru) for each MAC. The
+ * updated firmware names are stored in the @dst array.
+ */
+static void icssg_mode_firmware_names(struct device *dev,
+				      struct icssg_firmwares *src,
+				      struct icssg_firmwares *dst,
+				      const char *from, const char *to)
+{
+	int i;
+
+	for (i = 0; i < PRUETH_NUM_MACS; i++) {
+		dst[i].pru = icssg_firmware_name_replace(dev, src[i].pru,
+							 from, to);
+		dst[i].rtu = icssg_firmware_name_replace(dev, src[i].rtu,
+							 from, to);
+		dst[i].txpru = icssg_firmware_name_replace(dev, src[i].txpru,
+							   from, to);
+	}
+}
+
 static int prueth_probe(struct platform_device *pdev)
 {
 	struct device_node *eth_node, *eth_ports_node;
@@ -1808,6 +1850,15 @@ static int prueth_probe(struct platform_device *pdev)
 		icss_iep_init_fw(prueth->iep1);
 	}
 
+	/* Read EMAC firmware names from device tree */
+	icssg_read_firmware_names(np, prueth->icssg_emac_firmwares);
+
+	/* Generate other mode firmware names based on EMAC firmware names */
+	icssg_mode_firmware_names(dev, prueth->icssg_emac_firmwares,
+				  prueth->icssg_switch_firmwares, "eth", "sw");
+	icssg_mode_firmware_names(dev, prueth->icssg_emac_firmwares,
+				  prueth->icssg_hsr_firmwares, "eth", "hsr");
+
 	spin_lock_init(&prueth->vtbl_lock);
 	spin_lock_init(&prueth->stats_lock);
 	/* setup netdev interfaces */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 23c465f1ce7f..c03e3b3626c1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -259,9 +259,9 @@ struct prueth_pdata {
 };
 
 struct icssg_firmwares {
-	char *pru;
-	char *rtu;
-	char *txpru;
+	const char *pru;
+	const char *rtu;
+	const char *txpru;
 };
 
 /**
@@ -300,6 +300,9 @@ struct icssg_firmwares {
  * @is_switchmode_supported: indicates platform support for switch mode
  * @switch_id: ID for mapping switch ports to bridge
  * @default_vlan: Default VLAN for host
+ * @icssg_emac_firmwares: Firmware names for EMAC mode, indexed per MAC
+ * @icssg_switch_firmwares: Firmware names for SWITCH mode, indexed per MAC
+ * @icssg_hsr_firmwares: Firmware names for HSR mode, indexed per MAC
  */
 struct prueth {
 	struct device *dev;
@@ -343,6 +346,9 @@ struct prueth {
 	spinlock_t vtbl_lock;
 	/** @stats_lock: Lock for reading icssg stats */
 	spinlock_t stats_lock;
+	struct icssg_firmwares icssg_emac_firmwares[PRUETH_NUM_MACS];
+	struct icssg_firmwares icssg_switch_firmwares[PRUETH_NUM_MACS];
+	struct icssg_firmwares icssg_hsr_firmwares[PRUETH_NUM_MACS];
 };
 
 struct emac_tx_ts_response {

base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.34.1


