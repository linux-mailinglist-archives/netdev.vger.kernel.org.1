Return-Path: <netdev+bounces-30084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C90785F2D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C2A1C20C74
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B68B1F19F;
	Wed, 23 Aug 2023 18:05:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697C1ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:05:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2236DE9
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692813947; x=1724349947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UJ+qaPYXF1HzyqYcFfGWw+l8Ck8gpyBcclpDrej6rSg=;
  b=QwILCJ4Cfeitw4ZVXC3vDp1v1dnWQKyr9o7Y6UhGHlW1G4IkCLDsoKyp
   QoGfiSrQGgb+NySENRxVDwfw4eU5kC165MGS9Fatnky9i4f82md89EpUa
   HzjcnkkRw0R1HHujXsSQN7LirNcCHdt62/j9w9e6JH7iZSqLsUX4tt0c2
   0PG+BtlsfyqPvo8kDmqendwyN7lYWZ6GQ87jbcbxwIIgfmngvQB8KNSSL
   Za/66xu5Hap/4o5dBT5+y8RhjdAg4IGUueER8skGWPb7esknMqnDyDRVt
   +dvkhtHUtJXy2kCeahEwk3EjWd+IRThb3DBbNxUhQ1ulGmnIAwPey7IrW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438160468"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438160468"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686551263"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686551263"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 11:05:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 11:05:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 11:05:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 11:05:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 11:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQrAvyyWRRbbwYuKzMzMiEj0RozhFnyuoo29ef88ncdEix7XVK4DbumuMAoxY18X5MI5YoUd7r/PdV6aQ4ueM6GCiq73xEFeA/F8sFdfljoduMA/TT17/GqgX4s/E6/k4fbDuXw8uYuV6Rbu+ib7if563ca/Ro+yTNYLMw2Guw2y1ouViaSoYEk60t5XYCSJsNfCd5Ow0Ke/FPbyaIvEPU1m+mU+8qlGvzOI6uZvq4yZ30MpTlg5ZZYuhH5FuOfSc88JE2p86rXmLaJBAVyrk89WrzE648h/54BZ59BLX8JC1f2Uloph16ceaEv/tnlBz8xBqNqf0dz1k87xminbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y11IDwrKvdLlkw9vGnyL9Tun6tZTGUwRDetnCNo/J0=;
 b=QktFM8xaF7f6WLGBvS2cBKhvITpxZAOmqvE3ayBnKQ8Z4t6On8pA6UHrv0SXAiucs7YK9/yWjq3ItPwTmPYr0yel8utUMd9dXCrsF1gczK4Ut1dkd6B9lr2agsHiPuj8DZ7bnCzr0bxYECBhYGN2Pf0aQ80Po8T5SnPDQm7R2zj+ZQLZvnrujRQ6PFhvyoDhBr5P4plmmvep0brPt2/bYDHfzbpfzJ5Z2oXW15LptyI9adSkWa470RxtnCwqmPVZE1lTnKXD6CxZOiZlMWHEgKi3HnrjsQPwECECzSHeQa4DoFu//I7024f5fDZxkUI41ykw7/iDg0iOSKVblkvL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by CH3PR11MB7370.namprd11.prod.outlook.com (2603:10b6:610:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 18:05:17 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 18:05:17 +0000
