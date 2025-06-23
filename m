Return-Path: <netdev+bounces-200199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C8AE3B78
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938033B89F6
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25523D29C;
	Mon, 23 Jun 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QaAFyUiT"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DB23C51C;
	Mon, 23 Jun 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672808; cv=fail; b=eBfHl/xuH1Z6Pq1EgPAivnuznp/2uR6TnI0Wape097M6/1/NPa8rVJUmtmRWawbK5XhhPIwcYU1dj2QgL9d3ZgAJqfb0jfdwiw3rXxMZydBJUi0TNe7RZptPQpqgkZ3tldR8vCP47xhET95HH+M2FY316vhwPyEa2TO0shTsIOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672808; c=relaxed/simple;
	bh=91vAAVuH/IhG5dQ7LkEgENaMwgBjcFcazt11QbYJMU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imW0ZzgRLWPEClImcRMiv4suXcFY/8c70Jd3hm021vAn7fCanPGvxlDCHM7V9jlJpLOjN775Oei7I3BwO2zREib5j82NEk9zbFawc77IN0Hj7b2MOGq32IhQyjGfIlmyWhoL5jd4wVdfHEUWTH/LclI+A2yTYR5rh+Nib/l26oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QaAFyUiT; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M95cXZYCflF6HH6WtIb8BCYF9ndBIPmO37+pk/OBmxwZw97/CdD4NoQa3Xi2HsjDuoDOYpKOjZhY5pZtEtVQUzg//W+OmzqCVFrKXUdo+0rfG1pMEtpF6aJwbKTuV/kVk63GnCPa3c1KJdU3UvE+Jvi6lBNycZj8hz/GE1ueWTII5L6ynSivzPOoKTVjNhtVHZUUAGM4OZ6EZvqzrNKw1lN5tOhnE/n7Qmp5qfb+ln29Zsj/3BrcXjMwbzVq+ePCrtbdBPOl8J66h9sRGu8TgYiU+jO+DamBqARP+fETQBPfZqDdKpzQ3LxcU77a9p9jM5w0kGCe6xp3rPB5XXoBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqMrUvUP4A/lUUhFC9bseFAKEKsnIONmXx90GGfPkAI=;
 b=LDn194gims8O2ehE2SvqLz2PcxV2BkmFzCotGaqJ1dm4/fcB8FZMtb6TAeOc6GjnV79DVLXk4nG5xtlmTQMtA4vbjgfxT40h4L7ZS+TSLLiqHNkxt11NYqk7HVFVgPtkgXo0VMcmSJOcasIVK0tyc07q5J/8gj+DlUIxDZQfu5C79w16z7lLj+Ak4wquvdnmn8aFWjP07zkgBfx3xZZfsYzGV+bgENyNojKMBsFW1z7gebv7KL9mFm/YtTXrfrJcp2Ie7hIRwyf4Vr+aR6QKw/uY/uU1onrS/A2vPwHZPwdo6t7uYRM+WmOmL8sHX0wwTzk3YrU4v84p0q3MxknLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqMrUvUP4A/lUUhFC9bseFAKEKsnIONmXx90GGfPkAI=;
 b=QaAFyUiTK5NoocY+gici9po779sqJHiKpDLeia0lLsGYIM+kSCfSBCGth5gYcGK44DCWjwfiHXcZHYKv6EvpgNSIrfW21DWBDsbYdW1X5zp/0TSZbiQ5yUVpYB3qo9uVp7At6KKdBmjbWBGiPgHk0C+84zVJD5bTP1n2O+Ax8S/8b/sZvBodefGoDqUv3uAD/esJ/C2bpYI1lbVUc+D+timSfXZNsiWVvwkC10IAa3xxcRranwfzPrt2sPpxYr1s+xDgduGi3jHoGEsJlgogm0howoqTrlFS1QB/zrkq1vihrIlZTD/m8EfogjcAaZWkeMkOvd5/fvzECkFIcfmFvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10841.eurprd04.prod.outlook.com (2603:10a6:102:487::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 10:00:01 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:00:01 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	ulf.hansson@linaro.org,
	richardcochran@gmail.com,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or,
	frank.li@nxp.com,
	ye.li@nxp.com,
	ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: [PATCH v6 3/9] arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and modify them
Date: Mon, 23 Jun 2025 17:57:26 +0800
Message-Id: <20250623095732.2139853-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250623095732.2139853-1-joy.zou@nxp.com>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PA1PR04MB10841:EE_
X-MS-Office365-Filtering-Correlation-Id: 88373a24-ecd0-48fc-2b57-08ddb23cb821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqPs0CdhALfwIHTDwY7VOC0kWaBIdwNvV1aCP2rbj4SIzviZjU5sUCbrMZpA?=
 =?us-ascii?Q?0rMI48R0E8VUOC2mYsxfcPbhcqd5NU8Dya5rOuG0dqGuZDa1uMrjBq0m+uHr?=
 =?us-ascii?Q?ukefD/fnVsk6uijHONirMsP7rEA1bq9cLTt0szhge0FUZIfLq2h7O3Wowr55?=
 =?us-ascii?Q?Ky4dDFFsEBB3sQCVqGGAQvpXZrovWUYKVyOcDbQsx/vpdMyX9KOsyxi31xZi?=
 =?us-ascii?Q?7Os8Bn7kXVWlNMmoyCoiaMP+FP+XEnnVeRX1Olh7YEKfNO2O6qIzur6A2P4L?=
 =?us-ascii?Q?QoaKcLI5zvoX4BbOqqrxkcJqU0uO+WWOyhZB744vroDi8bNaUNiycbV3rhkA?=
 =?us-ascii?Q?+u7zv5olVr0cDy6VEItaeAAD9pWMnLCXe3iO3Vq8iWB5nDGTsUjakedGuM6y?=
 =?us-ascii?Q?k/vHbcB3WAcNyPxeVBp+/doA8ujivO2qRD0qTnASQHVydfsFAfFlr+5IlFw+?=
 =?us-ascii?Q?VY4i4ZqxbyN9BalfSu/Fk0Hqe7UpmtF2dfv5hWxBIttNcTGQ24zhdQNZ73CW?=
 =?us-ascii?Q?zV269MgsrOH9NnEsJkS/GPof+9QwcrGkbVSJbvdb6hcCSjWYkL0IrgWqQ7Yz?=
 =?us-ascii?Q?+PNf2LRr7sWCg210QhDGLL7/HRjg8opOqONbf5n5vZmIPUkDiBg5Fcv3I7Sh?=
 =?us-ascii?Q?vdC2/bzdHYI1Xu9kCQr/rNEMlDmKIylAka2fWio5JcGwohjYVzLLLzyfVGtl?=
 =?us-ascii?Q?vY83PCungIhK3MdZMEFAxwyLbzaQcII0dd02av73VX7TqBvKDVuMWXmEKO+5?=
 =?us-ascii?Q?4vqMFXzP8K6jR4clYvataoDWXc29aEvbDi02bi4XWYh9RW1JswLtHsUa2pPE?=
 =?us-ascii?Q?ah9nTg0mUoF+/2//E9l8SesvoHOsVkpB3/0uCa9Se+kv7lYtL0GjTPseRw+l?=
 =?us-ascii?Q?pHjUVamqUozZD6IAYjBsBdRxAdZWed+P9yBWG8v/KUZZVrykmnd24O4om1Sp?=
 =?us-ascii?Q?vztk3cSUmOjxJxwJvxlyHIRA8TyaROctlvPD765xDrbhhV5+YzD21aRRgPQQ?=
 =?us-ascii?Q?B/1wZuNDNij/a2KZ+M65GswZIV8ZfDAmZgs9/6aOi6/h5t4wZoSz5boPSjph?=
 =?us-ascii?Q?pcRtpiPjgI+WmwOUGxPmZUgVZYyqvLQb29nCVp8H+LmWKaXCb38g8OAGLCXz?=
 =?us-ascii?Q?koK918lBKLBNCj5Vsoo5pT0FJaVWval35AS3yFO48jHgBPdoaSSNgvIngqyT?=
 =?us-ascii?Q?ADupjjae1U195Xh3bFJgLcGgv2KbTdLC5Xbs1mgHMFEZ85KiA/+7AwxH4gnM?=
 =?us-ascii?Q?oY6RbRjb1iyGhC5b17palY7EMfrDDPQvFAm3KDGri24R8JeGcIttn02YJG0P?=
 =?us-ascii?Q?wsOSsZR0xeAcNnLRP53/+RlGcc7d6SM3/uoki4KRH3W1w+KoqVDtNtmmLc61?=
 =?us-ascii?Q?eOzU2Bu/fR64s39Sw1bMR8YzAsnzFC79Ppgku0w97ZpzcNYC3L+Ap6AXFHvc?=
 =?us-ascii?Q?XsgGXxJJBUYbqMorj96584ifJWC0R0ObZOwC7CGWGl64Q6R1bTAaXM3leQDx?=
 =?us-ascii?Q?WlRjNYIGZW1cue0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dd4cQGHOBqVfOi7PPJ5c6APZBqDg0D0lS9dSMu31+P0q0go2RRbBcY5/Ri5G?=
 =?us-ascii?Q?uuDGEo2be616Vpi7RHPdbBdzt+dEhaF/NljnLHt31ipOrhl9qxz5B7bEIjfs?=
 =?us-ascii?Q?UtrMWI4ghp2HZ15VCNQhek1mP/qgQmKwA56Gv5DwD/eZKPBoiF5sgNMBhvVX?=
 =?us-ascii?Q?asVuHMxrIru5a4xpaglP6/FQYC4rLtzOaF68yCcbE00vmKWhS0HaZbhXrSZl?=
 =?us-ascii?Q?Cs2cLMCyB573L58hQTYQ/aWDSPfmy0Zyu3irDBrHi80T1NHW7Vwwd+JHD+tG?=
 =?us-ascii?Q?FL5C6FMIZ2jZ1HJ/h0/xll/UCGO3IbsdU7DryKMN46Tce7x9z3BBVh1n1F8z?=
 =?us-ascii?Q?uZxH3G6xxkOCESy/0i1zGwNVMpErphdLGdxTbfPR3uMkSZUfdVQy2ZIXETFW?=
 =?us-ascii?Q?J3teNWhZrl2LLq9k8dbpckFYrah8vddfag6RSI3yq3QM5tGrzZiokIBnTXWF?=
 =?us-ascii?Q?e1TGjMRbkW3JnuT+yqIQ2MnM1hENvoV6AtYa8aW4nrtARA6BY5VmAbXFuldd?=
 =?us-ascii?Q?xZABPxMJ/JdDdr1/Owjnds/eF3QC+Ov0RzXsMajV/XiC9ANyzJJhcy5QpkAx?=
 =?us-ascii?Q?uIoezCAaGVdxR4UIOO8vwPv3hwVgEh5tnfTLgVVSb9cqgnFc53U4+Qy9rfIH?=
 =?us-ascii?Q?O6/Lp46Mn1tTajPC+8i5KM78ifth5qga0Yl+ulkXMevqI1z+JvyDRcvwcfrj?=
 =?us-ascii?Q?PrY19fs5ZpJQyCATNgMRzzqWArsGwUN1rA5r8kR03S1wEr+jFvAhvjOAEH+I?=
 =?us-ascii?Q?1abOngHrHn6xQvBckXn/BQVDbj8FQi7a8MNOhRxngW/uHaowEku7HoOwV63H?=
 =?us-ascii?Q?JKqgr/S0+O7Zm4lDSKwRv7bBF86zqNRzfgaY4E+w/xmYBrAoL8cipWwwITUL?=
 =?us-ascii?Q?8VBxaBsXifhR46q9pzDpvqxPvy6yn4nZXFoVUSt0UQlA44yYfPQZf9V/egV9?=
 =?us-ascii?Q?pgPYHDP1nZeD0e7k63Qn5Fi0McsAcR01HGiOLH9xkdrWChq5gVWtIoImJRCR?=
 =?us-ascii?Q?GIix+8q00srWkl5QwVnfUz0idPUFlXu8FQg1+iSGzWzv+rhpeThXseK18ieo?=
 =?us-ascii?Q?vupm34MgZ5X/PSNODJgq6Fl17cLvXSPQSRqwAmjan7Q6ccJX8JWTr7CwVB9X?=
 =?us-ascii?Q?c7tjgOH4t/cQ+gbupUrnRGOSZ61e+r1Af+GpagzWz1adwGycJ4cTzJhQ/I4t?=
 =?us-ascii?Q?nRPA7DtapoY9v1Oo2Tf0RjNSRMetoNmCajeBUm6PycYEvLRlpWCcsjIRJWjf?=
 =?us-ascii?Q?A4Zyi5DAyGVpC7n4nVxsILxLFUNI00AeYZR0YBrGA8RgBSkWH5dGajEE26/A?=
 =?us-ascii?Q?2Fj3Dofj8Hujl7QlNU/71Upg7kLlb+29WhM6K4agArvzHO7rT3Y4o43EKzva?=
 =?us-ascii?Q?zPFkCYA4yANhJhaW6n+BX6uadf4yuNTic0lsroIw/NU0JI1GNpiizM3qoE1n?=
 =?us-ascii?Q?yWtePELYGQ2+LztlF9idSMY2A1HnsgyL+4hFmqAYPWUya3MpZ7shM47ImwjS?=
 =?us-ascii?Q?ZxHme215j9D0DTln03z64mH8dS6mAfXpYj5W0P49XN3ydqLhMcASRrZpi8tL?=
 =?us-ascii?Q?zUHTxByLSeVwC41jPGGhBwS7JNOmiL6HKp6rOrJT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88373a24-ecd0-48fc-2b57-08ddb23cb821
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:00:01.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5J54t+52IW2bpqI6enprBrrtvCJVONyaMe0Uryrs0Q1LdXtFngru9RLAKZO1hzI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10841

The design of i.MX91 platform is very similar to i.MX93 and only
some small differences.

If the imx91.dtsi include the imx93.dtsi, each add to imx93.dtsi
requires an remove in imx91.dtsi for this unique to i.MX93, e.g. NPU.
The i.MX91 isn't the i.MX93 subset, if the imx93.dtsi include the
imx91.dtsi, the same problem will occur.

Common + delta is better than common - delta, so add imx91_93_common.dtsi
for i.MX91 and i.MX93, then the imx93.dtsi and imx91.dtsi will include the
imx91_93_common.dtsi.

Rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93 specific
part from imx91_93_common.dtsi to imx93.dtsi.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v6:
1. merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
   specific part from imx91_93_common.dtsi to imx93.dtsi patch.
2. restore copyright time and add modification time.
3. remove unused map0 label in imx91_93_common.dtsi.
---
 .../{imx93.dtsi => imx91_93_common.dtsi}      |  140 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1512 ++---------------
 2 files changed, 163 insertions(+), 1489 deletions(-)
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (92%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
similarity index 92%
copy from arch/arm64/boot/dts/freescale/imx93.dtsi
copy to arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 64cd0776b43d..fd303dbe7a01 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022,2025 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -52,7 +52,7 @@ aliases {
 		spi7 = &lpspi8;
 	};
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -77,58 +77,6 @@ A55_0: cpu@0 {
 			enable-method = "psci";
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l0>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l1>;
-		};
-
-		l2_cache_l0: l2-cache-l0 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l2_cache_l1: l2-cache-l1 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <262144>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <3>;
-			cache-unified;
 		};
 	};
 
