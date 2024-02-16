Return-Path: <netdev+bounces-72557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A585882D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32675283651
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18BC1468ED;
	Fri, 16 Feb 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h08RPzDu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9F3145B03
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119896; cv=fail; b=tivTVZCEzfgCVHJ4AASmiAETqVUL8dysJpGDsxE3bOgP4/wO8HG4ixK0e/eP6f5UD/4j3uiWfv72LGUhCl/ddRTCNPG/80crU1XKcuf0ltL6tnfxMYF8BhegxjKpAJxnK1130Vda9htrg6yo+ztr+hzFUFQN6OqQhd7s+BboiiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119896; c=relaxed/simple;
	bh=B/MUTgUbZlxRO10kscBoF7GM4rvlLoAWyjhZqTabyMw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RrRqtPTyiOAp1qHOnbh32PZc56txQl81lza9puuiDJoILnX6g6CmWeIcQwO9lccV8ymTY6QFZo3Vmr3JhLbcib+rxv4yHKRrlJ/vxGSAvIB7FI0CofrTVGtp+ixHQPqUbJuaCcYUSIaQ/ky98oZv9kS1sjrK/vQxO5UXyv9rWFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h08RPzDu; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119892; x=1739655892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B/MUTgUbZlxRO10kscBoF7GM4rvlLoAWyjhZqTabyMw=;
  b=h08RPzDuZCZzNdnAuA8JEY5W5qvnnRP6Q/gi202kZAioFaayoEbYM5u3
   c2Lpsio7x0p1UcVCUIZ1/9QD7Tpa0iGuE3xGEEvqh67QV48zFMqI4lOM7
   wM8VQtrNrzkinw4InNFivcKQlisOSNvtvgpuy65eDuSqilYSudduVzcoR
   y+/cJyA+b8Ey1t8peoBhhyOvU/vC6CQnTmSceicgQXX7pRAGUROMy6+1v
   6jcymPrq24F1JfHGma3aQCRg5fV0q9/H3bUW/h1mFQHL6RlhgzqqHqELD
   lLNRVmpxdfOUCtAyWFkZhkYzDvNIRrrDaSLnY70uCDjUCQJZ5qhoiHf+O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13668350"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13668350"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="34991204"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 13:44:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:44:50 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:44:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 13:44:50 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 13:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGzvOs5XnTWFiZkuYNYhMBJNurmZXi2GGCMAIUNmKck9rNKUTuYW/q7SNx45B0A4cn4D2ePtiRCnjrF8RB3BzVVXc3L4OfPmr7ENPbb+4gAQ0Pa4j6MGWryrWVVaHFTmnu/qpFbStLvAt7qxOaE91LKabqDLf5QWAg8tXJFYMi3+t8l7NetiJcNo7gK302d3F8bgSSxW+dQ8dDi9lVoA49Zkvkvw/9+7pyel+oUIOqy6ghyFghIGO4RAIN3idbd9ACeTVxCzo9XkiGJI1QHG3t4s/FNClUuuf6V1ITWRB8z4D8H5/Kqff+aiXtVkG4qMeja1Uju3lako4aOM0P4K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uXOu2pkqspcgKXW/zcgLbulE6Jknwe9vBO2vCEkhxk=;
 b=B4t9O9RO1un9oZN3+FFFoFXKph93wPxpUZJOx8PLGuZzBJ9MERjWR43v9aSUSy83WbYpdH9NIG9puwS1d4NuagacTSmJMDKQssy2Oi1lPNTUrazZeZEAkUQ77siITKZJyEOdjKN79mkpzwG8/BlUE/lOTuoro/GXXV3iGYRBvIfN0oKnp4V9sad8gbCrOMVPJ090AibFWed1txLA88VKpvZ2ztW2cIM6QBKMRYc8f1fRknqhieuBMKCAlskfL/Ta6I++nSTIQNqokcEjN+57J0vkljE+w/MMUoPyBJoYMenNAZCzsl2LgN5+suqDPH+6MvDopFqm1jxJYcZxtGLLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 21:44:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:44:47 +0000
