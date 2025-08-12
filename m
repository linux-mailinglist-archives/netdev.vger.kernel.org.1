Return-Path: <netdev+bounces-212775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C275B21E04
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829FB1881493
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800BF2DEA60;
	Tue, 12 Aug 2025 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADSGAvcH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE52D3A68;
	Tue, 12 Aug 2025 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979061; cv=fail; b=OYFB8xyuKFLlwZdo0u1fZo2vUwgRh7G5yiIBU3STKS+duQj4ETjNQ/jE2BQtvlgLF92PaQ8n6gMfX30C4ryasaeSr+siMOwRZZ38GTBLAp4gbrp/83ydna0uBM/4A6ilDwt2t//JIxmIsZ6DVZV2+ivjVJA3O9j8SNBtR16cdks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979061; c=relaxed/simple;
	bh=2x3LhJb6UsD6t79T0K1So6Iu4I59DjsmxEEs9zt8Jno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3ebL6XHnc/DH+BNhZ5Rbwqjda654AferpX+ErxGC1mlfUKo/VlvxDpU4JNXIgR8M16eyurVjdXAZZ7TCE+wGm9VjnkX+7hD447TmKGR1LwuOSTU0y6qtdp0eE8reoJzHdzdPOas38UJZckfwAKcsuEFT2dYL/z9OLFoUhpTMe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADSGAvcH; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKg7iDiV/wLO7qT4LQX0zB0sZYNAMwZcRP9Eo9yrLzGAHoK+U0+fpOMOArs2zZNJJOpIGeuSdfe9BfW+rrKVqxu+JjoGLvHrmPKuOF5ZRWKOfmSKs2FL86bO0t+jYPM1TRsDGQe3rS+OGD4Nyi3I5V6S7F7W+3OlJw3aEzPuuozOJIFkjBzEy0irz1UckXJe0ARtYYWU98Sc/3kW1yGWNgwgrfqFzV91z37UIhVQlNtGvOJUsF+1obtXmv2mxpE7IVmCvVlp0bsFoOsu2qJUZ3aV83w1T0/8MhFdSOSW70ldSiz3aZkonhfn1VM7MgqqHSFPBpddXLX+0JXbbIuQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daL3xJSSNUI97ihwpGYot53BGNk0VaqR9Ts9jnLRi0E=;
 b=bzDZmP6NWRpliP6anJnnXKPx+Q+U8avoEgjSlEB+B1g4TDYRDviFpbV+cugicQ20+0Q1VajTLVEHz11FmcGwfOP1sqmTU+rw9W1uSuUyterHPQlurrFdTRdYKZpCNPtf0D1l3Msu9+fKwKQmdVkwlJiHT7gtPUyVLLOZnk6vlBw37n/arSnr7mwlsI9iX9CBd7DKdnMl6vGDSR82FScQ7pKm1O6HQ6EMnfxcOd8/YVScsyM9IMAwmRV0y+CuQDCbFm/j03TlwzUIubt8mZki1ExzuyVbr106HJe8dX7idirk3ot1rvt84Pj/YX31C8Ui0e4OY9cHNSb6ypYDhlXWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daL3xJSSNUI97ihwpGYot53BGNk0VaqR9Ts9jnLRi0E=;
 b=ADSGAvcHZpXPAivLotheHjwHZKEhc0dheLNBthyo/Uk9tsnGzbW9rGl2HgKJLuF4yC3qte1uLX7gH1MfxI7vJhhEF1s/4UaOIo5cE16ADl1Ei4TrzcIovKywRdecAV/GDbzDDbp+Apd3qQMuUm6IX6IaCFyLPD9N9HhdyjBXmWLQ1wWetKdBj5UdosJxAPdmJ0Hl0M/5Z1z/Yc0TkX4dUel3aFDt5SmqaZkvtID1qK+CMCmQIggu9I0DX7elNkcHBfpaUJ39APEyEk0vFArX0OZTaA3zMGx7WZiINve5UbNHHqdewS5sEyF48CV03CgA5YUQv9LuZGL8j7ZsXI5S/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 06:10:56 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 06:10:56 +0000
