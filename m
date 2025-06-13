Return-Path: <netdev+bounces-197352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9FAD835B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7583A0444
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5B1C07D9;
	Fri, 13 Jun 2025 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j7B+/F4U"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1832F41;
	Fri, 13 Jun 2025 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749797169; cv=none; b=gilWzsIercfUXEAy/LaHNzvC5IPngi+POeCmUugwLcs83whzGV3ZitPey867uaZyC7oAeRlNAP538ZJ0r1mm/FSbAwxi8VckfXwcYTkQwFKAE2fHKxH/CsCPiA7nPlhXM3TkNZl0zdINDoJdPEiiMxejEgtyYXCm2SmVKNtKbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749797169; c=relaxed/simple;
	bh=/EwZg1oZR49LHjEgYh6mYVIRq1j8rfovxf5weWMxPCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUiQxEkXczjWpoCqBGuNph2Fek3/mt0z1D9N5EPs+PR50RClR2S806rt/sVjaLC6p5+Q2rqLR5QKk7vJtjTTTr8yzQcG+I/faePuvF9Ay6KYcwBy0F4i4PDiKb8uWUIT8AUazTDQAtfLFz10N0tbV7Ml5PWMiKRnkuUJjzI4ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j7B+/F4U; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55D6jquR3062110;
	Fri, 13 Jun 2025 01:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749797152;
	bh=oajSuti6jz9rnNbhXAfUaBOuSqrfLjbzmaFWuDd/IoU=;
	h=From:To:CC:Subject:Date;
	b=j7B+/F4UHhVdPcs8O9Ydb+uSyMe8pCC/kUbLQFR0baLIIzw/p8rAqtagY4O6LapLn
	 5Wo6nxtQ7J5/WaB4TqEK/X4einHMBsWFs/WQ0QrYlRR0+Gn7s+9qi6LNDqexUCCOfI
	 WGfhqdBVc2VWCNZUii6zl7RII2SGlEwcNn/AE1AQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55D6jq1R031690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 13 Jun 2025 01:45:52 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 13
 Jun 2025 01:45:52 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 13 Jun 2025 01:45:52 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55D6jqOS1130541;
	Fri, 13 Jun 2025 01:45:52 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 55D6joAm011920;
	Fri, 13 Jun 2025 01:45:51 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Read firmware-names from device tree
Date: Fri, 13 Jun 2025 12:15:47 +0530
Message-ID: <20250613064547.44394-1-danishanwar@ti.com>
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

Example: Below are the firmwares used currently for PRU0 core

EMAC: ti-pruss/am65x-sr2-pru0-prueth-fw.elf
SW  : ti-pruss/am65x-sr2-pru0-prusw-fw.elf
HSR : ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf

All three firmware names are same except for the operating mode.

In general for PRU0 core, firmware name is,

        ti-pruss/am65x-sr2-pru0-pru<mode>-fw.elf

Since the EMAC firmware names are defined in DT, driver will read those
directly and for other modes swap the mode name. i.e. eth -> sw or
eth -> hsr.

This preserves backwards compatibility as ICSSG driver is supported only
by AM65x and AM64x. Both of these have "firmware-name" property
populated in their device tree.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v1 - v2: Changed commit message to include an example as suggested by 
         Jakub Kicinski <kuba@kernel.org>

v1: https://lore.kernel.org/all/20250610052501.3444441-1-danishanwar@ti.com/

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

base-commit: 6d4e01d29d87356924f1521ca6df7a364e948f13
-- 
2.34.1


