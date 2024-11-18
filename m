Return-Path: <netdev+bounces-145741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07A9D098A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63E01F213E3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D221494AB;
	Mon, 18 Nov 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KG4apcNS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF11494A6;
	Mon, 18 Nov 2024 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910957; cv=fail; b=JwKWO8+k0mpe+F/qyHd/iYNIL9B+41GzCyQEzuul4v2G8dY04hHLf5i5dxN/LoSpPEvhV/wl4REkZCWgljuLVEiRMP30XTUUgQu4oR6fASdEznvcgmecSvk4so45v/OFg+jwIpLUGteqsGQRw1YXMxPu5a6I+XBOFN/SUbhVNYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910957; c=relaxed/simple;
	bh=Tnw+WjFVrI7oPyhkXEkN5viwsOowDzZhEX5d0qGpMsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJpDFYtHclmI6QAazPqdzLZCBByYbq0j2iI9/I/Xr0U+pwWCikRjFfDGUWsOowqfXGj6zs2Q4AgkEh/iOwuVbBpt7PeuX/WZfJv/ww2MMjvHQmEmvmBNECeferd5nMyFQhSaS/Yk+hHFX/zJS6ht0/zk2Nu8wNHlZ+ZaWZCocuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KG4apcNS; arc=fail smtp.client-ip=40.107.105.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSiV7IqcIiqOQysAAsUhywILDK6h5NungLFAaNhWm5tWplgDA46K0g7EChlnppImJegigNwWkwrF6+3miuo9eEQbJT8bZRRAalAGIeY/OtXf6zWK9D6f7Kn42felJR6HVJdEZgflyGZmMEPsxcdEwrxB8xvFVk9bKF/UySPu5FIcqBggqvGmsB7KDVO1CTru8arj3mDVzu+/IyUBhW6x58UKsmeobh3wSDzPv4Cegwt+1lTmaPNPNJ9MIMWR5ruqIBzs5yW7upAhnB2T6EYfyyL4XGFunz377SWX9doqEu7eimb98aWAAsqd/TIEhsTz5I5akB2iIUIImK32g6ia4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0upDHC3PtDWwb5PDww/DP3Oerjbden0UIXoPjrYBdY=;
 b=a09YHjy+qQzSMEjmcVjG6aqfnmziH7BcoFizLHvY2DbhfbDElkG2FGLpfIWSCH2mTZiLVv3O/YSQnQnUhP/7UePwv6vb7YhrZwA3Oz6Joe3TR8mFT1fVM29LxI0reWlES2zq2uSDHLAV2KmwMxunU3Vskn1ODeKPfY0uiyLnXCvLs7kH49+WznUxkY8M8K0KdoztHM9OB6yihyR7q21kC4K/dEGNf6mBhED6vVVPl1QnB7x4JZUx55L+lGJ5aUwIqHMhBVnc8M7Ur/yUDx3u8+eGvFjkPkq38M0XhrFVeujm3LlmnGBDoq8WXX4G10UZW1plxXH1xyCcXyyiU4eDvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0upDHC3PtDWwb5PDww/DP3Oerjbden0UIXoPjrYBdY=;
 b=KG4apcNSm03rFF1C2WL1utQe+op/LF3olzZQBQZCFRKtUkdsnrrHn3Bhc9yvJnUxD/G4Mvof/2HEDsBdz1HxGCW+PqfuoUC85ASrkcIBaggUvZjpeQNuLumI3hl0Em8UPVFXS0qcvGV9y/cwLUFwsrcxes5S4dXcaZfXSd7N9lnHa6Oh2o1epO4TzeY5aBKlRxF56B1qxcdOunEZ7lRjDgpoIZ9RIUlWq9exs8MJYMwdI2g3OjMKSpvgaLXfs7Bt39w7zGsxlUhhaB9z/5zf6aCdY2a0Lgld4skCnWQtQRrnAclaXmeRlJTsZVGlcXGLSRtJ6itl0v+yadJRgweXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 4/5] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Mon, 18 Nov 2024 14:06:29 +0800
