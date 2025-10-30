Return-Path: <netdev+bounces-234318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02524C1F550
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295D2189135D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B08343D63;
	Thu, 30 Oct 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J9rsif5e"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636F341661;
	Thu, 30 Oct 2025 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817071; cv=fail; b=aQROW1JRieYWJ9eaW2e03+rMx5F6ZUk0X4fzFQpEAJMEphLgi9+guZgYDrydgGS7JLeTK6i6ZKuUV5XMKpoflait+W6hBR/DLEO1Nva633C3tc2y2UJLl/0Lysbj2EP5Zr78axMwzivnz2Rw/bMbVBmQffbCb3v01BFyc0U9Ycg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817071; c=relaxed/simple;
	bh=MBKc9opRGYcml1W5ODjHbIfGlKPxWiCyLhsY/AKsVFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIKP0IecEr3kxXMoaNYw9TDUVsF7Fta522eH5Jv+qAHp1EmcbbGeiYmEZp60qdOArcFqYfJNARpXAC7UrcjeV4+kCsGeyH9H+HkIvOLetptF3/La/I3jx7WdPzk+eMdw5hNKT5XYExRZX2kmIuO3wtKdwdA6s5oPityJaKbhYmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J9rsif5e; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtQUYxZFqsV97lMafx/RX7R9mrYfMYwdmXae9MpZXtYUlgg+6CkKjePX+wdnBkyli3e2zFdh3ymHaWDLu0o3gJsWyuQGsCKzeXyND6Lm3xSyH3eyGUnB+ZHKav566dq2HHgIcRFkvremqxed9GxLabC2/4gWELM4G0nMOjf0Qt6MGxqV5iSHY0VH/yUsJtl7zX2TD2udAow9rgIEevE0q6PHlSZ6bmit+8XWD7tDTBlVP/p93uR29kEko8Ib00zjlQVLs2P3AdFrsPIrl3Gqxs01aCx9Mq0TWC8Lu/o4/UV4komUwfj2F4bf8RgsD4BxpLTmmsjfWJWR2D597ygy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/eugTD/8CFFhJnQzZHMZfIdCB2duZw7cMIF7/qFu0w=;
 b=PJ5bkw5toW2a7dpEI95iqIDVzOoYSsI0w7rLDg91jq3u0zkh7j1QHbxgTrrOVqQeLOW2IG8sJnoL2ZmbrZD1C52BX/bzRFKn8MGNCQziRAbcJlAgVo6051zVDDrGGbHjnFnxiFCe50HC3aUANvlhIBfFZuu7rhpIdVJbAZ84eU6AtCOXMKXTj7cZTdLiTAGhU0XUWY92HYnLya6044PCLJN0hMmFDBkePBbI1xOItQBUZRPlHi93j8ygByEZ5fiCq8598imgNGhS0XYdO6V8A0bkhwZTG/Iu0keE3ZhW8TvycAu6DokXIai8ixhJmb0dHfuzUvzvbbXlu7b9T6gIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/eugTD/8CFFhJnQzZHMZfIdCB2duZw7cMIF7/qFu0w=;
 b=J9rsif5ehBkJJ27TyOaL5gDbIjySkmGeSUh98p1AwVhYlpbC5iAzqzFO95s9yfr5wwqrK5gmNaxnN1mn8NaDHrPgUkiqP7tN1VtCE9U/5RnF7UZu76lhdmV4iKdeSiq+UNU0SWm00rCU2PcKrcLZkEv2Vsor1/AiUrBRWnvTMtiN7oGq66AJ53L12546VnpBkO0djyhqwALbXVginYo3j6axv6lBaXnHdcGQPA7GQsLeOFeGBP4fe6Csb01Fp87CmXRH49eM9diOvdVKseq9R35A19DlEwxb/gOAucKhEISLWpbIoGOJ42A3OYKbJeeE5p5RKhO3w1LEwUVlLcAccA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7950.eurprd04.prod.outlook.com (2603:10a6:102:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:37:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:37:47 +0000
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
Subject: [PATCH net-next 1/3] net: enetc: set external MDIO PHY address for i.MX95 ENETC
Date: Thu, 30 Oct 2025 17:15:36 +0800
Message-Id: <20251030091538.581541-2-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca5eff6e-22d9-440c-d61d-08de1797fc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qV8olJ7XNVXi9Yl4p6M1dTLRAhEWQGmkaiUnb2hMOcuCKVwkoGPLnGzG0AQC?=
 =?us-ascii?Q?sjtxqs5QmbiOGxFPAKR58iydofxoYaozeijeLlGH9RwIc9YYJYPlEgfHtRfm?=
 =?us-ascii?Q?gwwnp5wpveJzVR/dzvxA2waBKRSWG/EHTPDVOfaGJsWmswCppI8phTNY9CpE?=
 =?us-ascii?Q?j6kox94hAoWWv2OZkx86kAlkVZLbtzdn61FMvPhZBWhoKpHHdoVl3qsPUl5K?=
 =?us-ascii?Q?a0WcY6Q7K9aS+rupSk901tJxxW2+S6/yfhBvaGLfmFvXvAtrP0BviLPQ10Oa?=
 =?us-ascii?Q?H8qstryB6JYP1WkRBmUHdHMWZja/rEcJ7/yRidi1XsxMb+jQtdePUt+TvjvO?=
 =?us-ascii?Q?1GPBLJ4elxhupuJc7Xw9v17f1oEtPGvK38wcGv9euwRPabUC4QqXNCD4UafZ?=
 =?us-ascii?Q?6cVotYVY5zjjdRXy8r2wuXlfgQaDcvrGIGT84I3wS24CU6BRv3xtJxbL4pZg?=
 =?us-ascii?Q?RP6sCi6ht+uVkIgdGkmSmdmpYUge1Xrpj3Efw0NdkJtXXN8Rbkid8jAfr1IR?=
 =?us-ascii?Q?mEXVrxhB+v8p3X56Di1Qxa6MNiiLuGYu2yZCwbB1i1H869qReAzBvqRVCSP4?=
 =?us-ascii?Q?oP7Rm+vdPTud5yV5Gz/yFDEhrc45HQ9bjFvKEPz2+fsUPS+sKcKFESrUoDT8?=
 =?us-ascii?Q?QRevBlMYe4SbaW7vJI04hn3lLP2MAFx7ef7ktV0K0VudJdFW8wHNyD4+vY0/?=
 =?us-ascii?Q?Y9NjWdmX8X+912+be/NMgzBuW6upGZkuW0aTkY3eOxgmIdgzIiRaXNKtW5lh?=
 =?us-ascii?Q?soq6QgcpSgcaTE442J5tfROC/CoIE2xC7P98F2tx5J8clFnqFjfF39Qebed1?=
 =?us-ascii?Q?KNYupq9xeE7AkvqiP7mFbB38pd9WDcSzPKE2jIQaZj+y8RaObqgHuPcG8EdU?=
 =?us-ascii?Q?BcAjcvf673Bxoqm5Fk2jYM8bafUYqMZcEFcl8W8D0GjV7W2Af7tSjEPj/uqS?=
 =?us-ascii?Q?eMsXI4O87HwrRvtb3azxZMt8pZGy/0tsuttq3tD/QlcYruCB3yYTM/DbVQeh?=
 =?us-ascii?Q?kMxnryGYMQlaRUqfkBkkwoXY2JHjgtF30fsBqKdgD42VGb2MJhSlulltShRy?=
 =?us-ascii?Q?xujufiepbDKcVNPPllBB/oK9xzY//io/cweJ7FO6M7Q/H90ybl35Wf0CcR1s?=
 =?us-ascii?Q?Yyle20kMW5R8fzpYH5ih3iK7SE9ogyeEAlKSjwOfWqIBjUEWpAxOcRNmzxgF?=
 =?us-ascii?Q?UoTjPxn7e1qpikboN7YUnFq+YeF73UhNy2TzFojeB9jeSge9tZ9OyhxVEZ1f?=
 =?us-ascii?Q?JzXMcqJDCipHGCI4hYnQS1fEpmgz52T+RKWh0IbyYlQik7Zsk8aL+5itBkmv?=
 =?us-ascii?Q?bbkZ27W966YirMJNWTuye1elWEvZk7/e3SP4TuDBiIF2940Q2xJPk2ufOI1P?=
 =?us-ascii?Q?FlrQYk5vucs/p8hK7jpNvy3N+voj9JFfTXIkg6SPA+ZFBblMhFBEoPR422FN?=
 =?us-ascii?Q?c9jeKdAH+Goon33AqxAet+AjmF0+Kwq7b/ZNpK7CK+fpe8QXjVwLoc78YwiZ?=
 =?us-ascii?Q?AVkDH6eUTYAV6qJIYEsGnaC4dc8sxcmxjpPs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mODbMCL6AM4po5GlrwaI8RAjtWZtPAfeyncsuOlpKbF8RURqjjDJvaAwWSgj?=
 =?us-ascii?Q?E9vJftjyjMW6xMQawHr/9ReQ2ZDBOnMuElML3iTWJ1MPKg22exDozHvGMwwX?=
 =?us-ascii?Q?HuqL5CJRCE+G2GbswBU8abphs1k5MmGKa6u3cAKnVHtfJRzLOMjbL4r7pPfQ?=
 =?us-ascii?Q?SGp6SFggsLK04HHRwzWo5mly4Pw35MIkCyGiGjXHaY3bCbvPNEjkwV6OspF7?=
 =?us-ascii?Q?kIKPKljxDSfPE9aua0T3IwwPXqrZBBucbDFI8lB69Q67OcGj4W8+0Z7pvWYY?=
 =?us-ascii?Q?h7FnDmjZG1yuwNcbdgmCA1QbWPqTIrmXZXfjBKh5y/6LqCf5Il5Btsi+NCs6?=
 =?us-ascii?Q?uRUpKSQxWgLbXVlMwQAbLysaAEmP+S3TigFEPzqQWArsLqptB/W6dWZ6jdSr?=
 =?us-ascii?Q?VYT5bJ/1FePHOJfgdHOzC2fpzRPl2neAiTxtjjPUr1LNZerlDj/QTIRRfRLP?=
 =?us-ascii?Q?rHBac1PfJDHoffpyOephGf3Rvf840W0zwlGb793/E+wjXHuQ0BLfyJdScUBP?=
 =?us-ascii?Q?vyA5KLRH3G4jREQArKnfp6H3so8FIJ3TMtOzdo56Oc9hBOeyk1yQj010A394?=
 =?us-ascii?Q?YtSm4ft6DgsZzF7gDOKi8UHxWqUJQRE3tNl7vp7PPGX51R8RLoCNNUKIVwAW?=
 =?us-ascii?Q?vCH6IKqQNDrV3Gir8bAzvBCUlj091j3yHf9OUV8l/ZgIgipyL58w5nTUghtJ?=
 =?us-ascii?Q?gOhLkL/JS/TroeVdflv012ArH4ybGi4oRJdMYbMFxvli8MiK5SeOSL/RYISY?=
 =?us-ascii?Q?kF0+ZcpUrz5fQ+ydCuDUIniK4//IU8EIbdjS+LpoBwNZt1iiHt/IMYjLN7NN?=
 =?us-ascii?Q?ugjVSOPmuBGag5iG5OysvDSYbs149R5ecwiZINs4/dFsiZo5uPy0/lAD1VM5?=
 =?us-ascii?Q?95RKBA6QaV46mJatux5n+8qsJts2KTcEp8mNLmzPmHlO3tT3D2YyEN5MJH3d?=
 =?us-ascii?Q?oVxZbAcAUvhkbgv1fL5odjpqMRHq6w2hX16DsG9s8kBoBG1VWolRuCX61uoB?=
 =?us-ascii?Q?7IAEfbdHH3bM1Qrm6nm2ToL4gkwbgYiCXIXk1Oxpym5g7EHdFjw14q+9R/2n?=
 =?us-ascii?Q?AVyQqLSOJO8OsD8D3cydnXq2vFCbguUNayBIi4YMCnZd9sagrPC3myJAsQeF?=
 =?us-ascii?Q?LP0BzyiggazgxtfmPe/DwRMCGTzuGwz2p9ksosLCJGviZz5D7ZZ6e2xIIN3D?=
 =?us-ascii?Q?CQt9oJU7XjokWOujw7beCbuWf87zYB6mBYEU+qMqywXrC2EfD2yJaJA5/WXG?=
 =?us-ascii?Q?6JerF7uNxU8uFK3+TNl+2sh9buX4/FBmhDnx/L8XsOaVkllVtm3PLQyX52XH?=
 =?us-ascii?Q?DePr1GWwA4FNeT5arps/opb2WvTKPIx/+4+ykR/F3h6z8BBrtgN1BA/BDDIQ?=
 =?us-ascii?Q?ES+VutNe+ht6dkmssKwhIobMYX23kaHJl7uWbUi/CQrVzpfg5Nk9eCJ0dE5J?=
 =?us-ascii?Q?3+jmRWtS905aNdD8c4Io64Hwgygka+JDvAlIU8xNrnmoUODiV7h4HHe++W4Q?=
 =?us-ascii?Q?Qt3TZuxCpUPVwjtVAxoOT3P3sXwD6tZzq2/u2EV71FV5WlHFjSAnaTnKpjlY?=
 =?us-ascii?Q?TnLaufPTLLaMLYizd1hVxLK5PEevoioyDXWaxRpH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5eff6e-22d9-440c-d61d-08de1797fc1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:37:47.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SEpcPRCm6P1xE2qYqAWOZWf3I0npSZxZ0X29GuUz+i/AOOdT5geLXzQIeQzrsbebNwJ0x/D5zvRMDwPoPKWxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7950

From: Aziz Sellami <aziz.sellami@nxp.com>

When configuring the PHY as port EMDIO (by putting an mdio node as a
child of the enetc port) the ierb needs to be configured with the right
phy address. And since the configuration is harmless for the central
EMDIO mode (current default behavior for i.MX 95 EVKs), put the
configuration there anyway for code simplicity.

Signed-off-by: Aziz Sellami <aziz.sellami@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index d7aee3c934d3..1d499276465f 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -67,6 +67,9 @@
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
 #define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
+#define IERB_LBCR(a)			(0x1010 + 0x40 * (a))
+#define  LBCR_MDIO_PHYAD_PRTAD(addr)	(((addr) & 0x1f) << 8)
+
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -322,6 +325,58 @@ static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
 				 1000, 100000, true, priv->prb, PRB_NETCRR);
 }
 
+static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *phy_node;
+	int bus_devfn, err;
+	u32 addr;
+
+	/* Update the port EMDIO PHY address through parsing phy properties.
+	 * This is needed when using the port EMDIO but it's harmless when
+	 * using the central EMDIO. So apply it on all cases.
+	 */
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return bus_devfn;
+
+			phy_node = of_parse_phandle(gchild, "phy-handle", 0);
+			if (!phy_node)
+				continue;
+
+			err = of_property_read_u32(phy_node, "reg", &addr);
+			of_node_put(phy_node);
+			if (err)
+				return err;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(0),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(1),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			case IMX95_ENETC2_BUS_DEVFN:
+				netc_reg_write(priv->ierb, IERB_LBCR(2),
+					       LBCR_MDIO_PHYAD_PRTAD(addr));
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int imx95_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -349,7 +404,7 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	/* NETC TIMER */
 	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
 
-	return 0;
+	return imx95_enetc_mdio_phyaddr_config(pdev);
 }
 
 static int imx94_get_enetc_id(struct device_node *np)
-- 
2.34.1


