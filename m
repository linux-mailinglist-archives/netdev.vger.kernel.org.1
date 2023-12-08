Return-Path: <netdev+bounces-55259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88E80A03A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A515C281886
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8A13AC4;
	Fri,  8 Dec 2023 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5G3Kvdm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A210EF
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702030032; x=1733566032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KT6LEZl3j8wvrGXloORsPXksnXVfCB3kuawYOGnAwH4=;
  b=F5G3Kvdm0AwFk/FKDl+AshDbXEFzS7vkcDbzbxYUXztT1Y3UY/2De45G
   IhocfWgERv7bI2BpDmeJ1Tv3RPZWV6+zvrtNp9h65niv36GYc7lZgPN0m
   kmGuCnXTfuxaNjz7ahOnQ5FwLJj5RgGpAAAhA1TPIAaCAghzLzqnLLuNF
   4c6rni3znSHg9O9CbO/PFZq1O8HOUdWtdU46frk+0hJpP6cU3J7L2g1ra
   zJ5acje4rqgsVV/155rQwijduG6yV4wA4GbFYh6b02I2CUJBMRlWqSQ7m
   0c+izQPd1G5fs3H/zLz0uKD3dQfnBO75TgZidnYDpHECGsZ3bevBNeTfq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7745565"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="7745565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="801064260"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="801064260"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 02:07:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 02:07:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 02:07:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 02:07:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 02:07:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apz3/y2AqeSzst5qw6adWgxnYCfRubjlO0UHDv3fiFn0Gdgg7yIQx40RW0lCUSA7Ib2fyWsy+WcJTqHiMIzlArbZge7XZo8sg0iI8EeMpjcLZaUiuAuBB/4LGBkmrQp+31Uv0ON/JZ3eGapDEAwEWiLSjPeRhY8qG1NMuhvrcbIqNZusrs1SMRjoxy1fC8tvfU/j1tGCI+DDa/cXYgvRJhjinmluOnnip1ufEYNMSrQqORd6u5xBwazob4BBm6CpgynCn8Cq2v93JrVegoLzEAajAV4Fd+NIk1O8tx9PazFDoaeRhNbaBRiUF4xSgPnFQR7Rh0Tbt9efQz3flRwx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKPY334gUjQhiWOH/KZbeVlhs8A6EceowYVsoWZN4mw=;
 b=YZfyUIJY1u6ZLh8K4+saCn2xyeHIbDFf5A/dbwqXVsAhemPwEx4LvKk4dAAwpezYXMenGQapDNSV9BUfJsac3b8j8oQrUUbO6+LDptuAM5MkMflIBM9pSquPoetkPNUTG67x2z9/JfKhzDtxvmkTm4GtPFEDoZi3RzZzomYeHH3htoWPd7Z1heXDBj8XehZ8+3J3nUNi9dzbBFX9qA0JbVuKb9IhldmOZZcTKnFWLiFmeBagSIWnYgwJAexTyyIjpLIMdq7A49dSLqkivRieuM/jNcgcAy4HxUqiVdqMjk3gtTonF468Y27laOdNjJUA4bo1W6QSIFzlhx9aW0OAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 10:07:08 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 10:07:08 +0000
