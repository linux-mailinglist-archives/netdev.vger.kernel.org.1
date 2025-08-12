Return-Path: <netdev+bounces-212848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3126B22419
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A41AA857C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CD2EB5BC;
	Tue, 12 Aug 2025 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eVdx0MK3"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDA2EB5B4;
	Tue, 12 Aug 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993253; cv=fail; b=WnJO6uzI/g1DOVTxeyluYL9ecFM3meRByI0F7xO6f72jjk2sMCpNJU0TRMAXLRluLaTo+ERSE46L0ku6N+pnWpdFfV4xUXCKPA3Sg+i751cZCFRfc+E0e8T81D+P7UXIHsuvf/02E1gT/SGqNy+y8fm5SqJKHsohoLKYNyggBdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993253; c=relaxed/simple;
	bh=OM/o/ozpL1i7WOGDxgET2syd5QZ3hnzn8fOU30v+9Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9Uh03/ZC03hUTPawj3HtlBZS43SEp27n1zEM3XfJjhyNhiHcf2vGqN/pdPRZZml/ZxoXecDXFhwM/o5z5GcfaBiGeLVn/9Az4NA8cuNdpSlEPxJ1C3Xq2zjVvC4hz7Ebz/ijgAJNXl5K/0gp0U2iEMt4keRMW2rMBC36eUK3Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eVdx0MK3; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkscKcIUEHSVGzrqMi31J0E7FeYAjqhYO3vEY6VCEAzoINwMy2fv25o6dPObHDmtpeoEFIz0deBMSmjfnAoI6i8piWfha4d/C/hJuePa4PuP0jQhsF35aIA6vrCsVDL1IaMn3//7fBmLAuU+ZHRiqcpvZQuoJx03WJceTKrEskJk8/nkvmlqzuFO4cuGRTbTCYEPx/oRWVDJ+IxB0Z5gCC4h2G/d42OVMqaEp3Eh6OXmv+ZE0MFIdbGrhN167pJiNVD9CnjTisMY8tzFI+ThkEjzywmxdRXEIUq+vT2ZhuOzjB+yrMTokNCNwtY8fByp+vgMl6PQ+4nGJdBatU/31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjWgbnvI6qFxxUEajcGelbOwtyaZb7fIEFdDJCucPkc=;
 b=Tg8EFN4Jk2vsQ7nlbwnGO7cuDGpVHv/7otvre8ZFmqmmE6yebuR8dPGuRA1xIPYh0x+0lgVprwneJ4fpdnjBan5f5Hl8J3sQgR+95h9+ndqd/ptzH4BhwTvDweu7XmTGWf9IUJm1Mqqn0G2zaekL/Rm8hKc5I63bkU72TnOc6kGFIS3WjBCDw+FB08plpj3aVfmdWyHUWnP0TA0DL9EUhSfx1jUXURMxAhYG9+uZnFDLensEUXM96ZO8/mgbdRMsM7JWRP198KiM83MEL+/bse8rjui/FaicQ0FNlUblQBN13bhm7SOk+w6Y+SgGvqQzo1qPU/k+gKm3S/+3GQlHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjWgbnvI6qFxxUEajcGelbOwtyaZb7fIEFdDJCucPkc=;
 b=eVdx0MK3EMA7Q8jwumrjm4s9t+YuoIXbZeDoJbdPRkCdcN0U54pgTIvIVejRfWJmOs+/dM1PMCuM98Uq+6nz6kLX9PWpgCEbM2seurdDjtfuElVpDFumfr6BTnrmgZJ/lKv2XJjcxJ9gWzIb50lJRilQvHGgxWtCSK6AZz03c2OEn6PjkwkID36g1A8Qj9QrKlDodhpErnOVd+NMb36Uzc1NAdsZdgEgUgC/v9N+r/Ga2gxK52bFI6H/mNYQ0nk856sKyKImbKOc7rU3ChMgyYCF4Pdq8OCpht8u486Inqz6rmNA7tQkzM3KgDkGOkJfpELHvqhChqnngxBYVnwkRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:27 +0000
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
Subject: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver support
Date: Tue, 12 Aug 2025 17:46:23 +0800
Message-Id: <20250812094634.489901-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37c61e4c-1e84-42b2-65c4-08ddd9880a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXyBup7kb7ToMBs1SO3TJgRtaZeyIIvLEC1sXrJqQBf/HySg88eSyNBz4Qt/?=
 =?us-ascii?Q?NOcNL070lmufU6BeiMPck1ESac2txQsXei88V/kCTPzivTlnEn0n8UQiC7KI?=
 =?us-ascii?Q?wel4fMjheAULHsFGp8paqL25LRfsu54+MUhpe+b+Ns1crFeRR7JT5AYw3qzj?=
 =?us-ascii?Q?wZB3ax02CA5IYfr+afVEWkqCf90jekZikQzhp41XXCJ/UIWOtcMpj+Tpg58f?=
 =?us-ascii?Q?dOvYI+gejSkercwsD0T7Kptjk+7fUla5AEU1S2tUJLY2VoDAr3X9j6n/6o2a?=
 =?us-ascii?Q?wodaIyLykwBrXqFWuQofkJK3D+vb1/9Qy9KYQy5aihdxRt4co2DqdOI6ZKxE?=
 =?us-ascii?Q?Vr7s9kmvDvgahT5NKvjr29h0ULvqAn+yJ354y13w06Qjt/bVUc2D1HRb97wP?=
 =?us-ascii?Q?9zuQvqMjU/DBptK8AtaCkXx4nlT16gk/xFU2jUw4XDbfJJCK2uyP094On33v?=
 =?us-ascii?Q?bzgMuyiEK60jwZzLQD8yfiIDu5H+l7QngcKDLqWXuxowliAHqs7ek8xd++oR?=
 =?us-ascii?Q?Dvt9Fq20xNhu7r3dniiz4bGELp/ZwnM61/D+fqDTOiRj2vezpf8Lzog7KmY8?=
 =?us-ascii?Q?yffbctJEPgd8uds+BrMPNwv1F00F4J9t6H0Ktf6KHhixhW8r1aRa3XCdLXM0?=
 =?us-ascii?Q?kCU7mRNXeYyF2GmPUNeeqbMjhzNBeg/6XJywXP1S1uJyWY4uyJqPIIKlAPDc?=
 =?us-ascii?Q?QyrW/ZVK+lWc7aivS75w5ivGO6pv9x1YBaSRfIQXh43kEXdvdKSd0OG4sqS7?=
 =?us-ascii?Q?bW9HM1cpNg38fGCt8xuGFMl1t4kdWNvuDX66GHesEGHHU/Z57DXgbTY4e8so?=
 =?us-ascii?Q?Lx4dqmSlwUMS0p57bG0ImdYn9nJirKx/x3XWQgG85dEaQyfksedFGTVwLtt0?=
 =?us-ascii?Q?SSHfJtcnw99Y4L0PYrN4pd2FMKDA93iwJOtPOH5Cvs0t65wAmZtXpzIgX4JD?=
 =?us-ascii?Q?CwDa3YokIols8ZXFboJ9ToZ1+N63gCPs5Uox9TyU0q9sugeMRSIzS5rLZ7BN?=
 =?us-ascii?Q?SpJJJAIw3F3Y2MwfZjh1EqsxT8YIbJ++chXsPOkat4QZr4gyohWc85NwG/S0?=
 =?us-ascii?Q?Y4HLJZCkY2BiCbhtuAz31rzQQxl0u/q62J38GB2gTLXZUCl5WA1ErCcvRz7+?=
 =?us-ascii?Q?7qQ+C53HvDJkNqYjxgbh/fCsjJ14udCaBAJCMkRAt86WVdh1DKCwE2ijXpYj?=
 =?us-ascii?Q?NVPXGCSu38c0GxzI4JECGFki0KxBCw/ksDFgsewV33DTz5DgwiPHxwBrzZBv?=
 =?us-ascii?Q?qVxqMN7Had4xyK4SF+HSeVIPuyhHZKqGpnTwzgIBNLvymOFPHyJ2vh2nDci8?=
 =?us-ascii?Q?HaDwWD+G+DTkWbo39O7mOMcIw5yxVsN7KzcY53VZSYpvcX1KTeqg270rCcA2?=
 =?us-ascii?Q?dv4DpSuB4R1PDk6HXpOpQlo/MgtcBMUc4yq4xfyoKq5wJTEHNv5mk2yCnXZF?=
 =?us-ascii?Q?VC3LmWk5a0fluco09AObhkdp/JdTxgEtPW2oTTNhXDn2XykjcJB+E1MM1f+j?=
 =?us-ascii?Q?jDMXn/ax36nzy+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0u9j+UoDC2vaAjT5NjTZOgsNCi6uXkPBfFNyL8lDX5yqhYMulh00cfEEBFT?=
 =?us-ascii?Q?6MDt/nqgEnkZw9QEtEDVQPQXUao+wLA2Q9NxGwCH4GjDdbvQCks7J1uD0LR7?=
 =?us-ascii?Q?FNyE8qJ9PBfmVr/QlcT1VCDP6gMH+2hgdtyyfa3K577lFxn9yQH93BPfJvh8?=
 =?us-ascii?Q?rh6UVv+5erAcNtpc/H8d8M+H7Vf9V+898hc+fnlWX0SHKUK29W3Qk+dd691t?=
 =?us-ascii?Q?kEVkKIK7guBsZH21dd53cDrvK0Rc5+hQAuNFsG/91JR9G7kDmrFx/V0mq/VH?=
 =?us-ascii?Q?yix8YLj27korMnno8R70c9e1Sbc3yEdTLViydGwhlwMUzTtH1q+hp9V1x5QO?=
 =?us-ascii?Q?25LyimDGDWbzUuZGIwgCyTwrUgIjKOQIdbf4JDGWHepMmer7enQ0CPrjfzR3?=
 =?us-ascii?Q?UndeNhly4ZyGA/KbriysL2dVRXYxJAzdjWovWD5iXoa6LifHOYgjJkJSIYe3?=
 =?us-ascii?Q?luQ9f1oG26ITPpeh7PhmbNVrIk3kvU0hbe9tcyUu5TNcVCm8N5s7jWUCjfep?=
 =?us-ascii?Q?/9StQrtQ2QzfsJgB3cxo9ybuaZh6eMS8ldn1hi5Wu9AtR0BH2dFRQVZZRlP/?=
 =?us-ascii?Q?HhHdy/CpiyUrYiou9WWy1hdc3AMRhZ+6573F2sDVpWICkB364NCfMIGVoRwd?=
 =?us-ascii?Q?E8ZB9VyVnhlXmmw79o7OcWMa3/74D+jc6Hd2K96MNBhqn6OLkrjXmPMNUuBu?=
 =?us-ascii?Q?qYgJCTa+T1eW3wyxyPJAaoSxSBjLrAK4WeDG6XQDH3uWwwdi1x9kytqhZphL?=
 =?us-ascii?Q?irPVCEcYw4nCjRD4zxJYDVsBTldBsstTS4nE8Jf+eRYphAAixfx13K6kkatM?=
 =?us-ascii?Q?pbhnWYnPoknsUiR7mgn3+JVtXoZe12SzpE5CKa/Xec49jg/YOAic0rjUPOWQ?=
 =?us-ascii?Q?W8Nxi6R4nQkE15pj2mK4vRgk2Z+wOOb3fI0d9AVw4MlR9leQdTvohBwx4UD1?=
 =?us-ascii?Q?3Mi+z5s11dVAHoCJkQWUDNtTeqxZfCT4zGJWaq8sYMK0g6hpm4QeU+flWe7+?=
 =?us-ascii?Q?Y2oShVSrSN9CEwe19HwhUwnNmbVL7H9xR+fiKPA7tvaXYucxT04DHXIyghic?=
 =?us-ascii?Q?/hymzp59eOnvUlt6yuIMOLXdAG+1ckwUAcbVFxS5oZ363pzoeS7fIX+fFsBp?=
 =?us-ascii?Q?pQkYmn7AhW6ffbKQxJYjnb5V1EXX9FuSV3xal3jhjyTr6Q0UQBsipSPDuzdM?=
 =?us-ascii?Q?F140kKFxW/7mOBClrI1PnXOSad+tRlErTeV4TJU5HWMUN5N8P941opYK80+0?=
 =?us-ascii?Q?jjdrzsKyLT7tlLxHvALXxE/HlbqfkfMV4iSVg9vd8DGwaPXAwTb6Fz60BlgJ?=
 =?us-ascii?Q?EpZ8Mm1Ztl0Eq7ZD2VvloSvQPftvTXaKLy9JE9IJSRWsaX2PuBxZzZJHUTrI?=
 =?us-ascii?Q?PWYDJnmo/S3DU9eD0xlvUsiYOSwFnwMYEvUOVnlT+k8QvzDv0QY4F6q952rc?=
 =?us-ascii?Q?dcOHBznYpWM8yn9mNDwn1NTfwbuGIeW89SFwhulbPXFu53TpneF8bhQNcUVS?=
 =?us-ascii?Q?HsXIOcfyeEqC8yl1aBsn2YK8a3IZTJt7RZgdeQcAnOXNZlM1GK+/p/8YDdjH?=
 =?us-ascii?Q?3CrPzF3nCvd8DLTXcOlwbh3zWDkEgR4/vQ8i50Qa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c61e4c-1e84-42b2-65c4-08ddd9880a53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:27.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99gOFbEbUKzYjxb1J26qmCRITWHC9QdeNb5GYMARqgzgmPNpoN0XJzpR7nhQq69+ylby75QW4CpxRTEe9g1LYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