@@ -184,44 +132,6 @@ gic: interrupt-controller@48000000 {
 		interrupt-parent = <&gic>;
 	};
 
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	cm33: remoteproc-cm33 {
-		compatible = "fsl,imx93-cm33";
-		clocks = <&clk IMX93_CLK_CM33_GATE>;
-		status = "disabled";
-	};
-
 	mqs1: mqs1 {
 		compatible = "fsl,imx93-mqs";
 		gpr = <&aonmix_ns_gpr>;
@@ -307,15 +217,6 @@ aonmix_ns_gpr: syscon@44210000 {
 				reg = <0x44210000 0x1000>;
 			};
 
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			system_counter: timer@44290000 {
 				compatible = "nxp,sysctr-timer";
 				reg = <0x44290000 0x30000>;
@@ -519,14 +420,6 @@ src: system-controller@44460000 {
 				#size-cells = <1>;
 				ranges;
 
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-
 				mediamix: power-domain@44462400 {
 					compatible = "fsl,imx93-src-slice";
 					reg = <0x44462400 0x400>, <0x44465800 0x400>;
@@ -542,26 +435,6 @@ clock-controller@44480000 {
 				#clock-cells = <1>;
 			};
 
-			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
-				reg = <0x44482000 0x1000>;
-				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-range = <0x800000da 0x800000e9
-						 0x80000102 0x8000012a
-						 0x80000166 0x800001a7
-						 0x800001b6>;
-				fsl,tmu-calibration = <0x00000000 0x0000000e
-						       0x00000001 0x00000029
-						       0x00000002 0x00000056
-						       0x00000003 0x000000a2
-						       0x00000004 0x00000116
-						       0x00000005 0x00000195
-						       0x00000006 0x000001b2>;
-				#thermal-sensor-cells = <1>;
-			};
-
 			micfil: micfil@44520000 {
 				compatible = "fsl,imx93-micfil";
 				reg = <0x44520000 0x10000>;
@@ -677,15 +550,6 @@ wakeupmix_gpr: syscon@42420000 {
 				reg = <0x42420000 0x1000>;
 			};
 
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
 			wdog3: watchdog@42490000 {
 				compatible = "fsl,imx93-wdt";
 				reg = <0x42490000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
dissimilarity index 97%
index 64cd0776b43d..7b27012dfcb5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,1351 +1,161 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2022 NXP
- */
-
-#include <dt-bindings/clock/imx93-clock.h>
-#include <dt-bindings/dma/fsl-edma.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/fsl,imx93-power.h>
-#include <dt-bindings/thermal/thermal.h>
-
-#include "imx93-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		gpio0 = &gpio1;
-		gpio1 = &gpio2;
-		gpio2 = &gpio3;
-		gpio3 = &gpio4;
-		i2c0 = &lpi2c1;
-		i2c1 = &lpi2c2;
-		i2c2 = &lpi2c3;
-		i2c3 = &lpi2c4;
-		i2c4 = &lpi2c5;
-		i2c5 = &lpi2c6;
-		i2c6 = &lpi2c7;
-		i2c7 = &lpi2c8;
-		mmc0 = &usdhc1;
-		mmc1 = &usdhc2;
-		mmc2 = &usdhc3;
-		serial0 = &lpuart1;
-		serial1 = &lpuart2;
-		serial2 = &lpuart3;
-		serial3 = &lpuart4;
-		serial4 = &lpuart5;
-		serial5 = &lpuart6;
-		serial6 = &lpuart7;
-		serial7 = &lpuart8;
-		spi0 = &lpspi1;
-		spi1 = &lpspi2;
-		spi2 = &lpspi3;
-		spi3 = &lpspi4;
-		spi4 = &lpspi5;
-		spi5 = &lpspi6;
-		spi6 = &lpspi7;
-		spi7 = &lpspi8;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		idle-states {
-			entry-method = "psci";
-
-			cpu_pd_wait: cpu-pd-wait {
-				compatible = "arm,idle-state";
-				arm,psci-suspend-param = <0x0010033>;
-				local-timer-stop;
-				entry-latency-us = <10000>;
-				exit-latency-us = <7000>;
-				min-residency-us = <27000>;
-				wakeup-latency-us = <15000>;
-			};
-		};
-
-		A55_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x0>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l0>;
-		};
-
-		A55_1: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a55";
-			reg = <0x100>;
-			enable-method = "psci";
-			#cooling-cells = <2>;
-			cpu-idle-states = <&cpu_pd_wait>;
-			i-cache-size = <32768>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <128>;
-			d-cache-size = <32768>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <128>;
-			next-level-cache = <&l2_cache_l1>;
-		};
-
-		l2_cache_l0: l2-cache-l0 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l2_cache_l1: l2-cache-l1 {
-			compatible = "cache";
-			cache-size = <65536>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <2>;
-			cache-unified;
-			next-level-cache = <&l3_cache>;
-		};
-
-		l3_cache: l3-cache {
-			compatible = "cache";
-			cache-size = <262144>;
-			cache-line-size = <64>;
-			cache-sets = <256>;
-			cache-level = <3>;
-			cache-unified;
-		};
-	};
-
-	osc_32k: clock-osc-32k {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32768>;
-		clock-output-names = "osc_32k";
-	};
-
-	osc_24m: clock-osc-24m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24000000>;
-		clock-output-names = "osc_24m";
-	};
-
-	clk_ext1: clock-ext1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <133000000>;
-		clock-output-names = "clk_ext1";
-	};
-
-	pmu {
-		compatible = "arm,cortex-a55-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
-		clock-frequency = <24000000>;
-		arm,no-tick-in-suspend;
-		interrupt-parent = <&gic>;
-	};
-
-	gic: interrupt-controller@48000000 {
-		compatible = "arm,gic-v3";
-		reg = <0 0x48000000 0 0x10000>,
-		      <0 0x48040000 0 0xc0000>;
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-parent = <&gic>;
-	};
-
-	thermal-zones {
-		cpu-thermal {
-			polling-delay-passive = <250>;
-			polling-delay = <2000>;
-
-			thermal-sensors = <&tmu 0>;
-
-			trips {
-				cpu_alert: cpu-alert {
-					temperature = <80000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu_crit: cpu-crit {
-					temperature = <90000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_alert>;
-					cooling-device =
-						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-	};
-
-	cm33: remoteproc-cm33 {
-		compatible = "fsl,imx93-cm33";
-		clocks = <&clk IMX93_CLK_CM33_GATE>;
-		status = "disabled";
-	};
-
-	mqs1: mqs1 {
-		compatible = "fsl,imx93-mqs";
-		gpr = <&aonmix_ns_gpr>;
-		status = "disabled";
-	};
-
-	mqs2: mqs2 {
-		compatible = "fsl,imx93-mqs";
-		gpr = <&wakeupmix_gpr>;
-		status = "disabled";
-	};
-
-	usbphynop1: usbphynop1 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	usbphynop2: usbphynop2 {
-		compatible = "usb-nop-xceiv";
-		#phy-cells = <0>;
-		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
-		clock-names = "main_clk";
-	};
-
-	soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x80000000>,
-			 <0x28000000 0x0 0x28000000 0x10000000>;
-
-		aips1: bus@44000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x44000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			edma1: dma-controller@44000000 {
-				compatible = "fsl,imx93-edma3";
-				reg = <0x44000000 0x200000>;
-				#dma-cells = <3>;
-				dma-channels = <31>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,  //  0: Reserved
-					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,  //  1: CANFD1
-					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,  //  2: Reserved
-					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,  //  3: GPIO1 CH0
-					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,  //  4: GPIO1 CH1
-					     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, //  5: I3C1 TO Bus
-					     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, //  6: I3C1 From Bus
-					     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>, //  7: LPI2C1 M TX
-					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, //  8: LPI2C1 S TX
-					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>, //  9: LPI2C2 M RX
-					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>, // 10: LPI2C2 S RX
-					     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>, // 11: LPSPI1 TX
-					     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>, // 12: LPSPI1 RX
-					     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, // 13: LPSPI2 TX
-					     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>, // 14: LPSPI2 RX
-					     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>, // 15: LPTMR1
-					     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>, // 16: LPUART1 TX
-					     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>, // 17: LPUART1 RX
-					     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, // 18: LPUART2 TX
-					     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>, // 19: LPUART2 RX
-					     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>, // 20: S400
-					     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>, // 21: SAI TX
-					     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, // 22: SAI RX
-					     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, // 23: TPM1 CH0/CH2
-					     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>, // 24: TPM1 CH1/CH3
-					     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>, // 25: TPM1 Overflow
-					     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>, // 26: TMP2 CH0/CH2
-					     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>, // 27: TMP2 CH1/CH3
-					     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, // 28: TMP2 Overflow
-					     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>, // 29: PDM
-					     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>; // 30: ADC1
-				clocks = <&clk IMX93_CLK_EDMA1_GATE>;
-				clock-names = "dma";
-			};
-
-			aonmix_ns_gpr: syscon@44210000 {
-				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
-				reg = <0x44210000 0x1000>;
-			};
-
-			mu1: mailbox@44230000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x44230000 0x10000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU1_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			system_counter: timer@44290000 {
-				compatible = "nxp,sysctr-timer";
-				reg = <0x44290000 0x30000>;
-				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&osc_24m>;
-				clock-names = "per";
-				nxp,no-divider;
-			};
-
-			wdog1: watchdog@442d0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x442d0000 0x10000>;
-				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG1_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog2: watchdog@442e0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x442e0000 0x10000>;
-				interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG2_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			tpm1: pwm@44310000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44310000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM1_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm2: pwm@44320000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x44320000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM2_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			i3c1: i3c@44330000 {
-				compatible = "silvaco,i3c-master-v1";
-				reg = <0x44330000 0x10000>;
-				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <3>;
-				#size-cells = <0>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_I3C1_GATE>,
-					 <&clk IMX93_CLK_I3C1_SLOW>;
-				clock-names = "pclk", "fast_clk", "slow_clk";
-				status = "disabled";
-			};
-
-			lpi2c1: i2c@44340000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44340000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 7 0 0>, <&edma1 8 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c2: i2c@44350000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x44350000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 9 0 0>, <&edma1 10 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi1: spi@44360000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44360000 0x10000>;
-				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 11 0 0>, <&edma1 12 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi2: spi@44370000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x44370000 0x10000>;
-				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
-					 <&clk IMX93_CLK_BUS_AON>;
-				clock-names = "per", "ipg";
-				dmas = <&edma1 13 0 0>, <&edma1 14 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44380000 0x1000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma1 17 0 FSL_EDMA_RX>, <&edma1 16 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x44390000 0x1000>;
-				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma1 19 0 FSL_EDMA_RX>, <&edma1 18 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			flexcan1: can@443a0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x443a0000 0x10000>;
-				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_AON>,
-					 <&clk IMX93_CLK_CAN1_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&aonmix_ns_gpr 0x14 0>;
-				status = "disabled";
-			};
-
-			sai1: sai@443b0000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x443b0000 0x10000>;
-				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI1_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma1 22 0 FSL_EDMA_RX>, <&edma1 21 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			iomuxc: pinctrl@443c0000 {
-				compatible = "fsl,imx93-iomuxc";
-				reg = <0x443c0000 0x10000>;
-				status = "okay";
-			};
-
-			bbnsm: bbnsm@44440000 {
-				compatible = "nxp,imx93-bbnsm", "syscon", "simple-mfd";
-				reg = <0x44440000 0x10000>;
-
-				bbnsm_rtc: rtc {
-					compatible = "nxp,imx93-bbnsm-rtc";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				};
-
-				bbnsm_pwrkey: pwrkey {
-					compatible = "nxp,imx93-bbnsm-pwrkey";
-					interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-					linux,code = <KEY_POWER>;
-				};
-			};
-
-			clk: clock-controller@44450000 {
-				compatible = "fsl,imx93-ccm";
-				reg = <0x44450000 0x10000>;
-				#clock-cells = <1>;
-				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>;
-				clock-names = "osc_32k", "osc_24m", "clk_ext1";
-				assigned-clocks = <&clk IMX93_CLK_AUDIO_PLL>;
-				assigned-clock-rates = <393216000>;
-				status = "okay";
-			};
-
-			src: system-controller@44460000 {
-				compatible = "fsl,imx93-src", "syscon";
-				reg = <0x44460000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				ranges;
-
-				mlmix: power-domain@44461800 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44461800 0x400>, <0x44464800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_ML_APB>,
-						 <&clk IMX93_CLK_ML>;
-				};
-
-				mediamix: power-domain@44462400 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44462400 0x400>, <0x44465800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-						 <&clk IMX93_CLK_MEDIA_APB>;
-				};
-			};
-
-			clock-controller@44480000 {
-				compatible = "fsl,imx93-anatop";
-				reg = <0x44480000 0x2000>;
-				#clock-cells = <1>;
-			};
-
-			tmu: tmu@44482000 {
-				compatible = "fsl,qoriq-tmu";
-				reg = <0x44482000 0x1000>;
-				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_TMC_GATE>;
-				little-endian;
-				fsl,tmu-range = <0x800000da 0x800000e9
-						 0x80000102 0x8000012a
-						 0x80000166 0x800001a7
-						 0x800001b6>;
-				fsl,tmu-calibration = <0x00000000 0x0000000e
-						       0x00000001 0x00000029
-						       0x00000002 0x00000056
-						       0x00000003 0x000000a2
-						       0x00000004 0x00000116
-						       0x00000005 0x00000195
-						       0x00000006 0x000001b2>;
-				#thermal-sensor-cells = <1>;
-			};
-
-			micfil: micfil@44520000 {
-				compatible = "fsl,imx93-micfil";
-				reg = <0x44520000 0x10000>;
-				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_PDM_IPG>,
-					 <&clk IMX93_CLK_PDM_GATE>,
-					 <&clk IMX93_CLK_AUDIO_PLL>;
-				clock-names = "ipg_clk", "ipg_clk_app", "pll8k";
-				dmas = <&edma1 29 0 5>;
-				dma-names = "rx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			adc1: adc@44530000 {
-				compatible = "nxp,imx93-adc";
-				reg = <0x44530000 0x10000>;
-				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ADC1_GATE>;
-				clock-names = "ipg";
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
-		};
-
-		aips2: bus@42000000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			edma2: dma-controller@42000000 {
-				compatible = "fsl,imx93-edma4";
-				reg = <0x42000000 0x210000>;
-				#dma-cells = <3>;
-				dma-channels = <64>;
-				interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_EDMA2_GATE>;
-				clock-names = "dma";
-			};
-
-			wakeupmix_gpr: syscon@42420000 {
-				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
-				reg = <0x42420000 0x1000>;
-			};
-
-			mu2: mailbox@42440000 {
-				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
-				reg = <0x42440000 0x10000>;
-				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_MU2_B_GATE>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: watchdog@42490000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x42490000 0x10000>;
-				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG3_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog4: watchdog@424a0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x424a0000 0x10000>;
-				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			wdog5: watchdog@424b0000 {
-				compatible = "fsl,imx93-wdt";
-				reg = <0x424b0000 0x10000>;
-				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
-				timeout-sec = <40>;
-				status = "disabled";
-			};
-
-			tpm3: pwm@424e0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424e0000 0x1000>;
-				clocks = <&clk IMX93_CLK_TPM3_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm4: pwm@424f0000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x424f0000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM4_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm5: pwm@42500000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42500000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM5_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			tpm6: pwm@42510000 {
-				compatible = "fsl,imx7ulp-pwm";
-				reg = <0x42510000 0x10000>;
-				clocks = <&clk IMX93_CLK_TPM6_GATE>;
-				#pwm-cells = <3>;
-				status = "disabled";
-			};
-
-			i3c2: i3c@42520000 {
-				compatible = "silvaco,i3c-master-v1";
-				reg = <0x42520000 0x10000>;
-				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <3>;
-				#size-cells = <0>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_I3C2_GATE>,
-					 <&clk IMX93_CLK_I3C2_SLOW>;
-				clock-names = "pclk", "fast_clk", "slow_clk";
-				status = "disabled";
-			};
-
-			lpi2c3: i2c@42530000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42530000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 8 0 0>, <&edma2 9 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@42540000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x42540000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 10 0 0>, <&edma2 11 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi3: spi@42550000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42550000 0x10000>;
-				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 12 0 0>, <&edma2 13 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi4: spi@42560000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42560000 0x10000>;
-				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 14 0 0>, <&edma2 15 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42570000 0x1000>;
-				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 18 0 FSL_EDMA_RX>, <&edma2 17 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42580000 0x1000>;
-				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 20 0 FSL_EDMA_RX>, <&edma2 19 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42590000 0x1000>;
-				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 22 0 FSL_EDMA_RX>, <&edma2 21 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x425a0000 0x1000>;
-				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 24 0 FSL_EDMA_RX>, <&edma2 23 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			flexcan2: can@425b0000 {
-				compatible = "fsl,imx93-flexcan";
-				reg = <0x425b0000 0x10000>;
-				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_CAN2_GATE>;
-				clock-names = "ipg", "per";
-				assigned-clocks = <&clk IMX93_CLK_CAN2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <40000000>;
-				fsl,clk-source = /bits/ 8 <0>;
-				fsl,stop-mode = <&wakeupmix_gpr 0x0c 2>;
-				status = "disabled";
-			};
-
-			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
-				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
-				reg-names = "fspi_base", "fspi_mmap";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_FLEXSPI1_GATE>,
-					 <&clk IMX93_CLK_FLEXSPI1_GATE>;
-				clock-names = "fspi_en", "fspi";
-				assigned-clocks = <&clk IMX93_CLK_FLEXSPI1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				status = "disabled";
-			};
-
-			sai2: sai@42650000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x42650000 0x10000>;
-				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 59 0 FSL_EDMA_RX>, <&edma2 58 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			sai3: sai@42660000 {
-				compatible = "fsl,imx93-sai";
-				reg = <0x42660000 0x10000>;
-				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SAI3_IPG>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>;
-				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
-				dmas = <&edma2 61 0 FSL_EDMA_RX>, <&edma2 60 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			xcvr: xcvr@42680000 {
-				compatible = "fsl,imx93-xcvr";
-				reg = <0x42680000 0x800>,
-				      <0x42680800 0x400>,
-				      <0x42680c00 0x080>,
-				      <0x42680e00 0x080>;
-				reg-names = "ram", "regs", "rxfifo", "txfifo";
-				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_SPDIF_IPG>,
-					 <&clk IMX93_CLK_SPDIF_GATE>,
-					 <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
-				clock-names = "ipg", "phy", "spba", "pll_ipg";
-				dmas = <&edma2 65 0 FSL_EDMA_RX>, <&edma2 66 0 0>;
-				dma-names = "rx", "tx";
-				#sound-dai-cells = <0>;
-				status = "disabled";
-			};
-
-			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x42690000 0x1000>;
-				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x426a0000 0x1000>;
-				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-				clock-names = "ipg";
-				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
-				dma-names = "rx", "tx";
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@426b0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426b0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 71 0 0>, <&edma2 72 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c6: i2c@426c0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426c0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 73 0 0>, <&edma2 74 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@426d0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426d0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 75 0 0>, <&edma2 76 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpi2c8: i2c@426e0000 {
-				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x426e0000 0x10000>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 77 0 0>, <&edma2 78 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi5: spi@426f0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x426f0000 0x10000>;
-				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 79 0 0>, <&edma2 80 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi6: spi@42700000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42700000 0x10000>;
-				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 81 0 0>, <&edma2 82 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi7: spi@42710000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42710000 0x10000>;
-				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 83 0 0>, <&edma2 84 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-			lpspi8: spi@42720000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
-				reg = <0x42720000 0x10000>;
-				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
-					 <&clk IMX93_CLK_BUS_WAKEUP>;
-				clock-names = "per", "ipg";
-				dmas = <&edma2 85 0 0>, <&edma2 86 0 FSL_EDMA_RX>;
-				dma-names = "tx", "rx";
-				status = "disabled";
-			};
-
-		};
-
-		aips3: bus@42800000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x42800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usdhc1: mmc@42850000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42850000 0x10000>;
-				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC1_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC1>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <8>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@42860000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x42860000 0x10000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC2_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC2>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <4>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-
-			fec: ethernet@42890000 {
-				compatible = "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
-				reg = <0x42890000 0x10000>;
-				interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET1_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER1>,
-					 <&clk IMX93_CLK_ENET_REF>,
-					 <&clk IMX93_CLK_ENET_REF_PHY>;
-				clock-names = "ipg", "ahb", "ptp",
-					      "enet_clk_ref", "enet_out";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
-						  <&clk IMX93_CLK_ENET_REF>,
-						  <&clk IMX93_CLK_ENET_REF_PHY>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>, <50000000>;
-				fsl,num-tx-queues = <3>;
-				fsl,num-rx-queues = <3>;
-				fsl,stop-mode = <&wakeupmix_gpr 0x0c 1>;
-				nvmem-cells = <&eth_mac1>;
-				nvmem-cell-names = "mac-address";
-				status = "disabled";
-			};
-
-			eqos: ethernet@428a0000 {
-				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
-				reg = <0x428a0000 0x10000>;
-				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "macirq", "eth_wake_irq";
-				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER2>,
-					 <&clk IMX93_CLK_ENET>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>;
-				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
-						  <&clk IMX93_CLK_ENET>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>;
-				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <6>;
-				nvmem-cells = <&eth_mac2>;
-				nvmem-cell-names = "mac-address";
-				status = "disabled";
-			};
-
-			usdhc3: mmc@428b0000 {
-				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x428b0000 0x10000>;
-				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
-					 <&clk IMX93_CLK_WAKEUP_AXI>,
-					 <&clk IMX93_CLK_USDHC3_GATE>;
-				clock-names = "ipg", "ahb", "per";
-				assigned-clocks = <&clk IMX93_CLK_USDHC3>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
-				assigned-clock-rates = <400000000>;
-				bus-width = <4>;
-				fsl,tuning-start-tap = <1>;
-				fsl,tuning-step = <2>;
-				status = "disabled";
-			};
-		};
-
-		gpio2: gpio@43810000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43810000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
-				 <&clk IMX93_CLK_GPIO2_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 4 30>;
-		};
-
-		gpio3: gpio@43820000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43820000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
-				 <&clk IMX93_CLK_GPIO3_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
-				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
-		};
-
-		gpio4: gpio@43830000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x43830000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
-				 <&clk IMX93_CLK_GPIO4_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
-		};
-
-		gpio1: gpio@47400000 {
-			compatible = "fsl,imx93-gpio", "fsl,imx8ulp-gpio";
-			reg = <0x47400000 0x1000>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
-				 <&clk IMX93_CLK_GPIO1_GATE>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc 0 92 16>;
-		};
-
-		ocotp: efuse@47510000 {
-			compatible = "fsl,imx93-ocotp", "syscon";
-			reg = <0x47510000 0x10000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			eth_mac1: mac-address@4ec {
-				reg = <0x4ec 0x6>;
-			};
-
-			eth_mac2: mac-address@4f2 {
-				reg = <0x4f2 0x6>;
-			};
-
-		};
-
-		s4muap: mailbox@47520000 {
-			compatible = "fsl,imx93-mu-s4";
-			reg = <0x47520000 0x10000>;
-			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tx", "rx";
-			#mbox-cells = <2>;
-		};
-
-		media_blk_ctrl: system-controller@4ac10000 {
-			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
-			reg = <0x4ac10000 0x10000>;
-			power-domains = <&mediamix>;
-			clocks = <&clk IMX93_CLK_MEDIA_APB>,
-				 <&clk IMX93_CLK_MEDIA_AXI>,
-				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
-				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
-				 <&clk IMX93_CLK_CAM_PIX>,
-				 <&clk IMX93_CLK_PXP_GATE>,
-				 <&clk IMX93_CLK_LCDIF_GATE>,
-				 <&clk IMX93_CLK_ISI_GATE>,
-				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
-				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
-			clock-names = "apb", "axi", "nic", "disp", "cam",
-				      "pxp", "lcdif", "isi", "csi", "dsi";
-			#power-domain-cells = <1>;
-			status = "disabled";
-		};
-
-		usbotg1: usb@4c100000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c100000 0x200>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop1>;
-			fsl,usbmisc = <&usbmisc1 0>;
-			status = "disabled";
-		};
-
-		usbmisc1: usbmisc@4c100200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c100200 0x200>;
-			#index-cells = <1>;
-		};
-
-		usbotg2: usb@4c200000 {
-			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
-			reg = <0x4c200000 0x200>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
-				 <&clk IMX93_CLK_HSIO_32K_GATE>;
-			clock-names = "usb_ctrl_root", "usb_wakeup";
-			assigned-clocks = <&clk IMX93_CLK_HSIO>;
-			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
-			assigned-clock-rates = <133000000>;
-			phys = <&usbphynop2>;
-			fsl,usbmisc = <&usbmisc2 0>;
-			status = "disabled";
-		};
-
-		usbmisc2: usbmisc@4c200200 {
-			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
-				     "fsl,imx6q-usbmisc";
-			reg = <0x4c200200 0x200>;
-			#index-cells = <1>;
-		};
-
-		memory-controller@4e300000 {
-			compatible = "nxp,imx9-memory-controller";
-			reg = <0x4e300000 0x800>, <0x4e301000 0x1000>;
-			reg-names = "ctrl", "inject";
-			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			little-endian;
-		};
-
-		ddr-pmu@4e300dc0 {
-			compatible = "fsl,imx93-ddr-pmu";
-			reg = <0x4e300dc0 0x200>;
-			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-};
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2022,2025 NXP
+ */
+
+#include "imx91_93_common.dtsi"
+
+/{
+	cm33: remoteproc-cm33 {
+		compatible = "fsl,imx93-cm33";
+		clocks = <&clk IMX93_CLK_CM33_GATE>;
+		status = "disabled";
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+
+			thermal-sensors = <&tmu 0>;
+
+			trips {
+				cpu_alert: cpu-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert>;
+					cooling-device =
+						<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+};
+
+&aips1 {
+	mu1: mailbox@44230000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x44230000 0x10000>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU1_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+
+	tmu: tmu@44482000 {
+		compatible = "fsl,qoriq-tmu";
+		reg = <0x44482000 0x1000>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_TMC_GATE>;
+		#thermal-sensor-cells = <1>;
+		little-endian;
+		fsl,tmu-range = <0x800000da 0x800000e9
+				 0x80000102 0x8000012a
+				 0x80000166 0x800001a7
+				 0x800001b6>;
+		fsl,tmu-calibration = <0x00000000 0x0000000e
+				       0x00000001 0x00000029
+				       0x00000002 0x00000056
+				       0x00000003 0x000000a2
+				       0x00000004 0x00000116
+				       0x00000005 0x00000195
+				       0x00000006 0x000001b2>;
+	};
+};
+
+&aips2 {
+	mu2: mailbox@42440000 {
+		compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
+		reg = <0x42440000 0x10000>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clk IMX93_CLK_MU2_B_GATE>;
+		#mbox-cells = <2>;
+		status = "disabled";
+	};
+};
+
+&cpus {
+	A55_0: cpu@0 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x0>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l0>;
+	};
+
+	A55_1: cpu@100 {
+		device_type = "cpu";
+		compatible = "arm,cortex-a55";
+		reg = <0x100>;
+		enable-method = "psci";
+		#cooling-cells = <2>;
+		cpu-idle-states = <&cpu_pd_wait>;
+		i-cache-size = <32768>;
+		i-cache-line-size = <64>;
+		i-cache-sets = <128>;
+		d-cache-size = <32768>;
+		d-cache-line-size = <64>;
+		d-cache-sets = <128>;
+		next-level-cache = <&l2_cache_l1>;
+	};
+
+	l2_cache_l0: l2-cache-l0 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l2_cache_l1: l2-cache-l1 {
+		compatible = "cache";
+		cache-size = <65536>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <2>;
+		cache-unified;
+		next-level-cache = <&l3_cache>;
+	};
+
+	l3_cache: l3-cache {
+		compatible = "cache";
+		cache-size = <262144>;
+		cache-line-size = <64>;
+		cache-sets = <256>;
+		cache-level = <3>;
+		cache-unified;
+	};
+};
+
+&src {
+	mlmix: power-domain@44461800 {
+		compatible = "fsl,imx93-src-slice";
+		reg = <0x44461800 0x400>, <0x44464800 0x400>;
+		clocks = <&clk IMX93_CLK_ML_APB>,
+			 <&clk IMX93_CLK_ML>;
+		#power-domain-cells = <0>;
+	};
+};
-- 
2.37.1