Message-ID: <e1a752df-d550-4e98-b275-371a8fe303a6@intel.com>
Date: Fri, 16 Feb 2024 13:44:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
CC: Jakub Kicinski <kuba@kernel.org>, William Tu <witu@nvidia.com>,
	<bodong@nvidia.com>, <jiri@nvidia.com>, <netdev@vger.kernel.org>,
	<saeedm@nvidia.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>
References: <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org> <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org> <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org> <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
 <Zc8YgDOf6jKIHNsF@nanopsycho>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zc8YgDOf6jKIHNsF@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:303:2a::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d05eb61-ea92-40fb-a8d3-08dc2f387ef0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoFrf6E6SHyTRghCkoLtSJrYyxiOYRvbO8jd9+HnRcEQUay1skE4hbuLe7aUn2kNVGJfX3rDoCzBtD0qxkdRoq755YGhtLalRx1C5kR9eCrL2NGFMp3RKDOS9RSSOIyq+DgFdLLS9TwRfwoe60dR3Fi25P2+YssHyj5MDkzXU0Cfz41NzKDWaY8VU/VlhuRIdrmvFgyQd/KfYWQ3Wpvi/eKXaASvvOgt9+AnVrt5gWfcmD5Be4SteYRHerUhygZQqaEAKphOX6vLMgV4mhuTjIT+cyUBw1Zdm4sBKhiolTgE/2xlL3loQ0OITaNh5gRhCgQTyDY7viKLEfV6WjqWsk4aA1tsc6GSOc/mitrKZg5YJ1a9BWch4SRoxMh5+cj/NdjDg0ylhxbWmGNFaUKEbv7JtDOiB9mniNu+xTqgUPqPlkOj/JFkC3Hv11SOC5L8Wvk9hh5YHIt+jpL+eN3adEDMPlDOj84PEQgWWMTD0ZMPDaawwlcGtq11y9YRe/sPVvHR3tciX73k1h/lB+kYthm9oLlJR60Lt0hUN9Kd445wFwEn9SVyUFEtOLGhFYtE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(82960400001)(31696002)(36756003)(38100700002)(53546011)(6486002)(478600001)(316002)(6506007)(6512007)(83380400001)(54906003)(26005)(2616005)(41300700001)(107886003)(66899024)(4326008)(2906002)(8936002)(66946007)(6916009)(66556008)(8676002)(31686004)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxTQmZ2VEJ6RElGOTJUMHBaSDUvSXBZZmFhdm1wU0RkTm04MTJvMm9xN1d1?=
 =?utf-8?B?UkhlWlgxYUlkK3gybS9taDV0ZytiaVdsc3R0UHJsa2VwQ3JJQVZWejd3UHBE?=
 =?utf-8?B?N1BPRWlJdS93aFNjeGV3cXlONHVpUFpBM0FNQk9sNVhHWlNkazdSRStiWVBX?=
 =?utf-8?B?QmdJMUp3bDdORnpxUzBwcUlvMndkRkVKMkV2cXNSL1VOdmhTRVhSN003dmFu?=
 =?utf-8?B?QXp3TkJISzFha2RheURvaEFSY1JDMzV0VmV0MU1nQVhLMWtaTk91TmFyTmo5?=
 =?utf-8?B?M3NqN2FWZmZJT0VzVkVSQmdPRTV1dFg2TTFNOHpTOUZLUHVpRHBzNEk1NU4x?=
 =?utf-8?B?dzJsa0FISkw4eFpIRkZlVUF6U2x0dVlCRzlXNC9KZm03bmptTjQwcFRBS0dw?=
 =?utf-8?B?djViQWNBR29WU3pBdTJlMTIxSEkxR3grd052cXRjRmNtdUUxVGJKUnh6NUEy?=
 =?utf-8?B?aUNJNi9JU2lnMG0wNUZmUzdqNlB1SG55YXhhWEQvY2NPVWNXcTFRT2cwcnhF?=
 =?utf-8?B?M3JUTEQzRFlyL2pSc1Q0bEZRUUMwZFRlSUZTQXhuTGNUajg5Z21DYkp5M3lh?=
 =?utf-8?B?a2RaRWhjeHJlUENuMWtuUzlIeHdIRjdhYzNyRnloU2JTdTZWY1U0UkpIVU1a?=
 =?utf-8?B?WU5FWkVHNDhucU9rM3RyL1FIbTNVc1ByMjRUQjhsVk8zNEI4aUFreWhqOG41?=
 =?utf-8?B?RWFTRVdpQ29hd1A5K0NRVW1yRGZscHpvQkJSNC9RSUNUdHRvUk1WU0xib0Nq?=
 =?utf-8?B?QzVyRHJ0NGQyMHhVSXpnSnNMalk1ejg0d1dRWkNmRGozb1ZSM0dkVkdTZ0lk?=
 =?utf-8?B?OXc0NnYxZXNKTUdwUE56MVdwN094QzNQNHNPODFZZUNVQisvUVpyQ2Q2Y3Mw?=
 =?utf-8?B?L2RVeW8wYVlHTEJkTzFyM2RkMXh3ZmNFdDJPQ1JvMWlMbmc3T01mampDTmw5?=
 =?utf-8?B?d1RFK3hyaWp2K1ZiQWVPVjZhNk45MVBNQmlMWjhqeEYxaHBlemlvYzVtZzdt?=
 =?utf-8?B?dXVBUW94a2wxTFZhOEVsZVEwSW5YblNwaUphVW56dUgyQjdBTG5Lb3lJclNa?=
 =?utf-8?B?WEtEa0Qza2lCdVQ3ZkNCM3pkTVRIZDYydDR2Z1YydkpRZCs4WFB0MXlZMWRC?=
 =?utf-8?B?VVNZc0RKR3MwbXNiZG5HZjhjTGhRU0dFaThxNEd4amNmY1I1WXpEYzFJdlZ6?=
 =?utf-8?B?UVdQdHRNekd2MG9pVEJpTGdJNWZ5RnZxMUlnYjQxaVNoWU9RKzlGVmlqaFkv?=
 =?utf-8?B?SDcza2lmVUdqUHp3VHJkeFJkSDNTU29nb1VxMUhsb0JUVm10M2d4OTBQRVds?=
 =?utf-8?B?ODJhNjZWaUw0YUpSalg3NlJXZ2pvdEtJVXFvSnZIY3hDNWM4WTlGcGYzNFpK?=
 =?utf-8?B?bnBmbU53MEtVWVByQ3BIS2o3bmtPbUpCV2Z4VmtzUkhhUGxnVCtiM2JIM3pB?=
 =?utf-8?B?WjV3dTRScitiY001eGpzaFN3dUdvM3lxRGlsaHFEWDU0L00xYUNGV1lpazlk?=
 =?utf-8?B?dmVWMkpmamozeE0rL3l3d0JOZ3ZoaGE4TUxycGticFhqZXU1U1NERjNZdVha?=
 =?utf-8?B?c0lTTEQxNno0SlhRUVVhRmMvS1B4RGd3SmYzT2NmR0FNQm12UWZjYUlvT3Bo?=
 =?utf-8?B?VUU3dW9QUEo4V0IwaEJZME9PNTRnTXNGNHN1YjdhRGdZTVVJMVVCUWZkRzNh?=
 =?utf-8?B?THFVUjRMNVc0a2ZHd01hM2puaWFWVWNEVXljU3RsYzFGY0dGSGc5aFV0RG5Z?=
 =?utf-8?B?Y3M5aVA0NFFXY1dBb0pJYWpnYk56ZG9pTXVxQXo1TTBlWFZ5SXN3aC9qWlZU?=
 =?utf-8?B?QnFwdVdhUHI0UWU4VFBhRTNHVDc4NlhUUFVyRHM1dVZkWEc4Rmw4RzNQbTV3?=
 =?utf-8?B?dVM1ZTQrWW8zaG9hTDY5V2ViVzlmZit4R2NhQmp1SDRDbGhKZ1ZRUXMzdTBE?=
 =?utf-8?B?dE5IckF4NkU2MVc0a1VRRHNLdTZ3bkVpTHBjd0FjL2hqQmlRQUxRM0ZzUVVV?=
 =?utf-8?B?djNxd0h2OFJXK0hsSG5WTDdRUlYzRzBzQk1CbG4xTGlTOU5BTk04VHoxNWE3?=
 =?utf-8?B?WnpRZ1V2ek5sY2o0bUhtc1IyRVNMMlJaTTBOY1Qxa2RxYS9uNEtscmZvN2hz?=
 =?utf-8?B?NWJPUCszdUcvcVM4Q2dma1N5ME5vbVA5Rk9WZzE0WUZMSU81c2Njejk1NThP?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d05eb61-ea92-40fb-a8d3-08dc2f387ef0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:44:47.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmdWS2TYAXc3PrqkAHDXs/PU0P+/aZr7Tbj9eXBNkwL7v5M3qoJPZxWReBx3xlp3pLi3FradTx5prN95u3/gT26GukQ7fuk5n8QiN7EUEV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
