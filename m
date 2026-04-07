Return-Path: <netdev+bounces-276003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPUQEZAK1WlQzwcAu9opvQ
	(envelope-from <netdev+bounces-276003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:45:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB53AF684
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1849A3003617
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46D3B584E;
	Tue,  7 Apr 2026 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dka+ukOo"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F983043DE;
	Tue,  7 Apr 2026 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569548; cv=fail; b=lWx20OFxW3ufAx1aOP9AT6i4N+InfQU3fqNbJ7eXc5Vbaiv2ZB3QUAn6NfzvrXXj8mgYUy/8BtXV0vSDYecTQNYnWAEoqqnzRbGdvJDArFTXXyClAY38dheYVtEnbihbu0ne97YDqu00bSnR+B4mLCvLPKMhXI0fHQ7nRhC0IR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569548; c=relaxed/simple;
	bh=1DMLuNXHb+P0jdFxIK5MIdxOjAGfhuszRcHlxGM65nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=syqhSFTasd3U8qPzeU9V0wvy/KJ2KWsYafl6BdbCuij/CfApCSRuzDa5dNHoTUG0JBqzgmVLUWFO7rGlT0yI00knzmi5DW7dqXeyxpyBUoBxZsUVUvmP/BcQd+8/R3DW+lN0x5vK0PdGTcclgpZh/CfgfT4gF/IdHf4RQF2ySBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dka+ukOo; arc=fail smtp.client-ip=52.101.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqaGjr1nDG77zLxnZRcQpJ5FYtzUdLh8BdUsOz837onPr1wlVMjxLwruJrFfWh8KvAfWYym1fVs3swgUJnEzijvTRP15qZjWKFpAqTZBQwlF8OF59i88vS49Zum8xCDsOY6GwCyhCFBQgBH+pytQQg2jSmBBaRC9K6+tYz12pNI0XE2/WL8OVLakDG7MlwUkmdMFRjSrkVWEffwRcRanSEIyPzCXg+HNyPYJcFg0yS7OjdXDG6uzeXN07RyYJm7NUZjnsImJ36Wb95ZdUu6Ct32h7wfPrm1lub/PCkD326BJhs6U/F/K8mEekxX3x02Vkqihnx6jn6BDpl+3wc0GUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBDIZIZsztlMUlTIAQMk12s7Flxfl32Yg50nIxS3KqU=;
 b=KWvI2q7X3CFabKN2q/lZP3gyJ9bZ+cyswGcXq8jOscoyddZ5DBNt0pzdJ8BS332RULWcgrVg2VP4n2qFFm9RnBD6UDawsEPmVKnYb9osoL4Kyvb44DoAhQ4jWCxev5ACzZCoWUdZLK3ZY5+NHCXGaPkPZpTqRrJ7d1Swkz0mu9w34Ph76scmv7c0O1AyYKYYcl+c/k6ssc6lRifxzAv/PzNhAxHs9+ZGolHsZBDkNK8bez+SvaEkfcNmU5Taym+7VmyvoBsPspzh6COGMRWsFcQmRKCH/TSLNc1d1MIkP+gcyFF00QBXqhsf4fdCZI95p2lYB88pUuhGyFDNQx0llA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBDIZIZsztlMUlTIAQMk12s7Flxfl32Yg50nIxS3KqU=;
 b=dka+ukOo1tAIRCj49AX4IQMfeXwp4IylogXtQPZnLv6zW4xlAc22CYl3m6/J5xwki4rTQ6r169PZPKNjCow5W6N85+KzGL0rNAZp2FVkG+B1ARCBhGyZELZw5IlEZBwGO3j/bgnCeUc8rjp48qvLwWwO9E9aswCpJHLp6iy8z/zpHxvIiCmL0/TtceEgPrvuGPf6c0psg2B+yH7lRmQTL7I3Gcd4B3837qPfP9s01ymVeBaRuE03tHAdVhVaONwBdbppWJa/WyXEmAkiscNwySvSKv1nj5/xVjibARQnGeCM0KLSACuSTislB2V9s7vauFBJMwTEEqwKIg5qP2JN6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 13:45:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 13:45:38 +0000
Date: Tue, 7 Apr 2026 16:45:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/5] selftests: net: bridge: add tests for
 MRC and QQIC validation
