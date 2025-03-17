Return-Path: <netdev+bounces-175387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EC9A6590E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EBC188ECA4
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0D1A2630;
	Mon, 17 Mar 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XVmcnq+p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8E1AA795;
	Mon, 17 Mar 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229733; cv=fail; b=Pq0CUUo0Fe0vWtkYbOkOWh6DWVGpjIScX4qTwzLlV8f5doGfNG/uPxgW/mTK9LqA181ns4ugN5mgF5tFdL7BCigZs1xlCUUbqAC97C63EWN/mCj7gIEc+3isAOH1QA0goqZmoo4bxFwYyhFVKqIPftpoIw47+Wuaja2EOeIrvfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229733; c=relaxed/simple;
	bh=RjplOj43JwQhW6BkItngH6ce66UXDT500NzPoVY8ils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m27FobJCrz6GlhyCS/EQ2bEwLf49Nf74hQNqaxT4JnONJm1Xe4qQwWpt4ckjQHO6KIiEmp6cBi8y1hdFMoM/D4lDoMi0fPUIphLLJOvc7X0xXiy1IL9qNegD7x0l93x9NMtdJ5i7nPx4FNJavfFjFXemHEQwg30lQOm/MyplRcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XVmcnq+p; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMUtjKjyOom9yrLAVzekUBCMxgkKdiWaIBe1oY9zXrLN9lVZEFou2zrUSr1larhI2P6pkTfOG9KhNBdLxBJuVrGKt+Glyvc+F1PMvB/JF0qLoP6gr/TSMa20AlBwL9OIU5JDXX9RG7esRuONuQYop9AOCVEoeLpU49/35T64yp784Oz2Ctn6qFMmekP5J93enqL4rcZ3TgTChV7oayUZf1g+aFpWs3y9SnnvV+iHNeyfvDQjnsI+r+/GDPKyNW7RwYZtokm02KNtQXmMJZXdEhiZjuR1onbFIjKp3C2fR96n366jrWFumvyvr3YlOUU+eozj4mzficpagd8UCMewwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuxreAdMwOwwNMQyOsXiWG/tBsi4dW/BmxlW0++FCOc=;
 b=Nt0Bd0EqDl1s48Md5KV9jv5/WZJk5Z0QZAZ/HTJJNg37A+imIFyUFRI7zmylp5oCykm2QzLwg6TCKX8tBXj6kb2OTE73of1ATvhbeGthgixIQUwxEfFIWf7vVshUyRrGYPLWg+MNiQV6iqUCUdsJkcIfzRYNdNeQbfXV0iuQ0GhpZ/jDYApJEOrWcxRGx/BzFS4Z60s0Ks7JIxbRTZ5su5Uhb07aLBQvrqpEcc0xnk2YQf9k6nNlNPgvBRLR4aGNDAdBXQutwixMRi7n023d5d4Qh0vMbHlQbwnuM0JtIstWe9fVRao0Stvwfjhl3+WRruCmPXPwoY98o3DD3uRu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuxreAdMwOwwNMQyOsXiWG/tBsi4dW/BmxlW0++FCOc=;
 b=XVmcnq+pt7A5YOXSNskSRbH34tb7EMFcNlUFmMjHS9qFOZRwpDXIibrhTwdvSNjIZco0WuCUBIklOQol4GBXFDAz3EXCDdoa48IrzU+IGuhUfHlH33LITCYdfW9Tz/NRPqb5N1ZluaudhOJ7nAKVfdBsu1Dkhtp6dOmJqu499q71Cwla9gb/JGDthX9vafhnlLeiTHuODzl7J52BAlvOgg0iIFAtnGML3QABxoz9GIWRML0YuF90bBEuOMLulOZKYJpIou0oFT/4u0YG5+Yhi9mBcw7YoHeyLyFtOaPhZG2kDd7r1cQKgOKwhMPueen9zBuDnnTTvFeevtMhV1/7aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6976.eurprd04.prod.outlook.com (2603:10a6:803:130::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:42:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:42:08 +0000
Date: Mon, 17 Mar 2025 18:42:05 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 net-next 06/14] net: enetc: add set/get_rss_table() to
 enetc_si_ops
