Return-Path: <netdev+bounces-205860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D142B0078B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F90C7AF9C8
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C76274FDF;
	Thu, 10 Jul 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie97GR1X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A0274FE4
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162601; cv=fail; b=VHeVj9OYbsOUi8oLYBtyY8cJGXIEoNvW0CEJhZUisRIylSR3fboFBWYuEwg+/TBps6aqwGMyhO/i1zUnZMwWBC6iknc+tmkA0+I8Zn/6tPMqO6u7QyzOyYC0xOYVtFHzwFkKcPDPcLkDVi4GEMJsOpXxzIPbkzwiu0aXeeVKNpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162601; c=relaxed/simple;
	bh=ysFUxkYeU+PAI7Fo8N+rG77JrElG0LBgG5XlGgWqtd4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSQ+XaOZ62necXh4grjzO/VxuxHt61PgdZAMbryl3gLq6DFjF+MBCkGwOdXsJGbIZztWuAt+7zgUMoNuvCUN+Bzq5lEi3XWv8JwoCr+e5xNfZDKKWzlimmOPsnznxw+FnBrdJkOupa6v5v9FvvTJJ4Qtem9IyFw4RRzf/oxp3o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie97GR1X; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752162599; x=1783698599;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=ysFUxkYeU+PAI7Fo8N+rG77JrElG0LBgG5XlGgWqtd4=;
  b=Ie97GR1XKIOxZNCKD7diIej0SfOcB8otrh5o3lQoXNEzsg7ks3DaNBzI
   VPKgLGvTywBdHxRi2+aR7rcLVLRtaUmeRGImLb6Bn7Pub26/sGRW0WRz+
   d2GzKYrxSiMtSK2cLBLyQnp+hRm89FQizbqxF9DGhGJ6CRLOJKRMQ8NNx
   R+lA93+rvKOHtblG61jnMvVviyV5Ho39oqtxOW+AWubUNo77wwOKkuhGL
   ZdFL0IQ2yOML4FjeLIuQfonCx5xpjZABwTmpcNb4fqKZSPqufs5e/6EQN
   0/rCgHn7elyfk6PPrZL57XM7Qw72+cPSLOOHz6i0I9wusYepJh7T2D/RM
   Q==;
X-CSE-ConnectionGUID: OYonzSu6SaaT7mqBCVk6lg==
X-CSE-MsgGUID: SrD11Eq/RJ+iP+cXean3VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54602648"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="54602648"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:49:59 -0700
X-CSE-ConnectionGUID: FQCjSSgsQqyuG5nryLtrYg==
X-CSE-MsgGUID: knsC+HE8TRq3tD+mYZI6aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="155552386"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 08:49:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:49:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 08:49:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 08:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgWPLI/EB5JgpyI+5LNGvxqGs/uGw1kohMgxnlMbjABLiaicMgZwyxZ0CLJ8um0XgfwdxRUbPhoNb5YCEKvlC5tzXnJFRMTGv66p52JcnTwh4QJUmO7lZgsGfBwSXs32/KjWhDHR8wAywG3LGLMzPVerAFxnoqpSz0wWDWudxD/LhyOQL0Zfc6C+yLUucD9Y2tBaqMJde746KuYu27MN2mfsGF3/WmSX9UpNyFtAiZdD/j3QgEEsCwZlRJ7fTVRM587yIHln6FL2Qkk+W+JifLMapFVIcn5JTBHDVFbdTk3NphVqQ0clPUgdj8kglHB/vkNssln1KBnDtnJSSLdiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7pigFKgIrWxJZP4oOkPNC6p0rK/KrynVVUlYHYd8kM=;
 b=wxMOsQRj8Byy7GHXlCo9rvDmQjL0U2RNPZLtYTsAMCqVbi0V8Np83ZaE12JdE83MXvvZdyg3e/aULUdMwCtciBwnV6abukLLrxIRUQs0Js8TsJZD1pyW/yPXXysXBY/pJk/UHuRtS5BMl7iRZ87Hf6MWLe0M61mT8epJ++hvmWEVP4RVmXQg7T96zOZO5fVjO0vHxnE61l9byWowV1V7T+4c91X6zhL0cW82nO36flWB9Jugx6WHzDzbnK8uwDp97K7R0OSw+h8D1ilvQUicmd92OVjlgJiY10miZHUd7/rAwSuSI0UJyXe9KyNJP53JYlpTKwT2Hs7yInN6Z9j+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Thu, 10 Jul
 2025 15:49:41 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:49:41 +0000
