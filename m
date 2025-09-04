Return-Path: <netdev+bounces-219934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858CCB43C16
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DDB1C24060
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761582FDC28;
	Thu,  4 Sep 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UoxlIyKq"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E962FDC3E;
	Thu,  4 Sep 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990376; cv=fail; b=d7dld46DlAmkkxFW3iuZrpH1nEi5QlmTuKsxI4m7ncAmFbMEU+phXW1hLBEQx4HUURqann84blmgTJwzoHddSNlqE3br5vC8Bi+PBWSvJCSVJddUP/y6Toy9j24JStTGU0VLbVEi2VOI82iKOqfTgyuCx8BUglTTNUzmchkfPv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990376; c=relaxed/simple;
	bh=yVeIEeSSp5mmNAFLfrWYIw9HF7oiL0X9tXw9Fn9wqvk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OebqdNmnvOi7qe+UmLt2plGiLUyrSL/DLzR7U13neCKGzwKmTZnVEbWc+NVgV8k60qaIxMtwuUrJf2Xr6u6dhGP0fOJ+w2PPvzgkkfQvHIMDWZwEy0l1zFOo67GQY5vcxjpMWj2XCGzotgrTvqQ4tvjwlEycI+ORvYb/g2jVgvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UoxlIyKq; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNq9rWAaTfS7KbtabZvR9ULhg5greT9djXUlInjLTY6oie9rZMkd9EuPEt9ijzjkKJXux5QMm3wGoD8rn2Xa3WImXJMOroVQNXkgbcQUdkNXUcvJIlscGsD6ia5bGfSGHLfu9petBNSglpbpMupR/D2djTr+50POS1TXU8xwWy4jTwI3tuUC09ork6iDWkfwdjMn3xYtC7kNG55TT6JUfX8G97PSgI4Ger+q52mO0zlfmCGatuZrwBALCNYaXv3aaqq0yEirPmuTZiknx+hdUApsYL9Pq1922yvlN9MHyELYLATX1ca3TOWk1qXq6CMfTN3WCEuMLFGGJFj1D0Zx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ8kIuwBi73EGYcYWqgkb0eeSMH4VTaP+izeuP5Xe4E=;
 b=hMa16nl16OdtIqrG0fOpFFeX74IKB1AIQYoOcYvZwk21iLdXh4PofS9j+qUx4J0YTUcT4EcHfNjPcyhuL0ir1dQpimssjlozeAs2fHg9MsrZjhA2YrO4LJsqfdlG/l0hd00x/Qn2xquKbBd891pDFpKGPiZuRN2CIjpAfGXetpp5sdAplxPeMitz7GlNOO73t3SD+qYtJMqwaIX8jBlkYUaGXt28mHlgFoT+ZzrNav0MKZQOHLYUY4ujoxGn+lKkQkdjIjnTLmYCa/j/E5+akzdV5zQIq7E9sPjHjMoD7IjBArMNkDQxtTAZWRcKCoRrvma620EanLSAZ7VBpcG27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ8kIuwBi73EGYcYWqgkb0eeSMH4VTaP+izeuP5Xe4E=;
 b=UoxlIyKqgvo9lJrKFLmwFLKcWyKjrc8RH9dr19obi1rlagg1loDnrbjoAf6ijMnyIwspu0gw1OodfhamKwvn9LKrryeV/Tt1LHWT62DDG8HxRVl5fyHvQ6ZoeyTpFzOJBrWQGbEGBJcxSoUx0qBwW14npXTW6guCvom5+NyXj9p7v2dVVPMaI+v1uaf+Oj0TCi7Ob1SuBZgZyCa8VyDlWCuMBj1Aljc9nn0XJ9SGyM/KDf5aRpNYK1x7EQGFYEphU+wou3+wSYOLbcNTp1zmHseiVal9x6p7Q1w21jPy8LVzx2eejjhKCDqbzssenStbZYfuOcqmv8Up4TC4CIt00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB9836.eurprd04.prod.outlook.com (2603:10a6:800:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 12:52:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 12:52:49 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net 1/2] net: phylink: add lock for serializing concurrent pl->phydev writes with resolver
