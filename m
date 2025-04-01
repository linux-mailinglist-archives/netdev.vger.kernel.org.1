Return-Path: <netdev+bounces-178678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC293A78338
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068A61890B81
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D891E1C29;
	Tue,  1 Apr 2025 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laiicagY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C73594F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743538657; cv=fail; b=k54lwxfhrf480etRMMTN/4Z0BKgUbdwLz4F7SOUSmd/H4jSSGAe2Wd8IOcYzRn5TxDPu60VbGD8WIkE9dE899QXjkyOSZFtOtNpkbcru1JYYe6p6cEVR11x29IJogTTuyrDHAvF2me+Ew0Y6e3mDeLCVVGdIgw95oAFUKaFTvVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743538657; c=relaxed/simple;
	bh=7GcnnKTla8KZxrZ1idYKtf7ApsZdqyDY+W1wQPZ+230=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSV1ijJ1di6/I30vrSkd4k5hq9Rv1uBYHYoRwa4gcPhQyuSCDlqlbPhjmv8n1TKepOPKqCcSxHu6fgdIhUP/Rcau9c/eOhy5MFSXvrWOuFaRMVB+6+cum3WLd++1BgBptfuNAL7z+ltJCHq6jinsRusPAXq44DFZf6ZwCrBazzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laiicagY; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743538655; x=1775074655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7GcnnKTla8KZxrZ1idYKtf7ApsZdqyDY+W1wQPZ+230=;
  b=laiicagYxV+acWMAkplHLEyUa17sti/TvAXNyQLDiJRT9PpTFl9ppJNM
   eF2e5i9/9pXPsyauT18xfe3u5n7ipsPQEVUlA/1ShvoYUr4ngH97Z2B6G
   ZeWGHPsHtaS0DsrcntL1C/cJaeVe1MMr1GZNF+XD+5A/Q3o+OzB61Rh1F
   dMRTIhAsaCBNysvLeOnS+jFGteJbspgM6ERrgsvIhxiUzMYGBM5ruzJ3o
   I3rqPQx/g7Ub94fuEs81CakjpA3yW3VYfWfRPlCHnNR3opCgloQfJo4cP
   O5GI703YVhXUovJXy96Vl+leNO1zbrlHdQGMDIqGWZqUe1VNr9jC2DM3o
   w==;
