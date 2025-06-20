Return-Path: <netdev+bounces-199796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E00AE1D0C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89F34A6373
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125328DF2D;
	Fri, 20 Jun 2025 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QDYWmsOp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA028DF13;
	Fri, 20 Jun 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750428625; cv=fail; b=OolQG57kJYtLuJ3OuwAjY8HjAKnGIiLHTrSZkEytInPVWc3KxxWQv/I7f0KTzCyLBRKpBUzaa/rY3I+1u1FFwV5GoNydxD06WGCHZi5gBw0BH1EevSinZjlviGXNXV2A/HZKKsJweNq1twBwhrP9QxYfu/TBxkXC5Vs4SieqPhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750428625; c=relaxed/simple;
	bh=oh/v2w4/zhPWXP4EzB7gL1be/QqJRqTBvUAfFOaWAUc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LNuo49SWkZG/viqt6g4gpaVn5H+tkxoYjF+WPCSZtCXdy/6Mn1xr3TU4PH3Bbg6Tw5uWoxZB/q3Pgpnky9f1K/Nx50S01DUsD9x2ap1KY0RXAbCGsWbwEFplrrAvb2zbB0cBbOKt48SDxdkENoylTwNc/ZFAUbL/Lg+YFca6A5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QDYWmsOp; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750428624; x=1781964624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oh/v2w4/zhPWXP4EzB7gL1be/QqJRqTBvUAfFOaWAUc=;
  b=QDYWmsOp/ipDqnoNWJjnEewQ6li0C8XcHVgXV4q163gpgzCWPxYcl+yk
   poZ8sH0z9wHFd2H44ifDtDRkmHInF/0pxlVxh1BDYmTk9UMjjHjctJig8
   EZo/0sn4ZMZtisxwgrRUqqs3PJZFZA36Ha4QzJ/g/o+bkwIF9TFdEk1fX
   kzfkiPNICZ7q+XCfQnOOhbDvHUmNoj/4haiQ2rnicUNNVkHK5ecY1RNzN
   B9Vu8UCmCO4gpJ31gBW0Sa+52fw5QUetOl/JC74zDdA4+xPKSY6xpMTqr
   injIVTronO0Vdhh/NiteJ8UEHqQzKdRKV0K2kuJCdq/Gel7mHOlaQr6W5
   g==;
X-CSE-ConnectionGUID: sra0lAeESuyEzD0JlquQag==
X-CSE-MsgGUID: 5Xszxm5wRTiFHqhvK1FixQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52773893"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52773893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 07:10:17 -0700
X-CSE-ConnectionGUID: go/KyU21QwulZwiiLyZ8Hw==
X-CSE-MsgGUID: BwVXHC7YTdGL8/fIX9XIHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151452444"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 07:10:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 07:10:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 07:10:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 07:10:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2sxG3zXt13OXlwPmEd3FLLD5jaoTvbudO/AZ83MmNnsCJzLOzupsb+HpWnA8Xsjl6YtffLRnUhHojRr1EevHLUvDwflbDmET4aFl5wxCa4CkZ/xeU/Jv69/vRLEzbz16X5uSqPpkkhULUBDrLUF4UWV0QiI5YFQh08fgSSS8fomTd5TuaHxNJDCGm7RKJISKhJQkkEBWWM/ftvqKFIHV+EXxqW3Ow9YCoDqL1DJtV9yUH1GI/UjyZPKw4u8ANCMHX7CjfCgAt/tz74PjpTlsg0FzV8yVeh9xePz3AQrZnb1AMTD/tnYSXyL3NmRXnR1GOKGsB/v4TRJa+TrPxbkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQIJrx5atcLjiUSbN4PrZGRUzzJ+kaBORMOiVEZvAhQ=;
 b=AMQ96OiliAes08y1RdhfKICZ9DiEiWXRbMZbRTRfdxanerjj+uBi1oDTpuZ4Hn1M5GY/ogQ/CFGSGU5hAU665GazHM0D1ig44VO1qC8lDmIoQsYtbifSXzBO3nNsefD9fAZYvhCMDGLmLf7nyFE7MWxaTZHCvYFVGh025lblo1ToTvPl5RN6U6YIkdd5Het+J4ERxphchgAoyczOvr8eVKJEK5ffPb2qOm7QzsJg/s1IW0epMsiZKdcTVzLRzYAFPx8+fOvQt+vZ0LVepfoC/HV5pZoiklXHmtRs6Np94PHkxhzEGA+qHvbf7AJqfoouwA4cXAfrUY37aWEG/I+l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 14:09:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 14:09:40 +0000
