Return-Path: <netdev+bounces-48203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310007ED56F
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA8AB20E32
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBDB45BFE;
	Wed, 15 Nov 2023 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bl6t8BIs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0119BC
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 13:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700082342; x=1731618342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xzwBjfA7ogVSrflk5pbMD1/9hiiSkoK7p4pWonLmid8=;
  b=Bl6t8BIswUpVwEEizZby/gCVgENpH7L9Rv3Hw01BJU25iGlUEvt+1fMo
   tn1zHutcZPpjNuADOB8pRzQ8f8EY2kqjO0YjsnCop5sKpPfHHGlnMNbb9
   wc7s8zUVoNay0LVA8d+eGB0kjqtpsJxRkpsuP+Ftwf7ab6fCKXG3Ogt3/
   9Bd8BrjvEjd/SdsmMDXiXK/djCxQL4Ev7ilB0bhWLYxb6ghvcQMzmn1u4
   y8V516Rck2PpNoKfrNTEXVHP7j1bQAMSIJpWlRrQhih3wRQaopa3uNHof
   owQY37DJjv7+hqdMYxfzfpUCPzUT2nB/XS5nv4wRxCv+x6UjjOW6WFhCA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="9596573"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="9596573"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768706263"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="768706263"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 13:05:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 13:05:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 13:05:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 13:05:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZVnzTj9eUIrvcPrSvz/CKGyfUiFXh7FWmfYJ6j9i0BpDCQUpDBZ87X1sJQLOyP3X8qhhwK8AjjDceWVpzS3fMpu+gPeMv0sKpsrPitVqEzmnu1vCoZ8bQFEeh60EPwc/cNgpWtX1++zXZUOJvUVk9q7OQ6hyvonR8QyBBsd3oisLroZa96R5YShtF8kQkPEwq93yJvhHaG4deQhdna8GLankp/318sjCBo+vMw8kcCVIcZAMp241IjNDoEzxJgVVrfw5ghoUYLFqdk/fFyZ9D4BeQN6lNeR5WemR3MiGOfMsslTzPFVWgI5CFZp+XJNJAF/TzQ+dXSYikZ0sK/66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJBWOaHdnnjgCu98H2BpFBRvavJM9lUteG3f7D7KmEI=;
 b=f6g+KTImqHsgtiNm6pU4wL2Cg5xpiB8nyvEnZfOafQXTg3lbvet1wh83arAKwqeoqXj3c11lOJ0fnOzmGta2HGOt25NPt99hF87AaU9jSSRjx1yyeV5uLiUJ6bvpw7a35iTwtUtrNvaFviUZLK1BuSyiDJKL+/a2bdNjf3ZBO8vyehsVVOCVfGSY5nlVR5UFcVDn22ZYJNANrDwWyCV0E0xB5ybO/5upKmYsqrGtA4FMWR7ZWpDuCj3N/AHyaG7XByH3jIffe9bwnyLkwpmAd3xE1BeFmB2k/ozv/AkL7Gc3+vdH3KrhUr9/AwVgDFUOU0dITQE6uz6y5xuICmda/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Wed, 15 Nov
 2023 21:05:27 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 21:05:27 +0000