Date: Thu,  4 Sep 2025 15:52:37 +0300
Message-Id: <20250904125238.193990-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB9836:EE_
X-MS-Office365-Filtering-Correlation-Id: 062239e8-4fa8-4094-eff3-08ddebb1f40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l2kM9RdgrIYumhu5vEqNlzkVpAWSa6GSTOntptqsfVN4RxZSRlq8dAtlwjGn?=
 =?us-ascii?Q?2Gg2SEeLqJo8F3RDVYxhDT1UkWDF+emRDS/rmGmXdUy5G8EU7teG76yZk87X?=
 =?us-ascii?Q?WD6Z8H7xWdNMUMBI8PwoWpzC1DbK0oom2p3kMe5Gp1Q7HYsrmdu9zv90yNeb?=
 =?us-ascii?Q?Yt/rw0mUHIKKGWsaWBYAOZNC++liSH7wchUsTRLSPo36TsG0CW0SNu//CsXx?=
 =?us-ascii?Q?YlPVBQt1QYVBq2MCvTZD2KTTJK/xHAmmpf1BI47T2xNgJytvxFfxiC9dEFoJ?=
 =?us-ascii?Q?XvN0k9Y7rdV7tAosJORerPHtZdIHIfk/uVdARClWlv1jGG+IRIZW8cOK35e7?=
 =?us-ascii?Q?43fiCiOG9eS2Qzl6maT4+qlmOXhn1FBl1/xGPwb72Y02pRlpLLPd7KN2ZyAz?=
 =?us-ascii?Q?n67g6Px2NNxfgkD7X4Q7RkhEhc6niIBRhYwpOTfaT2A52VvJ6w8UIOB85iZE?=
 =?us-ascii?Q?/Z0lRZnUtnDUQg9+UoJvnJ7DO8GNmo0XqykVCo1Ox9a/t2XZbIp3V0roN0tW?=
 =?us-ascii?Q?SE5mlA1oho6tI1ug+XUJ3vmf06U3gRJpzdTJV1taRG1D9U8PZYPD41MHXdw9?=
 =?us-ascii?Q?9SrHBV8FJqiaSu83dF8eoWseHNEaavxO7VEpJQoH8ktgsJ4quS/6BGK/U1Ph?=
 =?us-ascii?Q?bOxVVpXxS38Q4OuoYzXN3pSWzwCcmvUZGCDOazl/QZPDr30rHw5Kkboh+eaK?=
 =?us-ascii?Q?8dQAPMFaB1ZQQGOe3Pr3maf+I8QpLNwJ+FDfZyjJB7F2iBW2pIaR4wA+BupD?=
 =?us-ascii?Q?gt+ICxa5iPl9WW7ReuAXPlbuoABXloW7KYFs2h8hxzh90p67AsWEEbG15FNZ?=
 =?us-ascii?Q?fDEnpQJgtgIaED/kMaYcI8lCe0//pPH2ZQ6ylkZ7KiMbtBLZc3XKHCy8ud9u?=
 =?us-ascii?Q?LU0TUmi5e5fXwKUXXtcnC9sKXqT3wEVkdcnOC/tVgzJvPG7mVe8xzEyFke9/?=
 =?us-ascii?Q?OLMRLIUcaqyVtZ2v6kmsPfdMC6uEG6i4wnqglq1DapuGRHrzlMw9DwUv7T5e?=
 =?us-ascii?Q?b7QrG/2ZKz7hB5+lflSUiRSMN1P//sfTIG85xrS/5bibhHiXW5/d5Y1GHdco?=
 =?us-ascii?Q?mabKlAvzsJ82r26kCeS8IW5Yzirqi8nvgsEqe9JdiFX3GfAtA9AmfeeHj9tg?=
 =?us-ascii?Q?7RuZu4azWBMn2TVyadMuU8uL0eMQoU9ETanr2QMOp9YeV+grXbS4z84ICqdk?=
 =?us-ascii?Q?eKy8B89MzTaHGA+GPTuK2uQMcPUIr+pmWlV28XR77Y0eLPMBLWqdea7pyqoC?=
 =?us-ascii?Q?R7EiOTraVk3Lwm6A/DRVDw13yqhwYoJvRFcYe546vDxPJKGxO3b1CAQVuiww?=
 =?us-ascii?Q?3+VkRkwqRCPEw5Bobs0pBf5s2Jryn4+CZOz327Nmrxm85W9R2ZpuZYlIrX81?=
 =?us-ascii?Q?uYUL9yklKn46zsyKH0JDwAXoDA3Pi4r2pd+wSG2E/Mmkgkhun0GWBwIk0nYQ?=
 =?us-ascii?Q?izwWtd6mMxjjf+ILzDXxXTOvTZZPeqhV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5Bunz8i9QvnYsCTIdC/pwZO4ing+mPP5ChUUvgkrXf8WV8zalRIkSKv1jQO?=
 =?us-ascii?Q?AYbSEJDa9VoVH/1epzKD3yy2QfDjyjQ/tdvHEISma6uEnmn4xmPNmQ+9H9ms?=
 =?us-ascii?Q?w1zeVCEweDKx6hDUgVvqw6/Q+D+LAWXOyMQZY4QZC8QK2J0RLUgGfLFxW3fH?=
 =?us-ascii?Q?ABhjoMCpXdifVpoKYZRCB191ciNhMcLc38ba0EnaE1AjdmtMXQQuGTswzbyP?=
 =?us-ascii?Q?XJ5nnKTm72pZFoBlVmbVlbYa0JSBk/SxpgCab7y217PjPWabPYGReC+xTQYC?=
 =?us-ascii?Q?fb4PA4UigZQPkRsP3e1F7vX6INnw/h9SBBD3BsnUSI2yTpNtF9crs/am70X5?=
 =?us-ascii?Q?ufLPFTQB7HMuuSy/zzt+FwwekvTv413g3+1xtx+lZJqxt4t24Ap/GUsW/4s3?=
 =?us-ascii?Q?nlDzHnm/Dhnxcav0m525elRbPF/O6G/mLQH0E0a/FgIhAMokjz8P9Ilh0YEX?=
 =?us-ascii?Q?BfMEfKeWqAmIbvr9O7/V3S91bBK+9oeY2QF4Ix0LHA+mQ8HoX8FFZ2g7Wg30?=
 =?us-ascii?Q?x1xjAU5d0x5Q6Q2gCFfi+pQa4pox7lXyEofpIHkcMpHM4vrKoIVj/sM/k7GC?=
 =?us-ascii?Q?v4Jm9J7krqlDXmOdA3008mflGdLet0wXqryghqoh42Zk4IpuipQFps1/YjU/?=
 =?us-ascii?Q?jXTsEskldVYovzhYw7UQ/fBbZC4e9KlWVZWpmzYmNmFmMcakC4plNnURPwh1?=
 =?us-ascii?Q?VgVyl1F9i3nhIq0aNYtmfnVHhwLjHl37ikYnSzTzw/yyqeSUAmXmBxU6+bDs?=
 =?us-ascii?Q?yHm+CYvbrD8uKZx5CkDLBkzYuHf2rxgrwLL/fssEe0F0Ebd8CenzO+8EmRvh?=
 =?us-ascii?Q?2QlaP1CfkeLVfPXTCPoW5CK6eqPzZ53K0DlKT+KxmDCG41uIDmpRqcNyPOgh?=
 =?us-ascii?Q?fHiDsD2/dr5t4LhmguRS7hGWJALzKVNcHXEQ85i9qbCLOsZ6ohN1VoXZkQQy?=
 =?us-ascii?Q?Vb5lglTOqQFGowPzBYzFYe5TCeS6hyLfzJZ0tiyapq8jMjRB+wDXxESGd3dH?=
 =?us-ascii?Q?Tsj6e9GmbKErFUXQ44CLTGA7p3dpy+clWmt0fBZJUTxkokcUZVX1kKonmaLc?=
 =?us-ascii?Q?ncJutaEPT+qwJ6gPZ1LA37pWJvZH1Yf3U4NMGzhqF3N+yEyUIJVsVp1AJCaN?=
 =?us-ascii?Q?PbeRQCM3wxXL+v4BIAdCR94D4HpfsU+N6JAtlaLjlStDihMaTjsY2yR/g/up?=
 =?us-ascii?Q?IaGZNx5MIMxjhPBEuRSeWo2/p6176iLV49OWuC7BcBA9pDYLV6/7YGAyXSsN?=
 =?us-ascii?Q?S3cTkx37sDprWNQzlO7FWCnYpnfIrDNLsT+FHV8OFYqHE1EZlPnBbfgNz52u?=
 =?us-ascii?Q?Fu1g1QAgTSl3IhmGf8kQ7BMVeEVn9912siefxrgBJixJ3VHYXAFo5aOx2d6z?=
 =?us-ascii?Q?0Mq+dekb96e7eqsrkOMcVXCA2CO3hReiJGxSLV4MblSDdF/bHTEEsM85GPZ0?=
 =?us-ascii?Q?NFqf1xG096uBLTpzgZfrZC6zhsVu7Ia0bXGL5rNQlJteZIwf7uREMAxKf7yS?=
 =?us-ascii?Q?GNuAc93xPTuIiVZjNf8lMJzPfNzeR8RQXxRqE7IInOhPaxHc13ZSEwAEejqR?=
 =?us-ascii?Q?WMTSllVv2HgO3zVTVmewuZdX6V4FA8vWmB6vs/JMLB7WPhullNz1wt11iZO9?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062239e8-4fa8-4094-eff3-08ddebb1f40e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:52:49.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMZ+2G+7LXhfA6O0RObQubKFyibxMIIWo9ZsdTV9zQ+cLymiSrthnq7yeOVvi6224YVZQyrdGAuTVxbFTPJs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9836

