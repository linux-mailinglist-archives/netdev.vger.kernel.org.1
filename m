Return-Path: <netdev+bounces-49810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DAD7F3847
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF86B217ED
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799DB584C8;
	Tue, 21 Nov 2023 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hi9epzye"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1BD45
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601999; x=1732137999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BMlm3AOfRugJFROHh5Ni+ANkLjVgqQt84K4BYzAcZS8=;
  b=hi9epzyeYmzc4C56LVJODaCSNu3vldWiiiXlDdCvAQRW89ZGjRAFfc5r
   MEtaoAKb6APCvhRlqXSHuUx02O7jlmfN7mWca83/0lbO9kFc7iClS7tNl
   eoz33R/Fs/P2tDi2ugT8gbRDRLvaWA/CFQncdx4GicJHthHuQEoZtD2g2
   PzznYZeChBCb7VkRvq8EDSEi2E7sV79YRtp7UeJoY6o6Y/IwXtY32ZV4r
   MR/iVr6GSKvfZ+uulJFateto++ADcUNZlnB6V9UT8RE/grhvdM3OGtd0v
   XTFfPdlBbLnh7k0DZpix1gvnPO4FEbcTITcKn7flqnD82DIKHBLQeBrV5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391703326"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="391703326"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014034356"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1014034356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 13:26:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 13:26:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 13:26:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 13:26:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKVuCTKxf+9Y09m8PlpwpmZAx1jdKVrNdvPh+cZ57x6xgHbmymp9xyRiJ1PnQppfnACmjFG30pUqOy7Y10rdYlaj6qFPZyOL1czR2M4DxOqEmttUHu09cRVvx4e/UsLG+YjkmdWaUMnDkFVIG7mWDPrM54PA65321qF2iwqsrd0Qv4D/yYaFhU8sTTpf2RZK3K7qZnwdghQC2pAhFO6xirsHzim0tGbYkxTZaB53ZfuPc2u2c7GiH7Fohb779eKH9G4wJRsrq0TKGxrp4UOJgn0A4vFR1YmhsNi1iDRsSD/c05A07BlDD32Q6KeR8yHFxwFVoeLOnGMG5LkorXjESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zp7bTHXh+xlMyUSyoKLdVf//P2cKEezrMoCwLihPbc=;
 b=nKe6Z9MtP3AzoraVxZd1OHILSkMDqOB8cwYZBStxJwx6dIao+9I/v//AKMnI4x5H80cTqREaLOcB3lpp+QXaDzlvw3iB5q/q8XGly/rtVoFYj1ZPM8Tg1Fi1r2hznHCRct1MAOhoCKRzruSfTVT3e439bd6uKPrKhVJ2WZlLxk/AKuIrDo59jxrxC/WsmyeQTcw5u2lV3i7AvTJK/h5FM5VrOcwvxrLiLSgNUsY8bUnCPdwCKx+SY1SqOx7w4F02uVivhVC4hP6ZWbJ243z+Bf271KQtwC88QnFr2iXoLQJZmtiFjzlG35mWqVKi8ftK+3k5KLrd+at+sjASaMc8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 21:26:31 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 21:26:31 +0000
