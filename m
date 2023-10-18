Return-Path: <netdev+bounces-42400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA67CE968
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43DD1C208D9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96A199B8;
	Wed, 18 Oct 2023 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN8zqvo5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0F3E017
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 20:51:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB739B;
	Wed, 18 Oct 2023 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697662275; x=1729198275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u9DO9876tOY+pPgtwgiaEgaKpQMj1fbOYHNHjIJ7/mw=;
  b=YN8zqvo5qLWpEiE8qE3GfsfjMXOYrhrwXu4+qDyZyLjsTyaeM46JSkpS
   FfccDFL3K7i1wmK2+GigaB05RAkImNRLC6zoZqcfe1WBQwgTiugJ2xcKj
   dLsY0UNl5kAZSmSuPaMeG0zUjuaTidBcpVqnVK/xNE3TZit0BHP1ccYnB
   YgTSlk06XV1HeQ/TMZbdgxDic8a6Xj/DNiev7GA2PUyj3BJ7GcbwxfX3Q
   pVSVmaRTwkQ/oWXGOGRXHnOaNK8OF/a1x6vqN4yARD3JSA27ED/5TnTb6
   Xiopgv2YOXIb2uMmHxkbUvURQ9G0QfjcTq1inXEbFkjKMYHQHaL60HQbT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7658641"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="7658641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4492757"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 13:33:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 13:34:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 13:34:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 13:34:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 13:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQU7R+wNx+Yxfdne1EVasbQcYAd9kaqHQUj8g8I54omPIgJ35vrBwsaRdpUjMvKgyhcoT7m5+cSfGt30mRB27bRFOIvr2RKjuCk0si/BWUETwPLIv2KJaWMT0ha+CeE100kXVSZNwms37sY4EVjDYQr4un9JdAFoKHpnhmKJwtTysjAPimnBg7Vfkn25/E7hgQ17WYtxqq54XK9M49sGDzwZSEhj8ljYY8Lcn7MTa0CGnuw3JF0L3ZnflZprSP1uNGi6ZqHBoSzMPPS6FQ7pQAFxkizBp5I9iI3FsEB+q6Z6KHHK/bTC0gMGCoBfThN2Y9GEKkIbH8IN5fe9IZ/bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrvFcnZzvD4NxjpqTuvHhCV46sISBuKglVL6Go0cpf0=;
 b=Ybog6zM5Yay9RsfL2mLDK69CpN5zZybQqzhbRN6rVKvcyKEnZ7axlWfcIycnSoj0MZMdhECvYy+xxpQloKdiQFra/w2dluqahtVsAaI0Cw7ZbQMBLu8X4L9a8TYfFDtaSZZvDL5yOFZkWFLjajqGVcRrc2aUZ1JaHnsQPffIXQ3PTvK7xq5U9yRKjRTPgStFek1s+4dK6i0oMpGmhEqKGc4Xn/ChQ2UwyqJOGu4pY05mwOvlyln07IIJ9xL+4xk8fUY9NmS6MUcW6Y4ZekrmtMfpXvpSPWxbcJzsuZxggaVlGicG+HJbii7wdD6xpwaQrua6YwY0UdSyWpQVTIsQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB5487.namprd11.prod.outlook.com (2603:10b6:5:39f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 20:34:27 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 20:34:27 +0000
Message-ID: <ef479074-966f-142d-2839-f5bb690b5d76@intel.com>
Date: Wed, 18 Oct 2023 22:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] ptp: prevent string overflow
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Xabier Marquiegui
	<reibax@gmail.com>
