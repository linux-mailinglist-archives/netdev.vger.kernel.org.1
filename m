Return-Path: <netdev+bounces-142642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CFD9BFD17
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66961C21E36
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38D190049;
	Thu,  7 Nov 2024 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oJAEQmyY"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37318FDA5;
	Thu,  7 Nov 2024 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951639; cv=fail; b=icNIWUPqm6iza0iPEpacAdgUaWozMRwSx+bfzRqL2xVS7q/kM1CAD+sKreZDOhieu/9qlGtqZfhDo88ACAqSsJ8GfePp58qWEuSrkK+5smjVDItYRRNzdbAc+lUo1Q61W9iCUWCS2KFJOkD+/3ZRh5eQ7mD9Xzrey7vglohufis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951639; c=relaxed/simple;
	bh=+LGRTaFdfhXebYqRbOeag0l9EBSOweGSeu9YfpQsGTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGdxh7QryPjRJWzZBIA5eRRa+6YA75pgebpbDRqPhSh8uXcSECfcCPLsqV8trnDEMTd47wxDEhMNvF1O9yQLW8ZZTfOR5PtXPWRbNp424nIG3b/ORg+gAyqL5SYczURHnLCbAVYacLaESJ/iJ3ZV85zXw+u9c3Gkk77JXy/JnHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oJAEQmyY; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaQOgT/EjNLMYVLNRQb4EWunJrZEL0+lrxHcMfMIqiPmtke5Un4elFD5dNQQFU+XgoPMK6KzlpezJuxNsRErD7cRgjxsP2mDg5MipjCwKaKhZ8nBomlrhxSe2q4EsGhxTDO5RRvN8a77yMjk7t7MNleWDeqNiuFt1h7Y4vQo8bEKsLK2ymz51GphqmUsJewlp0VOhStN8kiDDxDIcvZptANH3NSqV1DqWJi9fhibOSPOVo+f8OgdO5NT68U8RDDcyYkBie4Xo/BagiBqbJ18nXB1yuYlCKB8zgGNYvRq0lPhpvYahHphb82mBDqX+/GTNcHBFDxp7lLp+EOlKNiyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3PRZvZZGzrSO74VuNIuOP4pK9eNhX1g7rP3zvoMVYk=;
 b=P9NgYMEOYKC3s5cTQ4bLjQCtY94xOXi46rI7RAsXV8iQAuKrRZv5AEzLKnP+x8bCojt1cVioRjI2Zegkz2JY+fX+l9mQT0g7VRJbIpxCQlgQAyD9T1PJ6CHvNNuwM+MM0+n7xC1l2NZkGmYwxf8lpHBRBJaZzKJfIXXdFjJ0SO6UwhDHdKSFy/kmqIxnnvdhw/St9hgmvDGDwA1ffSRhEbza80bJb2GwY4wn8945pHT0GRG+Uxl5GY99QHy6YyfKgLFCKhaMRnSuKTWR90S6hh7PAtqS12k0P6nDH1e4n2JLiNSPtb5/aLlBIEJtj+02RQ8sRAHzrl/mp3SuAaEOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3PRZvZZGzrSO74VuNIuOP4pK9eNhX1g7rP3zvoMVYk=;
 b=oJAEQmyYc66CUyI74oRsJHzmE8sBHvL1lrNNPO3a+J9cz2NzanKAFRr1PInjpEwiz0BUaHz2B5TlGHbBVvC82XlBUuPz6jmFSXficmtSOXJDKmgP6n/fgQhOvSkVE1DfnfEMcsYghTLeBzaDbVs5VTTvpEL2GjpJmHHUagURBlpJEmcfsYJeVHihZ2NSv3RgIoR0ey5o3jhIhkCkE4i1KGbR6STDKiNjtSzqv8C0ZURaPg1ixtOY24jQh9oNjytmYXLvCm6Bju9a25f9/WrK4BzaAHsCy1oQ3LkB+gFip4NKa3PNnFh4ciCtcmaqA5RJYXC2IVSb6eGZ9XScVorwTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 03:53:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:53:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Thu,  7 Nov 2024 11:38:13 +0800
