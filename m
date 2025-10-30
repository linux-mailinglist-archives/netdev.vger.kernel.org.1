Return-Path: <netdev+bounces-234319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D3C1F565
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09E31890493
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37632345754;
	Thu, 30 Oct 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDbMxw4/"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D15340D81;
	Thu, 30 Oct 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817076; cv=fail; b=qYzHsfF9TYu5VS0T6HV62rqPuO+bDH3HxcmKX7QllqbYUZAK0d8Mk95sZjZScbgrw99FJOFD8x1nj67DKgTaIkjjFnyxz4HNvEaDQa2evKB0SkBzOcNOBaw09B9k+GgpDoq2rcF4lRmEUSvcUaKHUbtPmKGAZYaZvG3bn2eO/nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817076; c=relaxed/simple;
	bh=9f+owVOJB+fuu4/UJ23d7SrKdOjiONXau6Rr4/NSQM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bxtsgxwarh9t0Pjg5cFVvRZmlvoGODkA7fIROfxdHtFO+D6Y8um4LOj8e2EWrVySDnKMMJv5LY1dc+A/NQAGo3wMyspwC0W5s4q/bSFmsVUKoi7Ng1lbDjSBbTfV9j+emnwL0eKIkv5BIlm15shv52mQvsyP+Xcz+60MbSkbju8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDbMxw4/; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV7I1hY2TnJASe/19Myt9LlDj+roKyjLMnCkMIIYFcf080AWKCnwHp7dxDSKfxzZw/1Sv7j8pl9erwA/MHHujNonoYLBCIUobN5tQlDAvALrPUktEDqtrwiWmVZntMS1Dnxp7IEufIwVqurILwSAmZYcVeupYhlk2iaf2S7eZLcEv80LkgU3KkB2hSkbl4CCVrvfcsYuSAVHt7/BkeOaPTi0zB6dpKjETtvrw8lIvUXCCuer3XQTut3DbSDb5iC6zzvnhurPymLMbcg9jM8VAnYXRZt4sraztYp1EUz47Xlw36fRonalX1ndVTxyNBifOqqapI42WLTv8eONPtX4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgdYLHV8Mr87VwiQks1SY2FXK8Wf9A3pCie1pIrMKRU=;
 b=WvvJXNsjh2LQqdacuuqoEIaMNLceLH2XtPJ2kWwxq7Ofw5KyJPnaJHQxefZ52mSShJDoNm7U9PGgfPo+adMzOntkYWNbyyuuUSZq9tOBLbyboF3rYq0wFsYtTAZSzhCdawzKWhhsWRaHDd+8sL+aZosmlipslUBy0UnkGUtciJ+XKMb2EDdZL+CD74FXuB6ms/J4+RU88Zec8SS4ytxDVRYZYSIPpGkKyxWOQIIa6RiEbQNVOTTtCTiFn2NFahUCJIRx7K8r9uLueQnT80fy8ydB3vMLd3lTfUuMGPSFcxsNGfrvkLT85RPvLD/lPVOJJESMCwkK/JEpA4RMcOwuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgdYLHV8Mr87VwiQks1SY2FXK8Wf9A3pCie1pIrMKRU=;
 b=QDbMxw4/bm50ISx7iPpPcqmGnbwz+iDaYP2X8fNE38v8hUsT9NzERkSfTqMAhIAhERi7pzJDsNCEAjEQ42RwdyglzdYx2jpvIHSlplk6yfNEXEqAds2z4zep7A87+NtlK33oTIEZlwaU1gEnfS1H46AYyKg52yzJpFVyqNfuCV3qebb2jVUQlWW0V/irgyz2rTeRk+Weoc+fk1kgD/kHGJaRQAs0nkuO5mLWfqNgbAfBgTAcWbJHKHUqutw+H58zkvPNWzVL746XSi+SadSlzg9oC85bSjnpWYLYsFAdmFQW3Uw27FLt4BBfddybGLgLtg5PUsXuYlM/siHf7Sl1zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:37:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:37:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: aziz.sellami@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: enetc: set external MDIO PHY address for i.MX94 ENETC
