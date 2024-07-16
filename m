Return-Path: <netdev+bounces-111665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E0193206D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499D51C20C9D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 06:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88561C694;
	Tue, 16 Jul 2024 06:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VseL8GFc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063E1862C;
	Tue, 16 Jul 2024 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721111239; cv=fail; b=gZsvb8z4SWaXt5Mojoc8h4y8HeBFLFU+WXxCzCsZGuPsmJ9n0wK2Y/yNsWYb2LE/hUHaOjOtktGVciHN7mYek3L2pj354SWbLojc+38hhnYsB798gXaVUHvnDr4zJQKft1MJnSIES5Z6xGHUdtfU8aeXkm4/Zt/sMbFXcJ1cpX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721111239; c=relaxed/simple;
	bh=10XxLXijEy7CUSO6VN4N+UH/A4UgxqVIlrmZLLw10mg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mez+VixpI9cZDCjkwsicW9tpYN2UMifdndQisyNKarpgA77FcTGZe/szK5y4DmdpLaDVKGdkq7V4dVGy8LaqJnYXGp+PUQqGZny+WqKUCVkIFCDnD7+HNfCQQvyHKlTOMrs/LZFcBfNrbNvoQ3DcSNse70pnlAvsPI8ePpI3WYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VseL8GFc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721111237; x=1752647237;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10XxLXijEy7CUSO6VN4N+UH/A4UgxqVIlrmZLLw10mg=;
  b=VseL8GFc+MNtAKoRfyR22POyOrBvQHYUtJn+zVj+eTptL++vNRIIO5Vh
   KV/4rbztQZff9l5vcIovzMvqi7bRA0HwzCuy/zBZuErPZhBiD/EBfFlv2
   GmqfJkUIMiFt3RNbxmiUzKV6Pj7Mk/WvESjvmwO+UCfpuWHNFOxR0JY2B
   b/1LreT8Coa7faMX9ME7kkR0Qp4Qbx3pjDswnvUhRBpvdyIKlutooaQVh
   zfCLy7FatHbEJKIhTir353o4lo2fOal3tOA7WN2HNQEaaiYqPfT66ERGd
   NKsRkpJMCNT5ah2Ix6UAd2gPrcYoWzJNAadWDF4wVuConOdsuyGCgnWg8
   g==;
