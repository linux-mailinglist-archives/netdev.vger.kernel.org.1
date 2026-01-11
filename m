Return-Path: <netdev+bounces-248803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15579D0ECBE
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87BB03004280
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EC338F45;
	Sun, 11 Jan 2026 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4fJ3Qrb"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82E2AD20
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133370; cv=fail; b=jgXMAVThZFPlmuS24s9N0du6IILmsEHlIiHQ14BRo+niAVx4Hw4/8z/0XDHor+w4Tiq/vLZMc28OTeUV0A3aHc7ufdXGS59iEoPwY6lPW51xkcHYxosMrCRcMXT4Ec4FjKb8TTIS7VCCvosuFiCeuY6tKhtj66AWq07LciH4tGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133370; c=relaxed/simple;
	bh=DEi9XPxBqmXX/WQEOk8yLkh8+kbAY9jozd1CJE6Q2tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkKUdE82nbm36qvfwHFZggpTvD76EqvRn6YH+QClvLXBiwbeh6PrWrda8iY70JL3D5RxQGzAOoofg6Z2HAyYGX8oElf1O+ccPPn2a/dyrt14AKKWSXWFQLUbwMj573qeokk6ZuGKVbRKIOuSSGygpEdN/u9gOTydDxpUyMQ6rr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P4fJ3Qrb; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmkuySFAQ5PUWlYM58LGEY7ary7bFMx7HCBf3xlIbbktS/87vPCcSPCQcRHwrzk8yEy6vbXeQ3loFvDEIuQzN+0tKCH0uUPnVTwgA0rYsMDeUj7acZFSfXWkP4jJ5JkVrnv2slBSDfaTv71ACpN59b1A8JaXTuWx7WFqgzk9IDVelI31SNfkowk6vxIeUi27UnIKWsgqe301Qsg5kuAOVkRxUHNx21RsYBYkaeodSMk1WO3xL/9yHks6KPMCMe9aMOQt5ESLh6Tpghmyc/hMplpu60934VfcPonoWwByzcTejXRJKbiVEFmp8JbnnFN811clavgwgBL3GEuSG4EDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IB83xb7JM8qmoU+9mZUJQqxD/AfhBWBavNbYmZ6sco=;
 b=yNhhkypCLPg7gj835boNN7B9jXl+3JKKyf3fIMJ+XXjPjivyLXmyUl9Nd+bhiChbgAfo4r0Ed6LUNMRiEyi4aZSuA/k/03mXs14tLnw2JR3w1B0cQJmtz98wLnCCfLaHxUOjnM6BNbJtmv3CNgP3rt9xLoSytk3iMvXZjVzZZ/oFFskbDfrUa+A280waQK+En4f5SM2tkA8ZQsRvhG7lebbKhcB16m7yLhnsgr7ktp8MwuTV0omhG1Puhbxw8Zx1zIYqusR9d4KY9c1QEbUclOGMhpYA54sCSkJAiA7kqNwap/HeV+Yb2ldmOaFR3ExlqHC0zdUD+Jc1kkn8lQCiKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IB83xb7JM8qmoU+9mZUJQqxD/AfhBWBavNbYmZ6sco=;
 b=P4fJ3QrbJnobxpf9yzSluhkQKIWDKXhl2frN5I2n5wuGr+YexqfVJfIDu5h3LD2d8dIAMrYZxwrQxv5U0BBWvb5vP+GehY65adCUv9dCNBxKe/us5Kp09ydCaWbw2AfT1G03jLdG3gqlBauzky2enIk0LXTnX97gInF/I6lrWZhTwaE9fwwYCM3GcfiGpQEcpCAFPzG6qIxeiUpazvXHQTFSvSpd1zRVJWrQmkpsPgA0YlsdK7EHA0S48VK6s4JShZdTw1P8YFei2Lc+sKfmopCxFzhlf0K/SXt87GqcGNVwNO0UG6rqMyi2JTXxCYu0iIik8Y29gutGNfR8D7bziA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 12:09:25 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 12:09:25 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/5] ipv6: Allow for nexthop device mismatch with "onlink"
