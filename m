Return-Path: <netdev+bounces-27481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68177C239
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6AD1C20B96
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD360DDDA;
	Mon, 14 Aug 2023 21:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38ADDBD
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:13:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB8172B;
	Mon, 14 Aug 2023 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692047612; x=1723583612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XgAVD1YROR8RcPXDpADrGtU4vt5ruk8Dh33L3bzD7To=;
  b=Fddqa8cWM+GF7GHiJduTpF5zQ7myBau8MMIVQUwCFNwoxr0bXWKszGgA
   UnyuYF4TBOoe7T/m953wepWKtmj5FOf0wx/OhabsigzsQVJaZUsPgzLsM
   UM6lvCBcZF16nEr6j41CYWFNcxDsBRUpFZzvrkX+8FfoMQSRDPRoqWhHc
   EJ+Ohi2BtKoqWVCFPZc3EYQVG7IQSDziz3gZG94F4hyH3dvmeiXU4VZHO
   4Z8u4/7kvcGs+HDUxvKKuIPkeVKhYr96d61+vof6tsWTnK5z+RPrYG20a
   wbme77x9cK9CYzudWhR6aiiHyaQFLxFOe+9Sy218TN+d/QD3bVvtez0un
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374910149"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="374910149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 14:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="798956460"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="798956460"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2023 14:13:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 14:13:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 14:13:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 14:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/anygerxkcsVykhmJH/b5yEdjGkDVTtXQNXnYjnCt/v3We3JAyJyMVM2/BEFpsjmirkaOYpaEqDrmkfB/GLzDpWF4Vor08WufCn3fJO9kc6OL72dMhoGd+UR4zbBjBG5tiyl80cLgX9KkoGVtnKM35oZueIQ/rY/1ME3y4Kelm2i4A2jL7Si5eePfNUK2idlQAFAVW+kLuNant+l8Ze3qz5sC9rGqoPwGSSRRsvjHxHv4Xtv0nz+5k/Q+xTNRzlIg0eF9q906OgGDNVnpKxOgZFYdRR/8h0Js4jQ/9oxqq6iYup8Wj2bLppy5FG7PD3RLqTY4O9x1C3EqaV3AFVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVXUNMunAumPDSkN/EaB4lp/78xO6YAfXg9379/oRv0=;
 b=j/FHi6uS2U+vv6QzKHXnkZPa4z5qzoSqMfYCdkxupwfl10uDRAAr4Z7XuoAs46JZaV8fEOPYk9RthH8hSVAcXAgtUuo3a1DXF4gv9iyIU8+Dkzpw0OlCvnD65E35H+oDm3MPq6NQ4nER8LfCuld/ElnkaTHmrOeZPkQIRcwv+Si9boPslQs4A01tMNoKJ7HMSX4QMBuD/jP1ZlPhVEuHk4LJ3bBtjwCzTyilzE5hAA5rmJhdS/mdK9Sg8uNRUyawBJ5JkyjwF02UyOLgeu+bf96j+KxcrhrItL3ArwnpGV99UjnXLgmMYr/SplKwsTlc4FoKjr2H4SFgS8OZPzdRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2593.namprd11.prod.outlook.com (2603:10b6:406:ab::27)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:13:28 +0000
Received: from BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542]) by BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542%5]) with mapi id 15.20.6652.026; Mon, 14 Aug 2023
 21:13:28 +0000
Message-ID: <5b6d4e1c-aaa1-b73e-0360-3cf6893bbaf8@intel.com>
Date: Mon, 14 Aug 2023 14:13:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 1/2] scripts: kernel-doc: parse
 DEFINE_DMA_UNMAP_[ADDR|LEN]
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <linux-doc@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<joshua.a.hay@intel.com>, <sridhar.samudrala@intel.com>,
	<alan.brady@intel.com>, <madhu.chittim@intel.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<willemb@google.com>, <decot@google.com>, <rdunlap@infradead.org>
