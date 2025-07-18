Return-Path: <netdev+bounces-208234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE31B0AA74
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923E95C12D2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8DD2E7F36;
	Fri, 18 Jul 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqEiCZ4d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181191DE2C9
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865041; cv=fail; b=IRqsW64QLd+qfHJ6Ha+I44njWUOFhRbf+Y3b9K8TQIUxx5QUjmiJI581vmU32VFa/Dn5TyFbzWPWayC1iyPcjD5nvvtByZP6HF0qnL0YyU/LaDgTL+k4eksH8oHVcxa0AylaUUIQ5m0+YFXgD5o2HbNvxYu9i909BpYM0xzb9IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865041; c=relaxed/simple;
	bh=UKmyHzSb/MCslYW5yGIe8VkvpoIjUbu83aoDc1auXuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Je57XP9aw+dzfwxmud7B59LbZ9jbVEqdUKGbmtGGTPq84gx/z9btVKtx0RKhgYc/0kPteOPF3SPFnHrtNzX+uwcxl29GqXgJiPJur8/Y6Voq9e4quN/9lyL3EzqQGzPG5lSWWBV7PtDjVjSps5GrMy/urhfyhekN7TOVKo/ojXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EqEiCZ4d; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVxTrfI66rFxm/u7h+vDpfFzfmDZt89za4op6IqiK7uLNjr803EFb73SzvfBZL0RaW5B7VIFJeUWq6r//rRYz1et0Mh1FjjOBLfxvBpsLT9xCoJ6jv4uujTYKJAbf1nXn+MLKbh+zfeWNTCCPuJlLfUTIENlgYWhNHIyiykCd3V7r3nE65WsAqvmB6XYWO42PpOfR+KG3tr3uKJhehWl593pzi+dBwOCPb2yy+HI0GyUvPnL2dAE92w+SZExsFBiwT702yOF9ZNQfgfOMOK4td/LPmmX0dvg5bHWAmLsB7xEg2j9aa0GvFKyqFepX/oPyJD18FhZU4mLTe1s/1zi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+dAicJZHvq2/wU6Ymf65yKd/tf/AC0za1SFkPpYfLA=;
 b=LTWEq/u1CpAyQVpjN9nnJmbEHnQkcYoDfqJASMz9KZlJzFSPkJKQwAFr/NCVvqDnBFnwrWbIS4BvZECvHP2WyiaK6S9khV8DzsVg96zoL7CpqEHBU7AzP/x4V0K/sgBF7Xjz09HVThZnYxk8VDzYPCDSfppWCh5xW4rHRmDFWOecHHGUyPQmAPjzNwm242UfR+0cYe9V88SGts86BfwtNTagYJua0ve+ixM65J3voUWGVCWcJkPd6QAWYT88+u3pdbnkdQwcBeKV566eCzljsjypXqXK8ieSgylaawKXTGVDkK0AZAR6ySLTuYc2WLda+j1Gg77cNLpibFoibt2ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+dAicJZHvq2/wU6Ymf65yKd/tf/AC0za1SFkPpYfLA=;
 b=EqEiCZ4dRD6YkgBO4cxIEXtDpeqa5SPK04eCko31YwPLyKjJSYXx5+J8m5dg5PNyJhP9Q/HXa37BGdLZCqSnAxG2YViAoSNp9LxVNOAnGswuVjYwCjMwHQSApYEInC0i/ZNmRxBCsnfRqi6gqzH5SHuD/OKxQ4pJZGp4T483h6c=
Received: from MW4PR03CA0111.namprd03.prod.outlook.com (2603:10b6:303:b7::26)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 18:57:13 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::76) by MW4PR03CA0111.outlook.office365.com
 (2603:10b6:303:b7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 18:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 18:57:12 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 13:57:09 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 1/2] and-xgbe: remove the abstraction for hwptp
