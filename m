Return-Path: <netdev+bounces-213186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2383B2408D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04A3166210
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECDF4FA;
	Wed, 13 Aug 2025 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umHOP1sI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65C21C160;
	Wed, 13 Aug 2025 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064111; cv=fail; b=GXuHsz6vaPGg8d7UsEw62hAWHMTkHGv9uQ2JFW5aZN58FO8Lvp/ZZslsx2UZMpch3a4o6PlJZSuecnaITE2BLJy2B9OUva91XMy1YrBdgyVgZelbYzJA1CeBv2GOZ22/F/SX1nRvV9Tq1bqMV6P5frpip8bpj3MZyXgS7MfDbp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064111; c=relaxed/simple;
	bh=uoMo2W8tlB7sz1QceEj8Ga2PTbXWkYBu9kRyIt+bsYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ij4edE9PaAz3tEzQ2HUeossU9KD7hZVzCnY+GavVCKYkE8aLPXjHlMzKiEw22bkfN7dl9uf5WGpPntJMQdZZ4dPVUe9DshE/tg1NXPmHR8nvaBxRbefk+BPke3nnS+RGPJzd/nQFpUoqZ9RrAAjvsI78sY/TcLf36K+GIfja8os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umHOP1sI; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9p+g3+q2yIqJ6VfuP3Kmnw3DgmbkJUKGv5UrnO9RuuCvIE/7BjAmCYTECGi1KwH+0fzEOGE2jTkdTWtuBQwkIRPrURGUDXt/6oyJgz9hZyHSjwiMMvQoihtLxHisiSA7KAwBnObJuv+RcQE/Wqamzn6p7xsUmNJZDJbGY8Pcj+nLiQ6N8UtDlObHRRJshEh1KOFZuQJr9zuhdiVJKdbE/mtytPUFl8UB2+JIUo9Dgvf1ZqvWjQW1kbmLO9/wkQHnlq4LjcO6/08NNlIU+Jg2VBVUYI3Wy2t3a4x0ZxSSh/aYDEblB/zy6nwidZDCnouXRKCZmnc2ZgzDK92Riv+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PQOWYiSWBQarQc0FSgrB+ib/HnQRYYgGhcsm12vwl8=;
 b=PHZC3Iex7If88/E/KFekv9qX8SFILuuuD67fBUupRpeXdXoK0wZnKc8IK5yhmd+3wp0K0WQ/q9lvPUnR9gmBLA/1vpWck1JfjbvteKp/FzbWkzv6JCPXycvsBcZSkj/6Tk0GX9x3Ywfhz1sPB8oM1ZeKGySuZI8u+gJfxEAgJuGerZFSygTdrGKNhpcE7BGxzKN8qUBj1xfP0qIM/xb1THGUOEaXnNSmkn3zo6sl1JbNzZ8KtvoAeWb+xyAsPsyggz1PHZLIrJkMPRKUXNxi1jrhV9czdKo2j7wDjbFQPytvshUfEhztfKObjj4jSLwMLMO8b6Iwoafq+AT5bvHkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PQOWYiSWBQarQc0FSgrB+ib/HnQRYYgGhcsm12vwl8=;
 b=umHOP1sISXJ/lu14YwF89+FO1Hud7IXdiXsPA0ajEgjby/cz/lp+9JX2KVI+4IdummCmcFTWP2wjocdWv4TgcjmQ1hnDk7l4w96wGOHddr+1e7JOyYfTHG3LYUi6M7W9+8RhcFmTf8QrygPAfPyj/ppD0WdOIHe7NQSUEaPwT9UuBVtxfCVGFHYQ9cxPtbIsUrb5TzHeO163TemBfVhn5YnWUDXMt+WviRb/fHHSQoABNBNDf7YgIVWnWI7CeOyl0CAzld5uhzNxUlZXr82Td9SbY9AZOEd+4EVaV/GLKMGLlnFo+Z5fc6plzWme4+YwtCm8iiNP1I++aB//W8rXdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 05:48:27 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 05:48:27 +0000
Date: Wed, 13 Aug 2025 08:48:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v3] net: bridge: fix soft lockup in
 br_multicast_query_expired()
