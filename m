Return-Path: <netdev+bounces-181587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41873A85986
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2899A01FD
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA563238C16;
	Fri, 11 Apr 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MXum856j"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0108E238C07;
	Fri, 11 Apr 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366674; cv=fail; b=X9hepF6SIk1LhYaq24Ya1O82JCt7PJ+cuPsMtqHPhezV2PvF50FZEJU0/c2OIPEdbS8xmm/B2PtYeeAV9YWwnsC0G+06RLmabfDjVbI8WljdNhyzKInJI6a6wIGECtYaFS9oBzc2poK3w+S+8Os2B4gC1BTB1UFPd80RieLg6r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366674; c=relaxed/simple;
	bh=W8fSjL5j+M8+TfQhIFWXRE/IBb1frBIfPAPvhSznVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DussiLO350gTRCe4FIxmH7Tx3Qx4OIA1TIHuuVCA4GCDh66M8/x6QR8W4cpiwbUfa5+i86hgi45dvnaQ3iQ1qSg8dBmU3pCm/cvtNeJ20p08xGv72zIz7iMDjzBgX/JD/B9YZGDAiEVgwrJw86vtOeCizh4fNxXrq1SAlRRtA7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MXum856j; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHg7ZICMZuNNwUK/AhxyYgqfLoyyBH4ZQa7N2QKt+JTvEVbjvv6jXFR9j+8Bh5QpDuxtZ2H/2TtSo1M3s5rZhdOI0KYiazjqbn5X0dqMtuwXVvsJgqwWyubShbjJt7DjGZuzNenLKP/nqiveURB/4fkSxd4y5TfW0L5PHHLCfV/ORhJQE4G0kFb2Mvdk3gAgoDEyH89DlFdemWF8Ndd0ZHnZv8iNKINVPxuHmBsMTgh7Jp0u62T6HgZewOpwQDB6ZfhaIJwReIk44ko319GUZEjtP/0GkG0ck8RL6YPr34yJvg7I/vYmDW8RPzmka4utlFxsNSJhpkomKCYN3ZmgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Is1uHO71URAcb+jjRjF9aZM/vERo/yK/4x/3VkHvY=;
 b=ftMgbuGv0Brn3Qgq1FqwQHTLsyB1qZCqTjMW2wFQrrwwLIJkdTxuUzv4amm6HSVu/aJNjEgnfH2sgby0glzNaRdZn5aM8LaxdclaSDbj4dxZVG3lTLnK3EEAOADDbvG+OhcDIZOQCRbuQhTjDvjq5oiHeULec5Xm1j259V9I0lFBDVQWaSTwEF4Gv7/+dYAyEDX2kMdzHE9JGOoXMx3JSKfDh6ZfmwoVPFiNYtZocXmHv9wJdHjMzmdROO/Zi94Z1tv7IxDK0f4JTsOLjL0/Slwm4EfTb8wOmWfNrQcI+Y9pPKwM2RUl1kqbglvnqTHMRJaHHTPBixdkGD4dPlZKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Is1uHO71URAcb+jjRjF9aZM/vERo/yK/4x/3VkHvY=;
 b=MXum856jSMqedf/6EMYGxxphSMlDNyBtBxJsXOw94jAXmarQfexpiLHb8q/o1kVFf3TxNIf27H9ORk/2CJDmD9BHrOf+Ttgzf/J8hqvyxuSzRgzAqq9BSj9f+K+yJC4N9ItdqCBI83Rov5K3I75Sof9Q32mCJrIjBVqk7RAGu0ZK7OP0WcBmDehHgkXozaumxc9Z3Vm3bebe00qo5QLnKyOF2znkBfI+I0VHhS4EphiuBhUG4wm9XZX1ZSKWP5/kdOspoMd81dq9VH0M0e5gPdqkS/yk078NG9lxB+iyyw8bmBUSXv+injtdXdNMTUAepdhqEreqi/MTwcEo9hByfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AS8PR04MB8900.eurprd04.prod.outlook.com (2603:10a6:20b:42f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 10:17:42 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%3]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 10:17:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 09/14] net: enetc: change enetc_set_rss() to void type
