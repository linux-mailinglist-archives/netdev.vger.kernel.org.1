Return-Path: <netdev+bounces-262114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COp5NFHSomnA5wQAu9opvQ
	(envelope-from <netdev+bounces-262114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:32:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 318D01C2908
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A2C30457D3
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7665438FFB;
	Sat, 28 Feb 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gvIzolv7"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FD43C045;
	Sat, 28 Feb 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278338; cv=fail; b=ngRBitwTjTw5onXmQZGbMbXfuCsopWGWqGwosvaMf1UOapveQ0OcoSGtZUGrzAJt85MtMiDfeF4IfJYz1QUDmYop1NE2tum7N1NeVuq5LleoEHFSk7AT4FkLNwxuPRm6CC2x59f28JoFk3Dc/0qS29s3Ia/8n74oDC+7SAuMXQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278338; c=relaxed/simple;
	bh=T5+8z+Ii2CQxYD3RZA+2q+s9Nv/LN9DacH93TOT3TPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS/RQT/2mOHIYKf/SRVJrcUUDmRBQKaU3OWkMBHy4fEVxqMF58ronuOPAvxJzpuTaU4SN/DLlyUg8Ff4/QVMKm8gpGYRMLyuyphuxqZKJ6ZDcQ8C7cXJQiQGQxD6qYpmGzUAdY8AclPa0YMO2PaBrQQzd6G0DLcJE3ba6zQS2Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gvIzolv7; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKYh6pwFrj+KZD85xvH+Jl1AwCzI/L5zz+QIDiU1Un4ir5RmWIBzLtP1PhrGMy4Ru4kMIyPwY5VygDMkvh1+Ubrb7+rgH/Re/7jgg6kvI4YMUTMnT2wseXsavVzsfY0ym6Ed8Hg7WVsg1zg7uQWZTwnAVzVnirm3Y54G2uvLZ+FELQCt+6Zu7CON6njgib+24oRTzo8rSW0owkVbrFNSzeDgLb0jdKtkE1ovQo+ckJOIKqcKa+Asei5fP5VIycUm+4l5/drQE3JGSMeaMiLom7zqOJha6T8WjnMNfNPT/O18603Tz2pLwMKKxTffGq6LIC+/QaNhcPswYwyGZHugzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmoa00latOBvhlTa+RPzwYPBbnM9LIBDzLmrG8yYRGc=;
 b=Bb7cdIzR5uTZgzrNBocKpPBONIzw9CJ7h//z/LuAYMzJaBR5yUcGfr8B838qv5CLFwRFg0wTrRcQMX+HDDSP9ZIBITUIIUj1FlpLS2hVdjuOOFEFA38M23RQ4NFjIu72R1xHYJ39uZp1AtwA/C96vqaN0gzdHzFehB6+7GSy2xNR/MO8636cLxg65SoFUhv3ia2eE0GqoOtB6lMaq5sO7Yvbf0WS7qIz+27gcbtkXCGe9HVKD/rSx5qeifHBRCR3GIYuZs9rhIbjp6wXxgj1M55PrtM9lV5iGcdtU+070wS2CtVSH8hdqZoKr/Nvf/yEJngtB1POgWnPLk4yc4FtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmoa00latOBvhlTa+RPzwYPBbnM9LIBDzLmrG8yYRGc=;
 b=gvIzolv7bYwX4ZPYoBrMsUEBRzNNRH+KH9fQUrtkrqRf5BG3ZmIWzPqbNg6T2ysJxiAjCbrah2WmgFFZW0lZ1uS5ZDc1QbcKecbHDAzf74v6TBpcLV9JMqdA3Azi7NZThnikd2jyuWeMx+jMWqKxkKqCtn3ClUGFBpwH+lbhP6U=
Received: from PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::7)
 by DM4PR10MB6135.namprd10.prod.outlook.com (2603:10b6:8:b6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16; Sat, 28 Feb 2026 11:32:13 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::1f) by PH7P220CA0084.outlook.office365.com
 (2603:10b6:510:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Sat,
 28 Feb 2026 11:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 11:32:11 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:11 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 05:32:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 28 Feb 2026 05:32:11 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61SBWBem1706775;
	Sat, 28 Feb 2026 05:32:11 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61SBW9lR005190;
	Sat, 28 Feb 2026 05:32:10 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<kristo@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<netdev@vger.kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay for dual EMAC support
Date: Sat, 28 Feb 2026 17:02:02 +0530
Message-ID: <20260228113203.498839-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228113203.498839-1-m-malladi@ti.com>
References: <20260228113203.498839-1-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DM4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4506e1-af2f-4d83-d40a-08de76bd03c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	gdWBDw5uj40PPzm2EugNWpIocjmPB/gPmYU+Oi+VZh2b2D4EGXtQM4nlgSTDR0TIkg9bxIaArQkP8qCv5A5kHaat/CPVJvSneetEZR++OwSUnjnx5m6eKGmSzRILV45wKQ55AUtVTXnpxXgUc0hA+hnTcbESxv0R+7ItT95AZEemWBEO1GE+sXZh/myJbDThlytevTtczopPjlyo+4oeSrHydnxaboWhry5uDHr/bllmoyfiJlbtpLc8rJM4l9EUcT+LGDgsCeHIFQUjED4tvCOTuicfsy2m4U7bXBOpxXmFiSt2yQl+Wk38URvcNtMnyTfBcY1R9qRv/1PtLYqR/WnpWeGWVeTDwt1sgWowKVHOW9iYia2VZ52Osm72Gox3KnHg7JogFKW/1QMhWLJuljs5aD9g9bRMMoyIqgQufKvAUpkbOaeQ1uQO2b3wdJzFvcNLGpSmA4voGWKjeoPGlrf7/z4s2R6LyXENJ3cMsswsGlFBDsqsxRqKtsKyBpBA7u6u8B8XwAI2M7mabMtSsdW6p9ZN/j5Vyynn85098QqTYgm588fl56rHvf0loAGcZeIYa8IXpBJYAcISC9Oev7sxBmeto1FTBjP4IzqEd9HbMmB/xLvy92871F2h91U3MpoEA+RhleGAOOgpb5tytRio6vdn30Z0ul+1fwgbtJYn6O6vp8DScGrH8yqXGHHIhW0hCB6k83IvsvFrNy9UM3GUYT0KcNsJ5oyVC8m8ZYofeTeMvRY+OP31r7rwwVXSABdSBIWHpAjJNXEO9YtZQg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/mMIwaARi9gq9tN3QuSZeBDNj9BlDgUos+stimBaNqLJB/Mf8kRr4u5ueSN4lQSp3wWArsJ3oTcawX/Sa6rYZDhEadmWkZgTLUOLHcMBr/8eTDK58ot+IrFDTm/YV6KwSCvNK6lB+MhvXZ9DTXuPv+TqqPeLPEeNNtl7Uiuwzh5sLm42B/RwsQbtIYbIxbLi0piLHvFjjwQwICEA3pwO6UISg2JDvDbovam/BLjZmcAt96dmLhNdjdh1jz9/tkbSLvMKuiUc/jUNF11k57DJjQYMUV6XXR2WzqrZCQQzdq6ExDLnagn16oC2H6zQQo1zS9GtwshIZYvY2/wCsIu8YIDbAgcV+Df/5NQoGZgxLvnQFlFiEHvapW9/1IoRr6bz1Y+gdCEyISiiYJAUH5yv0bv5WTtqvuxEOCVWX6fs/q7LK9JYm/kF3Lq7UpcAOv+t
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:32:11.6724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4506e1-af2f-4d83-d40a-08de76bd03c7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6135
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-262114-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 318D01C2908
X-Rspamd-Action: no action

Add device tree overlay to enable ICSSG0 dual EMAC support on AM642 EVM.
This overlay enables both ICSSG0 Ethernet interfaces (port0 and port1) in
dual EMAC mode.

Users can combine this with the existing ICSSG1 overlay to enable all four
ICSSG interfaces if needed.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v1: https://lore.kernel.org/all/20260226115454.1730618-1-m-malladi@ti.com/
v2-v1:
- Drop bringing up ICSSG1 support in this overlay as suggested by
  MD Danish Anwar <danishanwar@ti.com>

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 .../boot/dts/ti/k3-am642-evm-icssg0.dtso      | 203 ++++++++++++++++++
 2 files changed, 207 insertions(+)
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
index 000000000000..425a16948cc1
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for enabling ICSSG0 dual EMAC on AM642 EVM
+ *
+ * AM642 EVM Product link: https://www.ti.com/tool/TMDS64EVM
+ * DP83TG720 daughter card link: https://www.ti.com/tool/DP83TG720-IND-SPE-EVM
+ *
+ * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&{/aliases} {
+	ethernet0 = &icssg0_emac0;
+	ethernet1 = &icssg0_emac1;
+};
+
+&{/} {
+	icssg0_eth: icssg0-eth {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pru_icssg0_rgmii1_pins_default>, <&pru_icssg0_rgmii2_pins_default>;
+
+		sram = <&oc_sram>;
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
+		ti,pa-stats = <&icssg0_pa_stats>;
+		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
+
+		interrupt-parent = <&icssg0_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc100 0>, /* egress slice 0 */
+		       <&main_pktdma 0xc101 0>, /* egress slice 0 */
+		       <&main_pktdma 0xc102 0>, /* egress slice 0 */
+		       <&main_pktdma 0xc103 0>, /* egress slice 0 */
+		       <&main_pktdma 0xc104 0>, /* egress slice 1 */
+		       <&main_pktdma 0xc105 0>, /* egress slice 1 */
+		       <&main_pktdma 0xc106 0>, /* egress slice 1 */
+		       <&main_pktdma 0xc107 0>, /* egress slice 1 */
+		       <&main_pktdma 0x4100 0>, /* ingress slice 0 */
+		       <&main_pktdma 0x4101 0>, /* ingress slice 1 */
+		       <&main_pktdma 0x4102 0>, /* mgmnt rsp slice 0 */
+		       <&main_pktdma 0x4103 0>; /* mgmnt rsp slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1",
+			    "rxmgm0", "rxmgm1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			icssg0_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg0_phy00>;
+				phy-mode = "rgmii-id";
+				syscon-rgmii-delay = <&main_conf 0x4100>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			icssg0_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg0_phy01>;
+				phy-mode = "rgmii-id";
+				syscon-rgmii-delay = <&main_conf 0x4104>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+};
+
+&main_pmx0 {
+	pru_icssg0_mdio_pins_default: pru-icssg0-mdio-pins-default {
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
+	pru_icssg0_rgmii1_pins_default: pru-icssg0-rgmii1-pins-default {
+		pinctrl-single,pins = <
+			/* (module-sitara) */
+			/* (a14-y1) PRG0_PRU0_GPO0.PRG0_RGMII1_RD0 */
+			AM64X_IOPAD(0x0160, PIN_INPUT, 2)
+			/* (b14-r4) PRG0_PRU0_GPO1.PRG0_RGMII1_RD1 */
+			AM64X_IOPAD(0x0164, PIN_INPUT, 2)
+			/* (d14-u2) PRG0_PRU0_GPO2.PRG0_RGMII1_RD2 */
+			AM64X_IOPAD(0x0168, PIN_INPUT, 2)
+			/* (e14-v2) PRG0_PRU0_GPO3.PRG0_RGMII1_RD3 */
+			AM64X_IOPAD(0x016c, PIN_INPUT, 2)
+			/* (e13-t3) PRG0_PRU0_GPO6.PRG0_RGMII1_RXC */
+			AM64X_IOPAD(0x0178, PIN_INPUT, 2)
+			/* (b13-aa2) PRG0_PRU0_GPO4.PRG0_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0170, PIN_INPUT, 2)
+
+			/* (a11-y3) PRG0_PRU0_GPO11.PRG0_RGMII1_TD0 */
+			AM64X_IOPAD(0x018c, PIN_OUTPUT, 2)
+			/* (c11-aa3) PRG0_PRU0_GPO12.PRG0_RGMII1_TD1 */
+			AM64X_IOPAD(0x0190, PIN_OUTPUT, 2)
+			/* (d11-r6) PRG0_PRU0_GPO13.PRG0_RGMII1_TD2 */
+			AM64X_IOPAD(0x0194, PIN_OUTPUT, 2)
+			/* (b10-v4) PRG0_PRU0_GPO14.PRG0_RGMII1_TD3 */
+			AM64X_IOPAD(0x0198, PIN_OUTPUT, 2)
+			/* (e10-u4) PRG0_PRU0_GPO16.PRG0_RGMII1_TXC */
+			AM64X_IOPAD(0x01a0, PIN_OUTPUT, 2)
+			/* (c10-t5) PRG0_PRU0_GPO15.PRG0_RGMII1_TX_CTL */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 2)
+		>;
+	};
+
+	pru_icssg0_rgmii2_pins_default: pru-icssg0-rgmii2-pins-default {
+		pinctrl-single,pins = <
+			/* (e9-y2) PRG0_PRU1_GPO0.PRG0_RGMII2_RD0 */
+			AM64X_IOPAD(0x01b0, PIN_INPUT, 2)
+			/* (a8-w2) PRG0_PRU1_GPO1.PRG0_RGMII2_RD1 */
+			AM64X_IOPAD(0x01b4, PIN_INPUT, 2)
+			/* (c8-v3) PRG0_PRU1_GPO2.PRG0_RGMII2_RD2 */
+			AM64X_IOPAD(0x01b8, PIN_INPUT, 2)
+			/* (d8-t4) PRG0_PRU1_GPO3.PRG0_RGMII2_RD3 */
+			AM64X_IOPAD(0x01bc, PIN_INPUT, 2)
+			/* (e7-r5) PRG0_PRU1_GPO6.PRG0_RGMII2_RXC */
+			AM64X_IOPAD(0x01c8, PIN_INPUT, 2)
+			/* (b7-w3) PRG0_PRU1_GPO4.PRG0_RGMII2_RX_CTL */
+			AM64X_IOPAD(0x01c0, PIN_INPUT, 2)
+
+			/* (a5-w4) PRG0_PRU1_GPO11.PRG0_RGMII2_TD0 */
+			AM64X_IOPAD(0x01dc, PIN_OUTPUT, 2)
+			/* (c5-y4) PRG0_PRU1_GPO12.PRG0_RGMII2_TD1 */
+			AM64X_IOPAD(0x01e0, PIN_OUTPUT, 2)
+			/* (d5-t6) PRG0_PRU1_GPO13.PRG0_RGMII2_TD2 */
+			AM64X_IOPAD(0x01e4, PIN_OUTPUT, 2)
+			/* (b4-u6) PRG0_PRU1_GPO14.PRG0_RGMII2_TD3 */
+			AM64X_IOPAD(0x01e8, PIN_OUTPUT, 2)
+			/* (a3-aa4) PRG0_PRU1_GPO16.PRG0_RGMII2_TXC */
+			AM64X_IOPAD(0x01f0, PIN_OUTPUT, 2)
+			/* (c4-u5) PRG0_PRU1_GPO15.PRG0_RGMII2_TX_CTL */
+			AM64X_IOPAD(0x01ec, PIN_OUTPUT, 2)
+		>;
+	};
+
+	icssg0_iep0_pins_default: icssg0-iep0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01ac, PIN_OUTPUT, 2) /* (W1) PRG0_PRU0_GPO19.PRG0_IEP0_EDC_SYNC_OUT0 */
+		>;
+	};
+};
+
+&icssg0_mdio {
+	pinctrl-names = "default";
+	status = "okay";
+	pinctrl-0 = <&pru_icssg0_mdio_pins_default>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	icssg0_phy00: ethernet-phy@0 {
+		reg = <0x0>;
+	};
+
+	icssg0_phy01: ethernet-phy@1 {
+		reg = <0xA>;
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


