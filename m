Return-Path: <netdev+bounces-270434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIRnDX8DwWlUPgQAu9opvQ
	(envelope-from <netdev+bounces-270434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:10:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E722EEBDD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DABC3064130
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F0C386438;
	Mon, 23 Mar 2026 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XoxdVn8+"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E173859E1;
	Mon, 23 Mar 2026 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256661; cv=fail; b=WrA8NOukVOzupGOVBZBORSFlhqgix/SIkUKmnt7+2esoKGcojzx36b+YVjsnUWdijXcg2YzX6j6WYTFyjtABntcvAVy3WG9xQIw2SqHak4uNo/f+Sc+4I8YSAon9hGCb2Nis4ki1BDxpd2iyIX/+l0DtoNNa3Z/iHXM+3jpVhJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256661; c=relaxed/simple;
	bh=SOFN1YU7uUKbDzZom8A/igY+xE6NpO+0fGmp8yHXi3s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxoQ/Jr0To+aoVYAkXVwfBzqoXlrMUsBa+z52U/1CNeCXVb7Gw4RVBMP8vUOKQ367DW/0jQ0y8/udO9aK5UWfqje6J5MymH4Ur96SI3nex2QiMURinkBybrdmQya5qAGt6JBcKEUElV7pVdlf31tpqq8iEs1QWudc69h0PJulEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XoxdVn8+; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXnNKqWgSaDGl74ZpBlbyU8wM91jUt0neUPs6zIHu2Z/AzeuBrFEsz4puyNs1C50x2ahN14u1uAOlaE2EVynUtXaI4P+5pR/3Bt/HFiIM2j+Vx4yrD6mflq/wTpbaHM7GcyGcRjFc7yUMBsZvYxFfLB0ueqV6BeDi/CutuAifQVs4rYBH0Z0JnCma0YESRpsccYBxVVHthsRWmdZapg0yjHSt5YdZ8aBdpxdNkgPHXHFFGI6VK1ZIVGEAejkOVMJSGRD2AnvoZJgrf7Nhg7+fYjiw+kzTnX4kquyRFv4tIhoDNdAAMQhd7XTcG+AdR/eW1oe6x/+bbLS6SEGtBlUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BlsyMTkoFq/7CQJUvBsyCVyfPKy/VIPIvq67byc9Rs=;
 b=b5BVGiwhHUAu0Aup60UZfhFAt0N3/7jG7zhCOv4f+jM2tQmJ0FQUxhfX+ECQA3hPaNsUu+Xg9uEwpEM4c0snMmQJSt5DV6oK6oqqQ436OCWYI8XHz9JRiK+h7bKDOFidJ5rhmjTY+kGJAb2RG1ZqXEw0c5UEnNZKwRVcPMbGlr93f5+qHWeI2BD9X6rxIuYx3ze1ApqQKZqx60hKutaV5AuB2XKZtMuu5Xqbl/J8ME/knZa6q15OzwHL5a/ydQYpI1iFX6uzJp/9B4DqjBCKvLWuKWHsahM3Xos1E8RlQx7i6fHn4/fOGpVPw/RpeRcPprRQlugrlfJRm2rFvj6CMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BlsyMTkoFq/7CQJUvBsyCVyfPKy/VIPIvq67byc9Rs=;
 b=XoxdVn8+N3H5ERog15QuDHXC0o8yp6WXr56lylnLCnoP0+yDdLVcD2gg2Z7Ejcpmvwe6JGUHh4x1KJ5FsQOR05yDg4LzzlbppG6fKBWvTXKQkSQcZMu7PLjNh4eXkscQjN150S1V72EIK97uxXtk1iuiEue5HWU/kjp8rPf8ZeI=
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 09:04:17 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::e7) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 09:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 09:04:14 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:05 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 04:04:05 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 04:04:05 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62N945dh334908;
	Mon, 23 Mar 2026 04:04:05 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62N943Ev003515;
	Mon, 23 Mar 2026 04:04:04 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH net-next v4 1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
