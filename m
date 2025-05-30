Return-Path: <netdev+bounces-194332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75949AC8A9F
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369F54E2CD4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8821C182;
	Fri, 30 May 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KP5Q1in7"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4E219A6B;
	Fri, 30 May 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596814; cv=fail; b=ryaHsp5nzpHYuRFWr9B9h2YHsaqlgSEtueHbQ3h1FE9m9w/RyoIPoy5z2jlvxRukNyiRupBWs46X88s7IHYrwQ35st/1G0HQDqVA296zFOqg5DVEpowfMIhnguKbknhijjgIKH2nRAKTeSRM+jjrN2HAxpTr1PxOqVEz6QYiUhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596814; c=relaxed/simple;
	bh=2BUQqEeHTc36ku7ScZJaPPfb6pPGN4NOv5cHhpYt/Po=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kd7ZwByAmZbWoTGwX8l83HxOPjkCBJsirU13Pl7SKiieBYjL2sm4v9RFb4KN6cQWZjMvrJQaVQCxuvFUL3x11HTDmMnsCyTSnFo98FUeZUizA+qteCtgZysKHdqI8ScXoQaHlFH5moLZTtqUe4zAT+AE4yAL/aWSOqKHnHtnm5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KP5Q1in7; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRqXibkl+4AKmYLtcwhskNlLBkjeLCfy3SjxuIgZKltI+ibCgH+XIRrc3UszGO31yM7MoYgM9k6hxGGP/MBNA3yysReEptCiLFiRsy7d1SKMDfFavdvA2sTI7gQrYaUeAMxCmJmA6FCBJorrpsB3d4ifsXu2BtOhpwMEL92Z4OfOzYq6q4ubKOaK7YzFzw+N6r28kIWtsYoJ/X0jyKmTQrmgSh9ivBnT9Mbp3f47M7ap3Dh7HKt14b0hJw6GQafAtAXXdFkPBxKxbLxB8iVNRhNw+anUhS9ntGtMd0onGq/gKPQYw+a/yvpGzbH9o9QQE/M9hCsKnCWKYw3yNjSnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj0+gJLtntZkGJpgnIa8t9cEIDVZj1mAGmDvJLn5+xA=;
 b=c0g+nSzTqSojd5Eyrux9bvLxxKEuIYSyvsjOyzm/CrcOByynUB7qqqmzxvBJJt0YliirV44NrY1qYRCGv7iAjoUBKmy9cQJDf7tGbZa9N/53hUzjRM+0kBWXx9rpIMNiXwgnTpesMU6I0wesi5p2cdVPkfB/YlV3TShqKT8iWdc6C3xV88YuNZLWYLWndI1MJH8YbvNnO7zZF5PBkstbtsPINBT6i8iNylU94RaF5H9PvX3B9f67hvPgE5BZIMgRE446NQCLOO0TrTEX+7+YqZPQBHbrTq3u6l5qo34hygd1rcn1lCWpWO6GQGE1BCJTgHfoLrC1ZhaNklIiMrjMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj0+gJLtntZkGJpgnIa8t9cEIDVZj1mAGmDvJLn5+xA=;
 b=KP5Q1in7JTkKcUYRg/5vR1Nr1ZESkt/nsYq6LZmOdscbS2vPfOBJyQeFqZm86Th3/nIzl9MQwrr5B+r8GMu599YK7W31cILfgBKbv0U/+R6l+R505hCpRKnKUk8A0dyM7ZWt5cuo4IkyA4v4oHEvRGUMQU9YJkAVTs31s/UAs9dqvZ1YzLwQigKgrem3O1SgpkvF7dZjTNk/hzZbSMf905P47eqA0VJ4onCGuE49lUd+zchhbUflVOT5SQkvM1L9zCBFw+6H+q+KL/UziH2pONvzypRz0eOJE6u+rPkCag6pyKh+76hGuOfQbSnKnIO9/SiyKCX62shVMY2e3sXDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB7025.eurprd04.prod.outlook.com (2603:10a6:208:19c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 09:20:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 09:20:07 +0000
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
Subject: [PATCH net] net: enetc: fix wrong TPID registers and remove dead branch
Date: Fri, 30 May 2025 17:00:12 +0800
Message-Id: <20250530090012.3989060-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM0PR04MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae6de35-7969-430f-2351-08dd9f5b2b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EqlojVJ8ulOXi9TxjxwmDjFqAB09Mj71RSUKN/7kkIMzrOz5Fg6XczySsLbz?=
 =?us-ascii?Q?ztWej0/eGLzGN0ULsBxOXAHJF0yu9uD05ExckA2DaueR9ePd7rMGEUmK8OZt?=
 =?us-ascii?Q?SeyMzGtmR2Q3xgpgbAZdcqahFU5oZ117rAWFf82hvQ3+x4fKW58RkJky5JYv?=
 =?us-ascii?Q?JcjfLqMpEJUX0SDaREELndCSTYJtCaDOoH3cp4z1SnALRARqLoJrFhRz3o63?=
 =?us-ascii?Q?p8EvY+H751oiNbMYxTsd0wC2HFnBBGGrtbBthtXoxao6TY6BbZPRvNDzTDkr?=
 =?us-ascii?Q?3N1mQB/MQWTd0L72sSnUH8GppSrajeboZMdBUYKra5o6zqR2FgfJkVXxk1en?=
 =?us-ascii?Q?flQorrrAt/wN4ebPR2oZD46NRt18mzHaUkFumc0Tu8yVDOIjI9dSUjOLSqnZ?=
 =?us-ascii?Q?xjjSvyefcY5eBfq7FwWqshJbuTZ4FiJq/6ptMR23L8sRUjL9MmZQu+Xqb+ER?=
 =?us-ascii?Q?qgOYw5mwuNlanHSraoycJn2r1/W3IPHlNj7Z9yfaIuELOEvyJMflJC3TzphE?=
 =?us-ascii?Q?slW9Qir4griSyJMlnGPkrpeF1jwZtZ+7x1fIDfd6uejdsIaJigGBFIjGtk5j?=
 =?us-ascii?Q?Nxib176Y9sht41FaKQg0HL5UC2SeLnQj7wA69Wg5uBgm/b+RmjWV87uB9vB+?=
 =?us-ascii?Q?Ro4TSxYwaaJJihXovNsRPvCD8mlYi9PT0J8kAhg2ZMrqfW4f5SYR+U/J6Kto?=
 =?us-ascii?Q?kQ2HsNvEUomCCzs8OIpPCxjO8OgybR9xZ4YV8WnZOUxTDBmTfAOiJWopKnlz?=
 =?us-ascii?Q?DJsGBGW3lrPZWe3nlydm7UuoqC5VphyF3145DOnWTAzJiIqB4WdrauSxXVnf?=
 =?us-ascii?Q?3Z3BuKaJmdA1JfVvuhwYipyGCSL7zUHcHatYMuYmxZdpj0YfJGZZ7IiMdGSv?=
 =?us-ascii?Q?RnKjH21NdVKPFeJTdtwdUlHEcAmFsgauajwq/BATg2vHDSXxm3Dq8nKegcih?=
 =?us-ascii?Q?6zIFH2Uk/CB73tq+LP0d2iT1YjAUk+ukA09D1oyl0CCcnAZBcD8/e59Xq53Z?=
 =?us-ascii?Q?Y7yZdnBXkfxJbLPNvufkoQsFTtXt0B3nBtUsZYnZeb79sDcqQDCxZs3mHXbo?=
 =?us-ascii?Q?inMPm9svnLAPycgMtFUwyyMMxk34EjBknLEe3AZurp51FYarnrx8GczhwhZ5?=
 =?us-ascii?Q?3JgnYGWzqvopxeqc3+dTTGbtdaBZmns8DHd7kjZ6JJPBNvyCvynwWAfn9/ea?=
 =?us-ascii?Q?PaEb4VNZfNm9NQ92sLh7k6fVGo4BjzaK8UPmj/8gfkJ2VcsnVVa8qVdBgo8c?=
 =?us-ascii?Q?8+IMuyxnbJaRCN0c3EzbB8E4WQXkg2dFHAbPb4HJmATPENkYhY3EZpTR8FmA?=
 =?us-ascii?Q?XrOkuc1dsdtjH1M0M1j2PGjyBIAafKZY4t1kKsZ7yefhqImGGJk4FAOkLMj4?=
 =?us-ascii?Q?pg8OPSaLzZepZKgvZYXMF/AfwSe0LdWjbHdcFT+j4/rutAEgQADYppZtPJcQ?=
 =?us-ascii?Q?LXrJlNtemG3AUakikmrLXpihT5ATIH8ZD4Dc9UZvQk8p1y/N0VPBtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EzUFr7UR7tkIbMYsMj0eLDJeRr9B6f2nED7//gVzoi/iLeGSq7FbhMM5rD2x?=
 =?us-ascii?Q?97lIqjE+7YnVEdedXng1XM+GDh5+L9/nm5lk0YuhTZLy3jKhSA/8gwqJf5oP?=
 =?us-ascii?Q?nnbmEQPZjWTA/tUCPoFBwW2Er6NAfB6RG8YIjYvC07l9gFmqIqnDuHsloHfM?=
 =?us-ascii?Q?3phbC0nNDuwy8danL93F+K4CAUwWDsSJ1yYfSwVM4LrsXdTHZITGNnrnqgaG?=
 =?us-ascii?Q?5/P7DJ+n1pL0/olR9QugTJ+mPHHwW8V2Ew5DdK/HgRIQ8PRNRB5xUZixOlDP?=
 =?us-ascii?Q?26nQiUvSp0GHLSMQScWeAIUdW6ASTn7ZqbDAHxmlcvKwFS3AFqIM3ImXPduM?=
 =?us-ascii?Q?5/05Ejcuw+OYJbqDCipDg70xVWLSaHyuJ+0fFtQMKPZhaZNd07+MThb75xE3?=
 =?us-ascii?Q?qQzu1hFSvzqQZB0Zi4vi1wK75hFPMSsnyfikCp0Muc6N5z0FLSn2I88HkHy4?=
 =?us-ascii?Q?oJoGSEkGJpBMH/txQFZHEmsmtWmrvaB9hgy9hv0jZnKZDZXxI7/R5dujjEXo?=
 =?us-ascii?Q?3oLDMp33sj8al1FhoTJEzbfQEf7K1X0C/dQLvp0Qr0LoecBYrHESwjq525Of?=
 =?us-ascii?Q?nmlb6/PKpN/jzHN03ooecvV0SIAn5xOsrXdu8YPclNVdfwR8EomXFQ5H1SGi?=
 =?us-ascii?Q?wvlXd795yYbtIluPSSgFIv/mJ3Xj8htWMn+JAcZKzePlAWAWlDbZrigdL8hB?=
 =?us-ascii?Q?FJ74TCrv4uq0Itu5793ILdzAXt2N5M2ognZvSYwPlUyC29tvo83oX4Er7WFL?=
 =?us-ascii?Q?4iWDLpfQdE6IjOkB2wnFwwsSjpknnDWmwClgwqueUdlDQTOJRpsO8dxcbiGQ?=
 =?us-ascii?Q?by334sycYRidhruauUfHdhkRpTH9N3TArPDu44Xjiedv2Nx06xHPfLa/ud9y?=
 =?us-ascii?Q?E+0tDuyqlRAaaDod6nbrOJeL14pZhXEbX2NFItg8sa0L+6WkjxxOEtNSLaD9?=
 =?us-ascii?Q?MpsFIki0+qsn9YTphwOsWgGsa/bZqHtjJcv5ivGifEnqCaERNBeEoyQhifiO?=
 =?us-ascii?Q?u3XD76fyML2bGd8EiLiGhFq+/Bmpdt2jqoFf7jB4ljRP+FHy2GlQuB4/LuNg?=
 =?us-ascii?Q?ZM5dnWTrVzPMTn9kil3IhQzmJK9J6sBko7T5TBpT2AzVTVV5td3topykvh22?=
 =?us-ascii?Q?vT+CX5ehZezp1p/nv/arFzTposIgJvE/eLM/pUm559gEhVEGyVbmrujqoGrH?=
 =?us-ascii?Q?6suv8TXSj2iWcvUUhz4ZHs0VHFOhSXYtZRmV9V0ZQZL3RZs3qMfhzdmQL+0F?=
 =?us-ascii?Q?Knijk5Mk3qY5LXrs4AOpmDx4nofC1SFZkQyLQuxfcTtLr4FITbbaYxw8nY7I?=
 =?us-ascii?Q?Nu7VWD42Va7cIAyWbMVv0cBsqAq9SLCfvprCkEPIqD9Egg1Q8X27XK+fDhEF?=
 =?us-ascii?Q?c+lIkpChLOy6riUoeEcWs9aSFgoeLawvnJjcL8I5GANo3U98T/cwpuM87dkw?=
 =?us-ascii?Q?UroY3Ze+lVYx/cewCAvGWBoGciljZdrzVvS/AXfIUbttVOwdbVz7CMOHyrMs?=
 =?us-ascii?Q?y+Oc6D7of0QWeSyCBV7NXm0/FMNn5lwMgxj4dql7mMKYImWg6T4IVCDeuxb3?=
 =?us-ascii?Q?evim4xeoZrBfYXiz+W03U/CLwOdc60vzEgt2ARJA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae6de35-7969-430f-2351-08dd9f5b2b74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:20:07.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aReHm70IqWTOxSaOgKt30IhCY2rbbO4rZWshNtQ2oP/9XhBF6SxfXQddnBhK7NMcZWNw7IRwnDzFT1T8Yw8Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7025

Both PF and VF have rx-vlan-offload enabled, however, the PCVLANR1/2
registers are resources controlled by PF, so VF cannot access these
two registers. Fortunately, the hardware provides SICVLANR1/2 registers
for each SI to reflect the value of PCVLANR1/2 registers. Therefore,
use SICVLANR1/2 instead of PCVLANR1/2.

In addition, since ENETC_RXBD_FLAG_TPID is defined as GENMASK(1, 0),
the possible values are only 0, 1, 2, 3, so the default branch will
never be true, so remove the default branch.

Fixes: 827b6fd04651 ("net: enetc: fix incorrect TPID when receiving 802.1ad tagged packets")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c    | 12 +++++-------
 drivers/net/ethernet/freescale/enetc/enetc_hw.h |  5 +++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index dcc3fbac3481..e4287725832e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1375,6 +1375,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
+		struct enetc_hw *hw = &priv->si->hw;
 		__be16 tpid = 0;
 
 		switch (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_TPID) {
@@ -1385,15 +1386,12 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 			tpid = htons(ETH_P_8021AD);
 			break;
 		case 2:
-			tpid = htons(enetc_port_rd(&priv->si->hw,
-						   ENETC_PCVLANR1));
+			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR1) &
+				     SICVLANR_ETYPE);
 			break;
 		case 3:
