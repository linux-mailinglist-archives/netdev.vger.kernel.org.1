Return-Path: <netdev+bounces-13448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E97A73BA25
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C1D281C14
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10619466;
	Fri, 23 Jun 2023 14:28:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C3613F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:28:25 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A99269E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687530503; x=1719066503;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQhWx1KMUOfGcXfGaBz3svak0qLF/qNmDdNoeRf0F/A=;
  b=bOgfmWxKx+Fwc0mqBhm1k/6sS8MxAktWS5DGjFBJB8vo6A33eWfUm3Uq
   QB3wj4KDj32AiLjXM6SjsDHgtIGzmoMD8jfqI2s/RD1AYThPWzodgQyr8
   sZyOirZDAjgf80PNSdThX9VTmniSeJ0d2nDIKLgxU4jRVATHWIN5pe4Fi
   j6h+9jmTTSeHnOwJRCKKvg/rgdojJhMfkdKSX0s/yfdUviz/E8AE0H5VA
   a0lj9zvIHY4sMeute7eZUUiV1J5rxdmxhmgA7h4NVuPGZ9ilMNSXanQpZ
   rM0A2au1LhRrBNJLNPB21vBWbcYl4ekgjPbOdf/r/90atS68c16c26QM1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="358265734"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="358265734"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="859883676"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="859883676"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2023 07:28:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 07:28:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 07:28:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 07:28:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 07:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJKRo7q2GeCrhRDR9PWVSdkGHVTgQksmH8rujVHVmMz1VEMiCmsFhJ+cAcdsH2ABgKbaVpn+PsOTGtIS9YCLKr0FdraARUhNpi7onuGyYpXLFbA/nGIy/Lf9uP0RMGs4xmWQGtgOIoETea7gVkYFURhPl+yxGUQkjeiC9vVK75T/2uG+ejBCbaYRWl9S1JL/bvW5UWeEBC1RLtn2vNFSFZoAwwDTQAacd/UndcThBAItihKlF7X+/LDhzj896XuB0O+421A413UcpwiDXpU5dQZ963lo7VhuKPNWED+IEvwSE6g8ku5A7YWys74RebOSl6IK8ssgelLPO0avQ6T1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcXg3CGdsJnsUNnVWK/VxK4bFh+v/GoCmZ9Mp28NJ00=;
 b=Rjd1iSO1lxdSFnvtb/DicVoUX7awSUAU2kh+AcspV/jGJkhSIl9+0XKdIXK6Fni8azdyFnqJZypEV7KYcwaBkcRLBnMNseUPmhnJ1Ro3w5t8Y7ZMqxEhJ32C7hTGHRGtN/lwz1h+dXDpx1OXbXBuEVFceCR5QpScuS1TglsfY1y0VtD/IE5q+40AYgc78dzUbAa3ywTLGIP65vAc+YltaeyPjpcPEa68apwpcOaqjYr/6owvulaH5X9alFFFWZ0Gqs4MbIBJDjwLEU3bKmgRsVxkVtpee8bvgFzVob0mna0ko4moQDny4W5hTIq57Dfz/2bCjQXXqumauQAB8worlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 14:28:18 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:28:18 +0000
