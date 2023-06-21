Return-Path: <netdev+bounces-12800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF9738FB9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA5E281647
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610ED19E6B;
	Wed, 21 Jun 2023 19:13:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F152595
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:13:15 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2F19AF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687374793; x=1718910793;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uHXKsHPojXTxBDGqydq3yGfu4GPkidv0qeerQyUVkA0=;
  b=l2o/hjl4HzmawmBeUa0v0sizgFBSAnfjLHUB4dDeEXKurMDg80w/OBHH
   rergoqGfai3YI/ZlMB21afFxtZRwTXG83Pe/P2+CvuJ3GwtF5oIoCSzzM
   0ti3084nkQYRNlBI3/yggLuTP1SMBRGsR+WFsI7TngUGkaU4+P08bTNGb
   840Z8v+vQ+0qC8GVwR06QVxUE3yu1aZ+eEq5EpJF02qpp5vPzxXOCsxdj
   J+YPoU1rUzQHpRgiOu0gZ1GRCcJj3ZhpIFxjsPNgsYdTJ650656mSbSUc
   okqV+Co7K86ZyTMRyoGxRAOsAqmtG1UJUzcLU+J35FEMXjNbpvMX2EL+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="339893372"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="339893372"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 12:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="691961599"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="691961599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 21 Jun 2023 12:13:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 12:13:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 12:13:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 12:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0DkHRCTMxP1gbAUbpgzxUnNUlDonkr1GAwvOyXHGnPh2pxXz4s7Mx+xUze/761Y28eseoIs3f0yyuPLovNth2Yo6ouJToG7Vj1SvwOvxxDRfduHLk1vpFuFGgSDp24usRVOPXOdAxHFG02KHMmAlH6D1yE/f3Ezqn0fG+rIR9jRDnErZbUcTCCBkyqkyu1K5xp+cMwGnGpAbbp7XnJWn9q5fKNcKVuuK5nvOt9v+JFOMm8H1R2ZHcgnmIP+Bvfsaufq6XHTr42KbgDyiOxDWnxZ1q7DUXJ69AgzX+JkwoAhwiUGXko7E9dQ+UJm16Zyd9nXEFS10LfNy3a1wQzrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt7Tl1drrlwE4xiTV0bjx4/KWPXC7Yg4b3dbU3BrYK0=;
 b=AohVy9XDBIOCsWkYVniKktq/WfYxaAbVOtTqO+IClqRGKVS1E2xTvgb04NJKx+AEp5QT+cHpGsGQFbyLMXSZDTw6ScgsqYZeIMmiX6x40X7ywhZU99XP90R2W7GEf2wcVxoybL04XaeG4/l/n+s9suO0jxUKl2zxJt6I8g3GwA2o4ibr0Xqz3Unns2BMTWkYA3zBmm7L8XG20SurTm4tA4X1jbZTPoRJmfhCeQ7hEJnNCrGcgq6Byc5NqEzmJSdT/LF7IwosbuLqFkRUHmZSzHG2vvuSCwwDMIQEWzYVhWGCBpvfbVlIM52EdK5mUBxE9n70QlT/48muGKGJmMvvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 19:13:10 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::ab9d:1251:6349:37ce%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 19:13:10 +0000
Message-ID: <1bbbf0ca-4f32-ee62-5d49-b53a07e62055@intel.com>
Date: Wed, 21 Jun 2023 12:13:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Subject: Re: [PATCH net-next v3 00/15][pull request] Introduce Intel IDPF
 driver
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>
References: <20230616231341.2885622-1-anthony.l.nguyen@intel.com>
 <20230616235651.58b9519c@kernel.org>
