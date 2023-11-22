Return-Path: <netdev+bounces-50278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB37F5344
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D83B1F20CA5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893131F947;
	Wed, 22 Nov 2023 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXsQNJpf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E49D49
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 14:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700691561; x=1732227561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YeiWLWJqtteYif+RHe62R+4jkc0d5T6Oq9ffVhLR/28=;
  b=QXsQNJpfMEdKfZ3EBBZOyR+cvFyVuDPJFFsfWh8ehBJoKQyNO8uagSYs
   8pajrVvsaynh3UHi/qXvREQ1iznt3gHpbOf8imIv9+nFLo99Tv8ZxPq1H
   iUa9jrK3wD2BliEi/OQOO7mj0uc3dIUThNd4kWiQr9b5+UPsQHS7EHZWR
   I8IltzSirBV1YIdUlKjmRJHgSG2vHz4xyyNSx71OfNUXVBtCKYIEIjRu2
   3fe5VUhQqe8kin4tYfu7ZSpF0aGNPPpvJ/VnJxeyYg1Oq7RVZ7p9TMjPU
   LqQL0RfY1WBrkCwGAhvNol1zbaYRCN+bCZbSfAhVPPmjEhPJH8ayNpPM2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456494913"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="456494913"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 14:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743424685"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="743424685"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 14:19:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 14:19:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 14:19:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 14:19:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td34+hR/WbfBnZVELwHK7cRX+zn1hOASCffGIEnjmjqFq8kh75AehdHfMGUBWDurB6YfvtUlySJ9Zh1OoUmAA+vdJEDU9Noxst/k74vmqjd/yZvFFBDfX5tiXWt01KDkDOVBy8wMoJOcHj4YBAOJurJIyWyXi+qZWVgAEb5dH14Gxemt04a/5fSXlyrxWfJh8SHxgFDiTqHscInb0zn/Edevet738fO/1Zq8xx9qynnuk/zVtduZjO6cTuirjwrUQRRiOAr3qytARQ3gfWWkTErYdadNJX4Htei545YroH/hkDUtaAADIYKLyBzXA7I/9garnw8Wj4WGdSA6IsGZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xzzTHVOJfKSSk1aSIu7hgN7yFqGdC01NoZayMl8ehM=;
 b=ZCi1K2yvb0TJTBjm8olz5aNqe7NLEqO1OhFYHqGcEsGtuDLThtD5eqUSVUCK6IHbT9dv50Ce7vBQ8kZK2o4idjoC6Rvz4MdTYSrDevlVFypyBPUGOL5Bv0q7vnaqAjgQ4N8HsN8XT6vZjbUik1Hj1cyBHcenP8H+/c1nkByTdvc9Fg/BeeP9cPM45kQsMu+dILFRNlTy69a0ZEF9ik8j/VE0NdNlsDGQsQK8X5ADbSTnDTMeBjtjRPWopkLY1TvSTUVcFy987L69BtTKUIrWev72kSn1R9lli8Lu6ACerHIuZtk2IkfF2e3xclr03NbldFXDOFbJKd0/aruQq4H6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3175.namprd11.prod.outlook.com (2603:10b6:a03:7c::23)
 by SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 22:19:17 +0000
Received: from BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::124:ae3c:93d1:981b]) by BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::124:ae3c:93d1:981b%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:19:17 +0000
Message-ID: <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
Date: Wed, 22 Nov 2023 14:19:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
To: Jakub Kicinski <kuba@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>,
	<maxtram95@gmail.com>, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, <pabeni@redhat.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
 <ZOcBEt59zHW9qHhT@nanopsycho>
 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
 <20231118084843.70c344d9@kernel.org>
