Return-Path: <netdev+bounces-109503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB589289E4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB981C240DF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D361314A4CC;
	Fri,  5 Jul 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHTpz54o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7D14A092
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186718; cv=fail; b=RX8AKY17ftYusevJUs4kwbCOs3/b6HDXg9Arau2Xg2kHYWWdgXIUpKhf096oa5HmcgxD+k6EqNKKgPPvFIClnfs4Wpet1ZtvYxTHLHHC5RLzSSc1QVAFH02IVAjfA3+88uLVBgjZkdwWXTy53XZh+BUyFkVNqNPK5i42AT13jF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186718; c=relaxed/simple;
	bh=3uzR6g+UyNIqYqDSNcajuIWZP0Qw9+0PcRAKW/eX2wo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=geyC7tqwklKT9ATlk2O72uiSQt7Vevueu3xZ6+oNaWYXNCwuA4ZfQgFC0uINBYbT2lb5s9X0dZgKKvxXUnFCrJZF9wXmn+NL7POe3P8+KQkckbvhgVYDUpji3rY9vcZWpDzdbw0eZhUqBrFBOY23b2r3++QppJx2yRk2catHoQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHTpz54o; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720186717; x=1751722717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3uzR6g+UyNIqYqDSNcajuIWZP0Qw9+0PcRAKW/eX2wo=;
  b=VHTpz54odE0aWJGP0sGTNdt0FXp0E7Bi6j+TqQnO76azm257knIyHRbk
   7CxeYQfU4vjrNbaxWXmynEecf1B5A86+z0gkpnBi4H+IyyNLuwxwAgR7J
   J2ACBpm0J4hl5M6aLmIbZe4MD+EBweDZfB5B3X96ZgwEObZP8CuKK2oGr
   sQubyiwWkYoaYAnfyLW0caiopm+HW/pym3qy7LEVHSmbktCQ+Eq1Y/jt6
   /bkjBXUL3mJUa3KHrezvTGPPp9rPLdfzq7h0h/FIaMsCVeNbViJhVezJv
   B97mBEDtUc9JPz+yjUHDA0ymaWQWKCr8psatRZM3B0GUuTIzXAiCbHCAt
   w==;
X-CSE-ConnectionGUID: QYS9dd5IRA2NCd4aVk8HZA==
X-CSE-MsgGUID: hytmQbLwTTiE9sYjKMGUEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="39993143"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="39993143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:38:36 -0700
X-CSE-ConnectionGUID: Uuzw2InRQTm8HNB4CDme9g==
X-CSE-MsgGUID: CMuL5mrKTjec2u5p7mgJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51830381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 06:38:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 06:38:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 06:38:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 06:38:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jem0zo1mgM4KaxRgaiZfGgwZqrRC34hildYURCJxpo9RvknBYvDAjg9tCcebnnsTpOCmLGkdRUq2ngEyz426bZGiqG5YDnDI9DiEZSslYgwMdNaCjmCekPmo94VtngQCoUBrHLmi54Mx2qW7rYaLRRWqNmXiOMPjzHIJMVgdekKBhzPItbi2xrbiYpWbUGw7rSf5wYIDgP99XjT960ZFnOjAVUw9Zux//8FKDfoCMzDeLTsyCzaUkJa2LXcrjLcSf2khUvn/Nubfk7Bfrl7YR1Ib1Md68c12izLr1sBkNvQU43KUUb1KUcAW2h/Q9cUbwMDQR2aayp3q6bjlUOqdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XysgiRXfZ2oVfY1NlTLE1YiC17hZk8HwJWvhYurMuME=;
 b=Oo/w31Mkou7j23q04jcneA+Ldoi8l73fjehAgDAv8R085/czmx/LlSUe62iKR8oodK9FVy727r/K4V8PZDbYDxsZ+QcBXv+0Mis04SHtSEQSL3eyxyFiGOyAO1sfxayRfLU7J+DOvQkxZ+4LvUgF0PNmzP7H4CxF8ur+iTeOQNfhU5EdP8zJJUjLfgTf6YQBjlimDo+5TB06LH/r4OHa1zWHVBBp0YOUYHMbwoXk0IVDpUvkBTH1iCxQD900trBXms9fuZLt3ID43upFXXl7cVVHU1jbqXazde4Hj9J7GXWkuZpa0QR6bp1sWx47Ei2Yj6SKpTaaos3HTBYnZSpqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 13:38:33 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 13:38:32 +0000
