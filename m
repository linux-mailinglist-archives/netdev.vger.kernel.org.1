Return-Path: <netdev+bounces-217181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C9B37AFD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1211F364F22
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFF31A570;
	Wed, 27 Aug 2025 06:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBPkoY5h"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580231A560;
	Wed, 27 Aug 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277751; cv=fail; b=L+DUqzxGrpj7qalsRbsgCmTJsT1Mdpzm5y5Dbae2ztyUSVynwVRnU+PobdIzljz7rxJQ18oX6bo1jvu1ixEkGL0Z1nEtgJa+a91rluYRypspCLA3Z6uD6n6eQchU27NABfGUxCjHU/uZRYs7TVwQOSMhwJitHqJHsMWEh6XOj7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277751; c=relaxed/simple;
	bh=2iisT149WCBX22OiUrGmjRWrkQ0xuWFjnS2hoouXTOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAT4C1sYXh3i9xCRmVeeZ9xc3TAFhfDBLrGxiIpfK+px9qTvfMpV5rx/54IZUgDASyl0GIA6m3xnkHbPmsXe4IcAZY0VPXN0jt+G9cvlYDWszoFSrKLJ5M7Fxlxn+cOrGnP2G/WgBkaUDpiG9nvKIZU0Sjelo2i1w6JfNXAxu8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GBPkoY5h; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djtCXWAalUvIG493+dFAAzOterApTEqRw1eAXq9Iu6U8ccbBvajJOBEUEkhsKi0IGLoHaMqkX7Mh44BgUganl4DQILDiqzoX3SyD7V3pyLlssRgQZkKJXdrtvH79m9mDqOEI7glDXEEkLIVyxLS8br1LKq5XkMqMSdp9+R+UCOYhjm0abECut/rcT0jqaWJk+k6J4B4kWLwqJqzHsUH/rCC3fvokznsldU9kX+WxNttAXqj23zH3ftF5O0OoT6FdBvX8fIq+bH+fzUrkqIuyxqvEM/mIJKSarE99eWd7LtSevxYA8c7AFmSAWUZ+IZt/RKvTFTH9a+L1QYTli+oBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85YcdYl+afRSJpLxIkdZWkH5fO5OWmDwpfeCgaN4qLQ=;
 b=SGtIn+DkA/dQk1FwYpX9HFRh2SEjUhmasf4PnbkSvPHtFiCZNWDQEvsgnPYGqYTp0yXkSV7QZ+1Uo190pLT13CMeorudjEL1gXDCK8AY46R8aXkD8PQUWDL8UvePVbOtRRh74Kwb8VqC9WEeDEVeiKW9NbiIGdusg134yITt5bfXbcCvQL7FneUavPmPyzCYuHr8SElb6o9L+UciOzMAZXWrWR9xf4RxEEJSO52QvaYvLEYWH/uw9JTEWiYNF+/KpjJx/MmlmkK/f025G5CmFzQK7p2hy2JtNzbJUBSXlMNtbQWosO+H+hCJ/uSoxMmRIN0wD5vDcqOvsoXFQgc1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85YcdYl+afRSJpLxIkdZWkH5fO5OWmDwpfeCgaN4qLQ=;
 b=GBPkoY5hKt/H1IAooXdM1E//7JBJ2RmETsUW0VE8eYjiVsJ9kteZEK1L+IRKA6ZxSEqsGdqZGZN+4cV5zT0fPk2h35pPOxugnMSlCTzHJuith+5qZXiztwiobTmtar3xYoKMUEx8TgC9o8elq5NSZ3tTMymUyF0PInCpzRk10WLU0N2EY2qQ8Xl8RuP2D0CmhB/xShVTbbdM6oRHrpA+kDq0d6xSvn2soOwKJ+mjY0bjh2DadnF2dlAIHxvwAM2kUkxnznzRK72/T3pZnNYm7Aped1etpkkrq/VwJ7zg/74Ze+iQRejHFeyEd4T4dTbScX1HTEepqZPLKyddP7WHEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:55:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:47 +0000
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
Subject: [PATCH v6 net-next 09/17] ptp: netc: add the periodic output signal loopback support
Date: Wed, 27 Aug 2025 14:33:24 +0800
Message-Id: <20250827063332.1217664-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4dab4d-8003-470b-fb8f-08dde536bfea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vuIzjKaBfz3fOjMsMRqqqJf97pe2rxNfR+LpY4ZqnbPYmS17XNbGiNhc82Sp?=
 =?us-ascii?Q?1EsVsayP7uXeburSEsL3bzr5vhtIwE7VuUL79n4beHLRz0rzZRJRYJ+G2+Dq?=
 =?us-ascii?Q?a9jP7lJNnd8y45K0MWM3EDbWbqcSr+J+EVmyGxBLk/q5qzgTIL7gBjfoggG9?=
 =?us-ascii?Q?Np2wMCmKzMp+qHtj8Xo37UQemdmLs91WJzC6WBn+1efa6Azc5+Ctws/HcmYQ?=
 =?us-ascii?Q?FGUh/ZZjpm3kgukX7iaeN0NSrMy3T1LdM78AgMmHYc88SK7VFKe2PFZLEOGC?=
 =?us-ascii?Q?Ou4T/YA7/Zc7wNziGBUM6pyaoMWsNTneudZNbVuIW7i/rTTcrHlmiHYWNpd+?=
 =?us-ascii?Q?EVXKbPc/nrIxooTkFdB/97ALOzBmZDunSCwd9J0HIZWaGR4eW9Moref8Kuox?=
 =?us-ascii?Q?NDVTua9D4es0BFQzI/g2effoUQz60guVaIf5WGGr+l+7l7Gp0V129kXxG2qv?=
 =?us-ascii?Q?7fSnFvbOuyHhm5vg5ylMATL8t6X2+yGamWQ3JsDMnVuat4fN75wYFAD0js3C?=
 =?us-ascii?Q?FBS5wcaebpOu611aZcCJsUSrdUD78JkuoBvBLZcoj4pguodSbyZr/s0L+/if?=
 =?us-ascii?Q?0mbG69437k6wZ3AkdCzQp73pVQ10Vbt3YKzr57Uk7aG/bZcVfXpZhkgyW8lF?=
 =?us-ascii?Q?XtLQDKo/iBGv59cNAi77xmFmuWe4xcwQtsUFluzR2sLrH0Q99GA9SHxJ1mmm?=
 =?us-ascii?Q?ws1VuEdK7fUkaqQQewG4Zd4+W5j+2sAfMNViNpSO+mSKYs5v4VWPgY0WkpH+?=
 =?us-ascii?Q?AOikz6XBYrHvzvLlzGNX/1oKiaNn5JV1T0azbcHoWZc3aNvKh0CLJ2SkXbfm?=
 =?us-ascii?Q?2EL99CCDSUR7BrsFMXXpcgh98oVAhYv3EQktXLdKndhxl+M+Daxy+d5eYzze?=
 =?us-ascii?Q?GN8emFjUv4ildvv2oRs6w+yDCtbrg47Jy8C66vx3cmx56dwdtzLH7cedkG4X?=
 =?us-ascii?Q?EU/+86XjXRxD8hZjPlYJ3qGXi8LwYwFx76kBYZynnu9iOQhBtAB0Mnzphycb?=
 =?us-ascii?Q?AX0RDjWJBMm9zgFy446q1ff3xhL83E6ocanX9u7DuUDatJBWOCClo+zTzyAJ?=
 =?us-ascii?Q?2WrbB+AD9Q4LD+FP5rJ/YPZ5pZ17wEr8nuRIAhEtPAUxPJUahFhCbu2Rexz0?=
 =?us-ascii?Q?nU2zT1i0qXkNnos7L8FUJd8ZYM81pZKu1S9edA0xFE8YwdsU2mMmyh2l2XkV?=
 =?us-ascii?Q?7yglfAX2eTLH9048AzFPEcgMko1FL+wBQucVYwv9JcEIRcKE8kVf6WOwWLgT?=
 =?us-ascii?Q?7aaTDPbOWoLsEzoDWM5om27AUI1W2lfKW30CoICPTVfVspf+/wQZX7pwzNT9?=
 =?us-ascii?Q?q++nJnEc332heZqzx0AuMO5e6A6cFVijHfhLHmurIcGvxhmAATnCdSb12s0x?=
 =?us-ascii?Q?g8BKfIV+njrNe6hgu0AXevYrcjKUdmO0ckwbML9Sz8m9bTrqphs8amYmJ7Xp?=
 =?us-ascii?Q?J3MWGl1rWymfD62JYEXP/arQwMDwqc5Cq7hpE84GTU6fZUqszCgI4HGYPnEJ?=
 =?us-ascii?Q?sKv9BxHK/yD1hfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlYOSDpLx+nnYxQaTx9NtLKsKvLytm8i9v59yF7iwj67Fn/z2lxILZViPZPs?=
 =?us-ascii?Q?GyrADJpVJLKtfACYUZk3wMu00oBfPXUxc1SSxc/pZcaygV5gs98o7Ry3D0qC?=
 =?us-ascii?Q?xw6i/H9j+KAxs9D+cokQjEIcKUWmInv84tRmvGZDuhBqgWVIncI6iJi8UMpU?=
 =?us-ascii?Q?ls/i7M0J/HDQrJFn7knIYBG76nRW2LKTbKf5HakYiPcuJ4hWY14FjRnt4U4e?=
 =?us-ascii?Q?V3g6YyOeRlu7kNLF1LllDFniEcMtboKWedoEhfE95rkrm6D7NeITl6imUjsl?=
 =?us-ascii?Q?hrQu76r4hX28wAzAx38ezDcC1GfEe/vB4kyTQM68oOn1Gs4FBsIF6xrMbBnN?=
 =?us-ascii?Q?+YEgDSvPQ9rxY2VhfZ9GMHcyGoOPa6hSXHpzWfe2GOi4CNIr+6KUVTctCziD?=
 =?us-ascii?Q?q0/PHKC4DrdP8GoVZn2L4o1YJADpQXoTmUttkZwDzhiLOWXKxDfAs99kXD4q?=
 =?us-ascii?Q?TapXp3TyYuQYOCJBSVhKUDQkFQiWtjN2z0WuQgBIumkic1LcmUpvQmC6grxm?=
 =?us-ascii?Q?lbkc5F2AHBYojv2be3mL9x8eqb7weJXo6yF/yp1BZtNw/QOD9AvYACcetxO/?=
 =?us-ascii?Q?MRDnimjsTLFghuAa5cgzcWetXSSFyVmmyxv4CaYjo8CMda43pBvejR3Y6o3i?=
 =?us-ascii?Q?vK9FcprbI+9DtXRru9wXE2tBJvkkcP+HSAxT3MTsG05+QAW7MixfX5s8jAWF?=
 =?us-ascii?Q?1NVOV9bZ4rvUU4TjW0Z3jyc0RHLckf0CkgqOhrjLzlHIZiQu2CwyEJ7nHjc2?=
 =?us-ascii?Q?d0vP3KcfsNUoOv0/coS4vnVfv4uixZqIgGhi+yZyR/Mxs9lS/VEvGokssCfc?=
 =?us-ascii?Q?9S/ToFRJcWtDGFkInxJER3FLeTYdF8SZyE7gBsQp6SMK+iE1+WRdWhKSYrSN?=
 =?us-ascii?Q?1lBlS+InJ13cUaZTugbWwEtW+ssgZcQK9oMyl1YHRQ0x4cBkMK4U0Dd+qJC1?=
 =?us-ascii?Q?hlaPJTiX7FZhahPc2Gq/m5XPu0LMC3IXGKS+NBIjfdNXjzfOd1zrULkfmYpO?=
 =?us-ascii?Q?736aNxq5cc1XEIiRYwlXkCk8Gwk0VXDQuQqyfbalXYgLzYzle9xh2lr4Mnjh?=
 =?us-ascii?Q?Hqlpxh6vk0ZvuMTlINWDCl1ZBTGYdCgzbJSbjap1JPnBoKKUG0bQbdnP4lmD?=
 =?us-ascii?Q?nld5gUGMbnEzkG7IJyVHowHgSrhCymHTu96F2dftEYUvun8DQvFNiXuK6j0k?=
 =?us-ascii?Q?JT492rH7MAAqY9w/vNomkL4EUNuFXFQ+LW4R3H8ZSU8QyrXSE9RUi4V2WlYI?=
 =?us-ascii?Q?LeJyRZ+I0RQJdiOQXcldHI+OwznKMG/+kBZNsoyQj1vHhuA4rgMXkJ2oOVD8?=
 =?us-ascii?Q?ZLtZmAmuVpGbBCdRnWjiTIQSjQr4h/fg4tdA9OH30m0z/aRvQJOqKev08sj1?=
 =?us-ascii?Q?EFcdUKUo51PV7HKreWX0ZdqE/xXQGVPQD8TrteFKIJ5iD9ICZ/byzXlog1IN?=
 =?us-ascii?Q?iFqeh97MujWo9Shb1CfJzn0JUFGOxNAuJDMiNgjmFS53FzCzX+hc6rwNnoEc?=
 =?us-ascii?Q?jpvSviF1IS0kU2gbIZXTP2xHpmDWl+wGLYwncgejpfuw48PRF0kf6LtTywPv?=
 =?us-ascii?Q?P+GsU0gvyOtpurR0PigPKmbWUvJFMH8uR75SuHAY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4dab4d-8003-470b-fb8f-08dde536bfea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:47.0424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vezrGKymWZkO2EWJkkoFpToM6z0/HU23FEYtSE2OnLimbIEPUGYD6WER/6Jqywzqv0R3rUEoNPv5BJ68ZzCViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

