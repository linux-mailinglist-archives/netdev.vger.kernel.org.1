Return-Path: <netdev+bounces-242795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8AC94FE7
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4396D3444C8
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67421A447;
	Sun, 30 Nov 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FrfkD6iX"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8AC19C54E
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508656; cv=fail; b=Y3WTZ7aaFHBqWMJDS6WIvpWyjq1ZN0fOgD0EpqMpzPwnNefPPuUhe5F/87mzfQc1nmZ5CY5F+hrZLnUz0shVA/wPfM5F+lbBiAunnZQtku2auQXFteSvfC8pveO4hEVgt4KbLNioop0L4cKDmU+ULAfwQWHrNgAbFhqxWW8RyzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508656; c=relaxed/simple;
	bh=x8fYug4ulXyZSHLylE3Rjf+BREWFjdDiXpiMOdXB9CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cq6CEdn5sFjdUUUJCr+eQrsJihEU6tLXZJAlMU0tHingBlhmHxCaNhoj+Pemct5+WItwdIsGSIwC6ASRy7RvCOk0/vIFKd1lurSjHZn/4SUulZ/oWV595sl4oDe4PgtHeFwleQruB5vQtK82Mu6M9zCV11bCURz79v7zHdrInMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FrfkD6iX; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K001n5v7a0lWcvGB60AsPuFismA9MdjVG84m9EkpF11UpleC2FTX6fbK9VRg+v3EfVEE4jKVymtBtwxzonmvTqEnhnbkC2fHpZ22EQJy5Ojr4r0oMtokTvsRNbp7KNNBKZso1+msFhk6/vcrfZjvSAIXASK57qmePc2ImSt+VhA0uXLiTDf2/h7lnH0EEckk3P5ptBl1t6K3r/WEnDNA1YD6r0XSs0epfb+aPp+pzcCm/pYHVa3Bb2prG/pK17iVdKcESSYvFQ6+e2eSlX1akmH2B+3BO+KbJhu4g3HPbCjYzt/22QWyZf1FMzwaxgUvssxLVftHrSDHu/v1qiCAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcZuRvI1zyfhgVbAvzRfpE6QTFo+AEaPtWVeKNO88yE=;
 b=ThhKfxlghxnjvIX5cd4GjzF09skjPa07T0imrrybt7UPadzg/uszAirz+/tfvCc2iX6lJt1Wi5sVQjQCDz+g1+xw4lya3BhTwW2n++ChYHVWKFTCAlJOgxMgi906XOxQlI5qh1H9fsZfV7zzyRpp9c3R1wVjT6Yp0Vh0fAA8MEVbx202111NN6/9I8eQVM+Cm6TLj11d7tawfNuEvVAOeFV0PsgoM3fz6OecLrhdbE1tDsihzKORfR0T2kX1WVxj6b/gXvRzeauq/cugswT1ScCXFVvS1RE0L2k9UKt9Wgl0TrQkTHAKDOYBlFovDH9b6U3DtaD+BQsqsU2pxA1Ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcZuRvI1zyfhgVbAvzRfpE6QTFo+AEaPtWVeKNO88yE=;
 b=FrfkD6iX4kbDgyV3AyhX4T4xm/w9p4xZ9QDpxqSszY14Ml1NgDzF89eHZPpMOS3i9kaAldH3/zQ0V+easD+2Xh7Rpje8/NBoIeO+loyxqL7lAYZImF6lB6tm0AexAbqzRKFshQ33l5wGAa7Tjd+1ArxsO7c6bBz9fhHVy+hUj2m3gkUCl4SVx2Oz/auBCoY4odUSaemHhmW8qFjh2t5Yh2FJcUzPwOh3Uq70HWfv/qFUR1z1jclS3V2iASkxBM7fQ3SN8tMDHcWI2vCGRGnrdMMIX5M8VbRt5IR+MpUaMcH5ARxMW+GnJXCm3+hdohPW7/rx0oY0/JwUvd1G8WZYRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 01/15] net: dsa: mt7530: unexport mt7530_switch_ops
