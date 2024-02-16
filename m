Return-Path: <netdev+bounces-72577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1CB85892D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BCD287566
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7271487C0;
	Fri, 16 Feb 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Os+AS0L5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43B1482F0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123843; cv=fail; b=j5UUUF45TooSuJNU0bgtRBgnWwRFqZJJlwTeHHzN0mwheP3pxRrTnPeXaIfZeXdlUh85cQuj3zfbUX+h96dNtf8at0o87wiwsLJ8z0OUhDTbXBO1JTGi90qsrRN/UX3F9PUXCMzqjeIMTI040iF+PT9uW8emmdcp2RC6w2KeY1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123843; c=relaxed/simple;
	bh=PTbh52Vr6QfpWPvwFlZR4/6e9tywnk1Mkpy96gpFOnY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asmFdhB4CaZtlEJwY4s7boGEPjbsOboq0eGy6srNzQW8kZwdiVR0JbVoM/B3qg6kWzNiWMwRTYp+nz/7RjaU0TVC5rSZv3qSiV9fUXKfw1zlqNCBvtqWHcQTXlQbqMG5mSqb2k6+1r+sASovKXES4JelAJHVCeoyTAZssPT7h1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Os+AS0L5; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123841; x=1739659841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PTbh52Vr6QfpWPvwFlZR4/6e9tywnk1Mkpy96gpFOnY=;
  b=Os+AS0L5XyGTk0zqNj9o8bPiQTng/WFt1DUpjd5tRPSLwQafqPXmfQMn
   c6CDwZVwvFAOs49ck9rH182kG311aSROjJCDX3tWPdsr7lAU3w5nkzzxk
   JNqoTfgViROdr8/mDLfOq8ksnaQmt3J+0x9W/MzIt6bsU6D6ULCpJ5iUJ
   Sf8i59S1OVLnXR6IUi4++3yijkHkqT1cnKn6flQ+moYMkA608x0kZIG+q
   d3ZLbR3NLlbdTgDVaXDrLz4Bq+DsMahTnzTuLmoJIAEM6ui1gKhznGXxc
   ps7wZg2jhPNgliuSfseOeYzKL7DPfz8sSm1f0JZnZZXG7GD3dJm+5bAk3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2383880"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2383880"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="27126091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:50:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:50:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:50:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:50:39 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:50:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIVNmAIjyK5xO1gOz1diR2vMaDqxhavKw4f3zHSLuLe/5pISoeLvEEBB8ukW21gxt5W74dkJ6LzvBvnSh23cLyHApV70TOw15664fh6TMQpewc3Mya/CHnAJkQScqWb291TQvz0hBYiE9MhLEaJm37CJ1ybq4riy8j34ha+3VJPz0A+mAucn3zR/tYcEQwNhEVNeek0vi9CJ1e52rtlBeInYFZejp5BU2QeKt78AJpT8fQYWguPtF0bUqrL7BAQsqBehCINt2j7TEhZmcW0XxucMXviH5lUJGfE3eyeUSa+hhEfxL/57mrhtkW0Nt8yi3WNwVx3rxVOR1WyfW1b8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uZzK5qss1nIu6MmRrB1h5h8tMBic0buOswwSEup0QA=;
 b=M1JYxHm28qfSpDdYQtVvZfPHQTrlwD0AdSgLjchIDMVtvasR+UJEIg1pA7xjBttfc7vZ9Qzy4/JVjyS4k1W2g0fN8hX/8MLtienVmcHZLPg1Kc7pFb3qruFqWq2F46pzxhtYMIl/SksIB7BkWRhTjrov5865U8FGPDc1VJNEzbUle53IjI/pyMyHJOHe3i+eSlcrH4PbbESoSEGCSEZaSXV+4vjA5tK2pIPxttdX3/v/XvlqJV2QVCjX2/+ptWaJXjStY/F4ED7hx4pmp0tcjTA40tXpt5w6WnxDg20jPXHtCpsq2GV6tF160IsiE++yjydwSEZ13WDp0L+CT/xGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:50:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:50:36 +0000