Message-ID: <20260407134528.GE849209@shredder>
References: <20260403150050.1235-1-royujjal@gmail.com>
 <20260403150050.1235-6-royujjal@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403150050.1235-6-royujjal@gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fa2cac-d024-4214-0bd6-08de94abf392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SFpdmnZrnfvtKm22JnygT+QdAkMVtQj51+iRHNW//pOAtNWaNK0MZsoH0yPPewF7Ka1zY6jJNc20Wai+BbcTcEQ+AAddysa4BfIIXzk61K+zesKQfpxRaO713lR3Fdem+yFVsC1T6MFYT9/9U+jq+NJ4XnRxL78e5ZHW8syRcDp53jkFTU0rOtHHOetSlV3KZ0sq8KISKwUlBPjMFUc77PXRvXIjReZKb+2NLu/P6tW2kBj273shodng5xah+IfoCMPOWF91mKB9hQfdm1bOy/muCKTaEH8ZaAJQE4EiQG8JU1x4qQLbFynSafU0QuSSPrLl3S4J/YYfQ480S14c1goCyG8LW+xM0vZD5n+Zzbembf3HLon+JZrLBSt5L+X/uad62YzwXI8VAh0LJWBv23Ovi8ARGoqGRzuxcS0QV0OjyozaU/YHTAYRnZ+LqcwlzpCsPsNsbgEtnnzZgjGvtYUviEla88ThkdWhoTFkCY80eJach4wPBYDCIowCy0nCFDycH98PrEDLV13YaNsVAdTzkAPf5LhwQuf3v/iDfq24XrOkhpvp1Q6S6dG+9XZTGrKeVrWzxZyD9WUKuZpLL09jhu3zBjYjps8ojcBP9U904w3pKZhgBlHVNBJrx6lEpvjB+b6VeTHk5/aXnPJR20yMr2bgB4klJ9YIpYguhM9PRSmK4wO1o2kmqer+H46ClKNpY9NkEUHdS2josCKcWnp1XdXoXasnvC7dHdY0r9I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R968HYRf9FD/g1n1AR5meNRKusuxj7RSa+bmnXIK5/ofbYbpam2HKOdiB7S7?=
 =?us-ascii?Q?y8w9kdPeXcHIgODjJbJLksNUFxzh902zCiAEO5/2s7oxq5tkiZBSyhGmUrTm?=
 =?us-ascii?Q?m2PU1Ieb5CR4Z4EH6XRVRGCUl6ajri5jtQoozLZahC5Qpai7vdMtHB1FB+TD?=
 =?us-ascii?Q?gRI8n97nRASJTdq17u/yImPBUQIHVIOFpXLhA9jg9PE7bMr3gQboePysv8UV?=
 =?us-ascii?Q?mXAMBQ82x+R7MzUOqexIXYmBnHVvWPs4R9HO08FBlGsMfc+xTjpdF7h8dMpu?=
 =?us-ascii?Q?btZEk7hs133mboExz5I4VGp+1+7TPB5jj5no9agx3OcLWM+n7916E6X8LUUw?=
 =?us-ascii?Q?3j8QFX8cUdoRuJE+07Mnja1b5Daqs7Wx+shotTkacQLCnY3gjstBMYk5lTvr?=
 =?us-ascii?Q?H5uQvLwSGN9+R5wPLQJiF7fgo7HCQpSj3d6ULOcyx2fmyGro0lCGV55DcGqT?=
 =?us-ascii?Q?c1VyDzEAX8If9xPDqJRnIMMTIeJXo6+FjPiEVSwlPbEvmBWAP8CrA7KcxAZY?=
 =?us-ascii?Q?Tnb7GH63TRQIanyQKytvTbqNSDclMzXXoRMS3XWDWsmHzWTCihSN+sES+bHN?=
 =?us-ascii?Q?oPhwO5ucaD0e0ubseu6MTPev6pW3iQn44YDcfgfAz3MIBY/OfcHL1v0J5xG8?=
 =?us-ascii?Q?rVoymp7G6Rfli/WizthaTng7MIh1lNtzMVlGwKJjqsbWva3crH7Whb/UTKix?=
 =?us-ascii?Q?tSwcqih6DbwczGSYqV/HPhpWMWF6QyUeXQ/wjXQ8h3gLQzlz/EvJCQJZw7Or?=
 =?us-ascii?Q?gLOsfc6G8LMe2RDx7C5/jU7YwzNPrAL38enaTgDlE7zcQpGLMrmPNmoOJkyF?=
 =?us-ascii?Q?aWKniygg2GHEdeesXMwCnGQbz3wBwU/Ui6Mkt8oIL5UE+rMTVjGX4BsoojSR?=
 =?us-ascii?Q?zwvwxv9GYgo1welz3EGgTPmNoMKPSOloTJI9TVmcMasl5c1biEu+2u9GEGFu?=
 =?us-ascii?Q?zm+bzoGlKroEFEbW1UGriExW+LwulzACAE5ZTwjc+5xKIapnvYxSdu8YpZjd?=
 =?us-ascii?Q?fg0nxAnRGjwgTgBVI14ELpOvAgsjtTGsulSPRNgFjLIjwzj3LqSvOYMjgYlZ?=
 =?us-ascii?Q?iIXx6XiussKW8rwYWpvlfFgac5+c5pVszctBKrqCbGK/fPvfCYk+6hCCPdWO?=
 =?us-ascii?Q?N/q6RoYu78ULVkAx0mRzBYUE1Mz0BvO7yEaGDvhrgcA9zAGpnPU/+tYsYqs9?=
 =?us-ascii?Q?/Fa+U9TK9Uaym/emHiwokXYHYYVuDOrM2UaZTCFyU6wDIeHzk2fRTJbwTfIp?=
 =?us-ascii?Q?XVGOehaSSXIyLChN/odb1BNKZjHr4ziavkbDzL+wnzKsnFhcCaQ0vi5QM055?=
 =?us-ascii?Q?1hEEPjJSRYnRZVXiQCEn6QTh9Z/y8o1gmpBtnxW1lYmF+rfmKiOjcS7wcfCt?=
 =?us-ascii?Q?HdaXm8NHUEjnAqxhqbhfhlxf/0hw+GfhfeM+yjT+/Pb9kmZ4Z4PwHjr3mEa8?=
 =?us-ascii?Q?m5gT3em4uCWEAxnCe3VqeKf3xmgH+dMQhqwViiuOJ5mgy/wX4+obpPKMpuYU?=
 =?us-ascii?Q?Ysq6aG3Grya4KaWGtZgtMgaoaNciKhdd+z/vVX7kLSQnTZ5yQ33l9q7AnyUD?=
 =?us-ascii?Q?cyEzjGIfcC7H1cffxCYfYZGAD4g4UEs/tWMCzeIIvs1Zr6tVLVJVLUNYL4nI?=
 =?us-ascii?Q?dM3VFBdU7S6Xmlo9Iv71wU2i5iXEKMusAs4vgTBQpD+//V+q0hK+etOX6fz6?=
 =?us-ascii?Q?029s8ZICko3MbBe7/BekjY7ArD1ce41XR6yECb0KcUP1T/oFnTDLkmpVTXB7?=
 =?us-ascii?Q?MKNtrFbuDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fa2cac-d024-4214-0bd6-08de94abf392
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 13:45:38.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZLHLHmPSDaJk9lKcRWLXuM51DeUaMeC29vkj4oz/toGT6YgW8LYvnZAN282ol0dCs80xWYQXPTBgB7W61i9XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276003-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bridge_activity_notify.sh:url]
X-Rspamd-Queue-Id: C6CB53AF684
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:00:50PM +0000, Ujjal Roy wrote:
> Update bridge selftests that configure Max Resp Time (MRT) and Querier
> Query Interval (QQI) parameters and validate the resulting Query packet
> fields for Max Resp Code (MRC) and Querier Query Interval Code (QQIC).
> 
> These tests cover the IGMPv3 and MLDv2 for below cases:
> * MRC and QQIC in linear range.
> * MRC and QQIC in non-linear range.
> 
> TEST: Vlan multicast snooping enable                                [ OK ]
> TEST: Vlan mcast_query_interval global option default value         [ OK ]
> Vlan 10 mcast_query_interval (QQIC) test cases:
> TEST: Number of tagged IGMPv2 general query                         [ OK ]
> TEST: IGMPv3 QQIC linear value 60                                   [ OK ]
> TEST: MLDv2 QQIC linear value 60                                    [ OK ]
> TEST: IGMPv3 QQIC non linear value 160                              [ OK ]
> TEST: MLDv2 QQIC non linear value 160                               [ OK ]
> TEST: Vlan mcast_query_response_interval global option default value   [ OK ]
> Vlan 10 mcast_query_response_interval (MRC) test cases:
> TEST: IGMPv3 MRC linear value 60                                    [ OK ]
> TEST: IGMPv3 MRC non linear value 160                               [ OK ]
> TEST: MLDv2 MRC linear value 30000                                  [ OK ]
> TEST: MLDv2 MRC non linear value 60000                              [ OK ]
> 
> Signed-off-by: Ujjal Roy <royujjal@gmail.com>
> ---
>  .../selftests/net/forwarding/.gitignore       |   2 +
>  .../testing/selftests/net/forwarding/Makefile |  10 ++
>  .../net/forwarding/bridge_vlan_mcast.sh       | 157 +++++++++++++++++-
>  .../selftests/net/forwarding/mc_decode.c      |  73 ++++++++
>  .../selftests/net/forwarding/mc_encode.c      |  78 +++++++++
>  5 files changed, 315 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_decode.c
>  create mode 100644 tools/testing/selftests/net/forwarding/mc_encode.c
> 
> diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
> index 418ff96c52ef..aa0c7f1afb4b 100644
> --- a/tools/testing/selftests/net/forwarding/.gitignore
> +++ b/tools/testing/selftests/net/forwarding/.gitignore
> @@ -1,3 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  forwarding.config
>  ipmr
> +mc_encode