Currently phylink_resolve() protects itself against concurrent
phylink_bringup_phy() or phylink_disconnect_phy() calls which modify
pl->phydev by relying on pl->state_mutex.

The problem is that in phylink_resolve(), pl->state_mutex is in a lock
inversion state with pl->phydev->lock. So pl->phydev->lock needs to be
acquired prior to pl->state_mutex. But that requires dereferencing
pl->phydev in the first place, and without pl->state_mutex, that is
racy.

Hence the reason for the extra lock. Currently it is redundant, but it
will serve a functional purpose once mutex_lock(&phy->lock) will be
moved outside of the mutex_lock(&pl->state_mutex) section.

Another alternative considered would have been to let phylink_resolve()
acquire the rtnl_mutex, which is also held when phylink_bringup_phy()
and phylink_disconnect_phy() are called. But since phylink_disconnect_phy()
runs under rtnl_lock(), it would deadlock with phylink_resolve() when
calling flush_work(&pl->resolve). Additionally, it would have been
undesirable because it would have unnecessarily blocked many other call
paths as well in the entire kernel, so the smaller-scoped lock was
preferred.

Link: https://lore.kernel.org/netdev/aLb6puGVzR29GpPx@shell.armlinux.org.uk/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- clarify in the commit message that rtnl_lock() in phylink_resolve()
  wouldn't have worked
