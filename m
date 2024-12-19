Return-Path: <netdev+bounces-153417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62CC9F7E2F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22541164B7C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6A15442C;
	Thu, 19 Dec 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="be7oKO/L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58770824
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622633; cv=fail; b=lx47NRmmYhkDRm+LxYmKK8vHa2dMkunbT4be+UpcSaSpr28Oil3pE5JIaxhifXg7Gg133Qm7jLcA+2bbbXQiH0tE2P/hKt8hNuUzjXHfA7xPst4zZu5WndgMt1oq8nbJq6A4BcqnVCt/akNZ1zP5X2T8+lSE6jRp8Fa7KV7e6iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622633; c=relaxed/simple;
	bh=ZPRTjDmWzopCl0WZyxsh9gS6Lu5TftkNT6wfASp+R8A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hj1yjOYI5O8Lq6mhVm/QJAw/2Zn5DHq9TZJ27em42Zc2yZ6lClN564Kj4YYZtaK0FyJ0JyMRhU+HrQu/u5xe8fWmwz5QfYjBGL9D/3boAg8V3drBX3rEiCugWS0EFIFn91KxzKdOtB5LgsFNoY/E9nJe1FK709uARLir5MVLajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=be7oKO/L; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734622632; x=1766158632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPRTjDmWzopCl0WZyxsh9gS6Lu5TftkNT6wfASp+R8A=;
  b=be7oKO/L8SiMXPKk0T/MXxEGMQoACybLB6ZOGOW7RuWJV2NFYPvc56aG
   GtNIdOauWRs5oSWPodN3IVxnRxPrY402+Dx+Ba71ccVCpTYPNpXakktN2
   HeKSX/D2ZocLmL332AeKixorBapegUXR6DJdrc/qO98qpQ0Lw18HCX0R6
   sVRrihFrMBz8pKIk41ysXGdaVVFOGZMQlsoUkl2RsqfeYvwcfeDudJmTG
   aePU5WDkF99eoXH/JEAiwBwueWB1xl3fsPYQmSplwtZYyTJKT3xW2G4AS
   YsiqZXTbT3ZqNKsik0RQB4MsMLsKGW83D1qpeZaiYBLi8txDivhU6Kh39
   w==;
X-CSE-ConnectionGUID: FxlHQ/IqQD+0D3vCvGePbA==
X-CSE-MsgGUID: ftiCbuIOSteupIoGemhYpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="38915974"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="38915974"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 07:37:11 -0800
X-CSE-ConnectionGUID: aaNR0ncSStuw+5az6bMx1w==
X-CSE-MsgGUID: vRHdpYEJSIqhwnqXjdUfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98626788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 07:37:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 07:37:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 07:37:09 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 07:37:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKVahSbG47bArxIqYviYIPV4I2SOwdDYJW5I2x7J8TT32ox7K4NZwUi9IKVhL9MfY3v034OM73g858YX/lNcWi8oRERbjSpPE9DqqG52xd97rvK8oRkQs8w5zCL4jEwYVx09uatVL9QVzkE758KWLSYPZzFuXH7YIHbRAKiwos70HDiwMVhvMJP2DovMQCPELbXXglKP16ZbP2076j25RvWCrtvqjKmvTC7RJSWFHXggo0tw2ocprmTYuDnAicFlqL75rHgQ/15QGacsP0m9VMWPWR4C12oRxzTtCgNj73QHXiG++PHzAOQ2RGgHKVNIgV4asN4Xc+Fd147ERAgRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGUowlAguzFzj1aC4f5n5M0JRV9oUTfE0ZhTUmP/zgY=;
 b=EdZFIJhjroOiSJlMhN3yR3nyrsHeuDag/9YRC++2Tyje4gFN0Cwe4/jwnkrnCNbOVZvVJGWBAtWPnpTVNWGys8+67u/KWQ8NdlhR5wWwQDMpYRmAMR3qUooAcQ0EpKbjA8klDmd9CAE3DDjNpsyajAc7kGiL95mlc89mChSDGbgnqBXsgGP4ziGj8eWoMrgSE9KKC9qO4zkBOwgtU287f/F9fAhjO6DK23B9f9tQl2oYxlBStrcB9yQFRIjYqmBjnLGv5oOBWp8b0c/DtEK4pAf14IUagQoo+vnYG9L5s+sEOz5LVaV6RcovVnQ957lwR+lSmHGj5SxaIhPGHwWykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 15:36:54 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 15:36:52 +0000
