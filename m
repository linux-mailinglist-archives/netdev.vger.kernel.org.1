Return-Path: <netdev+bounces-111472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E904C931386
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453AAB218B3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEA189F5C;
	Mon, 15 Jul 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S7d+5nz9"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF864446DB
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044695; cv=fail; b=rMKOOiZjpNIqqJY2Nv79BVIdOtECWNDCBq5uPCTfkTyr0AakMgJZ1zYA1HjlPNzA9RLofBLWDBFuF7L9OP9vaeZGqoVy7iGtboMZE1uG9ufxag3aXyW1czPs0e558T2AEnVf21Qf3hULEO3Qb20uPKCuX4OUyveC699TinPD+Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044695; c=relaxed/simple;
	bh=61zWDj00xvxQoZgvosWnJ4DO3+9nKzHwvfiNBUFEkqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVtIffr4DNzeMh06jGm66InVfGNDnCY7MW1A7FGOZzpIcMTcQ30ZhlYFfRC0210PHJLsfQvWWCaa3TvBtjzsd5tMGnKN0Sbtmg1XOb3MgQILg1Jlq7yDhpvWkZhk5YOAH+ZvsgMoiW20Mqqe+/z2S79n4UlRySjvm41C3fB49fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S7d+5nz9; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUSVvjqCdtsh+SVcEd1tn7WB6TPrC++c8zv3em+82GSVIyZ77ZatjrbFMrM9Z3FephuATV+5JmsKKpFQWYF+/VoBFYGGP3+8h7K1sL+wCiYWzppcRVt+RGDRXaaP0RtdBp+ZcJP3aj4xf/wm//qQRcBBRcspHD6W5TL9qXiigCwtdJGVVb2tL+k/WnrbAA79Mp1eU1Km6W1BW9LAVxOiDxm7F0BBWJN3X4rCuM7HnokK+syxh/OKThSoB8kIUbShi6O5kBjtBZlBtqB7350doOnANQeizCPdfjYtmaDpR66fvLWelDuJ+UNbRInDcLp5Yook7PMPHEI5xjMGN20IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmOUfZQsA9jJkFUfBL1pHuks89e3NCgAQEOhMPjmG4Q=;
 b=LERw1i4CNxhkR1zmQNhcWIrhrleRLYudwLZJsMnQIERnijcNdX7O+ConPwA6m0hnsym48wADkZ4zthjmP4OHO+PGGPohKCDWYrZtatrVZR8HqWj+jCQ3CD4Z9a/fC8PO+Qzc1NJkX9wh9VWOWr7TljpKwV/z8lt8NUBLC6GfHqiQ1vvEtRml/Jp+m89RLGdsx8Gxv84+dxzK5D+yTqpNaY4qjha+XVbKjD+3qe+3vil/EXQGikWZzgXqYJTNvZ0kW1VBRYUwH3ymxNfLw7wlNIs4znDz0BQ9eR6bk9ie8e5BFe9cHNcF/UYOOB1QAm8WLhbyLAA4QCZ0oSO8+3s3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmOUfZQsA9jJkFUfBL1pHuks89e3NCgAQEOhMPjmG4Q=;
 b=S7d+5nz9cEpMxuiKblsODK+KRmKpzc8wW4ODxz9kcNW3vG1fbQ+XqlnRRw4r8Z5fBmfg93Si9ssKjdwN0msfvMBvzgpwzXuOrhWuyKyvhIoquD94ZHKm07HbLbB4gKY4FlS4mzb3BxJwvll9E0WiA0bf7zd/kHGZcaNqdYy4Cag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DB9PR04MB8297.eurprd04.prod.outlook.com (2603:10a6:10:245::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Mon, 15 Jul 2024 11:58:11 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Mon, 15 Jul 2024
 11:58:10 +0000
Date: Mon, 15 Jul 2024 14:58:07 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715115807.uc5nbc53rmthdbpu@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
 <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI1PR06CA0145.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::38) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DB9PR04MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa8fe9a-cfe5-4089-c327-08dca4c5660b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YS368GHy/OdF+TIi947lAWyiTYqqsGQG0erdguLDhk+N+hiXCNWjpxLZfsuM?=
 =?us-ascii?Q?M5OHTgoIluOCz8aA4gG+CoFAOkJ/SSeZY+BS7jPcFpgxPBRKD6wtsZiEfAmR?=
 =?us-ascii?Q?rbCwKnj4d4amX/Y+NrtsfiSKI4Es2mtm9xB89I6NgfUTAGkdP1IMfHQKD+MP?=
 =?us-ascii?Q?zjDqmK+87oyoL99FWsmKaoxukGFK65IwleIFWMHEsvJhZv/5PnOSb4uYx5OR?=
 =?us-ascii?Q?6blskV/1V6hRPIanmCGc9uSWGen1Xhx6KCj2zbfO2IWtruqkf/Vonlf6jbAh?=
 =?us-ascii?Q?GJI/rPIVNfepwbDBy6RMHCZLP7qvqAFglk7w5uHSpA/83bysjXqj+6VGPxa/?=
 =?us-ascii?Q?eVjkPQ3BPtjw33PcygzTQja7JBg/IWl2gSGZYKCvIpco4DUBk/ATFyxzTJlI?=
 =?us-ascii?Q?bKKxjtw/uWBYizZzUi0dzCP7480/uQK8O8bSz1P5yWpW1fLaBs92y31sQwTl?=
 =?us-ascii?Q?67w1FcH9WwvnCDLDZAUvlWU2GOCcmMADaobwDhwF3ERNeqMu10jwqToeElWe?=
 =?us-ascii?Q?4nB8MXvh9+oasGn2WbUXo4Z/qRv2vDJkxljUx1g/tUVxVb3QVKBVF8z/+rie?=
 =?us-ascii?Q?R5FhVvcssst1qGHh5/QO9L8fyRIYJYxjQLlSVx/ey19CXUUBfYuTttI5dMLo?=
 =?us-ascii?Q?cPuMY3iU0WNL03UFmx4YmVu6zoFEJbhp1Ehg99cXk9Gil9YW2CwkBYAl34P+?=
 =?us-ascii?Q?2m67Sfx6zjna6iKMPKqZhWwhSzSJOZ4eVqmec7M5gmWDIBzTl333vZ5lieHK?=
 =?us-ascii?Q?BHGO3TlUDMwMTgrsuWSdPBfC7Qm8Dy2mQUmnx5zsJ+5mywYfw9CTRi1GV1S5?=
 =?us-ascii?Q?SkZXSCDQvf/68d4JoX4sxXVgZF9Hlr9Awf6ALksRWRYwEVjjSDLAcqg+5ZcV?=
 =?us-ascii?Q?zIjSjE7L+S/9uthbAVIe/CNDuvHerEbHgtiYXNwE32DMg55Ws8dNKgR+pojk?=
 =?us-ascii?Q?I/VyvKf3zbALmNHANdjstgDE40ovjdrv/DgW0ISS+kOeyIJguJJm9Q4LYT7Q?=
 =?us-ascii?Q?L2PD0MALteWnZTzDVSbEFPeoM5loLCgBmRFnEFmlq7IwfuCpvfCHSNe6EP8r?=
 =?us-ascii?Q?5BEND2E7cMGOlQHYPCq6Ct7RL5smLpUEWBlW2RGOas8J5WZFRWKMyygwfsCj?=
 =?us-ascii?Q?Fsdqu8KpxDc3KlSdqnzyD4YFcieZsvi8vYCFFCARNYUhKEWgwcJQgvxfu2jE?=
 =?us-ascii?Q?ahtbkKj20ptEnpcMuDKwdYFJs6xfPh+IyolPnHXKS9oz3DReHvfdh/LX9uZM?=
 =?us-ascii?Q?PfuUD4Ht7DJ7uR66Osxb5cNZe33gml4xUayr6MjxK6Yh3URxw7iwV+KHNmay?=
 =?us-ascii?Q?pgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jwfwc67zgEEZj/s/WZpK2b5rKM1EGqVgdUvOG/HR7GX9Emw33Ey83yBNAwpA?=
 =?us-ascii?Q?VcDhZs/cwFxdIOPltXSazX8hanmO2UmLUuyNhuCV+v455r7AEN9T1VGROR9u?=
 =?us-ascii?Q?B9S5E9HdOzuagBU1R00oPERtjqwkGG1fyRr0Z/Ig7mAuCfl5Qewk4mfzKgEP?=
 =?us-ascii?Q?tPOXPp18zRSbizCkRVsMrKkztwx4v7IzR4/w/axTpoZVkHlvEBKV+bhRUHWj?=
 =?us-ascii?Q?JcAuFsxmD7XUV9cgG6WEksEObP50OhALDZly03Mr9XvSPTgMisljMb02KY/t?=
 =?us-ascii?Q?0lOzdHdo0I1oxZ3jeQWlmcYA3aRj93oaf7474r87c5f7dhF9DZE5nnV5BUUw?=
 =?us-ascii?Q?+ZZJmXqzDbjH5GyLB8bNScWkA79hoC2VFfuWeIJ2cOq/oRTn8wWIuxJZN5XO?=
 =?us-ascii?Q?pxX+nifZCEKAmwuxbYJ07ggYhXogTmkC3mgfrMBnhnBsrbdG/F7COUnlgeDU?=
 =?us-ascii?Q?2ZnKyCprA3q1naKQuW6TpLovbI16PqGeCWKMCn7QSZoWm+VgMSESnCmPr8g4?=
 =?us-ascii?Q?GPpIlGcRsCAAU9g/GUiZ8uREbU5s9hWhWbeHK5vRELX80FkdeGPnXLbGzk9O?=
 =?us-ascii?Q?ERJ3Qa1N/WTEH2fboZPwtF5d/WJPjFR7BBajcipXY7UssozEbGchUeyKkojf?=
 =?us-ascii?Q?bzRpZl3JROjDfTdEI+WuUNthqbtmVUCUZy+waJVaOMkn2wt0+unuPjMQ0gwq?=
 =?us-ascii?Q?QyK/qCM61Rti63RDKaXU0PJY3aJ/7lMW28F7IllufCumfnQ5iRh7VQRIdOkR?=
 =?us-ascii?Q?4Yr1U2nYWY/2j5+ROgR3JIZiIOi815arxUu/Va+is5BuPbNt4i0brvFCubOs?=
 =?us-ascii?Q?AfTrOk8x7NCZV9qnQ5piff+nqTt3JyA6PK0dse8KdbmaqH8Bxut3FUY2lrTD?=
 =?us-ascii?Q?XT7pJNGHz4fl8e6tY/Mkj/zgDu5czpj7r1q3I/8BMz/lQ6rg3H4qgNsBvos8?=
 =?us-ascii?Q?hU2yxBSmX/PQRgrb34ye5xvNXaT6fMmnOr+dC+SQnvcHSfh44mVWjf5SJPpS?=
 =?us-ascii?Q?TN1AmTY3GuugFZg2o4CcWvF+3ViP9U96rl0/tSVMrtbG7uZ4A+xddvSoC4Og?=
 =?us-ascii?Q?gbxArZs87gYlSZMYEG7zKzkJkUn5H6LLGuEq0/fK9HWQWSScNXOhoLi74e03?=
 =?us-ascii?Q?WYgWNa1OS1gwkasY8yxJFHyTLh23LdVVQu+8+rHQrRUgjlyztkVOyKQWjcXb?=
 =?us-ascii?Q?SesFEArAowGtGTOrWFoxv420S8nd01u46QXfwlmIwx4aP5ycpVCFOdCstuMk?=
 =?us-ascii?Q?jgjmP1lRCEuQ0XqoKTlrTCMqdDa1DoRZ4G1dR237LJsvkBWv0A6hs9sVhzpJ?=
 =?us-ascii?Q?iOprx9qbS1hvcmcELe+bo+OqVfKZIsHl0MgS+QsAfiu0wBNDexOlV4dAhR7d?=
 =?us-ascii?Q?WsWEqgctmtCn1I1xSxtQ/JiLx8gElYf/8kKEPq9uv1O5DNsQF/l/nx07elat?=
 =?us-ascii?Q?ObF3muAwyOfTsimsceZYfclSYFlXRQm7/DZAGJtdAAgKfnDUgb4kmja/r4qz?=
 =?us-ascii?Q?R5qavQ12+2WaZLiBQOa1Mjeyb7LO55X44BtCY0H6Er3+pcYLid2dkvC7xNko?=
 =?us-ascii?Q?JUQGSGiwQI8KN/et5jYcLFhBpeLcVihy3JcfAAlhuUykd6H82cfnIS9hEDfL?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa8fe9a-cfe5-4089-c327-08dca4c5660b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:58:10.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3qsKKowDBS0D9DG7E2qzSLYKq3HeRUaHq7tPJbnKjGms4BOOuE1XctHIjPehEWZQvQNaFZuhOcGromWZao2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8297

