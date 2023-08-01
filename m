Return-Path: <netdev+bounces-23351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC676BB29
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32A71C20FC3
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37122EEB;
	Tue,  1 Aug 2023 17:24:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2442CA5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:24:53 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A455E0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690910684; x=1722446684;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kl5oh7N3qE7T6nku3BE+F5b443Wn3IJv0MvBWW6qxV0=;
  b=RYsNp8iT2iReAUdiPbOPFGaAmXJ7Ns6EyNnj84yo2/hGCFVgnTFmWq3S
   4OMSIeaYMSrWbtMdnhk3GlQWGUXLhhLLXwlFPwlr6CwFPh6C1OhK4OGXl
   +ztQoZWGzetVJzykZDhGq8zQJ6ftBq27DfwZ+/izE+6nmC7Uq5wCL1O1T
   eNHHZTOIL+opmrTaJkPSsiJBE+miS5wfTVBIFQ/qW8cFfWxojTJBpi5kY
   FAGvzItU7+YF08mkNC/P4a5sRR/VSfLQkiYAKABqt0yFkFQvELzJz46AY
   vzEIDXB7vgLvs2FccA/dHkYYsLr34s+NXyxPU0pjGsMOIhsBDmgQGC6Ux
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359410057"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="359410057"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842813957"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="842813957"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 10:23:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:23:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:23:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:23:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1/SNHR3DpqqpeYmu2A91MddjwMMjPWHE71PgceIF04iUyEIgEBOcDMA1FWgEoO73030akflOyEB9QbzXZIwoXy2gBweDgHZmFb8iMz3G1pYTn2mf7Tl5GGrdb72ByNhQsUX2IoVm0LOoELy324eahtGa36vdR8frEHXmGVIDJbInEJOXkc+LS83s2EEyiEA1ZD+90Mfa5KyP47K16q2K1J8Yfxcht1E7Deecd/gGH0sqQiB69VNfOFB3G6idzqrp75BfScwo4MlAN4HH5rOOddxoXpMrJ5if2KIL8yTtTYLMfVa0thBIoCXWef2bkQKlvQ4qg12FHfouWghLrPFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTr09zR93vQUTgsE7qsxAUlcthOLMn5v75EuCK++F8s=;
 b=kz7VuydppmNyUu3qUbCQs2GTErmlvkvKcONz0NMWymTKSE4xOnwtcWPMVz1vgHK+XCYGaFcmfAuonMdxiavlght+CFcxDc7lUeBkopoE6DuRZoyLiqb0MR7IoDxu7ndj+baMkSqx5ZaKCWfJSmZFpgRNnHvRz1XXJglkVZcShrJX4waPq/aMs5tSILJ16IX2QxXDOT8TU4peMaL/lgcG7qQZcAFfdzlOFFWAXnlkSZPn/xtTREY5a4RPoGnLiYI3pl3KE2fWNjc4XSLiemoMclICuofC+fPyl43r6Hre4Wzuh2gsyuQsS6QqrAPYZrhU50ZnZaQbqfVJVVcbXD2o+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM3PR11MB8757.namprd11.prod.outlook.com (2603:10b6:8:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 1 Aug
 2023 17:23:48 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:23:48 +0000
Message-ID: <f18b3591-68b9-e375-1b25-810346d2304f@intel.com>
Date: Tue, 1 Aug 2023 19:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next 2/2] ice: make use of DECLARE_FLEX() in
 ice_switch.c
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Kees Cook <keescook@chromium.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-3-przemyslaw.kitszel@intel.com>
 <f68aa06c-c0bd-a614-914d-3e94ff8f4ba6@intel.com>
 <0ac9d86b-c659-d4da-0838-7e0e447d2e49@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <0ac9d86b-c659-d4da-0838-7e0e447d2e49@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM3PR11MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18884c-c246-4446-4a09-08db92b4110f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uk4HuCvncNghgljKVu7E27HuKFIhB6HSM8ZtebHUDCnG13nP1pF3xvzuvuhubjOJhJuje0BcHwNQc3AzTtZiGTLC+778gk8kElyxRE8KAsvHU4WF+O+UbdsHn4J98NBxm9tpaBqYixI4nrglo57eW9hSUlfFoNbSuK6/ock385b5g0oflisPPxvuzm/Px+RREIXXFlb0H2u5nD93XJJ9EaCrg/ZuJOcqaedIrRlq/zrAvh0GczA/VCPlPtVjYGrGdrtDsh+aul/XELrkVZaLwo8rfrXsTBOf1E1lQBEQjlO2LhY4ywGexbgsIaW6pYX+k6b+6ZSi1VKRtW9MRj3UZaaeCdvpSodS3ViZ2ite7kBnFzo/F9iIXXOGE++8HugFJD7GSuqC0ZCj9rcJAX1kgnd6dJacaIOCLV9guIEPyyG7kG+mnmzBhgLcwwj0Ippj0q/fY+DpPLQIqwYFInMo+VGdriVIpGV9Q7kc339NkcgoOk+ZZQYONknSdbJJnhlbJqm5D2SpgObnneqyVkaf5tBm3Xrk06qKP/HiJ8GzhdStyb1WFNU2DrOP28dMjzt4MMFZ8d5u0TP+ZAwvb9U9lMfBiDYjcvDXD2G3dhoYFlK9B34K05fZWnlNXtt5BzG86QaUbiEaMrdgu3iusY87CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(31696002)(36756003)(86362001)(31686004)(186003)(53546011)(6506007)(82960400001)(66946007)(37006003)(5660300002)(2906002)(38100700002)(54906003)(6486002)(478600001)(2616005)(26005)(8936002)(8676002)(41300700001)(83380400001)(6636002)(6512007)(6862004)(66476007)(66556008)(6666004)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJYT2VyelkxUXFvSGpqOXR6a1lZdkdmVGp4UnRlYzBkdjNla0l1V2tCcFhH?=
 =?utf-8?B?bkxJQ3BHSFFYeEtxRENJemgwVjQvM0ZRd0VldmtnK216QXEzQnMwaVZqajJr?=
 =?utf-8?B?WFE1bWlRbVpTVExOM1VRKzhGYU1JeVppbDltTHdwRjdLZ2dxWTRMc0pOakRL?=
 =?utf-8?B?bUpUU2prbUZ1ekF1WHFNdzF1azNPZUtCd0dVdDdkUzUxQ2hrZ2M5RWwxbE9n?=
 =?utf-8?B?cGFzWk9ZMGRmcjVxVDEwRGpxWng3NVFSekhtYkpYWWxybE55UUJScnlqemJ5?=
 =?utf-8?B?YmJRY1hBdzFhamgreXNrVnpySlBldG0zY2tSS3lrLzFUc01sR3o4aDdSYkQ0?=
 =?utf-8?B?MnYwd2d2YWdyRUh4QjNyREx2OFl2OXFNUzNnS2VyMzRMR2hIeWFoc2pTL3FE?=
 =?utf-8?B?dVhwNTZDSElVRkRhMHBRWXlTT0dFTWNlWGRCMUh5ZUVtNkUwKzRIN0EwUEZ0?=
 =?utf-8?B?WlFWNkZOTk1XNzIyWlBGUWV3bllVTVlnMk1ZYlFWWlYydk93NVl2QmpGSXhl?=
 =?utf-8?B?b3pjQm9uZE5SaHErOGZsc2gxY1FzUWpHbWZOdThsbUFmZENyc3N2SE1FUlRU?=
 =?utf-8?B?clBMaDhaeVFHYUh0SVBWRmpiNWdLWE9Fd1N3ck91eTBYNHMyd2hsUnVQME8v?=
 =?utf-8?B?OTI2cUxYQlNUSkNUWnVUcXRxUHVVT01EeVJmZ0N2ZFJUSjFZSW9NY0ZORjRH?=
 =?utf-8?B?dVozUU5ncXBiM09ocVBYUksvQ3NSdE40eVVIZjBCRmliYjltLzFGQ0t4TDRI?=
 =?utf-8?B?STNnWmoybG56ei9FWFVBVWN2UGR0bzJKNHJUM0h0Y08xSzJna3k2UnRxTG95?=
 =?utf-8?B?Y0lHUVJCdWtDWEpEdDh0dXFHVDQrR1g5eDcrdDFoekJDOUZ5ZDlUeE83N0pH?=
 =?utf-8?B?cG9vanVNY2M0NHJOeEdvcUlWUVFRMUdPZFNrZnpQcW9FOU1Xay9tRzBaSHpE?=
 =?utf-8?B?RHRwVzVsN1cyOXowdEJKYW9PTE9GaTdyNVNQTXlKUCtlZFdXeXVCendWMWV4?=
 =?utf-8?B?VUZFYnY3TDJtZkl6cHZTVVFlcm9kYmYxd2dVYTVWRXUzRjhVWVJxLzVDUjQv?=
 =?utf-8?B?VmU4Z3prTjJvR3RrZWczckVJYU81NkF3Sml2enBtTWlXUHIwaDFRdk1CNlp1?=
 =?utf-8?B?NU1ud1gzcUY2cW9KdW85MzRsa2h1M0wyNlpDTGFFSk1BNWxwc1JGYUFZajFO?=
 =?utf-8?B?aWRPb2loUnhBWk9GWVNzcituSkVEUjYvN0RVeXo1VXRRbDBaN3lMbW41M05B?=
 =?utf-8?B?OEFFL0JYaGxrU1hISEc5RWtnZjBOZExRNWVieGJ0b1dLaW55aEtzY2E5RUNn?=
 =?utf-8?B?QkZGVFVlNFcxaWdPVFhaeGdvN0xuR2E2QnpISmNRbXR0YXpxYWEzSU1Oc09H?=
 =?utf-8?B?MUovMXg3RkRnUWdCT2hVOTJwRHQwMDc4MnZsb1N6NHQvWUE5SFd0V1pFM2xR?=
 =?utf-8?B?Y1FNWlB2RG8rcnZBVnhsYnpZWmY4UUdOc3lLRkpxUHNqRS92Rm93eGVod21G?=
 =?utf-8?B?OHlyTTFFTDhSbjZDelU0am9WTGJ3RGRoczNseFpOL0hLMXBpbUxkb3ExRnRV?=
 =?utf-8?B?WmVkQVJOVkFtVWlHYVppd29sV3R4MGMwU1hzeXMwN3drS0RNSUdBbjFwaGxZ?=
 =?utf-8?B?TzVWR0U5SDBRQmdUVmR0clZtMVpMNy96L3QxZStSZVZhVG1ZK2UzelgvQlNL?=
 =?utf-8?B?TWNSOGt3UmhVYklXYUdUODhXOUpnYmwwVnYwWUp1UHo5QW5JNUdhR0t6ZTVz?=
 =?utf-8?B?T1BHNXZEYSsyY251Yi9XbEV4RWd0U2t2MW5VVk5PM3ArREswNGdqL1daLyty?=
 =?utf-8?B?RmVqaUlQK3hhL1p3ek5nZDBlcnBHL1ZueFMwVkw1Y2xPY01sN0pCT1pRVnI3?=
 =?utf-8?B?YjlZenlZaGZZbXNod2ZKVUl5VzJKTUZpTGdiRW9tMXJ6anhtSkVwYkVpa2Fo?=
 =?utf-8?B?S08yNlUwZlJVSEdHaHhRVVRtZzZHR0FGc0RUNFF5NWdnUTVoS2lSQ0FHOUFk?=
 =?utf-8?B?aXhoNG1HMHphWkVhQnpFWnpUN0pwcWxZeHl4RnlaeWFLR1VMMm50VDkvcWJ1?=
 =?utf-8?B?Z05PWkxNZm5ETmVoYXllMlhpcVFMM1h1WFZhMUY0U0Fkemswb1g3MnE1RkRC?=
 =?utf-8?B?RkFJOC9iTmh1OTRyZ1hNeEZkZ1AxT3k5YVJmV3lBWk1NYlB5eU1iWEZQOU1h?=
 =?utf-8?Q?IKy+ZxSweXfwvTcttTWkz1s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18884c-c246-4446-4a09-08db92b4110f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:23:48.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsqdGIU4sCv/x7vOQX5ze7hZUUjs1YmKhU7dXU550X6363+Q8w0uhMdFLQS5f2J/BbhZHs+hVACDASrQigxzL3Lx+dTg7jtelwJoCpo6TpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Tue, 1 Aug 2023 16:36:57 +0200

