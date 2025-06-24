Return-Path: <netdev+bounces-200571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D9AE61E3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B079400E78
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E32868A7;
	Tue, 24 Jun 2025 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NC97q17n"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972D2857CD;
	Tue, 24 Jun 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760022; cv=fail; b=rttZJLYW1AVSybZTPRmRtCtAy2PHdIudkqAyXRG9tiY0N519EXXxsmCtBnKVIxKYpjntYvuZ7mzT+ayJIr/vPcTIL6Yt21v4Jt5t8vBG2WO4bdTqw5t2od9pq7lz/Kot58ryrV5oJ5qInHAvbqf7S7RNeXiPh63cbctDZNg2hDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760022; c=relaxed/simple;
	bh=lhG840XTLg3bH5glJXZT4Q6vDuwpdyybshaAF3T3/X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERNQT+aLMj0XLoDLhCYfxXwVU0WMltVLrdPXXlH2HmtdaoUu9UluMDzkp+aIC7uaGffPuyhc+ub245V01jG/fSbkgdUrhZ34eC3NES2D8fDYzQ45ubSy1+2+sWLCdhTrrOgSnyLBlU5pQbnkcfb//dJbhx1i3b4UzHi5jioirZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NC97q17n; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7tHb3gtXPjNIGVTqjvUg7fhTr/ZStsfLsykuEgqoserimreVXPMkFGRFp5CAoODmE2tLKth8eCGo0QaeMaHtiBHwSH9ggPZmcyKgPYbnkRC53AeL3Cf1zZb3jqlmEUvHT7Sc08WUeviYiIzLrVOoKU+mUsjljzz/uwuvMzO1YwQ56DdTcv3f8KoudZe5e7iDde1oa0AhQ+8Pd4DtaZsFJao9lPbil7dnLK4wLrDIi+nZhXUKxjqNxPUn8BYATjmubUEwiMcRhALrZH+9XXccjB4NZJZw1G78vul0NESwswTttzYXwIDDZVqJuRu5BER+Xz04c6nui32gjgn2RG9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DTYQh1ncCfnc017OA3Z0teH6kVaN9UTNfKj5ox55VQ=;
 b=HWAQfAN0KU60t5nrDiBqYzfdm7XgpA8VCW6fkLSQStf4HWSkwRstGqOhAx+ki1eKNL6Qspd9ee44v7Kr00zuwKXQHdmYRS7JC4gVQT0L4FCWswoeJnK/SoO5Dr2BLg2xy0jv0xy87hFjFBrUE6Svj5cxwnhHIXl73zUVSlocprrRrqrxvgg+M9UG+ksulwjrzM2+RKSOGlUsIF40M3gCliG+xyA1PAny+lWkkGEnUtcINljWhaLfLIPiNiOruMLDCd46t3ns4e6JOQwytbQjcA/Xhbwwgk3K1QhRxie93JZtRuIKgHUn/2z3B9ZyKZnQ9CeAOnlv3h6e/lChYwTfrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DTYQh1ncCfnc017OA3Z0teH6kVaN9UTNfKj5ox55VQ=;
 b=NC97q17nWr0zBmxYs/rkbFiGzuQGYxFfT2l/QjhmKHOqdeO2VNzMMap8Uz5gpgs8j3o64QavJRH+hViAvwhZZgelc9uIR7tH8dBTBVkzMxwAoZNYBjCd6nO7CAUmlb1j9g+L2k2SRJo1oc6ad79/MC36w5TZbEfQhsexLO9iGy/he/muCS8/vh1kBbvd5MzTRXdKpLSRqc/rCGsFolxa16nzuMRtilulmZTje1JVCGyPm3XCbVPHM07/TXEoXeoVgKS6J9ic4E4e3nYbUHTIulYRNqf4SwtD8DztzRt3AjMT6yc9QQOSCti/qbmunWwkyN1LeLbMIjR5TELCnZCH3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8636.eurprd04.prod.outlook.com (2603:10a6:20b:43f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 10:13:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 10:13:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 3/3] net: enetc: read 64-bit statistics from port MAC counters
