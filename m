Return-Path: <netdev+bounces-306510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QtOTAazJUGpy5AIAu9opvQ
	(envelope-from <netdev+bounces-306510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:30:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDD739B55
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:30:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=DMxmsGQ9;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306510-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306510-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78582300B9EE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FC405C54;
	Fri, 10 Jul 2026 10:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF24028F9
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:24:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679067; cv=fail; b=UaUibGap3GH5fA/NDqPKUns5YxXkQNUfRoQIoO/Ijl92jpnzeQDx8aPoGe4rwzCoaWl3WK0K5YsachalSPqLLFNWbEO49aQS7d1aAnBoOc6oZm2WQtvpnKE4cJCDmRI85opI9bKlckjjEH4u1js87JOUvgcgX91bSySvlfmdyPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679067; c=relaxed/simple;
	bh=oWsSO37rzVg9gGrv0fIwNK2We7CSLP5vnbm7kTXeZgM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OP174QeuHfWXsByl7QzuwYVElhywvrSxh4yzrmoxpKFOTgaj2NcKnxd5sSspXVU4t2Abx5yZwHG97afFhFlZFz5B4XAtnmOVWO5dudVaCkqYPTExtIDHY7VH4OhTCGfFo7FAvSMON2Y+ZViUs89VGSg81p5tPu3Ct1V6bt+eDRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMxmsGQ9; arc=fail smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783679065; x=1815215065;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oWsSO37rzVg9gGrv0fIwNK2We7CSLP5vnbm7kTXeZgM=;
  b=DMxmsGQ9UERUrQseYyVpr37QgnnQsDTho8N1IyQkbbCKLPtaQBqOK+mB
   ScRbYUk5txsTuoohkEpHqL481gG3AIbSQ7rnHJyjwKrGxOuUKKvflOY/v
   1zCWAE2wmFlfULEd3AZzs1pkek82b19ZT7Ag9/VnPyQSsYfQXnlMOk7E+
   fKi2BXoi9/bFrORV7CoX8DaNQXnRujYVO72CWQJ7vmoqrhUSBC7kPy68z
   fzNsS+FSZqL5Vgo3nqoJsvDdY+BK9+CIBl1ydc16M4O9ObqK7J7h6vqxH
   B/90fEOZmLgU6z255BrpSvUnF7un8jiOnsiEDq9G6mHcSBaPgjkQ4wl7F
   g==;
X-CSE-ConnectionGUID: 8Zf3KQS9Se6+ib6PSUJLdw==
X-CSE-MsgGUID: 3/bEUukZTT+G4A3xmF4r7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84157237"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84157237"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:24:25 -0700
X-CSE-ConnectionGUID: BcU+PIihRNqLbvAWgluSdw==
X-CSE-MsgGUID: Gyo0G5ISRsCcYsTN15wMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258733646"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:24:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:24:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:24:23 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:24:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP/HQyX3BEjWBY/IuFYDgD7APg4YY/l462vgMFWrxiRCxh7OJKAJNOfKzmpM3k6Q8Wk0WliPR1qscP/kXTMt0rutrwe+bESzdaUqg40i4kQMYaimt/tOvsuEv7oQrQCAIrEdPJIb0HAKQN3rz+PH/Kwmc0hHqEa/L7E/H1Ewap5la5wvDQzozv4+TDPGpaptYikh9SJUIw+bEMcwxZxOgtY6zu6Q9PHNGFVTuuw8m0Gk5sPvegQKEMp7GOBf9ER1RvUwzixdZGozUxyWFhrR50BVwmx4mmWtWqXMPVUZ+qRccfGN7EsoRL5CXZ6Pd4+UeQaC0G7rUMV2/nbhyK4zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQQbkN/4ZNm25Wr9UGJz4HNOEEgvLueTMoGQY5o50yk=;
 b=GHyEaJIx8+ZG1GdRaUuOzXR4m48fe7TLogGhpQpQW5YsrWi656cv1rjwX8yDHZUVWEDRn1hyU9yJTZ/iiVAhWhWOk5WpVyDO7hkDIZRmr9yobvJCxhO0LPhKyA5MPllvrGXP4DpQdsnWP9yHHmKvJw6bvP+zeodKstvUm3iSU5Kx8zbvcew1Z0WzUvBrus3ZvwnMVHjlNAd/zh/MAO+bpMqWI4bzlhJBf3IsHvTAytq3+jI80XuqnkUZdoM7VsRQaG6JOH2lQJt7XSgjIQ0TymkjgbxYyu1bIk6qef4a0RyGygQ28bbmTy7v/Wp+NW9HVDEOQtX0bcAmxjxjVyqstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 10 Jul
 2026 10:24:21 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:24:20 +0000
Message-ID: <6250062a-55c0-408f-a057-16e4004127f5@intel.com>
Date: Fri, 10 Jul 2026 12:24:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] net: libwx: add support for set_coalesce
 in wx_ethtool_ops_vf
