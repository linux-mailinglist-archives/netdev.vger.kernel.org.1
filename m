Return-Path: <netdev+bounces-189007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B281DAAFD3D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2764C169C2E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E2274FC9;
	Thu,  8 May 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYI2xnAv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638E2749F7;
	Thu,  8 May 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715033; cv=fail; b=jZF5Vp2/LZGbVP0JPw3O+gg4v+Nz308xqLt17yJf7L4UXiGgQmN5fOZZIvPa4Mz07XExMpWqCGG0UgS9jjYQ0nbt0I94rCBJ/JSOjdXMxPKJiOCM641f9cYgq0PIEcIxXFwE0Af3a5zktmkKQ+a1R879UZE35IowtABpQzts/pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715033; c=relaxed/simple;
	bh=KP9iAc+qO3fu3zAe+/Z+7fMWbH9bvb5iQMcDYr3Lqus=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mXs1Auozcg81TsqBH84IczebcjoaQmNy5ft9a+ykxv8EnnGu9ywaEtx7y+N0GPxa93vldWVbS5JfrBL1vTXPONLVvEOhi6p465pRREVHDz2+pIGaOHknGxHKxpW4SneXHWtx8VDXwefJr/NcnlnC34B+ZLU+Wc3j77vP4wQhlSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYI2xnAv; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjwYdURBwe/pdSbdR17xgawBFGiJ+NG3FAL12Iy4rCWqHgnu9Z8vOA2I7Ei9lczvmOx1BRe/cLt/RuGrsr12FPd9sp598QLkCZUvapw9oO4DdP2tDqOcOGKL+9VSEg1cOTzJHICXm+oocfNqSwJohVI+PKJzTf643nEGjYH0ONgDW7p6y183jngYz1OkmTKBqxNxtZmUW89/x4EIs+cg1dduIN9X6RNSv11B7hAPUIi8soDJIKYawPDgNto+42e7p3Mu0UhSIKtf/9ASt9YWvsG58w/Uxv1Ns2hYCv7BK3zy2kT58YsXKrlkQCv1VtCMQTJ37f5UtYBXGpsBAKNCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYC69QtZI/90QMt6FygTxGft63slwqVIVU8yjTnCpFw=;
 b=oOxiII2Q8LoQ4AooHfm4t5c/maVuBJxSVoDMdwgQoEwKGIAvEZvv31nqSQs0iO/OM1kcuD3PYliLWNpm0dj2aHiTPzOPNicMqHJ6oku4JQoBwG6x/5utBZDSWws2z4yGqmCEWZpNX4chkFo7sWsnq1MNckiWB4assr9N2MwjVP0PabMz4Vd9KC5I9BxxVhUkOZ6+W2/XzGFI8SMQKhoZoB5sFn0drkN2flVxLeH8ZTO9gavPUTsSkT2TiUG8Ysejokq6Qr2pOGEU4O8LAYQ+esophBVHE85SO/ykPgNxGuS1f1ECihOBuxIh7DEplEubQ8h1eSKuLEQrWvhOBgdZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYC69QtZI/90QMt6FygTxGft63slwqVIVU8yjTnCpFw=;
 b=CYI2xnAvtWT/0PxuRVpuwLKJvioh4CNyzMEbb5skAAtlNhcEizjQYLbkoVekSwFGBhvADXeIGTPz4VkG0iQvS53Pp1l/j2R9nJQAMkwJoI8aPXzooWnh/hd+6RAycNGseKb5fVvbcqsXNEvR/R5nGBUVTtz4xDZdF0zXa7n2lr+0tuUVa8hrxtamP9lrZ94hLVnvgPmQvodEECoTy4Ol/CSh0AiO3M2SohBD/wbUD62GkeT0O6o4c5xr8q7fSShRyPFhJEgEe/VKMWel70zlWjnDQT9hnl6N3t13bg7xukXiJik/tSVSNSH1c5vKfp6qH2ThdMl1YpGRh60jAy1YhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 14:37:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 14:37:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: gianfar: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  8 May 2025 17:36:59 +0300
