Return-Path: <netdev+bounces-155805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2858A03DA8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A171E164EF9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E361E008B;
	Tue,  7 Jan 2025 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2Zi8W3V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB31DF98D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249297; cv=fail; b=B8DPo9GKzzw5c4p6BTowUSnA75NOuXQK8Wt2KUqgKfCe88ds6pTPY+ezxWidHXowOupz3gaAcR4vkBLUdVXotDz5FFidldBg3TeiLnheWom68bzRDz2GObR4bL+q1P5dMepv5OgOtplDQjox54uBYANI7F/wVCyfnlVGv6yPw98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249297; c=relaxed/simple;
	bh=vfo6gLUMtICi6Uj39GapyzDQaLsuDv0o0bNmWz1GXmg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=piCxMP2qhOgoIQfLpdpKmQZkcJDN3z29cg/BbF3TxJy3hRVcDYAAOLDKMKdlOIJ9WevipMUkU38Eg2ekkI9Z0RdePKVbyxN6uECnIFfxWQb4Sf4/7CDMS+BgtV7MFkrVKdI22fRid+vmeucluTVD15V0zgguDFLgNjmPPD1N+7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2Zi8W3V; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736249295; x=1767785295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfo6gLUMtICi6Uj39GapyzDQaLsuDv0o0bNmWz1GXmg=;
  b=d2Zi8W3Vkao8kfEUXxK6PktvxLmmRRpAMK8hu5HUgQUSqPR2d4SdSzwg
   TZ7AWjyUnXzDWbW6wBZ+FED8mAZGrgShTrn9fenMeHC4t0SDKyUXbW7yd
   6PYLZ+64bTxzYCUe+odSAbA9+UEEYpWhFgVtovuZ85fesW7rgdOislU5R
   LQ0IIYW+8ArSRWibCMb9CGntj5Rz3M2vavDAH1feJNfZ6ljqpUMQf83V5
   qN8qcl2DvuXZ8lf85ZdmWPB5s8CRVIc/TuYt9FOrfj/o6CGGyDLdyqyg4
   Qv0q7TGNAI0jJAhCyxmwccRGUQx+q7Eu/kqxQD1x0kG0VVYLW5f3NxbHP
   A==;
X-CSE-ConnectionGUID: s+wyXiViQpmRFCdiAflDuQ==
X-CSE-MsgGUID: K39b2WdFTxGYQOX0gjkWRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36583321"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="36583321"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 03:28:10 -0800
X-CSE-ConnectionGUID: +4fz8jxkSuWsEkJmFAvHNA==
X-CSE-MsgGUID: OtnvuzvoSuWkEF2i28jLXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; 
   d="scan'208";a="102555363"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 03:28:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 03:28:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 03:28:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 03:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX+T8dISZxvz5B5OY4gwF+I8Xc+EeYZanycey9au+7avWqckaMq+JQazEXnSakRU4QYMSX3Y2wSCF0/1DgERzTnLSAhLlexSAFQms1uWabmTzuK14vwdXt91s26uLlSwjAWGVzf21aetMbcDNQHfKz8d9XzKJWT0u+ozFift8Z+cKxAwd7rd5e56+xcY0TRTt56Xd60BzWIh/9t3E1vBQ/96ClnWlLLiWbTTvCTlTUubk22Orglzl/qAo/x8niJORsLs5++eUTvgThW9UCHt+N5huhlzj6HO541BeO/ghNFsqUSZhQD4YifkZF5+AKyNM8F5aNRRwasop9XF8CcMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM3CvrdtAHD1fYYTNkeo03H0bKnEGzNSa+tKBs9Eb/w=;
 b=Rkmq8VPadUjqxCKuhApRyU9NaEWAJH9b6UZEQJIpu9YO6KDZZSKJn9nzmSNtSqLEztO1nT4M8fQZj2423PwAKxQTTgGPN9vWl6kOiv6czty69IuP1b6gzLpGHZIVfDroDrE4ikP7DEszhYWzDSuRrqBDHhdflmdV63e0TX43m/MduPuJWHJd7hfTUJYrT5Yi/9GKfZdK3nhW/PoH2jcsoso+E1VaxjfdIrpaAGCM827tt51JBDlQyqt7xuhLbcGhTTND5QdUID7pTAJfEBdyG6c5KOoJF5b8S7mwj9yS/iZGgIEfFtlNQjnqTnZV9vIAk0WP83U0lJUKUgxrUCGFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 11:27:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 11:27:59 +0000
