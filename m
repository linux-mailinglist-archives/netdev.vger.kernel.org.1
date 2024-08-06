Return-Path: <netdev+bounces-116120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D856E949296
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4681F22119
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E97B17ADF8;
	Tue,  6 Aug 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJlt4f8a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C217AE00
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953028; cv=fail; b=tEcClM4rBbHy710Mc+pCHWZ8Jl+421gZmQQJ4wZA7I5cfR9ZL350TjjmSsZt9I5Q0uzv6+lgNcp2aP84Y46vdqLH1PC7eHPja9Ge53RxTKmrHuKYB1gFX3RhJoNjjDWAj6a1uT4bra0np5imozV6tVZtwZojLozXztBkzhrkExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953028; c=relaxed/simple;
	bh=SyMWtvvn1W3ZHgi4sOtsra4Xypj1jva+Jq0AjHkFHP0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qKOOoFYgFKLWH6flUfvOZC6IEtPoIsV45ta6tg9PAaZYzaH1ZgjXsV3qAIZ+rZx6vGT4DLUv2NYuNj2W2CWCPyG6kflyzOH+6rsSFw/6bgYgxq3Z/m00ESmmBuK75eCX+T27pFr2Ov1syfDU233ha/hF1cP+xkLc+/dktMwt07o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJlt4f8a; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722953026; x=1754489026;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SyMWtvvn1W3ZHgi4sOtsra4Xypj1jva+Jq0AjHkFHP0=;
  b=lJlt4f8aVO+KoNai3g/s1805ZycqI4I+rPa96uEibChPu73QWiqFdCQT
   sn4WhNSYoh93lyCR/xAhX7b9OeVV/CFmIf7oevdb1M3Bh7HGgpwuVQlbd
   /e9ac+VdTZCYdOeYOnc6qDYCp4V9CE0VR0dd4gkiVah6jjzKg8OOm6IoJ
   zdJF1bgcZH5G5E22NnULO1mpnXPcrWUnKfuuRh8O9ttcJ4Pm3jzUtFuR8
   VGSvlds+16sY450UIWuKOSTE9Fs9kKIkyhiiYUkJB9hGj5RYDcxcOdTTL
   B2UaYAX+kEPiG0uCY6bvHCpXexdFx2lefzwn0mjoC9fBV21HAVGq63W+q
   g==;
X-CSE-ConnectionGUID: HT18RyZlRLyKvmNYH3+42A==
X-CSE-MsgGUID: 6caHw3C6Rl2WB/D+fbyIgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="24844511"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="24844511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:02:38 -0700
X-CSE-ConnectionGUID: qp9JPfchTGi7UKAfTOntEg==
X-CSE-MsgGUID: TkChTQ4DRf2CEjUbIQ7ZYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56740695"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 07:02:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 07:02:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 07:02:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 07:02:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 07:02:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOXvm43figbk2rMnCGNOd4Cgru0ElVFYmrunjqPq8EcAV8bn2enVRaOaxGhIPYZT030INkegY5guFBPpBr0TceUTfqlK22q6JWySwhXa56Lqx4zubRzeRZyUTzU9ZAtoEj2m340IGjt/YtHYmV2xbOC6Le2PbazR6qgvgHamqlsIXGuuXGFB1sPGnQfZ42+Wg0EDCE3w04GMQ0BAwWK/ojHvVFHLqluW39i/lbUcAYluxU09/XP4RwcSIPvslNAU9vT8aQ2Jl16xORNNyz+mqCIuTk7l3lm3bx0p27ilz3h5puD8TduNKFlY/aP9uHr0Up/BHRZCN7+2QTKsSixFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+C4rTHqkREgpu4bJCuWnMktbmTGKro0C76WISHqfsA=;
 b=Mpzh4Z4RXJpNh9W8i7nR1ml3+hicnjbZ+2gAiXwQi2YWxd7fbj1yUzIW2gD2FlIjvSbW/c67IwgC+dksVCGcW/rmaSUlJcQf7WUCNTpxfkb+E1pnxpkuZlfY9+Gd1MTsmflz3iUxzTEH5SOHTaZWMMRlVd6Lnm9jsqsYy6TBzSQ/w3tnx+7ua+uRlYtl2x9SLmLFOklZXYoepIL7Ja7J+8qRd/bakS7H9xpdjHVKU9UupUN6mOGntlH5V00m28/x6CDGRzj9zHG5ZEaxZeZRGPne3FN05gIsw2MhMN+BIbmpvxiB2Ay/kVyR4ZzIpMyvTjbpVxQzYorH0RehLcpTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:02:33 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:02:33 +0000