Date: Sat, 19 Jul 2025 00:26:27 +0530
Message-ID: <20250718185628.4038779-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
References: <20250718185628.4038779-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e58c558-b943-4a65-75d2-08ddc62ce7ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pZYIHOxuRBBsL8q3CtO278x+G4WJwEtJaIMxG43eWE8QTuh6UIBpaj4qRHbC?=
 =?us-ascii?Q?fnA1PHC9EophqHDvlG6h9/w4Z6NV1nGPUCHDXRkabQb0RHNMtqbBv1rYKEj/?=
 =?us-ascii?Q?7Xrk3GI6nICSWSawy0MANpezFxpeB2yhsiHmOxHtQuMx4yIeb1RkbZa44DgY?=
 =?us-ascii?Q?8hCDRpfy9BDY0QwXlCZDZ7mKvLD4B7RNCPekdw7ify3KEt8NZ7actgLg5UNA?=
 =?us-ascii?Q?Mc2WbmpNi/qshud+M4cdBrfQt51j2tn6ShPg4MN6/xKAlHm8YGibM+tLzTmD?=
 =?us-ascii?Q?aBwVFwuDl6TD6oMs8scKA/hY9yh+ukaprKNbj10Y5JUw8szoawW3p5yDdIws?=
 =?us-ascii?Q?tzQbPbc89uuM5bmiWACE8gwJfnn3LOZBsSwjwwpjjd40jHUuEbq4cIwtM3QG?=
 =?us-ascii?Q?TDI3Q3O+p9zeuYqlOvXkr0PQojUhIc55iWQDv9dv0oaXrpVb+qM//vdT+pgx?=
 =?us-ascii?Q?9T2xDCt7odQeZ3E2ia/casxmrf8jHP76RS2OGCHtt5pYtkVhuv2u04CsqVBN?=
 =?us-ascii?Q?Z8Sk0hoDPGR7q0Xb9WGXkZymMJdPnoWOjawICTki4hCsFIyF5/1NtdBtP2Km?=
 =?us-ascii?Q?KiIcxsZG43P60xSvSDRBIEaWpnv4pcJanxg8QfFTBBpz4HqD/1SMuqcINXCb?=
 =?us-ascii?Q?rGkmrtgkWsSEXWsPiyokwysj2e5Cbjn5t+i035WUZNbI8K5u8vWuopD37w2g?=
 =?us-ascii?Q?Plidv5KuJF0W3hGVl3BXzLJe6PeV8FGbr9DDEwbLhlwHUtFMpiiBKEzRRDF+?=
 =?us-ascii?Q?hMG/XaVlx54eOZQPWe5dk1HcZudednlOmidDHMxR6shaHXi7c5/of93G5lpG?=
 =?us-ascii?Q?DVemMbsnY6dgaJ0YZtEojhYOFAo4qLT43lPAtGrmXHuNII5n/fEcnyFYMLHn?=
 =?us-ascii?Q?2fGiHwieclGItXig2bWEaOJyb4CmUeEFPKP/Jpi51rWroDVCpTMknRbQ5wTB?=
 =?us-ascii?Q?39D/nmL9Rp6jPF7Jb/9IfFrar4NRWSJHzEI9URiQZhBXq4llxdpCGDuOOL49?=
 =?us-ascii?Q?XZmkfzU+3Pc7gc1eQGPbBR3p0ro38EgqwoGoEIdHKA98lYJ5jAJHjDJW6ezS?=
 =?us-ascii?Q?Ob/TDwCdl9ZTvO4aEQE95Z9K5GqvjFdoIDVqeOAfkPiOMzg4Zv6BqSmZ+p2c?=
 =?us-ascii?Q?yFiajdNpnWpSDSCjQh/T08FDQKV5GOepD11O3by2+f+E+MLn8zGlpTZl8Av8?=
 =?us-ascii?Q?duaQz5TXomomDT9phmZv8wWHxrBjpG94tmNKQChI72eaR7sUpfz66wnih92L?=
 =?us-ascii?Q?yNa9TePCdTmACcGtKQvBe/jvrNSZK+DowLq6/6L71Lph38FTZd9ktzTG1gk0?=
 =?us-ascii?Q?d0g9IsqA4WwSoRzlb57LjrjBJXuBAisOtUm3HnVol7FbxCG9Kn9vlCSIW242?=
 =?us-ascii?Q?GAJHxR3Oz+HUANA8o8tdYFm0jDkuk5ILf/dZ6UhMMuvBgZBXXBDrQ68mt8xW?=
 =?us-ascii?Q?6b7t8iWvCr45jA4r8sjZ1+cWxBK+DoYpOVdmoe0N8XGwoggMvkLu6Uhh8pRo?=
 =?us-ascii?Q?Pdqykg4wvoN96Yj126/N3ui4JcY/xbg6RQhh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 18:57:12.8263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e58c558-b943-4a65-75d2-08ddc62ce7ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153