X-CSE-ConnectionGUID: 2TPvKe0BRHyD+v34TURB5A==
X-CSE-MsgGUID: DnxwpkqxS0CWbAMSzGUbuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18679226"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18679226"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 23:27:14 -0700
X-CSE-ConnectionGUID: RYxLauNlRJCdqufe1+TwWA==
X-CSE-MsgGUID: IjoV55qKTnaR+WRPzKL25g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49825151"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 23:27:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 23:27:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 23:27:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 23:27:12 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 23:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wl0RULRO2FdEnoAlfB2FL/ctz8hcbewyva7M8f2OxhjpBGyYSLXA5zJwztgJ9W5aBQHRDcRrEKB5ZhJq67Bf9om0Lr/iZrN+vKwQr6O8MdRM88ufL5E0eXEuB8Jn/9KdjIr8SYH9JY/yblt5OgPvD0gGqIN3CBfWvOb1nkCmGznnwQVvJ76dWFJgNEjJUDgfAHWlXsfynjTm82E7UKhAw115wlD2ZYChAj8T3sTBkj8xDF71J+UjDTBC9XqpyYbR8RzrOFCb05zIsYui/fyeWA3Obf3JrKK2246xlqQLwkIqD0N0bQWwTC/H8gXmMPJM87AeGk1k8sVlprqH1NAvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzuWnIuquulskHeuth31UreCSp+OzbPrShJ/L6Ha9/U=;
 b=q7kvAF3SF+2LH2XtqSScrN/N8GDanZLjWU9phfBHEoRaJg+qVQsWyRRQtP7gu6/vXM2R8qGakpZCa9FdKLFB3rn659RAOL8uK1b5e/rAxBAMWWyILacobaWx1j9fF1KDy6jEuxE83igYyLO0wTpNSGcBM4k0L+tDD9BBD6EPcNpnf1bIrBrAa4D4xZoJYDee38yY5vz01ZwucsWR9gXAuIgRIXgeGX1vo3mdvVGieGSTp0oAWU5FyFxuz2kJ9QSR804eDOQ64WStRWpsYTPg4VEiBUWo/0IGPX3qnaEEbEkxxKZKSInl1qS3cUzitg0FCrGxRTtH01cvA1mAUmUl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by CY8PR11MB7314.namprd11.prod.outlook.com (2603:10b6:930:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 06:27:04 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 06:27:04 +0000
Message-ID: <da346636-a458-4ec3-a065-6ce56a985573@intel.com>
Date: Tue, 16 Jul 2024 14:26:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] cxl: add function for type2 cxl regs setup
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240715172835.24757-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|CY8PR11MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: a565bd9e-fcad-4890-e60f-08dca5604f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEFVWGtUV1lmaTVoM3BGdnNZWmNEaU9GZEpnTVJaVTlmRlBsR2dSTUEzV2p6?=
 =?utf-8?B?QmEvS1lQd0MvR3dmSXc0eHZZSC8xSlQwNTRFSWdvZUY3bkxOQXF0M2Q1NlpS?=
 =?utf-8?B?VFJQa2VsRkRoWlhzNEUwZVRTTmlwam1TZFpDV2x3aGRYc1RDSHd5ZzdOcXFt?=
 =?utf-8?B?VGU3UXU5dXVKbmJCd1ZOYVNJMjZJeUlGdmdkaktkVHlGN3VNNTNYajc2cGhu?=
 =?utf-8?B?bWZDS1hYWE0vS1JQeEowbGo4WDhabGdoSkRZckZGUEZ2RkdMakJabDNNN1Iy?=
 =?utf-8?B?OGN6Ylg2OUFSaW5KM0RwVXozMUx4Q0ZaQjk1OG5YRUtBdDRvUjBJRXAyTkh6?=
 =?utf-8?B?dHovV2FmTGc2SlpEV1ZBYWRPczYyZ2gwbjk2b1cxRUtJbmR1RXRSb2UrejE5?=
 =?utf-8?B?UlZhT2c2TEEwMGpMV3ZqT3RoeHQ3YUpaWmhrbXA2QWMwb2sxU1hnM0pKVVZj?=
 =?utf-8?B?T1B4aVVrY292a2RJZFdZajZPQ3NKMjJCN1F6bmFOSmk0NTdZYTdpRWRzQ0dI?=
 =?utf-8?B?TllBdmNSYjB4YlpVSjk4V0ZqOXpmc1U3akRSTS84Sk5BZ0pQdDRoOFY0OUlx?=
 =?utf-8?B?V3BoSkd1aE0yb2RRNzV1NGg2WGlUZlZZaTZGTkloWmRaT3BrWXp3M005ZFNx?=
 =?utf-8?B?SVpKRUNDTVlpbVhzSi9sd3UyUkxoR1dUajhjc0ZhNkUrWUlUemIzcFQvbG1M?=
 =?utf-8?B?azZnb1RoMWJvcHVZR2Y0VTRTRm56ZWNMTWtTNTRSVThlck1abDdSekV3cUVh?=
 =?utf-8?B?VXdncW44aC9aTDcwRDZ0aDVKSmlPWStnbWNZM1ZsV2krT3dZMnRUaGF6T2sr?=
 =?utf-8?B?Q3RqZ0l0ZExMaENhaEgwaUVYRkk4NExPTmpVOUxZV0VldWt0cE1yQ1VjZGhY?=
 =?utf-8?B?WG8wZnJDSm11UXVCUExldndTQ3RHQndQMUFEb1lXRnIyNkpRakpoZ3J3anBu?=
 =?utf-8?B?YnBRWUcvemI0c3R4SVFRbXFPSFJEVFE3UkNFSFR5Z1ZvbFNyallsajZRcU41?=
 =?utf-8?B?NFhPZncrUDdINXNRaWkrODRjTkJacjd4ZWJaTDlnenVZSHhQV0dnTmptQjJi?=
 =?utf-8?B?NXQvTTF3Rk9oU1lXRzdLZkVYM2NjNmJybVptV0NCTHFUaFZwL2FuV0cwK0tU?=
 =?utf-8?B?UDVidUFweGFtVUZwaFpsZkxsbWV1a3dnY0lsVk5INGY5cXRwa3JUNDFVR0RJ?=
 =?utf-8?B?WGhwTThPN2tpSGhEV3hoa3ZaUGNseDZQVW1kdStxblhSNlArMTFRMVhOdDFR?=
 =?utf-8?B?bVp2Vkx4S2NCZFAvWWE1bmhoNHBtL2hxdi85OERuSEpjYWhjelNlUUNCVmd4?=
 =?utf-8?B?L1YvemxkZFBkTDR6UkZDMC93VEQ2S285VjdPemU2d1VEeUxEQlU2MW9hNXd3?=
 =?utf-8?B?Z3lKMWJOTy9yYWVtOVZTTGNwZ0VXMnp3SHU0OHhDOXVVM0VobFAwSDl4M0xu?=
 =?utf-8?B?T1VaRHI3Yy9zeGVnVWJiNHZ5aFpqbS9zbHNvSnRVMTJVY2tPTGVQSjFERXNY?=
 =?utf-8?B?RXFlMXpFSkxMdGIzeWFDZzBLWWdDTEE4WTQzdTVtb1NiWC9MUVYyTmlGZHpT?=
 =?utf-8?B?SVpjQ09Ub3ZJVk1HT0xnYlg2M3R2L3Y0ekIzaFVRdmlzYktpTms0V0tydE96?=
 =?utf-8?B?Y0VDZkJvVnJxRUlyYnBHWVR0MEEzbGl6Zk9TYlc0c0NUbGM1cU1pVXl5TVFD?=
 =?utf-8?B?VjVFeWpteEpmNm1aVEJtaE5JTHZiRnJqODBuQ1FBNXVYR0hOdlNLVFU2enha?=
 =?utf-8?B?L2RvOHQrb1F4amZZWEhpODByY0V0b205T3p4RmUwQjZKN0VGTVBzNFJ3Q3hy?=
 =?utf-8?B?VzYvbitlU3VIMG5XUTVpVFlwTS96aXh5UWVSTVRjRnY4RUdrNGYvSDl1emRw?=
 =?utf-8?Q?ku4QsqmY8Z2HN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhiVmgrTmxkTG4wY0FqbWw2RHJVT2VHS2s3ZDNHTU85NUZ5YXUzYnpUVWJK?=
 =?utf-8?B?bkVFQTI3Qm9mSGVQdW9nNkxnUm9EakFyQjMxSTUrOThrV0I5dkt6cXdYcEZj?=
 =?utf-8?B?UkYyc3kzWkhnZ1MxQUh2NTlBUFdWdzZIbXFiZVBPMi9LY2FzaDkyOW1ZT282?=
 =?utf-8?B?SmFuNDhKK2VvaGxSdkFCWUJCQ3o0dkFsdVU1eXJYcEhCcUdXZzd5elMwQWo3?=
 =?utf-8?B?djFtV3VlbFZPU09PcWVSVHJKS3JnMGlac2Z3VCtTdjNub0c1bFByOTQrQnpS?=
 =?utf-8?B?VXBOZTBzdWM3T3VCS0xiaXBEVWlPcEZtK3N1M0MwSzdvRnQ3ck9kQXpjaGd1?=
 =?utf-8?B?MUU5NXMvcEhLcTlVcFd0OEp3dDZLOG9PbnZrYlNtZXptWjFkSWFIMmtFSzEw?=
 =?utf-8?B?YjBCaFhYSW1FWXZlN25nWjRzYlBkS1ZJTE5pY3JsMkxQd1VKNEFLaWg4Z3ZZ?=
 =?utf-8?B?K2hrRXZnQk45M0xld0wxZ0x1NE1waEo4cDlPcUg0U2xIWXYvWWFhTFJBL3BK?=
 =?utf-8?B?UkVQN3kzYlI2Z2hObGU0UXI4RFplOU8wNFpubnJzT291eGZ6SDNqcnJ6VVJG?=
 =?utf-8?B?N3pOQ2FBWkJaOFZZbGhrT0ZEL1ZXWE8zUmpHMzJwcFZDSVNRNnUrS2JqTGdN?=
 =?utf-8?B?MXVhd3czcUJ0bVNoSTE0YWFvQWhOd3MvKzFTbUhjWVZzbWhUWDlONmIvU0Zj?=
 =?utf-8?B?enRQZWZDczUzZWorZjJJeUFseTFROGo2R0ErN3NZMHlqNG8ySDFPTllFSHRH?=
 =?utf-8?B?UnMyaFUyeldjWUZSeHJldCtsZmR1UTdYcmljclZCeitkSTBPWVdnYk5iekhO?=
 =?utf-8?B?VXFNQ3h1QkRNRXl1djJ3aVJJNVVWdGZBSks4dVVvUmVTb2pTRUsvVmNXYXBE?=
 =?utf-8?B?bm1TV2Z2aXpuS2ZqdnJpOFo5cXdyeGQ1TWJqdWFYS0ZMaW9WWVBzSTBDNVJY?=
 =?utf-8?B?WmpnMWRmZjJpUDA5VGlKYmpQdlcraEIvT0N3SGcrRWtBME1pZ1VqUldQMVlx?=
 =?utf-8?B?SWQyTnNuaUlmMTIwTVNzbHlYRTMvMFlwbk1FMEU1amRUTUgwN3Ywa0VRNjFF?=
 =?utf-8?B?T3N3K2FxUWJWcUFza2YzZVA2by9FTVBnVFZFT0pvVHlwbmRtYlljS1I1Q0Rs?=
 =?utf-8?B?UEttNnpRZ3NOdVNhWDdMcEFVUmJ0aUdTUW91dWNhZFBNREl4RktxdytLQysv?=
 =?utf-8?B?eDhNeVJOSG9nQXVqWGJ1T3JTQzF6cVcrWUd3eURxbHpsY3RnREVFS29wZ1Fy?=
 =?utf-8?B?Y2FXVG42TXhGL0tYRStucUd4b2RMdU9SUkoyK25YTTVTVThxNTUya0V0Mk1F?=
 =?utf-8?B?SE92aFltK1k4T1BrbmVQSi9xblRJY2RGRmYrQ0FmQWZHM3hlZjVDRjVTbEtG?=
 =?utf-8?B?NUpmU3YxUjhiNDFTRlZ1WmFFUWdLNTMvbEpVb0J2T0pUQmpOLzVBTEFLTTQ4?=
 =?utf-8?B?ODFzVUg1bkFLMlN0bkhrRU9xdFZOOXBUNTNjMm1tQmNoQlJPa0p6blBSQzl1?=
 =?utf-8?B?bW5nNzVXVThTRk5GRndzR0FwWmhYenNVSUJ1Q0VydGtSY3c2V01ZWnhiUzhX?=
 =?utf-8?B?OTdsQ1FacnB6elozcW54OXVuaWk0TnhGYkpzSVdGK3BRMDNsR1ZjTG9KT3hD?=
 =?utf-8?B?WkdXVGJQZmNKODZPVlVrVjBxcnkrbTREOG4yVHVYa1grSmRQL2pCZnJkcTJw?=
 =?utf-8?B?M3U1TU5XZHBKQ0VuRFVwbGZQcFpDUWR3SDVnV3Y1MWFCcW1FVFBaZU9zZldC?=
 =?utf-8?B?ZGthNytxNWE5WFNDeVR4RStISyt0QVRzOUJsOWhsRlo5d1BVZVo3em15eEF2?=
 =?utf-8?B?Vm1VSzdRSHVjYTBHQzBNVzJTMnZ0OUpGdk83OHdPeE9uaXl5QWhhaTB3NlZa?=
 =?utf-8?B?WkdqcDNGZmR1L1JqUktQd0xXdCtHVkFDSzFlNlMyVUNUWTh1bzQzMEx0TEpP?=
 =?utf-8?B?VkM5NERqcFNIQ0lQMjZkRmgxWlNOM0llUDBKMk51U0RCOFhDd3QvN0cza3Fp?=
 =?utf-8?B?L1IxR3g1Q2MzbWUxTlQ4T0ZwOTBnaEJMbWpvNENtWUxyOEJkVkNRc2h2TnRr?=
 =?utf-8?B?RG1SZDBxT2VyTUh3U3laamxYaWJCeG5JaTFGSGRnZWs5TWZIQk1tRS9BeHhr?=
 =?utf-8?Q?Qzkgjx0858tCmgZ64E9XtUUmN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a565bd9e-fcad-4890-e60f-08dca5604f29
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 06:27:04.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqsvtUkJjVYzrUqfLNFsFHvX/wA1OmW6vLtrNxYmf7hEouOmQc2nNe5CRHQzE/jKSwKrFJB6Zt7E7qQDnoINiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7314
X-OriginatorOrg: intel.com

