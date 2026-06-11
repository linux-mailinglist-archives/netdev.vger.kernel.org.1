Return-Path: <netdev+bounces-297966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GuXrGYlWKmqWngMAu9opvQ
	(envelope-from <netdev+bounces-297966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B366F0BB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SFiixOEa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297966-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297966-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B39B13004CAA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F7356755;
	Thu, 11 Jun 2026 06:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97529346791;
	Thu, 11 Jun 2026 06:32:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159555; cv=fail; b=tNJdK9QR152R32Vf9P9x+IaZSDxgjhLKQP99po506y5Bo1Gq4gh6QK/vVfDgeKmKUrqEj4tsDqM7MXvG+PYvAUwe4TQX1M+NxvF84cQmeQtmePKELYyuCb/sse3b6m3LGtRcZ6+hzHu6QDl/RaLgJYFPZYX/l36IAyK1QbPymu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159555; c=relaxed/simple;
	bh=C8GTcli8a/o9iyea2gwqhPHSASzqzuFuvrea+IPYCBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pQAUEoRWN12zRHKknwWvgEeDXM9GgkmApAxc5qahtzRsQTdyMqjMowUB7XYCWkKHYG0LUDKA2TSG4Wr1tmQAjaBhITFgIYrV4M1EVA16G9R2MGV5Z47YrgGiIFh4vbrrSZgvx97Vgny/S4PBt3OPKzmCOZs4DhXbTyGuOMdIVqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SFiixOEa; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/jdDrWJoBcjrkOmE7V5ISpug7C6Lb3l0VGcUrc+mNhlmGcF+DImz2wVuiaH4r9U8pUvDdeTU3U+92VX75ve+FGnBiVbCEzSgzfsv+aWabJsmN00CfEms2WeD+3jH2uBAmZkocilDPxEfW3btLB+4tA+sAV00czu+b1an/Qrt0Ro95iYWvw3eKIOTCtLhuNrwixPWanAzIz4TeUUvGkoKyrSkM2zPCodHb4iAOFb0BaT4TcjqbrIy9BhmB9t+vLSZGKSebWkLff5WpOJbJGVErc7j3QDgNuXy0jhebu92Lf686SydPUHLFADPehCfnOAlOiXrpUhYcBerUgJhh0tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAaywP0mvRZA8v+Co1M8k6Gh2GuEA3wYrPlC0160T5Y=;
 b=aWtGW5sNNxuWc8dkoUnLbtXJN/8NuafZmMjqevz3MFKsjWASOXZk+r2CDzeA4utgRjAIqOzYUh+MwcPtcd1yf8Btv17Rm/B+jjyUdKL9lIG6yqxu1mTGkFNy5fP39ZGAQXBSwCPJ2Lj9e7+kXunWd3ovVp41rUsJmLo4P1nlKGKWyh3qiULXOVCI7HryINMU/cXEu3jIpLCUsKA1NZ4I52+jdG58RyUZ5kb78jxBDad8t4OGs7jci8hfFUEmfiLll6DLhMDBA/pbgNmFyg5qxB+vtsHKyZSdXADi7qsl7ykfeMkRWLx6mn2+VmfZBtjlCamBmtAIRqNvdXdi+M1QAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAaywP0mvRZA8v+Co1M8k6Gh2GuEA3wYrPlC0160T5Y=;
 b=SFiixOEawX7Vphux1FNJLBkRp2z+KZ3xJjrlFO82t0n7lazgRAGWqKaWUCxG36tRbCzKU7wpyxDUL1nX8dwNJ+BntC+aSMdMOxFkNACUBEMR8a+Xdc5V/Nh3moqsGzSYk+ECfVzouSLQZ8cYVC09WuPmfr8FUnKLF9gy9PysHqKtldoNuHBwtsOlGFaaZw+VA71vCU+nuKCRTa6abN2gFp4+/wiDScfAQR1ep4H/0XZpyOskl3DY+YR3LhJRfn0UQc206/wuUBBsBNAAHDlh+NgvfoyO9JgstB7w96hSdqEevb3lyCF5Zm14hY4kUviUZl7mIsH9LQUdLKC+Rak1wQ==
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 06:32:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0092.010; Thu, 11 Jun 2026
 06:32:30 +0000
Date: Thu, 11 Jun 2026 09:32:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] ipv6: mcast: annotate igmp6 timer expiry
 race