Message-ID: <70a20532-3602-4e3d-9d48-28fbb1f23060@intel.com>
Date: Thu, 10 Jul 2025 08:49:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>, "Alexander
 Duyck" <alexanderduyck@fb.com>, <lee@trager.us>
References: <20250709205910.3107691-1-kuba@kernel.org>
 <bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
 <20250709171138.5da9df21@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <20250709171138.5da9df21@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------9Ey4CC9MPt7afkXaFuhJwDgM"
X-ClientProxiedBy: MW4P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: f3648ec8-c36e-4903-6cb1-08ddbfc9625b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkQycmNYbDRiZklCbXhxbFJtVXFVZEpuK0hpbGRvb25pUnFjeXZhS0dKK2cv?=
 =?utf-8?B?QkJZZmZ3cEZuQ2d5WFQ3d1Q3K1hqQjFOM2xqSnRNMCtjeG5qbGFQNXdjL21k?=
 =?utf-8?B?dGFRWFZYQklNUVgwcWJOcmRGemp2SVR6K3FhRktiN09yUWw4czhYZ0VTNndt?=
 =?utf-8?B?T0tUa1lGSWhNWGhCakhzbXBGU2hTb1N5eGxZZGhXN1F0dTJGenROL2syQWc0?=
 =?utf-8?B?cktHRkJ6WFBhYVFrRXRsdnkrcmFyUHJvNWtjZ3IvZE81SERnaDRmQzVEVjdB?=
 =?utf-8?B?ZTh5Z1p0NjFiK3RFVnhFa3o0a1IvM01QdTM5Z0Z3R3E4WXdPM1FpRTBkQTls?=
 =?utf-8?B?RUVtbTEzOWExTi9oZU05SlU5MmQ1dHRmTWpVSzNiRnpqb2VQS2JIa08ydndw?=
 =?utf-8?B?QXhreUxOT0tZaGhQMnhlQmdEdi9RcUg4dnpMZktSUnh4SjZkeUsxcnFrY0VC?=
 =?utf-8?B?RjdrMzFtUU40cUUwWGcwekJtdE9qK0FoVDBvOEdUcUp1a1greFQ0WFJaK1Jr?=
 =?utf-8?B?Y2VFdFY0NjlrLzQrdStBZWdUWWhOMzdGcUNINEFvMTNMb1k0VTlEVG01dW9n?=
 =?utf-8?B?ZDBDNURoOVh0bGZ4ZlNGVVdzZmFrR05TeXJEOTduQ2VKQi9CbXV2ZVVIMFZn?=
 =?utf-8?B?RHMxeE5pNC96c215U2J4UGIxSUp4Z0FwWnUyb3kxUDgvNHFRUkZrRG1jZlJr?=
 =?utf-8?B?Ym16cWZGYzNySjc3YW8wd3hRL3RqU21ZQ3lSNkY5bnVNL3JrendHcER1Y1Y3?=
 =?utf-8?B?bTdBTldvVVhEc3dkamcwQUJMWG04UCtaYTlTODNZNExqcjR5ZElWcU5qTzJH?=
 =?utf-8?B?dmdibEpVU2ZZV1ArdUk5aTh3c081NGhDM3FrMXozTG8vUVFZN1RlK1Nkb0po?=
 =?utf-8?B?cXByMzlIc2hkRjQrbnMwNFJOR2VoWjFNbjgxKzF4dmdqTUhyWUF1ZlhJNXpB?=
 =?utf-8?B?TWVkWVRhNmppekhRQ2MvSUVralFsMUxzWmUrTmR0SElaa3VEclFOVUVMT1lP?=
 =?utf-8?B?cWJraU1abGp6SXJ0OVROanp0QUZNM2JUWTlmRmhiRWRaWVlyd3pralpYRFJC?=
 =?utf-8?B?YUVSOXdFY0E5TExJK2xUU2Vtb0o0bFFWN0p1WG1nU3FhS3ZMT1Q0WWZjNHA3?=
 =?utf-8?B?VzJ0VHNaNmFhb2ZPZG8wUXh5UXMrdFZVTncwQ0V6THdWenNhWHBhd0NienVa?=
 =?utf-8?B?ck1LamViRlVzSzdqRkRIdDRIT1M0TTBUMGZxM296M3RCQm13N2VTdUJvS1lL?=
 =?utf-8?B?OXkwc0cvOUYzRU9RZUltOTBPVDZFZGdCb1dxMExjMHlpUm1kRXB2N0UzYnVT?=
 =?utf-8?B?K0hMTU1sSVl1OHBWZHZoN09JRXJHWUN3dm5SMy9BUlhlZDhPQTZhdGtwdGlt?=
 =?utf-8?B?V1htWE0rZnhkd0dBUGx3VkF5UG9NOG5LWDR2NXZXZ0VWc3ZxNFFwMk5KS0p6?=
 =?utf-8?B?UXlITStINU8xM0F2OWpnSUpoYTlxdEw4L3lTTy9BTkRaM1FkV01IblQ0cjVP?=
 =?utf-8?B?dVRVWDdpQm1OeWcrZkV1YnVrY1FYVjhwUDRHc0NmQUU3aEc4TCtFU1IxZW5w?=
 =?utf-8?B?MjZ6SWlrb21ldHlhZDZvQmY3SlpEaXhMeXBVMXpxVkwwNWJwSGhrRXBUT1dK?=
 =?utf-8?B?eWpKVDdiakZIMVBKUEsvUUI0Z3h4amI2NlQxNXhMYlBHUVpuL21mbWpyeVhz?=
 =?utf-8?B?TDBLMFVaNTZNdTV2TmtmRzd3T3g2OXRGeTFCL0w4SktHdExNbFZVc1BsaW1N?=
 =?utf-8?B?eWx1OGRmMmU4a2N5L1djc3VOd1YrUGhnaUpFa2tyNWhScU5QQ3pMV3lBRHpM?=
 =?utf-8?B?eks4TzNSQXFQbDh4K2lvYStqdWZLR3JpVFQ3SFQ4ZWplRzJtT0F4bFVPSGpH?=
 =?utf-8?B?Z2dIamdpa1NNUTBRb2tFS2RWRzI5RWN1Nm0rRzR0ckR3ak0zbmxDZG9MdzIz?=
 =?utf-8?Q?jdaj/lI3klQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnBhYXpzSjBrUmVabTFwSGNtR2dmTVI4UFU5Z0l0OTRObkJnOXZ2MnN1N3My?=
 =?utf-8?B?a29rV1RLR0RrWUp0aXExQ2k3ekJwdFFUMjRvQUNsY29jWGc0bVNiejQvc0dI?=
 =?utf-8?B?dEZOTENHMHgxZFhvb2J6czJGVCtGMlFhMGpBampXejhFOHo0RzJhQzJ2cjNy?=
 =?utf-8?B?YitYbGVVRjlLWHRMQzVvQ1BhdVlueUpYSC9CQTZMUlNNRk1ucThDbUxnR0gv?=
 =?utf-8?B?MlgzcUpaVDg0aGE4YmhVUVlCT1lCdWJmd1U2a1Q2MHo4dDFUTDEwNGVjc2po?=
 =?utf-8?B?bjVOWjg5SkQzNHpETVVpTXBFQUVSOHl1dmdnd24zSEVGMXdRV29WbHVQdFY2?=
 =?utf-8?B?bTVWNHpNcllyR2o0MmNGaSszUHQ5SXN0WmxmOFJzU0dkSWZhWDJGQURrOTFU?=
 =?utf-8?B?Wm1ObnJGNCtIOXNKUVJJZ1h4TWlpUklQckVmMDNseFh1dXNybUhoRVRDNjRM?=
 =?utf-8?B?eFQ2TXpKTG9RaS9GODUxdmNDczBtNHFtYzNvUlAveG1FR3ZGcmFBZVZydE4w?=
 =?utf-8?B?a1dQbnkrelhCRlFPWU5FTVdGSjc5WUtMemF2N3pxejFHYXo3QVRNVVRkMEVo?=
 =?utf-8?B?ZUsyWkhKMzRSa1crU0NsWTE5VzJhMWlCZGx0bk9JSDdYN3ZoLzNnT3pvdGJt?=
 =?utf-8?B?ak9meE5FTGJKb3J2Y2phMXVya3ZuOGV2NG1BYlprTHYrWFFZQWdQSlZyMURW?=
 =?utf-8?B?WWpjUHBjWk1ucGRjNCtsZnlmTk83SWNHZ3hGY0FmTmwwcHN1Z1lUSGhPelU1?=
 =?utf-8?B?TDI1aC82UXZ2VE9kUjQ1VTB1dHVqcklFNndKNk9KRWlPN1lVbVVzR01NMEZ1?=
 =?utf-8?B?MG9sRTBzWHlWQiswWURxT1ZCUkV4bXJRaUlvbE1ab3g5U1cyTngxLzNFR3Ry?=
 =?utf-8?B?WXJoUG1kN0Z6a0VZbXFVWVpGMmRCWXpDZ3VxSXYvb3h4N3VoZ2M3aThjMXZI?=
 =?utf-8?B?YktDM3J5OW9xeDNtdldjWUJhV0JuYytNWC96VnNoeUY5SjFuTk9ReXZTYlJs?=
 =?utf-8?B?QVY2VXRGTGUrU1V1RDk5OGxaM1RDTWM3OFdROXN0QWxiVmFrdGtRWmhpMXdu?=
 =?utf-8?B?RTJqYWN2NlBNV2w4ZVRUdDIxVU1kaTJjdVZNOUhOSnkrSFJrcmhVMHBsZS84?=
 =?utf-8?B?dHJ5OURHdC93Y2MrVGhzVTlraVY4bXdQUWhod1l4MlVPNTIwUjEzSzVZZWpt?=
 =?utf-8?B?R3Zwb2dwZmlyVm4zS3BvY0FoK1ZqbmxjdHprVmQ1RFp6WFNTeWdSZEtwbGxx?=
 =?utf-8?B?TjB2NUp1WXZ0MmxLQnp1elBRT0ZOdXNTQS9pYUgrWmZLaTNSSERML1dOVWZh?=
 =?utf-8?B?MnNtYmczL0xWdFZXWXMwa0lrN1NmeTNlOEhoNldqNFZ1RDNHbHlROGowN1Nv?=
 =?utf-8?B?UXFnS3BVMGRMTFp6dS9tUEtDTnZXMCtzTTVrc245Ty9nTi81VjJ3dE9aS3Bk?=
 =?utf-8?B?OFpyblNNc0tOSDJMNHJUbGhweVd2Ri9iV3M2TFgrVjFDai85S1ZPeDNnOFln?=
 =?utf-8?B?cWEvck5Jc3hteFdzV3JPV0RzaUJ0YTBFekU0MHVHaTVNVThKbGFxNTlGWmR5?=
 =?utf-8?B?ZUd3MXEyd2k1TXQwSjJSQmhxajRDK1k5ZHpxcHVoN3RlemE5YzViUHJCSTFH?=
 =?utf-8?B?M0IxNUgweC9tallSdDEwWVZ3MTdNOTU5WWgvb1FSd2NDTUNWeXZuMWNGZ3Yx?=
 =?utf-8?B?d1dkMFhzYW9QTlYxcUx1UEJzeHRiWnJsL1QyZmZtVVNVU2hJQiszR1hvMU9J?=
 =?utf-8?B?VnNUNGo2VXVxdkZiNFFWOUZkSXRZV0huU2NHSnJha3plWmpQaDVzNEVIenVt?=
 =?utf-8?B?ODNtNldPU2pWTW83czFudkN1UU1YVzV3VnB5bzZUU1VYby9iZGxvbUJCTUdy?=
 =?utf-8?B?U3Q4cWhlRFpXS3QzN2VQQXdiR2F5RDBFY3JJdDBjWkt2NkRNMzdhM0hOWWJa?=
 =?utf-8?B?MklvZUtnRy96NzNQcUQzbThPWjNiNVd5dHgxSjB0b1RsL0RhcEhDNWFuZ2Js?=
 =?utf-8?B?MHZ5RVJISmRGcG1hM096SFZuWS9tSGdVWWdKQy9aN0RxcFNPU1k4bGlaeFhQ?=
 =?utf-8?B?Z3B3QlV0LzFLOGpJVW5jUURMK3lpUGU3NjNRdTlROTExcWNWMHpsRHBLdnF6?=
 =?utf-8?B?L1oxaGNUQXRZblhROUt6MjlubG1obStZTjkvT2tIT1ZOL1ZwQy9kajJlczNy?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3648ec8-c36e-4903-6cb1-08ddbfc9625b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:49:41.7108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvoBfDqTicMjF2sWelj8JEBcO5HFUOV5HXW7STnpRbzdKbqBA2shmRY42dM9xbf15Cbfuo/HqntPdITRD28WgIxSqZPTh+tCNlElbyDKCw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7141