Message-ID: <20250317164205.bp4vcqarggp3fnf4@skbuf>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311053830.1516523-7-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR07CA0280.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: ea86cc37-e638-4aa6-3dec-08dd6572a836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rghkkGG+uppfCZNYz/FEUIrrs6nWT9xwkFC7p1tMYK8XE6WxwdK+ztEv1VxO?=
 =?us-ascii?Q?gkYSVCiC2uLU6+n+mLgMjGIv1Hwanawy1NSKMwRrcytU37Pq9dxj77Lmshr5?=
 =?us-ascii?Q?dadDUvGytZP/zB3Ac2GEH7cwF35OWCXAWIl7iWSWeLV58GKHp9EKEvcQLcb2?=
 =?us-ascii?Q?f8DlevTyIHHbf4TokxvadclDqXYtOZd4kiWSxqWTT+kyPjja05amDHnb82g0?=
 =?us-ascii?Q?ZPp3RE/oV+Eac02oppC5lySTJ5hzbgn6pSA9drCqnNrEK8bqoqCAkCQe+ht9?=
 =?us-ascii?Q?dczDbZq0KERknwwIFtD+9FQIR96v/PW3H9bpPmN/sb2e0X2+Urzquqq3IPk/?=
 =?us-ascii?Q?tTuCNMXrQQqUYtCZiD9hHm+Maxag9t4hZCGuC7vmkjOl5sG7U3s4S0EXME2U?=
 =?us-ascii?Q?IA8f6xmH9ct8UJIy/1MFlrWMZu+u9vItfhG7Il6QC5d4yKFqGnzRhOq9yRok?=
 =?us-ascii?Q?mkuRMUFJhPhtCnb4VsOi/zRgGyqRZS8+D3hDCRuPE7a95uqMussRj83jVXl2?=
 =?us-ascii?Q?s1dQ2EhRLz/6JIqdzaM6q+ElyMV5/XEKiQua0imFEj4zoCiPqZBG0XegUXSA?=
 =?us-ascii?Q?xs8lr4p+L6fTlC66qikpkc0QFz+BZDsmWALtExxqjCN4C+8uAs9k++323ksw?=
 =?us-ascii?Q?5fnksEXtcwGB38QeYP+OhTTXHTKx3L0kUqsodG4LJwduYTmKLd3QgCbzn20P?=
 =?us-ascii?Q?M0LcF6eJQmUGkkzO1gyskxNcOXrFqpMDnK0ESAHOgP0TYAEq/Qqtm6PZnTo6?=
 =?us-ascii?Q?9CXbv2rgyBoBhCIwu3Z1cYTr2+jIgJKqYuHKqgBDQ2lRWXtcJ4A4xefhOJ7e?=
 =?us-ascii?Q?Bn0DJIw1WwzOjfi0FMZu64jiGd9g/L+WNEDIs11mcnx1N7fRLNERB0Atubob?=
 =?us-ascii?Q?k1fCfhbVVWKYhbRjiva35M7bg9qgFQC3tb62L+HptyxhabIHKK8Af7wbboOn?=
 =?us-ascii?Q?VXKgXwSjkQNF3zjPXMeLe+eYAkCf5F+mmWsbdu2jkd4Mb5lNFpWdmruMHUan?=
 =?us-ascii?Q?NLaDxIGXQvTopWw9OtTW3QghEhYZtqspFbJLcjN/dpWUX2kSsJPgwBhln2VL?=
 =?us-ascii?Q?xoyjNnQwhIswa4UONemFyO94YgcIjf0eIpLDqK637ZZUvguWMUynCGYTiE6V?=
 =?us-ascii?Q?+wUqaYKJljWSGHQGvDBEhV8vkAkynweun8Zn7JMnNhvoFTPI6C8bkE/+dWKc?=
 =?us-ascii?Q?OpzoZzvmtJWYARH23XEYECnpX9n3iq6DBd0eKk/WTlcMJQGBQkU+4YPEoKsJ?=
 =?us-ascii?Q?7JcGoBbyii01DgzBUtfnN+GXrYZ9ThLBEeJfbNIsgOgmrD+qr6C/yk3KXCDl?=
 =?us-ascii?Q?v7fV+hFfZAB7EUt3zMr3enoIPo0UO8Wzs7cXW03fFLkSoWSfWx7fz06ln9FM?=
 =?us-ascii?Q?MZimMm+w+sltMalj02EeAFDTc6O8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uD4ST/cXTfjwqdwwkODCVYIpsbCsN+ZuhKHIypHVAVbOmt0910uDO+TW8RNc?=
 =?us-ascii?Q?RKAveG74LqcvViwWNiwrikG/BMTB+oOq/6CDst51bswqcSCRGh7Vftob2ASk?=
 =?us-ascii?Q?A7cHAW2X84DNR9EatEwFBwc58IgR2D6YTJ2LCjDzsWoZ8+b3vRnVxx2oL8xJ?=
 =?us-ascii?Q?ekmm1tv54KXZTloBv5bd4apxp6Dz/I0jk5ZatF+QrzCJbJUxjyFtcIA+qCKX?=
 =?us-ascii?Q?N3qTesjJ9tBBk9BuqucHpWaEk0cVHoSKYimAT6+ZJocCbnvXffjKbIWijtHN?=
 =?us-ascii?Q?z5OBlnZ+H1+p0ofa2EQVwAi4In2vkY+8DmDhJYv0E9gXLXMl/HYNuu/jnW1Q?=
 =?us-ascii?Q?8dZJKs4GAN5WJ3M/8L6SquVMlqfibiY6IZ0qONQqkvlHLtiahNYmJp/zqz8z?=
 =?us-ascii?Q?6fjbQqs+akdGd1ITcPOaX1R8bCHBxwIamyLPmIImKQhDnot8gVp2OG/nxKIo?=
 =?us-ascii?Q?RfB+YZEdnbg4I+B2nySrLMfKPEtgRHvbqgKXbfdbcjQxZnjNlk8AaJUTPkfA?=
 =?us-ascii?Q?XANFGJwZQibe4Y6v02YWx+8Tcw1ArMLvDjAkgI6+I9TFU8hhmDjsnw7OA5UV?=
 =?us-ascii?Q?4I7IWfyBI6I70QZfBId7VBK8MJdE8RtZqjgsJCtl3ifdFGj/kIIZN1a/N8cP?=
 =?us-ascii?Q?t5iFgZiTzqLJFRDf1zx5jcoCOBpwkNj9zbAa8hPDMkyyYHaJcCgGfc66lpOv?=
 =?us-ascii?Q?LlExf4nSdF2/BbTsWvOSs9p47NL0lgaLkbpOVJxy7JF8TU0qD8KLNmWfSwjU?=
 =?us-ascii?Q?LL8XHv3xg2m3M4HwM+ZLjk+s/iwx7fMXrn+Vw1qatRzWpCJtknwvmJZ+zFe/?=
 =?us-ascii?Q?EAQvV5fSSzMDtbY87AMnCBq+XuE137qAS8h9Uuvf34EKMX2PiMx6yz8MXiyl?=
 =?us-ascii?Q?sAMCYnevXQBeLq02xnePEphxEYKmxuszXWuofG7I962xATsJM7QzJw7oHMA1?=
 =?us-ascii?Q?/VQnq+1RKRZgWoUIspyrBS8HOgAk8+GKhUFuxs/u0A15cpkDl2Nrn2VJBLZ6?=
 =?us-ascii?Q?CrYyCM+yNq3KT1s4yAGzmGY4BfmHVhtsAYAI9OAv+/PAkdQPru3VijzXSaPY?=
 =?us-ascii?Q?n+Cz/lkourUL8Ltp8ZgF7OxmuP1KuG5LlR8rNUOhiPNbWvnztYYa5igown/B?=
 =?us-ascii?Q?8kByqj8gfznTiaAguYMusSaKSFI249xh12BmkZpXw1RSuJx6zSS6zjwEk39c?=
 =?us-ascii?Q?G0pSW73ncUzZDBDQuw7cnk/gOk0RMovUSUHhPwluDPI1IKQ6UNEos8D+fUcJ?=
 =?us-ascii?Q?5rqT7H/YptibFzUh10XUVQ44E08JjVsntF8jOzeITP39byBBShtcFoshc2bo?=
 =?us-ascii?Q?uAwXdtTcrCzaZ49I9XUF7QsY35LL/hL3ZPYLpMY0FB2Y8i7cAiUvIucnqLZx?=
 =?us-ascii?Q?uIfbfjrYGGMX5aa1HvFRox466PBcIpVOq5pSTafkhS6GfZpAdoBWhkVcb1CA?=
 =?us-ascii?Q?38RamkDmUfydQmofDBgEH0hBh8Y5ZSkWg85OWeZKGSEQfugsIdtqdkT4i8kt?=
 =?us-ascii?Q?7Du4k/7Xasd7Mn9hlon7zrGyTsPuGJDReGqUcdx7WZsEdBP8SYjdFNGqfmp6?=
 =?us-ascii?Q?YwYU+Bmk9Z4xHw4UcxdS3hkyksWAClaILdfdsBbCjFjFL+eN9dJstE4wynKi?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea86cc37-e638-4aa6-3dec-08dd6572a836
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:42:08.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtMZhm+pA3N9NUX2DcGF0gHhAfY98Um5zHWZ5q/zrssmrxOgBkEALGhkIKiMkT81nMUnIuzYFJZNXeAHzBZKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6976

On Tue, Mar 11, 2025 at 01:38:22PM +0800, Wei Fang wrote:
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index d7d9a720069b..072e5b40a199 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -165,6 +165,8 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  static const struct enetc_si_ops enetc_vsi_ops = {
>  	.setup_cbdr = enetc_setup_cbdr,
>  	.teardown_cbdr = enetc_teardown_cbdr,
> +	.get_rss_table = enetc_get_rss_table,
> +	.set_rss_table = enetc_set_rss_table,
>  };

Are the CBDR-based enetc_get_rss_table() and enetc_set_rss_table()
the correct implementations for NETC v4 VSIs? (I guess not). Does
the driver/hardware fail in a civilized way, or does it crash?

