Return-Path: <netdev+bounces-41889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9817CC1B7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58D0B20FFB
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03541A9E;
	Tue, 17 Oct 2023 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksaeieB5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABC41A93
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:25:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05FB0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697541925; x=1729077925;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u5GQUedLvBLceswx72xzUyHksGLe2Na/YHcKJ5JtrMU=;
  b=ksaeieB5+g6iFaZMClD9FnT4fznw6/z6fDOMXJyqDptZh72JMi9ejl+B
   wfRy4ABRvViEIhiIfMWbFpgBS8uiYDcLpTjWrV6T8Ta980UQXsSbwMXBF
   dNFRPiXmEsJBuIRxsVeYueT7F6yE211vgkzF6Bxj34S05dsD5OrEWIaWf
   a9Gkh969UMBGT+yYpTWQ4+jdmhv5rCxtm7d/461ydr41BoPGXVqA0PcMn
   /2jyT8qHfDlvFYkm9VPSc3+3YMr042BcE1dNC2cDSMP5Col8writdcB3i
   85Cjyw3UlS5lHzbfpaZAHcVYEY+tbiH4RAES18xruI0OpuiJnQTnYlVsK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452235958"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="452235958"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 04:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759774231"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759774231"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 04:25:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 04:25:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 04:25:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 04:25:23 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 04:25:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDJgTsrsRWdi0GF6IlQm+RxIHSLU+N+cA3PRGeLMqsFjyKGq1CvSWUvUp+7k2OW10PWDVy32Pg2StXR8LFMu786doOCbAN77E4eTKjPHafrk6jw7LgyCJYiHbsV0vgEjzYgSscvXtODX66Z75LXjs0eh3II803qQVIAWb/7nUvrkEX9vD2tcFHmRSp6t/5af0W4ArPxYR4ZNAOxvh++cOPqzO/xKIgMbQVJHjs9SBZlnHB3OfKGNiSTyqtaHNG1UtjUjFOztYVPcjjQQBCOdyOdYTObmMY/LvabSAnsO8k8/vIx7zKhUsV6usC21b1loe/91f3Qo+Ld+Gjrqi7ToBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUWLTufnr06PnyEo7/iAEJnfF0hWy4wGzxwivFZxoFg=;
 b=h79fZSzna7ExNEzpLI7BCfmHBgeyO/QlHtpV6VdN/g4FYEXaiR9bkXj4+POh52WNkRmDT+oqmx1czm3cSspqKCBjwpKc86sGy7l0IwWkwSlVbpMyzvKwctP7i0j+CE6Dk5yYA3VVyhjDhXob1l1sRcUrIFyv7xW85xNtc7e7H7Nlq8vDz4OwE5ZSlrAVaEhRPnsPZkPXvwGrR254cjgaHXzdFoovXNUuTtAQqmGqHixbMBzD2Srm8WNSY8Vd8GBDRzSiUJCNB/FY3PoIRGwIzMR5s3IsyFs24B681qP7aBaz3WZV4AtS4x6YO01v9segUhWvqndCDmEVnlJ0yf1VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:25:21 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 11:25:20 +0000