Message-ID: <e241a7a4-1128-44a2-ad9f-1d5424c86e22@intel.com>
Date: Thu, 19 Dec 2024 16:36:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 04/11] net/mlx5: fs, add mlx5_fs_pool API
To: Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, ITP Upstream
	<nxne.cnse.osdt.itp.upstreaming@intel.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-5-tariqt@nvidia.com>
 <0c6d6368-85ab-4112-a423-828a51b703e1@intel.com>
 <d8788869-51d6-45c8-9009-e72453cc381c@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <d8788869-51d6-45c8-9009-e72453cc381c@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: a7185d08-8cfd-4759-54ef-08dd2042f5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFVRZ2V6M3FPNFVvbEVXbmo4ODRoRklCak5TM3hUeTdPcUhMK205ajhvYkRE?=
 =?utf-8?B?L0JiZ21XWXhmM21YakpWcWtITEJRaUJJRUthVFB2Q1BXeTV4Vmw0N3ZnSWtJ?=
 =?utf-8?B?N3VZQXlZeGV2TEFGUW0xc3Q1cXYvQ1NXaW8wdEo2YUFBVEZUaUlIUWlFOFkv?=
 =?utf-8?B?OGwxY1Ria3ora1NsZUh0cUh6UXdxR3J3bVk0azR0U2hBN1ZaM0wrYkhrTUxk?=
 =?utf-8?B?ZlF1djl3a0J4RXRSRW0yd3V3YUt2dE0ya2piNGJKcG9TN0p5UnAwemVkT1g5?=
 =?utf-8?B?Y3pLZzJhY3NxRjdYamxBNzJPTXJoMUx3eTlNSTlFUUVsTkxmZHVvR0RHQUY5?=
 =?utf-8?B?Y3huK25rZGhsbmMzZXlYSGlkSHo5RER1YWJKTzAxVUY4WVFuWEVZcUdLQ0tl?=
 =?utf-8?B?b2I2NElud3AyQUwxeWhIbzR0UjF0cGZoMmJqNG9UMDJpQUhLWDNnMDljNlhN?=
 =?utf-8?B?OWdPN21USTZWMEFXYk5IN2x4QmNwVkhhWnppNUdWNzQrZyt6aU9WcDlMdERh?=
 =?utf-8?B?V2tzSHFCYkxUQytNOHBDYU9ncDNRcFR5WnZKTWRCVm5uOWp3M3VoaHJzNmFk?=
 =?utf-8?B?c3dQaU4wZGJFYjJUTVk5RzhwbkZ5ZnErZkJrc3liL2hHWlBTOFFPL0s2bXpU?=
 =?utf-8?B?TEttbUVnS1ZhSFp4dHBBYVgxMXBUci9mc29teE50OXlVc0hwVDZFVkRzdzli?=
 =?utf-8?B?SnN1SnN2WnRqM2oyRXcycHJpa1BFeVlMYXdUd2VpWnR5anFwUnRBZzdrWlUr?=
 =?utf-8?B?SHVwMEwrQisxTVg0MWs2RVpjM2dFWHJtejRiZlBCYmxPeTNJdVd3RGJXZUpU?=
 =?utf-8?B?dC9pTjE5aytXL3A5cnlEQjVOR3o5d094V2JaZUdxdEJMcUdheHR0Y1RMM0pa?=
 =?utf-8?B?RFRQSWVvZ3RkYWZkYzhQTm9JQi9lTTN0bEFRalRHWVBYVXNqQ0NuN3REajdn?=
 =?utf-8?B?c3FCaDRxSDJCUmlaa0o5ZFZPRVdUZXNwS3lENDF1MkVvR2lDSFUvbnVXbDZ0?=
 =?utf-8?B?QTVuNEhYRkkySDU5Y0tDcnhlU2h2a1dlZ2k0ejl0NzVtUnVXVGxMTzRVTnRP?=
 =?utf-8?B?NXBpY0pLa1hxOFBRN1JwMjM5bk5DSm5PR0hlZUFkaVIvVUFNbHh5RFVLdkk2?=
 =?utf-8?B?K2lPL3NPN09mMDNONmFxbzhqSjY5SmEzUy9xVnV0VXpYWGpIbTJYL1BSOHk4?=
 =?utf-8?B?dmRWUHU4dE14YWl3cWVnS1E2Wlh1Y28zNE5pMHN2cHd4RmFpUWlmNHpMMTg0?=
 =?utf-8?B?VTYwVzBaeGhHeVZwUGRtL3c3WlMxN1FjQllQbldqNFVCZmdSalgvWE45UU5F?=
 =?utf-8?B?QUpRaTg2blF0S0Vndk9WTmpYeU5Lc05OSCtqYkFDc1Y0WW1OZkU1dkxSejVI?=
 =?utf-8?B?YTFYMklGQzhvaFZSV2xXUXJackkrTkQxdDVRSERGZHE2aGVQenJQK0IrdmFk?=
 =?utf-8?B?VUs5YzVyMit1Nm5NL05aRUE0eUlFN3VDcWd6MnJxZmFGWUpPU1RvMVFWNG5O?=
 =?utf-8?B?ZmNNcU9UZzE3Nm9vMjdMcEtQd1h3djF4MGtRbXQvdG5OdFBBelJwajR3a1dk?=
 =?utf-8?B?ejFaM2hzZnVZYUwxTHJ1VGNUNVpXZmh2c2RPdEk2Y3I2bk11N1ZrV2duaE1w?=
 =?utf-8?B?TkNKSGtrSnZtajM4Uml4WEZ0UGtqZnFXdWRJaG1ha0dHcW9sMGt6MldPTVB3?=
 =?utf-8?B?WnlRRlQ2endFL2xOdmdaQ3hjODBzaUpWdUs0a2lwWHI2QTdSK1FkcEtXQVBm?=
 =?utf-8?B?Qlg3MGdrWis5NGU4WUFZS0hNWTNnYmM0bVN0UkRUMFpDNFJOenhianRIazZW?=
 =?utf-8?B?TEhLUjA4WGlCcEF3aldIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnV5YmVmSjY0S2pIMmFQejcyZUQ4NXUrTzlVcDJRUGVBaGxRZHpGY3VTQkVl?=
 =?utf-8?B?ejRRNkpyWGpNaE1qNVJrZjQ4MktKTWdZREZ4Z0RTNitRbVNWZTcyOFJQTXFZ?=
 =?utf-8?B?aUZ2b3M3RjdBQ09yZ1BwS0dKcHBhM3RqQ1NIN0NJQ0NnVlBMR2poZVpXWTdI?=
 =?utf-8?B?bXNpQkFOQmsrYzlSak11MG5rYit6cmgvcHRMa01JU0ZiWEhQOW5iOVR2RHdp?=
 =?utf-8?B?citxclNEdmt3Q3YxR2F6VEVYdTRpVytJeWc3cjNHbTdYUmovZjdRTnMrM1VO?=
 =?utf-8?B?RTk0dllxWTdEcHRlOUoyUnV4UHJzWENvQVM4Mm9YVnFLUTNyRndkM0ZWQi9q?=
 =?utf-8?B?N2ZYNUJGSllRVmNEMCs4SS9vVlFxUjdsbmxnZUoxL1FOYkJwdkJhQ2k3R0RX?=
 =?utf-8?B?QUpVZ2NqWXNRUURabHJXa2NkRU9odmdFTlRkTVh6SlFLR3pYSzk5UW9KcDdz?=
 =?utf-8?B?bnZ4WEpWaU44ZU80a0tXNStCVkRoVVkxWHVpbjB2SnVmbXJrejAvTWg0N1Vm?=
 =?utf-8?B?NjVuejVEdys0b0IwOUg5Z2dVM2Y2ZXF6bnFxTjZHbHVnQUtYTDI4T0lESG5u?=
 =?utf-8?B?QjRRdXBkM1RqQUYrNnNkbTZRVDFkN2J0YVdMRjhNSkV1T05VeXNKdDNCMXo2?=
 =?utf-8?B?N2JGQXNIcm1YN2hRT3lzTlBmMU1jSDZHOHNIUkQ1c0oyR1hpTlBxRU1rV1g3?=
 =?utf-8?B?bCtwdmlEWmZpcFpuR1VJdkxJMVNrZ3NBUUh4bzdBRGJwU0RRY0M1ejZqWXc2?=
 =?utf-8?B?R2ZrTGEwcUlieGwyYnp4Z2lGODlzNkpxUEx0YlhkK0hkSXV3ZXdrdUt3QkV5?=
 =?utf-8?B?dm9oUFRrNk4yMEovaS9hM01aZ3p3ZTRvTERLRG1ObEtGRnhBcXo1VUFEM0lp?=
 =?utf-8?B?UGVTZjVRc0w3RUozeWFGTXRRbjRGS1d0MXJXU0d0akFMQ3JlNUNoTTc3OWYw?=
 =?utf-8?B?YlY5ZFRxcFlpb2ttdE1zai9VRHRZUUdvMzgyOE5HUXFTdkVvLzBRL1Vyb0Nl?=
 =?utf-8?B?b2p1cWJsK2h1UmlVdDZrMFpSTUxUb3JZS05MdnpPYTFFU1gwSFdRaDZzdG1K?=
 =?utf-8?B?eWUxbHRPdjdrTmNJTzk1Wk45b0J5MStiT2d1dGhHZXEzTGdjSjNhUkxwWjFt?=
 =?utf-8?B?MUFpMWVKaHZZL2VDajR6d0w0UUhLcWtRNHM2czd1SEZYcTk1ZzdVb09iTXNk?=
 =?utf-8?B?Q3NaZktEWHI0VDE4RDNBZjFlOXI5eXpXK2daYkQvNitLRUxUcjEzcjNCVi85?=
 =?utf-8?B?azNIYTFTWHVXR0hBc2F6dmN6UkZRenoydDVJWnRtc1ppYW9SQzBOY09VQjkw?=
 =?utf-8?B?ODJ5RmRXbXpmcmI4UEErNzM0S0JMU0RYTEhmYjMrMkZnYkRLNW92ZWtNUFNv?=
 =?utf-8?B?S0hpZHl3WGhxVDB5ZzhPSVZyZFB1QTlxRm5aRHdZbE5iTlFFdmQzSlc0anRJ?=
 =?utf-8?B?WTBIdmxURTJabVh6VFQ0eEU1OC9iSEJTSlFmL1cwQXF6V05SOUVvbk41cCt2?=
 =?utf-8?B?clVZMzdtTmp3RkJ3SDkzeWg4T0Nzb1FqdjQrYXBYRnBmNUpxbmxlZmd0dWNw?=
 =?utf-8?B?NHRZeHU3ejNmUjVFQmt0YU82bklWcWhRbVJvcExydVdmWnJvUkRrbzNJQXdj?=
 =?utf-8?B?QUlpZ042WlN2em1EMGJZTWlOdjNiNVFua2dVd2RvL1IvdUo2dDVYMWs1OVlN?=
 =?utf-8?B?Q0hJNEwrRUx3Wk5DMUxoVnExWU5EbVNEaWRKTWJhVU80dnhpTVdmK2NiRHdL?=
 =?utf-8?B?amhqRjN1UmVPM1E5VHpwZjlHc2IxS2hPeDgyeElxMzFIaGRkTzk5SVJSM1hK?=
 =?utf-8?B?YjBPeE1jWGRnMkhidVBHTTcveEtBTkxPZ0JFSTNLMFVGcUdtNzh2Si8yelAv?=
 =?utf-8?B?dTV6NXEzRFRHYkt6R254VlBrWU1BMGRScHEvdVNwVEljNmlKYXlzSmRxVmN3?=
 =?utf-8?B?SjdYNkZtSWFLWWNnNHFIb2hKOUhhdzloN3oycjJtaXdrSEJrRnI2ZnpRV2FM?=
 =?utf-8?B?TVRLVE1KMVA4NHg4N1BUVEgrbm9SK0pVVHFKWGlxeWtQN3RQUW4wWE5WQ0pw?=
 =?utf-8?B?eEgrNEx4S05udVRzSG1ZYXNyOEtJY0FhZitMczlwOFpzTWJHVWxhRi9OakVn?=
 =?utf-8?B?ZG1UaXF4VjVaUGhzdkUvV21tb3p2ZTlINy92WkJjYVM3ZDlscHJDR1duRURa?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7185d08-8cfd-4759-54ef-08dd2042f5e9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:36:52.3591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yS6p5iqINa1oVqhNm0OGQUP1Jft8cNgWJPDP9o51t+otuP3z2+Ze5b5xzWQw06gSJXqhIQ5KOyQYYyBZynn0IJXsaCeJJPk5BEynQUghbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On 12/19/24 13:30, Moshe Shemesh wrote:
