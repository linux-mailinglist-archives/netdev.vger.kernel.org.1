Return-Path: <netdev+bounces-237535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C38ADC4CEA7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3C04FCBFF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4A346E40;
	Tue, 11 Nov 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XDZnGWgb"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013054.outbound.protection.outlook.com [52.101.83.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16797348477;
	Tue, 11 Nov 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855248; cv=fail; b=MpjcqnzsYkWvEosF57ZfDwGnCNTH0ox7PiDgl+4Tts3mq7fa1ypgba6GLodkU/f7JEIYswH9lMmU/2DZQ880mn36cOp2enyRrcKywYkNlQzY7Km9cGmowSu2hxBK9KL8V5uaHlqCNEhnxq8dXOvMyCkDU8KPEyiVr0lPdwKIqHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855248; c=relaxed/simple;
	bh=yk28TyT4W8ptk2ldMvpF2aHjRx/tpMCH0iDcQFFLKzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/q8qRH51KwnJMk/ybP3O8ySs3D2tMsFbfUwFHm8xKwZR9uQwSP3LTWiHSAAXQSMuW0DHXWZd6ZRLcsTcRHhD56GTknnYf3AN/ICXdySmjOOsOkJw0jon6PhyVxukRiUQfB989s+3AKNGCBq3TwIHG/UyquCy0GK/F/Rxvm9/+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XDZnGWgb; arc=fail smtp.client-ip=52.101.83.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy4sUnarJGp8HlqAoOXQ9oqiZB0I9PoNVUarFwMCvk0elsoNA1v0wKJgUJu4SkObHHxjlPs78uR/uNwF7Pi0KjThKqrXsJVjDhnDimJRJJatayPOgNlySj0awrj2S0WrVf6F/RQqndtwTlEi2G7cFDjREydbGMrry5+yyU7eJ7F9K0L+pY+nZl6uvn3EiRBEaj8yz55csCiXvDy1TfpxvlQrIoZJYYn4Tu4yrf0e1uOo4/UjbwKtFJgx+2sumfo2ANEkzl8kA9gWUUWT2uc+oF7kpBsjjWK3um4/iOj8wDuUkrQ2MQVMap9O19Hh23fLxc5M8SGXWEKNLFmy2C2wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxtGG6Lv2dF37ob+r6gXjcn/p+slzty8An7ppHCBx78=;
 b=Z7/jhq73awAi+K8lUXv1BWfklrjDcbVaQJwVEmOCoPeGXMMh/All1Cv4NhY4hfmKuC/IvaxeQv6Wh8ZDLAc3i04Uxm5SbKGMaqG7XQGooI3UDx0cC1sCicIr+/r4eHr9//bByywE1GzSjyKgMH7dFV9/x7ZHUluucWvYYag7K8z+lcyDdR5+eMSe1YRd6OHlyIqzAgAaJ+x3Pto1J+KXjuymdUciLtO0eqk5b8uLSmrUy3U/TKBvi81daBqrE/5js/+b51YgThHbRPbpY4eXFLkPZJGbsd9ApQRAVHLF9befMKpDLgaQX4DM0wWXe74YgBe0f56niOeI1QkzsO/Rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxtGG6Lv2dF37ob+r6gXjcn/p+slzty8An7ppHCBx78=;
 b=XDZnGWgbFcvl0eXJD/qpcG+SQbIsO014R33ZnntpLikBYxKM6kQUmk5LtSz6ui/dexCnzqTK6JHN4FbIyWZUbKdnP2os1XqebZAX/nYl8bVCO1CntuST6TlEFfj8l7/wzTrLzHQ/r9PUInJzhx8VAKLdDvMnr7PiH4prRS3nDLIlj/E8yacZfgKxdbUMEG0eQoVbWVhWIjZW7iFoa2dvORWngTsSFr0YdAKQANSukB+BbukUVLDJi4LbQIcJGvCw7xRQJs3hr+d3DNIgl7fSF+5mH04+uj8PwLK/H0xaKx3bjjE3BShEMwSiD52wlzK90EABEZXsdT93qeX5OZiwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7545.eurprd04.prod.outlook.com (2603:10a6:10:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:00:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:00:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: fec: remove rx_align from fec_enet_private
Date: Tue, 11 Nov 2025 18:00:56 +0800
Message-Id: <20251111100057.2660101-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111100057.2660101-1-wei.fang@nxp.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecfd8c1-64d3-4c69-d5f9-08de21092e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+k60CyFOg3OSaNSLmgon1Dkgrrp+WPZlj5QL85xW1GIEQeccNJT3ZnWwsRgp?=
 =?us-ascii?Q?jUepZ7U5CdjtzrXz2CBZFI3Lynm1+gnhePobba8t4g3n+37C68dDuqsW7yqr?=
 =?us-ascii?Q?0DGLkJmyEaJF9jsq1bpB90lunm+xaQHs4a8aG2KTTCwJfoge3IM8Y/7EdJ1J?=
 =?us-ascii?Q?7mdnz755/WcmZPKpTdxvy91//QZh+m0WHLMrZVL+0HFE0+G5wzMOOTzrPvLv?=
 =?us-ascii?Q?R3ZEha+lpnWo+n3Xrysr4IsAWTd5852QJif1Rrf4o7mzx1Zo5xyAvxy6PUrW?=
 =?us-ascii?Q?XQElUpTbAcDCEswuMz956gD3V8ntWZiubIHOOrAhbY9PN/VqQ/8sceGJflZg?=
 =?us-ascii?Q?UR6pfE2GBQkGNyPoQnmuhg2xHMGzCogn+lZCjdBoaAdAG5uQn/QFF4kJ02c6?=
 =?us-ascii?Q?EhhSVx5sPMY9mq78p2NFhaOUTRS4qVzrZ2VDBndjxSVi4aIAzKfKi+NP2N3p?=
 =?us-ascii?Q?Ni28+yCyctmKq+rh2niLUiY3zboQlCqZ5FzE4UOg/9eCUOh8PQRQkxQIhG8D?=
 =?us-ascii?Q?obzCaFlOgRYBShIz+w3uch498Kr3UR8ATytw31gUJtSwFaZrgifFNz4Ap8i3?=
 =?us-ascii?Q?ti5igFqaeW+/x292g1fNsSEB2MjA5KWnxcuS9fF6PRrNkuvKbX2Jeb3lovdJ?=
 =?us-ascii?Q?28pAQPs93u5I74bRybDN8OTlpmmRFT9JHMVgjEZP/mhxl6NAMFGUgZsbZfkx?=
 =?us-ascii?Q?e4cnoM4LOzXDyp2FfGNMAOJGPL1zKZXL5+G4Eoo2zFWate0IobikU2f2pq6U?=
 =?us-ascii?Q?V/dUclqY9KGjfQukkY91XGvT+TjWZIKpGST//4p4aO29GUq6Ipbb+ZKmK6jp?=
 =?us-ascii?Q?a3IWRapBTu57dDnGurDBRuxeJVIUHtFPWGYiW/eZDtEiDJBYFLRT62WZMRY7?=
 =?us-ascii?Q?w15FP1uqJhDA3MeDVbOTcOdhDjlooRpDzTm4V4My0/AUNk8tAzHPnYZuUd/S?=
 =?us-ascii?Q?cF3UOb/+YeOcJa04xGnkL7tFKwfxGhLif+rc081KeB17kpKhc4pJYfZNT7/z?=
 =?us-ascii?Q?I8KyLgBqMdeFTHnRAPZYG9c7YoawEsN4jAccLw01mxKfmfsH3rV2AVIkkBj+?=
 =?us-ascii?Q?pDn5WeueztXqLGkn2MzpygZYM3mt31JE8CBjbTnf++xE/VEpqmAcaSq2PjpN?=
 =?us-ascii?Q?d4vjjM8sNa8CBVIaUcPo2ZH+IyEofg3/fKAEs+Xk08c/JbnfMw6C7F9+418t?=
 =?us-ascii?Q?nbveanWol45T4lyjIa1S72dUTuMTA0qg7ApdCIBX7ZV53kcZS9GGmSX0yln+?=
 =?us-ascii?Q?Bab6HVzSBj2+UVA7vaLyZk2eah9vxGXWuljcgA4TtACsL5LWk8NkgKj2njVb?=
 =?us-ascii?Q?gQKdp4TvIXceUzKhTM+zODkhAaE6TnnE7HL84jj5fx5IvIyaoY9KI7DaqRgt?=
 =?us-ascii?Q?5dtKaDpKCxCEQ2dzSWQrV5V4oFTKf8HQShzrAx9BFlfYVsGujvU9Xvz98oJx?=
 =?us-ascii?Q?2/foa4XoM/uE7yge6V5KzT2Dw4P1WrAEe2Sw5hNmI3Jb1a9NjFUlkgqGHYoE?=
 =?us-ascii?Q?QKFHJ25Ebs5AYigyXMtH0T7+tbWRPQIxKaif?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Th1K9haB2HkPMEKSSTR1SptiJLP2mFZ+HLqoDZlawjP+Hg4gidPThs1lWN5p?=
 =?us-ascii?Q?3UuYsLdY+x3Z3z07sgq/ClTtIHV4JPztQq0gx1gzslBb5jvXuAQeqQDMMP+g?=
 =?us-ascii?Q?Ep4mpBcXudDoirR0h6T3N/u/YIj0/erKfLC+96l1BuRNYop2qhNOJbjc+EH0?=
 =?us-ascii?Q?Fwtdo1Y70lJNvUsYFviAIp8L6D3POnaF41k2pXGLhK7Hg3tK5/XuyUbvR4Ui?=
 =?us-ascii?Q?NRwOfxZItPTMUwlvxaYQyxpYLEmFzxzKxtUXLKcCKHPvVaBNTNZKVonjHY39?=
 =?us-ascii?Q?XBHttxyD2z23hXK/VZtq9C47KOuigrGYJNS5WldRaTVvanoX+m9oc9lbwKJY?=
 =?us-ascii?Q?Pp5hBgnHfZK2qMYPDXv7YSOVHdrIrgaFgUZEngG5eyM7dqR4mmtGAGRy65SO?=
 =?us-ascii?Q?hFribXGKaUtR9BTWzAQw3zzGpJFRm6F75sfPebpIC2EcbWWgV+v6wFifs4gI?=
 =?us-ascii?Q?srai8lb4saEP3Ez2KcUgJLLas8RjmtFxE63BH0uoBhMVLXUqF7VuOfDs60Mq?=
 =?us-ascii?Q?NgVK+dr5gXmxEGf2bxf7yY0RXPWmzAChokFO/g6J8gNGmqQShzAdRdc8+zeS?=
 =?us-ascii?Q?lcce7K+gdBWgDl7ljjPRxF6zZW6h590w2944Ds6U9axuJXgFU8w9rliye5JO?=
 =?us-ascii?Q?I8kUJRYXhLfqfl9V+kLQIXsc7+FxzULCSzCyr71vkPgw/JQtZqV/bIAk/JS9?=
 =?us-ascii?Q?Gtznaz72acj3l/92U1Qd2FDPLYFy9hIdxM8AuiK3KJaA2U0bAo0T4XyyovHI?=
 =?us-ascii?Q?0HlAe0nGeeoMT9A7pMZL0tDIdE0/SezhhWJzjWSl7gdKQ9+ibq2GH8WmcqGZ?=
 =?us-ascii?Q?K/rtmulgHbq82Z6ZUC2nYsRJn2eoeJLxtyHWBYS1B0maraHCEg5y2REyphl9?=
 =?us-ascii?Q?MIhfPgiOnGW5zmWOuGMUz/JEXQ4o1GW6BKWjfFv7spDIGL6a+xh4Dhr4+tK0?=
 =?us-ascii?Q?3Hm4Gmx7KGFoXyOJv2YhKwWCAqaA06V4CNf9sMmw45WpcFDhxwGq55+jJ+44?=
 =?us-ascii?Q?JCnDYhls1dYWU3XGvdfGgyuxj1hbGYGU+1/eZ4TruugK+RifOhaUHZ+l7r+d?=
 =?us-ascii?Q?rCHf6iNv8qHkwaS5ibTKb5oiuHvAqzuziqdOa2dkAAIFWclcH1XtaR/GPiSw?=
 =?us-ascii?Q?w+lCXKH7zV3zfO5TnsgqjwRw06lgIIXU5vRwjvBsbEb06k5lBJ33fp3W70xF?=
 =?us-ascii?Q?ARif/avnaPiyKvRPcPYrCCe5Gg0FO1r/tLlVw6haJPBqsQOctb/gdX6Qbbwp?=
 =?us-ascii?Q?pXw9UpMy5OSvyoSM4WXbPpIbskikxO6t80BBmD1QihQ4CX7f5BQ46ZhF1FwK?=
 =?us-ascii?Q?lKnHPjgVNGtUnyWN2L7T/Bsl73xxD4PqE7nCZMXQ7pmD94VJqDoQKzB4IfNZ?=
 =?us-ascii?Q?aH7QfNylpxWLHrgZ/XRhMNuNnXoSPNZNVzDB2fkD5A7plnsn+OV7lwyMaj9r?=
 =?us-ascii?Q?FH43fMaKy7L6nf6iSqqJpoojqJurbEXuiKZ+vQYIckmzUel0/Dv1HbTaP7ft?=
 =?us-ascii?Q?pHVaJCUD34Rc8EiVzK/9bH19JK45bBiG49WUoW/hUpfACz3zcAA41TkKXA7+?=
 =?us-ascii?Q?h6HDMzYffAFLS47Y+agVP9mDSJmjJOrH7aZC0vrx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecfd8c1-64d3-4c69-d5f9-08de21092e8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:00:45.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghmgOZLXUSG+tAn0GgawkE36qTnAbcYYRa+7XCxHRnVJgf95JdTHgOWE9QuoIb0fCK08kG+63slxqFXUWk6m+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7545

The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: change
FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
requires RX buffer must be 64 bytes alignment.

Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
buffers"), the address of the RX buffer is always the page address plus
128 bytes, so RX buffer is always 64-byte aligned. Therefore, rx_align
has no effect since that commit, and we can safely remove it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 -
 drivers/net/ethernet/freescale/fec_main.c | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c5bbc2c16a4f..a25dca9c7d71 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -660,7 +660,6 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
-	unsigned int rx_align;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5de86c8bc78e..cf598d5260fb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4069,10 +4069,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	WARN_ON(dsize != (1 << dsize_log2));
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-	fep->rx_align = 0xf;
 	fep->tx_align = 0xf;
 #else
-	fep->rx_align = 0x3;
 	fep->tx_align = 0x3;
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
@@ -4161,10 +4159,8 @@ static int fec_enet_init(struct net_device *ndev)
 		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
 	}
 
-	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
+	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
 		fep->tx_align = 0;
-		fep->rx_align = 0x3f;
-	}
 
 	ndev->hw_features = ndev->features;
 
-- 
2.34.1


