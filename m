Return-Path: <netdev+bounces-48192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4B7ED1E4
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEF11F2634A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25453DB9D;
	Wed, 15 Nov 2023 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6GyAT4t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571F5E6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079453; x=1731615453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELRBF2AFjO+20ESh1j5Y1O2NiAraxE04cKDEtu+WVcA=;
  b=P6GyAT4t4ScNkjKIyx04kXiwVNmWKNqzmWv6xKW90YEl1vhERa4fef0i
   l53dPU82jpPYE7NQ/EcS0ucK7qkBTq1GExagsxDAncxLteAFzYZ5Vbr2O
   iBRMyZjTf6LIGy8TS5g8M3FKgok92udRpzutyMO4cd+j7uK+DVndqbCIr
   gDYRr1ErX/ZT8D9geghYHbzV/8eMo2DR/2uWhBJ5vVWqwIVOYBdmLLgHo
   TwSgzuUMwMVVCJLPNERSu6RpRg7j7t/1o8zWNoJVMFu8iR748lu1EhPBC
   92gLEXZGui7ImFKdzAXRCxhOKsOaYhjyt+zYl/tT2JpHpDjbhNcb6GhD+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="12501880"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="12501880"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="831039070"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="831039070"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:17:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:17:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:17:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:17:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNpTdJZCgkwPHbKmKMsyCpSAC4A+iHYlx/6igzJ8tb7ZBa4IP6FhdGj2CcTblqjeML55jb9aBC0pI27dgioIrU/pIN7I2Csy6UeRX3Jv7Sx/nTWn37KVS6OZUjGCyYfazNugBmjgd2hCvsfvLnCL08rtPhLmMG4u8HTAyTQ8jWfmKU/W7VsuBRwrMwQKS3HGVowgwydQB0iwmzSX8s5pVipHKmGlc2JPulQ0K12ruvqTLCPzkls5ycdtNDNDL+zScYWHio9cxiaHYuR49GvszkLphLN3dKZS6gVKIptFT4PoPXiHNX9VwSr2xzkW9kBrU6xkU/RAGic/96xbH7In9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfG9JXRDCZrYHK9+iPYaTjQ2dJj+h6OnWJgdHbLLvV0=;
 b=WP9cAM6Xo/1qLoEhOTGag4SkkZPkakkuSiegvp1FOf7HWTFz53gvL4vsZ+Vzm6SNY7AykpVYAiLh3+OPnRLKvmco85OsBvGowl+U9NMHn3ItOSlHLLdFr0KWtkJYXCjcJjALQORm2+uwks+Cn8PLrcO61Tj5pDB3DlYTBjtd+5Jr8MMv08vILb0ETCPMiLwrhrNhbJ4b1WFsh81ViYaP41tunY3Z0Uu5CGVoW0TFzyGhSYtgog1AWAmHI+0llqgiU52GP9Xoh33wUxUFlxXeUEi5WfRZCv5Kt1rIKD5JZt1yx3MShJXKJ0kfVf6QZbIuxyEOtqOsR3qJneusBjFvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 20:17:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 20:17:24 +0000