Content-Language: en-US
From: "Zhang, Xuejun" <xuejun.zhang@intel.com>
In-Reply-To: <20231118084843.70c344d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:303:2b::35) To BYAPR11MB3175.namprd11.prod.outlook.com
 (2603:10b6:a03:7c::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3175:EE_|SJ0PR11MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a3ced2-65af-4b8e-aef2-08dbeba910fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oagMv+0eU/HaXEoU9M8PQ1AYChsnZWcsYgsjqguvJDjVg136f6XYmMEapZTng+ihgvnWBWkj7dhKJFSR7kYnX4DPUUdtWEfMUspjH9Dt1brg4mf5kbWnYW0HnbGBglZ2TijQ+4rJSj57CsfVyW257Yj7YydzyIy8xd7D9dySyQg5uh5k6BjOO41K3UI6R9wsJ9clqVC2+Am+DvwfO9BG+wDqkZmC6qb0kbw6yhgELm4ZjC5YF7VyVD9mpmYLIfh+j4MzwisJyi3VEDkKo/RaMgUd6nYAj6ljgavY0aW+I/4Jz9WoZBVD20eewPGTIupun6QRF1EtNFfnfAzcID39x7hdovmnnwcmh1hzGhoE9vfYfEtW9sMz4gaKj909PJx1XXHdnXq6awrba09sJgCZEzLatLPr2sdxDM/r4br5lVsnWqoYgI9H3O3xsnKfEXQ5YWjv3mPtXK10IjV2gatwhsZKw00uMqiCDLQyokgAOLHnEH+occGGtM1vnClq80WAXw5lXTARxkkaCbBnK683S/ohl1jttXKmEp/dcYuSuW3SRwN2ULQHtUYJsXhh5hOAaebgRtSBBv4lVgEqhkVd26gKisAu0jNCx95AfpqW5d4mlgk2N20SEfADRUpMOXSae55ofwW2dsEUd2RkTNg1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(53546011)(26005)(38100700002)(6512007)(8676002)(4326008)(41300700001)(5660300002)(2906002)(478600001)(8936002)(6506007)(6486002)(54906003)(36756003)(66556008)(66946007)(6916009)(966005)(66476007)(6666004)(316002)(82960400001)(31696002)(31686004)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWMwdWU1QUJyS3h6aE5OUHc2NURZczQvSkVWVG9peEFadjBUc3hma0wxODY2?=
 =?utf-8?B?a0VqT3VHOEMvOWtrd3ZFbVhHTUtUdndGUnFIZnlwVEZaSzlpZks2dGl4bUs3?=
 =?utf-8?B?RDRyOTViZURoZjNHZGUwTW12cW9oK3RnWkVsUWRtTTFCN1BCcXFHdDkvbzEv?=
 =?utf-8?B?a1RlanRiWVVJWkx3bm9qWHk3NFZkUzhFRU84WFNZdnAyZEtRZ2V3aXNUUmFq?=
 =?utf-8?B?eWhibmpUcmc1dU1ZbktZaGhCMnRzSW96NWJEekQwUzJET1RSN2FYK1FFTWVU?=
 =?utf-8?B?S1hhQUJmcjRhWFJBUlZmOHdIUDQ4QWhSUEN2WGhUU2FKUlpFM0VWZy94V1Zw?=
 =?utf-8?B?VmF5UFJKeWFMbGRVQzQwT3FjQ0lNUytoRXluUHpqS1Qzc0dvZ1lpN0NoaEt1?=
 =?utf-8?B?YnFjREIvdlBPcnFlUUY5WHJ3SHZoaitMNlQzeEdxWjU5QkRZa09FZTdsUFBQ?=
 =?utf-8?B?RVdlZkoxNDVvMURXREJDb2dVUDdGNFN6cGh6OHhXYmNVS25WR3JUZEQ1dkZQ?=
 =?utf-8?B?UXFCdlpsaFMrZ3ZQd2d4M0RqRmFIY2QrSlZ1TnRjWmgzQzFQN05zZXhUUlV5?=
 =?utf-8?B?cUppL09rZDl3RXNlbEFvUnM1ekt5U3pwZEExSmV1QmNhQUEzNHBaNWZUeE81?=
 =?utf-8?B?b0R3TjZFUWIyTmlHVldGbzg3cW1qaGdxN0srZDBhelFqcGhFM2tKS3JUYTcy?=
 =?utf-8?B?a2hHN1FFQUp2OVRERjdDWUtueXhHbnByK3lEZlBEbmVjRjkyUnlmZ0xielBQ?=
 =?utf-8?B?aUhvZkhQRHJIS3FFUDlmeW5yeFRjZ3pTN2JMVk9MYTNPeENhdUVHb0I0TEI2?=
 =?utf-8?B?NlZPWjh3anFHeTJWL2UwRG1JQmxQL0JOaHhMa2phK1NvYi9wNW85dTBIcmRI?=
 =?utf-8?B?eTNmRG9hQTAzZVFLUCt0U2gvc2pXNzVPOExlZGpENGVHbjJ2ZE1WdGJZbE9O?=
 =?utf-8?B?Z0dyK2szTEFMMUl6RFN3RUdhTlFRYW5VMVNZM1lCN05OMHJsV2dxVkNmK2t1?=
 =?utf-8?B?UzY2TEY5TW54L2FSM1FMVEFvSVZ0UWErZTR2dHJqeStCMFRuNml2bmpqNGJR?=
 =?utf-8?B?UXdKRWJWTkJCd3RhVHdtK3NRV0hmNTVkS1VpdXJsNXJralNTRnJrOWV0eWdZ?=
 =?utf-8?B?bVRGS21XalpKZGlOekZzQjZGemtRRXI3ellOODRIcm9ETFNkYy9CRDFEWlNI?=
 =?utf-8?B?SVZ4dUVGNk0rdFlmU2tRRDlwTnlMRGNmV0E2Rm5Sekw4MnU0ZlR1Nkp3Nmc4?=
 =?utf-8?B?Y0VVd3ZtNUNFZUZyN3U4REwwMHUyTkx6ZjJTUTdyZWlwTU42U2JyY1BjK3FC?=
 =?utf-8?B?SUxVeDUvci9KQ29qaGYydEliQkUwVTNIbnhkUURidEJuTXJ6UXZza1p5aFJT?=
 =?utf-8?B?VmZVOC9IY2p5amdvaCtkdFVDOWh4cW43ZVJUMGFBaVZ5T2ZaaGZqSXpPaFVi?=
 =?utf-8?B?THRKcldVVVM2b1Nsa25mWXF5NGZqK2xCT2gxSmZwaDNLTGtwMXNOaE5WYWJX?=
 =?utf-8?B?NU5PM2ZzZjkrckNBUGZBU3NRb21GS3NOT3NtbkZrUkxscnRsYWFOQ2V6cTdW?=
 =?utf-8?B?TzRTWmFHM2VsQ2ZCb1B3TVJrTDF0U05GRW5hL1RhaEt1eFlkNUcxMkZTWCs3?=
 =?utf-8?B?RXhYUEh1Q2JydFJkaHR6SmV2Uys0eG1zTmlvVm1LUHVWUVNPSlUyK3hPWU96?=
 =?utf-8?B?SUFQYThRWmFOY0lKOVhqQS8xSnRKelNNUUN0QkN3dXlIRXIzUzdNMUVXaGlM?=
 =?utf-8?B?aVg3ZXY2T0U4a015WW9EblJvbXdzZklYZlBib0pGZlk3enk4bWZQc24vODU5?=
 =?utf-8?B?TFdNUjRPZk9DUy9PczVpNGUwdVRHTmZUL3d6bXE4YTUxN1hoVThMK1Z6d2ht?=
 =?utf-8?B?SWkvelVvK1hsQjdPVWRadUhGSUZrd0ZEam1oZ0k1ZUt4UjRhQ3VMMy83UnNN?=
 =?utf-8?B?WnY5bXBQNHRvcDNyZjhsaXVyWVNqTnB6U0pDQXJQREVCV2ErWjc2Q3ZOOUl2?=
 =?utf-8?B?aDVvSjl0MjVKdGJmcjhQTXhlVTRWLzdnb0MvdTF0VE1RWElzOGJMRlIvV1du?=
 =?utf-8?B?YjROY2h1L0hQK2JRYW1IQkNvbVNHQ3lXY25pM3lsdi90L0dmMjBmWk5oNnZ3?=
 =?utf-8?Q?qV9DpiP08eXzDtkhX88zuPQRC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a3ced2-65af-4b8e-aef2-08dbeba910fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:19:17.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Gvlzo9wairmZVRNMwMKdQ9FeJhyMDmri++oNwVUNyxAtnS7i4EaqXn2c+aqVoNFQf0p5vPSLT08BOvFjtdl8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com


On 11/18/2023 8:48 AM, Jakub Kicinski wrote:
> On Thu, 16 Nov 2023 21:52:49 -0800 Zhang, Xuejun wrote:
>> Thanks for looking into our last patch with devlink API. Really
>> appreciate your candid review.
>>
>> Following your suggestion, we have looked into 3 tc offload options to
>> support queue rate limiting
>>
>> #1 mq + matchall + police
>>
>> #2 mq + tbf
> You can extend mqprio, too, if you wanted.
>
>> #3 htb
>>
>> all 3 tc offload options require some level of tc extensions to support
>> VF tx queue rate limiting (tx_maxrate & tx_minrate)
>>
>> htb offload requires minimal tc changes or no change with similar change
>> done @ driver (we can share patch for review).
>>
>> After discussing with Maxim Mikityanskiy(
>> https://lore.kernel.org/netdev/54a7dd27-a612-46f1-80dd-b43e28f8e4ce@intel.com/
>> ), looks like sysfs interface with tx_minrate extension could be the
>> option we can take.
>>
>> Look forward your opinion & guidance. Thanks for your time!
> My least favorite thing to do is to configure the same piece of silicon
> with 4 different SW interfaces. It's okay if we have 4 different uAPIs
> (user level APIs) but the driver should not be exposed to all these
> options.
>
> I'm saying 4 but really I can think of 6 ways of setting maxrate :(
>
> IMHO we need to be a bit more realistic about the notion of "offloading
> the SW thing" for qdiscs specifically. Normally we offload SW constructs
> to have a fallback and have a clear definition of functionality.
> I bet most data-centers will use BPF+FQ these days, so the "fallback"
> argument does not apply. And the "clear definition" when it comes to
> basic rate limiting is.. moot.
>
> Besides we already have mqprio, sysfs maxrate, sriov ndo, devlink rate,
> none of which have SW fallback.
>
> So since you asked for my opinion - my opinion is that step 1 is to
> create a common representation of what we already have and feed it
> to the drivers via a single interface. I could just be taking sysfs
> maxrate and feeding it to the driver via the devlink rate interface.
> If we have the right internals I give 0 cares about what uAPI you pick.

There is an existing ndo api for setting tx_maxrate API

int (*ndo_set_tx_maxrate)(struct net_device *dev,
                           int queue_index,
               u32 maxrate);

we could expand and modify the above API with tx_minrate and burst 
parameters as below
int (*ndo_set_tx_rate)(struct net_device *dev,
                  int queue_index,
                int maxrate , int minrate, int burst);

queue_index: tx queue index of net device
maxrate: tx maxrate in mbps
minrate: tx min rate in mbps
burst: data burst in bytes


The proposed API would incur net/core and driver changes as follows
a) existing drivers with ndo_set_tx_maxrate support upgraded to use new 
ndo_set_tx_rate
b) net sysfs (replacing ndo_set_maxrate with ndo_set_tx_rate with 
minrate and burst set to 0, -1 means ignore)
c) Keep the existing /sys/class/net/ethx/queues/tx_nn/tx_maxrate as it 
is currently
d) Add sysfs entry as /sys/class/net/ethx/queues/tx_nn/tx_minrate & 
/sys/class/net/ethx/queues/tx_nn/burst

Let us know your thoughts.


