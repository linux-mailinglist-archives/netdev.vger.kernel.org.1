Return-Path: <netdev+bounces-25504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD29774644
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9725D2816D1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C2154A2;
	Tue,  8 Aug 2023 18:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421415494
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:54:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBD24AA8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691519338; x=1723055338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KWcX9rHYzMwFhf6UMp8a5khpSr6z8wOeOEO3z9Pm8d4=;
  b=Jq6/5OB0rZNAvRCP0pZTlB3AxQ0XcEsrSxTec0FUBRL1nP0RqXYvMmNB
   np/448MQuM6Q8q1GOGUB5sktjXLogf5I/nn702kFSJI0ocFaa7bPGt5BU
   Z5DlAX8gq2Mk+i5HbWVZzp0rnn1IwB7NfCDBYeR5NpkCUgVRCpQ3L53TB
   CD+VAu+qViOJqfSgTi7QIWkB6i3f8o7eQGEas5WEn5tTCt5kpd/Kr7P4g
   prV1SkICWZuXBIXrgNqZyke+CAiPxHGP8BQHMzqQulicb5THx0iiInCUe
   8eEoqQ9ycxEURTgqrdeyiZlwdvaWBpLVoIxWWkrPnHUnzL8A8D138sP9k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373686575"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="373686575"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708352692"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="708352692"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2023 10:55:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:55:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 10:55:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 10:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQXMH5DlveUlV9iguY52CiMEH5ucB0JZysnsntIX5yL8AS8viTlyXDCNBq0s2g4tF7bm0hpJfniXAs2ICcpJAdsvQ4WBmOjL566Zd7DvL5z8bhIIOtWDYDSr5JkVqR1znoVhm+Tykh2Hw4wwiIPWj3+59nnD2zYeYRL26+cVVWhtD9kLD3aSPFMe9vZTig6T0bsI7Wgfwy13cqV8z1I9D76fehsLZfA7mOz6aqKqsjDV+QqoMpVYZfb+hivAZZt8d0PHFgESe8dbsAh1UY/58ngfVPaSG67TSD6i41PBHOjkadSe1gz2rZFZO8FCyuOtVVXUTe+vm/hCcgDVt8k33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjTD45CBVpb6JWCULBqEQ6KjPJQYusAvezYbWTeIcMU=;
 b=VCVsjGV4O+nCmpSits6zrH+LsGByINkMTMvH5bFvgXjo+Ne2eBwZMPP8OE7meKlPKbs9iCEaSh5YWxIAF14YR+Sg7kL3b7W58OBE2mqXbBYoyE/pjrD27h7S1jUyEqKP8TL+HrrG6Ef3c8FaNklsEzJgfAsa1naVSTwt5euhVuwpevFVDULre2N2Zs6FPzVw6/kUSiOwMBJr94yhy6h1pSfCBD74G+HyJq2JFetZTB+QOMAtLdXwRfAB54TVX7/7CWaBk68ZxVbulpWgSA1anqvBvs+EyIkKjCetRO6lcRaIPObqMfBO6FGaQC4iytyZHg/+f0EdSVxzYv1+F/GA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by SJ2PR11MB7620.namprd11.prod.outlook.com (2603:10b6:a03:4d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:55:09 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:55:09 +0000
Message-ID: <4e8adb44-1f75-6c46-d7e9-a8ea5f3921fd@intel.com>
Date: Tue, 8 Aug 2023 10:55:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v2] ice: Block switchdev mode when ADQ is active
 and vice versa
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, "Ertman, David M"
	<david.m.ertman@intel.com>
