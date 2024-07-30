Return-Path: <netdev+bounces-114075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47899940DDA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2508282F99
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE5195FCE;
	Tue, 30 Jul 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSVOkX20"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A797195B2E
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332174; cv=fail; b=LW2RkBM/B44OYpUayDP/zxQ8d4HKiu/OmiSisysBhe/ZAmnpHRwGTTdJaH/Fkw30rUghJxr3efhDQzz5fNVt/tnU+vfNcEZtCWSrK01wp5imcJkQXJjVSS1RJjU7RxrpMsZRKZ4CMoE2KvSLUDo1QdZdGHjvDd5gjLZznbb2+FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332174; c=relaxed/simple;
	bh=Xa3sL4L81mu6H9BmMcnaGO1tMMiJ6yZt71RRSLkktE8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bq7K73boGwKHye0ni4D+DeYXeRXo594C3Yx02/238cNjD56us5y0dH/yhx0BFgU7G/9hSz8dEhUjMKhfYRHfUKU6uHdQLdFmh2o8FdBoXN+RP+aD3I6uH494Q1PtVzTzvMG6wIa5Nf/5N296G1td7FEr+p9hW0A61XQ2koR5QEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSVOkX20; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332173; x=1753868173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xa3sL4L81mu6H9BmMcnaGO1tMMiJ6yZt71RRSLkktE8=;
  b=CSVOkX20e3YpSoSlpK9kclYWaE/YVjXKwHWLSTnWumue1WR+pGu2cZHD
   LFgxnxICcCCRBQhfm5YuRYZlVJkDQ3FBQFrAVNaz74Hlw9aLX0+k2U7iC
   RQs3joY+rlOZg+dj5f9elc60WU4Ll0HqR4vgJ1KM4qf3tS+Tx86Z2Q9YC
   l1PkDmdvm5dkjXTRXA9/oGhKIkCWlaZ4sEfD4OGn957vZBOa1mnjxLcGq
   qDe/d/l02buM9iWR7WBZ+dYiRCTJ0g/Y4lYqPUV3kzi+ZesfqlIhOF7Cn
   VZkqZdvgkTECryNviTkhdOG9lYeIdW0MGsOyvUlCmv6wHcm3UljlMTOR4
   w==;
X-CSE-ConnectionGUID: X9QkWLMESHqcXssafDtqMA==
X-CSE-MsgGUID: mzihyfg9RriRZSbu5zlhHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="23053112"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23053112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:36:13 -0700
X-CSE-ConnectionGUID: y1PzDm0OT+OSoZKTsgSDtQ==
X-CSE-MsgGUID: ei3TsGHITMKtMJzKFw2+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="53942711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:36:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:36:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:36:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:36:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxM2VBlyPEOwiHSnruceQ36qBOIwn43Jt87HJfMuuSK4I+dE77b4zXn0cXboReOQv2owu9zzTimQ5a0rFaFOrPHl5geg8V/TCCsO8MiSADAAfb0Xao9r4nc3yjT2hWM9QuPXXx0OAarOkBKJc7jnHrKGyDEriSonHx/Km04LHz1wyjw4YQdrXe9iYoPNjV3i/urrBe1mb5LT/pog53vkqM7cyZBJCUputJXW79SG8kuApW0l1heTp17COBVm+JdP/LhfbZf94su/Cn9hDtpWd7J5Ot4PCDuue3euiRZktdEC1MZm+IXikbYGtG/uKEITxMHpegtzJQPOcNlbjdz12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lcrroo2vTWu801waZcLYX1IB8iGL3+pbWBtYaVRttY=;
 b=vcyxqsM7k1XgNjNqyeLPXbz26X/POtCG8Fhsrn/vHFzbGDaF/1XeuKBfMA1mhT5p7dzyiJti2iyd4RDa18jWr1jdYRF233YuPsxLCpsb6YYCYFiuAdCC2nPG03nzBfKf9KoXqwDlqmhEtURKWgOg48ZmaXmH57Hb7DZF7CuKtQFys+mr99Ku6vToSWbPVwa6v1aCFfqPopTvLAA7efxqajG3mwf1c5CG63yN9kupCpmsYnQKER5RwPRp7pyX5Yp8e9qMZR3DFHjD7/BcQI943PPYG2jh8Kt4tZ1OCoHMHPplzOrxt4FoG4+tk4LAx+WEW5nZ1+Aj5waqhFktWQiLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:36:08 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:36:08 +0000