- s/phy_lock/phydev_mutex/
- expand and refactor critical section in phylink_disconnect_phy()
- make use of the local "phy" variable in phylink_resolve()
v2 at:
https://lore.kernel.org/netdev/20250903152348.2998651-1-vladimir.oltean@nxp.com/
v1->v2: patch is new

 drivers/net/phy/phylink.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..386d37f6bad4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -67,6 +67,8 @@ struct phylink {
 	struct timer_list link_poll;
 
 	struct mutex state_mutex;
+	/* Serialize updates to pl->phydev with phylink_resolve() */
+	struct mutex phydev_mutex;
 	struct phylink_link_state phy_state;
 	unsigned int phy_ib_mode;
 	struct work_struct resolve;
@@ -1582,8 +1584,11 @@ static void phylink_resolve(struct work_struct *w)
 	struct phylink_link_state link_state;
 	bool mac_config = false;
 	bool retrigger = false;
+	struct phy_device *phy;
 	bool cur_link_state;
 
+	mutex_lock(&pl->phydev_mutex);
+	phy = pl->phydev;
 	mutex_lock(&pl->state_mutex);
 	cur_link_state = phylink_link_is_up(pl);
 
@@ -1617,11 +1622,11 @@ static void phylink_resolve(struct work_struct *w)
 		/* If we have a phy, the "up" state is the union of both the
 		 * PHY and the MAC
 		 */
-		if (pl->phydev)
+		if (phy)
 			link_state.link &= pl->phy_state.link;
 
 		/* Only update if the PHY link is up */
-		if (pl->phydev && pl->phy_state.link) {
+		if (phy && pl->phy_state.link) {
 			/* If the interface has changed, force a link down
 			 * event if the link isn't already down, and re-resolve.
 			 */
@@ -1685,6 +1690,7 @@ static void phylink_resolve(struct work_struct *w)
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
+	mutex_unlock(&pl->phydev_mutex);
 }
 
 static void phylink_run_resolve(struct phylink *pl)
@@ -1820,6 +1826,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	if (!pl)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&pl->phydev_mutex);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
@@ -2080,6 +2087,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
 	kfree(irq_str);
 
+	mutex_lock(&pl->phydev_mutex);
 	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	pl->phydev = phy;
@@ -2125,6 +2133,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->phydev_mutex);
 
 	phylink_dbg(pl,
 		    "phy: %s setting supported %*pb advertising %*pb\n",
@@ -2303,6 +2312,7 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	ASSERT_RTNL();
 
+	mutex_lock(&pl->phydev_mutex);
 	phy = pl->phydev;
 	if (phy) {
 		mutex_lock(&phy->lock);
@@ -2312,8 +2322,11 @@ void phylink_disconnect_phy(struct phylink *pl)
 		pl->mac_tx_clk_stop = false;
 		mutex_unlock(&pl->state_mutex);
 		mutex_unlock(&phy->lock);
-		flush_work(&pl->resolve);
+	}
+	mutex_unlock(&pl->phydev_mutex);
 
+	if (phy) {
+		flush_work(&pl->resolve);
 		phy_disconnect(phy);
 	}
 }
-- 
2.34.1


