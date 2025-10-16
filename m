Return-Path: <netdev+bounces-230003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E5BE2E46
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434A61A63804
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D9632ED49;
	Thu, 16 Oct 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eelHGJ8C"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281832ED43;
	Thu, 16 Oct 2025 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611404; cv=fail; b=WDw6IzWgplS2fyQvyudYWDsNp764QrrisfIn3kA4Doio67/W3qnYQcJ2WVPEqk2D0oBhxV9xtwbUQM7Jo75un9b2w5g/yScHADpNglb8ZGJ7gEoq0XMuPqfs4I311t/Hmnnj/H/AAephZN9+aeeptduZHOrcjhq8QfydJmzXwJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611404; c=relaxed/simple;
	bh=hYEKB7rpLxHvtVgYtMOYHNICMc+FC6dW589MF+wgpKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSzrYL0mjGLjurVP9pp6x1Tjg/VMDXTJEWsGzs2JrDxQoRmCBU+oZBL4VpC1gowfOGXyzNGTeN0+kNzuh+0cmmmYbFFWWOyMYOtRRzqyaw9q5+yuRnhArFRmtXkdbsRjE7keF/EJTC4b80typsQsVxMYoaLT7iSLbx3BFRLEnCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eelHGJ8C; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/eda4WpeW+gWvVftd7BnLFhijl/QpPJgpgt0L/oKuGJKh74dLGEIBSsLi/UT2MiZMmU7lPBf+2QAUmmx5caRBRlyPxLR7W6pRqjlZ1x6lo2Gs6Gl4jXV5SxqlBYJlwkdplvUyv/0Wyp53OW9Cgnu++dBPGbs8yMi7CxY5LC3LNV0XzdVgL5KCFEf9p3QWM80Krpgf8z8Ejnh/mCV7vrTZ/ao3MAqFoOF4oI4hSV42JqIujzr5bpD/6XeVIpL/iK2LnDWNmQs9UL1v5zAEndGSFn+xEXqvGNYi5cLJMO2bo7+bLZ5CHm2kOemvffGL3owpNG8FTLbyIiVeeSHI7b/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuthJMHMq2UhFuRUJhoNgLYJ6d+iH57lYJsvXCcn1wI=;
 b=IzF5i23sEH45fzTJwjeQqQlxnySNb4NqS8VK8a+HkHiN8TyUZ/cUI8KghS3GwPWTpjzcmAkMjhcAMCBbPPayReJfMNY19rAH7FuKEUlD/D8NLRKG9/lRJUW1iR6rFdLRsgkjDvATkL22/M9QE5UojBb3PsklQxzcvTKLQFLVeofsuyd322SzttFUs16FJ+QJuwkPZv1WEhVjsLQEdCBz8MYGfC2a5Cmw9O1pQt5oNk9RjVc575JkB6CfNLUj6D9RSYoQFDVvSdMFHEoTk7EvLzOeonBrthmjEKnV1duYSv5wq2e1CyhCddDnwH56c7o4KJsfn/ecuobl3eZ2o6nR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuthJMHMq2UhFuRUJhoNgLYJ6d+iH57lYJsvXCcn1wI=;
 b=eelHGJ8CVQubQWtw8HfKgbOFTyRUzTJCErqvyuhqXacqk/udKLDAr77LGNFHxsGR9/7ff9o9/gZjGV3DKnLPSLdFf3aJ7SVKIlOXvCsZKlLX8McVmXZbi/4px+lEhS6EK1VgYVL5rkFwtXLBOUcSzVsSFNKFWbfek7D3kgjCSyhbpAeV2BY9eGoxrYpW03AjYcWH6rY+2cnxhs9dTxhCuhUfbZbXact+3BqraJn11skFoXz02W4RCjMRBePxS4PFVdhwH2pIR6yI33gLqsuwhtg87B0z4C6aRhou2cBBmUPQObsS7BnPEkzsbe7Qc/uV6t3ixu9uM7Cqd/w8bBgFOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 5/8] net: enetc: add ptp timer binding support for i.MX94
