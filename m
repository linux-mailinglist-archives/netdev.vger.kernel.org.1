Return-Path: <netdev+bounces-21384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BE763757
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706441C212DB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A62C15B;
	Wed, 26 Jul 2023 13:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A1CA71
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:17:42 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E622129
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690377459; x=1721913459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tdwInxS3FZyBEO9JgO2qkxjwqQxm9RYaaeMJ895hjmw=;
  b=LIJfvhHdzzfztH/1EXc1CK5Sj0iser0RM41XNCC0V1O/Dr2tMju4y78U
   rn8OABFnZjjWW5s6wXV8/RSt3hh2PBpBsS/wkuLLe06R8jo0JztY38r+9
   i24+ZCu/xQwdA0SFIoM++ISfpqjcfnQFqwjYRlIAELRvu5HgyzQiP8tNq
   GDs+g6Vy8L3wXEobA6qpnNR36eVm+wRFCtyiZNZz1fdhlGZTRN6A55hAD
   UCTc4jEGUxCqDf25u/LoRMo/qCieKmh1kVsu5bc2ueXAZgQ1CGudhAOcz
   XgP3+jvAfFVyfik3S+wpxcg+LZpBo2J+Hnm02ZTSs5qWviL5AirmANTfM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371623944"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371623944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 06:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="791861189"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="791861189"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 06:17:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 06:17:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 06:17:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 06:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqQQ8dPaDt1jrA/ZOuEwhsZ1qZ3qDg2ecvG0YKVgMj3K4sauXXuSeKrr/sDRLhgtlvmN6XoCHgK22jixO/wl6FxrIdSZQ0zeGbxrTKyCCpuF0qcepBhf7q/EG0j39udwxfCEzcfZH1ZMYebeEC0QafehSEoIOXVAECGgoY/aLbFjobgQPypecona9BQ68Pofhix7i2G3WTcAJRA2AbfdXOwKdTPj8V01HzDvjVG35HGahuSWSmY+bFm0DGLDyqq8W4MHr6PNgUpSQNJTLuD61kq8okFAaJHzVGVwFUa50Jigas7ySoBdVuFsjzy4FKMgF69cbiIO75ShfsCITDOt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAOJQWLlnC53yJUYc2/o2a7yp8wk+BW5CVt1jRzEU/s=;
 b=RO7/9e1b+Z54FqhSDwTwC53lvO7iuArw5n3p1G3GVaaJINGxeQWbi+111GKmifws6mJSuQgLUxHgX00nTVFIxBINLU2aCK+foZoX5GhNzjAQkAWsQCXbfFSibnukXRwrSg9GuI2+z2FV+z1H6BUZ9409AgsUggIfyz4ftsDY6PGJKmERQrsA0XDzaI9vMoHyx5s0EiSpWk3SP/KCl/TbMxedzcln/4oCQa5HkCmMkEGo2WjkKtOyzj0GKjoLe9Asu016TzYdmAqI+E2UkturwRPsAAC55mkdm9MnMvoeL4QBZbyslw6IdUMEGKR/EGT2npZpVpAA4/ewGjfrNrYHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 13:17:35 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 13:17:35 +0000
