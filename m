Return-Path: <netdev+bounces-145151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44D59CD5B1
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953CA282229
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5397160884;
	Fri, 15 Nov 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VE6IWhsJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C68B15B153;
	Fri, 15 Nov 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639815; cv=fail; b=OCCFtkfGJpLAHExwVaw78j220BEU9r6Vb0zfELJxrQeU8BQw8uGQ03tn8xbNxVPJ4D3reOG2OC7V70fCFtKh7ySq/gR5HW+W49HL6pH3ulqP1jxBSGIrC2hmMjQmYJA2Uc9B+GuLa3IcCuWgvMNoyPlaSefC2U/ikbnF2muE1Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639815; c=relaxed/simple;
	bh=6OBjYIif+Wi3qP//igl4AcNvIbBLWrayd06KnOnt48s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hODAOSaK5vP/3/kU3pfF+0Xqn7XIDDShpD2SCmoa4Zih197DF8INRMLnZOPXOPknV8Ad7f47DNQ71sKZ9mbZUkv2WVPFFqQHfr2G8vqKEcUxuHlqrgpYEh7uao2uedhAFXAKLHBTkW5hLdzAjtS7uaTJkYyVDgfeMlFuEnRM2Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VE6IWhsJ; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLlMunpKcyNFNtZ19TZRiXcfVX/Rs0GhZHxNmipMbASQP0WqGvMeSsDbju561xtW16HNg63a0vRS98gLjV3lHWa0Tng2wgPGVdwqBJF1c6ymBclxt0nb6IRUnB9IanPMTIGDNTfuIu6DtKvIbsnEKbyPFUOhCL3nTEy9Jcsl66HHwFxe/W6NHLJg2KYw7JLoiEGuUxWTzKauNcNWIeKcbT7MIACkeJETh5RHPxa47VuC+sVSjP1FvWKmKBY0QA2jRKmxgL8lkcik58bFNhZ5ixRfcFaMJ/rrUqvk6GIccA2UGjhqsu+SYqneyPuaFTr2hzIwGvBhkV9dbOcd8KRBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92o1UFRlB9G+7GfxDvmYRBzcLKkiB1JOI3RTc87wH0Y=;
 b=i5q/ql89gYeh+N6eF6HqbstVAHZkKKgYniNwQKySMKemPuvGhpIp+DqxEnfyf1KnU4JKD5EEf+AqTDiZlATxqAl0JlOAWeDwQqeVFsuiuLbgQ1FLp7If/bC248qTk3Q0HFovbVcKsu9iUoNH3+TxY6UMehRTNFfmTPjn7S++z/oI/nPD49KCw5qI5gbz1mmmZQ+md+dzddN9PtDBFFzoDIQ5sCJFGq1O/NM9eJI54846sajE2yIAZHoHgUt6tHj31sQHwVffZbW8ntkhgGWrLMX1gOw4cqHu8kr4OJRcVKehbWlIJx4UJEVOwQWLM7/tNoUHArtZTRpGa1ZvUJHX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92o1UFRlB9G+7GfxDvmYRBzcLKkiB1JOI3RTc87wH0Y=;
 b=VE6IWhsJ/2TLJyfo6IQioq0k3xtF5yT5KoOiJg4fVIWHWeD25QpHRX3rk1Iy/j0sQ/aUBxvhJSaX1tSRvo7zyRLY2areUNjOld8nbE9Nz2ijXJLS0F24xPBfnUO7vZiid2RmoElyYTQDLhgz3vXW7PdhucU7mUQzGfjR3ara2YYobRfubfQlfhpowjsSuE4IJ6xLnXcqxRz2o+qV3ycg1dq39VjpJUtKFf4qYOVAklz+he8p3GKT+It9kNvyoWcmWTRMq9MbRs6MqydkEJgL/lHzoF6AcAEbekunROrvgMxf8Zsxjf9jDq3VS/t2KWDT6UkDQVeOG5VNVZxipNwJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 03:03:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 03:03:30 +0000
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
Subject: [PATCH v4 net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Fri, 15 Nov 2024 10:47:40 +0800
Message-Id: <20241115024744.1903377-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115024744.1903377-1-wei.fang@nxp.com>
References: <20241115024744.1903377-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: f4222e3c-fa21-4392-6798-08dd0522156f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lMntpY3gQ8mQ0jB/Fdcj4frCN5/NyoFud+LsMKneD8aMcnLS69BKFtJYecWl?=
 =?us-ascii?Q?wUgyHqWii9jiyHT8Y5iB8bdNgWYjUrMKCozlj8bMMslCbDKy7qDiEeDjN/20?=
 =?us-ascii?Q?SwqaZL3SESe8TX6MO02U43cPTTpXaZiYg8GGNqvGwetTSGRGT0EDtom4AfI0?=
 =?us-ascii?Q?sRTHu1iGFQ/b89u5ASubryKSNoCJndAEKYhW0Kk6rh/G1wFPH5oewKJ/nNQA?=
 =?us-ascii?Q?F56L1VdBvRiclzE+bzRj5YnXT78FHvl2yeMFUr7qNcib187+W2rSift5siLs?=
 =?us-ascii?Q?b2kaKT8cQFFFk4RAbcpqCzxA2jKoY+tvYP30Ib/7vpm0WjdWoZkfoQvGDaN4?=
 =?us-ascii?Q?Rn1RiLcCs1VojpkQN2kqtwIp/kTrRZmg9WlhBSz7iK2N6rsntZurBZdsUdMy?=
 =?us-ascii?Q?Y3rKzgBk5lcUHSOFk0w9slcVi38yNcCl+85hCJYgDWmB66dgATdZs6/zWdV1?=
 =?us-ascii?Q?NpC+aJeusDuMWfQKYTWdmXrM4ADhEFImL0EinpbIehJhG2HND8IV/lSEIb26?=
 =?us-ascii?Q?GlwmSZDFOWb7hJloSSlxsMTk7qa3LsTEEWX64yv/QO+X0o2iZ4JRrGwzlP4u?=
 =?us-ascii?Q?OZhrYqgCtPHHI8AhCFv0v2Qrm2+Y3IQaUNHyJK41jWdlnU4yhsiej7tBb9t8?=
 =?us-ascii?Q?R5bDZv6NgaGcWDMj/yhUUSrDchD7TzrfK0kfTZiEFyOAyEZWmBTaOjJ0tftc?=
 =?us-ascii?Q?VXk/myeWL5K02chB7Cy5c9p0tFYCfnqIRtRrSTD68m160KCMvX6KuHfBCzZf?=
 =?us-ascii?Q?pYiYrIMC4ZP7PRDNJbyazRK4vsE6WGOh1RgrW1L7VnlZO5OQ19gPlDwhAKJQ?=
 =?us-ascii?Q?ITBbXBNV0Qxhs3xfiBP3EE6n+lJXHsTxpziU6dZ/R0XGweD8t86pLo5tjK80?=
 =?us-ascii?Q?HHpj3ixQeb7QfeCFfmCjZK24iwGZQRG/33XuczU1SFS3wBVLY58Gc/S0vO4B?=
 =?us-ascii?Q?1vGRDNCKCmMPxhrxWEhEalxHZAi28PC+zs02yCu7mFa1Tx6zznfyiBhICX6B?=
 =?us-ascii?Q?OqiT7mwf/9UM7Ge1CuPp9gcbt7bIPQkPCXSzm9uDm43vVhBnhwhR8TVy7JbS?=
 =?us-ascii?Q?/JhUf8XYbuLIGfXl/ijnjlFtIpREfbqtT2OiIhfE5yK3ypyOxyISf+EqqXax?=
 =?us-ascii?Q?4Dtm1+sjkMRmgh1TJokhCbxtddXPUQ0rP3jtoZUR2uh3oVBMo1S7nhBanEt8?=
 =?us-ascii?Q?TIEOmmWWo+1Vj/jnnpF9mO6tVX1+5D3idRxJ9QVfHgKpneE7mm/v+aI9cmdO?=
 =?us-ascii?Q?hFJWTb9XhdXZTJcx5nEaY1yRO2mJBtspI6Eubph7GEsGBKXU1DK7uXa8CH5K?=
 =?us-ascii?Q?iA8rcmxfgcFv9znAYxkkRxJIV0VQvOuLNVaL4Qknnqno/+j6mNpo5L/WNm2Q?=
 =?us-ascii?Q?TD7k53k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E8encL5DnBwqsru32Kg/EgdSnX0Zjd3bI0z5lmJQQNrfJGYmFI2ht27C0A7c?=
 =?us-ascii?Q?5m5FupmIMKewrYPVcKKoQjStmoz88TRAHU28xrQRzE46Rl3HmeCBykbiePwO?=
 =?us-ascii?Q?Flkl3sWX0c/Ft+uWq88kmyrSr+3NQRYBfHIPmuT1Jnu9Y3R2YBD1Nv5coA2C?=
 =?us-ascii?Q?Y5YMFh3nSzQMAbBGtGZYZJ99yb+6GmkaE6V/OicnWFiAAnmRTVjKVD+pS2e4?=
 =?us-ascii?Q?MXAvdyzHVpW5aZPhxm/ZKI8d4nEdDlLTCCadDVZnMkchfhnjUC/JV8gqwuCU?=
 =?us-ascii?Q?75Q5rv0NEFaYUBxCGXemfY0rksqjSfnLpgGwuY8PUtoOHEtJpYCT9BNgYx/W?=
 =?us-ascii?Q?wVLzlnFfrB8BsnZe9BkC5la6mgEByIT1yy0C/2dyBaOH66tra3MzQiLMnWXJ?=
 =?us-ascii?Q?hz08/0CdBhn5kav33RIHvIg1i6PC8i62m9hF89Ul+A5OGr6lJcLArMQZwD2o?=
 =?us-ascii?Q?/1mh0SxSZ9PHpJea7kcgV3hLGAVfTSEfR1jQx286KbVBCaZwhVPysu2KkZrB?=
 =?us-ascii?Q?YGLHeiuiooB/zBK48TBxhIjv+IUPO8+qx5czNgmM6UCt3Adw5gDLMhVdE9/J?=
 =?us-ascii?Q?bcK+/6TJVfzs8Jyy9yJxAjki2wPi1lX94ID6EuRIvJdg3XFJ3Cii1scQOcTZ?=
 =?us-ascii?Q?L8rp2tsnV3yUrisekKSjFA8w57ZridCmvSFE/YbyXv7PdFxPr2LA0YVTUVpX?=
 =?us-ascii?Q?eU4P9sBsyYDct/wvF6Gn5NQJv73FTCMDnN7D0bckBcmmmSk49Crv3qkOHCRu?=
 =?us-ascii?Q?evreP1NoFc3ZB+VNMI29xbU3vjcMHuDBM1vLSb6Sa+2HX2YLeYdRUQ+nZpVD?=
 =?us-ascii?Q?foe0sWdaD/8efB499jWS39cBuVFF9Qt5odmeL/WS73bAVhHb1W6FpgGq5iy8?=
 =?us-ascii?Q?RdsyWyr00yHlYlhV5MU759i9K23LFL68AO42SpHFQXi266BhIIu7yR9hr3d+?=
 =?us-ascii?Q?c4SxOxGyeGalRwtPZ5+e+NQL2UHD2tyk06RWYqsX7bpBDnKUklvmHawv7i/W?=
 =?us-ascii?Q?aBi+pmewwRXx/lOJSgoP/LXDvlF6JcK5EI1iMZOmYoz1LRjCAMjHvP4ipPe7?=
 =?us-ascii?Q?czB19PcHDKNHEQ++zp4tVUocrMTRJqUIy6G3lY6SU0Le+4au3yu45NObAZQ1?=
 =?us-ascii?Q?qafDXd7M+940lpadZKSFRSYFROByss/m8cAmmJd12msrY/roLxRKMEVxD98I?=
 =?us-ascii?Q?UPetBT6pQtnZJn+cV5pyPw0EsRTvUqeIRVryuc/6WLQcDknOI8JXnH+VEquF?=
 =?us-ascii?Q?Y4isnBRLRNGqsftX7TMusBJySIh/G1u3ObmVYzBXh+UPWk6uY0L+qEQZg7p8?=
 =?us-ascii?Q?8ZcrWeRZt+5rr0+ubLsJ9t0QcPbItjj34Attz6H94O0CDosXfkU7gcXBHvoe?=
 =?us-ascii?Q?3ol8qRd76YGns8cYj21Gn1hDcjTGhHQCAAuJrACF3bfLBMwQT0hWTvqMmWiM?=
 =?us-ascii?Q?gF+ai/fDspyXzsApST7S+l+ZR/Wia4KYPTil5E4zOoqEqZ/t6euF8JWIqMtF?=
 =?us-ascii?Q?BFfpMAIh+PWRXX2CHUpZEqSIJmtbLxWltQ2533bbEAYRNjp7javq6l2RqPtI?=
 =?us-ascii?Q?o2dtAi/BYKUGXfVst7JdGURW1XTARkJIUEg0cX3s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4222e3c-fa21-4392-6798-08dd0522156f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 03:03:30.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WsgkZ/vZr8670Gdnom3Gya+834LzMyXUPb5UFfXA0vpI5tULo+Rh1gpGeROihMzqoeUrjikwM+nqmGnL2TyJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
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


