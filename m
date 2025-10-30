Return-Path: <netdev+bounces-234299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C8C1F03C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 624F24E9076
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA531A7FD;
	Thu, 30 Oct 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q8jdI09N"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74EC309DCB
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813416; cv=fail; b=qBcUKAPp1OXYrGRSOSSfoWC1YYpnex4cS5fuJpcgFCYRYuKp04IWuzU0GIs2abg+m3Y6ZB4OwS9BW893V9VfInVHWkOiSM/JV1nu9hSNecjhTtCbb1E+FuDwvLZfdLFipht1mGQBOhtw+1TKBY2ONaGWLNFisgmM0w0p+3lcFds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813416; c=relaxed/simple;
	bh=r4f8hXcVbrhaHjuvg0tQBwSODNMHtIeV7MftR2rmRMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n0KqHRSFDouEndY9gFz82e+ln4brhtS9wKsFo4UDo+UV20Fx/G1ZqtLW38Fq1Vt4efGprkAUEZrjIMw1RlpLSXZp6vjYP8il4K9LTEhIuem0Nb/1You3BhUuvN0IillPLuhi0K8rbJwGYvA6jnTzfI0J0YznowOKgYBvmWW/egg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q8jdI09N; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sr3X2DRrQ8R7kt9RfIXlfr0f4oOijt1hTP+hf1VRgK7Xl7LJkhsU7lHqo/C8jtmwa8DtJgV/CPoKiuYYcP09BH3R87U9WmTudaXfR/ZalbYBRxI5n922qmfzMjGXTbXz2awTGeZkNUvbv+Q5d1E2JKmQBixlx3mq44J73pvFzQMGU1MQcqYIPvnRipHtISVFdDOEY3TJA7iF7RcfWwGYIN0WVAQvxlbRAUFb48oUkCNOMmphjyIG4QwT42DckNlcn4YwiFWuxbgeczrDih3FsJZ+nnnF/2d6ol26mlIhkXJNVSv4ZJ5tcJycJ/5i42VLM+PBwY7C+y17bUBQB+1LyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs7qcYOVq/2JyAEYZidWMSM5uZnrds36DrSHspKI2XI=;
 b=UFots9AZX7JN8o4txha5XOhoPVBAaMkd9UCbXl1TooAKZri30/N+wS7V2s1Opq9ArvLt+PG3A4YrV3gY2fg7hQCTK8ZVSOLGo6ZSzIbl1ZYMh2bKlHcus+027mgzTK6Vji6TKh2jYH2NkawUgB6vEq5+8zGllbyFVS3y9DFMEVfHB0DZ0+Xwka7vHftLeIGsBv9lU6IBhQCqCJoNvTDMbVr1t0x3Qax13Ue9G6JRFlNwAsCGgJ6SBMKeNC6xbosL9H8DN2BNlBs4y6JkIuxnxtP1fmYi0e3Fec2NdDIyYD3uHu0wSot/h2hsKF+J04tgr+vyNg2XmyBCgZcVZrrr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=secunet.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs7qcYOVq/2JyAEYZidWMSM5uZnrds36DrSHspKI2XI=;
 b=q8jdI09NDvU9bmKMsVsaD8vU6Nnjf4/18WlajO+oyVx7P2JrmdWT4McsHU0iBJgrzlVrgv4PfJXNGn5PvbYfS/vU9JIPa0dJmrZRA5CYcc6wRamzuBCTiaGrdX5XERWQHBYesm5iDCIkjyQ9voQ+zKGozZRP5S2K1vVLCY1ccoC1PjDZIDSjctgHKMvVJ6a4DldAzBuVdmUvPgwS1Tq+ftyGOr4CPjqZ7Y50GPAFVOSoqWmtNq0l9mlbv03WPpY/MOjTCChzHzpiE1cFUE0cGLddKwOrmjl8OvkTRRZnBmqc0y0JRKk1QXRScEhXNszL7MmW7q+J96iAnSbWk+wjcQ==
