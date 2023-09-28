Return-Path: <netdev+bounces-36947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE717B28DD
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 01:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B5BF12825D6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AC19472;
	Thu, 28 Sep 2023 23:36:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E961945D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:36:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC3195
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695944176; x=1727480176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QvCcg47KTcyFG/v9qOYTvk/VcKsSwXtEIqmPqttBjeU=;
  b=IIVuP8qBmMEi2q1xsmzd6rzSk5W4PHelRH/Stt9Q6EtXZC07vaC/tG87
   6Ibv/JI3QycSrR3/py5Y2Uaxi4Mu3cyydVtlAKrC/zJyKQXrw2L6Yn/Ny
   7ZDZWbtfhEbEU10bMwMMrUy2OzGqU9Lx2dUxNMCQM3oxZRr659XZoB+Gt
   DDGyBa1V3dA8MXpGIHZL4Aa7z/zl9GzGRkykYou68vLwzVEDVbc+fPma8
   /4Emq4GrTEu9tfEFmrXZ2bsEUQOA3erYZYQjYL+tjMm0qTUg00NQJ6vRa
   AGKcrt305fczN5L/QrDlm4vVh/2XHPm07qfthGgdkL8auSf0Mx4pNpvLV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="3769905"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="3769905"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 16:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="923436261"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="923436261"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 16:34:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:34:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:34:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 16:34:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 16:34:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRO/6Hr1A0j8KriYQeo4q4btYExASiq02B9Yq9rk2wH3QX1/lx/Z2wlfDbrdieEZYxTO9lc508OuTsIDAcpBmPFsaHMttY1siZtNvITzJsqLuzFa1JfPex5RKel9sRVi7RcZVep3FlUi3SxxWUTxUoel/sJTzOHs2GXmBAgdGyZR4dsvhR+e7PRW2Hn4q+U2MApAuGVQ3wF4HwMV4uQ5MIpEMHt6Elt332yI3CUsFr2Hy4ydJmh2lcbrE9c5C6SMrRCyo5mO89NF9qECk1h/eOwcZBaxno1NCKCLFBjdn+Zmzl2Z9u/ZYuzNij5OlYkbjqyt2+upY4mKzyAyd7/+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPx0pchZ9UeSzpkKVjSMY5K00iguGacc8fg3XdZrV5I=;
 b=QBnLGZK4hUto9E0B9gSpDpW4Fk/fjs6xoC9LFqQhMItJEgeIEYOCWyJDwLNrjIuTOu1DPtsIQx3eWyMSWdaPrZg+q2YIuPmEE4kWnT+YzRETyD3mTmMXMr1SNNrkkZG9S1wyeflXtx98Io57N5oju/A6cTAQqdbm9GipYVBISEwFLCF6Yxhlbbg/kOM5V3YlFu+xPkVpWnEe7Gtj14IWf/4/XqSnSHJRM3rZI3fn5o9JjApp8IrQT9cftfRmQJa+Suwx63UJn2B52OjJ+kx5S80aIjBfWVH8TZuf2EFnPUWgfboOzKb7xyGb4VT9WOyIZ5LK/64jGnHM1DOKTGyvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 23:34:13 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 23:34:13 +0000