Message-ID: <3edec947-a760-4605-9334-81c40ce62670@intel.com>
Date: Wed, 15 Nov 2023 13:05:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v7 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
 <169992177699.3867.16531901770683676993.stgit@anambiarhost.jf.intel.com>
 <20231114234801.0faee5db@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231114234801.0faee5db@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 26008478-cf28-4628-b0e9-08dbe61e97ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1RwQ+ZVdnfhm98D4wbTKq30mv546NyYOhSyCFnIzN6byo90K113yBCROkKeyZd/FRGV8jMian5Q3YGp9ByMCRfgcPxreJMmbfyYKne+ZQ+fwdbqv3JeTLbMSuQgttvq4zJ4PteXnl249XN1J1eRIXEYK/UB3U4jEzTyEKQwQOLiEnjrItbWJ+14i/v0es7RLkl4fqgbZHxygBTVi8p+matS/yRLipGCXtt/3Rz4EwCWwJQ0H7TTDALK+DDW80a21hb8Uw156snUfdxPz/oCBA/T0LDCuI3QGs3WUCVzxg9t4JmyAII3h+nXX2o/UicoLac3Xt73IS9+STH3GKqsoKmrlui2kN/cNS2I0Jvkm8Yg5qpdtiLwG0j37IljrQ8UF2ZAzstkuD25TtzMX6V7xbhzzJcA6Iol7VEWx+it+S2rNNZ0ogz0WUnbjpZrW3NBRS6urLZ5bTqwBGJ+PyRzwWOYz1KmXURZSFX6iYd2hiEp+pTFVBJcLlZnd9T/nEFgYf5oh4/j5uzpWI18I8oJpuyTzzB6ziILgGFP2btPyu4Y7snDMeLqIUWpuvLLUiyrl91PZKVtFTP/D1llQ0cI4+GiZ3pLPP+fGiyjNbEPHZVBuvZvB3KO/wymZiqkz/AkuAMUjUnKIEAh+mxtYUcgeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(53546011)(38100700002)(6666004)(478600001)(6486002)(4326008)(8676002)(8936002)(2906002)(107886003)(5660300002)(26005)(41300700001)(82960400001)(36756003)(86362001)(83380400001)(31696002)(2616005)(6512007)(316002)(66476007)(6916009)(66556008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9yMjBLUlZIUkllZWRrVVRrdnNUTjBLUGhCVUFkS1VVYjJvb2k4NlhOanhC?=
 =?utf-8?B?RnVIbDlpVE84NlcwZ2w2d3B3T3hOZGE0Tm9JZ0hPQU1GU1ZkdVZmVlRUV0V3?=
 =?utf-8?B?cURRaW1YSm9BZFNPdGtLUUpwc29ZZU9rSlpERlRzK0hRaGszc0hyVHg3K3Ry?=
 =?utf-8?B?akFSZEtyTUlZOVhHKzRqSEpOdmN3VnlJUldBY1g4MnBEMXcrdXdPQU5iQUhK?=
 =?utf-8?B?bzZ2ckRZMis5MG0xaE1LelNXNXJxTlNnZElESGpDUnN3dkxzNXRmbEdFaTRC?=
 =?utf-8?B?S0JIelNwRFRBSHlUVkVkdHpoWkdycmdFM0FLZTE1NzdUTWNWZFpuSnhrZEYw?=
 =?utf-8?B?VERNbnlvYXV5R0psZkxHNUtmcXBibllHNXA1anMveEVraWRnblRGZWowcENx?=
 =?utf-8?B?REwyelhGYm9TcW5wK2x2VFVkc3U3OUxTZnUyc3VLSWRFMzk3OTc3TWt1Vkth?=
 =?utf-8?B?dTN6RlhDR2pZTTAxK0ZzaWI3cWx5YklEbjkwMmZEVDY1b1RmbU5mUGxlWVlD?=
 =?utf-8?B?Wi9oMzVTWWd5aytNR29JMythYTMwZEM3ZWxoRkN6Q3orVy9CQlc1N0IyRE9l?=
 =?utf-8?B?LzJ6MlJ1WXhxVXMrc2NMQzZjbmNLeWt3ZDVndUxabG1MWWpMQTl4N3pEYWhp?=
 =?utf-8?B?a3BJU21UeDU2M2tkTWh2Y3hxcUdDcFZmbzg0UGhVc1FXK3NSZFQ2eStzL25x?=
 =?utf-8?B?enN5WFVaRjlXMjRBTVN4MUdodXJSeEJHZUFhS1h0RytIOHV2ME9BaGsvUkVp?=
 =?utf-8?B?d3hQbFpZVTY3MkE2NzRaN0ZTTnpQbVNEY01BWFhDSDN3bWE4TkJXSG1LNTdm?=
 =?utf-8?B?T2U0dmhRY1JlQnJ6b0IweEU3d1hnMS9aRG9mejk4R3FJbldkYWhBVFV2OUpz?=
 =?utf-8?B?ZlpETkR6SXArak1iNjIveFhic0JPeElHeU9MNmdtdGhmUEY5VHk1K2VyMmp0?=
 =?utf-8?B?bXc4WTZaWTUwbmdWNmt6bXl2S1ozcWJLS3ZZV2dGSkh0WGhsNVJrWXRlbGxn?=
 =?utf-8?B?cXFxMWlRL2ZjY3VTZUVqSlhwaW42MmNTN0NyZXFrWDRadE5udGlRNGliS0Q3?=
 =?utf-8?B?R3AyTzBOMmtLS290RW1TTXpXMTlqWE1tcWVjeU9TcExGd1V3Qk1hbnhPYURj?=
 =?utf-8?B?N0lteXg2NkZxNUFnZmdVZWFMVm9tL0xzMVZrYUlEVW5lK1Y2eS9mVmlTei8w?=
 =?utf-8?B?Mjd6OXhiNnZPTjd5bVlMOHVMSVA1WXhsaHluZDRYVnBmdDNGd2oyeDlLMXdK?=
 =?utf-8?B?czJLaE9YakZkNXEvV0FFd2J4cjlpc2hUMmIzVnNMbXQxSXZXYXY5RkJDUXl4?=
 =?utf-8?B?YUp3SGp2Zy9uNjZxeUxlNEN2T2Z1ZlMwbWh1cG5xZ25WOFVmZG5MbXA5eGMr?=
 =?utf-8?B?Q1NGYW5HMjhaZWNObzFvUXRMMzV2N3NCbkwwbUZUZG52ZWVYYkRvaWY2dXZm?=
 =?utf-8?B?cHhRRWdZRmczemJUcFdHaGxUOERoZHZyRUthY0xOb05rRG5lVk1uWGo3QXQ1?=
 =?utf-8?B?QVFRZEFpckhkbWg4d21TNUE4VmVVOVpieDBXRTFDVGs4LzR0QnlNaEZ6U3pp?=
 =?utf-8?B?N2swc0pzOWZjYjkyNERmYk1RYXZJQ1Fwb29wL1Z5ZWJCOVZxM2s1bitJVlY1?=
 =?utf-8?B?MmM0Tmd1Q3llaHFYTjJlT1NDWC9WVDlJZHY3ZllrbmMvWHZSRE9hZ2xRaTA0?=
 =?utf-8?B?bVRLd3pQaG1palZCSXUyN1VPN1BmbFJuOGREN2N4YTBXV0toZmoxZjFUOG9a?=
 =?utf-8?B?elJCU3dmakJieWdQVUhvR05LRmxYcWFnTzQ5bnRvdEVlWnJBMk90ZGVlVGRy?=
 =?utf-8?B?OXlLM3QvZDliTVBuYllyRW1zWnNZMWhtVWNScTF5enpGU0RoV2Q0ajNZZnZs?=
 =?utf-8?B?dTczSWFIb000elFwY2xNdk9WdGdUK0JWN0tjYlRQcUhGb0srZCtvcFdIcEd2?=
 =?utf-8?B?RjNJY0NVeGYxOHlES05GTWI1aEFqbC9MRG5iREhOUGErZlJINzB3RWhwKzA3?=
 =?utf-8?B?SjJ1cDdxNTU1WDRCNmpxRlJpaU9TVTliOFJXQ1JnWHJrbGZDWjJnc0M5RWoz?=
 =?utf-8?B?RE1TWEI0Z25WK1k1YlVZNk9wRUZyaDAxRG12N0c3bW95N3FBZ05ZMCswY2Y1?=
 =?utf-8?B?WlVkNjZId2JmVG9pbWZtMTZ3bmpleGMwcUg4cnBURyt2NXo5cFhQL2pCM3BY?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26008478-cf28-4628-b0e9-08dbe61e97ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 21:05:27.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTQYdBUDdQP3kwsALFaBIW2qVt5UGjWDootcRh+rMrLnJdZq0QkJ5yLpl9+OlPi12irpt2qfJbJRyDxSlyTOQLVIn0tte0FgFtjKweooSdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
X-OriginatorOrg: intel.com

On 11/14/2023 8:48 PM, Jakub Kicinski wrote:
> On Mon, 13 Nov 2023 16:29:37 -0800 Amritha Nambiar wrote:
>> Add support in netlink spec(netdev.yaml) for queue information.
>> Add code generated from the spec.
>>
>> Note: The "queue-type" attribute takes values 0 and 1 for rx
>> and tx queue type respectively.
> 
> 
>> index 14511b13f305..e7bf6007d77f 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -55,6 +55,10 @@ definitions:
>>           name: hash
>>           doc:
>>             Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
>> +  -
>> +    name: queue-type
>> +    type: enum
>> +    entries: [ rx, tx ]
>>   
>>   attribute-sets:
>>     -
>> @@ -87,6 +91,31 @@ attribute-sets:
>>           type: u64
>>           enum: xdp-rx-metadata
>>   
>> +  -
>> +    name: queue
>> +    attributes:
>> +      -
>> +        name: queue-id
> 
> Hm. I guess it looks okay in the Python / JSON but the C defines
> will say NETDEV_QUEUE_QUEUE_ID or some such. Should we drop the word
> queue from all attrs in the queue set?
> 

We could drop the word "queue" from all attrs of queue-object and also 
the word "napi" from all attrs of napi-object. Only concern is, queue 
object will have NAPI-ID as "napi-id" while the napi object will have 
NAPI-ID as "id". Same values but referred to as "id" and "napi-id" 
depending on the object (although should be fine as the command names 
carry the object names).
Here's an example how this would look:

$ queue-get  --json='{"ifindex": 12, "id": 0, "type": 0}'
{'ifindex': 12, 'napi-id': 593, 'id': 0, 'type': 'rx'}

$ napi-get --json='{"id": 593}'
{'ifindex': 12, 'irq': 291, 'id': 593, 'pid': 3817}

Let me know if this is okay.

> Sorry, not sure how I missed this earlier. Some extra nits below while
> I'm requesting changes...
> 
>> +        doc: Queue index for most queue types are indexed like a C array, with
> 
> s/ for/;/ ?

Okay

> 
>> +             indexes starting at 0 and ending at queue count - 1. Queue indexes
>> +             are scoped to an interface and queue type.
>> +        type: u32
>> +      -
>> +        name: ifindex
>> +        doc: ifindex of the netdevice to which the queue belongs.
>> +        type: u32
>> +        checks:
>> +          min: 1
>> +      -
>> +        name: queue-type
>> +        doc: queue type as rx, tx
> 
> Add: ". Each queue type defines a separate ID space."

Okay.

> 
>> +        type: u32
>> +        enum: queue-type
>> +      -
>> +        name: napi-id
>> +        doc: ID of the NAPI instance which services this queue.
>> +        type: u32
>> +
>>   operations:
>>     list:
>>       -
>> @@ -120,6 +149,29 @@ operations:
>>         doc: Notification about device configuration being changed.
>>         notify: dev-get
>>         mcgrp: mgmt
>> +    -
>> +      name: queue-get
>> +      doc: Get queue information from the kernel.
>> +           Only configured queues will be reported (as opposed to all available
>> +           queues).
> 
> maybe add "hardware", so "all available hardware queues)" ?
> That may help the reader connect the dots

Okay.