Message-ID: <20250508143659.1944220-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0494.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 81519229-6e6d-45e5-4c21-08dd8e3dcf2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IBg9oN27ZPS1qKfdy8L44k0rymxkPI6Tnw4d0cbi9lUJNdLgZwYnYm1tRi4?=
 =?us-ascii?Q?IdNEWOOxNpckvsKx2c4sJ3tzgjGy0TqMHrJKYnTBVQGgChWUoevZvsBsKUq4?=
 =?us-ascii?Q?qSjaiyeNQjL8zQc3RmSIO9NhfnfY8Jarzny/hUTzJx8jN8o4PG4/ejhHZNXX?=
 =?us-ascii?Q?fSOFZcF5po8jUvKed9pcKxcstW78eXhhrcgvT8ayVsKpRA2SvdjethmEKKkF?=
 =?us-ascii?Q?6JKzL7vkC67tfDFnoECD4A7S5pDLZkDpVGc+4upIsqQQX9OKhsIu/BPhrwIH?=
 =?us-ascii?Q?q3mJB8AxDVMgUYVGBUaKhgLJqS6pYrZBHd9OiBhHJ7AirFqC52m3mMPe+VsK?=
 =?us-ascii?Q?HMW4JpBSVejVicZYlKHaElkvLBFYqCF5aoOGxluIrpjXVaTPizdf1Us8O731?=
 =?us-ascii?Q?ZsUb119b/wV4UWm1YfCBF1JGr6u3IF0E1i0EysExfWq2aX0gTNCrJvYaYgJ3?=
 =?us-ascii?Q?Ybr/wJerp44YcYnGgGX0mRxP+zu0rWg3YY/WP1bwNfgUmUPz4n0CnE6/HHEG?=
 =?us-ascii?Q?T22qDz331hmWJ/qK7zQQb9F7bCXpZ5xKlzhUm8G7SjTRozk4MsF6DYPypb2A?=
 =?us-ascii?Q?LtaB0hTyAfBwoqVGfq0pkMV4s4yGtabPwHFTNNgdZQaiYZtBiBSOxLWER3eU?=
 =?us-ascii?Q?y+hX9gZe46xZ2YNFF3ZwN/leIZvgSvypfjvxAfJZeQfbAylXyFolntl7rwrB?=
 =?us-ascii?Q?xYQdQxLGZRJaQV43UnT+BHsd9ga3xoXn97k7MJXLUlY0fN2YMOKZB4Ky2BW0?=
 =?us-ascii?Q?7fonYDT1F2z1rP4WyRFoFbSNkkzV4wrb+JuJrpULAfBG5EL4T4fgl0srQI3L?=
 =?us-ascii?Q?pGhHwxSVDWGuS4IWjb5bkbAUfqKf6FQ4ZFPo0B5+BHJ42ErvrXg9ryjKBgy3?=
 =?us-ascii?Q?cKfEIq5hWks1wO+2BbHjrtu1G6CPEeQtEnC2fOhaQJz34UV31C5scyNdUiIT?=
 =?us-ascii?Q?/Pt8B1Mi5pZDZPIC5T69e3KZ0bdKE4uAGTDvx63szE119b+lFkX0yrhNCOZ0?=
 =?us-ascii?Q?9s2p9+ufGWFibo8CjdHb/eifyggJzR2Q2QX46/4p3xP16X5b184A+2xNHmDo?=
 =?us-ascii?Q?wFQ6yead1WbJir5PE1V35V64hYl/JNf7+H+In8JwXu85LLpp34JdEmp3FYjg?=
 =?us-ascii?Q?9zIIu5YncwqvZemjcrlPAN/ow2475rFD7wYc25XnVnwz310OT9zajifJpZDf?=
 =?us-ascii?Q?7FrZB4nycpcl4J+wr7YpUn0GynloPWh9cHh7N4zgiMh//eILSpMBl/CH/p+e?=
 =?us-ascii?Q?ADbH3XLMCp8Dl1p5B8sEHpgrKxoPZTvcQT+tD3+h58UVOo/By24IE5jYyDSh?=
 =?us-ascii?Q?wjU9ok2aQA7QMByAl71gc9h024zFcnOH+lCJAnfchHVtdCLWNWUETRP9AxN7?=
 =?us-ascii?Q?Lr1c+wJQuYKjjBVihhL3ZAk4XvGYwXIdK3bLZTyjJmYs9EksCB+Sv4sEUYIW?=
 =?us-ascii?Q?EdusQO9FdxAhYbT6IGCQ5294yfeOqTAMWxu8TA8/fvxs4lH8FWX30A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CX+GUdczj/1f0NiBkVzJQd+xF/7OcI/EOuxKu0+XFaS9QNUS+QZKrADoIEJW?=
 =?us-ascii?Q?yHvTc6KiW7/vMsbojLhAtiHoxCsFiuOFfEBYtqOLRKRk22LayIMOMK9qwtCi?=
 =?us-ascii?Q?TcHUlFSged2ooNh77peSddV2nKZDJ2sHJO8hCwRbBDbL4nmiU8qGwNenrMuN?=
 =?us-ascii?Q?4kJuaPZzTMGdNisXSdEU5N57/jKvCpUF/ko9o+DyIOBhHL0WO9lkdoigmBc4?=
 =?us-ascii?Q?lYQLr79RiBde/5kTYuKNJ6CMiK4W6YoJBrP6GKsJCwA4YzNAGk6+IUygrEIH?=
 =?us-ascii?Q?h8XzUG/j4mryFNonM9TPfa80ZAJjAtQnowqBSeEw4j+wNyl+dgqXHS2fbrjf?=
 =?us-ascii?Q?8AFqhrgmcX/D4czViq+pi/NW+xgWTRYcePvktNgPW1og9MmRJcpSrXjg2BVF?=
 =?us-ascii?Q?kZ5Vq9wMI1wRx/aRsHnnocDmwxXPmjseCoLHARiE90kgoBG2KL0Ep1ubNLKL?=
 =?us-ascii?Q?1FrPPsdkKmvzCzKL7zve2m97QIZXMAzvI9skPCOT1xtynb2mg+xZbUCpHYYM?=
 =?us-ascii?Q?qVpDIljxQDrBCOmJWX5GZAdzJ8An6iAPzDGWsgkpPxtBH+6mWBWA+Ehy7nfn?=
 =?us-ascii?Q?LPF/BZ7djocLaRT7SYBjWiudK7/vo/zduAAbLrwHHXvUBBU9pF30j9AZHGgu?=
 =?us-ascii?Q?o9iMuAlXhSNp/IFIHV4UXKpHNYo2qiwKykB98xNbbZuCNYvXkDTGYu7PPMei?=
 =?us-ascii?Q?5acSQ4wyrA3MTvCskcumgqGpXMfajvhJ7M/5MEvvJc4febOZzroG6TqrK+pL?=
 =?us-ascii?Q?PPygMJ8lY2/pqCtVQ0SYmAAjqoOtaQnG4QINXmNJFWLqy7jQcvdetwOMm3lc?=
 =?us-ascii?Q?0rDx6S2upzZbfi2JV6FwBQv27FcRjDsL4Vbc/h3/RAL4Nb62nPlnxN1T/F5B?=
 =?us-ascii?Q?tvQGqH3uSqhYMZBcr3v5ezWygXQOH6v7ORe7MGMzkgs8C/OOiH5Z0lWG9DiF?=
 =?us-ascii?Q?FZ6TwxF+ySRhYn0RPl232GQIZMvxDaO77dRB7fCsT3fQ9g3RfhdlkhPcicwB?=
 =?us-ascii?Q?r+ei2wNht6XBBNP1mxl887bhxaHWyJ+eCtf5vVisOGmbKKye+cuA7wfrQ5U2?=
 =?us-ascii?Q?R+9Ir8eKs7nMyp5n/GBRgsrs5renjdsbT1H3aLBiOceB1TIn/QI1A4aOojqx?=
 =?us-ascii?Q?fwZ9ocOI7Nulct113qUa14VSyAzYLSm9sDsLQDAFeMhZHJDGkSjcg7iVVira?=
 =?us-ascii?Q?5Do6O5JvJgbR9np2lSsOctg6TJMoUYYnj7mHZkX/VXolrC3yARvyY/wjnnJj?=
 =?us-ascii?Q?UQmHH0qhD0d2bfgKvbgqeBLArXIu/4SoIcuC5PnhN5s+l6WLGPG5g3WjKuhH?=
 =?us-ascii?Q?Lz9tq53doWMfcDT2XU7VhaQvAvWT9d0pBgFAOZsENeJMVOIr66hunrsBQ0Zo?=
 =?us-ascii?Q?y7AtVRDrjgUF2Xr+gv38G7TgOngk2lYosjKN1oL03H++tknnjFM6zzLRp0Ej?=
 =?us-ascii?Q?HO/5AJ3YszTWxavas09ztXNbE+AyD1CLhQ3WD4iygp2KhybGi4B84UCJ9skP?=
 =?us-ascii?Q?ftbL8BOpAYvqsxMocmHF2L/y0uL02sZilEAm2Y9UktS+LGoCgw4KvaeTxSq7?=
 =?us-ascii?Q?HQf3FXxG4/CJS4lDlOo+YbB6b+PJTrqxDTihIctWXbzl9HA+S1nc+CbSpSkV?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81519229-6e6d-45e5-4c21-08dd8e3dcf2d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:37:07.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdDi5+BTpSlwTMG3/veaKu1uwxC0YTDgysqkj/0vg2088OFVVpHf+Ru15lRjGSgpiOm+UszbFI69hbZgDxcLyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the gianfar driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