Message-ID: <0e9ae896-82c1-6ddb-c1a0-e233f8a9d7f0@intel.com>
Date: Fri, 23 Jun 2023 16:28:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer> <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
 <ZJV+dUvm4Mg1QNeR@boxer> <4278f944-57fe-6382-132d-728fa8c8f582@intel.com>
 <ZJWdP+RPaF+mYYPM@boxer>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZJWdP+RPaF+mYYPM@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: c22a2977-3137-4ee7-1db9-08db73f6166c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKwIKg/jNGJ2HegnG0h3eEUIBg3MHD+401FyCvP/CluXxpcZ+r5vpiTXlHpnNmJ/MZ7V0eAalB7ZTLwA9WICyLMSAW3O7lJdW6c4cF0eH3omtnWX/hPH9pGRYA5CELfGb7igil/QMPMzEACJz8ueX/qJTLEn/pKsBMku76L8qIk19uVPfEPIMVtq+rUVnZzfgpAJVXuEmVEoymiwmlegwHzNeQ6aNL6ov1sMVjKiwHrrd3iOtMAdKgzQ8yMNliAMRbW/EO3nOJnljRM6Cdl65tIasPk3kLqAITGCvNinnPkuUcT0+GA+BJHtU47Sb7r2BNMQ/k1A7A8BQX8M9KOpRhPFEIxcMjApXI+adJQyXQsYiZs0gZ9XmFsR/QwEBd5cCY7BGytI2d/byhY97Agneu7iQnPlKQVaJfNfz3z1LvnPHUgZK8UReH417+DoywSlsDI3r/oKOQecuYiFHZ+laRnkmZ2lwMIfmuekJWIvRSs0Icmbev+PtULA2kCcFuz4aJfRwewsaancgy2dnJ65IngO4yjka7txPkgv+anyHiK6EO0BvxOJD4w3dzBRJDrt3wtKCq2bPlaTroAQRkHwzcbT+v6wtwHPRRAhOR78TiHFJNLZaxzzKCdlponS6FSQJzNePTurJbyrRGRU3Ema0869rp7gLvzbZl7A0f3yQHE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(6666004)(82960400001)(6512007)(186003)(53546011)(5660300002)(6506007)(66899021)(478600001)(31686004)(26005)(2616005)(2906002)(8936002)(38100700002)(6862004)(41300700001)(6486002)(8676002)(54906003)(66556008)(66476007)(66946007)(37006003)(83380400001)(966005)(316002)(6636002)(36756003)(86362001)(4326008)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHNqblkwQy9QdlUxaVpBV2RLSUp0dW5NRnBXUVkrWlVib3ZRNHpSckVaaXlz?=
 =?utf-8?B?RSsycUJoWFBZNVNYVzk3SlBUU2xkS2NEeUk2RCs5RC9SOGQrbkVjVjU1ZWNt?=
 =?utf-8?B?b1RJVEcyN0RNeGpCZG9OZm1UNGY0cjM4YkhIUXlVWlpPamZETENlR3Nzam83?=
 =?utf-8?B?eVNaT0ZRZFAvZkVleG9qdWQ4dWo4azl0WVZRWHlVb0dCTjhmakVCSExzZ0k1?=
 =?utf-8?B?dVpFbytYNk92Z1loTk5PdjJNYTlyWUpSdUJPa1hMdWRncUVuS21JUWdmWklu?=
 =?utf-8?B?TXdmQmRjYnJsaS8vVjF4UFJNRXpmMmc4SGtDU1AvVG1oN01Na1c2RXFiOE5Q?=
 =?utf-8?B?V05nNGVKRmRvT0xjeVJPejhkZWZiUHc5bk1CVlR6OFZpZkhUc0NPTml1WndF?=
 =?utf-8?B?NXhvZFZkd2ZTbUhSWDl4dGFaUWdJNzM5elRmc1lvc1FLTEhrelFPb0pTKyt1?=
 =?utf-8?B?bGRZVENMaXhaMXprUm40TzBmampvRHlOZ2Z1UWhnV3hNeHU5QVVUSUhJVTR0?=
 =?utf-8?B?UEJkblFLQXpRcEpxbGpQd2dlRTJPSVZ3U29GaURpZlZCSlNOQWFMVkFnOTRO?=
 =?utf-8?B?WkVtQkRKWW1kUEVGMk56OEQvUFUwSER6eFhzM1l0dGVRZ2EyWnAwL01XaklJ?=
 =?utf-8?B?Z3IwNnpIVThWV3p5R0NrdXV2ZC9RWUphNHJaeG05NnpmRUxLY2NadkdOQkJ2?=
 =?utf-8?B?ZEZwbmR1YUR6NGY2QjdFOW1HcVI3aTNrR0NTZk1NNDgwZHMyWE9uQVdxalhR?=
 =?utf-8?B?WGh2ZlM0RnR2dVVQc0l1SExXMEhwMGF4TURLVlVTTTRyWlB4VndncVM4Q3Fv?=
 =?utf-8?B?cS8zdkw1N2NFaWpJSVRpTWVHM3hiL3RkcjRkc3BsUEtsMlhGTVQybWJrbk80?=
 =?utf-8?B?QWdsam8vRERwSDY2ZjJtZGdOMWppMjRhWDV2ZGowaCtVS0hTSkN3YThVQTJy?=
 =?utf-8?B?ZHRCanRqM2RXUXpKbjdNME9Dd2JTSlFpR21MN0dLczlzZnREUTk4K2pJektj?=
 =?utf-8?B?VXgwa0tQbVdoU081ald6SGttUmdNUXgyejd1RnRKeEY2UHVUakNabzNvMWo4?=
 =?utf-8?B?RStBNGdMK2pXYVorN0s0a2NFcTB3Z2ZMMEJWSGh2dkVxWmsrT0xIOHF3bkFS?=
 =?utf-8?B?b0xsckZoYjd4VmUxV3VYdjVDQ2J6QWU3M2xZeG1rdXo4NDZ1K2NwS1UvaWor?=
 =?utf-8?B?SWUvWU9lTlUzU0tNYkszTkZVZTZrVjZYQXBVUEtSUXFNVXVzQkVoMFE0bHdX?=
 =?utf-8?B?R2I4MnF6YUZyS2ltZm9xanFxZlFhNlUzeVJvdzRTT0N1R1R6Ukc0dzFFZmc3?=
 =?utf-8?B?YzNhd3hKcllNNDlqZ2taVDlndVJPeGJ5YnBvUnMvb2YxWDdNVzVSYXEvdmhG?=
 =?utf-8?B?R1ltWDRoMWRWUVhwYVRFT3NrQWZYYUZQMG12Yk5NdmRrY3gxR21RNjNZWDVy?=
 =?utf-8?B?UnRoWUg5T2szb21DdEFYNGNDbDVmZmNVcUpYMHFuM1JnN3hOekI3TExRcjd2?=
 =?utf-8?B?RTFxZlN5dGRXZFRvUFpWc3hMQjZ2M3dFNmdWRmQxOWlaZTdhMTZXN0NiYXB2?=
 =?utf-8?B?QjVQZ2oveFFKZ0dlVHBSS3JQdlhiTkhBRjJSaGpHazduVTgvMjlGV2NiRGpU?=
 =?utf-8?B?R1JDclZ5S1ZRbmY1dXozV3VReWpNc1V3NTlwNlpodlJiVFh2ZHFvWWFPOXhF?=
 =?utf-8?B?OWhGSzNPY0xZbnNoTDUrVTF2eTZlOEpHV1QrNFkvLzdvYUxnSnVFMkFtU2xu?=
 =?utf-8?B?cWJTQlAxaTY4aWRLK1dqMWQ3RjM0YWFPSTA2bS9YMzR2emlTZjdqVzNxdTNx?=
 =?utf-8?B?Y3VxWDVOcWhJeTlOcFNESVFZRllLSTJmU3l4aU0vb3hWUjNvVFlMU3V3SG05?=
 =?utf-8?B?Sjlxd2VDQVFJckd2bWhQYlNxYUV3Y1pHVWJzcDJUMThNSjZ6c08xVm96Vk11?=
 =?utf-8?B?Rk9UdUlESElqYWJrdHFXeWpJa3NuaWsrK2tiSml6L2E4dnNXWDUzbTJOY3Yx?=
 =?utf-8?B?YXRZdFpINzAyOFVVMGp3eU1pbHFNL3RhOEltamZSU0F3d3E2YTY0KzN1dXJt?=
 =?utf-8?B?aFk0YTZ0MmhMeCtpT1ZtTEhYMEtwc0l4NnFOY0xmd0pqRVJNdExGeUVWdGRq?=
 =?utf-8?B?Ty83b20zNmlhblpMdDFQb05jTm52bWdrbHJpemhNVWRrVXJ2UTBDRjhHUWk4?=
 =?utf-8?Q?77KEN5Cxyp+WdGv+VMgU6PU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c22a2977-3137-4ee7-1db9-08db73f6166c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:28:17.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7AdhiQuRUptFj6B3iDbQottSou/AGEJlGOZ8zkhwUGyW+Zpfm1sY2RvBDEzwmihtvupxXXyYC7+orUh6Y6iX6XT2XfkfUL/AP3MQEcQN/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 15:25, Maciej Fijalkowski wrote:
> On Fri, Jun 23, 2023 at 03:21:30PM +0200, Przemek Kitszel wrote:
>> On 6/23/23 13:13, Maciej Fijalkowski wrote:
>>> On Fri, Jun 23, 2023 at 12:44:29PM +0200, Przemek Kitszel wrote:
>>>> On 6/23/23 12:23, Maciej Fijalkowski wrote:
>>>>> On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
>>>>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>>>>
>>>>>> We all know they are redundant.
>>>>>
>>>>> Przemek,
>>>>>
>>>>> Ok, they are redundant, but could you also audit the driver if these devm_
>>>>> allocations could become a plain kzalloc/kfree calls?
>>>>
>>>> Olek was also motivating such audit :)
>>>>
>>>> I have some cases collected with intention to send in bulk for next window,
>>>> list is not exhaustive though.
>>>
>>> When rev-by count tag would be considered too much? I have a mixed
>>> feelings about providing yet another one, however...
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>>>> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>>>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>>>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>>>> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
>>>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>>> ---
>>>>>>     drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
>>>>>>     drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
>>>>>>     drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
>>>>>>     drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
>>>>>>     drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
>>>>>>     drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
>>>>>>     6 files changed, 29 insertions(+), 75 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>>>>>> index eb2dc0983776..6acb40f3c202 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>>>>>> @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
>>>>>>     				devm_kfree(ice_hw_to_dev(hw), lst_itr);
>>>>>>     			}
>>>>>>     		}
>>>>>> -		if (recps[i].root_buf)
>>>>>> -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>>>>>> +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>>>>>>     	}
>>>>>>     	ice_rm_all_sw_replay_rule_info(hw);
>>>>>>     	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
>>>>>> @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
>>>>>>     	}
>>>>>>     out:
>>>>>> -	if (data)
>>>>>> -		devm_kfree(ice_hw_to_dev(hw), data);
>>>>>> +	devm_kfree(ice_hw_to_dev(hw), data);
>>>>>>     	return status;
>>>>>>     }
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>>>> index 385fd88831db..e7d2474c431c 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>>>> @@ -339,8 +339,7 @@ do {									\
>>>>>>     		}							\
>>>>>>     	}								\
>>>>>>     	/* free the buffer info list */					\
>>>>>> -	if ((qi)->ring.cmd_buf)						\
>>>>>> -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
>>>>>> +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
>>>>>>     	/* free DMA head */						\
>>>>>>     	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
>>>>>>     } while (0)
>>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>>> index ef103e47a8dc..85cca572c22a 100644
>>>>>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>>>> @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
>>>>>>     	return NULL;
>>>>>>     }
>>>>>> -/**
>>>>>> - * ice_dealloc_flow_entry - Deallocate flow entry memory
>>>>>> - * @hw: pointer to the HW struct
>>>>>> - * @entry: flow entry to be removed
>>>>>> - */
>>>>>> -static void
>>>>>> -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
>>>>>> -{
>>>>>> -	if (!entry)
>>>>>> -		return;
>>>>>> -
>>>>>> -	if (entry->entry)
>>>
>>> ...would you be able to point me to the chunk of code that actually sets
>>> ice_flow_entry::entry? because from a quick glance I can't seem to find
>>> it.
>>
>> Simon was asking very similar question [1],
>> albeit "where is the *check* for entry not being null?" (not set),
>> and it is just above the default three lines of context provided by git
>> (pasted below for your convenience, [3])
>>
>> To answer, "where it's set?", see ice_flow_add_entry(), [2].
> 
> I was referring to 'entry' member from ice_flow_entry struct. You're
> pointing me to init of whole ice_flow_entry.
> 
> I am trying to say that if ice_flow_entry::entry is never set, then
> probably it could be removed from struct.

You are totally right, I have compile-checked it and that's good idea.
I will post a followup patch for that.

The field itself originates from One Of The our internal demo drivers (:T)

> 
>>
>> [1] https://lore.kernel.org/netdev/ZHb5AIgL5SzBa5FA@corigine.com/
>> [2] https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/net/ethernet/intel/ice/ice_flow.c#L1632
>>
>> --
>>
>> BTW, is there any option to add some of patch generation options (like,
>> context size, anchored lines, etc), that there are my disposal locally, but
>> in a way, that it would not be lost after patch is applied to one tree
>> (Tony's) and then send again (here)?
>> (My assumption is that Tony is (re)generating patches from git (opposed to
>> copy-pasting+decorating of what he has received from me).
>>
>>
>>
>>>
>>>>>> -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
>>>>>> -
>>>>>> -	devm_kfree(ice_hw_to_dev(hw), entry);
>>>>>> -}
>>>>>> -
>>>>>>     /**
>>>>>>      * ice_flow_rem_entry_sync - Remove a flow entry
>>>>>>      * @hw: pointer to the HW struct
>>>>>> @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
>>
>> [3] More context would include following:
>>
>>           if (!entry)
>>                   return -EINVAL;
>>
>>>>>>     	list_del(&entry->l_entry);
>>>>>> -	ice_dealloc_flow_entry(hw, entry);
>>>>>> +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
>>>>>> +	devm_kfree(ice_hw_to_dev(hw), entry);
>>>>>>     	return 0;
>>>>>>     }
>>>>>> @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>>>>>>     out:
>>>>>>     	if (status && e) {
>>>>>> -		if (e->entry)
>>>>>> -			devm_kfree(ice_hw_to_dev(hw), e->entry);
>>>>>> +		devm_kfree(ice_hw_to_dev(hw), e->entry);
>>>>>>     		devm_kfree(ice_hw_to_dev(hw), e);
>>>>>>     	}
>>>
>>> (...)
>>