NETC V4 Timer provides current time with nanosecond resolution, precise
periodic pulse, pulse on timeout (alarm), and time capture on external
pulse support. And it supports time synchronization as required for
IEEE 1588 and IEEE 802.1AS-2020.

Inside NETC, ENETC can capture the timestamp of the sent/received packet
through the PHC provided by the Timer and record it on the Tx/Rx BD. And
through the relevant PHC interfaces provided by the driver, the enetc V4
driver can support PTP time synchronization.

In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
not exactly the same. The current ptp-qoriq driver is not compatible with
NETC V4 Timer, most of the code cannot be reused, see below reasons.

1. The architecture of ptp-qoriq driver makes the register offset fixed,
however, the offsets of all the high registers and low registers of V4
are swapped, and V4 also adds some new registers. so extending ptp-qoriq
to make it compatible with V4 Timer is tantamount to completely rewriting
ptp-qoriq driver.

2. The usage of some functions is somewhat different from QorIQ timer,
such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
increase the complexity of the code and reduce readability.

3. QorIQ is an expired brand. It is difficult for us to verify whether
it works stably on the QorIQ platforms if we refactor the driver, and
this will make maintenance difficult, so refactoring the driver obviously
does not bring any benefits.

Therefore, add this new driver for NETC V4 Timer. Note that the missing
features like PEROUT, PPS and EXTTS will be added in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
1. Rename netc_timer_get_source_clk() to
   netc_timer_get_reference_clk_source() and refactor it
