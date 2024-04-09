Return-Path: <netdev+bounces-86317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63589E622
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CEF2820E5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65584158879;
	Tue,  9 Apr 2024 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpwfvpG3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDB2770C
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705747; cv=fail; b=PTdMNxmXfTyTje07ThFMLeTgHplCs04wE50OOWAkwD+HYx6JgUGaELj5Yh4euPFb8Up8DdFSxpqyotoA0+83L1MvEAocAqfnvZ7RBpMe6c8EFxQzZja0kISHJJoiRZOZg+0q18rHObuRo8T+iitioz6MHHrd3m4gInc75UG3Lbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705747; c=relaxed/simple;
	bh=QfsX7H4367eXlvrA5bIaPRatW3Pp/ETnUXQYD8RQPF0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rz+oIj3FSZGu/pGpHVAFTqZzcXIp+e1hhu+dvory0fbHBPplN7W/VAsrV/sA972xg1CEc3CvQNzPVuZm3csSuQ0Pn+ibDTWrW9j0r7VE3cqs4EjU1i2OWQrabxF3a0VZIbilavhpzVi4X/45Y0CUK6abhQoaUE5NQrFmMhCoUvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpwfvpG3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712705745; x=1744241745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QfsX7H4367eXlvrA5bIaPRatW3Pp/ETnUXQYD8RQPF0=;
  b=FpwfvpG3qPWIR83czJQTiojstEiNrRyK8h6/VpyPc8pNrndL676EeqRS
   4lyn+rNqS2yfVvg/JKMhM3Q3Eq1uC+AC8Lr445nevcUq6d0C+1lGBXLLY
   jqv9fIXsAzuCZM4IQ/IDNohIHwz7ioAgdlb8gxv3yPtF/KDkiCuI0lImF
   PNzh48+RJJ4uxxM1NZVC25hGeLVidscVTXbXYBhlUqVBcErTLrmMVOP5/
   4rQ7xYQ6GnII/M7SrZL31r6a2cvAU8xHivLSCcakGnBe2/Ue0/cWKzNg+
   q9uGvrSgPcVFRno/fVzP14L9FT642l7x7rhvCm//vsSR8J77q+3Q0nvik
   w==;
X-CSE-ConnectionGUID: ercfSdsIRpenQoedg40bSA==
X-CSE-MsgGUID: JHsN0EWgRi6mhW5P9m5bFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8274185"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8274185"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:35:45 -0700
X-CSE-ConnectionGUID: PogJJQwBRK6x9bgSNEAiJA==
X-CSE-MsgGUID: iE8FUn7xTU64E1Wek3j0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43620745"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:35:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:35:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:35:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCK1iFkyVTJGjD/jAjww+i88YnXr0GJBzFvegCEPoScRAfstIS84weV2s3ujzGyR81Z+DIwph98krQm7qGAS8zDqpN6IRL6DAwcJuBWsoH6cfddQTMiGY8lZDKsDxjRbMFgz6KZD3ggwJPdZybqxr1//WTAoJN7k5QMGMyJKEIKBRsFwHF37E9ypI/fdLU7yiJ4GAT3zfN/r1YRibVrMhJEfgdbw4P4BA1KHoPMdrStjXL5PEKLuk2IAqaMrfwkK9ZYV0d2VfVSrq9GYCvySMMy73h815hwSKib+svlAik//V4G6n4/3LPYgZ/efmpjG/HZHhJtrNp+k05qRYe3n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Y+o8h6mdqmN543UWA9Ie4J8dMFLRGFR0qymGKl/Qs=;
 b=CHHGMm5bh0kcS/o7bCi+/0pnFjzXeh3dZtsEBdN77lq8fdvg1FcoPKXMN+/K2QQxZgIBKjBMwWy2PjDS0nuMNP3V9KXxJEECQM0XCYutYyuHQacOkkoCHyEUf2FcliAc84CCfQG3+bKPnNRknPsgEoap36TFm/wX2PRnfyplYdE2SKY7S1a9GvYFaCLHFWOGSFjeERlnfh4zIft3h0PT/49/dUpzqhe/uYBDBQcvB0Q/sdsLjwt7k0yZ1N+JqgXtwTq/418pB2vfbKW/wmv5XhOZKH1ytMvZxearWBN8bOuDngPw1Qu1LddBQRQKhkromJlBGJI09pqrXoAJ0mzClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 9 Apr
 2024 23:35:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:35:36 +0000
