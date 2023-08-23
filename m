Return-Path: <netdev+bounces-30140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12D7862B3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF701C20D1F
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F52200A9;
	Wed, 23 Aug 2023 21:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6731F188
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 21:43:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B42D3;
	Wed, 23 Aug 2023 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692826999; x=1724362999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cFuFwNhw4HtAIA4dHvS4o9c209u78vsiDV5ocZ0MN8M=;
  b=N0iC6RWT17VEnRNaumXnZ/ETNXBE5XwthmvPjaw9R2l5w92lzp84aLbq
   Dt44tirtNbxygzL7L00giReASq6omGDQy/wQ96u6BFVK9VvEcrdkG0BMl
   5v+Tx3pH1iiuT39goi+NwzbAA0JY2FZv7CLFoWrZ+SbZAHtcVE2zb1WqA
   bKrN8DRU5FsVFGLlImaYxo7/tNTCk8NTrO3r0+Wp88b3hlFERgXgxkR+Z
   t09SdB8wL9fb0Z4VCELuzy8Sbj7NHdiRRwN9NipBx6FPxOlQ1SdGeSEtu
   YpRZRFNOLY5Dw0WD4gZad2XBR5aR4PVPgO0ElU/sK53nUCeiRkpTcb8td
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460639092"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="460639092"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 14:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="910671988"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="910671988"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2023 14:43:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 14:43:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 14:43:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 14:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7fCJxOnWCHE+dXyRLlMRLyMqby8NTgQYVREW0dZbMXM+Wmijwf4zz9/V5Q34Wc/ktkmPdbeJwPY1/w3fT0+/FLdVOIoyPtIbnAoAqlgwEL3jWD65hoimQzRCB0TeoakPSGmWPwPxtXWzOPU6nDUONXbSZBtA5FZMoHYnuvBEFV/+D79Lkn7cnryAopPOna8Lnbuzv9ggD+1I7AGLv1awaggsQIppKbpQe8ngagQRRUr5nNB9xhAk8x4Fn9i8LSHFjn6//eNKg4FD4A3H3llQ31Eaqoi/zghJt9rDFwssGfIFnXsi9Y1B767vw4HVPYNJHoxH5Jjnaj55VxY549KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEEf0TJuAdJ+QR+vb9E8H4IZSbObNDXkOfZoK0oIlW0=;
 b=Gip08QIL15kZ/5Ic0Esqlc/F1MQExNH/ClbBJLMNKs1KgsYoud7YzlEJsIWQhm53xIZKuD4noUxFKJpiBli61Dy4u/DkN0YfIiaulu1euO3Wxm2YQwPUZdNZny1nWPFXcyqfjVoYmNi4ncgHw4DV0bq7iWUuMjeNVxMLGCfbCp4KviNjB0AOLzgYGgxxhyArhsN9mpoFAkaJYcDR/4Wcqy/x3OtmFX+l59iF6FUVCODukShI6HMQluCRaIWlX2Wydv/2hFLHyT0Zg5Xok7ApR7vqZ97XZp0TouvDPz5I3iL5UG3J4+Fkes5C+yCcpFnrBhy0Z9AAkEs7vLL0O3+B0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 21:43:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 21:43:15 +0000