Message-ID: <73c1dc5b-4add-0db9-0073-7ae8fed0c747@intel.com>
Date: Tue, 17 Oct 2023 13:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net 5/5] selftests: net: add very basic test for netdev
 names and namespaces
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<davem@davemloft.net>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-6-kuba@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231016201657.1754763-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 499942e3-b587-47e1-99f1-08dbcf03be7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io6A+ZPwsLFeO2p1FuheWKrvBa/TAK9//0wQgxzMLkIYXU1O3jXINVZivvbxURnWeKipaElTrEFNt82UuGCAUbNNXW1H/WCalRxlVgJBWt8NCPj3DlTcd27ERWD2wgmBOon/l5CrPGfm7ndgvWBWs8WkwHK/4ZTB2ppOT1LJj/9ooDq0uwxeRhYusJ8z7DIk6x9PW88/A245bTU9m2ubqa52Hz4ONiLowctvvMPpTfacYjucL/7RKwC3QEuLBmmEAvuyXDGXlpkpSBxOqnn0PaWEu/QRceUBDhJ36yKFyroEiODVEQY84SzWFCd081Q98dr6Leoh+VudwE1sHlfPHxW/0CkUVTSvn1zeEQTIfnP9/ieR/9UKqqexBUl2AFgGNA6KcKGbkuyR01yH99bsPhIkVnY/oGGUyi3asIYS557QY3X8iHbwKUy3pqvPB6Wj95TJD9alXk+fHUegzA3K1s9X0M0D2xGj/JZnTzhxj4RsnHZcBhGxjPfeUprSk42ULSplIijQ9WamEvO+k/57Rn38bOnJPWPhWbtzLcdV6ZBzlwjWlSK3qJ/AbzMCM5rz7+j8Da3Phwdf7/HooxRn/71YE1CyWXSM6Xj/NaENLznJAnqwIvZmYgzZYEkGZmKAHLHOR6SzNugfejjS/zB6UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(6512007)(6666004)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(6916009)(66556008)(66476007)(66946007)(6486002)(478600001)(38100700002)(6506007)(31686004)(53546011)(82960400001)(31696002)(86362001)(36756003)(83380400001)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01ycTNDa0drQS84cEJLSVM3Y3J6T2ZrS2VRNE9VaGpya3BtOFh5MW9IV290?=
 =?utf-8?B?RTgyUVhzbVNWbWdqeXBvU0ZiY0wxNHJ0b0Jtb3Z3d0QwWm55YmNwY3ozUzcx?=
 =?utf-8?B?M2d2RUp3Z3lnN0FmWjJ0ZUtHU1pYQm10M3lqMWk0OVNxdEFVZjdpUHpjMmpR?=
 =?utf-8?B?djc2Uk9wS0ZJMDZxcWo2b3liT0krQWJoVXpKaGlXTDNmRi96bXFjZGhacHJm?=
 =?utf-8?B?TE14anB1UkVWektLUlZMTW9aTUhDTVBpYTk2NTRlY1B3b0VoZU1HREdVWVp5?=
 =?utf-8?B?ZFlxSndBcGM2NjBEaTBHSkR3bnptWnB0TjlRSmo1QlZiSXExRk0yV1llbW9y?=
 =?utf-8?B?QnVpUzNwcEY4QytKdDIvTCtDdWRhZkZQb1drY2UrUnJUeUZtaGFudDBaSUQv?=
 =?utf-8?B?cHNvUDAvU1NGZmZ3RnlFTDJlNWtYblNLYW9vTklLMVdXNmtkQWcxUnQzUFBG?=
 =?utf-8?B?M2UxK0U0bkZxU3dKcHIwRytBRVZHV3VjTGlYd3AxQnhnL3NzNGZNY0hIVEI1?=
 =?utf-8?B?S0EwVVBDMzlnMW1UNnBkZ0lNRVNEWHpmQk9yUEFncE1ZMmxSbHFyTlZaLzhr?=
 =?utf-8?B?VWtNbnFaN1E5K3RTRkViZUhDTWNtRFZaWFc5ZDBsNFdrejF2eUg0bGFHNzE3?=
 =?utf-8?B?VHl5bUZ0OGg3eXhBakRnVTE0Yy9GVS8vSkh3ZnBFOFZvdllSTy9oeEdoWnhK?=
 =?utf-8?B?YUJ4WWV1K05KcFJFZUVuQ21DV0tKdW12aFBVRTNtekZONVR3anZwWmZHaE1y?=
 =?utf-8?B?bXpaZUx2TmtSVHcyKzdjT0tCc3hYWUJvU0diL3VrcHdqT2c2clBFdHlWSHJx?=
 =?utf-8?B?bXdLWDI0amoycWY5SHd4SDRIMmVyV1Nrdng0L2FVU01XYWlFdUxYZnlSRlNz?=
 =?utf-8?B?Z2hXOFh3ZXViOXQ5Q004RlJRMmRnNzJKYW5PS1hiS3dSNWRCaFNxdXh0Rkt5?=
 =?utf-8?B?NGFjVFp2ZytqVWlZWkdQZWh4M1BHZXlhSTgrQ09pcy8zMkFKbmo4eGJQa1o5?=
 =?utf-8?B?SDlyZWtQdWIydzBGUk1jUmhQZUN0MW9TaUJRZDFnMTFQZTZLU3lhd2NidnNL?=
 =?utf-8?B?ZEtuRzVpNkp0MnlIYlkxMjI1VUtIanRiQ2hRaGloU1A1Um1XYTYvQzV5QzY4?=
 =?utf-8?B?dGhvQmtWNkRBd0pWUWcwaC8wUEF5a2FKckVzbnhETHVOT3N3bjkzamxtSWxO?=
 =?utf-8?B?c09qY0dweDE3eGhXb0ZidUUxZ054S3pXMTBEM3d5dkdsMngzV1piM2VmNW80?=
 =?utf-8?B?MU9pMWNJaUROcHgvMjZjWVNLZS9zQWtGUnRYVzNLTmRaNUZMUElmSzBVN0tT?=
 =?utf-8?B?MGxvcEtpV2JoQXJaMU5jN2tRR1VEUXl3Y0VEQXkvRXdVR2RQQkUwNzRCTlhU?=
 =?utf-8?B?b201bjF1Z2czaUtIR1B3bFlSY1lTREF2a0w1N2pwczVUd0s0UDQ2ankxTElT?=
 =?utf-8?B?MDg5SzlUdHk3N2VGM3RtUEpacGZGUkVtRGcvMXBWTlRnaEVDM0tmdUpEY0Ur?=
 =?utf-8?B?eGRDZGRnY0JmMFErZ3NMempRSW1Ud3B1TW1WV1k0Rk1VWkVIZmIwQ1J0S3Ry?=
 =?utf-8?B?K0xPTjI4MkdrYi94Z2k1Wk5rRFJzcStRd29UWEdTQWt1UW1MOHU2eWFJcWVC?=
 =?utf-8?B?OVk3dmtIbXYxakZrT2VPRUZHQjBESVpMWU5RbkFERS9IYWdVUVJZREppakdj?=
 =?utf-8?B?NGorZnRZQlBVSVp6VHBmb28xeXZha1grWGtsa1VHckpkeHhKQW81OG9wcmVD?=
 =?utf-8?B?dHpTSXlmVjVMSnVIc0ZUajhmaG5zUnhUS2Vtc0FETzkwaEdpT0FnL0NqV2hs?=
 =?utf-8?B?NnpLNDMvK25haWhrejczSlVJdmRBUHdkR3E0eFdEYXpWQWJhVkYzQkdrcTYy?=
 =?utf-8?B?di9HVGVsVUI5MTNudEJFdVJ1bTNrRTROU2VVc1hza2pYT2xFZXFtL3BSdWZI?=
 =?utf-8?B?M0V4UHFkcHV3ajJvNmRtRXhOWXlHSkdrZUxUWFVheHR3Y1VlRHYraWlCN0Qx?=
 =?utf-8?B?bGJURnhTdnFCcUViejB5dGNvMldBanRyTjlibUVtYjlaUXBlbndNZnBIWXVW?=
 =?utf-8?B?SFpTcDdnSFEvQnJLOXFBTVpwUzg1UGFxRE5NRW5jaCthdUFwQmF3dEwwUDZz?=
 =?utf-8?B?T2swRkFEeTlTa1dDUDhNZlg4OEs0VlhvU2IrY3dEMzdCRVdvR1JvNnVEWnF1?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 499942e3-b587-47e1-99f1-08dbcf03be7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:25:19.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K30RaOCFiRYWMq+D+BSwzg6uI5eleM2orKO2d2DDcNgfHZpeCkb1EIILDbEv1bWhkt43MO7MxwnxAmkGFPOUiZreCS7RqWjrjnnMny/qA7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 22:16, Jakub Kicinski wrote:
> Add selftest for fixes around naming netdevs and namespaces.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/net/Makefile      |  1 +
>   tools/testing/selftests/net/netns-name.sh | 91 +++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
>   create mode 100755 tools/testing/selftests/net/netns-name.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 8b017070960d..4a2881d43989 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -34,6 +34,7 @@ TEST_PROGS += gro.sh
>   TEST_PROGS += gre_gso.sh
>   TEST_PROGS += cmsg_so_mark.sh
>   TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
> +TEST_PROGS += netns-name.sh
>   TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>   TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
>   TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
> new file mode 100755
> index 000000000000..59e4a498aab4
> --- /dev/null
> +++ b/tools/testing/selftests/net/netns-name.sh
> @@ -0,0 +1,91 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -o pipefail
> +
> +NS=netns-name-test
> +DEV=dummy-dev0
> +DEV2=dummy-dev1
> +ALT_NAME=some-alt-name
> +
> +RET_CODE=0
> +
> +cleanup() {
> +    ip netns del $NS
> +}
> +
> +trap cleanup EXIT
> +
> +fail() {
> +    if [ ! -z "$1" ]; then

s/! -z/-n/

> +	echo "ERROR: $1"
> +    else
> +	echo "ERROR: unexpected return code"

I see that in some cases unexpected rc is 0, but it's worth printing.

At the expense of requiring reader to know about default values syntax,
whole if could become:
   echo "ERROR: ${1-unexpected return code} (rc=$_)"

I didn't do my homework (of checking expectations of selftests
"framework"), but perhaps errors/diag messages should go to stderr? >&2