Date: Thu, 30 Oct 2025 17:15:37 +0800
Message-Id: <20251030091538.581541-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030091538.581541-1-wei.fang@nxp.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c5b24b-5fa7-4e57-3660-08de1797fe89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bhNIro7s0lc6iEYaoerRQSL2B4IWGv6QO3tLM5z47qk3mpvdTkrN2vjRvFl6?=
 =?us-ascii?Q?IF7Usc2Lt1sh30uYUY2YDLv0t2tOnQzHBSLlr4lr6pKxFaD7vSPn34B05M/U?=
 =?us-ascii?Q?IjDIZ6D+uC9UPOA4nszoIO2jmDTPUa6Xpw7tBn8HOHoqAoJBee9YrK0eXqMD?=
 =?us-ascii?Q?pBkOFJH7PiklILh9lhbnDNru6axYLDo8zU1B+NgugpgNja9UqEuQNhoml4S2?=
 =?us-ascii?Q?47d7iUvSA4YN9xO+EGZgaHoJQk9Gvpc80ylTu1BniNgbM80e0mDxrbsr9WnM?=
 =?us-ascii?Q?LI+WsLc/+mD7EJelxOHB6d6QukCAkYDOEr07dKjdoNHuWU6+pLXTgaLmP+95?=
 =?us-ascii?Q?CwaTC9WB6VtloE70k1G5PcuX/vt1R/8j3V2Bv/IDAGv2J/hwyeeiIsF7H5lM?=
 =?us-ascii?Q?kQ0ut3yoGdyPtfb2UOMHwcbb9Awg6QMcISoTkDdGZDmEG0+LNhIdYiYUTj7e?=
 =?us-ascii?Q?ZMrSYVZL45XlqxMgHxncP2hITb6jv2cM7tmtDs42ui3p8u78EA/CKFRqy3cP?=
 =?us-ascii?Q?e/cdiqdSI3hyUcUn2R0BFlelgJoyM7xa9IHXnjDL5pJNE6BMKHcHgW3WLovP?=
 =?us-ascii?Q?xCz8riOgrbvEtYOS8FxGTl7+TzycSLkHNnVifio/wwTP6V8vfHndDPqPvcPK?=
 =?us-ascii?Q?lkuFbSxP+do5CxryQXj1WnWt4sd/2mEUzUuCkxqVjB8jbGeHWKmlVK4XZYeZ?=
 =?us-ascii?Q?svuk1E1PG6bTgxkGOCgGUDW4lD+zRbKtMI7IzYHs7XcWA65VtOZ96/3Vj1NN?=
 =?us-ascii?Q?M8x1C+dDrxLhNrf9kZiD9aiLS2NWzlIUEYLzKDvt8QkjphulHN0RN/YGhfs5?=
 =?us-ascii?Q?u6yMJe9Sk2tdIMfUMWi+rydYemhr0Vp57Xv3h8Ysc3GjfnF7YHGG8m7PoVnm?=
 =?us-ascii?Q?2DAe1f0id9AIcKCTUCtxxuF5f308Zbf2CKWsoAIoH/51iIEY+91mSg33SGKg?=
 =?us-ascii?Q?+MzoOlmFlF6Ei6K9sgOgR0PSBxvROAXyuf+V9t85zwzG6DkI8xkJeGyNbrLy?=
 =?us-ascii?Q?m9qCFoMrN7K4MmR1go2Fo6VbIR46+j1tR8uvLwNusZI68GKY4o123Zw/zaDA?=
 =?us-ascii?Q?fZqu7jRogAl8CfXyQob6ZMtep22CqjrNd0AbBYVQkzrqKCVNr1LQQpB6LoLn?=
 =?us-ascii?Q?/x9p4jmtpp5IbgwJAPTmoRluAsYtX4Blu0F/KrditFBuQVxNtHbmQZkwxaA6?=
 =?us-ascii?Q?dS95fZiFh9JObKBcVE8jwAiFC4r/922iSB5Rj2nQeHvmeMGWG+tBXCWQOX/I?=
 =?us-ascii?Q?nVRLS/5NJIgzQPYZe43nxEeW8DKpV6yrATpz3xbn0m6nlzwiVoqNXSurvjPd?=
 =?us-ascii?Q?HogFAhjhgGMT0E40kr3ievCItOV9pfLZUUO62pYBly2FhbgCiGysF0apPHIM?=
 =?us-ascii?Q?WZquLjHjTbEmb5mVA8G+wYEitAsuzzMtN3CvpOQ36ic7aJPyv2by1FmtoF1R?=
 =?us-ascii?Q?Pkxer33ZTF5/S3fNttiyAq4yQtHXKfFr7LPU12gHwm3v79UUOvn6tCV2E9Z5?=
 =?us-ascii?Q?e+8eBYcS/k6KJG0dIOv1NrZJReswBHKWyQH2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhDFm5iYSfAzZ9vg6la5X3NVm8P+DWS6Z6C+W8Umefp5+S7Aw7dACXod3u3j?=
 =?us-ascii?Q?0iyHvj8Wy1woc6RDVHVktzRUfZJjqI6QW6WSU6DJF9kLNxvF23JrHivaRLFI?=
 =?us-ascii?Q?wOqw5xXF1Tp07TrQ9E+qk1pE/fiuPyuny4QCDJo/PCW85QILpNF8eOiZvyuW?=
 =?us-ascii?Q?ZIQMm5h3HLhSp4bHeYgmA4J+PVNEk30UtapUXZautD9r02eqhVxjeWJZG1Wm?=
 =?us-ascii?Q?LonfdXKmmDnwfXt1Zb20IY+dZbFEYtCiMGKxEoafNUjK/hA/R7Y2Ld7fi8h5?=
 =?us-ascii?Q?GcUTf2iGpplPx6uZtIX27xx612fpKaoWR/AMu4f4Rsy4ts++crc+KJlLB0oX?=
 =?us-ascii?Q?cp2Xz7dEmoVMXpmw6bO+ZIlWNPuvHT9hpO0roGSGbk4Vd1PkibNm7lUMTTbf?=
 =?us-ascii?Q?K5JyUlvp4emyMmPwDeTev8GiFNgGbslCF4mtLxlwU3Ql8Py8Tw5sVU2+LSEm?=
 =?us-ascii?Q?fLoyrV+UR24z39fwx9QXogG4llq2W7FM1eeg3tcN+LbSBi53gR25mdS/E0uT?=
 =?us-ascii?Q?ovmeLjBs8+jbbQ2sWy0QkccVGA20+j2gkVX168EAetfNzdQbMyPgrlblM/k4?=
 =?us-ascii?Q?sLxttH2dGkE60AJAe5FTMHFoJMsVrWPJ1d9d41tvhPYMCtMRTCDrYlMhVeyu?=
 =?us-ascii?Q?hWPTfbOkN0Zle5BuVnzIj6tTeQRv2ZkInORHVgzwT/y84nSoVxR20o7YZKsp?=
 =?us-ascii?Q?jmgE210Rl4zJUgAVS4EccOSVDSQ38MKGs8zLDsUdlacPydxapO2EtSCISC/G?=
 =?us-ascii?Q?kMGNQQDAVy4EubYxI4WeODmg6Xh9KbeKXfpJV5uEaOl+e7/h9KinryNNczfk?=
 =?us-ascii?Q?tsy/ALxmih4guDjGsqu3ThrK1HjGTuJFI5vaNMwWQRLiJZMzEiAt7h7jZDqh?=
 =?us-ascii?Q?ZZsGM+B/T79ysAh9dKQf3YqFRRfkZ66pH7fIH4zLDV9Z8xHi1bz1WHNEWqeW?=
 =?us-ascii?Q?YJRUQkK8IP+VE3WobdG329f/OrZPajCIdUcImWlMoISRAbKB6Iw0KqGseQOa?=
 =?us-ascii?Q?w/AJRSBfcRU/DzN4BR6dz2+cyMrTfnttYtlSdhPq2aLUuCnb6A5SvZFRn1qd?=
 =?us-ascii?Q?cwmgLH5rnZRrsLfdLoTnKjT1vPDx8NU2WTHAE/WMzNbGBSiJuEMMCNwaWEEi?=
 =?us-ascii?Q?NUJhkYwj4AnAmh9OeagKr71s0WDSF0ouEjltDRxDDZ6mFRFoQ5CEIYxrIm+U?=
 =?us-ascii?Q?qYYu9sq3uYlivKVWA5jrAPWf/oTyhtpM01MnpGfTHX8dvMZKZ6vfNi4ITkPG?=
 =?us-ascii?Q?KR1C2hMdk1tPBPf0Ib06ySEVZaTw14QaIWwKKzpG6ojfmNy6uL3mEzuFlbGR?=
 =?us-ascii?Q?UJA/LywwJAq9plYLh8J3FRIFPkMUfQg7xdmWKmJxTj+6XrJZ6GI1wAqWdNcG?=
 =?us-ascii?Q?0dURXXJmHcIPu2MhMO7j3Vlqj+XVEj/EVbMiWlTezuboM/1H8/jGYYK4tXLw?=
 =?us-ascii?Q?/KksSpWgayiU7+mQqbFOuuLmYeRiNzf6BfI9NXkxMHIo6CTtOe+izZ3T9Rfe?=
 =?us-ascii?Q?/I+ruooer4L1BKGZ60wLtQAUOK9CUbfFw2RJXehgUf40GGgg1CcmP6AvSj60?=
 =?us-ascii?Q?vgaqdppcpTPrEx4uwPx1Gf4mImLLc2Hd90FjSDUZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c5b24b-5fa7-4e57-3660-08de1797fe89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:37:51.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLfYQZPMw4fJJ2D/mjEzdo3K1tyQBRLh+VCOEQFvHpij29sYNtQ+osR/DD8j10ls56fQVIgvBEC34hB7wDXpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950

