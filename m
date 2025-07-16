Return-Path: <netdev+bounces-207578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C6B07EF8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275C27A93EB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551212BCF65;
	Wed, 16 Jul 2025 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+yzfpid"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6A26FA4B;
	Wed, 16 Jul 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697984; cv=fail; b=WMfEFSHV888C7tiFwu19mWHKFFJR9VL3K4ZHKH9cFD6pQPWLIBx8N2ZsIUjZH5xpn2lJilKRYF2dzMy+EHzAgSqCo/UE1Ep80UouGKlLcmPhrNcjBhQEH43tKmRdYZDBrT0rzKMQMfMOGVlJIQFxlM29Hk+POaDlYIPcBWipm3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697984; c=relaxed/simple;
	bh=JZZHpIQKLLumM1vrQympjbavBIVvsMKQ4cnVjMMIyxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R+0ZH9aqjuZYepc1xP07P3OH0LJ7r9Yo6VDGhj1FITq/8xn2W2nafBsrTsL3o8QHxA26DIXtBZA4TulRDUwCeTfP1Mf5zRjBq8lAyE3nufY+MD0DenxNKqMpaKZnMfyRUOZhkiR8eqjvAv6Tv98xi9mlEvpX8K55RngqLFExCFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+yzfpid; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDPGLY8E+XRcY/rP4TJPiOwNlbh2tbOA/wA/zz4vODHiVr51eqV93jL226RcClV1pybIKOTDwBh7fa9tOF+1j/gnTXBsh4HzuzYoosOetTmTEipcolOPsMS+eY1Tt8zzoZLYS5CbXeY8jYoowwqcvXwdH8Nd4eHSMyOWMKGuDQ4H7YUkhJ0g6y4gptExJds+4kVlZxaYeW+DjMdKayrc22XV+brBmbqC7z6bLJNk6tBG5qVAesnKRrKuoU0yOLLJjq9gtDlAIoki5v6LpZe4a8ny+y5JKya02vvH7iQdGsUAQSaka7et4q6n3CE+3Jc/B9mHFh10LwzdIVDwmP/uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BBcTqiIDVdwWwSM5eFllDK/j6+eQXmqnzqVn7LjCrs=;
 b=GBfZbV4CHigbMEU5bmngDa1XO/JREI7CSnCg5nFdRVHYXTFNr/mvyDNYcUd/LkIKafgNzlAgsOoDw1dqqVJXWp57kOHjwsEy72hLJOcV3zfo6WBQGlVUp+KLDZY744tnVE3Flw5+1Dy+8KMC3OXLASyFnkEXlLIn2pzH3SA9MEhm34Um3XMvYYS9BX1FuX74wJcRRikxG9Ml1iRE57hz4BXepGcW25v/ZqOhampO0R5wnLWQZamql4k1jlJ1Z8UMXbpbUSSZxjsRN9zFg7fklzjb//6X2qxpXZT/ieX44h/WgRTaFBIRpMwX5cNIP2rgCF1ePU7HbLH0c0Dcp4a/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BBcTqiIDVdwWwSM5eFllDK/j6+eQXmqnzqVn7LjCrs=;
 b=T+yzfpidpZfeDTMhD+m9iFg0rvDDpAgEt479TaFBvE7hrfGDP6A9QkCMVroisVvb0xaE47s8sp68L8+JO+z31G7NrddIUVx3zdj64QbO8Rah1FLsic7o7zs+Gu2oRn38loqtdZdK1e6eWLcg+8OczwR+Hxa833hBng6DPXUfTNeEkNgDkDdf0u5l7OnD1KeAiGKRpeEtm2y+tBC+a1d8EI4LQG09lmTRrkymw77GMasEbHRC5wAHt7qRLx0UMyMCYxpVUs9IT+ID2IWtxvV4W6FCir73GJVOwJyVPm8JDZ7kbeMWeawjtK4xLy4Rdg7PU/QwU8UuGX48p76+PJ0NEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 20:32:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:32:59 +0000