Hi Sudheer,

On Mon, Jul 15, 2024 at 07:37:45AM +0000, Mogilappagari, Sudheer wrote:
> Hi Vladimir, 
> 
> Here is related discussion wrt this topic https://lore.kernel.org/netdev/IA1PR11MB626656578C50634B3C90E0C4E40E9@IA1PR11MB6266.namprd11.prod.outlook.com/T/#mdfcc6e25edb5b7719356db4759dc13e2a9020487
> 
> While introducing netlink support for ethtool --show-rxfh
> the tradeoff was whether to modify the command output or to
> use ETHTOOL_GCHANNELS to get the queue count. We went with
> not modifying command output. Didn't realize about drivers
> with no get_channels() support. Currently I have no ideas
> on how to resolve this other than drivers implementing
> get_channels() support. Any other ideas are welcome.
> 
> Though not a solution, one workaround is to compile ethtool
> with no netlink support. 
> 
> Thanks
> Sudheer

I guess the bottom line is that ETHTOOL_GRXRINGS != ETHTOOL_GCHANNELS.
There is a fair amount of drivers which implements ethtool_ops ::
get_rxnfc() :: struct ethtool_rxnfc->cmd == ETHTOOL_GRXRINGS differently
than ethtool_ops :: get_channels().

Looking at Documentation/networking/ethtool-netlink.rst, I see
ETHTOOL_GRXRINGS has no netlink equivalent. So print_indir_table()
should still be called with the result of the ETHTOOL_GRXRINGS ioctl
even in the netlink case?