Message-ID: <d5ffe1d3-0378-eaaf-c77f-a1f8a2875826@intel.com>
Date: Wed, 26 Jul 2023 15:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH iwl-next v3 2/6] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Content-Language: en-US
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<wojciech.drewek@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <jiri@resnulli.us>,
	<pabeni@redhat.com>, <jesse.brandeburg@intel.com>,
	<simon.horman@corigine.com>, <idosch@nvidia.com>
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-3-marcin.szycik@linux.intel.com>
 <ZLqZRFa1VOHHWCqX@smile.fi.intel.com>
 <5775952b-943a-f8ad-55a1-c4d0fd08475f@intel.com>
 <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAHp75VcFse1_gijfhDkyxhBFtd1d-o5_4RO2j2urSXJ_HuZzyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0498.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::28) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3538bbae-ed10-4f0c-27a4-08db8ddaad05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddOAmY66xogMYPrW/z8auBhM++uuVWlaNF8f+0MWUFoy6Porm/ZTtS0XY/Drb/zveKJ4AvFQEdDJMbKlQTCBWN0hMLXNt5cmrEIcy469AzI5+YiFskebdSr4iZupMJZOemHep5oZgYgphAtikxT08fO5KJDOozxjcUI/n9d6io5LdsVjBaSwnuPz7YXnnPnL6nT896cE9h9a1mPWF8IX9DgduCD/v4hEY+iMzksQCIRtG0wAH13+hxvOnh8hd9MWiy6BrErCo7+NjPAiNjRKmyo09ER1/RliodpE9B1JOd0XCmIZisQT9SUyLgDp0CQ8Mq53U+deCJsNXSp3OAC+2gxwucli8kQeMfdM2VibfFAszz8FytsQ2VK94wioHKvvMs8SFARLa7mRi98tp5WtoRBVWNQVc2gTy49De0JbHmMymP3O+F8UA9Z1SzFm2Hh5UDTwsEuGUyzI9VGFPqssuo0V3YCb/VMFA73rrI9fEzYKUEaNoGTGM+isiVyhmtskMFPDQgJ3oBAdqUphFin6YzHrS+kRFQozCTRZCMkXVZrMHJ5vpE9WvflcAkKMJO53kNqD4rn4OeC1Jbf4TWAH/r02oMPv1Xb7SP7U5MqxpHs2DE8pOhRI2AlFA5ajLV2PtpbViTM8FfPx4Wf/2OdFrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(31686004)(86362001)(82960400001)(31696002)(38100700002)(6512007)(4326008)(478600001)(41300700001)(66946007)(316002)(66476007)(5660300002)(7416002)(54906003)(6486002)(8676002)(8936002)(26005)(6666004)(2906002)(6916009)(6506007)(186003)(66556008)(53546011)(83380400001)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzR3eDBUYThMSkwrckgzRld4bjErNVI1L0lZODJ6TVladngzelJaR1ZXTHNG?=
 =?utf-8?B?VEFwSDcwKzRkQkVadzFqQnhsbjQzejhUSUdpakQ0RVVpQ0xZNyt2K0RLUmYx?=
 =?utf-8?B?NzBFTisxNm5pbmJNRGxGWGdDKzVja1Y5bm5Teklpb3JVZVZVdTE2OVBpNlV2?=
 =?utf-8?B?ZmQ1NC84UGh4TStzRDRMOWlXZ25UdmNSRjdRUzh2Kyt1Vkg0blIrbTJULytt?=
 =?utf-8?B?SVQwNSswU1p3amM5WmZ0ZjVyN01KMHA3OWh3bFJ5QjRSdm9qN2dZUHZOYWlQ?=
 =?utf-8?B?Q2wvWkRETU9tSUJJSThqdE5tRFptSTBOV0xXWGVSZlI4U0JlSU9wdDk1SFlh?=
 =?utf-8?B?Unpyb3dUUU92azh5NTFmVzE2czEzN3BXaHJadnhSZWZMd2ZRaTcycE5HdGZq?=
 =?utf-8?B?MGI3MTZuVE1QWVNpK2gzL2dReFJScGRYUTEydHZtNlgyL09HUXdEWUx6WEZJ?=
 =?utf-8?B?dDk5VUNqNmRzSUFMWElCL0d5dUJ5c1Bic01yQkc0TjVOYXVadzBVRWNsYVFD?=
 =?utf-8?B?cndjdE9ob0tVbVFkYTNYT0d2SFd4UFJsUGp6YnVsUzV6cUM0R2h3UWNnb041?=
 =?utf-8?B?eGtGb2JkSzRiZ3g0Y3gxc0ZHODBXVlBzWnV6M1VBTHV0ZTZkL2FWeDRKZXVv?=
 =?utf-8?B?dHdxZXB3VHVITlExUVo5S3RJNEtRdFByTlB2cVBCbG1IZ29GdzlHeWNKY0FH?=
 =?utf-8?B?TVJROU0vUHYrdTBkNGhRSi9HVzNMSW0xVFRWUDZobk5reTlhOE1maUd4N1Zk?=
 =?utf-8?B?d1JYU2RkOHUzVmZzd01qTVZ6cWY2MkhPSzcweUVsc0dnQzhKKy9YZ0xXcEln?=
 =?utf-8?B?VWZEQTlBVXdUTWc2UldaUTd0U21UaDU3bElzbTBJN3BLYlFLZGZoRzRtelUw?=
 =?utf-8?B?c1JuRGgvQjJBcmloRCtLUWR3cFFRL3JYZmZzdkREU3FoaDBFSFo1dWZNaEF1?=
 =?utf-8?B?RHh0a0RnaDdScExIZlAzYU5mNlZvbHRYZEZGdUo4UlZxOXhVZEgzakVEZHY3?=
 =?utf-8?B?dzU5UUZaVzNCQi9kU0JjZXdVZ3BZampxRmRMQmhGNmNXUDlyaHppOE9yQS91?=
 =?utf-8?B?ZlFVL2xCUUJuOStVWllqZldGYUNIYk44RXNkbStQUVJZNEhYM0ZRTjNlaTlM?=
 =?utf-8?B?S3IrOTVBa0hwTXZTMjY3TSt6a0ZoM3lVSXpEK2JINHNZczMwK284bGJiM3l0?=
 =?utf-8?B?cmNYRGV2cFpDaFFvRkdFSFN2eGZWWjh2UlRKK3VjNWRUMWJNZkZzcG4xaVJF?=
 =?utf-8?B?SGxzWDFqdmFwalExN2RENGUwRE9Talo1cDFMbDZUUHdSbi9Zc2RLcmdIZGRD?=
 =?utf-8?B?QkR4c0IwT3hPaG9LMUVoZERjVXdvM1V2b1U5bCs4dlFZdmYxek52aFhhaDVM?=
 =?utf-8?B?emZkZ2hZK3Z2L28ydHA3SkhZN09oSTFVcVlBejlCV2FKMHBhQWhqa0tJNEMw?=
 =?utf-8?B?OG8vdGlDc243VGp2K3QvOU0yazB2Mk9uNEJZTjhmUXU1QTg5SC9uTzRtVGdZ?=
 =?utf-8?B?QnNRK0hDcVFwOG1YUW5xZ2dUQnV0UGNMTGFZUU1pUlFqU2JKODRzcUpFM1Fv?=
 =?utf-8?B?Z0JhQzAvV2l2RDE3UTdHdTlKOERRQUdpK3YrdmpCQmt0TERMRlhDRDZ6eUlt?=
 =?utf-8?B?WjFxcmdRN3FFb2F4cW1EM1NwQitKOTFTUDlBU0plVVFEcmVrbzBrcW1QTE0y?=
 =?utf-8?B?eHhYbDRNZTVRdUo1VWFQalFzdWJvRzVQZVp4aTBjNFE5SWs5QVlGSTRtQjNO?=
 =?utf-8?B?aythMHhRSHMwZFRPaEVYQ0JBUGpPS2cwb1Jnbkp5b3hnTHd0Q3ZrbUdLNlVm?=
 =?utf-8?B?ZzVyL0tPYWRuTlVWdW1iekx5Zy9ybkxoc08zbXNGYmphSnVLMXphaUxXVVho?=
 =?utf-8?B?NG5MSlU2Ny9VMzJHQnN5bnRFVzJNbmJZSlNNRTBYd0g5dnFFLzJDUThTOEIy?=
 =?utf-8?B?V0VOMGM2bTRCTDJXOVorUm9vd1ZwZHVnMVhDQXRHaWdvLzYwa1hDOEkzSjJt?=
 =?utf-8?B?Szc3OFdRd2U4WWxlRlBRZ2NFbXV1dWVWeUd3UFF3c1RRbytkTGlkaXlxWEtL?=
 =?utf-8?B?U1hGdVV4bWZBNlJyK0pKSHJVb3FvdFNKa0J0TUhiRzY4NFlwSVN5QUxuNkNj?=
 =?utf-8?B?TlBPMjRFZ0huYTAyTnV2ZVVkOUdpbjcyb0dlQ2Z6TGlBN3U4TnZKQlNvK3R0?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3538bbae-ed10-4f0c-27a4-08db8ddaad05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:17:35.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R32duqn/iOpMxF3L1qw9Eu0n7+9PBZJYs7JxIKx6VAfdXRb+9ekW2nUGyxhJmF/cKkEMFkqorO8j53kRaWUkr/pRDGGNZVjKZsRg5A4nfAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Jul 2023 15:01:44 +0300

