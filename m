Return-Path: <netdev+bounces-224702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0CB8882A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2135A07BE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800D2EA461;
	Fri, 19 Sep 2025 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a5j/kyq5"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D31BEF7E;
	Fri, 19 Sep 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272821; cv=fail; b=JjCq7g9qamnhgE5Us0l2FkX/qpuHg34UGATxJp2SWhATdRQsKnxpit0OS0MEa017bq2/jxTKOafPzsA2sCkO6+UsmSmf11rVfdgFJ+RV5sMc+nPrDqUqlj/IIaWPfQsDpwAn1ZA/CY0RqxvFYQUeET35y7XkinyN5sJMte8Vv94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272821; c=relaxed/simple;
	bh=jFBiUMa0ZHVMhByddCEezDz7m8JbGicaMdgsYnslC4M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oGWs3U3zhxGkH/FoqsIV64TGEeXqIKJXaoep0dvAyiWl9/INvszMqlS88okFmFE7J8OaTdidUPP0GEjY59ioVAzczit4tGYL3rsTW/c7tHqa8EI0puyScMrWHIpRw8bOW43VXJBPZRcMV7PlGi72Wu3InljHEs59MHuwP0YvKy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a5j/kyq5; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkdrlFelhrTfN2JZTtErAXNM2ur59g5pZpZqbwWFc+Nd67wwzsKMBYVodpGWUo6irPmRqMHXUC/QJM5ZPcJwl4wpes/A5kb70x1nMEk03VwxoU6jkbXLIgeKd2X3tc1pPAhvipa7kXTDneOhIFazgqn5yOTWlWbhLRcnUCbkYC7k3W2atvz0eZb10QvLzB75xAfGnTc/jjvmAvrR1ngTHb4RG1s5v0yWPsId4BBPDy96vmXHQALUTlQSeckinK7Hdtisan0ypUcy37873sUViPrFyqtPoPDhjTKnPiD302qWnPeoEU2ME9iwRyvfpKEU/4/qdFstFrbiCpCibzQk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH8B2vb4VCFNjgs/Yac/SIadbz4EVI1RWb+HmQvQmHE=;
 b=PfPaLXCvDhEgjfJr3FjXGMiyhcbBvIWD0c1QsCs4JQeF2U/xfEJF9Q87d3uZ+g4jpi1y4vNCpTXCBVCibJiDo9neNp11al4GdtL2wy3R9sqNRIDiDmNwPHZzSilwJ4h6au6X30WRl5gcMdRWy/joh3T/QZaldhM2CDd94v1sv+jpuL9cRC1+XOqVc0N7B8W1a736w54A+tmYT5P7m5TBUwxdlP/xUdGEpqM6Y3W1Qq3lwdHu/OhxS0NfSxkKboHb6pl0X7wNVGuf6J9mFZ5SBxKsy3vef7BcgpxnqAqQpB2HTNBWkGpy0u5Z9R7dvjQg0YxVGQmUDhZtzyHI324xLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH8B2vb4VCFNjgs/Yac/SIadbz4EVI1RWb+HmQvQmHE=;
 b=a5j/kyq5xdU9eHJ9vdlaGtU1caNmS/SckvhJz7KSQ7ovnCHwSHKpM6WEg0WThgHlES9csiX1EDwOBt/3LK9lVSXIM6kLYCMCBO8pmnsPKNyTofb8CwMSU+lhu28gRoyeuewWBu2FtVwE6Bioxlm3x57ePD/8YxtXGnk+U3DGGlMOxLrisRQ1KWnC/BBvGZ1+ynlSCeMQK7GjhsidGqSGt91k50/r94umagVYlThCiPBALT+g48JDRMC+aOyJ4p5/mAmYuxCYnXPZasi2mw2IN7cQmEL1LqVXmxhouo2eBa0jrp9TfBbB0AqwkwzMovxdSctDpHEomn2PfGuAPUq6kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 09:06:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 09:06:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	yangbo.lu@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/2] net: enetc: improve the interface for obtaining phc_index