Don't propagate the unnecessary "config.flags = 0;" assignment to
gfar_hwtstamp_get(), because dev_get_hwtstamp() provides a zero
initialized struct kernel_hwtstamp_config.

After removing timestamping logic from gfar_ioctl(), the rest is
equivalent to phy_do_ioctl_running(), so provide that directly as our
ndo_eth_ioctl() implementation.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1021A
---
 drivers/net/ethernet/freescale/gianfar.c | 53 +++++++-----------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index deb35b38c976..bcbcad613512 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2061,15 +2061,13 @@ static void gfar_timeout(struct net_device *dev, unsigned int txqueue)
 	schedule_work(&priv->reset_task);
 }
 
-static int gfar_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
+static int gfar_hwtstamp_set(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
 	struct gfar_private *priv = netdev_priv(netdev);
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		priv->hwts_tx_en = 0;
 		break;
@@ -2082,7 +2080,7 @@ static int gfar_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
 		return -ERANGE;
 	}
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		if (priv->hwts_rx_en) {
 			priv->hwts_rx_en = 0;
@@ -2096,44 +2094,23 @@ static int gfar_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
 			priv->hwts_rx_en = 1;
 			reset_gfar(netdev);
 		}
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	}
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
-static int gfar_hwtstamp_get(struct net_device *netdev, struct ifreq *ifr)
+static int gfar_hwtstamp_get(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config config;
 	struct gfar_private *priv = netdev_priv(netdev);
 
-	config.flags = 0;
-	config.tx_type = priv->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	config.rx_filter = (priv->hwts_rx_en ?
-			    HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE);
-
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
-}
-
-static int gfar_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-{
-	struct phy_device *phydev = dev->phydev;
+	config->tx_type = priv->hwts_tx_en ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+	config->rx_filter = priv->hwts_rx_en ? HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
 
-	if (!netif_running(dev))
-		return -EINVAL;
-
-	if (cmd == SIOCSHWTSTAMP)
-		return gfar_hwtstamp_set(dev, rq);
-	if (cmd == SIOCGHWTSTAMP)
-		return gfar_hwtstamp_get(dev, rq);
-
-	if (!phydev)
-		return -ENODEV;
-
-	return phy_mii_ioctl(phydev, rq, cmd);
+	return 0;
 }
 
 /* Interrupt Handler for Transmit complete */
@@ -3174,7 +3151,7 @@ static const struct net_device_ops gfar_netdev_ops = {
 	.ndo_set_features = gfar_set_features,
 	.ndo_set_rx_mode = gfar_set_multi,
 	.ndo_tx_timeout = gfar_timeout,
-	.ndo_eth_ioctl = gfar_ioctl,
+	.ndo_eth_ioctl = phy_do_ioctl_running,
 	.ndo_get_stats64 = gfar_get_stats64,
 	.ndo_change_carrier = fixed_phy_change_carrier,
 	.ndo_set_mac_address = gfar_set_mac_addr,
@@ -3182,6 +3159,8 @@ static const struct net_device_ops gfar_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = gfar_netpoll,
 #endif
+	.ndo_hwtstamp_get = gfar_hwtstamp_get,
+	.ndo_hwtstamp_set = gfar_hwtstamp_set,
 };
 
 /* Set up the ethernet device structure, private data,
-- 
2.43.0


