Return-Path: <netdev+bounces-212982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5EB22BA2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF88F42662B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBA6302CB2;
	Tue, 12 Aug 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h5wiQ0ZP"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E12F547D;
	Tue, 12 Aug 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012256; cv=fail; b=aiYouZrrBwfAfvN8eweCOccI5gGs3IoPUgmhlWFvCiaiHcMcJ7z1UWV0jXLaxXgYff0bIgedpkeSgE26qzQDgqaHkOPOnNZK+e0uKpTScoESKYKYy0pWOc73oRNqf5Zp7bFy2Vh+Xl8DYvO+BU+X7MNSaGnHNxz8DYwjAVjYXII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012256; c=relaxed/simple;
	bh=fcziUALFITPVmGX2YXYn33KGRkslmmoVekqL5n6M7Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tw2I4bIcgHmhxYLszBuVfHO0aCRfbLXCndiPjKtcOcXxa9fFvz1Eijlekw5ri9ZOTUG8EdA6b4X/7QSZ6UTjK7zH3G3djtuq+XZzf2Es36eaum1xnHHhKQB4DN4B2/vZH9H4T8VNGbPKoCMG1Aufcu3KL/9CKUiE5Zk53YEdKN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h5wiQ0ZP; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dd9f8QKunHqO2fmRUv/LEaB1L/NvtFkw2eVi+0FnwWyfTVoDk9dmqUPdg/RlvrYUGEhct5W4RWPWyC/dfNGQVEU2l434WJVPntpt2kZ89DaEfMTBiNiEYVqcf+M0LTjjSErLHQIy/P639kMbXvyt887yJ2OIU8kSc2KVz875mDP4pFB38ldXYYMsfmqSgEeBK81w39UzgX2/MUSc+uMbckepR8sz6hZLfcdltlrl3j2T3u4yIM2Lm4T+Pww1gFtk7nMkKCpUjD4E/Ow3sGKPIYGrMvCU9q5Pqr+N54J/e2qe2UpjJnMtl/M02pejMjyY121ktiAqXmw/wIXdhdOpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy6NEabTlUxm8YKLyULT9gPH2iXtiU819eqhoNEHTqM=;
 b=P5OvAXS7SrtzhDDmd78AKMng+fbIGSxyn7GHe/avbKJSwMuuIVUSholdJEccozisOcS9rSY6pQmd60BBNKuvFOevQR9JMYax0jMH9zrTZwuvs2eRpACiL1p6ljP3/WH3Uk3OtnyuVfTYnMS/+Dr1q9/2CNpYMJn3zm/ljOihjERfreNIFx2Qj/FQEoYdu+4Td5ictrK4AfMHQadgjfPdAaksoim+O87/IBE0+dKHm0cQgD46EjqJsTWPpg2DgXOpO0KAe2qMKKMJ+2Nc15zqfxRVEp3oYlH2XngracTL43tTNHOF1AwuiTgnv1/rk46JZ4DsGNpvkLjwbON66+Vutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy6NEabTlUxm8YKLyULT9gPH2iXtiU819eqhoNEHTqM=;
 b=h5wiQ0ZPobzKYlQecutGMNfxpKd1dkM/iNhR4h2d4vPRJZxuWV0b0+8QNGvpQdZUwpbqWbn/2c2l12vGf485L2XYmwtVVL3cGR+ezJ2o9OfSItAflP5zQo5XZBJu+l0LDgfOd/l+XIURrQZuX/3FjaXjQfd09VcaS3pj2Yp954VDlDtFsnEyoasNTU9FvLV/DZ4v4XpRX3fLhkv3lbTojqH+Qnn+k8kYbnSdf4jebgwUMn3Lyqz9KbFsLdeyQd+2iL+iIl87SvEtqGSHeu65PwgEtf8YnY8dXicvu3PAPTHltKYTYUnsPRNWQcfYHBJ2YlptneYiJbW9Z/+esW46sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 15:24:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:24:10 +0000
Date: Tue, 12 Aug 2025 11:24:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output
 support
