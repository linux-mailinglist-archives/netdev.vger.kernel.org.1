Return-Path: <netdev+bounces-35068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801267A6CB6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 23:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D9281716
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FD37156;
	Tue, 19 Sep 2023 21:06:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166C68831
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 21:06:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F2BD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695157584; x=1726693584;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwHiTtCLfqQ7gkrOeD0rN/1xZJxmbTgeDokEvRWWay8=;
  b=Ie+DWe/N1XcY6THOVMjxSZQW3PZcg1wY5DSCp/Zfmk3MW29SoEDZWxtZ
   tnHJY801Zfe2J1Cgt8WABvYOhf0+FN8j5gM/lCW9taMH6Riq2lDvEIRNH
   AeXswH9Zlx6OQliEAjyHBvmIh39nwJt4BeNqCqm8EIVGng8nWK0rqQ93/
   9yxs9V9IH4Y/Ajm3FYaAHw6RG1obkn26AyvQIJVUJTwUKM4r/AyB64CcZ
   wVnDdR7B5xtSXGMN9kARhuWKNDUBKJc30zOTo4W91v8YsZRnx+S+nRNdL
   ja4kOzZsNNpSftjPaA1NxXce2/XAIaPQudFlmt4RU5L6xo3Cc4tPqdTet
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410985084"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410985084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 14:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="870099823"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="870099823"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 14:06:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 14:06:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 14:06:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 14:06:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 14:05:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz3LzmTK8YgFKvyB+OmjFEn+9EnJ9yuNJqCO1xNh76teOmNM/BJxZdGiYMajqctcpR/f1nJik4QAgaMqr9chFq6TeOIiV39yQ3wAmue7tnfw6hyjdwY2pOnHecSvuP/9aqbFem2Yv9XHN0zxApGlXzH5sIGhTmDM1qB4TwEshCvwvJGuymsNzEgtc1QZN0jgKIcjB9oJpcEMyD9E1CpBNoc2A9Qnk/5zzxdjayJiNAAofZ8SrM1fI8PVaIJBwhRJHaRfmFF+868j/lKksAb0+G8UCyGG59ggUK58qDjhBYUQCYPmtZG9uX3EUlgOmw/ZlpiEw0lhDBOrW9AgrZBp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIbw258ImQmmmDaCg1Fl2f6ECIwRIkPuIdhwYKt1nB8=;
 b=FP9aj4O0t/WO8+arNs4dpKxeF1UG/jfYJY4WdrawRm79kVlnDXPXCkdj69nSkwIN5KHfXef/A7GcGqdafzBNKFgjYXwoxuEgVesFbcY/1qH8w14hoNz5QqvXWK0yDnlZi9AIcinIDlH6BKu1gJ/cz67MXoEo4aR6JTV2uxyF5JDNCIQkf6kaI85IFZQxv8BeUpoweTHBIeh1fG86NNLYkdjx6w03NsWAXs/Ob34VKwQE9MZplof6kBadLxiDhuTkL+ssl5d3UnBs2n/6Wkf4A78k5KKlDUNaNVKdWI30zzbnaBj/GajoY6V53hitWlP0Y19bA0FORF5tCUirnnAqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Tue, 19 Sep
 2023 21:05:55 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 21:05:55 +0000
Message-ID: <69c31962-235f-565f-81e1-32bb25734ef9@intel.com>
Date: Tue, 19 Sep 2023 14:05:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 2/6] ice: Add 200G speed/phy
 type use
To: Pawel Chmielewski <pawel.chmielewski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <andrew@lunn.ch>, Paul Greenwalt
	<paul.greenwalt@intel.com>
