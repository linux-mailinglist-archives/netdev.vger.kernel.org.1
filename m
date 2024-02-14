Return-Path: <netdev+bounces-71853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4204855585
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765A01F2624E
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3A14198F;
	Wed, 14 Feb 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc849/xl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4213F01D
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948331; cv=fail; b=rAdwmXRnaYUqmgih8aIBVFrXRYv7CEOLjkZ6HxpQpVXBmzfarg2W3UDjyuFIeCbJ2ZxtzNExE7gypVrga8L5IzPwp2IyxN2TeOanjAE8XqHyImvCKERW/EbQv971CEGQH7GfoVrNXCfDT2Yq2nF/GetnNKHSP7uGfy0mXvTnfdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948331; c=relaxed/simple;
	bh=2IvBBJEz9flWvzKqnEeRe2ImeDlqshgoho0KaQWI2iA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSm0CNg8SOO/FGq5lqGNoCGetzBe6zQLHsXIUw+6C8ibsJ2Z1gSglRk0LywNMg1dmgM/G3jksNoWWZiF++bnKwlwnOyxptQYCXo+n3KkRrlq55kNj5xfsMxhCPW+/yVlM5ogdk6sBkRK5QpbwU8CmEdSBnSt9FEIg5j6PihPOdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc849/xl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707948330; x=1739484330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2IvBBJEz9flWvzKqnEeRe2ImeDlqshgoho0KaQWI2iA=;
  b=Tc849/xl2WRjacWMsYLyETNDL6zStYv+20agaNr8N34yoy7d/6kjF8Oy
   uXkNxlOveugEzyqVvOlmmxl5ium//tmIqRErwCgLL9fBdjHN6TLmWIhBR
   GZuFnAZL9Ijb6qfwdUEskUBFFTz1Yp6LfeH/LHJd4HG/gVtf9DacmY0HU
   MPKSnxeo1DpDoUFUJfqQwNaPwBIyDnWpnZPeQBWA5WTETbIV57DyfyhfA
   EgiIFMrDhgGUN1B8An4/+KwfaOFzz/el0Ibk4d/mP25rwK4J8IkGoRUui
   PunZF5SAqqhfPdvq7XGII2CK1rfhsOEbJx6ZLDQ5NHMEi1jc8dh4bobDl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1873172"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1873172"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:05:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3617745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:05:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:05:28 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:05:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:05:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ1vxuAPOXabsZUdXp9qplIn4o4Odvq6C6/6wp8r889KFoSmzck4ybjfs6T9G2OHHAynZiohUH1D8VXO2K9YkArEIyEMGbBeLRwh2+CdUrEpEIPCOIX2w5lrNEhbJD2UgpBCvRx7wRpiKYBsF0CrbHMS7rV9FA3J0+iZjRTOM28EzuY5iEXbxqtfZPpw0pNJwpKM3n+E/HVIv5zypG4VfsUPvMj6CsRatG5ZEb5yWDzVN6qZtJjJ5eAGJDaBHPORFDlHpy8ooTQ6AV4zs1Z40CM5liJWPwvak8+JAtF1xuT42CQlKpo/vR3NwoB5+aFqpGziWLVVtuBut3Cp5QSycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM+i6uQtTLWCuG46qFeYd638f3At9VxFiGQ1nWfSrkk=;
 b=fyZb4i2ZZm0kg4u3ngzBw6ln1tNQeNyFPIIqdQTyF+5tQR7t4jL+UPpmdBVexC4Ly4YBVqFKf8ZZeOm8/w1lnAn1ON/V8s6hK9XeFJmT38ORRW/D7Wz+TRiV0/fRXMmb0aCb6qNG+6acNzo+Xp59H+VgeIJCxGZGH1NbyOkwBi7oUHuWT3fQiv4C8PzYoN/Kc7gyy2U7RguNNams+C2QuwDrS4VXwhVG0rahn1szuI0oHkor7k2V5+TomL+nbTprd3SryPLkapv3bsy0wCeipArPXufsi1hFvfmCuJua5PX5k76lYCl/K/fKXUSAdbgsnIAipctwc53fNNuCL/Y/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 22:05:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 22:05:25 +0000