Content-Language: en-US
In-Reply-To: <20230616235651.58b9519c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: f75b7f9b-38f5-46cc-2975-08db728b8d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/heFSK4S2IIuxJwG37A8J4MiKNOj26CTv7JpN1GyrbA4UdlrUmg7mHqA1Dwmj4eXI3Op8sEU8iJI08FIQrdlUtRCCjPh6rGEW3O7Obz2hKdHop6aDugl6z8DK8h5nBUXm1fpjJTfPvkQkztonj4FT0JnA4hmQe+Th057BepuM27u1UgY2FA+QMqpnmATt5m5k02apiPH3iXVIOsHjHRLWLObq9LVF3lvYV4zODbkSE72hMSTBzjnFe53BG4nRE3T8uJmmB1vcpyUkw6QBQmE1C13QCjzZTykewzH89VG9J5ARZGf/MijsGsD9urfklZ6m0GSeZUQeuzmjyFbVrLHGQpZg11AQFiCrbIw8/SWPOeDJXWlzhYDB5MaPxsPoMn+qFBR6ywOJh3kbE5/BvFmNI1P5porlHVfxaXOf1k2dhkVALU7lSDiLyMs+l2qT6e6vv++0G8cW72GHI3Ob6OGqBdh+JbLVKSEGZuX9NWDFHSypbbuWUyGZVqpbbAVYkuRVHhuea9DoQTsT4VqQoP6s99p9BW8Ep5ushnTXMA2AZrVeYYjDK093QVpVKfV/cP4lm+P18ik6k8UTETrPGUz0FakdzW54uY1Hr1DWRHbvQIGD3xuHi5oVfvvz0plT7cVu6Idlfeuej9juXKU3+TmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(6666004)(478600001)(6636002)(4326008)(110136005)(6512007)(26005)(186003)(6506007)(53546011)(6486002)(2906002)(36756003)(8676002)(66946007)(41300700001)(8936002)(66476007)(316002)(5660300002)(31696002)(7416002)(66556008)(86362001)(38100700002)(83380400001)(31686004)(82960400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUk3WGRMbWE1eGFtMmRva3ZuenlERTZYeTVMUVJSU3BhcHZ0VDh6a2pVSDBV?=
 =?utf-8?B?aTZ0UThhcjZ2MmlDVmErcksrWGFDN3p0THFyU3RhS1RWeHdSWXFzVFZueSts?=
 =?utf-8?B?RE5NbXNlcjV4N0ltc2RSeWpud284cWtxclI2WHJMMXljNFY1c09ZQVJJbERh?=
 =?utf-8?B?NFZDbk5RemtNOW9rV2w3V2ZPanZGSG9IZi9PSlFUSG40S2tMYlcxRm50dnkw?=
 =?utf-8?B?eC91R3pNZzRkc09SdEFES2dCUnFTRCtKQmNCdEptRDU5WllwanV6R25RTVB1?=
 =?utf-8?B?ZGF4VWE5SlhqUXFpYzFnZzdWbzRlZVRJREVodzF1TVp1NnZRZTNiaEJJODk4?=
 =?utf-8?B?bTBac3pMbGRhNXlZSmNCM0wyR1NndmRIZk5rcGJWblZKcCtPNnBMTFNLZmNX?=
 =?utf-8?B?djRhaXpJZ3gyYjJzRWNzbDhVSDQ2eVZicXp4cllnSlRpMnA5cE9oVVRaaTBP?=
 =?utf-8?B?djdrUUF1RlZUdlVraVhLV2t4REwzay81cFAvSFNSK1RLZnlNb0Vhb2sxRjhk?=
 =?utf-8?B?bG5NWnZIVStadHhwVm9kTVlmRzBBZTh0T1dKVVF6WUpoL09FajdhbVMxWnlo?=
 =?utf-8?B?Q0g5dUw2a0RXZFVsMVBzdlVLd25NbXY2bm9jYU9rVmVxak9sbzZBbVlheWV5?=
 =?utf-8?B?RHY5REpJcVgwRzBwOEk0bFIybW9aYWozdHJhTTFQQ2dtL2wyZ3lQY01PTlRI?=
 =?utf-8?B?RVR4c0V2MlZDYWZaUFZzbi9pVmQ0T3BNSVo1Y2RWZEJ6S3BtSEI0b2grbXRn?=
 =?utf-8?B?cFdmUGZEUE9QL2tlam00Mi93YmNtU0UxZ3JXRG9Na1FpS3BaQldjZWZGb016?=
 =?utf-8?B?eVpkNGpjckpHcitjSzJXeTJuTTB6ck8wWS9WOUZHKzdjWm41VUwxaVNuNlkz?=
 =?utf-8?B?SFJHU05LbmF6QUpucHJhN2hHeW9OZStJZ0czS3BhY1lNSXI2Zm55MGVPODZq?=
 =?utf-8?B?bksxVGhyUW9TVVo3dkQxaXZXZ2phT3NlTWpUNnZNbjQ2T2hpUGNjRExoVjc4?=
 =?utf-8?B?SnV4L3dKcE93ckN6MTdleGNBV1RiWHZvQ0xVV214cHZqTVgzc2lIZy9BZU1J?=
 =?utf-8?B?WkpWT3pTei9VVzdmNTVPVTVoRDlyQ0xydTFuZk1waTRta2x3cVVhQnZqVFRN?=
 =?utf-8?B?RVoyRVRpdVg4UVVSZ0g0OU52UGRpUFpZSWgwNXRrZVFaV3JlQ0E4NW9EVkFM?=
 =?utf-8?B?US9Jd1ZpaWV5cWxmODlFbVdPQU1HU2h5dTY4MzVuRTFYd1NJTmduM1o1N1Vt?=
 =?utf-8?B?QjhCclhnQ3ZGWkV2TWVDdnVNR1NaNEJEck1EQ29iUWRCb0xyVWFUV2Y2eWpm?=
 =?utf-8?B?bm42NzRVUHRScDhXZ1FBNkg4MVd5dHVZTjJNOWorL0E0OXpwSmVwOElRekM0?=
 =?utf-8?B?SmlDTzAya0Z6QzFmdU5sMlhmNmpDbzl2NkhHNC94eDkwRzJOeEp5OHRHQnlJ?=
 =?utf-8?B?OHIwRjJCa3pnZGxaRUg5YU9qT0tSTmJzVXZxYUpWMUU0ZDByZEluRDVMTlNP?=
 =?utf-8?B?RmhtQnFrMUFidlFpSlMxUFZEMU5aQk1tMklaMms4SjYrUlZIYVo5RklFMnB1?=
 =?utf-8?B?d2N2d2IzS2RUNzZJdjBQT0hsczZBYnk2dGJOZmdaQjBjZDFubG1xOXpRVTVX?=
 =?utf-8?B?WXNNcDVDTjZrUWVaK2JITDVsR3NWYmpQSzQ1TENTaU9WNkNxb3p4SVFwSVVQ?=
 =?utf-8?B?RE1rbEl5cml0ZElPSWo3b2Q2cGtzMHZVQ3pvMDhnNGl5RXdDZzFid2hnbEJk?=
 =?utf-8?B?UDYzSUZscElDek5vL3Z2T2lyMmJUQngvRTJOQUYyUEFyZzdFbEpvamx2cDRI?=
 =?utf-8?B?ODJwVlNNd0hVQ1hCby83SHdNaG5HR1c3T281eEdtektIeGJwWS9nWEozTC8z?=
 =?utf-8?B?YXBUNjZacCt6QTRQbUtFZ0tDSmJuMndVTGc2MFE0bVU4Yk4xc0FTSmdtaElJ?=
 =?utf-8?B?V1MxL0NZcWlBL1p1WWJEUmhWWS9FL003SDhrK2YvN3FRTUZkdW9ram5hbnVp?=
 =?utf-8?B?QjM1VSt0bmhuamlscjAvSG1QdkJxejNrNWQyNWw4aUdBWjM1dmhkVWlkMFE4?=
 =?utf-8?B?RkYwL0RRNmJYdmRqbmFLbktZeHU5eCtLdXcyVWY3d0N6clNGcGlHbmtZdFFD?=
 =?utf-8?B?K0F5dnRXY01YTVN0OEI2WW8rd0wxem1zclRoaTdWd2tvUjNuV2w4K21ocUdx?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f75b7f9b-38f5-46cc-2975-08db728b8d18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:13:09.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbT1n7AYye9t3kuG/PKTmIv7yOn5d1P1Usj5fvOOyTD738YYVLWGFH4xV49jMXPwsnoZ3U8rHFgJ77iTiVJxgP1fvnseEyggjONMJA9USHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/16/2023 11:56 PM, Jakub Kicinski wrote:
> On Fri, 16 Jun 2023 16:13:26 -0700 Tony Nguyen wrote:
>> v3:
>> Patch 5:
>>   * instead of void, used 'struct virtchnl2_create_vport' type for
>>     vport_params_recvd and vport_params_reqd and removed the typecasting
>>   * used u16/u32 as needed instead of int for variables which cannot be
>>     negative and updated in all the places whereever applicable
>> Patch 6:
>>   * changed the commit message to "add ptypes and MAC filter support"
>>   * used the sender Signed-off-by as the last tag on all the patches
>>   * removed unnecessary variables 0-init
>>   * instead of fixing the code in this commit, fixed it in the commit
>>     where the change was introduced first
>>   * moved get_type_info struct on to the stack instead of memory alloc
>>   * moved mutex_lock and ptype_info memory alloc outside while loop and
>>     adjusted the return flow
>>   * used 'break' instead of 'continue' in ptype id switch case
> 
> Ah, missed this, busy times.
> Luckily I commented on different patches than the ones that changed.

Thanks for the feedback. Given the timing and type of changes requested 
for the patches, would it be possible to accept this patch series (v3) 
in its current form, as we continue to develop and address all the 
feedback in followup patches?

