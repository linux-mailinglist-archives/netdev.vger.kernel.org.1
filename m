Return-Path: <netdev+bounces-74213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5858607B6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44462866FF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12930372;
	Fri, 23 Feb 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvhOQIkj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB38370
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648160; cv=fail; b=CWJVB+tbOJPLzeYeHZwxSYdwKrRo3PguQ5d835ISpaz/YaGwz2Z3tdtB6eiaBEKz774MpG5EBeDn/YGQtWAKmSYC7W6AszDI+PoXltP57zHEWWGu5Y0YEds5KKkvK127KZtbmcSIkCDgcxBGMO6qXw/aOUukcUtdqsKswP81vPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648160; c=relaxed/simple;
	bh=Z8g21W/+EsR8SbRaqAoywR+5yN0flZy/roZGU39Gv98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bqnKCmMNwmeft92z9AU6cHH7oKhoAJ9lDPgjzN2HT6kEbQjB6/1x78ceTVHorZBl+61rbDYwTi24WUGx5nb0E3REhMBFHHGTSlJaZXA+o3Fl4udB7tFld2VefeFWbCk5fnfkPIj095mxo9EioJsL+GGMU4WZbIR/WTdHAAdonZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvhOQIkj; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708648157; x=1740184157;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z8g21W/+EsR8SbRaqAoywR+5yN0flZy/roZGU39Gv98=;
  b=nvhOQIkjpzOOFelNdA+koO8inLtu05ecz1BKmNyohO8r1h8wtcE2HvuH
   g6hKhQZmCew5vcJTDMxWeaWoCBV+T/4h2ShgfT5DSbDEe5kZA8D7lf5Iy
   3bYimDhWoUEDKwBO/Klr1zZV24X/2TTUdCyDgDiN1dA8nxvRu+hBrR6Gx
   cYhqrTgTYYVsiXxb9V225wFsOw3UPWCb83dfbZinVY7myrRtsg7c7T8kj
   v1JhGztdDAHs4n9Pb3pwu5A8C6aKZw9EDytF40YvRATJ7vk9hXVghUhQA
   hA6H4r+LXllRBpvNbsAiOEfEevnHOjNiZdvy8lZMppliuGLZSRb834/JE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3436129"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3436129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 16:29:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10291041"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 16:29:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 16:29:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 16:29:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 16:29:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 16:29:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6QlZBtc9FqAOE6IzK1Fj6lpmqkOngupTR+PL1kJkmK/cfM939f0GWEVhNyA6rpuK4OdF6fQ7nkdsxsZglegHnTa4f41YI15gZGN2/NT/sOcY/mcwSZB0hSF+f0Ak2tfmMSxaONkoA5BA0yYc37cdRATb+sKcM4BO+j5GJ0e68NOPNSCJv/Javov20Cns4rEpMX3JlSpUCN4pZW8hgwgPbO3sI5PUJ3Yw6eS2m3sP8d10oeQ7SucsEnqw9w/pdwWx3nQoZfcoBfAs6ndYfDtP4AATTh7H6eIhJZKrltOIWY73LRWH0Fr65H4FSAYjBmkqepiyzAgH8ohyJFcehVORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Lgp+m89/0JwCwJEjmGKSgB+yfe+KDlsbHouDt7ut0=;
 b=PtuvNYKbrz/tFh5SCY2sYuwbc0hJTgMyuET3mP0CMdVhJM0xOIJnE6Eg/iUeeYKznN/QqcISy/ZlXo0DgX+9joL2pULsz+CORPGrKVl2USgm2hGKs7NFDFpIP2py9ieI83Y3X5JWwvh3IdIcyMIZMrD/zuy7Mc5ViZ+9Bt/s51yXJX2HInROr5U6CgWFtmdPjh4L2CU0SMezqxk84tnYnqz32WxEmVaWUr2mId5jy/2GfCGbM88v+P2D+t0EXAz20t9zO5eJyaisfmNW3o9BGXyqW9ccUd3H3sdN4LP2NFF4JK2pljjJAnF8ICytGGM1Bs45M2ssEvDU4TCsu2//Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 00:29:12 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c%4]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 00:29:12 +0000
