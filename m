Return-Path: <netdev+bounces-27517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70777C351
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 00:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F782811B9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB3B100C5;
	Mon, 14 Aug 2023 22:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA71100AA
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 22:16:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4455F18B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692051378; x=1723587378;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M5kCn13Lv58qE45SSdiLh7XK+YtLuCIW+mBqrnQ/uvU=;
  b=DR+vG3pJA7TdFzsT/sRjPKLCxoDf9ewLyXbcT1SEWu2rDdrNV5q6jxGC
   hoPHZHhXbzDcvOjO9zq9ceTZyyiQ28HX3gDHqP0LbVazcdtXU+QkP85oc
   nEnyf5QeDl6Obek1LJiKDpO98WXw+3XGE9BPdNZYmiVxU6QllQiybJkeh
   Xanw4A/BbfKVkO5qU7f8kfJUOu767fnTAC3u2R2jlBoGXSocmdBep3fEs
   uKh58SF8GjZ3oODjWUSl5P77BsR4o+cRq8ZovOBGCPgRoNfGzZ8PrF9ix
   C8ygrT34bwk5CNuCALINhTexPAhsTRTA+YXy1Er7rIGBMoGydPo1yFDXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438485813"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438485813"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 15:16:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857210006"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="857210006"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2023 15:16:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 15:16:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 15:16:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 15:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5EPEPjF9tQJWnKj4O7c8MFpkFBsf5UEQufGgxMqz9lX0379Ehj3T5ApigzLIEov4IZCH7mIZymNVscufN4qqTzwg8Evdt0GBpXkh9TsB2zmqZKkbTUC6ftyINGiJ/2hEB8gg0ErdcIrTvbVzFW3lg6Qkt4TKkwEY9mUoXatY2bWCgvyJ58BZVuAIT/kJyHKELPJhfa1VkUxDE3w3tuV3fI9M0DvObSA4bZSWY73sYLLEJbsTItZenStBahSXpHbFUFs2JWb79m+hKs0FWcX4AhFYAk7S0cbhVFKR3oUzpvymx+CJeE3afcFpCgPy0lEGSO5Hqw8mWCdJKVd0VI4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmeUYWBdCeJzzPMUpCiTdVJo5Axz9RlxkyfAB6HUHN0=;
 b=n5SVLFo3XMfodoMcQngC8jQW18DQatFFSpROSZKpGqzfgjB0eIw7foNHQ4gOw1dB8IkhelcbJuyOChJbOao38e1fn1vk9UwtXs2zc+DX6s2ZF6fm6sUEukiJobfAhaObQj7k/9YjoC+ArvEyubkNQqZQ21fkvjFFzTY+2yo6/PAgRCI0cupDweAemza3G6kNKPrS8bELxZCLuO0Mo45mExgzxyvHZdzy+qZPBsvaSU+jmrnKDjypjcfsweeiSjmfJ+J77Mbuan61BNyHv/69yoqxs3g197YjkAG44y/Kct3eYdDbCwPyLxOd6A6ByrGHSrQ4sN5rqS9RatRCXVHQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 22:16:09 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::5c09:3f09:aae8:6468%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 22:16:09 +0000
Message-ID: <f8b9cd9e-651b-8488-5c4f-aacc03a3c9c8@intel.com>
Date: Mon, 14 Aug 2023 15:16:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 1/2] igb: Stop PTP related workqueues if aren't
 necessary