> On Wed, Jul 26, 2023 at 2:11 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>> From: Andy Shevchenko <andy@kernel.org>, Yury Norov <yury.norov@gmail.com>
>> Date: Fri, 21 Jul 2023 17:42:12 +0300
>>
>>> +Cc: Yury on bitmap assignments.
>>
>> I told Marcin to add you to Cc when sending, but forgot Yury, my
>> apologies =\
>>
>>>
>>> (Yury, JFYI,
>>>  if you need the whole series, take message ID as $MSG_ID of this email
>>>  and execute
>>>
>>>    `b4 mbox $MSG_ID`
>>>
>>>  to retrieve it)
>>>
>>> On Fri, Jul 21, 2023 at 09:15:28AM +0200, Marcin Szycik wrote:
>>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> ...
> 
>>>> and replace all TUNNEL_* occurencies to
> 
> occurrences
> 
> ...
> 
>>>> otherwise there will be too much conversions
> 
> too many
> (countable)

Ooof :z

> 
> ...
> 
>>>> +static inline void ip_tunnel_flags_from_be16(unsigned long *dst, __be16 flags)
>>>> +{
>>>> +    bitmap_zero(dst, __IP_TUNNEL_FLAG_NUM);
>>>
>>>> +    *dst = be16_to_cpu(flags);
>>>
>>> Oh, This is not good. What you need is something like bitmap_set_value16() in
>>> analogue with bitmap_set_value8().
>>
>> But I don't need `start`, those flag will always be in the first word
>> and I don't need to replace only some range, but to clear everything and
>> then set only the flags which are set in that __be16.
>> Why shouldn't this work?
> 
> I'm not saying it should or shouldn't (actually you need to prove that
> with some test cases added). What I'm saying is that this code is a

Good idea BTW!

> hack because of a layering violation. We do not dereference bitmaps
> with direct access. Even in your code you have bitmap_zero() followed
> by this hack. Why do you call that bitmap_zero() in the first place if
> you are so sure everything will be okay? So either you stick with

Because the bitmap can be longer than one long, but with that direct
deference I only rewrite the first one.

But I admit it's a hack (wasn't hiding that). Just thought this one is
"semi-internal" and it would be okayish to have it... I was wrong :D
What I'm thinking of now is:

	bitmap_zero() // make sure the whole bitmap is cleared
	bitmap_set_value16() // with `start` == 0

