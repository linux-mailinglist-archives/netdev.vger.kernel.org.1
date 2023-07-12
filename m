Return-Path: <netdev+bounces-17294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC61F751195
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA171C21047
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1F24183;
	Wed, 12 Jul 2023 19:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B917758
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:59:08 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92FA1FF7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689191946; x=1720727946;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DluBURNaraI8spBF3dNvOcO11FPb/odbpYNfRnpBHOI=;
  b=DNzMxH/i7m//JtPhAVAeeu0GKEtD5mtrHd8x75iQDkmkNzQnhZjN+Dqm
   Qba9jHNIS1jsJliykCGWfE+JK1+3MCTQ1cBdW6St1jLiXq23hBjQVuXdu
   +jnarr4y1eM0IgISuaGpOmZIUC1pQHlq9Ef1KRSWwWxqV7V7sCmnCwhCh
   HFnie5c3+pPNyRD2d+EDTHWRZW75kMlWusdUVCfPEs0Jjrqyw1JaieWE0
   raL3/7Nw4NxeS+RDimOzMsbMaX6VnAzofCI1KJ3+EG4GMm+H6pFd4JJg3
   yRnS6fyctpwty9TRJJJRZ3Ps4kvUeYltlyB2FIZDa0QhLg9lYcHf6dlYg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363859516"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363859516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="968332066"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="968332066"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2023 12:57:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:57:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:57:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:57:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8PYUruyoPhlJfp42k30w2txaEVhLb9WEDJgAV9WltIlaVO6EekrJx4PkARbHsUB4Fde5yb96J5JxAoI4xFRT1YXhBmFeG+q4TRNai/iKF5M80foqrC8dGZ6Bg/YOknPsiAfh5cpm8cGCNJGI2QfFrMDZhgKUaodN/005OBo0x4l+rbm9lnQ15n8D6FH6nvdpa9+RpvuTElkH2dnSQnTZBnAejtGufQl9LSqmYVNgcgP1He+oJuPWCh0khkjw7twK+r8Zv5jWlUtX5WtvlDItCImXqOGCDTy6W6KvCUTFXEes8ttJXBZgd7L+d7ogVuH8g61nY3CTl14eCE2yVo23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6EYc1bJpFYu5ViC595Ksko6Mq9ienzN0fZnQVMdSxg=;
 b=dU7+8IBGsRRYfvtPddiLV0/IU6EbMjqr7BYEbcsSXXG1KL0wVhk/s6b8hopnzpo1M4CXdYgHMxdyE0Y3Qgsn8ejtjgm92ytiCiUz/uy1oks71LccqotN5z663F0nvnNf32YRNtWSNryLiR1XqFTeA1HGIbAIRlAOhQ0d3004cV6M2UkWt2OBY8DQsaQOML67GDX5FRiDv5xbygqR7P9B/HjaYCIiS9YgUuTuF+Gq0yMXOE2JUj0PqG/JS2oSRQmJgSzT1Uk2zewABkCBN7zTT/8wsq3xg/ULcUmMnSFzoZJ7rED3YNYkN3lEc/6yEifsJZEv1SvKu/UYDb8cPyatVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA1PR11MB6661.namprd11.prod.outlook.com (2603:10b6:806:255::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 19:57:00 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 19:57:00 +0000
Message-ID: <a60dd904-7001-119a-b001-a756ec7400c6@intel.com>
Date: Wed, 12 Jul 2023 12:56:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 2/4] net: Add support for associating napi
 with queue[s]
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <davem@davemloft.net>
CC: <sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564135094.7284.9691772825401908320.stgit@anambiarhost.jf.intel.com>
 <71bf3e779f59c2417c42293841b76b32eb32a790.camel@redhat.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <71bf3e779f59c2417c42293841b76b32eb32a790.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA1PR11MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e65265-72c5-4adc-24fc-08db831227ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PWaHCCwgdYGkf/S5GelaO7Utc3oT6FtQ3V8XL7sBUJudK4094WJTU4W8uMSfOQiEoOji4EoDcpFoL9eEbix7FRMzMf7FzQcid/DpUqm9DzLzvTlkHbvO1gQiTG0S2MzkjBdJ2drHdXK7WCWrM9wx39yyfnxyoMVqlzAB7SZUlpXlTxrG/+VP6arlyDMWixZWs/zlr5VkQyn1BDMzQickpLJJfvoET3gjEANGt3Tda1apEsD8jGvv6AiDw2s2ItymeSg8pHOKXI1wPzZjA2CudI+ySm1jeA5nxcwhUWyRRdueIO0Bykzsf7FSOqQ8j1YALpJtGKGao9iQJb3T/8xEnDU4pBl302WPc3rxUmxOHVEiXmP8TC5LJiToUJDouAtqYaOU68dCo4iV7Wj77UwiXpX8yvuD7Uv2SqqHBsw2eUkoh8QoOz210nuZiwNKoDLYj10qkwM9kZQ3hTUKYemC3+Rk2oUDjLJTxRBI2AhmSE0b9Nwng9OmU9oLwIwlourrRNIx5O/4okeK8ekkunuW1LG9ajG5mR4V/WIcGk1vd94SaGxBc9Vup1QcfYhTlBnEzPSM0qOtx3GsUDUECfczjen8t3D0abDyDUFQ4wHTbg2R7RTDqyx1mJrW8zzjgjvWPR2bzNKC9BAzG48V7mL0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(31686004)(478600001)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(31696002)(2906002)(186003)(26005)(6506007)(53546011)(107886003)(6512007)(38100700002)(82960400001)(8676002)(66476007)(66556008)(316002)(41300700001)(66946007)(8936002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGtQaWNmR1ZQakVFV1g0cXptQmw5aHVnVkpMaUI3d3RmeFpUd2hHSzREeGQx?=
 =?utf-8?B?eURwbDVVR1B0RUpXdDl5U2JlWWswdEt3K2szb3VCSlQ3U3ZTcE1Ob21tOTlG?=
 =?utf-8?B?UDZhZzI4TU1GWUhmWFRKNGJ6ak1nNm5McDZ3Nmh3ckhwVEhrQnk5TXJZMFlm?=
 =?utf-8?B?MDAra1lVT1BtMkowWk5TbUtQODQyRmtZUWxwTURoM3lVenBnOEwrYllkWXpG?=
 =?utf-8?B?eVowakl0Q3RxSk96NjlMbDNvUkZFeEVGdDl0d212K2dzTUlRME9hL2J1L05V?=
 =?utf-8?B?ZDV3aG5yWXlrdS9aUmJDUU1hWTJrdXh5VXcyU0FybFgvNU5oVEI5d2tCZkI0?=
 =?utf-8?B?b0FBOFBnYWNCK0w3ZVZ5dzRJSVZUa3A1aXJRNlZNaU1Fb3FLQkkxQzc5aEg4?=
 =?utf-8?B?Zm1SeVhVazFlWlhGejllUlcwN1dXMjh5d1VkQlNXMEFzMVREL3JYSjdMVUJS?=
 =?utf-8?B?NjFVTWVRTUEwZjduUG42RTlBb1I4RkNQZFhOVzhsaVV3ZW96MVFKNWZ1bGtF?=
 =?utf-8?B?TFk3djgzTmI2NGpHZWJhQk9aSGJ4bDVOL05CYlpEUlJ1L3k2aEZ1SFRjU05S?=
 =?utf-8?B?Nm1ZQ0ZWQ21hSHBqbkZxTzkyL2J2V2FvcTl1TEthbGFncjBkK2ZVbDhxby9P?=
 =?utf-8?B?NkJYWUErck1ONzV0ZHV6Sm9hQkM4N040YkhBVzVhaGhjK3NRdlRrRE85YXFC?=
 =?utf-8?B?UWV5ejVwRXN4S3h1WlBjazRrT1NTVEl0eVlzaWJCNExScW54NC9lUjJHWitn?=
 =?utf-8?B?cmVHK2hWdWg1QU1PQk5mRG1Tb2ROUHVHdmZmYzViNlprZ0FuODVoTEZDUEVT?=
 =?utf-8?B?OGl1aFRGdjdtbThaelhFaW13eGdvRXlyMTh6dHZ3QW5aN0R6dlVPMHNpSGEz?=
 =?utf-8?B?bHhtMExQRzIyeHpOWTd6ek9kb3Yrdkw5c2tuRk1ZbGFodkZQUDJtWkhudlVv?=
 =?utf-8?B?d21pa1NqcytYYjBCSnU2N0QvbEV0djNvemFjd083eUN0VW52UU04bGhPVXl6?=
 =?utf-8?B?MmFzWkxla2xvVjl6SXVDdENudHZNeDJEbzBBcEVVVDJmVUt1M1JFQVRzTTVJ?=
 =?utf-8?B?MGh1SlVzd2FlZ2poNHVDRm81L2EvVUo3QUxVV2dSLzZvWXQ4b24raUloTXFv?=
 =?utf-8?B?NVhmK1liWisvYXh2c25mY2dPSytQd2dUZ05lRGJ0RXdVRGY0UzVkd0orbTAv?=
 =?utf-8?B?ZDcwUmdCR3JxcUd2WlRnK0pRWU1MV2hFK0dYZlF6eVV3RzVYNXFzVWpDUTlz?=
 =?utf-8?B?NkQ0SWx3MjhOU1NmTUlvZUo4dXRpKzcxblE4SFczd1RjdEVaaEhDRkszRVRE?=
 =?utf-8?B?dW5ndGNvbWp0cy9ZN1pHeTNobnBLeStMeGlMeCtoSDgzMDBtNXJRSlNoRTQz?=
 =?utf-8?B?Z2pPSFhxSnBDMDh0bG5SS0tYVnBiV0FsQ1NiTTdiNnl0aDB3YmdQK0U3bWpp?=
 =?utf-8?B?YlZmakluVXlLUlBkSlBDc2FpRTBMTWtLMHFidXpBZmhkWUhmN3h5dDVVTGlD?=
 =?utf-8?B?YzBZNHY4VXJvaEgvT0VQL2xBZUd1bUVWVTIrWUo4NTZncUJwQ1VBM3hlNDNJ?=
 =?utf-8?B?M1JuTjJvTlFNbDVSRmZ6RFhURWxBekpVQ3NKUEF1R3JlZmdRT2FLZlNKRVlv?=
 =?utf-8?B?VUVkTUEvVktTYXpLdXEyK3U0K0czS1NXWlJCNHlSZU9uVU9uVGp6d095ZUNQ?=
 =?utf-8?B?NTZpRHVSemxzZE5oWFRhZnkvY3FmRzhrcFRQcExUZzVYQ2F0MC9LSmNjbzQ1?=
 =?utf-8?B?OGtCd2xNTWxrbUdUQ3lYbDIzS25WdzV6U0c5bmtXa24reEkvay9wa1B4cS9h?=
 =?utf-8?B?M2tzZHBaazJmZ0VZYXBnb0w4T1VlTWsva2tOTTE1UUM2T0hQVjlacUw4SDlD?=
 =?utf-8?B?Uy95Rmd4K2tSOE5pVWMycHdyS3dieXlpOFlyWW5tMHdwVysvVFlsRm9YQWxQ?=
 =?utf-8?B?QkV2eXVxS0h1bHRwYVVGNlYzMUxnTWluNXhNakVzbE51bCt3bnBncnl5bUg0?=
 =?utf-8?B?amZVSGVBSjJ3dzBWMWFhNzQyVHJLRmh3RUx4UjNEd3g4R2Q5RjNUQ0d1Tkcr?=
 =?utf-8?B?Vk1SUXBnZ0I4WGEvR2h1eW1HWW5NUGlQVlZOVW03RW9EMEozZmxKSFJkYWNy?=
 =?utf-8?B?aGxDRjhWN3h0ckdRbXJIY0wvNGdLWnBabnIvcHBOcFJmOTU4MXRndUN3MkVO?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e65265-72c5-4adc-24fc-08db831227ff
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:57:00.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUow62G8YSBzWjxkdW5/Es921xWY1szCz7vDvrJgLGAuo5q5Uz6gDXTWvvw3Mr0FG2wGOMaS/0ZBSCZMl1/j0vrRuRog6jenLAE0583Nbho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 11:31 PM, Paolo Abeni wrote:
> On Thu, 2023-06-01 at 10:42 -0700, Amritha Nambiar wrote:
>> After the napi context is initialized, map the napi instance
>> with the queue/queue-set on the corresponding irq line.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_lib.c  |   57 +++++++++++++++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_lib.h  |    4 ++
>>   drivers/net/ethernet/intel/ice/ice_main.c |    4 ++
>>   include/linux/netdevice.h                 |   11 ++++++
>>   net/core/dev.c                            |   34 +++++++++++++++++
>>   5 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> index 5ddb95d1073a..58f68363119f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -2478,6 +2478,12 @@ ice_vsi_cfg_def(struct ice_vsi *vsi, struct ice_vsi_cfg_params *params)
>>   			goto unroll_vector_base;
>>   
>>   		ice_vsi_map_rings_to_vectors(vsi);
>> +
>> +		/* Associate q_vector rings to napi */
>> +		ret = ice_vsi_add_napi_queues(vsi);
>> +		if (ret)
>> +			goto unroll_vector_base;
>> +
>>   		vsi->stat_offsets_loaded = false;
>>   
>>   		if (ice_is_xdp_ena_vsi(vsi)) {
>> @@ -2957,6 +2963,57 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
>>   		synchronize_irq(vsi->q_vectors[i]->irq.virq);
>>   }
>>   
>> +/**
>> + * ice_q_vector_add_napi_queues - Add queue[s] associated with the napi
>> + * @q_vector: q_vector pointer
>> + *
>> + * Associate the q_vector napi with all the queue[s] on the vector
>> + * Returns 0 on success or < 0 on error
>> + */
>> +int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
>> +{
>> +	struct ice_rx_ring *rx_ring;
>> +	struct ice_tx_ring *tx_ring;
>> +	int ret;
>> +
>> +	ice_for_each_rx_ring(rx_ring, q_vector->rx) {
>> +		ret = netif_napi_add_queue(&q_vector->napi, rx_ring->q_index,
>> +					   NAPI_RX_CONTAINER);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	ice_for_each_tx_ring(tx_ring, q_vector->tx) {
>> +		ret = netif_napi_add_queue(&q_vector->napi, tx_ring->q_index,
>> +					   NAPI_TX_CONTAINER);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * ice_vsi_add_napi_queues
>> + * @vsi: VSI pointer
>> + *
>> + * Associate queue[s] with napi for all vectors
>> + * Returns 0 on success or < 0 on error
>> + */
>> +int ice_vsi_add_napi_queues(struct ice_vsi *vsi)
>> +{
>> +	int i, ret = 0;
>> +
>> +	if (!vsi->netdev)
>> +		return ret;
>> +
>> +	ice_for_each_q_vector(vsi, i) {
>> +		ret = ice_q_vector_add_napi_queues(vsi->q_vectors[i]);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return ret;
>> +}
>> +
>>   /**
>>    * ice_napi_del - Remove NAPI handler for the VSI
>>    * @vsi: VSI for which NAPI handler is to be removed
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
>> index e985766e6bb5..623b5f738a5c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
>> @@ -93,6 +93,10 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
>>   struct ice_vsi *
>>   ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params);
>>   
>> +int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector);
>> +
>> +int ice_vsi_add_napi_queues(struct ice_vsi *vsi);
>> +
>>   void ice_napi_del(struct ice_vsi *vsi);
>>   
>>   int ice_vsi_release(struct ice_vsi *vsi);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index 62e91512aeab..c66ff1473aeb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -3348,9 +3348,11 @@ static void ice_napi_add(struct ice_vsi *vsi)
>>   	if (!vsi->netdev)
>>   		return;
>>   
>> -	ice_for_each_q_vector(vsi, v_idx)
>> +	ice_for_each_q_vector(vsi, v_idx) {
>>   		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
>>   			       ice_napi_poll);
>> +		ice_q_vector_add_napi_queues(vsi->q_vectors[v_idx]);
>> +	}
>>   }
>>   
>>   /**
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 49f64401af7c..a562db712c6e 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -342,6 +342,14 @@ struct gro_list {
>>    */
>>   #define GRO_HASH_BUCKETS	8
>>   
>> +/*
>> + * napi queue container type
>> + */
>> +enum napi_container_type {
>> +	NAPI_RX_CONTAINER,
>> +	NAPI_TX_CONTAINER,
>> +};
>> +
>>   struct napi_queue {
>>   	struct list_head	q_list;
>>   	u16			queue_index;
>> @@ -2622,6 +2630,9 @@ static inline void *netdev_priv(const struct net_device *dev)
>>    */
>>   #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
>>   
>> +int netif_napi_add_queue(struct napi_struct *napi, u16 queue_index,
>> +			 enum napi_container_type);
>> +
>>   /* Default NAPI poll() weight
>>    * Device drivers are strongly advised to not use bigger value
>>    */
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 9ee8eb3ef223..ba712119ec85 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6366,6 +6366,40 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>>   }
>>   EXPORT_SYMBOL(dev_set_threaded);
>>   
>> +/**
>> + * netif_napi_add_queue - Associate queue with the napi
>> + * @napi: NAPI context
>> + * @queue_index: Index of queue
>> + * @napi_container_type: queue type as RX or TX
>> + *
>> + * Add queue with its corresponding napi context
>> + */
>> +int netif_napi_add_queue(struct napi_struct *napi, u16 queue_index,
>> +			 enum napi_container_type type)
>> +{
>> +	struct napi_queue *napi_queue;
>> +
>> +	napi_queue = kzalloc(sizeof(*napi_queue), GFP_KERNEL);
>> +	if (!napi_queue)
>> +		return -ENOMEM;
>> +
>> +	napi_queue->queue_index = queue_index;
>> +
>> +	switch (type) {
>> +	case NAPI_RX_CONTAINER:
>> +		list_add_rcu(&napi_queue->q_list, &napi->napi_rxq_list);
>> +		break;
>> +	case NAPI_TX_CONTAINER:
>> +		list_add_rcu(&napi_queue->q_list, &napi->napi_txq_list);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(netif_napi_add_queue);
>> +
>>   void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
>>   			   int (*poll)(struct napi_struct *, int), int weight)
>>   {
>>
> 
> I think this later 2 chunks are a better fit for the previous patch, so
> that here there will be only driver-related changes.
> 

So if the later chunks are moved to the previous patch, wouldn't git 
bisect and build throw warnings as the kernel API (netif_napi_add_queue) 
would only be defined but not used. The function netif_napi_add_queue is 
being invoked only by the driver code. Hence, I had to move in the 
kernel function definition to this patch that has all the driver code.

> Also it looks like the napi-queue APIs are going to grow a bit. Perhaps
> it would be useful move all that new code in a separated file? dev.c is
> already pretty big.
> 

Are you suggesting to move just the napi-queue related new code into a 
separate file, but keep all other napi stuff in dev.c ? In that case, 
currently, the new file would contain only two function definitions for 
netif_napi_add_queue and delete (if the napi-queue specific APIs do not 
grow). I agree there may be more generic napi APIs in future (not just 
queue info related), but wouldn't it look better if all the napi code 
were in a new file.

> Thanks!
> 
> Paolo
> 

