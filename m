Return-Path: <netdev+bounces-213639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5DEB26080
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73791895037
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86632F7445;
	Thu, 14 Aug 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qO1OaXbu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A92F60A7;
	Thu, 14 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162471; cv=fail; b=DegGMx27Sp0S2rmWaFhz1w0MySAgwkgOZ3DS1uB+vqrE1494M6arY9Py3zscioFLsb5QFoLAU1uSkX8EPXhWQ/cc9dXAMMesHyfTgDUhaJDQ7SdF3xUJfRb/WX3txiEfiClHj4WHgPj6LqnHVTKJ8OkAmkRw+FIDhcyVgb3q5AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162471; c=relaxed/simple;
	bh=uGR16H23HGNTRlZ/yTQj1BRgMFB0ZATjWwCJ5B3YzUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JXwT/2Z1PVThIsnbjLFCgUd37XMw7+xz2UA62jEksVPC91nFwidBtmf8U4r9C1u46k4mhhpKhn71Lbv9ZD/KLfJqiNyw8Sa8RYkuOIjmcQ4v8IGD7MF3KcbZcdObV/IifQXtoecTUUy9g0G14OePyi9XVu/W3PjIh410LLeCsNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qO1OaXbu; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmc2xsShbLbKiSNaV7aVbC/Vza6n8eVrOFIwQSyawZlGn8aN7i/DoZrQDBlsKN0oASVpyEZJHcWF7x0Mk+doAx6YBOWhzHqEh2zoeUtEbAVNnJwrl8r4EVd42s/IPi8geG9iwQEJiqZ1OPpwwUbJMENfLOok+TYCdqdg1g3EjAU4HnGP40MDdqrAUSj3/9Q/6E3Fs/RratAndf2nj5tt/cpPk6Lg2YSIQBcJXCZw30zby8kscXFTM6LtE0a4l/BebV3vaUG86myYz+vU9gfz79C5/YI6QZSeyvhVLFLSf5xhd6vBfyo8AMl5hcj/DjMIgZPyKitr8grbIE0qOcL7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdNwsdrdB9NM1J9nDKxT8jp5AOGE835UAW1GnteD0r0=;
 b=cdoppC49RCpdYMgIWiwlzYc0v8amZcqF3LYvz6Jko3fc+xAMomY0oYQ0x60QapeBMLCz/uHIxNttDWiCekdHjeeWG2N2PrLxNTnyoDKpczLP36GeOkFDB5cpp241sWbBaBswcSzdraHL+zQd3LUn3fqZWAoctNA0nyJB++FJOlA+9m0NzU/i6Mkj4miSBHhy2mSYnAm/2vgUdUG+4+TcY2u+Noy6g87ToSFmV8HgtfT28yWsTNYThMElHg9DfqTvJJ1fbpOB28s4geRC83HbLgWR6I8JgSPmfi0PWxsAViJ9JzuttI5XFd6l61etBCSRiGxlbuDlyz9VGPrpAfiiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdNwsdrdB9NM1J9nDKxT8jp5AOGE835UAW1GnteD0r0=;
 b=qO1OaXbudXUum5FGgY0eSWf9vmDLAx2LxWjGkr3uZSE6TxqWRzrVPZbmtmWjnqnvumQuhtQ5MEj9uxxoYnp62iOfVB79vv5g8oWvrPUnt1gXqtDzZpWDKEJf3EgGPboYQFGFrI2Oj66Yws1QmPlNcMi8HK8grSl8Er4CtHX8ED6OFZW7elMckoYTFjx6Eha4HqwH3yVrgRmtvjoTC3isMyTliS0rvAkzOsUT7VInMMnIuM2CQPyi8ejZwk4cLh3y7igWTF9wl9rhCV+C7yhJvJl6fUhRKVyALkAexZ3qNtkm3lO2nsjuNDcloaZIDK/8iOZdeY1S4pfzwv7f5vT+1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 09:07:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 09:07:46 +0000
Date: Thu, 14 Aug 2025 12:07:37 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net-next] net: bridge: remove unused argument of
 br_multicast_query_expired()