Message-ID: <b379366c-27e0-4676-8003-b3c89e27274f@intel.com>
Date: Fri, 5 Jul 2024 15:38:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Johannes Berg <johannes@sipsolutions.net>, <netdev@vger.kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
 <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
 <b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net>
 <ba861ef2-eb28-41c8-b866-f3accc7adf0c@intel.com>
 <79f8905a-0eb7-4203-bdc7-fa77c25e79ea@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <79f8905a-0eb7-4203-bdc7-fa77c25e79ea@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: b052cf68-f6d9-4fbb-7f47-08dc9cf7c312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGJvV1ZRWlFweW1rNlNwTHRwSzJYZWxidG8rOXRwM0xWZFA1ZS81YXBwTGxy?=
 =?utf-8?B?UHZRbkw3OUxrUDlablNCNzV2U1pHZ1N2ZkNkc1ZLd3FFYWU0MjNXYXIwU3Bu?=
 =?utf-8?B?TUFUQlVqMU53WWxCdnY2MncvKzAvemFWNzBhNC8rbUNLdXdIK1NQZDkyaElG?=
 =?utf-8?B?U0VDQ0tHTmZDS1hpRUhwUDZTNURlYkVsOEhHZnZLbnZaM1dDNFRmbGI1K0JG?=
 =?utf-8?B?UGtPaUZOWVRqbVFlQ0U4anI2a2NLT21lcUF3Yms0VHA2NEpHR3ppclNvK1hM?=
 =?utf-8?B?SEl3RDdHNzJUVDdtbzYvK3Bwd3ZoRk1OTEZSSlNYMzJ4RUMrMlZqRVVYYUF3?=
 =?utf-8?B?MHJDek1pT2RjeFBYSlQxNXN2ek01NTdWNStJQ09UcWhJT09RZUl1VHdHUnNT?=
 =?utf-8?B?ekdtT1U1Z0tMOWwxTzBUZmFiaFdWUy9KeGZqaUdsSkFRSnBKejRUNUpCSTYv?=
 =?utf-8?B?Nk9IRkdxK1p4bm44bW9nTXNBWlhZMUR4K0lJM2pGRncrajZCUnNHbDR3aEVS?=
 =?utf-8?B?R2NmY1JVV3VOREdkRWJFVnZOWUFPVDkwK3A1TVdxY3QyempOWWxXcUpKTGtI?=
 =?utf-8?B?eElVUUtSaS9jYy9GeUZWTWtoWmx6MjZReUdxTjB3YW9Hdm4xYmtwVGwzRGpC?=
 =?utf-8?B?STA5VW9TTGtxSXZveTZ6UUs0dzNpSy9memZveExqNERwMjQ5eE5Ta2xHRExu?=
 =?utf-8?B?MlJRVWk0NDFMYmpSTFZTc0tqNTIxUTN1eU0yTGp6L0hlQ2tzQ3l4Qk9oWk93?=
 =?utf-8?B?YW9HWW05Zi9qRFBaVkpyWTdOWmNXYzZvZnR3clV5SFEvL1ZMc2Q3RTJ5YW1D?=
 =?utf-8?B?Ri9SbEhTaldOTnF2ZVFBd1d1WFNWL1RPY015WDNKTTBwZ1dKZWhKWjRVMGdT?=
 =?utf-8?B?VDhsaGZEeFluWU5EdnFzZjVBL3VIdStHN2l3V09zdmpFYXBDQk9LQUxYS1Yr?=
 =?utf-8?B?QUNzMUEwQ2NyMGJsVnQwRlZ6c3NndTMwRXQxdVQvUDhhYXlhK1BUd1I5WnpM?=
 =?utf-8?B?OVpKTlRvUXV5M3I2VXNsNFZ0c0Uyc3dwaDVYMVplQjZReThQVDIwRXhvT3di?=
 =?utf-8?B?WlUxTWpVRFl1elQrY3JEUGJQNEtIOWZmQ2JWMnhYSDdKSFRsZjRDek5nUFpp?=
 =?utf-8?B?enhtM2pKSGNXT3JmeUhwbE5qc2NHbGZ4bzB1V1NBSjRPckdLb3g5TVNjVFFT?=
 =?utf-8?B?L3hvaGprQ041WkFpcit5SlE2SlFFRmJ2cy9ZU2owMCszTDVTbUxUWFp4UUUz?=
 =?utf-8?B?TUhEYmtoV0FNOWJWa21EYVlMZ0laRHRHMW1kaTV0WkN0Nmt4ODI2MmxydWF0?=
 =?utf-8?B?dEJRZm5KaHZZTklHWFpnYUZSaW4ybTk0NjJoVFduSWVpdVpNQ0RvY3ArZnRN?=
 =?utf-8?B?blkwOHJnd3lpYUdmdENZaVJxUWk3WWk2dVRaSlY3RW1lVVFqbStFN3JsdUJY?=
 =?utf-8?B?cUJhVXVlbmRPVVRsVkRvU0d2dE9nU1Z3OEJaY0NnL0hIc0tBbzFWTlRjK1Vk?=
 =?utf-8?B?ZEJ6UHI1UHF2TzRobFE0V2p1aC83NEJOZGxuMzZNbHJrRXAvVXl5SWpXZlhn?=
 =?utf-8?B?MnBWZE05QUswMkNuOU9PZHhkazRSdXNDN296SWJIL2t4elIycTFqcENhR25Q?=
 =?utf-8?B?b2FxREFpRmxNMVpzYWNoaWZqcWYwVWt6dHZKTklQZ21KblhGMERMVmxMWWM5?=
 =?utf-8?B?eFE1WVpGWU1mZ1BVaGg4OXBjQjdxRG1wNDNqdmNWbVNvelNHOG1YeTNTaVN2?=
 =?utf-8?Q?MnAenPenBPNfipYcj8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQ3VDE3L1Vtc2ZhV21JWEZ6eXNGb04vamJXKys3ZE9xVVhsOXMwblpoVDBw?=
 =?utf-8?B?VHBhNUJxQVVGTEc1WWhCZ2tMWWg5M1RocWFlYmtURXZGeHhpcE1KSjJvbmRY?=
 =?utf-8?B?Q1Z1ZGVLUHlyWGRyckVvOU9STVJaUFNwY0M0ZTloSThQVnRFTERvOGczcG8y?=
 =?utf-8?B?STFNNXJJeWFObUJEWHIzTFY0UVJlSDFkdno5aDZoUC82TEFpU2tTWGFxNzQv?=
 =?utf-8?B?bWhYYkhadWVtSklmWENpNlljbjZ1REs5QXoxY09sTmJkZlhpdDZvMXllbnlk?=
 =?utf-8?B?MUxjUnMxQ1hiU2k5SkpUOXJwRWpaR0lDdHpNUlZyMThsUHdyZ09OdzZobzlk?=
 =?utf-8?B?bmdSRkh2OXlVeVViWGF3OEZaNnFIRE1oVU8rMXBDNnhrMUJ2NnBnaHR3MGRT?=
 =?utf-8?B?NE00SWVldUdYbzZUeEJvUVBQVmVLcnR0TThFNUJ3dHhjSXgxdkVNWEExY3ox?=
 =?utf-8?B?cWxLL2ZYMXpQVmg1dEZaRHhLSWQvRVB3TnVGcldudnYwMHgzbzVJVFE1dTRm?=
 =?utf-8?B?U3lOZk54emQxMnB0b05Kc0ZFYTJZelM1TGt3NThScUtUVHI4MjMzZitIVjEx?=
 =?utf-8?B?WFR6U1l5OVZXK0hLQmtZdElTODRncUVJTHdKOHdlYmtSaGV4QWh1dzdNNGdH?=
 =?utf-8?B?aDRkYzlzaVB6YzNvK3Q3eGpQQUpBaENzOE02TjJLKzFRYTRYQWNkYnRGUU1Q?=
 =?utf-8?B?RU1OcExHNGJmYzFIeWUySWRUVVJRMlpEamRMdkJ4WUJSc0xMSVZqN0lscG0w?=
 =?utf-8?B?MFUwWittcXg1aDVmb3YzbVlXejFvRmxxOWxSeTNScmp3VFRHV0FabG5weEFB?=
 =?utf-8?B?YnU0dVFpLy9VNElMdDk0NndGeWVqVWJlcVVwNGtjZ0NzYWR3RHpzaE1zeXl5?=
 =?utf-8?B?NWJySmN0ODFpTGNIMTZRcHdVMUVnWnBzdUlRRTlrR1NqSEhIUGkrSlNYRDBt?=
 =?utf-8?B?d3ZpQkxSM0VFNjZrVjdXTU5aMFMvbzBtYUo4YzNWckhhbDA4OGFxZjFLcVlj?=
 =?utf-8?B?dkM4aEorWUh6Zk9ZalZFK2pheVhnazRLdmd2ak9ReFpDQTRRekk4bkVOczdQ?=
 =?utf-8?B?SEN3ak1JcVEyb3oycy9LMXArN1Y5Q0JYYmtBakxDZjhwWG1HTFZIWGpyd3Bo?=
 =?utf-8?B?OHRPOWlpaUNjakgwRXZXejltTFBuNkZjdHVNRWNLcThNaGE0bmNVZmVTalpW?=
 =?utf-8?B?Z1ZZV3hHc21IdjcxWkpRR1RudU5DYWtPRUtVUE53akNQR1pGMFMvSjhzMXJq?=
 =?utf-8?B?TEdZSDMrMjZxK0p3c0pJNHNLRFc1RjRGNFM0Q0ZmQ0dCb0pwWkFDSjJwUnJw?=
 =?utf-8?B?a1VoSjZBbHVLejd2L1oySnVVT1NhUVpyeUFxMU1ITWlMcHJqZDhpbWZpcTRU?=
 =?utf-8?B?RkF4MTJOa0hLcHd0dDhhZHNzUTlDVUh5MlhtUTJzMUliQkNVU0l3SWpuelVu?=
 =?utf-8?B?RnRzcXluZFdKMW5yRkFFcmF5SU1OdHBMYVR0Q1hpZm15andVZ0NLZG1ObzFx?=
 =?utf-8?B?amJXdkd6QmxPMnpRaHF2RTdtU0FMbXVGUDlNSkpuc2xHbTdVWnpudzQvalBx?=
 =?utf-8?B?K2lNNmtpSEJMY2MxaTN3OER0bDZkZVhPeTNPb1h5dm1uTERsdWpKM253MUZv?=
 =?utf-8?B?azNKZU9mQUNuRG5FYUFZaWFRdDRkcEVRZnhtdndoWmdTSVlUSHBjVjNpZjls?=
 =?utf-8?B?WElpaSsyeEU1TnVsbkFZYXdSQmVQRDlhd2dSdXdnZlJpc2krajZuWFhXRE9C?=
 =?utf-8?B?SFBMN3RQWjVBaXZhL0QzZ3crSitISWxJbG9FTU5SbW9odzA0bWs4aTBya2d5?=
 =?utf-8?B?b1QrdVdWRVlaY05PWlA2UERIU2FvbmovZzkrR0JtbUdLaldVdHhoc0VTMTNM?=
 =?utf-8?B?YUNPZEJXRFlpZ3IzSnROOEhJbmR6cFYweDcwTjB6SEIrc09oTCtjaThsR1RZ?=
 =?utf-8?B?NUhUUFZQWUladGJOZ0pYQ2t4VTZicVYxTXlSRUlWK0tZVHdkUEtlempSQnFq?=
 =?utf-8?B?ZGpxWndzd1ByaVNlT1JwbXc5Tkd3K2R0aStJSHFLTzhaNEZmZWxuTkNRTG9R?=
 =?utf-8?B?TUlRaVZPMTUwd0VYdE1Oam1oZnF5QlZtTXJRSGx5UHZGVXVNbVNzT0kzem5B?=
 =?utf-8?B?WFJTK05ZOHBEN3E5cnUwdzM0ME9tRGp5d3RjMkNBK3dEM0xwdWtydkFIQkhN?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b052cf68-f6d9-4fbb-7f47-08dc9cf7c312
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:38:32.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q46O9OqbMqlQ352qwrqkOsW5C77lATckrXg9CeIV6wi02RMyS6SRA90pUrhki/q6tzOhlFSSJ6/UdzbpuBKHu2CZyK/8C5G55B07eBxoWGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com