Message-ID: <aJtckR0o71mi3PR5@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-7-wei.fang@nxp.com>
X-ClientProxiedBy: PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d988faf-d5cd-42ef-e5fa-08ddd9b44943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vCHfPYVEufk+JisbdPZvXUDFKr0wN6JJkiZw4URpXE/+Gnry68E6PSawJY5N?=
 =?us-ascii?Q?QtbzoMQvbWd4Eohf6CIW9Z05z20h2EPqPYDR2Ox5ROS0dXOAaRoyIIji55ey?=
 =?us-ascii?Q?PsxgTnEGOtL/f2NWoXGb7cNdw+reu1bHmzgE2Ud3MN3FZ8GTuRcB6EtdWDpR?=
 =?us-ascii?Q?80/47qu9kbCTuVFBU8MfAPSF+RSkWivyH3vE8AK9dvCLOL+D8FLJfp8EAFH1?=
 =?us-ascii?Q?Ly/FrQFHBJ1Tzc3o3mNbfKLTXh2OuS/8W1Z4acYH/a7h/xhoShEs5oiMlHKz?=
 =?us-ascii?Q?01UthfLxLAu4aktTxiqb9jWnxjcm+C9E0+wbpbfizE9msDKPGzxz4D2wnaOa?=
 =?us-ascii?Q?NiIBmrowENrlyD8F+EtiKUaYtgCe9W+B0CXd/V5+KPKS0vW5Z5XGb2koXMmU?=
 =?us-ascii?Q?9FLlD1BPSwX3oCf6M0tEGJm6jNoUT1X7Uh4O22D4gSVUsXiAiAb8L+SZQg+a?=
 =?us-ascii?Q?VdRKc8Pz+G9P+1LISYieFxYAAbZePSfyRToAFb67DavaSUymtRujqlz9+OuU?=
 =?us-ascii?Q?/PUTNQ8JIrmBsHC9XhnYOz+1nEFXCiG9QBGh9H/2ncPNsv5Yt+NQc9SzBL0K?=
 =?us-ascii?Q?2VQu2vVFk6ivTRdcDQ/6DwxLIKd7hVRoha1Ii/poBMx4OUgop+ceIKwDoX+N?=
 =?us-ascii?Q?01bDfkODYiW/yOyjGMdTbsbZQfvy3oeQgtVv5sMp6w3iQptEqsFqt2EAg0dW?=
 =?us-ascii?Q?F+T2KjUPripSHaPrUy047IqceHun4qToOaQQNOBNWWwjOkNZbqtlXRHAAGFy?=
 =?us-ascii?Q?vh/N63brOMO2nWu+1E7WhHnjSD64+SR2dX52/rig+B7wdEZ/Sc+9O6Pm+mfH?=
 =?us-ascii?Q?0J1dSumXzo7DPGbdHWBHaWQaTIYMq2QE0uojXdtkXik2KBQuLk87uQG3am94?=
 =?us-ascii?Q?p8gfZyBM/NyqxTluZ86ixWCFOeV2YoASR4/LiesWMvCm0nqnPchU5Lf9Z4dp?=
 =?us-ascii?Q?jzBWtCWvNhwpmLSLa3LfXH5uYUrBzFJlD+ER1y3G1ZSahD0YopvJuV3siKx0?=
 =?us-ascii?Q?9/GrGZg4ysgxmwK5kHDnMAFXoFPm2AtsC/y8sZkGQe1otbZ3gnA9qMGxuSwb?=
 =?us-ascii?Q?7+l1iU2m/uo4jUWigcPwlYV01JuPAleviRqn0gLiPtlxtKwXiIW8wL9nvczF?=
 =?us-ascii?Q?KES5FQmwu5hLKmllI6LJZNYu93dM29DkqmWbl6yr5BrWfCUjOtQZHzlXseS1?=
 =?us-ascii?Q?jkkoN5HoAId8Ha/F4ki2TZXHij3G5YC1u5Iv5I4Y+9Ag2o90tkN8Fb7elTqD?=
 =?us-ascii?Q?Qv9qpcRoCoRaYUWlBX+6JId4Mj1ZGkWXpmmHIzBqD8x92feQNlwBZl8Zexof?=
 =?us-ascii?Q?rJgs0RChGGQ8sbw9/GO6ddycgYMpyZG7qVzk+PTMUIieBol3tzmhKbsrME+e?=
 =?us-ascii?Q?nl+bUJZsD5GOcDr7FhKMwSTYTSCri01kdtwFRyHtqlcWmPC9pHJo4aOLQi0n?=
 =?us-ascii?Q?fiqeqkagDdfozr5VI8ntyCs0ldjsfa+iQ8Hl8AEQu+l9A3I8hC+Bow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErZAUnt3yAxwelexOglIIGKLZVeefZLmXyVu9UpKSf2yRjaC4Z0LiIGO2wKg?=
 =?us-ascii?Q?xDpdchwtjBJewsxqe04ckgx5Atb85djtFo/3A19MxhgDbtsJDWTw7MTWdOdD?=
 =?us-ascii?Q?OZNnzekF9ikEoFE18HRwNaUNswGqTAy+ynoDjfGQS2EMWe1HBYOZy0Yy5qg4?=
 =?us-ascii?Q?x2he68wPNdulF35/mtZiGmoUoqMChwz0ml56PY4Sj7SgujXmaHlftOI8IxGo?=
 =?us-ascii?Q?KpApf4NZ2r5mBv+zAOISKIpRl5g5bihjzWRDby1eeIi+H4rFG1+abpZPcrI6?=
 =?us-ascii?Q?dWFjNtGlgdkDEDSoLMIzMjlH6GH5OCkZIA6ATPnUW8AwanCebUy5T3iczbV/?=
 =?us-ascii?Q?DFaMDKaHBKuR2im8QCXmPVvWfGXCKw58b71NU9RJXQbyY7zznvh4BYqoPxTT?=
 =?us-ascii?Q?8QB0DXZ/8kSyVvj+gcvyXPwtCRHMWL1lHjQZa5MEkUiQ4V/Tu2clZTo3CvhT?=
 =?us-ascii?Q?eDbpLo/6mjGohX5Utt5+OWYlC95xrswVYymdpcIu6VvcVgzbsQnB0xO912Xh?=
 =?us-ascii?Q?RdcHYcKGYSYgXsA8KQ5scrS/j+dGKJ98l0HMNJRH4eh7N6JpZTU6CSkPuZ7P?=
 =?us-ascii?Q?8NhwFOcfzrppsuAL7GKEp8s42J2UhYLs3LFEyU/pa2ezFZSRoxoyXOJZ9ozy?=
 =?us-ascii?Q?CH8BSI1Wrzx5BfAx3ybIqyzkKm0Av2MnBeC/jdOACWjzjDvVu6qDQr1CJPky?=
 =?us-ascii?Q?k6c1Q+U6dAeHmSA3nQ0fEHGXYFKzeaPGLnRfeQPyzt9U+a8i2wqNFsKUAAw1?=
 =?us-ascii?Q?rOAmoz5Mm5x1Hoe469KGe5G9rBnQW0WsnHECpSrfcYyWFFonf9slgfXd2g9W?=
 =?us-ascii?Q?CM7t/oWJhSZkanwjbAtKr4GmrodFKf0ay638eHSncUE5aOysVaFjK0rWOFbQ?=
 =?us-ascii?Q?iFM1gVOKjV9vizDECbAcr2Kz5FFbgPneOVur9/zKfXLNycXCKC2v1VsUFbY9?=
 =?us-ascii?Q?j2c2V30+8UXVZdEvBU6c71ZGJOyFc1jLh1R2zaIx4wxDnShzY2nbVGURwjX0?=
 =?us-ascii?Q?nwefMze+RosJGG4tp6LfdEj2LzCTgmge/+Tyaujzi2+1GGMVMZN3GC237UXt?=
 =?us-ascii?Q?lQh9oaOHWhLmbVtXbWLlG7mAb2cwse4mIAS2rVDkjD8O0+xcLoQd2fIw0AA4?=
 =?us-ascii?Q?4oajP/1tF8wQZoOtl7d6+5OGZLvcI1/i7Hv3s4fDxgjrzVmM7f1nO8xOc5p1?=
 =?us-ascii?Q?me6mnMiq4++RL8LnmIPVQGH22KISWBQBfoIPV/HqoXbcgH3pKP5Kv/QfE7Sv?=
 =?us-ascii?Q?6TSgEaIE/D+Ql6Mxb1/7YGH/QLBVxp5fxFcu+EtpzfmeDjXnYVYkxsp+OcO/?=
 =?us-ascii?Q?pItcCbyICoIy2/Jr7/uiVQzcirRaUls3CfPlrn9p4N9aoahqELBd4txaMwhO?=
 =?us-ascii?Q?irZrFaIcP96AXG4GeGEv5qSz0R5KuaYqnNw/rnZLrPvwfPKqFTI0GjJqAnNw?=
 =?us-ascii?Q?4n7TbovpOVOMp6jNdJyVYKL0UWukuUffhs8hh0QXqHEEodo6+J3fB1VxLBUp?=
 =?us-ascii?Q?Luf0BBCwrfLtR5TddlcEz3Gx2DwKYaLX4md7yDVvMFygN9lmkKkXy5pYx/XT?=
 =?us-ascii?Q?NJeAYs9UGERuHff366ES2GEzBfTrLi3a9/rey5Tq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d988faf-d5cd-42ef-e5fa-08ddd9b44943
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:24:10.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRgkTI1FzkPkeeTc+gQoTGR3MYseT0eOdSavTyDLkroSYNynDN2uqSMhoYneS5DHux6IB+qt2gEGpbSc0u3CWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

