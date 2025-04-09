Return-Path: <netdev+bounces-180587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8FA81BF2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 06:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FD1B676F0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 04:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09891D5AC6;
	Wed,  9 Apr 2025 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ngBGO2xC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22596259C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744174460; cv=fail; b=dYXi3Fo6e5l4t5mpmp+lG0jNhUQzC3QXpiCK+kpIf34Sxz+waS6yr6pT7i6DdGiLL+B2YWO0Yj3qZXyqExWCnQRRSOP7s9zskqDKP7KVoVHyIzyssziMFLo8zw01ZvQ22M6B4+8uBhZII87KVny/rGMmWg8KNiFM4eC2QHbl8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744174460; c=relaxed/simple;
	bh=MrmUm8R2tXzc+gbmJkB52KZNLOPNgfWrX6TRuF/raaY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mfmsE73/9qbttaOr9iR/gWenljxSo43tuERRcHQ1ZXh/R1xnkVQuHHXhtCPgZ2aTfKpWmNP/puxVUsfZhetLb305JWLkGXXaQJCRqtnqAKcGYEvdIia/z/ysgpHUmlAWBs+IYZNZVqaKe6mFxJpjRa7V0n+iwOXUxHmcghSYHso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ngBGO2xC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744174459; x=1775710459;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MrmUm8R2tXzc+gbmJkB52KZNLOPNgfWrX6TRuF/raaY=;
  b=ngBGO2xC4FJgbqZLyxuYSvOAwEzexdAQEHOH8l7is3kRdM/s6o5MUM1o
   uWw9XSjVJ9ZhTPoRCt0VB7HOYdqpC6JlcF8K11Xlklej7kYIUa+CZ/Nwu
   qJvlSx/j7aD13dH8vilgkOS+I1iA55yzlJh3G+MCPuEd4sid11NvT3el4
   bCBja7Co6WjbOFDaA5fY2kWzG1V1diogkLyLqz9zkh8T6KqbYHsX0bJ9i
   As9vki0obUS1/6LkeYmoparLuQZpV7hqTwXeKOISrPqmiNLCP/rgQJOdK
   YelGdXHEnm+l5tlcv1VUiyxrSjNFMAB7UnfJPeACDyR6r5welVpjE+Ull
   w==;
X-CSE-ConnectionGUID: 6mts/ShzTpK7JCfHon/cNw==
X-CSE-MsgGUID: aUwYW1BCS2+xl4r3tJX5AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49425753"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49425753"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:54:19 -0700
X-CSE-ConnectionGUID: K391++SvRVajoqXOlEU8UQ==
X-CSE-MsgGUID: K+AyTNLBQcSCjtzc5itEfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="165701033"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 21:54:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 21:54:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 21:54:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 21:54:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb82vQqMKyShchdQEzvuQYXL/P1iVcTPIjfXl/o76NvhQNMC30In0gUmHwmy+ivRaE8ISFLval9nO8lAmSgu3eQuhkKq5EligZMee30aIZPJpC3ps4xY10guY9GO4FVhoG5qzYPE3DceWD3q9ZxhOU2y/KpTxzz8zQEE+QQ8KN7BoB+vlzsifADKYWdhFQsFpAkh8Cz9zRUigbnh+sadd3+IRQ0vUW3F3XK7KXt1bZ41HxAmpBoUYwkmLrA5uv6eud4pTYG5h2vr3NNX74qG6fAYkFz711p3sMRlnFL+fmMWij6mKL/BpgPh2QSOhhHTtsjtEkfeUUa7Ftkt/ndhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8nxwQuAYiFhuzrp3PJ7XF9jyfyJyxT9x5ZC5sqf3xU=;
 b=mPYZHWd5CbolVVraOZ3SWHioKTNPedK8sSrDz6A3hT9714lgaDMHylLi6q2ImoGMV6MT1SymojOqyvjCqjUEIAREo7ss3B1zZ7Qf6g/JmT9bXXJyyq4tlAbsisohrNXSkJDy4ub5xu8D/MrB5nS1BNkxF7xV/iqjEXKDpnjxqr4NXGYyLt27GtSM9HinGcKdbcMYQbAfna3VV6HedPZRCt/agjS0eMgHOR/jQ8eNezQ3fjpR5kk3XRLGWOqLNUN2pbQByZ17iimEuuUx73usHOkFTb6DXWMMElGLRsfBktdMB3gk2NhiKYM4b/1F4EmQ529ENTNpTP7ULfYyf/QIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL4PR11MB8847.namprd11.prod.outlook.com (2603:10b6:208:5a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 04:54:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 04:54:12 +0000
Message-ID: <a382cf5d-fb2b-4bef-8f2b-3e3183d19734@intel.com>
Date: Tue, 8 Apr 2025 21:54:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/13] netlink: specs: rt-addr: add C naming info
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<yuyanghuang@google.com>, <sdf@fomichev.me>, <gnault@redhat.com>,
	<nicolas.dichtel@6wind.com>, <petrm@nvidia.com>
