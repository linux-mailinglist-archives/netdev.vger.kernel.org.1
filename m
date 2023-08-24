Return-Path: <netdev+bounces-30532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FC787BAE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ABA2816F8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 22:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9CBE4C;
	Thu, 24 Aug 2023 22:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF337E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 22:55:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5098019A0
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692917750; x=1724453750;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dIbnaw9KWcsTmg3o9YoRfr2aE5BBwRXMYD6R5GZ1ZAg=;
  b=YRVY/mSKLtgEdVLXrXGIY6sES1QNXAtz+bhd9KAG9Y6DBLGghHQb/7bK
   WDijSGqDfjJ55/JXu/0hZRJmRpekgHj24FjDV8fZIEaHjNk8ikwg/jOc+
   2d/R9hXv/WoQQ9prvPZGsISOCSQw+tDcq1IG5duc08odu2lPkiHxqdq4G
   zZXqkctNWoSQNxifL9z4MiQXObE7/XsmhOlYpCT9jO7OFCpI4kV0ciXSm
   9dWT0FNhRZAaZQuV1G7NjWUvKswg/DBiXdZNDTFH3UYBtaA2BAIxsi+YX
   cZHZMEL23Tmp9D1Qiv7T7WZx0DERAX7aEBJ6HBTjPeZ3VvO4LGjRgKC2v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="378365707"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378365707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 15:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="740380017"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740380017"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2023 15:55:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:55:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:55:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 15:55:48 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 15:55:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdl8PmD+z2iq/RIj3GVp7VwqxQ55yjUbjO8P2E4OM16BQvz5y/nEKWvMeYA+cCwISrADuldRh/GS7nftdvooYx85W6lgBc4hrDlitcyxRDmPmiAXSsINktWiG7wRRCfNQXRObPndH0Oez00i4NG01o5JbrnE10uvcGIo54upV2wbhAnZiHMEbZFh8ZA+7DSWXNFZY8OMOEzhgBo52MSSDAbGWUpgLGp2VpyKFQPeHJW34aq/fhvuHzvh8EH1fG3m2CxDow2T0L9pmclDnkFw6hc9oHeA27nzMHHb0EMtkurWMWOFl/TaIB6f0DmmIEumuIsem77pQMd06JXLq1qQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzWdp6ECalEloimKORa0f1C1jL0OS8gbY68TPASO/MY=;
 b=GspLl3KCg9Q43bzzydoPD/V1osq+nrQZ11avsHIMrFzKkkMA0e+UTLLZ6B38b6pvWu0tPnXyUUgtDrVq29tS840NUKyDitry7ORHs7L3FO+8/qMB8K2oYz36cqDV0oy28BwpSSYynzKMYc+Hi8qULggaRcWtBSPPEJAZSbBElul+HreLn0zXHQdG6GfWhKYR5jnfRVIMyWJ2m0tOcdE0IProFwJejXC3z6fQPpG+crhF9/cIe8vEGAKjqMW3OWWe1xi728LV1swaQWPW0dY2GDe/aMwRa6x+rzGbpbFZxa5cnSz12umwjWau+1MKXYt0Bf862+XGBFwOgjp/DNncfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 22:55:46 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:55:46 +0000