X-CSE-ConnectionGUID: NYR74H+ATVWfa4eFIS7d/A==
X-CSE-MsgGUID: O0siVjQESlaAF50RqODVEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="70242311"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="70242311"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 13:17:34 -0700
X-CSE-ConnectionGUID: HFJNivXyTEuTTH6c2ql05g==
X-CSE-MsgGUID: J31qb504T9WiEUW2y2RROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="131631457"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 13:17:34 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 1 Apr 2025 13:17:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 1 Apr 2025 13:17:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 13:17:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQyekc8wZvGswBHjBMfUBeHuAORNjGFgdbJIFHRn8/LHtOPvw/q8t8TFP0H8A86O5ZJa/6B8FbGezPQHfSFvooEZr40xbD/VRcjlAzIZPuggWNGrkehYBlNZX2lGXVQMWr9IK7IUPN9TWboO+xH2725Nigr3O8jN2WhRKYIlphpp34PaoZMuSCwrrfhYifvok8F9iunwU9WI/lbhctIXeoZ0/TjyxGDj3nY9/JtYVRLH3B9b7tb+vvO8Fgm3DmHHcQ2jFIaYB9d23lvo6yMmvNQkgIwYXzY73KN0AE6WzWRCPzStKAoKYjW7Vfo0G5Rjddd9bxfdqGMcwM0zRLS7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GcnnKTla8KZxrZ1idYKtf7ApsZdqyDY+W1wQPZ+230=;
 b=vqpG3BW/EZHtgjlzSVWaW7f2LRrEAtT3KvHP46xBr3v/x10g4wfVnBMEstgjBIDqXS/19RqM2c4gM+JNctRGXR4JjzUy5eMHGeroVS1/6Xbmq9ij5fEUG5QKKQwlIRVgcWjPVWzT37x+IMQr+7h1urD2msYzB+rlZgpgWkCHYzu2iOXZOimf5sxiy8BxY2YqshIB2N8Ipm0ZGbSXFT6dtNjl12AwF32W/Br6XMaOfqIkPzo/SUhqk92icRNVAgK5yaWMxNTlounAGV870kRujYO1J44/nSp+efbQnwurg1SXDNAk0HbPPLBCWzfg0o4+tLoNxCDCqneqAZjrBtBXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7143.namprd11.prod.outlook.com (2603:10b6:510:22d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 20:17:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 20:17:29 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>, Kamil Zaripov
	<zaripov-kamil@avride.ai>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Michael Chan
	<michael.chan@broadcom.com>, Linux Netdev List <netdev@vger.kernel.org>
Subject: RE: bnxt_en: Incorrect tx timestamp report
Thread-Topic: bnxt_en: Incorrect tx timestamp report
Thread-Index: AQHbmabzt9yIJ9y65UWSheI0MF0lJ7N8QvaAgAFyeYCAACXggIAEjWoAgAFA/4CAAAgFgIABxueAgAGJB4CACFDr4A==
Date: Tue, 1 Apr 2025 20:17:29 +0000
Message-ID: <CO1PR11MB5089FF56F6991F88F5E4E8A8D6AC2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
 <8f128d86-a39c-4699-800a-67084671e853@intel.com>
 <CAGtf3iaO+Q=He7xyCCfzfPQDH_dHYYG1rHbpaUe-oBo90JBtjA@mail.gmail.com>
 <CACKFLinG2s5HVisa7YoWAZByty0AyCqO-gixAE8FSwVHKK8cjQ@mail.gmail.com>
 <CALs4sv1H=rS96Jq_4i=S0kL57uR6v-sEKbZcqm2VgY6UXbVeMA@mail.gmail.com>
 <9200948E-51F9-45A4-A04C-8AD0C749AD7B@avride.ai>
 <0316a190-6022-4656-bd5e-1a1f544efa2d@linux.dev>
 <CBBDA12F-05B4-4842-97BF-11B392AD21F1@avride.ai>
 <CALs4sv1KFsXLMJhsXTr2by1+UAXAiLTz90EQR5dJ4bqrs6xZCg@mail.gmail.com>
In-Reply-To: <CALs4sv1KFsXLMJhsXTr2by1+UAXAiLTz90EQR5dJ4bqrs6xZCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|PH8PR11MB7143:EE_
x-ms-office365-filtering-correlation-id: 1bf16178-32e1-4a18-a908-08dd715a3a16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Sy9kNkhoUWpzb0o4Mnp3ZEFHUVdndGszWWZGbVdGWlJJSlFycEY5OTRHdnV5?=
 =?utf-8?B?aG1WZ3RtUDd5Q2hxZHN2bXhmYTErUlpTNytnckE4cWlqS0ptakk3MVVzOEJM?=
 =?utf-8?B?NmhISnJXVmJFekg1N0x2b0tSVncvRjRjWnVxSE1BK3Q2ZUJDS2pTcm1GWkU1?=
 =?utf-8?B?a2FUaDFrb3E3b0tRb010Y3NreFhxQXFyR0dlYkZybTNUZnVnTWQ0bkdXTTdX?=
 =?utf-8?B?VGVCc1Mwemljd3R3NktEWkU3TGJqT1ZOaTBYQkFOOVIxNGRvcnNhOGtEVlVh?=
 =?utf-8?B?RWNrRXpZSVdvbDlqYmV3L054bDRIYXhUMWxGbVozeTl1RE9MeE45SGIzalZZ?=
 =?utf-8?B?UkRiL3IzRU1OQWFWc2w0TWxMdHZtbWg1bitWYlNBcmpBNzhZVThEenFJZnpk?=
 =?utf-8?B?dUEvRWhaUHJ4TlFzRkcvTjVyTTd4d2VhWHlKV0ZYMFBVVHlWZGFmOWxjS2NG?=
 =?utf-8?B?YmV4VkVrdlJNMnNIVlhBZlRRUWk0U3NDZlFjTW1lNVhMcWNoRkpqRkROaEhR?=
 =?utf-8?B?bkxMRmhxZVhUWGYzRlB3WHBneUsvVTlyeUFQOGpyS05xTFFHYk1KeUpIVk1Y?=
 =?utf-8?B?V1ZiZm12QzIyUCtkMm04a2NBbWFuVjN0bmtEVHNvL05ZTlF2MUY2T0tjZGN2?=
 =?utf-8?B?VU0zVUNRRmM5M25BYjVyYVdSNFkyeFdrUVB0ZWZvOUcxVjdLVERwbTJlbHFa?=
 =?utf-8?B?M1NrZFZoZjRtb0RBVGlTZWEvU3BDNmlQd3lXM0FLLzhhcTZWNTVnV3Bnb1JF?=
 =?utf-8?B?TkhHV2kwTHRxYWp2NXVSd1BhUDZob21xV3EvMWpEdVh1VkNrcGxCeG1aVDVN?=
 =?utf-8?B?Z29mN0sxVXBlZTBRTFJ0YkRBVkRBK25tSXZMUk5sL0hCSFlBNDBUcCtiL1kr?=
 =?utf-8?B?QW02UFVmekZwbU90L2ptaHg5aWljSGYweHJQZ21GM1FySGwrTklIVFRQVVU5?=
 =?utf-8?B?N28wUEdQbUVtcW82SHhPSWxGWDZFSi9YeWJMUkgvRC9lVkVmbFI2MnZWM0Ri?=
 =?utf-8?B?Y3ZEQmU5dDZtd2poNjhrVktkSFd2MWNmUHRFeWN0STNuQnRoSjcvcjFJdHc5?=
 =?utf-8?B?ZEZWKy94L0Iva0F5Nk5yRm4rRHN2eGJ0NGVxZGFOMGd2a2p0RUFHUjJ2aHdN?=
 =?utf-8?B?anBPOVlCYUxaSlhHT3RKU2ZERDAyZFF6ZlZZQ2JGQ1U2OHl4TXhKMDR5ZUNr?=
 =?utf-8?B?RHlLWnVSV0hHbExsTi85SGJkaFlzcHRTMisxeUNyNjU4SjNnVk52WUpubUht?=
 =?utf-8?B?Yzh3emNPK1NmWnhtMnhQd2VNZWFlOS9ZZnVTZ3VoYUlBaCtuamxENXhSV3px?=
 =?utf-8?B?a09HWmxOWGVWc1Nrb0J4dXNpVHhGb1QxS1l5eHhhSGY5UE5KS2NmZmNmNWF4?=
 =?utf-8?B?R0liamYxRlZxVzRUa0pTeUtPUUlHdExzdi9IaGpMV2ZvSVBSZ0o3K1lWQWw2?=
 =?utf-8?B?RmZ2UWJZakpNRGtLK3NTdHFjK0NTQkJ5OVZpbnNmajEvamlSaGJLSHFhOGNn?=
 =?utf-8?B?ZXFHRXc3cEoyUU5udUNyYnQ3cnlvYWNWOXM5ZThjbWdQNld1bFZ0NmtpK1dO?=
 =?utf-8?B?dDlERW1jNUpCd1ZURVZwYWUzQkdQZmloeFMvVFVRYkpFbHQ4ODlpYWYvL2Yv?=
 =?utf-8?B?cFliaGwvNThseEs4TTdZTXhvUlRUT2dObUcva1dvbHBmTDJUMnFTRWR6NnRD?=
 =?utf-8?B?VkNhRStEd0l0aWVtYXA3NGd1OE5aUmJZbGlpTzhlWktZWXh1bzVWMWdiWlBR?=
 =?utf-8?B?Y1hUc2x3NEVkOWNhb0xTb0dnRERFbWJSa3BReWJKV3RwSkluUE8xSkZBK29t?=
 =?utf-8?B?T0J5dzN0ZUlLYTZlT1JWMlhxUkozTXFKdzB4QWJ2QlJCamVzaDR2V3M5aTRp?=
 =?utf-8?B?MC8vRnB3Z2ozdjlHNWloQUQxWm8weWltb2F6Ymg1c3RHR1czQUxLMjFCaHc2?=
 =?utf-8?Q?QUoW3aZob7nr8MW0uObfWCRS+HbLsr/p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czVmSjRVaXcycW9jSitwQTFxRHVLbDFCUW91WnJUWUFycmlyclZVWjgwTnRK?=
 =?utf-8?B?VERwbm1acS9vZW41bksyMzg1aFdaeHhmUDhYM3Uyb3pQUHF0Q2dRU2xlZHVt?=
 =?utf-8?B?a0pZUGE3bGNNRG5DRG5YQ1BHNCtQbWQxUHRlcWR4T1NkZ3VvT0lTYmF0MGZs?=
 =?utf-8?B?WkE5U3lPRzhBMTE2akJrc0xZMk5JV3N4R09ESm9XZFduRGVGdytEWCtqTzd2?=
 =?utf-8?B?eG5Ma29VdGN4Q2U5V3RKaERRK0pHNkJyY2VTRnNoTWc5MHpHSFd1Y3ZPcDRZ?=
 =?utf-8?B?SjIrQ2hhczJIQzZOQVhiR05BT1hpb2ZJTnh3YTBwck5GMldkWE9UZWQ4VW5N?=
 =?utf-8?B?OCt2d09ubGJvUlc1UkMwZGs0Mmo0UmxlQlJQMml4MGwxSERKRU44d2JQT3U5?=
 =?utf-8?B?ZVZnUFpCUEUyTzN4MFVXaE95L2Mrc3B0Y21yZGlBckxsSTZ1RVRqczBZVEJJ?=
 =?utf-8?B?Sjg3NkZhWUxLTmJMYlh4Q3JtTnU4NkE0U0Y5d3VCcFpMV09kWElXaGtuWXB5?=
 =?utf-8?B?K3lnTVdUMHQ1eTk3Q2EzbXBsaGRDajJjRVBPbTJvUWF1T0FQWDRFbUVmUi9I?=
 =?utf-8?B?ZFRiV2x1SWlCMnRtZk5jQzZEY1ZyTWQ2eldqN05vUTE1c3ArbjBGZWUzUk0x?=
 =?utf-8?B?R3dxUXowSFNSMWFZL3EyVXM2TzJRRUNFR1kwaTdNdy9SbFpyUlpSTzU3bnV1?=
 =?utf-8?B?MkYvRW1uVmVBNHdCSFRGaVJXVVBSQ2JqeDV5SFVRNjBSeUY0aTFJcC8xZ3I2?=
 =?utf-8?B?SDZKeTYzUXRVb2hLdk1KZkxzSUlWWFBnNUVTUGVwOHFXYmZ5ODBOT3VkSnd4?=
 =?utf-8?B?eGlIeFBmRkxSUkNSM3A3WWVUR0lpaWkxOWsrN0UvUDJ1K2xLOGNEaWdqV0dV?=
 =?utf-8?B?amJ5U2xtNk90T0ZzeDE1Q0RISXlNNmxyMkxMV3Izb215Z0VFTG5nSnhaSzFo?=
 =?utf-8?B?SHF6R2ZjdFVwb0ZSRG44aEFseEZSMHdQWVB0QTRGZE1JZUNtTVMrQmg1Tktx?=
 =?utf-8?B?SEpUMWVVR3pUVFBoRGFWSEdkR2MwZU5jbW5qbXVXYUdWWmpxUS8zU1JpSWxQ?=
 =?utf-8?B?ZmRaK3NhR21pUTg2T3g4WGQyTllxOStTc2M2ZERJMjVobGlEUFFjYVFDNEtt?=
 =?utf-8?B?N0MrTmhvRnFuaHF0VjlkT1h2QldYSy91aFZuSGlDeDJOMVdLVVBCcTRReTJy?=
 =?utf-8?B?c0xVbEptQU9Mc1NVV3huREtEZytqT3FYNFpuMytiUDNLVHdHcUJWZVYwOFZQ?=
 =?utf-8?B?ZXdSYjlyOXZmR2U2RFNqeE45NGlaOCs5dWxIbzNzcE42Zk9LT2hNdVpkczIw?=
 =?utf-8?B?eDd5V0E0KzVXQ0NLWG02UjhmMXM5M0trc0M0Z1dhbjhhdzNaYmZMeFRvU1hJ?=
 =?utf-8?B?clF3NElOazU5TU5veGRKcnFCbHBwSEQwNkpoSkZzVTFTNHBCTTQ3bXRrRmc4?=
 =?utf-8?B?N2xZZ2JVYzJzZHNkdFNyTXBZWkhFUUlMOWhYaGlrMFpWbDJPR3prV0JvSGZi?=
 =?utf-8?B?Z1RIMHFWRWZJcGRmSWlCek1XaU9hb0ZWS0tNeUFRZGN1RGlkM3ZKOXVyNWFz?=
 =?utf-8?B?SERiQTRVSDFVZlBQRHhwVDJCWXJnWVk5NFRLeGZyQVJFeldRYzRIZDlnbDBl?=
 =?utf-8?B?VW9NTmhIUkpaTSs2cEJSUG1tUWp0UGtvdDk1RmpKeHBoSm8wbU9PZzYrTmRy?=
 =?utf-8?B?eFlVYW5iRWRlV0hBVG56WTllR09tYzJIS1h6bkxEWjd1c3RsRi9zMEc5c3cy?=
 =?utf-8?B?QVNURDVDelNnQzVRZWt5WEkvRXZtYnpkdDFxVWJCV2N2SG5YSXBFUzNsa1Q0?=
 =?utf-8?B?dktlNHdoZ0pVQ2Roalp6blQyd3NzdlpXeTV0d1Z5ai9aeGttaGtJWWFBNDBn?=
 =?utf-8?B?R2puT1YyTG0ybEdzNXRaVEpSK3kyVzI2V3ZpOU5EMi9NSUZxVDVGV2lJK25V?=
 =?utf-8?B?VFpHOEFjMnlCNDJFaCtPTUZCRHgzczVFbWZRbWZhZ1RPWDhjbXJGdmlYajFD?=
 =?utf-8?B?Yk5oMEtzei9YaWRabkd5MFE5UDdEZDM2dkJhMCtGTndCYkZoWXcwK2o3Uy9u?=
 =?utf-8?B?RGxDNTFnQ2tZQ3pkY0h1aXJHV1d0L0JmdGtERUxDTjUzeVhtYTlGWTBYcHhl?=
 =?utf-8?Q?GdO576bQS6xYy6kb6ZWC834qc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf16178-32e1-4a18-a908-08dd715a3a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 20:17:29.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZoLx/kQqOTnROK8Hb8RHgKofVTaRQpglu6DuRpazIvO/6SNbOKNr6s/8e6GZUDNIVCc4LDQdIqidFusN38RDMm6s11YIIuBYhLUw6g3IQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7143
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2YW4gQ2hlYmJpIDxw
YXZhbi5jaGViYmlAYnJvYWRjb20uY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjcsIDIw
MjUgNjoxNyBBTQ0KPiBUbzogS2FtaWwgWmFyaXBvdiA8emFyaXBvdi1rYW1pbEBhdnJpZGUuYWk+
DQo+IENjOiBWYWRpbSBGZWRvcmVua28gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyBNaWNo
YWVsIENoYW4NCj4gPG1pY2hhZWwuY2hhbkBicm9hZGNvbS5jb20+OyBLZWxsZXIsIEphY29iIEUg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT47DQo+IExpbnV4IE5ldGRldiBMaXN0IDxuZXRkZXZA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogYm54dF9lbjogSW5jb3JyZWN0IHR4IHRp
bWVzdGFtcCByZXBvcnQNCj4gDQo+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDc6MjDigK9QTSBL
YW1pbCBaYXJpcG92IDx6YXJpcG92LWthbWlsQGF2cmlkZS5haT4gd3JvdGU6DQo+ID4NCj4gPg0K
PiA+DQo+ID4gPiBPbiAyNSBNYXIgMjAyNSwgYXQgMTI6NDEsIFZhZGltIEZlZG9yZW5rbyA8dmFk
aW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gMjUvMDMv
MjAyNSAxMDoxMywgS2FtaWwgWmFyaXBvdiB3cm90ZToNCj4gPiA+Pg0KPiA+ID4+IEkgZ3Vlc3Mg
SSBkb27igJl0IHVuZGVyc3RhbmQgaG93IGRvZXMgaXQgd29yay4gQW0gSSByaWdodCB0aGF0IGlm
IHVzZXJzcGFjZQ0KPiBwcm9ncmFtIGNoYW5nZXMgZnJlcXVlbmN5IG9mIFBIQyBkZXZpY2VzIDAs
MSwyLDMgKG9uZSBmb3IgZWFjaCBwb3J0IHByZXNlbnQgaW4NCj4gTklDKSBkcml2ZXIgd2lsbCBz
ZW5kIFBIQyBmcmVxdWVuY3kgY2hhbmdlIDQgdGltZXMgYnV0IGZpcm13YXJlIHdpbGwgZHJvcCAz
IG9mDQo+IHRoZXNlIGZyZXF1ZW5jeSBjaGFuZ2UgY29tbWFuZHMgYW5kIHdpbGwgcGljayB1cCBv
bmx5IG9uZT8gSG93IGNhbiBJDQo+IHVuZGVyc3RhbmQgd2hpY2ggUEhDIHdpbGwgYWN0dWFsbHkg
cmVwcmVzZW50IGFkanVzdGFibGUgY2xvY2sgYW5kIHdoaWNoIG9uZSBpcw0KPiBwaG9ueT8NCj4g
PiA+DQo+ID4gPiBJdCBjYW4gYmUgYW55IG9mIFBIQyBkZXZpY2VzLCBtb3N0bHkgdGhlIGZpcnN0
IHRvIHRyeSB0byBhZGp1c3Qgd2lsbCBiZSB1c2VkLg0KPiA+DQo+ID4gSSBiZWxpZXZlIHRoYXQg
cmFuZG9tbHkgc2VsZWN0aW5nIG9uZSBvZiB0aGUgUEhDIGNsb2NrIHRvIGNvbnRyb2wgYWN0dWFs
IFBIQyBpbg0KPiBOSUMgYW5kIGRpcmVjdGluZyBjb21tYW5kcyByZWNlaXZlZCBvbiBvdGhlciBj
bG9ja3MgdG8gdGhlIC9kZXYvbnVsbCBpcyBxdWl0ZQ0KPiB1bmV4cGVjdGVkIGJlaGF2aW9yIGZv
ciB0aGUgdXNlcnNwYWNlIGFwcGxpY2F0aW9ucy4NCj4gPg0KPiA+ID4+IEFub3RoZXIgdGhpbmcg
dGhhdCBJIGNhbm5vdCB1bmRlcnN0YW5kIGlzIHNvLWNhbGxlZCBSVEMgYW5kIG5vbi1SVEMgbW9k
ZS4NCj4gSXMgdGhlcmUgYW55IGRvY3VtZW50YXRpb24gdGhhdCBkZXNjcmliZXMgaXQ/IE9yIHNw
ZWNpZmljIHBhcnRzIG9mIHRoZSBkcml2ZXIgdGhhdA0KPiBjaGFuZ2UgaXRzIGJlaGF2aW9yIG9u
IGZvciBSVEMgYW5kIG5vbi1SVEMgbW9kZT8NCj4gPiA+DQo+ID4gPiBHZW5lcmFsbHksIG5vbi1S
VEMgbWVhbnMgZnJlZS1ydW5uaW5nIEhXIFBIQyBjbG9jayB3aXRoIHRpbWVjb3VudGVyDQo+ID4g
PiBhZGp1c3RtZW50IG9uIHRvcCBvZiBpdC4gV2l0aCBSVEMgbW9kZSBldmVyeSBhZGpmaW5lKCkg
Y2FsbCB0cmllcyB0bw0KPiA+ID4gYWRqdXN0IEhXIGNvbmZpZ3VyYXRpb24gdG8gY2hhbmdlIHRo
ZSBzbG9wZSBvZiBQSEMuDQo+ID4NCj4gPiBKdXN0IHRvIGNsYXJpZnk6DQo+ID4NCj4gPiBBbSBJ
IHJpZ2h0IHRoYXQgaW4gUlRDIG1vZGU6DQo+ID4gMS4xLiBBbGwgNjQgYml0cyBvZiB0aGUgUEhD
IGNvdW50ZXIgYXJlIHN0b3JlZCBvbiB0aGUgTklDIChib3RoIHRoZSDigJxyZWFkYWJsZeKAnSAw
4oCTDQo+IDQ3IGJpdHMgYW5kIHRoZSBoaWdoZXIgNDjigJM2MyBiaXRzKS4NCj4gSW4gYm90aCBS
VEMgYW5kIG5vbi1SVEMgbW9kZXMsIHRoZSBkcml2ZXIgd2lsbCB1c2UgdGhlIGxvd2VyIDQ4YiBm
cm9tDQo+IEhXIGFzIGN5Y2xlcyB0byBmZWVkIHRvIHRoZSB0aW1lY291bnRlciB0aGF0IGRyaXZl
ciBoYXMgbWFwcGVkIHRvIHRoZQ0KPiBQSEMuDQo+IA0KPiA+IDEuMi4gV2hlbiB1c2Vyc3BhY2Ug
YXR0ZW1wdHMgdG8gY2hhbmdlIHRoZSBQSEMgY291bnRlciB2YWx1ZSAodXNpbmcgYWRqdGltZQ0K
PiBvciBzZXR0aW1lKSwgdGhlc2UgY2hhbmdlcyBhcmUgcHJvcGFnYXRlZCB0byB0aGUgTklDIHZp
YSB0aGUNCj4gUE9SVF9NQUNfQ0ZHX1JFUV9FTkFCTEVTX1BUUF9BREpfUEhBU0UgYW5kDQo+IEZV
TkNfUFRQX0NGR19SRVFfRU5BQkxFU19QVFBfU0VUX1RJTUUgcmVxdWVzdHMuDQo+IFRydWUuDQo+
IA0KPiA+IDEuMy4gSWYgb25lIHBvcnQgb2YgYSBmb3VyLXBvcnQgTklDIGlzIHVwZGF0ZWQsIHRo
ZSBjaGFuZ2UgaXMgcHJvcGFnYXRlZCB0byBhbGwNCj4gb3RoZXIgcG9ydHMgdmlhIHRoZQ0KPiBB
U1lOQ19FVkVOVF9DTVBMX1BIQ19VUERBVEVfRVZFTlRfREFUQTFfRkxBR1NfUEhDX1JUQ19VUERB
VEUNCj4gZXZlbnQuIEFzIGEgcmVzdWx0LCBhbGwgZm91ciBpbnN0YW5jZXMgb2YgdGhlIGJueHRf
ZW4gZHJpdmVyIHJlY2VpdmUgdGhlIGV2ZW50IHdpdGgNCj4gdGhlIGhpZ2ggNDjigJM2MyBiaXRz
IG9mIHRoZSBjb3VudGVyIGluIHBheWxvYWQuIFRoZXkgdGhlbiBhc3luY2hyb25vdXNseSByZWFk
IHRoZQ0KPiAw4oCTNDcgYml0cyBhbmQgdXBkYXRlIHRoZSB0aW1lY291bnRlciBzdHJ1Y3TigJlz
IG5zZWMgZmllbGQuDQo+IE5vdCB0cnVlIGluIHRoZSBsYXRlc3QgRmlybXdhcmUuDQo+IA0KPiA+
IDEuNC4gSWYgd2UgaWdub3JlIHRoZSBidWcgcmVsYXRlZCB0byB1bnN5bmNocm9uaXplZCByZWFk
aW5nIG9mIHRoZSBoaWdoZXIgKDQ44oCTDQo+IDYzKSBhbmQgbG93ZXIgKDDigJM0NykgYml0cyBv
ZiB0aGUgUEhDIGNvdW50ZXIsIHRoZSB0aW1lIGFjcm9zcyBlYWNoIHRpbWVjb3VudGVyDQo+IGlu
c3RhbmNlIHNob3VsZCByZW1haW4gaW4gc3luYy4NCj4gV2VsbCwgbm8uIEl0IHdvbid0IGJlIHZl
cnkgYWNjdXJhdGUuIFdlIGRlc2lnbmVkIG5vbi1SVEMgbW9kZSBmb3Igc3VjaA0KPiB1c2UgY2Fz
ZXMuIEJ1dCB5ZXMsIHlvdXIgdXNlIGNhc2UgaXMgbm90IGV4YWN0bHkgd2hhdCBub24tUlRDIGNh
dGVycw0KPiBmb3IuDQo+IA0KPiA+IDEuNS4gV2hlbiB1c2Vyc3BhY2UgY2FsbHMgYWRqZmluZSwg
aXQgdHJpZ2dlcnMgdGhlDQo+IFBPUlRfTUFDX0NGR19SRVFfRU5BQkxFU19QVFBfRlJFUV9BREpf
UFBCIHJlcXVlc3QsIGNhdXNpbmcgdGhlIFBIQw0KPiB0aWNrIHJhdGUgdG8gY2hhbmdlLg0KPiBD
b3JyZWN0LiBCdXQgb25seSB0aGUgZmlyc3QgZXZlciBwb3J0IHRoYXQgbWFkZSB0aGUgZnJlcSBh
ZGogd2lsbA0KPiBjb250aW51ZSB0byBtYWtlIGZ1cnRoZXIgZnJlcSBhZGp1c3RtZW50cy4gVGhp
cyB3YXMgYSBwb2xpY3kgZGVjaXNpb24sDQo+IG5vdCBleGFjdGx5IHJhbmRvbS4gVGhlcmUgaXMg
YW4gb3B0aW9uIGluIG91ciB0b29scyB0byBzZWUgd2hpY2ggaXMNCj4gdGhlIGludGVyZmFjZSB0
aGF0IGlzIGN1cnJlbnRseSBtYWtpbmcgZnJlcSBhZGp1c3RtZW50cy4NCj4gDQo+ID4NCj4gPiBJ
biBub24tUlRDIG1vZGU6DQo+ID4gMi4xLiBPbmx5IHRoZSBsb3dlciAw4oCTNDcgYml0cyBhcmUg
c3RvcmVkIG9uIHRoZSBOSUMuIFRoZSBoaWdoZXIgNDjigJM2MyBiaXRzIGFyZQ0KPiBzdG9yZWQg
b25seSBpbiB0aGUgdGltZWNvdW50ZXIgc3RydWN0Lg0KPiA+IDIuMi4gV2hlbiB1c2Vyc3BhY2Ug
dHJpZXMgdG8gY2hhbmdlIHRoZSBQSEMgY291bnRlciB2aWEgYWRqdGltZSBvciBzZXR0aW1lLCB0
aGUNCj4gY2hhbmdlIGlzIHJlZmxlY3RlZCBvbmx5IGluIHRoZSB0aW1lY291bnRlciBzdHJ1Y3Qu
DQo+IENvcnJlY3QuDQo+IA0KPiA+IDIuMy4gRWFjaCB0aW1lY291bnRlciBpbnN0YW5jZSBtYXkg
aGF2ZSBpdHMgb3duIG5zZWMgZmllbGQgdmFsdWUsIHBvdGVudGlhbGx5DQo+IGxlYWRpbmcgdG8g
ZGlmZmVyZW50IHRpbWVzdGFtcHMgcmVhZCBmcm9tIC9kZXYvcHRwWzAtM10uDQo+IEJhc2ljYWxs
eSBlYWNoIG9mIHRoZSB0aW1lY291bnRlcnMgaXMgaW5kZXBlbmRlbnQuDQo+IA0KPiA+IDIuNC4g
V2hlbiB1c2Vyc3BhY2UgY2FsbHMgYWRqZmluZSwgaXQgb25seSBtb2RpZmllcyB0aGUgbXVsIGZp
ZWxkIGluIHRoZQ0KPiBjeWNsZWNvdW50ZXIgc3RydWN0LCB3aGljaCBtZWFucyBubyByZWFsIGNo
YW5nZW9jY3VycyB0byB0aGUgUEhDIHRpY2sgcmF0ZSBvbiB0aGUNCj4gaGFyZHdhcmUuDQo+IENv
cnJlY3QuDQo+IA0KPiA+DQo+ID4gQW5kIGFib3V0IGlzc3VlIGluIGdlbmVyYWw6DQo+ID4gMy4x
LiBGaXJtd2FyZSB2ZXJzaW9ucyAyMzArIG9wZXJhdGUgaW4gbm9uLVJUQyBtb2RlIGluIGFsbCBl
bnZpcm9ubWVudHMuDQo+IE5vLCB0aGUgZHJpdmVyIG1ha2VzIHRoZSBjaG9pY2Ugb2Ygd2hlbiB0
byBzaGlmdCB0byBub24tUlRDIGZyb20gUlRDLg0KPiBDdXJyZW50bHkgdGhpcyBoYXBwZW5zIG9u
bHkgaW4gdGhlIG11bHRpLWhvc3QgZW52aXJvbm1lbnQsIHdoZXJlIGVhY2gNCj4gcG9ydCBpcyB1
c2VkIHRvIHN5bmNocm9uaXplIGEgZGlmZmVyZW50IExpbnV4IHN5c3RlbSBjbG9jay4NCj4gQnV0
IDIzMCsgdmVyc2lvbiBoYXMgdGhlIGNoYW5nZSB0aGF0IHdpbGwgbm90IHRyYWNrIHRoZSByb2xs
b3ZlciBpbg0KPiBGVywgYW5kIHRoZQ0KPiBBU1lOQ19FVkVOVF9DTVBMX1BIQ19VUERBVEVfRVZF
TlRfREFUQTFfRkxBR1NfUEhDX1JUQ19VUERBVEUNCj4gZGVwcmVjYXRlZC4NCj4gDQo+ID4gMy4y
LiBGaXJtd2FyZSB2ZXJzaW9uIDIyNCB1c2VzIFJUQyBtb2RlIGJlY2F1c2Ugb2xkZXIgZHJpdmVy
IHZlcnNpb25zIHdlcmUNCj4gbm90IGRlc2lnbmVkIHRvIHRyYWNrIG92ZXJmbG93cyAodGhlIGhp
Z2hlciA0OOKAkzYzIGJpdHMgb2YgdGhlIFBIQyBjb3VudGVyKSBvbiB0aGUNCj4gZHJpdmVyIHNp
ZGUuDQo+ID4NCj4gPg0KPiA+ID4+PiBUaGUgbGF0ZXN0IGRyaXZlciBoYW5kbGVzIHRoZSByb2xs
b3ZlciBvbiBpdHMgb3duIGFuZCB3ZSBkb24ndCBuZWVkIHRoZQ0KPiBmaXJtd2FyZSB0byB0ZWxs
IHVzLg0KPiA+ID4+PiBJIGNoZWNrZWQgd2l0aCB0aGUgZmlybXdhcmUgdGVhbSBhbmQgSSBnYXRo
ZXIgdGhhdCB0aGUgdmVyc2lvbiB5b3UgYXJlIHVzaW5nDQo+IGlzIHZlcnkgb2xkLg0KPiA+ID4+
PiBGaXJtd2FyZSB2ZXJzaW9uIDIzMC54IG9ud2FyZHMsIHlvdSBzaG91bGQgbm90IHJlY2VpdmUg
dGhpcyBldmVudCBmb3INCj4gcm9sbG92ZXJzLg0KPiA+ID4+PiBJcyBpdCBwb3NzaWJsZSBmb3Ig
eW91IHRvIHVwZGF0ZSB0aGUgZmlybXdhcmU/IERvIHlvdSBoYXZlIGFjY2VzcyB0byBhIG1vcmUN
Cj4gcmVjZW50ICgyMzArKSBmaXJtd2FyZT8NCj4gPiA+PiBZZXMsIEkgY2FuIHVwZGF0ZSBmaXJt
d2FyZSBpZiB5b3UgY2FuIHRlbGwgd2hlcmUgY2FuIEkgZmluZCB0aGUgbGF0ZXN0IGZpcm13YXJl
DQo+IGFuZCB0aGUgdXBkYXRlIGluc3RydWN0aW9ucz8NCj4gPiA+DQo+ID4gPiBCcm9hZGNvbSdz
IHdlYiBzaXRlIGhhcyBwcmV0dHkgZWFzeSBzdXBwb3J0IHBvcnRhbCB3aXRoIE5JQyBmaXJtd2Fy
ZQ0KPiA+ID4gcHVibGljbHkgYXZhaWxhYmxlLiBDdXJyZW50IHZlcnNpb24gaXMgMjMyIGFuZCBp
dCBoYXMgYWxsIHRoZQ0KPiA+ID4gaW1wcm92ZW1lbnRzIFBhdmFuIG1lbnRpb25lZC4NCj4gPg0K
PiA+IFllcywgSSBoYXZlIGZvdW5kIHRoZSAiQnJvYWRjb20gQkNNNTd4eCBGd3VwZyBUb29sc+KA
nSBhcmNoaXZlIHdpdGggc29tZQ0KPiBwcmVjb21waWxlZCBiaW5hcmllcyBmb3IgeDg2XzY0IHBs
YXRmb3JtLiBUaGUgcHJvYmxlbSBpcyB0aGF0IG91ciBob3N0cyBhcmUNCj4gYWFyY2g2NCBhbmQg
dXNlcyB0aGUgTml4IGFzIGEgcGFja2FnZSBtYW5hZ2VyLCBpdCB3aWxsIHRha2Ugc29tZSB0aW1l
IHRvIG1ha2UgaXQNCj4gd29yayBpbiBvdXIgc2V0dXAuIEkganVzdCBob3BlZCB0aGF0IHRoZXJl
IGlzIGZpcm13YXJlIGJpbmFyeSBpdHNlbGYgdGhhdCBJIGNhbiBwYXNzDQo+IHRvIGV0aHRvb2wg
4oCULWZsYXNoLg0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gT24gMjUgTWFyIDIwMjUsIGF0IDE0OjI0
LCBQYXZhbiBDaGViYmkgPHBhdmFuLmNoZWJiaUBicm9hZGNvbS5jb20+DQo+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+Pj4gWWVzLCBJIGNhbiB1cGRhdGUgZmlybXdhcmUgaWYgeW91IGNhbiB0ZWxsIHdo
ZXJlIGNhbiBJIGZpbmQgdGhlIGxhdGVzdCBmaXJtd2FyZQ0KPiBhbmQgdGhlIHVwZGF0ZSBpbnN0
cnVjdGlvbnM/DQo+ID4gPj4+DQo+ID4gPj4NCj4gPiA+PiBCcm9hZGNvbSdzIHdlYiBzaXRlIGhh
cyBwcmV0dHkgZWFzeSBzdXBwb3J0IHBvcnRhbCB3aXRoIE5JQyBmaXJtd2FyZQ0KPiA+ID4+IHB1
YmxpY2x5IGF2YWlsYWJsZS4gQ3VycmVudCB2ZXJzaW9uIGlzIDIzMiBhbmQgaXQgaGFzIGFsbCB0
aGUNCj4gPiA+PiBpbXByb3ZlbWVudHMgUGF2YW4gbWVudGlvbmVkLg0KPiA+ID4+DQo+ID4gPiBU
aGFua3MgVmFkaW0gZm9yIGNoaW1pbmcgaW4uIEkgZ3Vlc3MgeW91IGFuc3dlcmVkIGFsbCBvZiBL
YW1pbCdzIHF1ZXN0aW9ucy4NCj4gPg0KPiA+IFllcywgdGhhbmsgeW91IGZvciBoZWxwLiBXaXRo
b3V0IHlvdXIgZXhwbGFuYXRpb24sIEkgd291bGQgaGF2ZSBzcGVudCBhIGxvdA0KPiBtb3JlIHRp
bWUgdW5kZXJzdGFuZGluZyBpdCBvbiBteSBvd24uDQo+ID4NCj4gPiA+IEkgYW0gY3VyaW91cyBh
Ym91dCBLYW1pbCdzIHVzZSBjYXNlIG9mIHJ1bm5pbmcgUFRQIG9uIDQgcG9ydHMgKGluIGENCj4g
PiA+IHNpbmdsZSBob3N0Pykgd2hpY2ggc2VlbSB0byBiZSB1c2luZyBSVEMgbW9kZS4NCj4gPiA+
IExpa2UgVmFkaW0gcG9pbnRlZCBvdXQgZWFybGllciwgdGhpcyBjYW5ub3QgYmUgYW4gYWNjdXJh
dGUgY29uZmlnDQo+ID4gPiBnaXZlbiB3ZSBydW4gYSBzaGFyZWQgUEhDLg0KPiA+ID4gQ2FuIEth
bWlsIGdpdmUgZGV0YWlscyBvZiBoaXMgY29uZmlndXJhdGlvbj8NCj4gPg0KPiA+IEkgaGF2ZSBh
IHN5c3RlbSBlcXVpcHBlZCB3aXRoIGEgQkNNNTc1MDIgTklDIHRoYXQgZnVuY3Rpb25zIGFzIGEg
UFRQDQo+IGdyYW5kbWFzdGVyIGluIGEgc21hbGwgbG9jYWwgbmV0d29yay4gRm91ciBQVFAgY2xp
ZW50cyDigJQgZWFjaCBjb25uZWN0ZWQgdG8gb25lDQo+IG9mIHRoZSBOSUPigJlzIGZvdXIgcG9y
dHMg4oCUIHN5bmNocm9uaXplIHRoZWlyIHRpbWUgd2l0aCB0aGUgZ3JhbmRtYXN0ZXIgdXNpbmcg
dGhlDQo+IFBUUCBMMlAyUCBwcm90b2NvbC4gVG8gc3VwcG9ydCB0aGlzIGNvbmZpZ3VyYXRpb24s
IEkgcnVuIGZvdXIgcHRwNGwgaW5zdGFuY2VzIChvbmUNCj4gZm9yIGVhY2ggcG9ydCkgYW5kIGEg
c2luZ2xlIHBoYzJzeXMgZGFlbW9uIHRvIHN5bmNocm9uaXplIHN5c3RlbSB0aW1lIGFuZCBQSEMN
Cj4gdGltZSBieSBhZGp1c3RpbmcgdGhlIFBIQy4gQmVjYXVzZSB0aGUgYm54dF9lbiBkcml2ZXIg
cmVwb3J0cyBkaWZmZXJlbnQgUEhDDQo+IGRldmljZSBpbmRleGVzIGZvciBlYWNoIE5JQyBwb3J0
LCB0aGUgcGhjMnN5cyBkYWVtb24gdHJlYXRzIGVhY2ggUEhDIGRldmljZSBhcw0KPiBpbmRlcGVu
ZGVudCBhbmQgYWRqdXN0cyB0aGVpciB0aW1lcyBzZXBhcmF0ZWx5Lg0KPiA+DQo+IElmIHlvdSBh
cmUgdXNpbmcgQnJvYWRjb20gTklDLCBhbmQgaGF2ZSBvbmx5IG9uZSBzeXN0ZW0gdGltZSB0bw0K
PiB1cGRhdGUsIEkgZG9uJ3Qgc2VlIHdoeSB3ZSBzaG91bGQgaGF2ZSA0IFBUUCBjbGllbnRzLiBK
dXN0IG9uZQ0KPiBpbnN0YW5jZSBvZiBwdHA0bCBydW5uaW5nIG9uIG9uZSBvZiB0aGUgcG9ydHMg
YW5kIG9uZSBwaGMyc3lzIGlzIGdvaW5nDQo+IHRvIGJlIHZhbGlkIChhbmQgaXMgc3VmZmljaWVu
dD8pDQo+IEkgYW0gdGhpbmtpbmcgb3V0IGxvdWQsIHRoZSBwaGMyc3lzIGRhZW1vbiBjb3VsZCBi
ZSBwaWNraW5nIHVwIGFsbCB0aGUNCj4gYXZhaWxhYmxlIGNsb2NrcywgYnV0IEkgdGhpbmsgdGhh
dCBuZWVkcyB0byBiZSBtb2RpZmllZCwgdW5sZXNzIHdlDQo+IGRlY2lkZSB0byBzdG9wIGV4cG9z
aW5nIG11bHRpcGxlIGNsb2NrcyBmb3IgdGhlIHNhbWUgUEhDIGluIG91cg0KPiBkZXNpZ24uDQo+
IE9mIGNvdXJzZSwgSSBhbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSBhIHJlcXVpcmVtZW50IG9mIDQg
R01zIHRvIHN5bmMgd2l0aC4NCj4gDQo+ID4gV2UgYWxzbyBoYXZlIGEgc2ltaWxhciBzZXR1cCB3
aXRoIGEgZGlmZmVyZW50IG5ldHdvcmsgY2FyZCwgdGhlIEludGVsIEU4MTAtQywNCj4gd2hpY2gg
aGFzIGZvdXIgcG9ydHMgYXMgd2VsbC4gSG93ZXZlciwgaXRzIGljZSBkcml2ZXIgZXhwb3NlcyBv
bmx5IG9uZSBQSEMgZGV2aWNlDQo+IGFuZCBwcm9iYWJseSByZWFkIFBIQyBjb3VudGVyIGluIGEg
ZGlmZmVyZW50IHdheS4gSSBkbyBub3QgcmVtZW1iZXIgc2ltaWxhcg0KPiBpc3N1ZXMgd2l0aCB0
aGlzIHNldHVwLg0KPiA+DQo+ICBJIHRoaW5rIG9uIHRoZSBJbnRlbCBOSUMsIHRoaXMgcHJvYmxl
bSBpdHNlbGYgd291bGQgbm90IGFyaXNlLA0KPiBiZWNhdXNlIHlvdSB3aWxsIHJ1biBvbmx5IDEg
Y2xpZW50IGVhY2ggb2YgcHRwNGwgYW5kIHBoYzJzeXMsIHJpZ2h0Pw0KPiBCdXQgSSBhbSBub3Qg
c3VyZSBob3cgeW91IGNhbiBydW4gNCBHTXMgb24gSW50ZWwgTklDIGlmIHlvdSBhcmUNCj4gcnVu
bmluZyB0aGF0Lg0KDQpZb3UgY2FuIHJ1biBvbmUgcHRwNGwgaW5zdGFuY2UgY29ubmVjdGVkIHRv
IGFsbCA0IHBvcnRzIGFzIGEgYm91bmRhcnkgY2xvY2suIElmIHlvdSB0cnkgdG8gcnVuIHNlcGFy
YXRlIGluc3RhbmNlcyBvZiBwdHA0bCBvbiBlYWNoIHBvcnQsIHlvdSdsbCBydW4gaW50byBpc3N1
ZXMgd2l0aCBlYWNoIHBvcnQgdHJ5aW5nIHRvIHN5bmNocm9uaXplLCB1bmxlc3MgeW91IGV4cGxp
Y2l0bHkgY29uZmlndXJlIHRoZSBwdHA0bCB0byBiZSBzb3VyY2Ugb25seSBhbmQgbmV2ZXIgZ28g
aW50byB0aGUgc2luay9zbGF2ZSBzdGF0ZS4NCg==

