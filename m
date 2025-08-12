Return-Path: <netdev+bounces-212849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E97B2241D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7891AA8613
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66692EB5B4;
	Tue, 12 Aug 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QAdTChgo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE22EB5CB;
	Tue, 12 Aug 2025 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993260; cv=fail; b=gHrRfat9ydDZYW4pO6FPhfS6+VRTBlIqyAiAxXIkIpxY5hKktc14adl/x7d860rXiaCZwruLfXSMuDchtvbYPEvI/e7aUWeQZeMre2BPsqLMp51coF0vDVRKyA+N3h8XsxmRX5R+UjXy+Y+k0AwPu7HZSE/5QhEMYStE5Ju1mgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993260; c=relaxed/simple;
	bh=znKMh/y5SQstKXXws7HcrN5TNXSSVj1usiLP208Dp38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdvCasyviAQDacLKjxqQ+/mmGRNfDYqlE+32pKSfV6qKf8x7ovGyr305XrlUUqCVVa8hUIE2nJHQXC3BMnW3Yu/Nt3ZbpRAS2d9pIE/FyyywBOHto/W6ZKGsOt5zixF0j1dpeRr6ZlpqOhmkf+02MJViSaa8XV/rShb+A49Y4II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QAdTChgo; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbfMPHydzzvDVdZe2gL4RdZt2HIlXZSqqA8DZqzcyMIMCtISNkIDBSbsxuLNQa/DP8UUehsIOYeCfUUU6rEah9mm6HmT9rBue5IJ59/uZy0r50Are+GAm1Wp9L6PsZbv8pr7KCSX9PoA4p8gq3YIxduKwmdHx7tlJ1B6Fm9oomgUc0BTO78mOUKYiha2/+Gugn1eL0eZytMn6XIoVnJJg3DlhTHeZzuu5wbQqHLetuJkczO9uJfvtqMqBEMP/sFV0tKXdj/w1iG4hUzJifqLI6vbyA/31nC5rN6WWApo9FM4iM6CYS8iv95HtW9cMoS1oNTdxlZ5mv6pB4nNEjiHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSM+yPN8VqsgZPaBHRwxjau/gppjz+NGMUItr4a5jVo=;
 b=Q+BSY0gLkVmYZbloCxq8y8kSX91h3d2QmkirwV/9KyndBTL2asBUGArbC1jk4qA4sdcTNQMaF9Fu+wfGevrU/mK/cV9VRlxMGczMYBqEaXzkuW5vDOmNu3ANh3nxr9LFuRXj68gGcAF2ObluUraIeh4f57OmxjeGBGKMKdi8GWipkgXQxNJZ/9VEM/5MmjpsuMYjJaNNF0itcJBhQnz/AaLvNHubTO/xz4oIfxfmPSQxkr0tyLX4MJp6ymJnYO9b5h610ql7sgzNnsMvdxkmWdJQ5LN74gUreiaAmRk3WtvsY5tAb3+DTBonUWlv8mtESFDiu/N9zOH1sHvqRg7D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSM+yPN8VqsgZPaBHRwxjau/gppjz+NGMUItr4a5jVo=;
 b=QAdTChgowBnvLhh8umjoWIPKy5fQx5NkUgrzEO4RSrKysRVsU7N+2dVFJMEE6MvX0tVgTV1cDSlEZWHr77cPb4rYvlbTu19YJsBHMLOJwYfXmow33neCkXi69yk70pZrnqINNjxeSGniu2pCIlJFCdQtxhDHP0mdL7CEykU7KIVwhh1QEHOJEoR1lcfqu4a4Ppmr5VzJdoea79k8d54fsd0kpRW0gBxFP7d9S6lcnHQj9QN7zvoGe0CtC106VQwkR4MgrMgNUHpe9oiHwDX8CFtHkS/4K6QS2N4MB/IYBiVm9CQqULBcDeCIMG6B2FxTBFojl4LuNujIjybWf+GUmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:34 +0000
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
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Tue, 12 Aug 2025 17:46:24 +0800
Message-Id: <20250812094634.489901-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e715806-418f-444e-c112-08ddd9880ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5Z732axBVR7IdTOlTNQpe/pbxmElh5XY+cDqP8KqauiYjCZQ47H8EZgWS0n?=
 =?us-ascii?Q?5QK2wS+ZzFwPsHVs0+Hc34j7aTITQ9H53RWicWaeHdkwYko5lWw3RDH5UOgE?=
 =?us-ascii?Q?Ia33paNoOWekqKmvUxKmKKI/2H/pXj1G2rWoy2mTbo0b3VAyU1K3aNXOWosj?=
 =?us-ascii?Q?VdOs8kaPnSAc4sdjTNCd/wGt5n7wdyU6v9baU+7f+8dcakOl8da4DXSvyBND?=
 =?us-ascii?Q?xWi2AsBpOGABheMj+Ba/6V0O+1WFKn7b4t/nnoZ6H9xi7SyfoI6Zf/N3ZYVO?=
 =?us-ascii?Q?CHFyAwG5c+puq+l0yrjujECZQgyzzv4VjEq43HwvTgQBRshcMJwvuNC5j/yH?=
 =?us-ascii?Q?DvcM5bMW3EuO9UmcU38RthfpLVMDAY1jrogL+Si9zfUqaR7tqlQ5CTF2VljT?=
 =?us-ascii?Q?zLg8d13d7Smx2hEb44sVWVaUrdtbe1RAdBgTeMZtQVFia/2qsABKiEtkx3Kj?=
 =?us-ascii?Q?z1Y9IrYMDsW0YP6T7gr4Fh9FjsT0Nq89IFsYNNxGSvCMPducqyl1c5fuIh7j?=
 =?us-ascii?Q?9SHk5ssKp/nTiFG7THHHO2y6q25JR3JCVgzjFGgw6Df2GppAEKzRFOLrOWhG?=
 =?us-ascii?Q?wfqDNkhccu0CM76KlIov5/1lFC50+0MkxlpUftrTJU18FsNZ6Rl/mxtMIbvm?=
 =?us-ascii?Q?+arLd1B7MiBP8D9EI76Nx4oIATQYS38BGe71BaRa4MtMDq56oYAqS+YmSNe0?=
 =?us-ascii?Q?Rm0IMbTCxTXbDSN4P3ZqHEflZqolz9YYyaLGIXOtbX7zFM+CAxW7Sk3J9f4s?=
 =?us-ascii?Q?hw3HaGCSbLJuJ0UKm5M7B6ho7KhazFUdAoTyLjGc663fACbhpS1yo3td2FZv?=
 =?us-ascii?Q?qMEDHowut0UYu5d/p8iKc7BFLGjlVr4Lz7MLlF/OLNG82lKkS8CoOpy63ju/?=
 =?us-ascii?Q?TEMhbU5ogjOAlRxgAEahI8zginkvOcakvodn5iHMmUs/Q1sadR4APxyqwLdK?=
 =?us-ascii?Q?q8hASd/Rf0q90CzuzYLRJHysKdj9kX6dO3b28CDohhuQV7qzTMs1UKIoFz57?=
 =?us-ascii?Q?lV9vL0TV5HC/crxSzMHORowz/cPi9vbmGL3ItZxaEsjN+xjHjOnqBFbBl7Cr?=
 =?us-ascii?Q?1w1m74E4CjEkg+HTAevUB6D4vs1ShbvzirMmlqfame9QBt7aW6RgQVtvEagA?=
 =?us-ascii?Q?tv+rGyDU8w1u8vynIgow+hsbKhnbyOnwbmdX2LkKVD1UNnBi0fVmGL4DJLIV?=
 =?us-ascii?Q?v+sqC9vtOx6uJVUB4AGgNQeLQkOlNAwUa20iaTk0q2mLEBjjx3uxY7NO0M9E?=
 =?us-ascii?Q?LNCeBq0pmQtQF0bDrzAMh9a5UFB0czARGSH27/3vtMhfeYP8wHhGUlXbpJG2?=
 =?us-ascii?Q?ek76rWGtQWuObFp//k5pxFrbi0qfCV0Lbp2l5nv5IENSakXcl/KTS6MYMUpR?=
 =?us-ascii?Q?xP/G3t6ixP645353gpJKdQ0G67WlVxgekvjjosnKvE3qGWEbPgZrnjGMJXjc?=
 =?us-ascii?Q?mit9MOuWlL56vyplMbNDmi8soAnIWTpHWT3UumAmUebNh9q6uxxa1QHx28K+?=
 =?us-ascii?Q?oExMEyj1nvp7EDxD2Qd3WpYx03yEPS1W2ueN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+ku3h0Uw5B1dwk90e4A1s/FJq5UZp9eRGhF5YF+Ql7yGF5B22fGCSOMDUdK?=
 =?us-ascii?Q?ts/OnVdRXUuZWHdeqyJMQSFWbMOG/AtyT05Aj7JqKj2rBa9HzLaOtszauhX6?=
 =?us-ascii?Q?Dw6M0G11MGXzIvtP4kwnyXHUMKTsrJMY0Vmix6liQfQtF/EDnrMtGFmSNFJo?=
 =?us-ascii?Q?mWsuaqvLvP0ds9D/1Tk02y4oPJdzAnARMYib6RV9/uZFu2YZIPA2fneJxFq5?=
 =?us-ascii?Q?wuljh52hxNbqXJhxstZT3WxWf7UOsodWyGsj7L2LkjokmOnx1U0dcTR0NuMV?=
 =?us-ascii?Q?i1ETVWnfuMLJtdMr6QIRbOx3ef0SIhKGec/PnXJKqqA8m4vkJFJ16qZvOyAH?=
 =?us-ascii?Q?yg4q6XrA1StBwCIhVCIEoy/PChFukE5lnuXXYbVsHsWEa37mAeS2J+S/tJr6?=
 =?us-ascii?Q?W8tUxN4fIVdKMNFNifXoqKdSIJeuOJul933IOCYbC/spvGvsNW58XysEq5Lo?=
 =?us-ascii?Q?lL+f4S//otJHDRfluIWKgj95teoSGzqhAWaavaoTRwutXSTMYBeFYOgYVuRQ?=
 =?us-ascii?Q?1R0hvhjC28Jfan8MI2feL+h9mUBfqybr8ysVuXGikesuOgdGRhi40NIYqmsI?=
 =?us-ascii?Q?ZqbGptBtCT4l4TKmtg5DH1Y02Ft3qHfZlBpx7tdFJ7xIk28Ew4h2TH2zgRRt?=
 =?us-ascii?Q?o/7febjTm9NGK4MSYSzOcVIAZpX2V1Z5TyGCVNbJe4u7qjH5dv/oj5I6uhjd?=
 =?us-ascii?Q?Nr69z+HymRvEzD+D4ePEURm7R3J3UgUF9IUKPI850jqWvKBWlbP6iWZGM542?=
 =?us-ascii?Q?l9Xd38UBEl/RUUFmW6pqKuq3vb9f8lhV0my+dCI0SOZzvlAgG0RcPnu/4S5r?=
 =?us-ascii?Q?MIyqSxWan/8rsNq408VnLm4yE6AkHGXVny/rNTzG81uSaYU+b3J1iAKr6Kto?=
 =?us-ascii?Q?JvhneAnJUXi1dPf9saB9mLvefPLjRGTDAyKlpANmmHcH4lhx0Hnf5Y593vLv?=
 =?us-ascii?Q?rruX6T8viMHMNqZPHYzsx8tLeqSdH2/f/i7G1Y+iK8hDr+nxr24TSKraT5JF?=
 =?us-ascii?Q?EDM+N9/cuWQVoxCG2I34RBadJdZZToGCQmNzgY/fjkkICwH6lz2DFvHjyn/w?=
 =?us-ascii?Q?7VveXTrtv7fGPpfmKYqUR/U7jPrpLg2cLHPBbzc/kq1YbI4jl6t1eEiwp3ko?=
 =?us-ascii?Q?4TtApuHpMuESEXRqi6i8suBx4aW7SkGbF00mVHpCUGMXG6wmFpl7t0qDWv1i?=
 =?us-ascii?Q?Fyon4hjjIcfFh5rzkW0CgzxdHjkHIno6xHXou3N71U3L0+HDWOyHyUxNkfRt?=
 =?us-ascii?Q?/nYZE5Bf7DN+YcqbasvU0KQst8hmTRhj/53w0tkVdYdZSBYbBflpR1bgCjQF?=
 =?us-ascii?Q?z+ldTCpmiiCq6j7UY5jHG9XIy0P/1elvtkszqfwVH9n4V67ttQhS00tbRMeA?=
 =?us-ascii?Q?9Yg/FWSeEqgVbzuKEeXFVPYcZGhGZI1yDHrf5SlM5uL8yBHeC4N1Bn9Eil61?=
 =?us-ascii?Q?Mn0P5VFHI81AfvkferfBnVhXy6YI2YK7pYQOYSzs8IeyoPJwCwjr9IIoNtQG?=
 =?us-ascii?Q?50eAlZpTEre8CrF78gAbkhF0mW5nASgxmQin5kTY6IZoSgU8HYwjcwO1tsbp?=
 =?us-ascii?Q?iBBjM+gqPkLmAjPlOiii01zUGyB74WzFR/VCqMWZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e715806-418f-444e-c112-08ddd9880ec1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:34.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMGT1fbvULgiefwfbhSTa0dnEvUoUQLeUEfhiy+EZ67lKk6JhR6hAxANEhAYkJwi5Xez3BCPD9xJjkpyynSMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