Date: Tue, 12 Aug 2025 09:10:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2] net: bridge: fix soft lockup in
 br_multicast_query_expired()
Message-ID: <aJra548HB7zGcA6K@shredder>
References: <20250812091818.542238-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812091818.542238-1-wangliang74@huawei.com>
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: a542b16d-0d22-4f9e-d29e-08ddd9670010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ylcD8Tc1jFsknhPx4aG7VO8JqYkyfUJo0d0kewTL0iBamimaegx4FiwYL2hZ?=
 =?us-ascii?Q?nudvHjMW8GKFd9aZlW9tZDdCt+O86OhTmpIi313Ps8w5RqIoBvZOGZaGiXmQ?=
 =?us-ascii?Q?w1ySQp1x6/N+43jFjZj1FSi0JS2cDnyFSkwfmSUV+p/UYVtYfhkaE8ilzFOc?=
 =?us-ascii?Q?K/WIQfv2jmC5qDqBfQZBuRbc6GUlZ4yKxiskJIBp7jFcj7t+eCVyRzW/9PwY?=
 =?us-ascii?Q?70ONNekoLSWSZhtpjFGJCBR2dUqj8QxAOBUDHTjHtzbFPbbFaFq1ZRMygbGM?=
 =?us-ascii?Q?FIsl57jk5brdIbsb9RDVqxtxbwINFlnif5y3OPobQvu/TTqJdWApH9B6MIgA?=
 =?us-ascii?Q?YqLdGJBpSL5UFUa+wWoRw1W3KO0hdKoHaxChCOPEf+fmWsOsFRiX0rw/BA//?=
 =?us-ascii?Q?Fu2vNw6CLe+WEKUSXkkFmly/IEuvDq51mmdaje7d/5eXDFdaCTaryLLmtoSO?=
 =?us-ascii?Q?rE21xb/PCWMl9oZMZ7W3HG1IODnusOqTFawQbsDgCMXm6XxhiUpjUmS41JGQ?=
 =?us-ascii?Q?wJFxo1cXW7iNDncEuKGQNRi1Y1Ns1B5R9+FGUUdeIRPx/OXy77NH0PEGqg2j?=
 =?us-ascii?Q?BYdf1ospFqQYI0HXd8lIatKQBKf3Macdl9JrlrnZ6wubPwCTxYU9Meg7LEls?=
 =?us-ascii?Q?vBUhaTwE4/TRoPjmvwa6ys00ZM2okDNp4bGwzysqdzEVLP1/vCq8X6XbsaM9?=
 =?us-ascii?Q?g+K7EnXELJFShAfcGV0TIPerJR/V3T3A20bosbBMLzOnIsXbvTt2BnDcuW9H?=
 =?us-ascii?Q?RIKf3mICbSzsXCrf6cR2Qy2joYEISv1b9zKzZnrqohzuAPajYq3R8KiLjXgt?=
 =?us-ascii?Q?ITA/Ho1MV+g18IBN1zrBC3hMUwxTvyxjU+lPHMbIPAT6BzyHx6I4VWzfsjEa?=
 =?us-ascii?Q?keqf6XrI0z5jRijtpvmG05+K9jNGpd7VQ13s+YpO72o+qHM/hd2wr+orDyVB?=
 =?us-ascii?Q?D9Z4BL0mKwH/Kh+fQXKDvP2in6f6f1hhqIFQE1zBZLimZhamDbFYo5sDZ8eB?=
 =?us-ascii?Q?g/d+q3NjwyGUuEZHmgUC5oyjLtyyP5v1UU6xTeqrWiw6Vd+Tvf2bKwKlmdWd?=
 =?us-ascii?Q?6H9fRSP0jUK9/HMscAxLnR6oq0miBZ74GqfMXmmsChkWz3b0JDGsRYeFAAot?=
 =?us-ascii?Q?N4ZuWJnGhEVM+aKBUSkEWXUZOX0fRJyJLhCNaBKUC8qoLJwDOUBJ/QUKretr?=
 =?us-ascii?Q?+ZMs6TndS9QPXVm9wFl5nGoHv1WUHqCoYalEIOEDeSPNBjSOmhklh9SQ6TEk?=
 =?us-ascii?Q?vPHMlTbfZrL1LZF/gNSBf/PRB2mNCwwanpQ56pAIJ/bGCcwhms9j3R5/JDPA?=
 =?us-ascii?Q?pvhNpiamMKinnlBGRSaYgLJ/EUgmL0qmz/MEgfR6AX15zmIFy/4WakqkbtF8?=
 =?us-ascii?Q?TEmClChOtxxE6oeKy9ori4eImZTrH1L2A1bcheypeLq2HRxA3iG/XLcZogTT?=
 =?us-ascii?Q?DWrEaMddvgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNvQ8Xm6aTzanSRNUUeF+lF/uuJsxlSi/HOOOdyZtMafEdv3J/zvVwo14yCV?=
 =?us-ascii?Q?tSWS54xfw3IWVtfC71bx6fOU4WENFhvj6W/O34i+oz78Tsikw16+r+GzMJ9C?=
 =?us-ascii?Q?4ZrkcTgEhrN4/ZspfwfkLcSSnWmcmNR4QWgrgWZxt3iFVcWAk2gUr1F4eJkZ?=
 =?us-ascii?Q?o5/RgnSTbfP18X/r2NdecpArpc6JlpfQ+rTT9iwt1FE0Sjoe0vikW3+yd0ec?=
 =?us-ascii?Q?4N8ZUQ1sI1oMUe/8nfHdlMPrraJSS1Qy1GUdq0HAwsy24ErDv7gqs62jNYd/?=
 =?us-ascii?Q?AncMztR6rHVIctTSxH+78o6rE8JpoWX+h665sqKk4GvQ2chfmhhjZLfnWfut?=
 =?us-ascii?Q?mLIEhJgS5CFqYrjJ7yWP3trZyWGoacu7uohYUpZXCdnOxLF/H42jfQlRbPXF?=
 =?us-ascii?Q?PdPUXlw9iH/WdUJIDPxYFLLm8Cy8N3RqhuhkduiJbiUrgSwRsvn07zhgcuzr?=
 =?us-ascii?Q?ihX2ziYPPWb6l+Gs1jvSSgjh2hDdmS+WWjkrIHwXWUjkET/V0hZKZ/rQSR/y?=
 =?us-ascii?Q?8hAe+c1exjtvNzv0VWXeTSX+Khhv0hXoZ2Z00ehn6OPbpY45bOgcfHV4Z6ok?=
 =?us-ascii?Q?26qXOkN3dKa6kxzIgjVGTUN50saSt60EAE718WZphyPdgLYfX6GE6viebFN6?=
 =?us-ascii?Q?Fj95eS7bEGk/6EOH1XeBM5n75RPrkVT0CFoGT2gylMcDBMm5BEdrZUkTs35G?=
 =?us-ascii?Q?aTdCrOz7oZ+78HVqCjaO9kuqCltL494rocUWrfksWv6aEon7Z4rWOabKBsny?=
 =?us-ascii?Q?lQFWSKlCCpWRd/1oXCwhLtPgVJIdty/lCI312PhI1p+xJGVj54BJTaaEhEFx?=
 =?us-ascii?Q?w+IDXuQ3dPgfwVF58leJMT7P8kUJrpaRt1XQlNs7pwhtsS4qyMbaj4wWTrlS?=
 =?us-ascii?Q?HtWSDs5d4UEC9KuTXaF2dBSVYqC+M6WGjrAkBEwdkDwbdZ76YNZyQJpTUl28?=
 =?us-ascii?Q?3wYlw38z7e4EOB1EBg8Kng2Jct+raZlmB4radnJpg5Mk9o8G19LAV1w66gQA?=
 =?us-ascii?Q?5TJivInpfTX64ySk9Dc9z2nEGe5ltluCYT/ctmb7Kx1WSr9adbsYXfTJauZa?=
 =?us-ascii?Q?th3HTJtarBVR4wHpkVOHSqZCLAICm2BFjuiA5B6PS/9C9PEmCsPeq8lvTjJk?=
 =?us-ascii?Q?0Cy2ltLJzYN5YrD7MOv8YLD+S2D3xD+cpErcaIWdnz2dVFm7Ac//MUaNp+EG?=
 =?us-ascii?Q?L9vG5tzGURA0QIiSFL397C4+ExpatpL/Qa5yHn3RAwLzsyMBh25DKArz638x?=
 =?us-ascii?Q?MTZHSw72f2CzQPvbL2xdp+b39/CIypWMMGtRzpXr9Mvy9Jf2j/OqLhxJPl82?=
 =?us-ascii?Q?tgY5j6Y6TWb29mk5B+f2r8L3xdgQrhwYiZScJByTlwayt0G1zHVhDKSEpycT?=
 =?us-ascii?Q?dhO+Sjo2qbSIYUJXi6ciZq1123UJOujLQJ1qnVSBSxenYcofGBMoRokQs26m?=
 =?us-ascii?Q?HKiE/V6kDIaVivWLhlQlkJaXupLTELU9u24J/U/3UacSmXznasrOJyspki6P?=
 =?us-ascii?Q?Of/AyGRaVhEjvwZT++6I+tOsxz8bwHxlT97AsSQPZeIGdfBY2QUw2wxIo/0Y?=
 =?us-ascii?Q?+AzDNYuRVrPdenyDlQbkeD3UjWoFH1SfCTsd335m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a542b16d-0d22-4f9e-d29e-08ddd9670010
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:10:56.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHNnsBhs5/sCitok/BVkADWqyHX6oKGC1Sdi9mvfxCmoZVRvL9VPDTaA3tH0rdyO0/V2Gh1frtqSMmF8uIJatQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261

