Return-Path: <netdev+bounces-51660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308487FB9BB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538371C21214
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4294F883;
	Tue, 28 Nov 2023 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMyaj2z/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21195
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701172430; x=1732708430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VrElOGKjaAt9x8lXWPqfOq0D5skgI2O9DHyxYuMSBnI=;
  b=iMyaj2z/YflrqWefW3CsKrSpfTLeViSBVnI1XzDXI5iF/7pzK/n1rRfe
   oUSJu/aLlSnjazni2OmCfa1p7rRYAULdm2NeqlXaBUsGHA4S4zQr60Rch
   kiBlQHQ0fBuSfXBb2Jy1dw30hO+FZVZ0BIZYhVV2y6YLEzcfE1qPJajv5
   kEQdUTHgtHjHOZP3KD+goJV6GnM3SxGOTm0FSXTIe3zPTp4zdarYiYLfE
   QcN+d+I9ONh2wHsfuyfvGCi4DowJ3gQmpmfV+vxPao1M8hoWOCyAYmUwW
   Bq3dAKZv5cSc+lORH+XyOl6uTqtAEHlE1itjBx4Zw3OkXAKDld/GRn/LS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="479106315"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="479106315"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="768500272"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="768500272"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 03:53:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 03:53:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 03:53:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 03:53:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7NeZhhKYFz37TsOT0WSBKEM9BZ8zujt5HNv0LfNJnFSIcReVK1Md3iGMbuXUKNuiO+LOzM0DMZPEH59abXJOou16VaipaRd2Ot8m8mfDILOu/DCtVsAkzsacNuj56qBUne5yitQzsog5AeP6eiu5Q2559de58LmjT7HLZSV108pFjkIka8U20qWZ8zYALrfEX0udKt4FmeBOh06/pI2R3IMtVG3XluMH6QGaKzPOQlqPNdG/mFcre9IOimlHIgjF9Uso98mhkaQY+GFFjSqd85oAO7pGlybL2m+Vm4a1hgMhT7iGCMXMIPyXhcDmAGTs/p8MQWjx4eG5sVmj30XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EkYN5RlnwWZH6XTn+GZkQwplADltPnVlvQYBVLBCLQ=;
 b=k9SnB8mpm3/UMi2d+9h1MzpyMhjg4io+1xETdSRGkUGS8nIDpmxxSnv8cwGPgJs0m/V1wOp87et1cPAnkMGTKkK3HONTjnOHjzSrdoNVIWG5tRbriAV3CQJZ1RtBffq5Tgz5x6iHOsCkg1RH30RwFpJfMLqvDmeiq/1h+HQsWlFJ6cxp3WFHy2dZ5PCWex9IuXPoIGbLufWppZuUvw7Cma3Xzbex+dDzIYNF9jRwEgEH6rAARvAod8GvM19NHIjymq95OJLxBZWT4krhR+utIRBFCMfCNQWKKFyTpu9+PbY9eY4wU6q8Lu5pAS6P1FwYHFBVTb3ft0Xn3qFyUgIehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 11:53:47 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 11:53:47 +0000
