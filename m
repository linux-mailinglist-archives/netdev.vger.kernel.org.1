Return-Path: <netdev+bounces-218113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652AB3B277
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427B9568584
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD2239E6C;
	Fri, 29 Aug 2025 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HwfnqTAa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AD2367DA;
	Fri, 29 Aug 2025 05:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445271; cv=fail; b=V8jCQYa/J/KwgCRIEYhIyBiVcdmD410b0EH0UTA1nh+X2lObFGGHU+ej3TZ689IsTbyfDVOnV/7zCcu1bxbhSdUq517eEwmP8qc9mnVBwBvmkr/48BYc5xMuHQOPhQeX9lrXAKbiZp+Fd47GZ1UaR47EvXwqqjJxcPsYnWvDbfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445271; c=relaxed/simple;
	bh=9u0yytS572U1uzc0taAN0Tt+OxB0SufRr1CkO3oSrRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWwP6NEsekT1YoTgwnxsnrHpm6idChDuw/5A3zO0+5RIs82GQxwRU1ujOVwouQAmghLTKWFjJg9tO06jXDZns+xyWvI99ykdbzrlpF30jpscH4s5DATw/AFqHyym75ff43bEviNwZeu3M3R+pd9uxcGIXoNGW5ywR6d8c5PLhvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HwfnqTAa; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBPy1wRvtL2t1fjnFFua5QZVdfn6SHSR2rB0Ik73f+UIkSNr1sw8X90JWwzim/5QojkH7bJV3uD/7YtPkv0OcFodNloqeErabdTlhRNmfWQOiQi92eSRcmLPY1i0MkpkPyJOa4QIh957/RgEVTvTBkWmoXTByCKTFdUn7mgNELZr4pO92DLJtEgj87XIXSMeLJjy4ZwYdYEDX5NduHZ4wFYk0ufkialIpevtE9tcXmybRmEba6PhJYOPi2V6lS/LX6lnMK3XZEki551i6YE5FLbAtsVsgcNpPLtiMGZZK1GU+gQZWBbtmyTGYICyHZsGpPJ/1e9v0Js4VCEa5pkEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnogvHmIsSga4MddG/YNWarykOKLv3jxCEVn0Bho6VE=;
 b=PUgfxNdxTny/0/6hXFK8JqPbBpuLDoZEacuVU9fbqOkIEA7qeOrWao1Qc38qLee2gMzphOsc0zoE0/0XMnZUCFmXQk6isdb0h6nQES8DEimHFgAArdVhGbXULQGwD+bE+wyuauq35h9vRaBr10dk8Dzmrxew4DIV6BWBhhBNFv/S6VbCS0qALkeOwsw2MDWDIul1/i9YboA/vz2mXJWXUVzYQLSSRUZIAw/G/70W9cJ76rmqNqRyEXPqxEgg1Eqqkep/u5EBo8Db5/PzD6BETJ9AvUXLHZAnuhHGIj3NBOCcwpbsB+ubWCwfNm63gR+tvgLEvFSAorpD80C8sXnfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnogvHmIsSga4MddG/YNWarykOKLv3jxCEVn0Bho6VE=;
 b=HwfnqTAaYb06ej8kEjlJXG652yiCCKEnMVnyHXbEs+MJe5F1rzmKvCpOw060e8NS6Ve4gUTSN5TEUXeqVBjcLIiNWbvrDnUorlV9FWj0k9qPPYhjcrASrwHH8Gmh4q/0DYnaarhT2Bu61h1WPrRiArskO9/jDck6kXwx9pkqORo1EkgfhO9YgUMSE92Q7V7OS/Ux2vwBRexgcylZx7AUOfj0OGg+BbAnW0urXjyyJC/ZHhL4aNr8cSC3tUk4hCw31iLNnhmPdQegke473STNKcKVqTfHxVCp7JGyBn1l2Nhe8oRZ0+QxuUAETY0bTa5SLEQePpZBRjcahHm5NzpzQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:46 +0000
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
Subject: [PATCH v7 net-next 06/14] ptp: netc: add periodic pulse output support
Date: Fri, 29 Aug 2025 13:06:07 +0800
Message-Id: <20250829050615.1247468-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: de807be6-73be-4df5-3496-08dde6bcc8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8l/WhWORUj/f82+x6VpNYiNmRvh18FHrysPjYqLH4mcExtjTe0yWuk69YDXx?=
 =?us-ascii?Q?xQqoO63hZAJ/LpeDLMQb97wioMQLonHfxBTshuw2TEqY40TbSUzccnmgigjQ?=
 =?us-ascii?Q?2waUbo7ufF4FnWfVm4QIFXhcDDtPA3O27c2JBGDUbn2n2/HxpwvbFlmS5Umo?=
 =?us-ascii?Q?1YBcJvMN61zdHVtKkBDiSpOlINU2wUz7o9yYHFQaqE2KYTxUbA2n+G6m+9Jj?=
 =?us-ascii?Q?J9WxuzJnMu6DZ9H2Sc9M2OrmbzNT0HAUb+m5W/kiLZAdZn927BmsKxoprqT/?=
 =?us-ascii?Q?rXkVhQ7Utd/6JUwJjkKL+XSRPqLopSyGuNmfqS0xH2c+qfKH6lhyrWPCmQlO?=
 =?us-ascii?Q?GvWFD42IBmh7d4XxE5UwofUy5QhpXxmgwu9h66wm2HSXwLeZCq2Gqr3TphSV?=
 =?us-ascii?Q?DX7Ub46oOcJQC0rJ/d3Qfj/gBMaPz+292oDJQXgnuzrVkPdKbjVOScSE0NJI?=
 =?us-ascii?Q?9JkjVadaj/VRpUO5MzqAovbXGUv/gWVBoMPLz2dCDo4BXLtfFnh5LCORpAFK?=
 =?us-ascii?Q?wkN7P7zKJuGpQOcN8jzs35eQBhXE7d8kLQDS1OThweMbM1moJf2u4viLTBhJ?=
 =?us-ascii?Q?bJ9SFLLZdR1pgD+ehpM3wsgoJVElZOPeExSyMabhYAJqJ+fFRqdWDkmqrwTG?=
 =?us-ascii?Q?pZBCTszywdz3uGVVmnuxSv2n7TOOP93NeazIE8ocqcm7YhyQSoKMALNyeVQj?=
 =?us-ascii?Q?k/f/MgCAm7L9ZMEFZsKiXWpTa7tXrBCEUYTTqS+UVNscg+li1cJrnJH3Can7?=
 =?us-ascii?Q?iPRFAqUtTZOATbm5Bnh2URfIiD8whB2/Llr8PFE6PyMyGa/rwptRiNH7lL29?=
 =?us-ascii?Q?eSiTUvCukgdNvIFSXVMKSKQu9ItR7/oMjbLW7ioKFaJyucdvnYclrkwkMgY6?=
 =?us-ascii?Q?Ac6mAeqai/8xkihlU+jpVhTFxM71qwoaQtTMKQF5pOiAQdzymDSUuWpPK2IG?=
 =?us-ascii?Q?004jvEFiYPMqm+KAzWvGmQIGyTflRe8eKNw9TppsJwRs1LYJWhPLoj1xHpT2?=
 =?us-ascii?Q?pbxaAMlNfSvrtIBu4Am6eRs84zUd8pPehugDyRcSN4r7uBY+36GLIr8eoS5K?=
 =?us-ascii?Q?SLBXSkxi8mHVx6Z9KYQAvtVH4rculwq5Hqo+VMjOutoOcTGxUdYAcnSTY1i5?=
 =?us-ascii?Q?wuG68Q/9bINln/iBy0lhNilAcXKPr7jiQ8ZFsd+YULqcxa4gCiSDEq20/AJg?=
 =?us-ascii?Q?jYW8BAahitGQ3/LQ90EfCXl89NSkf4UmtutwnJZ0XAlAcxgddSLNrMSsCy7T?=
 =?us-ascii?Q?G6xlA6fN51jps+JVGr4ZqR7Rq9HTA4zl+Q5PG8t/vX0B2CoXqQlE21koeaZd?=
 =?us-ascii?Q?fjOCCJ5YkQyBxxDhX2OGc5qccMRxnwFnXuXO71dZUkhUaqXsPaK6NEzR9ALU?=
 =?us-ascii?Q?gye9XTS58DwGH6SYSle8WvrwZzeqEkYCuozNsILfU1J1M149B8iGTK4m1SdE?=
 =?us-ascii?Q?rlS0o5Hz/w06kqXngKNkQH8vlF7lV+M4bH7bC3xYUFZ3HTwhV0UdcTr7N54t?=
 =?us-ascii?Q?Mi3lU26AF+OG6uY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4d2b/l0R6ENtFfnB/H/nLyHP7LsKWJ6UbIviC6RpXs8aaKndag2vfrf5IUxZ?=
 =?us-ascii?Q?fhPmYTzMI26xsYINcHSOrGOVWbVAYJfnUTk6ujpgU5oErBDmf6UJmOa5QdGw?=
 =?us-ascii?Q?4f/+eCQnVY2Xvkd5mIHbUbmCr/P2KA4PI6gkdmi4ZM0kQgx5mp/fk+yf/KL5?=
 =?us-ascii?Q?6P3DOz5BslVc9MhVkaJU4Kw8Y5xy5r8gZ8tq3VYDUdAwEohkZqcrw8wmMjHr?=
 =?us-ascii?Q?mQfvFXuTLOPM5GxwW8zLxjri24r1izRwbaFy8IJnngvP+UoTTkLaNWXy/GJU?=
 =?us-ascii?Q?7U9PGKT6YiUmLWixXJIs6QNcgk+6zGtW7EjmyvXiSyGgQ7TJcWO+ezZ0SlRE?=
 =?us-ascii?Q?KBY6FiS8shw44IipL8lZ6Ic1YRt9j8rPNYcMZ66Hd2B0TlKi+DeTjqkBSAIu?=
 =?us-ascii?Q?JmBsuCGmLd/P1H1EfXSE31Avvgj9zgArCrZ6t+8qQAvYvdmePV0RNYbMAozl?=
 =?us-ascii?Q?5+u3Tp3nRvBzaAef1zt/rkAxrC/iVRsl3LcTAU1EqCLxOoxYzOqNrclYGdU/?=
 =?us-ascii?Q?lM+pQqmDqP7eC/MGkLBeGoa5MpzZHSZaFAT1nfu3lhXGG4l+V/n9YGmJ6CmQ?=
 =?us-ascii?Q?r27KaN2GP2LBY+UaVVhGHQZOi6oOxGF3GB7YfUBBXNkLzVZyQYxflAbc/4+E?=
 =?us-ascii?Q?ZYDlzHXciNHJYIf/WNqPehVkOvhUdlAj5p7KfhPllE/x9YAcGk9FZ45aVCTf?=
 =?us-ascii?Q?tjk408naebv5O5kkYza86Ghz/wwMD+gYiviQ5V+9E5e1BtfYg5o+BsEwFiqP?=
 =?us-ascii?Q?PAudPK5cIHlHWnce6Jhu/pFSyD62DzSPbvfd1fIbfODeZ6zwhXaACVm1haQV?=
 =?us-ascii?Q?963zOKqpyKYngtr9uCsSAg514PLyjuALPZTk0TfkJNInP4lUCiH6y/azya2A?=
 =?us-ascii?Q?gyWttHXyXXqMwqkgbicTIhySqJzkEnpbHdHpYte8hR4B1N6cA2Ay6RmrNaod?=
 =?us-ascii?Q?FHYKpjmwEfmYzGnZJjdv4BLmsejWGvcnZpI5yauZDp1ExvuzCwS0IAQYLTOO?=
 =?us-ascii?Q?EShuXB6rMU+QyptJprbXxM+PR5JaxuNKngKsJT1SbLjMVSNcM23d1ylQSYWD?=
 =?us-ascii?Q?QZW4HJ0d/+L3Vke55zauRJiJ2Ls69x/4M1OpB9b0l1u9GHcbH6bKyX6Rz6DR?=
 =?us-ascii?Q?VddRZHWjxkjU2SCRTBhXmFlMGkRmHKbyLJbkT30Hl4mUiITtoZJKWVCx5tyV?=
 =?us-ascii?Q?nJeDJvlUJQqDr7VtsU3phU/jZzgQoq8y+lxc438wfMtfNocKiJOUn3/7PnAH?=
 =?us-ascii?Q?gsyp6v8TQCTXVMDiuSnuZD4Gl1t3TBiMrWEVXP/TcNTARfWbzLIF9piPyjaz?=
 =?us-ascii?Q?kV3kxqmrqZcjPE79U9q3q9QJIPpKHMAq3vhHeBDYicmVpWSF1XgQwiQUVaT9?=
 =?us-ascii?Q?wUG95OI+gh5IM3hFx8l3EqOnxSnzI768aIgHT8Kb4+YL+JGaIgO6V/Iywtt0?=
 =?us-ascii?Q?fj5HLmLloRd9AcwdWX5QSdXaKZQjaMjZ1OZ3HZtnsuUmHWAqMWqRM5uy7HRs?=
 =?us-ascii?Q?sRwvH2WCzEa76GfWmGCTMaL2f2PwwT5rlscr0pgjgMABwOaK81iBZEvDR9Om?=
 =?us-ascii?Q?WYIgdtUyuYQCKSLloTFFHWynU5RDqf2qXzNzWXVi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de807be6-73be-4df5-3496-08dde6bcc8b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:46.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdjOFFbDEdewsmyhpZ7oCIg6loHYZBiePiT2w/UpDv1zMiv9oC3qm1nukD3UJni3SeUwAI3PgTkrg0TUuvIxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way.