2. Remove the scaled_ppm check in netc_timer_adjfine()
3. Add a comment in netc_timer_cur_time_read()
4. Add linux/bitfield.h to fix the build errors
v3 changes:
1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
2. Remove the check of dma_set_mask_and_coherent()
3. Use devm_kzalloc() and pci_ioremap_bar()
4. Move alarm related logic including irq handler to the next patch
5. Improve the commit message
6. Refactor netc_timer_get_reference_clk_source() and remove
   clk_prepare_enable()
7. Use FIELD_PREP() helper
8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
   help text.
9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
   confirmed TMR_OFF is a signed register.
---
 drivers/ptp/Kconfig             |  11 +
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_netc.c          | 438 ++++++++++++++++++++++++++++++++
 include/linux/fsl/netc_global.h |  12 +-
 4 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_netc.c

diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 204278eb215e..0ac31a20096c 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -252,4 +252,15 @@ config PTP_S390
 	  driver provides the raw clock value without the delta to
 	  userspace. That way userspace programs like chrony could steer
 	  the kernel clock.
+
+config PTP_NETC_V4_TIMER
+	bool "NXP NETC V4 Timer PTP Driver"
+	depends on PTP_1588_CLOCK=y
+	depends on PCI_MSI
+	help
+	  This driver adds support for using the NXP NETC V4 Timer as a PTP
+	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
+	  synchronization. It also supports periodic output signal (e.g. PPS)
+	  and external trigger timestamping.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 25f846fe48c9..8985d723d29c 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
+obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
new file mode 100644
index 000000000000..cbe2a64d1ced
--- /dev/null
+++ b/drivers/ptp/ptp_netc.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC V4 Timer driver
+ * Copyright 2025 NXP
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/ptp_clock_kernel.h>
+
+#define NETC_TMR_PCI_VENDOR		0x1131
+#define NETC_TMR_PCI_DEVID		0xee02
+
+#define NETC_TMR_CTRL			0x0080
+#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
+#define  TMR_CTRL_TE			BIT(2)
+#define  TMR_COMP_MODE			BIT(15)
+#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+
+#define NETC_TMR_CNT_L			0x0098
+#define NETC_TMR_CNT_H			0x009c
+#define NETC_TMR_ADD			0x00a0
+#define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_OFF_L			0x00b0
+#define NETC_TMR_OFF_H			0x00b4
+
+#define NETC_TMR_FIPER_CTRL		0x00dc
+#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
+#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+
+#define NETC_TMR_CUR_TIME_L		0x00f0
+#define NETC_TMR_CUR_TIME_H		0x00f4
+
+#define NETC_TMR_REGS_BAR		0
+
+#define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_DEFAULT_PRSC		2
+
+/* 1588 timer reference clock source select */
+#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
+#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
+#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
+
+#define NETC_TMR_SYSCLK_333M		333333333U
+
+struct netc_timer {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	spinlock_t lock; /* Prevent concurrent access to registers */
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info caps;
+	int phc_index;
+	u32 clk_select;
+	u32 clk_freq;
+	u32 oclk_prsc;
+	/* High 32-bit is integer part, low 32-bit is fractional part */
+	u64 period;
+};
+
+#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
+#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
+
+static const char *const timer_clk_src[] = {
+	"ccm_timer",
+	"ext_1588"
+};
+
+static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
+{
+	u32 tmr_cnt_h = upper_32_bits(ns);
+	u32 tmr_cnt_l = lower_32_bits(ns);
+
+	/* Writes to the TMR_CNT_L register copies the written value
+	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
+	 * register copies the values written into the shadow TMR_CNT_H
+	 * register. Contents of the shadow registers are copied into
+	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
+	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
+	 * register first.
+	 */
+	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
+	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+}
+
+static u64 netc_timer_offset_read(struct netc_timer *priv)
+{
+	u32 tmr_off_l, tmr_off_h;
+	u64 offset;
+
+	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
+	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
+	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
+
+	return offset;
+}
+
+static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
+{
+	u32 tmr_off_h = upper_32_bits(offset);
+	u32 tmr_off_l = lower_32_bits(offset);
+
+	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
+	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+}
+
+static u64 netc_timer_cur_time_read(struct netc_timer *priv)
+{
+	u32 time_h, time_l;
+	u64 ns;
+
+	/* The user should read NETC_TMR_CUR_TIME_L first to
+	 * get correct current time.
+	 */
+	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
+	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
+	ns = (u64)time_h << 32 | time_l;
+
+	return ns;
+}
+
+static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
+{
+	u32 fractional_period = lower_32_bits(period);
+	u32 integral_period = upper_32_bits(period);
+	u32 tmr_ctrl, old_tmr_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
+				    TMR_CTRL_TCLK_PERIOD);
+	if (tmr_ctrl != old_tmr_ctrl)
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 new_period;
+
+	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
+	netc_timer_adjust_period(priv, new_period);
+
+	return 0;
+}
+
+static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	s64 tmr_off;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Adjusting TMROFF instead of TMR_CNT is that the timer
+	 * counter keeps increasing during reading and writing
+	 * TMR_CNT, which will cause latency.
+	 */
+	tmr_off = netc_timer_offset_read(priv);
+	tmr_off += delta;
+	netc_timer_offset_write(priv, tmr_off);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts,
+				 struct ptp_system_timestamp *sts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	unsigned long flags;
+	u64 ns;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ptp_read_system_prets(sts);
+	ns = netc_timer_cur_time_read(priv);
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
+static int netc_timer_settime64(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+	u64 ns = timespec64_to_ns(ts);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	netc_timer_offset_write(priv, 0);
+	netc_timer_cnt_write(priv, ns);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	struct netc_timer *priv;
+
+	if (!timer_pdev)
+		return -ENODEV;
+
+	priv = pci_get_drvdata(timer_pdev);
+	if (!priv)
+		return -EINVAL;
+
+	return priv->phc_index;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
+
+static const struct ptp_clock_info netc_timer_ptp_caps = {
+	.owner		= THIS_MODULE,
+	.name		= "NETC Timer PTP clock",
+	.max_adj	= 500000000,
+	.n_pins		= 0,
+	.adjfine	= netc_timer_adjfine,
+	.adjtime	= netc_timer_adjtime,
+	.gettimex64	= netc_timer_gettimex64,
+	.settime64	= netc_timer_settime64,
+};
+
+static void netc_timer_init(struct netc_timer *priv)
+{
+	u32 fractional_period = lower_32_bits(priv->period);
+	u32 integral_period = upper_32_bits(priv->period);
+	u32 tmr_ctrl, fiper_ctrl;
+	struct timespec64 now;
+	u64 ns;
+	int i;
+
+	/* Software must enable timer first and the clock selected must be
+	 * active, otherwise, the registers which are in the timer clock
+	 * domain are not accessible.
+	 */
+	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
+		   TMR_CTRL_TE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+
+	/* Disable FIPER by default */
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		fiper_ctrl &= ~FIPER_CTRL_PG(i);
+	}
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+	ktime_get_real_ts64(&now);
+	ns = timespec64_to_ns(&now);
+	netc_timer_cnt_write(priv, ns);
+
+	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
+	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
+	 */
+	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
+		    TMR_COMP_MODE;
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
+}
+
+static int netc_timer_pci_probe(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	pcie_flr(pdev);
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable device\n");
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
+	if (err) {
+		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
+			ERR_PTR(err));
+		goto disable_dev;
+	}
+
+	pci_set_master(pdev);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	priv->pdev = pdev;
+	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
+	if (!priv->base) {
+		err = -ENOMEM;
+		goto release_mem_regions;
+	}
+
+	pci_set_drvdata(pdev, priv);
+
+	return 0;
+
+release_mem_regions:
+	pci_release_mem_regions(pdev);
+disable_dev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void netc_timer_pci_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	iounmap(priv->base);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct clk *clk;
+	int i;
+
+	/* Select NETC system clock as the reference clock by default */
+	priv->clk_select = NETC_TMR_SYSTEM_CLK;
+	priv->clk_freq = NETC_TMR_SYSCLK_333M;
+
+	/* Update the clock source of the reference clock if the clock
+	 * is specified in DT node.
+	 */
+	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
+		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		if (clk) {
+			priv->clk_freq = clk_get_rate(clk);
+			priv->clk_select = i ? NETC_TMR_EXT_OSC :
+					       NETC_TMR_CCM_TIMER1;
+			break;
+		}
+	}
+
+	/* The period is a 64-bit number, the high 32-bit is the integer
+	 * part of the period, the low 32-bit is the fractional part of
+	 * the period. In order to get the desired 32-bit fixed-point
+	 * format, multiply the numerator of the fraction by 2^32.
+	 */
+	priv->period = div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
+
+	return 0;
+}
+
+static int netc_timer_parse_dt(struct netc_timer *priv)
+{
+	return netc_timer_get_reference_clk_source(priv);
+}
+
+static int netc_timer_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct netc_timer *priv;
+	int err;
+
+	err = netc_timer_pci_probe(pdev);
+	if (err)
+		return err;
+
+	priv = pci_get_drvdata(pdev);
+	err = netc_timer_parse_dt(priv);
+	if (err) {
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "Failed to parse DT node\n");
+		goto timer_pci_remove;
+	}
+
+	priv->caps = netc_timer_ptp_caps;
+	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	spin_lock_init(&priv->lock);
+
+	netc_timer_init(priv);
+	priv->clock = ptp_clock_register(&priv->caps, dev);
+	if (IS_ERR(priv->clock)) {
+		err = PTR_ERR(priv->clock);
+		goto timer_pci_remove;
+	}
+
+	priv->phc_index = ptp_clock_index(priv->clock);
+
+	return 0;
+
+timer_pci_remove:
+	netc_timer_pci_remove(pdev);
+
+	return err;
+}
+
+static void netc_timer_remove(struct pci_dev *pdev)
+{
+	struct netc_timer *priv = pci_get_drvdata(pdev);
+
+	ptp_clock_unregister(priv->clock);
+	netc_timer_pci_remove(pdev);
+}
+
+static const struct pci_device_id netc_timer_id_table[] = {
+	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
+
+static struct pci_driver netc_timer_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = netc_timer_id_table,
+	.probe = netc_timer_probe,
+	.remove = netc_timer_remove,
+};
+module_pci_driver(netc_timer_driver);
+
+MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index fdecca8c90f0..17c19c8d3f93 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2024 NXP
+/* Copyright 2024-2025 NXP
  */
 #ifndef __NETC_GLOBAL_H
 #define __NETC_GLOBAL_H
 
 #include <linux/io.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32 val)
 	iowrite32(val, reg);
 }
 
+#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
+int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
+#else
+static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1