-			tpid = htons(enetc_port_rd(&priv->si->hw,
-						   ENETC_PCVLANR2));
-			break;
-		default:
-			break;
+			tpid = htons(enetc_rd_hot(hw, ENETC_SICVLANR2) &
+				     SICVLANR_ETYPE);
 		}
 
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4098f01479bc..0385aa66a391 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -43,6 +43,9 @@
 
 #define ENETC_SIPMAR0	0x80
 #define ENETC_SIPMAR1	0x84
+#define ENETC_SICVLANR1	0x90
+#define ENETC_SICVLANR2	0x94
+#define  SICVLANR_ETYPE	GENMASK(15, 0)
 
 /* VF-PF Message passing */
 #define ENETC_DEFAULT_MSG_SIZE	1024	/* and max size */
@@ -178,8 +181,6 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PSIPMAR0(n)	(0x0100 + (n) * 0x8) /* n = SI index */
 #define ENETC_PSIPMAR1(n)	(0x0104 + (n) * 0x8)
 #define ENETC_PVCLCTR		0x0208
-#define ENETC_PCVLANR1		0x0210
-#define ENETC_PCVLANR2		0x0214
 #define ENETC_VLAN_TYPE_C	BIT(0)
 #define ENETC_VLAN_TYPE_S	BIT(1)
 #define ENETC_PVCLCTR_OVTPIDL(bmp)	((bmp) & 0xff) /* VLAN_TYPE */
-- 
2.34.1