> 
> 
> On 12/19/2024 11:17 AM, Przemek Kitszel wrote:
>>
>> On 12/18/24 16:09, Tariq Toukan wrote:
>>> From: Moshe Shemesh <moshe@nvidia.com>


>>> +     if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
>>> +             goto err_fs_bulk_init;
>>
>> Locally (say two lines above) your label name is obvious.
>> But please imagine it in the context of whole function, it is much
>> better to name labels after what they jump to (instead of what they
>> jump from). It is not only easier to reason about, but also more
>> future proof. I think Simon would agree.
>> I'm fine with keeping existing code as-is, but for new code, it's
>> always better to write it up to the best practices known.
>>
> 
> I tend to name labels according to what they jump from. Though if I see 
> on same function labels are used the other way I try to be consistent 
> with current code.
> I think there are pros and cons for both ways and both ways are used.
> I can change here, but is that kernel or netdev consensus ?

Would be great, but do we really need to open naming things for dispute/
call for moderation? (To give even more trival example: I always push
people to not name variable "status" when "err" is better, should that
be in the official doc? xD)

(to be clear - I'm fine with setting "the rule" for new code, to don't
mandate change for things already in-flight)

--
Re convincing: I would say that "came from" labels have almost no
benefits, and according to wikipedia, people make fun of them since '70
https://en.wikipedia.org/wiki/COMEFROM

It's hard to make a good came-from name for a label that needs to be
jumped-to multiple times.
Such labels are also disconnected from the code under them.

On the plus side I see only "a bit smaller diff" in some cases. But that
hurts when you just move a call with it's error handling, because, due
to name, it looks fine in the new place, but it obviously isn't.


