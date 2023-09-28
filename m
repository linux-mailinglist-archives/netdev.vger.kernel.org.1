Return-Path: <netdev+bounces-36945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9037B28A3
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 01:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB2E9282AA9
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 23:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DCC18044;
	Thu, 28 Sep 2023 23:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DE9CA6A
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 23:06:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA99194
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695942372; x=1727478372;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLyTcoKDyqtqFRB/Svv699TVy8woDkuLMDaBrQJTO9c=;
  b=a/vnb/tsHyJP9fr9NeXLdyiENiAwenGkFLrDHYPtGIsscDqyD0lh34w9
   PRFAV73C0DlgH/DXFmVcu5DUZ2R5zC0fCUYx9gInvTkIj9tcuXtdnb6/a
   P/jP5lYKRMBugtjawtouviStqgA8kdp3ekGWwm60GOo7bFuOp+MksvPWt
   yBQ5Iq2LUUSZLyQ1QN7CojEoaljfIKfXcVyQLE5IvQqYDkACwpkG5Ea7w
   rcQw6/RZy1a9mEreOHdpPiZai2t+GtimhFKowqrmG6jZZg0zf11hRKb2B
   4V7PN7Hf0bNrR46PVmVh4k/k3U106jHerwaDwTSTe8DR31daBds3U2NuC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446357375"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="446357375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 16:06:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749775399"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="749775399"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 16:06:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 16:06:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 16:06:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 16:06:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFFduojxftL0JDFzSdXm/YWypOSmkMAcKwz1gxboGw2y0e8D7951+i3Y5Cyr6HPQMi/jNskS5x9/fknCOfyT3b68fh4uoe7/1FESGP8ENth8VxAZdoTV/pAuhRfjMZ9nPAL5VPs+Z5tz/5FiyMH1hbcp7rJxkFevp/3MWX9MbzaxvcwWhTUsiIXancDAzdxOEzzLSDNmOZYJv/pHVTA6mAe7ctfSYYpqeKXXgqsrr3Y8IYiDdAPiDWi69epwS6U8JCdMihmG4A2YOV5j6+eNISEXomaerySuLwB+azt20jRt9h1B3WxAVkDRDkmuuojgrwEwZmJhXzxlJdbNOd2UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwxgZYjB4t9RU1mUKcJzqJ+t9FF7QybQG5wZR/hTj4A=;
 b=cCuNEfg75zkmQsAdiJ6wJOh3CJuAfPbOLfLDHz7NWvayYbOCqngT8/VhvDa14G6s8E2f+omnJozX1X3FJCeKbb4zVRlfZjPMEoJZt00STH5knZeVXE+BCOyeQQ633EyvCrJVGk1DWiyk08aXwXFNzHQLW3FHVbDn6Vg33MLq5BGMrijSKgjI+vo09L81ZymoLs5kYBpWo8ZgzOJp/AVT6IIhCnn9qpFjDlHwp4iORbyjgvFTozbnNIrcitPCzJaYqtBDjHl7xntfd8cHGto0m2tpbc7eqxo7KWFtHamcuV7FPFZJzAoqTNxNqv1YPlqMM1CGOHgLmPJZcbH8XavyiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Thu, 28 Sep 2023 23:06:09 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 23:06:08 +0000
