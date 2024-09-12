Return-Path: <netdev+bounces-127925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9669770FB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3651F2430E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89921BFE12;
	Thu, 12 Sep 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrnoxu45"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501241BFDE8
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167671; cv=fail; b=GQNRbeeyR2+YSHhiMgTdhq6MLeuUG4FyEBcjVGEmvwSG5fBc/mE+SNYEMIJGe8harxzh1MVeOT8sL8BwmcLAHeBO7v8HlD2XWt5Y165LwbGdCSg2E1dairfI6QDm4AP3lxWtKTBZ26A/Xt7aFEXeaCsfwZvhhWQP7RLNBcUxVqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167671; c=relaxed/simple;
	bh=Hhv7EtIQn5Cr5/58Ti7wiSiuv3aXC30GEeAgMcYjkVU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d1jpqzNJyfYnkmdjlvwgisH6Ffb9qqIxfDgpSw6wj4oHZPywooqdTu/67YuxmcVeVTMrtiWTQXSaaQhOX0VuIGrfxtKcoju1/QV5W9DYfgrWoOmKYeAkTwqe/PhLlCIkztq/8MR3zhpfr7caEQLNI3o6n9G5pTew3QumP95rNks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrnoxu45; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726167671; x=1757703671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hhv7EtIQn5Cr5/58Ti7wiSiuv3aXC30GEeAgMcYjkVU=;
  b=nrnoxu45L6Lt8madIbOMY4xafy8JuHb8E8dULwx5+DufXjJXFp/7FLTS
   bPnNe9QBhLA4ZwjxGgsxI8NBfcPUq7gs01pd5omg05/aIG0zAZ/UNS2+s
   pCCsLspg/EF3cfEFBRi79+LpmHctjEFMlSssR9r4vroVisyaGDdj08dxF
   /H6GPD6wbjougwQFAVawMTo/3JahmajXyoTzZYNcOULw+RBHpa8BoKSW7
   SjQzv1UJ3QlohW06v71wyHqAzQmD3e3LvQRnY9oJ/uq1ISRKi1un2exYl
   QFple0NW4kG0lzs3brudhi+ir0oCfNL1lfifx5ctAD3TLHtEW2wpBiPCW
   w==;
X-CSE-ConnectionGUID: LLpGhWSjTxu5tq/bW4MN6A==
X-CSE-MsgGUID: Qxu8C08YSpS/GR9C9Ix96A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24917856"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24917856"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:01:10 -0700
X-CSE-ConnectionGUID: bjTCgwTcT4GoJZB7KxzLJg==
X-CSE-MsgGUID: xuAetjesQROwS9ah4FdSnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98506187"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:01:10 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:01:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:01:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKQxAaYNzU9wSH/y6360mLBahynjI2nCnZdiJCv5T2QF0OhHg+A+UtPRldD+mFMDHqzxspR5JG0xmKnG7BghBBOLl5P1MLohzUfVYK2UjUsitxQ6eo9XPDQ+bATN2czH5aYboPDNgKCDN7d29Ut+nGVealdiYDenFoZycUKDUxpE9qpFdxC/HmiB3zflq4q9sKwnaAEgUpG6zjohbtajQFhW4veiFCVPcpjKl3IWB0OpLJ0QDpGCqCta0t2J6XCmkLRpdpkW+9zthnGMgaayv2kuRjt/6yfOD3P29LdUjjxfGwzp7dwlyIlL6IT24zuq1BebJBA6klFUAS0RWxJQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh9pO+190FpivvOMInlYe5qe3XupcPpxRg0/tamrC4A=;
 b=pjcaozZoOl6zsjaCnbbZrQq3kNG78tW+Gw24Gd6FsVFk9WYPhi5nmXN6dhffEnmwEKyzYjYkPo1MO1ud2OiqfCM8fLMJZii6injzA9BL3OoHf3JldGC/699eLL7O+OxLWXfxTTYxNJ/gWgx+c7O812CAZE4g5hWAJ+k5nfEgGImWm1rllIAkXugXbURadVHGm39zSPy3PgnY28mgAjuUp26p696QmMYFVlUcrXSnDubCZbw2Gp3gCvl0oQvCPoRQb4db5Z4mef+nocrCsBPVu2KxNwKqBX4wzKGP17cDQBvI9PkwNWIddjr5Emww2Ltb0nF4kXeuDHWIzFmjICaT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 19:01:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:01:02 +0000