Date: Sun, 11 Jan 2026 14:08:12 +0200
Message-ID: <20260111120813.159799-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111120813.159799-1-idosch@nvidia.com>
References: <20260111120813.159799-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 58de1f8e-a24b-4609-4200-08de510a434a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrwOQqRfnVdDUz7IAVAgALRaINCsiXaVV/Pfam68JIM6nAIabaJQlwWHMOAA?=
 =?us-ascii?Q?deDopo8/2Pt0NjVsXuBgHGApJykzBQ3tlGl1jKq/jl7iseCg3HuNtWzJT3+7?=
 =?us-ascii?Q?lIkps9T23WzNdgAVooG/slzRES2Yc03RayVEC8INv/7N8Ggd9b7UW2C4svDj?=
 =?us-ascii?Q?d1R0u/sr6aXyusENpTJ1/mC4cBjPUXI8fNLpPPEYD8oBvvUt+Mkdy5mzxMaZ?=
 =?us-ascii?Q?huM3tkIRUaeu7s2t661jgtU9ZRv1uco02Gt36CQblDZuS0ZOsBv2+VQM/PEJ?=
 =?us-ascii?Q?b7M8qzJfE4STE3FdT+twlInOd1SsoWVm9PrT+VIIdWRvhwyfnSsCuVnNLT4t?=
 =?us-ascii?Q?qielRlxLv50wf3c7HhieDf/rjGA5liPPgASqQ5j9KY+QW0h1RNeSTv8RaBy4?=
 =?us-ascii?Q?Jy3TngZU2xMt0UQInfU4tXZLLlfG9TLeFU7t9CQIQkqEQofCPqHg86N/DwYN?=
 =?us-ascii?Q?NsFn3CLMqxhbd8fxFO6nNNnW9uUGaga4S/829dQeyDz0JzlcAb7TMcrbLXbF?=
 =?us-ascii?Q?I44rHHrQKmjatrsTs8A9kUXP+12uuOyKqijStFvY53oHTcFPQj2duZS+ARyv?=
 =?us-ascii?Q?qp9I9VSR5WCmDVFPGs4VH8WALYSBjytyLxdhjDDhee2lv73VV+PtwnNToaF/?=
 =?us-ascii?Q?sTTAAxs4+L4O4Bnp6Qf/SK3EdBaXRI8Sa7jt73aGtPLy58FOEibGISxOF0ie?=
 =?us-ascii?Q?ys7m7S3jJhbFOCFEIrlvjeoL5cdQoG6Hsgm5f4A1BqXbh7f7+Hs1KfhjdsWG?=
 =?us-ascii?Q?X18IeAkPDStz3ohDoa0GrbdJUsGpKQr4/kAVU3n6dNhSEHfMhA1JG3d3YYhv?=
 =?us-ascii?Q?WllPRYKJVpf7TDhWXOqR+2nrtEOLOoZA6KYey2mDE/GYK2f1mrhTg0plfpoq?=
 =?us-ascii?Q?GEiRhV/6lPF7ZLilRE0UO2hcfakLV+r4nize0zQ97uWaRlc92/gLNNsXuWIj?=
 =?us-ascii?Q?L1oXAq/W7O4o9K3H6mtI5Xan0KTb2/bIyMOhc/GWxN7bx5bob18PsJswbMcS?=
 =?us-ascii?Q?ZV8fg4A7JgRTKNkqly2Lensmyps5XERT4i+Oxx8iX5HB3yHQyX7bgli3rtq5?=
 =?us-ascii?Q?fOgTe2jc0udgLXapUu0uIobtaouaFYnB2RM0NKnxw5nOraZ5h/SSrLDsrq27?=
 =?us-ascii?Q?78sfoBVbEkRElZhKsdQksTPnfuaqmNvqYqV2I8mz1C0hF4zIw6trVEKOVce7?=
 =?us-ascii?Q?XdDlOFaGX8OZo3xIDVki4PYlOvpufmlzdpmNhy4MJtpmRriloDYB3RF8icUK?=
 =?us-ascii?Q?tXSp96E4BY0MgnhuHoojJEp5LANMFUs9xUwkRBTAe7T004j+GDwXPzLvkQRV?=
 =?us-ascii?Q?0KwqouoiM/OQP39+PqBCc9ROwJcVJgYGbHzUQh2qThiev5reUzN8LsjpFIOA?=
 =?us-ascii?Q?EJ/wa6FNh/RTG+ZPjfyBVQ7LdtePGo6yqJf6lVYk/vdAOiPrszyVaL6Ac6GV?=
 =?us-ascii?Q?HWUTHoZFdrMO27Hio3aKAvvCCGua8N1O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1bO4LWvmDO6okZU2n/LN3jWkJncOWM5Rr5SqYmoKpopeQ/yztzb06MdDsyF?=
 =?us-ascii?Q?Bpl5zT+UbNB7HwfbvK+9gx6OEbHjJiRDGLGFfCmP3ibQMs+TwS2jVc0oCF7u?=
 =?us-ascii?Q?xUhOEtnzXhaSTtj4QPO6vupcM7I+G0dNoG/UIIpuLzFRx5ztgt7gW1yweeEF?=
 =?us-ascii?Q?ygO6rjz/pWR79bjg5AldIeLa1TpmeaJilqP2650RoAbuR5+wpp2aNOFu73C/?=
 =?us-ascii?Q?ukQuBfhQvIhIpajTAcF8DcvX/jtDWKsdnRrrFKGMHgN4yTcw/Qh1+eqo4v7e?=
 =?us-ascii?Q?br1O2UHwo8XplKFHhat3xynXDs9bmp0ncc2NFBOfvqrXbBz99IZuN1kxrz+R?=
 =?us-ascii?Q?WFLkneZ/Can/TdLtQ4QxGzxiUtp8RYhVxEMkjBik1KNyOV0mwbwiDOClog/7?=
 =?us-ascii?Q?xknAiFbZqIoWsub3W6/axgelQ2ksQPZNg6vuQwY/5TnfsV+qqUDwi6Ksrx0b?=
 =?us-ascii?Q?3z9ofIDEayiRIPpvcEuKVOO7X4VbXf0hEG2be46T0rgQJlAlMYSwqTAc+NyL?=
 =?us-ascii?Q?sezr8RcofcUS+o1bZ54oWVx5ITdqyn5F4gZxSYWsHlx+g+NKLQD1t8hUwfPF?=
 =?us-ascii?Q?EqXnoo61r+J3KaZMqEReSyhEDdKLSJN8aeQ0cJm3dvaKYAuHJAJ/6Lo2moCc?=
 =?us-ascii?Q?8lBrrMLUH6LBNWA+Fzfg6Va6EdWboCQHGOF62WjCcLNIsJ7Yc2eL4nwrJ64K?=
 =?us-ascii?Q?xeiv3JJdaQ0ESdIfzfGAxT4rC8TBXfQGXCcHNg5Z0ebZDT8Tvx8zoMUDvXQ2?=
 =?us-ascii?Q?lZ/8IPdXAJACbmJPYhYhVNQue/b8L22UhHUY9cYqpcJt4Tag/fMSWymqz4Q+?=
 =?us-ascii?Q?6jf4TaSZFnZtW+P6ghPVGF31vVRPOCRbhD7RHjGi4SPw5sMIr2LpASuGambB?=
 =?us-ascii?Q?tjqKzvwKHj/KJe7nfa9Kp1Yeqja9kymc7HrAgLEckhO8hm2kAOYb6PBn1rTG?=
 =?us-ascii?Q?ytiOHIo9ZM02o4FCUXvmPdLwZO7CpRTA65c0Y1fgNPNiHZb0MgzgMY4a+n/c?=
 =?us-ascii?Q?f6WcxjBmF4Tw7j221cjYodPGG3K+k7zSD/PNByt56WWgasgVcxxa3nugsQFv?=
 =?us-ascii?Q?jVroxbPIpbnIsuOo4DRy57YVCAXuwj/mxGPryExey3GRHT6sKUINpVEBT4Mz?=
 =?us-ascii?Q?SvKuI4/XpIivMEAurUMpEtaD70fV3KF3I1Q2vpvE6c6WT63VJTB3M/eBb4x8?=
 =?us-ascii?Q?6IDFELSBDnR+hpO9Sr+C4aTSXvB56UpjZI8v4f22T/9gk4LW+A4nMG63pD75?=
 =?us-ascii?Q?pJW4aKZM3fan7Rp6EGw3lC7F0tokhF/kpmGJLTh9M0JFYOZqG9ldA1vrTgiV?=
 =?us-ascii?Q?oTfO6i9sN/MHwUfEFrSf65Djw2sQE5xxXpj4Rbn25p0ekMbqz6X9BX+eJQ/y?=
 =?us-ascii?Q?RFuP+VvvdzY5Hd0rqEQatUk7oovH493FF+nh+COgw0w8eZ8MOsiFaXSnnt/Q?=
 =?us-ascii?Q?Z1UmgzboxoBI6QQ23aERxbXAyl+tDMcBZUwBPNnTbSrzodQGaksCZiJCHveg?=
 =?us-ascii?Q?WDYcRca19UL8ewEGNvvfprqdhP3q3ZtP9HAexBqQL+uO90SKJwShuufapJpQ?=
 =?us-ascii?Q?M3jfER4l7yKSD4nuw+atJ6qn2Q2C6IBKJ/DqnCshONxeDu0Nqeqjp9gzWt9u?=
 =?us-ascii?Q?tsrmMG/iY/bSN2HXrxzns8xcNJOEInD7iHP0OUGy3xEcOKYZBAeWzhzt91Bw?=
 =?us-ascii?Q?WmQFVPTur9mTNfUZNFzwjc8V8kTnff4HfLmDU6i5l7RRRJtQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de1f8e-a24b-4609-4200-08de510a434a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 12:09:25.4753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS61B1cAw+3HzBg88Fe03U/JOf/u0zmj1N/61nVV1Tzv9Unyq9PE845ORQaJaT9SUQyetY8E6q6AUFZ/AOGkkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B

