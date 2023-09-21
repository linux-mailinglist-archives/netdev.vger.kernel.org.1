Return-Path: <netdev+bounces-35610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5487AA04C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42081C20CAF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF8918B1B;
	Thu, 21 Sep 2023 20:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3827182CC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:35:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3CD40645
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695328549; x=1726864549;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3lxMGXZ+8LNeOM/Nc+opLklCaQsBuN0XjJ650QBF65s=;
  b=Xu2Q9LtrRdwaiJ5xEUEkOvBy0QXsdbYstGuxGyulfPD9s5b4Y6+9Z7IB
   lvtl198iVqKnA1Fx+q4jE7GvhZQK/qszpvwTXwii4aePVWPwq89pU40e5
   iIsgplQJbO54RGFcCyleARVHkpvo1oNiZu04MnEAt4U3moJvN3JnNa4xq
   Zpjco3IpMGHZa0Z7W4XKRpzoTh5LX5wsrjfWBGmKQ3Y0LBaYurElBqaYn
   C78vO0ryMu5a8zb9ZrNEwR50eKyYx5A7+BdCA/f60B0hlh2geHday60r6
   2C47BjVQH5E3MnjtuPYoBzzn4yWmJYJKiRq7wDk9uvhgFXkF0GKEec/Ov
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="377946137"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="377946137"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 13:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="747277771"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="747277771"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 13:33:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 13:33:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 13:33:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 13:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmtV6v5aOVGzQrYmsLFqINdmdXy1UCBtIrk6AlESGfvDDVUC8fLVv/OWsL5nck6s26ajhOyTwCydPCLioJAPmi8roXvSp7JfvSfRwSmsXyhWdhKKrT3cr8ZHWwADOWdfXf5Vt3JH6pALvA9BtsbqncF0wEr8T0Cy7Pu1GqanTBCh0mTEFiHlhjmISLiWz/UQp+w2UlO7+jm1eurZYBkybNZj4FA/YgYqdhJ5w9PZpMV+YcNwvgh7uqil4cv46W2ruh7r0yRZX5VkvulmXccETalOOsJCdnuxkCagnfhCZcOz4Ho8orP5HnPgpQWUt1KXgWd9JBM8tuLPQPJoJpx8XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4quTLdg+YntvrXCyi5wM+D0FgicSj/1vknLq8SG08SU=;
 b=fxyH0qeHay0PU5pQ4Gy1ex6ll9CU8UWpH+1YfL/VhqjVkhjU59Fod/nirxl1nZgTPZ5fBL47ffYyAc3E+d3TyiXSkMV98WBtWCGY8QQGrZcvW+Zl5sXctOs93JvEGyRofXYT6dHaXfZfXAwa6tfhgUluPTh0Kv2RkF59Q7Hhv9Ye/QIoj9CDU3zS5oUMFXSQIFwZ4wS+WSNSiRoPZszGxbmLJvJ3rueHsOskoTUCErkKMIvCinVrnzj7ZonXv5glCP8po8xkccdRJlUU1lsKAmMXJVISv8aHsIQhzvDU334TD3thZ5kqcgyQ09zYIchhSmmrah4R6dYA+6p8w2+2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 20:33:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 20:33:38 +0000