Remove the hwptp abstraction and associated callbacks from
the struct xgbe_hw_if {}.

The callback structure was only ever assigned a single function, without
null checks. This cleanup inlines the logic and moves all the hwtstamp
realted code a separate file, improving readability and maintainance.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      | 126 -------
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 195 +----------
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c | 319 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-ptp.c      |   4 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  30 +-
 6 files changed, 345 insertions(+), 331 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c

diff --git a/drivers/net/ethernet/amd/xgbe/Makefile b/drivers/net/ethernet/amd/xgbe/Makefile
index 620785ffbd51..5b0ab6240cf2 100644
--- a/drivers/net/ethernet/amd/xgbe/Makefile
+++ b/drivers/net/ethernet/amd/xgbe/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_AMD_XGBE) += amd-xgbe.o
 
 amd-xgbe-objs := xgbe-main.o xgbe-drv.o xgbe-dev.o \
 		 xgbe-desc.o xgbe-ethtool.o xgbe-mdio.o \
-		 xgbe-ptp.o \
+		 xgbe-hwtstamp.o xgbe-ptp.o \
 		 xgbe-i2c.o xgbe-phy-v1.o xgbe-phy-v2.o \
 		 xgbe-platform.o
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 9e4e79bfe624..e5391a2eca51 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1558,125 +1558,6 @@ static void xgbe_rx_desc_init(struct xgbe_channel *channel)
 	DBGPR("<--rx_desc_init\n");
 }
 
