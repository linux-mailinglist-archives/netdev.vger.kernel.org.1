Return-Path: <netdev+bounces-72558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD8F858839
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEACB2837F3
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C10145FE7;
	Fri, 16 Feb 2024 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MAaXjowg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6212CDBC
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120089; cv=fail; b=ot3rEMmB32uVs77mICTZdEEK/AEXK4r4gzTDFPBdOsGhL/F1d0j3dPwFvh97k2MNZGFty1RD3KIKO6G/5UHtZPrCtTsdTp+GSXSGhCR2U8hqRP0v18Yvdx8XKh+yFI2EK95W5ItJDLTq73SCQvEoNNjGAoH4yQHO7KavShlRPyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120089; c=relaxed/simple;
	bh=/QH05YXhFdEFvhwI3HfOLVIutzll5YIxUuhwvQMCGgE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RIzRAd3+JR5YcYW8GJ5+IG2g1dc8OeNSTc7kEb44dzl9ZMFmPwO+ZKSvLLENSGbw18COk43ITxZfeOnoC/VWaS3B2pta6N8TojdmnZ7nnwz1KhWw97QaApPfqzf+dsDQN/yAEQDg7aaCzWH9qFQSPS9Oe8SgRIpnEkYT4FA0CjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MAaXjowg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708120089; x=1739656089;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/QH05YXhFdEFvhwI3HfOLVIutzll5YIxUuhwvQMCGgE=;
  b=MAaXjowgysYbNPWEaiGUnHI+5Dftk7HMddkLLqvSX8lNEcQeYtmi4/w2
   RK0XgwaY9522XayBVt1nL3JqZCm5TSlucA/8ouqGh0/seVKVixLZqdvQy
   a1OiDYYjoZg8piXIe1dYfB8kumkKuv1C8Pt3dIFOcPkumhAx1HKADQb4a
   udK18DkhiDxIszPWKDCMxr95MWY1V/gzwcm2eKXpHvlR+R/tUrQa7Ag/h
   nfJItznaSco30RPIRqFTVPOjIv1xsOn0zkaJpgW8R0tBrezpTpu+bfVF+
   fJ11tLyzjy8yVYeMJW7mOPfRJjg/vQ9zVky3Wxsdo4b7Zg+q0eQddlNl7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2123480"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2123480"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4001364"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 13:48:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 13:48:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 13:48:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 13:48:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B08l5wpZizFnbUR0R6dGrunDpgD3H2OoWUpOSXowd1/wr8v8AkkRhA9vKpnWubxFva6z4nQ4WTl6QGrrbkKkejym8SRDIVsJ0iiOgOKvauF8SK/5Jkf94N2HiEbRH8s/Ah5c3P8G/7xmfTYAi1y+Y5sFRR9L/3UcSvvJ4UzR4/QjwI4E0xhTjubG3cMsJJJGG9C3vvxPw4Vva+hLrqI6mYaMcP1v6+wwEWqz3tfaz2eYa8BeGE8qzBoT29Fcwtar9vBpnvnS51SLmiTsGCXVfa9fMG5IzTPsgLxl2jsH6H1+Raw4SNW9JSCyRFnRxWGRyXvo8v3HQ3YAeyZPn1QNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAHrelr0WmdNxCsYrNS7xoMdWaokfT9/PIZHvHD3j7I=;
 b=mmu/HUKDmzR1SPL5EuKFhUESxj6vOXNquE13USFuVc4uU8c5HQCWpk88lsneP/2sB42uE3lTmUc5hXP2DZv/LJ40+zMArtjJX8OFxRibps7qteEU09e5lkksMxAFmrUKIxgvTV1wiIWg5GOO5r+jXOloyeQTQVNbD7F3AaDpUZXyHEDbUp2E2Jgv0RluH6AWBRVfyBU2/2gqXL5Jfu4Bman/cdQ9A1y/mpkWUjDOtjr224w2fKFEeooMixxuBTYoOieAa63zMVO22/iO6Lt36y0efHI2yTAy/uqiaaiA7qdD6kMcoX1/S2hU2S2qX+8wq17u+tvy9ePz84lzkMPXRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 21:47:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 21:47:52 +0000
Message-ID: <efc51aa7-9d5f-4c18-8f06-4a8df07a831a@intel.com>
Date: Fri, 16 Feb 2024 13:47:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: William Tu <witu@nvidia.com>, <bodong@nvidia.com>, <jiri@nvidia.com>,
	<netdev@vger.kernel.org>, <saeedm@nvidia.com>, "aleksander.lobakin@intel.com"
	<aleksander.lobakin@intel.com>