Message-ID: <aJ2nWdmpOEMQfVud@shredder>
References: <20250814042355.1720755-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814042355.1720755-1-wangliang74@huawei.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: b4835169-1602-41a4-0a9e-08dddb120909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29so7fMmlJ6l3/6yVkXVydY4wnnESLz3ZcgqUkB5vMKltcXychC74hsSxIqJ?=
 =?us-ascii?Q?BAnXVRWP/o71hSJ/8f6x4mEnTViNKwshydi/hN5AHDt+wiq48lEV1N6MS7yT?=
 =?us-ascii?Q?3la/zuwTGlhZl5NNg/pZcDEBRYc67VE+BnqkypHqUHF+Acs+Lz5ofMYsxhLB?=
 =?us-ascii?Q?nNO8O6T1AC7QJkrjMld+eqYzmlaoGNr9FDg2n57L06cNbWGw1OAyZ/k8I7Fa?=
 =?us-ascii?Q?4Xm9abXzrk4Ytfgfy3n6yLG4D1DiVwo26An+qMgqjr7yNhkafkgYCNU51QS0?=
 =?us-ascii?Q?wWrKsG8sB7MPpnR92sdI8jtiqf/xBVXcQnt3R2tXEltMa2DrTJqqEbeWQ8Xh?=
 =?us-ascii?Q?3jzJ8fy7xBaFzWtukP4rd9mKV0G4qW5qprPaZ/Fy4bt5hhx7iJCOG6RY4I1r?=
 =?us-ascii?Q?uypOG5l2sEkN5GjPoSpByI9geilORZkU1OuhTbRxc34TjY/71E7X0E9N13rq?=
 =?us-ascii?Q?MMG2FdJAvj+PrtD+YveNnrEQQ+Ff/URZZ0D7L/hj8D6vZyeGK5YKUgp1wQE1?=
 =?us-ascii?Q?YGx7nrWPATIB1iJvXOCD20Wz8es5/Fy0/10eT8n+mndzjOKDzM4YCMn6hPoi?=
 =?us-ascii?Q?5OPirGPxc00dnTfIsDxC9gj0YzQiWegJPWTyl61KrE5YXETOTZ43AWg9ZmoX?=
 =?us-ascii?Q?qQm8VhcV1hjHb7IVLChJ4YviJmQsLE/sxVca8TW3G/WedG/FYtW5CUnwDGlP?=
 =?us-ascii?Q?ArkKFTClDDSgcr8iz1mruOoBzRMFJ3fkFtHYK1tK99OzZn5wUrjlKHyT0hlA?=
 =?us-ascii?Q?H8vGb3XC4hjwq6K5ik0+GpLRHUqNK+YjBhjyhlw2wDB3gPbaICASGbv8007H?=
 =?us-ascii?Q?Q2tepvFt9nhjki4O4Zbmm+ufM/zEzG+VZZDM7LmeED7Ud5aa7Y6214US/U+s?=
 =?us-ascii?Q?3u8QPMvqBhDlZsEMYZwcfIjbmr0GLUvbosg1G5iM1w0di3rMBnkY23OsnuuJ?=
 =?us-ascii?Q?AFJ5zKZFcL4Qy0ZLqKwxdA75wYpMjRce8L3EN9y4S6gxxVB/7Y7WZN/ke88f?=
 =?us-ascii?Q?sKS9yNOFkicbkau66LMaPNxDUsSOxwX9YxA6pwYT5hLUZGC1YY4HZsMOObXG?=
 =?us-ascii?Q?ho5pZPMu8ptbtv4nRSXM43GdvcpdIRbCbYm+cHARo3lFXvCRwYT7faYBT65e?=
 =?us-ascii?Q?mfmJ/BG+k7L1hM5AguNRDDG12b/xS2KwTJG5wv0SQcNjbiAlx987lvpqzt4/?=
 =?us-ascii?Q?rMf58Ljy8dSc6VPDij+/U8Eck397luYxFwaGJqMr7OFjxdoa29J6VDtKVw4x?=
 =?us-ascii?Q?ZySGPTkkeTLsNRSXeQXHPTl+HC+FhGxP3A9ljMJIYrP6D6y0ZazuLH3GMv9s?=
 =?us-ascii?Q?KD2x4OQVSMdJahpXb6ggxke407cyb6ZmcUK+PxysnNO1ACCwITraJRR0Cb86?=
 =?us-ascii?Q?A6r9D2sxU13B1Zq+Uvuh/sQ38sZfJoOKKs4VQeBDNi65y8M5RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RuZZAiLrb+aejb5y2B5WCq53zhAMovex+P19VhDIyZ2XWmaDK/B8tsDaqi0B?=
 =?us-ascii?Q?FR+r7uHHKxNipUPj0aXnDKcFFZgv7FV+bODEnpkKVN7hB/K7Np4gUM0BzA1L?=
 =?us-ascii?Q?glNoG/dwnerc2NLn1wUFlmbtIf3ONxxVrMYpMhDtVeG1hvNOXJPVBnOexTmA?=
 =?us-ascii?Q?hnbZQr2hc8YB5sd8Dxzoa3n4YcSypWoqEkoKYqgV/OKtnEx83oAHVa3laGJr?=
 =?us-ascii?Q?UXzzZiW530NRF4X0WMCqONrK7hjxWFT3Lgn1Z1CXapG0C39fiuASEZx4jNcI?=
 =?us-ascii?Q?MojvsRbpzpIIfO40/C9DwHTFDaZlGh2cEu2kluQcZ4E3ELc0CxPUl5cS6FQz?=
 =?us-ascii?Q?duBSWvG3S2iUxa0HXQ+13JzXJSd1grStjO8Lj1b03EC4kj6sKMYF3yXlWe6y?=
 =?us-ascii?Q?miqtvIstDCtGTJOyW7iN/7Xcmk7B1rERsKXLgGYcvsjFARP1LHifJNhRARy4?=
 =?us-ascii?Q?cIztDhZ7hBDORNP8yW3qN9IOIjPzM0rZYyWZ6lG3vSim/e3Yr4uNRNeViLtT?=
 =?us-ascii?Q?W/jeCjtkxsNX6pFSQmtRu6EBmowfHA/w000Y83hEX5/uWUYp1yFVesOGNSTh?=
 =?us-ascii?Q?9GrV7Mk8qs69qmJb2k9uRwLkVA5syE1Qep+y0m0THuuXJy1Bf1CSdlthzUAh?=
 =?us-ascii?Q?U6uaumB9vW1c0kPxNXZDO8KxNzy8YoHDJiYCcwbHPAugACzBjF0s3M0dYDp5?=
 =?us-ascii?Q?R2I1N+mT9QLq6kj0b7o8RbdDRmrOyT7lOJgzg+2efmF/Z16IfyYTsqZh3CFL?=
 =?us-ascii?Q?d51DAOJQkZMKsg3yxyqDj58+JgZCujrQF6mutVR/2F/UjqUF5rx3w0CvTCBd?=
 =?us-ascii?Q?SkZOWXfbpBNj8ukZRUmtS9HlHQqI4aWhpOhrQkE7lLTi78+jcG5Y9MVpr54e?=
 =?us-ascii?Q?L+WpwvRpZ44q6I/GFWDvxqR3xIgJBDWTzKwHUiCd1JbkE16yA20t1VhIYODg?=
 =?us-ascii?Q?Vq7I4vdRJHM53OtrT58u0aLY49zprxe89wN/etq+glQ8/wuajyPVNd8+cMNy?=
 =?us-ascii?Q?yS3Y50gqtAHT8i42tvImX187YiMz02+1YQF9scqLbEUE8UqD9ZJ79S4886UC?=
 =?us-ascii?Q?BzdSvvD6IXp/TtfManNvxo7nvh5LE+toWFw1zWT6QvddjvtFdmOOZ/CjTMkN?=
 =?us-ascii?Q?rDco2eE15V/IeVILqY3z5BbkD4zlSD+x7+ofFfnsJKREIlEL6Wn0JJ3GVe76?=
 =?us-ascii?Q?mJpTmhcVRGkdmMSwIvuMkbj81zrb4eEA/cH8TMmsJoXMKyx2rCt6vOWKoJXJ?=
 =?us-ascii?Q?iOth5VW4Vai3QuPgfZfADFhccsqDUVsd50/cRxIinEWk/wghOzY9VIeAMFT1?=
 =?us-ascii?Q?SS/l5AfeXWtJOHW9Cb5OVmpjvYyu/TWii7J2wID1z9Ruz9D4K4ImUuSn+QVT?=
 =?us-ascii?Q?m02ZFLye61uaj78fW/534T7XLTZ+4mZ/AwG3byBm8Z0ZXMufPL+rwpqn2ilt?=
 =?us-ascii?Q?eYqS0xs557uupWvyzastHsIwf5m1D1rs3Ee4aIg8Lm9F5u1lPzso3EjIUBMM?=
 =?us-ascii?Q?SYOGpvGUMrgzFfy4cC3HzzMV0UP13Ao+bDpIOl8INigeZ7ugXsEuPcXFlzMk?=
 =?us-ascii?Q?5GhaQf9lpBXu9BMBtX89Z2OxGt9CJrkyt1fhIO58?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4835169-1602-41a4-0a9e-08dddb120909
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 09:07:46.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sd9kumxewDAyLtISqkmWO+FWX28CfOs4vrI7CdrxofeTOuMxbSYe3W7zLaWbX+utdN3NIZ8E60/xLEcnWI2+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

On Thu, Aug 14, 2025 at 12:23:55PM +0800, Wang Liang wrote:
> Since commit 67b746f94ff3 ("net: bridge: mcast: make sure querier
> port/address updates are consistent"), the argument 'querier' is unused,
> just get rid of it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