Message-ID: <c898e879-26e6-4701-9baa-f9d2444e3137@intel.com>
Date: Fri, 20 Jun 2025 16:09:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: qed: reduce stack usage for TLV processing
To: Arnd Bergmann <arnd@kernel.org>
CC: Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Nathan
 Chancellor" <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20250620130958.2581128-1-arnd@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250620130958.2581128-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0317.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::27) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ecda2f-8275-4efc-3e74-08ddb004188f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wnh4QkVCMVNlWHJYWm5LYjY3d1NhdzJzNWhFb2o1K3YwVmlidlJKeDlQVFhP?=
 =?utf-8?B?aThpdU5TVWY4K25WbzY4b2ExTDkveXpzMnhZVFc5NGNyTXc5dHNTSkE1U1dn?=
 =?utf-8?B?cGtEUlZYM0s0SDhDVTZkWjE3N0Y1M3NrM1ZjSWt3Q0lteEFDZXVmdGxBMFhJ?=
 =?utf-8?B?Vng2eFY1a3FjUHc3dlJDWkRwQm9NaTQ2SGlncE5VaGJRQUJwOURsY2tSUDUv?=
 =?utf-8?B?SVRhSFhIb1RBeHhOZDRrcFF5M1JTZTdBQUhBTEx1MUY3a0lCQlczdytqRzBI?=
 =?utf-8?B?RHUzNGZTeDJKbGQxOFJMYzFIdmNhVVFoT3pkN1RHNzE0c3BZRTNUSUcyQ1VH?=
 =?utf-8?B?Y1BFVDRVdUJ5T3pnVmkrb2NVZ0RNSTY0R2ZiVTl6bS9uZTliODA4L2NhMzZL?=
 =?utf-8?B?dGlMaCtKbWxXeFVvVkU2R2NFaHl2Y3h2VzhaeldhTlY0SVptZ0pQc0tKL0kv?=
 =?utf-8?B?MVVTWjNnY055eWhiN2FqODNmSzJJb08vN2JRd1FaR1pnU1VJTjlRSlpuRHBu?=
 =?utf-8?B?a09vdHprMTNSOEIxcVYvS2VGbW1Ga1lKMWx5R3RIbzR5VkU2VStyTzJodEtZ?=
 =?utf-8?B?a2ozc0k5c0RqbHFGajE5d3o5d28wWEFuZ0Z4alRHUGxycU9nYTJoSnlCZzNs?=
 =?utf-8?B?elhmV0Y0aDRDN0YrY3dTRHYxdWx0bnl2U3pqWGlBMUdJa3V6U1ZocmRYUEpa?=
 =?utf-8?B?Yk9GeEVLc1lLT1crb3czNmZBb1grNGwxZThOWkMxMElOSFZSWkpBd053bEpi?=
 =?utf-8?B?bnIvanZjUXJTZGFFUDdRQ2VoaHFCYTJnMG1zQlpnZjZ2RXJ6S3NmUnozcWlD?=
 =?utf-8?B?eGFhcnc0eVpySkd5d0VqOGNsazEyQitORUdwdHhsSHJSdjcwNHBlVDkxcXVD?=
 =?utf-8?B?cGR3RUZZVVJhU0U4c0RMeXNEaWd3azJkV0tnQjlia0ZXM2VhNGM1TFdGZ0J4?=
 =?utf-8?B?c21xMjllMEtSWndaSGh1aTIzZnBNRS92VVRtTU13ZFFEVUpnRjhGOERleWxB?=
 =?utf-8?B?eUt2K3F1K2dRUEF4SGdBdHNlajJERzBoZjg3UGhOOTloOEtDWWZZTlJrU0E5?=
 =?utf-8?B?aVFkRWRYZjA3bi9QSCsvYmlwa1dUQ1h5ZCtQNU1DYkFwdmZxQlNQOEFoeEl0?=
 =?utf-8?B?dUIzMkpYKzZJaDBwVHZTdU53L0dPL2ZQRUs5OEFNUXFqZlZBM2FVTTlzSG9y?=
 =?utf-8?B?QzVBeE1paHJTQnVGbm5ETi9YUUtxSWVmcW85Mi9DSEtQVVV5QVJOTW9VUm9r?=
 =?utf-8?B?ZVVhcGloY0o1SkhjSG1aZmxvQVhnait6dEhsN2puV2srVEczUUd1b0I2dXll?=
 =?utf-8?B?RzgzczkxWDFDWVllblh1bldTcS9TUkJIZldsd0s5NVFuUkx5Wk9CdmxRajh1?=
 =?utf-8?B?Q05zNnRuWWVVd0FVWWFXd1VUeWgzZnVMZVVtSlhIaGVEWktnL2lRTGZhanlK?=
 =?utf-8?B?ZFdMYmN1QWIrV0JpL2ZiTmN2eW53VVV5YkNsU3drVkpiQk5GaHU2eEdObUhX?=
 =?utf-8?B?NDI4Sm4zRkhhc3ZlYkZabUJSZmhLcDRkOU5wbGtqMUNtQWd2TUtyaDFlZ3hw?=
 =?utf-8?B?UmRnZWd5VkZocUtXUDJkU3IvTUhxTHlYdU5POUZ3dzFYVXpkdGRnc2FxbTRE?=
 =?utf-8?B?OFVnRU8rM0JvL3BMRzhHbDB3SkRLVWZTSXdabVc0OFZTQmxFMElzT044VlFr?=
 =?utf-8?B?OGs5d2tUU1dNTUxtUGVvTGZTZlQzb2g5ekxteURmWVZOU0VoVmhhR25tZkw5?=
 =?utf-8?B?eURSVmhvNnVITlJFbmlFK2Znek1FUExLUWNjbXB0bVcybjA0L1hENHVHTmxQ?=
 =?utf-8?B?eGZ0WEZVY2N2YlZFK2hGQkdNeVB6dW11emFVN29wUDZBcDM4Mmw3b2lEYWN6?=
 =?utf-8?B?b09XWFQ2ZUIyUnNQVUhEbytpTGdPVTB4Y3lDMkpUL3NJcFRhS1dQUzQvSTFF?=
 =?utf-8?Q?dsp0NKYT224=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBLZlRHYjVsZVlHRGNWUTFYU1RZaHZrQkZTSWQxZmRnYnJSZDR5QWJKcFhM?=
 =?utf-8?B?VDFobFFKUTNpU245OHUyU0xrdjV1NURlZCsxRE5VWnlubXVwbEQvaDcwUEcv?=
 =?utf-8?B?SW5DcmdGZ1ViQ0tlUHJJWWVRZ3pZTVRSME82c2pCQ0s3S0xZdmVYazZMZysr?=
 =?utf-8?B?M3VPNHVWK1k2ZGNhK29iUEhTVTFKRDF2SGl1V1RvZHAzaUVUTXEwS054dzJD?=
 =?utf-8?B?cnlSWHd6aUVJYWZMZzBBOHNOMEVQaVlwdmY1Yk9uVnhtRU55Qk8zWXBwMjBl?=
 =?utf-8?B?a0ppT2pZaXF0NXI2SlN0WTdMM3QrTU92UTNoRUlrK0l4bitTMW4rQmhOOWF4?=
 =?utf-8?B?eXBhTHRrSndhd2ZVUUVObU1iRHo3S0hESUEycFdmSk9XSHZoVW50SW9LVjFZ?=
 =?utf-8?B?ZUFwUCtQMzh0eXFZSzhSL3djcjlLb1VWVjhCQnVSejhwTjVpYWV2RHlTUXZ0?=
 =?utf-8?B?TEFidlAxLy82SWY3VUsvZWZWQkxkcHpjMS9oNllPTGg0RjFMeWhhZWM3R2lX?=
 =?utf-8?B?ZWlLOXkzYmZ4VExDaE41cEw0RnVhemJzMXBvWmw5b2U2N3lsNVNuSUlJK1Nu?=
 =?utf-8?B?WU4xUWRER3Z0SWZPanNmakNaWGJjRmxyTEV2eDBRMUQzN1NrN0ZJZXpPRVpS?=
 =?utf-8?B?bk1iU0NVUmRnMjdML1ZKNmV1d2w2cW83VXdYWlpKT3FNT2ozRGJBazQ2V3ox?=
 =?utf-8?B?V2QxU0QxRUU1cXZINFIvR0tadVNuNHBwbm91bXA3Ykp4VHdqYzR6cUJpbEVp?=
 =?utf-8?B?dTZBblk0ZXlXcFlxOTlySUZhUU15WG5ra2N0V2lkUCtQOWtWNXhHRmw5TXlw?=
 =?utf-8?B?MzRBRlppS0FQZHFJU1R2bkZZdHMwNGhXUmZCM3c3WStyUlJGcDg1RGVacmhL?=
 =?utf-8?B?bU1CczAwc0RmeVdrSU5xZmtMMk5DWGtwOEJPS0ZBSU5qZzRFQnFLYTFGTmpq?=
 =?utf-8?B?bU5tZHdMOVZ1bGtFbFY5ditVUHEraXJqck03bkhJblNlRFZtMjg5TkxOWmNr?=
 =?utf-8?B?L1d6MGxwaExmbkJVMkhyTlVFWlVqV2ErenMxM1dBZU8ybHQ2bkc1N3hTdk5T?=
 =?utf-8?B?Zllkd0RUNVRkVDZHbGFMVnZiV1NURUJYN21ZVlU3dk1SUUtlb0VKSmdjMEpq?=
 =?utf-8?B?OW5kTUxSUzZocUhjb25zOUJpOERscy9RV3VkWHYzODlqZ3ZrcVpTNUw4N3Fa?=
 =?utf-8?B?alNiWkt1MHljeE1IcVY0Vm5Tb0x3R3NDUW1NQjNDb1BDbFAwQ2xjSm9IdHpU?=
 =?utf-8?B?MTdzNzJLQy8zZExnOGNCR1JTNWJPTXZJTzZ5b0NhZmZha2hzUGhaVVJURlEv?=
 =?utf-8?B?dC9ubUVjTHZlZzhMQlg0WVg3clpPa1VNTFM5cHNFVTZ6TEFvZUtaeWxiZ05B?=
 =?utf-8?B?bXNZaDBFSGJXVkxaNzBoM1BOTTFKS0pBWE5Bd1lDRzJPd2N3MjlTa0thU0Z3?=
 =?utf-8?B?dFVvcXZXaFNxa2NMTmFhMHF0TFFMajdheW9xaG56K1M2ajJPNVBrSGF2eEM2?=
 =?utf-8?B?RXJQcDZHd3IvQTJjQUMyK0E0UjdZU3FZVDhQdGNNYzVrUllVR0c3YVZTU0hz?=
 =?utf-8?B?Ym40WXUyc01JajlaVWlkMVRLdHJGREpoT2lHbTRqV3BnS0pzT1ZJcC8zN1k4?=
 =?utf-8?B?aXYxZElWK0ZoMVJOVUdwVUR3ZktKaEVnd25OQzRBT2h0WmYwU2IyVnlYdXRm?=
 =?utf-8?B?YTh0eERHeHhIaDNMSGdVbk1GMmt6SVBhb0RsbDRwYldiQ1FCWmhyb0FDWFBj?=
 =?utf-8?B?TWgyUVpieFRubENYVjkzRGlONndwMGwyZWRQcndZeDY0ZnVzSTMvcTNYQms5?=
 =?utf-8?B?bndyQUduZ05RcEthNFF3UU5NanViWGx3TnVBZmJreHh6MjU3emZ0LzB5MTZS?=
 =?utf-8?B?NFpSZnR0T01tOWJ0K0RiaDh6WXowT0JBak16YmI0TkIweExCaUhJcHVtZVlO?=
 =?utf-8?B?NVIwTVRLSHNKcjh6WTl5UThheGdtcDI3c1pvSGtJUnBKdFVYTllzcHFrTHAw?=
 =?utf-8?B?S0luaFplK0RWK2JKMWMwR2FEVEUwMXhqdlRDS1F1TnVyTUZyS29MNmFCQVRK?=
 =?utf-8?B?MGRjZks0WXEzYjJUM21JR3UrcmJ5b0ZOUnZZU3k5dkFmd1BOY1A1cnNwK04r?=
 =?utf-8?B?VlM2anhnMXplVFljUCtCZVRzbEdLa213MDM0MDBla01lM0ZTS0kwV0FDOHRY?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ecda2f-8275-4efc-3e74-08ddb004188f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:09:40.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9llvzMm9rEr0Btbx89j3LIqaqeE+w/VyHmGWtJV5L1fxzpMZ2zc3oniNyqXTIIZlNlMl/nPNEqv+chIM/8l51HC/z1T4yHggydpZ17aLmjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
X-OriginatorOrg: intel.com

From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 20 Jun 2025 15:09:53 +0200

> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang gets a bit confused by the code in the qed_mfw_process_tlv_req and
> ends up spilling registers to the stack hundreds of times. When sanitizers
> are enabled, this can end up blowing the stack warning limit:
> 
> drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c:1244:5: error: stack frame size (1824) exceeds limit (1280) in 'qed_mfw_process_tlv_req' [-Werror,-Wframe-larger-than]
> 
> Apparently the problem is the complexity of qed_mfw_update_tlvs()
> after inlining, and marking the four main branches of that function
> as noinline_for_stack makes this problem completely go away, the stack
> usage goes down to 100 bytes.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