Message-ID: <849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
Date: Thu, 24 Aug 2023 16:55:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
 <20230824111455.686e98b4@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20230824111455.686e98b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::21) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6717db14-b404-48b8-c704-08dba4f5405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPbIQtffVGnmiNCQ658Pr1+zZt4Ysc5U+7xnpwLOp6vTBnFXXSGDME6dfyFoBdmBVF/Un3YHbRilleGcRpmcFSnm1pNNWGxrX+oQ13ZB9SBDuxCqqlo5nhFIFcPfamze9LEMZnKIDCKboyTfpxLxSTdTaJTG5CVlYXVHid70vGJenox7Zid1/P4Gm9xUxKN0+bLxVUlj97nyUHSPvM6FIJTHH3VMW7dEmCmXEzL/bu27WJxDX+8TpTu2dAK9cxIpLUlfmOUoK9zJqvTOEhnunRKEi3G7nn2b19i8Jv4Q+8zbzolbw+93PfeVuVEWtno8gwjb0P0JV+Cn7sc2gT7ZLarfloZJyVgRbRRvwkJtenrFpbcg5j2gaMNUEGV0Ls1HnbuKZ/cscCXbCnY4SyKs6XLCrLGSn9HMV3kpD5DlIXxL9ENE3i9pSGvsJYSh2o3Y1cHVZ/cZUMijK8u0XtHLAX1jOpegFistLC7CkdDv1SotYW0uZlGtJlBnjhG6LRnN25YbIczar2GfxS07GUQCa9vOVYlfXrps05uU34xkRXyIyRgZsedEjHv/FeVcVrLy8PgFDp4HpH52BpqdgrwquNM0dkVXR1WUuLm9v8CbqIcTzNWKDmOPGAGyTgMuzwv7ydZTWjiUtZkgd5GMM4TqVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(86362001)(31696002)(2906002)(36756003)(83380400001)(6666004)(53546011)(4326008)(82960400001)(8676002)(8936002)(26005)(6506007)(478600001)(2616005)(5660300002)(31686004)(6512007)(41300700001)(38100700002)(44832011)(6916009)(66946007)(66476007)(66556008)(6486002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09oTlUxamxuM3FHbHBsN0pFUTFlSG55VXh5bHE2VFRreG1VaTRIOGkzaVV6?=
 =?utf-8?B?ZkU0elVvRTcrTGlUeDhIeHk4S1dLN1hyMkcrS2xNLzJnU2FtTGd0dlgrR0N4?=
 =?utf-8?B?cHpzOXlvOHZxbUMwWHBWNmdrdHIxOWhoZTdFV2N1SXVINWlMbWsvZ0JZZi9u?=
 =?utf-8?B?SExtNnBHaTNSSDJCZ3ZwMFJrTTNBWXV0eEY5MmxlVmdtUExZY0JNTlJ0Wmc5?=
 =?utf-8?B?aDYwcmxpRkRJRElrWDVRVGR0djBhckxNbC8ydmVLYVJNK3huMHdUbzB1L0V3?=
 =?utf-8?B?dG14QXRXcFNHYkhQRldDbnE0NW44R1paS1MrQm1SaGxZRFJRWXNzQjhETGYy?=
 =?utf-8?B?UVhCc1ZDckxRL3ZKSU9jdVNZUWJpRURhU1RtOXMzQk4zUGRYREg3RHlGVVZL?=
 =?utf-8?B?bzlOeFZQekJuOWlhTDdMZlVCV09pb2FyY2FmNytXM3Rya0JKS2VGWFVRTlgr?=
 =?utf-8?B?V1hNMzZxZ04rRWdtcTdodkRkdlF3YkJGOGlmaFpVZ2V2bzkzeVVKM3JtSSs5?=
 =?utf-8?B?cytXbUhJQXgyMHN1eGoxZCtYVVNYaktVaXlySFpxVjgwMVVwamVhOE5YZzZ2?=
 =?utf-8?B?QlNnOXhCU1JYZXJkQm5QYm1lTU9POHdtcEN4eHF4U1hoNUlON1NJdTBPZHkw?=
 =?utf-8?B?dVJaczhVb1BibzJUMTUrMExKa3hWVyszSmRqdXE0TGJ3Qkh3M09lcEN3Z3pX?=
 =?utf-8?B?VFo5M1B1U0p3MzVSNTJMU0pyU3kvY0pBeG5oaEx1UVFjSGlwOVRIQlY4Unov?=
 =?utf-8?B?WDIvQzdDLytRN2g2QWZkOGRzaFlEWHQ3SUxPK21DL0pCN3RxMDRwaGZJV0wv?=
 =?utf-8?B?QXRSM2VaaHl0MDExZlJPTXJCWk9pRU8rNWYzeG1Uelo2UnF1TjBIYjF4L1o1?=
 =?utf-8?B?ektrOC94Y3RUYWR0NmpLVVp6TE1VL3hpREdNLzNqWXV6T0RzYTNwc0FUTERE?=
 =?utf-8?B?aGNtUWpBcHFNZ0ZnSUxFODEyaUVONTNVZXkwRjcxSDU5NVJsODFiNG5LcGhJ?=
 =?utf-8?B?d0R2SnhVSzFKKzBub0hpcUUvRHlLd2k4TkhwOUVwdm9jbTYrK1A3S2VDWUNH?=
 =?utf-8?B?cFZpZGhROFJzSGsyN0NDeEVWWGRrMHQ3WkJqYXB3OFYxZzZzMEZ1NzUyNGk3?=
 =?utf-8?B?dXYvS1g3QXhYdmYrZnRZWTRoalo2V0RxZ0h2Um9GTnR6THJmS2g2dmhoUnJy?=
 =?utf-8?B?cU5pM1p1T0E3SGFyVUtUeCtYaGJSK0VIQy83aFQwcnoyS3BZY0pKRmwxRkVF?=
 =?utf-8?B?THVlclFUZmkzWXZ3WklvT3JobVdGbU94cFQ5SkQwTkxCRjJkWWJ2RitOSWtP?=
 =?utf-8?B?TkVDL1ZkeVVPK0MzUU9NUjZHREM1ZzNNeU1HWXBObDdMR3dpNEhiTTJ6L2Jp?=
 =?utf-8?B?QVNMQVBucm9Qakhza1FtUC9ZdS9hTFU0Ujd1TEVqTE9rOVZ1cmM2ZVZacjJY?=
 =?utf-8?B?ei9SQjhmMmtnMTkwaDAzVE1CVzNOT3BUVEx1b2Fyc0dDV3ZvMG5Rd1NDeVFn?=
 =?utf-8?B?ejdBSGpWZ0NxWDFwekVNMGQxQ1RRM3pXUWp4RmhyOHRDazhWVS9HN21Fd01U?=
 =?utf-8?B?S3NORmhaRTd4ZDdnV0dFM1ozenNtL2l2WFAyNkNxNDAxZXRnUGk0b2YyQnEv?=
 =?utf-8?B?Y2NHY0pIU1ZZcUxIZXFqTitQT0pDWkhRVFdQVjk1ZVE2c3orc0pnVzZ2dndr?=
 =?utf-8?B?RzBOSXdEaE5tdGZPa2t6RHorU3hlaU1odjMxLzZadlZQZm4xRUxZUk54YlFn?=
 =?utf-8?B?NmZHQ084bUR2Wm9jdTBwVmVjMG5LVzd3U3NWYkdqWGtVODV1aUh3UHp2c1lC?=
 =?utf-8?B?TGRIYzBqN3E2L0hoTDUyTVY5RVdpWEZkQVowNk9PbkdOVHZDdWxLblVvZ2lN?=
 =?utf-8?B?a25aZ0E5c29HdUpYUk9tZzRVcHNHT0pVRzY5U2VNL2tzbW9KSnVUMElMYk8x?=
 =?utf-8?B?SjBkNzJTVmJ5UmVrNXcwQnBNdjRBUjNFZlJSck9jTmE5c0txK2hNNlFRWkpI?=
 =?utf-8?B?eFJ1aVBDWHdPREZQK0VBNEp4OFVPdkxGdGk5K053ejQ1clhIRWdpR1djOTZ2?=
 =?utf-8?B?dUNxSEUzR2todGZrUE9xUEgxMFpESnNPa1EvdVk4bGJ1VG5QYVRUT2NXUjNN?=
 =?utf-8?B?clJCV2dWMFZqczI5NFRhenZVTE96UkFwRFRET1NrNTdaWCtLMGVUUHN5c2Vp?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6717db14-b404-48b8-c704-08dba4f5405b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:55:45.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz0merVUBjdgXy6LcGxVXLn2UMsJyQ07jxoiI4d9iOlG9USG7Nei/UNysWfCMc2Bk6e6UyGt5MdWpKh1P9hR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-24 12:14, Jakub Kicinski wrote:
> CC Willem
>
> On Wed, 23 Aug 2023 10:48:29 -0600 Ahmed Zaki wrote:
>> Symmetric RSS hash functions are beneficial in applications that monitor
>> both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc).
>> Getting all traffic of the same flow on the same RX queue results in
>> higher CPU cache efficiency.
>>
>> Allow ethtool to support symmetric Toeplitz algorithm. A user can set the
>> RSS function of the netdevice via:
>>      # ethtool -X eth0 hfunc symmetric_toeplitz
> Looks fairly reasonable, but there are two questions we need to answer:
>   - what do we do if RXH config includes fields which are by definition
>     not symmetric (l2 DA or in the future flow label)?
>   - my initial thought was the same as Saeed's - that the fields are
>     sorted, so how do we inform user about the exact implementation?
>
> One way to fix both problems would be to, instead of changing the hash
> function, change the RXH config. Add new "xor-ed" fields there.
>
> Another would be to name the function "XORSYM_TOP" and make the core
> check that it cannot be combined with uni-dir fields?
>
> I like the first option more.
>
> Either way, please make sure to add docs, and extend the toeplitz test
> for this.