> On 8/1/23 15:48, Alexander Lobakin wrote:
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Date: Tue, 1 Aug 2023 13:19:23 +0200

[...]

>>> -        status = -EINVAL;
>>> -        goto ice_aq_alloc_free_vsi_list_exit;
>>> +        return -EINVAL;
>>>       }
>>>         if (opc == ice_aqc_opc_free_res)
>>
>> bloat-o-meter results would be nice to have in the commitmsg.
> 
> I will do next time, perhaps you could tell me if I get the results
> right here:
> 
> ./scripts/bloat-o-meter ice_switch.o{ld,}
> add/remove: 2/2 grow/shrink: 3/5 up/down: 560/-483 (77)
> Function                                     old     new   delta
> ice_create_vsi_list_rule                       -     241    +241
> ice_remove_vsi_list_rule                     139     270    +131
> ice_add_adv_rule                            6047    6139     +92
> ice_add_sw_recipe                           2892    2972     +80
> __pfx_ice_create_vsi_list_rule                 -      16     +16
> ice_alloc_recipe                             124     113     -11
> __pfx_ice_aq_alloc_free_vsi_list              16       -     -16
> ice_free_res_cntr                            185     155     -30
> ice_alloc_res_cntr                           154     124     -30
> ice_add_update_vsi_list                     1037     994     -43
> ice_add_vlan_internal                       1027     953     -74
> ice_aq_alloc_free_vsi_list                   279       -    -279
> Total: Before=42183, After=42260, chg +0.18%
> 
> My guess here is that compiler did different decisions about what to
> inline where, what is biggest difference.

77 bytes is very good result, because see below.

> And biggest gain here is avoidance of heap allocs, perhaps that enables
> gcc to shuffle things a bit too.

Exactly, having the stack grown only by 77 bytes after avoiding -- how
many? -- a lot of heap allocations sounds great.

> Another guess is that b-o-m ignores heap bloat, so slight growth is
> expected.

BOM can't calculate any heap usage, it simply compares symbol sizes in
object files.

(BTW, passing /dev/null as the first "object file" is legit, in case you
 just want to see sorted symbol sizes in your module or vmlinux)

> 
> Values reported for ice.ko are the same, with bigger base to compute the
> percent off.
> 
>> [...]
>>
>> Thanks,
>> Olek
> 
> Thank you too, also for our initial talk about on the topic.

No problem, I really feel like this macro would be very useful.

Thanks,
Olek

