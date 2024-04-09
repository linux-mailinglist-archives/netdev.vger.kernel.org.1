Return-Path: <netdev+bounces-86319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121589E631
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FD2B233FC
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A02158DCB;
	Tue,  9 Apr 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2SfvDm1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13777159203
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705877; cv=fail; b=GEdZQPr4mBSn742VnJNs97JdABx3L9dcrbGuehzMYO6fuACcTEDF2p6rnoVPrQqUvoI2u0o/S1n3xeBJVSt2B9ir6UT3Teqqu4XTcik2rvgUlkRjDAxZCGuaJnOE6hHyzMDo5vfKGxAx2UZT2XiA+2MrONZtkQWCXRA34dzD97Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705877; c=relaxed/simple;
	bh=91veoqUDkL6CJhYgOA668y/uYvfLO/LJaIOtSCVqfx0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hj25jHtwPm0/H9FfWbypp0dh1aocKo4O4MkO0g+PozB0Z/EomzTF01+dW7XoAmbyK/EXc3x4k3V76RixTeLD0K/ypdMbkCm/VJ+NA+iOSRo0tnA95kKRtryBDZLC1YTnUzs4famffCrbe2KbfzyTpWeIiPsq/w+gcQsRrbnLfro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2SfvDm1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712705875; x=1744241875;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=91veoqUDkL6CJhYgOA668y/uYvfLO/LJaIOtSCVqfx0=;
  b=U2SfvDm18PJOFKqcSSW4cCwXlpGT1S87IjlbYIzVj9+e4SOoHzJokxMq
   FyQUah08vCp8cxt0SwxBaYHcFDEX8WpFkYb/DfEDPWOhJ9aSm+qkMyrj4
   1HaR/eJsztzctT01Disms2i8mzfNtMdbRihgbwCKrA0+0lkZxw0w+up3F
   j51mD+6SkhmYZzuzbHU+PxxcD7NhouUn7fAyvw1cY4xKjRM4Ui3m43vFX
   c+Q0ei5soKPoh5zw79uMAoXZaW1rVxIix8fa2N1QiftfLtoxv2AJ/u4xl
   UhZyA5h1MvmX0yZUdKG/uqEr3EQ+/V22RQCHPAnQu2RGs8XmmGwObK2SC
   w==;
X-CSE-ConnectionGUID: 9j0PMgRIRW62YpoS0xvazA==
X-CSE-MsgGUID: cKLrUCkCReyFXdpnjEslaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8225614"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8225614"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:37:53 -0700
X-CSE-ConnectionGUID: 3jurjJIaTsy5EdQT8JODGQ==
X-CSE-MsgGUID: 9jYU3RCmSN2MoBknkjjfFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20409630"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:37:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:37:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:37:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:37:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA8cTh+M8sle3er4yBHURb0FGDVJGSirTIf0VMJxOmq1lCrPjcnZFeGqZ8ApDz4rMUGUODQtAM7hDVUjHZFL4P39YG7MFp/Ajv6iWtHqf/Fl/G/LkPP8UDN1VvoN8cajxUcLONAgWJ/cSOs8ZmdvwqoCi7RZenNx47a/aoGMkRruAEL0NWeGdkWsVdf+2JZ/cgNyLD71BzfSmj/zAFVBMKUm24rGOUN0+yOAztx+VOyLoMV0kHypt1qROTXSeTrPQVLEWvb4YB6VUhFiT7UWw5k9Wysuok3nFNMHFAY5sGLA2IbJ+aG5ybw5feEVKrji/tf6O+FFX/1i0ybVVfvAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9RF/dY3vKc3bQOhxW7SoKq1rYaUWsI0o0bouh/Lqq0=;
 b=jhAPt3kZUNyIWrCQC1hVc/TNCY6xg2jGKBdcIq/6OlPNvCGcEfzrMllfhl9VSYPtM70ad2uAkiiSHI28iHtqKtVHn2cf7gS7iRahQcj20m6X3v3eEwusyx1/FnTtUAJTt93g1uAls/XsTGRYCCrbpdQ7C7mpH2Fb+0Ljhaamk9mJd3KQ7Zh59l77OKjRQlXlBAexCqZjTkXMOzXpnerx06Ly29EQqQuudBGFfQcl7Wks/umr4N8wpcb5j0HoVdT2Pra8Cc5a8Bu6w75/4vtozaEVMk+C9kARII3sZ525VY4nvlqM7LOLeCNGIPVddvfI8S6julPHpVOUqbYo0uNb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:37:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:37:44 +0000
