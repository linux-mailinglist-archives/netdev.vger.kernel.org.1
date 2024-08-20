Return-Path: <netdev+bounces-120188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A4395883B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607A02848D9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB55190663;
	Tue, 20 Aug 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEJF3/ct"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582C190462;
	Tue, 20 Aug 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161664; cv=fail; b=FcnfGu9It3SBdAn/VH1jF/TSkFESkTNRo4YDevbKlt0Tny4C7ycBM5N6xTkqZ0QP4LSSpPjySLCbf/64g8Dm3WlCmPYoq+xpvby1X2LBPR14HBoPTm2n6jmm695V8QsgG2lS/A6NE8+HwZM+1notb+ekh7RGP3L+BTBrjwUyGwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161664; c=relaxed/simple;
	bh=Y69EqoUZ7rFiUQSIni33TDl2qGU5829cMEQArkMwfAc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UFLrBlWF2iO5fnQidibNKG7rYmVr9uZpLD/g8e+YRDR29cMsqBhtuClSjcWRgUMxzaV/XiMCMmkodbZrLRoOCfrDoIUscEIwEGtO5N2JQmCaQ9fTZa957HoOmjm74sABY8c5uL14u7SNjMdApopgG7DXFXnZ6Q9wXh2Z0/QpWbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEJF3/ct; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724161663; x=1755697663;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y69EqoUZ7rFiUQSIni33TDl2qGU5829cMEQArkMwfAc=;
  b=GEJF3/ct6Wipz4ulgGUU7JCb83S1NRKRyzsqPwHrKwdM7HE4AeFPtE1t
   IK2UcOKx7VWVButZiS76RRJVD1h2Z3twezykG0v7riI2bTnYxGaURudgj
   UHUuq5YoJDQV2ON05j1PL9cPgQ8IiRa2SVgvsQvz/wOf4SmnTOOcBBn6L
   ArgCH85kgoJGguFbC9p7q7Lih2VhYkyqWcWX4Rzob+I2Yuxlywqzvwx/E
   UsOZ03yc88km/4VHQBRhozTHAoI8e86HxZykGdSb/sVnPGIfLxjpSWWmQ
   5TmtePn/x0RKK6oHXS/eWc8vv6hgSja8gGKSsEAOJ1ez0+gvS8ESY32RP
   Q==;
X-CSE-ConnectionGUID: zD6tLDMATuC1UJ/lKpxY/w==
X-CSE-MsgGUID: CAh8sljgR+yB5x7L7IkEMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="21997729"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="21997729"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:47:42 -0700
X-CSE-ConnectionGUID: eiQUa0mRTCqU6Wv3h7nOrA==
X-CSE-MsgGUID: mOzOEHEqRCeJ0NPUaBbczA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91459956"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 06:47:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 06:47:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 06:47:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 06:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tm2mIdhAXZky2Nf1VJHMFRTO5ntROa+/qngyCQp8IRAhDLAiXxYqZlYD9dRG8/e/+TzqV0XwVjFZCWxIuRTTLL00Jmct4cj3fnWbgQOzQsvjpy2Pi3qLez8siBg9AC089Eib/kGJEmXTP/SZlCnts4Rzv/GRhE3b9zBlP4Byn/4OufqhBy7ehUwjULngVCN6aYAkomIQrLQjrOGNC+fav/ZI7HU1dKTLB2FMh1MECmLQ0veudIXwQCBRyWngQQqnM3y+LTh2YI+jbL7vQtVYyHlHzOovIj7Z+1lyCb8wXB3iT5FMm2MmJjV/sd3zzLWhIMlUs121OxstJ+jFEfN9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI6MKD138kJ1MFNaFuph7RsZ27SQrdrU9CxdCGyFRrA=;
 b=cj4sYdi5NdaKzWAjdJOsbvPJQGSM4YRPkLB30zOqEjR9OaP0/6TTMJV34QbiBFI+Gp1wIDfPbF0j16ri1BWg2SF0Fjv7GVv5oxlXk36cHNl7Fn1VccAT08nFXyjA2lg/KpdWOym+H8eyU6q5Kkip+21Z4ZWOns3VdtidpHC/yWt5vcCHagfLLbTsfMilcDorj9siuHpppGarZc9guw3BMKDHZ/9ziWBXVsWe2sT7wzE5smpheXm6nfuaasbk0J4AsoJxwqvgh6JzDNT7XVCKfgJlLJPJaCYHBjZ3iWm24gkmw1eZ7s1Jr//0sCSMhDU4Hmo+l6AkEGPr0KwniOxqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SN7PR11MB7705.namprd11.prod.outlook.com (2603:10b6:806:32f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 13:47:31 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:47:29 +0000