Message-ID: <57ed25b1-e00f-2601-fc76-1f9d19182915@intel.com>
Date: Wed, 23 Aug 2023 14:43:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 02/12] doc/netlink: Add a schema for
 netlink-raw families
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>, "Arkadiusz
 Kubalewski" <arkadiusz.kubalewski@intel.com>, <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-3-donald.hunter@gmail.com>
 <005940db-b7b6-c935-b16f-8106d3970b11@intel.com> <m2edjth2x2.fsf@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <m2edjth2x2.fsf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: d041c994-0f1a-462b-2897-08dba421f4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fu4GJzCibP8cogKfE3PYQ4AKPNkhEYBxtwYfm+I6F4wZWe+caLUWmAAXCj2WCW7t65zPILO5gvTxy74Q/mhFBW2+jkym73F+B3VCpf+GZkkaIEGp31HPi5FjRMibE8pw3ivk9uKZjSdON7/idjcrtjdq0/vp+p675vWYmaiQI1p+6GF74u1X1jkg+YW2rgL5eSMxMckqxplsmi7sMlB6JPoB+ElHi1PS3Yd3KyR4OFj37gYVYqNxAPciKdauNKDdS3uYf99x9RqAVgJY+R+yz4nHNDPCvRKwtiQiuh1Ckun0NlugZhK3cWDd0J9Vn9cBOigninYT6DHrKzAnusI1cjoEq+R3xmJA+ozeB56cDo0f1X6pP/kaMtL9pHTUxIoF9xCV3yMKUmkpjPoJdEuSxqCFpCL12ta7OMxBUSxOlq1pkgtWlvQ/vhqUi07ZkmUClI+i4G5xh4F2FQIrJ6mDz3q+n6eLcbOupAIldu1AbN3NNwWk+eXTCTAVMfoSB4k+/SpKeWx/znO48dPQj9CZsuYVWj+O1TZlySdkCfju7oDcVQfIQ+Hs4T/JcX5oLEmQY8Vc5Bsta6lo+fAIkxZo1cHSulptEg4Uz+O/z+M5PEnccPoOZ9PIwRxjW4Rg06ituHrz+WMgJMoTs1PtejCAiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(54906003)(66476007)(6916009)(66946007)(6512007)(316002)(66556008)(66899024)(82960400001)(8676002)(8936002)(2616005)(966005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6506007)(53546011)(6486002)(83380400001)(7416002)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytQMGhrQnBYdXBScjVHOEVVMk9aRTBEa2lUOFRkNVJlTnM4TmluRGR5Mk9x?=
 =?utf-8?B?Zm4vbTNobkFWeTQ5aWZHeWNvazBnRDlFTGpWZ1ZJajY5SGxjK2Y3dmJFVUNT?=
 =?utf-8?B?RFh4RFlZRE1oV0UycTB5aEZYY0l5NG5GdUVVeDZ1ckdmUkRiWTRSam45OXpy?=
 =?utf-8?B?RzJGQVJpajVBSDFMQXBBRG1vS2IyTTFyc3NKVng3QXBsRW5BUVFOTm1YUGF4?=
 =?utf-8?B?ZGxhS2tjZ1RJWmhCQ1lSV2hrTXhyZ1NBRXRzbDFKaXFJcThUZHpHUENhK1lI?=
 =?utf-8?B?WUxITm5pWGlHTU5EcVVkTmZ6WFNkUEVPNFVTMGFHRm5jNlo5L2NOOWpWQjZl?=
 =?utf-8?B?eUFXMFZmU0FMYUl0OW1pUS9LOG1JSFRWWG1rdzM5OFh3ZjVBREYxM2UyV3lN?=
 =?utf-8?B?WFdKVlFRNDRqNm56a0p3RDVzT3FncldDZFFMQzVacVlaZWN0S292bEpLVXBK?=
 =?utf-8?B?OEtGWU54ZExacXMrTjlFcUhxUzZXaWVHbVZGaTN6WURsRW5oWDZ3THhEY3Bu?=
 =?utf-8?B?WnpVbmNFbW44OEhIV3d6aDdycE11eFJJengzd0E3ZVRYdVdYaHlXaFlNTXdF?=
 =?utf-8?B?dWxlNHhodFRhK1ZPMXpteFpHQ1k5OHlEK2c3Mzh5eGtmNUpoQnZMdHVLUUFo?=
 =?utf-8?B?UHNZT0JFWE5RWURhTFB0TG4xaHJkb1MvODJhWmJ0SHB0K2FvbFJYdStLdE9B?=
 =?utf-8?B?R3hGNVkySk5XZ2JURmpQd2h2cnI3NU9vREx6V3dwbmkwM0w4RzdMdm5ldEt3?=
 =?utf-8?B?aVB3T2RXa1RWU3phZXZaeGpzbkJEUEtUc2FFeEZ2OUpWQTdoT2crK3F2VWxv?=
 =?utf-8?B?a2pKTVdMYndSdHkxREt5dTNsZnpFNVlLalFVNElCYThtNEZCU3R3MVFOdEc5?=
 =?utf-8?B?cWNNR2tvcTgvZ21wQVU2emNqWlY5T1lpV3ZBVDZsUjB5TXNYbEV0UEowNGMv?=
 =?utf-8?B?VEpUcnBoTGZLcXZ4S1BwRWdsM01zTzU4dFRPaStaWldCYWpLSFkrRUwwVFFy?=
 =?utf-8?B?bm4vR0MzeEdRdG1zRlRTcVpLTDgxZWhKZ24xR2tadmhHbldGb1BtRVB6cFpn?=
 =?utf-8?B?TllaMGczejJSWk9uL1NPdVBpUXkyeHZqK1cvUy96Y1BJMjg2VVNEYkwvVGsz?=
 =?utf-8?B?OHQ1MStSQmFBa2ZlM05VQm9hTWYzbUFOT0JkZTh5bGJyU2VlT04xRkRLVFJM?=
 =?utf-8?B?K1orMklqZE5NVVgrdmhYaHlPYnhPeDlIZWdwMkc4eUdSVmFjYnFpbEV0Z1Na?=
 =?utf-8?B?a3BwN0trZFJBdkFpR2NiSlRPSWpLTHJDbHdpblNpdHNDWFl5cng0a2hodkFX?=
 =?utf-8?B?TXVhTHpYdU5kb2phb0VzM09TZGlLMnhtY1dCZzduTmtlUmNnZUt4ZmQ1K0c3?=
 =?utf-8?B?dDBsM0FXanJzZC9USGVKcm8zV25XemFYUUtvTTZROUp6aG1heGlpQlJhVlBs?=
 =?utf-8?B?dDFuUGJsclRWV1BjeW9GckNDSmg5TmtQY3lSWittRkRIVWZKcHIzcmhhLzlq?=
 =?utf-8?B?Vk03UmNWTTduNWY4MDViTkJJd2pGWjN3Vml0dm80aUVzaDFOUlhHWE1UMVlC?=
 =?utf-8?B?S1pjMmY2TWw1d1FwNjhKc3pEWG84ZFRxbG1UVGVhS1dGblI3cUJXb0hOVVRT?=
 =?utf-8?B?aVBOYWJQejRjdHZCc3ZxbmtxbGJ2aUxvT1Fjc3Q4blYwUVVWQktCclpoU0ty?=
 =?utf-8?B?N0N2N2VOazZNdFlOelJQZjlibkxyUmpvdlNXcUZSSGVPMVFwRFUxeFp2elYz?=
 =?utf-8?B?Z1A4UXJSdUVIQUllSkt2bWhuK1VXTmhhYzdTV01kUHpFek16SXVzUmpEQmZ5?=
 =?utf-8?B?T0VTckhFQkhTb0k4eW9zWFJCSVhnTE1xdDUrcnBqdDBVQWU0YVpEMGhXZ094?=
 =?utf-8?B?aTJpS2U5N2l3c2dMTG1xanJ1aXpSdys0S2lLM1ZvNUtEZDk5TjlQcGF4TFdC?=
 =?utf-8?B?b1NGY0hqUUM4d0hvTUNRZlp4dnVRVWhvRzkwZWwyQ3E1NVVTVmFXWFozYXI1?=
 =?utf-8?B?ZWdsTkdCaHRQcENFVHVWZE9rZ3FlSnhpQThjU2gvV2FSY3RxdTQ0cUxQKytJ?=
 =?utf-8?B?Z245czdZY3pBMHc1TytlNHliaEZ1Zk5kZVkrckhSdzUyQ2hHa1ljdWRCVGlM?=
 =?utf-8?B?WnJNelJTMVBGTk0wOVJUcHA0eHdyeE92UEpWNDk3K1NjZXAzK0tzUG5zUm5I?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d041c994-0f1a-462b-2897-08dba421f4f0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 21:43:15.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLinT0XDbQ4WoYlIoP1tpE6LttAABFKRn4WVajBt6zKrLkjG/QRuX7oWFxTjIuJB6XTKyXrELpikXtxeElpxUq/aD+U4cXXpbc/5kJ0BGhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 2:19 PM, Donald Hunter wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>> On 8/23/2023 4:41 AM, Donald Hunter wrote:
>>> +---
>>> +$id: http://kernel.org/schemas/netlink/genetlink-legacy.yaml#
>>> +$schema: https://json-schema.org/draft-07/schema
>>> +
>>> +# Common defines
>>> +$defs:
>>> +  uint:
>>> +    type: integer
>>> +    minimum: 0
>>> +  len-or-define:
>>> +    type: [ string, integer ]
>>> +    pattern: ^[0-9A-Za-z_]+( - 1)?$
>>> +    minimum: 0
>>> +
>>> +# Schema for specs
>>> +title: Protocol
>>> +description: Specification of a genetlink protocol
>>
>> If this is for netlink-raw, shouldn't this not say genetlink? Same
>> elsewhere? or am I misunderstanding something?
> 
> It's a good question. The schema definitions are currently strict
> supersets of genetlink:
> 
> genetlink <= genetlink-c <= genetlink-legacy <= netlink-raw
> 
> As you noted below, there's only 2 additions needed for the netlink raw
> families, protonum and mcast-group value.
> 
> I would be happy to change the description and other references to
> genetlink in this spec, but I'd like to hear Jakub's thoughts about
> minimal modification vs a more thorough rewording. Perhaps a middle
> ground would be to extend the top-level description to say "genetlink or
> raw netlink" and qualify that all mention of genetlink also applies to
> raw netlink.
> 
> Either way, I just noticed that the schema $id does need to be updated.
> 

Ok, ya lets wait for Jakub's opinion. I think the clarification would be
good since at least conceptually genetlink is distinct to me from
netlink raw, so it feels a bit weird.

Either way, they share far more in common than I had originally
realized, so its not a huge deal.

Thanks for the clarification!

>>> +type: object
>>> +required: [ name, doc, attribute-sets, operations ]
>>> +additionalProperties: False
>>> +properties:
>>> +  name:
>>> +    description: Name of the genetlink family.
>>> +    type: string
>>> +  doc:
>>> +    type: string
>>> +  version:
>>> +    description: Generic Netlink family version. Default is 1.
>>> +    type: integer
>>> +    minimum: 1
>>> +  protocol:
>>> +    description: Schema compatibility level. Default is "genetlink".
>>> +    enum: [ genetlink, genetlink-c, genetlink-legacy, netlink-raw ] # Trim
>>> +  # Start netlink-raw
>>
>> I guess the netlink raw part is only below this? Or does netlink raw
>> share more of the generic netlink code than I thought?
> 
> Raw netlink is, so far, the same as genetlink-legacy with the addition
> of hard-coded protocol ids.
> 

Right that makes sense why this shares so much.

Thanks,
Jake