Message-ID: <68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
Date: Tue, 21 Nov 2023 13:26:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
 <170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
 <20231120155436.32ae11c6@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231120155436.32ae11c6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc8c59d-040d-4a3d-6c50-08dbead88778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cb5K7XudT+v9WXl6R/nOn8fC19ilw8X6EIIFkO0hUQ2sB1fZ/RMDwMBy45apPYXoaTVJiVsM+nq+juPz/j+Vkyou2af1geXMrzjGzWIR9lURulf32EMDoe27dkBJwbbZ3AJEaC2o0u4Fqk3KUfZlbz8Fk6dcUZkgIxfKWxn2P32WIXsOMNLjVGd72S7O89o4npMQbYgRboIPJgGhLTb7iTh1cQ+kK1SNiqLtTcM7YFopKFxAxl7NYI8YoCdAoFx+9HRBbjYraFg+GR5CI4FAeVii9pfA9r+hlRao/EZkXtNOTTBR4r4pIYiibcuBeA9uN2sbtosR04JRbCGe6NmHgHBPyQVlokbPsZz/Xf26bzjX66QE3y9HJpz30JUGDffF3y9JtdFW0Mp7gj1Zk1tQXlwmzrMThXRplMEIIzNN+84hhaOvDPSotidTVdLBw/hwPRGq9qaCakXTCdd14T/0NZuWzY7Ky2CPoO/xwAE9hB44cqlezFckI7Di1hhSymhCm4m5wQhGvCLVnOwxbv0KL0sHOONNlYi0YtGau8I5Sm2sRrGzsRxSZjaMtQT9+zLCOshW4/XgT6MmVNXv+Urbq6ZzP0X3OiBvLezWHeSh/vWRbiCG6TlMBTMdxt6oyiXBEyII7Va3k+Ao8Foq1y4WWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(4326008)(8936002)(8676002)(36756003)(31696002)(82960400001)(86362001)(38100700002)(41300700001)(478600001)(66946007)(66476007)(66556008)(316002)(107886003)(26005)(2616005)(6916009)(31686004)(83380400001)(53546011)(6666004)(6486002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWF2RUFGM0ZkNE5iZ3RSZlBhNEJ1bTZvTXJXaTNCNVJ1bnNOMmUrcmliUFJ2?=
 =?utf-8?B?T0JUZ0w4bmNTU2tSRWlWRjRKNzdxZ3RYVzhrcTlITEVXZHdnYWQ2ZEErc3ZB?=
 =?utf-8?B?THErcFVhdHhvOHg1WEEzSDQydjhNb1hsYUlIRFhJZVF5SHppM1lCS01IMWhq?=
 =?utf-8?B?ZWlNbVFPSmRyVzNBUXh4ZE9BMDVCVUxPN1JmS1YvUE9VZ3BJMG1TUFgvR2Uz?=
 =?utf-8?B?eFhNQWRjanNuVmI4WjNHaHhDNHFKRGFvWnM0YWJoV3V0aE5FS0R6eEh3aGht?=
 =?utf-8?B?aE4vc2xKamFBOE02cDRGRURsRWttOW1sU0JBNW9TUi9yWi9uYXhZeVlDQTJE?=
 =?utf-8?B?aUFLYnF1L05Eem9LNG52QmhvanlTZnlXZjRaSzVCa0R2Y3lPOHBOWGdJUE9x?=
 =?utf-8?B?L3ZhV1g2elBBVnEwNHhjUDlSbUZlZGtEdWlFQnBHam96U0JnWGsxRTRhK3Jn?=
 =?utf-8?B?S3lhbGhUbUlkeVEzS3hhbnllWjhzenJqWkJZd0RtRlhIOHVWVkdSQ3ZCZURW?=
 =?utf-8?B?NTRoVjNYYm9LWnlsVWF1MmROMGNqdXcrdytVSUFBb2M5ZllGN09JeUlzaDVM?=
 =?utf-8?B?SXhmTXJKSHdCODV1bWV4bG1jaHhJZnZVZzBBbkhKUDJWdHNtdWREamdmVDZS?=
 =?utf-8?B?dW5yd3VlN2xYdUhCeDNxVTZJYUhmMHBiYzB5RncyUXNTWG1sUHFkNTV0cGxH?=
 =?utf-8?B?Q20xVVh0MXB0bjlKQXJuZUpZczNTVGJsVmFyZzZGeVc0Mmx5SDE2d3o4S1ov?=
 =?utf-8?B?TDFRN0tvbjBwUE9MUmo2VzlJUTFlak1YZlNDTmxOZGpmUGlqTC9YNHllM2g0?=
 =?utf-8?B?STdHZzJ2Vzd5enpodk9yUTFrZ1A0QVh0dnlGaFJrS0VmditDRTV3NXlBbVB5?=
 =?utf-8?B?NWZ5VFJ0bERVa2tjbW4vbE90N1dZd09zNlBKZVZENEphUyt3STluZ3dtaUp1?=
 =?utf-8?B?aW9SVmVMczA0dGRnREtnVTZTWmZPcmgyd2hTTk5iTmxxUUxhQm5kSmpPL0Jx?=
 =?utf-8?B?TjRVSG52WmZsdnR3ZWxzaUJ4KzRVUUVsTWVkcXRlMjd5UDlNa2x3REV4Rlk1?=
 =?utf-8?B?U1pmUWFiWUZSdVBERk4xVGlucWVjVDJOZEpYK1VIdjVoWnNkZmRxUVhkdVBh?=
 =?utf-8?B?emFZSUVGUEJlWkVWSGpGUTR2SVpuZi9YOEcxVW5CTGl6U28zY1lNd0l6SjV6?=
 =?utf-8?B?THduQWhwWlZ0MS9MeFEyalByc3Z3WUJKWGpPcTcwRGxVS2N5KzhKemNXZ2Uw?=
 =?utf-8?B?dGpic1VoZVJKSXh0Y2NZY0c4bzJPVElZeWFXMlJWZnJIeXNUN1RwQnUwU1VJ?=
 =?utf-8?B?WGQrbHp5V2lQM09oSThuODNKQ0g4eUovcE9FVVgxakcxc0hTc2x5b1JJd0FQ?=
 =?utf-8?B?VVgyeWhYZzBYdW1vZXV6Ym1scVNDRjVFZFQ1cFF3NEovUXk1V20rT1dKY1pt?=
 =?utf-8?B?OFdKNys1b3pCbGlzZU9ESFVZbFBaZlJnQ1JCalJhRlN5S2VQL1d2V2pZRkFU?=
 =?utf-8?B?b001aURveVhPWDRUN1I3OTdUbG5yYW9LYVRDSGY2QUQ5MjhBTkF5dkZ0LzRZ?=
 =?utf-8?B?cjlzZnV0RXpxMGxvZkQrdktzN2c5bGhZOEtDdTlJK1J2a0RsYnRSOTBDQnJj?=
 =?utf-8?B?V3JiOFJNbEt3cEtJWmpGOU9UR0RkS1hmTXRjK21KN2lzNVdYaTd2WFUwOGlv?=
 =?utf-8?B?Z3FSUWVzRk82MEx0ZEVtQThTRTR3RldwWDhCK0NwWmNPTENGbTBHZzRnTVBH?=
 =?utf-8?B?MHZDM1gwNkVKNHczcmZrS09pblJhRWM2VGdocWh6bHRPR1JGMDhjUXYxbDRM?=
 =?utf-8?B?T3hCSXdweWtRd2d3eThOcFo5R2dDM2sxdkh4aHp3MDdBZUt4ek5LUE1GQmhJ?=
 =?utf-8?B?bTU3VDNOS1RxeDlRaHppS2hlT1RQR214UVJyUElDQk15TXVSMkxzMFp4ckhK?=
 =?utf-8?B?QXhvVWZMV2FjSC8zZXd0di8ydUF5RkJua3N4cGE0VXNDYUloTFRHSVRvYmpG?=
 =?utf-8?B?aHpPRldJTG04ZzhGclQ3YUw4Q2FDbnpPaHRsTWFkL2s4cFhEY3lvMUs2VnlI?=
 =?utf-8?B?a0dvcCtudUVBZllLU1pYZDlJY1EraEhCY0JpQ1kvUWV1MjlxZXBxOU5nZXdD?=
 =?utf-8?B?WTlPekNKNFl4SFU1U08vY3BmZlFwKzdnVUdVd2RzZjdHYkJGblJNNXlKUTRC?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc8c59d-040d-4a3d-6c50-08dbead88778
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 21:26:31.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlXn+5CE5odHXwKUi0Q9xI16yfLMFsWo7TJ8gN9AhFyJUVRXNQNNvqV37OztV/IQnsuwIH7uioQDgfyssyUO3qi8guM0M0J3jl2YenCYNLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-OriginatorOrg: intel.com

On 11/20/2023 3:54 PM, Jakub Kicinski wrote:
> On Thu, 16 Nov 2023 17:16:48 -0800 Amritha Nambiar wrote:
>> Add the napi pointer in netdev queue for tracking the napi
>> instance for each queue. This achieves the queue<->napi mapping.
> 
> I took the series for a spin. I'll send a bnxt patch in a separate
> reply, please add it to the series.
> 

Sure, will add the bnxt patch to v9.

> Three high level comments:
> 
>   - the netif_queue_set_napi() vs __netif_queue_set_napi() gave me pause;
>     developers may be used to calling netif_*() functions from open/stop
>     handlers, without worrying about locking.
>     I think that netif_queue_set_napi() should assume rtnl_lock was
>     already taken, as it will be in 90% of cases. A rare driver which
>     does not hold it should take it locally for now.
> 

Okay, will make these changes in v9.

>   - drivers don't set real_num_*_queues to 0 when they go down,
>     currently. So even tho we don't list any disabled queues when
>     device is UP, we list queues when device is down.
>     I mean:
> 
>     $ ifup eth0
>     $ ethtool -L eth0 combined 4
>     $ ./get-queues my-device
>     ... will list 4 rx and 4 rx queues ...
>     $ ethtool -L eth0 combined 2
>     $ ./get-queues my-device
>     ... will list 2 rx and 2 rx queues ...
>     $ ifdown eth0
>     $ ./get-queues my-device
>     ... will list 2 rx and 2 rx queues ...
>     ... even tho practically speaking there are no active queues ...
> 
>     I think we should skip listing queue and NAPI info of devices which
>     are DOWN. Do you have any use case which would need looking at those?
> 

So, currently, 'ethtool --show-channels' and 'ps -aef | grep napi' would 
list all the queues and NAPIs if the device is DOWN. I think what you 
are pointing at is:
<ifdown and ./get-queues> should show something similar to <ethtool -L 
eth0 combined 0 (0 is not valid... but almost to that effect) and 
./get-queues>.

But, 'ethtool -L' actually deletes the queues vs 'device DOWN' which 
only disables or makes the queues inactive.

Maybe as a follow-up patch, would it be better to have an additional 
parameter called 'state' for 'queues-get' and 'napi-get' that indicates 
the queues or NAPIs as active/inactive. The queue/NAPI state would be 
inherited from the device state. This way we can still list the 
queues/NAPIs when the device is down, set/update parameter 
configurations and then bring UP the device (in case where we stop 
traffic and tune parameters).

Also, if in future, we have the interface to tune parameters per-queue 
without full reset (of all queues or the device itself, as the hardware 
supports this), the 'state' would report this for specific queue as 
active/inactive. Maybe:
'queue-set' can set 'state = active' for a single queue '{"ifindex": 12, 
"id": 0, "type": 0}' and start a queue.