Message-ID: <c534a66f-adce-4fb6-8bfe-36d7d014ac7c@intel.com>
Date: Tue, 6 Aug 2024 16:02:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: nexthop: Increase weight to u16
To: Petr Machata <petrm@nvidia.com>
CC: Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, David Ahern
	<dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, <mlxsw@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
 <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <e0605ce114eb24323a05aaca1dcdb750b2e0329a.1722519021.git.petrm@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0029.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 60247f67-14eb-45cc-17bd-08dcb6206b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnRMb0YyNExvRk5yVTdHNG5MRkhuWC9aYU1iTmlwQThmWUpIVTRIY2pPSkVQ?=
 =?utf-8?B?ak9na0ZaMU51RVNyT2xQRnpqd2YwVDU1T0g0TDdkbDVrclhDVkc0b1Y2UnlW?=
 =?utf-8?B?Lzh1amhESGpvbWZ3WU1MclFFS05WeXF1SnFwL1R2aENMNXBzQnJTWmI2NEkx?=
 =?utf-8?B?U3hHS0pLTmFuREEra3N6ZXNaUTlnS1FJVkY0VktxS2lISVZINlZEQkd1QUVa?=
 =?utf-8?B?T1RsR1lUVFJRSHMyTU5QUTJKN1RUSUVWSStvMzA4RC95OW1aS0VsY3FlM251?=
 =?utf-8?B?YTFEWjZCcFdkcHdmM05jVVJPb1dSMDYxRThOczhhbGV0MmRFdWdqNjlpS090?=
 =?utf-8?B?NkFCOVB4QkJVUGhJaTRXenRIQ1E0Tk9UZmExKzd1S01SV3F4RjYxNEdYVStU?=
 =?utf-8?B?VVdIM1J1M3JJengzekFBdFVxS0xJcWdJd2JPSHo5bitWUUJSZitnZXBQY2hD?=
 =?utf-8?B?VUtvT3dKVEM0S2tGQ0VRbjNsUC9ucnh6M1NlZE9hZVppQ2xrQmxsd0hGR3c5?=
 =?utf-8?B?dXJoOTlIRUUrZVdtZmFHRU9RUjdMUDJxSWh5cEVzZ3pkNlNIOXllZDdaZ3ZM?=
 =?utf-8?B?d0cxZVExMnhkcXlhamRYc291Mk05SXdYY3RSNlJPbGFUTUpwUnhTUTB3V3lJ?=
 =?utf-8?B?bW1qQUwvaksvMGIxd1lxbldlYmcwazFTRWVDVlVPcytkczJWd0lTcUxaMFFr?=
 =?utf-8?B?SmZDNFRLdFA3RXU1b2haRFBVWjZZYXFOOEp0L3FoaFU1TWNuelZuYmhjR1lR?=
 =?utf-8?B?NE1wQ1EyZFp0WnlBUHYzN3IyRU5DMFYxaThJb3RXb3ZqakwyazZvVUdYdk1U?=
 =?utf-8?B?ZktBZEdPY3dld296cnJWdmZtRG1iZUR5c3gvY25EVGxsMWlsWEsya3E3TVFv?=
 =?utf-8?B?b3NxR3Y2bXRBZ0tGRUdZTGovZk5qTHM3dC95QWZZNklsOExYMzdsbm9vVE1k?=
 =?utf-8?B?bWdyV01NZGJIS2JhL0wybDBhNCtGcUlOQkRsQUt3UU1aUHJteHg0ZWhUTWJs?=
 =?utf-8?B?MEJyV201YW42MUp1Sno2NDI4MXpmN2diOW9vWkVZYXJqMUNveE8wcjEwRVVR?=
 =?utf-8?B?SkNoV3IxUGNDSFhiYXlYb0IzbFlLQjBhZTNmemF2KzN6QmZ1K3NFUzVIOWNs?=
 =?utf-8?B?Sjd2cUZxK0grSFJwR2xncjdOUFZCZjdFNTRheUYyUVE3L2w2eDlkS1hwaXk5?=
 =?utf-8?B?UmV0Yk5nNXdjMnM1WVRwaFlac0NtL0l1MnBqTXlabWdCL2RIODhldUlkYW1I?=
 =?utf-8?B?OG1JUEJSVFlWaVJ4RXFwRDlDSjF5N1ZSdVpmN3dKcW0rTUV6NG14aTNEZTFS?=
 =?utf-8?B?T3Z4T1FSY3Z4VC80L0M5QjBkWFVGWDVuOGhxUWQzeU5rdk5OYm1tZE54cmRG?=
 =?utf-8?B?S24yQ01QZmw3UXliN1dVcU0rMFQ1dWhoYW9pMm5tN2Y0czQwV2lWRE1oaDNl?=
 =?utf-8?B?RFB3V1VFUEV3MVd3Zkk0VWJQeWNnVkhuMlB1L05aR3BFTmtoYXBTTnBnUW9K?=
 =?utf-8?B?dUtVWGxXdytBRHNHV0YwT0VvaDZiM01ndEJPRVMwQ0R0bTYyMURxRHRZTExX?=
 =?utf-8?B?KzBvaWxMTFZEWVdaMkk2SmhOVFhMT2RhdVZhSkdJUGZuVU03ZnhjeEpSeDYw?=
 =?utf-8?B?R3M1RmVWaytKNVRPSktoZVNqSHQyR0dmMjRjY1VBMFVtd21hZ0N6bnhFU21G?=
 =?utf-8?B?bldLT0dZKzVPZlJaMnVudUR4ZG1XQVlCQXFwNTNGZFNCUDIyYVhzQ3RNVURs?=
 =?utf-8?B?TDJzZWhLVWllVkNQWDRpbHY0cHhvQjRZZDNpVjFBeFRwR2p2MjdaNnYvdGx5?=
 =?utf-8?B?aWh5SWE1Yk5YcTVaaWM1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nms2RDRMNTlJVkdqSzBYeVV4T2daalpyVFZJbGplT3kySjNkcGV4WU1EYjFp?=
 =?utf-8?B?NGRXTE5KUitsbmJBeU9vREVoODFLUVYzL3dqeWwwNDY3b2lXbEFGcXlVR2Rp?=
 =?utf-8?B?TmRITjNpNjBpVGp6ckM2Q1F0UENDU0pudUVvelJyMDRZQ2JGNHIzK0NZKzIx?=
 =?utf-8?B?YjRGWXI2MUVFY1lZenNLRXB6MXJuU2M4bUtUNlFuODkrcG0rNXRlK3lTNFpB?=
 =?utf-8?B?ZldqbUtTejgxSURQRGxJeGpTekh0NHNmRjRWVmlaMm5JQ2JUSGZzOS9lbVh0?=
 =?utf-8?B?ZnFiTEhBdzRwVXB1TzdiQndvdUxRZTZXNHk2OVAwRS9hUStHcFhCUjlwc2hk?=
 =?utf-8?B?ZEIrZEUvdzljaXhLYzdkMmdqYlFDb0hNWURFSzRSY0tZSzlOeFdHd0xwWTV1?=
 =?utf-8?B?elQ3aWVocjVMZ0E1VU5Wbi9sNS94cDM4ZElYcWgyOTRldHdsVjd0R2dLamo2?=
 =?utf-8?B?RGEyM1hpZ3JpbFJEUFgxNWZKYkx2Q3pFTFRVdW1kSitFRFBlcWFFR0FjNTdi?=
 =?utf-8?B?UlpGQm1pN2szM3dYNmxxRU1HR21vUlNlRWx0bUhGNUVCUmtJWUFHYkkvS2Nk?=
 =?utf-8?B?eEd0cVZXMjFaMS83SDE0WHppdkJ1dXFuN2lhUEpsSE50UXk3UG1uOXFsZmRU?=
 =?utf-8?B?MHNDYWdaSXlPRzA0Wm9MaVE0akE4R3N2eGV4TVNoNm1ZM1YvdVg4eEFrUGpP?=
 =?utf-8?B?dXF2TkpEV1dmd2ROSWNObHBjeWRlVUFQbnJVZXh2NjRKUzFRSTBxT0QwZzNW?=
 =?utf-8?B?ZzNvdllmRXFzbW4vRFJ5cjhLMDFkTTRlQzludFQzOE9LblJLT1Jyb1E5eVZV?=
 =?utf-8?B?ZzM4eXphZStNVVVUc0RVQStSUlZHUEp4dEdxcThzQk85S3NQRjFYeVFtdy8x?=
 =?utf-8?B?SVV1MmtCSWhhSkM5UG5PbFRScDBaL2Q4OURrdGc4b0g1N05iTEpaL2l5ek5S?=
 =?utf-8?B?SU1BMG56TWpLWjNqWTM3UUFyTVJIWkpVVGRscGYrRTE5N2VZWXFkb1gzWE41?=
 =?utf-8?B?Q0g3VHN4Y0hUd296S0lzSXBOVnpGcmJYYUdmMklPa3BuK2Y1eDF6Q0pEdlRJ?=
 =?utf-8?B?V1crRG93RHpEYWNaNFlvSldiSVNXYm42Z3g4R2gwOUdTK2NxVHF4UGlmQUJl?=
 =?utf-8?B?aDltbTB2M0hHSEh5MkJ5Sk45V3kyRDE2RmZCYTF3dzduSktXMWgybU1YZzZp?=
 =?utf-8?B?allxT0tMMUVkT1NEK3ZTdktBRk1UN1VSUmFNQVlUQUtnZVdqajZybVVJallS?=
 =?utf-8?B?elNGWkJOeHdMdWorOWYybUR3a0w3SzN1ajBSZWhoMnlueUtsaHI1b3RESDZF?=
 =?utf-8?B?SnhSc2Z5clp5ZjJKMzFyWS84MndYWVFsR3ZJQmZoUTRkUVNMbStQUE1RSktv?=
 =?utf-8?B?VGhHOUNVZndRb1BXaWV4N3dsUW5ocWd1TkJqNGhLWW5TN3AzSkRwbXRLdURz?=
 =?utf-8?B?TjNFcHVVc040ckV2SEwxZXBPMSt2ak1MQitzVWFpMW1YeWt5MjY5SUFOeXBE?=
 =?utf-8?B?Sk1KMzU3cXZWR2VodytHWkFuajRpSXQyWFRHbkxkQTlEZFR0VndRN29UcWE3?=
 =?utf-8?B?c285azhVbjIrWm9VNWtOQ244TWJjekV3UVJuZVlDRzR0ZExoN3o5S3F4UzVT?=
 =?utf-8?B?dkZRLzVhRjJqZFdUaG9hSTlHTUpMUjNGWnhXWkF1QU9WUmpkYTlYa0ZhRmhO?=
 =?utf-8?B?TzMyRURZajdVRk4rNk1CWW9CVGV3bGpRK015bmlsWWZGQ0I1WjNTaXpmNzdj?=
 =?utf-8?B?bUkyOFoyY2dYak14anBjS0x1TnlwUHEwUGk0Vk5Sd21xbmp1Smc3TmFZUUFi?=
 =?utf-8?B?eEF2cHloZmVDM3l5aXN3MnV3NkVuQ09JdlVKbFdRbUJxcGh2M1J3cXVpa3k1?=
 =?utf-8?B?c0dRekh4UnlidjJXaE9CcHRmQkFoL0JhaEpYeGFlaEcxdVZMRDdIdXh2QkFQ?=
 =?utf-8?B?MkFxMU45RlhBc2hKaWNvTjhTeFdnbjBldGxlY0I2SW9KMHh5cFdVMkpuYWJy?=
 =?utf-8?B?KzlucGpOVUNtb3lQWG0xQTBxVzBRQTd2QThkNmJPWTkyanZ0WFJPUHVYb2pS?=
 =?utf-8?B?bUxOREhtZElzRXVjRWdsOEx0eEI1OHlIUHFDb052SWppcGVsMjRLcGxLNm9C?=
 =?utf-8?B?akFlT0tkOURzcjRwMHpuMHhLYmhGTDdGRUI5SEhaZktrSFZxK3RqeHlodCtm?=
 =?utf-8?Q?Am5mj4DHzsicxoPqvh0OTBg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60247f67-14eb-45cc-17bd-08dcb6206b2e
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:02:33.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+/N0B9pmKEgSi2Z2Irhm1whjdBy3zMaNKyvbmmzty3J5hpyQuxua7GaF+MyyQugzeEOI16YQdO1j1seOBac4HT5v2iCIgr+bjbWPruoBh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com