Date: Tue, 24 Jun 2025 18:15:48 +0800
Message-Id: <20250624101548.2669522-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624101548.2669522-1-wei.fang@nxp.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 806b6c76-003e-46cc-1b23-08ddb307c99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aq01U84XY94/MP/kA/YxZ3jaZRjl5u3Is7fu7euWdFQGC2G9FnKjSntJ70ZA?=
 =?us-ascii?Q?3Z9e/4wUPbfTMVN0JrT1iLUsqB3oy9FFy2VXQzB0gycTHV8VC62EOsJ39hHK?=
 =?us-ascii?Q?cT2DVyWfev/ERlrhrRZ4Mtij6BcxjK6HvLEBX072KODToere8A2O9OAR0Squ?=
 =?us-ascii?Q?VfWimXelJGWR40zb46Ms/8GmA83ynQUHC+o1IVUIf4zQX3bGf7x14oTHnLi9?=
 =?us-ascii?Q?8TGK76XeIckFXT7Gg+5zOkmLNyLGiXhhLdPQzfOs8+3+C7HRcFGkNAaUfwos?=
 =?us-ascii?Q?3CKG4J6DhF6TW3T6btlAn7BdiTVLkaL8eyVNZWbLDnPqcTLLDxWTLLHqdB0D?=
 =?us-ascii?Q?PhMtwGWbEihGfok2UMV6ludciWonb9sllQ8Wwf5BrC/LoIba2Yp8uQeLCAln?=
 =?us-ascii?Q?ni6GoIXnqRTnq6U2k8UrHfmXPc8j3AT8Jw8Eku8eZcizI0IrbALF0WcMZ3BT?=
 =?us-ascii?Q?IBxlW1UoYz9abwjicQIsVunYKxEZnC3y+z7ded77aN9ubbvlJM26t81/mEY1?=
 =?us-ascii?Q?ZJet2rcrDrw+sB0L24UzWAu4Ubt/OXmithN6dOSGgP5xsd8kkxoSk5BWTRHx?=
 =?us-ascii?Q?BQwPT/P2MFa1r/51TRZ/YaQTlFZ4WsKs7isICxCHo7KWypyp+juoKWjvsaEQ?=
 =?us-ascii?Q?nVRE+Zwv5jNudNbABIYRV8sJxkVG3TTPuK+R4f94yh/jduoysaxV97cmsP7C?=
 =?us-ascii?Q?0VHTU0/utf1n/OPJRI0BMuVyVR7SaaixVpOOHqy5sw3V8neWp7+C6HQ2dmyW?=
 =?us-ascii?Q?l7Qul0/a/k0IIf25qZoTFHNQz/Yhw8oSo7C1lJ11mghfYPHC2QIQfDk5jg/K?=
 =?us-ascii?Q?5iXPd/B634IkK+jc8rEOKTHqwt4EVjniG4t1MXuMJpXBQ4YtYCbH3cj4Arqt?=
 =?us-ascii?Q?cIUQ7OnbfCxa3SK/WB2K5xIEAvGj9Otp5epfnqQzkxep1GzOHMeXlobY4fAJ?=
 =?us-ascii?Q?OzehTfbtMZzJ3JPUz91Mb0slmzeMTFmtmt/0f5zFnqmzCL6rkBLTnYWdFZTD?=
 =?us-ascii?Q?S+SLRoq5Eq287jtBD0oDYxqVCkZ1NJL7G+VllG4DyDBSsX/7Apn8dotccuYy?=
 =?us-ascii?Q?r1bt7/BW9QP/FW2cUw2UQaUoW6KyrIIIs7yOwsXf6xoPFLjXWlGE5qYFrnIN?=
 =?us-ascii?Q?rMbvrGImPRPom/hBTkGzZMYXxD5Kn9+5r10GXR4DmseBFOZE6P6/+vgDefAL?=
 =?us-ascii?Q?6RHSc4mAJweHwJvSxe2UQGhBdnJBB7orTG/FdLWrBTEe9KooNab27fymkh9D?=
 =?us-ascii?Q?LrvJICqH0deDC7cQE+0EZrwZqoIPsutO1TdXq1UtmVNvMptXOGmPimFDb9uz?=
 =?us-ascii?Q?t/R8yyBDw7jexcJYO/mhWHpqFqXG1cjrjzdFjJ78fhT/+unQTxYHXgi9TUr7?=
 =?us-ascii?Q?S+DsaJji7wWTD2UH0Eyv9HBLXw/A3HdgDTKeuIBTerjLulYAWBfyU2AXfyOP?=
 =?us-ascii?Q?WimP1eMkEPjz+eitV/8c3lvm/c51xZRgE0d0P1pwg/XjUQhNiGwjbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygoenaNQGq4DiyO1K/bATPbA9gGnrSNSPGn66J3s9BwVbeByJBk2mJ7GD90h?=
 =?us-ascii?Q?3+gvSBoIu4W7zGzBMNskga5n5A+kvA4oDDTyFhgIQUfsQAM1f9G7Iol5lcmn?=
 =?us-ascii?Q?EO1V8WrpNPEzOYs5pqMncuqVcn/+Cv3ppGPNISjpi1J8O63/ijs5J+5NLGA8?=
 =?us-ascii?Q?5TMPaKz4CM5W82TNzvSOEf45LEVWPoD44tvAgXAsenXUnsNxowFICaaOI9a5?=
 =?us-ascii?Q?AWiP7yJ8SNH3vyPkh5EB6WDuiF9eVIzRSt+V04jhHWu18ypI4rAcnlTqA13J?=
 =?us-ascii?Q?YKKAQED6/a9D16sPBwDxRWL4QBg3UwNhLZ0C2YoSa03vS1z6ifzLhb0lO9o7?=
 =?us-ascii?Q?35Q9kx3CA0jM4mqUHvpXoEXqms8Y5op26QPSMIcXYs2ztVG4lcNzNb9DSfZg?=
 =?us-ascii?Q?fKKJGKZbP5vmeqhJp5ZRCHrjvfrbUc3JiHnXxerDKgAJF+Gj/sYVm0mUpEi3?=
 =?us-ascii?Q?OjBpkCT0aUmS4sJjXgf5vgld/xtiOV+pkptCbH26O4vgqUQSM5A0BE3S8x05?=
 =?us-ascii?Q?mrOHF2QHpxSEOCbHVpL+wy2BPZYozQYcqo6VkzGd08rpOGU9yko4/igW4zzB?=
 =?us-ascii?Q?naCjl9mkSQ2uD8PG7o111xuV5prd0QpROZtuclA4f5M60zGK14saICtGAMs1?=
 =?us-ascii?Q?RFuTHFaJPN+R9Tp5ofYggRT4B/e8jCaueOeWwruFZMkkXaDDYjBBW+ufJ0/r?=
 =?us-ascii?Q?nYq0dbRitogjZwUzYXLsNSw4EDp8FJL05bVfhntAW9xM0gioS0yE4gFhky7z?=
 =?us-ascii?Q?z3a87phy1EDg49QVG3Sry2CBtmPVmH+O5cPNDO6oTgOikG1Nt2BVN809eMhO?=
 =?us-ascii?Q?rlld+6i19/CA3rJthvEdHIiva3OYn88+wPswC4olCtSEitGzWXRlHqHnFnzY?=
 =?us-ascii?Q?46/95Cjar+N0byjGugdo6+ZMpA/PbMmhN1nuxgu+UTYqR1olmbMfdyr6qKGP?=
 =?us-ascii?Q?eJYB/k/kuGHlunUSA6kOW1I43feTm9Z2/6ak8wmWH5C5b9p37j7ca9xhDFBK?=
 =?us-ascii?Q?2hTSlj1K0itwsIGOrQrmnuAMrvejN2yDikpvkC/ThRvq2A7TXLov96dtDw6b?=
 =?us-ascii?Q?/TYoJT/vakGEXARGOC/a6RK+feQ4gFY1KEckm2u/PT6AQYe04mT4ySZXRfWr?=
 =?us-ascii?Q?IzitcVqAPtbE2TzM5I7fUB9SLyRMhi7qzbiwcAvwkHZeip06B708rBZquyo2?=
 =?us-ascii?Q?xa4M2pRmFzRNPQhO244sMX/yL7rmBwAjsM/wHehq98o+EdkB6/Q8KJY42OaI?=
 =?us-ascii?Q?HwHva9Yx4Mz8EPsIwr1HP+HZnbtdPpQTzvlDZuFDAUXgQjrvifWvNsEUJh9w?=
 =?us-ascii?Q?0JNlDMO7A93iHLpUZX8SJQYNkH08/h0z2gYPPqUtALM3k0No19pqmfoAHmoV?=
 =?us-ascii?Q?P/KLkTTunM0uTRMHu4TJLFFMygP9iY57z0f9RLkd8nbmYaK8uqVFN/rb/3eg?=
 =?us-ascii?Q?SxpiePx2kW/0hk64Lmmc612DPBGORjwLMejZe1r8vnVW7pLuKyWPypnvnuKd?=
 =?us-ascii?Q?8/7aEqfiauJSXyVOuS1ZtKc/MgYF2O2SqJup9V38u3IA5ac/qiusLIg8gtD0?=
 =?us-ascii?Q?DLXbK2Z4wcyvgCifHCtaHDY4qRvMirTmJAhAVAl0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806b6c76-003e-46cc-1b23-08ddb307c99a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:13:38.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGb+BWugu7DQTMbJkISPLU+sBOi7qtcuMUl7Riy3NSWzFaSXDUNg7HAzNvh4pZyTWdP5U8WUJ/FB8TAxGngXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8636