LaBCR[MDIO_PHYAD_PRTAD] indicates link external MDIO PHY's address for
clause 22 and external MDIO port address for clause 45. Each ENETC port
or switch port has a corresponding LaBCR register. Once this field is
configured with the correct PHY address, the switch port or ENETC port
can use its own a set of MDIO registers to access and control its
external PHY. Currently, this patch only configures the PHY address for
ENETCs, because the switch support is not added yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 74 ++++++++++++++++---
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 1d499276465f..4617cbc70f5a 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -325,13 +325,29 @@ static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
 				 1000, 100000, true, priv->prb, PRB_NETCRR);
 }
 
+static int netc_get_phy_addr(struct device_node *np)
+{
+	struct device_node *phy_node;
+	u32 addr;
+	int err;
+
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (!phy_node)
+		return 0;
+
+	err = of_property_read_u32(phy_node, "reg", &addr);
+	of_node_put(phy_node);
+	if (err)
+		return err;
+
+	return addr;
+}
+
 static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *phy_node;
-	int bus_devfn, err;
-	u32 addr;
+	int bus_devfn, addr;
 
 	/* Update the port EMDIO PHY address through parsing phy properties.
 	 * This is needed when using the port EMDIO but it's harmless when
@@ -346,14 +362,15 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
 			if (bus_devfn < 0)
 				return bus_devfn;
 
-			phy_node = of_parse_phandle(gchild, "phy-handle", 0);
-			if (!phy_node)
-				continue;
+			addr = netc_get_phy_addr(gchild);
+			if (addr < 0)
+				return addr;
 
-			err = of_property_read_u32(phy_node, "reg", &addr);
-			of_node_put(phy_node);
-			if (err)
-				return err;
+			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
+			 * 0, so no need to set the register.
+			 */
+			if (!addr)
+				continue;
 
 			switch (bus_devfn) {
 			case IMX95_ENETC0_BUS_DEVFN:
@@ -479,6 +496,39 @@ static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					   struct device_node *np)
+{
+	int bus_devfn, addr;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return bus_devfn;
+
+	addr = netc_get_phy_addr(np);
+	if (addr <= 0)
+		return addr;
+
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC0_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC1_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC1_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	case IMX94_ENETC2_BUS_DEVFN:
+		netc_reg_write(priv->ierb, IERB_LBCR(IMX94_ENETC2_LINK),
+			       LBCR_MDIO_PHYAD_PRTAD(addr));
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -493,6 +543,10 @@ static int imx94_ierb_init(struct platform_device *pdev)
 			err = imx94_enetc_update_tid(priv, gchild);
 			if (err)
 				return err;
+
+			err = imx94_enetc_mdio_phyaddr_config(priv, gchild);
+			if (err)
+				return err;
 		}
 	}
 
-- 
2.34.1