Message-ID: <d80363ac-9487-4b1c-8069-82e0d931aa7c@intel.com>
Date: Thu, 28 Sep 2023 16:34:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 06/10] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <sridhar.samudrala@intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
 <169516246697.7377.18105000910116179893.stgit@anambiarhost.jf.intel.com>
 <1f55345f58987dbcfd566e1f61aee55d2c78f788.camel@redhat.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <1f55345f58987dbcfd566e1f61aee55d2c78f788.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:303:6a::26) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: f704ca7e-34bd-48c2-bbbb-08dbc07b6bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwLVI8dse+uI/3BCpMAFExXtqMc/7OBfKd2P7A0ozFinsX1D7NPxiNFMtIPf8r0jNu49lMUhrwtDGgPzEHjEzC9GlGJhNQFkgIy5ywKBrRXGvB1By2dKik1tNjV6y0ACI4afqqD3RJ8Hf45897xilWNfhXvzuH0oSM2m8lcQnuapfba7opwMAnOPJf23SRKvT1dJqgJK5fJeWDRxPVyc2MFU+iv9nIptSThFCBtMmcqP9Kqv4UFkdZFLy1qXmdTifypp+9RzL0ccsCTeTPpb4KoTwtja4Ohm/ta0Ql4MZiCZ6fFVg0Il5eIJhL+d4Ig0mLeYKMfQFxLVfqLl5+MDpfO98twe10aNrCP3iGO25E5G5gIpZ73Ylqin24Ne8nXtzXHG9lxMLaoD68XXK+8Z9Dyh2z6TSluyJin5Uyege3YSaApUPJ7TF9gn7WQ1Hh/fjnIuausc9qQCVORptEVN5IWYRDF3ZEKUhttDTTfktCxZqaS3GLslK98gS8m2eMVtKyrzxIp8gwKW46DQl7V+d0T18cpOySGV/IlgV6qJd6k9SZiDJ8TShGnNCtBQSYghbbkhSrfO1czyompb7P8hMO5FKrTsZ4/nf7QpjLzT1bY1EcckKEPeYdYRkmp/SupKdLQP3QfEPQSAmO/MfYAA9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(41300700001)(316002)(66556008)(31696002)(86362001)(4326008)(8936002)(5660300002)(36756003)(66946007)(8676002)(66476007)(2906002)(83380400001)(31686004)(38100700002)(26005)(478600001)(2616005)(107886003)(53546011)(6512007)(82960400001)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNneU9FQXZEWDhOdVhBeVVLemdDNUJwZkpSYndaejBtNzBuc0dJbVJmN05B?=
 =?utf-8?B?ekx4MURvMDBaOTRnTlBaS1Z1VGQ2YjdjK0w0VzZXN2QxbTIreVE4VXFFMVJ5?=
 =?utf-8?B?dkhVYWFQT3hZbFJ2U1NXTnlZZTNCamdncjk1WkkvcTdwclR6emlLcXNhS05h?=
 =?utf-8?B?SUZ4c3drcW1aVElsU05SUXZQdHMzWnJEdTBmcHN4dWoycWY4aW9xNVhmWW5H?=
 =?utf-8?B?Y2pwR3Q3ejJhUWdTZ3p1Wm9aRDlCUTJTN1FhWGhjeXU0RjhqUC9yUTVRTjVu?=
 =?utf-8?B?R0REbTh6VTIwQzFxb1kwdXd2ZFJ6ZkdmNFNqSFBKNkdOdi8xQ0VueVNmdXNJ?=
 =?utf-8?B?QlJXaGhOTVJWUldtVGlLb25FZVJ6MWF4K25SL3R3ME5sQXk4cVVYaHRjRXU5?=
 =?utf-8?B?NGhuQlF4cW9KOU9KRUNtTkJJaG5TTFo4U1NnWHYzU1RmZXh0RE1IRlVyRytq?=
 =?utf-8?B?b0srRGRpUThrMllLNHVBWE0zMFdLeGNscW1aMzdHTXdsUDBMemEwR0pTWHRV?=
 =?utf-8?B?UGt4L3BGMVpBZFZWbnFCYVU0dnk1UHhxOWpGU2lzN2NWMTE3WVl2NkRadTVS?=
 =?utf-8?B?alpILzhySXhQa3FNeVdCN3pNUGNwZTBTZXQvKzdHdkQ0S0t2cEQ0WExCRE40?=
 =?utf-8?B?ZDlKQ2xKbkpxZjM0NTRDdktNRUxUdkVYaXkvNmF1Q05zT05MK0VQR3o1ZDJa?=
 =?utf-8?B?dXZ0d0lIL2t6VGVYVkxtMVMwaWlZSm9zUUhkV1FUS0g2bXozQURGQ2cybG0x?=
 =?utf-8?B?UFR2bHZVcUpZbDlWamhZOUxIUFBLNlA3YlFzNGNWTXowdDgwUFZxd3B4TjRj?=
 =?utf-8?B?bjdVWXRKNmFMRmU5Nk5ZYzhLeFBTWDdkMzVRUEI3SlJEeVlaZ0RBa0lkMkRk?=
 =?utf-8?B?cTNXb3ZiNGIrSFpKM3MyYUJ6QzdvZ1NEK2dIbk5DTklkbXNjdFdodmNsNDVQ?=
 =?utf-8?B?MjdrZXdiQk15dmRkdkplU0NyWloyQVpYZjRhU1NzV09LVW5Yd0l5TDI2aE5T?=
 =?utf-8?B?ZGpjbi82dkhUeVAwQXZ1eTN4d25rbGZEVEcwN0lyUS8rNWVvTHE3cVplMHZi?=
 =?utf-8?B?QXZqYTRzU1ZiZllXSXlVbXpBMVRPcHV1WVRjUi9sWnBOeDhwTkRlYnhjMmxZ?=
 =?utf-8?B?clpWM2hyOHpPMEQzclUxSEYra204cTVobUdSaml0WTE1azlMUHVjWHoyTzVC?=
 =?utf-8?B?NFNuL2NLMnhsMnQ1WFJHVS9vZ0M5bVYvVXN6cUtNOWN0akdBeFp3YUxhUFVl?=
 =?utf-8?B?dTdKOElBWlVGR3o0Ulc4NUw0bzJadnVSRnhoSlVyRWY1cHg3UzUrWTB4WWl2?=
 =?utf-8?B?MmZSaVU1ODlrb3JHSDNLazdJWXU4bGF4MFROaU5vTlJTc2pBS3FZQXBWSUZo?=
 =?utf-8?B?cm45dUY3S3RqL1JHNzFydmRUdkJBN0s5dGVxbURmZ281VVovUUZ0OFl3eity?=
 =?utf-8?B?akhkdEhoYTZXeSszWHV0M3pYVTdJZmhOdTUrcHFsdFova3pzZWVnVGJyNVRr?=
 =?utf-8?B?akJ2bERCdWpuKytaS2tBdVJSUlEvRDAzWS9Hb29wdWNReEpIM2JTV21ZZWwx?=
 =?utf-8?B?MmZzbVdWYzFzdWx0ek9nZEZ3WSt2Vm4yblE0ODF2d25kTHVLZTB3V08zSUQ2?=
 =?utf-8?B?aXh5TU5xTmw2Wk5TMmVEaUdOR0tIWlM2b0p4RU5kYlN2bGZDMXRVTlZsaDdu?=
 =?utf-8?B?TXBWQmV3S2tCMlVQNjR1YlNyYTd5RkN5TlNLaU5XQjhHeVhYQzdnK21WTUxI?=
 =?utf-8?B?TFVjUzNXRGE5TnFxOFVsZDIzcW9rM00rVkQ3dFFGL0o1ZGE5SFdtd1J5TndD?=
 =?utf-8?B?ZXBJaXBhT3hsNHV5U1JheWtnTUVzOFlNR2JxbXNtNW0vNE1RdTkyd29od0tj?=
 =?utf-8?B?TWsxYVNlVHpmaXZJdHl3YnhxWVNHand3emVyL3loY1B5TGVlUlJiRUttNWpN?=
 =?utf-8?B?S1QrTnJvOVV6UVFGYjZvY3VPR3NPMjNTTVh3NFg0U3VrS09MYnU1OE5FbHJH?=
 =?utf-8?B?aEV0eHNYeldVNCtiQjFGeXNia2FCZkk0Y3VYOURKZ0ZWbXdJSXZwNkEwUEJB?=
 =?utf-8?B?NThpSnRDVUdWb2l6VmEwVmpWbUtML3ZuTXhrY2tSL2tPOTNEUy9YY2FOMGFq?=
 =?utf-8?B?aFI0VlNPcGxNMnUxbzRCcXZBOXhTT0dkR0FKd2hZdnpYSUtEckFLc0lybHRJ?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f704ca7e-34bd-48c2-bbbb-08dbc07b6bc2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 23:34:12.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw8LjgCootHkHqfCMZI6nr/Zox7Dzm8NZjnvGCzceKAFzUtVevHXx35LBMl5K9dQ/JY7SOobzA14uIo1C/RZbbzEzyLDNhMell/7JPZA2yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/2023 4:19 AM, Paolo Abeni wrote:
> On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for
>> napi support. The netdev structure tracks all the napi
>> instances and napi fields. The napi instances and associated
>> parameters can be retrieved this way.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   include/linux/netdevice.h |    2 +
>>   net/core/dev.c            |    4 +-
>>   net/core/netdev-genl.c    |  117 ++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 119 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 69e363918e4b..e7321178dc1a 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -536,6 +536,8 @@ static inline bool napi_complete(struct napi_struct *n)
>>   	return napi_complete_done(n, 0);
>>   }
>>   
>> +struct napi_struct *napi_by_id(unsigned int napi_id);
>> +
>>   int dev_set_threaded(struct net_device *dev, bool threaded);
>>   
>>   /**
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 508b1d799681..ea6b3115ee8b 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
>>   static int call_netdevice_notifiers_extack(unsigned long val,
>>   					   struct net_device *dev,
>>   					   struct netlink_ext_ack *extack);
>> -static struct napi_struct *napi_by_id(unsigned int napi_id);
>>   
>>   /*
>>    * The @dev_base_head list is protected by @dev_base_lock and the rtnl
>> @@ -6133,7 +6132,7 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
>>   EXPORT_SYMBOL(napi_complete_done);
>>   
>>   /* must be called under rcu_read_lock(), as we dont take a reference */
>> -static struct napi_struct *napi_by_id(unsigned int napi_id)
>> +struct napi_struct *napi_by_id(unsigned int napi_id)
>>   {
>>   	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
>>   	struct napi_struct *napi;
>> @@ -6144,6 +6143,7 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
>>   
>>   	return NULL;
>>   }
>> +EXPORT_SYMBOL(napi_by_id);
>>   
>>   #if defined(CONFIG_NET_RX_BUSY_POLL)
>>   
>> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
>> index 8609884fefe4..6f4ed21ebd15 100644
>> --- a/net/core/netdev-genl.c
>> +++ b/net/core/netdev-genl.c
>> @@ -7,6 +7,7 @@
>>   #include <net/sock.h>
>>   #include <net/xdp.h>
>>   #include <net/netdev_rx_queue.h>
>> +#include <net/busy_poll.h>
>>   
>>   #include "netdev-genl-gen.h"
>>   
>> @@ -14,6 +15,7 @@ struct netdev_nl_dump_ctx {
>>   	unsigned long	ifindex;
>>   	unsigned int	rxq_idx;
>>   	unsigned int	txq_idx;
>> +	unsigned int	napi_id;
> 
> Why you need to add napi_id to the context? don't you need just such
> field to do the traversing? e.g. use directly single cb[0]
> 

Not sure I follow this comment. Could you please clarify.

I introduced the netdev_nl_dump_ctx structure to save the 
states/counters for dump (for ifindex, queue indices, NAPI IDs etc.) if 
the dump was interrupted due to EMSGSIZE error. Also, I decided to use 
cb->ctx instead of cb->args[] due to a comment in the definition of 
struct netlink_callback in include/linux/netlink.h that says "args is 
deprecated. Cast a struct over ctx instead for proper type safety."

The 'napi_id' is saved into netdev_nl_dump_ctx since there is no need 
for a separate counter when we can rely on the NAPI IDs itself (as 
pointed out by Jakub's review comment on v2).

> [...]
>> +static int
>> +netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
>> +			const struct genl_info *info, unsigned int *start)
>> +{
>> +	struct napi_struct *napi;
>> +	int err = 0;
>> +
>> +	list_for_each_entry_rcu(napi, &netdev->napi_list, dev_list) {
> 
> I'm sorry for the conflicting feedback here, but I think you don't need
> any special variant, just 'list_for_each_entry'. This is under rtnl
> lock, the list can't change under the hood. Also I think you should get
> a RCU splat here when building with CONFIG_PROVE_RCU_LIST.
> 

Makes sense. Access is protected by the rtnl_lock, so _rcu protection 
isn't needed, I can just use 'list_for_each_entry' for list traversal.

> 
> Cheers,
> 
> Paolo
> 