Message-Id: <20241118060630.1956134-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118060630.1956134-1-wei.fang@nxp.com>
References: <20241118060630.1956134-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cdd731-7c6a-416b-7e45-08dd0799615f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nj5yQKFsVc1FM85rzc1IXrLI/DYbcHM8Cvzq5gU10xSpUToDx0kMx5ORcSxk?=
 =?us-ascii?Q?9m9KAYK6+KpGkjxcKPvq6UzNqfVAxzTicwvG6YQ4pGOwX4yGg6bisKWgt/S5?=
 =?us-ascii?Q?1Y3oYL1sLIOiTq9B/uGkXW3JI1StVHpKRcgGQO/G7WDNxZLOpVvdZR/tCWhf?=
 =?us-ascii?Q?wP7sTxXOCOcpaRZQl2x1coIqKJ3+XLwJZe5T9WGmaFKjSVKTU1ltJL5r4uVh?=
 =?us-ascii?Q?WhZHc8I6Nd+uY/O/EbJiii9fkUcte/EuprtrZY85bYs2HYStRlSewVz68r/k?=
 =?us-ascii?Q?ByoYv0iyJKZq2B1QPPvW2Yka1iH5RII/wNyA744MPShLCS52ZfbPUleNrKIH?=
 =?us-ascii?Q?OA8lxQVFEMLXKaaEbh8IMVWeMvAcULZLJPYaQuyeas8iU2k8sUcyto8paQpe?=
 =?us-ascii?Q?q7cwM2mJuckpuqC5Knr48Fq2m+Fdp/n4Pd8imOJHk0S/HWnSzTYCPcX8b6e9?=
 =?us-ascii?Q?eQeLRRR/5SOnPvJdkRRDXmldEzWedZA6gVof9adx6K2OGQBc4wzaVkFcfOJx?=
 =?us-ascii?Q?9GuFSWGqPeudarKwmOr1p4d7rlh22Lsv5IQEny3yP5AyOl0bIxzIg5CXWCwS?=
 =?us-ascii?Q?sThdel+SqibyLGUkpkqh3h23lBhmgIxLBAMwUvlGs5cNIKTrLKP8mkTS/8L8?=
 =?us-ascii?Q?7aacMQNB0T8/KA0kjjXYuAd0MC6UdWLnwH36cYFIxqFr/gO+YxrJqzfDetPy?=
 =?us-ascii?Q?TBsl/46ZXEIg4xViJkD56MfoSi3fXptNhxsca+JuY3lhY9MRobBZbaLoJ5PM?=
 =?us-ascii?Q?0KBxXLGwAF3/izN8e6bvIo81eCM4ue6pJ3RZcfpOOBEfywMIz52w+2PHXEtN?=
 =?us-ascii?Q?LAi454EXG1O+PML8PrmjgBr1KNfkCCbjZR0SU84sZvQVPmEnda+Fz/jV1qFX?=
 =?us-ascii?Q?yD0zp3uzi5L4gqu2WMGkW4dhzKl1y9kSYoFh9Nn6+TjZL3VpbMf9dUgtdXNR?=
 =?us-ascii?Q?jKrnRlVaDKX64s/XHhfm2gJ4mrCJgaQdBznQ9fNSG3fZ9bvmUNkyPUuHxkwL?=
 =?us-ascii?Q?m0mV4yQ2u1CDAR7+RnTcFAYY/782v7AAXA37ewoOnVG+Wm9dVBlwiDnQp5Pp?=
 =?us-ascii?Q?ydkAjpF9FQ7kQ6ERAquhPbl8NQ/GOQOBTEskmYSiS9xBFxixTfIdZp2oddRv?=
 =?us-ascii?Q?VfPwfTtdrYrMah1QnxC/fKxkLGmrXEJW3i2OMQI0qxNYvc8sRhJspzyH4jaG?=
 =?us-ascii?Q?VgznJjrI1Ef+1V9DPVwWCUIQbdWxWWP1jwZ6TBmOdm6CpcwMOKm9RCCG0LQB?=
 =?us-ascii?Q?ULOF0qwvnmgwOILdZ/FV0YI8Mi4Am917iH7IszsWFxus+4bu4gjp03qzUUfs?=
 =?us-ascii?Q?c8EpAp/KqZGn9DE4C2F9VJg/GMqYMnayjnjOeUAFuFZ5IQAosTN8dGBy307h?=
 =?us-ascii?Q?x3l5hVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Bj94PTWwzkQrcWkLtEyz7RCwJX9nfg6L/bcHnGuKWIzFN69QoZGFU6XJmkz?=
 =?us-ascii?Q?Y4lPnh9zhikmgytkk6u9NlnnQ4wV0Efws/Aq2aFxV7Xs5mcA1TvG1G4H1WFq?=
 =?us-ascii?Q?VrOGRRSDQiVCc9QtkORHqKqEWOPEgeKFjElg3JqvtfG6zuJiLUvslajS7HCD?=
 =?us-ascii?Q?iSqqDr/JIHE7hfPwdAqRcA6UpWtXk4oGRnyZdy8OSYQrmcRyp7QatXoXkAvY?=
 =?us-ascii?Q?lYZN8EAtGI9m5bPu+TX8VtK7mjCm8QVha4Jf1gl2Pv8RgzljTD1G8DhncZ0g?=
 =?us-ascii?Q?HhLOwJ4NlSz5jpRfEGS1gUVm+uEcfunNiU5aqQuNQSLVvVH9Dy8FS5+UBPkQ?=
 =?us-ascii?Q?z1gU8u4KFI0DTqyArDroSN5laa3ablHKY3/+y0LCgsrzcD28RtDd6E81/wbD?=
 =?us-ascii?Q?S4FlisQxU2iOV9gw5AF6UUNs1OtIjaDYgNBxNw7VIyez23FQCyrWgm2WA+CQ?=
 =?us-ascii?Q?KEJrNX68aLHXalQ9vCyGmuyapCGpHgFTObU+VRekEZF0wbF+lLeoieRvFADI?=
 =?us-ascii?Q?/cXoOMkf72DNbFnJGNo8qXCQMW35s2FDKr1q5eQVcgExG7FpBcJiFtENLmSp?=
 =?us-ascii?Q?WVKCLlwGNhZlIgvK+qZSixzu3ubvs7NkSkqKXHrNTY5s/C+7Q11KBkqc07WY?=
 =?us-ascii?Q?nnddpjSk6Yd8e3A++WAytnSgguWa6tAcMyDQPN9x5NUOs1PbWHxZ7ts1ISls?=
 =?us-ascii?Q?b5YBFSllV6EmRp5ipvPJ68iuzr/B/I3RmZaTelJrhn7xFuAA2n0VDrNczf5+?=
 =?us-ascii?Q?zIVGXPTG4RncCDm8fhY+V93zlsOsSA4ElFqSkrr5QOWR8Fmlw/2vswiLeqwi?=
 =?us-ascii?Q?V/GmZCVT5UbmGWyvUE57+xIwC2vw/zu1TWJ9nrmWRZdqV+HGtCjuVT7forVy?=
 =?us-ascii?Q?ADztH6lqydTNHUyvF51Oq9t9iaW16DejE8OTC4XzIimodLpFBZXDraOtfc7Z?=
 =?us-ascii?Q?JqtAAihF0mz3vb5YzgoUquVhH2J2Wc0hQu3E5coD+YLvnU5R9NZ3maE9GOIH?=
 =?us-ascii?Q?kjMwOxBH3V85OoPoEKss37n9zjEgM2J0rs9TuW6SOK3BpROVrexA8662YmPf?=
 =?us-ascii?Q?VY+Wv6QzYbmD5E6BaGJhxhsRJVE51WpzerTW74DRBtnwKFJ8ZU7sLgvpmlY5?=
 =?us-ascii?Q?rRvYvDUf8s7MWpu8KfAIVzRpy3BQqJ76ZVFR/UZQ3ZkPVyWpF8zV+HjNymqp?=
 =?us-ascii?Q?4QtebVpgx2qHGFuT2+IvTjZOQenbnj5FqXFGF8O4NbAHRfRgAmJ5aQq3mE7j?=
 =?us-ascii?Q?f2b/nMHDU8hbxKfsQ8cCyHrTvyOYdT4qMp6XboQC3np2CtheCfv+FAuL/nSU?=
 =?us-ascii?Q?XV59kOreEaTyymbEaTY5lFzabJFdsTnHWiRVoaVProGpYctHTQpC//eBOGvv?=
 =?us-ascii?Q?le1mLBPprMMUVT16lskrfItzaRCpjvTnyiIrb8isT+TS4JWEEdGvFG+wQZBs?=
 =?us-ascii?Q?pg1X8UxGAu2hj8OEtYJxlDAtodt+pD5NHlnUJMTHY4RmfboIS76anqUGrhiQ?=
 =?us-ascii?Q?sgAC0tSqjEYnmSJ8OPcTU6hsufKRf3KlHZLEdvNvfPvdbTCpNCBu9uicz7MH?=
 =?us-ascii?Q?0y2wzSeiwOc+TWmLWhWQNwc8URVjny6F/8uTdA4N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdd731-7c6a-416b-7e45-08dd0799615f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:30.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFzkHkbOnM+uXKzeAPt8mb7GOslPiYoqGc0qUZUyDv4j17ktM9q4t9oDWNwPnPsHaSjLkW9eT72p5Paj/PmYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 311 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index dafe7aeac26b..1d5c63ceaad8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -523,6 +523,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	if (lso->tcp)