The NETC Timer supports looping back the output pulse signal of Fiper-n
into Trigger-n input, so that users can leverage this feature to validate
some other features without external hardware support. For example, users
can use it to test external trigger stamp (EXTTS). And users can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time.

Since ptp_clock_info::perout_loopback() has been added to the ptp_clock
driver as a generic interface to enable or disable the periodic output
signal loopback, therefore, netc_timer_perout_loopback() is added as a
callback of ptp_clock_info::perout_loopback().

Test the generation time of PPS event:

$ echo 0 1 > /sys/kernel/debug/ptp0/perout_loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 63.000000017
event index 0 at 64.000000017
event index 0 at 65.000000017

Test the generation time of the periodic output signal:

$ echo 0 1 > /sys/kernel/debug/ptp0/perout_loopback
$ echo 0 150 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 150.000000014
event index 0 at 151.500000015
event index 0 at 153.000000014

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v6 changes:
1. Change the subject and modify the commit message
2. Remove the debugfs interfaces from the ptp_netc driver and use
the generic ptp_clock_info::perout_loopback() instead
v5 no changes
v4 changes:
1. Slightly modify the commit message and add Reviewed-by tag
v3 changes:
1. Rename TMR_CTRL_PP1L and TMR_CTRL_PP2L to TMR_CTRL_PPL(i)
2. Remove switch statement from netc_timer_get_fiper_loopback() and
   netc_timer_set_fiper_loopback()
v2 changes:
1. Remove the check of the return value of debugfs_create_dir()
---
 drivers/ptp/ptp_netc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 8c5fea1f43fa..75594f47807d 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -21,6 +21,7 @@
 #define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PPL(i)		BIT(27 - (i))
 #define  TMR_CTRL_FS			BIT(28)
 
 #define NETC_TMR_TEVENT			0x0084
@@ -609,6 +610,28 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	}
 }
 
+static int netc_timer_perout_loopback(struct ptp_clock_info *ptp,
+				      unsigned int index, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	if (on)
+		tmr_ctrl |= TMR_CTRL_PPL(index);
+	else
+		tmr_ctrl &= ~TMR_CTRL_PPL(index);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -717,6 +740,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.pps		= 1,
 	.n_per_out	= 3,
 	.n_ext_ts	= 2,
+	.n_per_lp	= 2,
 	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
 				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
@@ -724,6 +748,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
 	.enable		= netc_timer_enable,
+	.perout_loopback = netc_timer_perout_loopback,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
-- 
2.34.1