Message-ID: <301091f2-97f4-4781-92dd-d9cfb33eedcf@intel.com>
Date: Tue, 7 Jan 2025 12:27:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/13] net/mlx5: fs, add HWS root namespace
 functions
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-2-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250107060708.1610882-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::45) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CYYPR11MB8386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8b0812-4f02-44b1-8270-08dd2f0e56ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmxGd1NNVDRuUm9XZXRaOWVBc2RwbThMQk9Kd2RRRktvUFU0bWEwZ3lZSXA3?=
 =?utf-8?B?LzJJcXBCWEF0MW8wZ2RsbE5oNW9ML1dwaStRVzRPc3o3aDNTbXFnb1o5Sk5K?=
 =?utf-8?B?OEw5T1hkbnViYUZBWmkwWElydEdFMjFhSE1uV1pyU2d1ZEpjYUhwNjUzOU5M?=
 =?utf-8?B?Uk5WM1ltSjZ0UGluRVRYY040R1VFaGdlcGhjTDl3Mk94SUU3cVFJc210RGFR?=
 =?utf-8?B?SExXVkdGTHUwb3ZZRDR2QUt1cE1XZ3V2dVVrVmI3SE1BVVgzUmNwc29DNFM3?=
 =?utf-8?B?b3VKZjFxOHE3djVuSmFqS0d0UzExWGpGcjB3OEMvVDZ5cVo2cWo4NUdSRVE5?=
 =?utf-8?B?ZWVQdDgrYm1ESHNvRG55Kzkxa3p2NW9MOG0vYjRiK2NIWDloUzkxZlhuTGtv?=
 =?utf-8?B?WTdWT0JGVlNadEpwOUsrOVlnUSszOFhac0Vybmk0UnNTbTYycGJ1RXk3THVS?=
 =?utf-8?B?MWkzdmJCSHhZNGgvNnN4MXhkSnlTQ2hWbmc2cFEyTmRzZTVaR2tCakhPOUtP?=
 =?utf-8?B?VmdZQTQ1N2I3R1N0VGNXakZ1dWdQTGQxV0lhUDI4UzUwYUxDeWt0aDA3MFR1?=
 =?utf-8?B?YkZSMzlGVEVaVVVid29FcGRScHE4VCtVU1d6TXdHT2gzaHAzaW1QNkg3OFVL?=
 =?utf-8?B?SnN0Q09CY2s5eFdiRjRzdXNOU3EzQ1dXbkxFTXJMYU5HcHBDd1N3UVU4eTNZ?=
 =?utf-8?B?QXg2d2w4Tk5ZMTJib0l3M2lhTElzcngrOS9qdjBkMTFheTlkYWZZSEJETHV3?=
 =?utf-8?B?R3NsSVB4RVZzYXRiUjFTSTZGbm9pR0w5M2NvQ1Y5QzJEbzZtT1FwbG1DeVI2?=
 =?utf-8?B?QlFMeEZGZXlkLzlKZXRGRmpGTllCL2s0b0JtTDVaUnh4b1lMUmExR3NqM0ZF?=
 =?utf-8?B?aGFBd0FKeXZjN3BjRDRoSGRwZkQ0QWVsTTdtd0p6dk1HdDZWNkRpL2hnYmw4?=
 =?utf-8?B?RHhYWjhjU3FiWjZjOGluSzNWRExnU3Z0Uk9JWWFuYVRmLzNnamdlOHhIMDZ4?=
 =?utf-8?B?WW5pYWhPWThpVmcxR0RZNlZmYmdJcDJFWFJtemdLcjg3T3l3dXc3WXJjWi9v?=
 =?utf-8?B?WkNvdlV6bXNiWlFrNmpTTnJKblQ0T25MSGM1eXZEcCtBY3ljUjVhamNPSHh0?=
 =?utf-8?B?SzJaTDF0b1JCMlFoMndPaWNuby9ESDJnUFNwV21tMkk5TnBrWXF3c0JaeXlT?=
 =?utf-8?B?Y0pMaWFOSyt1Zk40UDZ0VHkyMytoaUwwMVJ1c0dCT21lM2xkRzM5dTA1ZUIv?=
 =?utf-8?B?L09vYXI5Q0VDT09QSm5QbjRUUlozSERvZ3NnSytKcFdVRS81NG9iNFFMSFFC?=
 =?utf-8?B?T0ZGMmhGaGJCQjhUUWVIUlA2V0t5QzVzd0xpaUpXNDgvbUI2QTlmeTdhb1Nw?=
 =?utf-8?B?bnFOa3dCN0g1UVY1aUdySGRSdDZPMlY2d0dVeXQ0MEliZVBOU2MrajFNWk9K?=
 =?utf-8?B?OVRGSlJOdlMwV2RxWlZIQ2R0dTRxTDhhU2hQYlhrZFhGdVZoZWtUSDRyK2VD?=
 =?utf-8?B?L1E2RG5yTFNzWEFxL2ZRc0thRFdGNFBsQ0lJNllxTW9GTVloamJsR2hLYWdo?=
 =?utf-8?B?eEhueU8wRXFHckt1a3lNMEFwdkdDZ1lBc3djMlh2ME5Hc2RvTXlHelB3VzBC?=
 =?utf-8?B?N25UT2tRS2JLcytIWmltczU0VCt2U1BnNzI5akpiVWYxNVZaVEJVYnAxWE5v?=
 =?utf-8?B?MW13WmxzTEM0L3YybkZxYWFmaDhqa3VVTU9JcW1CUG5RZndOVndaUnBaRy80?=
 =?utf-8?B?b0ljcCs1Y1NjWnArWlBBSGI2QlRGTHB0eXdOWno3M0ZoaTFFNmJCWFFSSldH?=
 =?utf-8?B?REZQMDJKYTBDUjh5TGovdzk0ajRaUDRSZHhxbjBSVVBGd1N6YisrWTNHOElt?=
 =?utf-8?Q?pvW4A4Jr1f527?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNMVmw1NytUZlVmeU5UMzJVVmZENndzcjNDSmNXSUpidFJFZmFwSUhIWnh3?=
 =?utf-8?B?SWNwdmpzYWFlK01SMDVZUk9GRXlESUp4RzJUbUZwYjNUU1Z1UXBpZTVLUDRr?=
 =?utf-8?B?MURFOGxpVlFnL1J2SENCem5wd3FJa201cGFSTEE2VGpDY0FjbldlNkhQMXRo?=
 =?utf-8?B?OTluOTNTVU5pTUdYRlF3TXl4aU9WUi9PMHU5cFpMdUFqdDdHb1ptZTcvbkFr?=
 =?utf-8?B?SjJqN2tqVU5jMUp1UlBMMG5LRkVQTG42Um1UTjdkdnNNbVU5WXQ1V0JOMW5h?=
 =?utf-8?B?bGFud2lMK0tNaEJ2NFgzajFKQTdONjhiQm5yYTJIZHQrTC9kZGxNcWMxV2U0?=
 =?utf-8?B?WktiWWJBcFFQTkdwZEtTZTVKZjUrdjEzRG14bzhha2g4TmdyZGgvd1Y2U0t4?=
 =?utf-8?B?V2tFOUsvSDQ5OGpJZ0hMdUIrQkhoQVNaNVJiNkgzM283bGgzRFVybnlPYlY3?=
 =?utf-8?B?NjBHWmNsMzQ3K3VWOUl6YU5tdTIyWHlXOXo2Z2dQdlprRnRpVTF1bTR5V1Jy?=
 =?utf-8?B?YXBKOE54OUlESk8yL0N4RWdURDhPa2ttMHgyWWlrcUFiMHdOWHFNaTZJZWVj?=
 =?utf-8?B?T0FXQmxVSkxtT3VSa1V0Q0c2T2FONWFHUEkwVDBncHJzYkN4eWhkcUdmUWdU?=
 =?utf-8?B?UWZHTHVDdW9kOW5mUEcxWE00WUNTaFAxT1VuZEl0d1Nkc3dnTFBoRDIvNzIy?=
 =?utf-8?B?SDVwd25FT0JOd1YxTEduRkV1RG13NkhzZHkyaE13VlpuT1diVmRxSko4amZY?=
 =?utf-8?B?T0o0TTZESC9SWTdOSlpiYVQveENVL3BFREkvS3VBSkFWcXE3OW0vY21ySUFX?=
 =?utf-8?B?K1ZEdnpHOVFsS2Z2Q0Vsa1IzU01OK1JPL3NSMDVJclkvSUlhclQvRWhJWXE1?=
 =?utf-8?B?cTM3L1JHN3oxTXd1QkxuWVJ1ZEZCZW9VdW40L25mcVVZZVVTQW5WMGJQWGRZ?=
 =?utf-8?B?Ym1sYk5vWllndGhBZ2VZNFBEODZXMCs1Z3BqMG5zSEh0VGFRdHorQkhhTExJ?=
 =?utf-8?B?dWM5UHkzbDhHNVRFRFJRMTFrNm5WUERLY0JiUzF1aGZCV0U2ZjRtci96cXhC?=
 =?utf-8?B?bTIzRmUrT0RXNjAzcUNXNFNRcFAwdUx0QmVwUGpkbmFlV2RPVVVUWFRzSGs0?=
 =?utf-8?B?ZGgwUVMrUnliOWk5akpRaUV0NFF0VVZNUUVqMzVtNkhPdDA0a3lnTXJXeGg5?=
 =?utf-8?B?RDVUbU1QaXkyTkNTcHlQUzVIWjhQWGgvSmNRMnJUZ1BzZndtbUV4YytxK0pa?=
 =?utf-8?B?TUE2QVhkMmlPa2NCZ2NSYWNRdXJVckRXMXl6RFhRTFhkY09VSlFqQWp1ZDBV?=
 =?utf-8?B?V3d4MXFxZkFwdHNKWk5XK2JKRkFpRnFMVkF3dXZvN1YvNnpWNFRWQUtKWUtk?=
 =?utf-8?B?RkFDeStGTkZ1UytaV3dDVW1WM2E4cytiS202OWN4VGNET0xOY0VoQnlCRVNj?=
 =?utf-8?B?czJDUkZjbjBQdkNuT3lDMFh0SVRpNExIbFVSZ3NCSGlEb1FNa3FhNEJVaG1N?=
 =?utf-8?B?R1pNTEo5UEhPYTQxMmVpazArMEVUaXdiNFZqNFVjTldTMFlneE4vaUJLYlA2?=
 =?utf-8?B?ZW5pQkVyVU42bGF3ekRaZTJYUVhaRWtrM1lOZW5TOFRhUktLWUFmRHdKbTUy?=
 =?utf-8?B?UnpJaktEcWwwV2szQ2pXVE1PT29EbWk3OUw3NXJiOVhoN2tKRXYxUU5WeWZz?=
 =?utf-8?B?TkdRWEhKUk0xNkxKYjNMeitKM0ViemV3MkNvN2VDNkNyZURvd3VUa1BGaUgx?=
 =?utf-8?B?a0dZRkJDSTVvaXVjeVBHTlVGazVLVDRZeUhqSHdORjFaZWNHdzMvenZDakE3?=
 =?utf-8?B?NnUyM3RxSTZyZ3gzckQzZllUTDlHY3FSZUNQeW9maEE5aFE2RG1yV29kTW5o?=
 =?utf-8?B?NVBJL3BtOUp2VWVUTFN6emlpcGRoQlM0d0FXQVhjaHpZbXZTeWMyem9hK2xo?=
 =?utf-8?B?djNGOFBiUzk1MDJ4cDUxUjBROWE1NThvUzhkK3ViWWxPRG5IZm9HbVBtYklE?=
 =?utf-8?B?MGdXZ1RVcXE3eW0wZ0hRWVNOeVV0dHZFc2p0bUpDVkV0WktVaWNKTlQyb3d2?=
 =?utf-8?B?d1NaUzlrcHJQQlhQV09OSkNKVFk1b3NYNzlqaSt6cEsrL09VZXZzbTdQQm5K?=
 =?utf-8?B?b3VXQW82Rk95dWRHT3ZPTGR0elpRdFNDVTNIdW9VWDRQTEVDMWtzTHdRMUJz?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8b0812-4f02-44b1-8270-08dd2f0e56ce
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 11:27:59.0112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY3UzBXfDJc9qFB0Ue0kkLIC7eSQX6RK5KgIDQI1RXO4brvHrPx+lg41MlU1wI3MHztmhDyJxDGibr0pBaeAxNieBTF/VjluWEKsRg132tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8386
X-OriginatorOrg: intel.com