To: Mengyuan Lou <mengyuanlou@net-swift.com>
CC: <jiawenwu@trustnetic.com>, <duanqiangwen@net-swift.com>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
 <20260710015925.34769-3-mengyuanlou@net-swift.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260710015925.34769-3-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::12) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|PH0PR11MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6448e7-2ff8-4a76-1983-08dede6d678d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|18002099003|3023799007|4143699003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: LMY3gTNXw+bOFU3dBe6Spy6fEcp0A7ZeV/O6d68RuCnoSimry8o6CXxh3fdvfgB5M4nB6/uf4F74lSHuIUardFxE7XcO4uarZv1haaI1lx+3zvzHnWWfkLc/jdSOE4Vff6jFwkZevk+UcU3///tJfWallwLMIgpsDJy7uiW6aF6V/PDcjoqsxjwVNVlQKMr7ME3hstY6kv8aRvHHowIC+AXZ6Ebsxe/yZULme6TR2qfSZFDNQTRuOhJ59DRabaiElbyfO5I39OGalI/snc1qv84FLFL7og9I67C4EEhauzRiCRSmC6aIpb5l++QNPZYwZbXP0UsjZ7pRvEXmJVCqOhFDhioOc4wr6Tq7AavarrGJJ+jL5B6Q27lqf6ijMLDUl3ReBZDUFvPrGB11zjzwamVXve3tXlUnc0tBdNH9Xpux9ApJMmipdA3k0Y9494YsROFCTfITRH0+D79FDcIxDrGV1/5+Vy9GaYwymM93sgYC4xVKnfTwYN78icxxtQ1yyygm1LdLVN3U8vU3nA7RUnfg5/D2ntKQBpcuvbQbdX7yRUbi/6GIztDenasaEEa2pwBSFDTpX4gh2OLhxAhKcyoW1RNrxgOx80wJx2LSuC+U0xrb3R5f+LGRbCdgEY6NvtVi1CNnF19FreLghuT/VS8XCHNcOPTmDq9k0YCpWgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(18002099003)(3023799007)(4143699003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1ZvNFlJdzd6ZnlOQlJEaEpYc0JNTklSMkoyMWZGMmNwdGhNcFBncXNnZkxF?=
 =?utf-8?B?S0NQcnY4blF2d0thZC9MQjkzc01lQXR2aU1kaHRCNzc4NU1yNnM3TUtWZTk3?=
 =?utf-8?B?UGZQdlVwU0UwMXlJNXk4NnJCdEJvcHhVNEhWbmxDR2pIQThqL3IzS3YxM3VT?=
 =?utf-8?B?NWI3OHUrV3R3VlZ1NVBMYmtDM2VKd1FpMzJnWDNvemduRVE5QlZJb1dSTFQy?=
 =?utf-8?B?a202d1hWV1I3U2VHWk45TUpYbWhXcTVsM3l6a2VvWmYza3hOR2JLMndjUVJj?=
 =?utf-8?B?MWNRcG9sZ0RPempEUUtqTjIzLzdTU3JacFJnUVcxZ2xpYTBxYmFHU0xUNXZa?=
 =?utf-8?B?a0xEQy85VXYzSHExQWhkRS9mSnMzWjNSQjZXRWJTajk2bUNGZWZ2Qk85clUr?=
 =?utf-8?B?Z1JuNHMzdW5JTUdSZE9neVJHVExvc0QzZlVYcTI1ekxOMnppQnd5MmEzUjRs?=
 =?utf-8?B?QmgzUjNEL3JjNzlwdkZJUWJSL0MyaHZOTTVBUHpwaWNHaE1wanJIdzF0Uktm?=
 =?utf-8?B?NzZyR0RlMjhaeHE4SEpCakxPam5HenFDWER5OG5GMjFCM0JLZGNSSW9ZaDda?=
 =?utf-8?B?NlZtUjYvN3FyZjcvRlJ3REdVeUxRT1E2YmhqcWc1S0lTcDc3QmVPRThySXNy?=
 =?utf-8?B?MFdMelFTWUszZXpVWWk1SFlQUndramM2Sm1iUXRrMlNhaEYrcGtxbEJCaFYw?=
 =?utf-8?B?Z1VpR21KeWZobkZqbHZXM2Q5Wjk0SEVLL3pEZk5ET21Salh3OHZDbDJEUUQ3?=
 =?utf-8?B?cThyS1RwZERzMi80M01DMDRUMnVQU2xRRnhiL0VvWXcxVTZmWXFtYWN0VWx6?=
 =?utf-8?B?L3ljN2NUczhIcDV5ZzB3bjNKbVhlSDBOQThHRlVKM3pxY1YrclpqNUsrUXRU?=
 =?utf-8?B?Sk4zU2hZMGVXZlc4b0t4TzgvcFhVaFBVS0MzOW9mVERiU1BsTHJNRm9Sb0ZZ?=
 =?utf-8?B?R0Z1TWdxR1ZMK0MxY2w3R05NcVVHZ3dNakJ6cU8wRzVQZFNOUjJWQWFwQ3JT?=
 =?utf-8?B?UElLcmJIcjRaeWM1eXdPNklhaTVob1ZrYkFRRVZmdklkVGsweWc2SE56T3dH?=
 =?utf-8?B?YzFsbkFYSjQ1OE9WallKZnY5dDhjZExvYVA2cmw5YWkvY1JCTWJWc2VzRE9N?=
 =?utf-8?B?cHA5M2VOb0FBM0VDMXg2OC9hNTZGMGJ6ZHdiK252S2IzWHFRSWorSUVHbnZU?=
 =?utf-8?B?ODh0NXFES0ZzNVVicFpoVGM3YjBsdVdvVzVCNUExY3RWSTlZcEp0UU9nSE9I?=
 =?utf-8?B?eWVIVjY5K2ZWeEtyQWJjUWtmYUtBR2tFYVVCb1FOYUF2MzhhT29ENGFodnFB?=
 =?utf-8?B?UTFmcFlYZ2pnd0U1YUF0a3IrblZhS2hnSUY3MHlMT3NtdUNxSzAvZWowZGtt?=
 =?utf-8?B?WGFLcElpdy9EZTAvaFd2VmFRQ2d2eEZWd1ZET05OSU03anpEODJRZFhnY2J3?=
 =?utf-8?B?amRqZDN1RHE3bXZZbnlaUHEvQWk2T3lSU05menljWkVUN1dwS3R5MEJVdHZ6?=
 =?utf-8?B?Sm9Gd2hnSUhaUzFUckh6Qm9aMERYSU5qSVNNdVlub0swenJtNjJ2MkVnYTdZ?=
 =?utf-8?B?MjJkamNTOGdVcHNra3RqczRudUV1dzRnakNpY3lTS3ptcHRoNS9sb0xwUEQv?=
 =?utf-8?B?bXZJdDlTRVpBc2JISFF3U0RuMjR2TklZNUVhbXhTeXI4ZUNYZUJwM0h3Q2l2?=
 =?utf-8?B?UXNXaWgybWtpREJhUXNPQ2V4MWpJT0kwMkNMTlNHMHdXOFRyTTVSNUZnTEZm?=
 =?utf-8?B?WUNxM0JWV1lhenNjRXkxZE1XQ2pSd1FGSEp2ZEJqRExQemp5TG1QYXBBczZN?=
 =?utf-8?B?bXRtMWd0ejdOUGJ2aEFUYThBeThBNmpXN3RHSXQxSUZjbFBxbmdoSXJYaHVm?=
 =?utf-8?B?T3FPQndiRTc2Sis2dW9NOUhBU1hmSXpJcnNrL0NNMnIxQ3VXekMzYzBHZG83?=
 =?utf-8?B?c2wzeGRPWVZqdnJDbDZiK1ZuN2VVMjBoNHdicVVVcUIrTFBzTVdLZzk0dHNC?=
 =?utf-8?B?b1lacUpPOExTTTBNRUhPNy9nRzJibldLRm00UTk4ZXBLMnlGWTFNT2lOVXJP?=
 =?utf-8?B?cUVkK1IxNk9aY1Y2TTdCWXROeDFpekpVME15UTJ6aXZyQU4yelcwRkIwVEtm?=
 =?utf-8?B?VGVBSXRPWEUwZlRUdFpMcmVPM3N2OVRQaTdqcVBmRjdiakZoUmZ1QTBlRVJB?=
 =?utf-8?B?Y1ExNmlVbGlFeFdNV2kwMDF5K3ZJZkRzdWRDdTVXNk5RUHk4Tk0xMGxNUkcv?=
 =?utf-8?B?dWp5WWs1WDhoNGpHQUtYeUJUS1lHRGV5emNZV0UrTnJkbEp2T2hLMGU5SXV2?=
 =?utf-8?B?RGo0VU9yZXlwak5DZnUxZlJ0OGo4NXJjbWVTZ2hIa0ZkV1V2YWEzdWg2YW1B?=
 =?utf-8?Q?giNa5BiPg+q4AqIk=3D?=