Message-ID: <98e96407-95be-493b-844e-66c33e59aef1@intel.com>
Date: Fri, 16 Feb 2024 14:50:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] i40e: Remove VEB recursion
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Ivan Vecera <ivecera@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Simon Horman <horms@kernel.org>
References: <20240216214243.764561-1-anthony.l.nguyen@intel.com>
 <20240216214243.764561-6-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216214243.764561-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: a5743f1b-f043-409c-d267-08dc2f41b0b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhUE+zIERgjE7MENWhaAXaPUYYC2yQ+IqG2VCYWqInNJTBHsdZK39TuAAZ/D5xXIWdIjOd+Df7KjRfGVRnUD5gFomfG7EaeBp/qnmhtG0oSYN/mbzngOrM5UXYkj+LWt8qdNgc9sGmcJCIkwleQNk1MsfcoUUFnKrJANhYYQLVFHSHq6+8SHY6yGbafGK6rDkh/TbdPzu3d4bM0DDgI2oB4w/LDws/X3EpmdUDiL2jTXeBDVlyU7ghYOva38E56YUW01+LfN5ocqR1XpuW5CG3KaHtyge0MylSTthfdsarkQv3UKnP0TEzVLaCCQI7qcm4Q34aQsJmEQ+ds3ypHrVdghYFBVQuigfNwJqZmfJHGS4ax7QptVVzmKkJQ3pbHa6D8jbf7TeByldh3o+9BIuWPxddDJ+YZp22Vy6kH10+kKYqFCFmbfY37+NcB0KQPdIoI5YGGmAML8VVoxkW9kgrv+15ysQzf6M4pinUFepWmG3bU4MblB91pDBAI5u8U55nWWiPb7XRILbq8tYD6usC7FaZqsGB3dB8fdz3sEgtCkiMTY+1CAiaFPu94cttSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(53546011)(478600001)(6506007)(6486002)(6512007)(31696002)(2906002)(86362001)(5660300002)(38100700002)(66556008)(66946007)(8676002)(66476007)(4326008)(8936002)(54906003)(316002)(41300700001)(2616005)(83380400001)(36756003)(26005)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VVNmIyRWhhUHM3cW4xSUZweU9BSkxVM1FDcHpYTzZURVVCbDJPTERiYzFr?=
 =?utf-8?B?aGF5NlRDV3FmVkdCK05sQ3lxeVdnQ0JjY25jN1pWeE4vekoxSFhIeldwUEM3?=
 =?utf-8?B?SFJ2elVFTy9VWWlIUjVwUHNJc09DL2FXUGNja0ttRlJKWExWU29NUnd1UUd5?=
 =?utf-8?B?aU8vSzFXWHNHenNSOTlvWWRvamVhUmR6QldZOTErck1sTlAyeUtmWUFWdHVG?=
 =?utf-8?B?S1pmbFAwOWJMeU1oRHlSZ05mNk5QOVBQQXZkMXdQdDk2bTBHMyt1K3M5b2dr?=
 =?utf-8?B?c2llMzNhYUpzQ1EwRUFpVjFZcVJIcG9USW1lRStTMXhTVm8rcEFBbjBaZWVV?=
 =?utf-8?B?Rk50TjFPM0RSRVhIRW9LTmNvaVlVUC9CUUhOMm10VGlnRnVHZ0t2SVJCZThI?=
 =?utf-8?B?bER2VkVwTnRXL2pLY2J5K3JSckE2eUc1M0Z5VmlYTHo5NU9aWFRpTVFKQ1g3?=
 =?utf-8?B?enlZOEduVGthNENlVkhrSUxZSSsvM011aUVJSzVkYmlkK3o5ay9Fcm9Mc1Nw?=
 =?utf-8?B?aHRXb2hweWNzOEw5VCt2VDEwb3FwM1BQaU1hTC9ZYm1oN1k1S2N2UjhvM3Vq?=
 =?utf-8?B?OVlQc3Vhb3ZmQjdXRzRndVZSM3Z2RkZzTXQxdk55OXVFanZnYytTT0NCdkZl?=
 =?utf-8?B?SkdvblJ6VWYvWkx4cDRxUDhERS90Ly9nMHVRYytpREViZUJWcnp1WlZGSXZI?=
 =?utf-8?B?ZFVieUwyRnQ4Y3kwWVNiNjhqREFVQ0wrRWdsR2dnY0NyNXp3TzZYQytCdmZP?=
 =?utf-8?B?VGpycmoyN1VEcjBSaUI0eVkwOTBvUnZvdnBNRnJTZzNKM1FJYU1LeUVJWFNZ?=
 =?utf-8?B?TzAxMU9DZG1sbG9SeUF6ZFpIeXdSN0JQT1Z2eWR5VW1ScWpEejVTOHF2ME5p?=
 =?utf-8?B?VTAzVmlYK2dpbTAvNmkxRmNFY2tVV25Ga1FzeWZabS9CbVQ5WUdFUTVJRmkr?=
 =?utf-8?B?Mzh6UEx4aDFCRlNjOXgvT1c0bWR6czZnUzdocjJibWZHeGZHOTFlZ2RTcXlR?=
 =?utf-8?B?TDB0dkV3M2EySUtQRHUzaFJ6Z3BZRFhrb0o5MEIzTGlKQzRua0QzTSsrTjho?=
 =?utf-8?B?NlJacVNreWJxbGtPYU0yK3JVZjhWc1p0RlB0UmRyeTl0amk1NVdvbFFzdkFD?=
 =?utf-8?B?TWpLa0JCdUkydHlhYXB3RGdPcGEzd09aZFhyamhJR1pqU0hEVElOeU1LbHlX?=
 =?utf-8?B?dzhubnUxeWU0bVRJWGlSeFhCL1JiM1lISFRXNWJReUlYN1lVaytML05yUFJh?=
 =?utf-8?B?SThxblc5bWJhMDhjREl1b1RDNG9xUWEvWXBNK0RyRXltOXBGdlVIOEhuVEVQ?=
 =?utf-8?B?ZXl1bEZvenNZdkc3U1kvR0I5NlVHb1M2YlFZVWszREp2dm5Xc1ZnQUlGQitp?=
 =?utf-8?B?QSt3am0yM0QrMjdYcnh1WXBjS2t0M3U2Y1VreG5GckdMMmJSdGxWQkxKU1JB?=
 =?utf-8?B?dEFmMmZhVzE1SE9Lbk5Hd3ZrQUdpcFFIL2NuNGN2ZHZCVjcrRHloRlo4ZEZS?=
 =?utf-8?B?cmIwa1VXMC9mM0QzT3FONGhpWmdKcXQzRWJ6Tm43TDh6TGVtRldCdjBUSDV2?=
 =?utf-8?B?akREQS9NUGxET05IcUtmbmZuSHNQbWRHUDdObUNjakpzSjNmUHUrRUdNVkw5?=
 =?utf-8?B?bXhIa3NaMjMxMm40Q1p1YWZ6a2U0TUg4OE50QmpqcW9uMTlCZ3ZiYlJ5MVVr?=
 =?utf-8?B?YVhBazF0cUlIODVhQXRMVzNGQm1kalNjWGtIR2dneERuWWdOVEQwK2V0bHJ6?=
 =?utf-8?B?TVBVTVRPZU5YZi9IWXA0ckJxSUlLVU5TNGVIa3htU0NNT0phSk1HNG1rNDlT?=
 =?utf-8?B?NUpkME9zb1ZEZWtVN3ZYZ3pwZVFiUTV6VVF5NFVjSTJaQXNESHI3WlN4SUd2?=
 =?utf-8?B?eExCWm14NGlOVkk2NHlrVXc2Mll5TUhITzNDYWFiZG5yZ2czUGJnNUtTeWtU?=
 =?utf-8?B?RVVyV2VHNFB1RTdncHA4VFZUTEpMSEY1WHRybW5DOE1BbURUWXRzTWpBc3F3?=
 =?utf-8?B?SFdUQSt6WU1nNU9wK0o3ZGF2QkV1S0xHY0t6NnN6bERqWXZEclR3REZ3R0Fh?=
 =?utf-8?B?ekcweVVnMWZXOXBHK0hGbkRRcGMyMlBrRHZpemgrM0xNcWJPVVlvd3JSZkww?=
 =?utf-8?B?bXJ4WDRlK0FCMWREZ2lmRitHRDFSdzl6ZzRWQ0VHSlBjallOV0VPQkZHZjZ2?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5743f1b-f043-409c-d267-08dc2f41b0b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:50:36.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hi0sg2F4HJXcc1OtJChXXVW6CQ7z7ECYmJ8vm3fk9TZJqAX1xGaQdERkdtfWUTEgW+8dkXmrodJtd3g9Swh5sQ75bbtQ/zELstFiNIhnwPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com



