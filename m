Return-Path: <netdev+bounces-153235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B9D9F7481
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945DF188ED72
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 06:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF56217704;
	Thu, 19 Dec 2024 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V8ODqOVJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D92163BC;
	Thu, 19 Dec 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588284; cv=fail; b=YUwTBW/eW6U7uM+GjEkx2HtL0v5aW7avq548BjUGFTa63tF/P27dxC5bPdUIDH8kU3n2t1NVFjOlcg3X/Y8bnwNeorZTpGIpY3SbDrb2G7tSi64N1j0eUv+BBP2T8JQ1WPgi3s28Rp5Y7ABI+XkoHElyM/+Yihik0JMWnosMlRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588284; c=relaxed/simple;
	bh=tY13rXws5W6leR03mO+Hff6gYei2uWpwK9E7fbZE3mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yr2IKHqDd0zHvsuDbC7rLFOY1hzlYTZgVr0kdEdPjwPdG02g3mHYkHmnDVRpj056WfzLHIAUpB01s+TGgCSHYuZ+6b9qYsye9eO8hIj6qXrFgNnOH10QnrEaiKZhOIZ/Ly1S3cVms8hfvnbIQwtzBVqn82Ql6yWpsYTmjfK1btY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V8ODqOVJ; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZzNT9T9to2IxHZ0zOb5JbLXs23r+xklaX6SX2kvB0RLrNvg1xq0tXgpgzJhQJIDkqjo03pAQbzcPjvHIXGUfZmM9SZ6dG8bqY+gkbWqQ9xO/3hJdnLBvCxnZd0BBO6M6IVYC9GbizF1lBFXDf/Ywv8os363ZDqdnfAWr/mC8cYTOTaLiG9I/paVx7UYnm4XckqERMjXNMeuBlA5uE2dgM791weECsQeVeoELwLpOHvJolzKSVzgSOAlkga6q5wCsRZuVSilWiN7vBlT5d7y/0zFkEnWM8ELlGaMPSW/A16i1Ux4iQuAM1xWeM+ITzSy2eQTLeOChaYgp+TXH9IS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B3XVxejMD+Wq83G3DeEObKdWQTI6LKYvjJgdjr0QPU=;
 b=qmN503RhaiZHMrU1lgviaTVH3xZTE7DuJ7cPoczp73SEAjGtPYsp5sgP7CBxz+uO9nHvYj43apsXRn/Yx+Hh4t6LLnjsYw9RmsRJcdOToXsyBlIYehJ9/OqxQf1lw4JvBbFnyZDmPdniuVNbb8IuZqKcMi0qQV/MTqFHNl9fRncmDQrEVm1V3oaPys8buLdkrfOwgGEj6KAzkayXcvMbp+NAQbRPIvntv4nXFnu4DNyDVTg28Zjf+VEJXFiQBb9pnzYXYGErmI+s4AamHyH9uXc9aQwC3AjTu5zfkVGs/9bGehLS2RmDMfVZepvODgn7bShDs1mkQk9WHmpLzQKr2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B3XVxejMD+Wq83G3DeEObKdWQTI6LKYvjJgdjr0QPU=;
 b=V8ODqOVJUT1MHzsXpzzWy36vmBfOQml7i8/r0icNSK1k1XR0enRhBclkamBVWE97qAd5DrvP4sX+d4O4XOXsPHcya0xwFvgb5D4pHCR0nnlmpZ73+qmKFXokcUrQhw2ajzAWdb+WPfUIOTO5OUhITv0e9qWMT99uetRMwqxSRJxmkLT+cvrbHNhKFXbgPl0egrDMqGyHFLyvwZIMMwyfZnRN0PaNYm/rGN3V2sAAVCAPL7Sm0OWWzP+7AfNW+Ury/dMsRVboaNe/kNOzg2DNkIgoWujmXbtKGUFB2cBJSHBN5cF9L/o8gvPTTo+mNQN7cCZ9pTVxD52HQB+84iGeVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10780.eurprd04.prod.outlook.com (2603:10a6:150:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Thu, 19 Dec
 2024 06:04:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 06:04:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v9 net-next 4/4] net: enetc: add UDP segmentation offload support