Message-ID: <6158bc09-842d-4e65-9983-d515ea76a000@intel.com>
Date: Tue, 20 Aug 2024 15:47:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: Fix a 32bit bug
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Junfeng Guo <junfeng.guo@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <kernel-janitors@vger.kernel.org>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-kernel@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Marcin Szycik <marcin.szycik@linux.intel.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	<intel-wired-lan@lists.osuosl.org>
References: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ddc231a8-89c1-4ff4-8704-9198bcb41f8d@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SN7PR11MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: cf88ce1c-24c6-470b-e65e-08dcc11ea255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zi84UmYrMDhjTllsWE5IaURnM05qWllKVlBvMW83SkppSVV6T201RG5rVzZv?=
 =?utf-8?B?eHBwU2Exck9iTUZJUWVEaFBJcWduV09uTDRhY2dtMkRhdmtrSVZWdnRHMHZB?=
 =?utf-8?B?OEIwNUNsUTZJRWVhQ3ZFTnNvUWNCbGoxZThlSnExZWFaczc2U3BJM01iSTQr?=
 =?utf-8?B?T3dhVkVUdHdra1NlcUxNQTFySnMrbnZENGd4MFhQOFRPQTcvQ2hlVlcwcmNQ?=
 =?utf-8?B?bWttRnVTWXVzMGxvOE9XVDhLQWZ5N1RHZGs5NjNxSFlLaHZhelJxTTFNczNX?=
 =?utf-8?B?WXhlemw5MEllRjZ4SkVmVDJ4UGJyOGJURTh2QUhUamozNGN3RCs3NE1QR2dG?=
 =?utf-8?B?QSt4cGV2MWpRbEtMVDNNaTBYNUROVGtFTUpreUhKdThwQVJGRmpPYUhxNmpz?=
 =?utf-8?B?OWlyWHBUaTVGcko2ci9ZZkJYS3ZaaUd3UWpwazFBMDBtQjN5QmJSZ0xiKzZR?=
 =?utf-8?B?Q085bVNMd2JvNVNXbjRoTXFlZm1pd2pkWGYvejRPVk5ueU81enZzME40a2dW?=
 =?utf-8?B?NFlqZUhkc3hDUGVrUzAvV0p3WnEvWDN3TWRRMmd1MmtZbW4vS0I5VXJ2UDRQ?=
 =?utf-8?B?WVFRNGo4TGZVMjZEdFJMYzR3V1NqRWczek5aK2g5Q1ZxRjY2VmhGei8zSVcx?=
 =?utf-8?B?Nkg0bnZ5UWRabi9ETFVTaUNUTmRXenRQQXZCN3J0RjE3TFZQY284R1Jyb1py?=
 =?utf-8?B?cVNsVTBuMWJCZ3E1dllXcm9Xa2ZBZVdqMzlCZ0RnR3dVK1YxNXBlR1AxaFls?=
 =?utf-8?B?UkhOVUVJeGkxZng1Si9ob1ZvUnRQd2hZTFZjOUd5aTZWT0hYVVk0Q2pVSS9w?=
 =?utf-8?B?VzYxdGYrMXBhS0NITFVCR1JuL204V0R4bHVrSzl2c29LeUxJeHBFS05iYUJ6?=
 =?utf-8?B?bGd1MTlYeWhRUEwxSXFybmthaUg1UUk1dTFnWVFHNnRFVktVK3NQTmdFNS8r?=
 =?utf-8?B?YUR2NlhBanYzZ3JIY3c4T3hnb3JlcEJMa2lIUzRwMUlySk5CNXBBRTVaVUxS?=
 =?utf-8?B?T1NocjVadnhIL3NjREJOc2JWMFpCVkRLcVRwZDI2b3VNK0lLaDRXYlE2NDk5?=
 =?utf-8?B?dXZpTTgwMFBFK3BRT0pINlAzYW1MdmdDWHFROW9zSElGS1JTY0ltaHVYUWd2?=
 =?utf-8?B?ZmVlWldKV0FHS05IT2NLV3E0c0VSNVlsd01iSkZldnlyOVNLUGg2K2FaQ3cw?=
 =?utf-8?B?bFFXOWJBRlVsZEQ5cHNpSVdiSWZONW95bDIwM3M5L0NUeHpCdmowOUxoTmxT?=
 =?utf-8?B?aFhsTjhyYnN6eStzVzhnUC9LUERtN0FsMTA4ajhKeEJ1MU16N3pCNlZjZE95?=
 =?utf-8?B?ZTExRCtqYWQzVXlTaDUycTg0endBL2hYVy80QTRTdlI2WllYN1hoZ0NDM2FW?=
 =?utf-8?B?bnpoT0U2K2tkVFovNDhWdHhUY005UlBkQlBtWVFnbkllQ1JuL0ZOOTFSaHVN?=
 =?utf-8?B?VnNLTno5SjZqUzZaazgyWFc1Q09nNjZCQSttUFVKdHlKdDhxaGNYbWFmTiti?=
 =?utf-8?B?S0pSQVdjQU8ySnZraFk5KzVVUE1jMHpycU9OSnBvbHdzWFB0a01IN3AyMDha?=
 =?utf-8?B?LzY4a3d6em81aUw1L1Mzc1JYbTBqbTlIU29RdmlZaFJ1QS9ER0lkSlhZT3l4?=
 =?utf-8?B?WGJoVXpWS3J2aEhmc0VpajI2bUQ4N0VKMTZIWDBxc0tOL1Y2cEEwNjV0YlBM?=
 =?utf-8?B?Qy9xOE1vVkphZm1RQS8rNU1lT2xKVjljT1NmcGdSU3ROd2w2Zi9nQzhpOHRv?=
 =?utf-8?B?Nlc0d3NrU2dhWnQwdCtUUEltQTRISS92TGNQSEV5ODJIT0gzVVdlNDlXdWhV?=
 =?utf-8?B?WHo5VUhpTG5JcE5OS1RtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wmtydm5NVCtCT2dMaG5KVWplS1BnTVpDcXNKVUIrcE90c09ROHZHVXdseTI0?=
 =?utf-8?B?YWN3ZzdhTmFicTVPVGdMVlVtdWJUSjBrL2RhajJ5NVA5T3NtNWg4QW9ET3lO?=
 =?utf-8?B?UmxqczNWSEtkRXRzaDkxKys2ODFTOG1RdWhRY0dzWXpmRkZYbDlzKzQrRWJY?=
 =?utf-8?B?bVpydHRKVktyV0dMVmw0ZUJzNW43aFdWT0RtMmxBb2ZxZzlqZTlVZ3dINmNC?=
 =?utf-8?B?WE9sTEpOSEt0bll5N0V4T3YwaHdjc3hZY0ZHdnphZUt0Q29MQkNJdzF6aFo3?=
 =?utf-8?B?UFpKY1ZsNnNvK1E2RHRDb3F0b1g1VXVWVXMreWN3VXpSVSs3MzRDcnU5NlBq?=
 =?utf-8?B?Z3p0bDM1TTJPenhLUEYrUi91TFRmVjV5bDN0OUxhM0doT3RNSUdhdExvZGRk?=
 =?utf-8?B?bFY2ZVo2SzdreEszMjlkWHp3K3BqMUJ3WGdtMFA4WGREUW91b2FnV1ZhQkgy?=
 =?utf-8?B?Ly9DeEpFZUFLTE5HZjlCUDVCMEl5Zis4UFBnYlVIM29KVm9zd2RJL25Eb3ZO?=
 =?utf-8?B?NlFXeHJDU3VkSnZ2S0ZwTXdsaUptWkdwd3FpUHk0VkRoTFdNeXh6aUNONXVm?=
 =?utf-8?B?c2l4eW41eUJiYWwvZzdJY2IyUWV1YS9vcTFnNWtxVHAxQUpYVkN1Uk5mME5i?=
 =?utf-8?B?d1lHazlXMEFGNGMzVGxFeW9jWEdYY3NDa2FOOVk4akRjYi9ZTVZ3NUp2KzVp?=
 =?utf-8?B?eExnbjZMYjV2R3hwSDZRZEtwcjEraDFEVUVBMTJhQkZ0Vk5Za0tVVFcwdEVm?=
 =?utf-8?B?Q1JjdXJlcWcxSTVzOHQwdmR2YTJGQjZueDJtRkN4NFNJajcxZnllRVJVNUxi?=
 =?utf-8?B?NHFLS3B3cXhFN0NGYlIxR1ZXRzArUFBXS3l5YmFNdkdsSlRNMGRHVG1pNjNU?=
 =?utf-8?B?SSs2ZWpDcDhrNnJyeklSOXNudG1PdWlXYVdUU21pNlE3UzJpeGxzK0syM2sy?=
 =?utf-8?B?Ky8vTEtOZkVKWmliZVlDU0pFR0JVL3RORHlrMll4dCtaQmxqbUxvNWplY20x?=
 =?utf-8?B?RGo1bGNSbFNFaE9SeVpIRG1IUDBLaHlDYmlWcUwrb3JSN2xDd212allOUUQx?=
 =?utf-8?B?cnVZbDk5TUYzZXRrc0gyQmYrbm9kR0pvZnF2LytBMXYrbktwZ01teXhpOUJy?=
 =?utf-8?B?OEJrSzQwQU9LMXEwNm03eGx2Tk8xZUx2bHdzdkQ2aUIvV2hYcU9MSkRRUDhX?=
 =?utf-8?B?S3ArSS94WlhhT2VUNDFpVjdVVndBTFVxaEdWUnBHRGwwamp2MjVMRDU3QnRQ?=
 =?utf-8?B?Mldkc3IraExjT2wrNGJNZjlCRDdBdk1EV25pQ3paYS9SMDZWeEZPY0tQdXdv?=
 =?utf-8?B?U09Ib0tFZzdrUjk4dTR1MkkyTXJSUTZ6YVNwalVkMXJ3Tkh6MVd6QmNQc0li?=
 =?utf-8?B?dGlOYlNRVldaY2RvRHRHU09ncS9CSkN4dHJ4RmgzZUF6aHNHR3dWbG5CZXFC?=
 =?utf-8?B?c3FBeEg0Y0NRMnRad2Qzck9pNXdCbGVleXQzTXlHY09vbG16WXNaZ1VncVdE?=
 =?utf-8?B?T2x2V1pEanJrN2YzZzF4ZHRUNkhFbi83Z0EzbHUrcWpFTHRqZzQzY001SUxV?=
 =?utf-8?B?YW95TUtyK2s2SUlHWTBZaDhHUDhSVnBtNkx5bDVEMFZtaEpBOXFaZUFSemVz?=
 =?utf-8?B?eG5KbUlyTXE2WGlDQm1OVHdvVktFSzVuc04wS0ZBTVR0dXpRVm93bEs0bHZU?=
 =?utf-8?B?UzNyTElBeWZvWHNrQ2NoeW9BVFJwNjgxRmZ0QlVYSy9TR3ozd3liNnlaNDNh?=
 =?utf-8?B?UDFHQUVtNTlTUys2ZlU4NnZndVhrMFNTaVYyd29abkxjV0ZuUTFLOXF3N2xU?=
 =?utf-8?B?WWZSRDJmK1NGU3k4cEhzQ01NZ0UzZ0IrZklkL0VTMkRHU1ZWaUJsN1BxU05K?=
 =?utf-8?B?bk5XUk5yb2FTRjdjNUEzQUtsc3FDS1U1YXB1TDBKZDZmVmk3RWMxcHM1TFFr?=
 =?utf-8?B?TGdkTzVZajRqem9pSmQyUEFvdWpOL05xUVVxZlJoWDF0amFuTWxLNHFCcnhi?=
 =?utf-8?B?bWJCaUlDOHRRMmVkK29RYUhyY1hXUEJpNWprOUUrY2tYSGJqUFdXU0JZYkkz?=
 =?utf-8?B?aVBja2ROV0RwTmVJT3NkNWZUeTNHY0hxSU12c045ckFQRThrQTE1SllQRjh0?=
 =?utf-8?B?OGlHTHd5RHIwZm5EUlluOUZyKzNMa3R5WHhIbXVESmtUZnRaVXI1NmlZelgv?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf88ce1c-24c6-470b-e65e-08dcc11ea255
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:47:29.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whSPF+g3vSHgqzKn2juoizJWLW1vl/4gR4hjNe8sqWp0Y81iS56lN1OwgjeKd9iVAUEuQYP23madNQc7leymkAb7Dh5qclFDTChRF1cRkVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7705
X-OriginatorOrg: intel.com

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Tue, 20 Aug 2024 16:43:46 +0300

> BIT() is unsigned long but ->pu.flg_msk and ->pu.flg_val are u64 type.
> On 32 bit systems, unsigned long is a u32 and the mismatch between u32
> and u64 will break things for the high 32 bits.
> 
> Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_parser_rt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> index d5bcc266b01e..dedf5e854e4b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
> @@ -377,11 +377,11 @@ static void ice_pg_exe(struct ice_parser_rt *rt)
>  
>  static void ice_flg_add(struct ice_parser_rt *rt, int idx, bool val)
>  {
> -	rt->pu.flg_msk |= BIT(idx);
> +	rt->pu.flg_msk |= BIT_ULL(idx);
>  	if (val)
> -		rt->pu.flg_val |= BIT(idx);
> +		rt->pu.flg_val |= BIT_ULL(idx);
>  	else
> -		rt->pu.flg_val &= ~BIT(idx);
> +		rt->pu.flg_val &= ~BIT_ULL(idx);
>  
>  	ice_debug(rt->psr->hw, ICE_DBG_PARSER, "Pending update for flag %d value %d\n",
>  		  idx, val);

Thanks,
Olek