Message-ID: <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
Date: Thu, 22 Feb 2024 16:29:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<danielj@nvidia.com>, <mst@redhat.com>, <michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222223629.158254-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 982f4376-2930-45c4-f6ca-08dc34067537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6qbTC2YFPd93pQ9JUYDXxSt8Mejkb3km/OdfRiRkZjAi/g38TBPt/zUyWfqdRz45YqfB7Ccw5st8WRTs1M4NL9PUMr9DbNcJOU6onhgIJLkqMAKwmY8EiHnvCN8bCmMhkMJkjIht8MFq22TRTz/ji+G0ucyKC/FlbWkbtFfoABZeXPWd+kgNufgZJU/TCjLsYYlVuDsRgtW1D91HbfKtbl2zKiszoBBo8cnyZPCpDYm3fsrAGUNq1Q919JD36N5qqPppjfOVNXsIA/yVMqUI2sgUgLHLWf+adfHkMT3Z7dDIDVVfLhQY/95tm8flJDk0M4+cFZXVtDUD7y03t+ql2OhXSMH/x1WIzqz+tsHUc/GZAbJ/oNrwNj4pKVGSLdQanTOkM7P0fyJjo8ghq0U2xhfhaMlr3RNkHkA0g56+bnAI+eMsw1nOnsZiYMe2Wq7z+nWUGcR01TjQdd6jv9hrP+4AkORqmmX1jI/d0LSCdKhEtLdEpZTpIX8lDFH2IjctdLIcJpVTVh523I+HKtQRhZzg0s+5Qvyv2s1K4/UGOQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHBCNEE2blJQUE55RytGckltbXY3WUxNRHBxZ294RXljNVdKZVlVaDdVTW9V?=
 =?utf-8?B?M2RYZVVFRjZuZjc1RnQyaDR0dHZLNFJQUDlHQ0l0ZHBoYlRKTUp5aGJ6Rnlr?=
 =?utf-8?B?YlBwYjlUQk5YVmsraGdBVFVSRjlsUkVjWEkreGk4RmhJTVdkRGZHTFIyZm9r?=
 =?utf-8?B?SHZZTktpSzltVlRlWG14dmF3ZDNzRisvOXVCYmloclJReE5SYW5ScmlUZDRZ?=
 =?utf-8?B?bHBxM2FPckVCK25YeXVhQ2NUUkFUTk83bDFoN2FNYVhPeG91U3ZuNHQ0VXFR?=
 =?utf-8?B?czZXMmZBY2xiaHBaODdNSFZVM3ZXNVZ1Y0JoeXc3YnB0c3Z3UGI5alhtQmdj?=
 =?utf-8?B?V3VNakdIOXJRNzA2U2RxeHRqVXRaTHZRZkNFaUNPVWNUMDkyMm5YUCthbGNQ?=
 =?utf-8?B?SDVPTkNMZXZPeU9VYWNZZStMUHpFMzVIOHA0b3hiNTVtOTZia2VXRGNqd1Ez?=
 =?utf-8?B?YUVPbFFvN0JCQXA3T000eS90TE9MV3JNSDVMZFJNb055eUJQYkFKQVAxelQ0?=
 =?utf-8?B?SGQ1aGZPTWdIaE8yUGJseTlza0k5WXZXRDBMVEJqeTB1TjV6U0dBZDMvY3RN?=
 =?utf-8?B?Ulh4Q2d4K0ZTd1N5Q0pQVGJFRlNFWFowMkROQ0xkRHA2c01vM0lBWlZOTGRS?=
 =?utf-8?B?SDRLNS9BVHBUcjgrdExGL3ozZjF3ZWhWaEVlRDJQZi9zT0dMakxpb1BZUlpZ?=
 =?utf-8?B?RE1OMFlsZkdIQkptKzFiL2daVFpZRDdIelI0WFNiQjdnVzhReEdQMFRBYUZh?=
 =?utf-8?B?UFZNQXFYZnYzVVVUMFZmaXRub1RNMEpXNTBHdmxIWURDSjkwMmg2dTU3bjBk?=
 =?utf-8?B?cXJxU0VKQzRpa2tubXdNaS9hblcwTUJRcW1LS0k1M1NTVElUWmVDTjQ4cnVU?=
 =?utf-8?B?QS9XTG5rOGxmcHNXbnZLNDk4REZibmV5TDV6Wkt0S2xBVktaQXVLNElIeWE1?=
 =?utf-8?B?REY2NW16RFI5QytGUGUyMHhXM0FaSTFOYmliSDVzY2E5czRCdlhkUTloNzBU?=
 =?utf-8?B?QmVGWmhvOE4zU29DczJaTTdDcEpueE9kaUFJcnlaa1hSWmxzbXMra3FSRys4?=
 =?utf-8?B?cHg5NVlIVWlscXFTNWg2dFF5Y0NrNWR5U04rVDNqVVMwcExudTdPOXRPbkk3?=
 =?utf-8?B?VTdhQk1jR2JkSnRCRkdONVV2MDJiSlpJL2JkTW9OU1djMm8wWGhEQ2U2K2ZJ?=
 =?utf-8?B?dW9EM0dVczZTTWdkNVdoZEt6VFl6UkR1cHVvWFU4NUJZanJ4Vk15Z0JKdFR1?=
 =?utf-8?B?VmovbWFFN0pXdWVEMVFBYi8xR0gwaU5ObzgrMXA3bzcyNnlzS0tPcGppbXl0?=
 =?utf-8?B?ZWU5dS9nNmxvaG1GOUE1dk8zdW5NS0M3RktTSlJyMzVPeWg4aE4rR3FjSVVG?=
 =?utf-8?B?QytvWml0WkpZdFlVQjFzc3JNVTNyeThBeVBrS0VyT0E2N25MQVV0RHorcGwy?=
 =?utf-8?B?a1RGS0dja1hnQ0UyV2dPSnEzWUxwWWlhb2VDQTdUaENUM0tMYlgwSVdqRjAw?=
 =?utf-8?B?UDN6U2tzZGtKemQ3ZUR1cFJKZzhVNXRPZ3RCdUU1d2R5RmR3elhRUFNjRWNH?=
 =?utf-8?B?aDRNUXltUHlDbU40dURYTE12Ymh3MVVBU3M4R1lnSjBRMDMzMmNNWGRockpX?=
 =?utf-8?B?UHN3L3pqdUZJQ01kWWQ2R2hBU0pkMHNFQ2NabjNjM0NLcGJ0YklNMkdlZHo3?=
 =?utf-8?B?SnlYRVQ4UUhTZzg0Qm5xQmNER21DUUVxMlY1RVlZTkZMYTBIbStxSmRKZG5y?=
 =?utf-8?B?bmpiUW5OenRLdW1YLytIU3VRbFR1SHlUN0NvR1lsTEdkTkFJOUt0R0w5L1Av?=
 =?utf-8?B?V0l6NGZzWFFxWjAzQXZGYlV1MDVINXB0aXdSVVI2MjdQM0RudEZnMTdMZGE0?=
 =?utf-8?B?T0twWmJwRlBpTkFQQlQybWZVRFUyV3p6U1RMZEd0QXNNeHM0QVBKTzNwbVFk?=
 =?utf-8?B?ZWc3RlZ4Yk9Nc3NYbWtKVWlaM2haUHQzK1VyOEV0NWpsbEdCWm11Q0h6aDU2?=
 =?utf-8?B?Mk9IT3NRWUpWYVZXVVR1ZFhjQjh4eS9MQnFmU0VLUWRIV1lGMHpmYkpkNGFO?=
 =?utf-8?B?R1FZS2s2SDBFVW9oSTdwdUsybmFjRWs2bEtkSzJ5QkczT1Q1SkN6dEJrT2pZ?=
 =?utf-8?B?dzNvTjBZNDl0WmNYWTI2MjZjRDBLM2hXeTErTENRQlhtOHNRaFYvSDh1SG1p?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 982f4376-2930-45c4-f6ca-08dc34067537
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 00:29:12.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2UjV4vHbXuuXtcpwSAQ2Zxl9GXeJOuaddMi1rbRCg2UfJ+++JqrL7wu1ROW5mJPJwx2aY9m0EYjuH1A/8RgKJpnFYyF+aA3duM3PvIjx3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com