Date: Thu, 19 Dec 2024 13:47:55 +0800
Message-Id: <20241219054755.1615626-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219054755.1615626-1-wei.fang@nxp.com>
References: <20241219054755.1615626-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0107.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::7) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10780:EE_
X-MS-Office365-Filtering-Correlation-Id: b5605bbc-3482-46e2-f18c-08dd1ff30611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xlw/NcwHyWTonHjJKHu6dUdDsB/PalkSkcV7VEnyCO/VDNm7pJySP4zVeFqg?=
 =?us-ascii?Q?oAv7x3pZp0HztsGfK3yz33v4osc4rk+ieO9vxNecX6qfSTW77ULSnCDfyaKU?=
 =?us-ascii?Q?ne/srug5Vq7mWbdO6IU1DEtR+J9FMhQZ1KA7+JKActX/1DkKeKISxTwwgXrj?=
 =?us-ascii?Q?vM73fhxZM4CkjFvT89SgvguDUnlyhRhLitVbKJkTOpR9VXUgw0vVR9Yr2glV?=
 =?us-ascii?Q?Pc2fhzsGYQIG1TTaE7JxP6OqRvch1L+GD7ZEEf/zFkKUdhqXfQ1jN47vyFvP?=
 =?us-ascii?Q?GNdx7DsMww7vEv7chU/oEXw7TTYyAyVnJUj1wn5sT8mULkGaOXLA4KaDT6e8?=
 =?us-ascii?Q?Wfg6B242ke7I3YZtQdtne5Uef/avY/E2Z5BKbLXqTVBBk/BYL+Kr0QnjFvTl?=
 =?us-ascii?Q?DXr9LEr4jmBG5jx747TMB4Z2cd0LsTRt2MsAozm/cQJG1DSvWBYwFssrJNuH?=
 =?us-ascii?Q?1NBAQmozPO3k/RTRyNCg/i6kzgLUDX2hdijrP6EsSVCVZz1af8pbZD06blpc?=
 =?us-ascii?Q?FFmzmzzVym9Cw9MAC2+/1wYyuCL4dH7ouTUjxU6BOTC6l4EitffaAIuKja9v?=
 =?us-ascii?Q?P9Z5lBXTU/InYttJVK3pdRRIh0UOGeeEPw5RZYoC3c8jnxqoxTPXL8O7vw6R?=
 =?us-ascii?Q?MuPDMHUyXwcvK4SfKwQUFe34tA0YGzMmfQziRMQCM2u6EQErPS3TkCLW2ZFZ?=
 =?us-ascii?Q?OwlOnbNAkoo6gAF1fU+DohkHpDoQYjOlaDW+MfT+HPLziXj9emwS7HHXXv09?=
 =?us-ascii?Q?HQ/jbviyLcU/87DkTbTTqJnASWo9WD6Qw0GY6U9mzUTJIbgvqIOfY0lHjAaT?=
 =?us-ascii?Q?zK5rHCebZyvhBKz+aAxEHlKx8DVnb3qEDPvKcrhJmMhgmMknfmLZRhXH/leK?=
 =?us-ascii?Q?UIJiVeA7wLXpm2uhXR/wUNfhbwzHFRtn0NaQsgH72Rm1F6H3PU/mB5xAKwvD?=
 =?us-ascii?Q?VRwY3k1qh6QSp81YqBMwQWDmfgZGAUYFlYGLWXr0ff/63kA3UWeZcKoq6Sq2?=
 =?us-ascii?Q?p5Zt2GZxdj8mq0WnaVNuX/Iadm0fVAL0kLHl6NdFSTN7m4k2HT1AqCklgT4Q?=
 =?us-ascii?Q?jckXgWaXDfE1fk2G0H2uItVGtVoGtCCha6CtRAOUHMxTMXWOB6p7Pld37K5D?=
 =?us-ascii?Q?47T+0Qd43Ok14MjCfQE+0lvQ1RCAFHbc7qksD1KYk/bam3T3Xp6B/XkAIdCN?=
 =?us-ascii?Q?0WRqqsmd636Y86x1QQZraw24nTITtp3Wct6eL3gK/16F/2hD4KBe/jGT+zJ2?=
 =?us-ascii?Q?mjcdaA3v777TPhU/U67HiYQhg5FwcjZr4wJzbw7zJfrBIYMIMA0/SlldE0EB?=
 =?us-ascii?Q?wrw6pQXEDZ+0UtCmfXjf5g58oAx5OdKpiGcuWFvs4YXv5oaowRf3ffAES5Z6?=
 =?us-ascii?Q?bMCmeIgwdrw/PBxrm9onnrvPDKLZ52in9N8nUBpY4CNhYgDIGYaLBeUb6+BE?=
 =?us-ascii?Q?I9aEAUQMrKxfxFV/plccPHrkOfCWu60S2t5fRzRh844ZLP0n8GjdVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TmXJXSR8wHaS6p9Ehg93PZNDBpxa+jBrRmKDSVF3zYoBm6Cie1CvX4qH5UXV?=
 =?us-ascii?Q?qLmv9qHJyObamIsF9rRoQ9ltgVMuWQXiVKyfYSFe9lK9CY8ZeCFmO/8UOHLe?=
 =?us-ascii?Q?u2pX0tozN+JK0Fl7J0+R0BQB5GaZzS+I5gYiEFZXx8BiPYHV3X5VIE5hH9Q4?=
 =?us-ascii?Q?cDKQKeOkG8MT+TJZcRtV0O0jx2qVwWqSxYHH8tnngjOgmc9rPeuyOWgA9wWY?=
 =?us-ascii?Q?+EatNRAIXUGLCmqodfT8bVyxDU05UM8qltL1ppVxAWrEKIKgVNal68MyC7g9?=
 =?us-ascii?Q?aTcWdgbD/aVUWANZZ1sI5Q4vqrIrtqVZXWT/C4Zv3ExYYwPCvW0KG2RJ67V2?=
 =?us-ascii?Q?yM6PKsEx5ptWp1TzddAbcNbYyD+VYmo3II0NjLN7KY68pK5sRlf/g5gUgBcY?=
 =?us-ascii?Q?VchFDnICvboOceT9lXy1hWwYMcDSxAZZSPeEHVZAGV2n9HHUnAoPPU67JItk?=
 =?us-ascii?Q?Sjh/xwzWsopfAIf7uGnn5EPWNItgH6mdEfEPbA9HlOlW5GbclAabyBFqENW8?=
 =?us-ascii?Q?9v2lxzVoeMxZ4g3E5njGmvDF42rgWLwLMFgFSA9V8SzHpMDmN7nqCAhmJh1M?=
 =?us-ascii?Q?D3VphNPh0y8K/u/5HjgaBGfrh841UeRvcfZzCd0ZqQpTskGkoVvG0rjYS3J7?=
 =?us-ascii?Q?9jexS5k3ztb6dQY3hlxrxrwL4dKaHxpDwyUs3UfeSwTGJC/8oFR7dV86/VV6?=
 =?us-ascii?Q?0aQx8PAzomkLTGtpOtIc2yeleVUf5YVIX1Qus1aNyWtT4NZzqU9YSqwA5OqI?=
 =?us-ascii?Q?V333+MtMMg0Q5I8dYBQ4mntB3uBkKEFthNnFKZXsNdlIBSzIrY+JVHrQ0XmC?=
 =?us-ascii?Q?bWivDvL/P7UqUOp5GEu3Gc/V3xKvP7dxcIHOtixf6mqvTC1iqyQPKQEpTYi2?=
 =?us-ascii?Q?iSasgV0adzhF1Fz2TY/9+6xdxXu6DITNZqsItRpmb1Wlm3J8XWLWsIZF22rf?=
 =?us-ascii?Q?DN1QtB0MjGv1WYw8xdBVhMrNQwWQBtrylQIa4t1OJ/2wA7fCCdh8TQt1D5B1?=
 =?us-ascii?Q?oFmrv2FNVyqMAF2UMx5itb3pwK5WLWAK+x4fH6PsV08vgd/tErMVfdT5LZZ6?=
 =?us-ascii?Q?EKU76Y817jarm9r+dTFMjpRjyBweJARFKcSkzaAxYoK3Ijz+uY7UbOKTMHRO?=
 =?us-ascii?Q?tOaAZ8q2rwo/AH6ZQkf+zSrlXGPtTqTRpQd+MkGC6/zUFqmbnjR6rinCraV/?=
 =?us-ascii?Q?RWz/mFIeACo9xvYdHAtOmYiaDm017/OkzySh+nT474CLtfBC2jT7QCTivNC0?=
 =?us-ascii?Q?Pq1V+3nSpGFHyk/f0JsLxeVoEeD2zHexS7Vlui+GKf46zxTg+vRrhgVH8OhN?=
 =?us-ascii?Q?7rDn5B99Ro8o1RLKP+i0kWVP0W9HBZUaDjmbYzVy98Tb5v2hdsBN55I24VvY?=
 =?us-ascii?Q?jATdduUC1T5cLYf0CdenG9xAGvp5PnYcR+U87xyUcn9xOxOEtqNCRAaC/tFY?=
 =?us-ascii?Q?AwKE1T+WUHoo96MQb66KGQKsyzxn0xdKItnDjl9WvLKJvceHQg04SDmZbvHe?=
 =?us-ascii?Q?+UnVtceM+uKSbmVJet1dDJ5r5mHItvDBVwIxiG7ryxX1pXDl3GVR3UrQTVSl?=
 =?us-ascii?Q?AqGK6Gd77k4edkVCg+aBVD5oy/2NXUfhZSI33Wqu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5605bbc-3482-46e2-f18c-08dd1ff30611
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 06:04:39.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJseP9iLurcqgotQwjijxNEeKlR22nHACGDn6pONXAKLOqTFS1u1ck5W5ykDw/q552xtpd3lSfzelaYrWyrJCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10780

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmentation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: rephrase the commit message
v3: no changes
v4: fix typo in commit message
v5 ~ v9: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 31dedc665a16..3fd9b0727875 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 63d78b2b8670..3768752b6008 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -145,11 +145,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX |
 			    NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
 			 NETIF_F_HW_VLAN_CTAG_TX |
 			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			 NETIF_F_GSO_UDP_L4;
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
-- 
2.34.1