The counters of port MAC are all 64-bit registers, and the statistics of
ethtool are u64 type, so replace enetc_port_rd() with enetc_port_rd64()
to read 64-bit statistics.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 84 +++++++++----------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2c9aa94c8e3d..961e76cd8489 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -320,8 +320,8 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 static void enetc_pause_stats(struct enetc_hw *hw, int mac,
 			      struct ethtool_pause_stats *pause_stats)
 {
-	pause_stats->tx_pause_frames = enetc_port_rd(hw, ENETC_PM_TXPF(mac));
-	pause_stats->rx_pause_frames = enetc_port_rd(hw, ENETC_PM_RXPF(mac));
+	pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
+	pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
 }
 
 static void enetc_get_pause_stats(struct net_device *ndev,
@@ -348,31 +348,31 @@ static void enetc_get_pause_stats(struct net_device *ndev,
 static void enetc_mac_stats(struct enetc_hw *hw, int mac,
 			    struct ethtool_eth_mac_stats *s)
 {
-	s->FramesTransmittedOK = enetc_port_rd(hw, ENETC_PM_TFRM(mac));
-	s->SingleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TSCOL(mac));
-	s->MultipleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TMCOL(mac));
-	s->FramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RFRM(mac));
-	s->FrameCheckSequenceErrors = enetc_port_rd(hw, ENETC_PM_RFCS(mac));
-	s->AlignmentErrors = enetc_port_rd(hw, ENETC_PM_RALN(mac));
-	s->OctetsTransmittedOK = enetc_port_rd(hw, ENETC_PM_TEOCT(mac));
-	s->FramesWithDeferredXmissions = enetc_port_rd(hw, ENETC_PM_TDFR(mac));
-	s->LateCollisions = enetc_port_rd(hw, ENETC_PM_TLCOL(mac));
-	s->FramesAbortedDueToXSColls = enetc_port_rd(hw, ENETC_PM_TECOL(mac));
-	s->FramesLostDueToIntMACXmitError = enetc_port_rd(hw, ENETC_PM_TERR(mac));
-	s->CarrierSenseErrors = enetc_port_rd(hw, ENETC_PM_TCRSE(mac));
-	s->OctetsReceivedOK = enetc_port_rd(hw, ENETC_PM_REOCT(mac));
-	s->FramesLostDueToIntMACRcvError = enetc_port_rd(hw, ENETC_PM_RDRNTP(mac));
-	s->MulticastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TMCA(mac));
-	s->BroadcastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TBCA(mac));
-	s->MulticastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RMCA(mac));
-	s->BroadcastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RBCA(mac));
+	s->FramesTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TFRM(mac));
+	s->SingleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TSCOL(mac));
+	s->MultipleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TMCOL(mac));
+	s->FramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RFRM(mac));
+	s->FrameCheckSequenceErrors = enetc_port_rd64(hw, ENETC_PM_RFCS(mac));
+	s->AlignmentErrors = enetc_port_rd64(hw, ENETC_PM_RALN(mac));
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TEOCT(mac));
+	s->FramesWithDeferredXmissions = enetc_port_rd64(hw, ENETC_PM_TDFR(mac));
+	s->LateCollisions = enetc_port_rd64(hw, ENETC_PM_TLCOL(mac));
+	s->FramesAbortedDueToXSColls = enetc_port_rd64(hw, ENETC_PM_TECOL(mac));
+	s->FramesLostDueToIntMACXmitError = enetc_port_rd64(hw, ENETC_PM_TERR(mac));
+	s->CarrierSenseErrors = enetc_port_rd64(hw, ENETC_PM_TCRSE(mac));
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC_PM_REOCT(mac));
+	s->FramesLostDueToIntMACRcvError = enetc_port_rd64(hw, ENETC_PM_RDRNTP(mac));
+	s->MulticastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TMCA(mac));
+	s->BroadcastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TBCA(mac));
+	s->MulticastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RMCA(mac));
+	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RBCA(mac));
 }
 
 static void enetc_ctrl_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_eth_ctrl_stats *s)
 {
-	s->MACControlFramesTransmitted = enetc_port_rd(hw, ENETC_PM_TCNP(mac));
-	s->MACControlFramesReceived = enetc_port_rd(hw, ENETC_PM_RCNP(mac));
+	s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
+	s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
 }
 
 static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
