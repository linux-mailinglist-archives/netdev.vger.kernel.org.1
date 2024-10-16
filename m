Return-Path: <netdev+bounces-136064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65659A02E5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E84D287797
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12971C4A02;
	Wed, 16 Oct 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="JEUjsCpV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26B1B4C23;
	Wed, 16 Oct 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064647; cv=fail; b=Y/WvdpnDX3p6ZAAnWbEHtFXA3fk8DM6O5rtouSnv+0MUR1H/d4waM3SUgGRftFPIMR1610OO483aRNWvObLJjljVlg8K2UorxfLgfPeIqy4u1I1gIDuThgcGMFLAxxD76/UajiVvRgric1ibsRUkWmtb5JRnmDU+9EZlwO37YRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064647; c=relaxed/simple;
	bh=ECj8R/F1t3KFohA8yQAwqii2MacCWG7p82k2bB/SGws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o9TWMgs/MuYwueYBHl6thBoAVk1f4+ERtSTd5Kwc1MuaYRIm2h3qV7QlktlBNn2fsd1KcX9ws1jbuimdffxRvd2Lrj/FujMvyvGi+h8MNUDE9Y9wKF6hb60YA2S8r4rnmUOdOD7PfDNyuBugO5loIZBML7Cxe1kZJNm3dG290JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=JEUjsCpV; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlC7V+39aES++2Q4Se91LowYIWhx0PRnFbA77BnwelFRf8RbKBKW8W60qQPgNm2jNc4IB6i2uQi1Fz0SaB+JhXysRTT0qHgl/q2V1bgAuVgwaUoxvTtkBc8KjANFbr+gCR7AsBHJPl+YkgJ1IyYJMUJI5p/5M7MNdlAJb8LDbi88pZrWRRL/KqR5TwioXR6ejUTJJ9Iydm05kg0yg/ZDXWBhQqwOJK6E1t+s0SHDfqjcyNGnJu+zVHRoIDdxmycJvQFezXET6fh9LmyK504+B3xxZ7n1AmQiACHvDaYdkcMsJwa54q/WZbzfUy1QVMivS4YnkAGvTchZKLWQvtd3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f44ml4snFkVwlkTRiqFlMQtrTlIyA2nxYMZaPdOLAWk=;
 b=a3JaNqMrRQp3a94WHIeXdAiic3AN0JpcyrsEVE4RfMCcmDqer/kotFQ1MnDXCFBdgCFe7YHlVa+MI0s+nrE7lMSU6YQ7bxK4csRicRV66lyWFMbLZRfjLfdj+milrqV77/d0sV7zuG2Wu9jjQbYYAVsFASYzWy2dtXpNIoYgHqT/b5i+lYlCxNzm4s/bQnE3jDzQUUJUA2P8o9OihgLo3t1NMoX56B8JTUFO4Kble5a7AoqdbQWTVrhw0q+vzNDI7P9l/LNgvc266I/COVMvqHuD6J83e/g+HgCGVP5Nq1Osmm5Yk5S3oHhno04CZNoasZQxbsB/UchhZ8kP1TaFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f44ml4snFkVwlkTRiqFlMQtrTlIyA2nxYMZaPdOLAWk=;
 b=JEUjsCpVb5cCFSJ4iudOLfkC283O99Yvy4YJY8hX8lrYhdunx8aNfexsNlA1BldBrCUy3zyBDIQuMsPzJaj9QlE7JuyXvzUelvhX5xV1INQwBraewy/QmIswvuVGrFOW2ksCG8j4tCDz6rnuB3J28w/rf768evj+sqs1GTvcToM=
Received: from DU2PR04CA0292.eurprd04.prod.outlook.com (2603:10a6:10:28c::27)
 by DB8PR06MB6363.eurprd06.prod.outlook.com (2603:10a6:10:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:43:59 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:28c:cafe::8e) by DU2PR04CA0292.outlook.office365.com
 (2603:10a6:10:28c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 07:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 07:43:58 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 16 Oct 2024 09:43:58 +0200
From: Mamta Shukla <mamta.shukla@leica-geosystems.com>
To: dinguyen@kernel.org,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: bsp-development.geo@leica-geosystems.com,
	Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH] arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead of "ahb"
