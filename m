Return-Path: <netdev+bounces-75252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFC868D98
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26EA1F217A5
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA91386B9;
	Tue, 27 Feb 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQ71Urci"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC91386A6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029761; cv=fail; b=GXKs0uzIQOZ9/s0fHCkcvCOeZZbvjQp0pwjrAgt3K5uscqvM7hkIm0wh2nZ/GmSyqDLWxaakCcMX8bPW2AzMtM3Qk1PDazovWy45Q7TwjRyzZakWF7pNeMlCBK4PwhDrxaSH+M/OElvMU89Zc8t4ZG+soBOOvwQV9mpuG7ArMG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029761; c=relaxed/simple;
	bh=fvWCQ+ZkB3unn5Cq5iKiXaGh9ORqGR3ixBX8DK9mkbw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwNRoJLxZEnSrFpnlSkFepMnREc2HhCcnhC9P1dZqrFxH4/Wg5I+KOSEnN421e/lF9QTGI9GvQIM6dhV8vAiDXJEMeNTgwMQbSq52d1jXgQkohhy32N5JjTwFELSX5Q3lJKfAE88GpCAaw2fwNQUUH2AN3+jX6JniHiHif4syy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQ71Urci; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709029760; x=1740565760;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fvWCQ+ZkB3unn5Cq5iKiXaGh9ORqGR3ixBX8DK9mkbw=;
  b=hQ71UrcihLi4CRkj2ymlhNB4zlnWOXbV4cLs0noLGnEqRxszhNBSwdf3
   dRAvHH8qfDmEwZP8fZPaVyplPbV0ZCNzC50IykJGZ0IS7+PymvwnVUzfd
   k4CfPFGVFD89YWCiPPtmuIPyCsHcAXjVbbCHGprldYHhnw/x6/yKeL/dS
   AN6SiH4nr1SNPIpw2oNtPKEF++YJeM0oE32QLvXFBZSbv/quT4WqgM+yb
   Lrv8EX68f1wbwMuziujmyRhUG1XYieUV+jrYGDjKXntqE4IZq2MLht3fA
   im6vxwuHAxSOTbvxc4+UDEOPpshenV46rYo7iRL593zUHXfieqOLPW+Kh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3232416"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3232416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="38025202"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 02:29:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 02:29:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 02:29:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 02:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0NHpBGcI3t9X7s7IybXbVjW0va3G9LBaLiJhiAU+m3l40amMEs8cqr89gu8YmCaRf5QK/OaOlpUroQHngTzUSDrRBtkBM/xJ6Uty31g8OrreyIo9wmvozopgGvtRq/WgvtH38RPL9TJNLCVRD8eIuQOwXzVhhy85PMEBCMcT4qYH4qy75mYxTzhrnz0oyVKiXI8eeLkVrXuK3fcix+6nyN0b8/MFfMts2bEUuIQjpbgGIEU5lUhPatLS4CjMmQwBH3xkGvpCP17l/PZ2mJV9zSXdhqkZNC6snqi63i4F8hNIOXwOSw2U2IAW4twKZY/6qmwOQC4tqigAoX5gCMl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O9qjKy71Ob9xUzpXhGSYUZCSldF6QQghDpOIltVi80=;
 b=IGtZoOFl1uC+lJYy2OC4xsA9CMJ1ym8Ncjl9LyesCxotSOu1siRCB9ajwm7D3pj3GrM6Az6vTLLQcLkKBSsU2UCeayBgCKqJyq3B1z46n6zfFTyVl6/aeQY5Hf6itpJprBwdLMTfp1lgCn0oSMLIALzAYyuIwELV95Huy1zqJb0UyI4elzyLucbhDM8Vw3PXYuoEdYmtdKxLvK8VtWN3OYpQ3Yt/y7MjrQesmcH/E/RNA3xlO0Uw36bvjh3r9b9kH0qQ6lQMxgOArDtv3zTmPImMAUNwPFX3DUP3r2zKtZeEcjDBp+IzFoBtrvvGD5UlgyNXiA2d+FsjIOInYVieAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 10:29:10 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 10:29:09 +0000