Message-ID: <ccf1a90b-4f5a-bcee-83fc-1bb85cb80d8b@intel.com>
Date: Thu, 21 Sep 2023 13:33:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2 0/3] Wangxun ethtool stats
Content-Language: en-US
To: Jiawen Wu <jiawenwu@trustnetic.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>
CC: <mengyuanlou@net-swift.com>
References: <20230921033020.853040-1-jiawenwu@trustnetic.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230921033020.853040-1-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:302:1::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: df94fe95-57f3-4363-bdde-08dbbae2095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rorqloxh/H1r55N87xKV3mWT7Df8HC5pXrs6/beWNbHVeoGiih1B/RH2DpoXn+IxcWiXffcNCurVkTbpNryGE/OAfsW/ZlJ0K7OaSyKZbDxHYmppy8RcqeCQdQuAdXBNuFavP9uSo2Qr07gFjfzDW+UGwsD0glDlTOQzLMzEGysbuRexuc4vaqqAN7V4VMU7ZG4/caRkQMdO0Vo4siUesXDTVbU+Y7D7Z9EH07c69wUvEwaU3VeemIV4Df/FPVhgcLtPVRagG7ByPKnberDnZP4c4BsOWYOurmCtGzpfwf4W89tV2+Kx+iyZ9JKR0R7fPJJQXMSp3q9wEQZclYHzRmB5NIhFIxba9HM1wLzF4j0fXhkUcrz8xUCePGVLfOChDduLknSitDlvfrxMirYas7l+3v6VeNMCDrLqA/yzdIhnED0HuRF4py5NvbQro/4g/IeK38ijfCysDJe+G2444i2rHJNBM/iT1cA7nc97GROIJRxIWEtLLzrStaXUV8LtsSYKdAia66asyTpM7TTZmOooYtVyMa2JFWH9yjG2tc2PP8BUBMP+sHx4ZlLvufWO8qkq3MaFTZbA+bqdm7ptbFWNS4dd6TGDRsjyXTUG1rA/RL9Q4iiW+eQpnR3Xf0r0KUG/F/ZayYuDRW924NpS0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(186009)(451199024)(1800799009)(478600001)(31686004)(6486002)(53546011)(6506007)(83380400001)(82960400001)(36756003)(38100700002)(31696002)(2906002)(2616005)(26005)(6512007)(8676002)(66556008)(8936002)(41300700001)(4326008)(5660300002)(86362001)(66946007)(316002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjNiaktWei9taGRXVVVZakRrczQ2MGJkRTZDRWdVOGtIUXpDTDl0Vk80d3c5?=
 =?utf-8?B?WTk2b2w2RWd3UG1qN000VHBHa0kwdW4vVHZoZFpPM0ZxUVBwY25DcU1nVy9D?=
 =?utf-8?B?NFY3aVB6ZkVUaUJTQlYxVXJZbGZ0NEZPdVJnNkxVakNrTWx3Qm9iODVvamlW?=
 =?utf-8?B?RVNwVjlHOG1NYk8za3AzSmRmc1Y1MGYrTzdhL3pEdkpPQkpRZzBEZnExMEJV?=
 =?utf-8?B?SDYvR1R6cnMyVGdiT2RuaUhyRm1BaG8zd2VITllWME1nWE1PVUxjOW1IeWhm?=
 =?utf-8?B?VDVaQ1JGeU9KZUoxdmRPZCtTKzZKcGw1V2hWOUQ0NXV1Nk1VeDQzRks1MHkw?=
 =?utf-8?B?bDNOUXQyT0drUGI1TnhwTUdvWThMUkpCTjZxdzUyTGorL3EyUFpoTGtVWE52?=
 =?utf-8?B?TmU2QzZRY3Y0bWhmWEs3Wk4xSkk2aWdDY3BGMHptSm9hKzNqaFNBbytYOEJm?=
 =?utf-8?B?c3gyZitRTURKbEYrVHdSTGJkekxINktLOW43NDRrMVhwZTRBOGtIZHN1aHNj?=
 =?utf-8?B?WXMvWEk0SGNPSVFEUWxHeC9TNHpQSEtRc0RaZDQwNklGZk9XcjZEdVNDMjZ1?=
 =?utf-8?B?STlWcEtHZHhUdTZVTTRHVWJMRUIvUm12dU1lMjBOOXgvMHRPbUw3WkxpWnRm?=
 =?utf-8?B?WGpyYW1MWmgzUkduNTdHaUNVVlVERVd4QkFWeWFBWkwyMzQ0Z3ZBTVhMYnlz?=
 =?utf-8?B?RUNYL2pySXp1ck1waFViSzZXU0Nkc2pLalFQZjVMUnVadHRWaTNHQlFjY2Jh?=
 =?utf-8?B?N2xqTFoxcFdRMCtqZDdDMmYyNFV1bW9XdGczM3BuOWI4eFN6K25Jb2dCaXd4?=
 =?utf-8?B?VGFUYUtuMjFjR2VUd3drUlpySDJralFTUmluN3d3Ui9jY00xZ1NIcnFmaHdH?=
 =?utf-8?B?bUI3MGhYMzBvZU9jVjB2eFdxdVhWUFFQVGJobmlrdkp0NzhQcG43Zks3VWJ5?=
 =?utf-8?B?V3UwL2dqWk9xQW1vcjFVd2pKYkNiMkx5SXR5OVBYeVJoSW5HNXB2b1pPNE1t?=
 =?utf-8?B?YzNVcFFNWGUzaHVmSDFGeklUbENBcXowQ09Ra1MweWl0QUdUVmlwRE5rZ0Iw?=
 =?utf-8?B?bzBKcGwyNFBJVFAwT0MyMjBuNjZtOUhhTlA0Nm1SYXVXMmUxMHNNSzNMOHpM?=
 =?utf-8?B?UnNSZmd4M01pbG8xZU51NlpPNlM1Rm1WTklzNmF0OEh5QWYvZEFMRWdsUW44?=
 =?utf-8?B?c2o5Y1JlQ2pocFFta2RlYVMzZ2Z4OUwrY05wUEtTT0VjVm9SMFJ2T0N0bDZF?=
 =?utf-8?B?d0ZxQWFlaWVDZFAxUUYwY2FIUVhwd1J4Rk9obDJubDRreDh2aHZrbUh4VGVh?=
 =?utf-8?B?cGI1WllTTHpHYXVIZkdsdzRNQktTZWx0ZktkSE9vMlBmcTVoNy9HQ1d4QlE2?=
 =?utf-8?B?MTR4SFlUMTRMV1lIeXFJNThwcFhsWlpXeXJxTVM2NGM4MVNzbjVrdHBHWVV0?=
 =?utf-8?B?Uk1DZVZGVHg4WmJxWDk3dGk2UEZDMmd6eVBCNlc5Vi90NGZYM0oxRWR5VWxu?=
 =?utf-8?B?SHBreWVoMlJ5SEYzbndDd3F0RVdkdnBTeG1Yb0FrejZRZmdLcmJCZnZQNzB2?=
 =?utf-8?B?cjVBRCtjOWN1QS9KQVo3M2RNdG5zUmg1VFpXSno2MURveTlKNWNlak9XZmlH?=
 =?utf-8?B?RklFNzRJdVJralZjUnMxczNsdm9oU2FtSlRTRUlVeDNzenh3NUJzZ2hHZ2I2?=
 =?utf-8?B?VEZOVGUyQWhvRkhPR21zOVhEVzR4eEtydGJzS2xnL1J2aWdtM1pWVlhkOGJk?=
 =?utf-8?B?MFE2SXFGSUVTenM5QXozbFU1SkM5NFdweHFGTWxOSHR4OFVwbnIwRWs2M1hI?=
 =?utf-8?B?VXNOdDNNMDliL2pQODFZSnVTWVZXeUVnMFJFZlFVY2pnRnJFMGVSaTlIOEhY?=
 =?utf-8?B?TkJiT05WdTZpM0tvQUs1cnhPWUxNaWxxcmszUWt6Nm1DM1pJUVJhNzdyM0Ni?=
 =?utf-8?B?eEJ5U05mUFpFN29Zb3JSU1E2aGVNQks0eWNGTDlIdkZicUE3MkdlZElvMEF4?=
 =?utf-8?B?Z1ZYRUd5Zllha2M2ZTRZOCtTK1BCMFF0R0Y1SjZvaEFpNG5laXVqdXRVTGdw?=
 =?utf-8?B?M1hjc3ZaaWcweldISmpxQmQ1eG4xMDQ4L1BieURDeTdGaEZiWEVOZHF1TzdO?=
 =?utf-8?B?T1YyejkvdEo4ZUhmeWpoaTBmOFppbVpIT2llV3pRMGt0anVudzhOb1RzSDcz?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df94fe95-57f3-4363-bdde-08dbbae2095b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 20:33:38.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/oo8kxCiFGtX7vehs5qPQWPXBKUUefOjYFES99RMW5gsnNBfSxpqYjGlAW8ldc5pjqndyD0qoQ87pW+/nhUmtIuHEGaKva04gjRxyeim74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/20/2023 8:30 PM, Jiawen Wu wrote:
> Support to show ethtool stats for txgbe/ngbe.
> 
> v1 -> v2:
> - change struct wx_stats member types
> - use ethtool_sprintf()
> 
> Jiawen Wu (3):
>   net: libwx: support hardware statistics
>   net: txgbe: add ethtool stats support
>   net: ngbe: add ethtool stats support
> 

I probably wouldn't have done this as 3 separate patches, but the code
looks good to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 191 ++++++++++++++++++
>  .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 116 +++++++++++
>  drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   2 +
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  11 +-
>  drivers/net/ethernet/wangxun/libwx/wx_type.h  |  80 ++++++++
>  .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c   |   2 +
>  drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   2 +
>  .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +
>  drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c |   2 +
>  .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   2 +
>  12 files changed, 416 insertions(+), 2 deletions(-)
> 

