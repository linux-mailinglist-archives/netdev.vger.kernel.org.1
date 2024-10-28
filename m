Return-Path: <netdev+bounces-139572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B99B342A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B561281A78
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC851DE2B1;
	Mon, 28 Oct 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="NJ/QgNkw"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74D18E354;
	Mon, 28 Oct 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127567; cv=fail; b=NfgpDEnsGKoGJXMLe2gCxGw+S+c0f8OtgxATx2fgmmgNdBeBhKJTO77dP+FpMzQu3VrZeFVi3CbfXfoXrM4eYaaT1STAoBIOZVy7is1L67vwzQpVDlaQ9tze2GmqrBUkhpg/GgW31EGaBsyYCxkhADev8yqsUR2vTR+jc1i6aL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127567; c=relaxed/simple;
	bh=leB1+sqgbXX6QZSCuX2NhBvJ8I6amVBhYT2rM3HrLY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cCiVW1bPE/fhNm2hKxBxh/9qMnWj/yd5OJm28FmbNI2OpuwoOKoT4o+jecCIPqxCfJoAYrUgMmJqukyRsSs+ejqErmhI40RwdkCTHlK3thrgERH0mNPGnrcEVgNBSFYWf6hPmLiV1Z/Io40v1X6xybECaURhRtV8pKmGNjphQU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=NJ/QgNkw; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddMzC1vkIROGKH3J8RctMR0X20EqjmHfsociYS+1ROM+Ay3fdT3xE/jKwwnF+Dg/4hrXy5mQmvZU+0FFQlH/0lu+FRFWTabzMuM33iSDwqhflfDP8+MuAZy1kgtb4r32xzdvM3viLkAeaSwbcpyGFLSGGh1VZth+YP+gPgbOgbfkclEgSzexuD19RBJQtz8oyk5MXOefipGvPF/xyklnrTyjsKo24JdUCMsGB3o4lWUUWiRUcOlqUBsTyJjo1tDfH8w5A6KNfBf6JTr44MC83bhyjGLzyvhwe3dYFz8uyO+0r0Y75nBiRVdRCIIhjdmBjLnPsIAJx4v1VM62Qtr82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30rG/7YxDBbuHOl7//qMEkeVkEZ72lzZkZHeP/aTPAg=;
 b=ChvbZOvIrLZmIoD81EemYWitxWvj2Ew9CCZnOuY9CbV3kmec+p5Df7gQxhIMl76pAPIM/jGXxMRz7TSYTlqUYR+QoMDhF5JlTyWFYwghF+/PyQMbupSSKYIEhh7AWYbiIED0WZXwScezP67EvuJyqRWPtizYt0NzpOnPxiM9WSumz9jTnfNvNJ6ZMWjrhnrqjN2T+uTQ2CxNCWRN4PPTHw6yqzkjLx45gHd8tw4LS/VRMPC6dPSmaXHSdU6hTG9qsFtwgxAoxpze9lhjUyLa9b24eR5VV/+XQRA4V+5pqVVNDdTLhxAC8h6iOJ3zPYlhTHmi/lhHuKzeZL+57MhKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30rG/7YxDBbuHOl7//qMEkeVkEZ72lzZkZHeP/aTPAg=;
 b=NJ/QgNkwvrxZqeI5QzuG3oF/p4/gWEZvZ4GVUMuvY5UYrPYXgqJWUoXmRKPjbNyMyL6SQelyyUXer02cxh6vsRyGJc1RP+o+XNPmQq2TzzzvbNoMRz1fW0/AshvgA960bYvO/QN7rbom7QhDF6YRuYyx8qukNCu+GIYJaV+Re9Y=
