Return-Path: <netdev+bounces-146143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A69D21B4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436761F22A14
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C78F19755B;
	Tue, 19 Nov 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DyAks3D/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31695150981;
	Tue, 19 Nov 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005582; cv=fail; b=nuqtP6QiWqGQpMviQEAc7RyaglE0zw6P+tYP4gbSjv7ZfypVb/M+dUXFGCIobw/ia0wmmOHM0llVuPcVebLIioTtH1Sen2/OuBRVD/gTQYAEBPKpktv1EKCRb0REoc4m0eewfs4Wl3WruVrYJ4w/tttLncbjRjhD1J0metJ41Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005582; c=relaxed/simple;
	bh=1YLGXTuRp1219LuDh43hdqAWtmENgnZ+xvWR/Q5akOg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jEbsM3dbqrw//OjxNvgkLdlHzrl9F//oLDrq2ActIVD14TErv/LFWqBqMT97xOKmWFQiDCmu+iUBH9z67f3XJByCJJ3IEENuVJCGchJ2pDUz3LpJlle8GrQzj+fK0y/BRIWybGEAtVt6JRkujrfBpsOtLOfGWCyR/i5tW9OLiMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DyAks3D/; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWvw4HtT6Fy9No6VyGMsAkrXGVYRhJSapYRFi+DzO+9WRuAILseBj6bQGuO76n0vzVEpJcEStydmQVC9WZu+i+IHtOPWPDGm33KRetMSNG8sPuNGjd5DthZCHzUhGq5v3wbZj7oxFG5wVFDCwCuQ6J9BaSytDuBWKUmzWlBRRfL7XnRyWgn4Hkqw/ZLAJ2srnZmn0vf7M2EKWwNYH9aRJK5/B4v20ZA6DZv4hwcgbhUH4gNC92zN1WyJaSBvzJq7MyCWbtr33OARU6yEobxgCK7P8n8KZnpx4/mmFGcW+R/UtYqIgZO8PyJ+azmfWapStyzvYOu1cCrD847EiOqcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djU8hL6xT5JUCxCZ9kde87cfB2xUGpB6f1/eX/MPbZw=;
 b=Z/lWjrzisFWThsdbzvOxh4F6a8uvXH9VqgZclE8JuqkCHsCa8p/eDEUwiOL0ky6yb3ZZ82u+Tfm6SH/OUJn8ZR9k7Hk8kPt+/avEVOxKuoKdkX0pqq38mCEyDbBLkUQjbMB0618jUcqk0sXvdWTlk1VeV21dBHxULCGnnGGeMiB25L19+L7Nj5JrdQaGIcy2KhUndFdkz7e1o7ylLcWieVx3mjEaF2eSd48qOGEsyVkVNeUwUozlLK9fQWyruJkjF/YeQOQfp3GeM1M04JWC608q4qyACaVnE45f5+GEZ/y/A4ZsAfVmes+eIUgim01ahAZxD7gnVmQu+chtZO15hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djU8hL6xT5JUCxCZ9kde87cfB2xUGpB6f1/eX/MPbZw=;
 b=DyAks3D/LamYUx1XnE2QA7XgzVFFCju934UeeL3hr1l5m68P2Kf+7BGGDbi4PZEZp9DV1UOk2l6LNjz49a9k79oSQnBzpA9FDqOLe8rR9BeUtBa8OquiLO/6SCFPUXknF87tdASB6jair7eSmqZ41jD6msFO6XffFJ51XUvcrQivMkTBIuweQDyS/x6AWYsCth4Gu7avSsIDgi7wBDnfQNMugzY3lBx+HNVJIMhB6FEGGRRBFA9e+vZ7LQXFbo9S+VPCBdfq4Su7itggs3Kb3ag4nPkvHQeJjvZW8h5gkB71nBigrKv20Qim97ZuaeOOHrusBTf1dD0lTyo7IKD78g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 08:39:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:39:37 +0000
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
Subject: [PATCH v6 net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Tue, 19 Nov 2024 16:23:39 +0800
Message-Id: <20241119082344.2022830-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: d8001552-8e09-4078-0e0c-08dd0875b348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZOVzlWINdYBg65XNe9biSIgDbTQKogTKN6UqOXv/HIeiFAvJ6gVqD0SXrl9?=
 =?us-ascii?Q?M10IMYV0kQFngj6FzprB9d9rsbjO44k431JvPb/rb6IWPZP+eGit47VP87IY?=
 =?us-ascii?Q?tdFh8b7+rxwnvbc6Bg39MbWs4hfmeKIyaP/MbtjAgb3rbb/mApZcSUK/zVKS?=
 =?us-ascii?Q?K1jxYUPTXqHZwjG0eHZZYXTeoi3DYcTrsX0Gf5Hn1q7/EWqXSJjxh+KYAy+P?=
 =?us-ascii?Q?6x59eXp7CUMJ+oP4GKa7NWPB1AXb1bA6kFdq2LYV7xQOrcFmVRCNBWaePGtx?=
 =?us-ascii?Q?IXNunxyWUxAMMmUV4tYJQG6NW3cDuz3LGA+w+E7nt7GIarxJk9HKFzKYvwlB?=
 =?us-ascii?Q?u0DqARgZOF+nKyo2Vs5PXt5kxcI+oltuy8RB2Xtsv93JTTXjLLBD+3p2xhuf?=
 =?us-ascii?Q?PkZ4mzERgfhi8mwEb71SX58WOU0mYanawgOMcrEdtMf/fc8zB4K6koHRcGQw?=
 =?us-ascii?Q?yUuFnMzahNawqojqgHLZ9SwbP2Ke4inRIijOFGpbeunMnB2m/uHquGMJ5r2U?=
 =?us-ascii?Q?/JXv6cBKxMdtwyf1rSHjT6UuOaiun8btC1bhZ8pvQRaNc/3f+2ZSb39/rRPm?=
 =?us-ascii?Q?QY3uHkdcfFw6zpiyrVsmogylGhtjHv8UM3cAKbbIr4W7OpCRYdK7E5oPwiwv?=
 =?us-ascii?Q?zl9B3jlAnXK74XpSZhXOiyL9U2eWj4FuHZeLsXwntHbvwY2LlpH1L/yvXw8R?=
 =?us-ascii?Q?C6EHKqQhrkL1Tqz78ExlYZRNODch8+07DBqlN/BCPeE6UYCO11m0Fc1WQRy8?=
 =?us-ascii?Q?X/eZGRpAsOgLcd1LSHCFPnCNq+o6Rmny7IZqlhBItcUdWBIQ2p8K82HuYMg3?=
 =?us-ascii?Q?LYFDFwGk2xh5RGPzqdqg7fibjXQa+0ZDH6ubiSOqK+cL42jWEfqyDKObx5sw?=
 =?us-ascii?Q?O7uispUg3KjK+UOMfmqT5Mdo51kH5H0RGtoA4T21cM+5TNDZ/Q2PxfX3AGOa?=
 =?us-ascii?Q?dSA5BExcwYNvv7TDREmNrJYCvQ+tHXPjmm8ShC3ht0V9O+iqRvNHI7MNwGDF?=
 =?us-ascii?Q?p2qU1eytrRo8hgnilXeu5gj+Y6FNr4PJnzGmugOWpwclXHnYnKRl3QT6D4FN?=
 =?us-ascii?Q?fY9VYAruBY3sqsi6WL0fBkUny5WhjCJ7io9EHJpD8h75YCeJo/0f35tQH92z?=
 =?us-ascii?Q?sqTUdZCUJZq+NN/wuzDuoUzEcKyt6CraMYHld5bjiQyMiHl+XRWNYnqIgkXn?=
 =?us-ascii?Q?uyb8bq2H7uu7sv1Fo5hJEEKoUobMETePwdj5cctcOFxVrG9lm/QeVPvGrwpL?=
 =?us-ascii?Q?HON/pisbSECt1BYE4UJk8mxpedUizQnTg7uunQMa3jAN4r0WTrmNr99s9Cyb?=
 =?us-ascii?Q?bB2i64LYsjbiSD5PkcTZdx4uTA2q+TVAvFcTcL5DfTNiNxqtajFhwmWTg7JT?=
 =?us-ascii?Q?oCvwEyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MudSrlVGWfKZ8B0BPjSyzYK9TKdLPxvlm1z9AWPTWlHRbFCBFQQnUTGJJXzL?=
 =?us-ascii?Q?w39bTYLFqonGKTqLDWxR0mjkUjuXTFfQ6eDJvJaq78cHS4sUHEvEBfy2CZfj?=
 =?us-ascii?Q?ZNdB3pYV3BItWPqgvkj1RUB6lDDUwyEmTkZe+M7FaX2qMnVpBcWk/Me66UR4?=
 =?us-ascii?Q?cXDDmD2n4J2k1CGoEeamBm6Lvk0AsnSX9rTD5ebKh80W9gKi3BZx2mRhYB13?=
 =?us-ascii?Q?uUgzkf2Li6U01xWK9yVQ0Gp2bi8Gv3ZoLZCfRplx756WXPA3bj8Mqqa1WuNR?=
 =?us-ascii?Q?IzyiVXRBJu1mxgyRrVuY3ZzqCPpVj1Hz/qFJd3XaMUhJosJGMyhSEriOei6K?=
 =?us-ascii?Q?47tHHxiVjKswnov5d+h4grYO8HJmmeV+0MGvdFwF2ZYpVpBQx52jtdmIr+dV?=
 =?us-ascii?Q?TDrtKSW3gewwIkjl0NWVTzLmzmob0p4TGAKSVUo1h30jTuTaYhN3BTf/mhzK?=
 =?us-ascii?Q?HTo47YBudt53IwuMVew19iFG4ue4x3O2W/KHsJQ6MNPXaJByiMwSDKaC2rjv?=
 =?us-ascii?Q?NvJRkqujAq7phQ69cSEe/phCKvhRX01wmJXS2YsT2kcyUzWQ3Ht2BkGLmZX4?=
 =?us-ascii?Q?tH46nuFk6hTcHTE9CTBj+nLKT2xQmhA8Fm2ROH81o6wdMzhV0VInAVSCiypk?=
 =?us-ascii?Q?Oj+sD4KwjPVtdi1gWO1JX6+wjjAlDwrShKcgCM4xFz4WEX1ekwyuTbP/6NsE?=
 =?us-ascii?Q?bziO3gHWoCd46653mjmFArXxdtOEJsxiJMeFXtFY2wdItr6lNXgt4aY15Yog?=
 =?us-ascii?Q?h/p+pfUsbFS1rHtvu3ScVAfBf1kVS9Vg/6CTm9ANkoHkuoCIxYiWxOf0eRph?=
 =?us-ascii?Q?o35Mh97sySWhf07iaRdXmUYW2eJ+mMRJQhYilZA5Qka8OC9JOX0LWfGnc0d8?=
 =?us-ascii?Q?qbMTDixy5bTcxetueehBz7G2EMgzxXmyN3UQjWcdvMF7iTWA/ojB1zcUelOp?=
 =?us-ascii?Q?+eSUcdJ7gFRb0o3JTUnNcaSIux8LCzYnSrIopBz8drZ1cq1MVfbQJMpA9Z2U?=
 =?us-ascii?Q?Jlnk5sOgp2XH6CjYWlZJBrTqdbdBLgoSxKpmUEBsI3Bq57R/5oEeMUOtPvDm?=
 =?us-ascii?Q?90VavaXc9pIzl6LTTbqZ0WduIfO1N79KnexZaYuOTLgTyi4vH9bHtK0bOeei?=
 =?us-ascii?Q?H8HrYlLeqLkCaP4a0UDUriBnbClJBGLI4HxGtRUxGNCd8U5+OkWxbPFzS86U?=
 =?us-ascii?Q?wQ2grPdSEzCNbX4Tq7lczZjNxyRlFyhZ9UlQwPLD1lG4lZWBvrCgMxF0xUgn?=
 =?us-ascii?Q?werEnPaumiGCwd91jAd3bhZvMbtxUGSChwvY9wPwRg9mlPZzGyGe3HcNSg2u?=
 =?us-ascii?Q?JiRtE7BSJpoBJfEcVAUNmE2msNe5BmwZdl7ZL8e5zwPNyXLLmzRrIUD7kn7E?=
 =?us-ascii?Q?07LDwyGa9sWhPMMspVOs/Tu5DipjCEjxY2Gkh/Lmwra9s4ZbnFM6rNaPLtoZ?=
 =?us-ascii?Q?gI/eYxgmzs9ID77HH1ojki7VuhJ2aihAgW8wLCsi9K0dhN3cHYFUS1AzxMRn?=
 =?us-ascii?Q?1ew4pMQTx1RVNRCptFEU9G33hCLLwumETFRtPCemPyfXOwf29qm47XWSw90T?=
 =?us-ascii?Q?7GqmxEr9UxgcEXA+h59FLG9eWu/yhJbe93RioTsJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8001552-8e09-4078-0e0c-08dd0875b348
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:39:37.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPDug6a5fQa6KFShcM/imua6pk2MySRZgT7Iy7BTlIHf5RAg0gvLfsivMA9k4GxihFNwK0ErQey4cZ0KP5oihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241118060630.1956134-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 333 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 407 insertions(+), 34 deletions(-)

-- 
2.34.1