Message-ID: <ec5bbfc5-84d3-4eda-977f-64483a7449d2@intel.com>
Date: Thu, 12 Sep 2024 12:01:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 05/15] net/mlx5: fs, move hardware fte deletion
 function reset
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-6-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-6-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: b95d37bc-2e3c-4f8f-005a-08dcd35d3eca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bllJemhuRldaczhWRnNwWkYyQ0ZxbkVFZkcvbW5zSzVWTjN2MVQwcGRJWWdl?=
 =?utf-8?B?RFpiWUdKS3UxZ3duRjJaM0lBT0RpeGJMc1ZJOFY4MGJjeEFDc0NBWkxSZkMz?=
 =?utf-8?B?SVZUK3duOFNlQVhQNkpzS2NVTW5GRk9NbHNNa3pSd3Fyd2pVZ3VVOURsTW9N?=
 =?utf-8?B?Sm5YSUhtNGhua3liRUxvclh5Mk9mMUh0MjBOb1BuREhzMk84M1RxZjRLRGIx?=
 =?utf-8?B?bmhIcXo5akNtN2F2SFNCZ05MUm00S2c5OWVsK1c1eEc4K2hKbVZBMVZWTmVn?=
 =?utf-8?B?bTJsUUUyVFFyVjZ2ZlFtdjFvM09mdGVucjIzRFRoVlNrbmk3UkdraU1XOTJp?=
 =?utf-8?B?UHlSWkpEYW5mNVVna2p3YjAwOGpIU0NWdzlobThlQWFnQkR1VldjSVpGV0pL?=
 =?utf-8?B?cUNVTkxGdjZ1N215elVBUi8vSDE2c3F0YkZpbXVNNmVNVWlmclN2V3lOZEU1?=
 =?utf-8?B?RGR0ck9hd0I2RWFlNHd2aHBteVhXWURNb0NFSXJJVTg2MXJVdXI0ZjBJeGVx?=
 =?utf-8?B?WEYvRlRDaU9RZVEwMTljS0dTOVcrM3F4WnZWa0lIak9kV1J1SUVMcXdlZTJP?=
 =?utf-8?B?THh0enNKTmM1S09nOUkrRnNiZ21SVitwditmWGpOWVZYQ3Nrb0V6dnNoWGFm?=
 =?utf-8?B?K1dYa1dYWnJFTkt3TTJmUjVSVFRsdU1FR2VyL1pPZ285NEJ6MFVkK1Y5Qlph?=
 =?utf-8?B?RnR3dEtES3NDV2FlNzN4eDhqaWp6cVdtem5lVDhZTVhiZHVndzBoWFVKcU9l?=
 =?utf-8?B?Qi90WHJiNkhzNFpEME8yVThYSEpnQkpUYzJZK0Q5U2tkTnIxN1FuY1oxRGZN?=
 =?utf-8?B?ZldVV1lTbnNodi9hRVVydm9scFQ2V1BIOURBYmp2VmROUmFKZzIwRjdQcndn?=
 =?utf-8?B?aE5wRDNMV2NDeHRvKzU0UVVDZEhUdll5TW83KzJYNERkUXB5VXYxUnNLZm5I?=
 =?utf-8?B?VXQxVGd4cCtiY0VHVnlQOGdxYWN4OC80NlBvSU5VTldRYmpPbjdGSFFuYzFN?=
 =?utf-8?B?N0tkSE1hVnZReXhjcUMySGtSVjRDMzdoRHVFRjkrd3RqME56b3FqM01pUmFX?=
 =?utf-8?B?S2NtdWFCVnU2MGU2S0NSVkFMcW5LeUZaaGt1eTFNQUs2RmVFOUIvUnd2bC92?=
 =?utf-8?B?WGZKMHZQMmF1K05NNE5ZRUpDeEY4OGhSdDZsMFFrRnEvb0dsdGh3R0ZOM2ZV?=
 =?utf-8?B?cm0vN2N4RUR2NHdmK3lMdDVsNTc2ODI4UlQ3VkQ4cW4xaEVsQ3NrQnkzTVFI?=
 =?utf-8?B?RzZOa25kZ0RQWEovelhIN3loVEpRa01lYytDVUF1NGtoTEVKTDlLM2E2WVk5?=
 =?utf-8?B?ZVQwems0SkFwZ2Q0eTdXNCtCT0VkS3JHbDM5MlpCKzRvcFpKN2F3RTNrM1Vv?=
 =?utf-8?B?YTAzTGt1Uk5lMDNRbWN3OGh5RzZ0YVJGdGtiVVRaajJWVVoxdjZUV2ZrUzZB?=
 =?utf-8?B?a0VDL2dhcFhoeUkxcHZUbzYvUHF4NHcrSFZObjhoZzk5NUVaTzJZaGdFYXZw?=
 =?utf-8?B?ZjRlaEFCR1ZNT29HMG5FR1hoc283aEpveVJZL0pGVEMzdGhYc1gzTGlPSEw3?=
 =?utf-8?B?eVppNlk0MTBkTEVkeW5pUmxhRmU5cFU2aXhoUCs2UFgvaCtCQWxGdWRFOXNk?=
 =?utf-8?B?bDBLcUhDb1k4NUtncG5kNU42RENlNEhmSnBMOUdlcU1BRnc0VGN6UW9keHVy?=
 =?utf-8?B?ZjZyT1Q2bDQ1SGRUQURvN0VydTlKbWZjZzdwQUNlRUIxK3lvRUxNUnlMMDZj?=
 =?utf-8?B?MDdsTzV2Z1BOaTZjUTUzZTY4aXF5SWtLekViV2RTdnI2aDZlYXFiRVl0RUtn?=
 =?utf-8?B?V2IxRUxlMHNGQTY1MHNhQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFxaVZQeWl6L25tY2Z1VWI4MGJnTnlXS0RRL29zajYzMjArUm5aTFU4K0Y2?=
 =?utf-8?B?K2poRGZ5TEkzUzBKelZVclJjTVMzSlFkbHhDOERPdHJidGlQTjJKVTNYdjVh?=
 =?utf-8?B?bGZyYTNJcXBMdHpLREZ4aWdtdTRVRlBla3FiN1VxWmZiWFN6c3JtWENWT0NE?=
 =?utf-8?B?bFMvWDhOUWYzTzRZbEgvaFE0eWo5S1NvTEgzUmJmWTVxZkRDbUYyR0UvNHJo?=
 =?utf-8?B?UFMvRG02OEtpbG9pYXBHTldCdFZRNzErS2FITGhuLzc4QXJvbnVJdWJLaU9o?=
 =?utf-8?B?WG1HcWg1M0JyaUYrc0Jzc2gxYmxVeFVVNFZPazU0aXhHMU9WWldvRzVVSlNp?=
 =?utf-8?B?dTltWVJGL2w5NDRSZXlCUmU2eWpLT3NhT2Z5STFBWTNGazErd2I3RmkxdnQy?=
 =?utf-8?B?VWVKUlJEbXhpSTJRYjZtQ3BIWG5ZUGRVMU93SzlXNlM3YlZwaVpWMkI1OEMr?=
 =?utf-8?B?OVZYQWx4MW9idFA2OEdCZ212Ly8xSmc1bFlNSjdxVnA5azNSaldBbE5LcHdQ?=
 =?utf-8?B?NzY4WDYxdERFWnVmbkE0ZVd4M09mT1owU3VDV21qd0FoU0xRYmhZU3hjM3ZF?=
 =?utf-8?B?dU95b2hONEtFOEhRK0luY2hhMEJ5eE1seHI4Snd1dmlKSkU1YjYxMWtUVHJO?=
 =?utf-8?B?cVAydS9xbzRsZ2J2NW85aWZkWm42cHVxNUZxaUs0QTh6Q0ZBcGxzZWlsQ0ln?=
 =?utf-8?B?WDk3cVJnVk9XR2RtK2pTKzB4d045RU5BTUJxYjAxTS90UjBHUGdFTWE3YTlU?=
 =?utf-8?B?QXhhckpZU2xScmJFQmFraWttWnNQL2s1QnBwUW9ZcTZuOGwzd0xmb1UvbkM1?=
 =?utf-8?B?d1RaSFNmNHk0ZzVLeWZIUkxRUW1tNVAzd2tnVTlONHo5em9jRVpUaDdtVFZL?=
 =?utf-8?B?WmMyRTBJcFBsNDlLd1duOHEvU0srcnJqUFJiVjV4ZUpPZGM4UmpVRlp1aFdZ?=
 =?utf-8?B?Y2Vzemg4ZjF4aHJVb3E0UityTXlFUWFJRlpnQ0syVEt6ZFpQc0RTZ0dJcUdi?=
 =?utf-8?B?L0hiMWd6U0phUTFYczZ4eHVEWWhrWlFiUW5ySHFOM3lSS3dpUHhaU0dzMWkx?=
 =?utf-8?B?cjF5cVdiZGF0NTZ1TEdwM3BENDZGd211S3lTU1gxUm1QaDNwMnd2SU90UU5B?=
 =?utf-8?B?TExPSEVxREtZQWc0b2wzR3VVT2sxRkdVSkFBM252cWlWSE1pbkh3OWhTcy9w?=
 =?utf-8?B?TTVCd0F6M0ttekxJWjREdTBNRHpkcis1YjZ6bmtJSVlrcnZPK05IWm5VU0xY?=
 =?utf-8?B?Mk5pRzRaelF5Y3NDcGtzMVorVUtmM3FWN2hTS0N6QjZPT0xlWXpJc291Znl1?=
 =?utf-8?B?ZzVTblFWNHhZRk5kVHhybGowYktNUVlDTWYwUldjYVN4THJkbTRvaEVPT1pV?=
 =?utf-8?B?ellqUGhyMlUrM1JzQmtaeVl6Rm5aQkhBdE9pUXJvWVVNM2pZamJ6VmVOdklj?=
 =?utf-8?B?bGROZUk3anZOODBud0pHRDdHOUxubFhJMnNaRFBsVHg2WWQ3MmpJRnc2K0JI?=
 =?utf-8?B?SGtzVFl0SG50N0hlamUybWdFSHRwa3hZdnVOZGIxc28zWWpGV0hSb1hETVAz?=
 =?utf-8?B?dU9rSFNIdDRtOXpjejlBVlFoMDQrUkJwQW1pa09XTlpoMTRVMHNieVRTbjdi?=
 =?utf-8?B?L2N5Q2ZIWTVUcyt0eldiRFZScXZvRTlMdTBuNm40R3ZacFJkV2hsa0NhOHc2?=
 =?utf-8?B?bDVpUGhPeFdpNEdkbWthYjNaaWV4Vi80NVZuZTRtdEw3anV0T0pPQUZ4dTkw?=
 =?utf-8?B?dzlmNmFjeVdiTkR6eUFwaGt5ZzVFS2IxT1dPTFNBS29MRVA0NGdZcTBNaTRz?=
 =?utf-8?B?WlU0MVI0eERyd3k5Slh0MStUbk1jQWZ5S1V1V0x1V2xiYUwvWjE1dTZzajY4?=
 =?utf-8?B?VHlwbForWkVjYnZHNXBzUEZzUVNWaXRsUmpOVWR0TjhEVDZhR3lZeC9DaFVS?=
 =?utf-8?B?YlRveTdiUktnNWM0VUFTL1pZV1lyS3pCN1FJZWRHbGhmdFpwK2M2ZDI1bFVN?=
 =?utf-8?B?Qk42RnhJNFIxZVdLSEd2UUNXR1cxOVlwT1FwdStkQXdxUG8yczIzQWwxMkRk?=
 =?utf-8?B?SWJ2MmFlVzE2dGV4UENwcWRuNXBvYmxWL0JvOEdhalZmYjRwUGxibUp0UkZh?=
 =?utf-8?B?K3FYOWJPTFNCSGZ2cjlwZHFxQzJQaWJVZGZNdks3V1NKRGxwbXVPMzZKa0Jw?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95d37bc-2e3c-4f8f-005a-08dcd35d3eca
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:01:01.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBNKu8/WldX+PMYUUOFjWKt+tTeZA8O6ickDVfaEHv0c7BgV2z3+B8gTlZ6nssPGBcovbWeCOEEAmW4xImTU/SncvzQEWaKWuVjZs5CXr8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Downstream patches will need this as we might not want to reset
> it when a pending rule is connected to the FTE.
> 

At first I didn't quite understand the motivation here but...

> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index e32725487702..899d91577a54 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -683,6 +683,8 @@ static void del_hw_fte(struct fs_node *node)
>  				       fte->index, fg->id);
>  		node->active = false;
>  	}
> +	/* Avoid double call to del_hw_fte */
> +	fte->node.del_hw_func = NULL;
>  }
>  
>  static void del_sw_fte(struct fs_node *node)
> @@ -2265,8 +2267,6 @@ void mlx5_del_flow_rules(struct mlx5_flow_handle *handle)
>  		tree_remove_node(&handle->rule[i]->node, true);
>  	if (list_empty(&fte->node.children)) {
>  		fte->node.del_hw_func(&fte->node);
> -		/* Avoid double call to del_hw_fte */
> -		fte->node.del_hw_func = NULL;

I see. You were previously clearing del_hw_func after calling the
function. Now, it gets cleared by the del_hw_func implementation?

That does feel slightly brittle to me when thinking about this as an
API. On the other hand, it also seems reasonable to ensure that the
function gets cleared whenever you call it since it should only be
called once?

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		up_write_ref_node(&fte->node, false);
>  		tree_put_node(&fte->node, false);
>  	} else if (fte->dests_size) {