The NETC Timer is capable of generating a PPS interrupt to the host. To
support this feature, a 64-bit alarm time (which is a integral second
of PHC in the future) is set to TMR_ALARM, and the period is set to
TMR_FIPER. The alarm time is compared to the current time on each update,
then the alarm trigger is used as an indication to the TMR_FIPER starts
down counting. After the period has passed, the PPS event is generated.

According to the NETC block guide, the Timer has three FIPERs, any of
which can be used to generate the PPS events, but in the current
implementation, we only need one of them to implement the PPS feature,
so FIPER 0 is used as the default PPS generator. Also, the Timer has
2 ALARMs, currently, ALARM 0 is used as the default time comparator.

However, if there is a time drift when PPS is enabled, the PPS event will
not be generated at an integral second of PHC. The suggested steps from
IP team if time drift happens:

1. Disable FIPER before adjusting the hardware time
2. Rearm ALARM after the time adjustment to make the next PPS event be
generated at an integral second of PHC.
3. Re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
v3 changes:
1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
2. Improve the commit message
3. Add alarm related logic and the irq handler
4. Add tmr_emask to struct netc_timer to save the irq masks instead of
   reading TMR_EMASK register
5. Remove pps_channel from struct netc_timer and remove
   NETC_TMR_DEFAULT_PPS_CHANNEL
