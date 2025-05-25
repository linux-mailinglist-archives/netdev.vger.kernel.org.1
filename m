Return-Path: <netdev+bounces-193274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9BAC35E8
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB104170012
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F57220F55;
	Sun, 25 May 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PHBDRTLK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84768221721;
	Sun, 25 May 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193620; cv=fail; b=FYp+7fBsNMtKi5vODhKN/1wFeInPaGSeJPzZYYFutp2zU0u/zZ4agYnMIXTWXczsKx/undMgXsPoIkssdXcbicg6ItRyJpzTEo96jXRnCmh9JnVZptINGeNNhWgQ77svBnWc8FQclzx9CCfO9t+Xf/HB4/k7na4Tz3qXMiwcrc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193620; c=relaxed/simple;
	bh=curVRvaDGfKprac41LuoJsfWBr7J65QfIl23QEUACFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UoVCrwIj6Au6K7sHn8jGxHVvJygWKNjrcsg/qjqCy53wc5D4JDoQftrK9OMSjXD0ytlYf3MaPBqob8qGTZSvP7/iqoOqjwJjVRqFjd6IitQ5Y2YgiLLFOaXqxyT13NL6MOEMDU6HtUL2y6A2UX674tTgRHGIzzsmN7kYc2E2BQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PHBDRTLK reason="signature verification failed"; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHI6jTtsRXJUiiuUjWuNIkDNpmQq5nMsxgrhHzZ+3WABosSn2p1WAQ29i0IPzB2XozFIs+Bv2Vqvdw6nKWpkPKG5zAmghNjo8dC9LkzGFU9ppYvxpcQi/yRiHIX/c366EdyZCHuwXOGwH5MdslMgCznzLgAu//4FaRxbf/KPVj3sShwCJ+fb7puwHaIHw9dML8ii9pPmGzC0sh0pH6Ev8X/Now6koycvNQhudzMynIRdh1mD/j9tAtB8QzxSHe7LyEXnW+UAifE4m8E6KIKtz5YV3yJSBGV6lbcxJ/pHRqMKLSnXINvWg+8Ky9WHC1bcNNTgpIyIYj/rlekPob91eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6CWDgu6CEfFZeBQk79inmzm9IakAHhNfOVtd9dkjc8=;
 b=BPNfcNl+i6JpsnApVIKkW3sv/a+ola7nv251AVtdvq5IZ4htpNs+2r0fAjJlKMmdvYYk8bKFflkdX1dNs+B9LLgq0E2yjk2SczW1dX1EoAxZqAnOcMSb6RdB3NxojShnj6XzDqppFQjuxY02PDDJCskUWPZxy+S5FcwY5FHjd46//haarrettdHf/uJX1LrXwIrBEucoi3N4hW+/7sxOjDSmGyrmvsbO4nqC8VjDgOGtRUfhjiC00TeM+llyEcHHt6aoFea6iq8d5DJc5x5/1DMTyRYNuwTtFwtlGnvVvydDOfHCQk5TtYYKQbW6+F081fse26XdgtSO7iMgOOP9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6CWDgu6CEfFZeBQk79inmzm9IakAHhNfOVtd9dkjc8=;
 b=PHBDRTLK8yclxZpt3E8Cyut43zVlgFmXP7UVIB7uYylgDgcWM0fd5LHr7135fv48YGazTY9ZGQz+IjzVCKONgUcBjRsOyLPQkhuXUK4gnOSGhane+8kIHwTggqYTKcs54beSLdD9i1km8O8LzZfw0q3ruRBUJwjoFR2Bn7uQQFrD9FqRSYcRKWdXcnmpWlV7cIvQLBdNhgFzGEDBz659SAVJM3kRRjcQbHB69RH2zU2ZoSAiY2Qn1oqDpDMryjiCE4ZEI7f1liifWK0crNv1uBq4W10I6KDohsjXT4hwKaf84fW+nKtOVHZxZVKAmZN1yRQFDmZXM/BR6W6G0AuECQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sun, 25 May
 2025 17:20:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8769.019; Sun, 25 May 2025
 17:20:15 +0000