References: <20230915150958.592564-1-pawel.chmielewski@intel.com>
 <20230915150958.592564-3-pawel.chmielewski@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230915150958.592564-3-pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ab641b-6354-4ffb-968f-08dbb95436f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR2e/qQQO0A68bLHTwhrQHxYtJopVtnDxGA2EHZlcomWy1BfPXTpoqAAxcC91pjLqgb6UUvsYkZgzbVZdJ26LQTmGBEvAaxCVcrYQ+ACv/z9jgmZa79Fe4OfnG7YRdqI+W/Ulm7/T8jHfdFjCDwmIbfuYOWww1S5Os21KtkxeNsmsQ3QtWGMt/weno7Zmncs9fwm45UFKaJS0tlKHmzLqFEQbHaYamnXfH0NLL2JjyBsJgtz33eI7NxQ9EA56/NpfZwY4nSBejXRL74mfnQ0iXBqcyGQxgYgb392AbZujPGZFtsU2NBTZBkX1ruPYJMMnx4IiSM2WjVaH8qhmummbX8THA4wNfgYY4j46iW3Jr4nLB4sP+f9eYzdL6g/rRUC5gexUm++psH+/fUgZd9xh8iNzsS0dNq+b1JTIIh+85Kt593I9xsJzSYqyXv8HHFWtrK1UNTI+4Lr77pPwej346K8MxvA1YhhwOwvoIio9RUQs2RjkyoifALoTg2hEMJt8yGvSfa17jFi5Gnkkhg/QX6R7XNp1jBscPdo5YT3Fd7T9vJhj8HvoLaBrZh0VuAfcMsST3MhvkQiZI/rJzOzyW51vxEweZaTqroMyDHY61+b/YpZFb99Ycqe3pPO0d6Edh5pejEnB5L8VwFRAdivFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199024)(186009)(1800799009)(6486002)(966005)(5660300002)(6506007)(53546011)(86362001)(316002)(6512007)(66946007)(66476007)(38100700002)(41300700001)(66556008)(31686004)(478600001)(6666004)(8936002)(82960400001)(2616005)(8676002)(26005)(2906002)(31696002)(36756003)(107886003)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUc3UXpkYzlQVjRVM3VOWGo4Y3M2ZFZmOXVMQ1JxNjFBanVZK3htRUdFam5U?=
 =?utf-8?B?T0daZ2YyWUg4WVNBNHJLVVdmUW1Xd0pmS2F3TXQvSmRYQS9DOGxRR1k0M2FJ?=
 =?utf-8?B?VndrY0Z3bGpHY3FBRE95UVQrbDUyUWVDUEEvZnNQNkZwNkdoamlqNzMzbWZs?=
 =?utf-8?B?VDQrU3gwMlZaaHl0V29uWmdzZFhHS0JGcEIzRWpLTDZIaDJKUlJEUFVPdnQw?=
 =?utf-8?B?aWhMQnZOeEkyV2NiNUZ4U2lLSWtPci9rMlNXMDlVNmpGRjdJR3J3Y09wTVdJ?=
 =?utf-8?B?RHZkODdmRXNWL1MraTE5UldqTC9iT1dSYktWZFAyeGt2OStuQnlMQ3BuUXdm?=
 =?utf-8?B?dVdQNkJQeTY4S0JESDk1Y3AxbDBuZUY5MHgyL2VUR3RmY2FXRVQ1ckF5M2xG?=
 =?utf-8?B?dmJYMG8yK0N0U2JFcUxLS1d5TDJXWXdxa2VENWZsTjRzLzFQR0VlcytJRlEr?=
 =?utf-8?B?Z2hzUmszNWJNc1Q1N0lTUHo2cElzeWc4YUVWaXV0ekFtYit0RW5Ba2VGRUNK?=
 =?utf-8?B?dER2WEVZbXFnZG52M2FFSmpudzZnejJSb1BVNUZRcWN6Sk5XM0NqcTVJaE9q?=
 =?utf-8?B?SVI3bzh0K09jZTNxUUlhKzQwS3UwKzYrTTdrTStOamhqeXdDYUczRnUzUDlk?=
 =?utf-8?B?ZVIzbTl2Ky9DanFoQXdaYlNyZkZwSjJEK00rcHYrKzNsbitSNWRBM1VCVE81?=
 =?utf-8?B?QXNzcjRuRklvdHNLTUJuR3VRd0xEZ3NCeXMzSjlEVUlwUkRxaXk5WUZqa0hY?=
 =?utf-8?B?bGdwTndrck9kRzJsUDdnUjRWdkNxWlRySzVTdXN4Vk5RSzBqcWh5UHdDZDB5?=
 =?utf-8?B?bUFzbDdnSytmL3M3MDlhWXBMR1Q2cGpTYWNSZmpseWcrY1gyTUpvRGFFMXFP?=
 =?utf-8?B?WlZKS1graC9NeUNpeG94NG54V2phSk9KM0k0Si8rUXFUSXhVNk9wTVJ1Rnln?=
 =?utf-8?B?U2w3TU9TaGtTMHF0T21tdTdXaXQ3K090U3owcWQzOGxPMWE4Rk5nTHppTldi?=
 =?utf-8?B?NTQzVjUxdXB3cTZTNFVnQ200akpOay9wRmswalFtVGxPQWc2bHVsVGNheDJu?=
 =?utf-8?B?ZE1PUC90MjNhQ0tSWkV1NzcrbVQ2cUlGL0xnV29NSTVZdG1wOHJSL2x1QXdr?=
 =?utf-8?B?QUUycll5cE1TMmU5SlVLeGZjanNpc3hoVU9ySUtTbmdLSENLMlR2bTd6QzV0?=
 =?utf-8?B?YWxQTE83WGIvUEwwV2NZc0dzdDdRQW82c3JkTDUwcVc2YUxhZzFzTjE2azRj?=
 =?utf-8?B?Ty9LN1FTZTRsREVxaXJJSUlBNWRRLzJ5RW5yTXFwMGc0a0pLTU5ZclFFTWF4?=
 =?utf-8?B?TlZQclVEbS9UdUZMazJrWVBDVTFiLzhoNGYwbWdjcWNXSEZIQU95VHVlY21o?=
 =?utf-8?B?OW1WaVY3eTJRS2NOS0RZbStMbTFRWHorOEV2L0E3blZIa2c5Tkx1YjV1Tlo1?=
 =?utf-8?B?RlVHNHUrZVhNZDdsMlN5QWd2anhST3c4ZDMydGJaNnlOTmNLdHg3VWdQOXND?=
 =?utf-8?B?RHFwSU5mRzVBc3dSTVBHWWJCcEFwWkxXUGh1Yk40WXJ4djAyN0F6LzcrdGdM?=
 =?utf-8?B?K0VRdTBJQ1Yvd3lUZzdBZGNReGM4Tlk3U3RrV0hQNWxpRlFoRkVUWWE3K0FI?=
 =?utf-8?B?OWwxMWFDZ2lqWE9obEkvMFBxdEhKc2RtcTM2SnByQUVod24wSHBLTldmRXZP?=
 =?utf-8?B?cjZmUU00cXJleUJGaXpWSVpPdTQyc3pFc21GYkRid28zdEY0SzNSczZuTlpj?=
 =?utf-8?B?NEJ3cS8ySnJCTHQvb1hVY2tzdmpzVGY5ckF0Y0lUUStXOHBrcDhrVXZ4T0dv?=
 =?utf-8?B?L1VjdE1ST01rMmV2MEtjT2lwN2VURXQ2a2Rra0NqNk5zMHBIZUtSMVBEOU1s?=
 =?utf-8?B?ZkFvNDMrdGtGZGlQNnRTbDk2RzBDZVNLZHdYcTU5UG1ZNU55Z3kxNFovODhp?=
 =?utf-8?B?K2tTdFB5NnJKNW9TZS9ERzVmRGdYZXVRTHlBVERET0N6TmJVOFh2R0VTbG5K?=
 =?utf-8?B?cTZQaHFHY3JhVXluRTZaYVpyd3JhNVhHWHlSZ2V5QUErcmV5dGFnaks5QlMz?=
 =?utf-8?B?djVObEFudDRQWVF4ZUFUUTNXM2hqSnlLVVVJYVFCS3VvdHo0QVpSUUk2S0c0?=
 =?utf-8?B?WDBycjNveHVhNGZEUG1Cait3ZUpwZ3pNdG5uVXdibU02ZjVoTGpiR3NoRDNN?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ab641b-6354-4ffb-968f-08dbb95436f8
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 21:05:55.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeOSHb1I8achxNW+jiU1oLLc1xJ9qDWQmbvOZy+HEgeyq9HkCdFDVl3gRALFxTZb+1wYw4lM5VOm6rSQzFtgpHdipty0WGCvcBnfBgdRszw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/15/2023 8:09 AM, Pawel Chmielewski wrote:
> From: Alice Michael <alice.michael@intel.com>
> 
> Add the support for 200G phy speeds and the mapping for their
> advertisement in link. Add the new PHY type bits for AQ command, as
> needed for 200G E830 controllers.