>   - We need a way to detach queues form NAPI. This is sort-of related to
>     the above, maybe its not as crucial once we skip DOWN devices but
>     nonetheless for symmetry we should let the driver clear the NAPI
>     pointer. NAPIs may be allocated dynamically, the queue::napi pointer
>     may get stale.

Okay, will handle this in v9.

> 
> I hacked together the following for my local testing, feel free to fold
> appropriate parts into your patches:
> 

Sure, thank you!

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 1a0603b3529d..2ed7a3aeec40 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2948,10 +2948,11 @@ static void
>   ice_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
>   		   struct napi_struct *napi, bool locked)
>   {
> -	if (locked)
> -		__netif_queue_set_napi(queue_index, type, napi);
> -	else
> -		netif_queue_set_napi(queue_index, type, napi);
> +	if (!locked)
> +		rtnl_lock();
> +	netif_queue_set_napi(napi->dev, queue_index, type, napi);
> +	if (!locked)
> +		rtnl_unlock();
>   }
>   
>   /**
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index dbc4ea74b8d6..e09a039a092a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2644,13 +2644,10 @@ static inline void *netdev_priv(const struct net_device *dev)
>    */
>   #define SET_NETDEV_DEVTYPE(net, devtype)	((net)->dev.type = (devtype))
>   
> -void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
> +void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> +			  enum netdev_queue_type type,
>   			  struct napi_struct *napi);
>   
> -void __netif_queue_set_napi(unsigned int queue_index,
> -			    enum netdev_queue_type type,
> -			    struct napi_struct *napi);
> -
>   static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
>   {
>   	napi->irq = irq;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 99ca59e18abf..bb93240c69b9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6400,25 +6400,27 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>   EXPORT_SYMBOL(dev_set_threaded);
>   
>   /**
> - * __netif_queue_set_napi - Associate queue with the napi
> + * netif_queue_set_napi - Associate queue with the napi
> + * @dev: device to which NAPI and queue belong
>    * @queue_index: Index of queue
>    * @type: queue type as RX or TX
> - * @napi: NAPI context
> + * @napi: NAPI context, pass NULL to clear previously set NAPI
>    *
>    * Set queue with its corresponding napi context. This should be done after
>    * registering the NAPI handler for the queue-vector and the queues have been
>    * mapped to the corresponding interrupt vector.
>    */
> -void __netif_queue_set_napi(unsigned int queue_index,
> -			    enum netdev_queue_type type,
> -			    struct napi_struct *napi)
> +void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
> +			  enum netdev_queue_type type,
> +			  struct napi_struct *napi)
>   {
> -	struct net_device *dev = napi->dev;
>   	struct netdev_rx_queue *rxq;
>   	struct netdev_queue *txq;
>   
> -	if (WARN_ON_ONCE(!dev))
> +	if (WARN_ON_ONCE(napi && !napi->dev))
>   		return;
> +	if (dev->reg_state >= NETREG_REGISTERED)
> +		ASSERT_RTNL();
>   
>   	switch (type) {
>   	case NETDEV_QUEUE_TYPE_RX:
> @@ -6433,15 +6435,6 @@ void __netif_queue_set_napi(unsigned int queue_index,
>   		return;
>   	}
>   }
> -EXPORT_SYMBOL(__netif_queue_set_napi);
> -
> -void netif_queue_set_napi(unsigned int queue_index, enum netdev_queue_type type,
> -			  struct napi_struct *napi)
> -{
> -	rtnl_lock();
> -	__netif_queue_set_napi(queue_index, type, napi);
> -	rtnl_unlock();
> -}
>   EXPORT_SYMBOL(netif_queue_set_napi);
>   
>   void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,

