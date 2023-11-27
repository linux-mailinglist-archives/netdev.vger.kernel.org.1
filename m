Return-Path: <netdev+bounces-51352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AD7FA4F3
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADD8FB20F70
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF54315BD;
	Mon, 27 Nov 2023 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMCOTxym"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D89792
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 07:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701099643; x=1732635643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CujMLaC91hba9SGvOQOk2IBV2puG1F9k2hjNMpAYqL8=;
  b=NMCOTxymEPKyRwjla+OhfuODAevHHRULwpSH6+efWdwSR0NIQ6vel/qo
   iZPgSyGvXoTpCoYDZ5+wkuVdVIP7Pdxp1ppQgQdHVtVK1KIh1Na5LAzJ1
   kKx3iNYeC4FNhWv2KOVBZfXYB8y2qi5m784OLjjcrPcef/YbmyxLTValO
   JIEK9dGD42BwFkWdeRZnkicdLS+Lt3GvCFGpOKZ4sm1W/wsmALoURzj6D
   S0Xu45PbR5+DK/MmkSc5encu4H6tSUDXXJFB9R0rowHAhbdLOYP84bxpX
   gIR2KBoU+Qec6j8SV12ICGdDgLAhyACfs0NaRJXWs/EOSIBSRo9N7c+le
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389875739"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="389875739"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 07:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16616250"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 07:40:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 07:40:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 07:40:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 07:40:35 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 07:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW+DK4d8OZzVSThRlRrhbEcganjHqDHLZ6aakU3YRnnvxzBuszwRIG0yfn1VEyarSvUlXSZ7yg9X8JCeflFiTsl4+VA4PvnEJYavlusDkn0eCGP2Opy7cnUbqhZShonxzDKWckO3Wg+1xrGVN7CCba4VQCqqEAzhQYNywmZCjxfWPwFu4AJq1+8i84sXYj+bqwT4VWvf83G9fs+vv/ufmyANhdce2mXELduJm7MrL2VwkdK03LDJsHyfhZLRwjakmpd/yFq916OhWvT9nxr673DHY/VXOR+LsBhUycu/43+lbVH5fJCprdpBsuVVFc1NzBTfXkjsRaVeqO1DSP8WzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkM0F0yrVbYj1X9luZi7Dy0E5LX1wb/yrF/QUaFb+Yo=;
 b=QvGN/J586O55YVE9qBQ6WCoRLbbYWkXSZYyMKUezCJcW+/9seFasBIWG3UEf28kZjdWrjmLupjuQ4QquHJZ8LavrSSHxnZu9CC6XqLNUxdkeKkT0KBNTCrf+sg0DxN4olIxOMThgnbKbWyMIDmSkJGaYiU+fmOFxVgp+NEY5yboYVhId7zi5gANDCF2votmeMkPmk4pW7DgxyYKOOeVhAnRAlZnB+cdr9w8YYji/qlqMr/YgpRehcOlf3DOIU5yyMqNA7hVDKDXyRaBjyELte3YdFlukJuk4Ba4RDLINt+Qkd2hMKhUYVycKw7oLWJUCLvRXTMeNYlEtRiZVDMEoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 15:40:31 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:40:31 +0000