Message-ID: <370c4d20-bb83-40f8-bccf-12e0685c07ba@intel.com>
Date: Tue, 30 Jul 2024 11:36:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/8] net/mlx5: DR, Fix 'stack guard page was hit'
 error in dr_rule
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Alex Vesker <valex@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-4-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::8) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: d26f63d5-599c-4fe7-dca2-08dcb07b0a66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzBHbUFDTkxxUjFwcXdiRWs4TFZWOFhhaExCOE0vbGpxcktQcG1jeHAwMXVs?=
 =?utf-8?B?d3UzQTdUSUcrSlZLR3I3bTVKY1dpVUx5UjhHVll3R2kzRDRzKzVXR08rdjRk?=
 =?utf-8?B?ZUNCZ2sxMmNQcG42WVQyRWVrUjVtQWRuRVlTRVk4dDNzZzdsWGd2LzhycmtN?=
 =?utf-8?B?cVAzT2lTd1NJNkV6cHhTUVpVaXNEaDJwS1hwZVFTNis4U2pGNitqNlkvSmVv?=
 =?utf-8?B?amlPTGlHTnpjSWtmdEp6Wm1VTTR1ZWRwVkZWaDZTdFFnQ1R4ZGRWaGpBV0ZE?=
 =?utf-8?B?VTlGOGN2YndwVkVRL0FHdyt2L0pGem9Odk43dU5pa0Z3NWtMOTV1L2J0dmJv?=
 =?utf-8?B?ZzhLTGNSdDZQQkZnck9aSjZISGJTQlBadlJucDZNR1NrQ1FOR3JoekNmTnd6?=
 =?utf-8?B?VmdVNjk5c0tlMjBOUGgybDZQRWNRdG1JRVllbmQxK2ZCb01BSjVybVBINzB0?=
 =?utf-8?B?czhmd0cyOWNFVjVkaUpBdnFkNG1jQVV1aU92UndtMnJFQzdhZW94ZnRvenlE?=
 =?utf-8?B?T3FXbzNCd3dzTTJ3bUtGcElQNTcvSExONE5LWFJSNXgyY2FhbEpJdEdVcEZK?=
 =?utf-8?B?d3ZvemI3V1ViaDA4Vm9Xa3RZbGswbXl3MUQ1dEdIMExqMm9icGh6VmdhMXBU?=
 =?utf-8?B?elNVcWMzdldqaUhSNnlVRDB0UTdWZzR5T1hIZ28vcXJHQUM4dkVGYkZFN2t0?=
 =?utf-8?B?TEFacnlXMU9BaTF4U2lRN1ZybFAyY28yK3Q5R2ltTWlPYk43QUNDeDl4QVB0?=
 =?utf-8?B?bk5CSENlYmlwOWZRQ0lPeUpvcUpTcnlPdnJpbTZhMGJJNEkzdmd5b2hBcjI2?=
 =?utf-8?B?MVM0c3VTZy9EdGpmbHZjbXU0TGxyMnlOb3hBOXl2T2RYTUxEdUx1RXFRK09X?=
 =?utf-8?B?QkdDZzBIUkl4eEdQRld4TTBDN1VZZUc3aktTV1NTRVRGU21BWmJ2TlFSamJB?=
 =?utf-8?B?NG43VGY5ZTZhZjhhdUtMWVo3OE9aaVNJeHM0SFZnVUdmRWl1UFQ0SzFkL0tr?=
 =?utf-8?B?eXE1dk90allJdjh2VnJKVnpnVitNcTNjVjl0c1R5Y09tVzkrQi94ZzY2OWtv?=
 =?utf-8?B?bHNXUkNPZ1Nla2pybHIwRVk5V3JhMzQ2YkVUSVZ6aDJhNklZUDhTNXlvdEhK?=
 =?utf-8?B?VUhNUDQzVlNvaGdkdk1GTHkyMzJYMkVtalNyZTFPR0lidTIzaUxrSXhxQzM4?=
 =?utf-8?B?NEJjM1d4ejJWeVR3UnNYSGg4d2NwS01QR2Y5OG5jSUVDQUpIOTdGQUl0V084?=
 =?utf-8?B?K1VIY0cvYUNKUkVEMXJGdjNOdXRLaEJ6c1VKOENXNmVUNlNjRXZRS21EMnUz?=
 =?utf-8?B?MHNjZFRFU3BlTFd2YSt5Vm83amxnZEpWNFlxU2pabDVCK3FodzFwUTNJbGFm?=
 =?utf-8?B?bVNaVjM2YzJTaHhsNnRybm56VFFOYTJBSTJ6cWIyT09RSnpjOWhDV3gvci9Y?=
 =?utf-8?B?eFpCbXN2cFRKTHNCdXJzVzBFOHZFSGZyKzVDb21kVG85U1drWHRkVmZSTy9T?=
 =?utf-8?B?RkZGeVJQRUkzWFZCZm1FUXlwdWI3Q1ZldFFqbUdSV3NWM3BUVENtR3ppYWdw?=
 =?utf-8?B?YUhJOEhNaFc3ZlRrVnJrTjVhOHhSRW81ZXJDd2toczN5M0NUQ290dzVxRFZW?=
 =?utf-8?B?RCtaSFhCUUYrc0xNNFdsNXBwbGtBanFNODVrbDZQZlc3SnQxdFJDT3hzL1V2?=
 =?utf-8?B?bG9RS1hQUys2MHp0SGk1bnE1SmRSUjlRQnl2bHZuWmVUYlQwK2tVVDgyZ3Ny?=
 =?utf-8?B?Qm5YZU90ZHZqbEtCZzN2U2QwNm92eERtYVNzQ0l1dEVjNkdVYVRQeXIrbUMv?=
 =?utf-8?B?YThEMFdIamp5cURxMmRidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnh0TDFPcERIUjlVbU8zblhaS25Vc0t4L0tKZER0Z1dHcnpGOFI2NDkxOWJ1?=
 =?utf-8?B?dU1MblJVUnhjMXc0ZmR3eXJXeit2VjFDaUdEVkNxTGJDTEw0UHF4bEx4ajc1?=
 =?utf-8?B?Z2RqVXdHT2dzd0J0V1NGcWl3cVZrbVlhcWJpNXBTVTNrd3I3eXBIaG1ZQ2JF?=
 =?utf-8?B?dHpZWTFxMHRtdTRoempqQUgyZTBoY0JhTGU0cVpDU3NEaExraEd3OFJQY1F0?=
 =?utf-8?B?d0hiSFpGQWhDVlNkQVdDcTNZVWlLUGlLNi9LTGdlUXdkZjRIRUtOUk1JVTl0?=
 =?utf-8?B?QnVNbHkrM0Y5eTZCL3JyMVhqaVFTRnR4Q2RhV2lHN3Z2MlFPS3ZMSEpKeGIw?=
 =?utf-8?B?Tyt2OTc1MUZodTAvdHhLOXk4Unczb2F2aW4yQ1JOUUNoUXFkZFZRbFdjQUN0?=
 =?utf-8?B?VUo0V3d6d3JPRlZvaTUvY3RiYTZwOExYT0ZnWUp3ZUI0eElGRkpVVVlxRlh5?=
 =?utf-8?B?TzFraWZuditkckZwMHBSRTRZWU84VkNBcXlQUHZiUTI1aEFrRUlVQWF2eDM2?=
 =?utf-8?B?cmxwbGs3VzhTQzladGpZTWVJOVdTeGhMa0VFbVFXVEMxOTh4UGE4dHRVVG5S?=
 =?utf-8?B?bmY1NnRhd0lNdnNUY3Bic0d1eTNrRHU5Rk5XeTZvb1g4VVAwZjdBZWZkNTBN?=
 =?utf-8?B?a0VNZEVrb0pjZFIraURjcTRTQ1dVZ1JaRHU1RlFYckZCMUppQWUxc3RKQTJG?=
 =?utf-8?B?cXdoMzBBRFRZcS9NUEtsUEh5OUVTQXBTdHVxd3NaWWJiWXc0TmY0eERDbjNj?=
 =?utf-8?B?WVJObFFOaG1jNnJDUWRPTFpuUEEzUGVMeUsrZEFKUllTUDFLRTRNWkxva01U?=
 =?utf-8?B?NzFVTEhQQ0xnWUVQdjJBWCtiUm8wd1JnU29yNDh1Mnd3SXVZeXlITlMrdzFa?=
 =?utf-8?B?bTVGRVprVzJ0QzZlUmQ1S3paSWZuUTYxNXJwWlpEY3JLSjJqbXI1a2kxWWlG?=
 =?utf-8?B?blBrR3NDenVIQ0hiRi8zWS9wVVd1NnVRb0g5SGp5T3V5U3ZJZUdkZGhPS3Rm?=
 =?utf-8?B?KzZoWFF0cDlDa2YxVnNQWVpTckphVng4VkZ5V1ZNL0FuTEZsdG5DRWo0Lytn?=
 =?utf-8?B?aDAzMk9oQ2lVc1B0djBjZGVUVlp4QkJuVGlJd1V2Rk5VdnJ3dmpibVdLWklT?=
 =?utf-8?B?REVUcmc3ekxkUVRrcVgxZXQ0S3diVGkraEQwUnM1cUhWVUswM1R6MExONXBP?=
 =?utf-8?B?Y1hhOWh6NW9oemV6VG1WbEFEdVFmWU9peEdZWWZkK0RHQUtnbDhGcXpsdGhh?=
 =?utf-8?B?T2pJWGxYYURwVnN3S3g5bHQ4TmJ0L2g1YW9tZ2lnYW5QN0VXblZtL3NDWVRR?=
 =?utf-8?B?K1lmdk1NTUdLWWJmMjJHRzc5ditVcUY3YjIvYnVpcFF2U0puQi9LeS9ReDhS?=
 =?utf-8?B?aCtNanBrdElraWpIdi8rSTllMC9QRzNpNlhRc0RKRUZkdUgzOXYyOERUeHVu?=
 =?utf-8?B?MHpkZVdvU0dSaFZLREl1KzMxS1VVaFlkTHIzNm5IM2RoUlJOemgxR1M5VXlx?=
 =?utf-8?B?bktVM2I5RGxWN2xRVVJ4SURIRmU1RzhsU0RRUmJuQnlUSi9wcGpZdnhDYkk4?=
 =?utf-8?B?M1Jvd0h1Z0JFWnptQVhYNmJmZXFhSEZNWEJJdmFXaEdBb3FRRFZ6UzBMbXZs?=
 =?utf-8?B?bVhJU1NLanFCRzFURDYrSlBXUjZkbCsrRnlSSk1jSUwyekxSZzdNOGMydWpx?=
 =?utf-8?B?MHFwdDlYazhkY29uWXRNT3FKcGxkK0RkK201NGpmOGV2aXUwN2RkWDFoNzRV?=
 =?utf-8?B?S1lobmNqQ3IreVU0RDRzOWlrK0V6ekpsc2VDbVhFWEtZL0ZTRnN6SnZGOEli?=
 =?utf-8?B?Wk9EeUdoaGUydk9DbFB3Sms5SW1TR2FrakxJenJicUNWNlRxM2RrQ1VOdVNy?=
 =?utf-8?B?L20rZVpPNExUNGxiK1AyUDdrWXBZYndQYTA1NzkzL2FXU2F0M1JVNDgyWXAx?=
 =?utf-8?B?WEJ0ME9Cd3pmYm1BM1ZLT0ViTDh2S1BaVjIwanRva29YQXlnbjZNcVV1VS9z?=
 =?utf-8?B?Y2NIZk1obEFJdXl6MDBIWlpIRG9XSUN4UXJpOEc0akM0a3ovVVlBWmxjNkx1?=
 =?utf-8?B?YVRVTmtNRVg5YVhJRDRlbDNxZDBoSXdUMDNoVEtuMlcxeGlESmE4a1lkenJq?=
 =?utf-8?Q?+mTSeh08sGtqAa+mGrjfqN4EV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d26f63d5-599c-4fe7-dca2-08dcb07b0a66
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:36:08.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbGDSPG9aho3GXr+yAVM/n+mTbgqDJfrVGgRd3f3ui47/Cl5BgJyRyCIk627gDpARaRnlY2H9RWeUc/RdE7CAGqJVkqOHKaVj/PVeYatf3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> This patch reduces the size of hw_ste_arr_optimized array that is
> allocated on stack from 640 bytes (5 match STEs + 5 action STES)
> to 448 bytes (2 match STEs + 5 action STES).
> This fixes the 'stack guard page was hit' issue, while still fitting
> majority of the usecases (up to 2 match STEs).
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Alex Vesker <valex@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
> index 042ca0349124..d1db04baa1fa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
> @@ -7,7 +7,7 @@
>  /* don't try to optimize STE allocation if the stack is too constaraining */
>  #define DR_RULE_MAX_STES_OPTIMIZED 0
>  #else
> -#define DR_RULE_MAX_STES_OPTIMIZED 5
> +#define DR_RULE_MAX_STES_OPTIMIZED 2
>  #endif
>  #define DR_RULE_MAX_STE_CHAIN_OPTIMIZED (DR_RULE_MAX_STES_OPTIMIZED + DR_ACTION_MAX_STES)
>  