Message-ID: <aJwnHqkv8TYQIpzt@shredder>
References: <20250813021054.1643649-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813021054.1643649-1-wangliang74@huawei.com>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e169c51-fd55-4946-1356-08ddda2d0640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YmkMj1rHCGyV7rxdlYToDuzxBKnToxsUk/FOTww1XKGKP0NGOMdPFM23rKHz?=
 =?us-ascii?Q?v9/y4Qf6XtAtFkNaDLD+dhNdEgGbLNmrlMxa2Cx6Fpe8ZhnrHH/lTkw/aze0?=
 =?us-ascii?Q?KeLRmJIwsBBE77maYK5tTa/+GvBU6y/mp+cJ3XfQdAbj860F2L2Yf9OF3/8Y?=
 =?us-ascii?Q?sinqmMAsQ4kJ5SF56OtHP5qET8ps41xpUavvS76/RbbM3AXJYKS9iW6SUHUE?=
 =?us-ascii?Q?3IZ9Ice49KbNxIqAVu6/1MCAqT5eV7Mv3COnsZT3GbRzyib7n0rOl2drRBju?=
 =?us-ascii?Q?xJRhaf3SghUHYgX45GkLPfUhPm+thfpKvmcRXreQAVmw4p+kV009iD7V9Uxi?=
 =?us-ascii?Q?ICfx1HJhczsL+IKoswbbacHVY2UGzm6Icko+uNaV4ueQGDCf/SfNWBqMcOIH?=
 =?us-ascii?Q?OJmbYwr25+AeOxdFAU0boww61BA9MNAGS7O9z+W2Up8GCHSiXps6m20abDx9?=
 =?us-ascii?Q?2UPaj1XiKXbMtFccxtRe5dW0h2d+nPMIgSCJSslw+KcZINxxPesvX2F6/iZX?=
 =?us-ascii?Q?fond/9oukWzj73YP4rZCSrTwwW0rPYd01Txt+F2wpP+3VuoTglXMEOMMSygM?=
 =?us-ascii?Q?stuz9gC+75vMjDRoEGty5qVdoI0M0pSpiimCe8K/knGMxWphZzYomBWdXa0c?=
 =?us-ascii?Q?M/wJMw8sakFqqd7z46LNFCb6VL/Ih8NBLz/FYgfh4vIO2bElutTTRcmuEnQs?=
 =?us-ascii?Q?JHh2WV5pbVl3hHXHlFuDSt4bSvDnfqws/LkkhE3pSCoKX0HsUXJgtEK5Mc/3?=
 =?us-ascii?Q?9WVrznTSrvKoH/suUE729GgW1yg9xY1wcolRBgTs43oj7pxhYTZytWK0TQEJ?=
 =?us-ascii?Q?wVT2M5lBN4MKp25W+/pASZPZ9AVohd4qrcniVaXPDRSGe437z5gq6KVZvgAd?=
 =?us-ascii?Q?1azNTCrrJDjNxXXRph9aetZejuUjvvVN7jKhaGrI9hKLZjPuMo+nOphx6+ba?=
 =?us-ascii?Q?QfZzGrNTMQufznai173xS/zDMUY9tpRbPnh3ZltAqG+RyZQUsQiMHG6oAhpy?=
 =?us-ascii?Q?Wss8VHbFfdSMkGhRVpVQeuqHaIRFDSlRw6C/BqT1+BQVw9MN/vtc0sNdTJvy?=
 =?us-ascii?Q?6H7tUf3xDvbwVgXAhIDoEpSl0mHQDa5TkXBuATaR4MtLpOsRnpiQQ8Iq5D7h?=
 =?us-ascii?Q?1lMoHGC6J+ibp81FVj8p5ZBEmsh1Gai/6LWaPPiRgbue+CbIq/ekb7P2GOVu?=
 =?us-ascii?Q?2JKpPvPGXpOxcDWQF81kt8PdgmXiwk8f8ekmynXJLZ80po3J8B48Le6Zr2Jc?=
 =?us-ascii?Q?x7DjFUg0HJWJOUChv6reBQ55sLhHjN6D6/MdEsfPVchHzhV2eKvmKODgzGPR?=
 =?us-ascii?Q?5kbktBp1P4Z/b24+K5LzSzIEBsH1C1IjZG0HnspyOyrT856rnc7b6hvO93Vi?=
 =?us-ascii?Q?rpTJd5z8kEbBiP7kAhaJdAoTnfFDM2DyvZ9HZgkPl55Z3nvJw7W7uxNjUx0M?=
 =?us-ascii?Q?tEz3g2ZO9Yw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kozlWys1KTjmLZQyUAp/4+85VLio7ktyR2xwRG49v6fRoO56XjV29sJ2X3PU?=
 =?us-ascii?Q?I3UIoqFebE/bFjHLhC14zbte5DgdWAi0swAtPBkeafPLMmLf+WohftpnaUQc?=
 =?us-ascii?Q?zSSOl08wjcGLkWME0qXOl4CssBi1AQzLWRH7X5ZtaJJ0QA6+e0OV8jn1HIuh?=
 =?us-ascii?Q?w4cOcNI5JlLvofAILIkQcvQjdlmkPR5roOUUuBYLMlswU0KFLKkEK45HUik4?=
 =?us-ascii?Q?2NQjKL/4K+K66jChjZPU/7Sx/UNkkYOj8hjvY01WiY9zOQJvA23sK/YfjGXQ?=
 =?us-ascii?Q?K9BMc/mAOq148eFFyK5f/nqMOcRheR/Xxpmrx9kk+stEBnSX2AdP0zDFlX1c?=
 =?us-ascii?Q?AT/PCELe1QpZVnuyrPiwFBJ0fDHBj+sa7VpcuUFDGu5YiGrsiB8080aQRIAC?=
 =?us-ascii?Q?xhCrWo7JEUaMy9MJjEz01dAvLNjY73a7n8j78b2Eq765IItQmEO2cEr7H0CZ?=
 =?us-ascii?Q?bKp11KEtkhhasYKSnkdHplydfn53FQZDd4HRkrl9s+swu1iVm/CpkOSPOaxv?=
 =?us-ascii?Q?RckPsJvqOWZNcXrJW+SYN/oEAUKUWL+HA9NXLCGyNy25sFEHzvXjk7wABD5Z?=
 =?us-ascii?Q?M+IvPlpPqSHhf9O293sPKaUmHreifeSNMnqtGe+PL68zFs7Kd39mCsJ9ZRG0?=
 =?us-ascii?Q?cxrpjh6L6+x6fdzmyZaaCu8fMWvHl9Z4fJKlypz8ecGJ9qybeHNG8b8uI2Kh?=
 =?us-ascii?Q?S79tU08e+pNCfSaJfKbuUEpKupyCKO/k7Mp9skqgmtq8dVrEaz4ta8IWuII7?=
 =?us-ascii?Q?iLGCn7mdHxMrVjZnktL8eU6BkndWMPwu1N0ekzu8S8VuLW8wLgltkxeeG0Jc?=
 =?us-ascii?Q?hJHmSOk0Urc7pWTlbpZNRRHmAGlt/abzCd0Z0Sg8GxhZLtWzke0/AwD9CU7V?=
 =?us-ascii?Q?IvcpYasCwtBm5Xw9tjF7Jdl0r46H5XbGWCV1sN/O++clb2nZhldDnPHBaQ8W?=
 =?us-ascii?Q?oWIVEvOojVNF1AX5GffOhoOyN7u229tq6xYOf1U6Q5zoCnKabkJOhWt3oxh+?=
 =?us-ascii?Q?49thFDuBzxmST1qK6FsZVq1Hne+8TUl6DpK4u/tSbpSdK9dLYoqSFobIgjmr?=
 =?us-ascii?Q?G5hEj6yETw5l4Bg8F4enO8+C4Ot7C/rrpWnzZgQnGroXqjtnPAIl4FhTroz3?=
 =?us-ascii?Q?pdVq+4Z5dGyOU/QJ4ObtOwMoHRnXL3Lrtd54Sv6YzLZv28DbxAb1BBZKGxS/?=
 =?us-ascii?Q?WEuyzZmfox77aXqXLB8JnTGy9uDtTW6G8b3afflzFijqQVVdFvs4vEkYM42m?=
 =?us-ascii?Q?WMQAYP69zJyvbwBKmL8dFD+m6SK7m/5q89Lqnu9x5mpvtkM4kMo9s2C/LtiG?=
 =?us-ascii?Q?YlUsY0ft8iyYj9CdWKOlsfPKTo3Ai8/ord41PRH2cZdw0kVH8kZe+OAeo33d?=
 =?us-ascii?Q?yDDeZ9vgLac7aLY2oQGCKDUyYRsuM87MCkaqI5ZufHDfqHKbaYH+f0DItNep?=
 =?us-ascii?Q?bkTqED792JWjsTGKE4BmHMhOjqNzfIZCgzBvcE0WQK2MhurFtc2H+Y59M9gq?=
 =?us-ascii?Q?YeZD32RwwqMMVWPRFFWHF4UHdRZHUnHPIGWYdi5LLWIWYMIhLlCqo8y3gv98?=
 =?us-ascii?Q?nqNGauzgReksbSyqItrebr5CEwWmuF0bG6R91E/Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e169c51-fd55-4946-1356-08ddda2d0640
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:48:27.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5BA0oIdhZp6l/Qvr+QDTUHWaeFRlFlkBgNHVADuDS884LwHWpj6RXtxBmprKhbHfxEFWzkDeNxRTrUs8VelVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784

On Wed, Aug 13, 2025 at 10:10:54AM +0800, Wang Liang wrote:
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
> the commit 99b40610956a ("net: bridge: mcast: add and enforce query
> interval minimum"), add check for the query interval maximum to fix this
> issue.
> 
> Link: https://lore.kernel.org/netdev/20250806094941.1285944-1-wangliang74@huawei.com/
> Link: https://lore.kernel.org/netdev/20250812091818.542238-1-wangliang74@huawei.com/
> Fixes: d902eee43f19 ("bridge: Add multicast count/interval sysfs entries")
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

