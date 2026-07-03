Return-Path: <netdev+bounces-304336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d+f5NRRGR2qjVAAAu9opvQ
	(envelope-from <netdev+bounces-304336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:18:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DEE6FEA26
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Hffic242;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304336-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304336-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A28203024B62
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A120F335091;
	Fri,  3 Jul 2026 05:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08C333442
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 05:13:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055621; cv=fail; b=Xa15O1IWOe6diEaU81QjXPb+HhgMnQAv7S0QcDaQQKK2vWYQ7oS8HJHJjfe2ooGHKsEy70aEi6QxC1x2HfrDMMHAIKT+CraSNWT3ub9OnXVivmgKI2RrWV+b9tLK5DB7rC3FXCF4xdfDDowP9sFMAo5EtiieahL1feCUcoQ2pOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055621; c=relaxed/simple;
	bh=ZvYaWoLAhMinX0mki4VfcBZUITWS5CymBCwnqhTjKVM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9gqVADRxk9/3Ohsn3sfetHYm/akpdFNkWWbehvW7IHjEjUek/MJp4QGpeQVE46SKYWM/JZslom1NOabyPtFNy+JS3eOmSEVKSs07+PH2EP0eNjE8d+hYTp20+L/97ONI1tos49nAyRzknttf4IjGuZUfXdtqBnXJG867DbK56A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hffic242; arc=fail smtp.client-ip=198.175.65.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783055609; x=1814591609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZvYaWoLAhMinX0mki4VfcBZUITWS5CymBCwnqhTjKVM=;
  b=Hffic242uSjKFWe0Tg4e/iqTOIpF2DEqgdBJDp/gY9AejQL9WrQOEzAH
   WuMXF/BQD1oUPVc1iKhnl6spmd8Nztv5F6VTGE1UfAU3pTYI4Gkl8XZ8t
   3KRs9U75qtxDpTAQnPs8NkUUUBGnmGg6fVjN+AD73ytmdSzfYsG1RZVm/
   sp+/Rk6W2DjBQpQECVfxCVCgDjYL8JnvW7cGb/RRxmq8ajVuQrdmA9ytS
   QBpDoQgYOUvN9EFq61ZRhvQ9VIDx4SuOYoJmpm4BsTRG3iHUboddHHq1k
   KGzoi2UFzWMGDwY4rOu/0topMP7K9dcvPda/+XsTCcb574GYJd0eHP8Hw
   g==;
X-CSE-ConnectionGUID: hTQYOpj+QuGz5Tr2QDvgpg==
X-CSE-MsgGUID: XwnM45X9TrueRzfpcUD+OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="95311546"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="95311546"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:13:27 -0700
X-CSE-ConnectionGUID: n5xFg7tQSpi8rmyhRE9SwA==
X-CSE-MsgGUID: wKSl38EyRDyz0qy+L7rjxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="253170762"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 22:13:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 22:13:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 22:13:26 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 22:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQk+b64PdZmrfNuf6HNAO3l3a3nc/7NvKRml69LzUi18Vk6pSKxANomZVc0f7oRoi+lNKGaa9+AU8pv3bYtpKfWZdu7OQiq85/WCGCQC9YJ4PahLDMWiiZKcDNXDxnWRdhY7FISOoYoKVmz2dWA9/CK2BH9RUJqJStkBTmEG98XUgNuN28O1BOAfl7LFMl7WI8Daw9J3aX8RFD31HGgKoEgZz+JCROFHzw+FimhTGggPHd/xOJBRs0AFXEdMz3P+SNve1wieKAdcLVo3oy5VCD615piqgLiJIRSdeHyKU9pAB8pXd5c6hPCOzWeyaWh+zBZVbJrxXO/T/qC/SoKZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKbxkcKtJeAwuFHRdK8J/SJ4MFv4DLxXKQomTnImO28=;
 b=rXhH2XYSL7sGNGKqy465JS+jSa2mim/M/gEpvUHXLCSvE4UMUafykLmhSucD8jWa2hyMsJ4JAgC3qz0l0Eevs5A4kplZOy/NXMmF7A0tiTGgtPpZviillTHKhQrYGwWHA1K6bqU9GYUCSPp2hr9u1naCziyn/19exnIOPJ4K2+iLKrAgz0uQ+ZXbS6dClqx9VcozXEcUJ/zDAJtJesetX2tamVBpJdrONvfXxFxfye8sUbgm5fCaSeuPpqAQpffFJyAU/qgvV4GRtSjyTzY05nPNs9BuKB7RJvG4onqlmEjJ1L7LeTHvM1qfgOIdpueDHJMXQmcd8zXoUzsX9HNnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB6470.namprd11.prod.outlook.com (2603:10b6:8:c2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Fri, 3 Jul 2026 05:13:18 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 05:13:18 +0000
Message-ID: <0769389d-e73a-4dda-878c-2bc9e59deff3@intel.com>
Date: Fri, 3 Jul 2026 10:43:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/ras: Introduce error threshold
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <kuba@kernel.org>,
	<lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dev@lankhorst.se>,
	<zachary.mckevitt@oss.qualcomm.com>, <rodrigo.vivi@intel.com>,
	<michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
	<mallesh.koujalagi@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-3-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260623101043.255897-3-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::7) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c2ceac-23df-40e1-d292-08ded8c1cae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: eKmqqjS+n4dWMkYBtEpa83coUxjIGgKoWBXQFdHHOHMK+hm9MOptrP5JPnnA43TqqqPJi62hxtBcpMJR8DIVb5Cc/SvJvRVTAnk5FIHmVzHhZhVgouJ19TLz2TXYVh5IR1M9tgS2iYH6MyYkgUYntoeC1dUj8F4W74lz4pgPZLLHRIrfP1mh2HCXAQ0fsTbiiz1FzZgXQRBu24pGZWoW4ENTlGCKbwMQpl4JHLQ+T8mlQ+m6aaCtJ5gxzHR+iy1dQOU1cSMGzUmOjc5SU3hJiyB/C095xIo4J35WBdpkNtL3K6FEB05IYAZxgJt9ebZupeUc9go1ccF211PpWFrSJcpEKd6ykwkbN1EPl+QvKrilWQBggpEMZesdtF8SoO0keQTz81nRI2jZ+miRTu3P/JK/GfuaKy2izG1Ywxk4/RVEerzVCzBMaPx+i+zvI77c47KlMgBtTrlBtYutPaeu7cNw+ZTIw3HMzZWVP8bs0CFIRGQEEPnsBFyzhHlQQ3Bd4pD6TaB9KZH72wVnMny+pE0lYcXdfUp/xemxeSbf+5Mn1E1UVMizlxO9OLANP7jveamC1fDuLMcYN7vPtmLg9hUCybhRQGHWw6xW5PzAl6lwiOEB479CYKPTW7tUR9K/x9d48t/XgEfM7/mh2GogabS0+YwOYeCclH5RqbIa0FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFWMHN3S2hSUVhqY3c1Z01ndVA0Z0dFMHdSbjJLT1JaRmw0ZGdLS3dobExP?=
 =?utf-8?B?a21Ybk8vOFA2bFR5QjJtZHQ4NDBXOS9nM0Z6emJYWmNqNVlPK2NCY3FzMEFq?=
 =?utf-8?B?alNEMXZEV05GMHZhS3VFbDR3MmVLczFESFkxN01Vb1lwdXVKbkdmWitlQVVt?=
 =?utf-8?B?TVhrcXlrMklTenZzY1hYMENyK05jc1czSjVVUllBTjV6SXdkNUlMbnJjTDVP?=
 =?utf-8?B?S3BCSGE0Ung3bXlwOFU1V1pOUkpnc3QxWjlXb3JQc0lPeTc3a3pVbHRCaFBZ?=
 =?utf-8?B?MmVBWElhK2FIOVZxUUJOc0NMNXFRdURieFliQnV3ZWlSMDVmbTdKMW1HN0hs?=
 =?utf-8?B?eEpYeGRaYlRpSjg0K241TmMzTXF0ZDVpVWw0TGN6TVpOYTBLYW1nenU5UFp5?=
 =?utf-8?B?ZlpGQUpBRG1DZ1RPMVR5b2VPd0g1eWFRUmsrMWNMbjJHc3k3cXN3Y3d3SUMv?=
 =?utf-8?B?azNGTXpIaXFvVU9CSkhmM2xOdi9ERnVlYlV6bDdwT3lOTjNrd2FRQ3dBbXMz?=
 =?utf-8?B?Wjc1LzF4TTNTTTRtT1ZFcmdrdGcvWXFTcDJiSUk5dzRvMW1Fc3VhNUFXT2lu?=
 =?utf-8?B?VEFjSHpnTXRYNWJHQnlocjh0ZkZOWnBVQ2RDTWZyaUpzSjM2aGVpRFltM1ZY?=
 =?utf-8?B?SmdtL3NFNnZXbyt5djZPWFhEQ3RaaHpvdHRoS1NFWDVSNWJ6MC8reGQxMzl6?=
 =?utf-8?B?aWVRcEhOeFlKS0twazhCMmgwdFg4aUJVdDlFbTZXQ0IwZWdHQjBuZXMyNnBY?=
 =?utf-8?B?QTJKeitVVzlkNGpQU3MzR1RJN2d5MUt1T1FLTmJ6SUhNNC9VQ2VWeE1oNkJT?=
 =?utf-8?B?OVhRK1dQb2dPYlA3aTZGR29GeGY3WitId1RwclU4RlVTSEhzVzFxMHQ5bXFj?=
 =?utf-8?B?WEl2ekY1UVlBYjRCTm5ORHFmM2g0dndkMWVzaGRJWndCVUFmbVdVUEVOYlNU?=
 =?utf-8?B?VFVWcXppUHUrRTJLSDlwc2ZicFJ3R0ZTL29zV3ZYNXFsdlV1bmlkQXAyL2Qy?=
 =?utf-8?B?YzI1b2tnYWpkZSs0WlZ5Yk5WNmlLMmM3alFyZjhsYVN2TGdZeXB1YjdRVERK?=
 =?utf-8?B?UkhremsrdW4vaDk0eFNQbnVBT1BJamlsVi9kS1ZtUDEyK3VRRWhRTktTUmJs?=
 =?utf-8?B?ZmhUY1Q2aVBYc1NINm1CNUo4THZORVVNM0xJSUt1ZHZkd25ERkZoTktWUWhR?=
 =?utf-8?B?SVU0WFpkUU12eThZWDJMcTkyc3QrRVNrZHA3dEJuaXUwZWQwaldicG5nS3Bv?=
 =?utf-8?B?VkxBSURjNTVuZ0Q1Y0lXVUU3Mk5Eby85b0RncUR0M0xWa0diU0ZEdU9aaUR0?=
 =?utf-8?B?T1ZQYW43b0tneVZkZWhpV1pCZjFMN0MzbzFSeWVtMHJKMjIwdzVWd0h1NGw4?=
 =?utf-8?B?N0NQRk9KYnE5cnY0bDBRTm16bGQvOXBWMEVpNFp2SUZPTy9Sd1RCUndCSy9X?=
 =?utf-8?B?U1hPbkNnM2VWeWx2TzlZT2pSb1hHT211Z1p2WmpERHJ0WStGZFdSTS9LRThI?=
 =?utf-8?B?NERLclNjK2c5NVU3NTBrcGlYajBLdXVWOUhOYktoK1RIUG5wRUoxSk9PODZL?=
 =?utf-8?B?ajRLT0NKbC9vemE0dGpTRGhtMUdTVVFtN1h4aDhCaEgxSktJaUFmMjhNVE5v?=
 =?utf-8?B?MXFRTjdYemxJYW1pZ2ZMSElPYmcwaTMvNVhsWkRpVGNINWFYb3BLNDM4MGNq?=
 =?utf-8?B?SjZXYWNJN1FtV0ZZdnZvL3hnUDNaU2wrWEg1T0RVMHdxNXgveWNQQ3Q0UENL?=
 =?utf-8?B?SlVhOFVuaXNoYmNSVUt0cVRpTmNZVFp2aWhxT0JzLytYTEJrMk1ETE5KZmVM?=
 =?utf-8?B?aGl6WnJlYzR4T0doUExVOUtseEpvdUtoTzhnazdVVmt3Nm1iVlpacythTVE1?=
 =?utf-8?B?L2E1c2x4K1Qzb3R3bGM4Z0sxbTZwVW8zcklQT2ZwREZZYnBDbyt5QzFvMjdt?=
 =?utf-8?B?dE8zSkRweXlrMU80MU1nK2ZWRlk3UkJIenpqakhvVzlJaEVHYmpBY2NZWWFN?=
 =?utf-8?B?ckpQL1oxUU9pRkdHemRWSk5pWVFGR0xBQ2dBMjF1MW1tL3dYM1kxOHF4djlj?=
 =?utf-8?B?Y0hhbXBJanJKUGk4dWxieWJCNDc0cThwRkg0bWxZbDZhdEI0ZzdwcEJhYnYx?=
 =?utf-8?B?cklkZ3h5R2ZhbnJtNEVyS2M4UVpURStVSURhSFhneFJ5MDhNUUtnYkV5SGw0?=
 =?utf-8?B?VTh1ZjkyeHZ6S3ZCTDBodzFHRld0RWlCV1JUUzhtVll6WGxwSTB6OTVOR0tX?=
 =?utf-8?B?cDUvZDNteVpqV1FvVmxVWU5Damk1dnU2OEUzMk1Lb0NWais3TzZrZ0hMVlFy?=
 =?utf-8?B?T0hDRk1BZzB6L0JRV2oyaEtrMlNEOVRITm0xYWVlVUs1NmN2UEFwZz09?=
X-Exchange-RoutingPolicyChecked: ckLSzT6FZs/AlFhK2evVaAexdsP210OQXNeuN/+O7ezTfXaR4QjdmJFGit0YtKOOtT4slaxTh8TkIWKy4sT0A+8/8ow8GRrXooKFsL3qhPKmt0+bWMqd9y4+zkzuULDkGHzHBPiW/gGSpiDVEqTNCClLgTpALlMmuVysFV7YZI3pRb2pHJizE8rcxz68Ts7OTzGnH6bBriFIwLo6169/gjLS6a3AbmW4XkdOvUvl/p3Ivp/zciELIMys+J+AGnv3MrVNuYpv6XCyDHTpQu2gwepnTJBn8DRQGbLzFgdvtstIQS6yUUAz+hr38ZDGbXPHbaAFGCIMcCpedN6t1EcEDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c2ceac-23df-40e1-d292-08ded8c1cae5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:13:18.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZQu9TDP7uSx2FIfp+HNBfkD8mVqlkNuRqgwl+fyJ9ZutIU4gTtps6/eJ/vZVZC4SBxPByFdR+LsHcBGffHUeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6470
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304336-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50DEE6FEA26


On 23-06-2026 15:39, Raag Jadav wrote:
> Add get-error-threshold and set-error-threshold command support which
> allows querying/setting error threshold of the counter. Threshold in RAS
> context means the number of errors the hardware is expected to accumulate
> before it raises them to software. This is to have a fine grained control
> over error notifications that are raised by the hardware.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> v2: Document threshold definition (Riana)
>      Return -EOPNOTSUPP on threshold callbacks absence (Riana)
>      Cancel and free genlmsg on failure (Riana)
>      Document threshold bounds checking responsibility (Riana)
> v3: Move documentation from yaml to rst file (Riana)
>      s/value/threshold (Riana)
>      Use goto for error handling (Riana)
> v4: Clarify 0 threshold expectations (Riana)
>      Drop redundant wrapping (Riana)
> ---
>   Documentation/gpu/drm-ras.rst            |  18 +++
>   Documentation/netlink/specs/drm_ras.yaml |  32 +++++
>   drivers/gpu/drm/drm_ras.c                | 161 +++++++++++++++++++++++
>   drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
>   drivers/gpu/drm/drm_ras_nl.h             |   4 +
>   include/drm/drm_ras.h                    |  28 ++++
>   include/uapi/drm/drm_ras.h               |   3 +
>   7 files changed, 273 insertions(+)
>
> diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> index 83c21853b74b..2718f8aee09d 100644
> --- a/Documentation/gpu/drm-ras.rst
> +++ b/Documentation/gpu/drm-ras.rst
> @@ -56,6 +56,10 @@ User space tools can:
>     ``node-id`` and ``error-id`` as parameters.
>   * Clear specific error counters with the ``clear-error-counter`` command, using both
>     ``node-id`` and ``error-id`` as parameters.
> +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> +  ``node-id`` and ``error-id`` as parameters.
> +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
>   
>   YAML-based Interface
>   --------------------
> @@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
>   
>       sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
>       None
> +
> +Example: Query error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> +
> +Example: Set error threshold of a given counter
> +
> +.. code-block:: bash
> +
> +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> +    None
> diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> index e113056f8c01..9cf7f9cde242 100644
> --- a/Documentation/netlink/specs/drm_ras.yaml
> +++ b/Documentation/netlink/specs/drm_ras.yaml
> @@ -69,6 +69,10 @@ attribute-sets:
>           name: error-value
>           type: u32
>           doc: Current value of the requested error counter.
> +      -
> +        name: error-threshold
> +        type: u32
> +        doc: Error threshold of the counter.
>   
>   operations:
>     list:
> @@ -124,3 +128,31 @@ operations:
>         do:
>           request:
>             attributes: *id-attrs
> +    -
> +      name: get-error-threshold
> +      doc: >-
> +           Retrieve error threshold of a given counter.
> +           The response includes the id, the name, and current threshold
> +           of the counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes: *id-attrs
> +        reply:
> +          attributes:
> +            - error-id
> +            - error-name
> +            - error-threshold
> +    -
> +      name: set-error-threshold
> +      doc: >-
> +           Set error threshold of a given counter.
> +      attribute-set: error-counter-attrs
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - node-id
> +            - error-id
> +            - error-threshold
> diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> index 467a169026fc..d60c40ac5427 100644
> --- a/drivers/gpu/drm/drm_ras.c
> +++ b/drivers/gpu/drm/drm_ras.c
> @@ -41,6 +41,13 @@
>    *    Userspace must provide Node ID, Error ID.
>    *    Clears specific error counter of a node if supported.
>    *
> + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> + *    Userspace must provide Node ID and Error ID.
> + *    Returns the error threshold of a specific counter.
> + *
> + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> + *    Userspace must provide Node ID, Error ID and threshold to be set.
> + *
>    * Node registration:
>    *
>    * - drm_ras_node_register(): Registers a new node and assigns
> @@ -61,6 +68,16 @@
>    *     + The error counters in the driver doesn't need to be contiguous, but the
>    *       driver must return -ENOENT to the query_error_counter as an indication
>    *       that the ID should be skipped and not listed in the netlink API.
> + *     + The driver can optionally implement query_error_threshold() and
> + *       set_error_threshold() callbacks to facilitate getting/setting error
> + *       threshold of the counter. Threshold in RAS context means the number of
> + *       errors the hardware is expected to accumulate before it raises them to
> + *       software. This is to have a fine grained control over error notifications
> + *       that are raised by the hardware.
> + *     + The driver is responsible for error threshold bounds checking.
> + *     + Threshold of 0 can mean invalid threshold or act as a disable notifications
> + *       toggle for that counter depending on usecase and the driver is responsible
> + *       for handling it as needed.

I know i asked you to add this in last rev. But after reading this, 
error-threshold bounds checking at driver level
should be sufficient.  It's upto the driver on what behavior needs to be 
implemented.

Some may notify on reaching threshold or crossing threshold.
I think we should drop this sentence here. Let me know your thoughts.
sorry for the confusion.

>    *
>    * Netlink handlers:
>    *
> @@ -72,6 +89,10 @@
>    *   operation, fetching a counter value from a specific node.
>    * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
>    *   operation, clearing a counter value from a specific node.
> + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> + *   operation, fetching the error threshold of a specific counter.
> + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> + *   operation, setting the error threshold of a specific counter.
>    */
>   
>   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> @@ -168,6 +189,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
>   	return node->query_error_counter(node, error_id, name, value);
>   }
>   
> +static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->query_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->query_error_threshold(node, error_id, name, threshold);
> +}
> +
> +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> +{
> +	struct drm_ras_node *node;
> +
> +	node = xa_load(&drm_ras_xa, node_id);
> +	if (!node)
> +		return -ENOENT;
> +
> +	if (!node->set_error_threshold)
> +		return -EOPNOTSUPP;
> +
> +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> +		return -EINVAL;
> +
> +	return node->set_error_threshold(node, error_id, threshold);
> +}
> +
>   static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   const char *error_name, u32 value)
>   {
> @@ -186,6 +241,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
>   			   value);
>   }
>   
> +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> +			       u32 threshold)
> +{
> +	int ret;
> +
> +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> +	if (ret)
> +		return ret;
> +
> +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
> +}
> +
>   static int doit_reply_value(struct genl_info *info, u32 node_id,
>   			    u32 error_id)
>   {
> @@ -225,6 +296,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
>   	return ret;
>   }
>   
> +static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
> +{
> +	const char *error_name;
> +	struct sk_buff *msg;
> +	struct nlattr *hdr;
> +	u32 threshold;
> +	int ret;
> +
> +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(msg, info);
> +	if (!hdr) {
> +		ret = -EMSGSIZE;
> +		goto free_msg;
> +	}
> +
> +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> +	if (ret)
> +		goto cancel_msg;
> +
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +cancel_msg:
> +	genlmsg_cancel(msg, hdr);
> +free_msg:
> +	nlmsg_free(msg);
> +	return ret;
> +}
> +
>   /**
>    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
>    * @skb: Netlink message buffer
> @@ -358,6 +466,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   	return node->clear_error_counter(node, error_id);
>   }
>   
> +/**
> + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> + * the error threshold of the corresponding counter. Sends the result back to
> + * the requesting user via the standard Genl reply.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 node_id, error_id;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +
> +	return doit_reply_threshold(info, node_id, error_id);
> +}
> +
> +/**
> + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> + * @skb: Netlink message buffer
> + * @info: Generic Netlink info containing attributes of the request
> + *
> + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> + * sets the error threshold of the corresponding counter.
> + *
> + * Return: 0 on success, or negative errno on failure.
> + */
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 node_id, error_id, threshold;
> +
> +	if (!info->attrs ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> +		return -EINVAL;
> +
> +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> +
> +	return set_node_error_threshold(node_id, error_id, threshold);
> +}
> +
>   /**
>    * drm_ras_node_register() - Register a new RAS node
>    * @node: Node structure to register
> diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> index dea1c1b2494e..02e8e5054d05 100644
> --- a/drivers/gpu/drm/drm_ras_nl.c
> +++ b/drivers/gpu/drm/drm_ras_nl.c
> @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
>   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
>   };
>   
> +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +};
> +
> +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> +};
> +
>   /* Ops table for drm_ras */
>   static const struct genl_split_ops drm_ras_nl_ops[] = {
>   	{
> @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
>   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>   	},
> +	{
> +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_get_error_threshold_doit,
> +		.policy		= drm_ras_get_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> +		.doit		= drm_ras_nl_set_error_threshold_doit,
> +		.policy		= drm_ras_set_error_threshold_nl_policy,
> +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
>   };
>   
>   struct genl_family drm_ras_nl_family __ro_after_init = {
> diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> index a398643572a5..57b1e647d833 100644
> --- a/drivers/gpu/drm/drm_ras_nl.h
> +++ b/drivers/gpu/drm/drm_ras_nl.h
> @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
>   					struct netlink_callback *cb);
>   int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
>   					struct genl_info *info);
> +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> +					struct genl_info *info);
>   
>   extern struct genl_family drm_ras_nl_family;
>   
> diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> index f2a787bc4f64..683a3844f84f 100644
> --- a/include/drm/drm_ras.h
> +++ b/include/drm/drm_ras.h
> @@ -69,6 +69,34 @@ struct drm_ras_node {
>   	 */
>   	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
>   
> +	/**
> +	 * @query_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to query error threshold of a
> +	 * specific counter.
> +	 *
> +	 * Driver should expect query_error_threshold() to be called with
> +	 * error_id from `error_counter_range.first` to
> +	 * `error_counter_range.last`.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> +				     u32 *threshold);

Add a blank line

With these fixed

Reviewed-by: Riana Tauro <riana.tauro@intel.com>


> +	/**
> +	 * @set_error_threshold:
> +	 *
> +	 * This callback is used by drm-ras to set error threshold of a specific
> +	 * counter.
> +	 *
> +	 * Driver should expect set_error_threshold() to be called with error_id
> +	 * from `error_counter_range.first` to `error_counter_range.last`.
> +	 * Driver is responsible for error threshold bounds checking.
> +	 *
> +	 * Returns: 0 on success, negative error code on failure.
> +	 */
> +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> +
>   	/** @priv: Driver private data */
>   	void *priv;
>   };
> diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> index 218a3ee86805..27c68956495f 100644
> --- a/include/uapi/drm/drm_ras.h
> +++ b/include/uapi/drm/drm_ras.h
> @@ -33,6 +33,7 @@ enum {
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
>   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> @@ -42,6 +43,8 @@ enum {
>   	DRM_RAS_CMD_LIST_NODES = 1,
>   	DRM_RAS_CMD_GET_ERROR_COUNTER,
>   	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
>   
>   	__DRM_RAS_CMD_MAX,
>   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