Message-ID: <ed15ae77-d97a-4192-b27a-995881d0a13e@intel.com>
Date: Thu, 28 Sep 2023 16:06:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <sridhar.samudrala@intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
 <169516244040.7377.16515332696427625794.stgit@anambiarhost.jf.intel.com>
 <7b83b400cff5ecb7e150e4c0a4bca861ff08b392.camel@redhat.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <7b83b400cff5ecb7e150e4c0a4bca861ff08b392.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0383.namprd04.prod.outlook.com
 (2603:10b6:303:81::28) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fbc4ec-b5cb-4b93-e666-08dbc0777fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or/7NHEKGiWVFiG5YytzW8K+xRBTmpm2niW6qTuEGK5DjDdf5OEfLj8QdU+K3DbZiGj6Qf674E4LVwOeT4aR8pg3I867Y23vNhByD8RdfJwp04HO45qgT34rfvCu6HQY6YBDnKlyjdQr8XeTBqVdfON2momcQFmLLhz4MaixNFEiJmu3mxE+EAfv0+q4MfyWKF4r2wv6767tPBwNerz6W1/z1O5EWKU7LJaY6Jy4gmMR7XPBCxi1IIk4Lhjl3//rWBzt5jpm4Yb+voeBqp4R0aSoMO2jTsyjjerQTARxZk0iUIWLCPqCM5tD5SqPqPTTLS/PMwSTMCL+a+fM1QLPWeOhq57mjzlp3K1tNGXdJoMxJizmYkIQTQxYiXnJ0MqE/SKqnR7pvwXa8dWtnOTKDzT/tlCDSx14aPcZ5yX/e8fmejzaQhfkfoMpNXpat/qCoj+ZFyfLBnzxUTqPJnptk8pXp53/HnGNczJYSDAkpLKddGUUKMk5BLYa9uzW6AV7s1bCXfclNCS3ko76DW4IDHC/UUro1XYfZDuAsOBzF5Mb/C3wcSgLOFQhuo96hNaz1ylSgD8BTT/GZKHOmTyQ8KM1SOw/ZLB2sjw186gtqxPG7yW4bwPgMFQY76hlWvyrXHLgpOG8ffyOUzMWJAEypw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6666004)(31686004)(31696002)(478600001)(38100700002)(82960400001)(66946007)(66476007)(66556008)(86362001)(6486002)(26005)(107886003)(2616005)(6506007)(53546011)(6512007)(5660300002)(41300700001)(316002)(8676002)(8936002)(4326008)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG94UVlaM2d2NnZCRjNNeVpOcjQwNWFsTGRkMWUrcW9pWWp2c2Y4b0J2UmNt?=
 =?utf-8?B?d2c3YnJTL0pqckxaWDlXTFE4SkNGSitrTXpBeU9PbWF0UG9FeWtSaWdhNkUv?=
 =?utf-8?B?M3JjNEVIWXZHS2hmeERPeVo4dGR3VG5OcEFmelNCc0JvVFY1azFLSmJYTTYy?=
 =?utf-8?B?T3Q5VGtwbEZuWVV4YUQ4M093N2Q2dEdrVUtiNzNhZG1mVDlzYXNWcEMzMUJs?=
 =?utf-8?B?UnFXcmszeitZbUI2TUdQYUNSWTkzUUNkeXBtdU5jVU93c0dqekw3N1dDQ2tu?=
 =?utf-8?B?clRrR1lRaEZwdVhFbU01UlpCdUZ6TGtVODBvVi90L0hsUUZSaTVIVDJmYzBz?=
 =?utf-8?B?NkR2a1d4d2xtL1BXQi9UUWlrZmk2ZFg2cS9DTlpCekErM1ZjTnd6WDlmV01Z?=
 =?utf-8?B?bURzWmZmRHVnQTc4V3RZcXk5M3JwVmNpZ3NZbEI5QTEvSmJxQ2JrS2F5dXlP?=
 =?utf-8?B?L2lBWHlOOGFTaHJPN1FLVzY1cjczenR3N2NxUTlKa1dmQTVoZHplTFB5bFRL?=
 =?utf-8?B?VHB4ZTAybjRBSnhNd2F5dythcUFKY3djQk9uUWJGZzF1bFBzbDg5WHQzY2o2?=
 =?utf-8?B?LzJiZlJxMGRwSEh5YkkwU0JoN29ZTXR3aDZoOVp3MWlKeTlIYmtIbnpFQjgv?=
 =?utf-8?B?bjNtaWUzQmduVk5RM1pwcFQ0Yk83ZzFpRTdtWWk4WlZsY0lVcmI3cW5tZFVV?=
 =?utf-8?B?ZjlMeHlkTCs2NjBydGIrN0hlYnNQRW5MZ1ZDajdueGpBa0h4MUxDYTdPYWJx?=
 =?utf-8?B?N3M4L3FiODB3bWJMc1g5Uy9XTFI1clo1d2pJb2JsckkvNSt5bWttR1NDQkxs?=
 =?utf-8?B?ZGp5RU9MOU5USjFaTEZ6YXRWRHFnbDVJOUdZMk1kRG1lYXkxZ3BGck1QbzIw?=
 =?utf-8?B?RDk5VEllTzVjY3hlWHVsYy8rN2gyMzdPNFJObDdZWklKeHR5bVlPcS9ldTFU?=
 =?utf-8?B?cTZyNTVSUlRCSExNWWVEdERlUFZaMGZTK0cwRmM2ampDWXFNczkzWWFEdExE?=
 =?utf-8?B?MG5VQ3RJM05ycXIyVXBBSnJkMEU0ZVhPS3lWWm5pS3dTTStrRm1vYUZHVnJ5?=
 =?utf-8?B?NDFTcXNEM25KSVN2emFtVS9OUFAzcjdTOWsxYm5qZytzbGtzSHBQRlc5SVNX?=
 =?utf-8?B?RFRWd25IbVA4bHQvaUhLWU52ckVSM0JnMDUvWFdyZXo1NCtSd1E3aC8zRVQy?=
 =?utf-8?B?S1NtZTJ2WkpaRjRtdjV3b1BnQnExSHQrc3FMeWNqT3Fnc01vajZQeXJycGtY?=
 =?utf-8?B?bWt2cWZYK1Y0aHBibzY0bEV6UXYvRVRYandkTkE0cWZLR2V1VElJd29WYU1o?=
 =?utf-8?B?WWx0N1BneFJ0bnRsUW1GK3BKQ09tNm1vdUhQNkJOQlI3RWJvVGk0SG5wT25T?=
 =?utf-8?B?dHFvN096ZUF5Y1UvTUhGbUt6UG84REsrU3E2bkY0UVhrZmNLNmdFOVZYKzlH?=
 =?utf-8?B?eHJ0SDZRcitOaXVjQnlQdUpNNVVnS3MxaXBFWE1XbEcwVmJrL0Z0MTJGTjBB?=
 =?utf-8?B?TndTS2QwbDYzUzlZb2pDWWNucGFWN2lDZ0VOSElPSmZ1RmZxN1N3dUpWbFpy?=
 =?utf-8?B?djFvOUh5MXdzb1YvWmhwTUxxaHBvQWlZUE45UlQ3bmVzZEUwVC9veEowc0hL?=
 =?utf-8?B?TDFvTWZGd1haU1hLOFQ3VHFWYWNzWkNFanFaOWZ3UE50eFhOZHNkdFRRSHhy?=
 =?utf-8?B?VlFxSmhTVXZXUE53aS9nRk5RZnRBcXhPalJVWnNVUUxCdURJQzJyS3FzaUR3?=
 =?utf-8?B?OFI4cEc0LzB6bnQ4TzZWY1pHcmhOUkZsamNmdGJBVmQzVG1TeVlLQUl1S3pH?=
 =?utf-8?B?a3FlU3lSS3pTSjUvalNPOTJTMzQ4M1lzR3dWVlc3VHZVZE5ObUwrZGRERFNE?=
 =?utf-8?B?SWQvWXRudUNMempiMGpoZiswQVpXaW15TVJjRWFSR1dzQ0tsTTIwVnNVd3lI?=
 =?utf-8?B?SklyZ2NsYjZoaU0vbG5CR2VKaENPQzd6WWxmWTNXQjM5T1ptQWNJWXNsT2l2?=
 =?utf-8?B?TXhvTisyaXFWTU5tR21kcTJZekFIeUlHS1A5RU1MVVh4SGdhODFiTmdKaXJW?=
 =?utf-8?B?SlU4N3RqQ0E0a2tKTFRqTmQ5MGtMNmNERkl0Skdlb0RGc3NCLzBjU2hSZkM1?=
 =?utf-8?B?dGx3cnkxbjVCVkZ5WkxUMU03OGFlVjZTZ3lSSENDeEIzbUcybC90SzFRV28v?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fbc4ec-b5cb-4b93-e666-08dbc0777fd2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 23:06:08.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2qSPRhdlZVIUqT5NYRf2jiUjVWzkEMgL4MLpGvWJiz3PnB/Bw+CWQCSrS+3tfdgAZwYtGf/ChbEk8P7P83CUYHqzKSIORjGdeT32YG5iVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/28/2023 3:33 AM, Paolo Abeni wrote:
> On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
>> Add support in netlink spec(netdev.yaml) for queue information.
>> Add code generated from the spec.
>>
>> Note: The "q-type" attribute currently takes values 0 and 1 for rx
>> and tx queue type respectively. I haven't figured out the ynl
>> library changes to support string user input ("rx" and "tx") to
>> enum value conversion in the generated file.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   Documentation/netlink/specs/netdev.yaml |   52 ++++++++++
>>   include/uapi/linux/netdev.h             |   17 +++
>>   net/core/netdev-genl-gen.c              |   26 +++++
>>   net/core/netdev-genl-gen.h              |    3 +
>>   net/core/netdev-genl.c                  |   10 ++
>>   tools/include/uapi/linux/netdev.h       |   17 +++
>>   tools/net/ynl/generated/netdev-user.c   |  159 +++++++++++++++++++++++++++++++
>>   tools/net/ynl/generated/netdev-user.h   |  101 ++++++++++++++++++++
>>   8 files changed, 385 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index c46fcc78fc04..7b5d4cdff48b 100644
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
>> @@ -89,6 +93,32 @@ attribute-sets:
>>           enum: xdp-rx-metadata
>>           enum-as-flags: true
>>   
>> +  -
>> +    name: queue
>> +    attributes:
>> +      -
>> +        name: q-id
> 
> Why not 'queue-id' or 'id'?
> 

Okay, I will change this to 'queue-id'.

>> +        doc: queue index
>> +        type: u32
>> +      -
>> +        name: ifindex
>> +        doc: netdev ifindex
>> +        type: u32
>> +        checks:
>> +          min: 1
>> +      -
>> +        name: q-type
> 
> Same here?
> 

Will change to 'queue-type'.

> 
> 
> Cheers,
> 
> Paolo
> 
> 