Received: from AS8PR04CA0092.eurprd04.prod.outlook.com (2603:10a6:20b:31e::7)
 by DU4PR06MB9681.eurprd06.prod.outlook.com (2603:10a6:10:55d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:59:22 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:31e:cafe::88) by AS8PR04CA0092.outlook.office365.com
 (2603:10a6:20b:31e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 14:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.0 via Frontend Transport; Mon, 28 Oct 2024 14:59:21 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Mon, 28 Oct 2024 15:59:21 +0100
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
	netdev@vger.kernel.org,
	a.fatoum@pengutronix.de
Cc: bsp-development.geo@leica-geosystems.com,
	Mamta Shukla <mamta.shukla@leica-geosystems.com>
Subject: [PATCH net v2] arm: dts: socfpga: use reset-name "stmmaceth-ocp" instead of "ahb"
Date: Mon, 28 Oct 2024 15:59:07 +0100
Message-Id: <20241028145907.1698960-1-mamta.shukla@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2024 14:59:21.0649 (UTC) FILETIME=[F886B210:01DB2949]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|DU4PR06MB9681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d754728f-0599-4490-e223-08dcf7611b26
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EXpAB1Fn33xi2Rp797xr0rsFHE+ehhDVIAkp6/BDJCxz2ep7RILENKIbdYU?=
 =?us-ascii?Q?eNp/XLvyPeASBKznpqosHJtLeFXscWQaDCk2Ge1mf4HhcazBfTySLT4h0UF6?=
 =?us-ascii?Q?1sN3XENRmARTR2nY3a/3EVpxod5JbO5YDOU9zbooiDTtY27UqTgehWlynk0z?=
 =?us-ascii?Q?WOR51B+7kKwxzddx8RW9wPHz8rfidZRg4BAVczW6u5jMFZP5MWWO4Ly2UUJt?=
 =?us-ascii?Q?5nAv1YS13ZWHo/oM1rCGNBOtruzSZoZw+e59GWfJONbHB8e5aB4oPIDXinb3?=
 =?us-ascii?Q?8rgSm4JfadX2vt32nvuNFTWfT+CoF+xukl6zvDoeLkhha4NeggRuNPWd+/I4?=
 =?us-ascii?Q?2f4YGGXB1z5+zwLZp1tcxLOXdkQPc58v7hf/QauymdI2qNbRGTz4Ll6xFc9d?=
 =?us-ascii?Q?IneQ19UDzWOuTYM9hlh/7KbOr0NmGHwCJ2nZ8HS3hRjyhXvkNYGfAiYZTYrQ?=
 =?us-ascii?Q?M6I04Eqa22pxQCHehQPf7bjc+voZm2c2724jTufnv/+fvqOpEpDGZvcaIAJ3?=
 =?us-ascii?Q?0cPDY/TW1Foz7QMuSMs1qvyTCH8/axYgnUA6dOyxthe0oHXfijqdv/CQ+55l?=
 =?us-ascii?Q?Kbqum3Bgv3FOk9pK5jC3jlDR9s4yrN7RrA93uaAZHOvmSAuU1893osCzVd7J?=
 =?us-ascii?Q?Fa0kNL7/1IdQi6x02TImcgzhIM3qskVe1ky1W5T34+84Bky718awGIHSczTT?=
 =?us-ascii?Q?FQK5EaVXt+QiH9/m0/N2qY/7+KcvNmhNxmfGUHzSQLto5PxKm326PAzosGhR?=
 =?us-ascii?Q?DPRkkQ28fB4Vqu/azitzO9CknZjvjXecrUvAa5pnuW2+qdIjyASfFwqfkPTa?=
 =?us-ascii?Q?ey633VQOQ1GMEKu5ujouSFyUY9q0cETU+EW5KTmfhYbLpus8iGv6QM/vD9NX?=
 =?us-ascii?Q?Twvj/YGQe5eMWL9pchHDZ5bJXOOZKbGQfkqTw4QYRsT/lSTXfvBEwUkz16OA?=
 =?us-ascii?Q?K80Mm4f9GbZNJmu7oz744MccfHb61VMUkenFusHCCFJPCi0fLey4et3ocelP?=
 =?us-ascii?Q?Dzu6C3+a5+BrSWRrEu14tent9YJJMsEz7zWtjHkwdtGRSPOvcxIiDiKhnlJl?=
 =?us-ascii?Q?kCX/Ep/nQPw8Il20w0ZQF1D6q84Ki9nLt2HMaiJ6wO3qhrZ9fF+Nu+uC5C4G?=
 =?us-ascii?Q?b3ey1PNHD78F3rbPccih3EZGnboZLm5BUtvnCHyq26U7zgjAuSc7qj/xUQAV?=
 =?us-ascii?Q?+PZ09+wqUikeaS7+FIQ82WkrY7G5Cs+sDGsOkuZTE/104H4HQkCqNkGB3vMj?=
 =?us-ascii?Q?cKsWkRFyOP3JZO0KfMDuApw4iQXQ65RpUzk/2OeVdo+dfcXCC5dYTv6Z5jQI?=
 =?us-ascii?Q?BZ5sNvdU+1DEbuMgwYzg/FddGCKhrxLSqqZlXLA6wo0MovmGwVT7AODPe2dG?=
 =?us-ascii?Q?3b7/U9HUu32ZfR92M1vX90YRtjUAb4Pic+kVKQcRKUX/irFPEyU57pDl2obT?=
 =?us-ascii?Q?0iBcaI7SocQ=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:59:21.8408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d754728f-0599-4490-e223-08dcf7611b26
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB9681

The ahb reset is deasserted in probe before first register access, while the
stmmacheth-ocp reset needs to be asserted every time before changing the phy
mode in Arria10[1].

Changed in Upstream to "ahb"(331085a423b  arm64: dts: socfpga: change the
reset-name of "stmmaceth-ocp" to "ahb" ).This change was intended for arm64
socfpga and it is not applicable to Arria10.

Further with STMMAC-SELFTEST Driver enabled, ethtool test also FAILS.
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
Fixes: 331085a423b ("arm64: dts: socfpga: change the reset-name of "stmmaceth-ocp" to "ahb")
Signed-off-by: Mamta Shukla <mamta.shukla@leica-geosystems.com>
Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Changes in v2:
- Fix subject prefix
- Reword commit message.

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