Does this need a 200G link speed map like the other speeds [1]?

Somewhat related. If you have a dependency on another series, please 
wait until it is applied before sending. If you are looking for comments 
only, you can bypass the waiting and send it as RFC.

Thanks,
Tony

[1] 
https://lore.kernel.org/intel-wired-lan/20230915145522.586365-3-pawel.chmielewski@intel.com/

> Signed-off-by: Alice Michael <alice.michael@intel.com>
> Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 11 ++++++++++-
>   drivers/net/ethernet/intel/ice/ice_common.c     |  1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c    | 17 +++++++++++++++--
>   drivers/net/ethernet/intel/ice/ice_ethtool.h    |  8 ++++++++
>   4 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> index 29f7a9852aec..c38e189ea8f7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
> @@ -1099,7 +1099,15 @@ struct ice_aqc_get_phy_caps {
>   #define ICE_PHY_TYPE_HIGH_100G_CAUI2		BIT_ULL(2)
>   #define ICE_PHY_TYPE_HIGH_100G_AUI2_AOC_ACC	BIT_ULL(3)
>   #define ICE_PHY_TYPE_HIGH_100G_AUI2		BIT_ULL(4)
> -#define ICE_PHY_TYPE_HIGH_MAX_INDEX		4
> +#define ICE_PHY_TYPE_HIGH_200G_CR4_PAM4		BIT_ULL(5)
> +#define ICE_PHY_TYPE_HIGH_200G_SR4		BIT_ULL(6)
> +#define ICE_PHY_TYPE_HIGH_200G_FR4		BIT_ULL(7)
> +#define ICE_PHY_TYPE_HIGH_200G_LR4		BIT_ULL(8)
> +#define ICE_PHY_TYPE_HIGH_200G_DR4		BIT_ULL(9)
> +#define ICE_PHY_TYPE_HIGH_200G_KR4_PAM4		BIT_ULL(10)
> +#define ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC	BIT_ULL(11)
> +#define ICE_PHY_TYPE_HIGH_200G_AUI4		BIT_ULL(12)
> +#define ICE_PHY_TYPE_HIGH_MAX_INDEX		12
>   
>   struct ice_aqc_get_phy_caps_data {
>   	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
> @@ -1319,6 +1327,7 @@ struct ice_aqc_get_link_status_data {
>   #define ICE_AQ_LINK_SPEED_40GB		BIT(8)
>   #define ICE_AQ_LINK_SPEED_50GB		BIT(9)
>   #define ICE_AQ_LINK_SPEED_100GB		BIT(10)
> +#define ICE_AQ_LINK_SPEED_200GB		BIT(11)
>   #define ICE_AQ_LINK_SPEED_UNKNOWN	BIT(15)
>   	__le32 reserved3; /* Aligns next field to 8-byte boundary */
>   	__le64 phy_type_low; /* Use values from ICE_PHY_TYPE_LOW_* */
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 983332cbace2..e8225b275f70 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -5666,6 +5666,7 @@ static const u32 ice_aq_to_link_speed[] = {
>   	SPEED_40000,
>   	SPEED_50000,
>   	SPEED_100000,	/* BIT(10) */
> +	SPEED_200000,
>   };
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index d7e7e1ba2234..68690e89b4e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1718,6 +1718,15 @@ ice_get_ethtool_stats(struct net_device *netdev,
>   					 ICE_PHY_TYPE_HIGH_100G_AUI2_AOC_ACC | \
>   					 ICE_PHY_TYPE_HIGH_100G_AUI2)
>   
> +#define ICE_PHY_TYPE_HIGH_MASK_200G	(ICE_PHY_TYPE_HIGH_200G_CR4_PAM4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_SR4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_FR4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_LR4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_DR4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_KR4_PAM4 | \
> +					 ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC | \
> +					 ICE_PHY_TYPE_HIGH_200G_AUI4)
> +
>   /**
>    * ice_mask_min_supported_speeds
>    * @hw: pointer to the HW structure
> @@ -1732,8 +1741,9 @@ ice_mask_min_supported_speeds(struct ice_hw *hw,
>   			      u64 phy_types_high, u64 *phy_types_low)
>   {
>   	/* if QSFP connection with 100G speed, minimum supported speed is 25G */
> -	if (*phy_types_low & ICE_PHY_TYPE_LOW_MASK_100G ||
> -	    phy_types_high & ICE_PHY_TYPE_HIGH_MASK_100G)
> +	if ((*phy_types_low & ICE_PHY_TYPE_LOW_MASK_100G) ||
> +	    (phy_types_high & ICE_PHY_TYPE_HIGH_MASK_100G) ||
> +	    (phy_types_high & ICE_PHY_TYPE_HIGH_MASK_200G))
>   		*phy_types_low &= ~ICE_PHY_TYPE_LOW_MASK_MIN_25G;
>   	else if (!ice_is_100m_speed_supported(hw))
>   		*phy_types_low &= ~ICE_PHY_TYPE_LOW_MASK_MIN_1G;
> @@ -1876,6 +1886,9 @@ ice_get_settings_link_up(struct ethtool_link_ksettings *ks,
>   	ice_phy_type_to_ethtool(netdev, ks);
>   
>   	switch (link_info->link_speed) {
> +	case ICE_AQ_LINK_SPEED_200GB:
> +		ks->base.speed = SPEED_200000;
> +		break;
>   	case ICE_AQ_LINK_SPEED_100GB:
>   		ks->base.speed = SPEED_100000;
>   		break;
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
> index b403ee79cd5e..b88e3da06f13 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
> @@ -100,6 +100,14 @@ phy_type_high_lkup[] = {
>   	[2] = ICE_PHY_TYPE(100GB, 100000baseCR2_Full),
>   	[3] = ICE_PHY_TYPE(100GB, 100000baseSR2_Full),
>   	[4] = ICE_PHY_TYPE(100GB, 100000baseCR2_Full),
> +	[5] = ICE_PHY_TYPE(200GB, 200000baseCR4_Full),
> +	[6] = ICE_PHY_TYPE(200GB, 200000baseSR4_Full),
> +	[7] = ICE_PHY_TYPE(200GB, 200000baseLR4_ER4_FR4_Full),
> +	[8] = ICE_PHY_TYPE(200GB, 200000baseLR4_ER4_FR4_Full),
> +	[9] = ICE_PHY_TYPE(200GB, 200000baseDR4_Full),
> +	[10] = ICE_PHY_TYPE(200GB, 200000baseKR4_Full),
> +	[11] = ICE_PHY_TYPE(200GB, 200000baseSR4_Full),
> +	[12] = ICE_PHY_TYPE(200GB, 200000baseCR4_Full),
>   };
>   
>   #endif /* !_ICE_ETHTOOL_H_ */