Date: Fri, 11 Apr 2025 17:57:47 +0800
Message-Id: <20250411095752.3072696-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411095752.3072696-1-wei.fang@nxp.com>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AS8PR04MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: eb627ce8-585e-4eaf-2f8f-08dd78e21837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWtlcpJYcgWEpr3g5iGMhkHmJp4RGjYTg6+nhNj7bCaUHg1zmgtlwrbFJwVC?=
 =?us-ascii?Q?hYhNVckQQv6GFIJQGfHkJZRqrnA/Grj+PAxfpfwe1Rww3nSOuftPAHJ7VGz+?=
 =?us-ascii?Q?S9Z3AIZkxeMcTGeVakAE+y9nNhu92H3UeM54PRQCiVKfH9RXH+l4RZWmyb96?=
 =?us-ascii?Q?JngLKaBOjGICDwSEfbHwjTTtLQrOEyLoHmciRcqvzS1GcRJtJQtG1MD+PwRk?=
 =?us-ascii?Q?WPUMI3r+DbGPfdG3XF0iS8tBedw3wu2f9CullSC7BzEr46/2JAHstErOYWfq?=
 =?us-ascii?Q?Lu1NlaigMnIzwQ9CY0fz+hqpcIrC3nHeialLAKEIrvLcTVuFq+jMf1sIJ6bB?=
 =?us-ascii?Q?HcgQo/zlHHpnuw6tMzJ2Jg9Cgs5hcqlgXQFugVb2YjmzBir1R50ubTi4FyxX?=
 =?us-ascii?Q?Udv4dk2u6zvgO9Vyg5ksR0Yr9lH28SW6rOyqh8TADqTLh1Tim439FWm8nRKd?=
 =?us-ascii?Q?6Hq2VRCoHYWyRLktQP0OXiNKbQbNFiSMyYmC5xh5WeKwn9iJwhQIdlDxqtAF?=
 =?us-ascii?Q?IszKWfI2W1v6P5nYINqDFw2JKPnhYuHL/eHzMDPQw4ZKCgQYkAiXt4DDhszN?=
 =?us-ascii?Q?MnCel1PG3i0Ud16F2kiuVv+waZMmMBUTX/DYsgSJXV7zQ2UKFUDc/gtF0n4T?=
 =?us-ascii?Q?LM1iwMVDNNk5EB0XSyOK6uK+uxYoDQPfyHvlaXX7A6qO0Wmwey5rV98sqDc5?=
 =?us-ascii?Q?7dAmDDSdNUGl99yAiiya179GUhww0s3YFpNy8eIpi9X5wYnIuzLTJA/7M5m6?=
 =?us-ascii?Q?EqypK0IjCQpF/LRdLQY1ojso8mgMpgijjefDv99IoihOzsE3FOt/eViWPcSw?=
 =?us-ascii?Q?xOWKwO6lZwSeBy8SpwGht1cBxSvrnBYybXEEXKTNaFSJbeUkafyFnFEm+0Ow?=
 =?us-ascii?Q?3+MP6gPonERSJ9l9rBgyBPViBclGwltIkW75GI+xunGAs/JPETib3yb/6RyH?=
 =?us-ascii?Q?bTKihd+roDx/sZaN2K0ihA5Day8LZec/9LYBcGMK4/2IyyQmjwVJp49jNNcd?=
 =?us-ascii?Q?OoCWXmHy9QECBYr7HHkrGRegVbkyqAZucUAYPDMJjl4nHg0JHNGooo18qkgz?=
 =?us-ascii?Q?uwsjMsFgrmkyUMCeCce82ZwAd59LdJcNw3Y3ytLovqwk37O9shSxF+46sop5?=
 =?us-ascii?Q?nqdXVxKETqfvUHrloh0izp/gATEO0O0i9i+/bwI76V3EbxdNG6mO38I5Tiix?=
 =?us-ascii?Q?zSBDVtOmKCfRlx9dr2ZmEc4a4xto6u+9mRDyRi0X0oN8JWalXTDs5RycvUuh?=
 =?us-ascii?Q?XSuxv/xZTwBhRDyyplmSmDtjI2TF/6gpw018YS+bnD+fHSBMNp+WqGow3t0J?=
 =?us-ascii?Q?xSQBKK1WJTCo/M0STxRkV5OoLb9Z9c7Az3B4j/9/gA1DDrXSD8yBZetCnBwJ?=
 =?us-ascii?Q?9/rzvv9B7BxUfizOsMTK/z6S8ZUA8DaMkouGmhtWn1sbvPgYCcKp9Zn8DlDE?=
 =?us-ascii?Q?bHLNzkwDzX9d7LUNDaxOYTrAqG4dA75kBXgaDNMzpYOoA1V+N68W+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rjyG/Yc+SJZzLYMHmrOWf1jDwytqPERSROAhiNXSRrXVEjuje0JC7YGBDmTP?=
 =?us-ascii?Q?2/lIOgwc4vrdGbXgJNq5L5utWEgrlJc0pwJxlQEIp66AQGXRGUhb7cMFYXtZ?=
 =?us-ascii?Q?Mnwic9YbPtO/zXJXUS9x/Lw/Jaieqvi2ZMT9oqYd7O3rtWg1aWVPoRK3S/ew?=
 =?us-ascii?Q?rtEfEDXSDf4uMIpiAUjhIhUXRTi4cPHApHLBnJ94+xQg9yY8XsK2vLuzv6hL?=
 =?us-ascii?Q?nhxqp5xjtzabBzx4btvp/wbPRcpsGOA1jF1dcSx/1NRajEsJJyBwXTVYXd5V?=
 =?us-ascii?Q?w2s+D7LoeZPMELbpkNM7CTQKSO7BOLokmBiboj95TKieJbwL5krbjPas00wo?=
 =?us-ascii?Q?lmqH25dRzWV99Mw0Avuf2KdrUWjdY0/tVFLFt94S0YgA36RHO8WdjxCUz4oT?=
 =?us-ascii?Q?G6K6PwkH8zO4Z3+ojXIkpBqLEWjlMJF6CTDr+LfNN3vxzycPr85dQ69ymqmq?=
 =?us-ascii?Q?/aJtO9jKKY6uEJgnGMwashNLpANtQS3F1UdodvS/v96kz3McfabQoRKU4p/c?=
 =?us-ascii?Q?JqzVcWaR1QuuoD1aE5wTEEhh2oh1KTe+zby2coqEiL481dSfI4hx+3c2clo5?=
 =?us-ascii?Q?4nmyoxCV4jY0FuCUxe+1OTb3K7gnVxN2MDOrJIghCUsKQq3o4QkoqaBvDhLs?=
 =?us-ascii?Q?uyYkRO2PC0fHjrPlplRugkj7z3NR3O2XVhYZ7lSF2HrF7oqHIv10SZ03lxph?=
 =?us-ascii?Q?rU9+Wmp4J14AOryfRtt+zgKaCgKub2/XCNn2SZUh7TmFUFlyrzyPfE/aqItL?=
 =?us-ascii?Q?KETiIQ7kcpdiaVFyrqLIgTtkqTVRmEDEB/hY6UIdLx7SX5aiX/lEeRMBZKUB?=
 =?us-ascii?Q?wTiF7+lQ1IfBKHkNHb2fnb2fTSLxPajXRexnsyk1Wnp3SSiP64MgW4F/RLfQ?=
 =?us-ascii?Q?nnVuJtfVhQuSM4raaKm/oGtqAUO5LPoW1M98Dmt8WaIj047CE9/ONIH9Rqnz?=
 =?us-ascii?Q?S1HEdvE3cjgbR/OvBzbRjLXZRbFu48OTSBD53n8BDJp+2prjuHneCQwuXdsw?=
 =?us-ascii?Q?I7kqRigL/5q1/A6hGAokYlr2aJQYwGIr5eIN5J8vjNAWrAXf+Com814dVX75?=
 =?us-ascii?Q?ZzIlS8qkrnkCeYw5mmnGcPHxqf1eGAdzCDXEUXsxMhlfqfG2O7/3khvf5Dp4?=
 =?us-ascii?Q?P1/CGNfs7N5u2mygo9wS7oK+MkppH0IDe+t+oUYJJbx+P7si/Gx0Hd7DpgHX?=
 =?us-ascii?Q?S2rlwbIbwCNgzIIuxXc42QoaekJouiApfi298mgJZs1PFc5Gi/RSrs33cX7k?=
 =?us-ascii?Q?UrYWBDXxwyWCy4ecUQpG2vCaZVD9LKF3A2Ix+4spaY0352E+IfOgQbRoW8xq?=
 =?us-ascii?Q?71fBfr3s7CGNZhzoNnPEL66s2Tj2ZB8ZdchIKlpFp7uRs7kDfUa7Q650pkNJ?=
 =?us-ascii?Q?4/TP9ChnshINNjK6EX/KXHTSXxJmvKt4pWZAos88l/QNQhZoWfWchet6gFs6?=
 =?us-ascii?Q?GgHahK9cMOrTe3OVFxKi/g29uOmbOgFYVyytWJDgeeXD71HH2rs77qzglZLL?=
 =?us-ascii?Q?h8mpm8rm44wunQZlA6aEGh2qOtGPQU/ZGz7JjGNEeBxJww468GIM/8U7kCKV?=
 =?us-ascii?Q?At2ACIpWrssnamG5iArP1KNSto04fX84SVux4AKc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb627ce8-585e-4eaf-2f8f-08dd78e21837
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 10:17:42.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hv0gve+I717zcXZiHJ7Z8amgFri3uL9nEx9ijsJvCnf8XDOoHRyNnvOrgYZjipD5Czv9K2f2NVbpO5phLrNoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8900

Actually enetc_set_rss() does not need a return value, so change its
type to void.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v5 changes:
New patch, suggested by Vladimir
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5b5e65ac8fab..a389d5089734 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3232,7 +3232,7 @@ struct net_device_stats *enetc_get_stats(struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(enetc_get_stats);
 
-static int enetc_set_rss(struct net_device *ndev, int en)
+static void enetc_set_rss(struct net_device *ndev, int en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_hw *hw = &priv->si->hw;
@@ -3244,8 +3244,6 @@ static int enetc_set_rss(struct net_device *ndev, int en)
 	reg &= ~ENETC_SIMR_RSSE;
 	reg |= (en) ? ENETC_SIMR_RSSE : 0;
 	enetc_wr(hw, ENETC_SIMR, reg);
-
-	return 0;
 }
 
 static void enetc_enable_rxvlan(struct net_device *ndev, bool en)
-- 
2.34.1


