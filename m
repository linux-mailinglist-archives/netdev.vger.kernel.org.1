Return-Path: <netdev+bounces-145740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80FE9D0988
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7927B281DFD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796015381A;
	Mon, 18 Nov 2024 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ffpP+lHb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062F31474BC;
	Mon, 18 Nov 2024 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910950; cv=fail; b=Wg4DtLmuOdBvxkSSH3k5zJGalmRZpK1LJ2Gr0OPUMT1xXGt2yHNgA5O9bz1740pzvR56yNxHmCH4pcUOAW6wZxJC2woT/ccHpD61oK4RjF60+cfc2tPpGLrSDYss2XgR/IOCgTVa/PDen7m4a4X9XYKG6WIGNfHdoRK4Fcinkp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910950; c=relaxed/simple;
	bh=0qS9EczlzVw7aBsCTfr4v8RQU5H8KeNqOfnwAsp/AGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YCcdCYfGUDlgxaJ+AFAUX6VgcjzJEVLn3+kuCCfQqTH9oIAyUgsBbOYXANLNCyMuEu2TvxeLSzuP1iq7S0xTyGlVMKs6J1vNfuhyWHkB75S7D+7Z+GQVMBwlg2O1m7c4kPYz05pBB2KQ3NNk9A5V6zyzI4Knh3Z+IEGvV5wuQ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ffpP+lHb; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uU69RyP+ahbFbOmQwKw78svH296tzhn3MP9RpqDxv8972mgj2zAtLzV74oqeopVQgVFMe8YxJbcrfB4awUkIlWsdrapE1QVS+zrxHTqabUhj3pksnQqITgQCyKMfRlpYK+PxWbCYvQRlozF5pBpTtjn4L3ZamIUKl8EMHT6u3JO3Kn2JegEaUzbLfMI+RqGK9ROkDA6IQna5gRaC8QJfJUjY5yX8dBVQBaPZUfrYXtfqSHNk25WWaSNozDhuqF0wcxG6FYK2cYe+tsEX/7rSG7X2962bX8vdmo6eeM8jd3CmSVhWNwpVzI8tUfmkhR0Nln2FDzMSDQXZ3JDJTlm3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiSuT2x1UtfiB+PF5lpiCO+cKmu3quHcLIqYoTVIYAQ=;
 b=S8b9Hc6KXotOHz1YH/SEln/M7miNKKDiL7CgWGN5tR50QgLDIRqoqQS0uvopWv1bIYfZPvffENyE9O3bQEcQUir1TCpYj8mMc2Jw8UzgE3C2Zklpe2U6xXTooKKz0EZqvtWKwPcwOlFp6+i1aH77FJzy3smkgS+At9NwcePqP3Ax0HnzLKqy1twlr0aMY5+rDEkK+0hnnwAFE9nC8HhJXEXfnG+///TfB3ZjGjYZcvPCDBroMh735yKrM67N9tS1cEy1z5zra+a+cyXRMEH7Pv4/rXJYAZ5DKfZml06eWwIYUpsZKY+jpj32l69g6XrwDGUV0NblfOzj2pHFmYdl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiSuT2x1UtfiB+PF5lpiCO+cKmu3quHcLIqYoTVIYAQ=;
 b=ffpP+lHbs/4S92pbGUVgbLS5Km5xFQs5/yYl4KajV92empCY8+Y7Y1swY5sMmNKJyi3yu67rx0ElVFUkRU4uf+VBRkRrYwLhzxmCskMtJqxS5PX+88osvm7fRSatpHg0z7kbNg8lSXhiwUmWvUZbGFw9EY4AEMQ4sPzDrFjUIi6CYRFsBJpntega+4PazkHSMHIWpe3mANSsR0AinO55P0JrK61UnccbsNLgmP8piizU7E+Ziqxlk2P5WSmcekOFvKU23EZuoR4omRjGQOKpu6iNx2PSVwtN06bv7XJb4iAWKxLKYm7GZySqU9Dt3z6DlSXi+S1BL3zwBqWSw+HH/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:26 +0000
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
Subject: [PATCH v5 net-next 3/5] net: enetc: update max chained Tx BD number for i.MX95 ENETC
Date: Mon, 18 Nov 2024 14:06:28 +0800
Message-Id: <20241118060630.1956134-4-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a092da5f-2d05-4b4b-9b8e-08dd07995f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzlIyLTjLAzKRFELvZHX1udp7ovNM3e6959ZkHrRAdk25kt416pEe5guCNth?=
 =?us-ascii?Q?VIMBxHJ30lU9mdETsx5HPLu9oq2OjNYjriE+1dp3p81PltL4YQhBUXbU9VcR?=
 =?us-ascii?Q?Nhq6Hx0MZaJ7e6jdSZn/TEmeTBJf3pAFICBre4yeG90FwN2lIKB9Jex2AUk7?=
 =?us-ascii?Q?ExUwcqrMCJ6AOij5NhVZ1Gl+/dEw+zz1q6ZmHDCpWOJRKUktRODh23QQyDSO?=
 =?us-ascii?Q?UhcWp+fPxR3JJdwborljd7qKNXkm2FI+Ur7bPY023tj/iw7wNgbkx1riifc0?=
 =?us-ascii?Q?JVZW7FJ2RYnrHML6rNkSR6/WenudQBK9xlrfsiI2LajejQ3qk/mskItTL0IT?=
 =?us-ascii?Q?snWD1aII9yVHDHu8kmM0gUihHMZ+Y62kcQdzlAHFKyOvMCIY9IJuvcpE3ugJ?=
 =?us-ascii?Q?SnczrzwoVsuI4vejXbEPm/YdEmwBmdK6Ac+Rb3z32X4KkoujYMz11wAlYdOU?=
 =?us-ascii?Q?hT+piLxTnzZs2gjt2P45QEQ9JvytsHORi3B9qNg3gN60ChAEGU8qE8BceDza?=
 =?us-ascii?Q?byqGb3YK4d+e7bOE43MClgU5d/FIr/llXhJkAZoON2c1FkWKAMEDlwX/ldaE?=
 =?us-ascii?Q?lECLGFD9r77HhTWVjFJi05QCHLeQkPRZbFceHmZYZpXsrJTTVWSL2hCxtAGf?=
 =?us-ascii?Q?bM/aSGtdNDn0tKtu5hVTdBQj63U4Lw2WgdrvXvV1jd6Z+aSeh0mMNO8cKmMG?=
 =?us-ascii?Q?FelrWE0NSPKssX7fXDZNj2O1yoyfXpzHGtiwssozSxQb3fJvkt3cNNNdIh+J?=
 =?us-ascii?Q?5OOfO8VPMhcW0U8K1EKP742F/hgz/r4bmVjwkHTbtiLSWLtQJUKBtEgM7tfd?=
 =?us-ascii?Q?6uY+0RiaXbaMCEXQoIkdtwlbnhzOVNb7s2UjwSZEBV085Jo/GAkXitmpBQFR?=
 =?us-ascii?Q?KqaHzRAFKOSbmvnQcCM2hA7d9h3QjY4AWpxyeC3mV9lokmR7+oBNBIdXW2XC?=
 =?us-ascii?Q?NlOueMGDz8iRXEyUTPkZq5hWvYPq8E1knroFSK1Pi2qPEQx9GR07lT0gy2oZ?=
 =?us-ascii?Q?gB+NrFmuqKEj3pNUFVzHt1tRRks1kFy7qmpjKr5wWwORFoPhAgBGEOFSHtsZ?=
 =?us-ascii?Q?0aJj2yUKY/4nBSD6IXzj62WVWeD+APi1bAyzILpSU9OLoTty2tbv9tyqXqSA?=
 =?us-ascii?Q?YSfgxogz/VZVyRmOFj9pdtqipCSwCEC9H+3ILGciaZ3PPIjkOy5ambUzdQ3j?=
 =?us-ascii?Q?jT7Uc4su9tj8UeSC76yXPag+9PUMFIpskzkS+9OutJggVWziOAHmBOhUQmIS?=
 =?us-ascii?Q?N2exIvi5UTQZ865LWPBcHMrqe+fSsvNM8S9fd7Kiz4kD5h062I5EP00a3Q/H?=
 =?us-ascii?Q?Sr9vrxseaSN1AWGWCrONTOQ+AqAfuG8apR6KjZyTAJ9EEL6Z/gi6S3Az6JKK?=
 =?us-ascii?Q?e6MJo30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pb68698r3Z9p5WBhyRZidk7l9oM5RdP0y+qW+rcaQhPv3VqhbItet1KDZEFk?=
 =?us-ascii?Q?8fK4Xn61AQntCXqyhrnCtuKRi+H6h4o5wQzxMdy2ebyp9oyod8cDXdPwSRe+?=
 =?us-ascii?Q?vENXSurPxbpf8dHQfI5PtRpX0uBfd0nWxVQd8v+bstMGGgfkxdtjQwwfss5w?=
 =?us-ascii?Q?AZ/3Qb/P6RfHzkoIcpblkHLio36jQlbX4poI2JtamWy0+9+FgqTFQ1QCc79K?=
 =?us-ascii?Q?iQQA5WJbhr/g4wDkcMAtIjoPBT0NAT9g17wk5Phq+vQmqVzpOPzJmiG9S4UK?=
 =?us-ascii?Q?ey5TxhdmOqcxqNtmylNWEDaKjT/WL3DAzvaej/Oodkzqyn6/MiE50/zj6jwX?=
 =?us-ascii?Q?j4HGzIO91dV6Y5yZF6CtRkkNuFSniBMYZiUPMfCie8WuXEo7AbCqSYQe9w8d?=
 =?us-ascii?Q?l+iYx05/6ujdHaQuyQTTtOWSZm5+3OBbH2lzYbxnaqJJWUerocPesPCHHVoU?=
 =?us-ascii?Q?f5aKb6dooTCKlLf0MaBf1psOjqvPgfGucmMZRPW1shKv267W335aEF+xit3X?=
 =?us-ascii?Q?ZGoC1ogNdt8txo5Vv3au6pxgDuDlJD+yzi2yp04EUPvvPKVOIogdHyA2yPXk?=
 =?us-ascii?Q?3miF+RipOsGVKaxJTT+uHNeH6cJp2Lqa80yaPHK7IkB+l5GytbY/OIpjI/zZ?=
 =?us-ascii?Q?bdjQRGEer/CbUBPP2JewVMlaHGf/K0QQiku7jVv12tfKmxe8R1DfRZgD9xmK?=
 =?us-ascii?Q?ib8bOqIHAVFFpM78aX1o9h5e5yhwMXoDMjwvcTL0aRJk9ukiUna+WgsUSQP6?=
 =?us-ascii?Q?zMpv5raACmFs22aNKX9dExdyQ+BJNTrAHgvrZ1KSjU051JmrocZFxdQaS4ps?=
 =?us-ascii?Q?g2mtkiSeRCrVsERIMxoTW2QH2Jeps48JwXGCHla8NMMJf12lDuKc1hypOfWx?=
 =?us-ascii?Q?DTAuB7xwDjL/aaPTA0YjkHq6RDalUp+tW0e1j6F69/6cYYjeFdtrwtQSr9HK?=
 =?us-ascii?Q?zNtW6xKuAHKSkMy8LPwqFZJyD0NZTHmWq7jgiyySQI2sRmJyu/n2h/XsGCHl?=
 =?us-ascii?Q?EFyiy96lU4tZ4HiSsJzQYXZk18zy7YXe72yJAK9He19B/+anawSuq4SA6U7Q?=
 =?us-ascii?Q?x2/f0fPPaqaRdEZbxsktHcVFoUjavZ/On8Y5aJwMd/llKCXPAr9Op3laSZaU?=
 =?us-ascii?Q?B+Yl+2PqvBcgOxEH+BpUeZrye7wpnmxR2WPj2zqAItaeWsX8Ap3FXoFFIfsW?=
 =?us-ascii?Q?J1w8X+d38CrAK292kpSdqWAP3zpNVubGXRvq8DHJ1+sNeA040cQHA9HmX9H/?=
 =?us-ascii?Q?cURYnZUGqKNp8fe7cKbTlx23ckmoOnu+9MI50TaxZumjhJ0mGjD5nHwUxjBR?=
 =?us-ascii?Q?bqDPCvTFQ6QNOA1Exd1kJD1mTvwZLQK+7Xu2oViHlaNI00RmzN/hNNKtHADs?=
 =?us-ascii?Q?VQXKn/ZAvZPpq3WnOqrQQZkwqMawWkYs7WLyXg+HxPGm8ulp5bGKL0Jy0ri0?=
 =?us-ascii?Q?jZgjzo56ZalzZVE6XLCQx3bwBtB+GQQhzTAoGKpx0Uhx1AiR6pBGAu/GN5Rh?=
 =?us-ascii?Q?Flh59p2ZnSM1D6pjQ9qqczUMsOWtzFQd48rIwv6oU/TPAYEdqGtCAr+Gjv8R?=
 =?us-ascii?Q?j54nFqr1L4GYCqzdkLjhyTwFO/WY9NgqinU7369w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a092da5f-2d05-4b4b-9b8e-08dd07995f03
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:26.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc05B3VSszCv0Ubxr0+KiWQjlc6O6RIU/Gyr9ObnZwxyVNSVKSuRb12mrUEiJljR/jGBZCwCah7rLR+mbY4xDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
to MAX_SKB_FRAGS.

