Return-Path: <netdev+bounces-214991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AC1B2C844
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AF8161430
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71122820A9;
	Tue, 19 Aug 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RuUwtBxm"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013039.outbound.protection.outlook.com [52.101.83.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21042586C9;
	Tue, 19 Aug 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616476; cv=fail; b=HgoJXe8X/oFR6GtdZx+SH4j4sxVjBao4hYo8a96xrLWr+bFybGZR94rI2zRDdouTf5pqaG7bYaZ8jaPChdf8ohH662Se4ehC4qqvoopj3E8tQltFVpQd8m/0GpN15HLviDE3ji1wTCWWKauIT/XU+vNwM/llSUs7d2AXPbdE0SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616476; c=relaxed/simple;
	bh=qeXAGysmfGcrW79W3aRvGxa88oahDFLpcHTz+aZfh6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VY2byDMe3qnLRRw897jDfZrP8/CGxMHo79QgC3kk4h2hQwEB3MUytFQwbdqHAG95lOvHjOuChPh3ob65XwGjaUyzz8g1NbUn2zmN+tVcZ5iFBB24NpFQFVjJ6rXV05yoximB6znLx08VVTQGhfDWjmVdK/YOxDB6oSK7zKrrkjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RuUwtBxm; arc=fail smtp.client-ip=52.101.83.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A19gsMbe+FC5uYaiX3PBNv2Fq9GSwex7eB5z7X33vUfpM/tTt8tn7geO/SFU1+keUVEqr1kS6+dTtTL6DeeUPCaZnIFTtUk8GY1dJHGvW2UAQz8Rqd+mz9yCZda4eMr1ylKOR+Sz9VdywSKbKZLDQj8c35JlVEshMnf49cSS3Rv/AWU34dR2sdBGn6m1vx27x1LTH5YvGLt/Jr6qGfuzAOVoolpR1obfM8tGUPlt3w4vUg5EKpnYQEwNYFgCFCcyJOWLaP/1nScwcfrV35w+dq4iNUULwBNq4ptyJhHFnrGz/I7baIf3M5iICjwj961DmUIyaTloruiJFa7rYL3gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU7AMpk0KslOS5iEQUT1Ivb8e5lwvt5WXHrRt6fZ7PM=;
 b=GrlwImr6nA7xzpui3lG7j1xMp0e556hks//v40DKTueD18S+5jzk7lCOtSYMFHstRp04YWYvnOjSuUVJKFIv4LqGj6r2eht1EVjVjfzMBlhWpR3Ju4Dfxx6iw+jc4zgJ9FOeRD58MzMDX2w5FDOerGvOhnR//t/D6Ybk9QnCMDqqKtvNGjwCcuL4y7x8sJTrBGc89idxuYbYQZkE3RNk+ZBjoQjVjqHJ/HrWMe6dAjzaQXUkOW5ak1svg0+zUTFd59fG10Pv7xJDcwj2px4z6pLXgJJ4K92fHya/WlxC8YloLs2W/RpGOPeiRqOh9iEgCfvQHJiCqHziFD9rEYchBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU7AMpk0KslOS5iEQUT1Ivb8e5lwvt5WXHrRt6fZ7PM=;
 b=RuUwtBxm6/kS+UPmDroN52ifQDh/YAiIJ3LZY4Ai9dmZgFYmig9PSVUbJwoSJNL5RQKm0IhKWVsTwCzcCWOZQ2+0dXrBQsWIzb8hK5DV05R4phEK1pHS6lHdAP4jAQS4i+UOkDJrQW1KXXT01B11x89drB4/8iqRLzoRE0pE3SO/r0K8CWwJEtPdNL4r5tZfFgqhRbbLejwMS2KhRG02uqNXqJbxJ4SQ8oslyxYnt5D1ccatZwjorhxlIQ0zGGdQEKr61jwRAkZl7au5/jq9y1RODldFFIK99Yk+CL65B/TmChViO5ZpP2Er/KYm+4oXK71cd3HL361qVDFgsLB1lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 15:14:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 15:14:30 +0000
