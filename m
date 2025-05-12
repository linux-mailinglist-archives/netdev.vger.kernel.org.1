Return-Path: <netdev+bounces-189737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06803AB36AF
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A00D8604DB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDB729293E;
	Mon, 12 May 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W7G/utVh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3688467;
	Mon, 12 May 2025 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051629; cv=fail; b=AkpTuVo6lw+0g6DucD+f+9yJb7m72VF5kWUH8UtBHoOI78UHGCNiTvqXq605oeQxF/aQL65+LEEMUANW+9HgpYUx8B4CMye82TMNm8WZI2vLB5VT0/v28+GwoXgPWna39MCuXgkmY1QG/4xRC7LyfpnqDONj7P7JE0v1oLwjqUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051629; c=relaxed/simple;
	bh=44rGwLkviGXD9Tu2vzmbmKFLE7cTc78YjzyeFmbq9KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IGQeMVEC7N4N++7wrSbkVU+74jFNRUIUspgHLWTZ6tZ+Y9wy/sBnUlliQFAHwwQtjM6Ei/H+rcK9KdptFolWipGD+6FuWSrWDWJbiISTXxxAJfmXzAIDjFI41UEFC1sNOi9xOTkEBDh7DaZVHQLr+HNV9884o8toyrTOVJOVxcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W7G/utVh; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEk3gWj2ORSRA2zAd6jeAtgtO7YjfDbQzpNVgfDDYM4dYHfU/s8Fr9nOHd8CZ4KBToTRx/75Oqi0C9gPmjuBCM2uHzb1y5w50tWNzTPSQqtBGWOc8lAi1QQ27Y7SEpIU5a7rvcNVcapnEQFJr7f6Qr+q+Lf7NftgC2GZFKj8XLJu6wqypFcqLwYROYUT/uI/yeWJM6jYpxOEjp6ll+J+3lUdAEyPlXb+11foBolwY9Cf2Ea/lQCKcZqHH3aTwIDOeq6YAop5bj2r2iXWxq8Wa6BZTrzG2t1ab/67mb2CkxzIBdVV6l/H4yoKSOr+SozXjgJLc7GvjWTU5CzarLnOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOjMhR686oGN6NYIasxDbGSnAw2tWWEgnL7pClNJsHw=;
 b=a4FqYAOiWk2vkyu0CF1VgFPIapgXJ3M7EiuFGYSnFZK8qZF20pDmJGcF7do9fRTl8pNgcjj+UCkK9MjRu5DGvlchgsDagRm9ANYCFeWXF+EWvZTskrRHpRCcsyP3FOtfrxUA05y8nbCFbqFqtMwbzw+GvVJnWk9LF9wRFveDc/X76Ccc6QtXjDIpqiNg+EcuLIUysdD7szF3UU/5FKE8T34YSCSMTScV2R51BziNKnAryRGWYMyAlRafr7vT79vObSgE9ygs9+i83svb0Bc9UDBDZ+mGtDHAPPnL5Eg1WZv5FkkMXJzcK7S+1EuXk1W2lZ7gjl9kMV5vTuSdtafJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOjMhR686oGN6NYIasxDbGSnAw2tWWEgnL7pClNJsHw=;
 b=W7G/utVhc2fDzVnS4tc5Us+Ov4GnFrbxk96acjg8WtLX8tQ4DhkHRA8hw3Ov3HuhcQSuGUndXFXTJfa29CCJqZL8o+MlRNEpbQPfxqBQxv0/cSDX2CxNLjDU4LQH6I1S1GUDd4gRbCeR4NHz6u55dNy+u8MkZOuZfTJgDgAqLZoD1gvE7s49gZdgfoowxSErSJu62bvM6AhR135BDhoGWNBi1lP9IF1Hcn4xDFBoyW38d52u3jBd7mgcVlXwnG6UUYRUK/M+FxkVTVJlpRdrbJJVmoA50pHOalRv+uKXmAraf63QMOTY265p4snsaQaA18FJy3aSPEc0SGmw4rYRjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 12:07:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 12:07:03 +0000
Date: Mon, 12 May 2025 15:06:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?S8ODwrZyeQ==?= Maincent <kory.maincent@bootlin.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ixp4xx_eth: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Message-ID: <20250512120659.r7dmrugocat7ou3t@skbuf>
References: <20250508211043.3388702-1-vladimir.oltean@nxp.com>
 <dfb57a6c-8db7-4ab5-9d51-eec40cf8662e@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb57a6c-8db7-4ab5-9d51-eec40cf8662e@linux.dev>