IPv4 allows for a nexthop device mismatch when the "onlink" keyword is
specified:

 # ip link add name dummy1 up type dummy
 # ip address add 192.0.2.1/24 dev dummy1
 # ip link add name dummy2 up type dummy
 # ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy2
 Error: Nexthop has invalid gateway.
 # ip route add 198.51.100.0/24 nexthop via 192.0.2.2 dev dummy2 onlink
 # echo $?
 0

This seems to be consistent with the description of "onlink" in the
ip-route man page: "Pretend that the nexthop is directly attached to
this link, even if it does not match any interface prefix".

On the other hand, IPv6 rejects a nexthop device mismatch, even when
"onlink" is specified:

 # ip link add name dummy1 up type dummy
 # ip address add 2001:db8:1::1/64 dev dummy1
 # ip link add name dummy2 up type dummy
 # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2
 RTNETLINK answers: No route to host
 # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
 Error: Nexthop has invalid gateway or device mismatch.

This is intentional according to commit fc1e64e1092f ("net/ipv6: Add
support for onlink flag") which added IPv6 "onlink" support and states
that "any unicast gateway is allowed as long as the gateway is not a
local address and if it resolves it must match the given device".

The condition was later relaxed in commit 4ed591c8ab44 ("net/ipv6: Allow
onlink routes to have a device mismatch if it is the default route") to
allow for a nexthop device mismatch if the gateway address is resolved
via the default route:

 # ip link add name dummy1 up type dummy
 # ip route add ::/0 dev dummy1
 # ip link add name dummy2 up type dummy
 # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2
 RTNETLINK answers: No route to host
 # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
 # echo $?
 0

While the decision to forbid a nexthop device mismatch in IPv6 seems to
be intentional, it is unclear why it was made. Especially when it
differs from IPv4 and seems to go against the intended behavior of
"onlink".

Therefore, relax the condition further and allow for a nexthop device
mismatch when "onlink" is specified:

 # ip link add name dummy1 up type dummy
 # ip address add 2001:db8:1::1/64 dev dummy1
 # ip link add name dummy2 up type dummy
 # ip route add 2001:db8:10::/64 nexthop via 2001:db8:1::2 dev dummy2 onlink
 # echo $?
 0

The motivating use case is the fact that FRR would like to be able to
configure overlay routes of the following form:

 # ip route add <host-Z> vrf <VRF> encap ip id <ID> src <VTEP-A> dst <VTEP-Z> via <VTEP-Z> dev vxlan0 onlink

Where vxlan0 is in the default VRF in which "VTEP-Z" is reachable via
one of the underlay routes (e.g., via swpX). Without this patch, the
above only works with IPv4, but not with IPv6.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a3e051dc66ee..00a8318f33a7 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3419,11 +3419,8 @@ static int ip6_route_check_nh_onlink(struct net *net,
 
 	err = ip6_nh_lookup_table(net, cfg, gw_addr, tbid, 0, &res);
 	if (!err && !(res.fib6_flags & RTF_REJECT) &&
-	    /* ignore match if it is the default route */
-	    !ipv6_addr_any(&res.f6i->fib6_dst.addr) &&
-	    (res.fib6_type != RTN_UNICAST || dev != res.nh->fib_nh_dev)) {
-		NL_SET_ERR_MSG(extack,
-			       "Nexthop has invalid gateway or device mismatch");
+	    res.fib6_type != RTN_UNICAST) {
+		NL_SET_ERR_MSG(extack, "Nexthop has invalid gateway");
 		err = -EINVAL;
 	}
 
-- 
2.52.0