Date: Tue, 19 Aug 2025 11:14:20 -0400
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
Subject: Re: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <aKSUzDpO9Yh58XoC@lizhi-Precision-Tower-5810>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-5-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6474baa9-2ddf-4d37-d58e-08dddf3318a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBKCWvc1ffoHf/qvaXnK6kCBjeR00Ztwp2iwG41Thij1GmUe5VKUEfp2hexB?=
 =?us-ascii?Q?kaMCZ6Sff+k6DhpEYJ8t5cjp6fw6TX3arzKgI2tnXX+oVmPTjAbHVogvhONw?=
 =?us-ascii?Q?CDlIy99Yplk3fYCCmP8KKE+PnF9eQBmnFL/vehZDmT3zKK0kWCAeZ9CBCfLK?=
 =?us-ascii?Q?nu6z8PIfUiX25O551Oh0ZhdKX/MvdekV+GIMvd8nxvnRu7wvUGbmHnOwL5bO?=
 =?us-ascii?Q?J5kL748+oAdXnwOBkMB9hkep03NFm+XXw9tmqoqM3yc9QxgNTE95ZHue6Zgf?=
 =?us-ascii?Q?VYESyvZtaANX67k6gvkufgghoHPX7cPZDgIKQgJx6s43AzYLLs4W0oHPEXcw?=
 =?us-ascii?Q?dSJLELK37QRa3IslgOxpoTq4uHEIvIqkJ05VmkuBMNlvAQxz1Ft0daCww7Fl?=
 =?us-ascii?Q?k/VxOiyadHTYfdNIY70j8vU+muKYCiKTIfwGfriKiJQhF/60JMCAy5dlOT+v?=
 =?us-ascii?Q?Pc8GiCcD9ZAwP9zXxzYboI8ZrvaLb6gJDGwya558Dulj7OKQTgT+PZrI6p1w?=
 =?us-ascii?Q?jIfSh2c3GIhRbkLARI+HnGH3lQlBrb5FBWEOXA/aHiuGHiAGac825ckp0P49?=
 =?us-ascii?Q?noAEMWfOeWnAUyxbwHRWLzlBAx3xqnYhXu4l+YwiKZlXk33nl79j59ABSy1G?=
 =?us-ascii?Q?o7o0/5wXXGnnD9+EKRad2uWDLRLMYfajy/tk9ZZY3U3ruR3xRiDcNnRddV0z?=
 =?us-ascii?Q?fqZzkO2/Tijg5J7qpNW6q5UfsWMp4jTXx+bEs1dmV6C+Xw44z/8FellA2tKJ?=
 =?us-ascii?Q?cjdBJyuPxyyzRMlWxpl0u2REdm/RUSEK06g5Z4zPyOcM6EecyFddpfZCe68H?=
 =?us-ascii?Q?RPm5uezzH+r0fFSh9nP2uklPopA+Yvj6rJLmhEhz3NOJoTwko4uHkHw/tc7g?=
 =?us-ascii?Q?qbwYuVbBvpG0J2mVY4UsOWH3LE70HdZsiUk9pK6sOboLAxZzWU4ACDZsYBUN?=
 =?us-ascii?Q?PMyPc5TM2R+E46Ov4biNPrHCH+lmOEtfQeWzO5WwIk5xyrdsfY9bzec6cHOG?=
 =?us-ascii?Q?XJu9w4mZcuMs8YACjHvzK6UqaHPBbA6QpNlBWigJ7UT0Dv2sLeolzKOUHiVz?=
 =?us-ascii?Q?wiplhpewwfSbFb+QBNluN1tgjbpDEYSr97tAfOlhJvx4zBpqjwmCLM0HQ1Qf?=
 =?us-ascii?Q?ishfitIjYxruwvICl22oUQQlzaYQLFIVN4P5lbKxmqR4a6dsVJewe1/K+ozc?=
 =?us-ascii?Q?yZOsfdOPRSsGqTIZ56ij4kGHeeuRLM5ewiDeSVuFMxL/XaSKQutcdLr5AJfC?=
 =?us-ascii?Q?oiPS4E/NJGPoypEL4EKvtK8og8Z1giex4Jc7RPgSu2az+xT0FrfBYZxLImdB?=
 =?us-ascii?Q?D3iW0/sodgxIYNL/IlIcdJy4qWeMnyp8tQJ3oVolJP710h9zEOHXiFxTk8Ze?=
 =?us-ascii?Q?Z5WzWuw6Bi/1PXkPT9kF28dOAx5ygJrHZtEeA39uD3OD9Mp+T3b9gDydpTyO?=
 =?us-ascii?Q?d/ldbI0JY3jKtBZiDknmbVKhRjDZdxgvWRR1Fmfdgj/i9kZBSMOF8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhnGphNoWMtcf8XsJPBUcMR02k2SQQ7bbFFMqgVGLhSdLeVNpJGkyqowj4fx?=
 =?us-ascii?Q?+OAIktR9d7egV6q9PKdP9r2HMhjbjgISC1ULphKfswzcuUwnA/gyDC3gTg5E?=
 =?us-ascii?Q?m4uiSLCw5LK68bttaK0ASEndDG/DoWFQU0Iazk/cuPeAHjH31VuRXIOoP+n2?=
 =?us-ascii?Q?h8BjjIMeC11HYqL3Xq46/8m7E5MkRf8RLSD0BBYw3ikIdQy7QFbh7O7gypWY?=
 =?us-ascii?Q?58eboZikT3YysXsVNp7dA6HvitRSaENgDgmOvwXBrZUEnm3rZo1OvjB3PRUa?=
 =?us-ascii?Q?uOayeMIbEMMhofhTnDjXp/Y+OwWTXRlKRiXliEKnyQ5ieyhS3zKygt4yt0kk?=
 =?us-ascii?Q?o8n1nC89KvhfTtNzokGL0WfIUUnY22qwSNj89W3V7OAwShCwUeGDtA8kPBk+?=
 =?us-ascii?Q?4914pUuanqNSMlSsUdpjB/olulbQ9pEZ56Ih2wwx8MlXZBEqqbv58VNsVwmF?=
 =?us-ascii?Q?s0CFpU7opUkCN/j3FfUXQYmiCLx0qFkiQi5oAMrp+VlTalq3iPZgJqdX5L9t?=
 =?us-ascii?Q?BqIH3tgKwXQH3G8O6nBJt90uIayfliun8U1KXcPC0s8PbP9QUWa7EWIoHv0q?=
 =?us-ascii?Q?NFbLiJwvAHopTRtEpv8fAqW3fjxMlaWbrAuWSLGUPHtUNSZORXmkJU2d22rj?=
 =?us-ascii?Q?ka8iiNmiPGqrqttGMBqTxu4bISg5Hgnmt8azzB1UWxRhQBh8j1S36S5HlQRl?=
 =?us-ascii?Q?Vtucxc43tfsUGekPe5wtqaZXd1r/FTX5lqndBME6uvMttC1cpjLS03aVydmf?=
 =?us-ascii?Q?lkHxK1TtpjDL4SYXNDtOzpHQrX1Qd2LUSZMm8W4AKxPD5FB4R2iiXAjTWKBv?=
 =?us-ascii?Q?SQQz30meCo0uOQvMKOPBeBqsGtH4hcrQnXnvw+sJjfqs8vV9AUClpY3Rp4b5?=
 =?us-ascii?Q?DCC/5e9NDvuwXRiZB0QuXIUUVI229O6XWqQt274W08porEDD+2W9iwpnisNG?=
 =?us-ascii?Q?+g9PCLu0teKcui6whBc4YAixZ38u50so5hYGBp6buYT4UreFDQjfudA3dsjm?=
 =?us-ascii?Q?KK27WPGWwGgpfyCYm7dn7B8gHTKteDnChWSFwFjbOWLuBFmt3ahbQ0g/ofF/?=
 =?us-ascii?Q?9HngEnuL1Pu9B0ncsh9BtvoagdIAx00xmGK7PBuJOk8994QFchzBRDNredGg?=
 =?us-ascii?Q?7t4hc0YtpWCb7OdUAMckoGDlHmheg+8QVn0ZcryM8jCRK5jRBuZtDr4fdjs1?=
 =?us-ascii?Q?LJKlrFfyZhQWM4nkSfa4lKwzYUSKSM5xb8Ss4pzCa52MMRYZ88kmg1+rRUwe?=
 =?us-ascii?Q?8aVNMRXCvY/hwrFfewTt/Pt2tznuOP+yaLRFIcQn4Ws0edG6KYSs7zHwvQ+D?=
 =?us-ascii?Q?HqrZixJKRN2rd+mYqvob83TIXI+9/o+ipcqzjec6Qz7kO5Ybjgs9Sjg1iYRR?=
 =?us-ascii?Q?6P1qiA73whKxfNZbYU/K4O2TgzMyiAwroWKsyDMwwfb2sNczQtTAatmcAvV4?=
 =?us-ascii?Q?7+pxjC9PqUAVoKlYfQsm4mXtt36iG472mSVE6kRt+myZy7e1VIeqwTal7fnx?=
 =?us-ascii?Q?KoGBsj+ASbxT7doIKex7MD5V+FdkhhK/QofNNV+tf8OooJ4CKsxQvJkAnLY3?=
 =?us-ascii?Q?9j63jGGUChOcliztN2OjcGGwokpDSgbQwXG4j13f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6474baa9-2ddf-4d37-d58e-08dddf3318a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 15:14:30.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ts0ARpspCSuz1MaKgGH3YJwPwS/xZVqzUHiuuxXWWpG1jgzASiAxD4mWAVtaa+1pdFhGkRDREn9qBJC+HTHovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827