Message-ID: <a281a9f0-0c2a-4a7c-80a5-6486e7e83ddd@intel.com>
Date: Wed, 14 Feb 2024 14:05:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/9] ionic: Add XDP_REDIRECT support
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-8-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-8-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b50eb9-29d3-459d-bb92-08dc2da90c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLj1LJlxNdnAv8jlBMQtHM6l6Fkk3SD58WXwE2u27KKYgrvEuFZeC+gH/61vn0T4qsKc+sJYo3AHgY2SDrjob8dymfGG86AWEGV4KDSdbdMwBcYGBNsFCT/W0FTTkAD2SSJto38ZVhr0TkfN2VMl24wp6NtYzZWymAXxCWNEfFVmg4lO+ocLOgLm/M35CQYCwshX6FL/MjFEDQAQfRRd5K2ASwjKe1ESCyQU7VrQgqvh+4wf6Ze75Mz950uYqHL7eHCWiJ5HdqPjHc5KRWassvMgxk6wb0JjOif1qd4eCkmbsMyxekf2LKawUN9AU/B/aN8+tfFeivydYVbSOaPnMK0Sep4oyeeMJTnaSINVdszKl2WzqSdyNpO3FKmETzJuwpM+ueuc3oZwVXkGxp/Cav1qyH5wpcBz95InIHAoDKr46EXF3dYoVsWqfmxTjjjRH9Ire63huuXeQPV/F5Q1LTKep8tkUw8d/ZyD0tqM1Yeej7yK+Zq+xAXRas/p52u2egIHACkXXppy3X1bD5ZjFM0f1EohUM5WZb84kAQ5GXx3dtzR/8/mvB2UNIePPKF1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(2616005)(82960400001)(83380400001)(41300700001)(38100700002)(4326008)(4744005)(8676002)(5660300002)(8936002)(66556008)(66476007)(66946007)(2906002)(6486002)(6512007)(478600001)(6506007)(316002)(53546011)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1YrdjRrMUt6S29zT2p1YjFZNjRpRmQxQ05wUCtuL3A1SEpkZ3NXL3NIM3JI?=
 =?utf-8?B?Ky9YT1VoU2ttMFhYUmFra25VSlErYzVicVpZYWRJQzcwbnluWDM0alU2cDVn?=
 =?utf-8?B?S2hyVHl1MGIrZnJzQUxNTzd6c0lLUlFucGh6SmRVek5RdTFueTRLV1dhTjNp?=
 =?utf-8?B?RWxqSWdFK21PemhTbHllQ2JrY0N6QU85ZHcrV2FFZEtYRGRlK09Fb05JUjFY?=
 =?utf-8?B?R3FzakI3VDRQcDdxMkkzR0s5aFdCWXdmdFQweHZzMHh0ejFscHhUaTVQZnBx?=
 =?utf-8?B?MlUwQ2MxU21ndHkraE5pNGJXUVBxSG5PNk9tTGwrRzhUNG5ubStmZ2FqVmxs?=
 =?utf-8?B?c0h2dWV6U3dLOWsyaUVBN01RT3BTWUNLbkFHbm44OWtrcnNXUjJ5UXpQbEc5?=
 =?utf-8?B?bk50M0tORGJkejVEdVhqVEs4YmVYNlJwL3diTW43U3NZMFlDTERQM2lSc3No?=
 =?utf-8?B?VmV4UzVsRkIzTGNOU2lFUERZQWl1SHMrSjdTcmR3RW1BSnBBRzV6OFdlaUxz?=
 =?utf-8?B?djVDdUg5TGNmZTNKdkxGL1ZkTmxybzV0cndQWURDZVFOd3RJUlRGSUw5L1F6?=
 =?utf-8?B?Zkw0Q05YZmJVZTZFWm1zaGs4dTcyWlRCV2FITW02NkR0bDFZSzFnMXJDSUcz?=
 =?utf-8?B?SkhZcFRFQzhGbTBveTA3cWxNWUhKVzZYNVVtQVhEOElRZk85dHRHZVpubXFH?=
 =?utf-8?B?blA5N0FkZnM5dW5PeC91eEdIbko5d1lFeEE3Z1RsMTJFbEIvZWMzRE1URE9k?=
 =?utf-8?B?dkZJbTl3SkRZbGl4MkNzY2xHbnBlYWhOTlFsV0JTUEZxdlRpU3ZWdmU4MzA1?=
 =?utf-8?B?dHhIaVpzVmRtODU2aVF2VGp5VU1RUU1pS3FNRGZ2dnJ3QWN5WDMwUHNjTzJM?=
 =?utf-8?B?RUd1WVA1RDJlRnFmTWdFTmNZT0d5QzY4TEhjUjVLdjlWT1U5OS9mQzdybnVm?=
 =?utf-8?B?WFVILzVSNFB3MzRzMEtHWENoLzdnSndVY1IvMzB3TzdPeEVZOHptVE9odlND?=
 =?utf-8?B?NEtKc3lvS3BkZ2Y3RzVGSExGcnRVdi9wUFRIanZLY21SeDQrUG1lTjdmWUJQ?=
 =?utf-8?B?Zm9EU1ZHOWtiYmJJT092QmJEWnN2Y1RKSCtXeERDUnNRb2JiNUxrWjBzWlJs?=
 =?utf-8?B?QytROGNKeFFkcWFZanA2dld4eVRneS9VZStGMGt0MVBJL2JzK2tidy9hcWdG?=
 =?utf-8?B?aVdwbERQc1hDb2pqcDNSUmFpSnVqOVdLODhNcG56RThlNkVXd3BkS1NqZkVR?=
 =?utf-8?B?c3dnVjE1eFhaWWl3VG1Ha0w1d1BpMTh1Ukh0LzVyNC90Q256d1FRaTdWbS9z?=
 =?utf-8?B?NWp0OXprb0F4b0RkcXQwUmRVclJFODVjV1lkRE5SdHlYT1VKaDNtTXkwdHFS?=
 =?utf-8?B?cjIzTWhQaUhnRkZocVdrdzZ2bXR2UUE5b0EvRGlzZ016UFlkUEdEcE1CTUl4?=
 =?utf-8?B?ZkFVUWtSOUdIWlJEcXU2amJ3VnFoWVlBbXBxdzBVNUtWVyt2OGl4dEp2L0dL?=
 =?utf-8?B?SlFqRjdtK2RjdEg1NUlYL1JGemF2UnRnZHYwZ0dqbEVSMVlDYTAwVzJlcjdp?=
 =?utf-8?B?SUJLaTFHTGlWSi9WbmJBcmwraVRRVlBaOUd5eFc2d3JXVGtRalFwTklqaW5a?=
 =?utf-8?B?NjE5aVk1aS9tQ05TMHhaeXAxS3RzTUNTM2h6Unlrd2VZQlZkV0t4Vjl5UEFw?=
 =?utf-8?B?bTE0WGVhQVdKQ0w1djMwUmJGQ2VXR1VjSE9NcmRDMEpoV2dvK1R1UUIxYVdv?=
 =?utf-8?B?Wk0vMVlrYlRaU0pVR01VZ2FTck0yWXI1ZzVWZDJHZ1lONm5GWkZWeXVPV21T?=
 =?utf-8?B?eDUxRUZ4a3ZhUm5TdnZOMXFVZWRYbnhwMzZFUjgxbXNaTUJDYzRoNVFHWXYz?=
 =?utf-8?B?bkRLWm9jbWx2Z28xcm5PeXNKbWwvbUFpOVFJK0Y4dU51KzBuY3ZJdzdPalhD?=
 =?utf-8?B?Rno3VC9FK0V1bVBOc3dsRlJuVlhVODJoemRINmd4QjJLcXMwK3Vtb3pQSXdi?=
 =?utf-8?B?ODZWMDBBYUhsZXlOWEFnRGhhZUtkeGhmQzJBZzVvVFpJOG1sZHBTYjhBOHg0?=
 =?utf-8?B?WTFUa09NcDIrLzNzekxxOWJadHNiQnpjdHVQSmNJaHlNaHdsQndvdTVRbHha?=
 =?utf-8?B?SHV6SUQ3M0dpOHZ3N1diZU9sRGlKU3p0d3hDNmxnRlZKYzhObS84em5lcncy?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b50eb9-29d3-459d-bb92-08dc2da90c11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:05:25.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMgtRKb49ZtFkHg7RIH/e0vH56Mnyb35bVd3orr84HAHYgb2s1PMN3hvFpXfE2urdx89b+NKXcenONAIRgpgQNNGToMFDsLB9nEm6weazso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> The XDP_REDIRECT packets are given to the XDP stack and
> we drop the use of the related page: it will get freed
> by the driver that ends up doing the Tx.  Because we have
> some hardware configurations with limited queue resources,
> we use the existing datapath Tx queues rather than creating
> and managing a separate set of xdp_tx queues.
> 
> Co-developed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

