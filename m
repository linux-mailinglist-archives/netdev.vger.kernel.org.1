Return-Path: <netdev+bounces-247648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44807CFCCAB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D443005E95
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103782E6CD2;
	Wed,  7 Jan 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRf5WAZQ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013050.outbound.protection.outlook.com [52.101.72.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC026ED5D;
	Wed,  7 Jan 2026 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777063; cv=fail; b=oP96HYAIWtTNt47a0mmWTqXamNxtnlZ2hAfW7ZfFPnpprOXBBBMlqOTlBXAJPbVrDe4DtLcmq+aZY3i6Mybeuy9BO25QD7Zk5ibE5mTGanDTaoRkw6hMcT+cFoJ0TbW/H7jjmXjbiDGazLL8y2sCwftOJ7ZH0oJVN7UsGWe8bjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777063; c=relaxed/simple;
	bh=J5jA+FP3W9slZVGCgP0XsvPLP2FQFVbUJOaXa5FTcfA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g9xNyC6M/Tn2/lIJ4QZFFuspsp6dpMtxdqK2b1VFC2gDTg69sIh8duv1IMmN0vJPsLybSrU9+m7hv1Xfx059G5hs0zZR8zVa+FSs3V9B1KMEMw/ToJDiZMcLYydSFzUb8YdAksH9Gtc3PKCiyh4VcDBfV9a+C/4Sa5bUOb53w+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRf5WAZQ; arc=fail smtp.client-ip=52.101.72.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx7fQP97c7mgNS2pmZj8dIN67u7Ttn7IBSKtwR463slCllPM1isMqS+0yYurcAq6VisKG3+3no42MoJpVcVbjaOzm4VM1pOChjAurYLPMMJMPgPM2H2KcQ+HS9Mfg5sDj91DuLJav/zrG29thX7RZAnCselM++w6e2DH3Z4Tx6/eb86QG+ayVsuD96AVPKObI1Vk87QlqTCPa+bQf/a+bPqrQJdZ76E3BCzvZQuLJG/cy4FN6S+iB/OBiSMlgPHZbAiQuu6paW8dln3bzQqmHDDxUYf0fZsDNx9HHnLeHHiv+xRXCseX+yAYlJAKC3Uo5o3UdLtMuT3Y87TCRN8lnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sr2l12JryNtEcmC/LFB7T5XFvRdvND9sHvVEvpmBU6U=;
 b=u14YepjT3QcvHCtLa4GCzr2H6FvoI1mDvObKD7u53Sdlt7ks9Y2Uo9u41FdHTtilJHNpn3uPLaGccgkp9ToxYtK0VLRKgL4JRQAU9BYQT93OACfNvWzjeMfvioo4BjGDzDZR0CBjljNJGOvk5G0j3cBdqieNAkXVOesz3MYUksmknkJENtFgCgsHH77XpIHeBy1ChmkhIe/Weai7YBIS/1ZwrxVB9GCiKE40wRC4xARPEqqXMAEjjDpdopFWw2c4gLt+YZuo7Ervlgqr3V/5gq87Gdw+J/cl4GjrurUta0oS6BBc+vwEB2g7I3Z+9QjYKWj1bJPX/AxHm/C7Now6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sr2l12JryNtEcmC/LFB7T5XFvRdvND9sHvVEvpmBU6U=;
 b=SRf5WAZQ1Yfkiorl/pSLY7hBbUEfbdkkoGMm8ED7uhkld4s+b9bp9OiMLUdST/IZ99kNUi+Jf0rOE0zysyrBUbBCcBUyeD8yrme6wcjHwA+4YP5eV9ki6VJ+OHqWM0yFt6+IZmR7XgfEXu8xUPTFsOe1zwHoRl5opKjtZjofgOx647UTZdCldqHpfsrNf08mt3a2SVC0/lAq01rOu6CkDKNU+oCGiQtcgSSYTqnHz6uWj4Wa4amXU+Cw3a+KP/ZfkMwAXtmnrSuGlVnd809hrNEIvsEBl/r5/ujbmr1oU4lgE8Ua1Uv0Hk4iAMWkdx5BNOjIU/kzp1Y85xnJyDkQBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8171.eurprd04.prod.outlook.com (2603:10a6:10:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:10:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9499.001; Wed, 7 Jan 2026
 09:10:57 +0000
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
Subject: [PATCH net] net: enetc: fix build warning when PAGE_SIZE is greater than 128K
Date: Wed,  7 Jan 2026 17:12:04 +0800
Message-Id: <20260107091204.1980222-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 0354459c-d1bd-40be-c920-08de4dccab24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7J8qTYiB/J8ifRbk0ySFsMacG9+zEhSj6ekamoGkdz/P3IJj4QW3+jjwlN6G?=
 =?us-ascii?Q?roDJsw6ZJXU0wmSRZa49kuBjQxMp0bPk9rM64ziFQt8HeBZqTvg6jlNZltoa?=
 =?us-ascii?Q?wl0WPb1xAYyl6gKhrL8PgdPRn0PymrcSh29eR8k5GlQZQFK3zuw2lxno3rFz?=
 =?us-ascii?Q?j/+rge7gOYG5xpY8E81Qo6SV5DJ6WTeXmLxrqJKndfpsxxBrJgmAIrhOYufn?=
 =?us-ascii?Q?yJHg9rvjhMLE+WavmqyMFyAikQp1X+aXfq+79EV3Wyrj6NFQuWaIAfpRfrgf?=
 =?us-ascii?Q?vK+O1OYCO59H1aqQ0isQ7NNzLrPGf2o6QDCLgZ8tUA7fFWx5cLoU/JBf/hyk?=
 =?us-ascii?Q?mh3e1bvhCd+0/ykN6EW7iB/tbgo3MrG3cjjL7RfbAnFiKh2oM+z2SVhiLHdG?=
 =?us-ascii?Q?IaVXctwVxZqRcRw9vDaXl8sHqccwUYhARsvWg5NOuRPdTdQf4NyJjbzwe5E6?=
 =?us-ascii?Q?BHEknLaWJTJxi+MDnZQR80G5WEdVpdtLU4E3fZKPDVSrhKpltpgLIgqSRIix?=
 =?us-ascii?Q?NrvpOVOONeKqme/Si8x1PIKODop51apMpC/IcXot4aLCItJra6p2SxUpNXnJ?=
 =?us-ascii?Q?xuG4HZLusvgA9ks/P1qErHipX8+af0Pc2MGwex+UbJthbC1ULJQpEALa0edE?=
 =?us-ascii?Q?BWje9SvKQHlasVZKXyiV+o9s9yIbfSawlRLjvt+GmKemq7rq8skhsHI09FX6?=
 =?us-ascii?Q?RMvxZ04KiNxfg0ebKSpOGVFjAHIS1Md1d8Ty2qSuZj6bpdtUocxyjQOdYoY0?=
 =?us-ascii?Q?zNQSJpQe9ALpDE/nTln5j3kSofEJy2qS7RcZYcUzgzyIkKcFamcq8slcUFGn?=
 =?us-ascii?Q?6S2g2Hr0vCzoHrHStJvZRADXkwsjxUlJT1DHCOU8g+C5v8w863wgvuALSDYV?=
 =?us-ascii?Q?l6gWhjWUqVHEQ6u+Kt/cUhnkLKfyM16ShGBf+sTWAodzZgL80DdA6TodxU37?=
 =?us-ascii?Q?GU3r3wbk2JkjwlYnnQ5D78dKz7yUuiIlRUUIf2dP5F7Bz6w9P+6D7iPgL6WL?=
 =?us-ascii?Q?inH/cJf6yu79IDUOKHbV38SqGYtZu2J23tYRLzOtb84B2FL1TdJbbjz4JrRZ?=
 =?us-ascii?Q?IyQe5xWoq2IiUAkgXb9iDfd32X/OTTCExXb2wT/krJKPNfAa+RsSdM2fo3aY?=
 =?us-ascii?Q?/8XKLHws6boWADjH/blyHYvEoLM8uNRr7tKRIzOtDRUXsLTjbWyxPOas3mqQ?=
 =?us-ascii?Q?/Uf0L+Bs/1evJzSgdsMRU37r3QMpb7o62/butKIX2XxuRvSHYEBvpdm/htFw?=
 =?us-ascii?Q?3q727wZbRfYWCuoUvGo+eih7fZqAK+Fm2Jr9kXlkiJ1mQeIsYBCwZLu0fsQO?=
 =?us-ascii?Q?XkP1kcyTX8t3vLcxnQ/Z8zN3WTcFk9ogoktfjB/Ok3aazPBPAv0V9d3dzXie?=
 =?us-ascii?Q?VmEXWsvsH1avISeR6UiSnttRLtowJw+v9DrHR9UeP3OfF6rl3pN1Apfqyb18?=
 =?us-ascii?Q?StWASR4qpxVdRFdKfbTFqiqsT0tlwMcaKS5bSLZDuUrNyDOxIYWAMG9fYKn3?=
 =?us-ascii?Q?SwxviXCcMtofPjkCB8NIEdp9HngkXrJtsN+B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X23ZEXWmGNZOnU3DoCwmI6qmNuGw7ylRe42+woHJxH4ht2C/jUgoaoNeOzPs?=
 =?us-ascii?Q?7B6GJ6zXTn7a1cpazTvksfdf5V9ITWQ0Rz/u96jQUqe9LwMT8mxnOgQZlUYn?=
 =?us-ascii?Q?+MDf7YVcKE17bQJ4R6hWWvIFFlwSgbTuncCxPsXMCy8+qsqiu0KGKzCkKpTn?=
 =?us-ascii?Q?BdeYvcyD28dw5s1Qt4gruJ16H57GQeWBI4uXiWkM8+npOADmd9VpPQsL0dlF?=
 =?us-ascii?Q?a9mxdoWx/yYm5F+VWTJ8s8zzN1P1syKAq97fjzkM5oxGYusMkH/5oayLSPeO?=
 =?us-ascii?Q?GJWPY60MRBnvN4a8BsdMQWzLKb61k/EJUewBVpHEPil69adPh7RhHXmW+5cZ?=
 =?us-ascii?Q?KIVo30fVuvuw5nV2XnnOHYjspCBZvHStWfBXcXHF+FUn3Pflmfxr3CgzCTNo?=
 =?us-ascii?Q?90gpUpMzvZplNM/O7bDHpLsdfkNi5TBAdk4AQfLC+L8ESBiuYXohqGk+9ojL?=
 =?us-ascii?Q?wYlq3tw/oIy+SAJ6Q39U7XB7podk53KIGVpE/oAffjVVg5xiN/k0JU6FyV1X?=
 =?us-ascii?Q?7AsBcdrng+OBjI8kXKtS1S6HX/T3gaaC15iINIyb/DzqyrwLw9w1PY4BwV3b?=
 =?us-ascii?Q?5JS2hgH1SfUNN6pHdiPYFl7/jWCixwKlyp2DDOsvCYSqmCBBR9rdcVwE27GO?=
 =?us-ascii?Q?HqcVwxDAHtUe6sG7WhUfVoLhH0Xpzvv8sOXCHNmRQ9WdiuLY3A0Bc+LY/nyZ?=
 =?us-ascii?Q?mkS3NBVWLGuFaiOV/Dz6SPot+yIswXSKWJPtYeq75X3TsbMYPjcLq24JrKy2?=
 =?us-ascii?Q?/8VRlKUhgAsqfWmHHjxr7IE7A+CWm1+rfZ26ssZmrW+dE3EpJX53PeWMr+Ps?=
 =?us-ascii?Q?43f+DxuLfVsjMCL3Q4CeOHnhuZPUXr8lCwCo1M1gpW8PuSuzIes3zMavLxE3?=
 =?us-ascii?Q?mWnD1HFZNkLfzJlho7piNNzcqm0gSUi+1fPcCUF7lpIvVCjF7V655eWcPMFB?=
 =?us-ascii?Q?vcWb5vAK5teR376rPQt4F+ya/FU8RISCiT2iXvDGxSd1zbpL9AqZ3nVIe+iC?=
 =?us-ascii?Q?J8mLFry5/4B0hih5QCNg98qEhFoZQYa2a1uxpN1Flxe5QlT8tglxaOISDcGH?=
 =?us-ascii?Q?likqQa0W5sk9dlcsfe9SnkXryKpLimCPt36CTkgqyD+TCI1Z2DANb+iJHy9z?=
 =?us-ascii?Q?REJuCfL49UHqt7Z0fx4HisgxQ9C1XatLkc1Jk4xwjXNL/3Y+We42XCFv7t9D?=
 =?us-ascii?Q?urb2s+uvo9tK00FsPxk3f1uIPqTQCN8w6NYspSF3shtHmTSaUXtc8T13wxYb?=
 =?us-ascii?Q?V4CmCFGhnDrslMAZYNfi9Bwucn2ddtiAYe1JOFPnnC8SgU/AlYKMTKlRqXYq?=
 =?us-ascii?Q?sPM/u+l6wavCp0W9SbQffaX6LBNFyD+utzZxNe1nmSvelVDIEtZFGGOF4VUb?=
 =?us-ascii?Q?aJtYVRY2C0XWbmIcbtxsYXQ07OdMEQSMYBZtZrtdZYLPFT69neVcjvDGIlqf?=
 =?us-ascii?Q?yR3DXDi82XtV/ngRwrlGMk5UrS2h5fZ+Gg3yo4ykAUX5VKGG6YydkmjnoUNd?=
 =?us-ascii?Q?2hpQM/cBIgB7JUM0uWC/AHYVIua6paeB2BOpDUZF3w2EHnyt+ryAcjVAy/Hv?=
 =?us-ascii?Q?8UwRFCiVw3nv+s3QggwiFjVXRZ7QEYO4dqh3ECj2l5rvsDzD9QTeqztpk7Gd?=
 =?us-ascii?Q?v1+SrDRHzO7KcH4tmHinMKZJMfNSJ0Fb67+BKdjtOe/J64R4AsVzvwZ3XqQ5?=
 =?us-ascii?Q?UM5jtX7Zc73iKnM1ZDEAvxhv603Zb4bkPSEl9XAtooObUaW7XWHlr+E8A9Fb?=
 =?us-ascii?Q?+Npf60AaUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0354459c-d1bd-40be-c920-08de4dccab24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:10:57.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYysatsz9tGPcO1SiWPsbG5NeqitKM4hVXN7SNxnbNDvpJqzCLj08V46ijsZKOrPRvPHUVcEnSI3WahgY2RvUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8171

The max buffer size of ENETC RX BD is 0xFFFF bytes, so if the PAGE_SIZE
is greater than 128K, ENETC_RXB_DMA_SIZE and ENETC_RXB_DMA_SIZE_XDP will
be greater than 0xFFFF, thus causing a build warning.

This will not cause any practical issues because ENETC is currently only
used on the ARM64 platform, and the max PAGE_SIZE is 64K. So this patch
is only for fixing the build warning that occurs when compiling ENETC
drivers for other platforms.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601050637.kHEKKOG7-lkp@intel.com/
Fixes: e59bc32df2e9 ("net: enetc: correct the value of ENETC_RXB_TRUESIZE")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index dce27bd67a7d..aecd40aeef9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -79,9 +79,9 @@ struct enetc_lso_t {
 #define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
-	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
+	min(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD, 0xffff)
 #define ENETC_RXB_DMA_SIZE_XDP	\
-	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - XDP_PACKET_HEADROOM)
+	min(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - XDP_PACKET_HEADROOM, 0xffff)
 
 struct enetc_rx_swbd {
 	dma_addr_t dma;
-- 
2.34.1