When "Symmetric Toeplitz" is set in the NIC, the H/W will yield the same 
hash as the regular Toeplitz for protocol types that do not have such 
symmetric fields in both directions (i.e. there will be no RSS hash 
symmetry and the TX/RX traffic will land on different Rx queues).

The goal of this series is to enable the "default" behavior of the whole 
device ("-X hfunc") to be the symmetric hash (again, only for protocols 
that have symmetric src/dst counterparts). If I understand the first 
option correctly, the user would need to manually configure all RXH 
fields for all flow types (tcp4, udp4, sctp4, tcp6, ..etc), to get 
symmetric RSS on them, instead of the proposed single "-X" command? The 
second option is closer to what I had in mind. We can re-name and 
provide any details.

I agree that we will need to take care of some cases like if the user 
removes only "source IP" or "destination port" from the hash fields, 
without that field's counterpart (we can prevent this, or show a 
warning, ..etc). I was planning to address that in a follow-up series; 
ie. handling the "ethtool -U rx-flow-hash". Do you want that to be 
included in the same series as well?


>
>> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>> index 62b61527bcc4..9a8e1fb7170d 100644
>> --- a/include/linux/ethtool.h
>> +++ b/include/linux/ethtool.h
>> @@ -60,10 +60,11 @@ enum {
>>   	ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function - Toeplitz */
>>   	ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
>>   	ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32 */
>> +	ETH_RSS_HASH_SYM_TOP_BIT, /* Configurable RSS hash function - Symmetric Toeplitz */
>>   
>>   	/*
>>   	 * Add your fresh new hash function bits above and remember to update
>> -	 * rss_hash_func_strings[] in ethtool.c
>> +	 * rss_hash_func_strings[] in ethtool/common.c
>>   	 */
>>   	ETH_RSS_HASH_FUNCS_COUNT
>>   };
>> @@ -108,6 +109,7 @@ enum ethtool_supported_ring_param {
>>   #define __ETH_RSS_HASH(name)	__ETH_RSS_HASH_BIT(ETH_RSS_HASH_##name##_BIT)
>>   
>>   #define ETH_RSS_HASH_TOP	__ETH_RSS_HASH(TOP)
>> +#define ETH_RSS_HASH_SYM_TOP	__ETH_RSS_HASH(SYM_TOP)
>>   #define ETH_RSS_HASH_XOR	__ETH_RSS_HASH(XOR)
>>   #define ETH_RSS_HASH_CRC32	__ETH_RSS_HASH(CRC32)
>>   
>> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
>> index f5598c5f50de..a0e0c6b2980e 100644
>> --- a/net/ethtool/common.c
>> +++ b/net/ethtool/common.c
>> @@ -81,6 +81,7 @@ rss_hash_func_strings[ETH_RSS_HASH_FUNCS_COUNT][ETH_GSTRING_LEN] = {
>>   	[ETH_RSS_HASH_TOP_BIT] =	"toeplitz",
>>   	[ETH_RSS_HASH_XOR_BIT] =	"xor",
>>   	[ETH_RSS_HASH_CRC32_BIT] =	"crc32",
>> +	[ETH_RSS_HASH_SYM_TOP_BIT] =	"symmetric_toeplitz",
>>   };
>>   
>>   const char

Thanks,

Ahmed