On Tue, Aug 12, 2025 at 05:46:25PM +0800, Wei Fang wrote:
> NETC Timer has three pulse channels, all of which support periodic pulse
> output. Bind the channel to a ALARM register and then sets a future time
> into the ALARM register. When the current time is greater than the ALARM
> value, the FIPER register will be triggered to count down, and when the
> count reaches 0, the pulse will be triggered. The PPS signal is also
> implemented in this way.
>
> For i.MX95, it only has ALARM1 can be used as an indication to the FIPER
> start down counting, but i.MX943 has ALARM1 and ALARM2 can be used. That
> is to say, only one channel can work for i.MX95, two channels for i.MX943
> as most. Current implementation does not allow multiple channels to share
> the same alarm register at the same time.

Keep short and simple.

i.MX96 have only ALARM1. i.MX943 have ALARM1 and ALARM2. So only one channel
for i.MX95, two channels for i.MX943 since channel sharing are not supported
yet.

>
> In addition, because of the introduction of PTP_CLK_REQ_PEROUT support,
> the PPS channel is changed from being fixed to 0 to being dynamically
> selected.

Nit: Change the PPS channel to be dynamically selected from fixed number (0)
because add PTP_CLK_REQ_PEROUT support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2: no changes
> v3 changes:
> 1. Improve the commit message
> 2. Add revision to struct netc_timer
> 3. Use priv->tmr_emask to instead of reading TMR_EMASK register
> 4. Add pps_channel to struct netc_timer and NETC_TMR_INVALID_CHANNEL
> 5. Add some helper functions: netc_timer_enable/disable_periodic_pulse(),
>    and netc_timer_select_pps_channel()
> 6. Dynamically select PPS channel instead of fixed to channel 0.
> ---
>  drivers/ptp/ptp_netc.c | 356 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 306 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 9026a967a5fe..aa88767f8355 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -53,12 +53,18 @@
>  #define NETC_TMR_CUR_TIME_H		0x00f4
>
>  #define NETC_TMR_REGS_BAR		0
> +#define NETC_GLOBAL_OFFSET		0x10000
> +#define NETC_GLOBAL_IPBRR0		0xbf8
> +#define  IPBRR0_IP_REV			GENMASK(15, 0)
> +#define NETC_REV_4_1			0x0401
>
>  #define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_INVALID_CHANNEL	NETC_TMR_FIPER_NUM
>  #define NETC_TMR_DEFAULT_PRSC		2
>  #define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
>  #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
>  #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
> +#define NETC_TMR_ALARM_NUM		2
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -67,6 +73,19 @@
>
>  #define NETC_TMR_SYSCLK_333M		333333333U
>
> +enum netc_pp_type {
> +	NETC_PP_PPS = 1,
> +	NETC_PP_PEROUT,
> +};
> +
> +struct netc_pp {
> +	enum netc_pp_type type;
> +	bool enabled;
> +	int alarm_id;
> +	u32 period; /* pulse period, ns */
> +	u64 stime; /* start time, ns */
> +};
> +
>  struct netc_timer {
>  	void __iomem *base;
>  	struct pci_dev *pdev;
> @@ -82,8 +101,12 @@ struct netc_timer {
>  	u64 period;
>
>  	int irq;
> +	int revision;
>  	u32 tmr_emask;
> -	bool pps_enabled;
> +	u8 pps_channel;
> +	u8 fs_alarm_num;
> +	u8 fs_alarm_bitmap;
> +	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -192,6 +215,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
>  static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  				     u32 integral_period)
>  {
> +	struct netc_pp *pp = &priv->pp[channel];
>  	u64 alarm;
>
>  	/* Get the alarm value */
> @@ -199,7 +223,116 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  	alarm = roundup_u64(alarm, NSEC_PER_SEC);
>  	alarm = roundup_u64(alarm, integral_period);
>
> -	netc_timer_alarm_write(priv, alarm, 0);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
> +					u32 integral_period)
> +{
> +	u64 cur_time = netc_timer_cur_time_read(priv);
> +	struct netc_pp *pp = &priv->pp[channel];
> +	u64 alarm, delta, min_time;
> +	u32 period = pp->period;
> +	u64 stime = pp->stime;
> +
> +	min_time = cur_time + NSEC_PER_MSEC + period;
> +	if (stime < min_time) {
> +		delta = min_time - stime;
> +		stime += roundup_u64(delta, period);
> +	}
> +
> +	alarm = roundup_u64(stime - period, integral_period);
> +	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
> +}
> +
> +static int netc_timer_get_alarm_id(struct netc_timer *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < priv->fs_alarm_num; i++) {
> +		if (!(priv->fs_alarm_bitmap & BIT(i))) {
> +			priv->fs_alarm_bitmap |= BIT(i);
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
> +{
> +	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
> +	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
> +	 */
> +
> +	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
> +		       priv->clk_freq);
> +}
> +
> +static void netc_timer_enable_periodic_pulse(struct netc_timer *priv,
> +					     u8 channel)
> +{
> +	u32 fiper_pw, fiper, fiper_ctrl, integral_period;
> +	struct netc_pp *pp = &priv->pp[channel];
> +	int alarm_id = pp->alarm_id;
> +
> +	integral_period = netc_timer_get_integral_period(priv);
> +	/* Set to desired FIPER interval in ns - TCLK_PERIOD */
> +	fiper = pp->period - integral_period;
> +	fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
> +			FIPER_CTRL_FS_ALARM(channel));
> +	fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
> +	fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
> +
> +	priv->tmr_emask |= TMR_TEVNET_PPEN(channel) |
> +			   TMR_TEVENT_ALMEN(alarm_id);
> +
> +	if (pp->type == NETC_PP_PPS)
> +		netc_timer_set_pps_alarm(priv, channel, integral_period);
> +	else
> +		netc_timer_set_perout_alarm(priv, channel, integral_period);
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_disable_periodic_pulse(struct netc_timer *priv,
> +					      u8 channel)
> +{
> +	struct netc_pp *pp = &priv->pp[channel];
> +	int alarm_id = pp->alarm_id;
> +	u32 fiper_ctrl;
> +
> +	if (!pp->enabled)
> +		return;
> +
> +	priv->tmr_emask &= ~(TMR_TEVNET_PPEN(channel) |
> +			     TMR_TEVENT_ALMEN(alarm_id));
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl |= FIPER_CTRL_DIS(channel);
> +
> +	netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(channel), NETC_TMR_DEFAULT_FIPER);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static u8 netc_timer_select_pps_channel(struct netc_timer *priv)
> +{
> +	int i;
> +
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		if (!priv->pp[i].enabled)
> +			return i;
> +	}
> +
> +	return NETC_TMR_INVALID_CHANNEL;
>  }
>
>  /* Note that users should not use this API to output PPS signal on
> @@ -210,77 +343,178 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
>  static int netc_timer_enable_pps(struct netc_timer *priv,
>  				 struct ptp_clock_request *rq, int on)
>  {
> -	u32 fiper, fiper_ctrl;
> +	struct device *dev = &priv->pdev->dev;
>  	unsigned long flags;
> +	struct netc_pp *pp;
> +	int err = 0;
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -
>  	if (on) {
> -		u32 integral_period, fiper_pw;
> +		int alarm_id;
> +		u8 channel;
> +
> +		if (priv->pps_channel < NETC_TMR_FIPER_NUM) {
> +			channel = priv->pps_channel;
> +		} else {
> +			channel = netc_timer_select_pps_channel(priv);
> +			if (channel == NETC_TMR_INVALID_CHANNEL) {
> +				dev_err(dev, "No available FIPERs\n");
> +				err = -EBUSY;
> +				goto unlock_spinlock;
> +			}
> +		}
>
> -		if (priv->pps_enabled)
> +		pp = &priv->pp[channel];
> +		if (pp->enabled)
>  			goto unlock_spinlock;
>
> -		integral_period = netc_timer_get_integral_period(priv);
> -		fiper = NSEC_PER_SEC - integral_period;
> -		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> -		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> -				FIPER_CTRL_FS_ALARM(0));
> -		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
> -		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
> -		priv->pps_enabled = true;
> -		netc_timer_set_pps_alarm(priv, 0, integral_period);
> +		alarm_id = netc_timer_get_alarm_id(priv);
> +		if (alarm_id == priv->fs_alarm_num) {
> +			dev_err(dev, "No available ALARMs\n");
> +			err = -EBUSY;
> +			goto unlock_spinlock;
> +		}
> +
> +		pp->enabled = true;
> +		pp->type = NETC_PP_PPS;
> +		pp->alarm_id = alarm_id;
> +		pp->period = NSEC_PER_SEC;
> +		priv->pps_channel = channel;
> +
> +		netc_timer_enable_periodic_pulse(priv, channel);
>  	} else {
> -		if (!priv->pps_enabled)
> +		/* pps_channel is invalid if PPS is not enabled, so no
> +		 * processing is needed.
> +		 */
> +		if (priv->pps_channel >= NETC_TMR_FIPER_NUM)
>  			goto unlock_spinlock;
>
> -		fiper = NETC_TMR_DEFAULT_FIPER;
> -		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> -				     TMR_TEVENT_ALMEN(0));
> -		fiper_ctrl |= FIPER_CTRL_DIS(0);
> -		priv->pps_enabled = false;
> -		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
> +		pp = &priv->pp[priv->pps_channel];
> +		memset(pp, 0, sizeof(*pp));
> +		priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
>  	}
>
> -	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> -	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return err;
> +}
> +
> +static int net_timer_enable_perout(struct netc_timer *priv,
> +				   struct ptp_clock_request *rq, int on)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	u32 channel = rq->perout.index;
> +	unsigned long flags;
> +	struct netc_pp *pp;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	pp = &priv->pp[channel];
> +	if (pp->type == NETC_PP_PPS) {
> +		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
> +		err = -EBUSY;
> +		goto unlock_spinlock;
> +	}
> +
> +	if (on) {
> +		u64 period_ns, gclk_period, max_period, min_period;
> +		struct timespec64 period, stime;
> +		u32 integral_period;
> +		int alarm_id;
> +
> +		period.tv_sec = rq->perout.period.sec;
> +		period.tv_nsec = rq->perout.period.nsec;
> +		period_ns = timespec64_to_ns(&period);
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
> +		gclk_period = netc_timer_get_gclk_period(priv);
> +		min_period = gclk_period * 4 + integral_period;
> +		if (period_ns > max_period || period_ns < min_period) {
> +			dev_err(dev, "The period range is %llu ~ %llu\n",
> +				min_period, max_period);
> +			err = -EINVAL;
> +			goto unlock_spinlock;
> +		}
> +
> +		if (pp->enabled) {
> +			alarm_id = pp->alarm_id;
> +		} else {
> +			alarm_id = netc_timer_get_alarm_id(priv);
> +			if (alarm_id == priv->fs_alarm_num) {
> +				dev_err(dev, "No available ALARMs\n");
> +				err = -EBUSY;
> +				goto unlock_spinlock;
> +			}
> +
> +			pp->type = NETC_PP_PEROUT;
> +			pp->enabled = true;
> +			pp->alarm_id = alarm_id;
> +		}
> +
> +		stime.tv_sec = rq->perout.start.sec;
> +		stime.tv_nsec = rq->perout.start.nsec;
> +		pp->stime = timespec64_to_ns(&stime);
> +		pp->period = period_ns;
> +
> +		netc_timer_enable_periodic_pulse(priv, channel);
> +	} else {
> +		netc_timer_disable_periodic_pulse(priv, channel);
> +		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
> +		memset(pp, 0, sizeof(*pp));
> +	}
>
>  unlock_spinlock:
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> -	return 0;
> +	return err;
>  }
>
> -static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +static void netc_timer_disable_fiper(struct netc_timer *priv)
>  {
> -	u32 fiper_ctrl;
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
>
> -	if (!priv->pps_enabled)
> -		return;
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		if (!priv->pp[i].enabled)
> +			continue;
> +
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
> +	}
>
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl |= FIPER_CTRL_DIS(0);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>  }
>
> -static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +static void netc_timer_enable_fiper(struct netc_timer *priv)
>  {
> -	u32 fiper_ctrl, integral_period, fiper;
> +	u32 integral_period = netc_timer_get_integral_period(priv);
> +	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	int i;
>
> -	if (!priv->pps_enabled)
> -		return;
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		struct netc_pp *pp = &priv->pp[i];
> +		u32 fiper;
>
> -	integral_period = netc_timer_get_integral_period(priv);
> -	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> -	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
> -	fiper = NSEC_PER_SEC - integral_period;
> +		if (!pp->enabled)
> +			continue;
> +
> +		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
> +
> +		if (pp->type == NETC_PP_PPS)
> +			netc_timer_set_pps_alarm(priv, i, integral_period);
> +		else if (pp->type == NETC_PP_PEROUT)
> +			netc_timer_set_perout_alarm(priv, i, integral_period);
> +
> +		fiper = pp->period - integral_period;
> +		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
> +	}
>
> -	netc_timer_set_pps_alarm(priv, 0, integral_period);
> -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
>  }
>
> @@ -292,6 +526,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
>  	switch (rq->type) {
>  	case PTP_CLK_REQ_PPS:
>  		return netc_timer_enable_pps(priv, rq, on);
> +	case PTP_CLK_REQ_PEROUT:
> +		return net_timer_enable_perout(priv, rq, on);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -310,9 +546,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
>  	if (tmr_ctrl != old_tmr_ctrl) {
> -		netc_timer_disable_pps_fiper(priv);
> +		netc_timer_disable_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> -		netc_timer_enable_pps_fiper(priv);
> +		netc_timer_enable_fiper(priv);
>  	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> @@ -339,7 +575,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>
>  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
>  	 * counter keeps increasing during reading and writing
> @@ -349,7 +585,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  	tmr_off += delta;
>  	netc_timer_offset_write(priv, tmr_off);
>
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -386,10 +622,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> -	netc_timer_disable_pps_fiper(priv);
> +	netc_timer_disable_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> -	netc_timer_enable_pps_fiper(priv);
> +	netc_timer_enable_fiper(priv);
>
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
> @@ -418,6 +654,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.n_pins		= 0,
>  	.n_alarm	= 2,
>  	.pps		= 1,
> +	.n_per_out	= 3,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
> @@ -575,6 +812,9 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
>  	if (tmr_event & TMR_TEVENT_ALMEN(0))
>  		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
>
> +	if (tmr_event & TMR_TEVENT_ALMEN(1))
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
> +
>  	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
>  		event.type = PTP_CLOCK_PPS;
>  		ptp_clock_event(priv->clock, &event);
> @@ -619,6 +859,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
>  	pci_free_irq_vectors(pdev);
>  }
>
> +static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
> +{
> +	u32 val;
> +
> +	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
> +
> +	return val & IPBRR0_IP_REV;
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -631,6 +880,12 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  		return err;
>
>  	priv = pci_get_drvdata(pdev);
> +	priv->revision = netc_timer_get_global_ip_rev(priv);
> +	if (priv->revision == NETC_REV_4_1)
> +		priv->fs_alarm_num = 1;
> +	else
> +		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
> +
>  	err = netc_timer_parse_dt(priv);
>  	if (err) {
>  		if (err != -EPROBE_DEFER)
> @@ -640,6 +895,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
>
>  	priv->caps = netc_timer_ptp_caps;
>  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	priv->pps_channel = NETC_TMR_INVALID_CHANNEL;
>  	spin_lock_init(&priv->lock);
>
>  	err = netc_timer_init_msix_irq(priv);
> --
> 2.34.1
>

