Return-Path: <netdev+bounces-188980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7EAAFBB3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDF84C74E4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0022D9F8;
	Thu,  8 May 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UmNZEIDa"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011065.outbound.protection.outlook.com [40.107.130.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0622C35E;
	Thu,  8 May 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711682; cv=fail; b=LLYKjZmNlYzi8FnIi2sBT9aybQqNMdyCKX1ma5BJQpv/fXGrfBC/E3UOp9dF7atXj1kOUm+kJnmRZQEi3Ygn+E84zpejJI+GByNS9t1ZIldqxOytFj0ThyU64RxI1rj0KEdwVXuVdaTiT0Pvr0yojouM/4eZooMwPOuBnhWWoXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711682; c=relaxed/simple;
	bh=qLO6TuotDroluQje3vt7qFqvX/h1N1nf7/XgKoc50rg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dqcJ2F6uDgtY68vKmiHJ7kXS0qNDyVpQM+bWNQd62LttjgNner8cPC3LEhTh8Q2PMLH0Q7kqvm8MAUi7AMlRhwQRjDK3EMUo1JORUPAdDBGoSceYYgcu8X4tFBMt39uNHP7vRuE9qhUP8FPvupb+afhu/pqwGtqExVZboibSE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UmNZEIDa; arc=fail smtp.client-ip=40.107.130.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STo4OFawi56QrbNB0xBAQCE9ujKnCdW8P9ZMJgT4URjsbcK0b6/XATawHwdswSxX8gKEE/wY9gnTkXWFAdkx2Nru7J/hR5IiR4bfY4XAU0MeRD105Bg6HZw6Bg+gOASV0xiKZWFy1Qo0LlyM79i3TJQJwgXm/ZazuQxFQXercAt2+NJZv3j9f9e6Zc39I8N2QiYL7IEmPg17+PMn5QlgP6fDYDIC7zbpAl/M2El9HcHJ5jHb66cwcw3dZdUCMNTp8256Q4Pfz63Pjla+BVjk2BxwWG1hNlw5sXdeMMx3NxfyQgUeLpxmaFUS/S4H8+O0pqW9jgAcXwH9oLG1gi1gQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsGbC/7+K9SowGMcjXUyhWoT7zodcJKaVFmFciUUPsc=;
 b=c7319s8nlREWgk11+DJNy+KbXpEnoXMyJQ8xQ6Gc9VTKukFenrzD1UONWn99rBbJLRxJqhXDg1GpOvGTuR8eMw6m5Xm/KdYlyVTpob6PlDQxxxW7jL4CCWBWTRQMInyGLqGc4JU+P8vTxxDm+Q/U1agS1OXN7LAh8+PmZSiKwMAV6Gtb7h2qs4IZ1wRlnGPvAfOK6WPwUpP+25kOxoKTyEitJRU4X8L2+XaVea1nTqVV7enstRKZ8ul1M0zqmrSxfWe7sV6U6TIEUYSNHYQUADHtWsQVGO4Tb3gYdqLFko4pUbQhi4DKPQpDLIGXW5Bfw9AYOeYPPxiIxeHZVGuQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsGbC/7+K9SowGMcjXUyhWoT7zodcJKaVFmFciUUPsc=;
 b=UmNZEIDa6oOCHKJ6Ju9FwHw5ejRzBTyTmWawEbdmDXk3fHbHHCtzkS9Q9vF4RVeH3oWivsVt6fwIotb4KYat+JPn9NxGx2YTm0TFBY5k+hObfszyvaFseaeRhyXIQ4C06wt8w4t+K6EQwev2fGav0ZTaBgiGzHKjsUIeuRSt9zb+zvG9ZkTCW13aL1Vhf2QCJNEb2eiNnwasLMIXGMUWm6HE8pr49b55HuMXfhAMTdmziWsLzSxuRu+8iPgQ3XJjUZ8aAFtUQS49/v5UEHnhadC2XUTgIthLQ9+xItFqVMS5SbfvdB9Ybjm4AlK7UW3S/Ftq1lNSGcOqZrAZADT7Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 13:41:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 13:41:14 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dpaa2-eth: convert to ndo_hwtstamp_set()