X-ClientProxiedBy: VI1P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 2355674a-a429-4ec6-79ee-08dd914d818a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wHREhan4BJOztNjVwHmij/7aIUz4LzehA/Ugx4+mo0VVsyh8pqN5wuosvVC?=
 =?us-ascii?Q?sTxcRnXF6jyFqs1YnZIn9gt+KrZeNyCMPIRxH+Z5kC0HVrml9vHmL+6qG6bD?=
 =?us-ascii?Q?G310gjJoq3p91W1intDoP5/yo+8t3EZDM636OTonZegKwzlSQrxBD/V+QQYV?=
 =?us-ascii?Q?dC9RNd9w8cqzPwvTdX5wkqgEhmjHOD1Zk2jBg8VMKjaAXY9PfbhoWswWE5sm?=
 =?us-ascii?Q?XhfBBDFhkBzsTjr8QiBeSR32mbn5LF/h7C6t6BEt8LFQktwxzp5yoDIC43bM?=
 =?us-ascii?Q?I5VO/Bo233fmz5VcF5+pwyskpDnO1O2w4qaWlHouYwyIYij3VgtP+Wltw27u?=
 =?us-ascii?Q?reZ6ilDIVf4/q+xfI5hhCOkzu84BTx5uSpydSb/VXnqXlsrzrMpIN2eCWWV3?=
 =?us-ascii?Q?hAvch8rxNk0o1U+kUU80pMf40IGBPSmF7T4q6T+7IO5KivtWykCoaAMGrW+/?=
 =?us-ascii?Q?W35hLirmHdwu/7j0WHnL+lf3Z5/5C53zPeOlrQu//Yfsujhuf/vPSI4jDqhC?=
 =?us-ascii?Q?Yo5Kiih3MIVSaPnIdxVsIgViWqPfbuEFNffYxNIBcaZnF7KQ44x/JyBss19z?=
 =?us-ascii?Q?W0cT7XDX78Ze1LXY3CRfKWH4Kvgg+m2JzOjfNCTs5i26FBACGZNmq0lstRNe?=
 =?us-ascii?Q?RBh/zxhqKcL1VCwzbz9yoVy/WnwbPYmYBf1Y4wHnomgLZnDUh+cQKEIFQWhl?=
 =?us-ascii?Q?Lj7sq2PGK2LLA3F3oSFG0rDmMQgBueFAfLZrGuCAMWCDv0G2TXFET44U7oA5?=
 =?us-ascii?Q?WWlZvxYRsZS9dA1F8ifkH9ZttXaKcAWi2CcXM3CEamBwF24gZNiHSz1IGnVm?=
 =?us-ascii?Q?gKKndC4uVuMe8GzoyMJ2kLnE/UXqq8TXabkkFlGypD7mPbnuJJCtVCKCKdfe?=
 =?us-ascii?Q?Iyd5ykCkvOshgdboUrzsdbKpyYmKeXNu3DQjI7e4iQGuq0uJsmJuLRtF0Aeq?=
 =?us-ascii?Q?TzYUYj/TbUz9M3jLooQhrlkSHFMR77Cv6SyvhwbBHby5SiVn2J1gHGtjAbHI?=
 =?us-ascii?Q?UkWbJ9BqrFii9+8DRAK6oqmd765hS1JBdtuLJ3rWPjqKmoq0MfNygdy3HAnh?=
 =?us-ascii?Q?a3vDN2kzY2Kr0teastMamUsJyCX+grJ6pYuo3Gf3kgW0fwIHGhqaPwNzYzQl?=
 =?us-ascii?Q?Q9v7Sdmw0+A1e4cV0EMp3XGz2ycsDEeQCEyp1pKsAd9kPEC0Qt2IV0rLk8Ct?=
 =?us-ascii?Q?w29ebzImvrBtzWVo1zGZMg9EeJCcQ5O+97ruXX7XOx5PeUv/YluGXDwV3MxB?=
 =?us-ascii?Q?Na850/ysGiALyj3ohnOLpxTUHBMSzAB9l4ZZTzH5rP3OgntEtNauk3Uw1OrV?=
 =?us-ascii?Q?3KLNwldiRVtfatwgLVESzfKg+DrPw60YSGY4hFLILAT9MYB63mGmbpM3LGmb?=
 =?us-ascii?Q?fZcIYoDF9iC+1l57cZW8DtN3D8uDSJ9TkCxJOFofnFkzziNIwg4pD0MjFtnx?=
 =?us-ascii?Q?rVJmeikuWUo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s1gfXHCPrM3+OSEdAcPo36C6lTMfYS8TDHubJALbK0ObI1tB8uMpXke3Ab48?=
 =?us-ascii?Q?sNITOcT/mYzzXHbYHH+q+Dk33Urssn3ula0XSiDIVZnlt290ndLbqOBIgJ6i?=
 =?us-ascii?Q?RPO2gEW1QenjsFRkCWFatBmmEcb1/Aay5yGFt7sViL9KAN8WDcVHB5OBsEgr?=
 =?us-ascii?Q?T7kaBy6SrM7ahZzpOmi/944qRADTOqdlAN0lw/zimxugqS3rFlRHDqQccIOd?=
 =?us-ascii?Q?osmPEyeED6aHTVx+40ftCzk1AMr1gxk+rLmLzx/YCYEkrytlsHwL3SAKzBMF?=
 =?us-ascii?Q?MIeOwV3qDCXfWysx1Wyku2Z334+UAZAr8Xz/hVNx0O2+KCTZz7kZCEan6YYO?=
 =?us-ascii?Q?TcusrfF8ai8+4YA6hdqSO+KVJLs4++FTSytRoH7w+uN3eeLWqYGEvZ1oCFcN?=
 =?us-ascii?Q?ZMW6LAFVwTp4cIMOt1uN/YD8+Ii84SIhynpO7tM+t6qRPCxaL1Qu8fv6VhDW?=
 =?us-ascii?Q?3udyEJ3NlVFWA6gqSihH641W4wKwwvqc5hxFasFmbGnKoPzrU1SVMIVF5dhf?=
 =?us-ascii?Q?Fpi6cODD6ZVBhILy3kWNBSMrqmo0YeUsL6Us8oXLQy8jkEWGVPfrOUN+gHAn?=
 =?us-ascii?Q?3ZQfT7ROujV6F32r5xQwvVBXzrnYG7C+RGhwscAo51Png38kf0+iSCzpnb8x?=
 =?us-ascii?Q?0W0OPssyJmt2Ze7rFR1BQ7ke26HpMU0z8zeWEcN4XkLa0vP9pwF7h3jfBZiq?=
 =?us-ascii?Q?FjjOcBXVIZjdWpqYTc07iR1VpDARPu+mlxuQ/kAjqX6yHeUeqZgOgFFsnWBf?=
 =?us-ascii?Q?+JyWO7ZE/4l+lFpv4hn2zXl1gPyp/rIoZS2SC01ahC7T5qq7zALK/jsuHbzu?=
 =?us-ascii?Q?eke++XbE2i18FJqw3+9pAR+F4CstBluyzElhfts7p1av3F9Aw7HzUwMOXBDI?=
 =?us-ascii?Q?WOZ1MiOYBBpW4+GkMS+8heNQmbvpOzucI6X8JvP5GAyZkNMGIGj3rZmuFwQB?=
 =?us-ascii?Q?3zu0UZqr4eU2VJT7B8oNUIru7o7TRjvvCGE1IxENoeLYsZBvtVhJqwfRDHOL?=
 =?us-ascii?Q?/ync11PdKKF5brTNFEWoxHlCAg13NrZ6Ch8Dn7nH5T8i0Ijk8lLWNqKJSSWE?=
 =?us-ascii?Q?UKwyzm+yJ/Q2iAbjr+ZToJYYH444x8N68LaYpa8fBKbhNADIR4p5/KLQJpSH?=
 =?us-ascii?Q?smEpoogLEwegUjlWZXaCBgJcaxYo8MUlRwjsR+5m+TCyDQFmY+B3qrDg8V5V?=
 =?us-ascii?Q?6go4U/w+9cyij5NAvWQV3paYkP9DPO6nWVDXTwt84GsA+3AOVmUOa9W3AeL5?=
 =?us-ascii?Q?scMPjOOWc2wOt/OsLAPgM7PLQen6PerfNY4hlNunozQbFZHUP0QOEdKJ2plS?=
 =?us-ascii?Q?dnmAk3h/5desYlScCIHkF3p4Scm3pSI54UCZhiG/aU61GgMTRdroH+/3pi6W?=
 =?us-ascii?Q?ogurvHl60MxtTqfHloQQC7/Y20bH4FUO79R2BXn+pTWa+Q/JAbj8lB3M/GzV?=
 =?us-ascii?Q?M66vM8dxjDxyhSMxSZWn3Qahe9aAN6rS3AVvSZHLGmRiizzx3DZmbk16OysO?=
 =?us-ascii?Q?UiH7jzlJFjOWFWdwmo3GQyKA2iNxif6mQiIyAdJUiZsWgyIdHUjypMyqMxNY?=
 =?us-ascii?Q?BNDjC50npwsVeekm8hTLx8VGrSNDUT5Uy3UhNq3Io08Lw8ePQMn2zV2/BZNC?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2355674a-a429-4ec6-79ee-08dd914d818a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 12:07:02.9873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vo/MewarGYQGyBauJoKEqIHJjHzJpXNsMuUQZRK80Mx/W6AALplpfz8Fqe0R0BsGe/eL2hI5IvacpT5campChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817

On Thu, May 08, 2025 at 11:45:48PM +0100, Vadim Fedorenko wrote:
> > The remainder of eth_ioctl() is exactly equivalent to
> > phy_do_ioctl_running(), so use that.
> 
> One interesting fact is that phy_do_ioctl_running() will return -ENODEV
> in case of !netif_running(netdev) while previous code would return
> -EINVAL. Probably it's ok, but may be it's better to have consistent
> error path for both options.
> 
> Otherwise LGTM,
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks for the review. Indeed, I hadn't noticed the -EINVAL vs -ENODEV
difference.

Are you suggesting that I first create a patch which replaces -EINVAL
with -ENODEV in eth_ioctl(), so that ixp4xx_hwtstamp_get/set() is
consistent with phy_do_ioctl_running() in returning -ENODEV?