Message-ID: <af839ea4-1a41-4250-b5d2-61db182d26bf@intel.com>
Date: Tue, 9 Apr 2024 16:35:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] bnxt_en: Remove a redundant NULL check in
 bnxt_register_dev()
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Vikas Gupta
	<vikas.gupta@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-3-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-3-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5803:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWAAEanzIKF/sVeZedKPIAwJx7I67VExkNHVUmmxSin+JHecpoGf3CCaJtTx8t/9qW10NKw8Z2l3VSOBYPRmwAzTbvhJqrlflm5TwrEyDeWRBmAG0ndVfcJ7QJq4jF2a3QJ8vWfFmluklpWnc8CmC0XlBWas2AdUdoysMYvXXI5EBB2gWCkbLTeRJLDNMAVwTyDbGuStCPqhum3H7sdqfuCvo8Z+eX4QYprGyDRt74NzPsu9Wx0Shmv8QwP7+3ffSJ/X9b3pkrX01NJA+hS+Q4ydl06SLEe370GSTe85+bz+rePj3xhxEXWym0EP/1WlW4659IAzMTytvzSQ16jNfvSgQ9eOAP/s7kfwHyg4r2f9qjTgfw25wVFJoQD8h1o0kfM+4Vd9CcjELsrvmxmRZ65CqgIgYHmGi6y9jp4kQrNOrArT+bt5MLlftc5Ybk/fbz+9Nj7i0QEXDG+N/NqZ5jz55Oaw/liTaK1iP9O9+jurwBUiy2MFqt002Lln9mIrsbVIoug4mrBr0oFWvHKQpCsiN5gQ9xcznsrzdWX/BvbNxDgUtmQMoezRLMaWtOcOFEwrs2O4cXF6N/5wFT/EcmNNSSVRM4hNqcjvBez6Wzo0wAurE+YIPjJdfVFgUrbtHQ8vutMSrdXTModmQEvlTHIp8AZq1xFzN8om+pi10Lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUNhSWo4UVR4aHFlS2FTc3JaZ2dTSm5RNVErV2NvWkl0L0hhMGVBVUJFTk5F?=
 =?utf-8?B?c1lER0haQnZ6bm1DV2YydlI5Q2ZWTVB2Q3ZkQUg0V2FTeTNXN2JYS2pCakpW?=
 =?utf-8?B?eDkyYzZMVEFZODZ4SGRCSWd6SHBSSURoRWVYUzdWdnNCcG53TXZkVHRHOGFU?=
 =?utf-8?B?NCt1QXNFdkR6SFVGbmpyY1g4aDJQSlI2WVBNMFB4SXJBM0I0R0RvRHdOU1BK?=
 =?utf-8?B?Y0d2bXVWeEk3MXpPTis0aXhYbks2ZVVTamhMNS9jb0NkWVJrbXRUWEtRc2NR?=
 =?utf-8?B?bHZ5NjAvSTdVYk1zdzlLQjJzckt5c1JjdGFzL1NFWU10MHNZaWx4NFV6OGxD?=
 =?utf-8?B?Vzl3RC9pM0Nqa28rbzl3K2dDL1J3dzN2cmozQUhVMVUxME13VDRsZHRCS1lE?=
 =?utf-8?B?d0Z1VTM3dVU1VWkyaWFhVnNxbFVjL3FTdFZhbGsyYTkyMjVJZTFwVGxjcTVS?=
 =?utf-8?B?R2RwZU1BMGNSV3pBWWk5Nm1ZOFRxcUV3U1R1ajZlTlF3SGJjL1NzQU9ZMWJD?=
 =?utf-8?B?bkovUE9tUkFKUERWZGhnWVQwZFNyUTJxQndMV3h2Z1pseUNtS0drR1NsbGlZ?=
 =?utf-8?B?TnBteDEzcU9Ra3NvcllwSjdTeDRRY0lPTlgzVkJ5YkRmV3pPcmNlSFF6S050?=
 =?utf-8?B?dEtnWDhhZHdxU01oeWtMdEFmODNDR1B6ZHZWaWdPNllmb2hsNFZNV00yVUdG?=
 =?utf-8?B?blFWQlVqVzFzUytxaUs5aVEwcVRXV0xYUWZKaTVhbVJWQVUrb2c5L0RsZi9p?=
 =?utf-8?B?cmdTMktNa0hLZ2xjbnl2bkdIci9LMkI2cEEvS3dJZzI0L3dOYVBjMG9ZOWps?=
 =?utf-8?B?bDM4VUY2ZVBKczRub2tjUHh4Ui8vWGtUTWRMK0ZvQlVMVnFKbEtOTWNKMjhn?=
 =?utf-8?B?TGRYNDZoZjg0VGZSa3NQeDZMZWtjQ2VtNHU1S2tQQ1JpbkdMYlNIajJYSGF3?=
 =?utf-8?B?TXlaSGxqUWwrUDFvc01Pdy9ySTBlbUNDWlJubWJxRlBwZDlVYkl0b2tKOGI1?=
 =?utf-8?B?eTFNelg1MlFrcC83YkpTMllHVVBVWlR3ZkFOU29XMWhNWFhiVnN4QjhicUhr?=
 =?utf-8?B?Nlh6V25PdzJ6TWpmZEZDbXphZERkaHJUNEhrcTZCVlR0eis0KzZEM3NOUnVo?=
 =?utf-8?B?V0xxY3VZd3hPajZkTXZ4bEhTWm11eFhldFUwdWNoekhOVElkczAxTURyZ0x5?=
 =?utf-8?B?ODVubHZUWHh2Qmw0aVQxR1VLYmtvQ3BCV250SkpPWHYrOTNFeFN1VVFHdmo4?=
 =?utf-8?B?dG16TUNWRzNrRldGenBJZnZjS1RoZmJWTTFYelVwMWNxaWI1dE1vaVV5YTgz?=
 =?utf-8?B?aVlsSitEeDV5bmNwWktMZnhGeTI4bnJHWWo5aWRwNEgxWXFzMnlDVnpWa25Z?=
 =?utf-8?B?MXZpU3dDOUx6N0xyczk0Z2U4S0tGTnIrVWpjbEU0RWtkSmxzMDFhREloTzVU?=
 =?utf-8?B?SGptNWhZcGNVUVU3Q05McjRKTWxPUy9mMDhITlZiOTU0RFJmR25kMkd2MHpH?=
 =?utf-8?B?REpmY2hwbURiUE9rSG56MGxsVlM5V0NBYUdqSXJEdWtVZkliaVVDNFVlajNh?=
 =?utf-8?B?UE5Ia2ZsbzdnbGtPc1lmdktzWkxiSE9ScG54QkR2aUd3Qkx0QUgybHh3ZDdv?=
 =?utf-8?B?a1Z5MzAzby85SUJVcnhvbWwvOFJvSjdBTHkrbEo2QWNZdTdXSHpOU0V1cVdW?=
 =?utf-8?B?TzVQVTNyNFBQbmFVQ1IvTjN5VzdveUU3cWVkaktxSUc1NkJiWi8wMG1wcHJE?=
 =?utf-8?B?Nk1JTWhTclRzRFEwMExoSUlDUC9DeW9xd3ZaTVVsYStjcmNNbGlCYXdvdlRB?=
 =?utf-8?B?MUtndFNHMDR4d2hkQXQ3dGdXd0dabnowcGY4eFN5cmFrNEZjWC9ycTIvUVNv?=
 =?utf-8?B?RnV6S3J6bVdnTFFRK2J3Z213dWprTm9RSmdTY2N1U2x6bmIzc2lBUUdXbFJT?=
 =?utf-8?B?NEhDS1lSNk9NWTl0RSthNUhFeCsrQmlFQkQxMjZQeStvcXVoUzh0K1l0WjB2?=
 =?utf-8?B?VXZFWEZIdEM1WjBCSmttT2Zpa2djVUpsZnF4d2thbW5TOGVac0lpUU1lZ0Jy?=
 =?utf-8?B?d1ZpQUJ3M0hmU3dGQlVwMXdVK1V6cTVqRk1BQVhsdzJXWUpyb3hhbDNiR1VG?=
 =?utf-8?B?dys5MzkyOTZuQ3RYZXljcFdhT2FzL2RiQmRnaDhIRzgyaFdpRW5RcEdCbDQ2?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9d794a-f91d-448d-d9fa-08dc58edc1d7
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:35:36.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MogBpjhBiCtctK6llipJNxHUR55fqPD7nhos+WtSipVh9PpyuRtSoOkd9+Idj3pZPVKzEf/0TbMIEB+3Hduo+cThWXFt0fQN58TZNoAa1sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> The memory for "edev->ulp_tbl" is allocated inside the
> bnxt_rdma_aux_device_init() function. If it fails, the driver
> will not create the auxiliary device for RoCE. Hence the NULL
> check inside bnxt_register_dev() is unnecessary.
> 
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index 86dcd2c76587..fd890819d4bc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -64,9 +64,6 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
>  		return -ENOMEM;
>  
>  	ulp = edev->ulp_tbl;
> -	if (!ulp)
> -		return -ENOMEM;
> -
>  	ulp->handle = handle;
>  	rcu_assign_pointer(ulp->ulp_ops, ulp_ops);
>  

Ok, so ulp_tbl is setup by bnxt_rdma_aux_device_init, and you're
claiming that the only way bnxt_register_dev gets called is if the
auxiliary driver loads?

But bnxt_register_dev is a simple direct-exported function, so the bnxt
driver itself doesn't enforce this. However, if we go look at the
infiniband driver that does call bnxt_register_dev, it only calls this
as part of its auxiliary device probe.

This does make the NULL check here seem redundant, though I think its a
lot more layered than a normal removal of a NULL check since this
crosses module boundary and its a bit subtle to follow the full flow of
the auxiliary drivers.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