Message-ID: <6dbb53ac-ec93-31cd-5201-0d49b0fdf0bb@intel.com>
Date: Mon, 27 Nov 2023 16:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jacob.e.keller@intel.com>, <jhs@mojatatu.com>,
	<johannes@sipsolutions.net>, <andriy.shevchenko@linux.intel.com>,
	<amritha.nambiar@intel.com>, <sdf@google.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231123181546.521488-9-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1815c994-d593-46af-a4a6-08dbef5f3041
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCgkWfZ+bY4+IO7xWZ22xGOCcv0Amt0I5OJT9OfmF6p/JVLIlmyXaoPNn6y25N4lB8JSLLIBkb6QD8dZiXQVKpYlgTiQMJZlKROt7hPwF74KCY5ntV4kNZMWu1nEV0C4c0Ts65/984FxSeiCMU/an+5yPLl7ki9SWQSckjorQGLqmIy30VXCjQp1bc9b0rpVKSoVHHOZSVlIkXbr2+VSvHVcnXu0l10XYhGfbNj8zOO0mgNTHm8skRDw2DWuO9briz1SjrIAvx830KWntcQmrR6v5EkJ0zbYVujjf3muHhZ1mX9+XWIVP1AYlJfadLA92vH4Rai4LiMmO9FKjQLpVTJ+WxqccLqosQVFRshMQVcyMXBbtMEkujV5dLmefOB1M1CfxMIW9L4RefjXYinTiqdkxoQBEFTPae5DVEA1qISaBfN7WydZbeaczac99r79BeYHigoVJLqL1h/j7lR+lo81IbldxGIbD2OdQb+AzWxWBKdwM5vRjLM51czZckJe4ws0DTghjOu6gjTVNjzUEh6zJD92lLr/3GX/wvoMsETZmrc0oxIahkEIrYRvp2Tcskt9dotZj8KiD20PdRSRnLAlBuIcyhII+ggvhSCk35dvMrawbrtFTtm05Vk8+1e/WIRJKXzINS4xl2LANyMPVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7416002)(2906002)(15650500001)(30864003)(6666004)(31696002)(86362001)(53546011)(478600001)(2616005)(26005)(6512007)(316002)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(36756003)(8936002)(6486002)(6506007)(38100700002)(82960400001)(83380400001)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9tNUFhcG5Oem1DK1VJNUk3OTd6b0hNN0NDL1Y0dy9nbXIxWWorZk42OTIz?=
 =?utf-8?B?L2l3YnVGM2x6YkpFbnNuOWI0bm9kdXVNVUxtQ2daOHAwRGF0bS9OdVdIS2Zm?=
 =?utf-8?B?T3ZMK24rTjhLRUpGeDZlYlQ1ejNzM0tqZDVqc2ZpZHBGb3FqeHNkN0UyU3NT?=
 =?utf-8?B?U0xJeDdaQzVNa3FlQVRYTSt6ZlNic2J1V0FSQVhyZ0hUOEpPK2IxVEVJMkdr?=
 =?utf-8?B?MkxyYWhQZzhJalNaVUZVTEE1QnJUYWEwMFVNQnk1YWFFUW9PZHdDNmtDUWRi?=
 =?utf-8?B?MEZlOFd5c01iOGdwNk8yNWl0ZGM0SmRkcld0UktQZG1OWlhZK0JQbnpJbzds?=
 =?utf-8?B?cWJRekJMMllHeEFvUHl3K09jc1FtZGVObXlHRU9FUURnQ0J6dEIyZ2VvRnVW?=
 =?utf-8?B?eXZUbFF6Y004ZGNET3FjTU9FUDk1M0J5WlhxUXZEN2lnUnNCT1ZrWFRNVDZG?=
 =?utf-8?B?OUdTd3h1aWl2RU5TRFROWE1lYlVuaUlndTVscGVDQllmMnJ5dVpwYnA3S01G?=
 =?utf-8?B?cC9JcmZJZVdXcVFTOVNzenNvZm81U2c1R3pKZ295Tm5DSnIxR2tIZkk4NkF3?=
 =?utf-8?B?cGJJT0YrWTBOQlNuMW9oaTRLOFlnUU1wY2FPUCtaOVdneDhiQjFlUjc2TEZw?=
 =?utf-8?B?alFudFJTMlcwVDN1Wm01cUFJWnM0dmRFSWk1TzFQVWpaY2ZPZXZ1NTNvOGV5?=
 =?utf-8?B?Z1R0ZlZWK0RYWTJlQzErdDA4RGpsbHZrWHB3UGJNWGRySnFBTmsxYjhJRzVH?=
 =?utf-8?B?OHh6a0U1bmRCbS9GRGtLd05DNk11a0VzMXdLMzY4azRtWkV1VDk0OFlFWVFx?=
 =?utf-8?B?aGNjWmNkS3JPK0lMTkV0aStoYkxKVVRHTlJmTE5YOEIvVnMrb0ZjL3k3NUlm?=
 =?utf-8?B?Rms0V2lDNmNvUXk5ZElkZDFUZW9PbmphSFlCNDIzV1JuYkxzUU91blZwZ3hq?=
 =?utf-8?B?eWh6b3ZqV2tYVGMwWkJYei9RNWxXNHJydnJBbXp6QTNMRWJUSVBNeHRHYklO?=
 =?utf-8?B?dmhUU1JTNUhjdGFHbVozK2dCWGdHb0krR1VmNzJxb2cxYUZXMDlSQ2RvWnR0?=
 =?utf-8?B?c3lyY0xMblJ5VHBmNmNZZEhpemtHRkRpVkh2RXBYUURrWmZTeXNWd0RTWFc3?=
 =?utf-8?B?ZUpCdFl2L3hYMnlFQlgvdEpudTU2RW9aTU9jWEd5Q2VybndXUXJWdklYWVVX?=
 =?utf-8?B?cUJKV2RGTWNsb0Y2eE13eHc0K2dPWEpCL3hWSEUxUk9DNWFLN2U1TnA2eFp0?=
 =?utf-8?B?TEdjZ3NCa3lXVm1CR0d4cnVRTUNYeVhmVnhoWFhscUdxWk42bTJqcCtmSzVZ?=
 =?utf-8?B?a2N2T3FJTU9SeG42akF4SDc4UkV1WEh3R2YwRGFJcmpzbG9GUnlzWkd5VHFq?=
 =?utf-8?B?SEJEZTkvMDZoRytnTFJGTkljM0xEUWZIbUtiaW1SNHJyeXpMQUZaRnVUM3oy?=
 =?utf-8?B?MFNzSFl5RTQ2dFNZREdlWEJsSSs3bHhZT2VyTDlhNm54VkhCckJ5WXBJd1Qr?=
 =?utf-8?B?alFuY3lHN05PcUxsWUI4R0Q4dkhKUHprTzF0dW80cGdTY01vWDdoMGZhK2VF?=
 =?utf-8?B?eDBUUzd3TXZHS3Nac2F6NXIwOUIrcVFpVnJTTFZBVzQ1bEhBdzdXMWl0NFBI?=
 =?utf-8?B?TjNHUGpwSzY2ZmZDMjlWVVR5cXFsb0ZDcERMSDBQYlJ1U0w1Z3lsRVFWOVE3?=
 =?utf-8?B?L01SZlVTS0tPN0MrMlc3MjdXeHllU2VkNmJhc2hacDlObG91RkZYamFUNkVG?=
 =?utf-8?B?MmxoUkJPR3c0TTZBSTNvRUFVZGpIb3lZVURCYUxkR1FOMXJmS3pKaEIxMFFz?=
 =?utf-8?B?bzNKd0orNFJrSmtXVlZoWVBlakhSdEQ1aWlZakg1M2xKZUtUVDgrM05SanFQ?=
 =?utf-8?B?ZHlzV0IrMkFmVS9kTE8yMnd1YTBlZ1NyVXJmV2owM2ZwcXJBUUZBSkFrYlFM?=
 =?utf-8?B?WExUM3ByTkEwU3J6TUVoRlRDUEFXa3NMSkszRHd4QVluK3QvMkpuSnN3Smla?=
 =?utf-8?B?dEcxSlpjVnpVVHYyOXY2NTVTMTZtY1RaSVA3ZGtEbDc0RVYvcGlFZURLV0RB?=
 =?utf-8?B?bjh2cDZodUpGeXFpY04vLzNPL2xOT0k0NHk2YTRPVFdIb3A5T0R2SmhLc2NI?=
 =?utf-8?B?OVlmREdBbld3OUdhOUdjdjJhY0VIUVNVZGVIdmhFelIwZTVKZUJ1bG1LbFRF?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1815c994-d593-46af-a4a6-08dbef5f3041
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:40:31.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vq2E1+1F2MJ2UOqNH0gCGpbHxCrgdzjuumPdRvazNz+TBtttIig7QpnaQ9n5lTU7G1mmEeUCbPtqntXUjmWr4qt3a1X54BS5nTmHFTBy+Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

