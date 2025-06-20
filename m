Return-Path: <netdev+bounces-199712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC3AE18AD
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644AD4A4B00
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A223ABA3;
	Fri, 20 Jun 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Okc8QPkQ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD661CD3F;
	Fri, 20 Jun 2025 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414762; cv=fail; b=LEL5AioTMrP3POq/l5UfEdO0W/+HeVs9J09pko57cZcvHed1zVhE3VOXyYHNiC925I7fathePnHMpqVXcGoJlAwVCYF7Wptk/n4bgbkksSi0oc/kxp+7PDoxO3J/5GdxHoNtQ8ehHZ+hOOI65O/czLb94oWnGXRhnLVkCaQEAsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414762; c=relaxed/simple;
	bh=Jb+uR/ajXrIgU6ZWrUf0dsDyDauMpVEELXo89wGxrV8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AZrc37z2tFEKqDAHqCc0SGNtffohIoopQFQ029eO6hEinjs75nI9uuTCsX6ssKndKrYDfyyQVuf36l7w488+05fzPyFQpJlRBs8ZtLvFsEC8MG5rWaCJvQt5YnIYJt9mqlsMWEvFD/gO/OhPcD0w/e+w1PZoWbEleUsx3nGIX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Okc8QPkQ; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3WlX2pHe1dpwH7A/UvyHzHrOhiU/0CcTWjC5L5i+u9qya2dZkKcrr3zdrelVLzfS1+L4B4Mg2eUVrc97nFzpD6JYP+TogkAGC2oXaK6nMfzRHHqRowIPf7rgAFaiOrR/+7B6/uqkMRiNw+6sgxQRLapA/zJnLgoGaKwyaQWgLm3vnFNVoLCfC1Du3+eeWUcPKq8pFp45iv+1udaP5HUoZGsXosCmCPx2Ih43Mg+GqtLJjNc6F6k7SPCjm6enxSF9iUEofPGXngrClq0v7HSonor8brfAykmrnvEkk3uTCQBsH9YchTkif+RwyzHgMqfFGqtLD1y3QghZQvNHkXF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Jt/DPzp136JvkLWRs/7t7hXi1Gg1zYxRiyjVnUFKFQ=;
 b=SbEK4bQinGVzSf0xwQ6RtTvpvtjunNMZMQ9MShYdVc4ocTH2nUrLSxlWWTx5USKG1k4kdWqSjwEc6zKpUX1nV1Hv+A+wqafZXconFwR2j7U3RlX9z1tHjFZzLByytZGnneF74cgePpWHhP/9T/KZChYJ3m3jHi+zyCP6Z+WyejcqjH9i7Tc4pT80sJYvLWchyHWjhDByw3dScHXQy41Sxm8ouJ5js1FFnHRK7eiGC6NQIyYt77Sz/xFDxcSIxAiM5R1rHMceaDwn1mCSQp/4UqbAcVvPzIPa2XQfjma3C6LD3MH1rLaWtwRxgZnejw1cKC9/3KGLkgTbr6JB+Q0YZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Jt/DPzp136JvkLWRs/7t7hXi1Gg1zYxRiyjVnUFKFQ=;
 b=Okc8QPkQAqM8ehylL24EKnCHWf384dZDMOgw0Plj0GPYwmdnGH4pdptin+Z4Z9mWMQUAhBU4LHV5KQXotnxtTHGAuXnm4HqKTkEE0esFXkWjJK4TnbQAQgQQPMoK2Fr+qkIFKHD4ILOPJycZJ9GtL23jGjCxM4mqLDPBF5p/xQXRj+i4pSqgokZ6pTQFEutZ0KWQNKS+CdWcD9+d35BjBQNGBB8f5YEAOIz3GkNYAh7Ni0aTFxeNMYcrELz1L8Vq0ttwnElGoB8N0RWHTW0e8Mfiy6Q50nL3U/Xz47rjn8esJNKSd9g4qMU7om61WJPMAkNG1tHNo+bw8r7xG5DSaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB11258.eurprd04.prod.outlook.com (2603:10a6:10:5dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 10:19:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:19:17 +0000
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
Subject: [PATCH net-next 0/3] change some statistics to 64-bit
Date: Fri, 20 Jun 2025 18:21:37 +0800
Message-Id: <20250620102140.2020008-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6a18cf-ee35-49d0-6242-08ddafe3e9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVPeaYSUo4q1aALh0OKHdVIAoHeb+jwHVlmVRgrUTurxLaC58545xIZT70M4?=
 =?us-ascii?Q?jTKNv5H+ZOXxIzCp4G3ZqGEvZf310TG1NS3Aq/Mzkj36ludWcmSaE3jBSs61?=
 =?us-ascii?Q?58z9bx+T37ZU6fHkkdIzRrHJCfnVTS5iESTRLYS9taqNwryCSZ9YxcBnpRPZ?=
 =?us-ascii?Q?fbOwSvAfSNJQcYtX2OTLjU6J4cvsQLxzmaCEhw7W31t0/p9i+40JZRPdnU1w?=
 =?us-ascii?Q?WVbu4qZHXlfGJEhSj9q01Rq0YI3TDubGCRLsJICdP+xHinEIXEudtOuPK/w8?=
 =?us-ascii?Q?27Q22WB4TlpiB/+byY8LEqcUxOGNe9x+tWjKHJrDQI/q+25woj3tuI7BOULt?=
 =?us-ascii?Q?aiR2uCnZxRvug+RaWCnWwMlP387Omn2jGb+eaf5VmOM3x2Rqb7LbfYYeSUtW?=
 =?us-ascii?Q?p4AGAflky9+iUbS/CMobIZt5uYdiyf/oRjhd9rRJhur+9k5BNjr2FdcSKlbb?=
 =?us-ascii?Q?eOeAT9jHBhekvEzWIb3dG0IqnIKTrYtRE+B/39eiMQDL3KW7B9GX5aUtPlk9?=
 =?us-ascii?Q?rIZONGMTrVExaUt/BvFj1vgo7InlPxseD4AjlTcFDf63/VPHqpdQ0m9kiR5w?=
 =?us-ascii?Q?3hA4DgP1XQEaS58xIRUHtfUwzZRgQSOMPNmOpx9mR71ZPHowZkJQCcQMluhT?=
 =?us-ascii?Q?skp6/OtlF7USARylAb9hiKw3q7Fp99dugQQnp0/E5yl3IPC2CZFi6e08L1fg?=
 =?us-ascii?Q?KC3mmec5Cf9MCRdxOK+RLspLRls5zcPYuO1L62Lm99x1osOyNqU5gXh8+4LC?=
 =?us-ascii?Q?obFDBPz24VxUnF9RkXM0N1gR5sd5iAOsGFfU8MfX8qSHO+84iAMTc8RJ+zEJ?=
 =?us-ascii?Q?Q9fqzE8CkO5p5Z7H9OccBn0ELT1LT6VP29bmWWMiGGT2mSBAVOX8Ui2hdCEd?=
 =?us-ascii?Q?e1EYmXXt7Yg5Dxd1pu5VezkeddWmZ5yl32ZD80FAOuXfjAQaBd5o0fB9hr+D?=
 =?us-ascii?Q?KntGSdy5XIpZ2Htm9ZSjJzUiroznU9SGvNskNi/SHc4NvvXg3hn9MJySiimu?=
 =?us-ascii?Q?1gLIhrnM/UFCzSnioC1Kc28bDUcy1DLfNvMjS5OB0Yoli+1B+GPnjuXqFm5B?=
 =?us-ascii?Q?T1EntBmi0t5LFyNcgWuIiPFwxEpI4l4qDKPzTJylidkkNQPOVBS7IuUUak35?=
 =?us-ascii?Q?ULPFJKnSMsjBQ0bUJ5eeD90wc0uwosiRdnDcb3GYlMBOWpKWgLfdpoh18+T8?=
 =?us-ascii?Q?xpaxNaImKLw64WQplc+oF9bHRu94hVBORIwgfnYYWINNKoriAe/EG38T1UVv?=
 =?us-ascii?Q?DX340uw/M3XvBk4LQC/jAQNKX8xdrfVWHmxQuPnb/4JiSGV9/01ujZJUKgnS?=
 =?us-ascii?Q?g5c/dpUSOkiDsLpWHK1IvmMbjGLOJbyc9Rdz99sq50ZdD5yf3MNhejv/EZEe?=
 =?us-ascii?Q?ZK5khiSGOaI7IgIbsP5wzWhILZUwXiuXDoTR7/Zf+aVgagLRwjnGzgKFsQe3?=
 =?us-ascii?Q?V+98OvRlbYOtVEHceG4tqhgwi0PONqy99gQ7z9DpP2goU8Dn75p5Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAyEXCxaogIKCjqn2mMcuE8FTnZ8EL8QGcJBV8ePArVUC+iqGlYvR0AVU/pK?=
 =?us-ascii?Q?FY5KDMp7D4c1qXwRBICmBTYnD4tknou53HzsYED35ZYNdSbwlo5lLmUPVny3?=
 =?us-ascii?Q?pC60aqc/UFd6UF6ehG5uLq09vjDY19qdF7R6teqmQfCV9iMI+21nY/9tITBd?=
 =?us-ascii?Q?QDv9fHNARvB1w+K0SJHpO1Et+/3yEmYq3uGJrfswYAtH+3tZmrSiw7/JLJVs?=
 =?us-ascii?Q?HhGnAL1XqOjYsSfUN+57KzJebaqjFzNsXzVzUHSCcLtUl/lIBcGnfO0EK2SZ?=
 =?us-ascii?Q?uCsJVXafKV/80x5dRLMyGt0Xu+U1kdf3UcPDuS3eg89C3SyeHG9Pdp48cPYm?=
 =?us-ascii?Q?UQK48eodao91RtguVqa0iLGgEUK5dC6ycliRxDkwbsnViTNIdeSxv9nDLuxl?=
 =?us-ascii?Q?IxRSQ92FgNxX/fGFXTZmOfJpOl7uljJduB7PLIAsQNz9v5MGSos+RSo+Up4w?=
 =?us-ascii?Q?Nocj/5t1S20kL0PWCrWoPW84+y8gOF9zDYvvFdnY7Jb39UsdA9yvui9nh9QJ?=
 =?us-ascii?Q?6Wyfh65mGXFkHZgc0c8qmDv/nsFIWH2wEfnYljyCD9PVjli4kKoQVlLBSTF6?=
 =?us-ascii?Q?WJOkNC/Lsmi2X5I40Wv4LidElKs/cdsf5GUsOtWWu8MstnM+2JdaPvk3tTks?=
 =?us-ascii?Q?y37r3BGkiagkm5jIlkteub5tlQz98AhQrvEw7VnyPbaVzAhVsaKnW19WXald?=
 =?us-ascii?Q?Hp4VEz+m6ujVICzVi/UNdcZSBcJo5YDT9ASDDKmZjmXzOdrAz+Ab7s5YhP6i?=
 =?us-ascii?Q?lHOt90fBfxPeOMjoKczSMyXI6jGDa3zXy7NwKwSwMafYWplr95kKBvjayQkk?=
 =?us-ascii?Q?WiKxK0G3dkywcUGCYmQ1Tl2dd4QxJOEfAvhpcHQp3ML8AzCRG8t/xQWU5ZQ0?=
 =?us-ascii?Q?pbbPF+kQkfqf8QPXjOmucHBEcFHenxjcxd4DKczpGdqxgGXJydQcahcv25KI?=
 =?us-ascii?Q?ufLYtuGse5c+MV98DO2huCYq04KiqG/SC8OS0Tbw9Dlep6yMXzfDUPUHjZ5f?=
 =?us-ascii?Q?Dtj/VXKaXb20nWvaKqo3yIKZA1KHyRETmBowoBMbPYOYYaTrd4EWhFcrDs02?=
 =?us-ascii?Q?8C7xLpsfnz6DjRcbaX3XnLy/7VRWq/0XtjIfiQWW7Das1TtlRYk9yJc5ieUi?=
 =?us-ascii?Q?mgNsyoX2RAgRAziDEHT7Vo1IKJSa6DAlcyRKILoL71oR4o3D5NA/KQUN1Too?=
 =?us-ascii?Q?Z3caGXYxTNea67FhzhEQqpyqK+YYgKdEqSXSz/knpl+y/oefE+evz9t9ilm/?=
 =?us-ascii?Q?sdbOpl41eEo7Jn64nGnKAFT2iA+t0K+MeX678u4d0vcz4/+/Cf/g0ss/FyDz?=
 =?us-ascii?Q?4kmXQ1Q9s1WINFpzwvATR/KaAkosM+inUR7QhM9xXqv8F9oitzMpmJx5ZFpJ?=
 =?us-ascii?Q?wTimXXYdgRErD9b457OGC07XtXfv4+CMI0S68/81yGMom/+j9vxHzVNE910H?=
 =?us-ascii?Q?PXArla+sSMAhaLJ8F9R8SNYZ9+E8985OOKiCZP/eiu++zg8FTWZUH4HchjHX?=
 =?us-ascii?Q?0pmcVeyabrefn2+D1jVKi2xqXDlW6IE5J1Dyx1H+XXoetICXje6kZjj/pWx4?=
 =?us-ascii?Q?JPczFIWKZUBdTTw7ov0xzuQADY19jMd/2Rx5XPDd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a18cf-ee35-49d0-6242-08ddafe3e9cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:19:17.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfsyY8cMPa19q2mfJB8gAgs+tn8kVOJbASLEgsLtuZYq0miYhmxrWVmd9pYKa7Wi8oE0pceFGhREbuCLBDeShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11258

The port MAC counters of ENETC are 64-bit registers and the statistics
of ethtool are also u64 type, so add enetc_port_rd64() helper function
to read 64-bit statistics from these registers, and also change the
statistics of ring to unsigned long type to be consistent with the
statistics type in struct net_device_stats.

Wei Fang (3):
  net: enetc: change the statistics of ring to unsigned long type
  net: enetc: separate 64-bit counters from enetc_port_counters
  net: enetc: read 64-bit statistics from port MAC counters

 drivers/net/ethernet/freescale/enetc/enetc.h  | 22 ++---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 99 +++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 3 files changed, 68 insertions(+), 54 deletions(-)

-- 
2.34.1


