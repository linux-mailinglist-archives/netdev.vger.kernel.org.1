Return-Path: <netdev+bounces-215588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01428B2F5EE
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92A86035E4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554930EF8B;
	Thu, 21 Aug 2025 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ep5tfZVg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB530DD3D;
	Thu, 21 Aug 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774447; cv=fail; b=j2yg4H3ypzfulaIDMIBEKH7zEy+cuTcGJc7z+dw7lV14Osksce8g0sH+wsGvfkul/a2K8tdZZv9lX/qbrOqhznb4S87isdMXBZyAtoWwyaqnz2FagOzE2HWDkxHO5y6IcoBRMvmuLLYP1RHjqBdUfju+zMkATOSJqlNHRR2+aa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774447; c=relaxed/simple;
	bh=K2uy4VvN7zTUcqZhY7dOPRuydbyz+EcWFRj/DWQbSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eY8DfuyZiJVlqdYce/MSavM/BYoXnoFuVkxz5VxxEwEzSLGwe/LYnJSb13CRYn3UWerNKK9vsA9ol4m0qblQj9JuosnMmGN3MfpM5TR0rgM8J7FWKbbRhJSXQ9fZO0IfdBJVzM7zsxD09aZua33Us4/nDvuItcBZ1eEgIfnwq3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ep5tfZVg; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjwjrFOgJ+KfVxKSdemSHttGkv/HLg0B8QzghThVRg5fAnu8xP6f3lXZXW/ph3nQCX0WgNVJ7U0qliPGLB69g+5Qla8Vbt5w/Y5xQUhHsF98HAWcN2bAXsA5ADYUGjnqBbCLKc0ykik2GhkEcD8S0b26P0ylvGW4VM35Q9xpvR990gIulUuGGuTJBmZyg6xejmzcPGhKRX7J4eQrdyG2CYQper/4oXWRr9lp+q3HYKK3p/++9MCb8ZBk3QxHJgLXd49Eh9tv0wAwAksf33ehq1GKNA0fFbUNGgwUO6JShs87+6dNU+cW8ftpHdDgx56vsshNdsJi/5+JZpGiOZlCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgygFsCsJde5xjSdpM52NoWbRwxIAMIEAxlCYU+it1s=;
 b=l/nmBOHRssRs0nIfvEcvFpzJwUSTmIkS0ZScuEDP4D019/ESx4pYEAMK3/mY18x08BvXHTJhueAwKbODoXtRWU0vxH2J0JfOrInjTA3c54AbltKofnQ6F2WBSdcz/HxjjhMsDPYgfl5yGCOmuVFoZpIMfbUjqLxfxYi8fa9W3d2CnwXO72eDZmcsI9SQXFKtx1j2t5PeYMGNKd2kLAvzdIw7+ou3iyZ88lGHeYygce89smgPxV8t3jE1UyW4hZSfZEHj4NhcV05dYf69i1YvJi9GhKePLrPyW90nqtPQyaf6g7u/TQX+Nm1dFayuGTkvEbLuuSWcYJ7m6pPFU00lLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgygFsCsJde5xjSdpM52NoWbRwxIAMIEAxlCYU+it1s=;
 b=ep5tfZVgnBrVq8vCVyhVkY+1YsDRqGgU4hZRnotZ30vW3tXdTeyfSLRIC0qMiBE9n3MXLJS+OgfdGiQvhQu17shQzeBt7jOWgxdPYpyeqFzuIhym/8GuxBXzRLzMwMbAg7VveYxaYH22J7RiG1qRzKGNGM/LZniaawj6pocYKtA1wmdYwg54MVICunZZcD3QhKSTWhOQ8oxK+GFyG9jz4KmNdSN31KmVhkdm+jX3GPXFs4HlVnI3naVAnq3yGMb6nhDj2J/BQWMtEEmcMXH9+dMjvI18SohUAbjJ+CuWx1qmUKGw5iZPqaVQmDrfVFrQJqEy07J6F0za/xhFbBMNlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Thu, 21 Aug
 2025 11:07:21 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:07:21 +0000
Date: Thu, 21 Aug 2025 11:07:18 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	parav@nvidia.com, netdev@vger.kernel.org, sdf@meta.com, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/7] net: devmem: pre-read requested rx
 queues during bind
