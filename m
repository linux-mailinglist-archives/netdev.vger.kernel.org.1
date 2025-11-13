Return-Path: <netdev+bounces-238334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F96C575BC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4244B4E1D41
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974A33DEC0;
	Thu, 13 Nov 2025 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slxWchsI"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782CF2D879F
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036338; cv=fail; b=eEe1pRvQXXbwBu/XGDEHCDa4AaHj2t+Lv6NmjTmBE9Rj5btEG461efvEMF93vAN+Qxx1P8LKYwMEJzDfZO2Y7O9M82+xcgLWgHux39Iagl6bSbexeMHLJ24c0cTcEQtJSDrq7w98S/k/q2ZrZS2hyOEuJbZABNOBtxVo/B6Cj4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036338; c=relaxed/simple;
	bh=ymK6f2aiPlvqBGePkQ9mBFaFk3u8VMmiCDS4NqHh1SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uWlCQRoP32n17sE3AmHcqr9NpfVg9x2Bp1tBtNXvYIDdM3a7dP8XFWdez2qnD5xbYguUIBt1lbfCxa/4xOPpb5mxRo0OeZi/eAggTyHy9w6ZsRSZsrkRJiipkPupKRWRwEVlN0OUny7s2kkWH8AYzdKAArK+9afplEJzUKdAFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slxWchsI; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taaxcsAjOS2jPNwV/zO3WHrTLm2fa0RGa5lqqjHCT9/T4FFGTDCG72uhJEgn293gAEvu3WIEyIr6oS4kxHF0TfIYprqDEfkZPB9Md7hV9DrEoSn90/Q/DdiGohV/ua7ZemFcG0n4SMNHRf+STvIK9ms+cpbpppS77t7st1mMtAXYYSoTWXiSpIk/lDn7KfteRnzGnbhZSoUx28M5EcCRMWnX87Umxvof/EkaUeXRgL/wp33xL1RI4qX5g1Odf+efnJELYZhExX8IiNImkErd0/J2Zd36a96LScitPOsj0RTFtvfgiAH87Su/ak3xFLwDSjQkwMp+odRXTX8TaGr37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCMkG0z0ZE9K9tI7YNEAwrZbtrORu3tHUd8o6yW6o/E=;
 b=ICv9SgBvROzLXhmu3bWb/BC7/sNC/lYJVGcFIF1ssr+nFj/TFtRRQ6/ttZ/lx3e+MLF2tDx+4isDZNNf8dTtgaQi33pIAtP313HLjfVUP4RlGqi4NX+Y3JEr5yX+A/xemB711X+12fiLZ/EtpA+pY7MbKITigmigWSC0DUZPxLp8EI4czCx2tRTiTKwC6e8H7Is24+CzOIt2r5b+VSAfeJ8NHbHS3rlwmS09C2jaAf/SmNLr9eo4CEY2+vKJ9Yl5EQWuFW2Vql/+lHYwSmzs+55McFzAfkxqnNDwpA7B/9gogDPE6PU+TX0oV7oP3j+95Q6AneHBseYotuFV44EtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCMkG0z0ZE9K9tI7YNEAwrZbtrORu3tHUd8o6yW6o/E=;
 b=slxWchsIvXCL8JmBrqLsLVhlzPyxKDJOOPeSJ7Zy3hNsVqMohruvWinkiv9gP5kbbSF42QP/MzogpEhJSHktveFWxGEuVPZvD3MenJOOXnMca4JCOeyjI3UhyVTEevWbsag8H5xxacpxT6OU/rPfb8tQURxzdqRNtHj+gvRTTkjoWD1mQs19U/UutmZNfc8rNocnH2wxHaTDRNJCmi5QerLKOg0h3EneuLW/S6ozCRlj7LWYnbF+a88kvOutUXv0108sRbEspl5hwWhSqrJqClYsW9ZD0F0GfHD895ZeGGp/1oCQC2phiXRdc1NDDbtg1M5fuG96snO5kIYQfcZqVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:18:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:18:49 +0000
Date: Thu, 13 Nov 2025 14:18:38 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH net-next v2] ipv6: clean up routes when manually removing
 address with a lifetime