On 7/5/24 15:28, Alexander Lobakin wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Date: Fri, 5 Jul 2024 15:14:53 +0200
> 
>> On 7/5/24 14:39, Johannes Berg wrote:
>>> On Fri, 2024-07-05 at 14:37 +0200, Alexander Lobakin wrote:
>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>> Date: Fri, 05 Jul 2024 14:33:31 +0200
>>>>
>>>>> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>>>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>>>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>>>>>
>>>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>>>
>>>>>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>>>>>> be intended, so fix that.
>>>>>>>
>>>>>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>>>>
>>>>>> "Fixes:" tag?
>>>>>
>>>>> There keep being discussions around this so I have no idea what's the
>>>>> guideline-du-jour ... It changes the code but it's not really an issue?
>>>>
>>>> Hmm, it's an incorrect usage of WARN_ON() (a string is passed instead of
>>>> a warning condition),
>>>
>>> Well, yes, but the intent was clearly to unconditionally trigger a
>>> warning with a message, and the only thing getting lost is the message;
>>> if you look up the warning in the code you still see it. But anyway, I
>>> don't care.
>>>
>>
>> for the record, [1] tells: to the -next
>>
>> [1]
>> https://lore.kernel.org/netdev/20240704072155.2ea340a9@kernel.org/T/#m919e75afc977fd250ec8c4fa37a2fb1e5baadd3f
> 
> But there you have "the exact same binary getting generated", while here
> you clearly have functional and binary changes :>

one could say that in this case the change to the binary is meaningless
--
I think that the most important rationale is that this code change would
require a -net level of testing, and in theory changed binary means
"some adjacent bug my now reveal", and for such changes we have -next.

The above even answers why "no binary changes" [1] above should be still
considered -next material: there could be some compiler version/flags
combo that would generate different binary, and we get back to the prev 
paragraph.

> 
> I'd even say it may confuse readers and make someone think that you
> should pass a string there, not a condition (weak argument, I know).
> 
>>
>>> The tag would be
>>>
>>> Fixes: 90de47f020db ("page_pool: fragment API support for 32-bit arch
>>> with 64-bit DMA")
>>>
>>> if anyone wants it :)
>>>
>>> johannes
> 
> Thanks,
> Olek