Message-ID: <bcj2oerynyc537fekpmvd63ei4ewtajo4ase4y4rp2hghiz4i2@weyhqp4itgez>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
 <20250820171214.3597901-8-dtatulea@nvidia.com>
 <20250820180904.698f1546@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820180904.698f1546@kernel.org>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: 41aa3c5f-7189-4fe4-e2ef-08dde0a2e6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jDnffFXlWzbGHMi3sxANMpfIfWclqHzIwwKzF1/SYsulReMs8BezDmxAHWy8?=
 =?us-ascii?Q?yF0VII44YmiTzwdz0aJhm8OhSOWiE8boMQeyeMI8AHQCJD69dDAu5ERQfPaw?=
 =?us-ascii?Q?r6a3IJQnNop/0+dPQMgylm+hrehH833Zsm8kOynhTm6wiZP+p0ZI1z/KyX9X?=
 =?us-ascii?Q?EV6iYb1lxIYSscALwDfjH8HglFUYZQF6n9+aSVNhdrgNIe+O9uSbiqCLEUBW?=
 =?us-ascii?Q?ask11pGzY7QpFWn/ZfUcpJPJ8VKQDyyfbAGuAg0spIfgkt12DZYPsD6QlmHr?=
 =?us-ascii?Q?U/anWGxGzSdxY2joqiuFuijEDNu1N63PQfgW61GNHz2giGIS+2hxvNvSzlaG?=
 =?us-ascii?Q?0mK2fwL222Ig6ScJloaJ6P451M/BIRqGTtdA00Q81WdolRLocgZYjLkCNWh6?=
 =?us-ascii?Q?kStqJMkVnbTvvyhydNx+K1CTMtGczJpAinlwNdEWVrK5eHro9wydjEyVa5GU?=
 =?us-ascii?Q?ZjlDBbqcgtxluKUjtf12OG2WiNtlp5zd4yfb3wcVoTXEeyv4FGt3amKiqY+A?=
 =?us-ascii?Q?uaJW93dY1VWP17y/OQgRc+rHagZO+9+rhaw5UHWJshADCKasHR/q6JmzsJEE?=
 =?us-ascii?Q?pUVVcqD3MfYN2F7Y6zgEQWyY/lM03cIb5dZDqeLOqHFhRjxEEYJPw0tm5q8N?=
 =?us-ascii?Q?oaL7pQKuqG+PSI/PEco3MotodSxrZxyrQVmZH34I4RkIg81olp5xyJYQrX0v?=
 =?us-ascii?Q?e8p+INrC8j3kTAgpOml/2egqLjCGf0cZ8Q6zF9ggDQ3fKupFxSvg78mbwNKj?=
 =?us-ascii?Q?km/R5m7L15M/oBOnbDeUw7Le0CcopMsg+o7f3jH0dXZLvV4v0eSWZ1yNaDn6?=
 =?us-ascii?Q?Cf4r+Ln6StT4gJKUNqWao63SIG0H+wEr3hPNl+TbQdIfQmCOTRKL0O0MIFED?=
 =?us-ascii?Q?i5CO/vaQooK//1BvsvALEUz1710ZmwlhSvl19LA9IOU7C0xoYS1IsnnNOpF7?=
 =?us-ascii?Q?iXdMwzQmb0aC+IXNAIoFztg7Rc5zE6PWd2o69VjtZaRlM4ZWmpKM5aTwVmhK?=
 =?us-ascii?Q?Qp2+oL9M37eJe1ccGcy9AcSaIUOTxnwfaica1t/qHo3WGBLNi9KGoEMqAmH6?=
 =?us-ascii?Q?CDdI6lnYZySNSN8xD4OI+YTtchQowK1epaVn8BEkblDiMO7f8XGNHl+3cBYG?=
 =?us-ascii?Q?evAOEzJqTTeRh+UeEWcAHWxRQfEDsyjnbmn2MmzTGfqolqbk6PCIXyfjkify?=
 =?us-ascii?Q?rLQP0/85mCKv4lr9DOCUKrJIbVB0P/i96ibEz44kuzYRE8fK2qyTys9cpKmg?=
 =?us-ascii?Q?51sQFq4Io1UB45zj+avZp443IMHh9/9QWnM6LWsSVXt1ixb24fUhce3f78eN?=
 =?us-ascii?Q?7MaZzWcicyu1o/nrxpLw1A7Nj/87HlDCrRqoxILVXh67SyY49F87Sp5KC7Nz?=
 =?us-ascii?Q?S6zz7YoMJh1ReFvsRIGXpak/r+tGevx6xZ7qc0WoR+5XvoWWNXclNgzG2TDE?=
 =?us-ascii?Q?cuyvmAQ0rGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfv/CgQOPGzxpPmobiiGPaP0Zo8UO8n8t6E9ajgQodhA+hh7+qJic2bNlEZm?=
 =?us-ascii?Q?+eMn+hJMWo0ow0axNxYauPJ0LBvFhmI7zT/OwxN9cvHnmI2XD1YNChwpsTFc?=
 =?us-ascii?Q?w4o6l2f/YUcA6vaehU7yZDS/V/Y7ixcMfrlmAq0ZR4JNRLO0UVzbBUb1HwL3?=
 =?us-ascii?Q?p8UtHxmgUNdvI4AL0xNFJ20Z7pWraUPhfNNU0MwdgUi7TXgO4fzrXj7fnI7s?=
 =?us-ascii?Q?c5ZS8D4GYyLCpq9BWut80MGjPon0vnWnEvK9UTCRsWd3IZHKyuK339K3aK2k?=
 =?us-ascii?Q?HMKsETtTbsT0agNNkTj+IjCZFwW57yVLi7nHOz8IHqj2TkXxcOh+Tn5cn26C?=
 =?us-ascii?Q?MQ/tkpp+dbtYJImr0L71OPsh9Vlrj23EyrhK4FKmIh+wzvr04bp+SF+wsZiJ?=
 =?us-ascii?Q?7up0Byb0xcIxGFVskGAiVlBxN3+UuI7hfDUbWHEE7AnTezOy+V1ne0HSVwrz?=
 =?us-ascii?Q?hNRKWl9JlRNKUz9iHabiOzUOjUOSzR7k+W1L14wfXbRHLG3JryjekJ/IXRyX?=
 =?us-ascii?Q?s/K9lxfaIio1+gfRp3HSO/294WbhwAbTBxOgf5odgVZLeRlypzB9lIaKaTQe?=
 =?us-ascii?Q?V7afahl8EUGkIq36en2B2KRasb3cgDalNQaEE+a63u+ZKFYbVXKn3/hVjrX+?=
 =?us-ascii?Q?rA8ee+C568kBFuSE/OxwxCrtQMsDJ33tiHnrgMnyoPH+GzA5FlXRe0A74gK6?=
 =?us-ascii?Q?hSWzEbgSm2/vcLmIq7TAkQ4T+qic9w6vSW+wbci4qDiy9qIl3o5WyfQr/lhf?=
 =?us-ascii?Q?K3ThG/z5Fu9KvIe8kywUXKqj21FiB/y7WNW6nIdajUxM+1B37rLeAuiYYGEy?=
 =?us-ascii?Q?KK0BXqSsGBFQ5eNA9NvBBc3m2/lUlosOk/edc8FAvlvqairOPajcD53EqfLg?=
 =?us-ascii?Q?iuGc/6jn88Xs/4/jk5tOC/G3MF1zB2Y3IDl8ytlvo3Nz+bkIS2ZZf2Q0hKmb?=
 =?us-ascii?Q?R9PU5p/+JpZfWDiA/5KgQhtdKdFBusq8QE+QsgdkVp6WmllnipZNFj1wRNeo?=
 =?us-ascii?Q?jZW0W6o9KvRt1c1m4P7VZK0mneE+KyYhCe0ZktufRB20mrsEAxtl+/Rtwrhg?=
 =?us-ascii?Q?JM2eptMNNskz0Wh+HEJ827ewcKuOyf/JEXl5ZkLw/zytN5psedwv7L5mxF00?=
 =?us-ascii?Q?lghrLLexx0xmrykqlJ66muCIRiqDSAnlusjObJb4k2s6OtF57vOqJyuUaI/9?=
 =?us-ascii?Q?vJ2mdKKumOVELaAgYeWxgv421jAs0OlZR/YbzNJ9QxAcOEG1ND7BqMgr7crr?=
 =?us-ascii?Q?ZUUJmb5t3CYZSm8Ye7WqARUHxMOtf2mAO8CjbGVBHqq4g11khGCaj+NBwIcT?=
 =?us-ascii?Q?7keqxcY+OQzaXD1BtbNeCQiRxaL0zs3JMJ4iByEaTh9eg7myqDFI8asgajNA?=
 =?us-ascii?Q?11QczZzfVox0/o6MVp+wiUGk+wb3MoRYnnWJqC4f192/LlseY7mYkNfQ+0xR?=
 =?us-ascii?Q?MDlJ+qTfN7hVH/QM1ZkRHZUHyDVuWJOYL480IL+99VtyiMlzeEROUp8euYBY?=
 =?us-ascii?Q?fi1Dwpzs/9bz2e3hCaf3NxYZ1F0PGqwERF54LcEUtgcsjEJ7iYVwfCwVmtCr?=
 =?us-ascii?Q?Ty8EHtrT284vHtBVIo41lSwmlsKiHyA13SidhzcB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41aa3c5f-7189-4fe4-e2ef-08dde0a2e6a8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:07:21.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4Yqw+x/yI1ZsewmDmoYnS8gtqLX10g8q4KZmeFPdoxx2GghYBoW1wuMxwKEKHeJs+gFAKUKVKpHNDkDGo6a9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225

On Wed, Aug 20, 2025 at 06:09:04PM -0700, Jakub Kicinski wrote:
> On Wed, 20 Aug 2025 20:11:57 +0300 Dragos Tatulea wrote:
> >  	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> > +	struct nlattr *attr;
> > +	int rem, err = 0;
> > +	u32 rxq_idx;
> > +
> > +	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> > +			       genlmsg_data(info->genlhdr),
> > +			       genlmsg_len(info->genlhdr), rem) {
> > +		err = nla_parse_nested(
> > +			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
> 
> While you're touching this line, could you perhaps clean up the line
> wrap? Save ARRAY_SIZE(netdev_queue_id_nl_policy) - 1 to a const and
> then:
> 
> 		err = nla_parse_nested(tb, maxtype, attr, 
> 				       netdev_queue_id_nl_policy, info->extack);
> 
> or some such.
Will clean up.

Thanks,
Dragos

