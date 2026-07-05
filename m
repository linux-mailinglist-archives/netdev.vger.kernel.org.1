Return-Path: <netdev+bounces-304759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /r0DGCMPSmq69wAAu9opvQ
	(envelope-from <netdev+bounces-304759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 10:00:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D67094BE
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 10:00:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gTZkTE8e;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304759-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304759-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D7E230039BC
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE826ED41;
	Sun,  5 Jul 2026 08:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD727E076;
	Sun,  5 Jul 2026 08:00:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238433; cv=fail; b=QYaJBzX5SJ/Fzx420Ct/4NH6k7WwIQ0H5umFclT9BDCmtPqAduJekK6jrulAp9Wm92g3UbWy6SdeblMYlvKEKW5ujFuIZUq+EC3ZInr+HXW7gxaze2pLBN5izzPGYpPE5rj5PlfJtMqHW0OxNDJ6YSd1wQqIwHxYSF/BNwSscuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238433; c=relaxed/simple;
	bh=gl4T3MjMIycggiIDWoZC7CYs4V0pJGPjmT7COdy9+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qSbEB2yWoYCaDm+iieeizXZjvX2XNmTG5EzQP5rw0Zut9LgHKI98Ub+ItfM+gtQOekIRSJ3+aWdeardGE4V9G6zLTGk9TJ14yYw8W6Rf4/5JU0U3W+N1+/6ce0BljLFe/6tIhyPkDQyTlx0RVrmqsNbuqlrvud65eh1B4qaut44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gTZkTE8e; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kftjPFycTActQOhQf6JM642bPd7O85bRIOyO8OaKDOAhn4ATOIpDFQLtkeRq3Xj3KeJ+b/MBjetG1GXTQAZEZcSaExGsYFA1+tXXrjB+A1fJrQlSziQWwpl7RXzswpBQ2IF392VZglO9uhPRhuMnT/7l8iQWDJEINsTbZFLWeD8se+im41jI0y2TICF8cw91oS5ahTm8NwByhac/ZkPh72gImPEjcTRFnQpTg6CLCTVYzDkOS3C7wDq2MTInZl7B/UhO5p6Ja5cTjWiCLK94ySZ4K1pEo5Fi/w2ogl+T11gANjJI+Hrd6wk8u60nzNp51uHVFTAZUXVlBMye/XELXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/ysZbaPHkl0IxqlPGl9MFU7dgg576dSpaYiVqMMUcU=;
 b=To4HaqHrzTCg3d6kxJEaB8xxriq/aYdHqzG+kabRdYKfGDXETU+Cy1QADNrkD86P13JyhBhEWFRysgSi00+o8FUIYvZsO/a9Ic+M44/WbTYZRsNCirOc1m4HLFs+fIbOoOwGgliBTbWK/+PnZPbXItw6xiigvv+BeAeSsjlB84gkqhwrftxaIX4K5v57/3nlhHDzsH5eRENFas26aLFfvcWD1jXimij4nqAFtfoRoOSFl1kX7ZYLoA4nvxYbjwikdgpbiKYbYw8qAPLyzEw7RvjBTIE2DSGO94dlJ+JlWnCjWMP5Kde6IYFaKAgik6mqluoBE7Z7g3b3c/vUx2UJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/ysZbaPHkl0IxqlPGl9MFU7dgg576dSpaYiVqMMUcU=;
 b=gTZkTE8eIVdGZy87z9n5v6MRMkrqkY9SHKnWP8ROPg3QkmHMQuE3JP17EnOy9dBGTGyNnse6pI0iIXSQLlUku9O79AgLk1/dOBzkpHUT6b+ReBZUHU51KMMJFDVDgLvzzmH+3/UPsRlZOGyLiBB1WC/bYZMS/wW8wbtF60rObRe0nXitkvD/BTqA9BT9HISJfOxhzYo9rmqxE7XTVMGctgGkfEVfMPJALyuFQP6QyRVLggtgCFMcQVVl6Os7yPj65A2H0rc1BqTQupIcO7c7lGBxMabUCmcWxjO55dAW+SjtAo3x1EuZhtM1QtNRu8BnRDDM29weS+SHR2LjF+dgdQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 08:00:23 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 08:00:23 +0000
Date: Sun, 5 Jul 2026 11:00:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	horms@kernel.org, xmei5@asu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: fib: free fib_alias with kfree_rcu() on insert
 error path
Message-ID: <20260705080014.GA104589@shredder>
References: <20260704171421.1786806-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704171421.1786806-1-bestswngs@gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5dbf52-673f-4311-55eb-08deda6b771f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tM4SITxaAzgG6Z0fh+lTbZX25VpNJ1H7ssgKjzU11iLvvfsrY/3vbghAGoUDeoSjeR0XwF2mN0A9yjeFSKse+ljijTm/Wjn1mmO3URMzEjOslBQiQlO2c1tuoYgPW8sJhbKPT0IWcrY1idF77JKa0yIPqY1PT4jLiFG0Fw22eopLy8HJQhBzJv89OLzxqZpGm9vrbYHJNWezUPWpzEAhzHZShKUlxklfDbvdGz35TpLIAiuQjzoXirI73FCwVRfQahU3z0bEPu7gvMGXziYHL7cvbgTJSvZVSvh6J1GHlhjV+oadlKI+x7EbfK2Q7XSlZ33yTkiwZ7ze13fhfLrJ4lat3rOUBJcRNHTyEs2ON2hBEP0K10P741SifUzTvFUIAJIUFlbAINPb/XJqDmMVZn6HX5KMyfxA7RYbBk7WAsr04uId+9yirfV/++ZpgJOQRIl8ND9mkX9m0PgQGPofGPADi9ghb9At20tQcIMGLXHWWqA0+HX/Qoon/dhwZ6X1aepZ/lW1OttxlWKcOzfmxbDDJymUMQNn98F/jKo/5Hdswyg6ON8KPaYAHCVlhPuG2ZyUnUudzEWBFjUWrAoGgypeewS1hGwgiLIa3n83T1yrgDFrlOBpQ9fWWPsETsANNwTHUqAKvqezMRBzv2HSCRiELtFt6fwsRwziu6EVfUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPIg7vizlcI1m2u3ptXDRRj1JdV8fvyo25zwhdFBvyoVD04UIL4oNDRXLUzA?=
 =?us-ascii?Q?FErjbwJyhqwmrHe2EhEC/dQkoLblaz510h0AclDLpON+MjxM/Pl+QKCsS8BN?=
 =?us-ascii?Q?Rj14crI2NyOIlmO+Sf1qKuD1045f7iCAx6MNmlkkLXcnfgfJlEUEY5VjxjDs?=
 =?us-ascii?Q?4X0dV+nD2DNEzMVsAlOu3uTJm8kSB4kG0pFm6GrE9SNsRQmFTlfknyGa/L5w?=
 =?us-ascii?Q?E7PXqa8GYE7gNDf+/YTZRQ6gl1H23p9d46eSHsvVSGNAIYzNK7g9Fg/Aknhf?=
 =?us-ascii?Q?yb4Fu6j1p0+xKwEVSyJC8KzUsjgD3X5lqpKKvOdnsd6dkJ2U8fWrPhAxDq2t?=
 =?us-ascii?Q?jv3ZrkkloUkAeuVmxWv3NoIpYjBs5qteMkH2p5+MyJBgw/WueBshccquYurX?=
 =?us-ascii?Q?lVpK1rTQWj2d/MI7k1JfYSZcemtAbR3rAf1MkpCkYhEcrnMrmVUr89inxYhj?=
 =?us-ascii?Q?NFcIRepUV06a8PSYFFajABlWSKNh7F3+v6aLSTSMa6+F3uUVOnB8zbYgPAPN?=
 =?us-ascii?Q?/MCrr+47oTH+kq8Aa4Mj4DkW8TLs+MOuoXak6+1wq7qP+X+QzJMvPvEs6qhQ?=
 =?us-ascii?Q?gRLBSFI4wlnKiCTKS1Fr9mcqX5emq2N239U8uT+EaiDDcrOF2oBRvI5/Mjs3?=
 =?us-ascii?Q?OBmHE805e7XWqJpzkHIlxMpOlf5cfnc66D8IiyxRcwtf+JXIVaG1eSGk5eLB?=
 =?us-ascii?Q?oFP6KBIRsulshd+lCsoXydu3V91K8pkHRhlvWcE25J0c3xeSsjSyrE0yKkdp?=
 =?us-ascii?Q?sAlWP5XaLPkVV4T5F96IUkONJcOSp+DjW1qOq7zRBHPsFAleBThWSUVn3A1U?=
 =?us-ascii?Q?zay7MmRtxGD8YHrxSOHGweaVIcgem1/lESGIQgNf1yO+jxF51ic2G0n/lrec?=
 =?us-ascii?Q?EPGlO1tCKj/J+tW5rG0kZfX4Zo14GD+ee4911SMmASta/VAHvgrESE7p3wU8?=
 =?us-ascii?Q?KE6vsq2l1Cw7/LyXoAJ6JhAbbvjIRnkVIPBXGYmevN4spUTNj6nM9LY+Xyi/?=
 =?us-ascii?Q?6NFo0B/zUZQV6b6Z59mEooSTXEcF8rL840mzqGEgCU1ZkYctEpIt91J2BHoy?=
 =?us-ascii?Q?vBJ05EmQxbPy048Zil/wuv01WCRCXSbZ8Q66Im1qpW9Y8Hxgw60YldD3YRsd?=
 =?us-ascii?Q?3pgPqlHAq/kUfNaLm1KlPRkN4T+qfl7p9Zh9GaOR8BymVcyqd0167DXbC9SV?=
 =?us-ascii?Q?Rw8hNzZsEb2UnY2kBKK7GhQNT0FtDv+xSFX5hIolrnZkA8hgNoPpDu6wqWca?=
 =?us-ascii?Q?yqspTOlPm9HQ4QG1h19Edd7g7O9owAazjBbjUIaCKSzqptlXT7BWS9Iqs0Rm?=
 =?us-ascii?Q?rsNgJcmkrr52ROFDeZUP4u0LNN4XUz523856NstvO9mjPHiHIu4M1LUjv0wx?=
 =?us-ascii?Q?3o+VP5UfF0BTfC2rTe+Uq5nMOrxZ1BZ+ZoeGJR5sLr3+Pe5zI4VYScYN5Clw?=
 =?us-ascii?Q?jETDNdgNPwBwvNwr0BUP9V5exge/dD8EMlwoms2/W46uvU2L77xSwY0vk7af?=
 =?us-ascii?Q?THwqNPEpEeCoaKE7LL02MzizJ1mLkVD6Cg8yhaRynnSQa9WFvi+fFDVxpknJ?=
 =?us-ascii?Q?98+c2jyLyOKfWQ/EdP4pYZ//9YC8bC7h7s/WdOxDFUq+Y8ttXLWKI16Yv6aZ?=
 =?us-ascii?Q?jkG6sFDsGELvT9cOdui1H2BHuQh3hlYt73U9nH26Mo74DrZKiLi2raPclF7z?=
 =?us-ascii?Q?QmXvKkCFhCJEawCuflSnW7vsdwLQf8PJXAgeXL2Lt947WjLF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5dbf52-673f-4311-55eb-08deda6b771f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 08:00:22.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWBBnJykB0XAPtxRCNtzIHbQfsRT+vQ4rVNe/oorccDM28wBBN4o1CMMmsfLtGYXeftA1Ba9DGg9OPQF9BBOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304759-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,shredder:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E58D67094BE

On Sat, Jul 04, 2026 at 10:14:21AM -0700, Weiming Shi wrote:
> fib_table_insert() publishes new_fa into the leaf's fa_list with
> fib_insert_alias() before calling the fib entry notifiers. When a
> notifier fails, the error path removes new_fa with fib_remove_alias()
> (hlist_del_rcu) and frees it right away with kmem_cache_free().
> 
> fib_table_lookup() walks that list under rcu_read_lock() only, so a
> concurrent lookup that already reached new_fa keeps reading it after the
> free:
> 
>  BUG: KASAN: slab-use-after-free in fib_table_lookup (net/ipv4/fib_trie.c:1601)
>  Read of size 1 at addr ffff88810676d4eb by task exploit/297
>  Call Trace:
>   fib_table_lookup (net/ipv4/fib_trie.c:1601)
>   ip_route_output_key_hash_rcu (net/ipv4/route.c:2814)
>   ip_route_output_key_hash (net/ipv4/route.c:2705)
>   __ip4_datagram_connect (net/ipv4/datagram.c:49)
>   udp_connect (net/ipv4/udp.c:2144)
>   __sys_connect (net/socket.c:2167)
>   __x64_sys_connect (net/socket.c:2173)
>   do_syscall_64
>   entry_SYSCALL_64_after_hwframe
>  which belongs to the cache ip_fib_alias of size 56
> 
> Triggering the error path needs CAP_NET_ADMIN and a registered fib
> notifier that can reject a route; a netdevsim device whose IPv4 FIB
> resource is exhausted is enough.
> 
> Free new_fa with alias_free_mem_rcu(), as fib_table_delete() already
> does for a fib_alias removed from the trie.
> 
> Fixes: a6c76c17df02 ("ipv4: Notify route after insertion to the routing table")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