In addition, add max_frags in struct enetc_drvdata to indicate the max
chained BDs supported by device. Because the max number of chained BDs
supported by LS1028A and i.MX95 ENETC is different.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2:
1. Refine the commit message
2. Add Reviewed-by tag
v3: no changes
v4: no changes
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
 drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 94a78dca86e1..dafe7aeac26b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -525,6 +525,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	int hdr_len, total_len, data_len;
 	struct enetc_tx_swbd *tx_swbd;
 	union enetc_tx_bd *txbd;
@@ -590,7 +591,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
 			bd_data_num++;
 			tso_build_data(skb, &tso, size);
 
-			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
+			if (unlikely(bd_data_num >= priv->max_frags && data_len))
 				goto err_chained_bd;
 		}
 
@@ -651,7 +652,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 		count = enetc_map_tx_tso_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
 	} else {
-		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
+		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
 				goto drop_packet_err;
 
@@ -669,7 +670,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	if (unlikely(!count))
 		goto drop_packet_err;
 
-	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
+	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
 		netif_stop_subqueue(ndev, tx_ring->index);
 
 	return NETDEV_TX_OK;
@@ -937,7 +938,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
 		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
 		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
-		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
+		     (enetc_bd_unused(tx_ring) >=
+		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
 		netif_wake_subqueue(ndev, tx_ring->index);
 	}
 
@@ -3312,6 +3314,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
 static const struct enetc_drvdata enetc_pf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.pmac_offset = ENETC_PMAC_OFFSET,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_pf_ethtool_ops,
 };
 
