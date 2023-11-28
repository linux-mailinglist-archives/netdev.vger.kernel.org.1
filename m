Return-Path: <netdev+bounces-51810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D28237FC489
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7BB2827D2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BEA40BEE;
	Tue, 28 Nov 2023 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3uP/21q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE819A7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701201645; x=1732737645;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eUmtbaHgD/s/UcupgJ9rxdfwEK+/zPV0EWuTDARwLbQ=;
  b=H3uP/21qlLMRawRak6hMk2kZIoZJXg9DQeKixNp5gORZECN4TwPTtnfA
   HZ+5QOq2eiDqdIjEDswR2r9rrAfFQqgzsudqL21YdcwQgymTQLXp+5pPG
   uyLIheDPO/hTKDeDeLF8Hf0VIp+c+Y84Rdf5KunIiTaUj4zBwQajxrRHH
   DZConC/ksl7Km7u/eU+EUmGzhqr2Uy4B75avXP/JPOyW1yY7abWZcGiH3
   9MA8Dt/3cxZEsTIHnIyZtypCfYQ0u5REvYkTp/HFbtfWVgRRG0v7Z3B8K
   pLSv77DvnjQ5eWEniuVGPFmspCo5GsiaxF4R1jN/iIU7J8XYvfgsymxIJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6216247"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6216247"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 11:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="768641769"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="768641769"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 11:59:13 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 11:59:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 11:59:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 11:59:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afLcOD9Fmi2LWz842NO9XCNk/QKLUKbpHExQBPt09G8w0byL27s0JqY+r9HSCGulZZKklfPrM9Xyn6/WILLzurjTRk2gJpcuKrA9XdYlgVJnQFvLlkfvS4DfYcDyZCz53nnRBlXshn0l29KhMDB+MGzxM3Sa+HllkmLu8/fR+4Lqill9BJ/0jNMKaQTGbgcpoLW4CySEyuXECVXMaKQl8ZQ7xvlOEbLJeOG5k61MamzLfcNYALcuPeq9jBCrPNj5XTr28RYGYPRhGTrw2EMl+buRJy4PqZt4WGo1qkNMGMVJ7UNu24SpCxr7Zm2KZopWXpGfhcPhwS3ifmNPeVzwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEswmdmMVJTgEiS+Uu8Y0ezSAFjNK54sJXwM2TerLrA=;
 b=bOTBoxRPmkRINyZRCUA7CVzSuVij+alD7B3oqqB2gvfwdGJ/JWtj+bsq1Ez/R/hS7Ob2ffgcYXvCqqvctPm/LxtKlUVO6EdEWmG4atGxE/X5MCnfFqLHqE9qKI2aZQ25Y/Iruxfv/vWqJDvJaURJngO6AFaQv8dCWHmYTdN1FOplY1Y+tVyLZwl5MYrL/UTNA7BJIByuu2UobWwj8HbI6m7AxSME5scrpDJJh9aYdRfhAboW6zuYuSZOOJnwCDbO4KgX5xSkJI2MBhz7+QREhqOoCq5zi6cfoFlC4XHBYdH3zlOUkHkcFR0Zkdlpo4reEUMB0m06311vlP8oPgdvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Tue, 28 Nov
 2023 19:59:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 19:59:07 +0000
