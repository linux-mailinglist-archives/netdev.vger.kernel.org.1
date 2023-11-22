Return-Path: <netdev+bounces-49846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7247F3A9A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEBC1C20E03
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48919A;
	Wed, 22 Nov 2023 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuFR8rMC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A93CB
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 16:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700611697; x=1732147697;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HhX1Ea/wRob+RZJkTZceaKIxpsh50QPqRFyLQ8VBgFY=;
  b=GuFR8rMCuo/POo/YMr6h8Wko+5mBQ/wab+uxEli0jXuuXb3OSI0a8xO+
   ptlD11FkEntiTjGVi4ZdU17ehyAgxodvWSYqjWprd74e1rv/6TKPF5mkP
   X57viL5IcU6p9sQvZbW0n/nAqPbhKJZjHEY6mw4qEz4bX/Vnlg43E2wYs
   gUBjaj4xylr0mkmqKuQE8C20e5I8NPug4L5uihy00vt7Fnj7nxnE7Xy2Q
   llrLywbdteqSWucptKDT9/N1jW7+btAvsSN8sXTKPGxPokW9fJklPlTfu
   JJvc3ryq+4f5z+Wp0AAUEhQfTVQUfKsbSbV93SgnWYgiKzyiKNq4zu2xH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5083176"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5083176"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="766813757"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="766813757"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 16:08:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 16:08:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 16:08:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 16:08:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSa9JVfbn/qff6JuvpdRcBTpVyj24eJbrBfICy3FYy+tL/zXd6Klo5PF7lQZrlvb7wCzZ4rdHt6YdVonVaM92iaKoGzJQGSPZkIMNEZbAxb8EyIcQemuMMCuv7iGPXOMJ4e3vfIyXKpHomDUlzzOWuTRI1gtD9vxC/Vh1JB2OYNiux3m1S0gWr3A/nJ5o1CC3YFE0M7q9McZV8of308jBFUhkERq/OnEMbUmDqofJ6T2HSdmkStHqSdgGCcmLkevcbFlEhKw1v0tfKsH7CbMEZpXdNENlwR9OSsN3hzJbuXoA1GuXH7x9ZXunaz0lYoqT1rgsi9xGvghV+DgXpc3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKU9guF7NvXU5QWE9XSuGlH+FPAU3D7kYNxvw3yxdH0=;
 b=AunpBBOB1wjXuLrInxsnh5sNgpFaKTHZu9E7gdUEYE9vNFiPIzu1YqWPRsad2Nsqp6jfje+j7E4L6agPoi89fHQVNFx2QmzdMfkpScbxAEoCVC9LxmONCO0iDFT4SrbTWgmbcEZUHhbZdxco808ChIPS6RGRdRmEX7uJp9Nb6jyXgz0BLzxR1oKwCUxUtmid8GCgos7ooIKMBHD3kyvkz8Fl9OHvR8RiGyKToqPTL+c8zlIibuLsCSa+DCCKHla1NfHnc41FzXSh7oVeGdyzAVQ7bGdUix0ym+YEH/nYsNKNiH/BsT0dlUYbqR6FPyAIPI3bAVIcNWIbkouO902ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA0PR11MB7789.namprd11.prod.outlook.com (2603:10b6:208:400::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 00:08:12 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 00:08:12 +0000
Message-ID: <d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
Date: Tue, 21 Nov 2023 16:08:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
 <170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
 <20231120155436.32ae11c6@kernel.org>
 <68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
 <20231121142207.18ed9f6a@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231121142207.18ed9f6a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0256.namprd04.prod.outlook.com
 (2603:10b6:303:88::21) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA0PR11MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: d7efdb40-dec8-4481-3644-08dbeaef1d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doqylW+WolbSE7gZlnftbIengpzGrApIVx+vp8ksBK0n0DvH772E4tdGaoN+qarw5iI8JMiUT2bOdhSZy9F/tjHy6oSjxBDBeZSk/uT9E5LqEdJ1XL8wwK8PUO+jBAiYj6sgehIf8u4CB73qiYF/uJmJbtzioq1keJSJpcgRgqOHz20URHmOEKhtLXlcmMD+VtHgWqnGc8QO2Ypv/H52wnPChq2OlVBpcZxGiXM5mF5xqGls3bZoNNQ2wrGUWrJQWkV8cCSEaJtFTgTTj0A+xOaG0uO3toysux8eqnrF09cQrBB0KtUh24yuVGdV6tK+CNDFcSTpGHGaAFMGkrgw0EnpnRI8N7QfjjSYFu/EVoObn9BKI3kaxSSaEmko5GRf9k6xrPeqKRybyhsvq3+j5Cf+62Oo05r1zi09I8M9eRf/jLUfO40u2v1MDEfaxlCnyIRzjTMLUsZGLnuJbWMAglVIgvOHfwPi/+9y4sxqnU2qWlkc4mkSOWGzxByCKZu+O2KpaRMmSVNcnnG+H/Wf25t2r3jDfV2XLPQshF5clnVZkfvR1ef8bwPaMWYW0nZq2smwiXcc6PJgyTZF80QNfUaX0k6VWLTw+Q2KWCRCN3zb5g6ooTpk9YWVdNl29Vi0ehDyqVgVyGde29Vt/mm/Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(53546011)(107886003)(6512007)(83380400001)(26005)(8936002)(8676002)(4326008)(38100700002)(2906002)(5660300002)(41300700001)(478600001)(6486002)(6506007)(6666004)(316002)(66556008)(66946007)(66476007)(6916009)(36756003)(82960400001)(31696002)(31686004)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckJicWYwOVZTemdaVStucTRndnFqSHJEdHE2MUltckc4d0kyeE0rblFTVEh2?=
 =?utf-8?B?cUpRaEVMbytnSTF6SmdwWEtWb3BRckxmd3U4Mlo0M0p0cXpUQkJnb1pSS1lH?=
 =?utf-8?B?TUdPcG9tUGt4SnBCeHBPN21pc3Z5bVlTd3IrNlJic3ZnQ0F5cGlYWjBDdUVv?=
 =?utf-8?B?UVU2RmVNVGZRdkUvbEVnYmg5WUcxdndDUDJjUDJxcHNkYzlzSXQ0YkNXWi9C?=
 =?utf-8?B?dWw0WGpTREZoa1dwMGRCaXFEMmtCekZUNDhOTmMrcVNMRzlxYjRjR1Z5cFNP?=
 =?utf-8?B?S3NyLzd5bUc3STVhVkRpT2NlbnRXYXllVXZDYVFCWnJHbHpHa3NyLzZxdmNK?=
 =?utf-8?B?UDgvY1hDeUR5VXFTeTBRRGE1Y1BPejJGNDRiQUgzU3NhL1NPOThXam90ZjNU?=
 =?utf-8?B?N0lCakovVTRRU1BYUUxKN3liUzJTS2lzY3NMY3FZOUVZWVp4Z0czakxRdVBN?=
 =?utf-8?B?c2NXTEFMN0JrL1FVOGhvbldGcDRxT2pBMDlNOWhOV21tK1Z4QkQxVlBLOGYx?=
 =?utf-8?B?UFdDVllIMlR5a0NnaFhoNjNrVkROOXhTNTE5czNaMk1DKzVKNGd2V0tqaW5V?=
 =?utf-8?B?V2FjOEpWTEZxZHd6bWd3L29UZFYwdVZDWGZXSU9LODU0VkkxTThKMlN1eWFs?=
 =?utf-8?B?bWpyNFNEUUlYMHVGSXF0TUxwZHdPRjMvVlVOUElxRlFTbThsVGRpYVlxbUFZ?=
 =?utf-8?B?ODZoQ3ZTNmdZNXlpZHMxY05rRnJMODRKTXEwMUR3OXFEaHluZkVzdFhQbWs5?=
 =?utf-8?B?aGp0V1ZjRTdjUG1NNW1tNWRoR0gwYUwvemNjZGdmazhUZVMvU2xkbHdaNHUy?=
 =?utf-8?B?ZjQxTk0rSlBVdTUyZW55WmdjOHVUclN6TWNhK1JtdzY4czFFOWNSVitzdGla?=
 =?utf-8?B?WWxWU0dFTEt3dDRZVnphUVhxb1Fja3doTDRnSERueVBKS3NwMWd6L1orUmIx?=
 =?utf-8?B?NEV3L0N2TVUwU1V1RlY2bW52eThzUzNDM2wzYUErYWQrbE1zQy9aSGJGeXd1?=
 =?utf-8?B?WDdIU0Zteks5R3hpVGwrb1R6a250eVJ6dDN5OEd1bkZ0WnRqUGtEVTFBM3Bi?=
 =?utf-8?B?OGp0QUN3NXlybmY0Z0RsU0VwaW45Y3FaNGxneHc4VFdZa2hocUNjWDhjWDZt?=
 =?utf-8?B?d016OGNFMG5GL1IzcEN3YWlqdHorb2VzSnNiM1A5MllsUkVTZFAwUUNpQUpE?=
 =?utf-8?B?YlRuOGpmc1Z2TjJIUGJWYms1NGxIbWQ5K2xPK2JqNC83TFBVWkw3b2JGalV3?=
 =?utf-8?B?NUxRQ1ZYWmJ5ZVNzRzN0YUtUSnJUbEdrVFVSa0xxbnVySjR0VENwZEZyRFFS?=
 =?utf-8?B?VmQ1NE0xR0xYM0tTd0c4ek91cHVVckxka0JneU1Uc1RqZ3FxRDFoWlQwZkdG?=
 =?utf-8?B?UFplNUVDblE1eHlmMk1UcU56M0pVMUphSTNZeXU0WkRHSDJpZEd3YXRXYmlX?=
 =?utf-8?B?TVpRWDVFb2puS3VJalIwQkRLQTZReWtmRVVZN0hDQXQrbmRuN0M5eTBEdzg4?=
 =?utf-8?B?ZkRqZjE1UHlMWjZ2a01QbnFNOThjTWxOUmNmMmIxQVpNTlM5R0VnZjZwWkhY?=
 =?utf-8?B?ZzhjNnF3ZFpXNmlaY0NNd2RTTkgxOTNyMXBRQ3VqNzJFbllNSUpxTEpPOEFx?=
 =?utf-8?B?eG03R0k1V012VjNJYjMvSXdtT2dxK1I2b25lYW9hRlBDcHRuUHc3a3lqaUxj?=
 =?utf-8?B?UXJvaGEvNC9PUHpWTnlTc3l4a0hJMTVqNEJtakZpazFNMURXTVNSUmVQOEkv?=
 =?utf-8?B?R1l5NzJoV1dXSnJ4SmdBY2NrWElCTWZNR3pna1FSNzhnZlJqam9DUmxoVmpy?=
 =?utf-8?B?WTNpQUF4VUpDaUVES1I3RFJzK3QxUWd0NEY0V2V2WjNKQjUrbXFNZ2d4NnhD?=
 =?utf-8?B?Y2UvWFBTdXg0bFE4RmgzaUQ3bTZQYTFYUkxOYXdWcE1YRlp1Nlc1U1JVVG0y?=
 =?utf-8?B?RWRTVUNtSndTWUR5bTgrR1NWTWxnS0tKLzBFMWlBVlJPNHdpVUh3cEpYQnla?=
 =?utf-8?B?UVE4cWI3aHUrSEpOcHBabkF3b2orQ3lDUzhzZXljNlp1VmFIS3UxcUpJV3VY?=
 =?utf-8?B?d2pQZjVrNGg5eEM1SzVmenNHSldrWFhncjZtOVRCdVY1aC8wS1c0UlRzMDBw?=
 =?utf-8?B?NHhtVThoanVjc0E5eGUzeFVVM1RXcWZhQlFMYlNCUGNEaDhKTlRXNi9XcnZ2?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7efdb40-dec8-4481-3644-08dbeaef1d42
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 00:08:11.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChBp1CHTfq6+g/8sBrYgfYCbFQuuok89oSbd0uUEGve2TAEeQ1KzKvlI/G7mWAzp/pazcVy229Vx6TGUHz3DUQ/PrE2p17qZ6SOzLL+TG94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7789
X-OriginatorOrg: intel.com

On 11/21/2023 2:22 PM, Jakub Kicinski wrote:
> On Tue, 21 Nov 2023 13:26:27 -0800 Nambiar, Amritha wrote:
>> So, currently, 'ethtool --show-channels' and 'ps -aef | grep napi' would
>> list all the queues and NAPIs if the device is DOWN. I think what you
>> are pointing at is:
>> <ifdown and ./get-queues> should show something similar to <ethtool -L
>> eth0 combined 0 (0 is not valid... but almost to that effect) and
>> ./get-queues>.
>>
>> But, 'ethtool -L' actually deletes the queues vs 'device DOWN' which
>> only disables or makes the queues inactive.
>>
>> Maybe as a follow-up patch, would it be better to have an additional
>> parameter called 'state' for 'queues-get' and 'napi-get' that indicates
>> the queues or NAPIs as active/inactive. The queue/NAPI state would be
>> inherited from the device state. This way we can still list the
>> queues/NAPIs when the device is down, set/update parameter
>> configurations and then bring UP the device (in case where we stop
>> traffic and tune parameters).
>>
>> Also, if in future, we have the interface to tune parameters per-queue
>> without full reset (of all queues or the device itself, as the hardware
>> supports this), the 'state' would report this for specific queue as
>> active/inactive. Maybe:
>> 'queue-set' can set 'state = active' for a single queue '{"ifindex": 12,
>> "id": 0, "type": 0}' and start a queue.
> 
> To reiterate - the thing I find odd about the current situation is that
> we hide the queues if they get disabled by lowering ethtool -L, but we
> don't hide them when the entire interface is down. When the entire
> interface is down there should be no queues, right?
> 

"When the entire interface is down there should be no queues" - 
currently, 'ethtool --show-channels' reports all the available queues 
when interface is DOWN (for all drivers, as drivers don't set 
real_num_queues to 0). Is this incorrect?

> Differently put - what logic that'd make sense to the user do we apply
> when trying to decide if the queue is visible? < real_num_queues is
> an implementation detail.
> 
> We can list all the queues, always, too. No preference. I just want to
> make sure that the rules are clear and not very dependent on current
> implementation and not different driver to driver.

I think currently, the queue dump results when the device is down aligns 
for both APIs (netdev-genl queue-get and ethtool show-channels) for all 
the drivers. If we decide to NOT show queues/NAPIs (with netdev-genl) 
when the device is down, the user would see conflicting results, the 
dump results with netdev-genl APIs would be different from what 'ethtool 
--show-channels' and 'ps -aef | grep napi' reports.


