Return-Path: <netdev+bounces-196173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD54AD3C3E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06A53AD771
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0084235060;
	Tue, 10 Jun 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TseKwsoE"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63E221F0E;
	Tue, 10 Jun 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567782; cv=fail; b=mFVudsItcQ9FUtkW1scHyN0ITDuL7gDgb268U59M9YsmC6UuFGM+v3eQ2Q4hs3+dn0ui7sjXhpH43/GbK0G/Q05C0OGzi6tmUoqPExIJk01pPTBgmQkcgUI5HuJS0LGSTdV2II4e2DsTwvjV7xINg1nw815RVqPq/crv2WJt4fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567782; c=relaxed/simple;
	bh=YFZU7ClABZTc6KLzYWAuHzNZymriOgak7k8RWJsjC24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IBoEa1X/YgONV7ycxWnSFJu32vlC7wF4jrbGImhQBsX51UyoLQ3jp/p9JvtXdSPIR9bRvKibuQMkmsr9NSnfM0zMnrk7wZBq+qgcq7iN6+FTcVS7uTiL0/TPSKEPLtUGRddH8Fb2f4ZrsSE1dxF/yt1ENvFSNW7pRm0yz7gh92A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TseKwsoE; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A42V5L82LMRef34PnSj9axreM5vg37q0LKGw8gJvVrycmK+MbbkaFsDMZvsPTFCeJ5YvuO+fakPjIfkDkroItu5FkkqY5JQPysfzU6wMBlj7gB0CKmLcLJwqjIbDTjy4mLtzS0XZe7+0hJ6htgsnP/NFgwwpnNr25YtWd3xkadD+M/Na/etKAF65NAqq7j6l4OxV3d5qNjbGaG0SjxYWPy0H/IYp/WafFCxiD+lcG2hxXDoTeJ0x0CbYw057eFV3LD83iUGKxOpc/V8RXXy8BPm220TFaRpwE4+nbB8sEvplBekMccoysAuy510uXwmDCnSWEIZqNtckFkypSMQOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz998GHR0tccku5jKmLrNJMRAs8svI7cC4TCDtjLEKo=;
 b=YjZSg7uuQM+jOLdJLG/iC/sr3NW+b4Rhk+Sx5f3+VTJRC94NPmzTO1/mXZb2sZO8G28pmOZLTghrzkkPsoyU9lY1CTsxzesJe1ywvlNymoEBLcezcnIYZ1gmBASbmyYkEF0ZMFi6CJMKyiXP7jl7TYUN3MvoUAPq8GpZr18Ktpvus57mkL/w6rawG6Xj5sxgBfzqEoztpNOATnT0kxf3QYyiVoJQdjyabqX165/uCxcgaWck/yZR+B7legL0UuGDumOoEMwt1gJP5YqJhYABgt+v+xtuhWhvCg//JGPRfWG1UVEaHs/8hfDMbHvhO3AcYC9BtuCnAF4cJP3N5uLVbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz998GHR0tccku5jKmLrNJMRAs8svI7cC4TCDtjLEKo=;
 b=TseKwsoEEfyBgayvNl4jDaqp4gB71s2qcXVTRPqCkW3Z4pZz3JqpnaSFrbr+KUJbhn91jmWNqgcK02Y6WRSQ9NjK6vgIth5j3bFeFTB8EDhL3ZsDTCl34xVOLgtXXa7mtqto5m1wT4kdT8ggResn9hGpKpSDY4vuVXzac1n1RFWEzD5nRLKCiLnOoVWQmTO+6u3JfuarLPoTJsnXlGLQo65lD7Hhf7ZpAju7C+adZrW79Kg2fgz6PiS6NUZeqhMN4qTQPirAhRab45eRVHD0dMvZMxqUc0T0Gicygutx6q0Zy33wXIu5mErYWGA1UuwALSedLI0tVNYYUSXQbphvng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 15:02:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:02:57 +0000