Message-ID: <90cf2808-bd93-4571-8517-8e6a726802e8@intel.com>
Date: Tue, 9 Apr 2024 16:37:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] bnxt_en: Refactor
 bnxt_rdma_aux_device_init/uninit functions
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-5-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-5-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TK3cXJ52jQQpfiT+EHfoFp2ZYOXtFekF8x6I0fad+VP4UTiBZr9874wP/mztBSHhvaCPQnkN6BIwvQMV7fpXoQiBSJD4WgaUXJNRFPnJdD1lffQ9sXEU9jKdB3rDdmgI7UGtDWy6dpUFhzFLrR9fUMR7Pvt7Xjt/yixj7+5FYFH2NqftnB2B6halkzEmKVwfYgXzvMPutAt7ueyD6fFVOlPtDqUvoyjuCa9N3cdRTQZ7J75y5IDpL6ycgPS86xb5b+hrC3lclPwdfB5sDHSjKXFUjiWUcE3hU/w7iFBDEqvc0V5Wj3i3n+o+6DThD4ON0sZNkhRVqmtCYhrlgExIKZFQp1cD2QFdZIo5SymIsJagUZS7sgkPIpRTrHTLFe5QBhmo3qOlAbdK+7wF7/a1uNnTuSlcF5xGN2TgMeIlaL1xopiFUE+mC78Fj7Nimf66Rim4BrquLqKEBXJtQ1pCtHCAR5oDCmZylHcjNX2WABuXAVtrLHftRlgIcPmqndS8fLlkCFiS9JKNkB1oKKzg4ngjW+F+AoLqICybXzTAZjP7phzPRQYfjn9pPjlxZ2HpMP7XseE5eI75m43UQCNXu0BN4Tg5v5HiLGi6XqjNicd8OjMSFb/TvZzdPxBWLr/Q+1ZcgUGQlYeXjUw6Txp+2N1vyBgUUFt/kNAVoJRKxFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHd6NU9NV1o1YlI0RytpZldXUG9TZHlFQU1scWdsNFlueFJpR2lzQ1gvTGww?=
 =?utf-8?B?YVJtdnNGaStRQWd2SjNTaEV3NWI4TmhWVlJHZlRsQ2NmclA5M3A5azkxSC9E?=
 =?utf-8?B?TFErNDg5aDBVcjZybTlkYVdwV1pPV2l6YmpSc01Xdk9ENUdjdXBUN29DbXM3?=
 =?utf-8?B?V1hqYzBrZVl6NU9IZmx2RDVRcWtsbFlKU1lNbDhyN0x3SlZRSXE5SW9zOWtY?=
 =?utf-8?B?bVd0YU40WDNLdzBpL2RLVUhsNE1OT0xucDFXTng1YjQwZUc4NGNSUk1qeHJx?=
 =?utf-8?B?L0hOb0lvcVo3ZFo5cFo1RkZXU1lmbmVSZ1BLNVh1NEZwYXlEUTJQNEFNbDBE?=
 =?utf-8?B?cFZZS2JHbFVFcXZ1WmR4MFkrQ2VoNXlVOWhKRjh4ZFVvam9NMmRoSSs3RE83?=
 =?utf-8?B?YmpGT241NmpCTE1tM1p3L0Z3bExxU0k5WWRBeXN6QXk0WGQzelZyQXl5Y1Vy?=
 =?utf-8?B?RDZnTG1lTDNWZ3NMZTNvOEZEbkpxcXdQamF0azJJUWNPLzNSdjlhVmRCejdx?=
 =?utf-8?B?NEhoNlIyQnhjR2Z6aVYwRzc0d2ZyQnZETm5HU09nMzE5YUVBTmg1cWVtYmF5?=
 =?utf-8?B?LzNQR250R29pNWJjU216NlByMFFMRlczc2tJbkQ0dm1uN0V2Q0QvMlI0L2JS?=
 =?utf-8?B?UVl3ZU1jRVpnMWpqMnZBQy9PSi9ZS3dueDRmMVZrbWRmTm5NQi9ubU01VUJj?=
 =?utf-8?B?Y3d3OU8rNnJXcWhOaXFOOHFVK2U3dkNGM24yODB3dGczYldyVE1veDR3ekhk?=
 =?utf-8?B?M3VTYzJJN0U4M29KS1R2THV5OVRzelJwVE41UnFxdEJ1WHd1UDZaK2V5QXls?=
 =?utf-8?B?RmZKaGhhZDJnVmtScVpMVERUa0F3bWo3c2ZFazV6S3lDcWJPTzBIRFQ2TlVF?=
 =?utf-8?B?cWFEQkVMckt0cFA2cllTbE1SNUdHWExYRVNhSmo1NndKK2pzdVpnR2dQWDVG?=
 =?utf-8?B?NC82RGtmaDFnRk1qRXFLM282cGJXZi9ha2V6aWtHVnRmcDVjWmJ0WHozNUdo?=
 =?utf-8?B?eVJnZlU1NXF4UkM4TE9IemhsMHlPRzRUMnM4YlhNRW1iTWs5WWw4bFNKNjhV?=
 =?utf-8?B?WkdzMWJmY21XWGFGUDcwZmkzZS9xcjBqenZtdCtkYUhvU0wydDUvdnNPZEUw?=
 =?utf-8?B?blRVWFhRMWRGN3JpSHdxemdQYlpZemxHcmE2UWFUWXpzWVNzK1ZsKy9PZkJi?=
 =?utf-8?B?czlNby9OTEpKczNWdHo0WVZLdmdZWGdIblc2VCs4UWg0VFliNkdEU2JKcW42?=
 =?utf-8?B?U1VrdXRsd2gzVFV0NEszdHprSHdEcWlBeFNDUTZjeUFOK0JXR0hpdzhkNDM3?=
 =?utf-8?B?b2lYTEdNUFJBMkwweUNVb2JVbWR5S0xCbWdwWmEzZUVwSlNpZXRPS3E5OW9P?=
 =?utf-8?B?bU9iRDkzUlNDSXk2ZkpEUGt4U0ZrNHNKVUtibkYwNXcvaW1ET1l2c0t0dC9r?=
 =?utf-8?B?NHV3Z0VreTBucTAzQXg3UEJsN0FQN3BOMk03RUQ2RlIvZENqTGxwWG1oSG9R?=
 =?utf-8?B?Umx5KzkwNGxtRFlZT1dLakt6WDFjQVFTU3lUZWhjVm9oQ0E4MEdaSEdxVEZj?=
 =?utf-8?B?RVdBRCtDTHJodUVFa0lUaW54bWMwZS8vOHNqeEZVSllhWER5MFlneit0Z0JW?=
 =?utf-8?B?YXFhY2FtNnlsb2FzNXNxYWtrTTdFWTRiTHowZnNLcllaSVYvSVN3QWdHM2dr?=
 =?utf-8?B?aHpzbVZoTDIxY0t6QUxTaTNDdWs0SlNxWU9RNEpZeFRyVk00K0g3VC9UK1Z0?=
 =?utf-8?B?N0E4aTNNTzNWbmJOOVJIdHRuZlQvRC9qTzZMRy9oSUV1NXJnMFpSQ25kakk1?=
 =?utf-8?B?ck9WaWJDYklTT2tFVHFjRS9SZ2Z1RHAvZWIwSnlzWGxVWjJTN1RoUnRRYnhy?=
 =?utf-8?B?NmYrb04xKytTOHBSQ2o5ZGJmTmx0TVFXMVNRd1MzdEJZV2Q3MFZXWVUya0lq?=
 =?utf-8?B?cXVRRndZNVh4QjlIYkh4ZERyNElnQXlVWHBGYTlaTXA0WnhEZlBPS3plZTEw?=
 =?utf-8?B?Uy9GdlJQMkc1QkcwT3NOUUEvNmp4K05uekRGS08zSHFFMUhFdVprRGZ1cDE1?=
 =?utf-8?B?WjRPa3o3NlBscUNDZ2xPU2pGdWRxaGFIL252dE1neUJpcDhQMElBNExobm1n?=
 =?utf-8?B?ZTdmT25GVkVFUHFROFhXdzBaK2twamtnSUtJQTVyUkpuUXdxT3hEV3U1TGRP?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd605482-73b7-41bf-b0c4-08dc58ee0df5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:37:44.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaKebb6OPeK+CFnFJwaxddZK2HxmSlLVG0u6kgENW+3wiqBx066egTYy7/wFgbWsICQj0gZFz5vOMQ+Sxs/so2ZgMD50TH7WFrqdQZRP9s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Vikas Gupta <vikas.gupta@broadcom.com>
> 
> In its current form, bnxt_rdma_aux_device_init() not only initializes
> the necessary data structures of the newly created aux device but also
> adds the aux device into the aux bus subsytem. Refactor the logic into
> separate functions, first function to initialize the aux device along
> with the required resources and second, to actually add the device to
> the aux bus subsytem.
> This separation helps to create bnxt_en_dev much earlier and save its
> resources separately.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