Date: Mon, 23 Mar 2026 14:33:57 +0530
Message-ID: <20260323090358.632329-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323090358.632329-1-m-malladi@ti.com>
References: <20260323090358.632329-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CO1PR10MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f725fe-ee6c-440b-659d-08de88bb2831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NGdeLuwgfYlIi6wgBcvw03TV8Z+kcB7ksAc1MYijMRu8Jfs2EquKq7i8Qb2NAv+8cbJIjw0Fl5nbS52tGnOYLatByYF0FbdLaAQZ/m/xfz8a9JBhEbDcsothSn/fgNdOk0piDrouJMJgielMXqWlltcvNHZlHVsOQ5s9OPpvjyZhfbxyWDjzpi/l/rDEY9bcsH/Xz/zL/N6snQfaRWCItYzaIAu3iOpYQ2AV+SY+Q5BdDPp87iCrM+UkKhdtVZU//J1ehVzU5eozs/U60xRvc1mNe4BHyEXnxn8sGKSfAJFBq0Ow1FAd4XEmk+AHI/KV9pAr8q+9GSwQRiEzTqs8XM9ASSXvwN3uZylJ0gp3xz02aafShSeod3GrgnD+OkAfOV2rlLFbEEC9hGe6Ac2Q+vdVhTC8b+UKo7rcucAQA8l59Mbs4QpFr/rwIv3DWKIL5U7nzS7encIgrusul3j0SsE4PoPA+PKu/bOCo6fYppmGEFZ3nVnCN75o/EjNue2d9jrBsudzOfym6BygUzPY2IGA9zgJe4HPXmvFsmReHInwis1LsfsFkIADCVRCWsUKKHicKj2KNyHG+9Vl2To8aWitFgEEI82/vHZiZL9Ap5z+9R9F4hKR/otfiVbUHc8XU77xXwJe+h2XWFX2xs1xeDhj/5294/Txog49Zt/xE/+2MVMKNhDZX3OKp/9AlZp1ui0zgElCfrskD3M3FFs2L1AY3/Ksi8j15Aut96Hwxc8=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zS4tzCgCtgX+4NhDwI/nJoWZ8cEurI+2cJC9eTA54mTH1QPj1tm5DDeaQrY/VAv1k/Hqc75ck27GWfmkSeyPTTQPXqB2hBB407wRAH+e4PFL3FKE3wLxHtl/cG6dwY3iIQjm+OzxWsMhSjB+h5tfoGA3ewGo8GsM9MhKAyvFO0frDe/D6/m5KOyoMH8+tgVcYzYxHOGkgcdm9azxfxoS+GM9xJJ4l/Uf8MSrZpKXGzfpnR+aOU+WDcg8gwnOnW13lBysvq8dQUUe3PROFnipxAJNpJy2DTcKBqXcEYuFnctkMiiUo7kq2BU27YJmBmXwbJYREQLNWHMEJ7+KFAWh9InlVbKVkHfpm/EVFvX0dEd/slRPCniMTOnRbaaiPhRWma+IVhJAbgZT2qWo+1J0o/zrBLOXEitBwxiv8KNOb/PII+RSvwfA13uP1BTjf7Vm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:04:14.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f725fe-ee6c-440b-659d-08de88bb2831
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270434-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid,ti.com:email,ti.com:url,a:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E6E722EEBDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add device tree overlay to enable ICSSG0 dual EMAC support on AM642 EVM.
This overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
dual EMAC mode.

Users can combine this with the existing ICSSG1 overlay to enable all four
ICSSG interfaces if needed.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v4-v3:
- Change the ASEL value in main_pktdma property from 0 to 15
  as pointed out by Vignesh Raghavendra <vigneshr@ti.com>

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 168 ++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index ba01a929e06f..d2cd124a5b08 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62x-sk-hdmi-audio.dtbo
 
 # Boards with AM64x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg0.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
@@ -218,6 +219,8 @@ k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-ov5640.dtbo
 k3-am62p5-sk-csi2-tevi-ov5640-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
+k3-am642-evm-icssg0-dtbs := \
+	k3-am642-evm.dtb k3-am642-evm-icssg0.dtbo
 k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-evm-icssg1-dualemac-mii-dtbs := \
@@ -306,6 +309,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-imx219.dtb \
 	k3-am62p5-sk-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
+	k3-am642-evm-icssg0.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-evm-icssg1-dualemac-mii.dtb \
 	k3-am642-evm-pcie0-ep.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