Date: Wed, 16 Jul 2025 16:32:53 -0400
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
Subject: Re: [PATCH v2 net-next 07/14] ptp: netc: add debugfs support to loop
 back pulse signal
Message-ID: <aHgMdcOAWujOPOUC@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-8-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: e6044443-d50e-46b8-9f3f-08ddc4a7f426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a7ongZcMOixhRKW94vHL/xKRAXAw3xiIi9cXI3vZ2wxwIm83gjfQaCGDhtpf?=
 =?us-ascii?Q?Kec4y8h3cwMDcyy7aICWONtOqkCrGmtYNBDYOPZ82rWa+R/lQ/bovbCiytb6?=
 =?us-ascii?Q?1+IDBv1Vl+wwoGk6XKx9tzbUZ2Qw4DriFdwWuuw7eInN7w1qgzpa2y8ej5XT?=
 =?us-ascii?Q?GGZEQrQg1BLLZcMG5lPQHN0MOSljcQyBob7K3lpA88IqrmIk9LmeWbOQtPJJ?=
 =?us-ascii?Q?3wrjpms1TeSrM6ixpXdZX/y/JWpEs7ZJLcjW+1zSJwnymDbjm3wc7aDbazth?=
 =?us-ascii?Q?VpcDTB3Ec5bVcAlMQZOH2YXQWlRHS8JycisoQ7JD2qmYgDUUC1ByRal0ZBRe?=
 =?us-ascii?Q?FCSA+Mumo/0h1n1jlJrzrTfRudzjYC+XlXHgHO75eZuy77/HAcf1GZbkMH4b?=
 =?us-ascii?Q?xWbITflGHIMPMW1eeU3PttJSYYgy5idCr8fQMG/x0qH40ligYEdxN6vNJ4q+?=
 =?us-ascii?Q?IGaNnwzoyN2Kx19AOqwTtr1eG6o5T1315HqpWHmzUWb0J1vrOn1pRfT37kjd?=
 =?us-ascii?Q?2I6zrQ/+tYCLJWrTWODKjF3MnLdfqbMncdKkfk6v27EmBtVesA+dDHEsKo19?=
 =?us-ascii?Q?uvKSHLzn+E4qDVawxPgLZ22K7a3zFAiE3XVkzksucoHUwtyisYhj5b21HoMd?=
 =?us-ascii?Q?ZUFM0hsDyZAOEXYTjBY8KBVdZTFaZB4LQNuM1AlZQE66FQQCiu0xLFww7K7f?=
 =?us-ascii?Q?wFUvG9d/hZLGJpIm+yOCLaTMXKwCtA6WZeBVXJONiaSK7AFTOTmykqJMy9CQ?=
 =?us-ascii?Q?9k+AFSbJXKphHtQVwCwiwqYjJYGVa81Lb8CEW2+JAoO4G90Von+hEz4++0qK?=
 =?us-ascii?Q?R9IlLU/AtH2j3VasEltt5Tljmhp2p3w2+AgcJD6dn8czP5e6KCC1R11RRbIZ?=
 =?us-ascii?Q?p82nkE1rEAKhAQSTa2AFm0LTuAImVTEYWosjMni774425aSFL/NqS58C90dO?=
 =?us-ascii?Q?UV8uiee9rYL7M+6OVp54NuEGN+raA4g56WYUJjQ0ukNga7BzWuAHaLWEps5S?=
 =?us-ascii?Q?RLh/1WmYWjXFUBOHjmxF6P3gdkbrGTgdLQiSVjL3eRr1EUL5sIGtkatVr83x?=
 =?us-ascii?Q?qlC1Nl0Fo33kj9mZMKUyCH/TaAydUwH+R/zUgC/wm+K5rjN/6RzCAo112W3B?=
 =?us-ascii?Q?FLI5SRfjFV+WFjOjPUXXNDovx2u1v4Apmr+F55Dgcl+d1nQI3lAXWWbf+1yn?=
 =?us-ascii?Q?vrPih60nbHSB3gcWdA+b4krCz6rNtzgSFscbtlQjbI5KYjZWN0d9B9UOEsW9?=
 =?us-ascii?Q?Smkbw9w9id+FhJWFlc0Wrs0LLNz3KvRmQ080tSMMu1L/zsOw10bVVnYARTR1?=
 =?us-ascii?Q?HCUFn0tPGoJ4uZAdPU6q+sRytKSeIGzqrJHdVAslPAUbup4/vAJOKICUwd+T?=
 =?us-ascii?Q?BBnPFqXOarm0gaPfPakCKbzS3k+NXGZBbyizgiNDE9PNLf9kYHTxK3ekhmPC?=
 =?us-ascii?Q?cyWeMvELt8qScaQ0CujIMOqxLuBtP4eTK39JmsbliVLIRvQF9gG2Zg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gs59J/P9M1KiN1CAmEVdDALCf/U/r8cH3saXNXtTLVtWj3eIBp6zjxrbLRHZ?=
 =?us-ascii?Q?DnWHWw/fWyFlox4Xrrx46PqxDgQcFJM81f3KCsX0xASBMJdez7lD50MVSeFb?=
 =?us-ascii?Q?CKeTSAycTFmUf3e9whXSLMFvymPSGNu8KaB0fczp0xwNXy88LhauU529Mz/B?=
 =?us-ascii?Q?ucZDeTyvWMJISSt3iABPGCBjeH6sdeNfE+LJlIQ9eTmvE/G8+RlopZwaCEm9?=
 =?us-ascii?Q?Ojdh2yoKeUctwGmmDT7zfFQ+I9by7bC1DXlGORlHbqPxCbAXKMuiMwjE6erH?=
 =?us-ascii?Q?cLPRP3356uQ3XP2ESVX1+Clw4OqbJwLzuMSPCRcGvTf0uFJwP/EkVluTKmxp?=
 =?us-ascii?Q?OKx+zWbdPA4RKgRWt0hVPE8z4YS/U0C27ZkIZjLhtQnQAbxvYUZKj0QG+X7K?=
 =?us-ascii?Q?fRz3f0l0A8Z/rwic5ofCNFQxWsNIs447v880rhUtKuTOSeNSRvxeM2YfBAEA?=
 =?us-ascii?Q?Gqmt2AY1KD34jQwS+aebT+Q4yrdvunXDz8QDmzg2CdwLHw6H/Nt5pkmegL6Q?=
 =?us-ascii?Q?sGRp2jGrKMYwaYb8/1eTwRYepcFT3XNkvKgRvsisBCPSgQhBFnGKUWDWAZBY?=
 =?us-ascii?Q?gxNmMyy4hEPkUR04eQ77ML4GaLZdVZRTQOunIxgoYplh2qCbH07UPVDxV9dK?=
 =?us-ascii?Q?0inFnuljjp7rEzGJpYmzyoa5MyuBktCUC9ovjtvgHTHIR7lCuHrIrFDzm2XO?=
 =?us-ascii?Q?bxtR8onlJjgNL7WwsyuI1w1WX3JEdfSgx8ePtCp3C1q+6s0Ulo1mU2DKtQn6?=
 =?us-ascii?Q?yDRtMRScd63sGuZCZf9P7kNubQHXjEb6V3JU/V11z4F+ghmxwqgcfnZ904bh?=
 =?us-ascii?Q?/AGYKhKxUlFVTSodpNJrZrJNtS50YXjMAICDlpQdCh4pAOipjdxOFwZOtqx/?=
 =?us-ascii?Q?YzxW4gKvWdXFLwPCU/sl2zLCVEYTKwWHG6l339oadCViGA/P6Rt+Db1jqI/t?=
 =?us-ascii?Q?vGvVOoZW5XoqWL4yJwlCDR9YbwEIjmBbb2DJX/yx9em/ffJk0BpHEnX9o2L+?=
 =?us-ascii?Q?cHZLgNg5UL9jpNwtFITQD2rzegYKdGwFkbj0c0IQ3azUTv8Q237578r4w34P?=
 =?us-ascii?Q?F2Hw9xxz40qXMiF8+9nGcBwNT/mKEdxxliY2sb8lknDGCGG54hPiH9VTrwb1?=
 =?us-ascii?Q?7kNotq2OfrfLPG74Vrtm0bOeACmKmZr4FKcReX2ebj8ukU+H2wOgLK7l1DP6?=
 =?us-ascii?Q?c6caxpG6Qn44HSdRZIQwkRL+zCV06ExoFZF5hSfBmBFjbhIy7Xfec3MC3LUm?=
 =?us-ascii?Q?3af1qfME+Ko3Fcs8XjHxVPKFuKfehI3PUuGy7okeMx40hSdW7sr77E/OMUyJ?=
 =?us-ascii?Q?2odeO5KRvHqihmAtGJ9mBhOK4A1FifLjsNHEIzle7pYs2b1meSBNsGhZCuiZ?=
 =?us-ascii?Q?HM1QO5yH0sK788zapJGV1SaC6YJQzXIC3gL5jgG5qT8QjgdGQNjsjrFATsWK?=
 =?us-ascii?Q?njxgEG19WToqpIjeyrxFAszV8eN7QsetUz9yPmbnp8SFQWKj1mOR75KX09d8?=
 =?us-ascii?Q?Zi/yMpvhf1scv/pqBJpl53/18c0vOYUSAOZuHa+kd5IBTDwbtmkQkmLM1Sr4?=
 =?us-ascii?Q?5c1+PyqIpx5VWoDPNZiJTy+KNB35SGbQeewbhRh5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6044443-d50e-46b8-9f3f-08ddc4a7f426
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:32:59.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiwTtkF/IRq8kQfeH8nUS18vSs46T1VgByFPxi7VgvXki2HqN/OmJfpTWbcwWv6kJLmN5u2s3VxFepVysjwJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

