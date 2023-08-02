Return-Path: <netdev+bounces-23718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EB76D4D0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A26C281E8A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91358DF52;
	Wed,  2 Aug 2023 17:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB87DF51
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:11:57 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE330CF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690996309; x=1722532309;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2ZLL0+mXWDl2lZLEH33D9l+ULDJuIrOw9VLc5/7bYk=;
  b=D+G1wMD3jXV+oEotx1fKI+UwNQZTecix29wfQN82WqeDZs6d/nVZRo7P
   f7aNKknRCvbnw+Wr5RyElF3G96dqOdz/5Yy109XAsg8vObETOy7sdZ0d2
   /OhU1tcphwleNhLveM7pkXmXw1OmY7ARLNYnCucVNT7gZnMHzmlVPwMMh
   N7GSlOVK2dG5cRJe7ybF83x/fB0UyqOBweBLssQ+ZkipuFZ3lHybaWoR7
   NtdodxUIYJx7aGRpGUmeLMF8U66m+3C9kGxJ7BbJE/7F0HKTQdnm46+fr
   RKKRzoPDLCqDn3B68v9r0lpSH9fzXivD9YR3stFE56XpCzp4ALCSQzyk9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349244016"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="349244016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 10:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="764294226"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="764294226"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2023 10:11:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 10:11:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 10:11:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 10:11:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIJt6MRrxKPCVx2/spmyVCB0AnKPqq1/XMxYBDTATPFsTkwFmVo9iI6s2ST1CV34LSzdQsevytRaDUEczBdlXsr4Q8t/OG72gRj3rIa9xIBx+hoXvxbc4Z9H+8W3VDersI9Vg1aY7/nhgUtSixtdZVFNlPeuym5kcBVrS5Ha4LwdP/eUSSwQs20xkpQ/bGyCraLcSrpaBt2T0d41mJ2lLglaae87NOflvQlMpCVNSJ3TkYej+MQyf0lAb/VaUwCZnOqh9N0fD8f9rVfasjwPLYbWpSxVxo++ebdmI1teOEIwPGivaAfsw4ylLIeNocj8Xi7Wzyfa3UnbiWvJVg2Ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVZs848vikRkw/i9U6TVcwFEEV2lmuS8oRu7Av9yhOQ=;
 b=Ix8IP9gv/WUnAtTp6S/6HjiGx0yvIK6zuKFiErbss7oE1NhZkTEa4v1IqTSyMJyyRT6408gWZnY6ZUKWFKjJpjTRFHgv2QdvO0kcSBzTq+dhIaI4Q0RGcWUNRMwcdMFtwMx8RcSRVB7cw2t7TVCrW3lfT9a3+/Odvc7JmZA0W03/+m23XnClkYPN4dKRT0JnWCK2A6w/XmR2LEAEWbo4ypqxGuraAs4XuFtvWDC2C0/Yv/NhrTiCXq3f18SP9kLNERbpDTcTirYYrbNcc7n+u7lZKah/Ta/HeF6Pu05r9+2Mle/f4rmwQqALd3xt4eulSREUBWldDW2GBXogbbO4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:11:40 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:11:39 +0000
Message-ID: <222b7508-ee46-1e7d-d024-436b0373aaea@intel.com>
Date: Wed, 2 Aug 2023 19:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP
 handling