Date: Tue, 10 Jun 2025 18:02:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250610150254.w4gvmbsw6nrhb6k4@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
 <20250610085001.3upkj2wbmoasdcel@skbuf>
 <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
X-ClientProxiedBy: VI1P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3301945a-5d2f-468d-eecf-08dda82fe274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQMS4ZGgmZ6ZqYo3piK85BjIxwDpUKS7SDwreqE5Zx8X+5cpBtk5WVzNXVvX?=
 =?us-ascii?Q?UOdjhyet1JOwnNYchQUXSPX11ZC2kqycqrZocZt4zHfS5pB9ev+ECn6Om9l+?=
 =?us-ascii?Q?iFnDm9cN1fybBYVKrq/WRWW22508M+Pi2kZh5X8Wf+onRyD4G7SSVFRW8FnI?=
 =?us-ascii?Q?hqX+1SIywmxd6lFNK4/F0eoRaWPWF0/cJRgJ6Y3Y1JKElFdTY4GD1XyiJtNt?=
 =?us-ascii?Q?xHyHwTV3rOCSL0Zc6MEB9JOQQ9YKR7rSh11i1nfB2qewHC7CHKrTS6ruhrrF?=
 =?us-ascii?Q?1s8Sar8V0yPeuoim7ylcLJnN2AiF5NVD3etOOSaBAsfWIJLgxwEu3dLdG6xG?=
 =?us-ascii?Q?kFn6/vqe3kycbd6nDUzhhj/370nK2IB3yjPb23ZW0MkY2gC1PM92WfNwMV6U?=
 =?us-ascii?Q?PyafUyd0aFN5afFIYLHqorS75GU34FtUCPj+sk44Sr3dQGIbYaLrcjkUkP5T?=
 =?us-ascii?Q?gm0e4tU3ouJUlpSKqQhVCQDW1G5IqKZ4hzwW/p/YAlG57D9llE7z0H4dPWmM?=
 =?us-ascii?Q?M6GB0F14QVTYXy2xq33eIvKuflNXpbuR1PKG9aPnesmzgOefLUiwqgnw15So?=
 =?us-ascii?Q?QwPSWeaZioFgMZLFE9GUI+56/tvydXg/GhzVJXNA0riHkvROcBQaobLJeSbw?=
 =?us-ascii?Q?TwfhTHkyyejBri5B0tlV7Sau1pF3GzvYe3mN4AF6ucpWXavZPRs5C7LoACUZ?=
 =?us-ascii?Q?fEznBifWBmj/ms43BuyKi0lx3gQAnH+Vt9W3FDorm4be/6vkQI9OEXBJIe63?=
 =?us-ascii?Q?WED6ZsZcStZ1CdQmNpbRxQQP3RE92o1noUNrgkHTSSBqCn1u94XhUCZ1OVak?=
 =?us-ascii?Q?jemaIesIaucx/5YpPfLadH87qDf9iMxBToxogqzM1e/ApyVJ9roCZx9fV+FA?=
 =?us-ascii?Q?I+bb8CAOybq/VaX/MfQxoK6BZ6JcvbDgICelXTd2q9iGs/55/bFvADECPtGW?=
 =?us-ascii?Q?UGT7s6wo2CrXmjO2aXoY587dxxs6RIN8Oy7eBAFsX6Lyb5QWGVaWRyD+YpG+?=
 =?us-ascii?Q?US2JUyRRZgnFhUqmOqWnFWGsBGQg2RUbPPypU2ERxpwVAhFKWeNYnknPgipS?=
 =?us-ascii?Q?tgB7/T2Oo5vYmLnGiIOWc+/HrISNiQNqs4K6Bwf5G6sQp0teN29ZCtSFYfYH?=
 =?us-ascii?Q?4KrjYx4iDJiiX390WbvrdFizhDveYO/OqyRyeaL9YIjBfnrZ5fuXptfKgRoS?=
 =?us-ascii?Q?SJkpFlPXqd1GlBZkdTPAzaS+Dtur5jlOR1FLnWLr1FyLty2eEyLMTsiB95vo?=
 =?us-ascii?Q?v9C/g1O5orsfNWdove+7DMCDdbiU+CdY266kuljDk8aQFULJjZmUPAKxvtmK?=
 =?us-ascii?Q?c0Rz2Gq4grNTV9tXHHl19j1TmGRl/dXsiy6lL42bWTcz4o8ruYLRKjDRT72c?=
 =?us-ascii?Q?kS01KHsQhf2RFHPrRzviBB2dw4Soqtjo/KRHSthfXXexVj+ILX3X5C7muMPf?=
 =?us-ascii?Q?ikwLN42xAyU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cBnh9oaobMkOJ61wtlmJTvEUb4qrQSJWdUqoLTZ48E0JD6HA/dBv5u5tQPXg?=
 =?us-ascii?Q?7BqiNWK57/RO+KL5zClz3AYNKeDNVV7/KstX7VQux9y/qJOQkP9VGxhKG5qu?=
 =?us-ascii?Q?Thu8nBJt8KW1XLN51k4uFkRjC2Mlr+E6jUNPGEA91SQuvpIeaueGGICe/nON?=
 =?us-ascii?Q?ac7aoGbPO8ABQ5yWl2C6cwb1qhiNHDTU6VJzFStwafyu3koqLl6apk7FsXdJ?=
 =?us-ascii?Q?oHyRDKgR25Chb9GfxKgKZfKMgmr+RZPh+V2lT4PqZWVZWDTYtZEs0hV9ikzK?=
 =?us-ascii?Q?++hDjf7zY1jp2HQoV5bdsHT45A9h+lUEZnGpkdjBtWIBZ/v+2la86DcU0FRz?=
 =?us-ascii?Q?NplJsh3ZoKkzRjs02+UIPH1XVOG091oBzn4nEVB3kZsDucmH34TBH2EY7MOC?=
 =?us-ascii?Q?U0s95ehXs3d3qaRiWhiOWl7mJ54jEEWCPmOLWMzn029LlnvAS9ftXXt9In9M?=
 =?us-ascii?Q?jZ0dYxpST0IKIepvfr1KeAj31HrBpdPt0FX9QVlAe2EVaXtuSy5dX6gag9Ye?=
 =?us-ascii?Q?ZRNq9w4G6hIytQodbcbHBH6esyiO+ZD7vnxs1Tdzp8TX5tvD5/tUzm86bh34?=
 =?us-ascii?Q?O9hBjenAlonOOWs/WXxKjda869G+lWp1GPtR56QO8i36t9UI5OzqmmwYJiFZ?=
 =?us-ascii?Q?IeLesyRxmHjLUpB2HjcA42PBnr41L+eDD6PLAYeWCfHDAEFjAffAhptlbjSH?=
 =?us-ascii?Q?tDHPGg9LsX2V3k9X2RUT+1cRC97oqNx+9fEGwSvLxUv2ioWC6P0vhnz1AsgH?=
 =?us-ascii?Q?ScR46/MSAklCTzsAqkVFeMRhmMdcHrvjOVMtrOnDYtY2BHF48HJy9fgDnn//?=
 =?us-ascii?Q?QTbodv26F4lcQFIzEpfvtaOQJTvr6+5lPF8irdNjRRIu5pZumDKmAN1bEQTI?=
 =?us-ascii?Q?PTIzMv16PrEMfdgffGaRxO/h7vMxyc2mT2Ntj6nLeyAA5zPU+vXNMwoBpq5A?=
 =?us-ascii?Q?qgZqhtF1LKEJzakwbAyTOSd/cDyxk+NyA69wy5xaG5JeE7jGMIwaJhUf6MmH?=
 =?us-ascii?Q?JY+hmaQeBMHvPnyne667idPcIv9XVvrlcThbzCrZGPh6dNjxJ0j4+hm+fi+j?=
 =?us-ascii?Q?Kzpk/RkmMFaBsqMV3L6/YcpLJfg5uE3BlCB2yKvlzNY2xVk4OEYveJlCqtzv?=
 =?us-ascii?Q?62JVMQ9KSlBz1QrkyrLsf4GtOvRUCcPaHJjuZfaEeW6OBbtSN5nxTs6cDX1b?=
 =?us-ascii?Q?NGtcBPBjSYvJgZNvc2xtPKRK2X+SdAQogZDr/G6cbueWvC2RwFjLQjcXCOPC?=
 =?us-ascii?Q?21c2drq1OG9qLkDRlo5wQ+Cv7dYGNBoGyc+U8sPmPa7zLNgc2k/SvBj8ypRT?=
 =?us-ascii?Q?MEgEh1Xjgmq8efheyJRItwbdyTPJ/udjbPLp97NCsAdWllpE2d+3QqMpV9m5?=
 =?us-ascii?Q?FEzYNZtd6bailpoq2Owg/pKLVzwyfZU7tshMCu1UgkvrK7izfVSNV+AT/0UR?=
 =?us-ascii?Q?rNNv1TckmqY/0+S90+DoxTPfmQcJ1UpQrE4dDfg2eSeuR/g5oRNxc6u0SY4f?=
 =?us-ascii?Q?awjbyPWKYrHDESX13BUbDGsTFW+CMrEU83wOIO6KZfHyXUhu22Y8BzzXtGKd?=
 =?us-ascii?Q?g0LeewWhbJeiwm8kAVerR4BpCvZgsQJ7gXSY7YvoKpQKd2fnF84kyxaouSOj?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3301945a-5d2f-468d-eecf-08dda82fe274
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:02:57.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQpLtwN6Q8mdDoSnHxOMgWrFhGVBdQgcW0zNIkc2RBFN4PcG8XGvlg4y9aCt631cK7K0ABIomygoAlLONm+oDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7554