Message-ID: <63a83bf7-b2d3-4af6-b87b-4e166fa22744@intel.com>
Date: Wed, 15 Nov 2023 12:17:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 3/8] devlink: send notifications only if there
 are listeners
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-4-jiri@resnulli.us>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231115141724.411507-4-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3508d0-2374-4e7d-8c32-08dbe617e194
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 43MqJIote982g00eqV2KCpoC7LieFQV84RCUjnnvIL1CsynDFvKT2lelP/G/2QZ5DcyXUhWufECr/dytb8nYuV29GU511vCiKuo/O2AfQeZ1zKjFsFMXHqMv5KGxIT/MtbVyfpms/wputtFvgo86C2OfVYctIJaepjb6mlP1iDkIQ843M7Zc7NWLi5FxCoHmupi8dFU3f1nD3kQ9MphNoJ/XmETpc/D8SzV30K832EY/QbzirBkFdXDTgEUI2fPC8JObaf8L9KMM4Cqsrl2GUQyYO9R3ZH2F6aSSsGskxQfs8yeSB+eaNPdadhoaQi2qbrCaO4tKAvCvE/jIM6sU2xyBGT1Q3GrSLj75oAaHhUUZj1IRs16Nb5WqLJ5FGTUJhpQPSC/Orrwf1VVQoU0i58ylWv3wclKFTo5bgJFuQ/Vb0Jg6dHIxpcUPJdcdzn/pdE2Vj5ufA8MHxabV4OLp2lu9A+8Ind2cECX2g5kNkwLuRh+ExzIiu8kJ8ZILk28nM69dR5oM4Usycei9ZoziE3tOdjFsOJu97H42XLfp/aF/nJVh+lz+yrK4X8hu5BOKMcMp5Q6F6A2depckb+lpUIs42mc82mYMx48yqeXnihlPqQ7TBUDv7OuOm9bmlPEhajcL1NS3RfNq0jSp/TEn7S34XhpF7eUX5HvCpOHGqZ3hJeiQTI6sV27aLdSjxeap
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(15650500001)(2906002)(7416002)(5660300002)(2013699003)(478600001)(83380400001)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(36756003)(6512007)(86362001)(316002)(38100700002)(6666004)(41300700001)(31696002)(53546011)(2616005)(6486002)(6506007)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01meFljbGo1S2MxUDRwaGFvcXVCVEtZcTEvQ2RHazROajFBalQ0ak9QeCsr?=
 =?utf-8?B?RGczRTA0TlVvVzlQTzRWdWsrTU5uUllrQ2ZDVDQ4dXFIVDVQOTJiazVsUS9V?=
 =?utf-8?B?UDlKYzE5NEpqSFdZcjU0UmFHQmtEUGVEVElCaHh2aFpvR2h5b3h0ZktUeFJV?=
 =?utf-8?B?NHhvVk9OQUdlNXByNjV6Vk5JcmYrajRVVGRydVphVGJJbWtBejVmajg4SmV6?=
 =?utf-8?B?TS9NdVhXYmV6UC9sSFVlOFVISThaVTRYRnYvandqZzVDOHNicDlOcDJHVThm?=
 =?utf-8?B?VWtOWWlSSXozODZ0aS94RDZJc1EwSVdLajBJcXJmeTRaY1Q2YmZkS0hWTndC?=
 =?utf-8?B?aG01M0J2SVVodWFGb1U2a2V4UlRJOHc4NDlMMHZ4N0FFdVJndjhtblE0RnFS?=
 =?utf-8?B?bmhmTThqSkVZWEdabHprWXBmR2ZrTzB0QkplSVpNSStnaWdEK284eXFTbGdp?=
 =?utf-8?B?UkM5RWNJNXlqQ3hhRmF0ekMvOUNQSHk4S2h2aUxVQzc0TUxQSlB1NEhBVmNG?=
 =?utf-8?B?L0tjSkp1T0JwTExYbUtVeEZGQzA5Q1hpWlJPVFF1b0o4TGlNTkpINDJpeWJt?=
 =?utf-8?B?Ym8zY0RJV1U5UDFqMEpYakJldjJnY1NGc1Vza0dqdVBDREFobkY0VHNZeFZ3?=
 =?utf-8?B?MXlPN0tCYzR0OVlXZjJ4aytkbW5Wc1laTzkwazY5UDNDUDlFWHJiR0hBb0Ix?=
 =?utf-8?B?TkF3M0s2RTBkSG9IWDV6bzlWRmJkRy9tdkhiUVJOOWVZN2I3Zy9yOWRSZHdM?=
 =?utf-8?B?TWpObnN5Y3lUTy85V0ZWcmpMc3l3YjI3ZS9QMWpCMklZQzVpUENXZGlXbEh3?=
 =?utf-8?B?YWd3bko5NWI1eHFGcnV0MnF6bzRudEl0clVWd2xKeGJ2SjNiZUlWQlNZb2xJ?=
 =?utf-8?B?bXhGVWY2ZU5Jd1liSHMwZldCMVJMT2dUekhOMU81Zi9FY3c2TXdkbFlVMTQ4?=
 =?utf-8?B?ZHRHK3FNYWJEM1N3c3lTQXo1V1lzV1VwQ05ZSWZFUnRnSDJGTmhVb29mVTlQ?=
 =?utf-8?B?RmN0US9tdjAwNExsRDV0ajMwOW5sQUsrRU1YVU1xSWlic2I2SW9OdDVGd1Vq?=
 =?utf-8?B?YnpVWUUyRnhYWWE1cW90TjNrTU5RVGdsQWY0TlNZc3NWdHlTOFM3NFc0WWNj?=
 =?utf-8?B?dW5RODNYZm4rcmdpR0h5OUxDb0N3clRUU292VWVMam9SMDgvVmNPT1BqaXRE?=
 =?utf-8?B?RHhTdzRIaTZtZUJXQVZ4L0xFMGttMlhFMlorNWpNQm1Vam03K2xrQm9ZRE1h?=
 =?utf-8?B?RFlIVHc3S3Q5UHVudkV2MXVqcEg5Vjg5UEtGT2lJcXlCY3FaMnNLblBkU1RG?=
 =?utf-8?B?UXkrTXhkdkZLRGRoTm9Sekd5WW04VWsxTkhRKzk1ZU5VVXNiWEh6cE1HOTEx?=
 =?utf-8?B?dWVNTHdKd1lOeEtrQ0M2VjRpT0xBcUtiSFJxZGM4LytaKzFkM0xFbEYrZTUv?=
 =?utf-8?B?V3hoN2ZiUm9va0lHT1R5cURGcEk5cUJ0Y1F6L2tGaExuUVRsL3dpdi9nUTRI?=
 =?utf-8?B?ckxMeTk1L2plVFBaWUxkamtPUzhUZXN0YXlDdk5TTDJkcFdPL2gwYWdWb1d3?=
 =?utf-8?B?Z0EwN3Jpc3BGTWppaXdmV211WDZmaTVobXlMN1NyVXFHbnk5bVR2UHM0OThk?=
 =?utf-8?B?NWFXS20xRXhQTjgwN2V3dlRDZG5yNGRUWWhMQnppVldRa0xrMFo1ZW1DUnpF?=
 =?utf-8?B?QVYweUZJMkFJTHJqOFY2OENLd1BScjU1OVREdHhuLzEvRFVPQVJMREgzcjBu?=
 =?utf-8?B?SlNXYjNTenZRcGNoc0plRUlSNlU1MUtQS2FVbW9QeU94ai9sdlNkQ3VSZm5y?=
 =?utf-8?B?WXJQQm9Oam5QM2M3ZEhKN3VGeUJTbE5XaXJnY2hTb25lNGM1QmQ4dnV5dnNo?=
 =?utf-8?B?bThYZHV2NmVjQ3BDYmZiTGR0cjBLMDA2MnJPSkhieTYxR25UMGZJSXl6YjFn?=
 =?utf-8?B?Q1dlcDdZU0ZoRGZBM01WdlJoeHB6R2t5QVF3d3lrZk1ha3JvRUpCbm42NzJU?=
 =?utf-8?B?V0Q0TTFxQjRYWWtrMHBVckZUcUZobFZVSTBDTzJTYytWTXk3VXpEZDE3VWw4?=
 =?utf-8?B?dnBmTDBzZmFYeFJmSlRyY2NLbWZGQ1BoZzhzR1R5WFFFWEFmbktxa2paM1pB?=
 =?utf-8?B?OGliOUYreGVCQjVMTE1SMDhzVjBRa0VERE1TR04zSE5jTFpEM3lLWGNadUFD?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3508d0-2374-4e7d-8c32-08dbe617e194
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:17:24.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnEPC1QoDfXFCcYbM9WmfEPGvTTjffdtQ+R8ffeNciJIBuT8R+XdoVCW7qof8rJm3PZ8rF27mwIYUgOAhliwV7UXiAHnYYRMzN3HeJnTO78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com



