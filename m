Return-Path: <netdev+bounces-225899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A3B98F88
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F9D3A6A0A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD42BD00C;
	Wed, 24 Sep 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hz+az0lI"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0243FC2;
	Wed, 24 Sep 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703797; cv=fail; b=JL564hQwnDB9V0uRzQa4zyiborwb/nx/BYBOy7B1AX6pmDTP77sDkOqXP5Eq8yZYpA6SaHi0nLy/mISzUwMumayqorNdjmzZGjRvx2iRLFcFAPj+K44MfmzD1uvzGCVoQLCj6R0Mw3ozpAzTxIEdWz6AEg5FD2iiszLzpbsc4qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703797; c=relaxed/simple;
	bh=ZNcHH8hLu1+EEr5O9E9bZ20hcDF8cg63SiPg2QLOOAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pUxSnJu+AH080cC3vYp7P1XXEsEP07o/ox6cDRpM+jNoTj/hUofOYOcZcIL1SorsuFMgcz201+UfL3Kj235hh23XMQixl7gGCxDtVv7X6JDEtElurhVQJCPz/ERYdJjW79F1DzZUPU0AXAnpuhTQJToCEt6KND8qePw+hnMf49k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hz+az0lI; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoJ2efQrOs1H4SJkB/vOmE0w+EsQH0uMtwqiIkz/w2XdTruY1LC4dL6NtQgFQUqEEJW8nabmJCQeJZY+fVGYNbafyaOPF44gg4qMVEdY+hihVBZOxthbotOcejvieGUcmEKhXy+f8d0t5+mb0Pm4OMc8rslAk+zH3GrbgcSL+4iBfaMeJ243j9j76kSIQjHwUdvOYRDacqDnNWcLo1NAIO8WxPNrlxrbElbLnUxpX3lFx2igQAoAhE8lRG+YZBVlZpsdesxEgotDVUxMrPhKTdbo6RctwIeEe1QDPBZieIZTG3PgCqSjbqI2ZFSKQhCMuSAyIa6Xe3Esss7RTRt95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIsZmLiqxnOpzIgBYGT6+CiO8Cn8NCckEcPmnfHuYAI=;
 b=yxpWr3VJd57Eh2WvQimaTIr0V54HyPAQ3nUg5VitBRIsQUx8M1/7g+ehQm5z5H6Cs5Y6OUnOCfhGiCV4giG6LydiGm5/hGusKX0cwqjb5022pi24CRQrWl4BckXCYGTwygroWNvF2NtQszoxhqHIkofsfsfpvQpXs80JzNOq7e334gqfVSPv6HRfwkDR/c3xaXS4gsftFbBdmWNMt9wG6hNp/uJTyl8d6qIfGSwWZlk5ZR/OLDUwZb/rdqEAzTXfONYn3qHGvRbWysvffu4doUYrDRbclhvuvXJUYzEnXhOGCswbtAnVD1WnfVglz9ErqY+QwjTmVjGB9BhrxEUyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIsZmLiqxnOpzIgBYGT6+CiO8Cn8NCckEcPmnfHuYAI=;
 b=hz+az0lISzKoPxHjNxcM5T7vCuGWB8UJ8laGLtf7YgxtHcEnaSAlTaPoXQr/V43zGPrWXEHZsiB3nNcnACNfnvSCKLLaO8lctaNUjl0iWwujDRC6RPbGF9N06sanUnLlz+DYYuuhukauXLZLpy4UjWyNnvEJAMw254yc9ZJ22DCkfjoYmlgSq6m8YrKQ7wuuaq5kCRvmbaq5u/20B3a5/C/ZN0HShywMSwgFLfM2eR6Gc62Q5q+TFCzEy3rh02LWOKAI2/5v6TdKszxU9SRghE3w/FT2chVaC2xX7UTZDY30NNCIw9jrlwwlk0HK5QSCZRiGkti0umg0nXU/2qOG5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:49:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 08:49:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: enetc: Fix probing error message typo for the ENETCv4 PF driver