X-OriginatorOrg: intel.com

--------------9Ey4CC9MPt7afkXaFuhJwDgM
Content-Type: multipart/mixed; boundary="------------1JzskAXsTTuRZZsl3iYjsJk0";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, lee@trager.us
Message-ID: <70a20532-3602-4e3d-9d48-28fbb1f23060@intel.com>
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
References: <20250709205910.3107691-1-kuba@kernel.org>
 <bfb5122f-e603-457c-8115-4c4acfe7360b@intel.com>
 <20250709171138.5da9df21@kernel.org>
In-Reply-To: <20250709171138.5da9df21@kernel.org>

--------------1JzskAXsTTuRZZsl3iYjsJk0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/9/2025 5:11 PM, Jakub Kicinski wrote:
> On Wed, 9 Jul 2025 14:23:11 -0700 Jacob Keller wrote:
>>>  		head =3D list_first_entry(&log->entries, typeof(*head), list);
>>> -		entry =3D (struct fbnic_fw_log_entry *)&head->msg[head->len + 1]; =
 =20
>>
>> I am guessing that UBSAN gets info about the hint for the length of th=
e
>> msg, via the counted_by annotation in the structure? Then it realizes
>> that this is too large. Strictly taking address of a value doesn't
>> actually directly access the memory... However, you then later access
>> the value via the entry variable.. Perhaps UBSAN is complaining about =
that?
>=20
> Could be.. The splat includes the line info for the line whether entry
> is computed, but maybe that's just a nicety and the detection is done
> at access time..

It might just be the way the pointer is generated. I think I had issues
with something similar when working on lib/pldmfw too... Been a while
since I had an UBSAN splat though.

--------------1JzskAXsTTuRZZsl3iYjsJk0--

--------------9Ey4CC9MPt7afkXaFuhJwDgM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG/hFAUDAAAAAAAKCRBqll0+bw8o6DAq
AQDmRZRqxM5zIpd3QrXQeCmPKM7bsDVesaHrvkZF2s+aTwEAraUkvKrCGND7VcSdk9QWK4IfePjf
uTHPaMUaxoApYw0=
=CpS8
-----END PGP SIGNATURE-----

--------------9Ey4CC9MPt7afkXaFuhJwDgM--

