Return-Path: <netdev+bounces-130978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A598C502
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF25B2824BE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD5E1CBE91;
	Tue,  1 Oct 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7rHPgGM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A92321D;
	Tue,  1 Oct 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805800; cv=fail; b=OleXasy2GskTN/Pgcza7Lkzr4YiSO7eLeOuqUdAqah12W0AzXFnLFnw37tpAelCft97Kyxidu57vCGk9XRjrYcmWXKkSQlMpLVhKdjrd2IjuJa2PhC1irejWndBDdPA02TGy6hCLQxt+sGDx0GXcrPjaFNUHvj+tebrz/vJzL5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805800; c=relaxed/simple;
	bh=n0jbSaXVk1xzVJQxjHFvBhHoqm/RPfAEQSVSUvzF5bg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bLvWErfHPtMmnwEWBifMzoqx3ZXuzz5E1cPdm2MpJ8JPgLm2gurkYVw+ih8Ld4rlSVqHNFKgl3V+uRIUnX4f8ueBPhH8uoRsLIrZuR/dXZ3miGpnhbw9FazUVJOZEKft38acEDBEQAMMy7reUgzzRszn2+1DTs4dVlvgbE0I2do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7rHPgGM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805798; x=1759341798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n0jbSaXVk1xzVJQxjHFvBhHoqm/RPfAEQSVSUvzF5bg=;
  b=U7rHPgGMNag0oUMkKTDSfbU2zR3Fg6A2R5dJYPKMB+1NRRBHMWKI8Bi2
   6USb9Gt9UNwfuTMinH6qubtv4CTbtqLQymomR87PjaeY2YWf7WKkMz/O0
   EYz3neypoMWKwUK873rUwDB/mgsYP/wyX9AnE64r4G8L2xrn9JQ0xoX2Q
   qEtX6R3pavy7+MEfMWYVeYYjjNgieJ+RhcAk3cb7ZF/BdcYtD74KJT4an
   vE/aaYawaFInUG7WpQYFb9aN0h4gHQiDIFm1pJrY235Y9DYtWa69Oih3H
   WCnozmYBxH7H0BIAHuRhWxZ++Ioy4jvx8orYCWJNY0lrF6228LXZzXPJf
   g==;