On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Create a new function for a type2 device initialising the opaque
> cxl_dev_state struct regarding cxl regs setup and mapping.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/pci.c                  | 28 ++++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  3 +++
>  include/linux/cxl_accel_mem.h      |  1 +
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index e53646e9f2fb..b34d6259faf4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/io.h>
> +#include <linux/cxl_accel_mem.h>
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -521,6 +522,33 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return cxl_setup_regs(map);
>  }
>  
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_register_map map;
> +	int rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
> +				&cxlds->reg_map);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
> +
> +	rc = cxl_map_component_regs(&cxlds->reg_map, &cxlds->regs.component,
> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, CXL);
> +

My first feeling is that above function should be provided by cxl_core rather than cxl_pci.

Let's see if Dan has comments on that.


>  static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 4554dd7cca76..10c4fb915278 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -47,6 +47,9 @@ void efx_cxl_init(struct efx_nic *efx)
>  
>  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> +
> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> +		pci_info(pci_dev, "CXL accel setup regs failed");
>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> index daf46d41f59c..ca7af4a9cefc 100644
> --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -19,4 +19,5 @@ void cxl_accel_set_dvsec(cxl_accel_state *cxlds, u16 dvsec);
>  void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
>  void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  			    enum accel_resource);
> +int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  #endif