On Tue, Aug 19, 2025 at 08:36:09PM +0800, Wei Fang wrote:
> NETC V4 Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020.
>
> Inside NETC, ENETC can capture the timestamp of the sent/received packet
> through the PHC provided by the Timer and record it on the Tx/Rx BD. And
> through the relevant PHC interfaces provided by the driver, the enetc V4
> driver can support PTP time synchronization.
>
> In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
> not exactly the same. The current ptp-qoriq driver is not compatible with
> NETC V4 Timer, most of the code cannot be reused, see below reasons.
>
> 1. The architecture of ptp-qoriq driver makes the register offset fixed,
> however, the offsets of all the high registers and low registers of V4
> are swapped, and V4 also adds some new registers. so extending ptp-qoriq
> to make it compatible with V4 Timer is tantamount to completely rewriting
> ptp-qoriq driver.
>
> 2. The usage of some functions is somewhat different from QorIQ timer,
> such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
> PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
> increase the complexity of the code and reduce readability.
>
> 3. QorIQ is an expired brand. It is difficult for us to verify whether
> it works stably on the QorIQ platforms if we refactor the driver, and
> this will make maintenance difficult, so refactoring the driver obviously
> does not bring any benefits.
>
> Therefore, add this new driver for NETC V4 Timer. Note that the missing
> features like PEROUT, PPS and EXTTS will be added in subsequent patches.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
what's change in v4?