X-CSE-ConnectionGUID: ciP5RtciScG/yD2bG6vw+A==
X-CSE-MsgGUID: IbgVPIgJR1GBY9cRO21GJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37514990"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="37514990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 11:03:17 -0700
X-CSE-ConnectionGUID: cAe6UQoSRUe9KhoxwzXZjw==
X-CSE-MsgGUID: QuTrWgm4T/mWDvR4GacQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78284314"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 11:03:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 11:03:16 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 11:03:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 11:03:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 11:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg8x7IITQ/+GLHTYhmPTx5J+fSc+9ExnyEwVIXbW23VJG26E1nRQF0plPf2/tpfrEeLgQ4fwjB3IuiFXfx/zqlD43hXgGyWnnEuA0paMOdR58w7KLvy0MCwX6prl3F1CP9yRZBnaYtejZXs/TGSK690DzevcnHNaKGe0wDs6ZUYpzi1v4b/iDXB7fiefpZBmxB9FlQ3Pz2IntLf5R6LaEQMhsaopyutSlfxxKwWnTX2kXW8y49U3t2XtzvWoEJJyPnHFTUK+aVpAM9ZYd0SEReyo/H4VZmupYOla9sG+g0dGS4MKHDUDvfk7w+aTNpK7avyztPE+7cEfClPbCKD5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKBeW4G+cr1/Om0zmXgPLhFl3uedtCIB59T92Gge/0o=;
 b=b+Htwe1WA5B8lsrIrPmV4xr3Fl6FJrMu8Q7W/OnMK+xgWzbWTRWlC5+7hFDQfdmbYPdVnpe2DGNZqo0t1JR1PV8xwXDKn9lZKRnhcSYfBRuidmxrs0x77614OR36YT3ZpAKndkGIq79dBkx6wcm6dFXWdMY/wil5bWq63dCAk2vrSK9ZtpSdhIYHWszUMs4DW4YxmZC38MUFXULMQxXOX31Vh5zqhIS4iQGZidoTLi3S57d8y5ZjPV09sGMH/Hx/zcHwKMr+eajVO0VT2WO/C8tDYjDIwLYaJ0inEhSWRqgFLps/lSd/c4i89L7USqwYxBzBJCQB+L3Oq0KKXzYr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA2PR11MB4841.namprd11.prod.outlook.com (2603:10b6:806:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:03:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:03:12 +0000
Message-ID: <4e89dd84-eadc-4cae-8892-c33688cc051f@intel.com>
Date: Tue, 1 Oct 2024 11:03:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net: sparx5: prepare for lan969x switch
 driver
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA2PR11MB4841:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f44059b-94a6-43bc-0255-08dce2435090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1pVWTdtT2tPV1Z2bktudllxekswZ3ZHbGVlR2JNQ1YwQXo5blZmNFpYQkpv?=
 =?utf-8?B?S0dCdy9aeVhhTXVCVkU3cTFJYmlsd0l5SlJFb2lmeVMwUlhRK1JBSjFodkxt?=
 =?utf-8?B?VzRyR1dOeDkzcENDUVlwdGFoeVhNOElFYWlVUEhNQzQ0Q3FhVnBnM3g2WGNw?=
 =?utf-8?B?WHJvVXROS1RsQy9nOEZ4TURYUGs0K3lWTFMzSzRlWDdlVkdqZkJZczJCdGpk?=
 =?utf-8?B?RVhEdGFzam9neGVtZ1M1ZnAzV1BYNExrVWNCY2NPeWtzbmdubXZiQlFjKytU?=
 =?utf-8?B?VUQ4TFkxZXYwbWNFQ1pwT2JhRVQrT2VvT2lVR2twbEVJVUZ0UU5XWkhIUHpZ?=
 =?utf-8?B?NUZNRnVmSnJMTnRKbk80WGN3eEtIL20xZHlEd3NVbUdwZnNaQ1Y0b1VFYTdh?=
 =?utf-8?B?cjZ6RUpZTGNnTmU3SFpTRTJIdkR3ZEpQL1NPUWJWNDFFNUNENkJWQllLS3B2?=
 =?utf-8?B?Um1hYUdvRWsvcDdYWEFQb2FNbGYxUHFMV1F3eXlXWnl6KzlBYlVPWlJBRUpI?=
 =?utf-8?B?d3YvZXJsc21OWStBR1BkMDBkY3E1VkZPZndVTFEwYVdISDY0Z0xNbm5Oc2o3?=
 =?utf-8?B?eURyZ0pLN0JlU2xURU1pQ0RBc1lqUUV0VGVsM2RicURiUUlBaUR3QU1ON1Qz?=
 =?utf-8?B?MFQybnlGa2tFTU1mZHZIUFQ2blFHZnFuVDJBUzhrVWFpNnZPTVMvT21FUWFL?=
 =?utf-8?B?NWxSZ1IrOXZNYTBObzZNQ2tEeVQxS09sM3hiTSs0QzJ3em5tZUNVZm10cXh3?=
 =?utf-8?B?UnZzYmFrcXNQYUdDTlpQakF5T2NoSC9ZYUJNM2huZjJHUUh3RTQ4MmdkV0F2?=
 =?utf-8?B?aWdEcEd4YlA1RUdXZWRMRFdvTHNNdVFreEVnT1R0MXRpL1BLaHpPUmxDYSsr?=
 =?utf-8?B?RFV0N2ZZVDlUYmJqY3dRaHVFK212UnVEOFBkbWxBdVVsK2sxQlJFalRQUHh2?=
 =?utf-8?B?WXRIdHoyZy9LclAxMEp5YzRlOGY0Nk1PUEs0TWQ1RWRVUTh2cGtPeG1mamlK?=
 =?utf-8?B?OG9ySzM3Yzg0RGpNVnlaWHlHT29tSEFVZEJ6ZmRGRFpyZGpUclNyRWMybmNC?=
 =?utf-8?B?UzN5QzhaODdqUFhWcDlUdko1SzA3OHNuSGpMemVxV3Bmbi9uVitqY0lyd3gv?=
 =?utf-8?B?SEEzMWNBOVdXMFdOcXVudlNlemZnbXJ0Qjd4d05oMUlnTWhkMDFoVi9pUm1K?=
 =?utf-8?B?T3AybHNSWk01enlVVTV4MXU5OGFMODhCVzByRWJFU01ySURCU1ZNZldmWkFw?=
 =?utf-8?B?NFZobXBnRVgwV1l0U3pZTnp4NjB5akg3cGZORWdyUk90L0JiYlk3SkI3S0dQ?=
 =?utf-8?B?d0xZUlgzQ0RrTUdsZHE5ekNyak1mbVV4Q1JyR3F6MnNlM0RkTVA4Ni9LOHQ2?=
 =?utf-8?B?U0NwRnJEUUFRZjZ0QmFwaUNhWjQ5MlJvbmJoU2xVZUljZFd4VnVjQVlRNjBt?=
 =?utf-8?B?MG5CQjh2SWsycHVlNFJ5T1VHV081dmFYMnR2S2labWRQejQyWHVaVXpDdk9W?=
 =?utf-8?B?eVphay9CVlBQQlRmaGFmNTJKMGVRZmV0K1BySXE5ZVhFZ2FPNHBMRXNMdTVB?=
 =?utf-8?B?OGVZaWxhZzMxUVpQZElTMFpNVFlpaGpYZENpVS90SDhwVkZidWsvU2o5VkVp?=
 =?utf-8?B?SzBjTjU5dmtjdUltYVJoNEZwUExXL21wN0tLcnFCNFZGQ0NXSjNNcjEwRFBt?=
 =?utf-8?B?L1VKVjBRM0NYT1JZR1JEcjcxaW9SS2RiSG5oM3dNL3NESVlvR2dWY0hUM3pD?=
 =?utf-8?Q?BfDzHV4OQQr6MfuF5Wyi5O5Qwi5ed0z+ejBX2TD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1M1UzNLRHpxL1JZMmVsZ2xGeDV1d1cyQlBSU1orcWlYc2NkRkZjczQ1aWNa?=
 =?utf-8?B?RTRaOVVMQzluc2YxREs2a0hiQXRHMFo1SFBaVkU4Y0c4VFVwSlR3RXZWaUlY?=
 =?utf-8?B?WU5MeHF1L2JwVTFQSXNYRitvaW13Szl1OTBmdWNiZ0pWc004L1JvNDRLbFUy?=
 =?utf-8?B?SGN5cUZzQkFhSGVRVldmVUp5NnpVdnNKazRxVXhUbFFCUDZXQzBVc1ZzL28z?=
 =?utf-8?B?aXYyRmFwaGsvdTdJZ2J5ZWIzcGFPNWtKVWZ1MU5YT2tFZklZM3F3Skc3T2g1?=
 =?utf-8?B?eGM4VzBhRkM2SGpBU2pXV0RVUnB4OTRrR3JuaVpEVTVEMkZqZjlFRUtxclJJ?=
 =?utf-8?B?NFNnVXNRMENJem1CRFU0SjJYYUs1aHJrWmRlNXNOMENJZE9yWm5UTnliVVRN?=
 =?utf-8?B?bnBXdSt1OHpocVZRanFWN0xIa2VldmdzdW5VamM2a2c5dithS0d2STZtdjZq?=
 =?utf-8?B?K1UxWjNmMnhVSXk5UTYvMldib1BzV0VHYkxmZ0FkM1QvQ0dCWWN2NHZOeDJs?=
 =?utf-8?B?cVVMNCtPeXRnY1J0OGtJdkFmZnoxUDdhMEE3ckh4N0I4N200aWZwaUdDeW4r?=
 =?utf-8?B?M1gzYXN0QStrMUVyY0NKL2U0SDR3SWpqSDl1QVZIY0ZiUDNTQ2dlUjRubHhT?=
 =?utf-8?B?b2FHS3ZJY21QU1FjVE8yMmNmdmZ4bUVRV2JaR3hkMk1PNi9JL3BwNERoeW1q?=
 =?utf-8?B?VzBLdDZWVUZ2c3N5eVNVNm0rbDN3WHhieHYrL3hZMFkrZGpXTGE4WUJpdDJn?=
 =?utf-8?B?dk5VbmM2Sit4eXYwckl6U1lMcXExS2E0NW5SRVROd0h4MHhXZEhoQ3dCMUtB?=
 =?utf-8?B?UkZMUG9zRHJIK3Rucnhib1A2Ujdtd0Qxd0NBc0RxN0JQWFRTSTcvOXdoby9m?=
 =?utf-8?B?VTVKK3RML1FpdmpQTVBaVHNwd1BZTk1lUU55aVdWb3pqN2JRaHdaeWV0UTNY?=
 =?utf-8?B?dkwwY1ZPU1ltY1pJMFE1eXlJWTVHdk1nb3NNMFB1S2lrMGMyeEhBc0NMRWEr?=
 =?utf-8?B?NDVDanRuSThGSERzN0VDUkVRN1lOUVNobHlBRDlqUzI3QUtVRjVoRU51Z3Yv?=
 =?utf-8?B?R2hsdVJuWEpqRE1pcURBSlpqckZFL0IxN2Z0b2NTbUo4M0tJbXRTcXNVVSt3?=
 =?utf-8?B?WHZmVlhtZkhsRGg3RTNRSGF4VnBWcTl6aE9idFVLMlh2OXV1Mk5ZYzVoMndk?=
 =?utf-8?B?Q3ROVFlYd1MzZ3RYUEdtTEYxa0psS3JoMk50SjdtN0RSZzhIdGM5RkdkTXlq?=
 =?utf-8?B?NEtXQWQ4NnE5NFh6UkJRRTNWL0pzRkVkTFdISmhqbG1iZDlrTU1WL2NkNjMv?=
 =?utf-8?B?amxjbG9jOXdLVzRxS3Z6b2gzQ2FZNnpEa3BNZGNyVVlsaE5ob0VCeUJ3V1Ft?=
 =?utf-8?B?SHMzMmZacVAyWjNZT1BTbndnZzJ2RXlva1B5VVlmYmtIRUZROUdHWUJpQlJK?=
 =?utf-8?B?RC8ybm1OaTZEWHpWdzU4bTdsaDJHLzFxNi8rT2s3RWFSei9TUjNmcVpvdWlv?=
 =?utf-8?B?RWV0a3RXVHZ0QkZkZTl2T1pGUzJZcWpXcTF6Y2d2WWdJenNBSVRCUGtDSS8x?=
 =?utf-8?B?VGtpZDZOZjc2QzNxVWQrSThtL2E1ZHFhZElVSU1NNDRORWhoOVQ4UTlhWFBD?=
 =?utf-8?B?S2V3cTEzWGp3dTAwY1VGajZvbVpHdEl2d01WNEF5Y2hXRDZhODlOTmY2MGdS?=
 =?utf-8?B?R21BMnBPc3kvQVVZdlFvaHpTS0tnbjFCaU1HdndEbTcyeHNOR1hGWWJTaHJx?=
 =?utf-8?B?bVd2M1Z5UlhHcWdGUThSTWhQOU5kR2NjeXh3TmRRMEdNa01ZWGw3OTBqbHQ2?=
 =?utf-8?B?TE52SVd6Q3VmeTM1c2lSTTEvTkIweWI1OUU1Tk5FYk5TVDN6YnFLTVJvZWtG?=
 =?utf-8?B?aGE4eWpRQ2MxNCtnZExYZnRNV2dRalNCK2RweEczeEgrVUh4WFJoc1NrNTdm?=
 =?utf-8?B?WVpnQTcrQkJXRStWZkNaT0xudlBqeVBpUHMzM0ltYXlpSklnemJiODZkT3Fz?=
 =?utf-8?B?cnBSeGJtNXREUzJNVWJqYnJhc01TVzVhZDQ5T2hEbEhoS01QK0lSeGh5eUI1?=
 =?utf-8?B?bGxScFJKQUNBUG81d0ZIa2oxZWdITWdwZ2VRTFZPMVhUSGV1YTJ6RFkxMVlh?=
 =?utf-8?B?aWxYQ2JTQ0pDdlFzWXgxcjQ1NGJxUUZyYzJtZXVQc3B4M3JMcFRVZS9DeGJm?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f44059b-94a6-43bc-0255-08dce2435090
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:03:12.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/XYKKZYNGR5yWMWNc+xblaidrZrpwCtpE+8z0wsAu2UAPCjPknw4jdnj3XW+pju/xRwPP4NbDAyT07onJsH+V7ApEljXqFdzsxLudzcfo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4841
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> == Description:
> 
> This series is the first of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
>     1) Prepare the Sparx5 driver for lan969x (this series)
>     2) Add support lan969x (same basic features as Sparx5 provides +
>        RGMII, excl.  FDMA and VCAP)
>     3) Add support for lan969x FDMA
>     4) Add support for lan969x VCAP
> 
> == Lan969x in short:
> 
> The lan969x Ethernet switch family [1] provides a rich set of
> switching features and port configurations (up to 30 ports) from 10Mbps
> to 10Gbps, with support for RGMII, SGMII, QSGMII, USGMII, and USXGMII,
> ideal for industrial & process automation infrastructure applications,
> transport, grid automation, power substation automation, and ring &
> intra-ring topologies. The LAN969x family is hardware and software
> compatible and scalable supporting 46Gbps to 102Gbps switch bandwidths.
> 
> == Preparing Sparx5 for lan969x:
> 
> The lan969x switch chip reuses many of the IP's of the Sparx5 switch
> chip, therefore it has been decided to add support through the existing
> Sparx5 driver, in order to avoid a bunch of duplicate code. However, in
> order to reuse the Sparx5 switch driver, we have to introduce some
> mechanisms to handle the chip differences that are there.  These
> mechanisms are:
> 
>     - Platform match data to contain all the differences that needs to
>       be handled (constants, ops etc.)
> 
>     - Register macro indirection layer so that we can reuse the existing
>       register macros.
> 
>     - Function for branching out on platform type where required.
> 
> In some places we ops out functions and in other places we branch on the
> chip type. Exactly when we choose one over the other, is an estimate in
> each case.
> 
> After this series is applied, the Sparx5 driver will be prepared for
> lan969x and still function exactly as before.
> 
> == Patch breakdown:
> 
> Patch #1     adds private match data
> 
> Patch #2     adds register macro indirection layer
> 
> Patch #3-#5  does some preparation work
> 
> Patch #6-#8  adds chip constants and updates the code to use them
> 
> Patch #9-#14 adds and uses ops for handling functions differently on the
>              two platforms.
> 
> Patch #15    adds and uses a macro for branching out on the chip type
> 
> [1] https://www.microchip.com/en-us/product/lan9698
> 

The series seems ok to me. I'm not personally a fan of the implicit
local variables used by macros. I do not know how common that is, or
what others on the list feel about this.

For everything else:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