References: <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org> <Zbtu5alCZ-Exr2WU@nanopsycho>
 <20240201200041.241fd4c1@kernel.org> <Zbyd8Fbj8_WHP4WI@nanopsycho>
 <20240208172633.010b1c3f@kernel.org> <Zc4Pa4QWGQegN4mI@nanopsycho>
 <aa954911-e6c8-40f8-964c-517e2d8f8ea7@intel.com>
 <20240215180729.07314879@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240215180729.07314879@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4f0a77-5a08-48ff-c2f2-08dc2f38ece7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VWkAl4OVR+F9BGHhBjF10mseu+djgZHezrcDv5IzWTk58zZE2pnCIhAdYQJ5/8Y+I04bD3QNpmHV9JtxnUwd16CwOTHBvEc+IKgQ2JfJxi8wJTbc+Q0kKbIqqGbe898GNzhQDNZdIN6rR9RLls57zX6hZVJCEPKNXsl9OWzxTiYTBPPV7XL5twtKQ3UcgFtultWRgZ8bcF65VFC4+xniWbyGkXtWgsXEGIaeEgcyI5GxhXmMkC+16ilD+LpP28pFM1dK8x72xJuBiVQtwjroE5l79fgVzy9EZGRlI5RODWGHwoI24qM6SBFVEIZQi/KJft9ZHnpdGlToNUUH4cE4+ugdJ0Sy1zNTR6sQQJz1SMvJU2EZZUBgNvuQpPrv+1HC7/pSvsXNVPmXiGZ1qm0361XgEwRrz8uSiQUZMwtovTatKflIXup7wAMJ21h8oJX7cH5ICVwnyEvbz/frw468e6AUUY0rNdp1apfpulsw+/0v+2PZxKdVTsH9/a3C3IQvHohTKXd9nlsnBoytgDxZE2OGxdZ0HkrmI0dnqh1UxoUtrzBFP9gbe+7tCxlm/nC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(86362001)(82960400001)(31696002)(36756003)(38100700002)(53546011)(6486002)(478600001)(316002)(6506007)(6512007)(83380400001)(54906003)(26005)(2616005)(41300700001)(107886003)(110136005)(66899024)(4326008)(2906002)(8936002)(66946007)(66556008)(8676002)(31686004)(5660300002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm5yaFBKbmNkcEV4N1RlOFJGY01tdDEwQmhhMTlaWms4TmMyU0JIcW9WNVpt?=
 =?utf-8?B?ZGd3cmV2a3NxakVHVmEyRGJhN2FUMHNxK3RmV2tBa0ZzMlJqdmNSbzBIWFg0?=
 =?utf-8?B?bVlGblRET0RjTGNBbzZmaGF0ckw2M3FMMVdQS1dlaWk5bWJMOTE3WGszV1ky?=
 =?utf-8?B?SUVIemJ1bitEZFlqOW14ckhmRk9tSCtCRWtjNkJra3ZaZk5aU1UzSU1RNWdC?=
 =?utf-8?B?TFRsbGJEcm9meFpvOVBrVkUyaVhJdXpVZE1aV2U4ZVlOVndCdDU4MFJrTEpC?=
 =?utf-8?B?TXFRVW9URHQveVdaT2N6eVNIWlNTeDBxK2dDbDdNa2V5YjliYzk5azlGZFBq?=
 =?utf-8?B?eDQzRkNQbUdINkZqR250VjFDNEpqSGlQUzMrUzdqd0daSnhjdm5wS0NTeHNv?=
 =?utf-8?B?dytDcFB4WFpYMHRYNndZZmlLNTY1UXhMaEw3YzhQaVZqT3ZKc2pLRDdIQXJq?=
 =?utf-8?B?OURHM3FiaDAyUmgzKytuT2xiNmNkWWRMTEZSY2x3QlZjYTVuaXUwbkhRUE05?=
 =?utf-8?B?QTNkWEdVbWkySUdXSWRjL0xqUHNGd2VUMFhvbkNGOVZqUFU1R25nM0xNTjg5?=
 =?utf-8?B?V3VBcjcyVVJTTXQ4SzdTNkwxdnY2MFBWbjl4Q1k2VG9WMWE2ZUs1Zmg4NURa?=
 =?utf-8?B?YjBBUEFyb2g5dnlZVklQUWlTbHBvTkhjczRtMGRNZGd3ZjQ5Z0sxMmcxam90?=
 =?utf-8?B?aGIrMGFCT2NNd0ZrTXQvd1dQTjlRRlBuZjZoL1UyT1hKR3k1UmtzdWR5N2ZH?=
 =?utf-8?B?cDR5WG1ZaVo1Y3RhUWhXZkNwZXdJTTZGbnNHVFNjT3gyNU1VeHF5c0RvamYx?=
 =?utf-8?B?WXJZSjU3Mjd1TmZUSTBIMUppazVDNjFINGkyaXBYWS9LQjJzcTZxUTYwamts?=
 =?utf-8?B?RG5sZm5MdEpMMUxYUktRakVvV2w3QUwzSDZqckdjdmxIUUhqMTBSaUdudkFC?=
 =?utf-8?B?bDl3MFppRXZxK2J0N1hiM3A5V1hjY014bUtKK0kvU2s0ZmhPNUFBVmtuVjdL?=
 =?utf-8?B?a3BwZmxIVmk4ZW9PUkdPZnBBbFZlaURjZnYwNXV5NU9QNGFKclAxMmhDR2d6?=
 =?utf-8?B?TVY3MWhJS3VkbDBSSkRxZnZxME1POGdzN1pTTUVmcHZSZXlHK2lSR0VESWEy?=
 =?utf-8?B?ak5FWk5zRlZTNy93Uk5POThCcUpxZldjVGJTcG5lRG1mZmdNYnp0SHorb3FZ?=
 =?utf-8?B?YTFELzlwaE41ZHdNd2gwc0V5bi8wdW5ERC94aXB6dzU1NDVaMDlVcDVucStD?=
 =?utf-8?B?aUlEN0lZWDhTV3FsTTYzT2VYSU5HSTRUZWQwbHBaL1dDazJhcldXbldPSTAy?=
 =?utf-8?B?RVhkNFVrbnc4WTJSYkZ2TUdYZjdtK2pRZHVWeEM4RmRubDBYQXRCMkJ5TDhM?=
 =?utf-8?B?dlg0eDNUN2M5WmJsYUlwNGpPOWdmaFJicW5SR2tNbTVPNUNOV0EveGR1eTAv?=
 =?utf-8?B?Ym4xd2xTeTZqOVE2WjhUTzN0VDNjMDAwbHJhdUFKaHdtZU5MVXRuOFVxTkxK?=
 =?utf-8?B?WDM5aHA3dXo4REVDVUU1WCtVbzVzTDhuMWJjUExQNFZmQTZtWTdXKzZOUDQ2?=
 =?utf-8?B?aExxV3lYYWxmWXI1V1VSS2NBaUpzRmk3Y0lWd3M0dG1ic0lnR0dxVXN4L21N?=
 =?utf-8?B?dmo3RTFBVWpwMWtEMnh3SXNOUStLbDNPVzFjV2FMUHM2U3IwRnA5d2MrQW1N?=
 =?utf-8?B?RXdQUlJrREFHQ1Ntc09LdTJpdWtjejJVQWhodTYzRnNsa2VCSXNRL0pqUHEv?=
 =?utf-8?B?SHhjRTVUU1pZaEhsenBoMGU1cURCNnR5b2tmdVNrbWU4QjRXcWcyTEd5MjNv?=
 =?utf-8?B?SmtvK2N3MEU1RkkvRHVOam1Ua0JqOXpDT3AwOS80RG9paElaaDk4TkNrcGxY?=
 =?utf-8?B?Zy82VENvenkzSlNuNVNrVzJCNXJtM0xId1NQcVBJUmdXN1U2bVkxVmZteTNs?=
 =?utf-8?B?TE1sMk1mRmx1V0VPOVNZaTZSNW9HaVJxaEJDaitsZHhLWmMyejhTWlV2SlAr?=
 =?utf-8?B?MDJTVmZZZmV5bVY2eXNUUm5lZUkrZEt0eXA0bm1TK0hNZmkvRVJjVEpIWmw3?=
 =?utf-8?B?NEx5SjF6RXZlNTA5b1o1N2ZXYzFtNHVONXUxcTl2cSt5ejBzeEpHL2p0Wm9K?=
 =?utf-8?B?ZFJNOUwyMnNsRTVoTU1EZXZWQUlGUVFLK0JDYnJQeFdCL0h5ZllmRFRYVHZG?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4f0a77-5a08-48ff-c2f2-08dc2f38ece7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:47:51.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaSUEGcmydeT6XAobd8Aljfg28owzFiPID1ilrBm718D65wsCVDl0PZFMbawlfVYl4ZnZ9UtStvOjX/5PivG2pM351vrp3aYcx4jIQzvjy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
X-OriginatorOrg: intel.com



On 2/15/2024 6:07 PM, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 09:41:31 -0800 Jacob Keller wrote:
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
>>
>> Then this parent driver could register devlink, and each function driver
>> could connect to it and allocate ports and function-specific resources.
>>
>> Alternatively a design which loads a single driver that maintains
>> references to each function could work but that requires a significant
>> change to the entire driver design and is unlikely to be done for
>> existing drivers...
> 
> I think the complexity mostly stems from having to answer what the
> "right behavior" is. At least that's what I concluded when thinking
> about it back at Netronome :)  If you do a strict hierarchy where
> one PF is preassigned the role of the leader, and just fail if anything
> unexpected happens - it should be doable. We already kinda have the
> model where devlink is the "first layer of probing" and "reload_up()"
> is the second.
> 

You can of course just assign it such that one PF "owns" things, but
that seems a bit confusing if there isn't a clear mechanism for users to
understand which PF is the owner. I guess they can check
devlink/netlink/whatever and see the resources there. It also still
doesn't provide a communication mechanism to actually pass sub-ownership
across the PFs, unless your device firmware can do that for you.

The other option commonly used is partitioning so you just pre-determine
how to slice the resources up per PF. This isn't flexible, but it is simple.

