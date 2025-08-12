Return-Path: <netdev+bounces-212852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF7B22429
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98743507E7E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93252ECD33;
	Tue, 12 Aug 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mYL7tl2i"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013015.outbound.protection.outlook.com [52.101.72.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97072ECD39;
	Tue, 12 Aug 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993280; cv=fail; b=fAOxyYMMhTStj5jV1O8xHsS+MoRQw4riNLVZ9MpzEK6yr0gNHnUYP67SnRfDcsV/4CsR9va5Z6KOFmzpi7/K0PH9sSDvB7kjo9tfr+R/Xglg6vOac+f5pZt99f/f7w3jj49YxnqESFqrAbowinAvweINgbQ3oijmlQ3P7ClYzjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993280; c=relaxed/simple;
	bh=wjI4gSVqbJXm1Oun0CvErxcyDYflIWpiEze7urI8+5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWNkbOvpQvxIptohnXSUlngHWUroGItmXs6P8l7BMdBxeaRCs3UlPtmF7ESn8ys4ehzSpLy7/DtkeGBm9nGbnqHdmo527GPgJKKdHS1OLl7nFzlcq7s2nPgRM9/ZiGX+op8PGPN4miUD1aCK9+Tjy2NepOPa/a8ZSnKTM77CzHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mYL7tl2i; arc=fail smtp.client-ip=52.101.72.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLcTlIoxso+9tWWxpQyqBKUkYGyf11h7ProQyLXVhs4IEe+fcXvIxaHnfa5eafIr6mjbkNKkITErIqy0V5oc0WJ5Pzzznv+GD9vL17mg/EOpQ1tq1Z2wxa1ha9sl6O1PsFWss2FzBXa5jIp0lKtHcDy6gDWW9Y6hqnfB62wvbYNUG5bB2+id6Y5zMGjo7rvvjYU+wCYGnJ9frbHiNiIw23fv6Pek4xWqtGxpk7NeJvTglIBbv4yKNBB9xkmL8vZQ+fkEAG62NIcIfaGvozFZpYJxitqjXN9VUyx7cNk39xAXEQsEcqTuxsWTbU3fWvqdSJa5MFPRlVMHbv1/tF1bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUFOQX1kiLbdkjqEzjUWWkmabmdKZxpA5mNrtq5IR5w=;
 b=M7PoXlhZ4BNXsDc6ZPGT+S4DyRvlRtyVgZL3E8eUUJL7wA4CcZGIXffBuU8xnaLrLKRDV+hWb9zjQeURvk6Y0OVD+g28NYGdVxd95XFKAXGi+YGkTpah6nABHQouC04i6ufpIbXCchSb+onrKgUxcmRzcWJEPLCT20tjBBOpCpTXJalNuGVEw9FsE0D19cY1YcZkmqtcboqa1fB3Uf9S8ZfRElo+Cj3Kpb5fk6P8G4wHpEwgXgmQzkU8B8OVqSbfkKQxcdIY54vRqcLr459VvJB1YSTS6rZbnkHFS1kM1T7LDVvbLZGoBI4TtyLVLL0NF2E/bFFHv8DoUWpiCAPaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUFOQX1kiLbdkjqEzjUWWkmabmdKZxpA5mNrtq5IR5w=;
 b=mYL7tl2iudq3uWE347amgIwSdursGMWPqRIfESLrX8dTGIJoCUjKDwozdRm9KrN2KPkrEhwG3esuYfYlaw31kcY1G8oDhNtmbuER1Ds7gl3a45qmNpLi74YZKKXHaoyTwWRq8H2fUC5LtGAxtA6+LAtrc22ieh9SyW8ldcLXLH53jTluy72Dq1ioOT9oadFS6HK2oxFa2d9jHR2L76vp9iFISJbVfEv6L22Euet31caEY6qjKKadvIDuXFJLoChWfuHgOYlA5Vc7Rd+sOab1ZvKH3KlP0yuftW0rSw8gdsAxcdGue8cy1mrWc5mILEhQzK4OZeGwAfIKKtNhgcv+VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:55 +0000
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
Subject: [PATCH v3 net-next 08/15] ptp: netc: add debugfs support to loop back pulse signal
Date: Tue, 12 Aug 2025 17:46:27 +0800
Message-Id: <20250812094634.489901-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3221bd97-fd23-449b-9739-08ddd9881b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBhbKQYIFIaJp0RWQywtwAsCeDEKRdAXQsxg07Sp8d8cHeastqvRpJDPDCVs?=
 =?us-ascii?Q?4oVC5csVfOaLa8TvKoxgOYTXU5i7yxje2aEJzSFYRJI7OgjqmCHUMIDTfF0K?=
 =?us-ascii?Q?HMQVY88Uvw/Da9stlKesewy4NlKgLCXGKcMklE4nnmgWK/qvUl5JgG2CdWFK?=
 =?us-ascii?Q?LE+z6dBe9fsHN4pKL0ee4vxox/230z70eZzcNjHN7mJg/l7xxLglbkFBLWyG?=
 =?us-ascii?Q?1fbnG6BEXSa6ioCVi0kJloY01N8JNGmdMhDn4P8Vs8rIHuDz6TNCQ1+3ElCT?=
 =?us-ascii?Q?WUXwinkbmPA9NQ9kv4QbXBQhnNrZIPr960xl5dJBNRO7s3S/ax5SEptIKjPU?=
 =?us-ascii?Q?AP6Q9mj0HeWMP02ucsJdWGb0T39Ln0nWe4b0gCZaAHp8S7t/QmrrDWM4x4c4?=
 =?us-ascii?Q?sW+SBJWrUcygqTgpeNuxyh1F6tSsUnPVyvnqaFXRAILwUPVE/qrPQDAAYPCL?=
 =?us-ascii?Q?OEWn3X9oA+l46lUjWyQojB3yXU7rLn5zoWkkPlC+asrslSfnYC9Qava41dU6?=
 =?us-ascii?Q?7per8Fq6uj1j+yLBrHFmQTX0o5RlNumBsGVws7V6B+xfLP1Q3DdV+Fx0g7Cs?=
 =?us-ascii?Q?vtOc14UeKyGwZDkhSZSQe1Ti/OnhkwDZI/0nFE7UaRG3mHf/kZULpcsY4SFv?=
 =?us-ascii?Q?82tO3Fy9LNc3qzM3uS3cN64GCa8Jx3duOBAl2LVEa69ee9fBd20z8kQnoE0M?=
 =?us-ascii?Q?MUS6Hao4Ej+Q40rPyarDMziLt4yMncd0YzlzD34Iu3Rmu4aP8t9zcldOYZ83?=
 =?us-ascii?Q?kvyTpxjLba24BZyVp5qMOpa8nidJfsd6YUayi826+h1aa2HK4moVLl6J911z?=
 =?us-ascii?Q?ddcDuaJTUD+18U8cNrcO0zjJfCrOi4FSwKl/ZEG0SRo+hECLqMZKPdUPipyW?=
 =?us-ascii?Q?FTRwDEfimAf53f+L3ooB0JbGuSw1flb1lCIz0qlifb0zJP6kTGj4sSjxNYL/?=
 =?us-ascii?Q?aPMviT0gELqK7E2zhHt6cJeLbAWnGsM/fpwXiDPNfi/RPJu+YzgoI8kSnbIZ?=
 =?us-ascii?Q?9yv7yHhzAcRpaVm7+54JFhwe14cgMTaH+nWWXlKP6dTgzSNmMca9V4BpSod+?=
 =?us-ascii?Q?0MITcyU7EI/pqOznK8AyY+ZYzRsRhWWujcKNuMzgnJCFShhsiQUkU4zpc3JO?=
 =?us-ascii?Q?I+iJucDAsMAxQJ4OELb8p+h0MPdOxkjh/9GEWPVjYlPOOHzIyHJZzBz8XFcY?=
 =?us-ascii?Q?ikdAuF8sMFWg7kB6Kp3EEYSEyWi/wbVfb5LURXoGgl+A7WQMcC4vFG2VNKFb?=
 =?us-ascii?Q?PYmMv847xRW5B425pFmU36yRX97fGRxlxWPpGebpaK8II6Lr65Out3g5BnkG?=
 =?us-ascii?Q?xgeX/3WdsFmro9UZanOIsX1Udp9kcAbAsGknRVxeQ7TXNF4g0Vf/nL3/4K5H?=
 =?us-ascii?Q?hjJo+SRU3qXUlzy/v+JiYgnABGK5MoWfyu0d3Mbb54qxyatWxc5xvSCg6VPA?=
 =?us-ascii?Q?xqCLW9eFAFz+3nzJCV70zKdyXoGRd8fSnGHWZ8t5Hbih03BlAcoC0fWp4oXo?=
 =?us-ascii?Q?SR50k84i3BDLKxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/C5jDK0mEmsfHnfZAZ6jZqiTxxqufcoZPST0gKwZOMz1mlGkhfzn4YTJJWP?=
 =?us-ascii?Q?iVtQMMXViTg3ds1uwGchpmiIw96bIbooe5g04aTGh03R+XOih8c8ZhuzQCnu?=
 =?us-ascii?Q?LjznYRWQzSE0TQLbgh9Z12sEVTVMYsiRQNvsA4TpS/DKclV4zYdbFGBTP7Me?=
 =?us-ascii?Q?lN0vOLxXU6afNJphiBR+Ow1R6g44y6oiJQy2JoAbaDvkepLk1+hSJCJ8Xak4?=
 =?us-ascii?Q?qT4nmvV+aV8GaOwHTlJ/JkP5PR14dJ4IJSpzJlGFq0nJ7qooWdFHocQ5re9J?=
 =?us-ascii?Q?OUuCWtcqTM21W26Eygf97k1+V+ZEICao7fJmqzDQrzSRam/0ny9MAZwFAIa0?=
 =?us-ascii?Q?cuOER/9Q4SBvo9ROfVzLTFpjJdM5Wj8sy9tLRwUtNEnVpcugTBszKMMJouLA?=
 =?us-ascii?Q?G/U1On+A7rMWxpUUHX+cmfvnd8LUcGE+kzV5rjiAErl8qkeKzNe5g9lM7w3Z?=
 =?us-ascii?Q?TKc/pu44ILJuOtXPThoTI+bgav0YiRD58XwJY1hRrlO4+TBnRcw0sHQ4ymd5?=
 =?us-ascii?Q?EOS83sO8y8BApnr1KMLCdUgVvnvHpYE+8lSz9AA3HtCtBTAFBqd7P0tfAogX?=
 =?us-ascii?Q?GR0LA5YSid3hn5turcpl/iryKJVkU/C1V5cNA6Hgzyir/1cxrnf+sBCv4WBd?=
 =?us-ascii?Q?4YGCrE7sxnOBXligqMHnGdIu6iJkKqqTIeSyxuHuBVafPfAY1d9zv4bI49MV?=
 =?us-ascii?Q?gqex+cvny/6XTiW4jT4wzcZLMEM1WpnwWtARumcWMDYRnEWBZFyEGjIsJPi4?=
 =?us-ascii?Q?AfQGeWrvbxEYPUp5AFQ8A+1ABAV99+AC1WFVwbW08r8myYYOoj1Mr4ZBiaih?=
 =?us-ascii?Q?NqB6qc6MLkpLJq9p9Jn78bBqVGJP2XfE5V2T84rxv3UDC3RIcmREe5/I6gS0?=
 =?us-ascii?Q?SCabgHvcK+j/CdEMUsCVOK7MXdzibiQbWdVlmgImUHSqv4YEOwACts1sxhH4?=
 =?us-ascii?Q?7vwH9bxwK+jwmX9RCzKzitGLMIYcazCcU1OXtIwof/y8eRasHmBHwrVVY9g8?=
 =?us-ascii?Q?pa02LMljdr2smUuM8ZvH1d/GPKD2ojANo3B2Y/yzvegQ+jVWRJurCsMtox6G?=
 =?us-ascii?Q?94X2wXOcbf0GWlAZ3EcCAvnsWpXAQqSJjvbouSdJAY/kNoBRUTpxhbxQR0b+?=
 =?us-ascii?Q?a6jtyHdKDyzRtBT0ijV6jVxtJRjME9Z/yZcGXRCQUMfGlqSBv5wf9vlKpSEe?=
 =?us-ascii?Q?h6ihac63rUAsHHolpzLOdVeSN0A7patOedzWMX3IivlyPPHrNb/8INEssgDq?=
 =?us-ascii?Q?Rno9fg6vpgPMNCOagn2dIgCn8td9i91/OTRMWbg1wKw/cvvfpb0TOiM6ljW3?=
 =?us-ascii?Q?dKwKO5ZZa6XP9AcnfvLG9a8hp53Li25yHrn301MxDcnH/XnGKPl6bzq8pwkL?=
 =?us-ascii?Q?2v/IsJX0psk037JnxQQkKz25aF1lLbIw/SzCexQSmukWKTxMZPJm1ggcTdKO?=
 =?us-ascii?Q?J8YJdfPmhxLIOIAjPPswd+DqTJCJav171fyEvS8BNBqSTyagK+XS8Hz9EH9W?=
 =?us-ascii?Q?ePaaNHiKOQO56rVTmfydT+PCO6nblC1ucvGqWhDztTAjoQVN3WPZ3FKPp/sm?=
 =?us-ascii?Q?zcVWqzYMebaGPceF9SHfeKOmkZNbcWT3Fa982PD6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3221bd97-fd23-449b-9739-08ddd9881b0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:55.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2nEX/DifI2Zpf9c+MW0jOHf6sbDSIyW/VMfW7MDBXXrE2cHi6DqrA/V/WL7FXkYY6LsLRguQWRYDwIl8Y3wZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

