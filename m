Return-Path: <netdev+bounces-40486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AE7C7861
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89D1C20DFE
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D43D99A;
	Thu, 12 Oct 2023 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+flIhFS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358736AF1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:07:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC10C0
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697144829; x=1728680829;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KTNNp+BLOiFHbifjZaIXCASS3InKy5CR2ocNh2wsNO8=;
  b=O+flIhFSStdEGejz4BBzMVEnNxn9T6cCiEEEqnQJ5nGCmSOTYgstnfUK
   xlONdO/POaV+aBI2i/w6utJVL3uwGtAbEjs+IKF+wWxSxlRnixBo+ZFux
   xIf3FexkAEBXeBQAhWVv5RzR99x7S2qGlx0j4keOQ6qdXU/2oR4CJ4PY5
   dm2ZPD+HM8nd8pngB3PxuFfqgdXu6b5PElnCtLJP3Oa4HyF4Ph+MrIGrB
   c2nFV5vP9wp+gcM+Fbxs8H7dKqD5YcaAQnnST2DnhKrBWHExuX6o9v5w5
   hdzlLF7FjEguvJl9zV6KPboSXXqkspxLfrssQd9gDBlqcdl4yq6KZXY0z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="383897922"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="383897922"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870757487"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="870757487"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:07:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:07:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:07:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:07:08 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjYvp+exNTCeTvqt9K4JNf0xkP8pQHywuHMTLOUyow7s4XM4LptAqUzKo/yjqgHE+yG1/Fdp8bV1IxdJMCaqZgCbT0+keO0JHnyijy9SSAolR6+OEJlv1/SKb3nQ4UJK3aPVjn1zZjxA1YoxnkJ5nnzs+F8SVvMUOuabHIPkRxQsYpzv99nFse54qvbj1IhiRLoBuZ8R2kvfy6jzZMlcS3gqem2p5KBOdHK4Mpk9bQeYsMDi9bhxB5dI9Tc2jvKJrNXbk5mSVBeGUiqBV8E3PDrcQ4gtlf7qx1WfsT1gVIcZAhrHIZCbTPVykVPr7PIBdxs3Ly/jN7wgjultZ/K6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8Rpa572XxBb/hEP1QtN2zl9A4f020i8hOEl2jI30Vs=;
 b=Q6lqTGm0kCAaiKCzWogwqtiCE7IEN0J3GJStg+YGrNXGmmTutrXYEPOV5U9QMxU3GUHzIILOK27K3jQCrIPVkxTSBxfczpG1Qnc0XknNdoKC72iZlF3ljgP2Ua7sTql9VNg+Q+Hg7h4qcPMYZQIklFkN8+bZ/MThSe76LaMzuBJKSB6yR4VzTCabY0rFq7G3MXJ3ESMLLr66CuqzXX40noV7G8TRXgmeYZDVvCLQQfgCafu3nxVvKYkd00edLSDj4cQy1m1RXx+fy/od2JN4P7nNDrRL9ovl+rN96jH7iheWGg87NFwPdroIS+R/FCIOd7fF7NlasSU04JMz7g5h0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7530.namprd11.prod.outlook.com (2603:10b6:8:146::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:06:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:06:59 +0000
Message-ID: <b8705217-c26e-454d-a7f7-d24a4d8cbd0d@intel.com>
Date: Thu, 12 Oct 2023 14:06:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 02/10] tools: ynl-gen: introduce support for
 bitfield32 attribute type
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <johannes@sipsolutions.net>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-3-jiri@resnulli.us>
 <20231010115804.761486f1@kernel.org> <ZSY7kHSLKMgXk9Ao@nanopsycho>
 <20231011095236.5fdca6e2@kernel.org> <ZSbVqhM2AXNtG5xV@nanopsycho>
 <20231011112537.2962c8be@kernel.org> <ZSe8SGY3QeaJsYfg@nanopsycho>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZSe8SGY3QeaJsYfg@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec89734-f46d-4fe7-aea8-08dbcb672cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/gVLTQ7H5Hh98S7P3FmAZkR0YZUaP4sxvag7ozKVvjO4y2N3jRh9BoTJDHKhT8cDnqfdPiA1CdZ8anMQoUrXqbqPC2U5c3uKuH9lJcS4HE8DcUfex0QpIT78rfro2VPAiFMadY5Ofxz3zT4NXOPlf/h86U4MOfHuBLx4vUhAPiuOB0HKNPdXDD7m4/zG+IG4TB2kB/oXN5LOMopRsIYmffjKu/GvpPv9DvjM0hJO+p1QREaYd3lJtSS7BwW4FbmfsM1GStdCUTnJ82nfwVdh/YcS1WcQy3g2ZdshkUqGRm9sbiMl6IbCpXGbpiQVTHzROp1dQTvneri5ilfiwT52x/EUaBvdY72GlXGDm3a3TLPvV5GZD+a38/GMQEv0Rgz3rKwsU4Ii9WTskYV03IvNctEU7D+nu5RTkWewdVfgt947R5FzqLX0q5TGpY5DQszZKkHuegwNL+9Xg/I8eda6Qf8Lwb55ZkaKAEKMZn0Oq5KO0JtIVaAr3hXSm6byTaw1I9f/qiXTLi50aQ68pAPkBKOVKk8bWWwatEu49XndMojgsg3zcr5h80qhyQFoWQRqkMgTqunTpXMAOZwNAQyy4fdmBVsaFsV6Rv8kUeOcEaRNfZzr8BS8O48YpFMqRJlh2i/bXE2XBAdivQY7LP9Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(6512007)(26005)(2616005)(82960400001)(478600001)(6486002)(5660300002)(8936002)(8676002)(4326008)(86362001)(31696002)(2906002)(316002)(36756003)(41300700001)(66476007)(66556008)(66946007)(110136005)(53546011)(6506007)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0RGNmc2aHhjR0N4V0ZTdWJsMStWRHpkTEJMSWRtY1NBWTlDMXdzTUpRTTla?=
 =?utf-8?B?RG1ObGJQL09FQjZoT1dueGhpb3lVMWpCeG9jL3FjYkRMS1dhdzQ5WHdRUDlt?=
 =?utf-8?B?MlJqQ3FZMFVkVmtkcFhwdXNzSTg3NUIyYjVGdHVRNEpVRkVsNnRCcDBlVW4w?=
 =?utf-8?B?emhsaTdDZEt0VkVPLzZNWUVRNmYwaDZLcXRoNXJ1OXFhMnN6QXU1dTI0eUtX?=
 =?utf-8?B?Mmk2RlhIUlE0WUx5NTgwYzhRR0F6aklpYm9Ca3hKT0hYc0NMRHlsNkFsV0dP?=
 =?utf-8?B?N2YvUkg0UkhZWlJjNjFscjNoK0l4NDRZSXJuRmdmVXQ4amNINVA3eEdhbUtU?=
 =?utf-8?B?Z0VqcU1IYUVDZ1RQNG1raTRETTlRcVByQ1h5NnNvZDA1RitMcnp3TnFDZ1hC?=
 =?utf-8?B?Yk1DZWhaS0xLNzBzYWVPRnlKOVpjMWdwdlQyTWlzWGRMU0dlZFdIL0lqRjR1?=
 =?utf-8?B?K2ppZU1vSHpFek5hRmxyakVBYldqVjhqL1pQU2lud2p2WW1sRG9pRytTc3lB?=
 =?utf-8?B?ejdDT1JlZVpibDQ0MGNOYS9nV3NNRVRkbUVxY2UwZDlkUlFIUGpKOW9EOVRY?=
 =?utf-8?B?QVp1K3A3VkpVeFRwZ3JBemtOdlVwbXJud3ZPWGlGbklPMnN3UlZTTXJ4OStY?=
 =?utf-8?B?ZlpsREtEQmkvQzV0VzhPdlpWaGNFbXhFNTBZVGNpWlFza2h2YkVsVkdkNEtP?=
 =?utf-8?B?Qml4am4rREZheGpzMU1EZHRrTXVkWXlEcFFGRzd5N2dTRFVhSXI5WnQvelJi?=
 =?utf-8?B?a3R2YnczVzMyZXdrUWZYR2NuOHBCOUp2MGhkN01YZlFxMU56cFlpVXBKeko5?=
 =?utf-8?B?aElab1JsZXgvcWl6R1JiQmVZRG5Vc01va05ONkt4Ri9IQ2xaVmRGRVBlNVBs?=
 =?utf-8?B?Q1dzUUkwQ01rNnJLVWpYcHdPamY5R2lmd2dPY2VNLytyL25OenRaMFN1VFZL?=
 =?utf-8?B?SURXR0lHd2NYNjF6Y2VZcEVGV2d0WmZtYXZjYTRlZ0FHL3F1ZW1MUEJJNlNR?=
 =?utf-8?B?dUc1KzQ0dkRvSlBQdzhTaHhsdnBGeEorbEJlMzdxRm9uS1JleThEa0ZkMVVj?=
 =?utf-8?B?UWNCNDMrVTdVK2VncUJGcklCY2tBY0U0ZHNKMldCTnBOK2M4Nms5RmpmWG5k?=
 =?utf-8?B?MGZSYm1zd1Y2aURPM3ZSSWhZTk1DK0pnTzhXbHZZQ2YxVC9DY0lLNy9VellC?=
 =?utf-8?B?MzFXWHg0bkdKcW9TZHRVZEdMR3VkM3FiYy9oR0NSb1NzWDE2L1M4dXpxNVdw?=
 =?utf-8?B?cHdUN0tYTVozWU53QWtkTjFGUTl5bDBlbThpMXduNTdtUkxrU1FXTWc4VTRz?=
 =?utf-8?B?OThFdEpPQnpmN2lJUkFRc2p6U2phZW9IL0ZEWW9ZOGV1ZmxMMWJsMmVJMWpx?=
 =?utf-8?B?U2g2OHFJbUdTSkM2aGhwQXZEQkxtbnJZNEZ1alNjTko1OUdDbHdvc2F0L3hW?=
 =?utf-8?B?ajh5S0htVDgyS1pNOHJGajdmU0V1OWhjOU44N2RQcGw5d0hOelVpU004bERV?=
 =?utf-8?B?L3gxRHJUOHRqamdNakRTdUFoZkloWXdlMVFNdE9CdlArREJlV0N0QlBqRUhq?=
 =?utf-8?B?bGVMRXhjV0FMd1VuMUcyc0F0WjFhUXlPZGRZUzBLNExTV0xmVnZiYUNjMXpj?=
 =?utf-8?B?dnI4aHhudXd2UnJQU2ZqQkdjTTdPY0FLNnU0SXdyM3htc25INVM1S04yVUVS?=
 =?utf-8?B?aDEvZnFlc3hmMUNzOXQvSkl6MHJlTTRteUFHUzFpeWxxWk5wREpZeUljRmlM?=
 =?utf-8?B?TnBFL2d5TmJBaGtML2dGcXZJTEVlL3hYTVpMS20wcm5qb2ZIdFUvVTVlbi9P?=
 =?utf-8?B?ZndxRzByeE5uaUJoaXh1NFArci9kRk1YSUVnNmw1VHZ2d3pMc1hjMnJvOWpq?=
 =?utf-8?B?QXZoNjFHa1crV2ZjcHg2djVuOU93WFZ1MHBwTHBDRkMwYXQ1ZG03ZTV2US9M?=
 =?utf-8?B?TUx4cGxxL2FTREorRWZIYkhkbEVYQ1RpakxqYzhmNWd1NXFURVhiVUFueHQ2?=
 =?utf-8?B?dkF6Tml1V0FQTFp5b3h6Z0phMnY0WnRqVXRzUDhtZjIyQXB0YU40MUUrRUd5?=
 =?utf-8?B?TnhHUnh1TFJDOXRIcW1mbldWeW4zTG5kT0dUa2RWeXdoVTNSN3RhWm1QUGNj?=
 =?utf-8?B?SmdVd3Q0ZUhyWWV6U1dsNUJSUmxuc01WVGxKaHRzaVdjUHVhVWtVM254QjdU?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec89734-f46d-4fe7-aea8-08dbcb672cc9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:06:59.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7lytsAzWyrrBaFPlBXHc1WLw4hAy+5CVMlbUXkrHYLufX72CBLpgvAXKaslByx6+YYZE0O4Gi9F+ysIK25mKHBRz/NEdHmnM6CbR1Wou9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 2:28 AM, Jiri Pirko wrote:
> Wed, Oct 11, 2023 at 08:25:37PM CEST, kuba@kernel.org wrote:
>> On Wed, 11 Oct 2023 19:04:42 +0200 Jiri Pirko wrote:
>>>>> Why? Should be usable for all, same as other types, no?  
>>>>
>>>> array-nest already isn't. I don't see much value in bitfiled32
>>>> and listing it means every future codegen for genetlink will
>>>> have to support it to be compatible. It's easier to add stuff
>>>> than to remove it, so let's not.  
>>>
>>> Interesting. You want to somehow mark bitfield32 obsolete? But why is
>>> it? I mean, what is the reason to discourage use of bitfield32?
>>
>> It's a tradeoff between simplicity of base types and usefulness.
>> bitfield32 is not bad in any way, but:
>>
>> - it's 32b, new features/caps like to start with 64b
> 

To me, this is the biggest annoyance with bitfield32: that its not
flexible in size, which is one of the big benefits of netlink. That
limits bitfield32 to be most useful in places where you don't expect any
such extension.

> That's fun. Back when Jamal (I think it was him) was pushing bitfield32,
> I argued that it would be better to make it flexible bitfield so it it
> future proof. IIRC DavidM said that it should be enough and that you can
> use extra attr in case the current one overflows.
> 
> Sigh :/
> 
I don't like that approach because it means you need different handling
for different sets of bits which can be a bit frustrating. I would have
also preferred flexible bitfield as well.

>> - it doesn't support "by name" operations so ethtool didn't use it
> 
> It follows the original Netlink rule: "all uapi should be well defined in
> enums/defines".
> 

What's the "by name" operation?

> 
>> - it can be trivially re-implemented with 2 attrs
> 
> Yeah, it's basically a wrapper to avoid unnecessary boilerplate and
> re-implementations. But I think that is a good thing. Or do you say it
> is not desirable to rather re-implement this with 2 attrs instead of
> using bitfield32 directly? 
> 

This reads to me as "its easy to re-implement with 2 attributes rather
than baking them into one", and those attributes can support varying
sizes instead of just bitfield32