Message-ID: <37a14eca-8127-4897-a6bf-c6260d9d33b9@intel.com>
Date: Tue, 28 Nov 2023 11:59:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Jiri Pirko <jiri@resnulli.us>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<johannes@sipsolutions.net>, <amritha.nambiar@intel.com>, <sdf@google.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
 <ZWYSz87OfY_J8RYq@smile.fi.intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZWYSz87OfY_J8RYq@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:303:b7::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e308e-fc8f-427b-5ced-08dbf04c7afe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3srJI3i0oLmCqrxNC/wm/ilGfASs880mw+d5epJmyYG77VrszjZwHInDedhub4pZS5/4ed7xv4vZb4i/OHdjMqkYXaWqjlbz5Ob+V50Z4N9V619WWr89WEroCDwQhVKb/j9SAToMOhlzW+QqzxTWvMvUXufCN7EQDnokXBAZpgI8Qd00aqnpO0VOPBqsHm/quiZ9RHnYZcnp5oblzGg3bRBX//pG94qVHJIYwZPECa8T0QOKlkFSftbO1yh4gv2KcaBaacZqFtpRstU9nJrMUhYSKTUPizW+gIcCJKowB64eTvS4Y6oHAwzrcpWLrRxuHg+WIRSKVRYKzh+vrNJG2uSyG/zDqKv+V73nOUAaQ5/u3K39pYpWjyhkR4ARh0deqrEkoRKPP5PIxvIzaNOthiSkxWp7yILcNvzDN/BxIBge/rHkdmM94U+ieL7M3e+jHE3LdrSJqenHeZpc9/SHUvkO6NTyjJrF1dFt63tOQA206TOQCzuxDoZ7O/AIfC9kuzJ/xnpbrh6uaryk+msqJr9HfVvh3ZkAdFngVlJ0IcHvZbC8knhDR2NFrMsPNl6qAKVRpWHIfWQ5rol1zagOtW8SlIyaNpmHoVuTEh0IODtLhG1IBRi5k7VyKUnXFtIgv5UfchNIlyxghBy+nbuRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(6512007)(2616005)(478600001)(26005)(82960400001)(31696002)(38100700002)(36756003)(86362001)(5660300002)(7416002)(2906002)(83380400001)(41300700001)(53546011)(6636002)(4326008)(316002)(66556008)(66476007)(110136005)(66946007)(6506007)(8676002)(8936002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJKNGwvbUZkYkJYSlN2amx4ZkdCdXc4dlNqa3NsSkZsRys5dk9ObzVZN1lL?=
 =?utf-8?B?UVBCd3phZ0REaDNNREJaZUJPSlR0V21DSmRsWmFCbGdac01GT1YydStzem45?=
 =?utf-8?B?ZXFYTlhqdStXeWxjQjZnV09hUEs5UXVhWGpsdlFFUzlkbjJZVS85MU4yQjJv?=
 =?utf-8?B?SC90cmQzM0JaSUVKcHRTa08vTXVDek13ZmZpdGRNSFA0UkxpUk83V2xYOVZh?=
 =?utf-8?B?YVZxWndjZmNxNU4wMmdFZWlBQ2JoN281b3BTV2JnazBSdXhScDN1UHlzMFNv?=
 =?utf-8?B?eWxmWDByWEVBUVVoUk1SemxUTnJ3Q2xoOThtRGoxZlJVTTRMdElSSDIrN0dZ?=
 =?utf-8?B?aTRJSENUaGJCNjY0UWVJREJ4Ui9RTTRycVArd2hIbkljK2RNTmlwMmhpOGM3?=
 =?utf-8?B?MUxOVUtSTkNQWEZXRjNMNUl5eWtqK01uK0ZhSy80a0ZPRjB0cUdkeWYyTjN0?=
 =?utf-8?B?R0oveHRCYUN4ZnNSTzlObHh1VWszTklLZE9mTkdtVmUxWE5NV2c4REEyVWQ5?=
 =?utf-8?B?Q2I2SnVxS2svaGFiYmc4WWdVLzNZOUtrenJXWk82ckxzYi9pWVBNaENZUUg3?=
 =?utf-8?B?QWkwTmZCY1F1cUtydXptSUdJZE92VmtoZmhwTXFVRk5wdThueG9rK0w3WFM1?=
 =?utf-8?B?MUlYWHdpd0VYVnpkVHBBRHp4V1NjemY4WmxCODBGbUwvTUxKSlNWSGlFZXF6?=
 =?utf-8?B?WDVGNGRkOCtDVEc2RDlKR20vM1RWeG5JdFIweXJ1c0oyNnlGeS9qeHdOQnBH?=
 =?utf-8?B?QSt4WEIvZG4rN0NPa0NHK0dELzY0M0x3aG9DdmV3ZnVuV1lNKzV3d3h4cjVv?=
 =?utf-8?B?RG5KaHZqVDYvWFY0S3FQM2REcm8zNUFneUVNcWFYSjJnSDBIZU5HQzFTeHRz?=
 =?utf-8?B?QVQwSWRNUzR0dCt2aWt3cTBGZjhjMnRXbFd0eTZoMzZDQ2FKOEtROStWNGlD?=
 =?utf-8?B?MFZUNjlEeTMvMmpOeDkwcVNBeWtPNm42bkZtMGEybW1FYlJiZUxSSGd6Vk8w?=
 =?utf-8?B?dFcyazNWeEcrR1lvdVpMVmlpampLTWFEQ3E3R2ZXZ0NUeStzeVc0YkZsWno5?=
 =?utf-8?B?dXZ1TUtST250ZHVXRmpaajBFMXpndmRGOXhvWEJIbGdSZDEvLzR6bEE2UWwy?=
 =?utf-8?B?NFpBSWQ3SXZxRW1qaExsbDhpanpTVGtIYUM0YkFxTEw5amlyNHN5c1I1Vk9h?=
 =?utf-8?B?ZU9zTy9EeVdwK1h5SzhNSGxYNENMd2JKSkErL1JKYk1EenUwY3A4VWhXTkc3?=
 =?utf-8?B?U1c0b3F5OVJBT0ZTQWdCZ1FKQTh4SmpSTFJpSTVtMVVzZWZzbXFFeWcxSWtZ?=
 =?utf-8?B?T2o4WXNwNmlnVGgzbmNHTVo5L25iVE5PdEpoSlpRbk04LzMxaGl1NDFBSmFZ?=
 =?utf-8?B?MHJQMjQ3RTNndzA5R2hZcVpLRlYxT05XUjhhMlFsa3JydE5YU0tPaTRWUlFV?=
 =?utf-8?B?K2NWSUo3eEZuWDRacXRVZ1p0UzJvMDM2Q2wwSUtraFZ5Q2ZnbEg0TlZtUG5v?=
 =?utf-8?B?T0VjMDQwZDdlZUR6eUFNTnYwNUMxcnFYV2lyLzRqSTJpejhhUDNWbzJ5eDFs?=
 =?utf-8?B?azFSUVhTV3NJdFU2aTlBZEovdng5Mk50WWh4QzhXM1p3R0Z2WEtUS1pWbUtO?=
 =?utf-8?B?NFd5U2htMzExeHp4TTNOTWdVcEpYd0Uxd0NaY3hLTGh5TmlOMEVoa1BJeWRI?=
 =?utf-8?B?VTdjNXI2NTUveXdFWE5KQnpHU05DdW16NndPdW9rb3dWNjNNSVB5VTZMZlB0?=
 =?utf-8?B?cXJndmNtSmNkWWhqTGlySHIwUk5kNXAxSHhqcXFwYjZVYU04MDI4ZFhaVXlQ?=
 =?utf-8?B?RytjZXB4VGlIZjhCS1JzSERPSW9kOWlyOUwwUHRnQWgya2owQjBnNW9EUjdv?=
 =?utf-8?B?ODZweVN1RHdPSFJsZjNJZEFmeVFOZEo2Zzc3LzMrZDlvVHE2L2tNcWdWS2hm?=
 =?utf-8?B?UFV4T1kwb3FkMXBXQUpDTklRK1dxWDJpOVlZMWJoZlhndzhpUXFISCtkOW9N?=
 =?utf-8?B?dmR0YUtONWs3SXRNdTluL0NIREswbjI0T1N5dWdkc3VuWHpCM25PanZJUC9w?=
 =?utf-8?B?c1Zyc0UyOFpxKzhHRFFid29xdm9YWnpobDRGbVAzRmU3bEZQTGhqYUhOZkpO?=
 =?utf-8?B?c08xbG41QTlWV0hWSzBHSXhrbEVFZlVteE5FeGhGMG4wQmxPMHY3d1VQUDBC?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e308e-fc8f-427b-5ced-08dbf04c7afe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 19:59:07.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRnbPgpgtgPFQDzOcK02fXfbE5xUxDx2MhowpIPugJv9MMG+2nLCkIG5Na+LS7vjMlITW2eZboa6HnhHUKEPyoP/i5OQJTwaRf+cBMAEr5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com



