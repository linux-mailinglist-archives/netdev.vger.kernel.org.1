Return-Path: <netdev+bounces-17290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE3751189
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854012818D2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE824177;
	Wed, 12 Jul 2023 19:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1E1F95D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:53:01 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1171FDB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689191580; x=1720727580;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gcg4LemS/YoSu5xo4eQkUtgswXZXy5X+g9jlKUyOMZU=;
  b=V+/1fGe90PKozLOQhSl7QnfC7myTPgsgBOuONkXHjIZ/9ciMUgHAJjiP
   Xil9ZODMufLYNZqzCnZjSxeNA6S829ZV0a2nfpaf8PLVhi6AelljkeKtK
   xxydBMiTzVRSLfS9z5wOdxlf4WJbFq55Vzn+WMXv5Oe9rBKOXW/QSsrxt
   EdLFIx/ixz9UyQwqom5gv+rcutVynoTTjjlYjpTPXXTHqyEk49tCFAhxl
   NEybjLWE+yqTSJeZykBqFkevgA5M5hw9dj6aDhhIIJFuU6sAgLpsmAixA
   IzLQpd0nyBuQR/Fbto2A31rBHNmDyzcEq1E9kQM85HWy/TXJq8zlB2dzz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354903349"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="354903349"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="1052326578"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="1052326578"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 12:52:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:52:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:52:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:52:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:52:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsLSEV2R2JemEEXunT0dPW7psOI2BlGZtbV9HUwYM3Pj5zdeA+gnOnvFcMBhyJEm53EHePlYQVMszZOSN0NqUlPTVWrkPs5Izr8Xx2vvED8Hfn5qLgmDhlMQkRStnBj/K+7ymasQhd1ts/RQysqxktJcrm4S/BLOdtHECK9EreBs+lzNoLBLNlO8gwu960iA6PbdJTm9QQ2PNyEiv/MYsySoq+spUM+/aI6RxCiODaL9HgEC4XpxSEdJ0OlYta2BSL7n0MDspnvgrlPCRWG76lwS7wLv3K2YdArJGhCV5MAq1ipm2xOWrXsYdhIKp7D2knH7XCadSB78a5WCO9YrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTtWI7jdVPF+43mPACiadrzBD+BbsNOGuLB/MPubB/o=;
 b=IrP4rh0U4D6Y7vbeMKhUtyZEqkscTgW3GaQms8QkcR60/oAD6JPg4VlaWu0eEuIUfwkwPyIGOXSuKYSMm3dHFCzz+vMiEbWf4DBDNqj4QUC22yps9eu61ouQXFNGmtix5VtazY3C8VelxIsKGadGf6PAfySLqHj7OJPeFJ/oFDSSO88fzfTYVCPL50/e06CZPSXzTulT5jjkMDzsmCg/2saxNofLTVYdByKd4hZh8XwVUTIOM/u6tmJ7Z9iXsnmO0RjgiNgsemojeZat3pdxZJdtzB652jnfyhXs2s7I/XTblkb6oaMvKb+ApEngFDR5wseKPHjmsCAWdyp+0TS9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 19:52:50 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 19:52:50 +0000