On Wed, Jul 16, 2025 at 03:31:04PM +0800, Wei Fang wrote:
> The NETC Timer supports to loop back the output pulse signal of Fiper-n
> into Trigger-n input, so that we can leverage this feature to validate
> some other features without external hardware support. For example, we
> can use it to test external trigger stamp (EXTTS). And we can combine
> EXTTS with loopback mode to check whether the generation time of PPS is
> aligned with an integral second of PHC, or the periodic output signal
> (PTP_CLK_REQ_PEROUT) whether is generated at the specified time. So add
> the debugfs interfaces to enable the loopback mode of Fiper1 and Fiper2.
>
> An example to test the generation time of PPS event.
>
> $ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
> $ echo 1 > /sys/class/ptp/ptp0/pps_enable
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 108.000000018
> event index 0 at 109.000000018
> event index 0 at 110.000000018
>
> An example to test the generation time of the periodic output signal.
>
> $ echo 1 > /sys/kernel/debug/netc_timer0/fiper1-loopback
> $ echo 0 260 0 1 500000000 > /sys/class/ptp/ptp0/period
> $ testptp -d /dev/ptp0 -e 3
> external time stamp request okay
> event index 0 at 260.000000016
> event index 0 at 261.500000015
> event index 0 at 263.000000016
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v2 changes:
> 1. Remove the check of the return value of debugfs_create_dir()
> ---
>  drivers/ptp/ptp_netc.c | 114 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index c2fc6351db5b..2a077eb2f0eb 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -6,6 +6,7 @@
>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/fsl/netc_global.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -22,6 +23,8 @@
>  #define  TMR_ETEP2			BIT(9)
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_PP2L			BIT(26)
> +#define  TMR_CTRL_PP1L			BIT(27)
>  #define  TMR_CTRL_FS			BIT(28)
>  #define  TMR_ALARM1P			BIT(31)
>
> @@ -129,6 +132,7 @@ struct netc_timer {
>  	u8 fs_alarm_num;
>  	u8 fs_alarm_bitmap;
>  	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
> +	struct dentry *debugfs_root;
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -991,6 +995,114 @@ static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
>  	return val & IPBRR0_IP_REV;
>  }
>
> +static int netc_timer_get_fiper_loopback(struct netc_timer *priv,
> +					 int fiper, u64 *val)
> +{
> +	unsigned long flags;
> +	u32 tmr_ctrl;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	switch (fiper) {
> +	case 0:
> +		*val = tmr_ctrl & TMR_CTRL_PP1L ? 1 : 0;
> +		break;
> +	case 1:
> +		*val = tmr_ctrl & TMR_CTRL_PP2L ? 1 : 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int netc_timer_set_fiper_loopback(struct netc_timer *priv,
> +					 int fiper, u64 val)
> +{
> +	unsigned long flags;
> +	u32 tmr_ctrl;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	switch (fiper) {
> +	case 0:
> +		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
> +					    TMR_CTRL_PP1L);
> +		break;
> +	case 1:
> +		tmr_ctrl = u32_replace_bits(tmr_ctrl, val ? 1 : 0,
> +					    TMR_CTRL_PP2L);
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	if (!err)
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return err;
> +}
> +
> +static int netc_timer_get_fiper1_loopback(void *data, u64 *val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_get_fiper_loopback(priv, 0, val);
> +}
> +
> +static int netc_timer_set_fiper1_loopback(void *data, u64 val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_set_fiper_loopback(priv, 0, val);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper1_fops, netc_timer_get_fiper1_loopback,
> +			 netc_timer_set_fiper1_loopback, "%llu\n");
> +
> +static int netc_timer_get_fiper2_loopback(void *data, u64 *val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_get_fiper_loopback(priv, 1, val);
> +}
> +
> +static int netc_timer_set_fiper2_loopback(void *data, u64 val)
> +{
> +	struct netc_timer *priv = data;
> +
> +	return netc_timer_set_fiper_loopback(priv, 1, val);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(netc_timer_fiper2_fops, netc_timer_get_fiper2_loopback,
> +			 netc_timer_set_fiper2_loopback, "%llu\n");
> +
> +static void netc_timer_create_debugfs(struct netc_timer *priv)
> +{
> +	char debugfs_name[24];
> +
> +	snprintf(debugfs_name, sizeof(debugfs_name), "netc_timer%d",
> +		 priv->phc_index);
> +	priv->debugfs_root = debugfs_create_dir(debugfs_name, NULL);
> +	debugfs_create_file("fiper1-loopback", 0600, priv->debugfs_root,
> +			    priv, &netc_timer_fiper1_fops);
> +	debugfs_create_file("fiper2-loopback", 0600, priv->debugfs_root,
> +			    priv, &netc_timer_fiper2_fops);
> +}
> +
> +static void netc_timer_remove_debugfs(struct netc_timer *priv)
> +{
> +	debugfs_remove(priv->debugfs_root);
> +	priv->debugfs_root = NULL;
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -1038,6 +1150,7 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  	}
>
>  	priv->phc_index = ptp_clock_index(priv->clock);
> +	netc_timer_create_debugfs(priv);
>
>  	return 0;
>
> @@ -1055,6 +1168,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
>  {
>  	struct netc_timer *priv = pci_get_drvdata(pdev);
>
> +	netc_timer_remove_debugfs(priv);
>  	ptp_clock_unregister(priv->clock);
>  	netc_timer_free_msix_irq(priv);
>  	clk_disable_unprepare(priv->src_clk);
> --
> 2.34.1
>

