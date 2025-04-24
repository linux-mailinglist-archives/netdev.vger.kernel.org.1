Return-Path: <netdev+bounces-185647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EBA9B328
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4E0921044
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271921B4227;
	Thu, 24 Apr 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kW6yD6ip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68527A926
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510253; cv=fail; b=lW7Z0P4cVQZwKk7uw247ELOrO57dcozVYab0YiGc7g8WqqD9enQ77ai3ZJTEdhfUPz/X4x6unh5bxQ0Q4yE2R4cl4gBA82GaQSGSboZ5WNLc0Oyn+gGCVcdfbtBMoHahjDR9HlQDrlaXLmKYi1lpNimwbg4WQTpnN7wTtt/Ps04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510253; c=relaxed/simple;
	bh=eKZ6GcH76BhAruIxFSUmZ2KEmdQZzzvJKZOPVEw8ub4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VBOlONq/XQfm6WfyIuZg/+gVP2ZIBTy2vt61WwkBINYTFZmxCTcRW55mWplOhVswmFXtliXuFmR1lT9bSt+eCdPzspOCoeCYlkFpnSXB3ak6bQClgNojOQ8Y+DbbZsiD8TQRFakKhbkRYFhXl9Uhp/by8FQjKmzaZKX5OhLH3aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kW6yD6ip; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510251; x=1777046251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eKZ6GcH76BhAruIxFSUmZ2KEmdQZzzvJKZOPVEw8ub4=;
  b=kW6yD6ipMtI7bErE34exZuiHNLQHoqywzCdKBo7rVlYI0bjT+iToxfzl
   /ysZJfGYR3agb7KvcSWEg8ZZiy8ImNdD+WxdKzPcb7NU8bg/jS3vUVi6z
   VqS/wr7uBjpzVifm3hnKim0kyEOtqIOTQ52sAuJR8SJKp7yqTOyGZ0yFl
   05lT1pfHeI9aWyKwROHCVOGx0FxKLBk+P5O1T9CpLI3xKnGqkkhV0hZyX
   8iR2Uwc6LBLXytxnmenRMNuZf5/xNg3m6hJH2phB0pK5xNnIoe7LgEfvn
   fen239KZG8VtMo1J7UNuncwdO+ZQZ6R5MuGngoN5m+wbF96SY63hYTumP
   A==;
X-CSE-ConnectionGUID: cq8f/1onRoqt560TOBsiLQ==
X-CSE-MsgGUID: hVfj2+zGQga+aNO0PY270g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57793664"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57793664"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:57:28 -0700
X-CSE-ConnectionGUID: 53ycNAipQEqiQBphp/VYbA==
X-CSE-MsgGUID: 4OqRCVbURKWb/HGw/Lqmrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132646510"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:57:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:57:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:57:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:57:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTo8K18hGaEdemFJOinWrLg1G6G3LPdJqTBzuwm9L05xk43a00Q1B0V0XUtfKWdNp57d/KP0eQ6mOMMVYJbmKC5iiUH97Ar7G7vsmER2van2wpMHkIJY+28qukB2/76ouCEyUZWEvTM+dBM70wmuXP6rHDWwqdWcDAdsB4AmqGPAjJrjbBN83FZk1YgOEuO+SfjjV2FRciA1xWFlcIeEHLtL2mzLM7kBko1jZ8X4VqGp8DTHni1ZSZoxiWdK+ekpTUE8ou9uuhNc5oOTU+hfkBvzVmj3VEXpNXWZNli4y1Z2rDSpRoEnfejhtopD5AlDZkIdYJgfQixqPGn8uPvP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7BiypOWgmZ/tF6k6CWlSaWtFEJ4phBMDOGCeYQ/xaU=;
 b=BcIGMwKX6yiz5YSZovI8YNEsAN+AjDpjU5uRIjJyoLD1h3nHH8BWAQkNEwev5bJXmkp+q+yMNyL0GuTBtaIM6C5HF4OYW/BhTH+2cT9mSBvWk8YJQToLUYo7p4DPRauOsBIC0G3j/aguZBB2n6aVTegzXuWW3Nzi/ArOOmleg+3zDSztJFAq2IypEC87kKOu/JvpadRGs6R+2v/2zIzzFifARfWJE1ji3wdGGVSS/Ep0b2O4fy8Buj96Hw6xNBHji66jkEKSHrRC3iCrf76zvStq/OD8esAClIeGgY0vgQcv7D95mmOPUSxPv79aE2x7RdB3tejzMOsfINXXC4t6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 24 Apr
 2025 15:56:42 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:56:42 +0000