X-Exchange-RoutingPolicyChecked: hujtHlsHzoUIV95pxVUuXt4W4dmdAex8+Py0KX9NwCEVTFz/ZUIEwSGgqAtp85QDIQCgGpKSbHrUscuOwKOS2nGLXDalBKpE0W4lKY+FrXcj4iBalxbQkAzMDcOyyABmUxryvxsUvYROaLKEyViCu79Nu4XdKaKs/EFXvFHHJKshqPHxsa4n6FpVkGlkjluUKPEXRYAG/PPlasf1Tv4YyYwqVtnVxXYAlT1nLZPf8OSrqUA6n1vLP8/p5MuCkx5jhp1ydM1GSnBYjfGFRVehaB6A/8Pli2qaHGpOhxcLBfNXbGSWhqcTOJQsmoghcUVQ8SIlCXktnrPb14gBCtYQDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6448e7-2ff8-4a76-1983-08dede6d678d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:24:20.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4dDwc8AyP/jLE7i8X96ej6b6uOEwbW7nDp/3RvA/DtRv8gTsQze4A8hxNWCCRsz6gzB1PThIjDl1OdcV9JWdfoBlxcQspfnEx7uD4Pq/b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,net-swift.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34CDD739B55

On 7/10/26 03:59, Mengyuan Lou wrote:
> Add support for set_coalesce in wx_ethtool_ops_vf, which
> is used to set interrupt coalescing parameters.
> 
> Update wx_write_eitr_vf() to use the same interrupt
> moderation encoding as PF devices, since PF and VF share
> the same register layout. And remove the now-unused
> WX_VXITR_MASK definition.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/wx_ethtool.c |  7 ++++++-
>   drivers/net/ethernet/wangxun/libwx/wx_vf.h      |  1 -
>   drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c  | 13 ++++++++++++-
>   3 files changed, 18 insertions(+), 3 deletions(-)

looks good,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