Message-ID: <e05bed50-ef3f-466c-92e9-913b08bbc86c@intel.com>
Date: Tue, 27 Feb 2024 11:29:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<amritha.nambiar@intel.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>, <sdf@google.com>, <vadim.fedorenko@linux.dev>
References: <20240226211015.1244807-1-kuba@kernel.org>
 <20240226211015.1244807-2-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240226211015.1244807-2-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: df2d7e14-bf1e-4884-7dec-08dc377eef20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA7Nu7sm2z7PJ4Q40AFb7oGAITbQN8Nz9dm/LjMItDxVH1nl8BGkmPpLGXLzVB2zUn1rA5Thcfq3B3d966WScf+bpfw43Om7BBEaeyqCoI2CaLWC3/Jas9+O0KoiMlPAJbHz1YMe+U5IForDjG5FzzFJqMqvUqJKMyfRk6q6h6MHktWBOcQxAEd2kSpwQlyhPJQHeTWrFEY+abOd7ksj1Zj8wSqeBbM1tJOec62gjdPigXjdxdx3wJoL1C+gQurTjb12mxyXr4tm6Oef3EeiYdjrTFQSkjQN6hAHBXSM2o8ImiyWEk1jIKyaaoSpGyEDoT3HrciObg8fOBNax/Oqr4IK4n2po3Ki/d6x1S3d5cUXHigYnGuV9PNll4AgyZt8rHQ5BvE6EgJLpn0g0LU2lvgyy2FcU7riYoqgim912TYb9QQXV8iNi4KEA/vCatD2JxaBWGbC/z8SQVF1r2Qli6s+Yzq2KTbcEcsNu/Uwf/31FcyF3cgYnHHYy8olRLNuvMd367IpnQCqddlVG7SVAAmZi6zeuYJnF1VkvIW3VBd/t/ASxAxaNSzGd6JSIvPi40WvUogPZb61k+X/Xui6iPtxwtXvZkgdl9yNNyEyqqcu1CyrwiDfSsJJnbIDy1U9A1moQJVIV9792yYCv5cjJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjVMQ0E3VmpoQnV5QTBFMUZkREpQYXVIdlB5ams5UUpNMGRKbzVNalJBWGdF?=
 =?utf-8?B?dWhEa2lrOWgzditVTE96NE1yZXVzMFc5eloybUtQci9mUTZobmRZT2VGMnhz?=
 =?utf-8?B?NTNseWlpNnpoOVpiTzJlL1N1cjYrUzc4ODZYYkpsU1owM2VnRGRacjRPN0xT?=
 =?utf-8?B?ZkdZdkNGUFg1NEphemNRYW9KRlQ5QnMzYXoyeldJWmtTYWZpc3RjQ091enIw?=
 =?utf-8?B?QUZVY3h2ZytvRUFkUHFQS3pBMUU2YVQzUzNhc0ZKZ2Q0RjRDTFhVRW8rTms2?=
 =?utf-8?B?SElBNkNGajlJbDdzYzB3VmFXd3MzRjBjNlI4U3UzeGFBZzQrY2pyWFdtQlRs?=
 =?utf-8?B?TnA2bUpxaHlJcXg5YmE0eGdIcGtMZnQ0L0w5Qm03YXlzL29lMFBBclNNMEps?=
 =?utf-8?B?RjlaMnNhWXZWRVRkUFVQaEV0UTRWdVV5V3BySDJXbDYzL1RiN0t0NWQ5ZGFs?=
 =?utf-8?B?SlptL3hVSVdJV1lqdzlXL1Q4VGpHNkFMRjJJQ01IQTdOUVdjKzc2WHFhbmtV?=
 =?utf-8?B?V2tJNWpjd0tNN2xxZS8vdU8xUFhvVDFFS2E2SkNiZU9hVDVwNS9XTjBKWFlP?=
 =?utf-8?B?MDBMcnlLanVQYnhtRHhHam90TVAzM3hKYWJtY2dIalpmbE1vVTFRN3lyZ0M1?=
 =?utf-8?B?eGZSTGFwdzZTMzZOdTVFVWxmb2x2eUhXUUhQZlczSlhpUkphTTM1cDNDVDA5?=
 =?utf-8?B?cW9IMmNWbVNiclFVS2F3WSs1ZWF2UDVIRXloZkRXUUwzaDFYb2dhRnBVUmlS?=
 =?utf-8?B?T1lZRGdyQXZMd25jYUwyaXJzY1NQV3lDSGxrRlRMS0lGa1VzVER5bjRJN0Zs?=
 =?utf-8?B?ODFUR1lBNzBVMWcxMFpCZWxsNlFHVzl5R2l0YmR0VXNzQXNkdi9EeUprOHNV?=
 =?utf-8?B?TTJycGV1K3pNQ1BqUkptWk1BTlpYUVM2R2tGUW5QMkdyQmg3UEFyT1NpQ3FR?=
 =?utf-8?B?YXhWMXVaU1BmdjZpamlLMUwxSURPamtucGROWkU5UnJ6ZUw0MFUwQ0FmWnlo?=
 =?utf-8?B?blg2dmVyNElRSlBQR0wyYjAyZWQyRnJ4N1BTUUpjTDN2WU5hOHJEc2dLbENQ?=
 =?utf-8?B?ZE5mQjBZMExlMDl5QVp4bzJkNHJYQUtrVDhGNHVVcVErZXhpbHJWbVNFRk1G?=
 =?utf-8?B?QXNydzZVTFdyWXYwSW40WGJ0U09aWXMwQ3NvK3h6TFZKOW1MTmM2SEowbXpp?=
 =?utf-8?B?dVZPQ3RaL2tDNm01MTRLbG9RQUtCanpUMWtUOEgrQkhmZ1ZpQTFRQ1JzRk9y?=
 =?utf-8?B?ckh2cjRnVkpaeko0bS9kV2dwcWtsajVzei9vZzlhbWZyT3Y1bzRCYXlXK0RR?=
 =?utf-8?B?WDc5aXBQT0lDdmg5YTRmMXpUazJWN2Y2NTBkZVBLcGtNRVFhWnJaOUFBbDN4?=
 =?utf-8?B?VXU4T3J5ZXlGdnEvRG1maG82L3F5TzNDMCtFMlh3R1NQendmWU1IWE9Sa0Yy?=
 =?utf-8?B?SzVmendQZzZzYzhFdExjV0NsQnNjTGZ3dTdLSTRBTXE1UGl6OCs1Z1VhRnRy?=
 =?utf-8?B?YU9seDRSL3cyYnM5YW9YRTgrelZrQThZbWtaYjVab2pZeVVuanZUa3RzNzBl?=
 =?utf-8?B?c3Q0cjNNSklxRCtXRTBsekR5Ti9CVTMwVUpaRkt5dERDSUZURFgxL09wN2ZM?=
 =?utf-8?B?UTNaSTRmMi9tMG5yRDM3RDZ6Vk5KTEc0TmwzMDRsclpnQklsVkU4RGFtMWIw?=
 =?utf-8?B?ZGFac0liK1czRkNkZzF0dThTK0VCZjEzQVNXVDljbUMyNkl2UTY4OWtHTU9w?=
 =?utf-8?B?UllsV0piRHVvdkFuczZ6bURsTTZ5eHlSVFhocFp1UEh3MEx4ZWZQWDlLdjkz?=
 =?utf-8?B?OGhiTUFac3ZGVTdvWWpadFI4UWZ4NzJ0L0VKcWlNV0IxcTY4b3V3eDNDa0Fu?=
 =?utf-8?B?Z2xXM1E0V0Z0WXRPQ1hLd2RMRC82UGw5SXJnRm1FNHdER2Y5NHJadWIxQWYy?=
 =?utf-8?B?eDZkZnRUSXB4L1dYNGtvbVVwVzVlSjRDRFRFdFJ3ck9rOXFZWUlqTi93Zmdo?=
 =?utf-8?B?TkJ6QUhLK1ZLN1RIVU1wRFpWdHZyc3NEOFNtSXF4Z0NHVjhrdGs2THpEY04v?=
 =?utf-8?B?S0RiVUM3UWx0WUpLa0MwV21kSndTeE1EeW1pUmpJNCtzdmt4RXhmREwrVkdV?=
 =?utf-8?B?bHBlcEZ4ZHR6MmV5MGRzYWJJSEdqOWwyZFV6OEtCQUxmTm5oYkRlV2sxZWx6?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df2d7e14-bf1e-4884-7dec-08dc377eef20
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:29:09.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYfwMQHY9356IoStaYEUFvtd+/yKLtz/t25EzOdC/pIkCfMXydXM92nrZTAKDVI6XieDA1O3vYr2Xp/vMZScG366LKng7XmCbMUi+Q3S4OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com

On 2/26/24 22:10, Jakub Kicinski wrote:
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
> ---
>   Documentation/netlink/specs/netdev.yaml |  84 +++++++++
>   Documentation/networking/statistics.rst |  17 +-
>   include/linux/netdevice.h               |   3 +
>   include/net/netdev_queues.h             |  54 ++++++
>   include/uapi/linux/netdev.h             |  19 +++
>   net/core/netdev-genl-gen.c              |  12 ++
>   net/core/netdev-genl-gen.h              |   2 +
>   net/core/netdev-genl.c                  | 217 ++++++++++++++++++++++++
>   tools/include/uapi/linux/netdev.h       |  19 +++
>   9 files changed, 426 insertions(+), 1 deletion(-)
> 

I like the series, thank you very much!

[...]

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

I get it, but encouraging users to reset those on queue-count-change
seems to cover that case too. I'm fine though :P

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

[...]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fd98936da3ae..0fbd666f2b79 100644
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
> @@ -469,6 +470,222 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>   	return skb->len;
>   }
>   
> +#define NETDEV_STAT_NOT_SET		(~0ULL)
> +
> +static void
> +netdev_nl_stats_add(void *_sum, const void *_add, size_t size)

nit: this declaration fits in one line

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