Date: Sun, 30 Nov 2025 15:16:43 +0200
Message-Id: <20251130131657.65080-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: d3368bdc-1236-4bff-ef8c-08de3012d0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uYrMk7R6h1ensXMz/tsrd8iCZG9JJ1RNJgPZSGHZs8RdZ71/5aMkwWcFUCAD?=
 =?us-ascii?Q?eJz1l25Uf+5F5LGKKm7tJpczfVRmHlSxbW5FPS59eGpoEEgHz1c5jpbPN+WG?=
 =?us-ascii?Q?yk2FlJdU/iSU/aMEO2qIRbm6PqFChiTXJQH0PPPmTYyFh7O03MZA/JnMyHMh?=
 =?us-ascii?Q?6B27UQgP94rNrCvN7i7VjxJqX5xq1hukahmxpjPbVCYO9L0GxQ/FuTTcIyH0?=
 =?us-ascii?Q?I8SNxV+qSr89Mi44RsICdcuzr8rTM4685t/n5Ovn4M0Q0960YEEEGGPIg2HM?=
 =?us-ascii?Q?f5+J4crzazkzwxsbkRWArnfizSNuKXKL7AQUIzCoI7OlHIfqNbefZZ34VLoL?=
 =?us-ascii?Q?KrvIamLrhQ6Ow13W6jv48l3o4ufA/AI6gV3ijZTKmc77g2tAE95ktCKsFfVk?=
 =?us-ascii?Q?xvjUZtmzfxgDe+t2kYKCk2Soq+SaNAfAJyI95MMaBGdQUV5PDtXzuZfcxxxl?=
 =?us-ascii?Q?p+P0yUpWqR9qwqPbcXf/sAm/n2ZlqrqNqmJ6kjCIYud5EncNhJIcL6qj2PCO?=
 =?us-ascii?Q?7lzfYXq0SJYPKTHLNwG2ZVNoIakznTrT092rqopGvxMXUM91Vc2khIJbPi8B?=
 =?us-ascii?Q?Q5JCkdYoy7HhZHOCgTkGO/M/Q78v2UW8EEbipKlrE8D6iK8NkdwMQ5XgAUe/?=
 =?us-ascii?Q?CPo2f8RAw/7yZe9KygFryr2KV5I8uFZtiB8UUg2ufNpCq5CZUH0wuHOSLDxy?=
 =?us-ascii?Q?kgu3HZLJK//SvU4LwjTaz6kmD6bJUQHc6AWPxQdH4VfDgSNjnpx+UcGcK3Xy?=
 =?us-ascii?Q?BeIFpdacTu7vLQ/8KwXZqdPKlGlLNHrmZwh2IgKuCCyaGD+2ZMyttLGJevYA?=
 =?us-ascii?Q?0mqb9nsbHuMO58tGzpdjoKt66ec7KB360n4dCfwNGrDnT9SD6NwGvX7393Ci?=
 =?us-ascii?Q?M48XNQl+8mvxMMJ1AXut8Xmkek9SFlxDI/HxsF3ev8C560tzkBSV6gS+TrPG?=
 =?us-ascii?Q?Nag7HlYWckyYHhvmWP3ZhcMzVe5RYXL3ij70fsCETGJph9t/izmlcNJPfPzT?=
 =?us-ascii?Q?izDWPeOVwZYOC1/JJq5vpeI3woi1MPNYseLLEotf2MrI8FWHP2EDZBE07QAh?=
 =?us-ascii?Q?0mdiv9m/FLryDP2EPYPoa9tXfcRhpE8ttfnzfQn1/BRpLAlUsyPz2dbSkAxg?=
 =?us-ascii?Q?JfLSePvaI/hceXHIbNhQaemjDnoWMLSIos7P2rCU2YuAoU+JRZkjAK73MYT0?=
 =?us-ascii?Q?Bw4biDQ9MUATYh+lVW00WbRdCASGRIahDdltBOoyjlFAvHOhBGXX6tYcMUyk?=
 =?us-ascii?Q?H1rH5IRN/pjgIqVjQalw23bbVtQhNvhzGqZYMM6b7eAwhdqoSVRYtKy2cTC+?=
 =?us-ascii?Q?bnP2iN3JxapxfQyw2xOkxBhLlrQvS3B3F5bjV4AGH+sh7Ae4EDPIaUQ3xutB?=
 =?us-ascii?Q?zz0VUuVZ1rTDMrO+lufjhAdZWR1YQXgXiSrs/9bE/kx1Rn8u7J4Y7qRVMJr5?=
 =?us-ascii?Q?/zupzcz/Vqc14YmS7XF1eUo2QNFVL/xyWxjdjrkjaYS/ZTynYrBfhY4OvcDp?=
 =?us-ascii?Q?2MANgD98kzrwqEpSyWgrYfvtJ1cUNP8ADUF3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqGAu/elWdHxSoIgcDSvDlfW82QeDeH+ceqUKRbN8FcuyA38lcbjUXK3hMFx?=
 =?us-ascii?Q?zCPjRytxlMPeeI3J571gpDUatWTFM84XNLLGZT8m8aqmDqotB/1NBuMa8jHq?=
 =?us-ascii?Q?KZzw+rpwgWX/Pl/RlCmBPvb9kEj8i8AJE/bY6FhvltqKI8bMqiWbYh7PIRou?=
 =?us-ascii?Q?w0+J9r1k5WXhIKDrG9XER9cjt+67jc3WpiCiaMSEveADRiErN/tP5VFq/Iws?=
 =?us-ascii?Q?Doq8MTaEqJkQUoG5AYk9leY0q9ekY/ounnx8CflBax3PgqZQKM2PS2kyoSyc?=
 =?us-ascii?Q?PXkWIQfn8LOVx6Grlob0kbfw49Ie163UPiRVL7+xwlHfVP+4ObHzrCYS6T47?=
 =?us-ascii?Q?p6Nh9k84lJ8BOKhhwnWg1Nv2PKQWrmGwL4oRGnFjockDTraPF40IGgbi/wZj?=
 =?us-ascii?Q?izhqbRAHTTdVTvYCobDGqNF4twY7fs6f75oZxRkg3HuO2j8h6iXc+94SmekM?=
 =?us-ascii?Q?wCN/Gq55qrEV4KdxWqaLj1RW4rXVLrY6A//OGgdEZZxSjfuwyP3Ln4Ah/uny?=
 =?us-ascii?Q?y/F172mLMvx+HUXBK5o5OagcFFBNkdG6K7S7qYZzj5Z8dx5jCMa/emW/wTCV?=
 =?us-ascii?Q?hmy5pNzlZYqSU2eWHHfmR6jhPHDV3eR5/I6KJdSWWXxpnrxqpI6EKGjHcXoS?=
 =?us-ascii?Q?d7xDCEjCrKHryDDgewqcYpebPhInlbAh5b6OMJpF8A6G0EoyMfo2mTlJcL19?=
 =?us-ascii?Q?m49pKkmnEfth+1pqQg3QgVW/cbOeHQec+2y/NQwBm0NkGvwfv3gVI8vZui5F?=
 =?us-ascii?Q?tm+vCZGqASsMLcH8x8N/QK41M3Z0CMj2DjkaZ6OQTL8Aq6NDD1Lq7ibB3jCV?=
 =?us-ascii?Q?SAL5VvaiWMSannrPAjGCtsNdFAZ38uV8F2eH03FBrmzj2jTo6dqRiv92x7Pa?=
 =?us-ascii?Q?rjFh/SY4GVzbNxI/xswjbteG3C0uXy6Od17Eff3FhT8yBU2m5oaKz0s8kv+o?=
 =?us-ascii?Q?q+d39FhYrvrbdsoCWE+qpvJejPCNrD0bgAxnL72TB6L7aC9+kkTF0TihxEdD?=
 =?us-ascii?Q?VkSkmC03udkz7iEIwSAKaDaRhHcUH2v45myuBB1mVjxnzIdjDfeGd6z46G+2?=
 =?us-ascii?Q?3C2FXM2I+Ll933mr259tBb5r8uxTYvp52lmtKdtDRxtMoBBnedettdlGeCNl?=
 =?us-ascii?Q?t+lq6eRI7IhdZfN7+/91XD8BpJ1v6F4JepXC5QMAImvZ/5EZ4zTjwRvh1m1J?=
 =?us-ascii?Q?oG/FSBXIMdM3pcC8185SuUKE1bRvEN0w3gd8WVQR2CqFeOvF522gionmzyGx?=
 =?us-ascii?Q?uBDGDMVkDHmYQONjE02N/U6wWCTKLfoWIerX5cDloAx8DIROwEkYQ5L5VI7M?=
 =?us-ascii?Q?4M0dpRdp5iLh9XVmB7x5FbixUsEWljV4wwc6NbMbyh2Q02aC+cinv28vhKCl?=
 =?us-ascii?Q?BMP+EHcYGbGaFItjgAH4gXkzuToJT43lPWKLMJSqQNn2vWJvrXoaMlaOFNg/?=
 =?us-ascii?Q?hGNfdsfFMb32QakSt0TwCDaEVMH9YfG9m83C/PuJ4dcwATrjhMIwn5MaSNGX?=
 =?us-ascii?Q?yNcx9jvR+fn/R+3E3Xvd+IEMk1oPX4c/mz60regvUQG1e2R1q1/KeirTjDcI?=
 =?us-ascii?Q?KnmEyksrRBCJLp8pi5JGnZWKX3fhoHzFRGp7wWQJMbW85yGIxlZKdt68i1JI?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3368bdc-1236-4bff-ef8c-08de3012d0e2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:30.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1h0YTqQYRq2nGNzSv/jolV3ogswWLkx56WP6PXC6eCHDpmLSf/T8pkJXRNVvsl5ZyXC0mxqB2tQiNsNqAFk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

