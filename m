Return-Path: <netdev+bounces-284788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELU5OLoh+2lvWwMAu9opvQ
	(envelope-from <netdev+bounces-284788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:10:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 471784D99D0
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C431300E278
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9803EF64D;
	Wed,  6 May 2026 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nugEGIfD"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD853EB81E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065847; cv=fail; b=LNM+tM0NGiTLAl5iydYK4w7+CWptFZ4EOthKqAEJwty/x1EGoHRVWAcouRchku6p6jwXpDS4HNCdowl9ktaAGjyyAp7tnksM3Ovq5CgTQ6tQpdEywC0YaAIOXqqj785KYbBZNlPSsf2FUq7oPwK4iBbtc+HgFZB0KVDDBKh/7p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065847; c=relaxed/simple;
	bh=yLgb1on0nPXzT+m7z8aFoBPByoVyOtBUxQoazGl2d6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cu+1Md/nguxtF4Lvo2q9Mua/MJTHgevJ8zHb1loeIHfjWLyBFAxIIa9xRiqC1kAN/1Z6pQULaFqkrtSwSaIfL8vjO2CG1UMxf6A75aWK98jcw2d79ZwLCCw2ruuV8XUh9GryGqUS1hc0M0voAE+lIe3aPG/94hUbX/CSiqK53UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nugEGIfD; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkM2AGIUGCNUTOH7ye6N6eZS5mL8crj2CdXnZFdWWo0LtuCvNozBoQ5JFjy7PU0vTYI0nPoaFv1HJTYYkd211WIw4MNyPdbDAZf7enfCdaPuYOSVIyLHQ0B71FkF6cyr6uJ3BvYWE+sJuHfuQHw8rOSJttQ6fMgSlhV6nvco3zHGRjWP98dYVgJkuHOmlSexs2o6lxXmxFLcKn9wGEZBc2yrBk/CKgZZYyZNp6H3eilsSXypMYYtyx60Oyk+L+f1qlTimyHueucZeTTjvzRnLEQoRjW9VxOZvnJcbXUU161Oehcs1WkypWo2nfaYQD0xuKf7IpmVhUde41eLgpWMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c1/+/vHYCnhkafVNJr8kEyP2hdoKOqmIBKHXVwBS9o=;
 b=gr80bU+xiHKhgWjcqn1s00fIJOHFRXypwArZh8fpd2WWhzL+ndYa4EH8bFIq/tmuotgZYZVXTBw0YMUf7l53XbrctxipkC+wcJ+RGINPZLutepUbSY53RHm58Myk1aicuPpmL3aepI5BTYbAAaqZn3lKDx5K2MfmbpHiBtIStWQV3YXKie1zvH/MdnYWEwpcZXG8+JKUq3SzGBP0czdlROkYDNNxQgE55PC0QX76r9VcsX8SrDpT4ahhRs57eHKGTJ8tET26uWmLLF/x1E4rx98i6uS24/Yu46zic0CLSmCtw09lXDPqZJwOBPQqXoYuAfRiMndLWriQH4Eg4yeFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c1/+/vHYCnhkafVNJr8kEyP2hdoKOqmIBKHXVwBS9o=;
 b=nugEGIfDb/cJ1M3VBRf4NczdlBCbGiHVatK57vRAtz4R/edqK9AH0iQhf/Ajen9NkSOmKnW9nxDWt9kqNQuR8LudxEmE40lDPmRCT8I4JoDggslz2+/cTzdNXATKtDAdMiQ7rfDCfvNeNJWMVGQy5rcV599XoDWmmW2spKW34cwAr0eUW22DTLj7JPbkFiWnDT+1Dm57y0sgRX9fsEpCP8bdkMvgQL18m0ZnbdD7kwOM5ZmFSk21k2aVVpozWTKq2TE2tV9tF9ryMb9+/gVNm6n0gxmT5tNAh0d9ei9SEejef0K4N8YAHX6d/CjQV5jgjMixxvw4zPqISl1Ucw3PIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 11:10:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 11:10:42 +0000
Date: Wed, 6 May 2026 14:10:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Damiano Melotti <melotti@google.com>
Subject: Re: [PATCH net] ipv6: fix potential UAF caused by
 ip6_forward_proxy_check()
Message-ID: <20260506111030.GA664058@shredder>
References: <20260505130056.2927197-1-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505130056.2927197-1-edumazet@google.com>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c31321d-2fc5-406a-284f-08deab601c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jmowUx8UJozFBmEZbW7pTCLmMhpoL1MMlCbUpHjP2eQBnD9uM30yqc77x8adJuyMEvbCYGF2HUM27p7TY1XYhzQ+Y44OyRDqQ2g173wX2Z9uLimeiGzGC/y/7JhnmZFcQwn43ChSVCt1+W1+pPUuFaS7O3c/y4cc3yu9WGXHF70enld4frJzDkpg033PaKk17CAbquIAN4QJ0zW7fD4to4ADOKYlxs6NmJBVNlK/t7oj1F/aa5hOlWfD7H/0dRFM8UILXKuL+CrlK1Ssln+A3xTrhP+5W+1xbiw1rgCSZZim2iQaOggFjAazP5Ki/ZtXVgp4NruoxwwuDbYIpy3y+UbYq2HKUcso5J6Gh8co4Dk8id7nAn4ZuSxhH0GNkuApIeC8h7R/hLrkpqa9bUGlPbK7un169oywbR3V9884tshSXA5fLZe4f/DQ6KlXlTCa0WEQWSyoPP7vnEoi1ZZMOqM3l8pOseHgecluJRTTGrp/op6T72BslvY3WihFJP60cRA0PuCEoiQiZc8U6G7t0jmbvN3RoGuyc13hSTe+aE41GcaUjxHqAoXgzpWmtACo9OoNsJeNtdLcygKDTaKxztvj2DtUut6wC0vLNkrSPOJ2jTPexKbJ7xa83ybSwnucdej+j11PUNu5QFSV9tv6//RHgKwwBuIvO4N17xMCgN9HNhVDNmiPz5RjWH3vJBq6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t0NRbelmo33/Ew++rOIF1puosmQlYgokhDwFmByBE7UobGCQKLUfM/kDBSjY?=
 =?us-ascii?Q?tfIj4M0IfLH+JteiDc0ouv9HlVync2Kh+rwho7s9wheFglxOunT9PAGQs0kW?=
 =?us-ascii?Q?I0Ve3cXZ4e0+83SNustb5ZlzN+a0sZhw094qZolV1izOruYPLSMvFWjw635q?=
 =?us-ascii?Q?GZi9VJOYprD+4PZFMs0zPv9Aa5tNPAl2rWMJSbQxvOQtefw11l+6BG63N8Oe?=
 =?us-ascii?Q?NgjvaytP7pbZl+x9wj71R7hZE+ZCuAvbQzJ8gWjRK4w7LTC/IYQ12nCtLFtM?=
 =?us-ascii?Q?OfV6/R5qZDOsHAacat3GAPhJ4T7VjWyFt+yh+GfRnfAQ/WGyrJ+rJ3YYk4CA?=
 =?us-ascii?Q?EPBDMC91dUMG3hSMCCAcncsQstwqVDBX5Dt8jJ+fRHEMFPmg5GZ4XPj1T/6Y?=
 =?us-ascii?Q?lHpbJZ6SScjeW+Ow26sFHNcSELL7fUWp5gubsr3Wsr1+f2BMSQlN3uR0owA4?=
 =?us-ascii?Q?N1ytdqzwR5rv2Z9ygaib+hb7UZBYavZAt7ffTpzscNSuLACt1x12C/PvVBSD?=
 =?us-ascii?Q?eoYRjSrkX6cHnazgIdNRjh+Xy1N0UYNCEpJ/TCMkHe1YhkNaqYlMmMMMH59n?=
 =?us-ascii?Q?SZCnU7k4Jph6dpwK1WzkMZA0pOKWwDdxSxyoMwjitD4C4tqwMHIu5bd4TDk9?=
 =?us-ascii?Q?KRZvbAoBmWUez37UD5V477JPhQ4bKuc62hOoxSis6gO3dYIKdv0OFWPrCCj5?=
 =?us-ascii?Q?FFUUVf1Cy0WirA1X4jtNehWlmGIVRjgG/WYoAJY954/KujGHzmb/YmRjta//?=
 =?us-ascii?Q?zK6dPMwoG6HypsjcOh0VKXqYBaLRQGPjQgOlaKOK27JZloSx3hTZlTVos1+m?=
 =?us-ascii?Q?0KAYanybVL/9Heh67Zn5uVOhzDOAK5TAAywFwnppTz+n3UBepJwEXijpJ0bz?=
 =?us-ascii?Q?3xsS2OtZhVKwtkvminKJLqTwjcUFp48XuUNExW0fDy9iACkzR/OdkNp4S4OU?=
 =?us-ascii?Q?BH350p4y66D2iiOozMlG1dDgrzOGxiWWKxAoN73t1aZWSI/NwOOX6bOhlioC?=
 =?us-ascii?Q?VLssrdaPx/fa2CZxRCa5UpCOqRFhY0nopq+rGZ9onvF2UMFHGAt+MzdLWd1q?=
 =?us-ascii?Q?9UMMimnavM/Ho7vh0NQ59r0XIHnkUjkHVs1BiYzsFtBh8WkeTLJMTeMlYQxo?=
 =?us-ascii?Q?IqLjuuWzZY6EvlnO02TlWUawwuMGD0KC4FR7j0h9hdZb3Bg/oOZ3VeDrDj6l?=
 =?us-ascii?Q?1o5P0XzvhTJr9I8Ab5L/lvOf9AXMT6MAMNVu8NZV0fgPOIpEvoszKeGcm1OW?=
 =?us-ascii?Q?wBkhEXJ5owXR9Jf+kt3vZctiOEMbcbl1w6p/5973zBXN/j0mms2yCPSGTc+j?=
 =?us-ascii?Q?EFKvZCFWQHf/Q+i+rAjG+MJbLKbIDIW95w+YG5JUIVtxyHkiiX44twbgUTD5?=
 =?us-ascii?Q?hNtGOJYIop5kQS4ZmO4ltxgvdCHi6a+xE6eL8buu0ccda90TSf3J1C5G7Egc?=
 =?us-ascii?Q?5N91BpDD1pS8pu/P9F/9jyH/BPPdA+0LXPFY4YPWE5gMOJOO+rf+IJMxEQJX?=
 =?us-ascii?Q?CsMS5IZY/2r1LHyXKTWTNU0icihNJDHMb1KjZTLXHYliWtvgDPy/F4sDIWcf?=
 =?us-ascii?Q?VbaP/TDLZAfzo2LHxvbZXldIxtJm2tVB/hWwVdtqICYITtn9dZZwEgAM1ytV?=
 =?us-ascii?Q?Y4b8a4YvkrvbZjtV9pD/6InvmVL1aayItVTVNRLZnp5u1hfv5hBMnhylcEf6?=
 =?us-ascii?Q?gWg5qcjMw9LoA9Dsv6tq2dxRyn0tLagWg7KV0SNviezuaAsQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c31321d-2fc5-406a-284f-08deab601c84
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 11:10:41.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6ojFxiv+EXTaM2GDS+OOtWlprQ/JGmqiEyydOQdZftPKzfoqlD4U2VF4p8/D8secN9wlBHB01hXUIq4+EzXZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810
X-Rspamd-Queue-Id: 471784D99D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284788-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email]

On Tue, May 05, 2026 at 01:00:56PM +0000, Eric Dumazet wrote:
> ip6_forward_proxy_check() calls pskb_may_pull() which might re-allocate
> skb->head.
> 
> Reload ipv6_hdr() after the pskb_may_pull() call to avoid using
> the freed memory.
> 
> Fixes: e21e0b5f19ac ("[IPV6] NDISC: Handle NDP messages to proxied addresses.")
> Reported-by: Damiano Melotti <melotti@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