Message-Id: <20241107033817.1654163-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107033817.1654163-1-wei.fang@nxp.com>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: e8673ad5-633b-482d-c19f-08dcfedfcca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RwTWv4D5LUYLh1VOCaYqDsNes8bIinYrOJfnOh2n/T6DA4GszLEvaWw9vdum?=
 =?us-ascii?Q?ol5VqLm7hksxUSM7fgiV+6Ey0SaL9OA6QpV1oiG7bTUXR6Db9yQ5Tgc+FHC8?=
 =?us-ascii?Q?IOKUsuCZU4HMbnXoCXrJczj9pqiN1X+SpnrpaLaIca0X3j68+nt6RS4+OB8x?=
 =?us-ascii?Q?cHjuMcFs5bLeVcOflXXzDyh6zfUst6V2o1cQglXVudO8MPHn3F6zvZ25XZ6f?=
 =?us-ascii?Q?CcYzVsgB7zp2AnzoUuNiX2cGMGhSaQ6R0AnYwW8h4sxUumSXX9ioFGRGwoze?=
 =?us-ascii?Q?+NzSdT9XVRWz8DmpFVHZZhaQS13UXizbPY7HTolQcfDSuqR+M8qbe2RVvgN6?=
 =?us-ascii?Q?nvtL9zyivHQaBQnvf4aQNOHz3vSfdK3kFc96mAu+Gv01RnYK8HIq9y5hRPEh?=
 =?us-ascii?Q?Q0PgJ84iR+DUBrP3eJ6+GFFfnlkVYxzYYsSI9Bwwz9xJC3tCjeEpqXdKRYnw?=
 =?us-ascii?Q?h0eLYvv8bT8CglAdmc79phjfbuNGM1Km6VLLxc+FJLcF1uldthYtdSBDmsnN?=
 =?us-ascii?Q?XeZ3WPb4RheIaS8kAh2APmy+Dc/oTjjtTG6NUX6eHcbaEYtw473KVZ++htBB?=
 =?us-ascii?Q?pT594ot3HKluH/yEWb5pPNNAKMtmpn9mEmEUEEsnSJ3uc4HjooZek+HvkG/2?=
 =?us-ascii?Q?XxZHtjPl4kkeqxBnrEj07zs8XJI15JB/DSOYCHjoIOp4NPZP42LfWIzjC0pb?=
 =?us-ascii?Q?6BIomX/n6j6WE9cHKudR2kEyj/1I/L3iChKM2kVrm+jL1uOp5PS2QaZaxmsV?=
 =?us-ascii?Q?DJzmSusClO5CIWEwun/uE0OiiQQyhOQmXYHAsqWkpYuq4vZ6jbHpwsoKsXhL?=
 =?us-ascii?Q?n1OmdhbPAndGofU5s16xkrA8UWhnJtwKL4920w0ckTx6xO/G8upi1v+SBRHg?=
 =?us-ascii?Q?BfK1ItKjfY9mSPf7Q4XESUR8e2/rcOw65HYiv5QpdmOsCG4gea43mOurcadv?=
 =?us-ascii?Q?1oSPEQOp7xvMJZU2LfqPb70xtbOrzihf+AAg0wYkdwrsy/vSTj+BZ7F39GA5?=
 =?us-ascii?Q?Ymjq037mrBXRL0ZjQrAlal6GfnG8oH0DRHJ76c1L9udr3FtcDVCm4DpiZanX?=
 =?us-ascii?Q?ahsDj7Cav7ZVBzhxPaq1aO2p7QBnuVEMdn3X/moJuZf/XfuPFfiy63Ud1ivy?=
 =?us-ascii?Q?EsuZiDQDoFdeV7O15/shVym9UJriJcaZTVZ5M4ZC1950ybbZkETm8sZzmCDk?=
 =?us-ascii?Q?6lGYRNRqNcr70Ot5rGUQaV0weZ7/aD27P4JDZcigK+6ly3U54IJDM/gwxst5?=
 =?us-ascii?Q?HLUlwtNxBBK1OQamxSFGZJuzsZCfMbwWSI1MES8Kw8XcjlJrQlbAQvkKQeID?=
 =?us-ascii?Q?acJ0ouXA4PMU+9ZhXGXHhM3omsUy8IDhlmDKzTjvIv0iwhGiArWUN+dPqOUq?=
 =?us-ascii?Q?TNcsm9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pbJp69iQsO6+Hpb9r88q+uJQaWZM/zC53TCxG4ADWO+ttyhElYUPeP18KSqN?=
 =?us-ascii?Q?BeUUB6wt7L0a37iHRVPm1glakW7PymbJdXWrGJVIUzKoKMViKohwGsK6CdhY?=
 =?us-ascii?Q?mWLScEmcroHPgEg2LNfuzKcTfXXQTy/z3oA/lHiXviUp1M7XXXnXY3Tr2jT4?=
 =?us-ascii?Q?nt562fJ4c56p1bzi6Xa8+5rjXish7aWRCEZtcMlCzNXP09zoDr9e2QlWY7Er?=
 =?us-ascii?Q?JzQnjNnG91MJ9CEjEIG3q6dTAjzOg2yshP1x560OQ0EhqF7+WMZ+IOOCbT9+?=
 =?us-ascii?Q?c92A4zqsybujy2X2pTA5Ru49WltT3AyJlw30PiQhelRBBUF3edS3hDRjo1ZC?=
 =?us-ascii?Q?28HwuCmpN33C3Zjvp9cB93/tDr64Bd6+ea59GMjmkkBO2Pi2jcWrI17iDzV1?=
 =?us-ascii?Q?E7VsPEdaRMOvrL3CbyXKx0Dw20i4sysTnxUptTX4n5u0V5Le9H0ogf3CqKbk?=
 =?us-ascii?Q?M19P1b4wnCBPZCInStlw8McF8DvT4u1JveuYOZi/5SZmfkimbnD9geeMJQ5f?=
 =?us-ascii?Q?rVcWIFEcpRx6meQUFOE0Xt6hnydRD4WJJJmVw/ZMKAV7h4HkC04PZvYEVYoP?=
 =?us-ascii?Q?FWzQnBeaa8nH088Q+X2jike33/C3PXnrYV/3Q5Nu7TuqQD7Gn0+g297F59cj?=
 =?us-ascii?Q?muVHjBLSGhuBdvkuZCGCCk0evarIQ+TS0UPoaFHCDKopVUEsBTADshaItmtf?=
 =?us-ascii?Q?Lu8wyGMzC4ktt572lPVYE+/m3WJlpOQQNVZJdfA2U+Mwn0XWifhIutAKrPyY?=
 =?us-ascii?Q?GHlBKpPar76vmbZjfeDEIKK3SjYkOrx0ASRmbKEcVrfUH1jERe/CeR6oMd+Y?=
 =?us-ascii?Q?yoRSAXKY/wrbHGt4S3BBe8mDj6BmISvwA3PQzHIrfdZzM4/mtc/1BHA/UpIC?=
 =?us-ascii?Q?qeZLmY+VGBV2KVpWnqQXHBVy/mzNyjsK0f24bbhHpZJ1td15Yg6P4t4LIHmK?=
 =?us-ascii?Q?Fqw8Q2k1r45wNSgpzXapnAVYGTJzEOHuRX2S/0ipNeKv6uI5XsUbv218MmLo?=
 =?us-ascii?Q?J+UaYX2PqPCitCayi7hqOx46cgvKhEnM0c+9TTLHyu+o9L7GAEfqw2kVNKmr?=
 =?us-ascii?Q?Wr1E+CCBsg0NwYO3s1EBxhY0+8RVfRBtzmnST1RREtqwW9sfubKoz0zb71P4?=
 =?us-ascii?Q?wdR3XdN5LViNRy2TGiQWPJaBvyC29IIrf4QvsGqHJpRtHhi1KUfR8IZdlxS+?=
 =?us-ascii?Q?zju0eyPyKLmPLJWg8rhwGyN1oJo/kjvZVmo/QGteXitHbtQbLmFwWymcCv1m?=
 =?us-ascii?Q?eQfGZxD/ULBh6c4CEggzzrbq01GzQucpuwVSleEEhXWKME9QQNLt2K7FQeee?=
 =?us-ascii?Q?G6mEGaWI77hqJaad7LAaUZVggar5DMSnnb2w67nFWZkGkoboqjsgLrE+zjKb?=
 =?us-ascii?Q?cXQ2SSVY5ERBbHDAKnwBz51FFrdMOK6knIPxrqOiXQK/gDPU5Id8MndFGbh1?=
 =?us-ascii?Q?thYGKIwUeZnYyIWewaPlCTgx++LVEevlm6UQhIbF+RSH+OkBDSgTQfCMlva+?=
 =?us-ascii?Q?Bjv40RezCE6NJo3Wo+6uhC5H7QrfaA0mbEAJMI1gcobVAYu4Sc8eT4h/damB?=
 =?us-ascii?Q?y3OCyp+cNLmq9S5ZjC09sAivDnbDT1UcjS2BTb1k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8673ad5-633b-482d-c19f-08dcfedfcca9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:53:54.7569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+PqWauE6M4Dol90bNyaUOJiO+l63Loay6ameQQrxYUUKk7LNZ7vdM/UZikntyny6UpdeEJa3MNC4IxoZViwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