Date: Thu,  8 May 2025 16:41:01 +0300
Message-ID: <20250508134102.1747075-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:84::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: e42bbce6-0d3f-4dee-2e7d-08dd8e360064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cZde5Qo+EyGCbU2BZHbzoBbDHJ4iursg00A7Nbcp0GR0621I/w8KrzJI0Sak?=
 =?us-ascii?Q?ZpNn7sf15YLaYX6p0CBM8d6GY4i97IYRG3gBBiiPyhUPjKu/HXKVPqUOwTI1?=
 =?us-ascii?Q?p5sjGgE16/hIKZoaclif6gMfgVeddfX66khuhp+G/Msax8ta9618noRzOw00?=
 =?us-ascii?Q?MFg7me2BFyCT0EZ6TtlV93xVzPqQq8130YP9FG9lQiaFORSIbRZ9CZhd5+mm?=
 =?us-ascii?Q?6JJs3pVNY6J4rmHXQqCQSWGB/cdvf2zY4UZ1dvYH/lZ7nz35VAP6OTKO1m+v?=
 =?us-ascii?Q?xV+fLzAy8MPJJ1sMw1H98oo6637g7mUFES8nsw0XA6Z5RJ+VJMIGBLC8B24x?=
 =?us-ascii?Q?G17PMfhh/FB//90rZ9bQ67+cidMbvouvEV96GXxKyV1VQ6OVCjaTpKSZAgTD?=
 =?us-ascii?Q?v2qcDN9voPjJFPeCyWeguHSoxCNwH1hSPDlhobQgGLlDYXIdDJPWT5vDHOBu?=
 =?us-ascii?Q?dYby571uPFtDAmFldBD4dO2Mn0FmAmPUE64If/O1CMqW/4aa7VMWlY1yQnuj?=
 =?us-ascii?Q?zf9bd1/iCJb+Qycuta6Rq3zOgBfQN3EJXRJPij/E65hfMqdlSjuZqzICaO1K?=
 =?us-ascii?Q?Uui8rmZn2sXT80Y/i/c+FQOJ0izlnZPSQV+VhPPVv4c9qwrVItJ3xpE+kGTR?=
 =?us-ascii?Q?CaKhoAlhK8nb/MaL6zpmN411tFIHwDADL63js6yhRFCM97ZgWBVrZFMiEbGE?=
 =?us-ascii?Q?elPGAWxgi5sxmJbK/e+jXUTJoPmv/wYUHv7rBua1NjxZo9Jnz662LB60dO00?=
 =?us-ascii?Q?NZdxQvISjrIUpI8OzCN4V6RAjGFExRIcIKrqAerLamx8BxVJDuw1SPjHrtEt?=
 =?us-ascii?Q?6KrqjNHwh0ZNYanCjN1ojffJOuLXBop7oJNsuSqUsvHkFji22vGLpdGvxvV7?=
 =?us-ascii?Q?IGUKEcKVRXuVDicbiJuD+MrQ+emyRTtNlK+Affk9ORqimbGdFKiFAzmOEL88?=
 =?us-ascii?Q?i5Eu70Tp9ichYi1qhfdPX5BSfAam5FDWi35rPvI0ViTb6DJ9L7U2UaAv2/98?=
 =?us-ascii?Q?r7XXrtEY6CQH8U+OYHyfJx0wWOIHDtDFSNAAnFWyontk3ICOXX3NgmPy7F8c?=
 =?us-ascii?Q?6Tw989Y9GeOjiHQ46ZgfRAMc4tqRsWDnpa8fc7N6HFHlHSQXP9bchwtgFRe0?=
 =?us-ascii?Q?xEsZtr+UVu5qp2fgnXUO9O8PRzRFBWsSZoPmx7z/2c9gzIACYw51QgEm19Fu?=
 =?us-ascii?Q?jNnHRSmCXALnOxqYZ32TlAawlqtnJDlP/Ydznh/pVA69cP6wbLFmUeUR+FMk?=
 =?us-ascii?Q?PQePneS3OHCs0S7IY7Olluk7ntXFkd4cgAw9zE/5OgZaZeKtsFm4gzokciQu?=
 =?us-ascii?Q?KNDtAaLaWGg4bdLckhtoQODj9M/2sGc6nX3jjD2SEC2tt9bOXmugxi0qWKik?=
 =?us-ascii?Q?zfocdJ/LTidwxQhhkfOxAbGsedOvFAlVE+kj7DK2LK+QZZXMLIXT4fIbLrrh?=
 =?us-ascii?Q?KRZaF2TKfUEAdtzGwGF9MubgVWF/vWMrJfxLlVgk8mGJrO2XYGipDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?posItITJwTQE8r7NJ+2OT4Br/hJDB75UU5VIW13l9bClHZfsNR0+xLDalzcc?=
 =?us-ascii?Q?JscY24uCx5RXCxMD3m9O8Jf4ASFweGNWdtF7xjlpAlVip9tjqAmxfv3s4eS3?=
 =?us-ascii?Q?jWrFJvDmaeq7D6RoGcX0zyVpk9ESnBK1P+9Fi6p2XvxYjedHyYttSWkrPcqG?=
 =?us-ascii?Q?HzJN6oXEUzsMSAQ/xY7WyK6+rnKvghJct+o2ZsoZp+rgbnLplhqw5y7tPs+B?=
 =?us-ascii?Q?m2w3Zu3pZgdRmGhx9FLIcPOF/7hH0PtgsW5opVGvzMQIGJ6NZpTPyudR2+MH?=
 =?us-ascii?Q?tDnH28aoirja8ERMsUjaLOomrCglJygxm16kbquMPX+ZOgnzOJ9/otwp25+M?=
 =?us-ascii?Q?rE/PM3D5Z5qRrkCAQfbWGO2kQrLT6OedaZGWV+v7npCIhGYxsm1pB/jcdS9p?=
 =?us-ascii?Q?JAJQgyG6r0O0e6c0V0ModFUlsVInQ9cbqh3LWF1uruBSZS+bKgCBRoWWI7L0?=
 =?us-ascii?Q?YobNCM6wpeIbY1thMwtHzt7fN9QxLWlDWZ5pbNwccrXnYfMVIj0NlJrfvhe0?=
 =?us-ascii?Q?wyOt6BP6cg7LyKat6999XCR59VPJ8lM7W8lpW5mmU9ae4ZaSY2Snfs+3T0Lg?=
 =?us-ascii?Q?fEHHHmx//rBiRE9d/E/A/hRrbiFJAA3TDQb/QaCw0Xe4EUGnZysBInJVYaz/?=
 =?us-ascii?Q?X3VTVjpWSIe+Q4RH4hzUvDHGlsG+QuF9ZJRQjZIaMgL/pSMKIinpEMUsx2SN?=
 =?us-ascii?Q?3kiBZmVphlokWU1uLKz1/pmL3YXKXG+iL36xG/kpJbxw8T4nlOCv8tdZGovO?=
 =?us-ascii?Q?Cw5zmlBzN8DhMcWClw/V2cl3gU9Bw760bwBYzdG3n2M/S9bN7ZZev/n/TA2Z?=
 =?us-ascii?Q?9EtwNxAyou7m1MJieUpHHFEp8/J3FPyMJ+4xETCZdCK3EWHByWz4VfazqAZU?=
 =?us-ascii?Q?9diZ4VkB1XXvTm3nIEI699m3ins9Ca9n3PCxWxqTAlCpNIUGG/G9xl0ML+00?=
 =?us-ascii?Q?YT1dWzFyDJtJhY/7nfWH/dOok0/TFezr4/f4C2Qwbu4in10aBcMoN7xXkYxU?=
 =?us-ascii?Q?56tbI0zMO1WK2SmFOpInXl4x8dOUR8taUW+XHhtDG2jv3mr7e7s42pMNUVja?=
 =?us-ascii?Q?MENT2jNBjgryVjzBI9ZLZ0k9Y9nPSFS3NR8PJduzohNFOc+Ae3ksnBOXMx/m?=
 =?us-ascii?Q?Nn0DrgHkxy3jueNH/01spgEQ6i6f3iVYclR42niPbOhaRgaJxhssXKzLq1Dg?=
 =?us-ascii?Q?lmLx1uP4xypJ6bwAkR4h5c3CDOFvFBUNbLvd0VrqdgHmDgD+CLgGKMVhvz/t?=
 =?us-ascii?Q?2XC6JSoYO+j42K0FR2UiKKVeeLGPkFzDnpn0EtQNvfOynL1XLhPWwDwU8N4K?=
 =?us-ascii?Q?4ucbdcfXUoGE/caq0peLotGhCTjdx/H8z4+y1AV0aTvGdM7CCe6SVkXpVqyr?=
 =?us-ascii?Q?SQETqWIBvuW4apcLv+4UyTO9ALq9kntA4w+ssRp52JJ65OOtZIvJbQ8KfJNm?=
 =?us-ascii?Q?kw+Hb3cyvZhwR/swxH3s0rK5XN5B5gES/iHNZAXaaLYpzA+MEySzIV2tBSA1?=
 =?us-ascii?Q?j6jQKixe3D0cUMw6PfBD38bqBNXOhNm2MlFJhVM7P19IkBcRjTXh6trcFger?=
 =?us-ascii?Q?Ckyn5QLk8JXHnBXggt34BxpfV8SIQ2VHBJBtA0DtDZlOEOhBhm0G2C885/oE?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42bbce6-0d3f-4dee-2e7d-08dd8e360064
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:41:14.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oIPyxH65rhTksMuejuFCvKhH0tNffJGhGtnz1dU9liZ5cCFGC1hVwxeq9dJHz4LuiLufBEWBLszTkxphPqwYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the DPAA2 Ethernet driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