Date: Wed, 16 Oct 2024 09:41:59 +0200
Message-Id: <20241016074159.2723256-1-mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Oct 2024 07:43:58.0704 (UTC) FILETIME=[29149F00:01DB1F9F]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|DB8PR06MB6363:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dde93b50-dd76-47c7-501d-08dcedb64bc5
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76yeJazws6bjd4cjwxbOp8Orqqbvp4bGLbwkKUumqjYWYeq1MaX72NpL652a?=
 =?us-ascii?Q?YH+hhWeYZQCFTKfhem974RoRw6jcbGp04mNy9IZvW9h3k0PZ1hagQtfBaMAo?=
 =?us-ascii?Q?FOs+2CvNHHvDJaX9ZI4AuWhgvv09h7yc4ogcg6G+7K4kSmzylJS6t61p0Sjp?=
 =?us-ascii?Q?CksIDI538OI1b7dYFSbpCbVgrrR21VuXE0Vg+eEwkmmMW5FRTCE/m7mh8nps?=
 =?us-ascii?Q?SLvP5HwzikyYYA8SzX2fQrbgR+Zm3yvus34wUuGTfz9ZXauQrRCtRxe5rTfd?=
 =?us-ascii?Q?Gm7t1TFJVV/s7FmWrRXmp6bXJzetsDXCPN1BmZvOrqGFjMcCrl/loyOKDBOP?=
 =?us-ascii?Q?RNWvrOghuumWXpdBI/4HUJl8adj281bXWhi0EA4Kt0NaH293zPa30fkta7L/?=
 =?us-ascii?Q?XMLM8RiBN9vOOBPjn/UDZtRf7Iz3iVrik1ixnaAoPMrjGPgeTG9zTmP+uXRe?=
 =?us-ascii?Q?6I4c1/QTVglMbQR3AEzLByGN3bGao6vWkovKWwjzN9sTS/ZUpcYm6fWYkNZE?=
 =?us-ascii?Q?azBu/sy/K3meIGlgC+Tin3cQR4+CO093qyeJnI0NbkhRqqAyz07ha58KCeSW?=
 =?us-ascii?Q?huE4eMsmExYPdHOTSxBYqMIIAWQnlPRvH7hlh56xqxQvQq1LMY/Zb7bfCCRl?=
 =?us-ascii?Q?3VbWqNX3H7+N6ojZv7cGi9YI784GdMsqYxOLDvBcun3n+06KVXyLjMNP4at/?=
 =?us-ascii?Q?dkxH7rqtFJGAusJa5MpI4RKmv5hGiin7ko1Dl118g6PM8+dRljlJetVZdI1S?=
 =?us-ascii?Q?NIzc3aT/IXmdOhwh1on/2G8G/cocRGeYnjpKDw7ZIfWnkjpcd7v4X6gnykVA?=
 =?us-ascii?Q?7KelyWwci9KJuDmEqJF8YBP5xHklnfgUJaRWDJu0TjtGIaEo3RMEKga6iWyw?=
 =?us-ascii?Q?N8aYFdnCV1I9Y41hqeDe8Y27mm5aCS3yR/xcwEVse7f5eu4h0ucMWIyidNXb?=
 =?us-ascii?Q?NUsD5Z8aMtd0WJc4wD47uqhQNZiz2fX76fbPzKuf6Q4qlHBp7Hi9FTwjHzrG?=
 =?us-ascii?Q?W7nbo4XJXdpRbanVgib/cBbW0rlF+ix/TCWN8ZN70kIIB+u4rv6ZfIjGdIYQ?=
 =?us-ascii?Q?bwzl0hDs0GfRN/MZ9f0HvWj0WYCM2E5m2Aa3lr1afHhco/46SunUjGngZzkI?=
 =?us-ascii?Q?N0kQ9MTiEbHLwNxeyvxwUbjGlP3KNhPbibjugBgUf/a1+Hl7A8lSxlDBKXns?=
 =?us-ascii?Q?qyQlDnJL++SEYYGhAZAwGZ8NJXM7ln4Kj6nTCMnWoLh3LmyvRLF7L+6N/yPX?=
 =?us-ascii?Q?ZH8Y5P3z0ag17gnqjEZj/QZKJNe3KtFQXnrZfXIplzEACjZSxeoEULB7CmMc?=
 =?us-ascii?Q?/6sT21GEJPB5iLfQ2DRtPusoj6wdgurc57jSRHay11ag7O+OU9sm46/6IAre?=
 =?us-ascii?Q?VrYD+BAkV+K93H0wFrFXtbVP+rav0xVfH0BCLAkwIFvWQ+iN4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:43:58.9414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde93b50-dd76-47c7-501d-08dcedb64bc5
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6363