Date: Thu, 16 Oct 2025 18:20:16 +0800
Message-Id: <20251016102020.3218579-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 01796284-6bab-4dcc-1086-08de0ca0d0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lqVSKvaKyUGJLqvvaaq4gI/W48lZVY0jBdFN4H5zUP6QSVeNg0k+utgelXFD?=
 =?us-ascii?Q?Z4dzzSe/6YJfqBvsAGDZhiL6hs/F9WGYvj9ntolGq/dPDisyVnOT0wAIj69s?=
 =?us-ascii?Q?VduCtggZZNmObn+Jc+iPj/1XFJoz0tbyytqU9a4jJuxamPDxodJqCoFhRDso?=
 =?us-ascii?Q?WmT+R1+fJvv2bR/cG7h+VnMyqxRLTli4cshO6f12AVwkiJkjkUKB9hsTjaIS?=
 =?us-ascii?Q?rKm+E0XU5fVKEPqiMQOcmS2o7y3Y4Ckeuyq5362wKxjGJAyAw5LwjRvw0Go1?=
 =?us-ascii?Q?GSc4xg59MG36dx7YutqVOvMwHWYDUhf4anKiwOJ8i9LFTMAw4Gbyz0mKYE5I?=
 =?us-ascii?Q?0HOIhF9Rd8taRjbhT536uOjnxSrK1bs4Mn6J/F9SE/Gf7LvHZ9Bz0KQ7L9tX?=
 =?us-ascii?Q?3rTK6PANYmV79e4/HIVw3/aUXjlAzx659c6R30z8Uv8RiQgiZxAouyAIW3Zw?=
 =?us-ascii?Q?UqXxoulyuzw3M8bR/kTGR0PSZbIoALVCe41b4E3y2BCqbrvOUHwnqhO1JPKb?=
 =?us-ascii?Q?yZpI9PUqhF9Gqikelq4NZuPKiAGfE1VTAkn6eJ1viFsx4seTLECjq4XgPx9N?=
 =?us-ascii?Q?QZ1/NU9gVCmGQBXnr9377QFfgVrY/L7fJzsf7pigw3P6NMGdyVy6+OVUDYpK?=
 =?us-ascii?Q?ezEZwATq4Nhw5cYxeWqgZ5IV8rCVPmbhvNH8UYc1IK0hyy1yKlSX/Crpo9uU?=
 =?us-ascii?Q?gTWuetBHnqLYmdboQpaNi7y8wgjSAM8M4+jWNJlYSzzevCeDDL6bViKiBz1p?=
 =?us-ascii?Q?6wY339gda9Liq3491oWL9KXsf4HLjlLKWiXaW+5o0qT/sXxkTPlSNlbGI0kA?=
 =?us-ascii?Q?HLAjGARic040RXTYC5Nyq6vv7v88ZJLdxmGTp701+0B1+o0lZ3sGmtZ1rB2w?=
 =?us-ascii?Q?3rT2scpto/MZAaM0Yci+p+YtUJgbhrRw8EAKU5uHcgp5N6baU+ff1JJhZ369?=
 =?us-ascii?Q?r1Tugu+th0AGiF+T2RF7jMYFCYNJRsTH4VdHmmk9YkNznN6rOuwYA5YpetO0?=
 =?us-ascii?Q?YwoCMl2QRNOHDzvy83syuW1ucNyI7+H3yBlLOWWyFqzIZlBPrBoV45pVVMUz?=
 =?us-ascii?Q?p5S4poLtuTowpRK7j49r/4IS/Yh2IxwhjBnBrL/f8LukGhnxabs/koEdO5km?=
 =?us-ascii?Q?HfpsKm67OGTfi3FXTPf8LthAXx4NTveEr+j/SzZ0q2P154F1+eFOElzxHCtE?=
 =?us-ascii?Q?CmVrev1eB6H2Affh7w+shSCl+mXp2uonAjt6AgvMl3cHMFInzphe9+pTntiS?=
 =?us-ascii?Q?jUjpGhFh3SimgTqGkuzsn1XIVfzVllCOlavjPhA6N9G9CpRTcYezfPCvU+9a?=
 =?us-ascii?Q?HakHJ1zUTA1OrcNUCjdY4A+UofwthumwSaNB1JobVyIvF/v4ag3Zm5u7PFji?=
 =?us-ascii?Q?QxZ3S/tZ1KdWAK8FvO19ESCMAHUb1kI4gyRnbtDZgTvdCnHUDvMAlvic78Fy?=
 =?us-ascii?Q?WakxSMTobNFA92tS81oBA5oEdBuAizjeEB5qZjKyaj4Crs5/crWZtbmpVT0C?=
 =?us-ascii?Q?8lB34w3GqHq7OiSNa9gfVcG5rlFgFBn1OnwUK0ZDH3O/Z9W+WirfO97YQg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vHQ+ltN5b7ZUn+ugUj0yteqVfmFrmmr1lGgpeBlBB3c6aBF9JWDiAVKWUz0n?=
 =?us-ascii?Q?6YudnBgU41MZYB0rZ5/82ayijZK0ZMir7xp3cya/89y3rcH9i+z5nW3pMoa2?=
 =?us-ascii?Q?rEzwO+aZ0ARGCHFxg3NIiH6/3q2cORLc9HZvF5ZULIo2x2pP4NZdTcEyyAjh?=
 =?us-ascii?Q?UOoSs6BLIqHMMq0Jp1Yo8fb4ey09JgWyxUL/3fUp+tIwQJua1dfF000Ark3o?=
 =?us-ascii?Q?piSY9UP8kME7jX8oY1CGLA/LbqnMUQYv1wVrDU001v8MyJ52NZH+m9bBwixw?=
 =?us-ascii?Q?brM9vlm15rQI+4k0KcWv+M6wZh+DsYvHS1iqo2F1xwvlFLh9/zhrlgPPZrIj?=
 =?us-ascii?Q?tc3fAQbsQDBuPUhGYx7NH/jY3SFtzBXzXnJjKeFXixb4N11fwOaWLnKLT52K?=
 =?us-ascii?Q?/h5nM5VF1QX7sExlp1E/EzgAlfD8ly4F0tVDaonS8nKxWU33koaV6V5w4GWy?=
 =?us-ascii?Q?wskYSlyKye++xT1piiJYow9NafNQ6FPV58x69vh5+E+UdFIim3AhpopP6Drw?=
 =?us-ascii?Q?+HAevjKmPrXYj8Ie1mdLj6KMvswv46Am+G0Tj1jzia+ULz34Ya2T965gA+dy?=
 =?us-ascii?Q?/k1j8xRJptusIdHet1TKKVPH1JqkYbiGMmUjpVpGN3zvIz3n1L0C/xN6RXL0?=
 =?us-ascii?Q?/UI54hjMc4qijXKqVfM7QTwgk2HVBJgILugu/67wv+BsJoSEZCvw/1vNST4T?=
 =?us-ascii?Q?sdY6E2BPlynqqw2hIhJ1nHGr35ejw6NIFC/W7F1l8OBLUiU98VP1h6PHt4bN?=
 =?us-ascii?Q?NHDBLIF1BVEw9odOKKCD8NVxxpFkFoc6ZOAKYhSzJUu5+0hExI+rp34qvUqS?=
 =?us-ascii?Q?yc+XnlQ5dTY7p2R3fE5WHoQNP6gKc+PtZnG6l/moCuNBYz+vwmGAA94pZpFG?=
 =?us-ascii?Q?asnLMOR0Zo5dSomkPlVXbkR9/ehsXQxvsBP8UzJrxzpAaJmUUDR18hBOrI6E?=
 =?us-ascii?Q?22+6Jg0RgOJu+A8HjfvnmVSLcZhXWfEQ1AVrMY0qvOvaTTLGrCxKnSLwZdO6?=
 =?us-ascii?Q?qtaBER/vNhW8xgN3YPonwMJ2UsSRlonvi223P+ik+bUinUXZPO2qGtixkyJC?=
 =?us-ascii?Q?Fb+8SqGL2/H6o3lUNd8jo/Zrh7/6NO7jfsl/Uqh9NkNPSP1fuhAxAP20l/SO?=
 =?us-ascii?Q?kGIfqCRxM4q/4F3qTxvsQB8G6D5/XPf2QY1xAN6wxY8P2S5B1X1GJCHK+jDJ?=
 =?us-ascii?Q?Serh/p7jYmviGw61F6AS8TAb4m9fCsCTghQVzijzCOY8k3wF/B8HA67xEeWg?=
 =?us-ascii?Q?r9MgXthWdlV4YQozsTiOa6mFHVUk6hFhmMSHV0hPShaxjBqdNsn7faEQ9QrU?=
 =?us-ascii?Q?Pa14PLhcIqnQR6/uyG94qGX0GwQ8DCAgnPOUoUOBKlpmnTVmoqsX+cIyc8Bl?=
 =?us-ascii?Q?wnaGBUG7bab8La8APyWg/4zkOcB8DgqF9AqWcPzIezlwD/ZVA2C1IrSVL0M3?=
 =?us-ascii?Q?0+SgBk94HjBdlZSTZ5Bx1tMvF932pT1/nBK8Auuu/ZBfmdei6q9ocUlCsArM?=
 =?us-ascii?Q?IOqOYqEcTreLPu0mCmbxp2vNdDPNkFxEA4rGvC4y4mqELJh48ARg/mm4JZeg?=
 =?us-ascii?Q?LHmkC+VYinQARAgFwmLwRMER0MND1XgTbutgPs/s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01796284-6bab-4dcc-1086-08de0ca0d0d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:17.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLIAAihP9cI+TGvN9a7N50VejQx7rrPHSlQuYhcCNwDxrPsmaXHDXAGpGu9OoGZF9767R9H52r4Idgwexuyulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX94 has three PTP timers, and all standalone ENETCs can select