Do we really need this binary and all the added complexity? You can just
hard code in the test the expected encoded form of the non-linear values

> +mc_decode

This one doesn't seem to be used

> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index bbaf4d937dd8..a26da846632d 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile
> @@ -1,5 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
> +top_srcdir = ../../../../..
> +
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_FILES := \
> +	mc_encode \
> +	mc_decode \
> +# end of TEST_GEN_FILES
> +
>  TEST_PROGS := \
>  	bridge_activity_notify.sh \
>  	bridge_fdb_learning_limit.sh \
> diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> index 72dfbeaf56b9..89598712f869 100755
> --- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> +++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
> @@ -5,6 +5,7 @@ ALL_TESTS="vlmc_control_test vlmc_querier_test vlmc_igmp_mld_version_test \
>  	   vlmc_last_member_test vlmc_startup_query_test vlmc_membership_test \
>  	   vlmc_querier_intvl_test vlmc_query_intvl_test vlmc_query_response_intvl_test \
>  	   vlmc_router_port_test vlmc_filtering_test"
> +TEST_NAME=""

Why is this needed? Just pass to vlmc_query_get_intvl_match() an
argument that indicates if we need MRC / QQIC

>  NUM_NETIFS=4
>  CHECK_TC="yes"
>  TEST_GROUP="239.10.10.10"
> @@ -96,6 +97,17 @@ cleanup()
>  	vrf_cleanup
>  }
>  
> +check_binary()
> +{
> +	local cmd=$1; shift
> +	local args=$@
> +
> +	if [[ ! -x "$(command -v "$cmd")" ]]; then
> +		log_test_skip "$args $cmd not found"
> +		return $EXIT_STATUS
> +	fi
> +}