The NETC Timer supports to loop back the output pulse signal of Fiper-n
into Trigger-n input, so that we can leverage this feature to validate
some other features without external hardware support. For example, we
can use it to test external trigger stamp (EXTTS). And we can combine
EXTTS with loopback mode to check whether the generation time of PPS is
aligned with an integral second of PHC, or the periodic output signal
(PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.

An example to test the generation time of PPS event.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 1 > /sys/class/ptp/ptp0/pps_enable
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 108.000000018
event index 0 at 109.000000018
event index 0 at 110.000000018

An example to test the generation time of the periodic output signal.

$ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
$ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
$ testptp -d /dev/ptp0 -e 3
external time stamp request okay
event index 0 at 260.000000016
event index 0 at 261.500000015
event index 0 at 263.000000016

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Remove the check of the return value of debugfs_create_dir()
v3 changes:
1. Rename TMR_CTRL_PP1L and TMR_CTRL_PP2L to TMR_CTRL_PPL(i)
2. Remove switch statement from netc_timer_get_fiper_loopback() and
   netc_timer_set_fiper_loopback()
---
 drivers/ptp/ptp_netc.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 45d60ad46b68..d483fad51c66 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/fsl/netc_global.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -21,6 +22,7 @@
 #define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_PPL(i)		BIT(27 - (i))
 #define  TMR_CTRL_FS			BIT(28)
 
 #define NETC_TMR_TEVENT			0x0084
@@ -122,6 +124,7 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct dentry *debugfs_root;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -953,6 +956,95 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
 	return val & IPBRR0_IP_REV;
 }
 
