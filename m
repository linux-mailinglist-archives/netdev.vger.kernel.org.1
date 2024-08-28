Return-Path: <netdev+bounces-122966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311979634DA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96579B24CBE
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D881AD3E4;
	Wed, 28 Aug 2024 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpmymK3y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE71AC446;
	Wed, 28 Aug 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884276; cv=fail; b=tkZ0SBmzDKgX9UJhtUoIlF/dObtnhimyj3i0wSLq/ymZwGOZjidTDEzT948bxCIxy8PIJREMcu6iCTa/k7eiXLEOD0zEUqVVIyqT8rXN6sH1PfvLIhbETlAL21yvekx09J1DT9sDLp1Etf9arhZfSWL0NEYf/SbLRv4bt8MnCyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884276; c=relaxed/simple;
	bh=SxxjKczKeYv6t3/GrQkP4ngNAREZ3Ba+xDJaRjtuHxc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qDrhwJ2vv2nxvISQl41PaCJvxfzq/94lXUBCYJP5VQ42lqr5Y0Xphm6bmtaDTghF5+tIu2evlZnT//2ZCreGbmCtMUUFNR3Ai4YFadaBVkbxblTI18Y4HB0rVpwn6KH8C6dkq/wcNJmXb6tMAFoXXf/cSpUlmvcLvywYovAo2Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpmymK3y; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884274; x=1756420274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SxxjKczKeYv6t3/GrQkP4ngNAREZ3Ba+xDJaRjtuHxc=;
  b=ZpmymK3ye5dtEjvuTAaQ2X26+sPEn+6ttQehQvp1CtcpgHshBM+bt5wM
   c9X4CbNBsIAIIiYiHI1iFFqWsMvSwvySEMb7ZnR5AfqceXCspPZHIyzIA
   KumWmYVW+FjTR6BIpgjyCaUHW3UOO7srCP1HIGue6jgqCs626So9/OwN2
   fcB/iWiZjoWMxFNMhe+X/xYK2PxbRE/Ddy5AdjYtkzYusuxagxT5CfXHy
   yaRhoOpwDPpxAeSjGw1WP+siyrDFtvLOaeotV0qd05jWyOijRloetZfJS
   BLRleCoiDWPhwNPGUr1Jg8s9B+HctEiw8oAVFECY5sNLeVxvRzpQoisT6
   Q==;
X-CSE-ConnectionGUID: WnK+GajtQr2VOXik+sFmdg==
X-CSE-MsgGUID: P3W0wocDQKuT6twwTu7PIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23334085"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23334085"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:31:13 -0700
X-CSE-ConnectionGUID: pLSyAOatRlyMAX2wHAU5ew==
X-CSE-MsgGUID: TjgbJpLNQAOm0vybDB0E1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63055878"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:31:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:31:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:31:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:31:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:31:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcWZ8m/nuYx/AZ4K9kOlU25TUQWbdrb8qOENGpjt+H+tVV3n3STXlVwRmZESmtI6fGuQfuhHT97H+3/+5Z5VmOMbcdj0NDVU1QjTthPLvHvmflFPA1Mr4sRiN71Gh3w7GRNAqmZmE80jo8INklwSDNVK/z4XK0R0NBNc1W48954yZNvO0dqeO8XUQPWYj7jECqoG8shcdlqsLnizkBPFxhODywCRlm2W1k8cSsuNQ/lIw8NBWHEASZQaoz1fZAjU2YA9pEI7sklyDx0PrgcM1kkULAsqtnSTsg+l9oJnd6OdlO5XuNttrEl2g+nfC5/irhRHzN18ky4xOMHv0I9amw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+2U2JVAMmlWQptjhe+AJZLpsx/kz5dbb1aBwHFBkqU=;
 b=HetQTNvzPDl6UHtez3PhKYSNuPp0uF6XMTN1ecpw2ZSMkEeDWITdyFdsn9ZH0RDIeI5ZPBNGkVCGNAZhpStZ4TfiN1770uXsTxwqFkynipMwpV+68UeMLZVbQe3wifKeVFBZsn32CP4J7ct0Ij1XbolelRd4RdSJRW0jBpr/yfVq8QoKLDlHrVBpIIcSq3zvbp/QAKcB37dePVTtpJETAffzcoLtJXo+8b7wxS0XQ5FIsLD/R13lNlKMBkJk+Ch8pe+lDWCprh/EolH/WROrIDEpPSyZNq1coWVKpljKsqHNytq2gv/yWGvTshcsGr5ht2K9cmZW9UIeNQOdts8ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:31:10 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:31:10 +0000