This can be removed as well

> +
>  vlmc_v2join_test()
>  {
>  	local expect=$1
> @@ -162,14 +174,27 @@ vlmc_query_cnt_setup()
>  {
>  	local type=$1
>  	local dev=$2
> +	local intvl_match="$3"
>  
>  	if [[ $type == "igmp" ]]; then
> +		# This matches: IP Protocol 2 (IGMP)
>  		tc filter add dev $dev egress pref 10 prot 802.1Q \
>  			flower vlan_id 10 vlan_ethtype ipv4 dst_ip 224.0.0.1 ip_proto 2 \
> +			action continue
> +		# AND Type 0x11 (Query) at offset 24 after IP
> +		# IP (20 byte IP + 4 bytes Option)
> +		tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
> +			match u8 0x11 0xff at 24 $intvl_match \
>  			action pass
>  	else
> +		# This matches: ICMPv6
>  		tc filter add dev $dev egress pref 10 prot 802.1Q \
>  			flower vlan_id 10 vlan_ethtype ipv6 dst_ip ff02::1 ip_proto icmpv6 \
> +			action continue
> +		# AND Type 0x82 (Query) at offset 48 after IPv6
> +		# IPv6 (40 bytes IPv6 + 2 bytes next HDR + 4 bytes Option + 2 byte pad)
> +		tc filter add dev $dev egress pref 20 prot 802.1Q u32 \
> +			match u8 0x82 0xff at 48 $intvl_match \
>  			action pass
>  	fi
>  
> @@ -181,9 +206,46 @@ vlmc_query_cnt_cleanup()
>  	local dev=$1
>  
>  	ip link set dev br0 type bridge mcast_stats_enabled 0
> +	tc filter del dev $dev egress pref 20
>  	tc filter del dev $dev egress pref 10
>  }
>  
> +vlmc_query_get_intvl_match()
> +{
> +	local type=$1
> +	local version=$2
> +	local interval=$3
> +	local encode=""
> +
> +	if [ "$interval" = "" ]; then
> +		return
> +	fi
> +
> +	if [ "$TEST_NAME" = "vlmc_query_intvl_test" ]; then
> +		# QQIC is 8-bit floating point encoding for IGMPv3 and MLDv2
> +		encode="$(./mc_encode 8 $interval)"
> +		if [ "${type}v${version}" = "igmpv3" ]; then
> +			# IP 20 bytes + 4 bytes Option + IGMPv3[9]
> +			echo "match u8 $encode 0xff at 33"
> +		elif [ "${type}v${version}" = "mldv2" ]; then
> +			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[25]
> +			echo "match u8 $encode 0xff at 73"
> +		fi
> +	elif [ "$TEST_NAME" = "vlmc_query_response_intvl_test" ]; then
> +		if [ "${type}v${version}" = "igmpv3" ]; then
> +			# MRC is 8-bit floating point encoding for MLDv2
> +			encode="$(./mc_encode 8 $interval)"
> +			# IP 20 bytes + 4 bytes Option + IGMPv3[1]
> +			echo "match u8 $encode 0xff at 25"
> +		elif [ "${type}v${version}" = "mldv2" ]; then
> +			# MRC is 16-bit floating point encoding for MLDv2
> +			encode="$(./mc_encode 16 $interval)"
> +			# IPv6 40 + 2 next HDR + 4 Option + 2 pad + MLDv2[4]
> +			echo "match u16 $encode 0xffff at 52"
> +		fi
> +	fi
> +}
> +
>  vlmc_check_query()
>  {
>  	local type=$1
> @@ -191,9 +253,12 @@ vlmc_check_query()
>  	local dev=$3
>  	local expect=$4
>  	local time=$5
> +	local interval=$6
> +	local intvl_match=""
>  	local ret=0
>  
> -	vlmc_query_cnt_setup $type $dev
> +	intvl_match="$(vlmc_query_get_intvl_match $type $version $interval)"
> +	vlmc_query_cnt_setup $type $dev "$intvl_match"

Did you run shellcheck? I believe it will issue a warning if you don't
quote "$type" and "$dev". I realize it differs from other places in the
test, but we try to avoid adding new warnings / errors.

>  
>  	local pre_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_querier 1
> @@ -201,7 +266,7 @@ vlmc_check_query()
>  	if [[ $ret -eq 0 ]]; then
>  		sleep $time
>  
> -		local tcstats=$(tc_rule_stats_get $dev 10 egress)
> +		local tcstats=$(tc_rule_stats_get $dev 20 egress)
>  		local post_tx_xstats=$(vlmc_query_cnt_xstats $type $version $dev)
>  
>  		if [[ $tcstats != $expect || \
> @@ -428,6 +493,10 @@ vlmc_querier_intvl_test()
>  
>  vlmc_query_intvl_test()
>  {
> +	TEST_NAME="vlmc_query_intvl_test"
> +
> +	check_binary "./mc_encode" "$TEST_NAME: verify" || return 1
> +
>  	RET=0
>  	local goutput=`bridge -j vlan global show`
>  	echo -n $goutput |
> @@ -440,6 +509,7 @@ vlmc_query_intvl_test()
>  	check_err $? "Wrong default mcast_query_interval global vlan option value"
>  	log_test "Vlan mcast_query_interval global option default value"
>  
> +	echo "Vlan 10 mcast_query_interval (QQIC) test cases:"

log_info()

>  	RET=0
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 200
> @@ -447,14 +517,52 @@ vlmc_query_intvl_test()
>  	# 1 is sent immediately, then 2 more in the next 5 seconds
>  	vlmc_check_query igmp 2 $swp1 3 5
>  	check_err $? "Wrong number of tagged IGMPv2 general queries sent"
> -	log_test "Vlan 10 mcast_query_interval option changed to 200"
> +	log_test "Number of tagged IGMPv2 general query"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
> +	check_err $? "Could not set mcast_igmp_version in vlan 10"
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
> +	check_err $? "Could not set mcast_mld_version in vlan 10"
> +
> +	RET=0

What's the point in the check_err() above if there is no log_test()
before resetting RET? Let's remove them

> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 6000
> +	check_err $? "Could not set mcast_query_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 QQIC should match with linear value 60s
> +	vlmc_check_query igmp 3 $swp1 1 1 60
> +	check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
> +	log_test "IGMPv3 QQIC linear value 60"
> +	RET=0
> +	# 1 is sent immediately, MLDv2 QQIC should match with linear value 60s
> +	vlmc_check_query mld 2 $swp1 1 1 60
> +	check_err $? "Wrong QQIC in sent tagged MLDv2 general queries"
> +	log_test "MLDv2 QQIC linear value 60"
>  
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 16000
> +	check_err $? "Could not set mcast_query_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 QQIC should match with non linear value 160s
> +	vlmc_check_query igmp 3 $swp1 1 1 160
> +	check_err $? "Wrong QQIC in sent tagged IGMPv3 general queries"
> +	log_test "IGMPv3 QQIC non linear value 160"
> +	RET=0
> +	# 1 is sent immediately, MLDv2 QQIC should match with non linear value 160s
> +	vlmc_check_query mld 2 $swp1 1 1 160
> +	check_err $? "Wrong QQIC in sent tagged MLDv2 general queries"
> +	log_test "MLDv2 QQIC non linear value 160"
> +
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_interval 12500
>  }
>  
>  vlmc_query_response_intvl_test()
>  {
> +	TEST_NAME="vlmc_query_response_intvl_test"
> +
> +	check_binary "./mc_encode" "$TEST_NAME: verify" || return 1
> +
>  	RET=0
>  	local goutput=`bridge -j vlan global show`
>  	echo -n $goutput |
> @@ -468,10 +576,49 @@ vlmc_query_response_intvl_test()
>  	log_test "Vlan mcast_query_response_interval global option default value"
>  
>  	RET=0
> -	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 200
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 3
> +	check_err $? "Could not set mcast_igmp_version in vlan 10"

Can be removed

> +
> +	echo "Vlan 10 mcast_query_response_interval (MRC) test cases:"

log_info()

> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 600
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 MRC should match with linear value 60 units of 1/10s
> +	vlmc_check_query igmp 3 $swp1 1 1 60
> +	check_err $? "Wrong MRC in sent tagged IGMPv3 general queries"
> +	log_test "IGMPv3 MRC linear value 60"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1600
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, IGMPv3 MRC should match with non linear value 160 unit of 1/10s
> +	vlmc_check_query igmp 3 $swp1 1 1 160
> +	check_err $? "Wrong MRC in sent tagged IGMPv3 general queries"
> +	log_test "IGMPv3 MRC non linear value 160"
> +
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 2
> +	check_err $? "Could not set mcast_mld_version in vlan 10"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 3000
> +	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> +	# 1 is sent immediately, MLDv2 MRC should match with linear value 30000(ms)
> +	vlmc_check_query mld 2 $swp1 1 1 30000
> +	check_err $? "Wrong MRC in sent tagged MLDv2 general queries"
> +	log_test "MLDv2 MRC linear value 30000"
> +
> +	RET=0
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 6000
>  	check_err $? "Could not set mcast_query_response_interval in vlan 10"
> -	log_test "Vlan 10 mcast_query_response_interval option changed to 200"
> +	# 1 is sent immediately, MLDv2 MRC should match with non linear value 60000(ms)
> +	vlmc_check_query mld 2 $swp1 1 1 60000
> +	check_err $? "Wrong MRC in sent tagged MLDv2 general queries"
> +	log_test "MLDv2 MRC non linear value 60000"
>  
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_igmp_version 2
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_mld_version 1
> +	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_startup_query_count 2
>  	bridge vlan global set vid 10 dev br0 mcast_snooping 1 mcast_query_response_interval 1000
>  }
>  
> diff --git a/tools/testing/selftests/net/forwarding/mc_decode.c b/tools/testing/selftests/net/forwarding/mc_decode.c
> new file mode 100644
> index 000000000000..2c5e784226e4
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/mc_decode.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/bitops.h>
> +
> +/* 8-bit floating-point exponential field decode */
> +#define FP_8BIT_EXP(value)		(((value) >> 4) & 0x07)
> +#define FP_8BIT_MAN(value)		((value) & 0x0f)
> +
> +/* 16-bit floating-point exponential field decode */
> +#define FP_16BIT_EXP(value)		(((value) >> 12) & 0x0007)
> +#define FP_16BIT_MAN(value)		((value) & 0x0fff)
> +
> +/* 8-bit floating-point exponential field linear threshold */
> +#define FP_8BIT_MIN_THRESHOLD		128
> +/* 8-bit non linear max representable (mant = 0xF, exp = 7) -> 31744 */
> +#define FP_8BIT_MAX_THRESHOLD		31744
> +
> +/* 16-bit floating-point exponential field linear threshold */
> +#define FP_16BIT_MIN_THRESHOLD		32768UL
> +/* 16-bit non linear max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +#define FP_16BIT_MAX_THRESHOLD		8387584
> +
> +/* This decodes 8-bit floating-point exponential values */
> +static inline uint32_t decode_8bit_field(const u8 code)
> +{
> +	if (code < FP_8BIT_MIN_THRESHOLD) {
> +		return code;
> +	} else {
> +		uint32_t mc_man, mc_exp;
> +
> +		mc_exp = FP_8BIT_EXP(code);
> +		mc_man = FP_8BIT_MAN(code);
> +		return (mc_man | 0x10) << (mc_exp + 3);
> +	}
> +}
> +
> +/* This decodes 16-bit floating-point exponential values */
> +static inline uint32_t decode_16bit_field(const uint16_t code)
> +{
> +	if (code < FP_16BIT_MIN_THRESHOLD) {
> +		return code;
> +	} else {
> +		uint32_t mc_man, mc_exp;
> +
> +		mc_exp = FP_16BIT_EXP(code);
> +		mc_man = FP_16BIT_MAN(code);
> +
> +		return (mc_man | 0x1000) << (mc_exp + 3);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	uint32_t bits = 8, code = 0, decode = 0;
> +
> +	if (argc != 3)
> +		return 1;
> +
> +	if (bits != 8 && bits != 16)
> +		return 1;
> +
> +	bits = atoi(argv[1]);
> +	code = atoi(argv[2]);
> +
> +	if (bits == 8)
> +		decode = decode_8bit_field(code);
> +	else
> +		decode = decode_16bit_field(code);
> +	printf("%u\n", decode);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/net/forwarding/mc_encode.c b/tools/testing/selftests/net/forwarding/mc_encode.c
> new file mode 100644
> index 000000000000..24d9bd9299cc
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/mc_encode.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/bitops.h>
> +
> +/* 8-bit floating-point exponential field linear threshold */
> +#define FP_8BIT_MIN_THRESHOLD		128
> +/* 8-bit non linear max representable (mant = 0xF, exp = 7) -> 31744 */
> +#define FP_8BIT_MAX_THRESHOLD		31744
> +
> +/* 16-bit floating-point exponential field linear threshold */
> +#define FP_16BIT_MIN_THRESHOLD		32768UL
> +/* 16-bit non linear max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +#define FP_16BIT_MAX_THRESHOLD		8387584
> +
> +/* This encodes value to 8-bit floating-point exponential format */
> +static inline uint8_t encode_8bit_field(unsigned int value)
> +{
> +	uint8_t mc_exp, mc_man;
> +
> +	/* Value < 128 is literal */
> +	if (value < FP_8BIT_MIN_THRESHOLD)
> +		return value;
> +
> +	/* Saturate at max representable (mant = 0xF, exp = 7) -> 31744 */
> +	if (value >= FP_8BIT_MAX_THRESHOLD)
> +		return 0xFF;
> +
> +	mc_exp  = fls(value) - 8;
> +	mc_man = (value >> (mc_exp + 3)) & 0x0F;
> +
> +	return 0x80 | (mc_exp << 4) | mc_man;
> +}
> +
> +/* This encodes value to 16-bit floating-point exponential format */
> +static inline uint16_t encode_16bit_field(unsigned int value)
> +{
> +	uint16_t mc_man, mc_exp;
> +
> +	/* Value < 32768 is literal */
> +	if (value < FP_16BIT_MIN_THRESHOLD)
> +		return value;
> +
> +	/* Saturate at max representable (mant = 0xFFF, exp = 7) -> 8387584 */
> +	if (value >= FP_16BIT_MAX_THRESHOLD)
> +		return 0xFFFF;
> +
> +	mc_exp = fls(value) - 16;
> +	mc_man = (value >> (mc_exp + 3)) & 0x0FFF;
> +
> +	return 0x8000 | (mc_exp << 12) | mc_man;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	unsigned int bits = 8, value = 0;
> +	uint8_t encoded8 = 0;
> +	uint16_t encoded16 = 0;
> +
> +	if (argc != 3)
> +		return 1;
> +
> +	bits = atoi(argv[1]);
> +	value = atoi(argv[2]);
> +
> +	if (bits != 8 && bits != 16)
> +		return 1;
> +
> +	if (bits == 8) {
> +		encoded8 = encode_8bit_field(value);
> +		printf("%hhu\n", encoded8);
> +	} else {
> +		encoded16 = encode_16bit_field(value);
> +		printf("%hu\n", encoded16);
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.43.0
> 