Message-ID: <aRXMnmTapb9VNbc4@shredder>
References: <20251113031700.3736285-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113031700.3736285-1-kuba@kernel.org>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3b5ba2-1bfb-4f6e-f088-08de22aecd3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oyohz1XP8MkvfymnVGYBgOielX9LPt7J2rTtics+DUE5FUthr7Q5LaHaw/ju?=
 =?us-ascii?Q?qXZu8SsczqqU+plmw5CuCx5I5/z91OCKayzn6I551hlTeWh1bfDFg57NX+ow?=
 =?us-ascii?Q?CUJomIgiYCUywZd8rhbHT5uYi3RJIjZi5sdM5o7jcLNXpqTySL+nFGrFyR9W?=
 =?us-ascii?Q?V77BriA733pc88RHQTgwX7Vrph6gDsTe3HqNA/Xmeps0njt9YirKqB/A5REz?=
 =?us-ascii?Q?eAKZ2/N1ntGjOuyIF7NTnAElpptCNgEZ48MI2RNNm9qhC89hh+Kc8LMy3Feh?=
 =?us-ascii?Q?YitgYH3VVxESYVfXA70KCtQjYx3wywxapL6/vFUINaJjxV+AuW9QYHl1LL3B?=
 =?us-ascii?Q?uHZBWs9Hjo5nl7ZoYJup2HYPLBzugs9DyITGWocxHK5QpoygO9IuT+W5RGSD?=
 =?us-ascii?Q?XceyMHkZjOemO445pnJBB2VABIlVslaWf2Ng8wZDKC8nbSnmHqNw8y8FIr5Q?=
 =?us-ascii?Q?kHIrGL6vqhPSKLXpqQ5KR2htj9XNPfw+SPQIUp/g3dajnJSugZhdKK9H6Az9?=
 =?us-ascii?Q?yO5PR3uLFAeRhMNEUTVK/BBGSrIICT4JFXSYgYg6szZNGnYXE4264amPHE6z?=
 =?us-ascii?Q?/CggHRn3mTyurGuoovLaOf9/lNnb1R2h50HIwz90nSWLk2xMWw6jmTGM/kRv?=
 =?us-ascii?Q?Y6O1FvI2zl8JreuNVQfih6wliVq/UcxUS/4SRdDoFfvu327xqk0wqowtnPo2?=
 =?us-ascii?Q?tOWnrWTrOGfE6NXMxbBkh9dv+k84r24dY0gZ+NWCnkEnFkQUEw/uxuwDQH9u?=
 =?us-ascii?Q?nJ9d07NHJuKcySP40OIN8gdmdGlfEXM9zOqYOz4jb0wZnoNA31QXZaRpq0y3?=
 =?us-ascii?Q?tKcQLOvk7CL8M89S2fDVlBtDIaUmxXdnTW8sL5tQEaCPNBQtLWC0BzB/RrcI?=
 =?us-ascii?Q?U74aSTvSLbOTTmYS3oKxBeqNyEkX/1PHNY2dkNG4c3pPOkB/dENkRn6wj5KA?=
 =?us-ascii?Q?VSD69O2YKST0/gVKyPaQ29yvW4mAmet2CWrVhaMJeYg7IhhjyaXYGaDM6qas?=
 =?us-ascii?Q?xWQgJn0jmgfgCPdiGSigfN0GLn5lmFaWapYpXJFznHKNt3FvH63aaENgyEwP?=
 =?us-ascii?Q?oPT64PPxlOCE9d4qzk4BczSBhywuzTiXmcqo8mKdHz7cKH8B4mVHjAM7hxri?=
 =?us-ascii?Q?P5AArePv+p+x1zGlTydzwjRyUMRzniBVjnrTbHFpOhfi9v+UjF2Si4AVMRLH?=
 =?us-ascii?Q?SPj9VrjCEglJ0QgWsrfkZTgIcUdc6pMYcX3KeXhyOPdWsfYASB2ol0nLz09n?=
 =?us-ascii?Q?sKWB441Pqa6pBIrGhVSimgbRhUxGAnO/ZbGsgiAxHuhbJgnXNy5lifxTQ0KO?=
 =?us-ascii?Q?sETrvgdsUtmjsdrr8WcpPWAcr2aVbWdQni1CYjlFgg94acpaeZhXZTU+kSm4?=
 =?us-ascii?Q?Yc4iqrEPwA/QQ/vIDayonmFNeHe/wuRyYuYmZJ0eEgaI3rMimD+8GiMVm+w3?=
 =?us-ascii?Q?x0QuNu5gQq2KkFRqGjQ6nLM2HXJwWb6b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjOIGyc6wMOKXWnpmtgKRpHPC+0YyVbuI2vEtsGXiTbOQ0to18Gc49+8elN+?=
 =?us-ascii?Q?4JFwN5dhn9ExP/qfhB74EVC23KkspuBhMTtiTTIuoFzFGOCGhiiRPLPinvmJ?=
 =?us-ascii?Q?VobO7w9NEY7JvPXKEEvGnfUrD7/tPqdQ4akjihwx/gCCsyXJDWNo7wwOsV0o?=
 =?us-ascii?Q?DnyCVCpsuzcXksDXADUYcMMLfuI3rQG7tNNeUtIcKv/DyMmV5tPp4iKwnbdh?=
 =?us-ascii?Q?n2nE/6Fl9y+iyodIiahJ7d1NB/xm+KDaYxGds7W3ROXhRmCEl8MEeyo5C3lH?=
 =?us-ascii?Q?QzzoQlrDPvTSg2LPTrv4kzBtw1FSQuKy/h6ashm5yb2weKePeVuB3oVDPxmh?=
 =?us-ascii?Q?bpCYk1UbJEgG3IeKfVWYsRaeL6SQceAJPoS8zfKkcvAhuaUTnQoZRceRBVOw?=
 =?us-ascii?Q?J7IsfEVFevS1dB5ndVKNHtyr3COaeXQNByBhEzmQ3vposkV3yVM66RDi+dA2?=
 =?us-ascii?Q?dTbXCuTA5xd++amKLr4KEoAr2B8CG2vFneX8rZggpcxxzQENB5fNIG0ptxye?=
 =?us-ascii?Q?+S9Cmhha9accAbthYMVhu5SX4kN7n2F5oeVjor0y/wItY+x/GoYwmvqw+b8j?=
 =?us-ascii?Q?mGbLqUnvZ4im9patZsI9rVhTN7liPixHIaZ5kJTDBJP40AXYVvzw1TWKx2Kg?=
 =?us-ascii?Q?6oRVq/hrT7HUsSSynJ4HC1ieWy2hAri3hzYdFJUX0aCgBfMGkW3SnSWPXhA9?=
 =?us-ascii?Q?WlCF3iAJeEE6Yfly3lNR3leP44IJLNXSVLQzrszwgopxJVtJ1iy+PmqQ5Efz?=
 =?us-ascii?Q?R+NzH5FNUZOdAUyV53isQSMTvob0rdk1IVHs/pQx8mnCKwxMiq9CyZRWtLTi?=
 =?us-ascii?Q?8N86TqFVNDqARy/q50/yFk8y/33zDWdV8Nh/k6Ti+1Ae51Y3NVQpfLIeQXS6?=
 =?us-ascii?Q?m4SrMitkzWVRvRkGxiuM7VcKfGeK0LwB8U3QsOnSHuaySw6ONIOpDkJ2BjuQ?=
 =?us-ascii?Q?L5xLSRYUhxf0ohaX4KV1nDoTojnHicCip6r9v5AxBZncm1DLRjz9ZFdCqdJ8?=
 =?us-ascii?Q?ZPvk/JzwBEZwu0Gvyw+0cF2Z9VF4wVqjQPaUCNKh+QoT3nkJ6+9PmlbiNg2K?=
 =?us-ascii?Q?rfp0Vx1xYTM9zIovZYWadplQw3vLO6Jd9dzdz13ttXiqg+fD+vlG2KCRJjEJ?=
 =?us-ascii?Q?Yddsn+NxLkBaOHlCb1mmjvptfElHvIxaArJCDnGBvDHhQY2EUdMSPRjfkYJV?=
 =?us-ascii?Q?hAQ1TgDKhnjddCsEfsG0tQS13F9VRbqHHGy2D9sNcftRoTkCEiF6f42j/SpP?=
 =?us-ascii?Q?KgmaHVAAnuc8NM3LtE2Y/rrOaDOkzgMUd9CBmqUNsfrH1hcHR07sbjrTtuj3?=
 =?us-ascii?Q?XBn3HCh9wleqnEF2sQPaw0STe4drRLB8WNrjYLEG/ecjEKMHu/+U9Q6uQozd?=
 =?us-ascii?Q?sMtAJKNHjO+DSw+g1GWq8DraLTMNlZKcgrKt+68FIBtsB8Rk1/ufm6k3r1jo?=
 =?us-ascii?Q?TAEBgGv9AAdsklWNO2YltNa6QsF92L2Brir0I6uJFWwaR/0Ss52aUsTziiSf?=
 =?us-ascii?Q?VGuR4qSiS3VRkyXExvVciCgN4iFkDtrUzrjbBCv0wCGiEeF4LmdcmI79nYyx?=
 =?us-ascii?Q?/MQ+sZGYpqmZXsO/M+RbQtyA/vDYRcebKdhuytvy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3b5ba2-1bfb-4f6e-f088-08de22aecd3c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:18:49.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atFDg2F5s3zX/A7CbPm1oSgZ07XfkUcy2jGkxBvYAKF6DQnsra1Uf85XMOmiYWOC8qj21Mj8Row7YeyByE9W5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

On Wed, Nov 12, 2025 at 07:17:00PM -0800, Jakub Kicinski wrote:
> When an IPv6 address with a finite lifetime (configured with valid_lft
> and preferred_lft) is manually deleted, the kernel does not clean up the
> associated prefix route. This results in orphaned routes (marked "proto
> kernel") remaining in the routing table even after their corresponding
> address has been deleted.
> 
> This is particularly problematic on networks using combination of SLAAC
> and bridges.
> 
> 1. Machine comes up and performs RA on eth0.
> 2. User creates a bridge
>    - does an ip -6 addr flush dev eth0;
>    - adds the eth0 under the bridge.
> 3. SLAAC happens on br0.
> 
> Even tho the address has "moved" to br0 there will still be a route
> pointing to eth0, but eth0 is not usable for IP any more.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

