Return-Path: <netdev+bounces-144019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E869C5214
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C67B2FA18
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E620D4F4;
	Tue, 12 Nov 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCI8hVAq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E8C2123F7;
	Tue, 12 Nov 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403842; cv=fail; b=i6/E7LEp3HHfsg+tE0Bc+lF1sT1rAHl9cJgkpZN5bsR/kFV5XJ+nP8aWtSJxB7EjDzFrNB8w6+0Wseua7Gd9wiJFzdbsVfNmhz3BoTpjwb9F/tH+QYHK5aHuP29a6yL9RXBGjcZx/+K7qDbw1tPHWP7a7Tkzp7hKca70bRcdqKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403842; c=relaxed/simple;
	bh=X4d44crqkMfxyx6J/7WtVEOEq5iFvpaqo8i0V2Yzkko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USzzD73ehlrK5/sdNwRneqrHAEBc2RLeZikrRtWw0F3aaLP1BVrJwdgD1K8C2aFa0zT2BWXWj44sTS0AopZl7kxYc0kJ2klYGkQKB6fMi74BqsLfb7JBARN8JCm4oYFmxLBCNo37zfhV22NC38Jwm3xcdPbWDXayEeUVmd6IWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gCI8hVAq; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQQ/D9mSLLdsF2cKHa7hjopADXk3nUY5l6pokggLH2nlPMrCNeZFpLzS8tuwmf9mXwz0akiBy2Ns/C9qm7Lsn5m/Mt4Fivx0snIfjIm7+4u7XdqSnrPmKZZ4dXPSFtsDekv1lhMA3/fDK/cv9ZJgutoDxExLzYL2ZJEaQMoik/CKf4a8Sx51Es4t3PiGbuabALb7mIu7tkIOM9tW7oIV+zMhCj3ovhSpIvSqbmI/DGPq83jeS+3hY60p8p1xCioR0+HEGIIU1pDq6wAJwSrMTjF5Yba4mKz/iXuj4Av6H9q2h89XWf8qQ8/igy7mMJOIe9jHvPpFxMmRcNxzN8mSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ssm4zWHRK1/jOivf8RW//M1jW4WvovXFyRb6moy2Wg=;
 b=PUNGMvEBqNPuCxMMErUPbTMLsXLZcAO5WkxB1iSjfXrn2+4Tgery0ddJUZYDcTBO03axkUZFA5nBGSiPXTiscPFRzOvI2AEBsJPe7u3r4EpZOLaYOy++DFwbTEIdqcNEVuKEeqjeJa4V8nDTWwZxxoIUVNdBGvERvYf3bL+OiJNNQ2LMrXXKPkDwM+ItqI8imS9stdV40onVVbve7Iqy3X3+1PDhlxtP/2PouBGUQC3u2ZXRyyGE7MF0Y8d9995is9SXvGohmQFiiddBjMfdHo+VenwOj/Mb9BdbVJkZ4RCEc+XgYu03IzMt74QaU3d5zemPj9XYq/R9aIeGhxgBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ssm4zWHRK1/jOivf8RW//M1jW4WvovXFyRb6moy2Wg=;
 b=gCI8hVAqUnpLeMXGHBQmtp87St8y4LWafAp3oWL/irguOPzm7k5xltEiQgrfm+MHm/M35zvq0oOl0o237tLiX6pHJaMdiSgYTnV7UVqVYnM6tHpAE2NzdlN3fXAYaPu9iisDOMJTlfF/ka4YVobhoGck28OT3mpLsJ23vrxopOVlJlh8NqNw4Ic74rAJRDTJ6C8/OxocKf/F5mrC8lzuHCyLWrW/x7KCnORVCUxIV3AnDqbQoJuswvGVmXWBDm1uhoElePvVqNUfHRUIwVeGjwOPn8XssxhZecYPMzzXrokJySpOeYGQzTWkKtd4Xi80y4t3B8H08dddXYq1Uqt4uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:30:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:37 +0000
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
Subject: [PATCH v3 net-next 5/5] net: enetc: add UDP segmentation offload support
Date: Tue, 12 Nov 2024 17:14:47 +0800
Message-Id: <20241112091447.1850899-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091447.1850899-1-wei.fang@nxp.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: b783455f-ded6-4e71-7e56-08dd02fcaa6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pn3p11h2rmTG6p1emVmA3xNKJfBKBvpLXsy9oXpq8iwZcEKDITxpYg7bT478?=
 =?us-ascii?Q?fL7FKiO3d1FRP7jMAf4+N2yaqkiGu3b/0debhHITuX/BqI1AIhn5uWhGpaIo?=
 =?us-ascii?Q?sfKhCTyHh8Mzp5IUrVEMv2mit+QBHHPg4tytCIRwSaMMG0vumimrwJZuUtcE?=
 =?us-ascii?Q?iULAA5y04VEELvwi/qSRWk1zRpIbfsLzJGu3DKzxWz9AFNKwxGs+qYHjbUDn?=
 =?us-ascii?Q?kOeLwCNh800ouQSh+DJxKW0D6G9lr1g5saZQ9UVMviOCTj010JaWEhBH4Zse?=
 =?us-ascii?Q?D9FAem3B7MylptHrf4eNoFWK5GvBD+1mbQeGs2VYb19L0v+e+BYN9YQJ45rz?=
 =?us-ascii?Q?PDDgQBLj5+QI2S1dTKKVLbqzIxFw0NezeQZAioTC6DQrraQappjAMOW58+NI?=
 =?us-ascii?Q?0gSkqB7sNTk6JyWuoz+G6NF0ngUEzivL/ObwGjPevu27BM5s7PfGDEtkwT1e?=
 =?us-ascii?Q?4STjeggX449+fuhxZMgmf8uRtDkXUCLGq/dTb5rLbka3+vjxDIVeElbGjze1?=
 =?us-ascii?Q?NLDR2pLaYbE38Soci/T9rn7w/PaHctwEb3WnP3ouP0p99fO4j4ngbGngJ2ZW?=
 =?us-ascii?Q?M1pAqf5I6g7Z/INsprCPTozUr0gWof88IFFKQPo5hcilfwgPz3EX2IgO+7Jx?=
 =?us-ascii?Q?t/cNs5acOiOHYxeuIxJd3NWJKnKODhVsPSoofZqmHJzVRGq9Z0coLX8OH8bt?=
 =?us-ascii?Q?Ynn0JpKiutjTZbaVrCjphED+Z16NSTM5BR3LnvPk4OzXq9Uqd7PRK+MP2k8c?=
 =?us-ascii?Q?ZKKmpRLzASI3KMeiG08hZgwpkgVDUXEOXbcfHuyUUKSXDW2PgGSvYkM21jpi?=
 =?us-ascii?Q?O1a2+yDBoTjrharM77bSqhSchraRP4BNxDAldKCSopTJ6dSxAXLNSCcBcwDH?=
 =?us-ascii?Q?jdX7N6H31edYwiKzvL4rnki6xhCgrhjH8llEuWWbl+wC3V6mWssfK0ZAktG9?=
 =?us-ascii?Q?Jnw78PNjIvmrqtEMP+Q6goCgTY4o2GLQsga6ohgzyUO7L4o07LnwPXX/30GA?=
 =?us-ascii?Q?V8iS8BKxGdgVLt+Y2WYGGB03zfyg4ymPdmmZ8GwD//54U84NIAURdVMHZG/Y?=
 =?us-ascii?Q?iE3nKfQytBrvNo58ctc2ldbbWN7t53r0VYa3pPWP8sgkfcNfLI3DYSUQGXDP?=
 =?us-ascii?Q?MFy6JHa+CzeSWTfxNaYe94MhNAqrL1CXVH1QBPjONn10jV+d/2RqyLWfyBuT?=
 =?us-ascii?Q?WRKE3smglLbFpNpBLT14piESFm2qPeSZ8JI6+mNSJHyYfoDxRpiok2dATRHp?=
 =?us-ascii?Q?SmzXOvUeJVi0+JIOb0XcQoAerveY5XEXd6uUFUtNOke87JvOZR4bdL/YRR6J?=
 =?us-ascii?Q?fP04OX3iylTFWCZ9FFshUkizr1VjjfU0NwJYhv1C0FDe2ANh9yvuU8+4E4Ob?=
 =?us-ascii?Q?pnz5yHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DMPAoFEucUpKN3QdFEkA0OC1WqqxVgXUbv5F+QocDDVxMW0PwE3aq5l7ymN2?=
 =?us-ascii?Q?2OErh5ay+wOn92dcwlNcs4XIh0gxAkgkvvKWzl8hPF/+WZQ9CYmYnAzRP5zF?=
 =?us-ascii?Q?6YLKHyggH+ASHWhdy4TWPfLNKr2AbtjzSbX0YoGXutHBfw9JpKkLab+kjBXo?=
 =?us-ascii?Q?qCNVP1PgJoQt2es9X0nZwCWSGLdAUe1CkrEZ7L3oR86ei5lHExGpmG3U3tF2?=
 =?us-ascii?Q?2F6Z4Y+W4IhfsrxoA3Ur2CHgTNDKS5sWaPL5np/bQlK8njUhn+bbWbT7Kwmn?=
 =?us-ascii?Q?XyOifIy0cfBjvMhP1P5orZvgsp1DPRJ1j23qiKLcbr4sgwzUnILMXVYfNQDA?=
 =?us-ascii?Q?vHLC2g1uDYn0PX0vB6fQFpu6jUCQhcPWqeomsg5H4JLLgwP3m+C0wlArzCOb?=
 =?us-ascii?Q?sUG+2pN6WfcAdM8+9cwD5gzcfhmg1R60zXV/GZLyAYYikVhjvdeD1rHcuGmr?=
 =?us-ascii?Q?6lkVdXHIHLej66SBwwXVgXwSXwJyfaLpNtw8dk/khPHmYKiNywQ0BZJpujIU?=
 =?us-ascii?Q?v3qhMFpmEb8D+ymkP81frnr6wtxbuD9fGs9zfKPFSpzDxLIiEb5DPHGINUPa?=
 =?us-ascii?Q?0WNqUuWpBV5PyRzmPozQSaPwmlW46vyM/ykfR5U7YnLQwPfrMQpWM4PHYS5c?=
 =?us-ascii?Q?rHbToIYxkil5ue9q+jOsZPued1oUzxB0z64GveSbJafAF2lFw4DrcW7E7SxH?=
 =?us-ascii?Q?grgCyyY+m0ToV9lYUwQ6o74Cbh1f8ZbzkXdLHA2lphO59u1ngTo8Bo5nwOrF?=
 =?us-ascii?Q?mvlm1Nb76A5YdqbC0KrHvB7Z/OMZYpNk9ZUwh0e56aVP8nJqXbmpSh1ewFYR?=
 =?us-ascii?Q?st4VZSmp1/GMw4XWDCQpgZmPZettrvP3fB7dm/F91X7CmRFRasHh6QuXvIYl?=
 =?us-ascii?Q?WYDvmnxAfrVjTzfFxQ0iLQ9bGShG5wdb/buaiK2Is0uHe76cR86VN9BCcTge?=
 =?us-ascii?Q?7t+udv6gdEhG/Y4MJO2BnclQQ2E2qDufjRtdn7Apipg/vJJLqBO0HzwlF3Fx?=
 =?us-ascii?Q?KjTgk8iDLXKBaSkHwaoGsTlRTfFmNrKJLT/IOpyMJgKAL1a4o5tDCcbzOBgW?=
 =?us-ascii?Q?CSs6NPG2qpneEfzEkD2eQ5mB8t2AXt7CgVo9/n6YOpWcBz/cLjdqC9b90HDZ?=
 =?us-ascii?Q?HesP3Gfg5+MRyIPDYJBkdQKuc3+wkQaj7vLGK4SlEUm8TpXvDmlqJxKX+bnv?=
 =?us-ascii?Q?nyhPkLaJc6ZN+QFJWR+s6W2N9P/X+TlqDtLBO+z9whjAwcculw7eMl1ITl8m?=
 =?us-ascii?Q?qBCH76mS30GrfWgPjmw7oIdzJ+i80/ueBb6xaImYt9DCZ398P4h6Otpvu8RN?=
 =?us-ascii?Q?EEvlUee8Cew6hOPg/bqi3NqMhJCB+JHGkNqiqeo28B7OVDf6q8cbQgQc3vyZ?=
 =?us-ascii?Q?oP1SNisiV8gipt/An0vU8kHLDdHSiuyORryJVRVRjO7pwXW0l6uNRB+eHmZY?=
 =?us-ascii?Q?yF2FEh1i4GTd8bH0j1tfg/EKH9SgNiGrPlyeLS9iPPOtegjR5xVkklM9jODh?=
 =?us-ascii?Q?YIyIW0bf/ujaYpXWTyCPnpezld+vUrErtCPAJJjXySnIZuM9Uq9A5uBvl7ER?=
 =?us-ascii?Q?0Uo0lxLL9aXmwuo/BUWGc/0UpNsGK8n0bU86j/G2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b783455f-ded6-4e71-7e56-08dd02fcaa6c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:37.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZpQV9A/f0ieHFfhGB+wXYKQvaf62pkPF/CuRgVYZvuzxJVnCgD3jvjrteXzwxmDvdNVOOLJcCa3+GThVtpt+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339

Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
enetc and LS1028A driver implements UDP segmenation.

- i.MX95 ENETC supports UDP segmentation via LSO.
- LS1028A ENETC supports UDP segmenation since the commit 3d5b459ba0e3
("net: tso: add UDP segmentation support").

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: rephrase the commit message
v3: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
 drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 82a67356abe4..76fc3c6fdec1 100644
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
index 052833acd220..ba71c04994c4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -138,11 +138,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
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


