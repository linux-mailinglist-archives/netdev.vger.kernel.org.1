Return-Path: <netdev+bounces-111528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D052931756
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3641C20E23
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C718EA6B;
	Mon, 15 Jul 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s/4vVTvB"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013053.outbound.protection.outlook.com [52.101.67.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5D3A1A0
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055952; cv=fail; b=C4hMV2egNGnhdZvHpsH6Czpu+KQtPZDC6QPpZ3Pc4QDsM9O5jjVVb5FwldHHaLgABfQyOPhTAPk3TYG/jhLYGNzxOkTLsUdI70EdnRvsd/jnRaF/cE3FBbypVmaJmZgro3ohOI0/GHNXhDzXh8q0Q8eBFxmEoduKyZi4FKbX9Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055952; c=relaxed/simple;
	bh=BKqxI9rFeoWPL1qeTt+daXVElKnaY73wwXCjPcqCw4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZQbG41oLp9DuZHKVSaSNg53upylcN/trLDb5JwwHY95629/e5GUrJUzrcQmDE8sZV7ix1mgz2rGVZezUDWAqMU8kUGZ4xgNyOHyjxp4/XuGpSCXNM+uawvkJbqIvdgJJZ+ENmANLO8E07ja0c1GjgF/eYJ5ZLFyKc3ANgnW8lbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s/4vVTvB; arc=fail smtp.client-ip=52.101.67.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWEfLPp610xXDhVAF7i6DTt83Pqlnk+UcZqLZs37Ofbromt3fRnvouIvmSE7AKWJqtMLUwsNC3w3V2qxW4miOb601IV3BPXwnCf/wxNYV9RGE6wEWTIygQffY/lAV/Gz5yB97MZ4BFlRhRLB3jYH2ZEE9rPY3Gvj4szJP+Nx96Hr8K0B6k46GDkx2JwExnRneGYkO3Cq0GThpJGB9n18Z6t/YG4Ry415PgIJxqg7TCzdU/8SbLpl9YwNAlyjX7NQ+KbzBabVE1pLU/bbEICmvgjGGsh4zzvTCoOMkvE85vn+uaBzxGsGbqWj0GCCOqxEVACeIfLHqO52cj+SoDvz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkQ0bvbLL4MDbG9MZVvyi+3r87Thw3+XdkjQJmBTtzw=;
 b=XitpCjNG03rH3o0ZLAOlYf/sJ6cptlqX51Plhh4kC3yDAQOruPWIUZetWrSoNYb3obfuEH2Hh7Nt3GveZLKcHop8LXCa8pBQIJhr+QHCTAfk/pVxqp4ID+/yVQUOTS/D5n/wVfwXm/joX/1IH2xUxFiSIzDnIWMkP8QqZbiocpFgByPjZOXRNlXBw49Rz/zpmB9irdBxQhgPW745OUCnmKREnyOoAm+8WXEM9jfgt+GvpBElbOYcTbdRXGiYVKq5aRsF8CIl+eaR0vqb/68TPuFBuLdpE9TLmKhm9V7tDStuO5igCaiAwQQqHN4ONowz6Ryhq70/0tTBfRNeVkY0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkQ0bvbLL4MDbG9MZVvyi+3r87Thw3+XdkjQJmBTtzw=;
 b=s/4vVTvBSaxb1NAahW3CEzl8VxPFu/SubTGgx1cq0wJhOq2LxGNjoFtkp1WeLTSORPdQSItSU8VnRIIZtqksY9NcjhK+PNvJS+WID6JTryCjujcuKwsxXVysNwzjhbXttn7+2cHK2qV7Ai4t0i+j6g3D7rLjgNWH5EYGZteuzYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com (2603:10a6:5:33::26) by
 DB9PR04MB10012.eurprd04.prod.outlook.com (2603:10a6:10:4c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 15:05:46 +0000
Received: from DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a]) by DB7PR04MB4555.eurprd04.prod.outlook.com
 ([fe80::86ff:def:c14a:a72a%4]) with mapi id 15.20.7741.017; Mon, 15 Jul 2024
 15:05:46 +0000