> v2 changes:
> 1. Rename netc_timer_get_source_clk() to
>    netc_timer_get_reference_clk_source() and refactor it
> 2. Remove the scaled_ppm check in netc_timer_adjfine()
> 3. Add a comment in netc_timer_cur_time_read()
> 4. Add linux/bitfield.h to fix the build errors
> v3 changes:
> 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
> 2. Remove the check of dma_set_mask_and_coherent()
> 3. Use devm_kzalloc() and pci_ioremap_bar()
> 4. Move alarm related logic including irq handler to the next patch
> 5. Improve the commit message
> 6. Refactor netc_timer_get_reference_clk_source() and remove
>    clk_prepare_enable()
> 7. Use FIELD_PREP() helper
> 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
>    help text.
> 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
>    confirmed TMR_OFF is a signed register.
> v4 changes:
> 1. Remove NETC_TMR_PCI_DEVID
> 2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
> 3. Remove netc_timer_get_phc_index()
> 4. Remove phc_index from struct netc_timer
> 5. Change PTP_NETC_V4_TIMER from bool to tristate
> 6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
> 7. Remove the err log when netc_timer_parse_dt() returns error, instead,
>    add the err log to netc_timer_get_reference_clk_source()
> ---
>  drivers/ptp/Kconfig             |  11 +
>  drivers/ptp/Makefile            |   1 +
>  drivers/ptp/ptp_netc.c          | 416 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/netc_global.h |   3 +-
>  4 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ptp/ptp_netc.c
>
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 204278eb215e..9256bf2e8ad4 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -252,4 +252,15 @@ config PTP_S390
>  	  driver provides the raw clock value without the delta to
>  	  userspace. That way userspace programs like chrony could steer
>  	  the kernel clock.
> +
> +config PTP_NETC_V4_TIMER
> +	tristate "NXP NETC V4 Timer PTP Driver"
> +	depends on PTP_1588_CLOCK
> +	depends on PCI_MSI
> +	help
> +	  This driver adds support for using the NXP NETC V4 Timer as a PTP
> +	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
> +	  synchronization. It also supports periodic output signal (e.g. PPS)
> +	  and external trigger timestamping.
> +
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 25f846fe48c9..8985d723d29c 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
>  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> +obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> new file mode 100644
> index 000000000000..477d922dfbb8
> --- /dev/null
> +++ b/drivers/ptp/ptp_netc.c
> @@ -0,0 +1,416 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC V4 Timer driver
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#define NETC_TMR_PCI_VENDOR_NXP		0x1131
> +
> +#define NETC_TMR_CTRL			0x0080
> +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> +#define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_COMP_MODE			BIT(15)
> +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +
> +#define NETC_TMR_CNT_L			0x0098
> +#define NETC_TMR_CNT_H			0x009c
> +#define NETC_TMR_ADD			0x00a0
> +#define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_OFF_L			0x00b0
> +#define NETC_TMR_OFF_H			0x00b4
> +
> +#define NETC_TMR_FIPER_CTRL		0x00dc
> +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +
> +#define NETC_TMR_CUR_TIME_L		0x00f0
> +#define NETC_TMR_CUR_TIME_H		0x00f4
> +
> +#define NETC_TMR_REGS_BAR		0
> +
> +#define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_DEFAULT_PRSC		2
> +
> +/* 1588 timer reference clock source select */
> +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> +
> +#define NETC_TMR_SYSCLK_333M		333333333U
> +
> +struct netc_timer {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	spinlock_t lock; /* Prevent concurrent access to registers */
> +
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info caps;
> +	u32 clk_select;
> +	u32 clk_freq;
> +	u32 oclk_prsc;
> +	/* High 32-bit is integer part, low 32-bit is fractional part */
> +	u64 period;
> +};
> +
> +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
> +
> +static const char *const timer_clk_src[] = {
> +	"ccm_timer",
> +	"ext_1588"
> +};
> +
> +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> +{
> +	u32 tmr_cnt_h = upper_32_bits(ns);
> +	u32 tmr_cnt_l = lower_32_bits(ns);
> +
> +	/* Writes to the TMR_CNT_L register copies the written value
> +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> +	 * register copies the values written into the shadow TMR_CNT_H
> +	 * register. Contents of the shadow registers are copied into
> +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> +	 * register first.

You have not answer my question, does other _L _H have the same behavior,
like below OFF_L and OFF_H?

Frank
> +	 */
> +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
> +}
> +
> +static u64 netc_timer_offset_read(struct netc_timer *priv)
> +{
> +	u32 tmr_off_l, tmr_off_h;
> +	u64 offset;
> +
> +	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
> +	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
> +	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
> +
> +	return offset;
> +}
> +
> +static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
> +{
> +	u32 tmr_off_h = upper_32_bits(offset);
> +	u32 tmr_off_l = lower_32_bits(offset);
> +
> +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
> +}
> +
> +static u64 netc_timer_cur_time_read(struct netc_timer *priv)
> +{
> +	u32 time_h, time_l;
> +	u64 ns;
> +
> +	/* The user should read NETC_TMR_CUR_TIME_L first to
> +	 * get correct current time.
> +	 */
> +	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> +	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> +	ns = (u64)time_h << 32 | time_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
> +{
> +	u32 fractional_period = lower_32_bits(period);
> +	u32 integral_period = upper_32_bits(period);
> +	u32 tmr_ctrl, old_tmr_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> +				    TMR_CTRL_TCLK_PERIOD);
> +	if (tmr_ctrl != old_tmr_ctrl)
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 new_period;
> +
> +	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
> +	netc_timer_adjust_period(priv, new_period);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	s64 tmr_off;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> +	 * counter keeps increasing during reading and writing
> +	 * TMR_CNT, which will cause latency.
> +	 */
> +	tmr_off = netc_timer_offset_read(priv);
> +	tmr_off += delta;
> +	netc_timer_offset_write(priv, tmr_off);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	u64 ns;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	ptp_read_system_prets(sts);
> +	ns = netc_timer_cur_time_read(priv);
> +	ptp_read_system_postts(sts);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 ns = timespec64_to_ns(ts);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	netc_timer_offset_write(priv, 0);
> +	netc_timer_cnt_write(priv, ns);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct ptp_clock_info netc_timer_ptp_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "NETC Timer PTP clock",
> +	.max_adj	= 500000000,
> +	.n_pins		= 0,
> +	.adjfine	= netc_timer_adjfine,
> +	.adjtime	= netc_timer_adjtime,
> +	.gettimex64	= netc_timer_gettimex64,
> +	.settime64	= netc_timer_settime64,
> +};
> +
> +static void netc_timer_init(struct netc_timer *priv)
> +{
> +	u32 fractional_period = lower_32_bits(priv->period);
> +	u32 integral_period = upper_32_bits(priv->period);
> +	u32 tmr_ctrl, fiper_ctrl;
> +	struct timespec64 now;
> +	u64 ns;
> +	int i;
> +
> +	/* Software must enable timer first and the clock selected must be
> +	 * active, otherwise, the registers which are in the timer clock
> +	 * domain are not accessible.
> +	 */
> +	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> +		   TMR_CTRL_TE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> +
> +	/* Disable FIPER by default */
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		fiper_ctrl &= ~FIPER_CTRL_PG(i);
> +	}
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +	ktime_get_real_ts64(&now);
> +	ns = timespec64_to_ns(&now);
> +	netc_timer_cnt_write(priv, ns);
> +
> +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> +	 */
> +	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
> +		    TMR_COMP_MODE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +}
> +
> +static int netc_timer_pci_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	priv->pdev = pdev;
> +	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
> +	if (!priv->base) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +release_mem_regions:
> +	pci_release_mem_regions(pdev);
> +disable_dev:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_pci_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->base);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct clk *clk;
> +	int i;
> +
> +	/* Select NETC system clock as the reference clock by default */
> +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> +
> +	/* Update the clock source of the reference clock if the clock
> +	 * is specified in DT node.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
> +		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
> +		if (IS_ERR(clk))
> +			return dev_err_probe(dev, PTR_ERR(clk),
> +					     "Failed to enable clock\n");
> +
> +		if (clk) {
> +			priv->clk_freq = clk_get_rate(clk);
> +			priv->clk_select = i ? NETC_TMR_EXT_OSC :
> +					       NETC_TMR_CCM_TIMER1;
> +			break;
> +		}
> +	}
> +
> +	/* The period is a 64-bit number, the high 32-bit is the integer
> +	 * part of the period, the low 32-bit is the fractional part of
> +	 * the period. In order to get the desired 32-bit fixed-point
> +	 * format, multiply the numerator of the fraction by 2^32.
> +	 */
> +	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_parse_dt(struct netc_timer *priv)
> +{
> +	return netc_timer_get_reference_clk_source(priv);
> +}
> +
> +static int netc_timer_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	err = netc_timer_pci_probe(pdev);
> +	if (err)
> +		return err;
> +
> +	priv = pci_get_drvdata(pdev);
> +	err = netc_timer_parse_dt(priv);
> +	if (err)
> +		goto timer_pci_remove;
> +
> +	priv->caps = netc_timer_ptp_caps;
> +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	spin_lock_init(&priv->lock);
> +
> +	netc_timer_init(priv);
> +	priv->clock = ptp_clock_register(&priv->caps, dev);
> +	if (IS_ERR(priv->clock)) {
> +		err = PTR_ERR(priv->clock);
> +		goto timer_pci_remove;
> +	}
> +
> +	return 0;
> +
> +timer_pci_remove:
> +	netc_timer_pci_remove(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	ptp_clock_unregister(priv->clock);
> +	netc_timer_pci_remove(pdev);
> +}
> +
> +static const struct pci_device_id netc_timer_id_table[] = {
> +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> +
> +static struct pci_driver netc_timer_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = netc_timer_id_table,
> +	.probe = netc_timer_probe,
> +	.remove = netc_timer_remove,
> +};
> +module_pci_driver(netc_timer_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> index fdecca8c90f0..763b38e05d7d 100644
> --- a/include/linux/fsl/netc_global.h
> +++ b/include/linux/fsl/netc_global.h
> @@ -1,10 +1,11 @@
>  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/* Copyright 2024 NXP
> +/* Copyright 2024-2025 NXP
>   */
>  #ifndef __NETC_GLOBAL_H
>  #define __NETC_GLOBAL_H
>
>  #include <linux/io.h>
> +#include <linux/pci.h>
>
>  static inline u32 netc_read(void __iomem *reg)
>  {
> --
> 2.34.1
>