-static void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
-				      unsigned int addend)
-{
-	unsigned int count = 10000;
-
-	/* Set the addend register value and tell the device */
-	XGMAC_IOWRITE(pdata, MAC_TSAR, addend);
-	XGMAC_IOWRITE_BITS(pdata, MAC_TSCR, TSADDREG, 1);
-
-	/* Wait for addend update to complete */
-	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSADDREG))
-		udelay(5);
-
-	if (!count)
-		netdev_err(pdata->netdev,
-			   "timed out updating timestamp addend register\n");
-}
-
-static void xgbe_set_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
-				 unsigned int nsec)
-{
-	unsigned int count = 10000;
-
-	/* Set the time values and tell the device */
-	XGMAC_IOWRITE(pdata, MAC_STSUR, sec);
-	XGMAC_IOWRITE(pdata, MAC_STNUR, nsec);
-	XGMAC_IOWRITE_BITS(pdata, MAC_TSCR, TSINIT, 1);
-
-	/* Wait for time update to complete */
-	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSINIT))
-		udelay(5);
-
-	if (!count)
-		netdev_err(pdata->netdev, "timed out initializing timestamp\n");
-}
-
-static u64 xgbe_get_tstamp_time(struct xgbe_prv_data *pdata)
-{
-	u64 nsec;
-
-	nsec = XGMAC_IOREAD(pdata, MAC_STSR);
-	nsec *= NSEC_PER_SEC;
-	nsec += XGMAC_IOREAD(pdata, MAC_STNR);
-
-	return nsec;
-}
-
-static u64 xgbe_get_tx_tstamp(struct xgbe_prv_data *pdata)
-{
-	unsigned int tx_snr, tx_ssr;
-	u64 nsec;
-
-	if (pdata->vdata->tx_tstamp_workaround) {
-		tx_snr = XGMAC_IOREAD(pdata, MAC_TXSNR);
-		tx_ssr = XGMAC_IOREAD(pdata, MAC_TXSSR);
-	} else {
-		tx_ssr = XGMAC_IOREAD(pdata, MAC_TXSSR);
-		tx_snr = XGMAC_IOREAD(pdata, MAC_TXSNR);
-	}
-
-	if (XGMAC_GET_BITS(tx_snr, MAC_TXSNR, TXTSSTSMIS))
-		return 0;
-
-	nsec = tx_ssr;
-	nsec *= NSEC_PER_SEC;
-	nsec += tx_snr;
-
-	return nsec;
-}
-
-static void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
-			       struct xgbe_ring_desc *rdesc)
-{
-	u64 nsec;
-
-	if (XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSA) &&
-	    !XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSD)) {
-		nsec = le32_to_cpu(rdesc->desc1);
-		nsec <<= 32;
-		nsec |= le32_to_cpu(rdesc->desc0);
-		if (nsec != 0xffffffffffffffffULL) {
-			packet->rx_tstamp = nsec;
-			XGMAC_SET_BITS(packet->attributes, RX_PACKET_ATTRIBUTES,
-				       RX_TSTAMP, 1);
-		}
-	}
-}
-
-static int xgbe_config_tstamp(struct xgbe_prv_data *pdata,
-			      unsigned int mac_tscr)
-{
-	/* Set one nano-second accuracy */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
-
-	/* Set fine timestamp update */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
-
-	/* Overwrite earlier timestamps */
-	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
-
-	XGMAC_IOWRITE(pdata, MAC_TSCR, mac_tscr);
-
-	/* Exit if timestamping is not enabled */
-	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
-		return 0;
-
-	/* Initialize time registers */
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
-	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
-	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
-	xgbe_set_tstamp_time(pdata, 0, 0);
-
-	/* Initialize the timecounter */
-	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
-			 ktime_to_ns(ktime_get_real()));
-
-	return 0;
-}
-
 static void xgbe_tx_start_xmit(struct xgbe_channel *channel,
 			       struct xgbe_ring *ring)
 {
@@ -3671,13 +3552,6 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->rx_mmc_int = xgbe_rx_mmc_int;
 	hw_if->read_mmc_stats = xgbe_read_mmc_stats;
 
-	/* For PTP config */
-	hw_if->config_tstamp = xgbe_config_tstamp;
-	hw_if->update_tstamp_addend = xgbe_update_tstamp_addend;
-	hw_if->set_tstamp_time = xgbe_set_tstamp_time;
-	hw_if->get_tstamp_time = xgbe_get_tstamp_time;
-	hw_if->get_tx_tstamp = xgbe_get_tx_tstamp;
-
 	/* For Data Center Bridging config */
 	hw_if->config_tc = xgbe_config_tc;
 	hw_if->config_dcb_tc = xgbe_config_dcb_tc;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 65447f9a0a59..20d688a1962c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -448,7 +448,7 @@ static void xgbe_isr_bh_work(struct work_struct *work)
 			if (XGMAC_GET_BITS(mac_tssr, MAC_TSSR, TXTSC)) {
 				/* Read Tx Timestamp to clear interrupt */
 				pdata->tx_tstamp =
-					hw_if->get_tx_tstamp(pdata);
+					xgbe_get_tx_tstamp(pdata);
 				queue_work(pdata->dev_workqueue,
 					   &pdata->tx_tstamp_work);
 			}
@@ -1371,199 +1371,6 @@ static void xgbe_restart(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static void xgbe_tx_tstamp(struct work_struct *work)
-{
-	struct xgbe_prv_data *pdata = container_of(work,
-						   struct xgbe_prv_data,
-						   tx_tstamp_work);
-	struct skb_shared_hwtstamps hwtstamps;
-	u64 nsec;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pdata->tstamp_lock, flags);
-	if (!pdata->tx_tstamp_skb)
-		goto unlock;
-
-	if (pdata->tx_tstamp) {
-		nsec = timecounter_cyc2time(&pdata->tstamp_tc,
-					    pdata->tx_tstamp);
-
-		memset(&hwtstamps, 0, sizeof(hwtstamps));
-		hwtstamps.hwtstamp = ns_to_ktime(nsec);
-		skb_tstamp_tx(pdata->tx_tstamp_skb, &hwtstamps);
-	}
-
-	dev_kfree_skb_any(pdata->tx_tstamp_skb);
-
-	pdata->tx_tstamp_skb = NULL;
-
-unlock:
-	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
-}
-
-static int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata,
-				      struct ifreq *ifreq)
-{
-	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
-			 sizeof(pdata->tstamp_config)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
-				      struct ifreq *ifreq)
-{
-	struct hwtstamp_config config;
-	unsigned int mac_tscr;
-
-	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	mac_tscr = 0;
-
-	switch (config.tx_type) {
-	case HWTSTAMP_TX_OFF:
-		break;
-
-	case HWTSTAMP_TX_ON:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	default:
-		return -ERANGE;
-	}
-
-	switch (config.rx_filter) {
-	case HWTSTAMP_FILTER_NONE:
-		break;
-
-	case HWTSTAMP_FILTER_NTP_ALL:
-	case HWTSTAMP_FILTER_ALL:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENALL, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2, UDP, any kind of event packet */
-	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		fallthrough;	/* to PTP v1, UDP, any kind of event packet */
-	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2, UDP, Sync packet */
-	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		fallthrough;	/* to PTP v1, UDP, Sync packet */
-	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2, UDP, Delay_req packet */
-	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		fallthrough;	/* to PTP v1, UDP, Delay_req packet */
-	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* 802.AS1, Ethernet, any kind of event packet */
-	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* 802.AS1, Ethernet, Sync packet */
-	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* 802.AS1, Ethernet, Delay_req packet */
-	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2/802.AS1, any layer, any kind of event packet */
-	case HWTSTAMP_FILTER_PTP_V2_EVENT:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2/802.AS1, any layer, Sync packet */
-	case HWTSTAMP_FILTER_PTP_V2_SYNC:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	/* PTP v2/802.AS1, any layer, Delay_req packet */
-	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
-		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
-		break;
-
-	default:
-		return -ERANGE;
-	}
-
-	pdata->hw_if.config_tstamp(pdata, mac_tscr);
-
-	memcpy(&pdata->tstamp_config, &config, sizeof(config));
-
-	return 0;
-}
-
-static void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
-				struct sk_buff *skb,
-				struct xgbe_packet_data *packet)
-{
-	unsigned long flags;
-
-	if (XGMAC_GET_BITS(packet->attributes, TX_PACKET_ATTRIBUTES, PTP)) {
-		spin_lock_irqsave(&pdata->tstamp_lock, flags);
-		if (pdata->tx_tstamp_skb) {
-			/* Another timestamp in progress, ignore this one */
-			XGMAC_SET_BITS(packet->attributes,
-				       TX_PACKET_ATTRIBUTES, PTP, 0);
-		} else {
-			pdata->tx_tstamp_skb = skb_get(skb);
-			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-		}
-		spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
-	}
-
-	skb_tx_timestamp(skb);
-}
-
 static void xgbe_prep_vlan(struct sk_buff *skb, struct xgbe_packet_data *packet)
 {
 	if (skb_vlan_tag_present(skb))
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
new file mode 100644
index 000000000000..3ee641a7ebaf
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
+/*
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#include "xgbe.h"
+#include "xgbe-common.h"
+
+void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
+			       unsigned int addend)
+{
+	unsigned int count = 10000;
+
+	/* Set the addend register value and tell the device */
+	XGMAC_IOWRITE(pdata, MAC_TSAR, addend);
+	XGMAC_IOWRITE_BITS(pdata, MAC_TSCR, TSADDREG, 1);
+
+	/* Wait for addend update to complete */
+	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSADDREG))
+		udelay(5);
+
+	if (!count)
+		netdev_err(pdata->netdev,
+			   "timed out updating timestamp addend register\n");
+}
+
+void xgbe_set_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
+			  unsigned int nsec)
+{
+	unsigned int count = 10000;
+
+	/* Set the time values and tell the device */
+	XGMAC_IOWRITE(pdata, MAC_STSUR, sec);
+	XGMAC_IOWRITE(pdata, MAC_STNUR, nsec);
+	XGMAC_IOWRITE_BITS(pdata, MAC_TSCR, TSINIT, 1);
+
+	/* Wait for time update to complete */
+	while (--count && XGMAC_IOREAD_BITS(pdata, MAC_TSCR, TSINIT))
+		udelay(5);
+
+	if (!count)
+		netdev_err(pdata->netdev, "timed out initializing timestamp\n");
+}
+
+u64 xgbe_get_tstamp_time(struct xgbe_prv_data *pdata)
+{
+	u64 nsec;
+
+	nsec = XGMAC_IOREAD(pdata, MAC_STSR);
+	nsec *= NSEC_PER_SEC;
+	nsec += XGMAC_IOREAD(pdata, MAC_STNR);
+
+	return nsec;
+}
+
+u64 xgbe_get_tx_tstamp(struct xgbe_prv_data *pdata)
+{
+	unsigned int tx_snr, tx_ssr;
+	u64 nsec;
+
+	if (pdata->vdata->tx_tstamp_workaround) {
+		tx_snr = XGMAC_IOREAD(pdata, MAC_TXSNR);
+		tx_ssr = XGMAC_IOREAD(pdata, MAC_TXSSR);
+	} else {
+		tx_ssr = XGMAC_IOREAD(pdata, MAC_TXSSR);
+		tx_snr = XGMAC_IOREAD(pdata, MAC_TXSNR);
+	}
+
+	if (XGMAC_GET_BITS(tx_snr, MAC_TXSNR, TXTSSTSMIS))
+		return 0;
+
+	nsec = tx_ssr;
+	nsec *= NSEC_PER_SEC;
+	nsec += tx_snr;
+
+	return nsec;
+}
+
+void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
+			struct xgbe_ring_desc *rdesc)
+{
+	u64 nsec;
+
+	if (XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSA) &&
+	    !XGMAC_GET_BITS_LE(rdesc->desc3, RX_CONTEXT_DESC3, TSD)) {
+		nsec = le32_to_cpu(rdesc->desc1);
+		nsec <<= 32;
+		nsec |= le32_to_cpu(rdesc->desc0);
+		if (nsec != 0xffffffffffffffffULL) {
+			packet->rx_tstamp = nsec;
+			XGMAC_SET_BITS(packet->attributes, RX_PACKET_ATTRIBUTES,
+				       RX_TSTAMP, 1);
+		}
+	}
+}
+
+int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr)
+{
+	/* Set one nano-second accuracy */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCTRLSSR, 1);
+
+	/* Set fine timestamp update */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSCFUPDT, 1);
+
+	/* Overwrite earlier timestamps */
+	XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TXTSSTSM, 1);
+
+	XGMAC_IOWRITE(pdata, MAC_TSCR, mac_tscr);
+
+	/* Exit if timestamping is not enabled */
+	if (!XGMAC_GET_BITS(mac_tscr, MAC_TSCR, TSENA))
+		return 0;
+
+	/* Initialize time registers */
+	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SSINC, XGBE_TSTAMP_SSINC);
+	XGMAC_IOWRITE_BITS(pdata, MAC_SSIR, SNSINC, XGBE_TSTAMP_SNSINC);
+	xgbe_update_tstamp_addend(pdata, pdata->tstamp_addend);
+	xgbe_set_tstamp_time(pdata, 0, 0);
+
+	/* Initialize the timecounter */
+	timecounter_init(&pdata->tstamp_tc, &pdata->tstamp_cc,
+			 ktime_to_ns(ktime_get_real()));
+
+	return 0;
+}
+
+void xgbe_tx_tstamp(struct work_struct *work)
+{
+	struct xgbe_prv_data *pdata = container_of(work,
+						   struct xgbe_prv_data,
+						   tx_tstamp_work);
+	struct skb_shared_hwtstamps hwtstamps;
+	unsigned long flags;
+	u64 nsec;
+
+	spin_lock_irqsave(&pdata->tstamp_lock, flags);
+	if (!pdata->tx_tstamp_skb)
+		goto unlock;
+
+	if (pdata->tx_tstamp) {
+		nsec = timecounter_cyc2time(&pdata->tstamp_tc,
+					    pdata->tx_tstamp);
+
+		memset(&hwtstamps, 0, sizeof(hwtstamps));
+		hwtstamps.hwtstamp = ns_to_ktime(nsec);
+		skb_tstamp_tx(pdata->tx_tstamp_skb, &hwtstamps);
+	}
+
+	dev_kfree_skb_any(pdata->tx_tstamp_skb);
+
+	pdata->tx_tstamp_skb = NULL;
+
+unlock:
+	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
+}
+
+int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
+{
+	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
+			 sizeof(pdata->tstamp_config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
+{
+	struct hwtstamp_config config;
+	unsigned int mac_tscr;
+
+	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	mac_tscr = 0;
+
+	switch (config.tx_type) {
+	case HWTSTAMP_TX_OFF:
+		break;
+
+	case HWTSTAMP_TX_ON:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	switch (config.rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_ALL:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENALL, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* PTP v2, UDP, any kind of event packet */
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		fallthrough;    /* to PTP v1, UDP, any kind of event packet */
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+		/* PTP v2, UDP, Sync packet */
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		fallthrough;    /* to PTP v1, UDP, Sync packet */
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* PTP v2, UDP, Delay_req packet */
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		fallthrough;    /* to PTP v1, UDP, Delay_req packet */
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* 802.AS1, Ethernet, any kind of event packet */
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* 802.AS1, Ethernet, Sync packet */
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* 802.AS1, Ethernet, Delay_req packet */
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, AV8021ASMEN, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* PTP v2/802.AS1, any layer, any kind of event packet */
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, SNAPTYPSEL, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* PTP v2/802.AS1, any layer, Sync packet */
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+		/* PTP v2/802.AS1, any layer, Delay_req packet */
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSVER2ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV4ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSIPV6ENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSMSTRENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSEVNTENA, 1);
+		XGMAC_SET_BITS(mac_tscr, MAC_TSCR, TSENA, 1);
+		break;
+
+	default:
+		return -ERANGE;
+	}
+
+	xgbe_config_tstamp(pdata, mac_tscr);
+
+	memcpy(&pdata->tstamp_config, &config, sizeof(config));
+
+	return 0;
+}
+
+void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
+			 struct sk_buff *skb,
+			 struct xgbe_packet_data *packet)
+{
+	unsigned long flags;
+
+	if (XGMAC_GET_BITS(packet->attributes, TX_PACKET_ATTRIBUTES, PTP)) {
+		spin_lock_irqsave(&pdata->tstamp_lock, flags);
+		if (pdata->tx_tstamp_skb) {
+			/* Another timestamp in progress, ignore this one */
+			XGMAC_SET_BITS(packet->attributes,
+				       TX_PACKET_ATTRIBUTES, PTP, 0);
+		} else {
+			pdata->tx_tstamp_skb = skb_get(skb);
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+		}
+		spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
+	}
+
+	skb_tx_timestamp(skb);
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
index 978c4dd01fa0..3b8b4de8f91f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
@@ -20,7 +20,7 @@ static u64 xgbe_cc_read(const struct cyclecounter *cc)
 						   tstamp_cc);
 	u64 nsec;
 
-	nsec = pdata->hw_if.get_tstamp_time(pdata);
+	nsec = xgbe_get_tstamp_time(pdata);
 
 	return nsec;
 }