> +    fi
> +    RET_CODE=1
> +}
> +
> +ip netns add $NS
> +
> +#
> +# Test basic move without a rename
> +#
> +ip -netns $NS link add name $DEV type dummy || fail
> +ip -netns $NS link set dev $DEV netns 1 || \

\ after ||, |, && is redundant, not sure if it improves readability or not

> +    fail "Can't perform a netns move"
> +ip link show dev $DEV >> /dev/null || fail "Device not found after move"
> +ip link del $DEV || fail
> +
> +#
> +# Test move with a conflict
> +#
> +ip link add name $DEV type dummy
> +ip -netns $NS link add name $DEV type dummy || fail
> +ip -netns $NS link set dev $DEV netns 1 2> /dev/null && \
> +    fail "Performed a netns move with a name conflict"
> +ip link show dev $DEV >> /dev/null || fail "Device not found after move"
> +ip -netns $NS link del $DEV || fail
> +ip link del $DEV || fail
> +
> +#
> +# Test move with a conflict and rename
> +#
> +ip link add name $DEV type dummy
> +ip -netns $NS link add name $DEV type dummy || fail
> +ip -netns $NS link set dev $DEV netns 1 name $DEV2 || \
> +    fail "Can't perform a netns move with rename"
> +ip link del $DEV2 || fail
> +ip link del $DEV || fail
> +
> +#
> +# Test dup alt-name with netns move
> +#
> +ip link add name $DEV type dummy || fail
> +ip link property add dev $DEV altname $ALT_NAME || fail
> +ip -netns $NS link add name $DEV2 type dummy || fail
> +ip -netns $NS link property add dev $DEV2 altname $ALT_NAME || fail
> +
> +ip -netns $NS link set dev $DEV2 netns 1 2> /dev/null && \
> +    fail "Moved with alt-name dup"
> +
> +ip link del $DEV || fail
> +ip -netns $NS link del $DEV2 || fail
> +
> +#
> +# Test creating alt-name in one net-ns and using in another
> +#
> +ip -netns $NS link add name $DEV type dummy || fail
> +ip -netns $NS link property add dev $DEV altname $ALT_NAME || fail
> +ip -netns $NS link set dev $DEV netns 1 || fail
> +ip link show dev $ALT_NAME >> /dev/null || fail "Can't find alt-name after move"
> +ip  -netns $NS link show dev $ALT_NAME 2> /dev/null && \
> +    fail "Can still find alt-name after move"
> +ip link del $DEV || fail
> +
> +echo -ne "$(basename $0) \t\t\t\t"
> +if [ $RET_CODE -eq 0 ]; then
> +    echo "[  OK  ]"
> +else
> +    echo "[ FAIL ]"
> +fi
> +exit $RET_CODE

I like this patch (and the rest of the series), especially for the fact
how easy it is to test (compared to internals of HW drivers ;) )