On Tue, Jun 10, 2025 at 04:14:29PM +0530, MD Danish Anwar wrote:
> > 1. If there is no "existing" schedule, what does the "extend" variable
> >    extend? The custom base-time mechanism has to work even for the first
> >    taprio schedule. (this is an unanswered pre-existing question)
> 
> The firmware has a cycle-time of 1ms even if there is no schedule. Every
> 1ms, firmware updates a counter. The curr_time is calculated as
> CounterValue * 1ms.
> 
> Even if there are no schedule, the default cycle-time will remain 1ms.
> Let's say the first schedule has a base-time of 20.5ms then the default
> cycle will be extended by 0.5 ms and then the schedule will apply. This
> is the reason, the extend feature is also impacting get/set_time
> calculations.

So what is an ICSSG IEP cycle, then? I think this is another case where
the firmware calls something X, taprio (and 802.1Q) also calls something
X, and yet, they are talking about different things.

A schedule (in taprio terms) is an array of gate states and the
respective time intervals for which those states apply. The schedule is
periodic, and a cycle is the period of time after which the schedule
repeats itself. By default, the cycle time (the duration of the cycle)
is equal to the sum of the gate intervals, but it can also be longer or
shorter (extended or truncated schedule).

Whereas in the case of ICSSG, based on a code search for
IEP_DEFAULT_CYCLE_TIME_NS, a cycle seems to be some elementary unit of
timekeeping, used by the firmware API to express other information in
terms of it, like packet timestamps and periodic output. Would that be a
correct description?