On 11/23/23 19:15, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently the user listening on a socket for devlink notifications
> gets always all messages for all existing instances, even if he is
> interested only in one of those. That may cause unnecessary overhead
> on setups with thousands of instances present.
> 
> User is currently able to narrow down the devlink objects replies
> to dump commands by specifying select attributes.
> 
> Allow similar approach for notifications. Introduce a new devlink
> NOTIFY_FILTER_SET which the user passes the select attributes. Store
> these per-socket and use them for filtering messages
> during multicast send.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - rebased on top of genl_sk_priv_*() introduction
> ---
>   Documentation/netlink/specs/devlink.yaml | 10 ++++
>   include/uapi/linux/devlink.h             |  2 +
>   net/devlink/devl_internal.h              | 34 ++++++++++-
>   net/devlink/netlink.c                    | 73 ++++++++++++++++++++++++
>   net/devlink/netlink_gen.c                | 15 ++++-
>   net/devlink/netlink_gen.h                |  4 +-
>   tools/net/ynl/generated/devlink-user.c   | 31 ++++++++++
>   tools/net/ynl/generated/devlink-user.h   | 47 +++++++++++++++
>   8 files changed, 212 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 43067e1f63aa..6bad1d3454b7 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -2055,3 +2055,13 @@ operations:
>               - bus-name
>               - dev-name
>               - selftests
> +
> +    -
> +      name: notify-filter-set
> +      doc: Set notification messages socket filter.
> +      attribute-set: devlink
> +      do:
> +        request:
> +          attributes:
> +            - bus-name
> +            - dev-name
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index b3c8383d342d..130cae0d3e20 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -139,6 +139,8 @@ enum devlink_command {
>   	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
>   	DEVLINK_CMD_SELFTESTS_RUN,
>   
> +	DEVLINK_CMD_NOTIFY_FILTER_SET,
> +
>   	/* add new commands above here */
>   	__DEVLINK_CMD_MAX,
>   	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
> index 84dc9628d3f2..82e0fb3bbebf 100644
> --- a/net/devlink/devl_internal.h
> +++ b/net/devlink/devl_internal.h
> @@ -191,11 +191,41 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
>   				  DEVLINK_MCGRP_CONFIG);
>   }
>   
> +struct devlink_obj_desc {
> +	struct rcu_head rcu;
> +	const char *bus_name;
> +	const char *dev_name;
> +	long data[];
> +};
> +
> +static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
> +					    struct devlink *devlink)
> +{
> +	memset(desc, 0, sizeof(*desc));
> +	desc->bus_name = devlink->dev->bus->name;
> +	desc->dev_name = dev_name(devlink->dev);
> +}
> +
> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
> +
> +static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
> +					       struct sk_buff *msg,
> +					       struct devlink_obj_desc *desc)
> +{
> +	genlmsg_multicast_netns_filtered(&devlink_nl_family,
> +					 devlink_net(devlink),
> +					 msg, 0, DEVLINK_MCGRP_CONFIG,
> +					 GFP_KERNEL,
> +					 devlink_nl_notify_filter, desc);
> +}
> +
>   static inline void devlink_nl_notify_send(struct devlink *devlink,
>   					  struct sk_buff *msg)
>   {
> -	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
> -				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
> +	struct devlink_obj_desc desc;
> +
> +	devlink_nl_obj_desc_init(&desc, devlink);
> +	devlink_nl_notify_send_desc(devlink, msg, &desc);
>   }
>   
>   /* Notify */
> diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
> index fa9afe3e6d9b..33a8e51dea68 100644
> --- a/net/devlink/netlink.c
> +++ b/net/devlink/netlink.c
> @@ -17,6 +17,79 @@ static const struct genl_multicast_group devlink_nl_mcgrps[] = {
>   	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
>   };
>   
> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
> +				      struct genl_info *info)
> +{
> +	struct nlattr **attrs = info->attrs;
> +	struct devlink_obj_desc *flt;
> +	size_t data_offset = 0;
> +	size_t data_size = 0;
> +	char *pos;
> +
> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
> +
> +	flt = kzalloc(sizeof(*flt) + data_size, GFP_KERNEL);

instead of arithmetic here, you could use struct_size()

> +	if (!flt)
> +		return -ENOMEM;
> +
> +	pos = (char *) flt->data;
> +	if (attrs[DEVLINK_ATTR_BUS_NAME]) {
> +		data_offset += nla_strscpy(pos,
> +					   attrs[DEVLINK_ATTR_BUS_NAME],
> +					   data_size) + 1;
> +		flt->bus_name = pos;
> +		pos += data_offset;
> +	}
> +	if (attrs[DEVLINK_ATTR_DEV_NAME]) {
> +		nla_strscpy(pos, attrs[DEVLINK_ATTR_DEV_NAME],
> +			    data_size - data_offset);
> +		flt->dev_name = pos;
> +	}
> +
> +	/* Don't attach empty filter. */
> +	if (!flt->bus_name && !flt->dev_name) {
> +		kfree(flt);
> +		flt = NULL;
> +	}
> +

(Thanks for pointing out to this place in the other sub-thread)

[here1] Assume that @flt is fine here.

> +	flt = genl_sk_priv_store(NETLINK_CB(skb).sk, &devlink_nl_family, flt);
> +	if (IS_ERR(flt))
> +		return PTR_ERR(flt);

and now you got an error from genl_sk_priv_store(),
which means that you leak old flt as of [here1].
I am correct? (sorry it's kinda late :/)

> +	else if (flt)
> +		kfree_rcu(flt, rcu);
> +
> +	return 0;
> +}
> +
> +static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
> +				   const struct devlink_obj_desc *flt)
> +{
> +	if (desc->bus_name && flt->bus_name &&
> +	    strcmp(desc->bus_name, flt->bus_name))
> +		return false;
> +	if (desc->dev_name && flt->dev_name &&
> +	    strcmp(desc->dev_name, flt->dev_name))
> +		return false;
> +	return true;
> +}
> +
> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data)
> +{
> +	struct devlink_obj_desc *desc = data;
> +	struct devlink_obj_desc *flt;
> +	int ret = 0;
> +
> +	rcu_read_lock();
> +	flt = genl_sk_priv_get(dsk, &devlink_nl_family);
> +	if (flt)
> +		ret = !devlink_obj_desc_match(desc, flt);
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
>   int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
>   				 struct devlink *devlink, int attrtype)
>   {
> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index 95f9b4350ab7..1cb0e05305d2 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -560,8 +560,14 @@ static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELF
>   	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
>   };
>   
> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
> +static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
> +	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> +};
> +
>   /* Ops table for devlink */
> -const struct genl_split_ops devlink_nl_ops[73] = {
> +const struct genl_split_ops devlink_nl_ops[74] = {
>   	{
>   		.cmd		= DEVLINK_CMD_GET,
>   		.validate	= GENL_DONT_VALIDATE_STRICT,
> @@ -1233,4 +1239,11 @@ const struct genl_split_ops devlink_nl_ops[73] = {
>   		.maxattr	= DEVLINK_ATTR_SELFTESTS,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
> +		.doit		= devlink_nl_notify_filter_set_doit,
> +		.policy		= devlink_notify_filter_set_nl_policy,
> +		.maxattr	= DEVLINK_ATTR_DEV_NAME,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
>   };
> diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
> index 02f3c0bfae0e..8f2bd50ddf5e 100644
> --- a/net/devlink/netlink_gen.h
> +++ b/net/devlink/netlink_gen.h
> @@ -16,7 +16,7 @@ extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_F
>   extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>   
>   /* Ops table for devlink */
> -extern const struct genl_split_ops devlink_nl_ops[73];
> +extern const struct genl_split_ops devlink_nl_ops[74];
>   
>   int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
>   			struct genl_info *info);
> @@ -142,5 +142,7 @@ int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info);
>   int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
>   				    struct netlink_callback *cb);
>   int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
> +int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
> +				      struct genl_info *info);
>   
>   #endif /* _LINUX_DEVLINK_GEN_H */
> diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
> index bc5065bd99b2..cd5f70eadf5b 100644
> --- a/tools/net/ynl/generated/devlink-user.c
> +++ b/tools/net/ynl/generated/devlink-user.c
> @@ -6830,6 +6830,37 @@ int devlink_selftests_run(struct ynl_sock *ys,
>   	return 0;
>   }
>   
> +/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
> +void
> +devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req)
> +{
> +	free(req->bus_name);
> +	free(req->dev_name);
> +	free(req);
> +}
> +
> +int devlink_notify_filter_set(struct ynl_sock *ys,
> +			      struct devlink_notify_filter_set_req *req)
> +{
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh = ynl_gemsg_start_req(ys, ys->family_id, DEVLINK_CMD_NOTIFY_FILTER_SET, 1);
> +	ys->req_policy = &devlink_nest;
> +
> +	if (req->_present.bus_name_len)
> +		mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, req->bus_name);
> +	if (req->_present.dev_name_len)
> +		mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, req->dev_name);
> +
> +	err = ynl_exec(ys, nlh, NULL);
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>   const struct ynl_family ynl_devlink_family =  {
>   	.name		= "devlink",
>   };
> diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
> index 1db4edc36eaa..e5d79b824a67 100644
> --- a/tools/net/ynl/generated/devlink-user.h
> +++ b/tools/net/ynl/generated/devlink-user.h
> @@ -5252,4 +5252,51 @@ devlink_selftests_run_req_set_selftests_flash(struct devlink_selftests_run_req *
>   int devlink_selftests_run(struct ynl_sock *ys,
>   			  struct devlink_selftests_run_req *req);
>   
> +/* ============== DEVLINK_CMD_NOTIFY_FILTER_SET ============== */
> +/* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
> +struct devlink_notify_filter_set_req {
> +	struct {
> +		__u32 bus_name_len;
> +		__u32 dev_name_len;
> +	} _present;
> +
> +	char *bus_name;
> +	char *dev_name;
> +};
> +
> +static inline struct devlink_notify_filter_set_req *
> +devlink_notify_filter_set_req_alloc(void)
> +{
> +	return calloc(1, sizeof(struct devlink_notify_filter_set_req));
> +}
> +void
> +devlink_notify_filter_set_req_free(struct devlink_notify_filter_set_req *req);
> +
> +static inline void
> +devlink_notify_filter_set_req_set_bus_name(struct devlink_notify_filter_set_req *req,
> +					   const char *bus_name)
> +{
> +	free(req->bus_name);
> +	req->_present.bus_name_len = strlen(bus_name);
> +	req->bus_name = malloc(req->_present.bus_name_len + 1);
> +	memcpy(req->bus_name, bus_name, req->_present.bus_name_len);
> +	req->bus_name[req->_present.bus_name_len] = 0;
> +}
> +static inline void
> +devlink_notify_filter_set_req_set_dev_name(struct devlink_notify_filter_set_req *req,
> +					   const char *dev_name)
> +{
> +	free(req->dev_name);
> +	req->_present.dev_name_len = strlen(dev_name);
> +	req->dev_name = malloc(req->_present.dev_name_len + 1);
> +	memcpy(req->dev_name, dev_name, req->_present.dev_name_len);
> +	req->dev_name[req->_present.dev_name_len] = 0;
> +}
> +
> +/*
> + * Set notification messages socket filter.
> + */
> +int devlink_notify_filter_set(struct ynl_sock *ys,
> +			      struct devlink_notify_filter_set_req *req);
> +
>   #endif /* _LINUX_DEVLINK_GEN_H */