References: <20230814170720.46229-1-pavan.kumar.linga@intel.com>
 <20230814170720.46229-2-pavan.kumar.linga@intel.com>
 <87y1idv4du.fsf@meer.lwn.net>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <87y1idv4du.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To BN7PR11MB2593.namprd11.prod.outlook.com
 (2603:10b6:406:ab::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2593:EE_|DS0PR11MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 663aba9d-f1a2-4bb8-3a73-08db9d0b4dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eRFAGmJVRoilFfWa/C/63hwMG0524rcJKLO/+HKu9oIrPLrwnON317MwKUpUa/eIHIWMsXzdqfUyuiTfy1LLlOsfn0onxQnF1o5hSvtkXGhRMtZI039m0pfvxTiG9M0cdy+HNOhnoBi9S0ms2To58cr3mVef9581vNnrmwSeSbRenF7nQzItfNtUU+P++X/aRW8XeTVHp8E8ZsJIvPvzwdCIxcddvuFo0Mrn31fLAwFMsRFkkgvZRNAQgTwhOk9WwlbRv4rdLkFBiQU0gvKyTW8CBIZZhfa5A+9E5Gi+pdsXgdvzeirCYUlfw5d6qAMfbCEhGfq8IWyosCIWFi8n4vg0Z9/JUmjOt2579e8e0ImfJVWfLagTXdxxLj2gg3vb57UlMeZ9doDJgdSJDPxujU9uxoxuPR9W1xVOjv/WpL2JK/FgdhS5tevaeRCYNGlYM2vcXBvbLh3LHulUYoXKVEedU+yd1FAKGdG9+Ixl0HOsL69dCEPKiRJqzSYfXQ1bf5liCps2J7/Vxmtf9XfGzr2DV0oURhyfvUexU1TehS6+I3yUFtuIKqYZhY6zS7tD2IgLqQx2svFl8m3jcrhAu68dkP3DVAuv+QgsJMPXg2MndRvOl/uQa1YTWrfPIfeZkckuRxKGBuLbm0hlq79Tc7W+MXmEZSiRh3xVuk5yPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(376002)(136003)(39860400002)(396003)(1800799006)(186006)(451199021)(83380400001)(36756003)(53546011)(26005)(6506007)(478600001)(6486002)(6666004)(2616005)(6512007)(86362001)(38100700002)(31696002)(31686004)(82960400001)(5660300002)(41300700001)(66476007)(66556008)(316002)(4326008)(66946007)(2906002)(8936002)(8676002)(83133001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVYvU3FrL3R5ckhEN2NpZXhQYzY4dkkxR2EzS0l4YTU1dXNrQURQT2dyZHdV?=
 =?utf-8?B?ZlhFUXFhWWdjSE43OGpCeTFFMlRUTVRSL0xSckhVZWkwVmZWWkN4Y2dpWW9a?=
 =?utf-8?B?OTlTT0svejdzV2JGL0ZQeEFUd2o0ekkyWTFoUlFFZWZ2ZG9yQUUvc2VSTUlK?=
 =?utf-8?B?Q0Q5N0ROOFFWNS82SjJBSkhqMFE4Y1lxTERpUTgxMlFPRUtINm5XSVlHMXl2?=
 =?utf-8?B?RnNkaGRBOHRLNVIyMllhb29LaVFTSDA0bUdtVTM1emM3azllWTBXdWs2a3Fo?=
 =?utf-8?B?N01rZm9wZmdWRWIxZHF1TWpPVUh1REVxODFFNkxtNlBrRWVha0dqVE1BVjhE?=
 =?utf-8?B?REk1Z0dDYkVnRWJJQ0pLZzBDZGVQZCtIcFdoWHplOGJTb1pSRjlzRXljcStp?=
 =?utf-8?B?TXUveDM3UnVzWTcxd1BhL24rS2Y2YWRQaVB1TnpRN2hZQXREK3A3aHExclh0?=
 =?utf-8?B?cWF1ZW9pTE5oaGFmZU1BbnhNdm5SUzBSemVkR1UrMjV6VU03NXRQejd3ZmFQ?=
 =?utf-8?B?WnY0dnd2d3REZ0JrRnNMdUw2TG1pZFhWK21nM0lpWXUyNmVrUUZyVFdia1R1?=
 =?utf-8?B?VkhWay85cytUdEZqdDJ6L3cwdHhFWk12OFptbitxZDR4b2c4aHBVZFF0ZWhs?=
 =?utf-8?B?R3VNbHMxckR6TkRYT2xweEJ3a2U1TzJEWmxkSkpCZ2ZRclFDWVJSQXhIVHh4?=
 =?utf-8?B?cXd6c25HSWhVakhOdkNqQ0VULzc0bzh6NnhvU1J3Rkk0UjVMVUpkUGUwQ0VV?=
 =?utf-8?B?S1BEeGhRVUR0SmRlN1EzK04wazdyTHpmeFEzdWNXanpQOWsyZDN1Mzc4WUtW?=
 =?utf-8?B?NGcvamNTcGs0OTFXTDl2NUxxemd6MXpjdy9FbGhNSTc3bTN2SWl5RnRqZGU1?=
 =?utf-8?B?b0c0c2pCZjJTdjlPMHdzS0VXQXVKZzNvRm8xTkF3NGt3Wm9lTzBoSDlXZDg3?=
 =?utf-8?B?Yk03UnhSU0RmMGwzaW5VNTJHNXZ4M1dLdm1UajdhOG5McXJDZzdZbGRLOEhH?=
 =?utf-8?B?WXhJOVU5TERKNlNtY2c1Nm5sRmpIUHU5WDB4eEFrQ055MDJ0dGJsN0dwMnhy?=
 =?utf-8?B?c1piRi8xMHg2dzZPTEI2TG5qbExSZXNId3RnbW5XKzBJbXE5MHBJNy9ZNTZ3?=
 =?utf-8?B?OHF1d2hkcG91MG8zdi84Wlh1dlZ2MkJsd3Q0WWJ5ZXh4MkpHRTNud1hqeVRl?=
 =?utf-8?B?dE9qN0V4clV3Y2JsUjZDWXFES0lac3hoMXJ3S1NkS29neG1jRklyeGZidkJS?=
 =?utf-8?B?b3Qyc25oR00xSGFoMzlWc3lHWTZZb0JQaGRqekVBL2RldHlqSTJ6VUJFeWJT?=
 =?utf-8?B?SUdxSHVBS2xkWGYxaWFITzZ1aldkakF6eUlGYnJJRCtiWDRvcTFkQUhmMWdS?=
 =?utf-8?B?czNFdkRZVXl2Y2VXOTNNVEtKa2l0Ym15dlhHZVpOWU5qYmlSWS9sTHVxa2Mw?=
 =?utf-8?B?dmVFY0dpV1oyc08xNm1yNzFHYnJ5dC9SQkkwUm90K21WempUWStuZVNlZ3RJ?=
 =?utf-8?B?U0VRNFQ2L1NUbVF3NkFQQ01QZG10c1hiY0srNTcvWFNSRWJNbThwU0FOcjlj?=
 =?utf-8?B?eGdqa20yQ3lDNWEvUjJVcWVIUlVCWUpiQ3RPaFJkMGNiTVNiRThvVVNSMGQ3?=
 =?utf-8?B?NjZ4KzRHMkJKRUJnZnA0UkxjUGJNOGJPVTJvM1pGcTYwRndCaEZvRkVyMFMz?=
 =?utf-8?B?NFdWd05LbVVuSWoxaVArMnJ0ZDdjWUoxV3FCS1hrNlBIWkliOXVRR1ZhWjdE?=
 =?utf-8?B?NWRraFNPVllRdm9uVW9rWk5CMHFIVFpUQjg0YjZnNEJHUW1QdlBjR2thejVM?=
 =?utf-8?B?dThFeHA4c1JCMDB3cmVCRDg5dlM5aTN4OXFYTGNpTk1qSFJSaDJ1a2Vha0JD?=
 =?utf-8?B?Nm4xS3NCTWc4QTVnQWRySWZacjlmMG9JbGdPcWlRejFzVW9sODdRMTVUSjVq?=
 =?utf-8?B?a09ONDg0OWsrREE2QlNpYXF4ejJpTGk3Mi9sTUxJbFRlY2tEOEQ5dnk0ZjRY?=
 =?utf-8?B?L3l2YTV1WGUvYm1RcEo2NituSC92RkNLMTUzZ0pVMi9Fd3lkam1jUzgxaHVL?=
 =?utf-8?B?Nm5SdFhOai9PRjRYK0N6TDBwbmt2WllsdTdRc05RWjNvQXg2WGsvVUwxV2xu?=
 =?utf-8?B?QjAxY3o1b09kalRqTlZ3QWkwRjJTZWtXdWNMZ0ZXYTN0SkZpTldpYUZlU2FV?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 663aba9d-f1a2-4bb8-3a73-08db9d0b4dda
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:13:28.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfELapf9DIyXhm0ptpZqJHaFKlV7CrS2YE9Gc6mw9w3/q65ec7qdd8baGH24FMJT7k3oPVK41AV0jbNb2mVCgjj8VDqNrivLq0XEXFatvig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/2023 11:57 AM, Jonathan Corbet wrote:
> Pavan Kumar Linga <pavan.kumar.linga@intel.com> writes:
> 
>> At present, if the macros DEFINE_DMA_UNMAP_ADDR() and
>> DEFINE_DMA_UNMAP_LEN() are used in the structures as shown
>> below, instead of parsing the parameter in the parentheses,
>> kernel-doc parses 'DEFINE_DMA_UNMAP_ADDR(' and
>> 'DEFINE_DMA_UNMAP_LEN(' which results in the following
>> warnings:
>>
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
>> parameter or member 'DEFINE_DMA_UNMAP_ADDR(dma' not described in
>> 'idpf_tx_buf'
>> drivers/net/ethernet/intel/idpf/idpf_txrx.h:201: warning: Function
>> parameter or member 'DEFINE_DMA_UNMAP_LEN(len' not described in
>> 'idpf_tx_buf'
>>
>> struct idpf_tx_buf {
>> 	DEFINE_DMA_UNMAP_ADDR(dma);
>> 	DEFINE_DMA_UNMAP_LEN(len);
>> };
>>
>> Fix the warnings by parsing DEFINE_DMA_UNMAP_ADDR() and
>> DEFINE_DMA_UNMAP_LEN().
>>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>   scripts/kernel-doc | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Is there a reason why you didn't CC me on these?
> 

It was unintentional and my apologies, as I thought CC'ing you while 
sending the patches should be good. If the ask is to add the 'Cc:' tag 
to the patch, will do that in the next revision.

>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index d0116c6939dc..cfb1cb223508 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1168,6 +1168,10 @@ sub dump_struct($$) {
>>   	$members =~ s/DECLARE_KFIFO_PTR\s*\($args,\s*$args\)/$2 \*$1/gos;
>>   	# replace DECLARE_FLEX_ARRAY
>>   	$members =~ s/(?:__)?DECLARE_FLEX_ARRAY\s*\($args,\s*$args\)/$1 $2\[\]/gos;
>> +	#replace DEFINE_DMA_UNMAP_ADDR
>> +	$members =~ s/DEFINE_DMA_UNMAP_ADDR\s*\($args\)/dma_addr_t $1/gos;
>> +	#replace DEFINE_DMA_UNMAP_LEN
>> +	$members =~ s/DEFINE_DMA_UNMAP_LEN\s*\($args\)/__u32 $1/gos;
>>   	my $declaration = $members;
> 
> I'm not happy with this ... we are continuing to reimplement parts of
> the C preprocessor here, badly, creating an ugly mess in the process.
> 
> That said, you are just the latest arrival at the party, can't blame you
> for this.  Until we come up with a better way here, I guess this will
> do.
> 

Thanks for providing your feedback.

> Thanks,
> 
> jon

Regards,
Pavan

