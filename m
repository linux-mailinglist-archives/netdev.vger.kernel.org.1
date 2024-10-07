Return-Path: <netdev+bounces-132759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F89930A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF01CB22937
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE21D9A40;
	Mon,  7 Oct 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PXM502KE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D71D934D;
	Mon,  7 Oct 2024 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313595; cv=fail; b=T7UxfaETntJm8ocIUaalqpjpFJPMVp2me8exQE9Qbs9Yr8dMnuSx25fM1yNFLRMs93JGsF3Z39caMzimBUxdE/zu2v2YbO1mBovUK+xOvrNRY63RXsfUxy/tEmsz2ci4r3BvTJoIycbPyNEv+RAEvmQoaPGwtitXNIEEPjaGKQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313595; c=relaxed/simple;
	bh=/BnsBb+tWIpEGtb1y1NQyPkL4uLRjYVnuWROv3J23Og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPiQOZwSqK+T9qH9V3+msxNqQ/4rzduijdrrYvHLytnZ3iVZoIMnE9gqOs3QBnYAIjPVKcK0FOLApMUwfCNqcvd3/nGmFFOKnK5QkUYRjSZNg8R+pYqwnrkkUNFoVSqGynB5P+3gpje5cFZDzzuRK2YoklahYZnxFhkUKyNv0SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PXM502KE; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra+lUFbQNgsmtTXHB4r2y6N3+l8l91+A0E6AQen5WZR0Y32Yh4VuIiW7rlLEYvTxBwK4ZQtaq9ENFGF/Q6szrgUgVlVsG9KlTIRnG9j39TUm7Enov+kkf92Jybpa8xJRwo38j7+FxkzRWJf6iv8w8SCNtXKxujK8LRjUcN6btrgrdbLo9ldtRdXu5F0Y5/hfv5wSCxdnyLWjsjvqgy8RyU5KmrylYpFLbTWBVPuiKilvva6dWpcLaaH1550HP+j/5uTwxNDmNh9fN+KneonAeJbSqh5/YhoinWW3JX7d0gGLPoW8U5xP8RsjOoWxSWzkQbaW22vXzSOYD4oKuHPQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXZOcttCcNKF06ZH/EOUl92KAIgU1q5QSWG11onV2SI=;
 b=h7fxfYQBqDGAt6UjC/6S/1nYnYiluuZjuZRVdxPWpyzsHVVqW6D197qdZRUVl+LIdZ6VXYyk3abMXYyY5D8Uf76Az47yhb0jIgsEf4wlrvgpOlmmThqb4Ps5AXsqoVkKbrVm94uN9EX7aQQHx5VNreTLs0gw6nZqbCdmfx1O3phN+3sijkAXf8QVH2RMz2Zb1ee8xtlnAmxt22vZfptGgAYprZEPrPupsqMp8bGS8paEd11LHeyik6atcfviLNgDLNdRTlf2Lcd3m/PXZINOIBJzaMpPE4tswPVcPi4o6s50ORnGyWUU+Y0F0Ctnqov2Zf2sKk1lp0a4p25CYzAuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXZOcttCcNKF06ZH/EOUl92KAIgU1q5QSWG11onV2SI=;
 b=PXM502KE0SKd7ZzwuXLKyIz+Xlc0szLmMMz4AUKs8xGAyMrv50juEJ4v7Uef5POPkn0KOO/n+lymK9wXv2+tkc91T1v1LBBDdP9WVyxlSubUHd2XfFhobx4CBby3k2lFFWoFA8OjciYzRWJPsamSW5Y+J9fsG2qdLd5ui6tonLM=