When you say that "even if there is no schedule, the default cycle time
will remain 1ms", you are talking about the cycle time in the ICSSG
sense, because in the taprio/802.1Q sense, it is absurd to talk about a
cycle time in absense of a schedule. And implicitly, you are saying that
when the firmware extends the next-to-last cycle in order for unaligned
base times to work, this alters that timekeeping unit. Like stretching
the ruler in order for a mouse and an elephant to measure the same.

I think it needs to be explicitly pointed out that the taprio schedule
is only supposed to affect packet scheduling at the egress of the port,
but taprio is only a reader of the timekeeping process (and PTP time)
and should not alter it. The timekeeping process should be independent
and the taprio portion of the firmware should keep track of its own
"cycles" which may not begin at the beginning of a timekeeping "cycle",
may not end at the end of one, and may span multiple timekeeping
"cycles", respectively.

What if you also have a Qci (tc-gate) schedule on the ingress of the
same port, and that is configured for a different cycle-time or a
different base-time (requiring a different "extend" value)? It will be
too inflexible to apply the restriction that the parameters have to be
the same.

> >>> That's what our first approach was. If it's okay with you I can drop all
> >>> these changes and add below check in driver
> >>>
> >>> if (taprio->base_time % taprio->cycle_time) {
> >>> 	NL_SET_ERR_MSG_MOD(taprio->extack, "Base-time should be multiple of cycle-time");
> >>> 	return -EOPNOTSUPP;
> >>> }
> > 
> > I don't want to make a definitive statement on this just yet, I don't
> > fully understand what was implemented in the firmware and what was the
> > thinking.
> > 
> 
> The firmware always expects cycle-time of 1ms and base-time to multiple
> of cycle-time i.e. base-time to be multiple of 1ms.
> 
> This way all the schedules will be aligned and that's what current
> implementation is.
> 
> To add support for base-time that are not multiple of cycle-time we
> added "extend". However that will also only work as long as cycle-time
> is 1ms. cycle-time other than 1ms is not supported by firmware as of
> now. This is something we discovered recently.
> 
> We have a check for TAS_MIN_CYCLE_TIME and TAS_MAX_CYCLE_TIME and they
> are defined as,
> 
> /* Minimum cycle time supported by implementation (in ns) */
> #define TAS_MIN_CYCLE_TIME  (1000000)
> 
> /* Minimum cycle time supported by implementation (in ns) */
> #define TAS_MAX_CYCLE_TIME  (4000000000)
> 
> But it is wrong. As per current firmware implementation,
> 	TAS_MIN_CYCLE_TIME = TAS_MAX_CYCLE_TIME = 1ms
> 
> 
> The ideal use case will be to support,
> 1. Different cycle times
> 2. Different base times which may or may not be multiple of cycle-times.
> 
> With the current implementation, we are able to support #2 however #1 is
> still a limitation. Once support for #1 is added, the implementation
> will need to be changed.