To: Leon Romanovsky <leon@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Alessio Igor Bogani
	<alessio.bogani@elettra.eu>, <richardcochran@gmail.com>, "Pucha Himasekhar
 Reddy" <himasekharx.reddy.pucha@intel.com>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
 <20230810175410.1964221-2-anthony.l.nguyen@intel.com>
 <20230813090107.GE7707@unreal>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230813090107.GE7707@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3490f6-4806-464f-b95a-08db9d140f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJSkdzFH0HSh3aDzsWiHvbjWIb4q6tJnvmuuQvg0z73DSk6mmJUFz5lNOMuiZDjAefc1DVPikKCrJZbvs6qpkvsF3uZ7Bc9G7FEG2fFmzF5t6EdeFEQMqwKAE5Pzn9wCKvhWR2OE1Gy2W+4BmlVAQzLAt2a7fkWXi3xwxhIS5P4QxwNvZ3YEqm7xc18icY7UiIFfSSsdwLrkkpC5s245T6/Rv4KxyzvrNWFOQgJTJj7dLllNG8i0JWDXpjaTG+PhN5OmmwkOtoonvwsMj/xWXTf17fiU4DTGA7uEefIPuP/DG10yBQ1JSRyHNhekGJMC6vR+GzEo7GkDzms+BPBwlpfao91/+Ibjo9yxjqIGlBFPzFnggfudltmJOQuT2B9wXKUhZf1r+x8xljmftO0D5MkmVcI90S5J0ScFqXN/DbMPzccl0IG0lkqpq3ieWcNzBFqTFLEt0ce1rnSiGZ7GuqZIZX888wJM4cMgp4kMMzzflh/JgMPgjyB2h8XemAHzOnSjFFmb5cqm8Pi56gnGRQwMU2ZRwee9nX5zSoMI4LrmJbuvzov+dxQCGxoPgOISiGbLw+kRlWgxjUk6r4uwTAbhG24ZCWVmp8l+sqx0WKgsskE4v56eUc4JJw6pHordmJaOFLhW4cgHrbwxU4mDeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(38100700002)(54906003)(6486002)(6666004)(478600001)(82960400001)(5660300002)(2906002)(36756003)(86362001)(31696002)(6916009)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(316002)(8676002)(107886003)(6506007)(53546011)(26005)(31686004)(83380400001)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFWRkxCNU0vRW9uTUN3cDhTSk5vSTZYMzhsSHpWbVFFODlRRktaRDRBSXBL?=
 =?utf-8?B?cGlSd2g1NStKSUtxaU5rdFdZWlpkNGVnNFpVbXorQ3lydGdJemlacGdzN0E1?=
 =?utf-8?B?eCsyZnVWU1lDcW9CejRsWlByQ3JQS2ZLMERVTjRNOUtFa240ZWRrRzFhanFm?=
 =?utf-8?B?ck15bzhTVmtENk9zcnp6dUlOc2xNOURPcDI0Y21DZkM0UWdlVStpdDdIc3JG?=
 =?utf-8?B?SmlhV1UrdlZEK1YzNUFaMDBhRmdWSk5zeWh0dFVzRkJPZHkzZXJRdDFrRmt2?=
 =?utf-8?B?TWRtRWEwWTk4c3NnRkpkTW5MK1pDbTllYlg1L1lzS0JnbkRKLys3aFpzZCt5?=
 =?utf-8?B?NlNRTjdxSVQvRVozcUNNb2xsM2o5MlRyWllsYS9PVEVkOG9KSXlpNi93Lzdo?=
 =?utf-8?B?NkdwUmpuY0dQSXpLSUlRSkJ6Z1l2Vi9Id2x1T0V2Qml6cEdiMDFMS09PMVZm?=
 =?utf-8?B?VjFqbStiY1laVFNkUzZLK1RkUWF4aldldTh4TWpvaHh0RGtlK0Frd3NJWEZY?=
 =?utf-8?B?UU1ERXhXblZZMjFZSVEyQ2hYZ202aElFdVdiTlFuNERFamp5THkvQ0ZnVFFM?=
 =?utf-8?B?MjBpMk5BRVQ3eUdWenphWnVzUTRraEdmSExhR2phdmxhU1RZYjRkbjNpeFYv?=
 =?utf-8?B?czNKZ1NWeXkwVW02d08wVXJ4N3pZMUxLWXMxREk3ZFBEOEFvS0ZPMDVXTmZI?=
 =?utf-8?B?MVVURmZGRzgxYnQrckY1Q3ErWkw1V2lQcWdXVndPZytyNzU5N3V2TzBJb1Ey?=
 =?utf-8?B?cHljU1ZMYzNVTmFFeE9RakFRMC9LV1dOQVlUY3FrZ3hFQnpacThjb2pNUzZQ?=
 =?utf-8?B?SHZlSE1GcWpBR0hlOGNhdWZhTmFEcXdHNm52TzBWbGpYY2l1N29YVlB2dk9C?=
 =?utf-8?B?TXJXc21QK0FmS3NuSzA5NWZqV0EyVUF5amhsUFJ2eVh6ZXhCaTYya0Z6V2hV?=
 =?utf-8?B?VTZDQXg1OXQvSFNOZ0RGeCtzenYvQTVINTk0a2tQNVpWMDhCRGFvbUxLWUFt?=
 =?utf-8?B?RHR2UGdhZHpvUWdTNkxjaTNMK2k1ZTBKOWdacVh5U3E5N1FJbk9jcHQ1c2FV?=
 =?utf-8?B?V040M1QzcytyeHEvNHI5cytXdDVxK00vWXFRRndTUjYweXd1RUVHZ3ZOQXVW?=
 =?utf-8?B?THRwVTgvNVVjSUp5UGlpU1ExKzYvVlkvRUVWSEszblhuT2kzU1lKTTBkdGxn?=
 =?utf-8?B?cGRwV0ljcnkwd05CS0JvYy9qdll2OHhQTldmU0o4bHpjcGR4djVKT0Njd016?=
 =?utf-8?B?alZ2YkJWUlBmZXJucUg3Rk1ldFI2Ylptd1M1NDM4SnJXS1hLRTEyME1peFln?=
 =?utf-8?B?WFhHclBEa1R0U3NlWS9VMEF6U1B2QkVDVW81d3FqRkoxbDErZzliNEhidnB3?=
 =?utf-8?B?eEtyRjR0bmxzdG1BSEk3NldXZmQ4OEJBMmN0VFQ2QUtWUGZLS2ZCNXVsa2Nm?=
 =?utf-8?B?UDVaN29sS3ByaFNvR0N2VW40dzJ3MkU4ZGxjRElXbVZiUXduRG5kV3h3Y0RS?=
 =?utf-8?B?V3VXU0lHcHpRbnRiMm0vZTBqRXNWRDdPUU5YZE8wZjJSSmRRMXF0djNWVmlo?=
 =?utf-8?B?NzIzNFhaMEFJVmZtNW5xNGIva0UxZnFucVhPaU11eEUxR3RwNi9idC9hd3lk?=
 =?utf-8?B?MFRSZ2x3TnZPUkQ1R0ZtdS9zTC9qLzFadmlCQU9EcWlZM1lPcnpwN2hMbHhT?=
 =?utf-8?B?Skc4TnVkakRrbXhWZTZCVC9hTE1TYVFXSzZpL1d3aVErRFdFS2F1TFNaSHFZ?=
 =?utf-8?B?QVJXQnBhdEJPMzJheXFLYzMxRW9qKy9pUW0zUThlbkhLbVppRlcvZFZVUHlp?=
 =?utf-8?B?R3VabmpnTE5LWE1TM3EyT2JCdW0rODVjUjJZQ0lIQzVNTEorOHNWYi92ZjQ4?=
 =?utf-8?B?V2hJazQxejV1VVFCdmF0L04xYkV5SDEzeXdWMFJmVi9mR0ZScGs1ei90aENn?=
 =?utf-8?B?UWlCK1hZekU5RlNVZU5aaUh6enhsUFlYYzlWc0NPSlAxdzdwcThvQVZ2clV3?=
 =?utf-8?B?d3dzWmJxaUJOM3dkL0h4WjMzSXptRlE2QTk0QUR1TndlcVhyNVlvR0VaQVlj?=
 =?utf-8?B?OTc5cVl6VElNVHo3b2xERmFXd0xXUmRnd3RaTmhjYUg3bUNZcnhqa3JhMTQy?=
 =?utf-8?B?YkMvSG9IRWp2Y2t2OUJMbVdTZjg2ellRYTh1eGlVUEd1citoYXlXZytlcWpX?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3490f6-4806-464f-b95a-08db9d140f9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 22:16:09.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM7OeSAjfavxHP0qXQzxwczXNq5LHSJOeawzyFihpDeKJE6WB0eQkmKrdhqhNCD3V0eZCItqOpbqZjp+dWSeFglDbye0MwNgkUaEy6Sm+q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/13/2023 2:01 AM, Leon Romanovsky wrote:
> On Thu, Aug 10, 2023 at 10:54:09AM -0700, Tony Nguyen wrote:
>> From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>>
>> The workqueues ptp_tx_work and ptp_overflow_work are unconditionally allocated
>> by igb_ptp_init(). Stop them if aren't necessary (ptp_clock_register() fails
>> and CONFIG_PTP is disabled).
>>
>> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> index 405886ee5261..02276c922ac0 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> @@ -1406,7 +1406,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
>>   		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
>>   			 adapter->netdev->name);
>>   		adapter->ptp_flags |= IGB_PTP_ENABLED;
>> +		return;
>>   	}
>> +
>> +	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
>> +		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
>> +
>> +	cancel_work_sync(&adapter->ptp_tx_work);
> 
> Is it possible to move work initialization to be after call to ptp_clock_register()?

I'm under the impression that everything should be ready to go before 
calling ptp_clock_register() so we shouldn't register until the 
workqueues are set up.

Thanks,
Tony

> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 405886ee5261..56fd2b0fe70c 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1386,11 +1386,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
>          }
>   
>          spin_lock_init(&adapter->tmreg_lock);
> -       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> -
> -       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> -               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> -                                 igb_ptp_overflow_check);
>   
>          adapter->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
>          adapter->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> @@ -1407,6 +1402,15 @@ void igb_ptp_init(struct igb_adapter *adapter)
>                           adapter->netdev->name);
>                  adapter->ptp_flags |= IGB_PTP_ENABLED;
>          }
> +
> +       if (!adapter->ptp_clock)
> +               return;
> +
> +       INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
> +
> +       if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
> +               INIT_DELAYED_WORK(&adapter->ptp_overflow_work,
> +                                 igb_ptp_overflow_check);
>   }
>   
>   /**
> 
> 
> 
> 
>>   }
>>   
>>   /**
>> -- 
>> 2.38.1
>>
>>