Date: Sun, 25 May 2025 20:20:05 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next 2/5] net: bridge: mcast: export ip{4,6}_active
 state to netlink
Message-ID: <aDNRRReO3SufLNkb@shredder>
References: <20250522195952.29265-1-linus.luessing@c0d3.blue>
 <20250522195952.29265-3-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522195952.29265-3-linus.luessing@c0d3.blue>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e29034-e2d5-4e6e-8c48-08dd9bb06a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?R1BaLxYFXkIV6QJcEqwxmMnDgmsG2SziofEG3agYYwZWHHQEIlFGiVXirn?=
 =?iso-8859-1?Q?9FMv4iQ4QsHmN1Zyqh3+51WtEq+kiD9b1YizOO2v5iUQTLiVUkUkFJ6sRA?=
 =?iso-8859-1?Q?c5sp8/fwhTJPB3RzeEIopjTVfaaV+jOcll1vYBW3RPsTk/ccXcK3X6LQBM?=
 =?iso-8859-1?Q?eA0eK052+LXHhxT6cplg2/FQtGzPcFFU7LMuJeMfgP3K5KHKW+ms3rJPcA?=
 =?iso-8859-1?Q?I5UaeAzoDQX1je7qGBFSaLenrRyZmTsOQ1TOEruskQf4qx+4RvMBzmlKRb?=
 =?iso-8859-1?Q?1PV0ZPHp2HMncywhU9kJzaV1Ryb1oEdS4U/2x1+HUdxHcSLLHnutlk5WLS?=
 =?iso-8859-1?Q?7qrW8dIuOruY3TrrDjlvx3OZLa1L5PeHuZCy2JmZ4GXvwKdlfEuzR9AIKr?=
 =?iso-8859-1?Q?u5dFVk39D7dB4HlLiPN5ydKnPpvTi/GX208wfcfHXaQdUBLufMO2v/t3p8?=
 =?iso-8859-1?Q?WIdfyV40lnGQpm1rxDHFdTuJculX/rq2uowoeIQVM3VnwlqmVzf/nVBTBN?=
 =?iso-8859-1?Q?L1WH/JdQ1l/yEaNpu3CXcFFZraI/MI6k8mgHad8k3j7rOsJgZO2cFPKyoR?=
 =?iso-8859-1?Q?lVzdi49u1PypaSk7Mq2bSxoPAWR4Y27J3fKUili0LvtyMn5gjzUUMrtCqf?=
 =?iso-8859-1?Q?OKkc+Sbf+p/ZKZ0RG7RU9Nwu6m+rrXEx4+1FM9VmtCuUjBxSMKYa/CO4kQ?=
 =?iso-8859-1?Q?LCTwjw5S+eVcmkGFGlYIU88NjA1jwQHdxEEdVtd4FuWJSACOwSL+BA1eKW?=
 =?iso-8859-1?Q?h75F3l1bUU/sld4yA1b70l9LkGhbrK3w4ps7VyyLgKF8dWdJu+AFpn1B5Z?=
 =?iso-8859-1?Q?kqKokKw0v86MmbLnowLngpLB080y35QXUpwb+aH9QkwfhUs0ZzbtsTOjeq?=
 =?iso-8859-1?Q?DtKCtkH5ngBp+zaG/wQ/DlDGGfSZH7j4l61V6k4D+j13vnRkY+kfo34Nfl?=
 =?iso-8859-1?Q?Il+gyJqy0g+rqzFp2cjc/GOCwA95tQ/Xgdz73CPVQ3moIMPm+y1JqZvqNU?=
 =?iso-8859-1?Q?7d59KrjrsCpg53WEJTYGJFUjlYNCswr0ekrt+R2lMp+YddQqtDQ4g4zXWc?=
 =?iso-8859-1?Q?Gb9KFYVnku8TxOtVehb2cgAUoinaf7P2TktNazCrLf1ZyizxKkUoHu144Q?=
 =?iso-8859-1?Q?06dXsEtTFspA4TeZkAzgXyPXkUu+LVuPLPuPPbV8zSVdi89THJlu9ctO6a?=
 =?iso-8859-1?Q?hDyIX4M8Fa8ZhQTPlUCEABu/OpkAOlTmNL15/nsl1c00Ps3Xkstl0HJHY0?=
 =?iso-8859-1?Q?sTvqizhVSoro/GRWZnG/zHatVxAV7cKGQbMwAvfKDjuD/jZCNvkBBn9N4Z?=
 =?iso-8859-1?Q?CLddHl6WG8UYrCtXlWNZZS9lex/KS52Xzvba5Pbxx1yIHaX/cnwjSs4gNs?=
 =?iso-8859-1?Q?wAYrfOSZel40OlUm1CBqAEcP1MlHDVIlgeBxMjcPTK6fgxXkS7arY6KdD8?=
 =?iso-8859-1?Q?2XUDZTZtpep9MPxYD5+KhQ08nMq+hZrDQ89/m94G8eOlVyDYxBDloPMOSH?=
 =?iso-8859-1?Q?g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?KOMgOK2Te60UjrDu/IuVouVqaKJU+xdecFRJTnqHJL/q6eXq+xsK17tBTO?=
 =?iso-8859-1?Q?AyZYPsi52hArRDe9YRWYH9q05/zgclQ4EONF6gotwcsGI79iwZrqdV7dty?=
 =?iso-8859-1?Q?3pNUXFTlUjDN9JNTu+tAbUZ/hNzM0ZpsgmOsYgiJFr8A57CO4jlVPylDdN?=
 =?iso-8859-1?Q?SDrKQknvmo+DJjm8nCwfHQMS2lAjJYIIUVlpVSgvBphqGRfZHTB3xWjzzo?=
 =?iso-8859-1?Q?S32reiYSaPAprdeJxtVWi/74kjT5gWIZZCd1T1LVZr3RZ2p0hBfYveYwAc?=
 =?iso-8859-1?Q?fEdQUEd49CFnbShpOXKB43TyzCXl1gXM+UQryu/nm0N+c1aftwUqvkE7lT?=
 =?iso-8859-1?Q?yCFoIEoFpteOvBInpLNHf58VpUZUkkMFQAXiTuvQ1Fh9nGXrRR2hhbqJqM?=
 =?iso-8859-1?Q?aP6u8HxY9VA9ZAAAqhQteYveC/1tN0tqHFMZIo0O+cjWQJDUlgfK23M2b2?=
 =?iso-8859-1?Q?e1yKLQM7UV+n8e3oeM7NlzejazOdHVk1+ZJZYYF+JvWt7dAg7E4dyQho/r?=
 =?iso-8859-1?Q?YtCqawMch+UuJVar5r/pddK/kaGoZgHXTPyhR8sQUBH0viqdJs/RYvCxJ3?=
 =?iso-8859-1?Q?T5qTF+c5FSMWQtIby+MLoyrsT1pcK/t5i8htqgFMXuQb/5dZjOmIFVwAdx?=
 =?iso-8859-1?Q?w2RD5dBzLIsLvOmL8iRTtHdcm8XH5VSYSySD7c7/zfQonGaOO/PT0Q8iU/?=
 =?iso-8859-1?Q?6Lo5KI7SOyJs9cFo3NiTwo2aBXI4AKomOzEyXQZA+tU+hU3h+ZcAUX5Upy?=
 =?iso-8859-1?Q?FL/C7200NWPZNk3CzStRD0HZiWnkXzPVPvcX0NW0MHCppStgnj+QJI5VxK?=
 =?iso-8859-1?Q?6v2pXIuOy1IYDQAAEdUZuk0J9MV98Se4y3MUS1WtE4HMyz1khx0yaT2Duv?=
 =?iso-8859-1?Q?wsZgKRiPVg/gEgZ0JNtmyqgVtpHdEvPMZLLUmB9ztYsnbKQiAXHcpSSSu+?=
 =?iso-8859-1?Q?kmXz1b8xdiR6tYFp7URaB911OKoM59DM4QD/gKIbdHl+rIotmlWB070sZ1?=
 =?iso-8859-1?Q?swzwzfCl977x+KW8VZq64n4DY1Rz/Ei8CxVRbvC4OuSyl1uPu0VtV/xXMu?=
 =?iso-8859-1?Q?IMug5E8a9jaYMN3mp2pyHXNPbSBlfJuc3+o0WFhrcJpS/BTfZGipYPKApv?=
 =?iso-8859-1?Q?HfkD8PT8WHWROYi0L9H39LETjzDFqbo8ekpViQQpUZYuZxYcuLXQs0lIeD?=
 =?iso-8859-1?Q?dedwvQ8TNdbm2OWs5BuvBnxiuwSZAz6cKxntJUW0M7PkGnqGs4su9Yi3xR?=
 =?iso-8859-1?Q?JROrzVHJJtnU5ZGoKyF1O0sD7pyuBgerXkRM2wnTZt8hP4wrRl0qkZ830K?=
 =?iso-8859-1?Q?Sn7Vcs0a1IBswdLE0XvILDsxz2FZB7mon/WMp+hx6nTXq+6QWsJTSHdEVF?=
 =?iso-8859-1?Q?NS+EWUHnqaWL+FkVHsJbMAlez25bPsayiB114ZHDwILgtHrGzumYqRMKIU?=
 =?iso-8859-1?Q?6GsYKdpEnXyxrdFtT+JfoVcGL58zAzhhw60cPUB88xOeP4+zDNO8pAdw3F?=
 =?iso-8859-1?Q?uvkm/D0n3UqoaxSvu7UzXkO+qHew7hRcMP4+u5ZQTZB79o1vc+XiHWbUcL?=
 =?iso-8859-1?Q?nW5gGE7CmKZZkGHEjORuqq/XnTKg2BfJ6XVXtQNcsrpbkVlGPGu0f5jrWO?=
 =?iso-8859-1?Q?KIP+MnnYg0mc25pYaFuSCst3zqPdf+8iIL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e29034-e2d5-4e6e-8c48-08dd9bb06a28
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:20:15.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vIqQC1bFZYrCI3LtCtQuNcPLBpo2sGvmBdkFJjSZm9rPHVMSN4ohIgHUBKBw0Dr1jvCvwY7fHgJfO7X7UfVHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909

