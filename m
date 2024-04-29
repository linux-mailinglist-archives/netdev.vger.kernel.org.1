Return-Path: <netdev+bounces-92251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BFE8B63AE
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 22:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBAF2840D6
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36EB1607B7;
	Mon, 29 Apr 2024 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F65CJT/L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C36160797
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422682; cv=fail; b=ujfNKtNNElK19MY97mCkQhzAXr2NBdF4qA0+cUtJjbrJzaSAWumE3o4+8BuEA2i/GPiqRKTbQYzYLvxjvrcoAgeM4pGW+l9BS4kEX8lG/QRPwZqo0IcIlDylnyxJqz+ezCnHgmSbsax4VoOkspYxRAOmPeGrQlUP67+8EEb+M6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422682; c=relaxed/simple;
	bh=hfJx3mUa3mcc0nvXxDlk0AawfK08OkDMiXp1tazTMPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L2f/X4QCLj0GmmyG77zUZarcwG0XVy268KzSkkr6NhhyfLGX4fN6yNuXAOFurWkScv4qe7+hzzuuMip2Ma4MIyNuOBGWJo3gFK4F+hOuvkGGAHcGfDdFDy6d/m1VpDjqB9Gf0I26STHbvS5Ehoxn4JWb+CHJ+dfGjK+B20ygKYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F65CJT/L; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714422681; x=1745958681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hfJx3mUa3mcc0nvXxDlk0AawfK08OkDMiXp1tazTMPg=;
  b=F65CJT/L1rWqP3iuYbjr0nncHDjxz2DQNB7zSIPpL/HKCyta1FCksHNY
   1xGZZWHFs+XS1zU5m19iwEWPeYR9MJgYNImjE8FucMw+ANLdbntOul77W
   r4NPvRrjVkXV/LQ+b2TVavgUMR6/0xNEiAsv43+A0vsBaJgyb+RYga2d8
   4cDQUaT5B1cquERoPKv0N9mFn3RU7FUpX18I5SoNMLPsqmmYUMgLaFzAf
   hhnx15KLBUXh0DAhssnSs/2Xyg0t6SbalsSIi30V0uU+xm41JYq8C9/qR
   2m+AlWBhvTsoIX3r3mjEJAmcoCXG9PcfY1FFbR5dBcOIQokVrDHIZpKhr
   w==;
X-CSE-ConnectionGUID: ppBuRJSTQbuDXg1jyTDeCQ==
X-CSE-MsgGUID: gTNrPoO2TJqjj++30Je4oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="13882918"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="13882918"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 13:31:21 -0700
X-CSE-ConnectionGUID: t7Dh+OFcSNKcGLtTaPHCyw==
X-CSE-MsgGUID: TJK/CnJnSiKADM3x5Gttlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="31049004"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Apr 2024 13:31:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 13:31:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 13:31:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Apr 2024 13:31:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 13:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7VYGisejfMsRTkUi4COAgFtvZJfKfEuuHf8TLy7lXhM1gXqMNyim+iJOilYii3O1Dqjbwf8Ju1+SCHqiKMVgqdrNF2M8ejH+NygDeNGXzEJFgye2kuq74bzO/edJwzk4ezoHVD41BWoLwQ40bwYXuvhEifI37w8Coo7nbJAmhUOOeN3ziT8AqRU4Pf9vvjrB+uQvjRuJBsCjeGsp1tw9SblriIXnzAB+lLovY2jI70uwkZEY0RO1Yv7Nl8IvbxClk+mPicpA2I1PUp90qsRNZoII+sBtH2UwKcrRsaIKpvCMhG6CkyRWJQckksQZEGiorFUyiOBUJqTP+A3/rLeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SILBc5QFXkZs3hMKXpPdVGfSgSCHMETJ5pYpdE7WpDA=;
 b=VaDHeDQ45MnpyZNNZP5kEl/qcE1nx4OoZuEuHJEE3JepPfId4U7jftajKDMvxxqPN4QY25N9aejZD72nmtp/ZP0sa6YYuEuu5HGHoDoOh1/PA1NnJ4lbSbq4/u0UbSLud+hitcoYQBb7jng42X8MqWBaOMXPWt6xWWPV/7UxHicx2/YS9p2VDDSx9Ul65P5Atc/BniLb0fBwgR0k9E6dYhtEzibqEF+7uElkutolhO9HHQmzJ3Lv8clsj0cUrCn6gP6iVTNkFWOtsRI7H6NUoQwumV39TBXxMmDI1dvrHw7CU6aRNvh9WC7mjl/+A13dvGv6DLO4cETng9p51/wicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Mon, 29 Apr
 2024 20:31:16 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 20:31:16 +0000