On 11/28/2023 8:18 AM, Andy Shevchenko wrote:
> On Tue, Nov 28, 2023 at 01:30:51PM +0100, Przemek Kitszel wrote:
>> On 11/23/23 19:15, Jiri Pirko wrote:
> 
> ...
> 
>>> + * Returns: valid pointer on success, otherwise NULL.
>>
>> since you are going to post next revision,
>>
>> kernel-doc requires "Return:" section (singular form)
>> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
>>
>> for new code we should strive to fulfil the requirement
>> (or piss-off someone powerful enough to change the requirement ;))
> 
> Interestingly that the script accepts plural for a few keywords.
> Is it documented somewhere as deprecated?
> 

I also checked the source:

$git grep --count -h 'Returns:' |  awk '{ sum += $1 } END { print sum }'3646


$git grep --count -h 'Return:' |  awk '{ sum += $1 } END { print sum }'
10907

So there is a big favor towards using 'Return:', but there are still
about 1/3 as many uses of 'Returns:'.

I dug into kernel-doc and it looks like it has accepted both "Return"
and "Returns" since the first time that section headers were limited:
f624adef3d0b ("kernel-doc: limit the "section header:" detection to a
select few")

I don't see any documentation on 'Returns;' being deprecated, but the
documentation does only call out 'Return:'.

Thanks,
Jake