i.MX95 only has ALARM1 can be used as an indication to the FIPER start
down counting, but i.MX943 has ALARM1 and ALARM2 can be used. Therefore,
only one channel can work for i.MX95, two channels for i.MX943 as most.

In addition, change the PPS channel to be dynamically selected from fixed
number (0) because add PTP_CLK_REQ_PEROUT support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4:
1. Simplify the commit message
2. Fix dereference unassigned pointer "pp" in netc_timer_enable_pps().
v3 changes:
1. Improve the commit message
2. Add revision to struct netc_timer
3. Use priv->tmr_emask to instead of reading TMR_EMASK register
4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
   and netc_timer_select_pps_channel()
6. Dynamically select PPS channel instead of fixed to channel 0.
v2: no changes
---
 drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
 1 file changed, 306 insertions(+), 50 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 2107fa8ee32c..8f3efdf6f2bb 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -53,12 +53,18 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
+#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
 #define NETC_TMR_DEFAULT_PRSC		2
 #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -67,6 +73,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -82,8 +101,12 @@ struct netc_timer {
 
 	int irq;
 	char irq_name[24];
+	int revision;
 	u32 tmr_emask;
-	bool pps_enabled;
+	u8 pps_channel;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -193,6 +216,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -200,7 +224,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
+}
+
+static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
+					     u8 channel)
+{
+	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+	fiper = pp->period - integral_period;
+	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+			FIPER_CTRL_FS_ALARM(channel));
+	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
+			   TMR_TEVENT_ALMEN(alarm_id);
+
+	if (pp->type == NETC_PP_PPS)
+		netc_timer_set_pps_alarm(priv, channel, integral_period);
+	else
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
+					      u8 channel)
+{
+	struct netc_pp *pp = &priv->pp[channel];
+	int alarm_id = pp->alarm_id;
+	u32 fiper_ctrl;
+
+	if (!pp->enabled)
+		return;
+
+	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
+			     TMR_TEVENT_ALMEN(alarm_id));
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			return i;
+	}
+
+	return NETC_TMR_INVALID_CHANNEL;
 }
 
 /* Note that users should not use this API to output PPS signal on
@@ -211,77 +344,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
-	u32 fiper, fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-
 	if (on) {
-		u32 integral_period, fiper_pw;
+		int alarm_id;
+		u8 channel;
+
+		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
+			channel = priv->pps_channel;
+		} else {
+			channel = netc_timer_select_pps_channel(priv);
+			if (channel == NETC_TMR_INVALID_CHANNEL) {
+				dev_err(dev, "No available FIPERs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+		}
 
-		if (priv->pps_enabled)
+		pp = &priv->pp[channel];
+		if (pp->enabled)
 			goto unlock_spinlock;
 
-		integral_period = netc_timer_get_integral_period(priv);
-		fiper = NSEC_PER_SEC - integral_period;
-		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
-		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
-				FIPER_CTRL_FS_ALARM(0));
-		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
-		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
-		priv->pps_enabled = true;
-		netc_timer_set_pps_alarm(priv, 0, integral_period);
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
+			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
+		priv->pps_channel = channel;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
 	} else {
-		if (!priv->pps_enabled)
+		/* pps_channel is invalid if PPS is not enabled, so no
+		 * processing is needed.
+		 */
+		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
 			goto unlock_spinlock;
 