+static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
+					 int fiper, u64 *val)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	*val = (tmr_ctrl & TMR_CTRL_PPL(fiper)) ? 1 : 0;
+
+	return 0;
+}
+
+static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
+					 int fiper, bool en)
+{
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	if (en)
+		tmr_ctrl |= TMR_CTRL_PPL(fiper);
+	else
+		tmr_ctrl &= ~TMR_CTRL_PPL(fiper);
+
+	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 0, val);
+}
+
+static int netc_timer_set_fiper1_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 0, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
+			 netc_timer_set_fiper1_loopback, "%llu\n");
+
+static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_get_fiper_loopback(priv, 1, val);
+}
+
+static int netc_timer_set_fiper2_loopback(void *data, u64 val)
+{
+	struct netc_timer *priv = data;
+
+	return netc_timer_set_fiper_loopback(priv, 1, !!val);
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
+			 netc_timer_set_fiper2_loopback, "%llu\n");
+
+static void netc_timer_create_debugfs(struct netc_timer *priv)
+{
+	char debugfs_name[24];
+
+	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
+		 priv->phc_index);
+	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
+	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper1_fops);
+	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
+			    priv, &netc_timer_fiper2_fops);
+}
+
+static void netc_timer_remove_debugfs(struct netc_timer *priv)
+{
+	debugfs_remove(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -995,6 +1087,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	}
 
 	priv->phc_index = ptp_clock_index(priv->clock);
+	netc_timer_create_debugfs(priv);
 
 	return 0;
 
@@ -1010,6 +1103,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	netc_timer_remove_debugfs(priv);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
-- 
2.34.1


