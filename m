Return-Path: <netdev+bounces-148625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF79E2A1D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC871657B9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D841FBEA5;
	Tue,  3 Dec 2024 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9uGU+bP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B941DD0FF
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248665; cv=fail; b=OrwdS2Y3N5rF0wmpYF2pNlbel8OegYztK+/0/v7prKVeEZrq+lnjUsPTlA6P6xu0teyL7+u6vxg4xIswZDGgRzMJgSRbBt+HACxQ8IT6D3D/Fi81NOiTt1KyEvvnQjJjN289l3PZQK4LJju5MFAPJe2W2J44sf93MY8m0ywmyAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248665; c=relaxed/simple;
	bh=mPVA1GHrh6hN8WvutX4AkTUW1VwrmM7x6ixf+z3WSt8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cVOVQtrIk2WhxFr1lMVHl75m51XCcXu740rkdn5Rwe0Tl2Fabmkc4E+e/88OU1ujRhMySuJxRUdQwLZh9nc0i85aUQ1LOW9Zy6zvFfuDMcpYKgyJl8vBr/Sy/Ukx/dtsSwSHjosw4mTXjm75VjlEvPQta2fGcjKfTy4XrBRK3k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9uGU+bP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733248664; x=1764784664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mPVA1GHrh6hN8WvutX4AkTUW1VwrmM7x6ixf+z3WSt8=;
  b=l9uGU+bPp2V78NIJ0ZCy/P5ghgmDey9fUjJZ+uw6RY9XudO/n4Ih9/xR
   7JnaMyil7AGqizLZBpT1aqISeSsX//QjFjoTIfBIz3taQZ/MCZOes3y9L
   6OOcG7WcFqhpCn/X1H5rubxaUFME+x0J5fV4QLNwT+JUUr/DsTzGWk/jf
   48jSRRyDVJlud1bO+clF6KabELvVIUoEwQWhkQC2PLESTO8NU0OTNc05U
   lQFAeNtNUhRDg2SVZqOZEOoAgRoSrLNVeoxJddShnDwOx6nWAFJ3I5Nwm
   sGl/kWgxqXUQcufrX909ogwfUrutL0ng/MSxuXVMKsRnU7PMW+3vuF33m
   w==;
X-CSE-ConnectionGUID: U23iEPffTyeUmLJQZ3V54w==
X-CSE-MsgGUID: RmOmRx9AT0CYuPAp53l1eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="50892050"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="50892050"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:57:43 -0800
X-CSE-ConnectionGUID: R61RbgbgTs6HXZVNgbIZuw==
X-CSE-MsgGUID: OOOn1x+uQm+XoxxBWvSEWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="98299622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 09:57:43 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 09:57:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 09:57:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 09:57:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZyO0ZO98F+4UXWkvQmpKUA1n296vOuS9sBMyrWyU9twPzpxuQ8J9tsdthH5bX82EbM/+S7MziPg2WGahCkw8rZ0D2NXI8rT8P/zL2vQTHJLvGl3yYv4bpGMQZJVO6jFlnnXX1/CDJolBM0GbDxgd1y0hs9bPEXZ6VWKzUErpHKd5GeHHcEjZxjwv+bD/Zz0AifhA9tRXTorlZN8+XXhYkWrHGVIMMWhqaqn77pjZ5aGRsxqGL/kWt1I51mE+aYOgqMaoyOGoMBqNY4oVgacsAzQ8i7/JMtXLwWnsVJfI6A6cJy4uh2CDymwluqdkTXnKBgE2jSakcf9L14LoUAZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4kOQkMs7GYXfdoZMGKq6Q6DAxIDrCTju2/dPgNA3Q0=;
 b=BcehppeZjK7dWW0DwK0TsDQhJLSXdtsCIoMyvMDiuaKAzztC4QtftDakbRvlv2nnzvgegmLn8xR6pjpH2FWpYRciGzbZnKax+pTpyYAkpPmSJIGNsYY3lVado1erbd8tt4MUzpi/7vEpzmxQ95K4LamEmQYP4g9MdjfWDWUGjo/Od7J3OvdcTOSZRBr6omqwrp89tvcf4TUtFroU4uK+TfcXUuSRCxfiMqrj1PFv8sxD7zdjN46pqUk7YfSS9gTWJnaLDTLYufXu+4c9b5GlxVwBlNznOWmiLBDEQATknmZKlilsD45dnqRzMS90yC4N3QJumwfXHItpcHJiXrsg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 17:57:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:57:38 +0000