References: <20250409000400.492371-1-kuba@kernel.org>
 <20250409000400.492371-6-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250409000400.492371-6-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:303:b8::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL4PR11MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 970073ae-5cef-4c0e-39bf-08dd77229282
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHg2UFhqTlk1STM1M3d1LzRvTUdhcy9pNVBEWDFxM2JsQU9iamF2OWs1UWR3?=
 =?utf-8?B?U29mdVZWZkM0Qnl1a09QNW9BRUU4b1ByU2t3OWw5QlVQai9Jcy9Sbi9DaG5h?=
 =?utf-8?B?N3cyUTFtcmJscGM5RUhkNjkzcFNNMWsrbU5WR0xXUVJMRHZjZ01pck90bVlp?=
 =?utf-8?B?QnVzalBDOFkvVW5UU3J4RmpMTCtnQ25jNERubjBYOEZuSVZBZ2RFMnovemhs?=
 =?utf-8?B?SStieW0yNUphWWhsS2pYbFM1a0s5M2w0cXZFcE5vUThvbm9qOTFSWjMvY2RI?=
 =?utf-8?B?cmlZaTVVTElucUV2UkJFRW5uTWRsb1J0Zk9xaHhFeDl1SmxZVzExcVlHZC8w?=
 =?utf-8?B?N0FJZGsyeGhHV2JobmFiTTA3eEVOY253aGNTMW5rV05jWFJvcEMyUitPTlkx?=
 =?utf-8?B?RmN6M1p0Tm1MT2V2S0VtQXFuTjlZWGZEekgzYUJIcElIN0VJdnF6K2NCOHRn?=
 =?utf-8?B?WFpWUlNYNG5zT1hyckJwL0tCSS9BTm45VEx5QjFFYjZxdjhSUS9DYnhDd1Mv?=
 =?utf-8?B?YTl5ZGUrUld0UnJHb2VRNlBTSTRENWhlZ3VrODRhOGVQSzRtM3Rvd0tZb21L?=
 =?utf-8?B?SHpSV0lWb0tIdFJkTWlCaDhUaWI3TGNQOU8yUWZtT3JibEhGTUV5cnJNS2Y0?=
 =?utf-8?B?b2I0TjNSV2k0NU5MSzdQK1Z0cWI2ZGtHc3JWS2hJMkY0czlWVTFQem1ta05u?=
 =?utf-8?B?ejlkV1dxeXlDN1BiZ2MyT3RhRWUwa3RYbGhRTWwydnJmUEZTaTZDZFN2M3ZP?=
 =?utf-8?B?YTk4NUowMjRrTUgzQkhjai9NSE0xQ3JCRXJWTzVRdjdSV0IwalZmL0taUTdK?=
 =?utf-8?B?ZjdIQmkwOUVoUURUSGFRWE90OXBhUjFhYTN0bW9ibmx5TzBCQkFjTi9vTmls?=
 =?utf-8?B?SWcveldFTTA4enhvSm4wZk9oU2VZdlVjRlJjcVFKOW93MGMwbGluSS96UTNY?=
 =?utf-8?B?bmdWOGFFT3ljbHNsd3RKcUxzVDd5V2Y0eFdSb0VSc0h4MHhxSGhyTkdEdXNj?=
 =?utf-8?B?Q1c4MkIrYVdEY3NqdTQvZUg3M2ZqZHVzeGdmbHZhUlNzcitlb0VtRUN4VytW?=
 =?utf-8?B?Zm42MEtYNE50cjJBMlRtSjZURkdFNnlTeUdhNXR0MzBxY0h6STRwcjJVVTZ4?=
 =?utf-8?B?YzRNQlJCeVM1RURjMm9Ha0tqbGZYcGV3Zi9aRFYzUmRONGRNcUZVVm9pMkNR?=
 =?utf-8?B?dUxMK1dGMDlWa0RUQjFwa281U0ZuUDRsV3dBS1hiVjlyU3BPSWtzN0syYUdC?=
 =?utf-8?B?R0xlM1hXdGFVYUxqUGR4TkN1TnZqVWJKelRhMUVIbkpoK21KS3kxcmV6Ny9s?=
 =?utf-8?B?SnoweHUrNzc2T243c0dpT2czMUpzakFSeWtrd2xrUFNEYnRnZmZibDVKRVV0?=
 =?utf-8?B?MGtTc1piL0JVaEtTU1d2emRrbmJqRS84eHQ2bVROS1dQUmM0TWVCbmExdWV1?=
 =?utf-8?B?cjBwUldDV3VKTER0RVROV1BDd0FYeDJtZ2JQMjJhQjJTeEYyVUdVcExBS2c5?=
 =?utf-8?B?MTBHTEdqM1loU0xKM3l6bzRzMUhaanpoamNaT1FES0RtV3RXNjNGeTRKSkRB?=
 =?utf-8?B?VzZrellJWU11VHh4ckVVa1p4T0hrbndGQXdUazU1clNSaWdIVmdLQW1SU3h2?=
 =?utf-8?B?ckt1N1NlckZBN200dWpDVDdXVFFEeVZjTG8wN1EvbUZsb2ZLT3V3UXdNeWdB?=
 =?utf-8?B?eVVzTnAzT2dvazNMVDBFVEJIcWJtYXN3Vm5RbjJJSUZZVlJvZXJLWlAzQlBo?=
 =?utf-8?B?bm9CMHc1b3ZDRWVENjFESDdsb2xaeGhhZVNjdDFySFM4dmU3WVA1aXpPcURF?=
 =?utf-8?B?RW8vcktacFUzMHhzME40L2l5NkhEVHgzbnJFQTFmajhPMmFjdXFRUmNmdVJZ?=
 =?utf-8?Q?8jAtH4V7qTIcy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVNWEp2b0xJV3pONi95VncxRFp2OThMN29SUjEvck9rUzEvZEd6b2pBU0pP?=
 =?utf-8?B?Z1V6VUJub0FEY0pZVzZlN01kOHFBSEgrV3JRN29HcHFCVVlPakhRVE8vMHo1?=
 =?utf-8?B?L3pwVUsvdFBtM2J4d1E3bkFHQW9MSzdRUFYyWDlyM2FNN2NuQXU2dTU2b0NW?=
 =?utf-8?B?b0IxYUV5cHBndWYwbkhOZE5YZVJtenQwcDQvVDlEZTkzVHdaWk5qOTNlUjlk?=
 =?utf-8?B?L1FJN25pZU14dkFJb3Z1bWNGc0ljM09MUnoyZVBNWW10NS9IRVRNeC9jYUMv?=
 =?utf-8?B?RTVaSzBIMUV3RDh5clpIK2ExbktGbDJlQm5rU0MzdVNid1hIanRkNTJvUG5M?=
 =?utf-8?B?cVVzTXlDRjA5ZFhIQlNFajl1Nm1HMGJGM2hEYUJzSko2VHN4M3JTUnkrZ1Zr?=
 =?utf-8?B?Nk5VS01udDJIS0U5K2luczBxZXhQbkZUZVVwQ0VlRlNmZ0wyMkpQc2x1eHlH?=
 =?utf-8?B?cW4xbG9MTm5TNThuUTBLbkRLZ0tWRVo2OEt3OUJBeEVHKy9LYUlRVUJFSlVY?=
 =?utf-8?B?N2RPWkpCZU1vdDI3aVhwbEptQ28vaDlYQjRSaGdPSVFxbnZwU3JqVEwyU3hO?=
 =?utf-8?B?ek1SbjhhSlZZTkNQWXdrR0Z2clhCRjk0eVlyc21TVUtibGtSc2UvVmlONnpL?=
 =?utf-8?B?MkFpS2gyN0tnT01xNHFCK2hJSUowQlpqbjBUV2wwaG8zSFV1T0FOYnp6WnF0?=
 =?utf-8?B?ZEtWdU9Ea240RDNLN3hBTEt0SEhLNUovYTUrYm9Pcnh6NjBLUlhmNnhZMW9R?=
 =?utf-8?B?aUZ2aUxjN1MyckE3SEZsaHVnbjRkMTJ4QkIzcnZla3haUUM1QlRhd0g0ODdS?=
 =?utf-8?B?djh2OXNlenN3Z1BwdnExeGkrbUZlNDJFK1FoTDZ2VHJFQWhmclFvQ1VrYm9F?=
 =?utf-8?B?dU1sTFY0ZXZWcWZNeUZDVlNPNzlNb0NjWU1SN01lR1JtcGdlMnZIZlo4RkNO?=
 =?utf-8?B?Z3BHUGNKNHRaditxc1BMT3M0WlBWdUtTRFgxdUtST243N2RXOTBYcFJiSjJB?=
 =?utf-8?B?bCtLSitiYjhpRVk3U3o0OWkzVzNabUo5dVdWa2xkT0szTys3U3Y3Y1d1QUNW?=
 =?utf-8?B?bTVMcnNoOWFvRkkxR3VZLzg4amNpSHF2U0JoV040V1NGNjVJMTBxVFI3dVhE?=
 =?utf-8?B?RFA4bDBJK0xiN0FVUWROMlVaaFg0RVB5WWhRcVorSVJtUHB6Z252bkQwQnJE?=
 =?utf-8?B?YmNzd3N5clo4aHJOa2swZk1WUVpaTjROQlZ0SkdvMnJzUGlaMUJQc0V3bGYv?=
 =?utf-8?B?OEk5MVZSQmsvbTNXdEtXb1ZTbUU4dkY3eFg0UXp5NVZ5OWs1Y3A4cVV1clA3?=
 =?utf-8?B?cnpZdi94cWtWS1ZFSStueFQwUWN3SndJeUdhU0YwVlBMZVk0ejBMVElGL3JI?=
 =?utf-8?B?NXRXUGZrSUlXV1hwenhiZmZRQ3Zkd0tvNG9ia0UvRVFWb1ZUK08wTmhuS283?=
 =?utf-8?B?Tml1Vk8zZE5Vckg5bDRobjhlazdXMWRMMlJCM3NTNGpULytkZEYrWkFIaXNP?=
 =?utf-8?B?VHBhT0FDSzUxQWFPN1I4SnVZMUdWS1FQZGkxR28zTzRRRVRoV0tSOWdqSHlF?=
 =?utf-8?B?dDdLWGMzaDJPeU9ZcjdqMnNOZWVaQkg0TG5uQVc0N0E5WjNabk9hOFZyOU5x?=
 =?utf-8?B?QWVyUTB5ZTUzMytoN0srWlJ4c0RKVE5jTnQwZFJ4UlVlK3A4SXhFTllMYkha?=
 =?utf-8?B?TnQxNGVlVmdLcy9Nd0tNNFNRL0xKR09TRnRTRHJ2M2NnN3JJVHdiUkUzTFdO?=
 =?utf-8?B?QnV5Y3JOVE1HMWpkeDNoV2lScGlmaHJEZzl4akE1MkZTaDMzazUwd3FhdWlB?=
 =?utf-8?B?TzhwbUFTS2xPNVVKYXBEK0krY3c4enBUZlpTeGtnN1JzQ3lWUVNFMUVwOUdx?=
 =?utf-8?B?TDl3RU82TUlHaUpaZ1YvZVBVQlRKVjRhdldCQlBDaFIzeW1xNG1oYkUzQlZC?=
 =?utf-8?B?SHRUV3cxNFBBeVJHeGEwMis3cWNIZGl1NlQ2RU5RYmxTS1pjdGROZDJtb21X?=
 =?utf-8?B?cWdXUStJOHFKTFlGbkcwS1NsOGtvYXBPRHdTV0FmWjZxV3VVM3phOWZpbnRr?=
 =?utf-8?B?d2JBaVBlcWxLV3poR1NRSFFNRXJ6Uk9CaHpMSVZ2WjJuSDM0dWhVQ3pKeFpp?=
 =?utf-8?B?d0dreTB4L1ZQQ1FpeG5aUUNiSTJTQ1FRQTNHTHN1RlpVTkF6RWdDZEZ4dktG?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 970073ae-5cef-4c0e-39bf-08dd77229282
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 04:54:12.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8QP/Cw5Q6S5xwFtNWBZBj/nYUIxCzoRs8OG+Ud2p2X+8AIPURHmnFCBoUxfC5aJwokVQGhnHDhvPqKMEgKVF8cZFtD3xpvGN1kkNBwQQtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8847
X-OriginatorOrg: intel.com



On 4/8/2025 5:03 PM, Jakub Kicinski wrote:
> Add properties needed for C codegen to match names with uAPI headers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

