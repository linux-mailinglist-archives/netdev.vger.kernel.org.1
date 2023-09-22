Return-Path: <netdev+bounces-35763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FCD7AB028
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 755D9282751
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614018B0C;
	Fri, 22 Sep 2023 11:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169C1DA53
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:04:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9523197
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695380668; x=1726916668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CiH8nT3EsXOTYbXV6qfFJZwNJMvT+GMGji1e7gPc734=;
  b=nGWjS3xlDf7uZE3X0WH3iStLBRN4IpHSBn75IpFVthb+UPa0fPzc+wDK
   7YNUzLOWwk3uNZ9BazoyyuD7AG1Sp0He2z3dFvaCNyBsUCcv/hfGVJpQJ
   9aiZpXNq4CXDBeuNcnRxgbaOdJY8GP+jhb2ginoLvUl1F92TMXWNV8Cu+
   QgQEUh8g8rVnTlAHL54IldkknAhZybF+IO6p/96HMrZ1xlQI4g5XbV5bD
   WiVW9CzQOFa3F1QZAQiXNi3gv+82Z1sjXyXNuBfVZl5mEK3N6YYiMi515
   2ZTL7Pde0QUM5Hnujxw/36VrSASFLUjokIBR4n7buN+eDQSFup0BdWZEl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="467100854"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467100854"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 04:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747483475"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="747483475"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 04:04:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 04:04:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 04:04:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 04:04:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 04:04:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux5QAQkTs8ZOLtCtynHRUjkTOkbsVKkumHSfuNASDbqwq6pYxNizOvvCGK7TZYHOqa2i2RPlY/vpU6GpmLAo3OINxVKbFlcR6aplEqvhKwjQI9olg2Qofl8EpSecigG92GEdkdkmbtfmzDkoprMwM3RWa5iz7ezhfHelQVN+NX1th5g5F+P01KIFGq9JASiFYgOJDVSHpbrP8KphmeV80wJwfQCD17COeMbH0Q6g6qaW/YvLllNNxWHIjYe8/EYhYin816KR3rni5DDBUHKM1CjTxG3YNhjg48PDenYQGruz8YRGH410sAmHDKaahDDqVTRfPaRtAbBR5QaLbbdzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RUs4JnI0gCTz6Hvn7gPAPoBrg74gCgQCYIVWSSTJ5A=;
 b=jIR716ATc22LgtWlGLZK3P+Yo+uq9mQ12Q+oqqKZcbMd1+fGx+snwzU/+LuBOex/+Kwc6x8Tq7ZBWuK0z4Tk/Ji7VP8ZI8lqtQQp38x1tW2AxS8tpozlYlu+/NhjFFiA7OuL5BrlUy4+TdwVTvg8WsYYziE0sBdX+qExcl0G18OKxlpzVyEAH5bbPFFjcB0KYhZhtDT+3MMtd0PVdISuiDIMyLJxhQI0+nPpWYShjgaG0OaeWiGVOF/8DSZ1Zkb7pRV+ygDHalw2M32NucqxOvQZ1rYULJmuAOsOlZdD+irNKKLEDEYlVKJAkjNumLBPaij6zelJzX44YorYB2gqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 11:04:24 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 11:04:24 +0000
Message-ID: <a4204cc7-cb40-dc17-610e-73ca12d8d6f7@intel.com>
Date: Fri, 22 Sep 2023 13:04:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 2/2] ice: Refactor finding
 advertised link speed
Content-Language: en-US
To: Pawel Chmielewski <pawel.chmielewski@intel.com>, <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <aelior@marvell.com>, <manishc@marvell.com>,
	<intel-wired-lan@lists.osuosl.org>, <horms@kernel.org>, Paul Greenwalt
	<paul.greenwalt@intel.com>