@@ -389,26 +389,26 @@ static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
 static void enetc_rmon_stats(struct enetc_hw *hw, int mac,
 			     struct ethtool_rmon_stats *s)
 {
-	s->undersize_pkts = enetc_port_rd(hw, ENETC_PM_RUND(mac));
-	s->oversize_pkts = enetc_port_rd(hw, ENETC_PM_ROVR(mac));
-	s->fragments = enetc_port_rd(hw, ENETC_PM_RFRG(mac));
-	s->jabbers = enetc_port_rd(hw, ENETC_PM_RJBR(mac));
-
-	s->hist[0] = enetc_port_rd(hw, ENETC_PM_R64(mac));
-	s->hist[1] = enetc_port_rd(hw, ENETC_PM_R127(mac));
-	s->hist[2] = enetc_port_rd(hw, ENETC_PM_R255(mac));
-	s->hist[3] = enetc_port_rd(hw, ENETC_PM_R511(mac));
-	s->hist[4] = enetc_port_rd(hw, ENETC_PM_R1023(mac));
-	s->hist[5] = enetc_port_rd(hw, ENETC_PM_R1522(mac));
-	s->hist[6] = enetc_port_rd(hw, ENETC_PM_R1523X(mac));
-
-	s->hist_tx[0] = enetc_port_rd(hw, ENETC_PM_T64(mac));
-	s->hist_tx[1] = enetc_port_rd(hw, ENETC_PM_T127(mac));
-	s->hist_tx[2] = enetc_port_rd(hw, ENETC_PM_T255(mac));
-	s->hist_tx[3] = enetc_port_rd(hw, ENETC_PM_T511(mac));
-	s->hist_tx[4] = enetc_port_rd(hw, ENETC_PM_T1023(mac));
-	s->hist_tx[5] = enetc_port_rd(hw, ENETC_PM_T1522(mac));
-	s->hist_tx[6] = enetc_port_rd(hw, ENETC_PM_T1523X(mac));
+	s->undersize_pkts = enetc_port_rd64(hw, ENETC_PM_RUND(mac));
+	s->oversize_pkts = enetc_port_rd64(hw, ENETC_PM_ROVR(mac));
+	s->fragments = enetc_port_rd64(hw, ENETC_PM_RFRG(mac));
+	s->jabbers = enetc_port_rd64(hw, ENETC_PM_RJBR(mac));
+
+	s->hist[0] = enetc_port_rd64(hw, ENETC_PM_R64(mac));
+	s->hist[1] = enetc_port_rd64(hw, ENETC_PM_R127(mac));
+	s->hist[2] = enetc_port_rd64(hw, ENETC_PM_R255(mac));
+	s->hist[3] = enetc_port_rd64(hw, ENETC_PM_R511(mac));
+	s->hist[4] = enetc_port_rd64(hw, ENETC_PM_R1023(mac));
+	s->hist[5] = enetc_port_rd64(hw, ENETC_PM_R1522(mac));
+	s->hist[6] = enetc_port_rd64(hw, ENETC_PM_R1523X(mac));
+
+	s->hist_tx[0] = enetc_port_rd64(hw, ENETC_PM_T64(mac));
+	s->hist_tx[1] = enetc_port_rd64(hw, ENETC_PM_T127(mac));
+	s->hist_tx[2] = enetc_port_rd64(hw, ENETC_PM_T255(mac));
+	s->hist_tx[3] = enetc_port_rd64(hw, ENETC_PM_T511(mac));
+	s->hist_tx[4] = enetc_port_rd64(hw, ENETC_PM_T1023(mac));
+	s->hist_tx[5] = enetc_port_rd64(hw, ENETC_PM_T1522(mac));
+	s->hist_tx[6] = enetc_port_rd64(hw, ENETC_PM_T1523X(mac));
 }
 
 static void enetc_get_eth_mac_stats(struct net_device *ndev,
-- 
2.34.1