Message-ID: <63d45a76-6ead-4d62-bbca-5b1e3d542f1c@intel.com>
Date: Wed, 28 Aug 2024 15:31:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sfc: Convert to use ERR_CAST()
To: Edward Cree <ecree.xilinx@gmail.com>, Shen Lichuan <shenlichuan@vivo.com>,
	<habetsm.xilinx@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
References: <20240828100044.53870-1-shenlichuan@vivo.com>
 <6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <6e57f3c0-84bb-ce5d-bbca-b1a823729262@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0348.namprd04.prod.outlook.com
 (2603:10b6:303:8a::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 100c64fd-c88a-4435-1b62-08dcc7b11d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0xaMVdnVW9ueHdPaE9CeWcrTEpuWURubVZ1VTdjTm5UYW5QdEYydFArY0dN?=
 =?utf-8?B?Y0hXRWo2NVN2UldkSUZwcHFXbVYwc0xMcElQYkI0Z1c2bnU0Qkk5bU5mLytS?=
 =?utf-8?B?Mnk3ZEVHR1V6STN3aERvVFVUYmpEeGZ5T1ZTYVVDTDc0Q1pTcGxrNStXU3Ny?=
 =?utf-8?B?bFpHTi9haEwwclZBS2RMSjVPWFgycWxEM2padGxrMXhaTzcyV2ZXTkhEOFdX?=
 =?utf-8?B?MzNlRFZoMXhCZGM5SmJQYzFyN2FoNitUSHorQmU5Rkc0eGc1a21zNWpwZmJ0?=
 =?utf-8?B?Tk9hM0dTeUUwNnBNa0YvSVVIb2padkN1U2wrYjRZQ2ptTDltNGkvRGpaMHRC?=
 =?utf-8?B?T2ZKV1F4WTRsRFFQV2RSNGsxdEtKR0pLUHlvaWxWRTBXYVB3OXRsdnU5OFZs?=
 =?utf-8?B?Y0xRbGNwZkNBVFdTcUJyUGp3Ti85OU81YldoUm10TDVsdWFlWGRRRXdyUUFa?=
 =?utf-8?B?RFI3Z2FnZDE3d0UvZ1hEbzFoQU9Gc0VQQ05jZWQwVGxNMnMyR084dU9WL1RT?=
 =?utf-8?B?SlFmMjR3dHFaSksxY0J6cnpsYWFrZTRMZVB4SjdnWnFaWlQwc0kxUXE4Q3Jv?=
 =?utf-8?B?VjROeGpQL0h4d1VldDBZRVBPVzBLKzdwMUxlcUJZZVRGcXFOWXdSeWpRNHBJ?=
 =?utf-8?B?VnBIaXI2aWJHeHhwa2tlT29VMFN0dUw1U29iNjlsb040ZjY5SzdUeFpMSXBi?=
 =?utf-8?B?LzZhZUpkY3Z2V3NqeWZpY04wQm8zK25iL3BxNjdZbWd0TlhsZ2pGcE4vZ3RO?=
 =?utf-8?B?NnQ3TW9veFo3SlpYTzFNT29LUEFUZ0ZlZmVFa2pvVnpLcXlNRnhSYk5vM3F3?=
 =?utf-8?B?eDFZMkgrYUU0OWJtdUF4ZEFTRjd4emZYSVpHellCMTBLRTBGUnNSUmM0TjVB?=
 =?utf-8?B?ZEJLOWpWdElCblcrREpsQmp1b2J1cERaVkQ3SVE5UEE2dmxEcmdmNE8zcTdt?=
 =?utf-8?B?ZmNqWDVlaTVOWVBBbVh3c2V0V1VGeDdweitMQmdCNnBvYi9YNzFaNE5na0lz?=
 =?utf-8?B?RDNZUi96SXIzK1NvbWpGQkRVeWxZOHFoMnBhOFJ2Z1pEcVhYdXF3cUJleTdT?=
 =?utf-8?B?MGoxaXhBRUE2dW1uQ1grdmEzNFpEQ0Q1ZEdPMzdxK1huNnpmeklKVHZuMW9H?=
 =?utf-8?B?WVpFR0l3VUk0NFpwK1NqbUV3YnlPekZuSE5kVmxGVys5N0dRQmcxRC92dllD?=
 =?utf-8?B?UWk3SmpreEhHRmlGbVdOaDlIZjU5cEtFMCtGQWNMRVVqZDV0SG5uQkZoQmtu?=
 =?utf-8?B?UUwrQ0hBbjYwMk9BbUFkZFV0emxrWlRNTHUvbUxnL2RiSHJraGRsdDBnZnJr?=
 =?utf-8?B?R1FuOENuVjVVTDU1VndzNE9SeFZUMW5xcGNCYjlxRmkyb3lvd3ZvVDBtNUlW?=
 =?utf-8?B?b3I0cThCb1gyNkI2YWd4N1hMNzFFem1CdUlJV2VhRjE5bU5JQndtVlNnd2Ft?=
 =?utf-8?B?NDRGRitzMUZtL1dudG84a3RnYVJadnk2RGQyZDN6SjNzQTZ3VHJTY3hKb1Qz?=
 =?utf-8?B?QWduTjFmTm9ycEZYSkYwM3NEZlVhL2hGMU12Sk90ZEZ1RFJ1bE81Wk0yS3lD?=
 =?utf-8?B?QmZOUWNNSXoxUjlmM1NLaVJhdE9uYkFmS05XeUsyL3FoNXJTNjRtTjk5dit3?=
 =?utf-8?B?VERPUGd1YVE3aWJ5RURIZUhDWmRVQllMQ01SYSs5eWhXWE5BMUIzUlNrdDhR?=
 =?utf-8?B?Z01IVkdaeUZubEl0NUNHdkwwQXBEaiszQ1ZUcUVtNnV3d3hkbUN1L0FMTVEx?=
 =?utf-8?B?VXJRR2RnL0RLRmtiRXpOd1QwRDBQNWhieHp2Y1JhNzk4OXJpUHdmSTBvVExl?=
 =?utf-8?B?Zy9JbkhLZlltV1dTbVdLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtGSEZqQmhDa3lFOG1ZV2hnL0hDVTRNYlFnMWQ5QUNZKzlrWmpQQXZCN0R3?=
 =?utf-8?B?OFR5SVZUMHdhQ3p5L0k2SlhlT2JWdXlZcStsVkhYdmlZa1RpRCs3ZW5Cc1V6?=
 =?utf-8?B?SEo0bzJjdG1ZQWRTaS81VTArQ2RldjBNWXU4Rnd2bU83c0VoQkpQb2R5WHdV?=
 =?utf-8?B?aGZmOW1nSFdRMmVOMHVhL1FDaGpSczFpSUV2NWFjTjBRcHlTRTVzdWdjbDMz?=
 =?utf-8?B?dkVKT0hUcmY2RVBrT2xUb2cxUkw3aTUzNk1BaHMwSnVlZFlGSUV2bFIyc1BT?=
 =?utf-8?B?eldYVE16YlR6SzYzN01RdlNJeGJyU01Pc25aRzRUYXZtNk5IajhhV2Noem91?=
 =?utf-8?B?T0kralh1UXlpVXFwZ3d2amhYdU9XaFJodG14Q2JOR0ZnUDZHL2ViRUtuRlZD?=
 =?utf-8?B?ejF6N0p6clpYbjBtUTM5a0R4SkM2Nnp4ZUVDOHcrV3lKWVh4em5NbTdVZFFE?=
 =?utf-8?B?dFh2bmN3L1JOdzQvSjdyQXVERHR4ait3SWU5U09KOTdpMVljd3NYOEZsTGt3?=
 =?utf-8?B?dTJDSUViN3JTbTUzd0tkNVZORGZRczJxeS9DZVRFSlpXd2VtbWY5cEJLZ1c3?=
 =?utf-8?B?VGNPMTdOTlVxUjlydmpLVCtSWmpxQ0UyWStsL2E3SWR5MmREdTRTWGJid01i?=
 =?utf-8?B?bXdUNG9XcnpMZHFFbHJwclptMGNCcXZUSmVqWWlPdmRLelNWRmlHRzJ0TVNl?=
 =?utf-8?B?UXQvOUJEa0E1L1oxQmRHVytLUFhaQ1JZdEYvUGc3V3UwNnp4S21ZeUpTWENQ?=
 =?utf-8?B?c0lXckZ2dzlpdzJZNm1mS3RERWdCTHFNL2wrZ2xDdFVKaThlWGJ0NVNlZDdB?=
 =?utf-8?B?ZHMxZ0U4bEhGTDBDTm01NlQzWjlEYTViQy9lak5Rc3o5cnl5b0VMazlwamVn?=
 =?utf-8?B?eldqR2c0YXFSc1FrbTRFOW1qbGtGTDkrVSs3QjVPVDRHVmtzSXpJVTV1T1cv?=
 =?utf-8?B?SGN3dDFTbCtMTHA5b1lDWE5NVmUzdmVqdDFBQnBSWGE1enNpc3haUjVxUDJ5?=
 =?utf-8?B?UjVHWEhFZGorL2Zvai81dzJCWW1LWXQ0eEEwQ2I0bHhpa1laRzczbDRGS094?=
 =?utf-8?B?eFJyL3hZWkJRVkhNUThrWHpyN1paMlpzOGViRlo5ZjNTSVVUM2JXMmd0d2Fn?=
 =?utf-8?B?bkVYYWIydjlNNlY5WDFpQW5yRzh2cnloT05KTysxTGRyQ21oRG5mQlBYVFRt?=
 =?utf-8?B?UnczenZGTWVYdEkxUlMvU1I0eGFtcFl2SVhsbjVQR3FRVzV6MzR0V2tHZTRK?=
 =?utf-8?B?eEtYTjhWV1Q2NGNINXJEZ0I2MnN0Mko3bHoyWFIycDBOdVFQbkRBdDhsalRN?=
 =?utf-8?B?am5xMldHSWdDV0M4RktDUDhZdHhISDgyZ3RYcGc5SUsrRzF1M2FmcjJ5aEdo?=
 =?utf-8?B?aHIrTDRXYmJCeFhTOE8xTGZPZ0hvY0tzRzBsbTVHa3NCRThrSWkrYzY1VUhN?=
 =?utf-8?B?dGdlb2FnS1BpVThQWTkxTHRmc05vK3Q1Z3VQazZuMnBlSzh1Sm5ycThaS2pr?=
 =?utf-8?B?NWhkYU9IL3NCK0FwL0dBTTNPR2ZyTUVYSE4rTTN6bzVlVUJTdXFJVHZjcjF0?=
 =?utf-8?B?SkNvT0JUMlRNZkxUTXlOQmZtL1hneTZVd3l3QVFWMFNjcXZUT2JEeHpVRXRh?=
 =?utf-8?B?ZG13R3phQmV1RjVuOTRKV1d5YldWV0FueTYva05JWFA5YjNyWS83VFgySVp1?=
 =?utf-8?B?UVhIcSt4dTEyck1LZXpJMk1LMTdXWHZPYnNhZjFlaVNiY25nc0hab0RMbkd3?=
 =?utf-8?B?QkhjaXlncTRwTTZVOGhuZUpVTktveDVMdFFZN2Q2ZGtrdVJCcy9iVkQxTEl5?=
 =?utf-8?B?eFMydkVicGxtYmhmR2ZUNW9EQjlSbDQ0VHUwTVVoZlBhM3RnMzVNbFpISGhK?=
 =?utf-8?B?T2haYmJmekI4NDJodm4yaVVVZlh6VDIrNG1kQlRDL0JwdU9QRFpDazFzeEtl?=
 =?utf-8?B?M0E4ZmF6Y0xtWWx4QUhQbEg1ZGhaSndJU3UzVUE3M0xndlI0MTJ0UTdiUFlu?=
 =?utf-8?B?b293d0hYeWdib1lBZkpLTHBFb0RGczZqVlpBeFVYOTFuVCtYTHFaL1p1MmVT?=
 =?utf-8?B?QXZGSWYxcUsyNFlMbGN5RG1qdUovK0MzRzlKcHF0SzhtODdkamtMaUtueTBl?=
 =?utf-8?B?cWtZWE5vUngxMDV2d0ptREg2cWo4blEvVU9oZFRsVFcwQlRTUytoaWJaZXl3?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 100c64fd-c88a-4435-1b62-08dcc7b11d92
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:31:10.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Oojyje8dMOBzFRQTBIbwT6xy8NM6jlgUM/acgBFx6qQzA3tB0vhpp+5SkR7ZjchA3BxzLh+9qun/BT8ta+H95Ic5aYKlt8KF0E0MFCfo6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com



On 8/28/2024 6:23 AM, Edward Cree wrote:
> On 28/08/2024 11:00, Shen Lichuan wrote:
>> As opposed to open-code, using the ERR_CAST macro clearly indicates that 
>> this is a pointer to an error value and a type conversion was performed.
>>
>> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
>> ---
>>  drivers/net/ethernet/sfc/tc_counters.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
>> index c44088424323..76d32641202b 100644
>> --- a/drivers/net/ethernet/sfc/tc_counters.c
>> +++ b/drivers/net/ethernet/sfc/tc_counters.c
>> @@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
>>  					       &ctr->linkage,
>>  					       efx_tc_counter_id_ht_params);
>>  			kfree(ctr);

I was confused because I was wondering why you would kfree the error
value.. until I realized that this function has both "ctr" and "ctn".

>> -			return (void *)cnt; /* it's an ERR_PTR */
>> +			return ERR_CAST(cnt); /* it's an ERR_PTR */
> 
> May as well remove the now superfluous comment.
> Other than that this lgtm.
> 

Somewhat unrelated but you could cleanup some of the confusion by using
__free(kfree) annotation from <linux/cleanup.h> to avoid needing to
manually free ctr in error paths, and just use return_ptr() return the
value at the end.

Anyways, with the removal of the comment suggested by Edward,

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