Message-ID: <20260611063220.GB848847@shredder>
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
 <20260609081113.7613-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609081113.7613-3-sigefriedhyy@gmail.com>
X-ClientProxiedBy: FR4P281CA0238.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::17) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3403de50-82e9-4671-0d3d-08dec783369d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	33oSlzeCyzIluQdCPnIVL9wOfdDjVZrJdFlJZQ0nOso6fEyQilID378Abo1XKRZkAI8gBprs6MSu8plhJi92+pOqbuFOADa5JzYtnGiEXaAycnbix3smXXtjeqdo4k7ItCq7Ks7lzqOCKvi20bX4pFm088BYnGt746R82Gf2/vUnSWbhnd8ge/8hoSluWOaTj8pkKxsur+KMi9jr5R2D9DOPt9DndJxHI4wihPsOhNOuZXIGumPp+BJQk2r+zrroMAy9mpUoiKC+Mi5OX70V3O6cGCNuZawUS8MlJ9k+xwd6tVsF4mvQfpd6MPYhg6fAegEHvi2PqmRribHogi9I/gCJvNdZcMcmq25zqWzGIeheW1Rzm3taiRiJuozZx2hhOBsk4UJlpGUx1Z7n3vW56IlfIB3sZrRIs6hc6QEIOs/vyyDjaTG+V8g/PQRlc1wTfpdDmEzh9hijYsRx2g4jYGrIhpQGgGRnm2yjX2sqZLA4A1Rzp4omDPeN3ieWz6PLSHPqrh/Q2PTdpQ0vxkcUwIKQBGIeW9avd9u6q46WgSGasAbSQSbwm8lzyPQ3GryZfAYNqNvSDdjHKc9xja9UJjaMACUUuX6KyQe3FIOYupO+MGHChmfmB+bIfXVyZ0mK+Alzwqrnd3doYflQPo4EtXvemnsHin+kyqahIpaibtKIDBZ3SWovuuoIdVadkmtx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AcSWVjY6yD1sjYp/rZTBqLUjFy9vgr65rBvVM/lvOVuksIozUpT7oV/nTREp?=
 =?us-ascii?Q?pDTZnJy53d/jpSoR83r+l/SWuT5k2ZcWaZf+Upp8ns7D37cQXy+77bR5gN7W?=
 =?us-ascii?Q?6Llj0fNrube9/+iIu8UQOK4MVLFV/MgiSwxq/KVQd+MsZxzKJq0F5Plg/xEu?=
 =?us-ascii?Q?/dpkcoGR+BuqM/vwAYMZ13TLlm4TGCEDsHRssLxJsX2g1/6phjmir+ySmL+g?=
 =?us-ascii?Q?MrHkYyyCy+UVli0irODobsh2kZVuYbDNd4ZUtszVCk90q2sGnJV0+e0MdNes?=
 =?us-ascii?Q?AeM8Hquzw0H32V8kQjbu4tGBwLTkVRhYHSA9r1M/p+3ihD0OcmQhfUmNuRe5?=
 =?us-ascii?Q?kFREVkSEakOkHJuygfnMFjteY8F80F14Da2Q1/vYpG7S1csyNqWKIH5HmGbP?=
 =?us-ascii?Q?GGjzjucOY4+y6HSvQF94TK5hneM6Bpgz3vq72UVMBKlu+dpOvGPHZmhIn21L?=
 =?us-ascii?Q?+Z5FWqglBpWhjzR/YINvMV8XTitTFUElF8iVd6B1ITRQu3Qr/QeLFIQ9pxWd?=
 =?us-ascii?Q?+YCpuDYp2VOHG0WorBulPCVNp0S/H9T+at+zOPyo4MpGelZMHzxWyhqQbKq+?=
 =?us-ascii?Q?DKGQVBo7QmuiC+dvnJgRTo6p3KkMWxVLtjgCRds+lV2RWbdjLbXdSLU4k1PF?=
 =?us-ascii?Q?2V/bfNHfNFksRFrs40sHRoq46i0F4TSs0b9Pe2CzCPtWSdejYkry2omDkNhi?=
 =?us-ascii?Q?42qaClTszI5WZn8nyfDSRKYJ96rv5zYMsx+aYPx5Jj5002/Q8+d4Pu6DnIP5?=
 =?us-ascii?Q?ZS+ePKn4JU59eSbnjsUnb5GZEAUeotCQf1khT1CMdZChIs5CS98hwsO4ntdm?=
 =?us-ascii?Q?eUQ6A0+9TcUT7vmFlHtDTS0ad9fc1fE7z9btAT/xkYlXwbkAvW9MBW69EIQf?=
 =?us-ascii?Q?LTuG3eAPACa5BHAcUYUZ58hnBZmC6STanrXwOyx/GLSFlHzuzEb+ErVR5SL0?=
 =?us-ascii?Q?2GcDxeREltS1QMweLlLWnebuZFJJCFLNPM6/pbI5iTm9bWsFWxJSXB7THotL?=
 =?us-ascii?Q?ybvhN1rSfzaxrFIv8rn/dUfzi3v/wT/X86wH4Qu5/aBQAAy1LQa5CBIRPhgH?=
 =?us-ascii?Q?JJpmBbQ7dZCDpLpcjQIB+ODn8+50vlILJnEQxtEEobUbYbOAJC08S2wUe2l5?=
 =?us-ascii?Q?wyaf4M+xlIIVW5SlspFU4UM2cNABnnoy5rdCD0YVgDdIbGEZ0v+z+PUjMWLT?=
 =?us-ascii?Q?CLYq1EPvwLq/1+yy/5eUR7SeqTU7JTH/63hEPwNF45dXm2qvJwcTFolz8Sl3?=
 =?us-ascii?Q?hmVAtDmii+BuSIFDfGZLd/nG9YdkBgJWROjuhPVDewvTDxDGaHmstPpu0G+j?=
 =?us-ascii?Q?fSLx+QCkWjNQOjHjDKPaEoAxH5+nXdclGhx4OWkb2UfF4ZsLlO+FL6Y/wqll?=
 =?us-ascii?Q?G5tiwGHstzQUE8cTlULMtuPiFqIMOGTqMkEkUUkJ064Qeh0m0/xVB69+WuPP?=
 =?us-ascii?Q?zOxypSdSPrl5UJddJywAfKmFKKRMLZh33Fy5bL8yZ1royd7qWEtatVO1St4/?=
 =?us-ascii?Q?fg/Tb5iNQT0ipFUQIcgT1w3x3bogNDLKNMDRuWXhyh1uaqgM2ESJ5HzWxtEm?=
 =?us-ascii?Q?2wjXlN7el30J8NFBcpGHpWYeA/58yQkp8SLK/Nypas49NASv5b4DL22zheXe?=
 =?us-ascii?Q?H9flpmjqMMhIxJCa3RWJChYr9MVSzYd7Q0UCijAAEe+zsfirQ3ERSnffNlUU?=
 =?us-ascii?Q?ESQwPxqD3ANK8QZvEOMVFzqdrO7sqejaCC2MyydzRurUIER3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3403de50-82e9-4671-0d3d-08dec783369d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:32:30.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6njLmlnvKOFo8m9chbi8Y5tZUFjlW0HOocsUAbyFlyBVAHgLZI/xGxPsvf+TX+2nqAdp+hkxQDDPTVnZc8OXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297966-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,shredder:mid,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 596B366F0BB

On Tue, Jun 09, 2026 at 05:11:13PM +0900, Yuyang Huang wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU and reads
> mca_work.timer.expires to print the remaining multicast timer. The
> delayed-work timer can be updated concurrently.
> 
> Annotate the intentional lockless procfs snapshot with READ_ONCE().
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