CC: <netdev@vger.kernel.org>, <leon@kernel.org>, <jiri@resnulli.us>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>
References: <20230804142654.9729-1-marcin.szycik@linux.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230804142654.9729-1-marcin.szycik@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:303:2a::27) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|SJ2PR11MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a92691-43d0-4234-416e-08db98389aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNwC6gn76DlN6D0hOAuMovI19EI7jyIcaUgSTAQ/rTZaR91qwr/HuP7PPC35RTfGNfGqQjlh8q/jrs2BGmInGXJZujcgKLBj1g44xqMetVFzkcSefb+JKAzZbYQKt7WA4uQb6MV2JyncY3QBCDzVezkmzSWocJ0+U9oKiyqJX7ucRx5RIbSrIMfHscPwT6b4eA7s3bWUj76L+9NxvGPRbgsyUnj5Dbojkdx2cAofZQYGzkhdvzKEKAPqD88btjU39O8p5WwztQB3439625udJEJAw9dfNv9jWjxmGxb8/sK6RJInYuAMXPRb0B6OxSakuCTHQ+cAzxiBayoWO2Gvv8ajz1/SD9pYLyXAOeSWPHth3T2pH3Ol4Y9MseVW2zwLgDE+lpyORHUYuigcqgOpH7PHEvbIKA71nRG20ZdLWPythCYmYkqZV0HC9JhKdv/eMtK78Ljd/C5YytOA6LGqNQ6pHnBUPIdC+NjSkJ+msbiaW26eWvqJfxNoxxybRkQ996npjdao5WuWBJeimtEugIoDJWPGN1TaK7cMgVLh3rkUfggLKT4wX2bHFGSyqG9uA8A4VbRMT/PP5tp3hQ9yEClMSvGgYcFQBFIWSgEadK9QM1koILUYHuVmhfap3zYoOdipJcZQwV0kLw1a8cwPeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(366004)(376002)(186006)(1800799003)(451199021)(31686004)(82960400001)(38100700002)(5660300002)(83380400001)(36756003)(6512007)(2906002)(4326008)(6636002)(31696002)(86362001)(4744005)(2616005)(66476007)(41300700001)(66556008)(8676002)(6666004)(8936002)(316002)(53546011)(6506007)(66946007)(26005)(6486002)(478600001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpMQkQrM2tpVU9EcDRBcVdheVMyZXZvVFo4alZWMHhuRUhzSjRsQURmalhq?=
 =?utf-8?B?UFVGZVBhNEJScTU5QUdJbmJhUDgyL1N6VGhtK3VsYnNsVXJZa3hXeTdlWVlF?=
 =?utf-8?B?ZWZ4UnMyWkh5N3hjRmpPZFBTKy9CbVRBRFFOek1mc1N5RDM4dFFKQVZLcmpz?=
 =?utf-8?B?dFl0T3N0SzdkSkhmU2VCZDBNVjg2bUd4L1BXc1BwWXBZSjlWdXVNeCtlbm40?=
 =?utf-8?B?NGN2NS9JeTZEM2h1ck11THRoVDMweE9YSHM5S3FxQWEvNzFWVUJySWNDeDFD?=
 =?utf-8?B?ZElpUjRnazJ3alJadmRFK2JLZ0I2MklHNXREUHBodjNkRUI3SHArQUtXWGo2?=
 =?utf-8?B?dWw5bTh3aldrenRBUXlQWVFsZ216MHBKWmw1N2tJcGw0UlgyWWwwWXhBY1Vn?=
 =?utf-8?B?TmxBbW42TGpLeHEzVXZnN1JuV1BNVE55QUdXSmJBREo1OHBRL0cvTS8vdkhx?=
 =?utf-8?B?Y0FRcXZ6a0ZwdWsyMG83dWk4L3BadGl4eWgvdkZTTm1qUTdzeEVRWnkzQW5h?=
 =?utf-8?B?akZhcnFsdytqMUpzWFVjVkhzSVRwSGpxaEpkaGNJQnlpWWQxeDlSaTgySEhD?=
 =?utf-8?B?K1U3M2lkcHRVL0RmcklCb1NvODE3NnducWxyMFQ3cVlZbWZ5TG1xSG1hOEla?=
 =?utf-8?B?YjdZSnlZZmRtbkRtUDljZitnYnpKanpLbkRzNUFkV1Q1UXJGZVYydW41UUQv?=
 =?utf-8?B?ekxiam43UzFsdXErcThCY0hNM0RJZWNSQXFmcXlTbEY2V3JLMjI2TEJFQUt1?=
 =?utf-8?B?L294UXg3UDdaQjAwcEZkQTdDVGlWUVhiZExNY0ZocU01V291MlNNN2dzM3Vo?=
 =?utf-8?B?eHVzaHoyU1ZnZTJVb3ZJc2FYT2FwdHRoL0Ztd2t4NndQSnlkOTM1YXpqL214?=
 =?utf-8?B?YzZBak9LOS9YRFdreXUwVkZSQjA1WkhrZ2NmZStlWGRwQTV1REFyak1NL2xX?=
 =?utf-8?B?RGVZeXl2WHhkWkdQNzUrSkd5RHVodlhPZytXMm9MVnpSZEpkMGFTN0tGRGd2?=
 =?utf-8?B?OXNIenhRWmsyaFVsRVZhaVdoUjFZSmNxVmxpR2JVTXV0TTZPaXBZUmUzcVdZ?=
 =?utf-8?B?L0JQUTNwSGYyWU5EUUlzL0VXcGVoRGlaZllXeW84THluekJwV05zZkVWNFBz?=
 =?utf-8?B?SFR5Z2xzcCtTRDBoOGc2dDNhUE5WYkJodVRhSHFpZjNKZ2xxZFhpR2VyR0lw?=
 =?utf-8?B?TlJkSUloeERhUmVnUkFOaGYrSHlXdk9FZWZwN2dUa01MVlY0WkFVb1huUnBW?=
 =?utf-8?B?QndYNVZidjNIQWhjRHI0R2pwN3lZc0JvYkJZWHhoV3l6d3FreEwwdTJDazZ5?=
 =?utf-8?B?MHdVRU9pcHZuWHdwYXhYN0xHRmF1V01aa2dTRnpNdHlvSHRubFBxNC9ydkhS?=
 =?utf-8?B?emJIc3dmSWhCVG54TGE1dHE3dTcwY1JHekYzeXFxdXZ2WWpyNW5uWUVZWXBk?=
 =?utf-8?B?dUpOMThqYTVyc3dQSnRwQk90VENSbjFid0VoTCtlS0wyVUZObkFiWUlleCsx?=
 =?utf-8?B?MjhqK3N4ME5Fc2Y0ZldVVWNoTFZzOS9heXM4SFVDNE96UGhaRitva3NxVTlG?=
 =?utf-8?B?SlVHc2hsa1pPTHVNU3J6Z0MwTVRzU0xsTWhLWmJPWXhldGdncE96ZDVWdjc5?=
 =?utf-8?B?enIxaWRreHJwVGtEbjdONjd5VmV5cncxL2hLYjNQNzdWSTBCUEp0U0hwWHBZ?=
 =?utf-8?B?bkRKZFlOR2dtakJGc2JGWWt2QkNFS2hKS3VqNGZRZDFxRlA2dnRTOFhtUmhy?=
 =?utf-8?B?V1A2Rlp3RXROMlRuUmxqejNLRXYwUGhVWFROWnNib2Z6YU4yTW1rNCtsUVdZ?=
 =?utf-8?B?Y05lanBLL1BTRHcwT0pmV3p5TzV0ZXlYYjBiRFYwZEtSMXA4eWZLS25rTm9m?=
 =?utf-8?B?ZWdzTHU0M2lQQURLeTY2K2w1Y2xhMHRlWUlOeGhXMERhWmd6L1dDa29VdlJO?=
 =?utf-8?B?RVNLWUMrTStsOTNnZzY2dzl2N0FtSDZWNzF2QjNkVWVLeWFkVjZLQVFPdUll?=
 =?utf-8?B?dXpia0d3Tkp1NjBTR29HZ0JlNE4xMjZZZFFUNU43RXBTelBQNHFJcFpOSG1T?=
 =?utf-8?B?bEZXQ1F2bXBIOTJZc0htL2p2dlpCbDBLdXFQTHFqTWsrWkhPVDNLWHFjLzZy?=
 =?utf-8?B?UlVXdU9WYmNMYWt2UHJYMmxxdVVaZEhlZ3Jxb3dnR3hVdlRIUEVNZU5DeVBZ?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a92691-43d0-4234-416e-08db98389aec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:55:08.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYYO7JWTVKG79Hc7WJBIFQQPTVRTKQqdeEXFG8yPbj9DN7S03RTPBqzDP9hy137NuI5xPNGziWokNwXEYhoQ36W+hvOoG9r4No45QHjQWEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/2023 7:26 AM, Marcin Szycik wrote:
> ADQ and switchdev are not supported simultaneously. Enabling both at the
> same time can result in nullptr dereference.
> 
> To prevent this, check if ADQ is active when changing devlink mode to
> switchdev mode, and check if switchdev is active when enabling ADQ.
> 
> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

...

> @@ -8834,6 +8834,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>   			}
>   		}
>   
> +		if (ice_is_eswitch_mode_switchdev(pf)) {
> +			netdev_err(netdev, "TC MQPRIO offload not supported, switchdev is enabled\n");
> +			err = -EOPNOTSUPP;
> +			goto adev_unlock;

Does this need to be checked under adev locks?

> +		}
> +
>   		/* setup traffic classifier for receive side */
>   		mutex_lock(&pf->tc_mutex);
>   		err = ice_setup_tc_mqprio_qdisc(netdev, type_data);