Message-ID: <fc923f03-e3c4-da59-4f43-c1d585bef687@intel.com>
Date: Mon, 29 Apr 2024 13:31:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] net/i40e: Fix repeated EEH reports in MSI domain
Content-Language: en-US
To: Thinh Tran <thinhtr@linux.ibm.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: <jesse.brandeburg@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, Robert Thomas <rob.thomas@ibm.com>
References: <20240423033459.375-1-thinhtr@linux.ibm.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240423033459.375-1-thinhtr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 320a4f74-2b63-4b71-a46d-08dc688b51c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZEdpZW9oQWQyb3FtUGhYQlJxdmc2YzRkU05aK05sODhLa1NhYXZEOUxsemhP?=
 =?utf-8?B?ZGZxUnFFbk1vcm1yT2tuR1BoWmdTNjFVSysyZzdwbFh0blhkK0x4L2pJVTVu?=
 =?utf-8?B?NjVvSEZTTjQ3RXZTUEdwR0M3enpXVnN2OVN5dCtRaEo0ZmxxTFZ6SnNhUktK?=
 =?utf-8?B?czZIZm5pbUMxSFFRNFpEb2VpRE1VQWRCQVlGODlkS0hpVjVFd0dQanlIMVJT?=
 =?utf-8?B?Z0h3QWRyenpMa1FzZ2JNZGtWNTRTejdTV255dEI2RmJ0amw1WWorM2FrSlJ6?=
 =?utf-8?B?d0x1TDlsOXNEN2k0c00ydnowU3hrY1N6Wmo2UndVZnVZQVArVlJTMHFhMlFw?=
 =?utf-8?B?SHUrNEZ5Q2hHbmJMWmVpQ3QxUW9sU0NnblRsUDhKTXgxRmhvcmZPTmZWei9Q?=
 =?utf-8?B?MU5RVHVjdk1UY1VDNk5kSG9qUDE2eTN3TGxUSDQ4enJLbmJKUGpGcER5Z0lC?=
 =?utf-8?B?OWp5bnNGTFVDUHN1V3NoSkhuaXlNU0thbjdJUWl0ZHdLSUdrTEpqQTY0RTcw?=
 =?utf-8?B?cTRyUWpFUnFyQkpGVjdDQkNPSnBpQ1VUcEZJNHdENGpOenNHRDlSUy9QNDRo?=
 =?utf-8?B?bWZ4RFJLS2Z5cEdsUUZETG1odmFUYVNId0RLc2t6Vy95Sm1PQlAvb1d5SUxO?=
 =?utf-8?B?dVJ2U3M5azV2S1JQZkx0VXYzRXlmb3hodVg5c1pSZ3B6aEtZbjhZcTgyVVdH?=
 =?utf-8?B?NEdtNUNISS9MQ29rOTlLR25nYlludHNpK21JMjA1M0NENUxwUEtXWGVJekNt?=
 =?utf-8?B?SmY2UEJUMTVmQVN4T3d0YUpXaFRPeERhWWRiZENYWllhTHZTZ3BaMHpESUFN?=
 =?utf-8?B?dmk1YndKZUIvblpYTXJod1ArQ1NMSUlsaDRaRVI0Z3puT1ZaR2hRV0xyUW44?=
 =?utf-8?B?ZktENXJJVUU1QUFQbk1yZVFkVzlDNVl5N0dGRHB6MFNGb3B0SWdPYVNidG1S?=
 =?utf-8?B?d3JVY25KZWpYZklWamlLZlNpKzlMcVF1ZG5NY2RnQTNicXUzTUNYYXlURXVL?=
 =?utf-8?B?WFYzT1MrREdJS1h4TnZWTE1ZeWN2TkVGWGRRMzl1Z0ljSk1kSUxIOUQ5L01C?=
 =?utf-8?B?ZmU5SVJLTEU4UnViWVRub1J2ZXNseXp2V0F0K29sdjJhYUZMaUQwb09oeEhy?=
 =?utf-8?B?RmJhK3BBa3dKcmwzUHpnTDNQYUxWdm01dEU4Vko0eFBrSUpRT25wRmltUVBL?=
 =?utf-8?B?dUtxVVg4QjNNZzNVOWhDRTZ1MEZBL0dqeTlYSm45YU1jMkNvU0htYkVZT1ov?=
 =?utf-8?B?STVJdDV2TVdhLzk2YjNwaGJESkFXTGw5SCtEN241cVd0ekVwYkNPTGlJNE9T?=
 =?utf-8?B?YmxsSG1zRkFHTFpzanBHbzgzdjB5a2c2R1dxSjBzczdLZGx4a2FCTi9JL0dS?=
 =?utf-8?B?dVN6WXZ0YVc1R2NYMlJwc1B0TUFXVEhHeGtSWjBhcE5sSEtTTmlxR2VQRm9O?=
 =?utf-8?B?alkzbWk3cUtKYmd0OWdtZ2Q2bDBjeE1OOWRtRXo5ZWx1YXE3enZYZzlMMXpF?=
 =?utf-8?B?RU1rWnVxTDRLV3hmakNFNWhmbEZqa25VWnFmd2Z6RUR5RE82S2FpdncweHJM?=
 =?utf-8?B?bXBzWXFoeTN5cC82RFNYVFgwRHAwU3FmRHMzdTNkRHBSYWt0R3ZrS21sTTVq?=
 =?utf-8?B?a3JVZTJrSkxMM0xVQXYxRzh3eTdVd1dvc0kxYWhmeGlKTG0xc2hibWF1NU1J?=
 =?utf-8?B?UEoxYm1YWGlRZlJ5NHRjVlNpNm1rWFYyKy9kRjUvcUhlcE9BMndUSHVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhtbS8vRzFndHpZdEdRODR0ODRyd1NycnZSVnpVakcrdnJzZWFRcmZrZVo4?=
 =?utf-8?B?RVEzNDRXdzVZM0RIOGFGYmErWnkySTZ1MmtXS05XMFpqTllYM3ZEL3FoQ1pJ?=
 =?utf-8?B?bHEwYSs4YjNYNUxxbk1lNkE3ZUFUQ2M5MmFGS0p6Q21zRi9qZFZBMWVzMVdV?=
 =?utf-8?B?a2Q4Nkh3SGRIT0padVB6YTBGTzFwZC9RNmRTTGcxbUw3SCtVenhtbkU4RlNV?=
 =?utf-8?B?Y3ZWQ1RhS21RaDl5NmVaM2FlZ2NSWGFYRHppeWJjM3lidnFqa0VzVDg5V1Np?=
 =?utf-8?B?YzlxL0ZOaGxoNWZGNEhGcDNqbnJOYlYxdmVYbFNYMG10eWwwcU0yNDg4L2dY?=
 =?utf-8?B?RXQzcGxTcXBWZ3RJRDR2Z2ZnZTdhZmdod1E4QnB6a3B3WjhpYnhVcmhTOWZw?=
 =?utf-8?B?UmRtbWwrTFRvY2VBTUlHNGdZZVRoZmU5KzVSc3Q0cDlvMTl3WWZpbGFaNTE2?=
 =?utf-8?B?bDZpbmkvaDRVVm0wOEpEdXIrWGxaVXU2SFhDK0NNQzVocVNNNzRHeFp6OU1k?=
 =?utf-8?B?dVJNNFBocC9kK0dOd2NxcG9maW1WUzFoUzFrUkVOa2lTb3Z4WkJ0bXFEOS9G?=
 =?utf-8?B?MTRSUjNFYXBEdmlQcXBSUnBqMG9lUFhNV3VoY3QrWGF4YWJnWXJ0eWplVzAv?=
 =?utf-8?B?UU51L2ZNQzhKU1h4dWFjOTF2T2sxVXZKbWN4dzBnRmJUKzlOMlFUbk9JNitt?=
 =?utf-8?B?anozZ3liSVhBeVpETmRtOUVvdHRJTGZ3RXppNm9FV0NSVmMrU0JmNFR0YjVJ?=
 =?utf-8?B?T0poalU0bHUzWGxkSmZrc0NoSXc1VHRDN0hpbEMwd3NRSWhtOUlpVHJWZkpM?=
 =?utf-8?B?UlhWalJHOUJGYVI0b1dzbzlvaVJTNUNVdFZzMmR4TUNtK0J2dkFzMWhlSW1w?=
 =?utf-8?B?Qkw1Yyt3aHI5dmxTY3ZuM2NpOTlwS0VxVjVtNVBiRnJoQ0Rtckd3VUtPeU11?=
 =?utf-8?B?eTNWb0owNVo1RTNoMm83VDh5cVZHZU5lSDVuTHRZVWlyc04rcFJWblVmVEha?=
 =?utf-8?B?RG9VejZpRGVVbnV1c0FrVHdMcXJOY3NVaUJ5MnY3OWNsMUVQb0J2dlV1WDhz?=
 =?utf-8?B?VU9od2J4NWloU3IyYTBhZTVtSHNUK1ZZZGFCTkFZTndhVkR3NThWT3JwL2ox?=
 =?utf-8?B?alRjNndNNG42ODZZdm9CU0ZNc2FPMXl4aHdURGZxNVhYK2tLUVFTa3Fxd0h5?=
 =?utf-8?B?QXlKQkNEUys2VFp1WjhacG8wZlRsMmVnVGw1cm0rMnJBbEVRZDYyZ2V5Nm9S?=
 =?utf-8?B?RUd4djJLWEE2K1B2U0tzdWpLbnNKck9VYmhNaVVlNkJVajY2TEVUby9ldGpR?=
 =?utf-8?B?L3B6N2lYVlVwSGVIeUhmL2ExZXhHeGNsVjc0UTZ1MDNiME9OTVBVSjhQWjlK?=
 =?utf-8?B?cFVabFkyVWN4NGFYRDlMWUZnajJPakhlaFdkL1FOb1c1cGlBY3I1am5leHIw?=
 =?utf-8?B?ZWIyQ3RqVFpJd1U1MmlocGtFWklaazNrRVBSenZrMnRKcmJRTDZNcWRSUXZk?=
 =?utf-8?B?cm82bTcxZEpYSmo5Vi9UZGRKakJWVUlGTFdzNHpJSHd6TjVhT0Y3bEZvQlFh?=
 =?utf-8?B?MVg3THhkSXRyT2JSd0o4Y3dVV0t0Y21BSjdha08vbWhyKy9acnRabjdyWkpW?=
 =?utf-8?B?ZkdUMzY2S3hHbnhIcWJZUkwxdFZGdmZtZEphcDlnRXlFUUx3Vlp6WmtZNXda?=
 =?utf-8?B?UVBZSXJZaG9qZWtIZDRVZE5DNjI1ZGFjTTdRenJFQlUwMXowS3dqVkJ6MHI0?=
 =?utf-8?B?VnhoSG9EMzBYa2xTUWVFQUY1Y3JnNjFWRDBLZCtkdVlwL3ljVWlDL25sdHl6?=
 =?utf-8?B?UnV2Sno3eVd3b01tdExyYnlQeTdhV3dNRmkzdDdmS3ZRT0toRDhlaEFGVURO?=
 =?utf-8?B?U0hRNnZLOG5QZnhJeVBFZGhVK3FLanRPT3l4QVlneEFqTm9UQWZwNWQ4Q2Mz?=
 =?utf-8?B?MEdOQkVMRkZPYVcrTGl6NldzdnhWRVA4UXlvR1BIU3NaenlQQkpSSS9ucXRG?=
 =?utf-8?B?STJPd0MydnlNdVV0cHdZS2xqbWZUeEh2cXI4V2hHTG1oRXVrN1YvU0FYRHVm?=
 =?utf-8?B?ZllFRzZWR01qU3BWOXBVVXV1WElETmJTWEdMWTZpN3VYWlpodTg0VFZQdnZz?=
 =?utf-8?B?UXU5dVp6M2VJcmRTNFhrT0tEQWJjQTN3QlRUV1V6MnV0elZCM2hhdUlSdGY1?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 320a4f74-2b63-4b71-a46d-08dc688b51c9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 20:31:16.3735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qeb12DhAljy0lkuBpQrePxx9ZdQI9MiutHsbt2DeQgpWr6appZecOIR6EtMRUfX62SDiB2+lQ8QAiicf5ZIx3DAcEyn25WYtI/Lmsc2VVww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com

+ Alex

On 4/22/2024 8:34 PM, Thinh Tran wrote:
> The patch fixes an issue when repeated EEH reports with a single error
> on the bus of Intel X710 4-port 10G Base-T adapter, in the MSI domain
> causing the devices to be permanently disabled.  It fully resets and
> restart the devices when handling the PCI EEH error.
> 
> Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
> introduced.  These functions were refactor from the existing
> i40e_suspend() and i40e_resume() respectively.  This refactoring was
> done due to concerns about the logic of the I40E_SUSPENSED state, which
> caused the device not able to recover.  The functios are now used in the
> EEH handling for device suspend/resume callbacks.
> 
> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>    with i40e_io_suspend(). The chance is to fully suspend all I/O
>    operations
> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>    with pci_enable_device(). This change enables both I/O and memory of
>    the device.
> 
> - In the PCI error resume callback, replace i40e_handle_reset_warning()
>    with i40e_io_resume(). This change allows the system to resume I/O
>    operations
> 
> 

You don't mark a target tree, I believe you're sending this as a bug 
fix? If so, can you mark it with '[Patch iwl-net]' and provide a Fixes: 
tag.

Thanks,
Tony

> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>
> Tested-by: Robert Thomas <rob.thomas@ibm.com>