Commit cb675afcddbb ("net: dsa: mt7530: introduce separate MDIO driver")
exported mt7530_switch_ops for use from mt7530-mmio.c. Later in the
patch set, mt7530-mmio.c used mt7530_probe_common() to access the
mt7530_switch_ops still from mt7530.c - see commit 110c18bfed41 ("net:
dsa: mt7530: introduce driver for MT7988 built-in switch").

This proves that exporting mt7530_switch_ops was unnecessary, so
unexport it back.

Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mt7530.c | 3 +--
 drivers/net/dsa/mt7530.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 548b85befbf4..1acb57002014 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3254,7 +3254,7 @@ static int mt7988_setup(struct dsa_switch *ds)
 	return mt7531_setup_common(ds);
 }
 
-const struct dsa_switch_ops mt7530_switch_ops = {
+static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
 	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
@@ -3291,7 +3291,6 @@ const struct dsa_switch_ops mt7530_switch_ops = {
 	.conduit_state_change	= mt753x_conduit_state_change,
 	.port_setup_tc		= mt753x_setup_tc,
 };
-EXPORT_SYMBOL_GPL(mt7530_switch_ops);
 
 static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
 	.mac_select_pcs	= mt753x_phylink_mac_select_pcs,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 7e47cd9af256..3e0090bed298 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -939,7 +939,6 @@ static inline void INIT_MT7530_DUMMY_POLL(struct mt7530_dummy_poll *p,
 int mt7530_probe_common(struct mt7530_priv *priv);
 void mt7530_remove_common(struct mt7530_priv *priv);
 
-extern const struct dsa_switch_ops mt7530_switch_ops;
 extern const struct mt753x_info mt753x_table[];
 
 #endif /* __MT7530_H */
-- 
2.34.1