-		fiper = NETC_TMR_DEFAULT_FIPER;
-		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
-				     TMR_TEVENT_ALMEN(0));
-		fiper_ctrl |= FIPER_CTRL_DIS(0);
-		priv->pps_enabled = false;
-		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
+		pp = &priv->pp[priv->pps_channel];
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	}
 
-	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
-	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
+}
+
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct device *dev = &priv->pdev->dev;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int err = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period;
+		int alarm_id;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		netc_timer_enable_periodic_pulse(priv, channel);
+	} else {
+		netc_timer_disable_periodic_pulse(priv, channel);
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
 
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		if (!priv->pp[i].enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
 
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(0);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_enable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
-	fiper = NSEC_PER_SEC - integral_period;
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	netc_timer_set_pps_alarm(priv, 0, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -293,6 +527,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -311,9 +547,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -340,7 +576,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
@@ -350,7 +586,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -387,10 +623,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -404,6 +640,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.n_alarm	= 2,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -561,6 +798,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
+	if (tmr_event & TMR_TEVENT_ALMEN(1))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
+
 	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
 		event.type = PTP_CLOCK_PPS;
 		ptp_clock_event(priv->clock, &event);
@@ -604,6 +844,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -616,12 +865,19 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		return err;
 
 	priv = pci_get_drvdata(pdev);
+	priv->revision = netc_timer_get_global_ip_rev(priv);
+	if (priv->revision == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_parse_dt(priv);
 	if (err)
 		goto timer_pci_remove;
 
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
+	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
 	spin_lock_init(&priv->lock);
 	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
 		 pci_name(pdev));
-- 
2.34.1