On Thu, May 22, 2025 at 09:17:04PM +0200, Linus Lüssing wrote:
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 318386cc5b0d..41f6c461ab32 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -742,6 +742,16 @@ enum in6_addr_gen_mode {
>   * @IFLA_BR_FDB_MAX_LEARNED
>   *   Set the number of max dynamically learned FDB entries for the current
>   *   bridge.
> + *
> + * @IFLA_BR_MCAST_ACTIVE_V4
> + *   Bridge IPv4 mcast active state, read only.
> + *
> + *   1 if an IGMP querier is present, 0 otherwise.
> + *
> + * @IFLA_BR_MCAST_ACTIVE_V6
> + *   Bridge IPv4 mcast active state, read only.
> + *
> + *   1 if an MLD querier is present, 0 otherwise.
>   */

[...]

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 6e337937d0d7..7829d2842851 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1264,7 +1264,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>  	[IFLA_BR_VLAN_STATS_ENABLED] = { .type = NLA_U8 },
>  	[IFLA_BR_MCAST_STATS_ENABLED] = { .type = NLA_U8 },
>  	[IFLA_BR_MCAST_IGMP_VERSION] = { .type = NLA_U8 },
> +	[IFLA_BR_MCAST_ACTIVE_V4] = { .type = NLA_U8 },
>  	[IFLA_BR_MCAST_MLD_VERSION] = { .type = NLA_U8 },
> +	[IFLA_BR_MCAST_ACTIVE_V6] = { .type = NLA_U8 },

The new attributes should be set to 'NLA_REJECT' if they are meant to be
read only. They can also be removed from the policy, but being explicit
and using 'NLA_REJECT' is better IMO.

