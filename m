Return-Path: <netdev+bounces-284722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI7oBhjo+mlIUAMAu9opvQ
	(envelope-from <netdev+bounces-284722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:04:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CF4D6F5F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3323302A063
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A52367F59;
	Wed,  6 May 2026 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CxynK1iS"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98632E141;
	Wed,  6 May 2026 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051030; cv=fail; b=NLNo8EUOQ+Lo6Mzhc7mjW3+Z+6YeBKEErLsQead8q4Ia5UuOT8Xf/Z3ORsAZ2DmloKjKzKlbG9vfbNKkU/hVqhnPOSHK/nnay2wxzyhvLtY71RUhy6gz/0O5nJA/cAV+tLbBpSyUHKLU0zIek7XukycZfxYwvLASzvt044XKyqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051030; c=relaxed/simple;
	bh=09TARG2AYzZZjcYNmcI3LZXLrHwibksTJifrdYWq+wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRdvDUMeo8Oq65JHaONuliRyRNRuxjk/MizlN8XWzH5EdftW53KgNz9uvdBdzNUafC8KH4TFQ5Ku9N9ne9V1HklzdZekiAgRwc0YnsIs0jcRQcHrsspAxSLHfdS5hyzDRYXJdikZmpGZpp9stdK7r1J3m6odFH6jdeUgaOqU3z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CxynK1iS; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGS1Y24bliPZsWUWrfcB5BKJadqNjCc1BghuHu9BExuns6mHmFDABIJOyX8Bx6MZ7p1VqhsVakkmwXEMAmEYwRd/UxXragrUd0sJzjn68xxvQSbgLqorjUjzhVxRNaRnc67j9ka2yPk+DTcysfgeQWOJmEBRDpiRXrSyeTzGYmZCewM2ifDLM9bdznrvY1SGohV/n0cGi0DuCnDunqQ1LQpeY/GytP0gm2U9JK95obHomsYFyg5tm21L9kRxI3bukhdTMSGCVzbok1LA4qdUq1+XeHrRIjw4IN/UajCxSJnYXcLWSNqjjtUNPRRsXp2iyUZADrtLCLDbAYDFmz95nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL8Sz3IyIJfPG2jaaAsEZ94wmQP8MBjpZsOMWuFBw3k=;
 b=Ux4i68vqcLcISgXiTP2E/JcAE/CAdn3h5uNVuPAN/rtTeQP2FZchaOlKQBEwNkHc+NZsXWiqS3CpTXRu/T1aZiIv4oJzheyUNq+Jk5CeWvwNx76w6Gvpw5Wir5Ro6p8TtXMEBrdXh33mmMXqJjT/gCSqGITsBl0OngFcvQcuyMeYIYygNTbhdtus6Pl1eYR9C4AZrSvrxuDDm09vZ8DRx4h4wf5hOfoMqE5STGO2uSufBB+7iYHK+bAQ/jSZ4F8vgJGUZ/nMEOCe9+8dCmT3sDLUejmblHN7maXUo19okIc2qaE8n9UwSOuK+YtVcdvQ/WMYeofHJQAkd9lhVcb7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL8Sz3IyIJfPG2jaaAsEZ94wmQP8MBjpZsOMWuFBw3k=;
 b=CxynK1iSAD3/dq5FBCQrDxs7VC/CJDGXa+t/ZMjj4d33W7MKdkyEenz74K7adD6jbndCM1+5RhQH1sa5ELvdOtYxafao2m5HtdgVtjKjtVUahW+A+b1losz0ZOhT3vzHvYHOFCDZN3F616+rX836DLg+Iy7fIrBwSpGbWJsIwI195WaQPfasBgwZrx0Pxuk4JmDzgc4gw4eyJEDrBPtNm0edQjwjw9ahuKXX+IJeMsDkaoQzwA0Cqfh08KXhjQm+KbPGW/8jN9mDgV0rjTYgYYoO+ucYX6yjw3sDYIwGT0J6HMn6jiCmhzFvzmqJX4UCtkcXJ5449L+Fkr3njZXAsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:03:44 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:03:43 +0000
Date: Wed, 6 May 2026 10:03:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
	donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, razor@blackwall.org,
	andrew+netdev@lunn.ch, shuah@kernel.org, ast@fiberby.net,
	liuhangbin@gmail.com, daniel@iogearbox.net, aroulin@nvidia.com,
	fmaurer@redhat.com, sdf.kernel@gmail.com, sd@queasysnail.net,
	kees@kernel.org, nickgarlis@gmail.com, amorenoz@redhat.com,
	alasdair@mcwilliam.dev, johannes.wiesboeck@aisec.fraunhofer.de,
	petrm@nvidia.com, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat
 netlink attributes
Message-ID: <20260506070334.GA617302@shredder>
References: <20260503073532.2138165-1-danieller@nvidia.com>
 <20260503073532.2138165-2-danieller@nvidia.com>
 <20260505190044.0608dfb1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505190044.0608dfb1@kernel.org>
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: b196ef58-5fd1-45eb-7191-08deab3d9c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hqs2tbC+kYEh5vDv4MPJItsXD2enLK59rknUIXQfIOC5kY5rNLx48YM6q/po9tah1US7n/Atm7VpQYrC8ScirPSTE/rua7Ug7YCbuj7EB7zB5a6Q3AbKLemohFuQHS1bc3udgTHyum9aeUBJe8EljJ1X+ZTuA5+F8Fjqw62Io5Q9o0cSjVb4jR9HfJxw1DxstVEpLOOAoFHmR9w7/B0TQlherx52jO+lVBMlxPgYETY98nyaChbsBiHiTbIkEOo+KZV1qJl1UK0mcVGK/KwOzSQYdh3urnzVHIqYBtypZ7a9QuzAuUx6PTgNC79h9h1skoC1nny4Y9pqRQ30INCqo8fOeJeNqB3xjvl0qqpzO+c4MlnGIJA7xxAdMSmYqmnBxyNKNPR0kEnv16bjcubYW4EGcNb0asZRXtzACRLntjWr5RO9Q/eWQAciPRAzdZejejc7Gz3y4G2Zqv6FezRJkVJsbXrLbwql18hk0uTyCigsj885x6Jf/+Wji3Q4hBBr1g66pzGFbGbyKYgPBAJmm2k5uyhHwzVfB7zarzjCciikHh8mrsRcBP7x9Bes3WhrBwE4PoWOfwnQl6qx+A7FxgH5c/tqF5dOj6wBcoCwko46pXwAcdTPSMTuocseXuNEOxFdrDnnVkJLxiswWT4aPiCeqBGZ0WBtIWSkttDySNy6o7nk2ML38yAwNfBC7LlH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9y6nqpQ+wG4IVpqejR1n4mQZ7vc+XznkyzPBORDVwvngC9Uk/Ez++3km/5F?=
 =?us-ascii?Q?kujz7w9FZFyiTVGtWrCKL0v3tVJ662V7CaqXpXfI2PseVuTG5OBLqekv7tRQ?=
 =?us-ascii?Q?X4dRiynIKEkCinZ/X2Fu/S0KaqhdKs6Jb+UQW0xbU8bpNMXc1/cT4gKwEOcw?=
 =?us-ascii?Q?5s7S4OouEHM16nDUMw3Ma6DvK4gOAI6wAsqVWCtvsQBCWpgpknyt69fSCK4s?=
 =?us-ascii?Q?TiKWiFsCEhVlllBay0Wnz/g55k1TuTWtIWlzTwT9rM5M2s1ntyF99I0rt2pa?=
 =?us-ascii?Q?SJw5Se61YeLokX3pbCW6JlCbUrsDKamUFJPzR7cliBAvecviwZvN17m1gOEy?=
 =?us-ascii?Q?ZeYwQxK3FCWzA4ktH6VUd7dY+6abeQsxD/Why+/KhbrJqnP/Bojq1BaoEsee?=
 =?us-ascii?Q?nQUre59Bn7yPKx1H6cWeSuIc5a6zbHphjda/X0UpiN59b+lsa6oAcim1g8xo?=
 =?us-ascii?Q?YzrYdUbQl2c9VKBJjd1Xz2q8SBoZkRuvxuNV0mqOLwmU7vq8QkuJWwkEUcNZ?=
 =?us-ascii?Q?SUZjZo7ZfaOcKiRwYwNTMCmNF6S12O8opTopOP2hRSdzeXUWleFz0HwQ/hWP?=
 =?us-ascii?Q?MUvqiEtwaoKkc1y9kYbyC3uZtIVUBaFspo4Q5htFBB68l2A3gKg5blNeJkb9?=
 =?us-ascii?Q?svWdoQNl4EKYuXQmI9NKeQYX8FeLC46ORgK+588houBqih1CsA4xZ+jrcPjo?=
 =?us-ascii?Q?/3kqSIh3kqCCTSa8jvyOX0UeDz7OlAWJpb8OOMFX/gLNkU4sjaPppPHqLfyB?=
 =?us-ascii?Q?7Vi1KvZlX+EYfTcqcw9V8R4Cc6sGiFGZ3i5JZnHnL1F3wMFXHOYKZgf1kfWF?=
 =?us-ascii?Q?5DRFae6PY+jiHj+fdkspIEE7U2gANDrwK9bViTWXIZ7j5pKJOO/UgAlXsiw4?=
 =?us-ascii?Q?edEW38uE6OnL0BMP9GSL+7+beOWPalIRcyBSh9DIkcEjnC0DsP/xrfGDLv51?=
 =?us-ascii?Q?SNc/hc3CkH0szCwOnapEQh9ROezJSbyDZh+NQ1l4gc8wIDfRWrEpIBRnwVrU?=
 =?us-ascii?Q?ou2aQCRbKqZSDPfMOSYJTsNkZS6r/mTDsbhukboEA0DsbVsruEnmT2PO5Qu/?=
 =?us-ascii?Q?0D8iZGbBFd+jmhmJUADsDuNyCP0diC7qjARhRwX4R9RbH1rEfFoScsmr95qG?=
 =?us-ascii?Q?trNkHY/1h5l8Ct8RzjKrLRuSrneD4/Y0pfdP8mEdXWuH0bDHzITfrqGPIyB1?=
 =?us-ascii?Q?P+ITcaqopclU1PtO7LTI7z8ZrDnv1YXLOjex1WWQa/yZ+/ZQUF0F+rYtJZ7O?=
 =?us-ascii?Q?E65vp4p8cG53bb/oJ31UNhZUmBQx9weVSh062N/spaZCvhBb7zPrQVXuZCUA?=
 =?us-ascii?Q?Guzhf+NyoFR3qxq3pz/GO9qhOHiA0fipjTCtxB17+3hm7x/9D+obPXlwM49i?=
 =?us-ascii?Q?AhAjVinQs7YSkN0S5sx8EPPIr/+d09JXglQ2jTlO9eAgyzNEAiAoZSy6omQC?=
 =?us-ascii?Q?nNm3WAROqOno49s2S3fMhs7jQ1uAFu0aCzypDKJQxmg4TxWg9u+jSJ8hdP9b?=
 =?us-ascii?Q?kx5CTouwZgSBpenT9kB/ETaMSCsIGoEX4ykAJsVXiYSM5ba1+HRDitKwG9+M?=
 =?us-ascii?Q?c4n7bICG+OX3CYUQn9jXjAHlwPG6fsjt3wAtD/ZI9AuvDxiRQ/LleBF1b9KD?=
 =?us-ascii?Q?Vy5yyiyDXHy+XbHM/aMH4X5g6N1OiZLx6/op7Vjf6ISLLrUJRJAbSDodJQW4?=
 =?us-ascii?Q?u7Kq+8zBSptwvNaxK1Ux1D0jKMNXwUnm7zD+A/2gN3++A3/H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b196ef58-5fd1-45eb-7191-08deab3d9c2b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:43.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKKZH+l0abU8t7JPcxB8bXTkEzQd7c1/RSXf0K4BBc3JKLuwv8Z/RXlhBAxGr1ctDLkUXRRuzKwR136ZUPNoWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
X-Rspamd-Queue-Id: AD0CF4D6F5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,blackwall.org,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-284722-lists,netdev=lfdr.de];
	RBL_SEM_FAIL(0.00)[172.234.253.10:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[Nvidia.com:query timed out];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[Nvidia.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]

On Tue, May 05, 2026 at 07:00:44PM -0700, Jakub Kicinski wrote:
> On Sun, 3 May 2026 10:35:27 +0300 Danielle Ratson wrote:
> > --- a/Documentation/netlink/specs/rt-link.yaml
> > +++ b/Documentation/netlink/specs/rt-link.yaml
> > @@ -1700,6 +1700,9 @@ attribute-sets:
> >        -
> >          name: backup-nhid
> >          type: u32
> > +      -
> > +        name: neigh-forward-grat
> > +        type: flag
> 
> I think this should be u8 ? neigh-vlan-suppress looks buggy too

I pointed this out during internal review, but assumed I am missing
something since almost all the attributes use flag when they are in fact
u8. We can fix neigh-forward-grat to use u8 in v2 and change the rest in
net. To be clear, I believe the following should be converted from flag
to u8:

mode, guard, protect, fast-leave, learning, unicast-flood, proxyarp,
learning-sync, proxyarp-wifi, mcast-flood, mcast-to-ucast, vlan-tunnel,
bcast-flood, neigh-suppress, isolated, mrp-ring-open, mrp-in-open,
locked, mab, neigh-vlan-suppress

> flag is a type without a payload, the presence of the attr is
> the entire information
> 
> None of the AIs seem to catch this, I think you may have over-split
> this submission a little bit. This patch may have been better off
> squashed into patch 4 ?

Related: The AI also did not catch that the spec was missing (easy to
forget for rtnetlink). Do you think it's worth adding to review-prompts?