Message-ID: <35c2be6b-d2ab-4330-ad95-cf8b0b6e1af9@intel.com>
Date: Tue, 3 Dec 2024 09:57:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/9] lib: packing: add pack_fields() and
 unpack_fields()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-3-ed22e38e6c65@intel.com>
 <20241203133927.g6ngln5tjuwrqiu7@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241203133927.g6ngln5tjuwrqiu7@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f420b5-98b0-4504-cf7e-08dd13c3f9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TExHb3kzUXZTR2RLd2tlUTVTbG9kR0I1TmVDU09VcWNrN2xsTGZNZGpuU2xz?=
 =?utf-8?B?clpTK3d2WTJmaEJVN3BUN2crM3JNSDNxeHpKZzlCWTJBNWlzRmFrckRrSUpw?=
 =?utf-8?B?d3g0eC9qRzVmNzZSRFpUQ2V0SXlMOWkybGZGWGZCQ1lsdEFCRXFqejd1c0w4?=
 =?utf-8?B?dEErWkw2ZmtlSExwRWFPZTdJazlTNFhFc3FLd3J4QkxCK3VyV2cvcTM4RlJ0?=
 =?utf-8?B?ajEzSWxnaFhKYytXS3JKWXl4R2FyY2FadGk1TGtPWUNzbm51clN2bS9VbEw0?=
 =?utf-8?B?UnNQcTdLOHVCeHlLNnhHS1RXeG5KbVZxd214cTBuaTFyYm02ZnU3enErTnFU?=
 =?utf-8?B?Q3U4VGF0Yjc5Y3NCOGNtQmVMSFpnNC9HZWt5TFVub3RpNk9DYm16WVVrTW5Z?=
 =?utf-8?B?M002V2ZTUU5qYVhoZ05YbVlmUi84RzNCZmpQQVJjaGFicjEwNGdQUmMyYjE1?=
 =?utf-8?B?K2pUUTcvTS9sVDEzaUJDQ1RKSWxLTkFseEdZS1hHaWptb2ZOMlAxYjlWY1Za?=
 =?utf-8?B?ZlY1UmliZ3ZOYm1wOW5ZNHJxQzlPZkNvdDFyWkE3UDlENEthL3kxLzRDbXcz?=
 =?utf-8?B?bXJ4QXduQWRnWURldGo1NkdKRVdtK0EyQklTR2xEL1lDai8yYkNQekxsYUJR?=
 =?utf-8?B?a285Wndxb3VuVHpMV2dQVERnRFVhcnhKWlIxS2lsUmo2US9sU3hKSmYwd3pn?=
 =?utf-8?B?bzdVcWVlaFo5VldESVFzNXBWTkUwY2tXMktKSTlBNEcreWx5OUZBandGNG5F?=
 =?utf-8?B?TmdYdnh6bEFhOTFWdDJIUi8ycFU4emV2ZFJYMGQzQklZYy9BNE1LYUs2STNh?=
 =?utf-8?B?LytsRmNVK2xxenJNeHFhazZQSFpWNjVQOHVpRlZxRXRpN1U3T1JCTlhWZ2RB?=
 =?utf-8?B?UHpGVlZmK2lzdXJMUGVrQk0yMkdkbUVUbXlQcjF0WDJVVytKK2hDTDVrRFRM?=
 =?utf-8?B?OXdqNndnYURIQ1VRZ1VrcUtpYTczQmdQbm13SlMzMVo0N1REbG0yWFBYSnVQ?=
 =?utf-8?B?SEhzdnpDSC82RUJNRXlGeEVnY1g0R1ExZW8rV2dBOTlBOVVKRVc5SXowQWhQ?=
 =?utf-8?B?cTAzZGpsRHdpZHRNVktjc3RVU3NtWlU4c3BvY3F4UjZsVmxzM1l4cXFrZ3Yy?=
 =?utf-8?B?eUE1SlEwNUswZlM2T2J0L2MweHdaaEZZbmN2NTNRa3phSW5SeEt3SVprNnZr?=
 =?utf-8?B?L2ovcjF5bnhPOGpUcFV6NHBxK2h2WkhvOVdpdmFMS0FHWG1kRHVLSGQ4VW9j?=
 =?utf-8?B?WXdiRm5YMWRIUHErdmZTZkZRSEEvTlVLWDI5ZExkdHVSSXphYnYreVZKbGF1?=
 =?utf-8?B?ZFpRcGJITy9QMjRCODBHeDZKK1YrQXRMRy96NDBjbVhxWE9ibWdnRXo5c0Vz?=
 =?utf-8?B?cXRlWFErbUMzcVlrNGNIWmViNzVLY1VQMy9pYnRsMlhBV2ZYRlhSeHVDSjdT?=
 =?utf-8?B?Vko3S2s3S2x0a3Z3aFRPcEJXTjNOaFpiNktzUDdiN1RTQkxKeGt5dnBuMFFF?=
 =?utf-8?B?ZklXcDJ6SGZaUVlGQTlCaTlZR2xXbndlTWQyVVh2WWZneUJzcTN0TDVYRXM5?=
 =?utf-8?B?cytIQ0xwRnA2cjZvdXk3em1ZM2txNzBmalNTWFhLaXRpVldaVHJjNzM5UkVj?=
 =?utf-8?B?eVUvTGEwVkRscXQ1L0RtZndPUnUxWjVnemdneWRXeHNLZFBvd3lmKy95d3VX?=
 =?utf-8?B?bzJZdmM1MWJNZHRDdzhvKzR6SC9xQnk1ckdRd1ErY1ZDRmswTjlObEEvMmJC?=
 =?utf-8?B?TUtzaDJoV1dDUGNDKytraWlNUG9yRldzVVMvVEdkOGFpbEQ3U3NNejlOREUz?=
 =?utf-8?B?WmNCejdqWUVXUXZJdXl4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmwrWkV3dWtEdnhIMDJ2M3htVFhhamxUQU8yaTVRS0w1c09KWlRSRXpLN2ow?=
 =?utf-8?B?ZXRqU2sreURoTWhRZWh3UVcxMnRlWmFlWGJ1U3h2MjhjampDZTY1S3h2WWZ4?=
 =?utf-8?B?blVNTkJyalFGK0ZqMGZBSHljQUkwQ1Q3S1VjREd3MWxRbVpjVVJQdjNKdEtW?=
 =?utf-8?B?MGp1UEpBVzAzTEJINjIzK2VGT0c0REw4elZJemFxVVVZaEdNYnZzc1E4L3ZR?=
 =?utf-8?B?L1NxTkdSd0lBcVl3NWg4RSswTnBhMWkrdFM2SzM4WTFXd01xWVA3b0ZMMlZy?=
 =?utf-8?B?ZnBZS3R5cDdVWXRqMTNWYzRmV0RwVWZwNURSNW9pOFdkQWN3ZVI5OWEvNHFE?=
 =?utf-8?B?aFpMK3RkbGgrQk1PaGZGeCtZL1RLdE1Lc3B6Mlp6R21WbXhGaGdOVlE5Q0hN?=
 =?utf-8?B?TGtEbExXR0ZpNENWelZVdmJnYVZVQ2w2OGVWM3YvZ0pwbmE3Y093Ri85K3JY?=
 =?utf-8?B?WUtMRjFIaFBiTDZCT3Rzand4eFVHZzZ1Yjl1dWlQYUtFYktyQXl0WW5XbnAr?=
 =?utf-8?B?UjhCa3MxbkNNdjNoN2pnbUNJTXJLeXpabmh1NWFLWGxzL1d1SUZBVzF5MjZF?=
 =?utf-8?B?eWpmMUVPbzBHZ1RkcU9sOTlpY0FCT1ZpOEd1V1dlRjRZVUFKOTVsUlBNS0Na?=
 =?utf-8?B?NllxaVZqdFhOaXVOek5xam56NktWTEVxWGd1dXNTOUordnZlaDQ5M0hTV2lC?=
 =?utf-8?B?akloY0dCbTVwTk1ZTmJRNWU1TDltWTQyTlpnRVduVXFvWkpuVDZraFdhZ3VE?=
 =?utf-8?B?ZDd6cXVsU3VwdnFEYVR2L2tXVEhmMkt3bnlPaDJ1NlRZNVB1cG1yVFNkMW1k?=
 =?utf-8?B?WUVuTnpBSWgrWDFUMHdhS3VNMlYxQjFvRXJZdW9HejdRRUZjUWVreUpCN2Zp?=
 =?utf-8?B?NzNRTFV6VlF6MGpyZGdkbWZtNnYwTGR3SU5iazBKUjNqaDRVcTVnRTQxZkdQ?=
 =?utf-8?B?NkUwbXY3ZGRBSlZXcFJlaTljSDRIamk1U2pkc0hlc0wvMlJvWUZ4S1p0YVgy?=
 =?utf-8?B?MWwwMjlidWhKQWJmNnVNNEpMMjZXWTFjY01nYzVNT0R6NmZwTlJaY1JmN0t1?=
 =?utf-8?B?SmNXaG9ENGhNVVFOYmtNbXk5T3RoZUJnNGt4c1JibkI0SWhLZDlNRUowZVQy?=
 =?utf-8?B?NFZjVVNMVWJjM0d2NDNOWVRiVjIzWHhDRFRPanNJMDloWUtlVVBrUzJkWTFJ?=
 =?utf-8?B?cVlhS2hhRS8vbGFDL1ZYL040ekwwZHpJTmFvaVhzNWJ4clNOSXlwdHFtTVh1?=
 =?utf-8?B?US92dlgxSUM4SXpGcHg3R09qeGQ4L25ldTdER3Yrb3VnSm9mT1ZUUldwUmNO?=
 =?utf-8?B?REpvbFQ2MnNIcFBVdmRIbE9iTUxyZUI4OE1wVzBPQVB6UUJWdU12Uk5JU3pM?=
 =?utf-8?B?aW9iUVdPZU5Jd1o4Nk9rMHFmSWxlQit5bjlHbGJGakNnZW9jRVVoYjZOa3ZW?=
 =?utf-8?B?eXJmSHMzUEd6eUJKRjAwVmJUMVFST2xZN1BSVUhwcEpyMGhpaUV4aVdEOUxL?=
 =?utf-8?B?TXVGNHQ5SVk1d2QxUndGY0lVOEsrZEZVdEpOSXc5cnF3Y1piQnV5eXhmN0lj?=
 =?utf-8?B?TTdvNDFCZFlRd2ZqT2NtTXNpc21BU2xubDBWRnNaQ01BYmxwZisrSHBUWlJ5?=
 =?utf-8?B?d3pjTVhDU2FINXZYNDZhNWJTb3pKNmthamF5S0NXV3AyaEdaQ2dQWHhLejhn?=
 =?utf-8?B?SnVGMXkrYnlvY01ZNjVaV2NaMVFQSVlCV1BPeEo3QVhZNHh5azRvbURSUHNw?=
 =?utf-8?B?M0tFeWdTUTRrU2dTaGFFN20rV3B1T2lSdy9yZUtrQzhQY2FSTnNNZ1NiUk95?=
 =?utf-8?B?dkFXLzA4dVNLUkZPVTU5dUFERUtoZlQrS3lIdGtveGhqb2pPcDhzdGtiWTB2?=
 =?utf-8?B?dmpIdFU3T0xzcjBUSlR0QUJSdVNpQmpNc2pkUklVVXpBZDhUTGJJWnlnSnYy?=
 =?utf-8?B?YTBNeWRqK3JFc043UEMyOUNHcDhjWkNtNExSMnIrYkdwekVWSi80cFhEWTdR?=
 =?utf-8?B?OFlUYlNWTGN0WS9qeVlpWEdrWlR0dWxjSHJPODRyczBsYjdKRVZ0T2VFN0hz?=
 =?utf-8?B?V3JQYWxtNlNzYTAwd0xFMFRjaG4rZXpOWDEyS0dIazJ1aExlR3JQYWE2bTFz?=
 =?utf-8?Q?bguP9UOgspJfW4QwpzOiJ2t0m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f420b5-98b0-4504-cf7e-08dd13c3f9b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:57:38.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvC43sJnisnVsQ5IxTJ7hW5xuGpda50wwiqGTPpEI4crKZQKXohskYF18LTGa08VfCN0gTjpvcADoEB1lXlip9EK0XfmE91INf59tcidE/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com



On 12/3/2024 5:39 AM, Vladimir Oltean wrote:
> On Mon, Dec 02, 2024 at 04:26:26PM -0800, Jacob Keller wrote:
>> +++ b/include/linux/packing_types.h
>> @@ -0,0 +1,2831 @@
>> +/* SPDX-License-Identifier: BSD-3-Clause
>> + * Copyright (c) 2024, Intel Corporation
>> + * Copyright (c) 2024, Vladimir Oltean <olteanv@gmail.com>
> 
> Not sure how, yet again, I managed to forget to say this.
> 
> Please use "Copyright 2024 NXP". I used company time for this.

Will fix.