On Tue, Aug 12, 2025 at 05:18:18PM +0800, Wang Liang wrote:
> When set multicast_query_interval to a large value, the local variable
> 'time' in br_multicast_send_query() may overflow. If the time is smaller
> than jiffies, the timer will expire immediately, and then call mod_timer()
> again, which creates a loop and may trigger the following soft lockup
> issue.
> 
>   watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>   CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>   Call Trace:
>    <IRQ>
>    __netdev_alloc_skb+0x2e/0x3a0
>    br_ip6_multicast_alloc_query+0x212/0x1b70
>    __br_multicast_send_query+0x376/0xac0
>    br_multicast_send_query+0x299/0x510
>    br_multicast_query_expired.constprop.0+0x16d/0x1b0
>    call_timer_fn+0x3b/0x2a0
>    __run_timers+0x619/0x950
>    run_timer_softirq+0x11c/0x220
>    handle_softirqs+0x18e/0x560
>    __irq_exit_rcu+0x158/0x1a0
>    sysvec_apic_timer_interrupt+0x76/0x90
>    </IRQ>
> 
> This issue can be reproduced with:
>   ip link add br0 type bridge
>   echo 1 > /sys/class/net/br0/bridge/multicast_querier
>   echo 0xffffffffffffffff >
>   	/sys/class/net/br0/bridge/multicast_query_interval
>   ip link set dev br0 up
> 
> The multicast_startup_query_interval can also cause this issue. Similar to
> the commit 99b40610956a("net: bridge: mcast: add and enforce query interval
                         ^ missing space

> minimum"), add check for the query interval maximum to fix this issue.
> 
> Link: https://lore.kernel.org/netdev/20250806094941.1285944-1-wangliang74@huawei.com/
> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")

Probably doesn't matter in practice given how old both commits are, but
I think you should blame d902eee43f19 ("bridge: Add multicast
count/interval sysfs entries") instead. The commit message also uses the
sysfs path and not the netlink one.

> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Code looks fine to me.