Content-Language: en-US
To: Liang Chen <liangchen.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<john.fastabend@gmail.com>, <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230802070454.22534-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f8548f-7a4d-48ed-24c4-08db937b8927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgnH2O2oWWu7hOPiwB/7zoFD2FwksMs6FuHPPkdkS2G+YP81Qm7i6LoKYwVT9S44eC288ufRDVqQXfde6Ubey0gpcckmOXIxCC53X49Q1R64YEclAHxCCb/hXvxM/U4cGvpxBIvlF1ypZRCAK0l0AO5gtCNPNTjJV2GelkELXAD6SDfu3uJiivTG0MMM8vB5zSroUHmvxT0ODnpbp6wiURsU1ckLZ9W8kUk/bxPro37rJrJkBHLsVEeZWWnAISjpSu8AQtWf6Px8tVwfyWPRco/aBzSMmPLLKv2iHqduv/tOlHfDnH5cwuOqY0J7KNyWdv08nlvHSRqegrJyI+ZuGKymR9ekBnu9+XnBKOkvz+FOiBR46di+JX7zoKhBA1/jw/zzFvRjwuF8Fmbm/Flt7VHIvZCgSiv31UpSz4eSY7UP2duRea1+PKXgGs3ay9DJw+q/eT9SQybM/t0OKK0jh27qF/SPNqsY70rPRLIjlhHDl0E0EjjQk08woo0Y5qeODqcYU6sGI1aXB4gkAjTN3rvlN7FX/fGsFrpr8I08U3ltizoHAxkFfdm1ExGlOOraFDIoGV7AmctUHbfxDBE113qUh0x8osrVpem+5ebchzjWWAbtAS8JxHTlnmV/Uliw4DKcql3buevgQ83vYDcg7QSnCqkKv7snkZ2WOq141LI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(2616005)(186003)(6512007)(316002)(86362001)(478600001)(38100700002)(66476007)(66556008)(6666004)(6486002)(66946007)(31696002)(4326008)(6916009)(82960400001)(6506007)(36756003)(41300700001)(26005)(8676002)(5660300002)(8936002)(2906002)(7416002)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TitlNG1aenBHcERtVllnMWpYdWxkdjhIVDg2K2FiZzczVTRjMDgzcEpsTEJ0?=
 =?utf-8?B?VXR4YVFuK1dQSkN0ZEF5alRmRG5PWHNTb2pvQmRnenJEbDNQaS9XZTZRYjg3?=
 =?utf-8?B?Z2l5bXVmL3FJZWxTRlAvcm8wbWpUcTI5MVh3NWlRVTVQYlBXMS9RcUV2RWRT?=
 =?utf-8?B?UUY5Sm9TNUcvd0REakR0bEQzbk9kK3laWUVvajBOVzRQazg0UG5DNFo5WUM1?=
 =?utf-8?B?M05acjIxQ3JqSzNGNUZabHRiVUlza1VwcTFIbkZFbS9NV3JEb1FsbEVhMU9l?=
 =?utf-8?B?NDk5OEk1V1dybUFSUzNFcnNpYy94Uy9DZEtPdzlXSHVTY3Z3V29Sb2VpU1Zy?=
 =?utf-8?B?U1RFTVJ5M3FjQUNjREx4cmFaS2VhNCthcVgzczRZRGlidTFsdGVFUEJoVUhF?=
 =?utf-8?B?bjNCUFpBaTF3Mkd4UTdCM3BOTmsyY3IweXF5bTRybkYxLzFROHhjN1NWVlov?=
 =?utf-8?B?U1B0a3EyNk5JMkl4NlhGMTdEZGVLWUdVcFc3VDU4aFh2cW51amNqcjRVcXJ6?=
 =?utf-8?B?TzMvVkVCT3REY0NLR29mUWhRSjgzL3o1aGdUTFBtNVluaU5FQWhuSkpObTVG?=
 =?utf-8?B?Sk1tRUU4V1pGNG9uc2kyUHNXRG5wSlBrOVFIYUtHcWd0dnFab2RCek9obFBC?=
 =?utf-8?B?d0FrZWNubCt3OTgzeWRuK25oQ0N5V0RNOFprMXFWby9zZDFWU3hTTlU3RVR1?=
 =?utf-8?B?TktDTDMrVkNHWitiS2dIOFROTFBwNlZXSnpva3N5WXdkTDh2N1FZWUFBUjQx?=
 =?utf-8?B?eG04ZzFmOHVFck1NTnZCS2o2T2xnYi9YNmV5bE0yajBzWTlJNDdESnViZENG?=
 =?utf-8?B?WGo4ZGkyZDBRQ3JJRStucHJ6VmptVmNtcWQ2bHl5NTBkTS9XSVUwVEtjZWZ1?=
 =?utf-8?B?bDRNSnJVZVhLQkowU3FOdFVTR1o1RUVQYUx0QzBFMHpaTkVPek5pY2FsbTB6?=
 =?utf-8?B?UW5DOEl1TGJqN1c1bTlKeEVzbjQ1blNJeEFGZ2lzaGlYOTJhUEVzb3QwNVJE?=
 =?utf-8?B?MHF6SFZMNm5RNjZZNS9sd25HTzZSZVZjdmk2UDVEczFVd0FpYnNXbTllWE5j?=
 =?utf-8?B?dFdXVFJiejQyQkpXeWk5YzR6UnJ2WVMxeEdnZkNUSWhuN1VmdG1EcHd3bEl2?=
 =?utf-8?B?SnN5elZVdWRoZFpiS2ljWVRDbnVBbUZGWXJhWnN1eHhjMWZOMnF1dGtaR1dV?=
 =?utf-8?B?Sk5oaDJ3MHk5Q01BdXRyRVBDay90UkxlbkxvRENpTWVhajhxS3ZOenRwRXFi?=
 =?utf-8?B?SDhaMG5QclZob0ZJZCtEdVBtdDVENHoyTk1GSGQrSTNyOU1GaXo2Wnd5U09N?=
 =?utf-8?B?MTZOdnU2WlVLZS8rOVFRbCtzSG4wNS93eGlDa2Z5OVRCenQvVVpSU3hqdFpn?=
 =?utf-8?B?T25vd2ZZUDFhdUtoV0U4SVpkWFNxR2QwN3VuaitVMHJ4Uld3UHVKK0paaFZo?=
 =?utf-8?B?L3V1ZldTQWZMOWJQVU5JeTRNZFVSZ1B0T1EyQ1JEQ085cG1zdTIySXRXRXpv?=
 =?utf-8?B?eDk2U2kzeXBqQU4xcUdaTmhSak1CNmJlRXVtciswcFJEWlIyZVJyYXNkUlc3?=
 =?utf-8?B?S3pxQ2FlOXBTN3pXRmd0U3dFRDExUW5lOVlISFVOc2VIUmg1V1Z1bDF1K1Qy?=
 =?utf-8?B?MXVDRHdUYkw3U3EySjFYRTJFWk1UZEN5K0dPTjhBa2pwK1VpajVoS0RRWlZp?=
 =?utf-8?B?N3VSMW5uK0cydENxd2RSa09BbkoxRTFBSSszeHNmS1E0ZUt1Mlkra25DdC9a?=
 =?utf-8?B?RjNOTCtUbTdZSDdlbko4ZndmeXB6ZCtjVldqNEFuM0hlMTRiSEs1ZFNTRjNM?=
 =?utf-8?B?UTVzWmt5Z2pjaGR6Z3JBaVFtZGNjUkFiUEwxSExZekJsVmtMSXkrWi9Xd0k2?=
 =?utf-8?B?OWJrclJ3K0VVQkFyWENSd0xhd21iNDhKMmVXcjFxd1YvdUZja09mbEgwck5r?=
 =?utf-8?B?aklNd21iWXArdzdLN1lUZloyVlBLRHJHYkNJSFF6ZFMweHM1WlF2RlFzSTdC?=
 =?utf-8?B?U0hMZmdTUFNvRFVvb1hNNzBhcWQyK3F5NTRBUGhpcHBLcE5Bd1hoV05tUU1i?=
 =?utf-8?B?RFN5ZlZXV1FJVEUybU9oTmptZXdOY0V0d0JYQU9WbmdPcjFWa3Z1TnlsckhS?=
 =?utf-8?B?aFNNOWUzdVU2ZWVERThHa1h4QXRBY21vaUZjLzBDR212cUd2dHNMaXE1QXRq?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8548f-7a4d-48ed-24c4-08db937b8927
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:11:39.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+kPRIRbAkM2EdIzS0lP3wfIuT11ke8wU9l41K6MhjAPy5AmyUN8kLryeXI41on06wFuTk8960s7fOmz/62h3QX4oS6oPEes7vNn7BVCMIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Liang Chen <liangchen.linux@gmail.com>
Date: Wed,  2 Aug 2023 15:04:54 +0800

