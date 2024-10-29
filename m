Return-Path: <netdev+bounces-139968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B8A9B4D3D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49C71C211AA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5D41925AA;
	Tue, 29 Oct 2024 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifSXvd6R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340E1917E6
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214802; cv=fail; b=j+VMlqbgc8mOJfrlZzvunVXhxaFaMseUBV98gabMzyIco7ii73GGdbkMvCOAvTk9lVXqSXR+OpzwZEywO497IEe82+dV+E/bws+wk3a0pbymstUzzwJXjXtIZi9bbwOEKjswnjdwaL8Dx5W/7Wkp6rAwNK9PJl65vmSjRy/hHBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214802; c=relaxed/simple;
	bh=IJVMZrtytubjGA5h9h1TYweN54jnjGposcLa4VvimOo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCp9zDqYAZVSXtm2nBXudPrkXkVJ9t0ILfBM6NhD7qAN1nhnc24YQ7vjoiI/ug1i9GI2i1DIF4AwWj4Ep5HViKqFmmCVVN9p0TRlaSO9DTrLoCzaUSdP9JX2FkbRTaN9db718b1gApfA7NiXmdul0m6e+wRg267/hTidZaES3Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifSXvd6R; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730214801; x=1761750801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IJVMZrtytubjGA5h9h1TYweN54jnjGposcLa4VvimOo=;
  b=ifSXvd6R8jCoyY5qr+cCki3ztbdagF78bh7z9kk2B1zmSUlaXPfwvtxw
   ellkpRBSyc852D59OVCq8kEG5CgjjJPfRcP2TU9imI5AYonRXadXDldOM
   seysiKDGzIVpAw0OoaBexmeB0kCwZuX4l+v+p9/BDmXHWlMIvE8uUQnmi
   1Grc9XApFTxGfpC1BLwEZRqVoRbfat075Et8WTR1RWdsnKHyyaCLYXIDN
   46eO+aI314BlVJES1eWOQdt0zRe/iMULUvMpU9YrrLcicqeA3Ti+K5Wnx
   icU0qcBNphWWwrxx0GR5U6s5HOPeqFK/eHm1ys5SZslCKgQIb46vMUA9w
   Q==;
X-CSE-ConnectionGUID: lCJEUiVITwSmCbeXSoyzeA==
X-CSE-MsgGUID: sCV4DaXIRTSJa0BEZ0t5hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="17495604"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="17495604"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 08:13:17 -0700
X-CSE-ConnectionGUID: TTAftVgcQEqVanN/3hXLnQ==
X-CSE-MsgGUID: qwa2FqMzRKSdXUsLJwUgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82802967"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 08:13:16 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 08:13:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 08:13:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 08:13:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSVQ9tXZGkDaQ+GlUAtDGA7cgzJWvx7pzNTs9sjj62VF3D1QrPb5mOLDfG43wkypHtCsMWjDZbFZ5bErMRjVteYTD8i7mNqXVPirqQFrcC1hE2H8FnmhzqrjnBE49+BL1/kOaYQmD/ye7P56/r6367I4WR6Ccot2rUNq2YxjrJWf/qCYznPLfy4jI9sL+2UKRxYJ5rtNm1K1Ft5bO4psRlFmVDuzx7DLLCLnZfNKomcDj0LyWVWRVOLgoSOeNlLqIQJ7iJ0kbGd5CBV/+TRX9GcqvgItGjun9vXBOWdx+MRIyKsDurkUqWfrFbCngHY3QS6ZpJOIBVTxa6Vy1JSHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54W5+HwvCu+yGaRvO+C0LumvWZcgKwjmK4+/ESmVrCE=;
 b=f7oB2s2vUTqp9H4Ncgrf5vMGJGQm6nJgv5WUGK8YFKfG8oh5NA7q2VdpB+gtn1K5KBW2H0lVVy3AR/Y1UPhJGHj22lni7Wpq74XtMKKFx4e9mOlbZ/fXyVJ5xFHJDEB8CUhL88VbLkT8kiPiS/LhBkKbFTsZ4nwXDmXy7aE+Ug7Vb3h2AYCb1UZfi9vUZ/85jhm8gpHqx+eGqlV0CaD7Ok/PZ232a0XhE3AP2XDrLMnVp9N82ea2981lizRqHi8gUvJ2/u8DQMJG9aD9ycAG0bdlaLJHKKuVwdhrBhJuGc29fA9/7wi/V5B5waPpdwWtvs9KCyUADodyJI4MAL5jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 15:13:05 +0000