one of them to bind to as their PHC. The 'ptp-timer' property is used
to represent the PTP device of the Ethernet controller. So users can
add 'ptp-timer' to the ENETC node to specify the PTP timer. The driver
parses this property to bind the two hardware devices.

If the "ptp-timer" property is not present, the first timer of the PCIe
bus where the ENETC is located is used as the default bound PTP timer.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 35cfbee00133..98f8629a7c52 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -66,6 +66,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -78,10 +79,16 @@
 #define IMX94_ENETC0_BUS_DEVFN		0x100
 #define IMX94_ENETC1_BUS_DEVFN		0x140
 #define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_TIMER2_BUS_DEVFN		0x181
 #define IMX94_ENETC0_LINK		3
 #define IMX94_ENETC1_LINK		4
 #define IMX94_ENETC2_LINK		5
 
+#define NETC_ENETC_ID(a)		(a)
+#define NETC_TIMER_ID(a)		(a)
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -344,6 +351,97 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_get_enetc_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return NETC_ENETC_ID(0);
+	case IMX94_ENETC1_BUS_DEVFN:
+		return NETC_ENETC_ID(1);
+	case IMX94_ENETC2_BUS_DEVFN:
+		return NETC_ENETC_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_get_timer_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse NETC PTP timer ID, the timer0 is on bus 0,
+	 * the timer 1 and timer2 is on bus 1.
+	 */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return NETC_TIMER_ID(0);
+	case IMX94_TIMER1_BUS_DEVFN:
+		return NETC_TIMER_ID(1);
+	case IMX94_TIMER2_BUS_DEVFN:
+		return NETC_TIMER_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
+				  struct device_node *np)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *timer_np;
+	int eid, tid;
+
+	eid = imx94_get_enetc_id(np);
+	if (eid < 0) {
+		dev_err(dev, "Failed to get ENETC ID\n");
+		return eid;
+	}
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np) {
+		/* If 'ptp-timer' is not present, the timer1 is the default
+		 * timer of all standalone ENETCs, which is on the same PCIe
+		 * bus as these ENETCs.
+		 */
+		tid = NETC_TIMER_ID(1);
+		goto end;
+	}
+
+	tid = imx94_get_timer_id(timer_np);
+	of_node_put(timer_np);
+	if (tid < 0) {
+		dev_err(dev, "Failed to get NETC Timer ID\n");
+		return tid;
+	}
+
+end:
+	netc_reg_write(priv->ierb, IERB_ETBCR(eid), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_update_tid(priv, gchild);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int netc_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -440,6 +538,7 @@ static const struct netc_devinfo imx95_devinfo = {
 static const struct netc_devinfo imx94_devinfo = {
 	.flags = NETC_HAS_NETCMIX,
 	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
 };
 
 static const struct of_device_id netc_blk_ctrl_match[] = {
-- 
2.34.1