This driver only responds to SIOCSHWTSTAMP (not SIOCGHWTSTAMP) so
convert just that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LX2160A
---
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 29886a8ba73f..13b44fc170dc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2585,40 +2585,37 @@ static int dpaa2_eth_set_features(struct net_device *net_dev,
 	return 0;
 }
 
-static int dpaa2_eth_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int dpaa2_eth_hwtstamp_set(struct net_device *dev,
+				  struct kernel_hwtstamp_config *config,
+				  struct netlink_ext_ack *extack)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
 
 	if (!dpaa2_ptp)
 		return -EINVAL;
 
-	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		priv->tx_tstamp_type = config.tx_type;
+		priv->tx_tstamp_type = config->tx_type;
 		break;
 	default:
 		return -ERANGE;
 	}
 
-	if (config.rx_filter == HWTSTAMP_FILTER_NONE) {
+	if (config->rx_filter == HWTSTAMP_FILTER_NONE) {
 		priv->rx_tstamp = false;
 	} else {
 		priv->rx_tstamp = true;
 		/* TS is set for all frame types, not only those requested */
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 	}
 
 	if (priv->tx_tstamp_type == HWTSTAMP_TX_ONESTEP_SYNC)
 		dpaa2_ptp_onestep_reg_update_method(priv);
 
-	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
-			-EFAULT : 0;
+	return 0;
 }
 
 static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
@@ -2626,9 +2623,6 @@ static int dpaa2_eth_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	struct dpaa2_eth_priv *priv = netdev_priv(dev);
 	int err;
 
-	if (cmd == SIOCSHWTSTAMP)
-		return dpaa2_eth_ts_ioctl(dev, rq, cmd);
-
 	mutex_lock(&priv->mac_lock);
 
 	if (dpaa2_eth_is_type_phy(priv)) {
@@ -3034,7 +3028,8 @@ static const struct net_device_ops dpaa2_eth_ops = {
 	.ndo_xsk_wakeup = dpaa2_xsk_wakeup,
 	.ndo_setup_tc = dpaa2_eth_setup_tc,
 	.ndo_vlan_rx_add_vid = dpaa2_eth_rx_add_vid,
-	.ndo_vlan_rx_kill_vid = dpaa2_eth_rx_kill_vid
+	.ndo_vlan_rx_kill_vid = dpaa2_eth_rx_kill_vid,
+	.ndo_hwtstamp_set = dpaa2_eth_hwtstamp_set,
 };
 
 static void dpaa2_eth_cdan_cb(struct dpaa2_io_notification_ctx *ctx)
-- 
2.43.0