> In the generic XDP processing flow, if an skb with a page pool page
> (skb->pp_recycle == 1) fails to meet XDP packet requirements, it will
> undergo head expansion and linearization of fragment data. As a result,
> skb->head points to a reallocated buffer without any fragments. At this
> point, the skb will not contain any page pool pages. However, the
> skb->pp_recycle flag is still set to 1, which is inconsistent with the
> actual situation. Although it doesn't seem to cause much real harm at the

This means it must be handled in the function which replaces the head,
i.e. pskb_expand_head(). Your change only suppresses one symptom of the
issue.

> moment(a little nagetive impact on skb_try_coalesce), to avoid potential

                  ^^^^^^^^
                  negative

> issues associated with using incorrect skb->pp_recycle information,
> setting skb->pp_recycle to 0 to reflect the pp state of the skb.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>

I won't say for sure, but may be a candidate for the fixes tree, not
next. This way it would need a "Fixes:" tag here (above the SoB).

> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 10e5a036c706..07baf72be7d7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4934,6 +4934,8 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
>  			goto do_drop;
>  		if (skb_linearize(skb))
>  			goto do_drop;
> +		if (skb->pp_recycle)
> +			skb->pp_recycle = 0;
>  	}
>  
>  	act = bpf_prog_run_generic_xdp(skb, xdp, xdp_prog);

Thanks,
Olek