Date: Mon, 15 Jul 2024 18:05:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Message-ID: <20240715150543.wvqdfwzes4ptvd4m@skbuf>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
 <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240715115807.uc5nbc53rmthdbpu@skbuf>
 <20240715061137.3df01bf2@kernel.org>
 <20240715132253.jd7u3ompexonweoe@skbuf>
 <20240715063931.16bbe350@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715063931.16bbe350@kernel.org>
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To DB7PR04MB4555.eurprd04.prod.outlook.com
 (2603:10a6:5:33::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4555:EE_|DB9PR04MB10012:EE_
X-MS-Office365-Filtering-Correlation-Id: 556f393c-3353-4831-eadf-08dca4df9b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlOZ+xgBx9D2Ymty1uaO/v4L7nqnzbehinAnCKH539bRn7E3YlsIEErJyH3I?=
 =?us-ascii?Q?APXN1SA73VPa3F0kgc5+VpOMgJzYJ55pNRZMcu7dnwAMY4Yvr0RjCVytCdIO?=
 =?us-ascii?Q?TAihSihCnmdHD0fg64ayGucgC/r2ZnQBodE/L/qUlx+cADtx5X8H+mwQkDHY?=
 =?us-ascii?Q?2vyONMG7KMFUWu9J239N+9c725u/tPYtWo+oMVFdk/GrYK/rIJKlvQ78zh/j?=
 =?us-ascii?Q?m/SmSJ/hbsfJ2TidADiyYLNa36fW2rpoPvKGwPkw8KhAUhNtyR9SW2djV63j?=
 =?us-ascii?Q?yGS7lObo6249iWv+jT12FAkxh5+UfJgPcpVolc/r69nnREjZqkMp6Sj0Hd66?=
 =?us-ascii?Q?w52Pwu9Vr38RKKPTgVz45NxmYkVNhhgpiw0og/YRFAVR4dusnO0TnD6U+VdM?=
 =?us-ascii?Q?T6rAOuCghnhvmEQUg8APWNVwxF0mVQs2MBSdTVoflTWuwVzPk7f32+LoQHEo?=
 =?us-ascii?Q?m6BFBMzCcB5md3YVJvdMSV/RhC/RTKLkEchcZQOUeWRxxjhRxJFJla5b47uJ?=
 =?us-ascii?Q?IJeYE8qreEp51dm3/vU9W6bJ5iR5VqObz4nlLjL8I2d9sJMIi7KNo2X4/Go3?=
 =?us-ascii?Q?xYeYudLyGQGcE5icFH0FFL+cNqjfXacU2ZXWxeKU170pZh2R17JEI/hJLETW?=
 =?us-ascii?Q?NFvppFlxVuJcUICysflLwsd0nVTDy4tzW7+uMrJOCdeUdIFjy4qreh6UNU7s?=
 =?us-ascii?Q?c1gEROlXkDitedzQea7fqwNLrZ/2Jzk6QrlsXvIlMljgYpoOinUWgTOXKNy6?=
 =?us-ascii?Q?gJoKw3kM4lZWC7QsdLVkSkV8W2vcLPxbVyyLw6TNaHVKvv7W9LCtXiuX0Tlu?=
 =?us-ascii?Q?Mu7pWzQFppK3SOEyWoNj9ReQ4HchUa8vEXIHbluXjPH8+WhNtiw6ivy89SD2?=
 =?us-ascii?Q?B1Ja0WquFF7byyEAVpcx3hPVstryQx8Mr5nMvoeeO7cI69ukEn8vzz8wmwTk?=
 =?us-ascii?Q?PhBJ70RA3g6MtC2x37BR0Y35xpEdzQWtOHz/DzTbeViQomBc2v7IV1skYa05?=
 =?us-ascii?Q?MFqcqFsxAjq5JqFLSoJzb6M0bs8h5+tcbhQ3CIBn1BBVo2ixOyv7xn6dwB4+?=
 =?us-ascii?Q?esgA+fwO7P3FsWnBH7xIjK4g1M0EtBHGSRUPw2nx+2Yi46Y0vWdufG/QAp1F?=
 =?us-ascii?Q?kBSQ90mi5Mk1d3AkLhas2Fpz3sYJn/NGmqMvedL1pESeaBGyHXAgeEBPrk2I?=
 =?us-ascii?Q?pRFWtUY32DCfMpBDh92et05Wjh5Q6CTkHlzKqOrQA6Wh3zS7YR1WWgRHdtLT?=
 =?us-ascii?Q?/Yh1W5U8aVc0JeuXzgtEy9r6yzLEGaDke3B2ImqLrCFotIifc0cV57MP88BA?=
 =?us-ascii?Q?sJ3muZFJHqUCcN4JMAobWv44sbZ4yaXsdCGC7A6pwjz2dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6B4A4f/J7+Op1BEKNhUGB2zboPYOE1xZFgJGkmfLH8Xh7/Dn4bBHDyn8dgu?=
 =?us-ascii?Q?fHygPeXtfWjyHGmnpxBdGIbT2ou5WYmKfOA9Z2POk0VRPeD3FHaRaloZsfwK?=
 =?us-ascii?Q?9IhDKEuKjDknWoqqm2HR9PWGeT3uiaEtxNeG5UfRvqfcdIAn3cfdYJCHdxXs?=
 =?us-ascii?Q?ZFrljNu+dBE2+i+FQWSPF75i5ukK1L7tjwA4Hq3kQW3tirQDDDXSlwVMjkan?=
 =?us-ascii?Q?KBe2lbvtezXpC5c1YBFHkl7JEogIaIgmCM9TMfhF0rVlmEMmCGYYY4EaHqTY?=
 =?us-ascii?Q?iTjy6if+Xaxz73MqPJpP5G3M64LZB4a+rt7DkUyeH5dGxCIFhuLpt6qPm26a?=
 =?us-ascii?Q?90H4pbdEmQDL1biDr8GY9naSn/pYdSXrvZsQR8x+UhQwl8nt96ds4FKX92Dv?=
 =?us-ascii?Q?SbrI3DCpbb6emnC+B/2z80hBZXWZ32vXHdaJRDMHEjgDkfz6CXzBBY+hpeKY?=
 =?us-ascii?Q?CbuLFXn4ln2s8X2H0mjo5nMgB5/k/W93bAnV44F610oDQ6weCVS5eBUCXzch?=
 =?us-ascii?Q?QeEHlg3KgA82G3HWi+MM596pShsFTwNflPxHcMj7IUzppRtlIyaM4lbDNBBH?=
 =?us-ascii?Q?d5lH71g0zrKPHPmUDVvmlq2pqtefG8LCYmRhdc96tNMwWLH0qXZOifoQ0kPs?=
 =?us-ascii?Q?Ez5f4l2sUZhHVpPHQ4AQdCbSCUIB0E4xLJ8RfHsWibnZN+QTiQ/OeQfSvW7J?=
 =?us-ascii?Q?TOqRzBhf9GUhe/BUYvmsCV5HblwpV3avawv+PIszXG0PZcmdNKOIy03yy+3j?=
 =?us-ascii?Q?61NOvpq/ha4mhcFXYYHDMFt5gbfSvc1/NGuCYexs8nKSSgohPagyH3KCgpoJ?=
 =?us-ascii?Q?d98oVvxHUHY1oj+EXX/BUYupERQbT69pimB4IKY0Fk0ZXH0urPRXvS/xTg+8?=
 =?us-ascii?Q?d5GWVpS5HbvC5FyQ7HjQKrX9ES/aZd571zoRO4KeB2u3a5uY1aN5n8UPCqXW?=
 =?us-ascii?Q?+riSElej/dynbQOUZ0fcvb8mqslBVUuqPOsAmKp9H5BnaNJV0ytf9+QLXU0l?=
 =?us-ascii?Q?Xx7M2mnTX360xZmHazuV09d63rENqX3vHhSPPyIC883bmOl5klqmLxRquZ1n?=
 =?us-ascii?Q?GNxwz1QSYondefjG3jEuiSZQvKMxTRsGpFmqy+IhQcfW7NI9lKiZimWEax+v?=
 =?us-ascii?Q?XBQLExLMB9LEI+gONeorBk5SEO4Ak1cQLZ6CFFudfHGg8HwxEsnWTsp8IydH?=
 =?us-ascii?Q?TnJf9JBeLyEB3s9sedyoyWH2CL9o91nMTqKKyusQyxbeyIdR1ypBKC2o87k+?=
 =?us-ascii?Q?Ogbi4yHExh7gF2JRH4nMJgO1zcokCoQm2/AP0f59PFaM4V61iPCWFJ5Y8dT3?=
 =?us-ascii?Q?qMQq33fAAdFucfh0l+mb6bwO6v8CBq8Zk653hpoRieOinGXVqfo0btZWThZY?=
 =?us-ascii?Q?vFd45hMXuX4Awfryz3FIyW152tMyT/xWhqWX12qoKGXUSYU4Hq8fHgQ+S1Cn?=
 =?us-ascii?Q?2xTFoWzayrMTQ/IkFJNeusiqmBHtJudEvCgN8k/hbWSbZW9pMt3CMnUVyR/A?=
 =?us-ascii?Q?sUWEhRVDuEzIWrPgDK3aesincEmZcnrJdphm1uNLcHI5m9vqO4omu2MwRvDu?=
 =?us-ascii?Q?u+hIcGfbGiTcgyDzXZlOko/IXpVYoCoUK/Y4U301FtjbBp01Haay5pvkmNuW?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556f393c-3353-4831-eadf-08dca4df9b0d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 15:05:46.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSKdqMZDdD+02b3ufH1Tdq7eUHvYbkeC/dhYPSZY0N/j7B3b8sGfkgiZnUlRwN44D8DPjcCSPi+jjKJ45WgM5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10012

On Mon, Jul 15, 2024 at 06:39:31AM -0700, Jakub Kicinski wrote:
> The definition I have in mind is that the design can't be well
> understood without taking into account the history, i.e. the order
> in which things were developed and the information we were working
> with at the time.
> 
> In this case, simply put, GRXRINGS was added well before GCHANNELS
> and to assign any semantic distinction between GRXRINGS and GCHANNELS 
> is revisionist, for lack of a better word.

Are you saying a channel is a ring?

Semantical differences / lack thereof aside - it is factually not the
same thing to report a number retrieved through a different UAPI
interface in the netlink handler variant for the same command.
You have the chance of either reporting a different number on the same
NIC, or GCHANNELS not being implemented by its driver.

revisionist
noun
someone who examines and tries to change existing beliefs about how
events happened or what their importance or meaning is

> I could be wrong, but that's what I meant by "historic coincidence".

And the fact that ethtool --show-rxfh uses GCHANNELS when the kernel is
compiled with CONFIG_ETHTOOL_NETLINK support, but GRXRINGS when it isn't,
helps de-blur the lines how?

I can't avoid the feeling that introducing GCHANNELS into the mix is
what is revisionist :( I hope I'm not missing something.

I'm just a simple user, I came here because the command stopped working,
not because I want to split hairs.