References: <20230921135140.1134153-1-pawel.chmielewski@intel.com>
 <20230921135140.1134153-3-pawel.chmielewski@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230921135140.1134153-3-pawel.chmielewski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: a45a54f2-2ed3-4e66-147c-08dbbb5badd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlE98G5qD5RtVTHT61eEvqWgS7IoqZr0tOxBJXjHQJM35C0my6GDeu+UPnHOn1xgOwRwRFnrJMt4YaoZ9eXS/Ppj3xeKzBenMlsgneCHbu0GZooId5inFu64hp/SLpHnLZbZlzLYSEaSUelCSGQ2Dyb/R0TeLJQu00ij4VMBGTNg6vrgVqvJeckqzcIoPJIOg4V43NBSP88zXt3eHqpwCYKk+rdC7PVfE4hS1uOtxAtMfYNkW7yZzMPkkPT3SLtJ2bcygsCjfbXm9Lq2W6Z/bFB/g9ZNLplgnoc/A4vTnyZtwpOZFVNkouwvy3ZeIzKfUHobjqLLYJLoldqKDPbdMYbTikzJKvydiVeYxZiTwAQY1u/wzb1gpJNcMvIxc2aD6neWhCPcCGjfjd9xJqH9B7ehPsQDFM2/in+8tYggdIAHw4EzjS3B3utBABczVsSv6OkC35swGtcOtbr4LWYnbvhz2U5k+lHrYWucRqfOygFBdlOlrQHapECfCwuc0Ib/UEC/SnbdZgars6q+nvt5CkNlL88iRTehVUUq+PwNngwG6/zLb2fs1fvfHLiR/l3moiXmdrdl/lyh30auugs5qAo2xUrFlZUgx+0UV6MYPcUZNThBlDYLF81qjbCeH0VO2cWbHaIlEC3mx3a61+iHCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(26005)(82960400001)(2616005)(8936002)(8676002)(4326008)(107886003)(83380400001)(31696002)(2906002)(36756003)(53546011)(6506007)(86362001)(6486002)(478600001)(6512007)(6666004)(31686004)(5660300002)(66946007)(41300700001)(66556008)(38100700002)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MElzdzk2QThpZjQyUU1IdVlxdGpQWStQN3hteEZ0RjF3cXBRSnhTTVd1L1Vo?=
 =?utf-8?B?b2p3cnZvZHk3K3pCR2RxeE96NVV1c2hwemVFTitueWJqajJpZ0M4a29KWmgv?=
 =?utf-8?B?eUthcXNYUUtJTDAxbitDNFhsTVhjS1IvMnVxUkRQcEdSUXl2VmR5V1JGTFli?=
 =?utf-8?B?NkdkbGt6c2xUSndxWXI3YmNJNzc4NUtvc2NETms0OTl2SElaMnNlcEtJc0Qw?=
 =?utf-8?B?aE1haGE2UEJkQzRuMyt5MENYU1g2dzBra05KL2NlS2k3YjRQSkJ5Wk1jU2dn?=
 =?utf-8?B?RisvMktDYktNa2cwT0FjdU95c0pPUFdZUHJWNVphZ1dXMWJnUDBoWnVYQmRF?=
 =?utf-8?B?RnllM28yQlpsYWtaTTNoSGdrdDRSVTJNUlNiYVd0M0RSa09ZZ3Z5UldzZXMz?=
 =?utf-8?B?dnVmN1dXYlYrZ2FiRllyYjA3TjhyUC9BY3ZwTjlyTlZVTnp0SDNKa2U1ZE9I?=
 =?utf-8?B?YXFteUp3SnlOY2pnL1V4NUhRbGM2cmVhaWFvZnlTejVqd1YzUGlndWtXdWVJ?=
 =?utf-8?B?ajRwNFIvMjhvdEl0YkttSDRjcXU0ckU3N1ZtY1kvYWNybjM4MC9SNHQ3ZitW?=
 =?utf-8?B?QlBnMmxxdmd0bzJETVRGV3E3VGlHSVBGVGxxYWMwZXZCSkFEb2pXaEF1U1ht?=
 =?utf-8?B?MExEMTI0Tjcrd0J2TWZFUzRtUldqS05WYW9kUXhhYi9GaDQ0d1RDYXNlOEhy?=
 =?utf-8?B?dG0reSs0VkdMSkN5WHNzNnZpWHdHRHVUUE5LZU1KckJmcnBhQ0ovZnUxZVdt?=
 =?utf-8?B?cnY3c1A2Tk42c0ZTOHg4ekdsMmUxRTMrdFZMVTVhc1hPYkduY2dTRy9SZWQy?=
 =?utf-8?B?eGh0V0IvalhhbXBBNEY3MWZHb09hYlJ1VjZQeDZnWU4zQUd4cmhldTJZMjB3?=
 =?utf-8?B?NkVSZDlkSjlXSGVteGtuNzdLRDFQZ1NmU3cxcm1tbTYwTGE5WGdlczQzOTVN?=
 =?utf-8?B?WXNXbTlrZFl1aEo5YlFYZitCaWpTZnJoNHpOc1J3YWtXUk5WRVd3Q0V0MmVu?=
 =?utf-8?B?YTExRWV6cDNWUFpTZlM5QVZaWXpabWVVN0dnSldyTWVQeXdxL3VzdUlBekg0?=
 =?utf-8?B?THl4K2RSK3J4VGZqUzllSzhqU0lsbGxpbXJ3dFl5SWZBOFVZRGVZdUN1L1B1?=
 =?utf-8?B?MzhOWEhDTTI0ckVSREg3ekhQR0paQTFISThqQThnbnhuQi84UXpjOXZOVG9P?=
 =?utf-8?B?Y3dXY3hhYWtJKzE4VmlLQ3NnSk1nbVdxUmNUU0lMOUhyTTNjZ2dYaWlsbU1u?=
 =?utf-8?B?RmM2OHhleFNoa2tibGJpdWtpdkFOZGpLSVZCZGFlN1hxTDBGVmUzMlY0Z3U0?=
 =?utf-8?B?WEZXd0V4KzRHT21HN2JFRzQzRVh2clpDaW1lV29pcDUzQ2N0NGdXT3RvZHFV?=
 =?utf-8?B?djA0c3d4WkNLTXVJV2RtUlB4V2g3dTRiRGdtdTNFUm1rUEdiZXkrUGhoVURI?=
 =?utf-8?B?TzdDTlY5UDh4SGQwVW5oK1BMOE9rV3RxbGYxS1RheUNtSjVIcURwOGE5MGNl?=
 =?utf-8?B?RGZEL2N3S2VkdmQvQlN0TTMrYWx5c2VQUW9URUJHRlI1UGtTWWc4Nk5kbHhL?=
 =?utf-8?B?eTd1d2ZKeWt0QzVPaDlTNmdKQTZlYmllSHdPZ0xRRkFQL0liOHh4Yzcrcmla?=
 =?utf-8?B?RkF2U1ljNmZnL3R0V1ZMeDhLQnZJeGFvVjUwZmluU2lTZUdCSjRrNnV2UGtq?=
 =?utf-8?B?YUxUb3lkMW1VVXgzNVhXeUdZdzBZTTQyVzV6Ynd3UFBXNWFWNXhYVmJCOUdp?=
 =?utf-8?B?REFzM01BSkVhcEdjVHZMaXFydGgwT05KdHhDNkxlNURSdEt4Qmc2UkYzdWdw?=
 =?utf-8?B?TVl5M3VRV0VWcDVJa0tLSURZVUM5MW1EbFFqQi9qYWw4UFU5ZzNKdEVUb3d6?=
 =?utf-8?B?SUJCUUR6S1YvMU1LbUlEM0FIOFdCUVczMCtGR1NDY21ZR0dqMFpsZDdQSlhv?=
 =?utf-8?B?NEREOGxWWUFxc0daYnp1Z0NEV2J3dkFqR1VOMkU5MEtRRmZ3WEhodXNnRkhC?=
 =?utf-8?B?blduSHgyc2VWL2haZVNLTXR0SGVQaGhIVmpPb3FuTmV2MWtrQWZ1T0NIc28x?=
 =?utf-8?B?VWc2bnBLYXpsa0toVDNiU3RSN1czUTBKLzA0NGZIc2VIMEMzN0dLeGwxOWlk?=
 =?utf-8?B?QUxDTzM2dnpEWDk4OVIzV05qSnNoQmtkMlNPTitIMDVjZkkxaHQ0S3JkTjF1?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a45a54f2-2ed3-4e66-147c-08dbbb5badd4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 11:04:23.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEOhvfeMQ5I6rAQs54Q8XMiSVErfe6CgaL5/72Cb870wbIHwwYnkTiNR1VOUFn0LaNeyFcca2NAj7Fkx20eVZT+HKubll8SxeUoMqqcj4jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 15:51, Pawel Chmielewski wrote:
> Refactor ice_get_link_ksettings to using forced speed to link modes mapping.
> 
> Suggested-by : Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>

minor: your SB should be last

> ---
>   drivers/net/ethernet/intel/ice/ice.h         |   1 +
>   drivers/net/ethernet/intel/ice/ice_ethtool.c | 200 +++++++++++++------
>   drivers/net/ethernet/intel/ice/ice_main.c    |   2 +
>   3 files changed, 138 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 5022b036ca4f..5eda0fa39d81 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -942,6 +942,7 @@ int ice_stop(struct net_device *netdev);
>   void ice_service_task_schedule(struct ice_pf *pf);
>   int ice_load(struct ice_pf *pf);
>   void ice_unload(struct ice_pf *pf);
> +void ice_adv_lnk_speed_maps_init(void);
>   
>   /**
>    * ice_set_rdma_cap - enable RDMA support
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index ad4d4702129f..8b84bb539e1a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -345,6 +345,86 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
>   
>   #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
>   
> +static const u32 ice_adv_lnk_speed_100[] __initconst = {
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_1000[] __initconst = {
> +	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_2500[] __initconst = {
> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_2500baseX_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_5000[] __initconst = {
> +	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_10000[] __initconst = {
> +	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_25000[] __initconst = {
> +	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> +	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_40000[] __initconst = {
> +	ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_50000[] __initconst = {
> +	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
> +};
> +
> +static const u32 ice_adv_lnk_speed_100000[] __initconst = {
> +	ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
> +	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
> +};
> +
> +#define ICE_ADV_LNK_SPEED_MAP(value)					\
> +{									\
> +	.speed		= SPEED_##value,				\
> +	.cap_arr	= ice_adv_lnk_speed_##value,			\
> +	.arr_size	= ARRAY_SIZE(ice_adv_lnk_speed_##value),	\
> +}
> +
> +static struct ethtool_forced_speed_map ice_adv_lnk_speed_maps[] __ro_after_init = {
> +	ICE_ADV_LNK_SPEED_MAP(100),
> +	ICE_ADV_LNK_SPEED_MAP(1000),
> +	ICE_ADV_LNK_SPEED_MAP(2500),
> +	ICE_ADV_LNK_SPEED_MAP(5000),
> +	ICE_ADV_LNK_SPEED_MAP(10000),
> +	ICE_ADV_LNK_SPEED_MAP(25000),
> +	ICE_ADV_LNK_SPEED_MAP(40000),
> +	ICE_ADV_LNK_SPEED_MAP(50000),
> +	ICE_ADV_LNK_SPEED_MAP(100000),
> +};
> +
> +void __init ice_adv_lnk_speed_maps_init(void)
> +{
> +	ethtool_forced_speed_maps_init(ice_adv_lnk_speed_maps,
> +				       ARRAY_SIZE(ice_adv_lnk_speed_maps));
> +}
> +
>   static void
>   __ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo,
>   		  struct ice_vsi *vsi)
> @@ -2007,6 +2087,55 @@ ice_get_link_ksettings(struct net_device *netdev,
>   	return err;
>   }
>   
> +/**
> + * ice_speed_to_aq_link - Get AQ link speed by Ethtool forced speed
> + * @speed: ethtool forced speed
> + */
> +static u16 ice_speed_to_aq_link(int speed)
> +{
> +	int aq_speed;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		aq_speed = ICE_AQ_LINK_SPEED_10MB;
> +		break;
> +	case SPEED_100:
> +		aq_speed = ICE_AQ_LINK_SPEED_100MB;
> +		break;
> +	case SPEED_1000:
> +		aq_speed = ICE_AQ_LINK_SPEED_1000MB;
> +		break;
> +	case SPEED_2500:
> +		aq_speed = ICE_AQ_LINK_SPEED_2500MB;
> +		break;
> +	case SPEED_5000:
> +		aq_speed = ICE_AQ_LINK_SPEED_5GB;
> +		break;
> +	case SPEED_10000:
> +		aq_speed = ICE_AQ_LINK_SPEED_10GB;
> +		break;
> +	case SPEED_20000:
> +		aq_speed = ICE_AQ_LINK_SPEED_20GB;
> +		break;
> +	case SPEED_25000:
> +		aq_speed = ICE_AQ_LINK_SPEED_25GB;
> +		break;
> +	case SPEED_40000:
> +		aq_speed = ICE_AQ_LINK_SPEED_40GB;
> +		break;
> +	case SPEED_50000:
> +		aq_speed = ICE_AQ_LINK_SPEED_50GB;
> +		break;
> +	case SPEED_100000:
> +		aq_speed = ICE_AQ_LINK_SPEED_100GB;
> +		break;
> +	default:
> +	       aq_speed = ICE_AQ_LINK_SPEED_UNKNOWN;

minor: wrong whitespaces

> +		break;
> +	}
> +	return aq_speed;
> +}
> +
>   /**
>    * ice_ksettings_find_adv_link_speed - Find advertising link speed
>    * @ks: ethtool ksettings
> @@ -2014,73 +2143,14 @@ ice_get_link_ksettings(struct net_device *netdev,
>   static u16
>   ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
>   {
> +	const struct ethtool_forced_speed_map *map;
>   	u16 adv_link_speed = 0;
>   
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100baseT_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_100MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseX_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  1000baseKX_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_1000MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  2500baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  2500baseX_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_2500MB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  5000baseT_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_5GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseT_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseKR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseSR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  10000baseLR_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_10GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseCR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseSR_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  25000baseKR_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_25GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseCR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseSR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseLR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  40000baseKR4_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_40GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseCR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseKR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  50000baseSR2_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_50GB;
> -	if (ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseCR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseSR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseLR4_ER4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseKR4_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseCR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseSR2_Full) ||
> -	    ethtool_link_ksettings_test_link_mode(ks, advertising,
> -						  100000baseKR2_Full))
> -		adv_link_speed |= ICE_AQ_LINK_SPEED_100GB;
> +	for (u32 i = 0; i < ARRAY_SIZE(ice_adv_lnk_speed_maps); i++) {
> +		map = ice_adv_lnk_speed_maps + i;
> +		if (linkmode_intersects(ks->link_modes.advertising, map->caps))
> +			adv_link_speed |= ice_speed_to_aq_link(map->speed);
> +	}
>   
>   	return adv_link_speed;
>   }
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index c8286adae946..04047f869a99 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5627,6 +5627,8 @@ static int __init ice_module_init(void)
>   	pr_info("%s\n", ice_driver_string);
>   	pr_info("%s\n", ice_copyright);
>   
> +	ice_adv_lnk_speed_maps_init();
> +
>   	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
>   	if (!ice_wq) {
>   		pr_err("Failed to create workqueue\n");