With adding bitmap_set_value16() in a separate commit obviously.
That combo shouldn't be too hard for the compiler to optimize into
a couple writes I hope.

> bitops / bitmap APIs or drop all of them and use POD types and bit
> wise ops.
> 
> ...
> 
>>>> +    ret = cpu_to_be16(*flags & U16_MAX);
> 
> Same as above.
> 
> ...
> 
>>>> +    __set_bit(IP_TUNNEL_KEY_BIT, info->key.tun_flags);
>>>> +    __set_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
>>>> +    __set_bit(IP_TUNNEL_NOCACHE_BIT, info->key.tun_flags);
>>>>      if (flags & BPF_F_DONT_FRAGMENT)
>>>> -            info->key.tun_flags |= TUNNEL_DONT_FRAGMENT;
>>>> +            __set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, info->key.tun_flags);
>>>>      if (flags & BPF_F_ZERO_CSUM_TX)
>>>> -            info->key.tun_flags &= ~TUNNEL_CSUM;
>>>> +            __clear_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
>>>
>>> Instead of set/clear, use assign, i.e. __asign_bit().
>>
>> Just to make it clear, you mean
>>
>>         __assign_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags,
>>                      flags & BPF_F_ZERO_CSUM_TX);
>>
>> right?
> 
> Yes.
> 
> 

Thanks,
Olek