On 2/22/2024 2:36 PM, Jakub Kicinski wrote:
> The ethtool-nl family does a good job exposing various protocol
> related and IEEE/IETF statistics which used to get dumped under
> ethtool -S, with creative names. Queue stats don't have a netlink
> API, yet, and remain a lion's share of ethtool -S output for new
> drivers. Not only is that bad because the names differ driver to
> driver but it's also bug-prone. Intuitively drivers try to report
> only the stats for active queues, but querying ethtool stats
> involves multiple system calls, and the number of stats is
> read separately from the stats themselves. Worse still when user
> space asks for values of the stats, it doesn't inform the kernel
> how big the buffer is. If number of stats increases in the meantime
> kernel will overflow user buffer.
> 
> Add a netlink API for dumping queue stats. Queue information is
> exposed via the netdev-genl family, so add the stats there.
> Support per-queue and sum-for-device dumps. Latter will be useful
> when subsequent patches add more interesting common stats than
> just bytes and packets.
> 
> The API does not currently distinguish between HW and SW stats.
> The expectation is that the source of the stats will either not
> matter much (good packets) or be obvious (skb alloc errors).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks, this almost has all the bits to also lookup stats for a single 
queue with --do stats-get with a queue id and type.

> ---
>   Documentation/netlink/specs/netdev.yaml |  84 +++++++++
>   Documentation/networking/statistics.rst |  17 +-
>   include/linux/netdevice.h               |   3 +
>   include/net/netdev_queues.h             |  54 ++++++
>   include/uapi/linux/netdev.h             |  20 +++
>   net/core/netdev-genl-gen.c              |  12 ++
>   net/core/netdev-genl-gen.h              |   2 +
>   net/core/netdev-genl.c                  | 218 ++++++++++++++++++++++++
>   tools/include/uapi/linux/netdev.h       |  20 +++
>   9 files changed, 429 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 3addac970680..eea41e9de98c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -74,6 +74,10 @@ name: netdev
>       name: queue-type
>       type: enum
>       entries: [ rx, tx ]
> +  -
> +    name: stats-projection
> +    type: enum
> +    entries: [ netdev, queue ]
>   
>   attribute-sets:
>     -
> @@ -265,6 +269,66 @@ name: netdev
>           doc: ID of the NAPI instance which services this queue.
>           type: u32
>   
> +  -
> +    name: stats
> +    doc: |
> +      Get device statistics, scoped to a device or a queue.
> +      These statistics extend (and partially duplicate) statistics available
> +      in struct rtnl_link_stats64.
> +      Value of the `projection` attribute determines how statistics are
> +      aggregated. When aggregated for the entire device the statistics
> +      represent the total number of events since last explicit reset of
> +      the device (i.e. not a reconfiguration like changing queue count).
> +      When reported per-queue, however, the statistics may not add
> +      up to the total number of events, will only be reported for currently
> +      active objects, and will likely report the number of events since last
> +      reconfiguration.
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: ifindex of the netdevice to which stats belong.
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queue-type
> +        doc: Queue type as rx, tx, for queue-id.
> +        type: u32
> +        enum: queue-type
> +      -
> +        name: queue-id
> +        doc: Queue ID, if stats are scoped to a single queue instance.
> +        type: u32
> +      -
> +        name: projection
> +        doc: |
> +          What object type should be used to iterate over the stats.
> +        type: uint
> +        enum: stats-projection
> +      -
> +        name: rx-packets
> +        doc: |
> +          Number of wire packets successfully received and passed to the stack.
> +          For drivers supporting XDP, XDP is considered the first layer
> +          of the stack, so packets consumed by XDP are still counted here.
> +        type: uint
> +        value: 8 # reserve some attr ids in case we need more metadata later
> +      -
> +        name: rx-bytes
> +        doc: Successfully received bytes, see `rx-packets`.
> +        type: uint
> +      -
> +        name: tx-packets
> +        doc: |
> +          Number of wire packets successfully sent. Packet is considered to be
> +          successfully sent once it is in device memory (usually this means
> +          the device has issued a DMA completion for the packet).
> +        type: uint
> +      -
> +        name: tx-bytes
> +        doc: Successfully sent bytes, see `tx-packets`.
> +        type: uint
> +
>   operations:
>     list:
>       -
> @@ -405,6 +469,26 @@ name: netdev
>             attributes:
>               - ifindex
>           reply: *napi-get-op
> +    -
> +      name: stats-get
> +      doc: |
> +        Get / dump fine grained statistics. Which statistics are reported
> +        depends on the device and the driver, and whether the driver stores
> +        software counters per-queue.
> +      attribute-set: stats
> +      dump:
> +        request:
> +          attributes:
> +            - projection
> +        reply:
> +          attributes:
> +            - ifindex
> +            - queue-type
> +            - queue-id
> +            - rx-packets
> +            - rx-bytes
> +            - tx-packets
> +            - tx-bytes
>   
>   mcast-groups:
>     list:
> diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
> index 551b3cc29a41..8a4d166af3c0 100644
> --- a/Documentation/networking/statistics.rst
> +++ b/Documentation/networking/statistics.rst
> @@ -41,6 +41,15 @@ If `-s` is specified once the detailed errors won't be shown.
>   
>   `ip` supports JSON formatting via the `-j` option.
>   
> +Queue statistics
> +~~~~~~~~~~~~~~~~
> +
> +Queue statistics are accessible via the netdev netlink family.
> +
> +Currently no widely distributed CLI exists to access those statistics.
> +Kernel development tools (ynl) can be used to experiment with them,
> +see :ref:`Documentation/userspace-api/netlink/intro-specs.rst`.
> +
>   Protocol-specific statistics
>   ----------------------------
>   
> @@ -134,7 +143,7 @@ reading multiple stats as it internally performs a full dump of
>   and reports only the stat corresponding to the accessed file.
>   
>   Sysfs files are documented in
> -`Documentation/ABI/testing/sysfs-class-net-statistics`.
> +:ref:`Documentation/ABI/testing/sysfs-class-net-statistics`.
>   
>   
>   netlink
> @@ -147,6 +156,12 @@ Statistics are reported both in the responses to link information
>   requests (`RTM_GETLINK`) and statistic requests (`RTM_GETSTATS`,
>   when `IFLA_STATS_LINK_64` bit is set in the `.filter_mask` of the request).
>   
> +netdev (netlink)
> +~~~~~~~~~~~~~~~~
> +
> +`netdev` generic netlink family allows accessing page pool and per queue
> +statistics.
> +
>   ethtool
>   -------
>   
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f07c8374f29c..afcb2a0566f9 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2039,6 +2039,7 @@ enum netdev_reg_state {
>    *
>    *	@sysfs_rx_queue_group:	Space for optional per-rx queue attributes
>    *	@rtnl_link_ops:	Rtnl_link_ops
> + *	@stat_ops:	Optional ops for queue-aware statistics
>    *
>    *	@gso_max_size:	Maximum size of generic segmentation offload
>    *	@tso_max_size:	Device (as in HW) limit on the max TSO request size
> @@ -2419,6 +2420,8 @@ struct net_device {
>   
>   	const struct rtnl_link_ops *rtnl_link_ops;
>   
> +	const struct netdev_stat_ops *stat_ops;
> +
>   	/* for setting kernel sock attribute on TCP connection setup */
>   #define GSO_MAX_SEGS		65535u
>   #define GSO_LEGACY_MAX_SIZE	65536u
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index 8b8ed4e13d74..d633347eeda5 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -4,6 +4,60 @@
>   
>   #include <linux/netdevice.h>
>   
> +struct netdev_queue_stats_rx {
> +	u64 bytes;
> +	u64 packets;
> +};
> +
> +struct netdev_queue_stats_tx {
> +	u64 bytes;
> +	u64 packets;
> +};
> +
> +/**
> + * struct netdev_stat_ops - netdev ops for fine grained stats
> + * @get_queue_stats_rx:	get stats for a given Rx queue
> + * @get_queue_stats_tx:	get stats for a given Tx queue
> + * @get_base_stats:	get base stats (not belonging to any live instance)
> + *
> + * Query stats for a given object. The values of the statistics are undefined
> + * on entry (specifically they are *not* zero-initialized). Drivers should
> + * assign values only to the statistics they collect. Statistics which are not
> + * collected must be left undefined.
> + *
> + * Queue objects are not necessarily persistent, and only currently active
> + * queues are queried by the per-queue callbacks. This means that per-queue
> + * statistics will not generally add up to the total number of events for
> + * the device. The @get_base_stats callback allows filling in the delta
> + * between events for currently live queues and overall device history.
> + * When the statistics for the entire device are queried, first @get_base_stats
> + * is issued to collect the delta, and then a series of per-queue callbacks.
> + * Only statistics which are set in @get_base_stats will be reported
> + * at the device level, meaning that unlike in queue callbacks, setting
> + * a statistic to zero in @get_base_stats is a legitimate thing to do.
> + * This is because @get_base_stats has a second function of designating which
> + * statistics are in fact correct for the entire device (e.g. when history
> + * for some of the events is not maintained, and reliable "total" cannot
> + * be provided).
> + *
> + * Device drivers can assume that when collecting total device stats,
> + * the @get_base_stats and subsequent per-queue calls are performed
> + * "atomically" (without releasing the rtnl_lock).
> + *
> + * Device drivers are encouraged to reset the per-queue statistics when
> + * number of queues change. This is because the primary use case for
> + * per-queue statistics is currently to detect traffic imbalance.
> + */
> +struct netdev_stat_ops {
> +	void (*get_queue_stats_rx)(struct net_device *dev, int idx,
> +				   struct netdev_queue_stats_rx *stats);
> +	void (*get_queue_stats_tx)(struct net_device *dev, int idx,
> +				   struct netdev_queue_stats_tx *stats);
> +	void (*get_base_stats)(struct net_device *dev,
> +			       struct netdev_queue_stats_rx *rx,
> +			       struct netdev_queue_stats_tx *tx);
> +};
> +
>   /**
>    * DOC: Lockless queue stopping / waking helpers.
>    *
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 93cb411adf72..c6a5e4b03828 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -70,6 +70,11 @@ enum netdev_queue_type {
>   	NETDEV_QUEUE_TYPE_TX,
>   };
>   
> +enum netdev_stats_projection {
> +	NETDEV_STATS_PROJECTION_NETDEV,
> +	NETDEV_STATS_PROJECTION_QUEUE,
> +};
> +
>   enum {
>   	NETDEV_A_DEV_IFINDEX = 1,
>   	NETDEV_A_DEV_PAD,
> @@ -132,6 +137,20 @@ enum {
>   	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
>   };
>   
> +enum {
> +	NETDEV_A_STATS_IFINDEX = 1,
> +	NETDEV_A_STATS_QUEUE_TYPE,
> +	NETDEV_A_STATS_QUEUE_ID,
> +	NETDEV_A_STATS_PROJECTION,
> +	NETDEV_A_STATS_RX_PACKETS = 8,
> +	NETDEV_A_STATS_RX_BYTES,
> +	NETDEV_A_STATS_TX_PACKETS,
> +	NETDEV_A_STATS_TX_BYTES,
> +
> +	__NETDEV_A_STATS_MAX,
> +	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
> +};
> +
>   enum {
>   	NETDEV_CMD_DEV_GET = 1,
>   	NETDEV_CMD_DEV_ADD_NTF,
> @@ -144,6 +163,7 @@ enum {
>   	NETDEV_CMD_PAGE_POOL_STATS_GET,
>   	NETDEV_CMD_QUEUE_GET,
>   	NETDEV_CMD_NAPI_GET,
> +	NETDEV_CMD_STATS_GET,
>   
>   	__NETDEV_CMD_MAX,
>   	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index be7f2ebd61b2..a786590fc0e2 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -68,6 +68,11 @@ static const struct nla_policy netdev_napi_get_dump_nl_policy[NETDEV_A_NAPI_IFIN
>   	[NETDEV_A_NAPI_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
>   };
>   
> +/* NETDEV_CMD_STATS_GET - dump */
> +static const struct nla_policy netdev_stats_get_nl_policy[NETDEV_A_STATS_PROJECTION + 1] = {
> +	[NETDEV_A_STATS_PROJECTION] = NLA_POLICY_MAX(NLA_UINT, 1),
> +};
> +
>   /* Ops table for netdev */
>   static const struct genl_split_ops netdev_nl_ops[] = {
>   	{
> @@ -138,6 +143,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
>   		.maxattr	= NETDEV_A_NAPI_IFINDEX,
>   		.flags		= GENL_CMD_CAP_DUMP,
>   	},
> +	{
> +		.cmd		= NETDEV_CMD_STATS_GET,
> +		.dumpit		= netdev_nl_stats_get_dumpit,
> +		.policy		= netdev_stats_get_nl_policy,
> +		.maxattr	= NETDEV_A_STATS_PROJECTION,
> +		.flags		= GENL_CMD_CAP_DUMP,
> +	},
>   };
>   
>   static const struct genl_multicast_group netdev_nl_mcgrps[] = {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index a47f2bcbe4fa..de878ba2bad7 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -28,6 +28,8 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
>   			       struct netlink_callback *cb);
>   int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
>   int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
> +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb);
>   
>   enum {
>   	NETDEV_NLGRP_MGMT,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fd98936da3ae..fe4e9bc5436a 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -8,6 +8,7 @@
>   #include <net/xdp.h>
>   #include <net/xdp_sock.h>
>   #include <net/netdev_rx_queue.h>
> +#include <net/netdev_queues.h>
>   #include <net/busy_poll.h>
>   
>   #include "netdev-genl-gen.h"
> @@ -469,6 +470,223 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	return skb->len;
>   }
>   
> +#define NETDEV_STAT_NOT_SET		(~0ULL)
> +
> +static void
> +netdev_nl_stats_add(void *_sum, const void *_add, size_t size)
> +{
> +	const u64 *add = _add;
> +	u64 *sum = _sum;
> +
> +	while (size) {
> +		if (*add != NETDEV_STAT_NOT_SET && *sum != NETDEV_STAT_NOT_SET)
> +			*sum += *add;
> +		sum++;
> +		add++;
> +		size -= 8;
> +	}
> +}
> +
> +static int netdev_stat_put(struct sk_buff *rsp, unsigned int attr_id, u64 value)
> +{
> +	if (value == NETDEV_STAT_NOT_SET)
> +		return 0;
> +	return nla_put_uint(rsp, attr_id, value);
> +}
> +
> +static int
> +netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
> +{
> +	if (netdev_stat_put(rsp, NETDEV_A_STATS_RX_PACKETS, rx->packets) ||
> +	    netdev_stat_put(rsp, NETDEV_A_STATS_RX_BYTES, rx->bytes))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_write_tx(struct sk_buff *rsp, struct netdev_queue_stats_tx *tx)
> +{
> +	if (netdev_stat_put(rsp, NETDEV_A_STATS_TX_PACKETS, tx->packets) ||
> +	    netdev_stat_put(rsp, NETDEV_A_STATS_TX_BYTES, tx->bytes))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_queue(struct net_device *netdev, struct sk_buff *rsp,
> +		      u32 q_type, int i, const struct genl_info *info)
> +{
> +	const struct netdev_stat_ops *ops = netdev->stat_ops;
> +	struct netdev_queue_stats_rx rx;
> +	struct netdev_queue_stats_tx tx;
> +	void *hdr;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +	if (nla_put_u32(rsp, NETDEV_A_STATS_IFINDEX, netdev->ifindex) ||
> +	    nla_put_u32(rsp, NETDEV_A_STATS_QUEUE_TYPE, q_type) ||
> +	    nla_put_u32(rsp, NETDEV_A_STATS_QUEUE_ID, i))
> +		goto nla_put_failure;
> +
> +	switch (q_type) {
> +	case NETDEV_QUEUE_TYPE_RX:
> +		memset(&rx, 0xff, sizeof(rx));
> +		ops->get_queue_stats_rx(netdev, i, &rx);
> +		if (!memchr_inv(&rx, 0xff, sizeof(rx)))
> +			goto nla_cancel;
> +		if (netdev_nl_stats_write_rx(rsp, &rx))
> +			goto nla_put_failure;
> +		break;
> +	case NETDEV_QUEUE_TYPE_TX:
> +		memset(&tx, 0xff, sizeof(tx));
> +		ops->get_queue_stats_tx(netdev, i, &tx);
> +		if (!memchr_inv(&tx, 0xff, sizeof(tx)))
> +			goto nla_cancel;
> +		if (netdev_nl_stats_write_tx(rsp, &tx))
> +			goto nla_put_failure;
> +		break;
> +	}
> +
> +	genlmsg_end(rsp, hdr);
> +	return 0;
> +
> +nla_cancel:
> +	genlmsg_cancel(rsp, hdr);
> +	return 0;
> +nla_put_failure:
> +	genlmsg_cancel(rsp, hdr);
> +	return -EMSGSIZE;
> +}
> +
> +static int
> +netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
> +			 const struct genl_info *info,
> +			 struct netdev_nl_dump_ctx *ctx)
> +{
> +	const struct netdev_stat_ops *ops = netdev->stat_ops;
> +	int i, err;
> +
> +	if (!(netdev->flags & IFF_UP))
> +		return 0;
> +
> +	i = ctx->rxq_idx;
> +	while (ops->get_queue_stats_rx && i < netdev->real_num_rx_queues) {
> +		err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_RX,
> +					    i, info);
> +		if (err)
> +			return err;
> +		ctx->rxq_idx = i++;
> +	}
> +	i = ctx->txq_idx;
> +	while (ops->get_queue_stats_tx && i < netdev->real_num_tx_queues) {
> +		err = netdev_nl_stats_queue(netdev, rsp, NETDEV_QUEUE_TYPE_TX,
> +					    i, info);
> +		if (err)
> +			return err;
> +		ctx->txq_idx = i++;
> +	}
> +
> +	ctx->rxq_idx = 0;
> +	ctx->txq_idx = 0;
> +	return 0;
> +}
> +
> +static int
> +netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
> +			  const struct genl_info *info)
> +{
> +	struct netdev_queue_stats_rx rx_sum, rx;
> +	struct netdev_queue_stats_tx tx_sum, tx;
> +	const struct netdev_stat_ops *ops;
> +	void *hdr;
> +	int i;
> +
> +	ops = netdev->stat_ops;
> +	/* Netdev can't guarantee any complete counters */
> +	if (!ops->get_base_stats)
> +		return 0;
> +
> +	memset(&rx_sum, 0xff, sizeof(rx_sum));
> +	memset(&tx_sum, 0xff, sizeof(tx_sum));
> +
> +	ops->get_base_stats(netdev, &rx_sum, &tx_sum);
> +
> +	/* The op was there, but nothing reported, don't bother */
> +	if (!memchr_inv(&rx_sum, 0xff, sizeof(rx_sum)) &&
> +	    !memchr_inv(&tx_sum, 0xff, sizeof(tx_sum)))
> +		return 0;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr)
> +		return -EMSGSIZE;
> +	if (nla_put_u32(rsp, NETDEV_A_STATS_IFINDEX, netdev->ifindex))
> +		goto nla_put_failure;
> +
> +	for (i = 0; i < netdev->real_num_rx_queues; i++) {
> +		memset(&rx, 0xff, sizeof(rx));
> +		if (ops->get_queue_stats_rx)
> +			ops->get_queue_stats_rx(netdev, i, &rx);
> +		netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
> +	}
> +	for (i = 0; i < netdev->real_num_tx_queues; i++) {
> +		memset(&tx, 0xff, sizeof(tx));
> +		if (ops->get_queue_stats_tx)
> +			ops->get_queue_stats_tx(netdev, i, &tx);
> +		netdev_nl_stats_add(&tx_sum, &tx, sizeof(tx));
> +	}
> +
> +	if (netdev_nl_stats_write_rx(rsp, &rx_sum) ||
> +	    netdev_nl_stats_write_tx(rsp, &tx_sum))
> +		goto nla_put_failure;
> +
> +	genlmsg_end(rsp, hdr);
> +	return 0;
> +
> +nla_put_failure:
> +	genlmsg_cancel(rsp, hdr);
> +	return -EMSGSIZE;
> +}
> +
> +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
> +			       struct netlink_callback *cb)
> +{
> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> +	const struct genl_info *info = genl_info_dump(cb);
> +	enum netdev_stats_projection projection;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *netdev;
> +	int err = 0;
> +
> +	projection = NETDEV_STATS_PROJECTION_NETDEV;
> +	if (info->attrs[NETDEV_A_STATS_PROJECTION])
> +		projection =
> +			nla_get_uint(info->attrs[NETDEV_A_STATS_PROJECTION]);
> +
> +	rtnl_lock();
> +	for_each_netdev_dump(net, netdev, ctx->ifindex) {
> +		if (!netdev->stat_ops)
> +			continue;
> +
> +		switch (projection) {
> +		case NETDEV_STATS_PROJECTION_NETDEV:
> +			err = netdev_nl_stats_by_netdev(netdev, skb, info);
> +			break;
> +		case NETDEV_STATS_PROJECTION_QUEUE:
> +			err = netdev_nl_stats_by_queue(netdev, skb, info, ctx);
> +			break;
> +		}
> +		if (err < 0)
> +			break;
> +	}
> +	rtnl_unlock();
> +
> +	if (err != -EMSGSIZE)
> +		return err;
> +
> +	return skb->len;
> +}
> +
>   static int netdev_genl_netdevice_event(struct notifier_block *nb,
>   				       unsigned long event, void *ptr)
>   {
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 93cb411adf72..c6a5e4b03828 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -70,6 +70,11 @@ enum netdev_queue_type {
>   	NETDEV_QUEUE_TYPE_TX,
>   };
>   
> +enum netdev_stats_projection {
> +	NETDEV_STATS_PROJECTION_NETDEV,
> +	NETDEV_STATS_PROJECTION_QUEUE,
> +};
> +
>   enum {
>   	NETDEV_A_DEV_IFINDEX = 1,
>   	NETDEV_A_DEV_PAD,
> @@ -132,6 +137,20 @@ enum {
>   	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
>   };
>   
> +enum {
> +	NETDEV_A_STATS_IFINDEX = 1,
> +	NETDEV_A_STATS_QUEUE_TYPE,
> +	NETDEV_A_STATS_QUEUE_ID,
> +	NETDEV_A_STATS_PROJECTION,
> +	NETDEV_A_STATS_RX_PACKETS = 8,
> +	NETDEV_A_STATS_RX_BYTES,
> +	NETDEV_A_STATS_TX_PACKETS,
> +	NETDEV_A_STATS_TX_BYTES,
> +
> +	__NETDEV_A_STATS_MAX,
> +	NETDEV_A_STATS_MAX = (__NETDEV_A_STATS_MAX - 1)
> +};
> +
>   enum {
>   	NETDEV_CMD_DEV_GET = 1,
>   	NETDEV_CMD_DEV_ADD_NTF,
> @@ -144,6 +163,7 @@ enum {
>   	NETDEV_CMD_PAGE_POOL_STATS_GET,
>   	NETDEV_CMD_QUEUE_GET,
>   	NETDEV_CMD_NAPI_GET,
> +	NETDEV_CMD_STATS_GET,
>   
>   	__NETDEV_CMD_MAX,
>   	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)