Message-ID: <ef28e3dd-6869-5047-5113-c6f9288956b6@intel.com>
Date: Tue, 28 Nov 2023 12:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] r8169: improve handling task scheduling
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c65873a3-7394-4107-99a7-83f20030779c@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <c65873a3-7394-4107-99a7-83f20030779c@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ce7048-7448-41c1-c4ac-08dbf008acf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZS5UTg9wQJyKkIsYjDyc5yHpMFcL1iOjOoxGAp4K0SHhfSNE+Ip/pd4ZAy8vI5AEbMHwDvZaJhXsS2cS7AlP2+70SGWMSA/OsALUM9Hno1cZiYkipBpPeVAMBh1a+iiU1Wc30A1IHQbgSMiioJP3JEQvgNyYC40IINF1I5rEsflVaWXWOyEfv6Ar7zoXcbtcKUw+c4Y+OPzhPmc47UX2n8shUsu6TgG3T+bTJKYvy3KUzv7ZJLXpPi81ATt3vq23aKdaiSIy8vSLRxZNSZHq7hgXgZNXrY8tk0IOPTIPkBVUSteQe060V9F7MK6AlrTdVxme3PnzuOJZmhyj36XPZQLYcam1at73MbyOj+VefY6+vdOk0YTEsnQ2eimBKC8gnptY9Rqzb9+qaeRd/yShuQIOd657FqIAfh52hJGBE1Lof9kLqEWM+9/sZ+oHIfxV9/c1rTKu09IM4pUw6J5RlaskQTqbmrDpEqVlaEvharWEfng5ihiHI9IxZIl9x8bmJ+CsBmQIrEHNl9HKKTjD7Q+cZLrsvqe2sqIBvoSqCY751FwuJGS2FEzOOzXD8pzQaLBBgEyb2J9o0a1ADJcttAhd5FDkibXvL9r+9AXAfCUXYGhogpk4Iz3eSW8JziZUoJlCqRWV4pYLdgRdHxX4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(82960400001)(31696002)(86362001)(316002)(66556008)(66476007)(8936002)(8676002)(110136005)(66946007)(6512007)(53546011)(4326008)(6506007)(478600001)(6666004)(6486002)(5660300002)(2906002)(31686004)(41300700001)(26005)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JqMVJhbmxuNEgzWUpONlNCeTBzWHo2QjVLajQ3a3N4R3NkM2JidGJuVmRz?=
 =?utf-8?B?UURGWlU0dmxHVWlLVXhieUlXL1NGQnJYMG9BaWtmdGNsMVFRaC9RYzFkNHc4?=
 =?utf-8?B?TkNMMVk1WVpYODBVRFAxcHFJSmtYMld5aVcrUTMzTlM2SVFmeWhkVjVnT2xp?=
 =?utf-8?B?cWFudy92aCtjcElvMmpxVEQvNTJqMWFNUzNORDBtaXpwand1TUlpTXkzQjlV?=
 =?utf-8?B?VVdqQkNLZCs5Z1F6WERnMzNvckdlVXJmUG91cmRpNGdLcVhKQ2paeDFkeVJx?=
 =?utf-8?B?L2hyU3NjUlFIcWxsM21XUkhCSVd0SlVEbFluUEFOZXFTSlJmUnNPOTczd2NK?=
 =?utf-8?B?TVQ1TkhhOU1RZG9QaHV6Zk8zSjdvTkhPdzNDTnB1ZHRFaGFQQ2FwSjZkRGgw?=
 =?utf-8?B?ZUs3eVdzNGhTUFVlQkkvVk50RVBKSDY3WVRNc3hPYzRiQ0hVOVJOODBrYmFE?=
 =?utf-8?B?KzlweDR0U1hjdkZqQUVBZVBldUVRUEdnTEl4SE9VVEx5MUpCU0V3MGttMDY5?=
 =?utf-8?B?ZGxzNWJBc09jOUFQVG15dklFc0dDOWpmNmR5K25od2FRcDVFUkM4UUttbyt0?=
 =?utf-8?B?VkR0bkpXVllnUDZlL3ltMGJaTkNvTW5BSzBkcnloLzhCcmljbTJWREpnTnhs?=
 =?utf-8?B?R1h5eXpxYzlyRXJreERPSjRoS04rZ1V1YklLT3NFMHc3blV5RzRFNUd0N3FT?=
 =?utf-8?B?UXJ4RUVrRCtIaElTZWJHdVE1Yk0yejVqRm5wVjJsVW5MNDQvNlBSVXlwaExu?=
 =?utf-8?B?OEVIMnVTQlcwN2dQZ090L1M0SXRReDV0eGRWemtBR2JZR3hZY3RaSU4yZGFx?=
 =?utf-8?B?ZHB1Yk53R1czTlFORmtlRldnMCtBMmRPMW5xcE1YNzdRcWlVZ0JmMDhkcWth?=
 =?utf-8?B?ZVBSR3BWQ0tuTDNDbldLc3BKaFIySHNKTEFDZW1JNnVMbUZvMzlvdGpsQno2?=
 =?utf-8?B?bEIyTXFUU2FhbktuZ3BNNGxvbjlJWm1ZWnMyYURhZkExVmdScVFQM3lFUnRj?=
 =?utf-8?B?NU9EbzJCZjZkY01JTUxPcUxtYWcxeWk3Qi9mSU0wRlVvc1ROVjRWOEljV1lK?=
 =?utf-8?B?YzBzTW83T2ZVTzAyRitCZFJGSCtVNHIxa29xUHRVeDRBd2o5Uy9STzZvVlBk?=
 =?utf-8?B?eVBGODdtakJXd0R4U08rYWR2anZPNjM0bzBWMHpnWDhtMlRTbDZ4VllKYUt6?=
 =?utf-8?B?dzBaK3VQaEtSQXA5eDY2L3FxVkkwTlJwSTFYVW1rbW4yRlJ1Ti9sRzBQeGlR?=
 =?utf-8?B?enV1SUJRcVpSTW9XNnlMbDhiQ0JTdFVxd25pc1NtVUw4TkJYWHRQeGs3RWE4?=
 =?utf-8?B?R2pqK1hkZjBFQ1VhV2FCQ2RqRVY4aU5lVTlSMGNxSE43ZWt6RWczN0RJYXVO?=
 =?utf-8?B?V29MOWNPaG9XaUtNZWJBTk5oblUrOG1LUGVIRTBQemdDcWRQWnhmd082TnhQ?=
 =?utf-8?B?M2pneDcxMWNjZ2NINFRSdXhocmZDS0RUUGJ1UmkxbzU4aGU2Tm03a1B2aWVI?=
 =?utf-8?B?YjdZWGhaM1BwUkpLQ0lzV1NERDNLNzBJNFB0TTQyeFRDVnVXWjE5dzluN0Vj?=
 =?utf-8?B?bmJoUjlYZVBqd3Zza3BxNUR6MjNtekxzemdqKzZ2VSs1QnQ0OURML2NoNXJT?=
 =?utf-8?B?V2pUaE54VXN1ZG1qUFJ2b0Q0dC9tY05BZXNHdnNYRWViS0lFRURvWUVmbHp3?=
 =?utf-8?B?QUczelRmTnQ0STNoRU40TTFlUkZMVDlWYmNCNXZmWTV1T0RYc3U5endQejQ0?=
 =?utf-8?B?K0R2NDZTTllFd0lZM0RnREdCZ1RTMEJITHNwMDZvQUxhQno0eHdTK1FVMTEx?=
 =?utf-8?B?WVpWS2NyQ2FFN0JuNk1yQWpXbFRicW5YNGwyM3hFMDJnZ25qbXByVFdITUhw?=
 =?utf-8?B?SmUxU1FCVVJPQmRxNVMxWGFvcm9tbEhuSy80ZHp5QU5WcFBXcWV4bVZ4L2RM?=
 =?utf-8?B?SktaUjBBYkpqd3p0K0NxZHUxdTl6a1BFd2t0bzBRejZ4T21HRjZvdGtXRTJn?=
 =?utf-8?B?T3ZjdGxvcjN1KzNFV0VLU3lxaFJsWTZ1WlBEVkF5MDRqZmx3c2RSOGwzaGFY?=
 =?utf-8?B?bTcvc0cwMDVRdHQ0dUpiTmhFOFRSQmR3NkVZVXRIWHRab1BWd2xGd1V5SHFS?=
 =?utf-8?B?anBRVXpwb3NCL2hRVFRKZjlKallPWGlGYmNRSWl0ZHpCL2RTanF4bW9FRk5U?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce7048-7448-41c1-c4ac-08dbf008acf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 11:53:45.6312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEyXl6bfUCMOtD6STOk9mVFDHXCAx3SdnJuTX+dMFnglJ/93SHI+KxwcQ20xdiGbTs2qTnueeE0Fq0OLbslNTbr2RWyRLHpTFINmF0ZqTBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com

On 11/27/23 18:20, Heiner Kallweit wrote:
> If we know that the task is going to be a no-op, don't even schedule it.
> And remove the check for netif_running() in the worker function, the
> check for flag RTL_FLAG_TASK_ENABLED is sufficient. Note that we can't
> remove the check for flag RTL_FLAG_TASK_ENABLED in the worker function
> because we have no guarantee when it will be executed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index b74d7cc50..91d9dc5a7 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2228,6 +2228,9 @@ u16 rtl8168h_2_get_adc_bias_ioffset(struct rtl8169_private *tp)
>   
>   static void rtl_schedule_task(struct rtl8169_private *tp, enum rtl_flag flag)
>   {
> +	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
> +		return;
> +
>   	set_bit(flag, tp->wk.flags);
>   	schedule_work(&tp->wk.work);
>   }
> @@ -4468,8 +4471,7 @@ static void rtl_task(struct work_struct *work)
>   
>   	rtnl_lock();
>   
> -	if (!netif_running(tp->dev) ||
> -	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
> +	if (!test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
>   		goto out_unlock;
>   
>   	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {

sounds plausible and likely to run better,

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