(...)

> > As you can see, I still have trouble understanding the concepts proposed
> > by the firmware.
> 
> I understand that. I hope this makes it a bit more clear. Let me know
> what needs to be done now.

Was the "extend" feature added to the ICSSG firmware as a result of the
previous taprio review feedback? Because if it was, it's unfortunate
that because of the lack of clarity of the firmware concepts, the way
this feature was implemented is essentially DOA and cannot be used.

I am not very positive that even if adding the extra restrictions
discovered here (cycle-time cannot be != IEP_DEFAULT_CYCLE_TIME_NS),
the implementation will work as expected. I am not sure that our image
of "as expected" is the same.

Given that these don't seem to be hardware limitations, but constraints
imposed by the ICSSG firmware, I guess my suggestion would be to start
with the selftest I mentioned earlier (which may need to be adapted),
and use it to get a better picture of the gaps. Then make a plan to fix
them in the firmware, and see what it takes. If it isn't going to be
sufficient to fix the bugs unless major API changes are introduced, then
maybe it doesn't make sense for Linux to support taprio offload on the
buggy firmware versions.

Or maybe it does (with the appropriate restrictions), but it would still
inspire more trust to see that the developer at least got some version
of the firmware to pass a selftest, and has a valid reference to follow.
Not going to lie, it doesn't look great that we discover during v10 that
taprio offload only works with a cycle time of 1 ms. The schedule is
network-dependent and user-customizable, and maybe the users didn't get
the memo that only 1 ms was tested :-/