On 11/15/2023 6:17 AM, Jiri Pirko wrote:
> +static inline bool devlink_nl_notify_need(struct devlink *devlink)
> +{
> +	return genl_has_listeners(&devlink_nl_family, devlink_net(devlink),
> +				  DEVLINK_MCGRP_CONFIG);
> +}
> +

I assume following changes will add more checks here to filter here so
it doesn't make sense to call this "devlink_has_listeners"? I feel like
the devlink_nl_notify_need is a bit weird of a way to phrase this.

I don't have a strong objection to the name overall, just found it a bit
odd.

>  /* Notify */
>  void devlink_notify_register(struct devlink *devlink);
>  void devlink_notify_unregister(struct devlink *devlink);
> diff --git a/net/devlink/health.c b/net/devlink/health.c
> index 695df61f8ac2..93eae8b5d2d3 100644
> --- a/net/devlink/health.c
> +++ b/net/devlink/health.c
> @@ -496,6 +496,9 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
>  	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>  	ASSERT_DEVLINK_REGISTERED(devlink);
>  
> +	if (!devlink_nl_notify_need(devlink))
> +		return;
> +
>  	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>  	if (!msg)
>  		return;
> diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
> index 9d080ac1734b..45b36975ee6f 100644
> --- a/net/devlink/linecard.c
> +++ b/net/devlink/linecard.c
> @@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
>  	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
>  		cmd != DEVLINK_CMD_LINECARD_DEL);
>  
> -	if (!__devl_is_registered(devlink))
> +	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
>  		return;
>  

A bunch of callers are checking both if its registered and a
notification is needed, does it make sense to combine this? Or I guess
at least a few places are notifying of removal after its no longer
registered, so we can't inline the devl_is_registered into the
devlink_nl_notify_need. Probably more clear to keep it separate too.

Ok.