Message-ID: <f63dca8f-0082-6e22-5ab5-3b940b646053@intel.com>
Date: Fri, 8 Dec 2023 11:07:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next v3 1/2] ixgbe: Refactor overtemp event handling
Content-Language: en-US
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>
References: <20231208090055.303507-1-jedrzej.jagielski@intel.com>
 <20231208090055.303507-2-jedrzej.jagielski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231208090055.303507-2-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY8PR11MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9db77b-d98c-4107-2dd6-08dbf7d56f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dy2WdfFSk9R0dZyhwtXavZAd/37yLG0Y0LTVp2xEDbe+CucXG0v16wCpX9W1OY75yCy2i7XtepyipdNIwwbbloEID3ymLWQhiLxhNnFblYtrLo4Ru6AhMI5MvWSfm8MHqT9lOcakhFm+W2a1FH9w+/j4RmxOTNDMTEamtN2mOW5k5meFoDLAKiuuvPoSb5OC49o6LtQia7lljwm7Cv0MqTnYA5rJKeTA4lfVa4RfGn6OB8HAQk2yVnlaYW93pFDhwAJ04HIDExgKVBV7AMt5hfJ1hDB8sC5US95SMA1717oI3abKr3GPCPc+E3Iq2UEn5uE33FmgfiI/K+MRKD38lw4tFmheg98wSqY2Y1LvU7NXan8BksfjRaPsfbpTO05Pv2L+OkHd6p2/oVPLiqTmkf+uQBOB4ZGCKWSdJqlLHhTPVQLNrR+Qtw3lxYrl2ZQwxgA7Fmpsd1L8zHfcNfEncQBfRPqcDlvtz6x3za43YMMf1gwHFTldEhR3leQZk6f/FUcF/5pOtU/29UyIz+F6Rw/kNlqUowfHhd9/QJ/jJWuP7BuEoh3xMkNl8Mgim5SQ9vbD7G3mAmHLaT+96+K2D2Pclf3mM8Vfk0ulxpKlMciVb2O1RnVYn3D2qUcOZkrqoB5gkU9ZBIOjEIUoIh2iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(2616005)(6512007)(26005)(38100700002)(53546011)(4326008)(8936002)(8676002)(2906002)(5660300002)(6486002)(478600001)(41300700001)(6666004)(66476007)(66946007)(66556008)(316002)(6506007)(36756003)(82960400001)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVg5VjRRSGpaSWZRQ01OVUZlU1A5OWp5eDFmTW5wdzdHSzBpMUZCbmZVWFkv?=
 =?utf-8?B?OGhmZ3dNQmFMa09ldVJ5cGZ3SHdRS1JTVVNLOWxKZVdKM0JVNnc1Q1RRb0xQ?=
 =?utf-8?B?c1k0T0RTN3gzZXEybk9aQ1RZcitqQkV5RHNDOUxjd3VWVmdQa0VqMXFpOFAv?=
 =?utf-8?B?VjByaXUrcHpCV0x0UVU3SW91MXNHV3ZmalRyN3NQNm9Fc29WcVJFKzJmaTly?=
 =?utf-8?B?WFQrWnBmWkhXMnhHSy9BKy9FMW9ZSHVlTmNGenJKQzZPdzNYVVRRMDQ5ZE9N?=
 =?utf-8?B?a1U0NGFESEVRN0R6Nk92QU4wMzNscWRjVEpHSExoR3FvaFVkQzVQQk0wamdG?=
 =?utf-8?B?eUtFU2NQRlRDWTlFV1d0blk4bnVVa3JUYzMzWlRjOUgzNDFwdkdUNzBOZGJi?=
 =?utf-8?B?OW9lM0ZZTzRCNi9WYUxyQnhuUkMvQ0lleTkvYjVqS2VsZHFyY0ZQdmw5NzQ1?=
 =?utf-8?B?R0hES1ZNb0lvTVRjRlBxZGNIamFIT1cwWGV5MWs0V3BVMTdxUWlhV1JVYTJz?=
 =?utf-8?B?TG84T2p0L1ZkTnpFa3c1bHdiclY5WFh5STVaN3M2U3h3eTlIeThZTitsTmpj?=
 =?utf-8?B?aGRSRkYrL0VzVGs1dDRvb0lhaUhBUDNJcnYwZ010UTRxSjlYM01UcEM5d1Na?=
 =?utf-8?B?ckhIYWk5NENrTVB3U2dqWnF2N25BcHY0VElzOXpnVWNiTWJldG1OYzBqTWVS?=
 =?utf-8?B?NzJBZzVocFozK0J2d1JJWGc4amJGVFdvNmtCem9kVTBYZlZzMXh3Z2FESFJr?=
 =?utf-8?B?ODNnRHhia2p4YnN3ZzZORDlkVzIzMHpxMFdvSTh5U1RSTjNLMC9DYUlNNS9O?=
 =?utf-8?B?Zk5zbyt0Uzc4c3loTWtKamJJS1FIc01oVHZkclNaQU42czBRNzJiR1pJWDJY?=
 =?utf-8?B?UlZSOTFJQ3hmUDY1N2pPd1RUbDdiQWJ5MUVSQ3BIV28wYWo5bGZUNDN5ejMx?=
 =?utf-8?B?cjk4VWdFNXk4WUwyN09RNzMxUWVFeENoTUUxYWVCYjAzdW83bFY4SXNWWVJD?=
 =?utf-8?B?dUZod3hiV2kwSTM2NEdwdW9tYnl2L3YwdUdrUjJlczRBQmJNQW11a2xHbXB5?=
 =?utf-8?B?Q204TlZsSmszbGtiMVpCMFBNRFJBKytIa3cwdUtCMWc2NUpiaS9Va004MnBI?=
 =?utf-8?B?ZU9wZEtneE9UeHR3aTlNS1BZUmd2blNkTHVZdC9rY2VhbUtCNERHbjFKTVk0?=
 =?utf-8?B?b3ExeFd4N25jY2lNVitPNStPRGhkN2FtYWE0WnExRmdBVmltRUFsV25sQnJQ?=
 =?utf-8?B?b1dsWUYyQm92anp1SWJQem5lbTc1c3lRTnVTMUZVK1VwV0N2bFo3ODB0SFlR?=
 =?utf-8?B?aWRqTUdZUkZWZUlSMDN2ZXFBSTB6SGt6N2xhWmFoeWhrRE9nMnNsNjZ5bVMw?=
 =?utf-8?B?YjMvdDFwU2Uzd05QMnFqanp5ZlJ5c2NZaDFXRE9jdW52TkpDQWJ6dUNMSCt5?=
 =?utf-8?B?YWZUUGRPYXhGUmUzQnFxMmJkT1BNMndKQXhvTHBsKzV1bVdxM2FUWW5xRVpS?=
 =?utf-8?B?aUxQNzlQWW9tNG5YRVVYOGVwMFZEdU94UnVTYm0vS0JScWs5R1pMeXJvRDlE?=
 =?utf-8?B?ODFDWjduaThXb3JNRWpjQzhJWFUvdHZvTER1QjVkM2NCbnl0ZVNpeDZoeUxU?=
 =?utf-8?B?UDN0S29tTTFyU3BxL3o3SmRSVHRtcGIwbGU1K0cwekU3VzdWdjU0WFU5cGtB?=
 =?utf-8?B?dkprQWw4UUNndmRTeGsrQ0ZXZHU3THZaM01Rd2ZSelBxZ2dJS1FzMFgreFZ5?=
 =?utf-8?B?QS9LSzdTV0tpc2NKM05Lc1JXa1piY2M0UlZBUmZSK3BjR3JmallXYit0VUNP?=
 =?utf-8?B?Ni9XL0EzQ05OTnlsQnZabWZUdlh1MGV3TjYrVnF3OENpbXZBZXA2WWFpNVU4?=
 =?utf-8?B?aXNjOU44NTUwL1A5Q1NlbzBJQlBpYUJZNEhIbXlTSEpIUitxTEQ5UWJYV1Yv?=
 =?utf-8?B?TWJJeW56TW1jcmhUWGNVTW13RDNWRmR1cGZTSnJ0Z2dKT2h5UWpxL2lxZk52?=
 =?utf-8?B?L2VWNzJ1RjlYT0FsbGVvY3UrdzRWVDFzSys0RDFpTGlscXg1TjRKWHE5OWtK?=
 =?utf-8?B?NGdsR3NlNDhTcStncE1vaEV3bjZBODhBaGFpZWVuSzlrUmhkbWFmVk5Ybkww?=
 =?utf-8?B?bWlQaU15OXpSRW9qMlhNNjNQQUpYSHYwUkxicUNjOUxJcXhRQ28vVGR4c2VT?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9db77b-d98c-4107-2dd6-08dbf7d56f94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 10:07:07.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8LgXN1RH3kmRGkk4bTCvmTgCIALSaw/XZPyMuK88giaPWIQAG8ncifke4nHzk35l3sHnS6u6EZSWz/V4c3EovuEcTqQe2zSjv3bYBt+yS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
