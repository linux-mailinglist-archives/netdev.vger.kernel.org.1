Return-Path: <netdev+bounces-218117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA2B3B284
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD681C85F70
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63E24635E;
	Fri, 29 Aug 2025 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bz4CLrl8"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68A24503F;
	Fri, 29 Aug 2025 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445294; cv=fail; b=N1oIPjj+i+Sz1OsoNXi6oRvwDEHxMzNNFbifVjcMQxGLfQqKTK+umhEmwlAWxwJWn8+T03kDHDJA3+aP3a/vknIL1YL0rQC/X/M8bJ+wdXbWQuG39BRwL4dokYgeTQ2A7gJhMTLyh/6tPvQFTij2hXKEQF7nwgXY0S3ECj6r3Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445294; c=relaxed/simple;
	bh=UTJojxAfJgGXQCOwb3TK5Rtk/qCsTObezhIbI0siTzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=km8HCF/Bs0JK79Jkv8r6BUfl2geION40jzOiPU0iajEDYol2dhETKneeUR3auRRXU9bBf1WzyG3maDzO0tSyo5/Lj638rpIfaIxeJDYNzVliktVGC97LU/9whzGJaLWe3sXUNMZZ10XIujJWoopLK+ERP9cVdi8fTyizVfSEl9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bz4CLrl8; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFouBndJSHBW4EjRnWmcGpvV0yH+DQjUd+RkSIgzoKLe19vNLdwN55Eek/WcrnpWNtxIXZkh/XUKwQcKpqvUli3sM2an8Utp1BoXzDPofLeig7rX9WyHoI+sbaiwQNVn4NObqpvF2J5+6UpIKK1q0iuVq4JnYEnD22IWzzMKsZpdUQI3ygWkz6MJwbeSWWg0RqTWEgN8K4I45MncND3rSVBKu8bFvSRRRAkf6aJcdKNXwIS5Bik6IHDu2oxdnAkC76Yb1bjqlcMy0/qlwL5LeD5Q6MoGeWQcglbgzmySTo4GiZdkKoL90Kn0dk8tPwRzdej+KMu5UG/PPfehjU5fGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=oNjVuS3znFSWHJp3566a4YgjDgjdnoEXQEOt0pR7N75rkcWyxHtWI8zEQdgBjux7wRQYp379RnMK89PWxXkIsPVijr915BWqn8IOEPbFrYy5Eq5qxChj20TubUthda4Eo/wQaTxKULAzW7cYvGiZRlnIjR8uYF8jI+H3mFi42cnCE9L9XJRUi7S9/lB4q4MWt8KCjnVScHGj0RynmqfMzcPBVCxanwV6vX9LgJvqoE5ovtwUtwzc9AhYPgdQajf5uoG8T3ucdZQS4xXKfZ+rWoF0fAP1/b3NAJ9OKP3KXU2oS5HkGo/3kJ4Gi8xpWzko+3+QKB33JjsaYCiWWVcphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=bz4CLrl8lpO04mf6lqW3W6JNu7EyMfbhkZMQVHyBXkFcHdlYeUncL8SLBhmFp4tqkknUczUpTI6L+WMloI5iIu4d/9mEthUzPP8aZoshTwIO73RANT/DinIVZcuigLGA1Qa77nVPqSxHiJBvrL2j/WCXVixu29nq9+7p52S8ZZXxIph6Nf+NDpw6EDtAQQCCnFPpk8FjlE/v7saVjcIH2cWKWxOEx5oQGGrfbpJiCLnLoXjg77ZahUZctICrWBfiwY/fuAvLgOubC6+Diprl1WoFvmMSu5qC7fyn4AWZpc/4uf3SdeVUTfUqT55Aghlg78o1M0Y1rFGPxNFWL6B+Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 10/14] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