@@ -3320,11 +3323,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
 	.tx_csum = 1,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
+	.max_frags = ENETC_MAX_SKB_FRAGS,
 	.eth_ops = &enetc_vf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ee11ff97e9ed..a78af4f624e0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -59,9 +59,16 @@ struct enetc_rx_swbd {
 
 /* ENETC overhead: optional extension BD + 1 BD gap */
 #define ENETC_TXBDS_NEEDED(val)	((val) + 2)
-/* max # of chained Tx BDs is 15, including head and extension BD */
+/* For LS1028A, max # of chained Tx BDs is 15, including head and
+ * extension BD.
+ */
 #define ENETC_MAX_SKB_FRAGS	13
-#define ENETC_TXBDS_MAX_NEEDED	ENETC_TXBDS_NEEDED(ENETC_MAX_SKB_FRAGS + 1)
+/* For ENETC v4 and later versions, max # of chained Tx BDs is 63,
+ * including head and extension BD, but the range of MAX_SKB_FRAGS
+ * is 17 ~ 45, so set ENETC4_MAX_SKB_FRAGS to MAX_SKB_FRAGS.
+ */
+#define ENETC4_MAX_SKB_FRAGS		MAX_SKB_FRAGS
+#define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
 	unsigned int packets;
@@ -236,6 +243,7 @@ struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
 	u8 tx_csum:1;
+	u8 max_frags;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -379,6 +387,7 @@ struct enetc_ndev_priv {
 	u16 msg_enable;
 
 	u8 preemptible_tcs;
+	u8 max_frags; /* The maximum number of BDs for fragments */
 
 	enum enetc_active_offloads active_offloads;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3a8a5b6d8c26..2c4c6af672e7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -101,6 +101,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 31e630638090..052833acd220 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -129,6 +129,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
 	priv->sysclk_freq = si->drvdata->sysclk_freq;
+	priv->max_frags = si->drvdata->max_frags;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
-- 
2.34.1