---
 drivers/ptp/ptp_netc.c | 260 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 257 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index cbe2a64d1ced..9026a967a5fe 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -20,7 +20,14 @@
 #define  TMR_CTRL_TE			BIT(2)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
 
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
+#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+
+#define NETC_TMR_TEMASK			0x0088
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
@@ -28,9 +35,19 @@
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -39,6 +56,9 @@
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -60,6 +80,10 @@ struct netc_timer {
 	u32 oclk_prsc;
 	/* High 32-bit is integer part, low 32-bit is fractional part */
 	u64 period;
+
+	int irq;
+	u32 tmr_emask;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -124,6 +148,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return ns;
 }
 
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+}
+
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 fiper, fiper_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
+				FIPER_CTRL_FS_ALARM(0));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
+		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, 0, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
+				     TMR_TEVENT_ALMEN(0));
+		fiper_ctrl |= FIPER_CTRL_DIS(0);
+		priv->pps_enabled = false;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(0);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
+	fiper = NSEC_PER_SEC - integral_period;
+
+	netc_timer_set_pps_alarm(priv, 0, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -136,8 +309,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -163,6 +339,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
 	 * TMR_CNT, which will cause latency.
@@ -171,6 +349,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -205,8 +385,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -232,10 +416,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.name		= "NETC Timer PTP clock",
 	.max_adj	= 500000000,
 	.n_pins		= 0,
+	.n_alarm	= 2,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -252,7 +439,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	 * domain are not accessible.
 	 */
 	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
-		   TMR_CTRL_TE;
+		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
 
@@ -372,6 +559,66 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 	return netc_timer_get_reference_clk_source(priv);
 }
 
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
+	u32 tmr_event;
+
+	spin_lock(&priv->lock);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_event &= priv->tmr_emask;
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	if (tmr_event & TMR_TEVENT_ALMEN(0))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	char irq_name[64];
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
+	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -395,17 +642,23 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	spin_lock_init(&priv->lock);
 
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto timer_pci_remove;
+
 	netc_timer_init(priv);
 	priv->clock = ptp_clock_register(&priv->caps, dev);
 	if (IS_ERR(priv->clock)) {
 		err = PTR_ERR(priv->clock);
-		goto timer_pci_remove;
+		goto free_msix_irq;
 	}
 
 	priv->phc_index = ptp_clock_index(priv->clock);
 
 	return 0;
 
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
 timer_pci_remove:
 	netc_timer_pci_remove(pdev);
 
@@ -417,6 +670,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
 	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
 
-- 
2.34.1