Message-ID: <4748f19e-2336-b1de-1763-36f4e57ce157@intel.com>
Date: Wed, 12 Jul 2023 12:52:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 0/4] Introduce napi queues support
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <20230602230019.78449c21@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230602230019.78449c21@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: ca06710a-4a79-4137-a647-08db831192e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW/hjP8suWse2YrZ+tNEFEfFpmlF+k1RXQjn26iOjjAGF5lIAiIi/9Gko35GNYsdxRVL42J2mIdhE+A7aFAlWOQjdl4I6VTp8PaIQabE84lyD67HoGazppseyVPU83chh1p/bnIqn8vQMRsXtSTc4wPK99H57oY78JMcemSHSj/C039O9OWQRkcbeaH9heQIU1siBhKTWUAE/WX2W6CCU/hSubiUJ/BYXDqtI9weR2M2Rz8rw4MqOIEYi2Ext1Zz6Dz2brwMgywVzSCHe7rjDHP0VzXCSEVS69F6okylxhdMQEy9KYqSPVvk0tAmbM77e7sfgzV28IHb9obx4u7+97IFf51GeBO9ZYt/wsw/HF5lRD0pMvsqZD/onqQf7JtybC+hp3secJGXJRq1kvIZ4zJt2EEC7M+qUT5KY7S+nsOMqvtr9WPa/kF49oT3SUH3t2tqntajM6rnfvGSUbbU0rXba4LoLpKORtN8K+u1w+TyprvD7SwPdmB1k1QgUNXyep2ieFARaqn3OoZBiZCdiOPdHO7PfmFQ7N1tZJa0Dmp72f7SeIl4o0ifdGwMO3nnL5UiAhQDzQARZBOFMdApNtstD/K4JdOzDoM4aQskcepnxC/779vkX5C4hpZ1t9SYWMV28XM7V9uFRwQnWaktYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(4326008)(66476007)(6916009)(66946007)(66556008)(31696002)(186003)(86362001)(2616005)(26005)(53546011)(6506007)(82960400001)(107886003)(38100700002)(83380400001)(478600001)(36756003)(6666004)(6486002)(41300700001)(31686004)(8676002)(8936002)(5660300002)(6512007)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhIZUx6cDU5YlBNNHI5cnlqT0pJSXhhbVNYSVJIV3NtTHVGdVN4OWthTlhP?=
 =?utf-8?B?bHg0ZURTaUJreHNXME02eXNEbTlOb0Ziemc5cG1COER6dldKdzJXeUFCY3Fn?=
 =?utf-8?B?STRBZ29vVUF5VW1wZWFjWk1kSWFKOTl0SThCakZtdVBsb1MrcmUvUWtUV096?=
 =?utf-8?B?QjA2MUx6eUVFQTJTUWUwaFFsU2ZsK3NYbTdkcHl2c1VKM3FySjdTY2JzRER6?=
 =?utf-8?B?UXlZRHFaYmhtRHRJcGt0MndvUER0RG9qR3N2RitWTVA1V0xzdzcvTXFQR0hN?=
 =?utf-8?B?cEFFT2lsN0RQWnV1VmZKT3djZGZzNVE5WHl1NGhjeVZrMWV0dHJTSi9PNit5?=
 =?utf-8?B?U2ZmNmg2L1hyejF3a05VZ3FDOGdCbkRNU01SSnRDWTl6RURPMFFRVDc4bk9p?=
 =?utf-8?B?VE4yRFNGWGJZNktCbThzbTVPeldUczV0RTJhbDdubmZOdzhxZ2UyV3YzNW5s?=
 =?utf-8?B?MmxMR0V3VTE5MGhldEw4dklFbUlKUC8yZ2pHRXp6Y3czM0RqNXhrNEZEWWt5?=
 =?utf-8?B?SjZtTlZBSEdCbndkZmkwSjAwNjNyUHc3YkV6RUZTSkJXYkRyeExya2VkdmVJ?=
 =?utf-8?B?L21mSEpzRWRLaE9PN0d0ejl1LzF5Y3UzRHdEVFBwSGxlc2M0RzI3SkRHdFFF?=
 =?utf-8?B?b2F3T0RLZkNIeWhBSHV5KzJETDlSR000ZDJSSTdSZkVYVU4xcDdob1ZtR3VM?=
 =?utf-8?B?dGY1a1Q5U1hVM1dlbUt0QVNjR0xMR3Y0Y0twOFNxY3kzL0s4d3k3TUtuZ0dl?=
 =?utf-8?B?VHRuajdsQnJBTFA1aUV2Mkh5aFRqMkRPaFhXSzA3V1p0V0hOOE9WNVZJMHk1?=
 =?utf-8?B?eXZiRU1NTGdpeElGUEljNnJ1NVhyM0hmRzFkKytvdTZPN2Uvak9hRkcwR0tz?=
 =?utf-8?B?VXBOTkd5ZWlVa2l1U0tKMWdqVXREUWc2UGhlTkZFK3EwZWZ0SGcweUN6U1Bn?=
 =?utf-8?B?NjZoK2wxbzlzYXNwM3V4YnZkZWZJZjZIL3RoMFpOU2FlMndObTRzWkdEbDRC?=
 =?utf-8?B?TjlCS1ZudDUxL1BZYnRoWXVraFl6SFFHRm1XcWJPUmJheTZ6ajZ3MHJOWVRx?=
 =?utf-8?B?dmlEcTJsM2ZWMWdTUTFnZzRKOWtQOTBEdXlPSG1IRmE2ZnV6NjVDYS9TU1hw?=
 =?utf-8?B?Z01DY0dON0k5Q1ltemVhVVYwUXgzMTRnYzZkSTR2RjlSRmNNNWNtZDJrWTRs?=
 =?utf-8?B?SnJsRkJ1REdTeDF5RTBKYWVnbzQreGJHZlhVVUZiaER2elhVZExlK0Zad3Bm?=
 =?utf-8?B?VGxqbUV3bkEyZEk3S25ocDkyc3VNdVNkNkxDWEdNVTdoL0NDQjJsY2RwQlVD?=
 =?utf-8?B?M0VvOXBOSXN4UDM1ZGN3L0pRQU9FSnZ5MEtaVkV3Ty9XTE5Jc0tvNjlDcldM?=
 =?utf-8?B?d0dsRm5VS0doZzlKTTEwS2I3Y1Y3RDkyV1AyU1JSbndGOTQ4aGU2TmR5TTJG?=
 =?utf-8?B?WCtHSUo0VnhSbENiYjEyVmE2VjgyVzk5ekYwRFdaWGZ2ZGlQNDR2QXdrWXlR?=
 =?utf-8?B?L2VBZGFzcFBNTTNJVFUzN1hSZEthUFR5TUljM3U4SjBVV3Aya1lId0RTYVBH?=
 =?utf-8?B?T2dzY2d4OTJKMjdNeWlwYlg0ZjByQnFOdzl0YnZKWkpzTkNWTDk2L2VaRnB5?=
 =?utf-8?B?NTRaYk93TS9rQ0tFOXRJR3RPemx0V0RIdWgwVVpuby9nT0ptWk1FVXpMOFNH?=
 =?utf-8?B?SU96eWFaWElZY2RER1VVQXBmYVk1UU5FS2cwYjBrMEpiNjhCbXpXWFNjWDIr?=
 =?utf-8?B?cEhtT3FucU52QTBxTVdLWkdkVzJYNW0rNkxoY0dSeW9FOFBxNTBaWDFWbWhH?=
 =?utf-8?B?RDlyMDV2YTZpanBESm52ZEZvL0hKTFlaQm5IRFNrVndJeE1yLzY4bndEUHRo?=
 =?utf-8?B?WUE1SFB1KzNpVHI1aVlDSTBNejRndDFXc1ZqdEd1aXdnM0ZzV1pudzA3KzhG?=
 =?utf-8?B?L29YMFMwN3dvNEFqYjdzYU45aG1FUU1ONnJzdEdiMzZ2MENtZnYwd0hUaUE1?=
 =?utf-8?B?c29HK1lyam05eEZmeXIwekNtNWNKZW10QWVQVTFsQkprcjdnaDBDN0lJS1Q4?=
 =?utf-8?B?cjdHMDN2TVltNVJDckF2bkN1NzArRDFIVHdsL2RrLy9ZaWVZb3dhVnE1TmNT?=
 =?utf-8?B?VmhSSkdPRXZBSWlMNXNiRDRmMEdlRVkxbE5UVFZFNDBJTnA3dGZJMmZjc0tD?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca06710a-4a79-4137-a647-08db831192e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:52:50.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+VBb0l2e+IrrceTWG2fhYviiOMUHsuQsAyKt3xidWXGH94EQH1fXZq30famU2XvjCFj2kP1cbegppXil4McP7DmEFjfhNMFHYLX9fjY4+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 11:00 PM, Jakub Kicinski wrote:
> On Thu, 01 Jun 2023 10:42:20 -0700 Amritha Nambiar wrote:
>> Introduce support for associating napi instances with
>> corresponding RX and TX queue set. Add the capability
>> to export napi information supported by the device.
>> Extend the netdev_genl generic netlink family for netdev
>> with napi data. The napi fields exposed are:
>> - napi id
>> - queue/queue-set (both RX and TX) associated with each
>>    napi instance
> 
> Would you mind throwing in the IRQ vector number already?
> Should be pretty easy to find the IRQ from NAPI, and it'd
> make this code immediately very useful for IRQ pinning.
> 

Sorry for the delayed response as I was on vacation.
Sure, I can add in the IRQ vector number as well in the next version of 
the series.

>> Additional napi fields such as PID association for napi
>> thread etc. can be supported in a follow-on patch set.
>>
>> This series only supports 'get' ability for retrieving
>> napi fields (specifically, napi ids and queue[s]). The 'set'
>> ability for setting queue[s] associated with a napi instance
>> via netdev-genl will be submitted as a separate patch series.