On 8/1/24 18:23, Petr Machata wrote:
> In CLOS networks, as link failures occur at various points in the network,
> ECMP weights of the involved nodes are adjusted to compensate. With high
> fan-out of the involved nodes, and overall high number of nodes,
> a (non-)ECMP weight ratio that we would like to configure does not fit into
> 8 bits. Instead of, say, 255:254, we might like to configure something like
> 1000:999. For these deployments, the 8-bit weight may not be enough.
> 
> To that end, in this patch increase the next hop weight from u8 to u16.
> 
> Increasing the width of an integral type can be tricky, because while the
> code still compiles, the types may not check out anymore, and numerical
> errors come up. To prevent this, the conversion was done in two steps.
> First the type was changed from u8 to a single-member structure, which
> invalidated all uses of the field. This allowed going through them one by
> one and audit for type correctness. Then the structure was replaced with a
> vanilla u16 again. This should ensure that no place was missed.
> 
> The UAPI for configuring nexthop group members is that an attribute
> NHA_GROUP carries an array of struct nexthop_grp entries:
> 
> 	struct nexthop_grp {
> 		__u32	id;	  /* nexthop id - must exist */
> 		__u8	weight;   /* weight of this nexthop */
> 		__u8	resvd1;
> 		__u16	resvd2;
> 	};
> 
> The field resvd1 is currently validated and required to be zero. We can
> lift this requirement and carry high-order bits of the weight in the
> reserved field:
> 
> 	struct nexthop_grp {
> 		__u32	id;	  /* nexthop id - must exist */
> 		__u8	weight;   /* weight of this nexthop */
> 		__u8	weight_high;
> 		__u16	resvd2;
> 	};
> 
> Keeping the fields split this way was chosen in case an existing userspace
> makes assumptions about the width of the weight field, and to sidestep any
> endianes issues.
> 
> The weight field is currently encoded as the weight value minus one,
> because weight of 0 is invalid. This same trick is impossible for the new
> weight_high field, because zero must mean actual zero. With this in place:
> 
> - Old userspace is guaranteed to carry weight_high of 0, therefore
>    configuring 8-bit weights as appropriate. When dumping nexthops with
>    16-bit weight, it would only show the lower 8 bits. But configuring such
>    nexthops implies existence of userspace aware of the extension in the
>    first place.
> 
> - New userspace talking to an old kernel will work as long as it only
>    attempts to configure 8-bit weights, where the high-order bits are zero.
>    Old kernel will bounce attempts at configuring >8-bit weights.
> 
> Renaming reserved fields as they are allocated for some purpose is commonly
> done in Linux. Whoever touches a reserved field is doing so at their own
> risk. nexthop_grp::resvd1 in particular is currently used by at least
> strace, however they carry an own copy of UAPI headers, and the conversion
> should be trivial. A helper is provided for decoding the weight out of the
> two fields. Forcing a conversion seems preferable to bending backwards and
> introducing anonymous unions or whatever.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/net/nexthop.h        |  4 ++--
>   include/uapi/linux/nexthop.h |  7 ++++++-
>   net/ipv4/nexthop.c           | 37 ++++++++++++++++++++++--------------
>   3 files changed, 31 insertions(+), 17 deletions(-)
> 

> -		if (nhg[i].weight > 254) {
> +		if (nexthop_grp_weight(&nhg[i]) == 0) {
> +			/* 0xffff got passed in, representing weight of 0x10000,
> +			 * which is too heavy.
> +			 */
>   			NL_SET_ERR_MSG(extack, "Invalid value for weight");
>   			return -EINVAL;
>   		}

code is fine, and I like the decision to just extend the width
(instead of, say apply this +1 arithmetic only to lower byte, then just
add higher byte), so:

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