X-OriginatorOrg: intel.com

On 12/8/23 10:00, Jedrzej Jagielski wrote:
> Currently ixgbe driver is notified of overheating events
> via internal IXGBE_ERR_OVERTEMP error code.
> 
> Change the approach to use freshly introduced is_overtemp
> function parameter which set when such event occurs.
> Add new parameter to the check_overtemp() and handle_lasi()
> phy ops.
> 
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: change aproach to use additional function parameter to notify when overheat

on public mailing lists its best to require links to previous versions

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 33 +++++++++----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 47 ++++++++++++-------
>   5 files changed, 67 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 227415d61efc..f6200f0d1e06 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2756,7 +2756,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
>   {
>   	struct ixgbe_hw *hw = &adapter->hw;
>   	u32 eicr = adapter->interrupt_event;
> -	s32 rc;
> +	bool overtemp;
>   
>   	if (test_bit(__IXGBE_DOWN, &adapter->state))
>   		return;
> @@ -2790,14 +2790,15 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
>   		}
>   
>   		/* Check if this is not due to overtemp */
> -		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
> +		hw->phy.ops.check_overtemp(hw, &overtemp);

you newer (at least in the scope of this patch) check return code of
.check_overtemp(), so you could perhaps instead change it to return
bool, and just return "true if overtemp detected"?

> +		if (!overtemp)
>   			return;
>   
>   		break;
>   	case IXGBE_DEV_ID_X550EM_A_1G_T:
>   	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
> -		rc = hw->phy.ops.check_overtemp(hw);
> -		if (rc != IXGBE_ERR_OVERTEMP)
> +		hw->phy.ops.check_overtemp(hw, &overtemp);
> +		if (!overtemp)
>   			return;
>   		break;
>   	default:
> @@ -2807,6 +2808,7 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
>   			return;
>   		break;
>   	}
> +

I would remove chunks that are whitespace only

>   	e_crit(drv, "%s\n", ixgbe_overheat_msg);
>   
>   	adapter->interrupt_event = 0;
> @@ -7938,7 +7940,7 @@ static void ixgbe_service_timer(struct timer_list *t)

[snip]

