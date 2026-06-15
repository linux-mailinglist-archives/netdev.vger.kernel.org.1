Return-Path: <netdev+bounces-299349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lEUXDPCqL2pIEQUAu9opvQ
	(envelope-from <netdev+bounces-299349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:34:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CD6843A2
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SwGvIcmA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299349-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0873302F27B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 07:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD493168EE;
	Mon, 15 Jun 2026 07:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB82459C5
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:30:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508624; cv=fail; b=EdJJU2qMILVrcbID+lw+Usf6MxBEN+5NBlFQlvYeFlCiT1I/VpF8lcb38IeYZUiU9OwxHRGnpkiCdc9eCEUqu6eXA2/jCBPUdKNXDSbboMHWyopw8QHB6vsOAy/AtXWyORNVB0IRDBL1yIsDcBftYkkqp2mKBgMBQgviGzsCQLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508624; c=relaxed/simple;
	bh=L8No83Nw2rWYn6F/tzg2uYh/YBUth+2YwlEHC6YYLCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aq08s4aEp4ch0lECUIF1d/ohUv/yblveTGeC2lTIgsQR7f2mgEVwj1KMeEhk8+qUiQJs7gmrhYo/ElRC+BSFfNZRp+Jd862j/EWZZlm0XZ276LzbsG5bcTcK7m7xa5cgjs7mnK3W53P4T1Lxb0PU0zhdZFTqdc3fTO4aM6kk9To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SwGvIcmA; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5+jxVKTJa/ZAjcOWKypI4k26sUe8UWyDP6k8HB6dbJBS6DisMc/6z/SzjyPscMNcftrg6lc1giIucPFqRv/H5Zr5d4/fLMVUsx/807FOX/tTA34R6cPoHXzv20wAdZkPsOsKbyqjT9VkQ0cOqRlCBf356hSEA7S+UUnWxZ9w8TwI9h0N41y902gvg2YzahXl0sX9Hr0aOh4kuVZMPuzAfJlRUMOKWms7LjLoPK65D5EXjdiYkI6f6wbpZJN97b2XpTotmF4dVW0GKsvFZ6MRQwvH9VwVkBHYON3OEkIn+54kw5sReWMOHJkRqZKTN8Chc5kUK66td5ToIPp0YJQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+pbB3j5GEXcvx+bf0YEUx8nmsy3FesHCy/+rwQ9gB4=;
 b=sPG7dV7mUkuovwrO1VlwlLAu+rjl5ufW05JiVhYryHyQtTMmB1BLV4smJXWlpNwTqp1afjUvIXy3FU+k85mUBGOasWeLcHiX9rjXoAf8OmhoKba4fAzIRRgrJcGtKl4d1GuTM8MgUh8m7pZjbdM+SEVOiX2AOPYOoKksRm+yDDLweIIv8y/82keelJ1h2ei4vkzg5t6dnsS/Z5AesJ7bZLOGCpwMyO8DxohUVgOh9hTGe700BDtQiy5m1GxNZHUmCNkoPlvTcepoWQEnvPgsxLgMU+WXQ/FYKPxBoxo6l2sRXgbImuuhnaGcThw09LxYN8yXvz5+x4S4Wahwmh+CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+pbB3j5GEXcvx+bf0YEUx8nmsy3FesHCy/+rwQ9gB4=;
 b=SwGvIcmATHw7mWjKVvt1N1XzjKWO3Y1iojHufNOJDwVV3WNY4K+bVK06Ej8C3WoAVlqDc3iK70ByQhz7m1MR9dHP/mNCgAC6czWolFqSYUWhZ8qJCbhL+ggDFG9bh6k3ntTwHxwhiCaNSQyVnVR5vgYOwHyKAZtuqwQV8Se4G2cgNrwhLVXppu2KHDICSVa+4BVRSAV18PXRnap0bTLT/aVk5S5f5KUwlSWy238YfvIDTuue37AMVAStQBjv4AlZlKQx7op/cxJPkxxgL307cz77umaWaGoczy5YZjCYdSqIXinn6tUNrSMxlZ1tv2y4o1LjByHIK+m2Sg2FudtDnQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:30:19 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0113.014; Mon, 15 Jun 2026
 07:30:19 +0000
Date: Mon, 15 Jun 2026 10:30:08 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: [PATCH net v3 2/2] ipv6: account for fraggap on the paged
 allocation path
Message-ID: <20260615073008.GA338677@shredder>
References: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
 <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: a10a8a6f-0eb9-4784-0e37-08decaaff370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|18002099003|22082099003|56012099006|4143699003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5YVDXZIlVPJanip7TlhHbuutprIVfu/c+EjCRNFHly2pSWQnuri9pGrXCNQs7HeU4/XZPCabdXwz8e2VayM36WyzypqpgHbnYO4DMWd7DTrWYNLyLexbYcNWkP+iMYlEDXxNkGZgw6uN+S8ZopAjOSZnQmmQpFC9jQrEORzvSXceuBw8J9KqQ+SIv/8smfgho+4X3ymRFoyrxiKLp3DjlNK09ukI2F/SJHb8dF/oS7ZkJgy+COe2BP81K3lvhBbXXECbrv0lHFDf+CPfoaXXLMDOwpIaAZJN7tJiCacCqN6YWwJMxhuIUrXqtd2nJ/7feXXvryywN6oxmWCFjoN0BX/3r21VoLgVYL3aWoB/60DYbfKQzgspvR9La78J8BF3BR9RhHIu2LCL0EbcYZVZhL3bHrK7+4l1ADcEOWIKvLXnc/U8iUPuoNz5MNZjkVJxwGCPJH7t3UtWyddlna/9RqepfyOQbQ5d9ix+RHU5AnH1Ux/fE0RZen8XfPFT1GU5pfDZQBOD0AMEiex5QWgbKD1hdVIdLuC3nIXNSEqF7bazjpR7KvmP2DRYGq9HaMPSVz+aMEV153QcjhDxbkbgOskk8Zlvq+W9AHCr5E3c9aXBCxth6OFNRb84qM0DcvGUk9qraCbs7468pqpACd+HNC8ST4f3kl+7OrD4OCPE6Hoe0n92XU5Rw+N2nkAtxSxp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6p5vtj4s1ZiIpOROKN2jo11Snf++vcUY4gEks/eW/GD160E0RWF2SkxYjf6w?=
 =?us-ascii?Q?TDCP8ew/rrhd/6K5nnOg1x6ZucSlg9kOPtxROq5+lvTgU4lh0TK3nOFUpQ8v?=
 =?us-ascii?Q?QP632UFVnAS1TveP2BZGsDnxFSp662URQX2IoSh73yhUxVudmWVKlbD4KY8w?=
 =?us-ascii?Q?GC6/I+kW5WKfH6kL+UU1EKfP+uANBXVmxd7pSp1vMpNudSJmU60TGngvI7Ny?=
 =?us-ascii?Q?8XajXr71WJ5cIXqVsN2DaSezB5edRK+/MJ4dm6LkWhqwcqDGgAYRfkXMPmsw?=
 =?us-ascii?Q?NHEENJqvsSwjSDhQbgY4fJ3yFMPaxb1++VVkbpUDAO1UQ0sJnQAuuLEcDoV2?=
 =?us-ascii?Q?REV8raMWaFBJ29v8otbuW9hoKka6NhmSWxyFBFgCujfydEb40CmbgnrnwPn5?=
 =?us-ascii?Q?TNw3GBBcRV3heL24aJSzlMC+20uPntETWaM+L2yom5Wjwfn6KXA4Kr6/f4Ku?=
 =?us-ascii?Q?j3+IBprSOG7PZNFFZrnYDJzQlUL3qCFvc0BDjOPZNuXV34/D6/GW6SC9Dhsm?=
 =?us-ascii?Q?nmHS6mDP0zV2yFpiDhO6UG8NK/vAIfOWzjvgZ4vhNJ0U/rGgPnjcEGhhjYZL?=
 =?us-ascii?Q?yYOiwzq+xjpZW93COE/xGeO2yyGWSGkQqcYYbEULqq4Cc+EemQr+TB/EyYRH?=
 =?us-ascii?Q?kibNHLZ2EvCCoo6Nwux/r2h5qdtowBgioeiZN/aiNF4PCxagxjxLMNiKPqhj?=
 =?us-ascii?Q?uR68sUrfbm3wd/+sNzs/Cqou7eZpUh69ChLtGEL9SmuO/zkfXjDVtTPWXG/r?=
 =?us-ascii?Q?76eJytHM/DRq6xUAU2upQN4EWQ9CtJJ3Eq+Vq2mqmLwTEpnfb0gH7dTrcJCN?=
 =?us-ascii?Q?gvrnvuYpZqk2D4DFg+STcPj2LmTBlTU501wD6rjsP2/9HUftESjIlYleuoK/?=
 =?us-ascii?Q?4BkSsZ6KUiGwKcBt0bcvkJADpcSTS7UhwCYerNLC5JZhKwwTgeFt9enZ0B9g?=
 =?us-ascii?Q?TuzMOqChSDkKPB9agc0mRXz4AxwX2I5+pHg4dWvbv84UCCs+DnMo8xgbr7s5?=
 =?us-ascii?Q?8dTSAegrGCm7VUyu9eDQssgoCVwcRLtsBxtLsuPI6TrSzbw2ZTSXJSftg6LF?=
 =?us-ascii?Q?0WMaLuIgf8jJEgHY9UJ65ndPYvzLIT/NUsvJLAUpOSWLIoTpDKMke0j6JBH/?=
 =?us-ascii?Q?8+xkrfE6cxPyK/qvihdM0O1NwNwMR7znnSH0WRftIdum5qFHks2gEjD2MICL?=
 =?us-ascii?Q?C5fqNixtNLVvhMA+KC9pBkMFqdkzCjcen4H0jwcQEsXAAeB9fCLtDN3UQJWq?=
 =?us-ascii?Q?QaKVsh7tXhk1Fw+AtVBhgOMpSDfUZttaM7oFvWFBX7BZwiL9wchy8JXcboaD?=
 =?us-ascii?Q?ynTt/Klgfb4Jz2g8HmIDPEbSmDgjrUGgjCyqvdRGR0EWF2ID492cczaA3CX5?=
 =?us-ascii?Q?g8QyB05ag3PKhDZTtjOfKIlsMbCuoSaIWy95PNKOTqD2VSsWvMrXvIJsCOD0?=
 =?us-ascii?Q?KdVy5zq8RFct2IAoTX+kvxLm3voMdn56M1JrIBeQPR/TpMIzlSyNZ7N2/rGF?=
 =?us-ascii?Q?9e5/QO2+juyjdr5Bw3PQLZy554O1ADLzp+996SNSDOZsHRwkECLZ7wuUadow?=
 =?us-ascii?Q?Pyp8dUnnSD+qfJ4lGQhXaSOX1b59Q8F9DCIv7EivSfu6NVcUkGbbR4L3buws?=
 =?us-ascii?Q?x54t3ZVv2dz6KNUKd8pxklr1efYNZMMgbaNR0Mx0CeOLjJaEQy4eOYwWeq6W?=
 =?us-ascii?Q?4sFaMdeCILGczcnEsHjmubXwrJewOCWvvw66cRIeMo4GNIIX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10a8a6f-0eb9-4784-0e37-08decaaff370
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:30:18.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIL+KOlph0IMvmCXX6G+M5kTfuNPgGT9LD7/cGGg3bdfeoouor17sSNPQHwrL8w6Gg0ruxK3uv98LFOX2YVWgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299349-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:qw3rtyp0@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,shredder:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 834CD6843A2

On Thu, Jun 11, 2026 at 10:34:13PM +0900, Wongi Lee wrote:
> In __ip6_append_data(), when the paged-allocation branch is taken
> (MSG_MORE / NETIF_F_SG / large fraglen), alloclen and pagedlen are
> computed as
> 
> 	alloclen = fragheaderlen + transhdrlen;
> 	pagedlen = datalen - transhdrlen;
> 
> datalen already includes fraggap (datalen = length + fraggap), but
> the fraggap bytes carried over from the previous skb are copied into
> the new skb's linear area at offset transhdrlen by the subsequent
> skb_copy_and_csum_bits(). The linear area is therefore undersized by
> fraggap bytes while pagedlen is overstated by the same amount, and
> the copy writes past skb->end into the trailing skb_shared_info.

Nit: I agree with the conclusion that the linear area is undersized, but
"copied into the new skb's linear area at offset transhdrlen" is not
accurate:

If fraggap is non-zero, this means that this is not the first skb and
that the transport header length is zero. We copy the gap bytes just
past the fragment headers:

data = skb_put(...);
data += fragheaderlen;
skb_copy_and_csum_bits(..., data + transhdrlen, fraggap) =
skb_copy_and_csum_bits(..., data + 0, fraggap)

> 
> An unprivileged user can trigger this via a UDPv6 socket using
> MSG_MORE together with MSG_SPLICE_PAGES.
> 
> The bad accounting was introduced by commit 773ba4fe9104 ("ipv6:
> avoid partial copy for zc"). Before commit ce650a166335 ("udp6: Fix
> __ip6_append_data()'s handling of MSG_SPLICE_PAGES"), the negative
> copy value caused -EINVAL to be returned. That later commit allowed
> MSG_SPLICE_PAGES to proceed in this case, making the corruption
> triggerable.
> 
> The non-paged branch sets alloclen to fraglen, which already accounts
> for fraggap because datalen does. Bring the paged branch in line by
> adding fraggap to alloclen and subtracting it from pagedlen.
> 
> After this adjustment, copy no longer collapses to -fraggap on the
> paged path, so remove the stale comment describing that old arithmetic.
> 
> Fixes: 773ba4fe9104 ("ipv6: avoid partial copy for zc")
> Signed-off-by: Jungwoo Lee <jwlee2217@gmail.com>
> Signed-off-by: Wongi Lee <qw3rtyp0@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