+		txbd_tmp.l4t = ENETC_TXBD_L4T_TCP;
+	else
+		txbd_tmp.l4t = ENETC_TXBD_L4T_UDP;
+
+	if (lso->ipv6)
+		txbd_tmp.l3t = 1;
+	else
+		txbd_tmp.ipcs = 1;
+
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_hdr_size = lso->l3_hdr_len / 4;
+	txbd_tmp.l3_start = lso->l3_start;
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
+			netdev_err(tx_ring->ndev, "DMA map error\n");
+			goto dma_err;
+		}
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma))) {
+			netdev_err(tx_ring->ndev, "DMA map error\n");
+			goto dma_err;
+		}
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+
+dma_err:
+	return -ENOMEM;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -643,14 +870,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1796,6 +2035,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2100,6 +2342,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2113,6 +2362,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a78af4f624e0..0a69f72fe8ec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -353,6 +367,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
 	ENETC_F_TXCSUM			= BIT(13),
+	ENETC_F_LSO			= BIT(14),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 590b1412fadf..34a3e8f1496e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -28,6 +28,8 @@
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
+#define ENETC_SIPCAPR0_RSC	BIT(0)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -574,13 +579,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -589,6 +597,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 2c4c6af672e7..82a67356abe4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -126,6 +126,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