@@ -37,7 +37,7 @@ static int xgbe_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 
 	spin_lock_irqsave(&pdata->tstamp_lock, flags);
 
-	pdata->hw_if.update_tstamp_addend(pdata, addend);
+	xgbe_update_tstamp_addend(pdata, addend);
 
 	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 70169ea23c7f..2341c7d213a7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -741,14 +741,6 @@ struct xgbe_hw_if {
 	void (*tx_mmc_int)(struct xgbe_prv_data *);
 	void (*read_mmc_stats)(struct xgbe_prv_data *);
 
-	/* For Timestamp config */
-	int (*config_tstamp)(struct xgbe_prv_data *, unsigned int);
-	void (*update_tstamp_addend)(struct xgbe_prv_data *, unsigned int);
-	void (*set_tstamp_time)(struct xgbe_prv_data *, unsigned int sec,
-				unsigned int nsec);
-	u64 (*get_tstamp_time)(struct xgbe_prv_data *);
-	u64 (*get_tx_tstamp)(struct xgbe_prv_data *);
-
 	/* For Data Center Bridging config */
 	void (*config_tc)(struct xgbe_prv_data *);
 	void (*config_dcb_tc)(struct xgbe_prv_data *);
@@ -1277,6 +1269,28 @@ void xgbe_init_tx_coalesce(struct xgbe_prv_data *);
 void xgbe_restart_dev(struct xgbe_prv_data *pdata);
 void xgbe_full_restart_dev(struct xgbe_prv_data *pdata);
 
+/* For Timestamp config */
+int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr);
+u64 xgbe_get_tstamp_time(struct xgbe_prv_data *pdata);
+u64 xgbe_get_tx_tstamp(struct xgbe_prv_data *pdata);
+void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
+			struct xgbe_ring_desc *rdesc);
+void xgbe_get_rx_tstamp(struct xgbe_packet_data *packet,
+			struct xgbe_ring_desc *rdesc);
+void xgbe_update_tstamp_addend(struct xgbe_prv_data *pdata,
+			       unsigned int addend);
+void xgbe_set_tstamp_time(struct xgbe_prv_data *pdata, unsigned int sec,
+			  unsigned int nsec);
+int xgbe_config_tstamp(struct xgbe_prv_data *pdata, unsigned int mac_tscr);
+void xgbe_tx_tstamp(struct work_struct *work);
+int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata,
+			       struct ifreq *ifreq);
+int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata,
+			       struct ifreq *ifreq);
+void xgbe_prep_tx_tstamp(struct xgbe_prv_data *pdata,
+			 struct sk_buff *skb,
+			 struct xgbe_packet_data *packet);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