Received: from PH8PR22CA0014.namprd22.prod.outlook.com (2603:10b6:510:2d1::29)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:06:27 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::78) by PH8PR22CA0014.outlook.office365.com
 (2603:10b6:510:2d1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 15:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 15:06:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 10:06:24 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 10:06:20 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: emaclite: Add clock support
Date: Mon, 7 Oct 2024 20:36:01 +0530
Message-ID: <1728313563-722267-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ddaa96-7aa7-4ec6-9a4a-08dce6e19d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lM6G7kp5YXP2VOBQdedTOW86IQOYWiT94tYBgGOW97PtsACxNebDCwCCKNqf?=
 =?us-ascii?Q?hTs9rAUtMdJgqnDRiNh3T+ddj02bj2p/Ef6dDSnrLvDl7MGWY2si2c2GK8Kx?=
 =?us-ascii?Q?37gdmZm5vShudcL17krayUz7eipb0d98skWYcZwtbuN15BNWnUufbpqBXpZ+?=
 =?us-ascii?Q?ptuXqseZNRHjjLD5jho58dnXYwJfboUiPTFKzJieRdFD3cGl3L8UcgS9vFBy?=
 =?us-ascii?Q?uKs03mtnGHwltUJt8d05hqDkB//mS5o4KREqNwyUCe+a+891eynYGZhobrkd?=
 =?us-ascii?Q?uRe/p5B9XidZ2KakrB2Uw1Yy12Gx8YEGvY9vYw8JkvS2od9DBQ0dUYUVCKCb?=
 =?us-ascii?Q?9G0ZAt4MwzH/stlCecnr+btjciScQ5zYeWGF+xQhJBN5MkD87TWFwpinAx64?=
 =?us-ascii?Q?adN7hVUHZrBM+tzoZLNTqoejgehp/JywgKHQfH+l+4xScEcoTCdBZPh16oX7?=
 =?us-ascii?Q?qanATuURu1IY7OVvntJ1kPQxhg8ri7EfC6DpFZWZ97MdaElosL1ZiRPn3Q0+?=
 =?us-ascii?Q?fFQYrkxAtSdKuDwWo6B+0h+etqi2+bFiCGV6UZvns8xXpWBwqecFYeo+0m9a?=
 =?us-ascii?Q?ixSRL1BcIpn+fHOE0XN6Jdk3l0uTCCHWeTLOPw8aTVtmdQHMLX6fieldSahL?=
 =?us-ascii?Q?SI3yMV8evVA9kBD5sAP8YVhoJmAV49yM+cd7AjdlyiZALC8Do2gN5tljF9lQ?=
 =?us-ascii?Q?pMriCEH8172kgBb0T6x/FmRTbuKR8+O4Q/Bj/UckwZn264fJmkihsMwz3vGG?=
 =?us-ascii?Q?merdpmmoCqXOPsP6V8HVMbqc0kTMnN/WsNspz0qkdZkrKKr+/PTC6gcCGeYT?=
 =?us-ascii?Q?RekjAs866VMSIzgg+6m5EbX+SUB8INAOIBmseHtMLGYBza2QGAC0R9u9VMI5?=
 =?us-ascii?Q?1OFqsmz0HSeLC27X99Mm2/FuO0vvmtHogkLrOuhIzkB7pG2m5mElPhL7lG5e?=
 =?us-ascii?Q?eR7CW8QPqjqnFJAdP/I7LcVuSLqjX9xD0fmMEEkvL0+YmVE500XDkVfOCusy?=
 =?us-ascii?Q?ZPw5+t9lyhoSITIhBgQVm2u0GeveEkMPftE8s2NdlalJjYEuKs3Fc3yhNSR+?=
 =?us-ascii?Q?6LBtCjKuaVG008d94NxgGoYxZGwLthsnfNJ18fUU1unj9z0aDpw8hGEb5hfX?=
 =?us-ascii?Q?oUQV9P1FOh/Nuqxxh+n3iPknac+Q0QVPEJUHEgSB5gmet6DGF7maNL0YDMAJ?=
 =?us-ascii?Q?a+s5a3Y3Tb7K2dE9Sh1k/Xze41JsAmYJYZy5P8++3j6oL6yy/GbJQrKkf3pG?=
 =?us-ascii?Q?AqVu9rOV83SK9rb/1AMCo/QWp7wtdHQral08DXdC5P3SyF93mYofsHH9T3oj?=
 =?us-ascii?Q?ZhbbUYsnSLtW7n/+pzteDyuBAKbCs6ORPDUhq9EqDC1h/TE0zrrmjemsxa9D?=
 =?us-ascii?Q?1gmTUhwhVUZIGThWJIq+07FqL1Pw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:06:26.3382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ddaa96-7aa7-4ec6-9a4a-08dce6e19d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

From: Abin Joseph <abin.joseph@amd.com>

Add s_axi_aclk AXI4 clock support. Traditionally this IP was used on
microblaze platforms which had fixed clocks enabled all the time. But
since its a PL IP, it can also be used on SoC platforms like Zynq
UltraScale+ MPSoC which combines processing system (PS) and user
programmable logic (PL) into the same device. On these platforms instead
of fixed enabled clocks it is mandatory to explicitly enable IP clocks
for proper functionality.

So make clock a required property and also define max supported clock
constraints.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Describe clocks as required property.
---
 Documentation/devicetree/bindings/net/xlnx,emaclite.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
index 92d8ade988f6..e16384aff557 100644
--- a/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
@@ -29,6 +29,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   phy-handle: true
 
   local-mac-address: true
@@ -45,6 +48,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - clocks
   - phy-handle
 
 additionalProperties: false
@@ -56,6 +60,7 @@ examples:
         reg = <0x40e00000 0x10000>;
         interrupt-parent = <&axi_intc_1>;
         interrupts = <1>;
+        clocks = <&dummy>;
         local-mac-address = [00 00 00 00 00 00];
         phy-handle = <&phy0>;
         xlnx,rx-ping-pong;
-- 
2.34.1