CC: Richard Cochran <richardcochran@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <d4b1a995-a0cb-4125-aa1d-5fd5044aba1d@moroto.mountain>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <d4b1a995-a0cb-4125-aa1d-5fd5044aba1d@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b2be1f-e221-414a-b7a8-08dbd0199ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0egI8Hdi1xkGsix0oPXy8+fvauUbvW6IVw+OXHddQvqvNXANqVfS+t46rPcDdRNqnA8R6YfAuXTZgsmktGGaSIiuy84t1pgqUWyNtZ+tvM0+LtLSY9aCcpP8rjhy7Looy4dVrF0iyp20qcHMmalg14/z+sZBQrjssNvtJAthXP0kc1Vvv6V46AKJwIE3QH/4T0fCPgeAr8+vfyPs4oM1W2Vo42XMECNMjMF9RlfbTaWQwFr99viZqP0AU/dIANBz83pqKgbczCGF62k+tJWqVwU4tfVgjIoEy3bcnuoi4P1vHV41ggcOjAwBWVFvh/XUTlDeb/13iwyxNdVH5jyyI560Ntje8SGyuZYaodg9jiNSGUmezn507cla9U3yz/O6pxYEjLIvNNoYagCzOBLZ4abTCZVYDWCm41Hu6yVPvvFuLUzBNV+pNj3oZcrjNgYOoXkvfEtyY7ESITgAguFhesPxkmwX9rbsqh033nM6lSz59e0lX2jgjiROZs/843dYa4M6awtHmhNki/UdJED7sstA/ZZ1wzYPKG9Wcx76VCkp/dWNfCY71Jz6KPv6MDXQ9834OKsccmOXIWxKoOUQfVPpDSATHNwNtJSJZWZZGgOayQxEb++eWg8a7gAwunHlwjsKNAg34XaY+t0APB5ytw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(83380400001)(38100700002)(66476007)(6512007)(36756003)(2616005)(316002)(31696002)(86362001)(110136005)(8936002)(66556008)(54906003)(41300700001)(5660300002)(6666004)(2906002)(8676002)(4326008)(66946007)(478600001)(53546011)(6506007)(6486002)(82960400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZSV0swWlNBWWlJSnVXbkJFUURnb2dVaW5qQy9kNzZ6TXh6bVl2b2ZHMnRL?=
 =?utf-8?B?QVZ2a3lNcE5MeC8wV1hQK3NkL3lmUHpNb0RXcldJOUdhdWd2b3lEM0JyeE1x?=
 =?utf-8?B?USttRms4UlYvMWhNQXNLZHlRVzZ0TG5MeWVIdW1FNWhwQy8zaEVrNVN4blJz?=
 =?utf-8?B?anRZQWdHZVNjdFBqcW50U0h5ZHRKOFhSMVFJbTNBS2ZyN0RIeUg2ZmxZeHJo?=
 =?utf-8?B?bWcvbWd5eWg1bFdzeW9keTdnZFV3amd3RnJiL0R0R2tFTHFId3lFbGxON1JX?=
 =?utf-8?B?bEZJTDk1RmJGWXIwOU5lZEV5NlFOV3ZEQm15d1hzamlUUnBzZy82NXhlSFVr?=
 =?utf-8?B?MHM5N2JEOUlwdGJYZHo4bnhaQU1YU1VlN2FDRFduZklRMWFXU1d3S3ZiU2Zm?=
 =?utf-8?B?TUttbHYvNVdwRDBtK2M0R2NqS2FUUFJ5YjJUejNvbGEwN0l5akFtSmlBb1RL?=
 =?utf-8?B?SVJXb055RE1kUlZWR0F4ZTRubml3REI2cVhwdTYxK2l4VnBwbWNnTmthOURx?=
 =?utf-8?B?cG5zMk5ya1dIQ1VMTVVSMUNEcVhON25XU1JtUWdPVXZSNmgyU0RtOG1XV1E3?=
 =?utf-8?B?ME16M1VhRFRrSWdaekNUWlgvL1BjamV4NHZJSU1HVm94NWRSMDN0Ykx4a0RL?=
 =?utf-8?B?cFBKVmdvWVVVZFZNUHVCRkszbm5qNy9Zbk1LZ1FRSnFYN1JpRmUwYUxYNVJn?=
 =?utf-8?B?Wm95c000ZW1yNXJLTGNCTFBidWg2YzVmdzJDRUNlcGp4ZUpibVhXTk1UWHVS?=
 =?utf-8?B?RFBZNURsSmFPVk90ZjVmNnZGZGFmbHJPMFNoeUJWRXVrdDJ0VnBiek91VkY4?=
 =?utf-8?B?dE42aDk1YkFQSVdQV2Y1MXdRdGl5Qld0S28wY0hObEZtazVDNjhtWjdCNEF5?=
 =?utf-8?B?Uks5UldXcHo1SHZJRFJ1YldvSk9hV0JFU05TOVVHUGo3RGFjclNVYlVJQVlK?=
 =?utf-8?B?b3gwZmh5NEg1YkRkN1RRNWlDM2Q5YTFxNEdyYzErSEtKKzRLemlXYXJycjVx?=
 =?utf-8?B?aXhDRzlVdDlOWFR6OW40NnpTemd2ZUpnL01zYkdHQkdOWmVsOUY0Q3g5c0lx?=
 =?utf-8?B?Qi83d3hpK3J3UTZxaHpxWVNkQ1paNHJIaE9GenBUS2RIU2tVVkN6VUtpNlVT?=
 =?utf-8?B?YzRTd2xMZktYc0tObWIvbENGMmtzRXY4Qi91R0pqaG5VVVJ0eEorTUhVRjV5?=
 =?utf-8?B?cVFiQ2hEMUFMSFo5NWVtaUZOKy9jWnFhL0ZSbHVJakVYU255cEF1OXM0a3Jt?=
 =?utf-8?B?TFl0VnVQZW1IQ1hXcm0zYWY0aU5KR3ZuWmFhb3VmQUdnSzRsZDFsZElhbWFE?=
 =?utf-8?B?L1d4ZDh1QS9OSExmTkdReDdISWp2RTMvZXpXalMvVnRzdWVkYTNENjZ6bUM2?=
 =?utf-8?B?SXEvMWlxWkpVQ1h3bzFxb2ZpUktQa3ZFaXErNGgvQ0J4ZFIyeDNiNnNHaURR?=
 =?utf-8?B?N0JmdWVVT2V0SjNZWDRqamRxbkZ0MmVCenRWR3JNRzVGclRoNGl0dUdxQ3V2?=
 =?utf-8?B?VVllVDZrUkRFaGRucHVOT3hkOGVjVi9qMlpaejRyMUJ2K2NvVU9KRzRoUzhl?=
 =?utf-8?B?bDFOYXFYOHFjRHdsbkZKcHRIY1hlRGFDTXA1TERkeDBmNXk4TkNsNW1lcmF6?=
 =?utf-8?B?RXhod25USkUyUHNLczkvWWJnMVBCUmMveTVsakJlcHZ6bDRPaUtrS1pIaTls?=
 =?utf-8?B?eUJjK0lDMnA0WTZxNURqa1dqRzg2QmFWRWU1aDZqam9IaDMzajZRUElyQWk2?=
 =?utf-8?B?MG9XM1JtUUdndlZPYzM1UDFDUzRsVUlTWUNaN3haZ21KT1ZlNWI0alJ1Uzh6?=
 =?utf-8?B?NVFxbmlCMitVV0MydEN6dGVxUWNWUC9WNkhKOEk4TjZNOGNUNUs4MFVTbWs3?=
 =?utf-8?B?a1F0SjN5UDdDdUVWYnZoS2xFS2ZKN2QxMmM1ZzU5NHh0RTc2MkJxcktQWU5j?=
 =?utf-8?B?c1hGdTA2UjVoWXRXUS9wYVFRZk9UNFRKUW12SlkzKzZlZjhzYUVZOWxRYmV3?=
 =?utf-8?B?QW5EenJmWWNLUktqSDZYM0M2N24yb1VZTlN2MmhmZTR1MnJTbUVpVmptMHJk?=
 =?utf-8?B?N2pyRWZKelQ0TENMR1pCcW0rT3krZnBRRVNlUThPNFZUUkMzQTE4dERKTlJD?=
 =?utf-8?B?YkJzSTQ1UjdDTHFjamRWbmMxdVFzQk9DL21rUmFoVHFQZVhBNENqRU9XaWV4?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b2be1f-e221-414a-b7a8-08dbd0199ec8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:34:26.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AR9Gty9+XyyVwnSjSFOROWjh3/zSmGCYASNnpNOeG6TVHnDIuFzJyyfHudGavZK6357pYnhNV1meI8MqicW4IGOe28nd6jFGIVb9OBBdfCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5487
X-OriginatorOrg: intel.com

On 10/18/23 16:20, Dan Carpenter wrote:
> The ida_alloc_max() function can return up to INT_MAX so this buffer is
> not large enough.  Also use snprintf() for extra safety.
> 
> Fixes: 403376ddb422 ("ptp: add debugfs interface to see applied channel masks")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/ptp/ptp_clock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 2e801cd33220..3d1b0a97301c 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -220,7 +220,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	struct ptp_clock *ptp;
>   	struct timestamp_event_queue *queue = NULL;
>   	int err = 0, index, major = MAJOR(ptp_devt);
> -	char debugfsname[8];
> +	char debugfsname[16];
>   	size_t size;
>   
>   	if (info->n_alarm > PTP_MAX_ALARMS)
> @@ -343,7 +343,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	}
>   
>   	/* Debugfs initialization */
> -	sprintf(debugfsname, "ptp%d", ptp->index);
> +	snprintf(debugfsname, sizeof(debugfsname), "ptp%d", ptp->index);
>   	ptp->debugfs_root = debugfs_create_dir(debugfsname, NULL);
>   
>   	return ptp;

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