X-OriginatorOrg: intel.com



On 2/16/2024 12:10 AM, Jiri Pirko wrote:
> Thu, Feb 15, 2024 at 06:41:31PM CET, jacob.e.keller@intel.com wrote:
>>
>>
>> On 2/15/2024 5:19 AM, Jiri Pirko wrote:
>>> Fri, Feb 09, 2024 at 02:26:33AM CET, kuba@kernel.org wrote:
>>>> On Fri, 2 Feb 2024 08:46:56 +0100 Jiri Pirko wrote:
>>>>> Fri, Feb 02, 2024 at 05:00:41AM CET, kuba@kernel.org wrote:
>>>>>> On Thu, 1 Feb 2024 11:13:57 +0100 Jiri Pirko wrote:  
>>>>>>> Wait a sec.  
>>>>>>
>>>>>> No, you wait a sec ;) Why do you think this belongs to devlink?
>>>>>> Two months ago you were complaining bitterly when people were
>>>>>> considering using devlink rate to control per-queue shapers.
>>>>>> And now it's fine to add queues as a concept to devlink?  
>>>>>
>>>>> Do you have a better suggestion how to model common pool object for
>>>>> multiple netdevices? This is the reason why devlink was introduced to
>>>>> provide a platform for common/shared things for a device that contains
>>>>> multiple netdevs/ports/whatever. But I may be missing something here,
>>>>> for sure.
>>>>
>>>> devlink just seems like the lowest common denominator, but the moment
>>>> we start talking about multi-PF devices it also gets wobbly :(
>>>
>>> You mean you see real to have a multi-PF device that allows to share the
>>> pools between the PFs? If, in theory, that exists, could this just be a
>>> limitation perhaps?
>>>
>>>
>>
>> I don't know offhand if we have a device which can share pools
>> specifically, but we do have multi-PF devices which have a lot of shared
>> resources. However, due to the multi-PF PCIe design. I looked into ways
>> to get a single devlink across the devices.. but ultimately got stymied
>> and gave up.
>>
>> This left us with accepting the limitation that each PF gets its own
>> devlink and can't really communicate with other PFs.
>>
>> The existing solution has just been to partition the shared resources
>> evenly across PFs, typically via firmware. No flexibility.
>>
>> I do think the best solution here would be to figure out a generic way
>> to tie multiple functions into a single devlink representing the device.
>> Then each function gets the set of devlink_port objects associated to
>> it. I'm not entirely sure how that would work. We could hack something
>> together with auxbus.. but thats pretty ugly. Some sort of orchestration
>> in the PCI layer that could identify when a device wants to have some
>> sort of "parent" driver which loads once and has ties to each of the
>> function drivers would be ideal.
> 
> Hmm, dpll does this. You basically share dpll device instance in between
> multiple pci functions. The same concept could be done for devlink. We
> have to figure out the backward compatibility. User now expects the
> instances per-pf.
> 
> 

Ya, ice started doing this over auxbus for PTP as well, because we had a
bunch of issues with E822 devices that couldn't be solved without some
communication across PF.

I'm not sure its actually worth trying to change how devlink works now,
its pretty ingrained at this point.

But I think it is a possibility that could have happened, and having a
centralized "this is the device owner" would have simplified a lot of
concepts for managing these sorts of shared resources which are not
owned by a single PF.