new file mode 100644
index 000000000000..0c8e245e526c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for enabling ICSSG0 dual EMAC on AM642 EVM
+ *
+ * AM642 EVM Product link: https://www.ti.com/tool/TMDS64EVM
+ * DP83TG720 daughter card link: https://www.ti.com/tool/DP83TG720-IND-SPE-EVM
+ *
+ * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	icssg0_eth: icssg0-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_icssg0_rgmii1_pins_default>, <&pru_icssg0_rgmii2_pins_default>;
+		sram = <&oc_sram>;
+
+		dmas = <&main_pktdma 0xc100 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc101 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc102 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc103 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc104 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc105 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc106 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc107 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4100 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4101 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		interrupt-parent = <&icssg0_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
+		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg0_mii_g_rt>;
+		ti,mii-rt = <&icssg0_mii_rt>;
+		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
+		ti,pa-stats = <&icssg0_pa_stats>;
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg0_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg0_phy00>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&main_conf 0x4100>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			icssg0_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg0_phy01>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&main_conf 0x4104>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	pru_icssg0_mdio_pins_default: pru-icssg0-mdio-pins {
+		pinctrl-single,pins = <
+			/* (P3) PRG0_MDIO0_MDC */
+			AM64X_IOPAD(0x0204, PIN_OUTPUT, 0)
+			/* (P2) PRG0_MDIO0_MDIO */
+			AM64X_IOPAD(0x0200, PIN_INPUT, 0)
+			/* (P16) GPIO0_32 - GPMC0_ADVn_ALE - GPIO_ETH0/1_RESETn# */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 7)
+		>;
+	};
+
+	pru_icssg0_rgmii1_pins_default: pru-icssg0-rgmii1-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0160, PIN_INPUT, 2)  /* (Y1) PRG0_PRU0_GPO0.PRG0_RGMII1_RD0 */
+			AM64X_IOPAD(0x0164, PIN_INPUT, 2)  /* (R4) PRG0_PRU0_GPO1.PRG0_RGMII1_RD1 */
+			AM64X_IOPAD(0x0168, PIN_INPUT, 2)  /* (U2) PRG0_PRU0_GPO2.PRG0_RGMII1_RD2 */
+			AM64X_IOPAD(0x016c, PIN_INPUT, 2)  /* (V2) PRG0_PRU0_GPO3.PRG0_RGMII1_RD3 */
+			AM64X_IOPAD(0x0178, PIN_INPUT, 2)  /* (T3) PRG0_PRU0_GPO6.PRG0_RGMII1_RXC */
+			AM64X_IOPAD(0x0170, PIN_INPUT, 2)  /* (AA2) PRG0_PRU0_GPO4.PRG0_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x018c, PIN_OUTPUT, 2) /* (Y3) PRG0_PRU0_GPO11.PRG0_RGMII1_TD0 */
+			AM64X_IOPAD(0x0190, PIN_OUTPUT, 2) /* (AA3) PRG0_PRU0_GPO12.PRG0_RGMII1_TD1 */
+			AM64X_IOPAD(0x0194, PIN_OUTPUT, 2) /* (R6) PRG0_PRU0_GPO13.PRG0_RGMII1_TD2 */
+			AM64X_IOPAD(0x0198, PIN_OUTPUT, 2) /* (V4) PRG0_PRU0_GPO14.PRG0_RGMII1_TD3 */
+			AM64X_IOPAD(0x01a0, PIN_OUTPUT, 2) /* (U4) PRG0_PRU0_GPO16.PRG0_RGMII1_TXC */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 2) /* (T5) PRG0_PRU0_GPO15.PRG0_RGMII1_TX_CTL */
+		>;
+	};
+
+	pru_icssg0_rgmii2_pins_default: pru-icssg0-rgmii2-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01b0, PIN_INPUT, 2)  /* (Y2) PRG0_PRU1_GPO0.PRG0_RGMII2_RD0 */
+			AM64X_IOPAD(0x01b4, PIN_INPUT, 2)  /* (W2) PRG0_PRU1_GPO1.PRG0_RGMII2_RD1 */
+			AM64X_IOPAD(0x01b8, PIN_INPUT, 2)  /* (V3) PRG0_PRU1_GPO2.PRG0_RGMII2_RD2 */
+			AM64X_IOPAD(0x01bc, PIN_INPUT, 2)  /* (T4) PRG0_PRU1_GPO3.PRG0_RGMII2_RD3 */
+			AM64X_IOPAD(0x01c8, PIN_INPUT, 2)  /* (R5) PRG0_PRU1_GPO6.PRG0_RGMII2_RXC */
+			AM64X_IOPAD(0x01c0, PIN_INPUT, 2)  /* (W3) PRG0_PRU1_GPO4.PRG0_RGMII2_RX_CTL */
+			AM64X_IOPAD(0x01dc, PIN_OUTPUT, 2) /* (W4) PRG0_PRU1_GPO11.PRG0_RGMII2_TD0 */
+			AM64X_IOPAD(0x01e0, PIN_OUTPUT, 2) /* (Y4) PRG0_PRU1_GPO12.PRG0_RGMII2_TD1 */
+			AM64X_IOPAD(0x01e4, PIN_OUTPUT, 2) /* (T6) PRG0_PRU1_GPO13.PRG0_RGMII2_TD2 */
+			AM64X_IOPAD(0x01e8, PIN_OUTPUT, 2) /* (U6) PRG0_PRU1_GPO14.PRG0_RGMII2_TD3 */
+			AM64X_IOPAD(0x01f0, PIN_OUTPUT, 2) /* (AA4) PRG0_PRU1_GPO16.PRG0_RGMII2_TXC */
+			AM64X_IOPAD(0x01ec, PIN_OUTPUT, 2) /* (U5) PRG0_PRU1_GPO15.PRG0_RGMII2_TX_CTL */
+		>;
+	};
+
+	icssg0_iep0_pins_default: icssg0-iep0-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01ac, PIN_OUTPUT, 2) /* (W1) PRG0_PRU0_GPO19.PRG0_IEP0_EDC_SYNC_OUT0 */
+		>;
+	};
+};
+
+&icssg0_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pru_icssg0_mdio_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	icssg0_phy00: ethernet-phy@0 {
+		reg = <0x0>;
+	};
+
+	icssg0_phy01: ethernet-phy@a {
+		reg = <0xa>;
+	};
+};
+
+&icssg0_iep0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg0_iep0_pins_default>;
+};
+
+&main_gpio0 {
+	phy-line-hog {
+		gpio-hog;
+		gpios = <32 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "phy-hog-line";
+	};
+};
-- 
2.43.0


