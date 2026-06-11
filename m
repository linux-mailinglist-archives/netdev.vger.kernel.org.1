Return-Path: <netdev+bounces-298189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2mW4M8naKmrJyAMAu9opvQ
	(envelope-from <netdev+bounces-298189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A3673415
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:56:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dMjClfcg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298189-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C71DF3004621
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630ED33B6D1;
	Thu, 11 Jun 2026 15:56:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DA1BD9C9
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:56:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193412; cv=fail; b=Tr74e1ujILsKKsgMVgUxqtAWOz5eTMSdKHOK4Fv+BQuRNHZJ3HOnkn/m22aYETIuNbI5Emk2MhtMXB3xBz8yvTxIVF/vJGaQoE4901oBsAGsaRGC5PFBrwuQ+xYvun/tzxE2slogGIQiKHA9bLr/ltMlodUBsJCv9hkSOPh+nlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193412; c=relaxed/simple;
	bh=THW671YmYFhFISa6o3vSgyGOJCI2Dhog9q0Z3KZhmBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkYBVMFdHiNRY0DoA6FB1TtN7saFvRd8T+w75B4If7YBcSleNrqjOZ4sVlaL4nyuhIMzY98rkGjximxz9rttDfb8GVO7PBQomMPXQ1NcUweh4GfkuJ/dvRsCy5zMyLsaCUC8EWoYGy9JvmlGnROY20n46kHAbZnuMsmlb0QNUY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMjClfcg; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781193411; x=1812729411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=THW671YmYFhFISa6o3vSgyGOJCI2Dhog9q0Z3KZhmBc=;
  b=dMjClfcgn4DYxNd3nOV/60bnTBQMimv/2UDfNR5+9d3I4wMPBy84GkGQ
   q3HImj6+bJzoZpqWp+JhYvgAgbqE+8c3yCOUF9poJ58X6yFQ1t3r2cAYB
   sNfvOY+tRZsCm2IlAOO496U3xkkFUvQRMdfHCgkiJrnajAK74LTa1/uzu
   +bYxROyj7UJecu5EgHs98lBSD+ITqxYQroKLAZzBYgG3GrrL8VNf3CKg1
   xl7wb1/WvB8sgd1I2TxM+XCm0r7f2cuzctu9izmdeANCHlm1fWvxEsULm
   rOKHoqnswtSj/cnUDVQbsZ31gxHGgyhEQYaJ5E/gcohX13vnEcpgERFr1
   A==;
X-CSE-ConnectionGUID: bhoDCfzsQ7OCaE6Ujq2jhw==
X-CSE-MsgGUID: Oyhw4LCdShaKD+YwJJYg8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82016610"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82016610"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:56:51 -0700
X-CSE-ConnectionGUID: wS0HJptQS0W2sjqiAx2ofg==
X-CSE-MsgGUID: 6DnSWFpjR8mWQ3a8YND87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="243583598"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:56:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:56:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 08:56:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:56:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6XImw0RNDdsTsPI+zXa4aUWAlJ8S2dPB0bc2lTpWO1IcdMNaYfFIt6yvuJnw7NZ2ImFsSLfOL7xZMySJoef6YrpeMcr/DVL2nsiYOmfsq/ajRAc6T+wpDtr7siPytDm76uaZyZbqSf8MoG2S0bbPSvl460iRkkzWKw/xBTn5ITjLQhEIzHEPc7I/oqAoX+RKcg0FG2IwnOk5J1Rdrt3GrO4d9fHWb7LXv869Wm9db6TuMQVG6sri/gDkoF2fChbBpwTf8uo1+eLoPRnGbEyTFKVpySswaghvM5n4p6kNBbwQIQ6Zs9JzIW7PeOLWIO/zR1WhLbA9qc0BBtkkJTi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4cU9QcN82ys3Fm+qrsCaebIRozDxCkOtWWuduIoVOA=;
 b=W922TaiuLYSCxitZl/mNZLNbwsy6LOfLTySncjJz1rpdtkkrS5BVjgf7zouNgqHIOjBdi35OzapSKFh2bl0TeXCJ4wjh0divkTS64bBkvDEXkIqvhYYsvvsy3MpD7vOSE6g0Th4xWGKLM8guGN3QQu0gRo1+i8YEFukUX282d+OyCvqnN5L+bJ4wgSKHR5/fes6PPfcSxzjmsXQaeDLhrf5lqD4uOC0AY238wvFRb1+skTQdHox/T9AMPdXILqTqTIXpB4Gf2dsaN1HCsWgBnCJY0v/Becjqk7xBUwccbRDWsa38iykkLUHdy5otJsZhOcKsvxFRnFskML0wj0ohDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM3PPF9EFFC957B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:56:45 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 15:56:45 +0000
Message-ID: <41d3815e-f060-4003-9974-42530addc641@intel.com>
Date: Thu, 11 Jun 2026 08:56:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: "Rao, Nikhil" <nikhirao@amd.com>, <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM3PPF9EFFC957B:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4b2bbf-07f7-4ccc-926c-08dec7d209ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: m/QPk4AlUUi1C4mkg1qSWPUf0JjLAAXwrXKIamWRfnl8ZLSVCIqZoBLDOGRyOg1U59V9ia1E2CTjb/hFLUdodxlQ5GSG8zyHzlkERDkQlgGreFZVq7DbJZqhVvTyx4zb9gdaRc3cFAaCz64HQS70absy0eMAXqBSFHOutDjh/WPdRynotRpYtYtihTh9e3kCABwfLmUjuzayq3J8y9rR/Xo2Ff7LsgDgxMLgoQoG+GsMHrjRdPxhz7mmEAVF4xwGOQTk6P1HU8vHHR8+K1V7bkd7QvYJFj64nIWcJUiZTftgOcms3zziM+4ZkokfRmggTRtO2Wc6InwRfXq1OSauvyYZ6hFZDgAonK1WPACRI5Db1Z49uylH9oS3ZjzXXvCfRycD80cPM1xgdRrk+RLbLaLvVR/m3PtmYi0/ZSnrGrfx9uUjtbVBETeGj94k8gw4AFXfQJ9jpOhV2F8Nzutj9ev4d7Rqzq23+WI2CgEiee2UbgbszeRyigtmJd0K5wROq+tSleqS4aMRY8WBb4Ik1mKdN4GqNIyF8XIOTXF/JsJHHPd8h9SbPSUCYvlQTkQ2HP/7nIPxQu6LYSZ3Ac0TZXPG1OTKtkrm+gYekiBWQMC8kyAgxy1H7uX5ZIPOGJw5BGYSH3kGcr1hbzwH890UohLeVNJS/xI4W6tq4HhuFy9iVkmzMwkC/PG9kTbwBf8w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWI0emdrR2R1bnpxWXlsQjlJTGYwSDhpeVlWYzRtNFpWQ1RCa3NUNHhaV2xV?=
 =?utf-8?B?S1RJOUF6S3FWV3laMTB0Sit4S3dBZFQ5ZEZBMWVNWkwzL3grbitlV0htTUNH?=
 =?utf-8?B?YWhYZk1ENWl2OWNTV1RKbmppZXhYODZqaVA4cFYvL204M1dpYjgwUUkvMWt3?=
 =?utf-8?B?QzVOOVByWXpUSlBNL29GZkxxRjZMUEFidFl6Ykc0RGliU1E1S1VlUThFQTZN?=
 =?utf-8?B?b3M1eTNmTFFXMTdxQTFGL3drMklWUVE1SDhHY1BFQU1pc2Yyc3BnU2JQUVhj?=
 =?utf-8?B?OVljVW1vVWNjTGtBMC9NWWl4Q3BXUUtDVm5mVzRBYjAzQm1HTkZGWVZVcmsz?=
 =?utf-8?B?aTRydWdNSjl3TmN3SU91alAyRzB0OWNyVnlDVndCNUJLSDlTRDVDL3U5eTlX?=
 =?utf-8?B?K21XL2REN2RHSVg1b3ltNWRJWGFDT1dhSUxDOW5NcU9WcmZBcXptVi9aK0Rt?=
 =?utf-8?B?c2ZORmtETHc3dDBMMU1GSThaQUNTM3RtWTcxVk1lTk54YWhWUk9GUWZ5VUZO?=
 =?utf-8?B?bnhvQ2RrT2VyTk04eU4wOHlBOEc5WTBxTzJsRkZNQ05EQVpzR01NTC92NGNY?=
 =?utf-8?B?dUlQTHJCRkZCaG85Z2hEWlNzQXgwemFTMTkrK1ZDUkcxcnhCUzRxNFBWVkkr?=
 =?utf-8?B?M051Q0hKYXVtLy9MUExjSXF2QXBMNjBCbysvNjFhR3BDSEViNnh1WXpwaksw?=
 =?utf-8?B?OUltNWNjdHBZbm9ucXJCSmdqWGtmcHVmZzB2bjRrbERUUzVLRE1GeHFEdU5X?=
 =?utf-8?B?VXdlNndMQWlueERJQjJESjltQ2xyTnhlVjl4RVcxcVM0WGFoV3NQMG1EcFFZ?=
 =?utf-8?B?TjJRY0tHYnRqemw5RjFuQjk5MDlwU2s0cEdSWEU2anNjQkhxeFptb0NWRHNh?=
 =?utf-8?B?dVdKTkhBc3ppN2tESUw0ekZFa3dyTEJET2YwVjVPMTBVc1JYdFpHMldIZklK?=
 =?utf-8?B?eVo5TElMem02UEJqb0dKTEpkcjdCMXZzcFhrbTZITktBR3FmTGdLSUxDZiti?=
 =?utf-8?B?emxHREg0YjJYK21VckxtVDhxZVN5NUQ3MzhBcitWZ1RiZTQwbXI2NVFUSVNj?=
 =?utf-8?B?UEVMdmdjYWdOTnMvREpjYkJicGN3RjNPVnRYL1prVkwxZERiemNGeXprVVFK?=
 =?utf-8?B?U3RESzVGdzE1eTFKWE1Wd2YyM1VNdk54RTBMUDJUOUdFZzNva2RnQVZHUGxW?=
 =?utf-8?B?amxHVEJZZExLV2ZaOGNXR0tzRzdDcU94SnoxOEU5VkREQVVQQUZuMzZsQUlU?=
 =?utf-8?B?WFF1UGIyQ0kwb3VWZWFxWGJVT1JSemw1UTJoQ0EzK3BPbmFKdEdvU1pYM0kx?=
 =?utf-8?B?QmJFT0xYQklRM29IV2RYN0NaUWUybkxPKzBOaDZvNlhHVEJjQ1NObHdpRFhI?=
 =?utf-8?B?ekdkbEl1dkJVWFpwdEN3ZnAyZnMxNEF2REZ2eStTeVRNTzVTTGhicHIzanVM?=
 =?utf-8?B?QTloSVY1K0haKzR0SFI2eXptaVM4TTZlbkpJY245RkJ4TzhrYlEvR3RpY2M0?=
 =?utf-8?B?eUh5SlF0NElEMm85MnZUUjkwOXl0QXBiL01EZVhCcnRaeHJ2L2UxK2JyMVdT?=
 =?utf-8?B?Zk84ajRsVFpSbmNrVVlZYm0wc0tYbkprQkNRbWw4WDdDLytxSEUwdUxpWHor?=
 =?utf-8?B?Z2hCSXBTaGsyWlRjY1ozSTAwcGFNbEVGV3FrakZVSDFtSzFYMUk4TnlidW1v?=
 =?utf-8?B?UUxxY1JDMHl2bytkY1FMZ3RKdnY4dHc2bVJ3TWFkODZ4VWw0MVAyTHFJZ3NL?=
 =?utf-8?B?MUpNUHNEcVd6WUYwNEplZUpqQldHcXppZWRVcDVUOW9pMk55VHRNUUJIYTlz?=
 =?utf-8?B?bE1kYjZqZXUvNHp6dUVINXFtTnRiZEkvd3FPa3VCTnFGcUxmcllmSm10Q1BX?=
 =?utf-8?B?SlNJYVVMU2o4b0VsUlV4RnlpNFlIWEtHejVSbzJXd1FXek5TQjZGM25Xd2ti?=
 =?utf-8?B?TkVxQ0JQYnhQSndpU2U3U05KV25NeFFhb2FKc21QYnl1THd2cTN1SFF3VUVh?=
 =?utf-8?B?VTJGS1FZcWd3NkJKTTA1SkJid0E3Wk9MWHBOcTNLR3R6a25mdUlFQWVOUTRL?=
 =?utf-8?B?YXhlYThHdGhuekthT2RyNndiN0RvSi82ZGJoUG1HYUh1aEZKWVJVVTZIdTFv?=
 =?utf-8?B?QU1YZ1cwRmF0aGswanhXam1zQTJCemo5eExQeXJocFpvcjVGcEk3Mm8wb3Mx?=
 =?utf-8?B?TlpUb0d6TDlpSG5IUVR1eGswLzhsakJEOHRPaFZaZjkzL2QxS0FhU0cwVm0r?=
 =?utf-8?B?cWp4V3V1STBhOTlRQ1liUzNsV09kdGtFZGxaOERWUVhPdkthTVJoNHkvZjN0?=
 =?utf-8?B?VDBBR3FRekpXZEU4SExVWVZjWmMvd0VaZ0JHbGJFbnZ6N1hjRUl3ZFpjUFZv?=
 =?utf-8?Q?4f5IBFzY9EuBxzBY=3D?=
X-Exchange-RoutingPolicyChecked: UCIXy2BC8K5G3QwwrPcsOLyq0uaaKiWSLC6R94dxleYREKXlsO3/ul+LfthxniQDxMOS1hL29DhlAFFN9JZaGt2ivsnEADq64PR+NG/aIze03OtTD1fQlYR4JouTV6p1BaClaPzcJIxbrEA0VoIb4jwG5CZfCKDmMGh2CKUY0w5FWITf+stoLX0xNcCD5l7AcinKtaqmGQIYnKWkfm5xxKX2DK9amKQ8yz/zw+217m4u92wxgcaM3gU27H/WZlRBBYkD+7BXEGBUsl/DrdZAhVLCoAqTYa4Sqp1ISGj2clMkvxV+BDZWhd8Sd6nDM/3NUGGhlhhix64DWPxzE0B1dA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b2bbf-07f7-4ccc-926c-08dec7d209ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:56:45.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgIwjGQhM1o91AQUi/kRwSpbn//jnti6u7ncMk31jsMKpV2ZKIlhZIL95r5+o+/taxfB33fwy/7oYpxSVzR0N6829Ox18XWmDiT84sqw6cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9EFFC957B
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhirao@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB9A3673415

On 6/10/2026 6:14 PM, Rao, Nikhil wrote:
>> extack never propagated through PLDM update path
> 
> Valid observation. The PLDM update path returns errno but doesn't
> populate extack with detailed messages. Usability improvement, not a
> functional bug.
> 

If this requires updates to the pldmfw core, I'm happy to review and
accept improvements there.

>> Vendor-specific component names
> 
> Compliant with devlink-info.rst. Driver-specific component names are
> allowed when documented. These are documented in
> Documentation/networking/devlink/pds_core.rst.
> 

The preference is to use generic names when possible/feasible. I think
at least some of your name choices could align with the generic ones.

Could you explain why fw.mainfw was selected and fw.mgmt was deemed not
suitable?