The "stmmaceth-ocp" reset line in dwmac-socfpga driver is required
to get EMAC controller out of reset on Arria10[1].
Changed in Upstream to "ahb"(331085a423b  arm64: dts: socfpga: change the
reset-name of "stmmaceth-ocp" to "ahb" ).

If "ahb" reset-line is used, connection via ssh is found to be slow and significant
packet loss observed with ping. This prominently happens with Real Time Kernel
(PREEMPT_RT enabled). Further with STMMAC-SELFTEST Driver enabled, ethtool test
also FAILS.

$ ethtool -t eth0
[  322.946709] socfpga-dwmac ff800000.ethernet eth0: entered promiscuous mode
[  323.374558] socfpga-dwmac ff800000.ethernet eth0: left promiscuous mode
The test result is FAIL
The test extra info:
 1. MAC Loopback                 0
 2. PHY Loopback                 -110
 3. MMC Counters                 -110
 4. EEE                          -95
 5. Hash Filter MC               0
 6. Perfect Filter UC            -110
 7. MC Filter                    -110
 8. UC Filter                    0
 9. Flow Control                 -110
10. RSS                          -95
11. VLAN Filtering               -95
12. VLAN Filtering (perf)        -95
13. Double VLAN Filter           -95
14. Double VLAN Filter (perf)    -95
15. Flexible RX Parser           -95
16. SA Insertion (desc)          -95
17. SA Replacement (desc)        -95
18. SA Insertion (reg)           -95
19. SA Replacement (reg)         -95
20. VLAN TX Insertion            -95
21. SVLAN TX Insertion           -95
22. L3 DA Filtering              -95
23. L3 SA Filtering              -95
24. L4 DA TCP Filtering          -95
25. L4 SA TCP Filtering          -95
26. L4 DA UDP Filtering          -95
27. L4 SA UDP Filtering          -95
28. ARP Offload                  -95
29. Jumbo Frame                  -110
30. Multichannel Jumbo           -95
31. Split Header                 -95
32. TBS (ETF Scheduler)          -95

[  324.881327] socfpga-dwmac ff800000.ethernet eth0: Link is Down
[  327.995360] socfpga-dwmac ff800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

Link:[1] https://www.intel.com/content/www/us/en/docs/programmable/683711/21-2/functional-description-of-the-emac.html
Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index f36063c57c7f..72c55e5187ca 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -440,7 +440,7 @@ gmac0: ethernet@ff800000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC0_RESET>, <&rst EMAC0_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -460,7 +460,7 @@ gmac1: ethernet@ff802000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC1_RESET>, <&rst EMAC1_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
@@ -480,7 +480,7 @@ gmac2: ethernet@ff804000 {
 			clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
 			clock-names = "stmmaceth", "ptp_ref";
 			resets = <&rst EMAC2_RESET>, <&rst EMAC2_OCP_RESET>;
-			reset-names = "stmmaceth", "ahb";
+			reset-names = "stmmaceth", "stmmaceth-ocp";
 			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
-- 
2.25.1