Message-ID: <a3ac09e2-ca51-4eb8-bf29-1a832189db30@intel.com>
Date: Thu, 24 Apr 2025 08:56:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] tools: ynl-gen: array-nest: support put
 for scalar
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-10-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-10-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:303:8e::7) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SJ1PR11MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: d97d5f69-2a97-4c23-26b8-08dd83489b29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmgzTUNhenRrekVMZk5mSVFzeWpoM3ZEdnVWcm9JSXpaUi9hQVdSVG1qZlNY?=
 =?utf-8?B?K3duc29URWtKb2hZQmt6aXZvbm85ZHIyYTY4Ky9FRVpteVRpS1ZXalhmR1Mr?=
 =?utf-8?B?eWE0Y1owVExhV1B1ZHFEQXkrMitXZTdITXVhNjlOMEZZK0tYSVdjbFY0RHcy?=
 =?utf-8?B?anhZRENWdkIwWXFxM3BtTCtUR2F3TkdNYTR5U1BteTFsVEJHQ2pvb0lXZTZF?=
 =?utf-8?B?aDhLTG44SlVsL2hHRGNLeVhvNlpJZmZJd044cFlmTFNCTUlnMUk0QUJEdkF5?=
 =?utf-8?B?RzFSQTZnM1EwT0ZYVDBPTXZsNjRmUmljNGVxMDJaQ1FXQldWVytXT2JuWm9J?=
 =?utf-8?B?aWF1T0JTaUJjY29KaEwwZGFZVXBUSkxvcTEwTmp0d3doUmFrSGNZN0hNQnpx?=
 =?utf-8?B?VndEVFlRb28vQ1hvU0MrZWExejRocVNZQThvUFMrTEphdVBMZnlTYVlUV2pV?=
 =?utf-8?B?eGNOQjRZSXpHM296T2ptZFpyNmszSmhGVmVJeXREV3VGMWh2cGNxTGZCRFlM?=
 =?utf-8?B?blRqYm1rNlh1N1YvQlBtTzVsbWhLeFVGL3NDdzRpVnhyNHAwc1ZTdWE2R00y?=
 =?utf-8?B?YlFsbmhuNzg1bE9lM0ZXQytKdS9MRi8zR0EzWmlpd2FQeCszNUl5eGxQT3d2?=
 =?utf-8?B?OElSb0pGODBYbDI3dHc3VVpEemE5RVJ3MlJNd3hiaE80UUFWYjZWNUtycHlN?=
 =?utf-8?B?SDRnNXZUWEc0TEdZZjhNbEp2UWN6SGlVSzFxcldnMWJGamZmNnVQTVFFekpP?=
 =?utf-8?B?M3N5eEc0U2xxeW5KTnVrTlJwbVRibHRNUGJwb0l6Slo2Vm1zSXpIVFBjRy95?=
 =?utf-8?B?UVc1TlRSSitZQ2VxSHIxU0h4K0kzV1NZc2NYa2pwam15dzdwWGR3bzEwL043?=
 =?utf-8?B?d2VadG5yTmJiS3BMT0NuRUkxRUxvRVBPa0VZbFlTR3drRzZDbnprZ3dVdGEw?=
 =?utf-8?B?bHpBdCt3c3VFYzI0aUtmSTRyR3ZxbW9pMlNvTmRNWnFqRHBmREx1NjREdCtG?=
 =?utf-8?B?V2xjTE84ZytTNWp6RTd2b3BEM1VyVXd5eGZjaW9hZitEa3dkamFDdmkwM1BR?=
 =?utf-8?B?VUpZNjNLMXdOUWgvU3docEtYa2I0Vm1YdnlMaW91T1MxcnIwMDVpaFhnbGgy?=
 =?utf-8?B?bGJwVXV6Z0RRRjZJNzloRWtvV0hSZnRtRk1VWm5SQUcwODlocHdVKy9QR0lE?=
 =?utf-8?B?VFFabld4VXB5SlVkZ0krcUFxU2FrTVhWczNqektJZ0h1a3RSLzV0NWpsKy9q?=
 =?utf-8?B?S1hHWm5ia3dUYWdKRk5SYit5bUFRdXI2WC9pTG9mMjlDVkIvVGZTZjFWeFQw?=
 =?utf-8?B?Y2VHWnR6RFRwNDk5dTNUQkVicUJBWHF3Nm5XR05TczA3cGhWZjlmZkVvZ0Rw?=
 =?utf-8?B?WlBwOHRaV1hVb0hvWDljRGpkTTRXaG9vWmlkby81YWtvTlA3L3g4NkhGb0Rl?=
 =?utf-8?B?dUprVXFTalZXQzdjWkowY1VxWGptZU02eDl3UWxLYmRtZUZJdXUvdlgydXJa?=
 =?utf-8?B?QS92aEdqTmlFczdER2U5dmVYS0tPMnpDWGZyQU1QM0U1M2RNQUpiS1NObThK?=
 =?utf-8?B?ZGpiZk4vK0RNMTZ4WVNnWjVqcFF3ZXg0QmQwWkxEQ3VFQzdHQTR3LzJNaWRL?=
 =?utf-8?B?MFE5c21wU2lxRUZXb04yQ2dnT01UMGFxUGQrR2VJbGM1eW9tQVFYYTNDMDhZ?=
 =?utf-8?B?Q21BdUU5SThadDVKdGp3NDU5ZXhpNTFwZ3hkQWhkTWdKb3E5djdCT0g3SFJs?=
 =?utf-8?B?RDdyaHoyQ0xDZFdUOEo4RDVZcldyazBwdTdDM0IyTjA1UkdNU0UzWi9oVWVz?=
 =?utf-8?B?Y0Fuc3lNNzZheHdIaUVPc1lEcFNZNGJCTjJtdVIwbDdyYTNQcUxEeW5qZTlh?=
 =?utf-8?B?K0JHL3F0YzlLVlgxSXJxckppYkUvSjQ2Ym45c2xKdEpuTnVIUDBPWnFBVXhk?=
 =?utf-8?Q?sOVEEy/gRaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3dqSXFFcEVnOWZ6SmRXaDN4TGFnNmZKcHJLUDJJT3l1K3orWEJjd2xZOE96?=
 =?utf-8?B?ZGNVYmdJSy80Uk5mUTluUllFRDl0ZGYrbUkxMHhDL3lwRGxMZURiUE1HaURG?=
 =?utf-8?B?S0JWV0Fub3QyVlNtU3Q2VkljM2Vzc0VZdHZ6dXBmU1NlV2o1ekprYjFVenFr?=
 =?utf-8?B?ak5ydm9ZU0RTU3hJSERtK1lvMS9JTnBkbWlXdHYvenUyRHdYNmwzd1hhTUFz?=
 =?utf-8?B?eE5aKytaRnpmUGpjQUx6Sitad01hSTBiR0JyYWZmRkFMWjZoYVVSVGdvaFRO?=
 =?utf-8?B?WEIyajRQbFhvQUpJejQxV3RqcDdROU9jdFJFZ3lCclU3aFlITHlQRnpsSE5k?=
 =?utf-8?B?WEZWRkN1WW8zeWl4NFJZdHBwOVlWbDc0RXprL2tFYUNxM1JJaUpQR2VOcCtx?=
 =?utf-8?B?WHJ6MFN0cE1qVEhSZlBYcmtJWCs3SHoycDQ4TnBOV0toTGt3WHFMNnJtblJr?=
 =?utf-8?B?Um1ZVHhnTG9JNU9RZjM0K0QzMlB4K3RrZWhTeWxtcTdJRGx1RzNjVGtHZWJH?=
 =?utf-8?B?QTBFLzdlSWRibGhCaVQ3a0JXb09PeC8zbXRFQk1XcXBlaXlJM1h6alI5MG44?=
 =?utf-8?B?SmtPMUxpd3R6QkU2RjcydGliMi9sdC8rUllHR0tnbHdNYkpXb09yVWxLd1h5?=
 =?utf-8?B?cmJKRThvZG11UGt2clhZZ0dUSDZTTGJ2bkZiVjZHSE81L0s5TjNjUFZvWmdw?=
 =?utf-8?B?Uk91bGVQak5GdDJWQmwyRnRKajM0L1NVWksvc1piRkNoWlJFZU5YbW5rUDF4?=
 =?utf-8?B?OEpKcWI4RFFOWkZtQlI5R1Q0eDdaUWsxRmZEOElWdlVTMEJCS253OVljTGQ1?=
 =?utf-8?B?bFdhcDVybURsWEEwaXRDanhaZ21CWW03R3RGZzZwdFQ0U2RDeXNoWmtRNC9i?=
 =?utf-8?B?REJJSnFpTHQ4R3Nta0tzckVnV3EzM0NHY1ZrdGdrTzBOSVFlendGamR3ZXpL?=
 =?utf-8?B?Sy9vYTZ4d3FQS3JOOVFCRit1OXlMWmhZQmRsSFEvVSswV2tzTHJIOHBQQUFl?=
 =?utf-8?B?OUozVzdibFZFckN3eFJmZ2xBa0RDQjVOeXlieHVVb3QvM2RsVlZpc1NCQktT?=
 =?utf-8?B?bG9kekI5enlLVmJyZWxQSE9NeU9CUFEweFVPeU1uN2MwTXJBWEpJdFRCRU9R?=
 =?utf-8?B?enVWb0dncnJJeEg4dno4WmtaZE5MOVVnOFRnMU1HT2hpZDlWdVVJbzJzYjJL?=
 =?utf-8?B?Mmp4WEV6NENFVlNXTkdLRDRMVmFhOGtWSW5Hcy9teC91TVFQY09aWDdMc3RK?=
 =?utf-8?B?eFBTaFVuMENOdnFqN3I0d2Z2OEZBQTFudVF6MG9RZUt0RnJVcGFueGpoRnRm?=
 =?utf-8?B?dlpmUld1NW1UMUoyVUdtdDhTeWJrTWpvY2kzSGZBbnJHS1JFTW1ES2daZ0pO?=
 =?utf-8?B?bFhCUEZBZDdCYkY2OEpXKzFhKy9DR3JKOXlXQzBlaXZ6d0dGZEFZTDVBejhV?=
 =?utf-8?B?eVgrckNUZnBKcmFpTFpwZCtSRDl2OXF0RG5aSmFKSTBZKzBNS3BwQWlxNHZ3?=
 =?utf-8?B?OFg3ZmphaGlOMXBMRHlpRjNPRGk2WWtqbTd0YTJvQ0h3Zkp5aVR5RVpTRHlF?=
 =?utf-8?B?UCtWSEIzTVNRdGlUMW5yMnV3ODdrVngrTkIxNkJQamxpMDVBb3FHeWdpTDM4?=
 =?utf-8?B?dDRxeHNkZVFjSm5YOG1JMm5FQUovbU1kN2NEZlg5cVd0dndQOStJVTA3UDZV?=
 =?utf-8?B?a2VjWjdiREErMWlZWVJVRnowaDVoQWhQT040UXdvRzY3d3NYc2N0QzJTY2JG?=
 =?utf-8?B?Z1hhTmxjeW9Vc24vTUEySDBncDBRQWxIaDc4MFhGVlBoaEVsKzYwY0FXYkdl?=
 =?utf-8?B?MkNQWmlYSFlMdEZ6VzJ6dDV0WmRnR3pUZy92cVB1K1FyY2NJa0RCY2c1UkRr?=
 =?utf-8?B?YnM5ZE5VUk9iN2hQbUU4WHI2NnJpVzRkMjJhVUd3YXBFeER4ZUdmOWwxY1J0?=
 =?utf-8?B?T28wdWhBZFp3QWtPWXVZdWhtbFZWMlRCaFN2QTllVUp1akpNUjMwZlh3T0tx?=
 =?utf-8?B?RndjL3Z3TFZxTnhHeHltZXJ3K2MwcFVURnBDQnpCWittWmloa21BSzZvQnJV?=
 =?utf-8?B?cmNwMStFcEZOeEN5UVF6N3RsYUczd2NVb3Q2MzJVcE1pQzV3dkl5eEpkcXkv?=
 =?utf-8?B?TGwyMFl3Rjk4V2g1aGtFT2lRZXdKbWxHdHUxNlRWcHpmUVd6VXN3TjhjcGpw?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d97d5f69-2a97-4c23-26b8-08dd83489b29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:56:42.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s21rj5qOsPpiCq1fVUyYEzZcwxQMPv8OChbzboMtwCZH06rzShqd7mOJ15WJn5xZpBpb8IExr1cobTHM4cv9edD0mqmN/0DyR/hLl45aO+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> C codegen supports ArrayNest AKA indexed-array carrying scalars,
> but only for the netlink -> struct parsing. Support rendering
> from struct to netlink.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