Received: from LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c]) by LV8PR11MB8722.namprd11.prod.outlook.com
 ([fe80::314a:7f31:dfd4:694c%6]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 15:13:04 +0000
Message-ID: <54900c18-2acd-42eb-8168-dd600273c33d@intel.com>
Date: Tue, 29 Oct 2024 16:12:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
To: Amit Cohen <amcohen@nvidia.com>
CC: Petr Machata <petrm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, mlxsw <mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
References: <cover.1729866134.git.petrm@nvidia.com>
 <92e01f05c4f506a4f0a9b39c10175dcc01994910.1729866134.git.petrm@nvidia.com>
 <a68cedfb-cd9e-4b93-a99e-ae30b9c837eb@intel.com>
 <BL1PR12MB59225E9CAE5C28E915187515CB492@BL1PR12MB5922.namprd12.prod.outlook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <BL1PR12MB59225E9CAE5C28E915187515CB492@BL1PR12MB5922.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8722:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: e95866ee-fee6-4bfa-317f-08dcf82c2ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak9LSkxyc3Y3ZDBvV2VCL2hIOWFYQ2wrZkNDVDd6dmRiNG56NnB6Y0VuSlAr?=
 =?utf-8?B?RTlMb0dDM011ekl1MDRLOHByNnNvcjVlUllRUDJVQTUxZEJHWlVaVVR0U2hQ?=
 =?utf-8?B?dnNQQTFFajE5Wm5kN0RiaWpxTDJSQUtHMGZEYjkwVkJUSkxOTXFERS85ZDlW?=
 =?utf-8?B?VjNwK2JyMTZXRmlWVTBKRy9pRGZNOFpKcEFTRGVaSWtVaTlVZkNqQVVhNjlt?=
 =?utf-8?B?eU5HNlYzS1ROdnVZekg2K0RuYVhYWW5OY0ZqM2RnWEl6ajhid0hDN2crL00v?=
 =?utf-8?B?L0w3bkhJTmVKTDAxU2NqZDFaQjRONE5pOTJGS2NhN0JYUm5nV2NvQWg4Slhx?=
 =?utf-8?B?VEhmaFRveWUyT0NTU1hWUkRPRTcremxxWE56aFJmQ2kwNC9ZZXkyVXY3WG5R?=
 =?utf-8?B?dWtwMXBxZFVFcUJ4d3FWV1IwUDZvVUtEMjhmbFRwSGhVVHpKVG81c2hnTWtE?=
 =?utf-8?B?U0FYQUVHVTliVWNWK1laL0VjOFlPbHpBSGdUMEl0a3pZdytLQkphVVBRdjVy?=
 =?utf-8?B?Mm5xam9zUk1sbGF5TmVzMU9mU051MXArZlBSVm9VUDlhU21BdUQyUEl5alhQ?=
 =?utf-8?B?ME1oYXVXMGh5bUxzZUdCb3M4S1hLblBIdFNFc29kalJUcjByakhpK0EyZHJo?=
 =?utf-8?B?OHFLNGt0TnJaNElJMFJWQ203VklxSGhsK01EWVZMK3VmQVZXQnVNelJxbzB0?=
 =?utf-8?B?dnE3NU8zQW0yQWpqd2FjNFo5K0puYkhwRkgwemtDOGliNnQwWklURjI4azZW?=
 =?utf-8?B?bFpkMUhvNmZyckt4VTBRU3Zrc09SRnc3Y2FLdmUxOWNLU01uSjBQWnVuc3ow?=
 =?utf-8?B?RGJhMXlaYllLWTRuVVBPbkxPc2xhYW9vcmVIQUQyYXBVQkJkNE1TdWtNMzZz?=
 =?utf-8?B?NU9JbkxhWk9jSllLTEJ2aytSc0t6UEwvc3Y5TUc1ZTVsOGtWYVo0ME5UcWwy?=
 =?utf-8?B?VEVvMmFjYkhuR1JyVURWNEozR1NmdG0yeWFKSTFNUEEvUzNFOXRpajBtQXVz?=
 =?utf-8?B?MFlzMmJBOXl2UHFYeHJNcHJxTkdQUC8xQ1dsblk4dFFVd0RvbmlnYXQvblBq?=
 =?utf-8?B?TzZaT0VQWldZbXh3WGI4UFFEcnduVU5lci9ZN0ZqeUlXQ3FVZ3k4TW56R3dy?=
 =?utf-8?B?L0xCall2bHlianJRTlRmVURUTkZmV0lNSUxTaTBPQ204Z01GRytReEFQUE9t?=
 =?utf-8?B?eTdLcjEyblZKZURKMXFKSXVYMTJFODAxTXBwbVd3UHNRVXhSOFREOFlwTWpL?=
 =?utf-8?B?ZTZ2UkliMlpJeGFlczh4VFdDakRWY2NIZWMwRnJ1NFc4M2ZLdE9MeHNoNi9G?=
 =?utf-8?B?WUNpVUJxMkUrMGNyc1B1UWNsYjY1UVBhRU9USnpQUmxFckZUNjNSVURuS1Q1?=
 =?utf-8?B?RVl3cTVZYkNBaXgyVXpqQ3c4Vmo5Z2xBNjM0YlNmdktRU0tyR0JMekNiTWtD?=
 =?utf-8?B?cStLbHZ1NWV6ZFdXRTViUzRmWVhBV3IrdHBJckdjRGI5bDVhUytiQWxjK1VC?=
 =?utf-8?B?dTY2Ri9TUHQxOHd2YldYU2tQZlRnQVdMbjAyRVZOeTgreHVucFhBMk9DaUZM?=
 =?utf-8?B?S3E2dENMSXJxWnRCS1MvSERnVk4vbUJVWjREYjhyOVV2eWhuQVYwb3FwNlNn?=
 =?utf-8?B?UGI4MWQ1SDhBWTVaMWNTRStuQW9aR2JxeHVjdUdnVDJiT2l5eGFYTkdlbDRU?=
 =?utf-8?B?ZFNYdS9RWFNMdVZoMUN2SjdYWXQvSHZkNFIxQkhoVVExa0F6NFVuM1VnR1Jh?=
 =?utf-8?Q?Do376geaNfONDLYJBrnVvObno997BISeptTvAPl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVLS2ZKR0hoeWFzK2RFUkpDUWd3K25mdVRvNzVBUWIwOTl1ZDl4ZUhueFdw?=
 =?utf-8?B?U2R6YVhZd2lublVxUlQ1cElGaXMvdHd2TDZmQ0V6dEdlK3Jjc2hDWXJsRkhX?=
 =?utf-8?B?bWJhN1cyYzFoMHJnMEJvWEZQUnNWMHNrSUlvL0tCR2k1SjZ0akxDZ21HaEpv?=
 =?utf-8?B?YmxuODlwUWxUSGoyRU1zbVRUT1BPSzNvY250aGk3NlFaNFNzWVpFczNmdkdF?=
 =?utf-8?B?M3EzNm9LOGcvL3Y3WTVIWkVBT2JkRk81MkVPeitlQmRmVWd3RHBod2FhV0JL?=
 =?utf-8?B?bnBuNUVERFllLzhTMGlkTllZZDVvWUkvM3ZTQlJuRlBqZHFJNDEvWUtIVzhy?=
 =?utf-8?B?ZDRXcHNhamVVRVdndXdhdzY5OEdZY2hka2dtUjJ3OU1BaHoyY3h3dlRSVUFn?=
 =?utf-8?B?VTFwRUU3SEpDR212VTVDby8rWFFqVUpNNXRIcGI4KzRqZzdsdU5UT1pMaGdl?=
 =?utf-8?B?Mkc5TGVKczRwMnZ0QmUyVGcyVDlIT2VzbjBZcUxjbWh6UGU2YzBYQ29FbGcw?=
 =?utf-8?B?QXEyY3VWZ1o2cm9jNE9GMS9BSmc3TFdzK0hoMEJkNW5CZ0NrdzhzM3ZRM2Nh?=
 =?utf-8?B?eVUvSyt2bWJaWmx1eUR1bVlWc21nTERERk5WT0xNT1k2TXkrZWJwb0wvcHNQ?=
 =?utf-8?B?dkhFTGNDMzB5M21vc016UlVBYzBOZHFBeG90SVRhbnFab0l2bE9POXRPOFlk?=
 =?utf-8?B?VG4vaW9XeXY3bzY2dEZ2RTZDVGoxakR2ZDlvdzZ0cHBVNUo3c0s5Q2Z3VlNL?=
 =?utf-8?B?RXJHakVRajFUNi91VjdMaFdCZUsvRnVIcFFpWjh4RWUydk0xcVkrc2Z6V2tV?=
 =?utf-8?B?blJiVmxMQmhER0JVTlBRM2dEdW5QNWJlQk14VnROMHJnbWxmVmxQYnRyWEls?=
 =?utf-8?B?ZVVXbHFzdm5KaW1mcUxUSU1xTFN2ZGdmSFdwWEtaVWdLQy9NS3NOUVhIaDB1?=
 =?utf-8?B?RFlsKzgwRmJaQVRUa215YmZDOWx6a29yY3hET1NBenppQjk1NkJjVHZlZ0xI?=
 =?utf-8?B?UHIyRVZ6NytOcU81a2QwL25DNFltVHFQdGxyRXBTQ1hFdWVmeVZJSlB6aStD?=
 =?utf-8?B?TDdlaW16U2cvTGxjaTgrV2xzM3JDZDFyaWUwbS9FWU42cTJpQ1FlamhqZXdt?=
 =?utf-8?B?clhyOFdERmdvN3VFZjRncUdEdTEyYmFjWTJRWW1GVE9oNFQ1RFQzQTJpc20z?=
 =?utf-8?B?RWhua1ZaLzJVVXJaTm1MQit1eDlpV2Y5bVh0blExRHlOVnpuOXMxVElSejA0?=
 =?utf-8?B?Q1E1VmJ1anl6V2tKdjFOQ0V0WVdLNCtFRW9BUnpXN20zaW1xNktWWXk2NFRz?=
 =?utf-8?B?ZUszL2pKY0RDVDYxWUg0UlJuQnVJOEwwNFByaWI4dWc1V1RldmlmR1NlL0p5?=
 =?utf-8?B?dXJPV290U3VRVHRXWkpKUElPNDlkb0hTT0JqRGx0eEJXSUExdlc3QkQrNFZT?=
 =?utf-8?B?cEZsc1NHbWFidkpGUmxwRTUxUGl3LzZpTk81S3hRNENnbGgwWFRIanRyaHdP?=
 =?utf-8?B?bFJLYXF5MEh2YTFLZGh4MlN0TFZwNHNEaXNLUFMwVGlua00ram1wa1Nsbzkw?=
 =?utf-8?B?OFV5MGFYWDJUUTNvZnRHVlMyODZWOFlOUTV3RFpDZnNVOE9mRGVXd2E5U0dQ?=
 =?utf-8?B?TTFlbUZFSGVoeHRvbGlvd0RKdlo5b3lqSkxBS1FNTnJucXJiVzBYcXBOZEdH?=
 =?utf-8?B?RktFc01xQ2lWemRtcHhsTXZieFVpa3JIQ2Qxblp4cnhwTmx0MkFMcHZtVUh1?=
 =?utf-8?B?bHFtbnNFbXRhUTJpekIyU1dTY3FLa2VUV0pZekFrckxjTWVUc2R3a2gramZz?=
 =?utf-8?B?Vyt6RThZVWhlQk9oQjN0N2Q0VHlLLzg1WW9GSUlLWGNoaDIzRlpzMlVrVjQ2?=
 =?utf-8?B?N3kyWDh2OGw2M21lNjMwL1lOVTZtZVNWbk95WDR3ZWxCbUlLTW9rZFZORFNV?=
 =?utf-8?B?SGtIM3NuTUhoVWExMFcrcys4cnZJV0U5U1F6d3lBYmVaV2VaaHh4dkc5T1Yx?=
 =?utf-8?B?b0dnb1hHeVQrdFJNWEdKYlArd1BNTDMzcFVQYjBaaFV4SWRoTVhzS2FJcE1r?=
 =?utf-8?B?OW1ONmwzOEhxV3FWUmZkTmhNTENUdlhmRlp6cSt0bTk3QnpSRFJ5MHA0U3FW?=
 =?utf-8?B?QkYzckQzUEJObjNtNCt4WGRLOFlWUXFrYWlmWWRJMWVUNnRLeUFJRE11NHdG?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e95866ee-fee6-4bfa-317f-08dcf82c2ff3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:13:04.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4/WYHSyZgRdAufF/7ka0d37g/JbCQevQcrVCsxoyUDyc8PjQhaQlu3sxxsFHurFGTGK56eyU54wGcQeJeVrJZTP1zNEodXYR9shdAlFGgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com

From: Amit Cohen <amcohen@nvidia.com>
Date: Sun, 27 Oct 2024 06:51:00 +0000

> 
> 
>> -----Original Message-----
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Sent: Friday, 25 October 2024 18:03
>> To: Petr Machata <petrm@nvidia.com>; Amit Cohen <amcohen@nvidia.com>
>> Cc: netdev@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>;
>> Danielle Ratson <danieller@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; mlxsw <mlxsw@nvidia.com>; Jiri Pirko <jiri@resnulli.us>
>> Subject: Re: [PATCH net 3/5] mlxsw: pci: Sync Rx buffers for device
>>
>> From: Petr Machata <petrm@nvidia.com>
>> Date: Fri, 25 Oct 2024 16:26:27 +0200
>>
>>> From: Amit Cohen <amcohen@nvidia.com>
>>>
>>> Non-coherent architectures, like ARM, may require invalidating caches
>>> before the device can use the DMA mapped memory, which means that before
>>> posting pages to device, drivers should sync the memory for device.
>>>
>>> Sync for device can be configured as page pool responsibility. Set the
>>> relevant flag and define max_len for sync.
>>>
>>> Cc: Jiri Pirko <jiri@resnulli.us>
>>> Fixes: b5b60bb491b2 ("mlxsw: pci: Use page pool for Rx buffers allocation")
>>> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
>>> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>>> Signed-off-by: Petr Machata <petrm@nvidia.com>
>>> ---
>>>  drivers/net/ethernet/mellanox/mlxsw/pci.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
>>> index 2320a5f323b4..d6f37456fb31 100644
>>> --- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
>>> +++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
>>> @@ -996,12 +996,13 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
>>>  	if (cq_type != MLXSW_PCI_CQ_RDQ)
>>>  		return 0;
>>>
>>> -	pp_params.flags = PP_FLAG_DMA_MAP;
>>> +	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
>>>  	pp_params.pool_size = MLXSW_PCI_WQE_COUNT * mlxsw_pci->num_sg_entries;
>>>  	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
>>>  	pp_params.dev = &mlxsw_pci->pdev->dev;
>>>  	pp_params.napi = &q->u.cq.napi;
>>>  	pp_params.dma_dir = DMA_FROM_DEVICE;
>>> +	pp_params.max_len = PAGE_SIZE;
>>
>> max_len is the maximum HW-writable area of a buffer. Headroom and
>> tailroom must be excluded. In your case
>>
>> 	pp_params.max_len = PAGE_SIZE - MLXSW_PCI_RX_BUF_SW_OVERHEAD;
>>
> 
> mlxsw driver uses fragmented buffers and the page pool is used to allocate the buffers for all scatter/gather entries.
> For each packet, the HW-writable area of a buffer of the *first* entry is 'PAGE_SIZE - MLXSW_PCI_RX_BUF_SW_OVERHEAD', but for other entries we map PAGE_SIZE to HW.
> That's why we set page pool to sync PAGE_SIZE and use offset=0.

Ooops, I didn't notice this particular configuration has offset == 0, sorry.

Thanks,
Olek