On 2/16/2024 1:42 PM, Tony Nguyen wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> The VEB (virtual embedded switch) as a switch element can be
> connected according datasheet though its uplink to:
> - Physical port
> - Port Virtualizer (not used directly by i40e driver but can
>   be present in MFP mode where the physical port is shared
>   between PFs)
> - No uplink (aka floating VEB)
> 
> But VEB uplink cannot be connected to another VEB and any attempt
> to do so results in:
> 
> "i40e 0000:02:00.0: couldn't add VEB, err -EIO aq_err I40E_AQ_RC_ENOENT"
> 
> that indicates "the uplink SEID does not point to valid element".
> 
> Remove this logic from the driver code this way:
> 
> 1) For debugfs only allow to build floating VEB (uplink_seid == 0)
>    or main VEB (uplink_seid == mac_seid)
> 2) Do not recurse in i40e_veb_link_event() as no VEB cannot have
>    sub-VEBs
> 3) Ditto for i40e_veb_rebuild() + simplify the function as we know
>    that the VEB for rebuild can be only the main LAN VEB or some
>    of the floating VEBs
> 4) In i40e_rebuild() there is no need to check veb->uplink_seid
>    as the possible ones are 0 and MAC SEID
> 5) In i40e_vsi_release() do not take into account VEBs whose
>    uplink is another VEB as this is not possible
> 6) Remove veb_idx field from i40e_veb as a VEB cannot have
>    sub-VEBs
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

