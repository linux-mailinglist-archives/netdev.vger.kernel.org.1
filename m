Return-Path: <netdev+bounces-262555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF4RJNlJpWn17wUAu9opvQ
	(envelope-from <netdev+bounces-262555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:27:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D651D49C1
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A7C1300BD85
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66FD379EC8;
	Mon,  2 Mar 2026 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T6nIC3B7"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC422083;
	Mon,  2 Mar 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440022; cv=fail; b=ZSJ37bPINCwS54Wx0CgIZKcp0ylpwnpAA/anwQvqA1HctrqradEXrl+kGVTIb9eVaoqVXQbJvAmuthy3u3FYHVJ19i3RFJBojZZRxrESGqiq9s+kkO/OPeYLw/TDOOnukX336LmbSp/Gz/gfYRnrVw4WJoGLqpQ41cq1Clm59BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440022; c=relaxed/simple;
	bh=sr5hfZEl7X1tBZJVVbn0HplW1ZGm4AuikvgTl37DIjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F/ZbVHTUhshee/2pMC2oVf0BJf6fa7a4vjNAbXwMmYoEGzRzT4UymkkGnBmQg89+h3orxx4ZQ09vBs7VxrIzRtJv0tfZiBEFfr24uWaWJTAGLmqlMJNiENZR/9F1rTOHeIXfrnwkm/a6KVRwM+Xngp60NNb5COIZEEtYAHvoL7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T6nIC3B7; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMm9HqghfKcs77c6bEEW4sOhIkp+qNGgqDdsch5KhFF2s3G+WtQJXGADdcJAZ5ER9pujJUSNXCSnAcVIXnhuDptL6Iu56jLZBNuQctZ24W6pmPvICQVVsFCT6F94gLKQzTU/6IUTdhNxGNfGl1I33q4ba7YjWOQVz7n7R8GJv7DlFS4+96NxF/DSwle80VMgroJ7uZ6sUUm2xpGBUXXWGzlUVdcullN1OnQ6WuqYFU9HV5+QYz7vBY5EW4A0g5AUm0+Y9FM0mildvBCdTxjYXKJT/ZsqAWPgb0vEzqfpbEQfdkLFvlthlBs6RM69czP97eutlMd7y9TBeyt+dphKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVHKPz91evMMJqcINTDiaGW8F3Et7EIwYNY9wHt6xXg=;
 b=SQC8ntmDBQevVgOOBzC6O5AKSnCZ/3aeWOvXc2Sc6G3aQvA7xvEdeC9ICvTfAwnqSZFWF9joJBhJ5jCmaMExDTXJRZFADhqph98hm8UdQkmba6AvR3NSSHK5HY/CjJOEK89kd4IkquyeWQtUhLyp3vqfIkGel8OVu6TX6rGS+Es8bZNDTumNQv/gjbf9urGwz45xhzOfJBeuiZIc6g/fPQiqfgAN6sYkSY78iF/AC/I4oX9YU0s3rfykG+5KUvJkcbS5BkVTSbdPGDCa62awkngC4lfER/vojRgETKrI7MC9uuyc2gx+fihLmiS/RqSJsZQ1Bs5vaTYHg0GQFDo11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVHKPz91evMMJqcINTDiaGW8F3Et7EIwYNY9wHt6xXg=;
 b=T6nIC3B7hQrWrOOjNvvLi6pIXtfIOgm/abb/ASIx23YVvr4PX6dl3/LosPLEkMqT42ohfT111fXzTWMLW4Ykx8qrHePenTnPraPGQhWxipwfotscmTnJoK9kbcJkzq79VZcT9yX+OZ7XqrHurTsNZd3ZELRzMJ1yDDKSbabe1pnGg0WTyFi/beUlxVhk8uVHHG+H6ErrOtZAZzwcNkQ42ctNjOZl+zKf67Rbe8Wp0lPFBPiIfzFqyjiF/c8uhUP0PWQGH3aX3uLZE9s72poWrxnJbAwjwO719Mrp+H/71Dxo5LBEHM2HlWOtEWOV8jtrmGIyOryJrn/N2eokW0fGgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 08:26:56 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 08:26:56 +0000
Date: Mon, 2 Mar 2026 10:25:51 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, jiayuan.chen@shopee.com,
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ipv6: fix panic when IPv4 route
 references loopback IPv6 nexthop
Message-ID: <20260302082551.GA814377@shredder>
References: <20260302051132.66314-1-jiayuan.chen@linux.dev>
 <20260302051132.66314-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302051132.66314-2-jiayuan.chen@linux.dev>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|IA1PR12MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 347c3f7c-19bc-4b98-5e13-08de78357750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	049iAmQI4NFx0Po0qK/nGF2DOHUu6SnM8zW4Qrdo+8/xQFIUTaDehr12dIdL1jy0yzvpPwUKQaWOBoERHxcFsxQRUAkWYQHpawo+PiHdcDcGIX5K2o9NNg9im2kxGasKMqNOp9MWDUE3raajvVrQ8IIGHPXkoVbULqCBhosT+UbC9fbqg5SWV0j3LuHAcN06fjKyR3+mHCxjJzj5tHHOrCxC9vo7RffVBQQi8Cd7ufrusGQ86MzuxkwamM3R1uIMJ80GU7RmXhxJhQYHfO0MwxYIikycl7N6Lo5vV3uNXlWbWt/UYO222D7WBZ/ciEe7d4dHj1ebECbj4nnzLafweVPFBOO0mjCON6LlJZGXjI0DDsDGzOY6pdtKyEA/6cAeObR5UmeO2bHOQI8hODvB0uiAsEl1q0BxaEFIRj9fCaA4SQuyQYw4NvlAfsd4N8ltwZQW7KvrAjDeV8lYVvZ0CbTOPJaz9pJ7wLrOMARVPWfxLcPFyQkGkS3m23RVKWuXRXtppF118Kd/zDYa8F5gAX+cm7zmQpanNPvDfHY9TeU4Lif3kG+q6SzpctkBc/tw8t1EUJDEh2chkbEiep7MheWeNmIk9c7fhL+apb/OzjC7h3j4OiXieOci18Yo1Zpk7PbNMHYBVzvbS2jZBJFDilGwl58xQdGK9REUvFnm3zSB5Z8JkD+m/+hhOInXSfNyzgEtef1jzHmNSveK5OGoRTd5+nzwTDzwjVK1v4t08p4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?muWdG/01fmnOQf3S7kDr/ggMLQf47w9sX+dmWZzt4DyrsZYnjgWdo6IlJPfd?=
 =?us-ascii?Q?PWRUuX8YfFqstbl9hE1iwo/yUNRd4skQuWr1cVgQ/mYHVek9Pykd/fh+uWDK?=
 =?us-ascii?Q?3GXyWn2+1X8ymH8VXyfiZ+0c3HymR360NElf36sLPJmnyyCaIeXzvZdzvlSM?=
 =?us-ascii?Q?TuVltML8hOtKUOVW+zZe+iRp6PTh7HhNYuAORtpEWx6LWVJvFpK2OpFBsd6W?=
 =?us-ascii?Q?ClOH8utg58lICpFRV8cN4wCQGxzvA7s2lMWjOCPu7RqG74xVVkzaDo2RFp1J?=
 =?us-ascii?Q?+J01Msf6z7dMhrGcDuZFPIGyuO5ifZnLafWIlZAp80YUFLHdwr/kASVtDP0r?=
 =?us-ascii?Q?eLov3J338qestxjBrMAwH60UqFK6m2JpKIbJANseDD26XmUEBax4BwBvyrQQ?=
 =?us-ascii?Q?8yor+aeYxfPiCr5eEMEJHx7bbBnIHywAgIxOMUgWzPxxeXiuEPvNofIHVWHk?=
 =?us-ascii?Q?dk9zqH65vHS2AUauoAZjhcAaBv116kWk6BLdVDkgGJ/wLI2G8jBLICe7VKBC?=
 =?us-ascii?Q?tTOEDz0FIH2TY2scUn+AMxh9GyWCkD8Zbj4RbfDG4ymZCPIAUlRZ0m6AjBKz?=
 =?us-ascii?Q?jDdQXlEHA1MVByKRxBZhqZs/L3Pl3Uq54lzXm3POmawyuSn9QonaxGH/sR9J?=
 =?us-ascii?Q?Si2G0nP/VGjcey+qckUgRlkz24ygRJLA6S2MZ4CHHWGjM8SYyoX6EiX5CXRY?=
 =?us-ascii?Q?yNkaGW1UO7VcZXiW+7eJMJGLwp3Q80Z/maC8TW/SOrKwyqaKFwaS1h/bm2aV?=
 =?us-ascii?Q?LFBO2UoDfXG2lncN1dK0WRalcmUXO/mWAr3/482N4GMPlpLMZoRoxL4CZH/B?=
 =?us-ascii?Q?LyGGGKKS386DyB5OYOonHdNitWveoIGMQpFqG0JMnfeeLx86yj8WEX8Qp1Tp?=
 =?us-ascii?Q?GV/b7V1TFkrSAnszfrEaL7bVGt8bGeC5oPBKTtB73/paG/G+Lshp3NJUcafy?=
 =?us-ascii?Q?FaxW4cwHz5qB9OOLUJdyWGr/ebspRTfRzn/yk0DzwC6gtvnu9uZZuC/5Sovv?=
 =?us-ascii?Q?vN7Li+cyRDN7i3IoGIC9l0Hp3JUP4/fvWyTUFe8pQVhfkH1p0gyKjN4SUSol?=
 =?us-ascii?Q?eiwH3WQLXD1yGoIvpJ6cVr3JioUh0ja89oNChwKpbJ/iITAQ8Az/7BiRZz0z?=
 =?us-ascii?Q?WM5SKfc7IH3qtj/RVS1gkBH/9nTrkrs2eMoctLgeE6wOJDQYaVJrLBxj9rVe?=
 =?us-ascii?Q?BRoR0k0e+9z8xJjRtbjEETsNLvbUXjxJmSPqy93C/hsV73UrXoChWmMgil4v?=
 =?us-ascii?Q?IWznmurD3nd+m8foFHp2ecGxEXYW5W61Ak2YFR6t6nB/FPqwMoy3smPf/aG6?=
 =?us-ascii?Q?EknP7HB3IW2GS6RpYc4fDPyA3RCmYr9U58eIuZ4m6S0uKophiIF3fyreNSFa?=
 =?us-ascii?Q?VCArNZuRsj8UQfCbUb/6GyzBgSTQrRMjfLx2osoPPLDUFD+BkOedGH/oBGAS?=
 =?us-ascii?Q?V2uRqApIBuG+H5nmFpxGUCghb8E/Pl9PRyWkjDB5Jm+4c7IKxYqY0cCqF3bw?=
 =?us-ascii?Q?h3e2htgfj6i+Itu4CbTnkAgDPQrseUdOdV0YRoNzKkawZ1ubn+PrOZGEAIbf?=
 =?us-ascii?Q?a+LPI3eYFD64qeBGTPXUwCl8+q3RD74ET5yGHoMnDwV1oz5dU0wW/ugVD7iZ?=
 =?us-ascii?Q?vAvdvOQBF/lNmpGsZlAXBZQdGZ3neo/dcXF6GwttschfvIfv5h/CLQVeX860?=
 =?us-ascii?Q?TcF+3tB2R2HUYr4jnf6qxaFrxoz0MVoPqcEFE0sfS7YGJMMYxv50e15iWqIZ?=
 =?us-ascii?Q?tryBNAW48Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347c3f7c-19bc-4b98-5e13-08de78357750
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 08:26:56.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +L8nBP6Yt+tgo0bfgcLLyL2HX5ildrPLYT7u2oUka9Jy0z703Q06aFDwjCBUQMpSlUYixsd5dd8X4K9JxHG8sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262555-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,shopee.com:email]
X-Rspamd-Queue-Id: D1D651D49C1
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:11:28PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When a standalone IPv6 nexthop object is created with a loopback device
> (e.g., "ip -6 nexthop add id 100 dev lo"), fib6_nh_init() misclassifies
> it as a reject route. This is because nexthop objects have no destination
> prefix (fc_dst=::), causing fib6_is_reject() to match any loopback
> nexthop. The reject path skips fib_nh_common_init(), leaving
> nhc_pcpu_rth_output unallocated. If an IPv4 route later references this
> nexthop, __mkroute_output() dereferences NULL nhc_pcpu_rth_output and
> panics.
> 
> The reject classification was designed for regular IPv6 routes to prevent
> kernel loopback loops, but nexthop objects should not be subject to this
> check since they carry no destination information - loop prevention is
> handled separately when the route is created.
> 
> An alternative approach of unconditionally calling fib_nh_common_init()
> for all reject routes was considered, but on large machines (e.g., 256
> CPUs) with many routes, this wastes significant memory since
> nhc_pcpu_rth_output allocates a per-CPU pointer for each route.
> 
> Since fib6_nh_init() is shared by multiple callers (route creation,
> nexthop object creation, IPv4 gateway validation), using fc_dst_len to
> implicitly distinguish nexthop objects would be fragile. Add an explicit
> fc_is_nh flag to fib6_config to clearly identify nexthop object creation
> and skip the reject check for this path.
> 
> Fixes: 7dd73168e273 ("ipv6: Always allocate pcpu memory in a fib6_nh")
> Reported-by: syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/net/ip6_fib.h | 1 +
>  net/ipv4/nexthop.c    | 1 +
>  net/ipv6/route.c      | 8 +++++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 88b0dd4d8e09..7710f247b8d9 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -62,6 +62,7 @@ struct fib6_config {
>  	struct nlattr	*fc_encap;
>  	u16		fc_encap_type;
>  	bool		fc_is_fdb;
> +	bool		fc_is_nh;
>  };
>  
>  struct fib6_node {
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 7b9d70f9b31c..efad2dd27636 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -2859,6 +2859,7 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
>  	struct fib6_config fib6_cfg = {
>  		.fc_table = l3mdev_fib_table(cfg->dev),
>  		.fc_ifindex = cfg->nh_ifindex,
> +		.fc_is_nh = true,
>  		.fc_gateway = cfg->gw.ipv6,
>  		.fc_flags = cfg->nh_flags,
>  		.fc_nlinfo = cfg->nlinfo,
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index c0350d97307e..347f464ce7fe 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3628,7 +3628,13 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>  	 * they would result in kernel looping; promote them to reject routes
>  	 */
>  	addr_type = ipv6_addr_type(&cfg->fc_dst);
> -	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
> +	/*
> +	 * Nexthop objects have no destination prefix, so fib6_is_reject()
> +	 * will misclassify loopback nexthops as reject routes, causing
> +	 * fib_nh_common_init() to be skipped along with its allocation
> +	 * of nhc_pcpu_rth_output, which IPv4 routes require.
> +	 */
> +	if (!cfg->fc_is_nh && fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
>  		/* hold loopback dev/idev if we haven't done so. */
>  		if (dev != net->loopback_dev) {
>  			if (dev) {

The code basically resets the nexthop device to the loopback device in
case of reject routes:

# ip link add name dummy1 up type dummy
# ip route add unreachable 2001:db8:1::/64 dev dummy1
# ip -6 route show 2001:db8:1::/64
unreachable 2001:db8:1::/64 dev lo metric 1024 pref medium

Therefore, the check in fib6_is_reject() regarding the nexthop device
being a loopback seems quite pointless. It's probably only needed when
promoting routes that are using the loopback device to reject routes,
which happens in ip6_route_info_create_nh() (the other caller of
fib6_is_reject()).

I suggest simplifying the check so that it only applies to reject routes
[1]. It fixes the issue since RTF_REJECT is a route attribute and not a
nexthop attribute, so it will never be set by the nexthop code.

[1]
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 85df25c36409..035e3f668d49 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3582,7 +3582,6 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 	netdevice_tracker *dev_tracker = &fib6_nh->fib_nh_dev_tracker;
 	struct net_device *dev = NULL;
 	struct inet6_dev *idev = NULL;
-	int addr_type;
 	int err;
 
 	fib6_nh->fib_nh_family = AF_INET6;
@@ -3624,11 +3623,10 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 
 	fib6_nh->fib_nh_weight = 1;
 
-	/* We cannot add true routes via loopback here,
-	 * they would result in kernel looping; promote them to reject routes
+	/* Reset the nexthop device to the loopback device in case of reject
+	 * routes.
 	 */
-	addr_type = ipv6_addr_type(&cfg->fc_dst);
-	if (fib6_is_reject(cfg->fc_flags, dev, addr_type)) {
+	if (cfg->fc_flags & RTF_REJECT) {
 		/* hold loopback dev/idev if we haven't done so. */
 		if (dev != net->loopback_dev) {
 			if (dev) {