Message-ID: <301ce6ae-f925-a1a5-3be0-06da4ddfafc1@intel.com>
Date: Wed, 23 Aug 2023 11:05:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 14/15] idpf: add ethtool callbacks
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, "Alan
 Brady" <alan.brady@intel.com>, <emil.s.tantilov@intel.com>,
	<jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
	<shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
	<decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Phani Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-15-anthony.l.nguyen@intel.com>
 <20230818115824.446d1ea7@kernel.org>
 <b12c2182-484f-249f-1fd6-8cc8fafb1c6a@intel.com>
 <20230821140205.4d3bc797@kernel.org>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230821140205.4d3bc797@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:303:8d::34) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|CH3PR11MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 4168f1d1-1cb3-4008-c6a9-08dba4038205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HY7NtJdHd1JoVUn6VIwx4meJmpASFILOpnxfk4LAuNnK1EzC9/Xas4j72I66xMCtx34tdHbVFZxi5FymvxlmnoXaBmNw0gZ+poogIY2v1Y7+DyZ5OVpfZNpgI07SPESRBWdZJgsZ7PQ0vdhRFyqMeQm1cIAbiyaSRX60S5aq0Rtan7OtuML+oCkYDE4B/l1ros5LhuaDqbnXL17bLPXTQ0Gsrpm3QH+00mECMNL1XhAvUwwnlU1wODGZjZ7N8WjCtmeiZe0SLKiAaMDpqzeSUxHEfbFMXoynv0y9R4hoZPjO/1Sx5WCJjtWVFw8AvvV7nkg5V6akCUQ79JSaJOm8K1IfM1oHmo//OzYue0zUZtx/pxogfzUer0PPvFPQseyWc8wYwLKeM81wynit7gfUM1z+EGRGqoz3wLycs5ggRHRnCfA4/bKRk3M1XP4Z2XPcuC3pzx1Hbn9l13VnYGem4Y00F+iIAJw9HJumsqO1V4cxKzL3iaZaO8Y7ykFQRHHu83iZAayeKREBXuWb3FcwH+eTeAHGSFOjwLeUAvnBSUjkB8IIn4MA1/wtn/pMW1CZjUAS0cbK6NpNaJ3aTfZs7MuQziPWUkxu3Rpb/2K91fvySeKuhEzxwJaMpJe3g/1giPqtudjm5Bm+uBYJqi6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(1800799009)(186009)(451199024)(83380400001)(2906002)(82960400001)(38100700002)(36756003)(31696002)(86362001)(6512007)(41300700001)(66476007)(54906003)(66556008)(66946007)(6506007)(6486002)(6916009)(316002)(53546011)(2616005)(8936002)(8676002)(4326008)(478600001)(6666004)(31686004)(26005)(7416002)(5660300002)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZhOUJ2dWtETkhzRkhIQS9xL2FHeU1OSFdvbEV5TTFxK0N1WWZ5citTQnVv?=
 =?utf-8?B?UkFNVFJJK1RhRXdzMXJJa1JkT2NMa0ZaOFNPUFZoc1llNXgreWtSengrdDdz?=
 =?utf-8?B?bmd4Ykg3VnlhY3VrNDNGQit4bXdMSVlpd29VZ1hLZTdEN2tHbjErdzNUNDln?=
 =?utf-8?B?aTdGNmk1eExtUC91dTI5c0VrTkZjVnhrU0syWm5RYm5BVDBhU3JFRFhoR0Q4?=
 =?utf-8?B?dGhERjRnWnZMUkpBTUpGOTZPUU9EQ1JBT29iS0dMeUVoRmkxVDhKb1JjeTZS?=
 =?utf-8?B?enY0bk9oczJqNGQrZjV0VTNJRzJvN2VMZ050ZlUzYTJlNWliU0NDWkdMQ2M5?=
 =?utf-8?B?N1FiakFIV0cwUVloMkxHVE1WcHZ5anhKK2VBcThYT2wwUlNYbEd1aEFpV3Ir?=
 =?utf-8?B?b25mdUZGMEdDUUNYaFAxQ00zVXcxZFJtWnJmUm5YYkpQOWsvZGVoRGlCallo?=
 =?utf-8?B?RzQ2N2s5YmNwRUFZeGY2WHlwcm9DUDhxMThGRGpheFg3aTV0RXpKdGFmdFF1?=
 =?utf-8?B?VDd2UENGVnF0T3RwZTVIdkFpM3NpbVBobVJldmRpMVI5Z0Jua1c3UHB2Nll4?=
 =?utf-8?B?SjlDa1hvVkc2bTFSYTFGMWE1cHg4UXEraUV6OEd5aUwvR2wvM3lIVHNtQkdz?=
 =?utf-8?B?M3hkaUp2YlcyS1pabFNjV1M3Y0k3Y0hpeXc0L01jVzFsUEFNelVKRGV0SEM5?=
 =?utf-8?B?cVpnVjZwV1ZJMzM1VFF4R3drZlZQWC9TbVh3RW9zNWVzYm9FNGRwaVJIMHZz?=
 =?utf-8?B?d1NpMms5dVk1YVVlN0Z5NkhiOWtNc1FNaFoxNUZPZEdnaXpMQkltVTZXRDZo?=
 =?utf-8?B?L0xtRGtRN2pXYXNod2M4MXBZcjV6M3B3N2FuOHNFYXVGQVpOcHp2U2xVZWdG?=
 =?utf-8?B?SDJDZUgzTTVzNlZMWGp0YzlKYXczWTkzbUx3NXZqVk9tWEVmVzJsNXozL29w?=
 =?utf-8?B?VHdTNjBqV01tZ0JBd285TWo3d2Nacit4a0ZHSldhYnArS1BFZVgvYTNxWmds?=
 =?utf-8?B?SEY0NStTclRZeHNnc1l4cm9TdHBNM1RIZys1SjIyUk9SdXQrSllyWTM0YjVP?=
 =?utf-8?B?Q3RyQjd4S2NhZmhFTDRYNDY4NWNHQXY1SkttQ0tPLy9QTVQrMTdXSTNZeUFQ?=
 =?utf-8?B?NDU2eTBZdytJaUVjWi91cjhNS1FsTW55ZXJZSWZIaDdqYi9GU2dGM0NpajJP?=
 =?utf-8?B?cFRybklpQ3o1OFFaWDdpQVZtMlhxZi82WjhsYldsekFRdlF1Skt2SFBOSDZH?=
 =?utf-8?B?QjRXaHl6YkozQk5IK3QweGZpdU9lYStGT2xmSWtaZ0d3T2YxU1RRQjAyL0wr?=
 =?utf-8?B?TEdhNFlWK0J0ZlJ3K1ZjMWpncVpCZlZpYnZrK0taYlRscS9KVkg5eXpGYzBT?=
 =?utf-8?B?dHhuVFNIbEwxNjFUWDBLRGlqTjNmOWo3aFR3TTQ1RVJSVU4xTFVhc1BybTgv?=
 =?utf-8?B?eTVuMzBiWnRzdHJyUjE5YmRYRXhtKytHNmlSaWdJY1VabGtTNjZsZ0dEWjhx?=
 =?utf-8?B?VGxxRVRmRjh5RlZCTmM2b05QVmdRN21yeDA0aE1QVENuc1ZQaFFnOVovZUVO?=
 =?utf-8?B?NTRZRUVjUjNJWnJzOUNRTlBLUW1pcTBtc0ZJclZEaWVDT3QrcTBKSUFHbjBG?=
 =?utf-8?B?ODB5NWFmSnNXVW9JeG9uVjVkQ1JmeWFZT0c0NXFabjgrVTNHeW5KRlhIcVl0?=
 =?utf-8?B?Y29TSUY1K1M3OXpMWkdYR3I1YjdrdURyeEcvTTgzSHJ2dDg0WllPRHhnZDZk?=
 =?utf-8?B?cGVZeHlXenpSSTNjenZDam10aG9TMUNRL1Fnei80RnVGblZGR2dQR1lzalM5?=
 =?utf-8?B?eS9SRWY0Y1dxODFQM3NnalkyWGV4QVFzVTltR1JsbHBRcVYwUXRHRjlscFJ1?=
 =?utf-8?B?MkxaQTNtVndYY04yS3NaQXFYcWNrZXVpL3ZhQjNmNXZrSkdsaG4vNXJUcWtp?=
 =?utf-8?B?cmhEZFlUWnA1WVNPeTBJNWcxbSthZm5vQTltRzA2Q1h1WWlNWXQwRTAzOXFP?=
 =?utf-8?B?V1RDVUh3UkxoaW9pYzFDc0VydlBzS1JvRnl3K0hObVowZmtoc2ZjMnJjbjZY?=
 =?utf-8?B?WlVZYnE2ZTV6WnZwZnVRT0d3NGxGQlNXR1BkZHpyQk5YTHRpZndrb2RZM0Zp?=
 =?utf-8?B?czJHc1Uybk10RFN4bWs4RzdvSlRMMkJoc09wak5xSEpmQ25yOU5Gd1ZNV2Rr?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4168f1d1-1cb3-4008-c6a9-08dba4038205
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 18:05:17.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uCqNWoQPPMR9FmjhS2buoTKdyNPYUKlkNIwGbMjoX5a6Ole4Kq07FWe4/KVyk22KWhuYEXj+bOiC5xfgj4PgWtvl5c+nMp3z+gKfHOODXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/2023 2:02 PM, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 13:41:15 -0700 Linga, Pavan Kumar wrote:
>> On 8/18/2023 11:58 AM, Jakub Kicinski wrote:
>>> On Tue, 15 Aug 2023 17:43:04 -0700 Tony Nguyen wrote:
>>>> +static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
>>>> +{
>>>> +	struct idpf_vport *vport = idpf_netdev_to_vport(netdev);
>>>> +	struct idpf_vport_user_config_data *user_config;
>>>> +
>>>> +	if (!vport)
>>>> +		return -EINVAL;
>>>
>>> defensive programming? how do we have a netdev and no vport?
>>
>> During a hardware reset, the control plane will reinitialize its vport
>> configuration along with the hardware resources which in turn requires
>> the driver to reallocate the vports as well. For this reason the vports
>> will be freed, but the netdev will be preserved.
> 
> HW reset path should take appropriate locks so that the normal control
> path can't be exposed to transient errors.
> 
> User space will 100% not know what to do with a GET reporting EINVAL.
> 

Agreed, looking into using locks to protect such cases.

>>>> +	dev = &vport->adapter->pdev->dev;
>>>> +	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
>>>> +		dev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
>>>
>>> The error msg doesn't seem to fit the second part of the condition.
>>>
>>
>> The negation part is to the complete check which means it takes 0
>> [tx|rx]_count into consideration.
> 
> Ah, missed the negation. In that case I think the check is not needed,
> pretty sure core checks this.
> 

My bad. After taking a closer look, the above check is similar compared 
to that of the core check. Will remove the check as it is redundant.

>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	num_req_tx_q = ch->combined_count + ch->tx_count;
>>>> +	num_req_rx_q = ch->combined_count + ch->rx_count;
>>>> +
>>>> +	dev = &vport->adapter->pdev->dev;
>>>> +	/* It's possible to specify number of queues that exceeds max in a way
>>>> +	 * that stack won't catch for us, this should catch that.
>>>> +	 */
>>>
>>> How, tho?
>>
>> If the user tries to pass the combined along with the txq or rxq values,
>> then it is possbile to cross the max supported values. So the following
>> checks are needed to protect those cases. Core checks the max values for
>> the individual arguments but not the combined + [tx|rx].
> 
> I see, please add something along those lines to the comment.

Sure, will do.

Thanks,
Pavan