On 1/7/25 07:06, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add flow steering commands structure for HW steering. Implement create,
> destroy and set peer HW steering root namespace functions.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |  4 +-
>   .../net/ethernet/mellanox/mlx5/core/fs_core.h |  9 ++-
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 56 +++++++++++++++++++
>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 25 +++++++++
>   4 files changed, 90 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 10a763e668ed..0008b22417c8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -151,8 +151,8 @@ mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/cmd.o \
>   					steering/hws/bwc.o \
>   					steering/hws/debug.o \
>   					steering/hws/vport.o \
> -					steering/hws/bwc_complex.o
> -
> +					steering/hws/bwc_complex.o \
> +					steering/hws/fs_hws.o
>   
>   #
>   # SF device
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> index bad2df0715ec..545fdfce7b52 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
> @@ -38,6 +38,7 @@
>   #include <linux/rhashtable.h>
>   #include <linux/llist.h>
>   #include <steering/sws/fs_dr.h>
> +#include <steering/hws/fs_hws.h>
>   
>   #define FDB_TC_MAX_CHAIN 3
>   #define FDB_FT_CHAIN (FDB_TC_MAX_CHAIN + 1)
> @@ -126,7 +127,8 @@ enum fs_fte_status {
>   
>   enum mlx5_flow_steering_mode {
>   	MLX5_FLOW_STEERING_MODE_DMFS,
> -	MLX5_FLOW_STEERING_MODE_SMFS
> +	MLX5_FLOW_STEERING_MODE_SMFS,
> +	MLX5_FLOW_STEERING_MODE_HMFS

add comma here, to avoid git-blame churn when the next mode will be
added

>   };
>   
>   enum mlx5_flow_steering_capabilty {
> @@ -293,7 +295,10 @@ struct mlx5_flow_group {
>   struct mlx5_flow_root_namespace {
>   	struct mlx5_flow_namespace	ns;
>   	enum   mlx5_flow_steering_mode	mode;
> -	struct mlx5_fs_dr_domain	fs_dr_domain;
> +	union {
> +		struct mlx5_fs_dr_domain	fs_dr_domain;
> +		struct mlx5_fs_hws_context	fs_hws_context;
> +	};
>   	enum   fs_flow_table_type	table_type;
>   	struct mlx5_core_dev		*dev;
>   	struct mlx5_flow_table		*root_ft;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> new file mode 100644
> index 000000000000..7a3c84b18d1e
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */

you have submited it on 2025 ;)

> +
> +#include <mlx5_core.h>
> +#include <fs_core.h>
> +#include <fs_cmd.h>
> +#include "mlx5hws.h"
> +
> +#define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
> +#define MLX5HWS_CTX_QUEUE_SIZE 256
> +
> +static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
> +{
> +	struct mlx5hws_context_attr hws_ctx_attr = {};
> +
> +	hws_ctx_attr.queues = min_t(int, num_online_cpus(),
> +				    MLX5HWS_CTX_MAX_NUM_OF_QUEUES);
> +	hws_ctx_attr.queue_size = MLX5HWS_CTX_QUEUE_SIZE;
> +
> +	ns->fs_hws_context.hws_ctx =
> +		mlx5hws_context_open(ns->dev, &hws_ctx_attr);
> +	if (!ns->fs_hws_context.hws_ctx) {
> +		mlx5_core_err(ns->dev, "Failed to create hws flow namespace\n");
> +		return -EOPNOTSUPP;

I would expect -EOPNOTSUPP to be returned only when there was no action
attempted

> +	}
> +	return 0;
> +}