Date: Fri, 29 Aug 2025 13:06:11 +0800
Message-Id: <20250829050615.1247468-11-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: a28dfefa-1250-442e-6649-08dde6bcd6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4ic+ZfA4g9Fp6Uq9uBlX+KWUgwk3LrqGVfp4Ysis4kb8Kp8KdVPWmSN1so0?=
 =?us-ascii?Q?0uEhod6lbYggC9pQ5nu6y88kLTylGadwSBP28F3T6jfJD5OwcqUupQGeuyCr?=
 =?us-ascii?Q?fZ1fC48ZrvF+xrlrC3rIqPW8wpjWQWaS5qccM5jkO3bnXPf4I5BFPD+vrqEI?=
 =?us-ascii?Q?YXTUX9cIqzbmR2ie47CtviyuWu16O8Ph2ljpJwAwqvw0+YSkaKBvFBBTHpuA?=
 =?us-ascii?Q?tnKq0THLSIAGMtXR49NICzV/9rmHhF5XurSBadDOVenk7oc4m6jJLL1vA9GQ?=
 =?us-ascii?Q?dPXKr1TSHBk5zEwmvPDjobHzGTIQABvDlZbqO4DjmdUAb4EL1FI0IpHEaPVD?=
 =?us-ascii?Q?B4eJ+8rFToRn7P4czxJZzn79/R4cXadQw4Fjt9MFlYP8gTC7JkEV+pNmOr6J?=
 =?us-ascii?Q?DYqTkaDTzzNCW6sGJgblPknBlU5zE+n/lvhZ6j7WOfVkawywsXw1wZOQvRnp?=
 =?us-ascii?Q?P1N3s4v78O71DwxWbDiS/u/cUp6NQV7trqNBzS7/kBXel6ixqa+/ejFMKbEW?=
 =?us-ascii?Q?vseq/oIGRU7ytnEm6hxrNrt/H4H2vkw1BwXvWsAavSTz5apdiWVqHgO2MCT7?=
 =?us-ascii?Q?WD5uwjppVDkNXKFENUBiZd/N2beN8LGi1fsF8XxsW6z0NLp9+Wxa9swqyzH7?=
 =?us-ascii?Q?rzvby223U1/VC6E55wql4TSRUjJhbKPz8Xn1wHRg7oFN0Pbm5q9hGTq63HW+?=
 =?us-ascii?Q?JlYVtK8sHCQNTTZqOv4ZjYATwM9Cn2SvWqjIom8V4dufm3+XlHS+Mj7kyLMQ?=
 =?us-ascii?Q?XYUoJrsUvNm7R6ldEGrTSuvsGHt6Cl2ELibeAfJfpGSQWuRLTJBurzHPi/c7?=
 =?us-ascii?Q?lFvmNF4GK0iJeTvayeQeKkpm5lH0GlKBb9Bdn8nh4Jk4eamdSYUsj4BgHIw2?=
 =?us-ascii?Q?PQnEH5QmZoSibUXX+p2wudzfZBgiyHxxR+76epz8C8XfecKNm/9+wS/nmGrq?=
 =?us-ascii?Q?CjUBcQLyLrznNGUBlOl46N+JKPxuBGGQRieBebzCEHsoQHqnS/9JxvBvRqqE?=
 =?us-ascii?Q?QmD+GANGkSZ8O9cmMc5F4JHU4zzelSusv/e4iqoISpea+OvBB4ZwTK9Gglj8?=
 =?us-ascii?Q?YbBHoL4JaLgDDSWgwAf0Q2PkBwABhLnQNGLUQ8azS0lET5pyOlG/7mcU/ISJ?=
 =?us-ascii?Q?qMOMmhBIcTe4UAtOb3S2Ju+/UOsaQqqCTDPtD6A35AL9GVSorCNJvsYoiuk/?=
 =?us-ascii?Q?JPX7HToh1bzd346zULmtXcIXgKVUguUxznhVzEPfLFK8aCRuDgKiaDfAPJBn?=
 =?us-ascii?Q?omzaJX4XGr1UpvhTmYsqvFrrnb9eyGdWLuD1SimFH9qqXaRRXsEOgZLnAM2Y?=
 =?us-ascii?Q?X8ISa5LvGRFdQScGEQ2f8RvW1H7evYrrCZn0WOVANbOX8ri+TSdODKgSGYMN?=
 =?us-ascii?Q?xmovdFwQPKz67+iAVlFUR8xuX67QsU6zualD2uwO5WxN9qL20SvFcsgsdlTd?=
 =?us-ascii?Q?ky0T7J689Y7Fro5hHXL+dY8JUWTWJrrKMLFasLMBEnXT0hyCVxCaPFEdmNAn?=
 =?us-ascii?Q?CedYomfpnpJdh50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zUIDFdjY6gkf3rb/WjeUN31/sfPQeEsOZZVIm537xRvSLFKdfM74sHSOXxf5?=
 =?us-ascii?Q?TZC8cX6xJOwx2X5O6Dxo/G98E6nJI63rP+dOdU9a/6xwznojNNT/hpdrgsKa?=
 =?us-ascii?Q?xRRYfsVQwfG9nJh9+4ONnilWxf6f4XKvPKbDUUiio04ZG4RiYuLr/AD0Fomc?=
 =?us-ascii?Q?s3i1J1VFhgE6kM4qJ26sqydi+xr7lYIfTUZeri2Lh1Ou5k4sV4VE59gbd2PW?=
 =?us-ascii?Q?2Jn5PWoA11r5YjTXT8FV7ia1TFPeDODUPBdNRIKR1NcfSMuI2q0hK+TJWMAP?=
 =?us-ascii?Q?EWgzbN0ck4dCuAcHv4/pJnXwg4lL2+xrlDnmlhlaupxmdblE8wMf2ctiesPA?=
 =?us-ascii?Q?W2y3sNhQJ3YnU6NYugK9TzFxXgsxQiwb5TL8tzglpOADBt5u+JGN4R1LGXdE?=
 =?us-ascii?Q?jl/1XAb7Eg0X/0S44KXTXzjePl/yTHclBQ32Fp5C7rTeVAvjx/s5NPj+5p00?=
 =?us-ascii?Q?Swx448r5nXwEaF1vUQXAa9MW8/9q5f1pheQ7gCMqj5YKHDRVMuVgeLQ5aDxE?=
 =?us-ascii?Q?Q+3e5aBGAAQukIZOvJG0tLnlkvlO9EHbnX5/DwiTsZ01xYhbcF/zPgsLHaCY?=
 =?us-ascii?Q?SZJ5cIJDyM1gefqg1pMNy8emrR/eWH5tuTaH1ysVK7qYuDX6BrKFLhbyCEEF?=
 =?us-ascii?Q?1t87tBrG6R03+3hmcFulk9BHnNC7HoozZ9Bx210ydXdc3qcyPYbBOxuMRTdv?=
 =?us-ascii?Q?NCUfYXMOirKjzMBxDHs/4XHh2weq5V5L0E7W7l8sOypigli9s+l7IHiUpk6C?=
 =?us-ascii?Q?jW7iJL1HKoWSGySkpQDYMgltmSc9BwDr0MzSDG8tcg9blYFQKSjcu0x20vCG?=
 =?us-ascii?Q?HwMLIpMY9w+AMjwWEt3kga3x9lXiMB9hV5WQVR1jLWnj4aVlC5AGjLyBgQFA?=
 =?us-ascii?Q?2EvN9nZUFpg0MU0xTZKd7qPz7JOmhzrcC6XGZRTLook7/T1sRZRCgp/+Nvgo?=
 =?us-ascii?Q?KwbRy1ac8a4qvNB9bBgkhzRTGOmnMrpoxw03Y3VGlL3e4DM2UCylS1UPe/QI?=
 =?us-ascii?Q?lV6PeeWMAODFGtZ74I0cdXqHujlC5oYF4Koib7JvEzjvKi/GXB0cKdyDBtFz?=
 =?us-ascii?Q?Cv3Y2GHtCx9bO/DXrs2tnOxRznHHv0RsJvSXWrFQ8LwsWdSt7XhyNqerwEmH?=
 =?us-ascii?Q?+wQ0rJ2JBn0LHFXB88ryf2o0OeqFlAdZCSqmqsVmSHBTeh4If4xHvPb/tgNJ?=
 =?us-ascii?Q?aYOQuzXMzLex+f3R26WBN7b9rG4JF6G8aLNE5zjsk5AP2h989Qzlte5ctqtU?=
 =?us-ascii?Q?9tmyy85IHfAuGfZs/PKBkdpHLi22DXFAeiCxqsh72SiCHO/3PtCxTYVCAGXj?=
 =?us-ascii?Q?oxgQJ+SjxN7HBSKrYF5qF7vwV1qccwGPCGnmebZiIglDJtIla8v6fK2h5Ddx?=
 =?us-ascii?Q?RzPjgS+auJnbpCWLy0J39KWI3saIiIHjOOQJzLyhh4CR6Cs+Rh1aVdggN1Bo?=
 =?us-ascii?Q?ffLXm/pPi5fuXHue2benTot6kaEdB01zQEd7Bn7WE5/0dEWXgHia8apo+IUE?=
 =?us-ascii?Q?h3N3jtZQxozZrHn8+Gk1iFu3psUt4LPnuVhDfoXAB0rfyQRcK4EimA5y8o45?=
 =?us-ascii?Q?52KzyBwvO5bGY3C7itMqa5Ng7XITd5969xr/V+vw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28dfefa-1250-442e-6649-08dde6bcd6af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:08.8938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAkVdzgFjJ9AelzJmXYrCFxScgLmzzpCenESsOK7x1UYIzUFop16eABsDGo73peraW/CnKwNq61Po1Lif2QPyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.
Prepare for upcoming ENETC v4 one-step support. There is no functional
change. It is worth mentioning that ENETC_TXBD_TSTAMP is added to replace
0x3fffffff.

Prepare for upcoming ENETC v4 one-step support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4: Add ENETC_TXBD_TSTAMP to the commit message
v3: Change the subject and improve the commit message
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 54ccd7c57961..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