Date: Fri, 19 Sep 2025 16:45:07 +0800
Message-Id: <20250919084509.1846513-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bb544a-84d6-41d2-59b2-08ddf75be191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWDtLX2iVbdgaTzI1swVsAtzR7090fzzMv4j47CrwP0xiCuBeBhxtAoJIS0F?=
 =?us-ascii?Q?3dX+y0X7FvBaOtBMKkmWC1d4AlsAISVaHAJxXk3dz8FqdT7Stb4GD7/Y4Che?=
 =?us-ascii?Q?yojZNbdrkqNzp0j/meNwwuSpTA5LjmlLelR77KhN8QMiCA7cA/K+3PRwZluc?=
 =?us-ascii?Q?/4HKw4+8CamM9uWoQ6kVB2jjyWHMiQnp3sTA1q2SlI3lwE1rIdaisNed3PaD?=
 =?us-ascii?Q?w4eimsJ8dL82mSEXXO8UwEZMv4UfmqZmgTNboaXy4yBa3fvTMKEF3jojkz4o?=
 =?us-ascii?Q?t8QjOquK1dhDos36acq30DL3jsICwdP1qbGWdthfLMGQtBLBpY7uZ0C0bSS4?=
 =?us-ascii?Q?bQkimfgGBs87/SpWVlKOSqo4TPeFIxBz2uZq5QXUP3C1dnQyfAzFspHVlSol?=
 =?us-ascii?Q?Sck0N1Howr/x2LVw9gPDULhGs9c++pq/+4QxYJUCn/Ej+Hx7qL20QmTYMOx3?=
 =?us-ascii?Q?SSf8c5uOaNf4PGXI0pITr6WcmiZ+wFpnnDyvx+sgGL50+4ems7mTUXSKYO3f?=
 =?us-ascii?Q?XRpdyJmrl7yFZKciwsv07bVTGdrKfgQqMXIsEs2GW5OaOIzHGGs/knugemUn?=
 =?us-ascii?Q?1q4g3h0Jk8cfyJTyYXz6qZHoWDtXiySt3mQBhi6Q0vS0Www48MwxquAxXMeK?=
 =?us-ascii?Q?zZrRTE00DyREBjiVsqvVK0ZlFihLj05R0TWW+uVJ/x9eBRcSRuDA3uHbwBwT?=
 =?us-ascii?Q?EIZuTEbDyXsCXc54c/bnZbWH4CW+r5ct2esLfWpe8oe12dKf8NoAFul5bG8C?=
 =?us-ascii?Q?24Qt/ZVEcquifTYHCscDgYxfEV7w7x0HOc5cZA2pTUhLT+Qtt4TByOFfw5tQ?=
 =?us-ascii?Q?08iHmJELnNSJh+qOiFfdXJ9jin9VqTGq2yAHERw1TPnHAfDer1V+7lCrzULw?=
 =?us-ascii?Q?DXfFO4i+u4WWEvgaD+Ho+7dkIOObyUgVfKJLXvwNqc+6STES5jP7gehJ4Aig?=
 =?us-ascii?Q?FvNxAOogUMIZKmiiRmBM4Q4VV7pYAHfl6cLalQPEjwIbwcw9B8BE8mh2xoAn?=
 =?us-ascii?Q?YZ/ziWmxoeDggErUHdsp1QPU5y0Q/L43Q5ey9OfjgmlWyzMaf3kNuBDjdYFC?=
 =?us-ascii?Q?QsQoftNbeykiSC8hciLVIHG/7yH5664G5KLaa8QuU39PpXmHeJK12+HxeOKr?=
 =?us-ascii?Q?PiXMGdkWp62gsBT5bdVFTtABrWoxgvHRgNMqAdxah9bwca/5PywkplgZb/eL?=
 =?us-ascii?Q?ADfYIQtCoFTZ9XkUZytfHnuToAfDGWxlXc/PK1WhVdtOItitG4ThnzYIFCLf?=
 =?us-ascii?Q?XpyzZlM124un05PjijbserpvKGxsy1nbOcwNCVfNBURx7eNX/Y9TNP4lC8lE?=
 =?us-ascii?Q?V8wDUe0XN30ZpZ4B+EwGSGaawJS+WnPY3lAjYIwDlAXs2yeKMVI8gyZUVTxZ?=
 =?us-ascii?Q?RZnZYSzRF8cMYuqIyCkffauAzLBPEnN/Gdxg65lmHdhFj+/6khTNBAC/5cVc?=
 =?us-ascii?Q?IuV1jqf9awgGlSNdJ8nfwPEOnuXqrHeQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6N+XKv16HFRStIU5YJlXaL96RNcVCDWfzAxUKAbWJ93hEv6qB+2gnaNSs8rQ?=
 =?us-ascii?Q?piROlmStwTlfrI6Y8xmjOSzv6KC+FU9VKVaG4tymzxfWTgbe05lM0OxFtcas?=
 =?us-ascii?Q?o5cRK2RRieP2D2h+H3BDQLcBJR5krAFAB2FJk9OscLNOgioZgwBt69T3jPdE?=
 =?us-ascii?Q?KtJLNp7dFblBgRzaikKAqeQ87zmFr691nH2rqj8L5izqAg6wuF3vMvut7ieX?=
 =?us-ascii?Q?AjwqRBSzYuBkL5hKlvBelN+fQcf6X/myiJkIcDpTzr/GJx9a1g0lbE2R5c8z?=
 =?us-ascii?Q?E3aCt5Gr2vGEnXEx/es9hUuJpO9pAx6B941gyI2VkifC/czLBdyT5KX+ulcz?=
 =?us-ascii?Q?5l/k0JloZ/WSQInAKCjGOE3zn1k6YRbduBzb99DUhTz2QLUFte7QkhuZQYlT?=
 =?us-ascii?Q?M6XioI4tI+sBuydEfMXJeMlh3VdMDDU6fcPb+L5I+DxQdRZGeeG8rKRk6/U7?=
 =?us-ascii?Q?FiGEMpbUmLy2ooTZOq1NhPvMkGroNFSx46tQ12kf/8MOU34Bjsbjh+eo6/YO?=
 =?us-ascii?Q?Fpv8FQtkWKmPp4uo9xECqau5LbVLokv0eoP5VVoslF1sMeFvd1SXDM6ah7BH?=
 =?us-ascii?Q?ryuhm7cSPjZ1LQG6Xjm8k5Ceu1tnhCUsb3tb1JrNjWL1IT75xLuXwg44zEld?=
 =?us-ascii?Q?8SYWNwDwNdrd7kGalite4tfXrEPoQfvwODPtyatKxJXS4Rjo2MT/NGPMDbfq?=
 =?us-ascii?Q?h0urovGopBK2aRbAPT3wtRUJ3I+/xiS2EIcPTCddq7tAgLAbzpSMzy6Nve5y?=
 =?us-ascii?Q?how6ruxRpdzKDadz8GmIE/27Es1SOC5VoirIWiiSTq/qVhu6xzMNmaMqMER8?=
 =?us-ascii?Q?A2cf6W13so8oW7+O/I7qIlnnJ6QM1GRmKpj9kruS5EZuMzDEWFcaHGdg/eup?=
 =?us-ascii?Q?DqhWkgfUMsA56wD7UDSn6ZQ0vpIrvPcUNwenvjEfFKk68+C6cq1KqA0eqgrK?=
 =?us-ascii?Q?w/EqouNE8dPYdBO+k2shBS+ijeNDPpp6kcosm/qTg5oKydQJCk2OuHYvAXDD?=
 =?us-ascii?Q?Pj9IbOabTgumot0ZSSB+NEIF2y4PnvaMQwuAG3e4/ChfCJzWu1boTVuWYfA7?=
 =?us-ascii?Q?JnT/Xu29W+EEDwdfMwNUFu9/o1o47vnoQRW0vUSFAFDO59ITdfQqL5F7BreZ?=
 =?us-ascii?Q?4WlWZCBCaAFHISl9ePmU1vw4vP6a6lKGz5Hl1CU6TCB2sOuoP9kFtTLnC4v4?=
 =?us-ascii?Q?icHwll5GRJ1xiA6mphtmM0Vt8V2tc1yFGYGDWA1y3fPSs1r29YLV8flZ3dP8?=
 =?us-ascii?Q?fMMDhRyx5pgd9f6uSGWFxnlDDsCoDpCYOyn4oHqfOzxIW5UkbAcpvYwSFCKK?=
 =?us-ascii?Q?vXS76KNLdTgdMlsD2YU81+zsO7V+WrmLSs1IsmC/WghA1hmbY54DcBJs7Ke6?=
 =?us-ascii?Q?FILJ50YnLMzl5y+3xoL6t84aLy4rS2wyNqX/Z4HvUHhLqkOB9yd3hA1twqvh?=
 =?us-ascii?Q?P58woEoWTCe78hPNLaMdedYXUISSj0oWDOEDk2a9Itop1wUue+CHTtVRF0Y7?=
 =?us-ascii?Q?jrzsUTgDUqCU0J+s0aNj974SNCgtbUEusWrP+itZpnvLkNenPIBT3HFVv9SW?=
 =?us-ascii?Q?Df+Ngd6tFaiPRba+2eLe93BGaYNcm729ZPgNSnWf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb544a-84d6-41d2-59b2-08ddf75be191
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:06:56.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp1aSG6e5MJOCUCJgUDNm0lL+j4ZYnYDVBtk2QklHIvL3fL/wS1Dkx13L027pWw/GHVJzhuNqwpS23RVN/oh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657

The first patch is to fix the issue that a sleeping function is called
in the context of rcu_read_lock(). The second patch is to use the generic
API instead of the custom API to get phc_index. In addition, the second
patch depends on the first patch to work.

Note, the first patch is a fix, but the issue does not exist in the net
tree, so the target tree is net-next.

---
v2 changes:
1. Add patch 1 to fix the issue that sleeping function called from
   invalid context
2. Fix the build warning of patch 2.
v1 link: https://lore.kernel.org/netdev/20250918074454.1742328-1-wei.fang@nxp.com/
---

Wei Fang (2):
  net: enetc: fix sleeping function called from rcu_read_lock() context
  net: enetc: use generic interfaces to get phc_index for ENETC v1

 drivers/net/ethernet/freescale/enetc/enetc.h  |  3 --
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 29 ++++++++-----------
 .../net/ethernet/freescale/enetc/enetc_ptp.c  |  5 ----
 3 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.34.1