Date: Wed, 24 Sep 2025 16:27:55 +0800
Message-Id: <20250924082755.1984798-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: d69244e3-5e51-46c8-a573-08ddfb475353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yP3AGNyuwY+oVu4wqUvNB5MlTov99KMBMOuM5dBTiYtCR+H2kfGs/nkDM5PT?=
 =?us-ascii?Q?OCorZXJJxUX0KQreaoCEgKt2BQNUzVn5v0iCL/EhLgfAY0hTpYDv3DJm+phc?=
 =?us-ascii?Q?iIq4qIr/fg69Icrz35k38pGBl1T16+hqwrPerOwhd2vOcuY7O8udA5Y6r5MU?=
 =?us-ascii?Q?+wSdOiCCldTtnUDnrlhJ4WbA1XANWmPtAC6LnPIHSHFiGrwmxXKr3Gx1hlVd?=
 =?us-ascii?Q?P9vPF8Tlf5j7wnsIJWBByAyw/7APtSovIrSRcyQqDmCBtW1bF/utwohlihar?=
 =?us-ascii?Q?neJVANT83TEcEvWvE0aVAjoSCVYZCyCwqATvw+exotegVI3FJtEUjn2JROLJ?=
 =?us-ascii?Q?anzOr8wgUBjoM37GGMA7nWWyPz5HEraKkAB3shcz7YQ3Zm135PycRJmNnmpi?=
 =?us-ascii?Q?jPQ2Wm4FeKnW3c08UmXZ9Oa4sCxmu2qkCFIaTTgDkaGDgqle9RLNMKlo6zFB?=
 =?us-ascii?Q?7mgcj3SoYzsk38OQDw6Sm8oFWuncspjtigNo5ap+fk0Hw9lr8jBmZLz05TDB?=
 =?us-ascii?Q?YadPUf/TxoAbp6IS41SMGPc6K9I9Q0NBVljkC0MExAk9LFsNRWL4gTgIJOAV?=
 =?us-ascii?Q?XzZ41kNXe4AXwUVa4xEgcon9DzZu+7YOJxZwH2pMU8sf3x7IpFjMZRh450/W?=
 =?us-ascii?Q?Gtuzzwm9IIPpFO4DAGbf4izOEuf6ljKbhmQFyqi6OmT1PbHyApxR1y+q0kVd?=
 =?us-ascii?Q?nF8YMr/CEE4bCbsX9Rge9V3WZ6dGeP9jAUzSkUSy7aJThfo2q+wMOtLuWFw5?=
 =?us-ascii?Q?H7n3v8XyI6KpyEoukTo88vSvkIPjASKiojvlHPG2Ee2KP7TX58A/C7zcJfy1?=
 =?us-ascii?Q?Kp0L22rjgPo+7PoWFWW0c8Pu1CyZf5bk5lESZ+/HyP0Oxnmmxo4+vXpHjapl?=
 =?us-ascii?Q?qgirSSrvr1tkdCF0fNw7/2Au7MnS7y9a+Lju4LgscnGnvSdixcxhVp9+TBmi?=
 =?us-ascii?Q?6LIqcDRSIxqBB3Bk+nZT1Abes4n2iSkWS+WCUqbzRL1EIyxqpRDo+ls0jDcp?=
 =?us-ascii?Q?OJXsVuk451tFJh3Xeh1t7Cj9sTmjklc+GPtgvyM7Q4HkrgD/o++8cgpg79Yf?=
 =?us-ascii?Q?eIH3Fz0ws4zzWivH9BzlxKxxHp/zFdZCZPs0X/8B3P2NiO7P++lSFR4KBZ62?=
 =?us-ascii?Q?sZJtIL3LypQCbmOa45tKUwtSrGL8q+V6agUQbL4QX8LvKmrnKhNKtgMI1n9C?=
 =?us-ascii?Q?z104fSY/4qpv8K7OWwNiPVXBYGVpATMlE9m/5nQIeHfEvHwez+UvpAyvJmi6?=
 =?us-ascii?Q?bVJwS0Aes4bKheWMU965kMfu5RC7N4C7nF6QIXP+UzmcMAnv/qQlY4I/LhbF?=
 =?us-ascii?Q?xUVXWFlD2p+D4gDNvaC+8JZOsA+p9hAWu4sNkNaoAiEPM4zegxdsLOmr+Fj6?=
 =?us-ascii?Q?CtigO7V2x3vSU47NjVY+Kielh8dL/HBQkLhZl/Gl+iMor9donxTNRpKpNJh5?=
 =?us-ascii?Q?r0f+TcXSHu10xBgmxkvyAbNwWPHa6o5+1pzqRjnmeNxuULJ2D41rLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XZ8KRdRSgtbF7BpCJS6zW8n/s2XYye0X/s8JjCbDHaCwxKx0bwjBdqqpAeyT?=
 =?us-ascii?Q?VssYd+fhOFiAl2A3Li5QbR01byovyi0fbEpxNCieVMiR1s+O+54U+rMdgQT3?=
 =?us-ascii?Q?qFXo0FXuVRR1Qm/aphovJ4Sise3hvn+r20KjdSnF/yoSpalwYU7mo0mxgl5t?=
 =?us-ascii?Q?bb/5DS6bLRu1iXZBmz0rNN4XtrhqW4/7fd9K6JGr+r5Vv5j4fW7140dgq9OZ?=
 =?us-ascii?Q?qwjzs9MusjdDCI1FTx+VR51MJqYR+nt9+pJ8HJzbSAD7fuN5bBjNOpykL1Fc?=
 =?us-ascii?Q?OO5R7OIjpNLWwlBT7D97n6jghnBjRTCuWTpbudMIlKkg0YxZJKymNypAP9i/?=
 =?us-ascii?Q?c387XZtO99zb51BvAZQnAPxl/Wfkmh5cry/GdK1j4+31vS39FZFQS/qEkOIH?=
 =?us-ascii?Q?kBXHBjb24BWNuMMcGw6HNv/yjX5eefVFg9735rSDWEVkjmklMS+B7wjap6Wv?=
 =?us-ascii?Q?CUrwvJCwNCCOjqm8IQPKToQtbKlELJI3vw9l/gCMsiJ+BXBdYONRNDGCDDAt?=
 =?us-ascii?Q?RrBYsjrT9xCUXqgJ6CB1oJcA8bzXACLClA944AQz/NsjT18gmr2hKqZoRuWh?=
 =?us-ascii?Q?DKzuLAtConqkMOF6mazBeFuE5LbSqmw077zXYaFh2T82sW6a6n8Tncn6NsEv?=
 =?us-ascii?Q?yDXcj2SmBZCdYKdUoq/AF+4Lwm7+Q21cnlPwj3qAyN/FyX5zmVd4woUu2zye?=
 =?us-ascii?Q?qa69t9hsq/OzR+2O0oKJyYru0DjLbY4SnSKeRFbc5gp2XXQRlOiA1zvaqPLi?=
 =?us-ascii?Q?uKlvMbXPdFq135skH4BL85WL/nd5emfi2WozL55IlfnckElVUpAjkmHx5N2D?=
 =?us-ascii?Q?25e/4CftS8aeFrWHbOIhUWwIoNlHLxct609iLvTbKqB2bfgYjPhtdMZkpEr5?=
 =?us-ascii?Q?4XXtl2M8qnrB3kvK8w0pP2eAiTGae4yXBeayjHhbV+xGdxThLnDEv7hQ1vLh?=
 =?us-ascii?Q?Gsa2RZHwHBOYqwqqmU9/IuhOzH8FyWcrwfc4FExeNnDw/sftoR4oG/T0eSu9?=
 =?us-ascii?Q?bxsqo44NjJsICLRcwbis+B3lOtwmDtdUElooDcHo/6v5+g28nG6yWu+hiiYJ?=
 =?us-ascii?Q?20xLCHrbBCPjMcVmW7mOGzxdWcrAC9PDBL50kQT3zm8YUN69z+/w3aiCliCc?=
 =?us-ascii?Q?sKHMu0yauWts1BYB7D3WwyAdVbhUfFwuq4ynBS8365l4jPPdPhmr1XYgI0rG?=
 =?us-ascii?Q?zdPQWSnVqrb39wDMXxMb2/FSkuo49/dCfbY/0Zb5GyW8aR+9jzaNfcC9SqMS?=
 =?us-ascii?Q?MZ8OobFaLKYBpK/Zmzdsy1MFvvHFoSJMVl36TLaGF/wYpuIh6e8v3Axs3G69?=
 =?us-ascii?Q?obHfFUJa1IQL2NE9o2RoFagPHWdYiX9DZW/zeRmK5RMbGT32DWRFvMWvjggv?=
 =?us-ascii?Q?DE7zgp8xkiSZ3IiZPbP7Z/YkEghAQdegyFP7xo1xnfIRAqGtCIahfp4K/ZqU?=
 =?us-ascii?Q?PkWm6klb8aqk9nR61nKPrvMgEvb95RHtWIEJU0eMoIVK/lrOuyNgqenAoZul?=
 =?us-ascii?Q?Kc6CICuh2DX0E179jI/5ZCBZk6daQRTtcyTe1TtYh26DV7pKwDJaoa1sFl2u?=
 =?us-ascii?Q?DZnVtoru9s36Lz0m5ju9zZtGXPfDXq30s0Qo6i6y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69244e3-5e51-46c8-a573-08ddfb475353
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:49:52.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDGbhrBAdVg4Xd4UcUXqDcS/WKXzibOaK7SE7T5Iq1xeTXPlN1YyzSIjjEeCxNDhY5BFGrLdLqfA9JZdTRVCog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Blamed commit wrongly indicates VF error in case of PF probing error.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index b3dc1afeefd1..a5c1f1cef3b0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1030,7 +1030,7 @@ static int enetc4_pf_probe(struct pci_dev *pdev,
 	err = enetc_get_driver_data(si);
 	if (err)
 		return dev_err_probe(dev, err,
-				     "Could not get VF driver data\n");
+				     "Could not get PF driver data\n");
 
 	err = enetc4_pf_struct_init(si);
 	if (err)
-- 
2.34.1