Received: from CH2PR18CA0057.namprd18.prod.outlook.com (2603:10b6:610:55::37)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 08:36:49 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::b6) by CH2PR18CA0057.outlook.office365.com
 (2603:10b6:610:55::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 08:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 08:36:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 01:36:34 -0700
Received: from [172.29.252.152] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 01:36:31 -0700
Message-ID: <66394d1b-01ee-46cf-ba9b-5a0faaf398ec@nvidia.com>
Date: Thu, 30 Oct 2025 16:35:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet
 inner protocol
To: Steffen Klassert <steffen.klassert@secunet.com>, Sabrina Dubroca
	<sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	"Cosmin Ratiu" <cratiu@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
References: <20251028023013.9836-1-jianbol@nvidia.com>
 <20251028023013.9836-3-jianbol@nvidia.com> <aQCjCEDvL4VJIsoV@krikkit>
 <c1a673ab-0382-445e-aa45-2b8fe2f6bc40@nvidia.com> <aQDbhJuZqFokEO31@krikkit>
 <aQMc64pcTzvkupc1@secunet.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <aQMc64pcTzvkupc1@secunet.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ca7345-1aa1-409c-3aea-08de178f778f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXJDNTVxUHg3N2pCNkhvUGhCSDN0cXNHdko4czJ0a0tjUVB3RFYwdGN2dCt6?=
 =?utf-8?B?QVhXTGQyZHo1QmN5dFhIdzRnbzZZeFcxRk1ENktUb1lzTU9RZEZnMVBmWm1M?=
 =?utf-8?B?dXBnekdiWnVRbUtPMmgvTmRwalhpMUd3cGZNT1JEUnIxMHkvb1FHajlrZmE1?=
 =?utf-8?B?OGNJUEdaK1U1ZmpTU04zVjFOZnlKdjVIVkhHYm1aQXE0N251NERjYW1OZ2Nx?=
 =?utf-8?B?VEozckZuZ3FsSFdLQ1YyUHhxWnNobE9JWXdpM3NCbHJGbHlFQW9XVUlOOWRo?=
 =?utf-8?B?a3Nqdk9OY01mbUtDaitLenR1RDZ0M3F1aGJyRFJqZDRPd3NhMkNyK1oveWVh?=
 =?utf-8?B?ODZ5ZjlLcVVBbUMwVWdIN08yY2IyR0xaeGhLVDNsdE5pQWt3QUp3V3cyYkl3?=
 =?utf-8?B?TUVvTld1STdKOEdvcVFjejJaOEduMkVwSVV0emVxWW1uaG5aWnRaQnEzenhK?=
 =?utf-8?B?RjVobFFBaEZiZmJlWG5jSnNkNU9xakpZRmlNbldKbzUycGZ0WUZkZmlROUlX?=
 =?utf-8?B?OVF3ekd4RllWN1N5dnNsa2QvaFdoMEtLcDZGUTN5ako5ZEk1V25vQ3NXejhY?=
 =?utf-8?B?U2VyNTdzYlN3UklVTlpveGhTS2tXblRYaldzMkliVVViR2FycklDWEt0YTJu?=
 =?utf-8?B?NFF2YXBmdWNtbG5yVTh3QlliMmFtOUUzSXJ0RVpDaWFML0NlbWpCc2xzMVBH?=
 =?utf-8?B?djdSRGpGWDFvN0ZkZ3NlQ0U2eCtGVk5FaElQMmozbGI5MFlTakIzQUJvdDRO?=
 =?utf-8?B?VnNOYVNCaVZBVFh3MXdJSTRSRUhZa2lNSkV4SUEzVk9qTDd0VWMwQkhDT2VV?=
 =?utf-8?B?VDltVU9tbDB5ZWVYZnBhMDl5aUc2RlU1R3pTN0g0TmNXUm5nWXNTb1E0Vms4?=
 =?utf-8?B?Q1E4b3JmVWphYjQ1dTA4Y2hFK1pHRHpTZGg4THM0T1FrTmgyTUFxRzBLK0Y2?=
 =?utf-8?B?b1B2eUh0VXFEUTcwcU9kaHlqL0ZmQlF5YjRIc2FENXJsWDk3YWd2Yks5MDRj?=
 =?utf-8?B?d1dMVUVLL1FXdUppSktQZXNtMzZhbndFV0RCcGZJS2k0SU5oL0lNdXVYZm5k?=
 =?utf-8?B?WWM3KzBqVmtoeGIrc1A3RURDNlNIWlNXVyt5V1poV1R2VnVSejlBelBtNFFs?=
 =?utf-8?B?ZHBWVGNHOUIvWjd4NUVsendFeHVaK3ROeVVJVkJrY3dOTlhlZUpZQVpjakY0?=
 =?utf-8?B?NU9VMG1scllJclRhRWJObThZOC9vR2dMbk9SeVZPZi92UjlQNWhYSTNNZE5o?=
 =?utf-8?B?NnlxZGpkOFZnRitnUXEybEZPdTlIbVMyVFdQMGxqZlZNVW81OEJhRTF1T3pk?=
 =?utf-8?B?blUwZ1BTTm53clBsSVpyR29KNnY2R1dSZ25iT3cvbThPdXVFdklMaUlBZ3Js?=
 =?utf-8?B?My9nbDNRYTU5WG9la0Fuays4MUVlQmVKbWpkczlQbVFGUktPSUlCa0FLT1FX?=
 =?utf-8?B?VkNsUG5TSmFLcFg5dDYrOE4wdUluRlhqRVVLWmZVcW9QeWZWanpHcE9UMmM4?=
 =?utf-8?B?VTRpS3JMYU1TVzZ5a0lVZkRSSnJQNU1YaDlmS3RjaXVqYmV6WVBKZFdDclhy?=
 =?utf-8?B?WUNIelZTWmJDcGt0TzNBdk44OXl6ZVJsZzFBekNEZi9IV0V1VXRxc1ZNY2Rr?=
 =?utf-8?B?TktKR2NtRERIaUZFd3RRV3BGaDdWZXVFTS9Eb3YxN2piM2REVVAwOTk3UXBG?=
 =?utf-8?B?YW5WQXZSeUFpN2NnWnU2RWpZVnFjMFhYRUcyL3hYM2J5a3VvTFNNOU43ZWI0?=
 =?utf-8?B?SXIxZ0c4RE5ua29kM0VES1FWMG45cW5vaDlwRmxFTEtmSVBIR3ZLZGJhZnhq?=
 =?utf-8?B?bUwreGdHZ2d3RVlBRmRyaDlRUTFqUFZ0czNWZGdleVh0aHRLTjdCNWVJOCto?=
 =?utf-8?B?aTNpQ2JJRDl5UEdWc1A0VUVXbUFRU2l1TytOYVk3dDdQYWduOGlPZG1kU05M?=
 =?utf-8?B?TzRYREEyZjA4SmVVVk81NlpVd3NQaXc0ZHFTZ2FuREgvSmpSUG1odXJ1TVk4?=
 =?utf-8?B?WGgreVBpZWtjWTJRNFJadFNZcDFrek1kSVNINUdDdDc3bXBybnFDUXJ5emYw?=
 =?utf-8?B?d08rZU9VWGR6YUpmbWFzZnR6R05kMSt1SXNpTWpDaHRHNHl6TGNSelJUVGdG?=
 =?utf-8?Q?ER20=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:36:48.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ca7345-1aa1-409c-3aea-08de178f778f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419



On 10/30/2025 4:08 PM, Steffen Klassert wrote:
> On Tue, Oct 28, 2025 at 04:04:36PM +0100, Sabrina Dubroca wrote:
>> 2025-10-28, 21:36:17 +0800, Jianbo Liu wrote:
>>>
>>> My proposed plan is:
>>>
>>> Send the patch 1 and patch 3 (including the xfrm_ip2inner_mode change)
>>> together to the ipsec tree. They are self-contained fixes.
>>
>> So, keep v3 of this series unchanged.
>>
>>> Separately, after those are accepted, I can modify and re-submit that patch
>>> [1] to ipsec-next that removes the now-redundant checks from the other
>>> callers (VTI, etc.), leveraging the updated helper function.
>>>
>>> This way, the critical fixes are self-contained and backportable, while the
>>> cleanup of other callers happens later in the development cycle.
>>
>> The only (small) drawback is leaving the duplicate code checking
>> AF_UNSPEC in the existing callers of xfrm_ip2inner_mode, but I guess
>> that's ok.
>>
>>
>> Steffen, is it ok for you to
>>
>>   - have a duplicate AF_UNSPEC check in callers of xfrm_ip2inner_mode
>>     (the existing "default to x->inner_mode, call xfrm_ip2inner_mode if
>>     AF_UNSPEC", and the new one added to xfrm_ip2inner_mode by this
>>     patch) in the ipsec tree and then in stable?
>>
>>   - do the clean up (like the diff I pasted in my previous email, or
>>     something smaller if [1] is applied separately) in ipsec-next after
>>     ipsec is merged into it?
> 
> I'm OK with this, I can take v3 as is.

Great, thank you for confirming.

Once this v3 series is merged, I will update and send that cleanup patch 
to ipsec-next, as discussed with Sabrina.

Thanks!
Jianbo


