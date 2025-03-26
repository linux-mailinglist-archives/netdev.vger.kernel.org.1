Return-Path: <netdev+bounces-177858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E2A723D6
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6A53B057B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5820C039;
	Wed, 26 Mar 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnYgm/F5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75B19D88B
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027622; cv=fail; b=ducGRPrGOH/+linZDOXUmtsmH2ESZiuRL0YR+lOoxV6cj1qjiJoIfKZ+UvvRp/1dDVP2TnZiIz6lH9rXBYr/EEjzO801VtFU+L4ivQN22C5QJPNFcLLr2hruf/nlqdlPhBREGEuuzQlnualJKUVQayxzIV+mQZr+xaCmDvroMEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027622; c=relaxed/simple;
	bh=W6pfvEOVXEFm0TqClSU8ajUELo021eL++xzVFdvuLRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PiZ9gskAtTZxDa3oJTgcpLoKTC1YZFFBzn7PHzHORhiIp3oSBK6gtlYm2uKLvNSHxB4wEnHIPoU/hE+VilJHgNz9P7BO8i3tz6UX1fumbIfNRKMgST1cOehp4eKRCZ0DfR579Wh87rbwnE2HlN7kxVW8XAe95SmIGhZjQ02NRio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnYgm/F5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743027621; x=1774563621;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W6pfvEOVXEFm0TqClSU8ajUELo021eL++xzVFdvuLRE=;
  b=HnYgm/F5KV48JHg/4Xqm7mxPR04gkgHsBPeDx+Dmkr9pF3pSMZxGGEby
   b/aKb/B2RzC28nY0EzqB/JDqd9VkTzIgRsG1tskLnUhn+naLkpfVVlAkZ
   PSKCm9qy01lkdSspvY2YWsUSpCg1SU1vnrDEEce+FXBHPYmAsl42r/5mW
   pNCc/othnnxFM3tvWlNAx7DPmEvMNj1BP4Gev9ZsYC7jI13rSYwV++Jwe
   D8D8EusmYGDGp6wRT3gt+F0H7J/96u4ALnEqCgrDdGbD/dCF03jG+ZTQC
   SIxmLXO7tN605vRavccssps8a+qAL8EfE9+nBT59r+mdpqi7QTklsLSC1
   g==;
X-CSE-ConnectionGUID: BCuGVqiyQM6auw9yGpnF9Q==
X-CSE-MsgGUID: VfdkRbz2TDuadINnxj/5Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="69703280"
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="69703280"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 15:20:20 -0700
X-CSE-ConnectionGUID: fBH/dED/RUe+3hgM7xS6vw==
X-CSE-MsgGUID: VGx8H8GKSLKWDLa75ESTGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,279,1736841600"; 
   d="scan'208";a="129976625"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 15:20:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 15:20:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 15:20:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 15:20:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=typ97DbcqNZJN+Qk9KJAHqmDiZ3sccgntabEhNbt/nVBUrNA56Jb2DmFKJiFQrpgKRijQ0UMDxK4VpRQQgakKFCVbOwbm+ana/V+EcywvDl4HcTrNBOPlA39FTOQh+h5aB4xx6g1X+SS3ojzZ3vnu1H6igOGeyUPQyF9yoUiRs5RGf3Sr1keQ6xNpDuOoUrvZIJ2qqYgELIrNkJngspMVJbT6jxOW/okF9v56TlSmKOb1te9DoKXqDG09+IC4gqKy1IV2hTLpLd2Kb7CF7o3zRi9wZS6B9ixLo/EnilnACp/JA54TLwu6LCoqVqV+MI0AB8o1MRy8e6UE9Ot/HRbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KaLarreZaUq2mYfkDBZMaaI/9rSzomyRV8Iu04V2sQ=;
 b=CpD72SKe5ph8oMs5GiAZqD9qwvqIhBvePXXjXbHOxydMKV0WKisxrx0xginWy04sygowZJxDsU4K1O4LMikaClO4egg5pTFprfmvsdBw/HuWmusGDE4ImvmFgCdHKN+Q8oqOgJ5/UVi+R719WZXAC88rMPpmytZbLHhAZwrKZGsbO3/Txt8cm6NN+GGImN1SjNL7srhzmJhd8UZHsH+ZMMdD1KO9uxixVJhNGV4qSQdxpiqpmQZRUaYRJAuaZZFPkN4YmbbtVOluks3oQRCBuPgZJFqCZKVUAnXkYTZnI4Grae/LxrrVvnW6RmMYM5lbjF82+WnxK4lCTknyre2bNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ2PR11MB8585.namprd11.prod.outlook.com (2603:10b6:a03:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 22:19:48 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 22:19:48 +0000
Date: Wed, 26 Mar 2025 23:19:35 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: Stanislav Fomichev <stfomichev@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<almasrymina@google.com>, <willemb@google.com>, <jdamato@fastly.com>,
	<mkarsten@uwaterloo.ca>, <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] Add xsk_rr an AF_XDP benchmark to measure
 latency
Message-ID: <Z+R9d55KFikYXGm0@boxer>
References: <20250320163523.3501305-1-skhawaja@google.com>
 <Z-Hdj_u0-IkYY4ob@mini-arch>
 <CAAywjhTzmupd=ehmve=iDtK638=6_yKyi9WOM9L=tG2CM4n=oQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhTzmupd=ehmve=iDtK638=6_yKyi9WOM9L=tG2CM4n=oQ@mail.gmail.com>
X-ClientProxiedBy: DU7P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::10) To CY5PR11MB6113.namprd11.prod.outlook.com
 (2603:10b6:930:2e::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ2PR11MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 92599cfa-904f-49a3-5695-08dd6cb45140
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTlRU1ZhUXNWbnR2SEF0ekVlcFBncHg1VGtQWER6MC9aSVp1K2RZQ0c5bk8r?=
 =?utf-8?B?WjhIL1lEemZJUE5ZSHlNRU1FYWdqVXo0MlBYZ2huaDlBZEpHdmQ3UUNaSHVr?=
 =?utf-8?B?WmdZaldZYVBJTk8vSGZvM2FzK2hQN0ROK2Uydk1lem56SEsrVjFPQmFVSjJn?=
 =?utf-8?B?TlBudFV1WnZwR05hdnZ6UU1OWitUeVBTdlJhU2w4U3ZQOXM2Wi9PTkMvR1c0?=
 =?utf-8?B?R1pkNXpFOERtNmpidXlQdVk3cVMzRFRORXpvVnBXUDFRa0ZaeGhJdVZISlF3?=
 =?utf-8?B?N0craXJvbTBFWDFURCt5YlgvSVJzUmFUdXl5UDFSQ3BCMVJZSWxEM0hTc08z?=
 =?utf-8?B?NXpaUXZEZmRtMFRhQlVmSXV3eUNOY2dqWDh2ZnU3ZkNzMTIyYUhzNCtRSGln?=
 =?utf-8?B?THBqWEJqbm15eVlEQmdWQ2pjd2lPODBDME1pQUxVT1MvMjFDV2FJazVTNHdy?=
 =?utf-8?B?dnNPclBZNk5hc20vYWkxSkpnU2o5blVkWHJUUmhUYzFWdFRQUFdYbktnejJs?=
 =?utf-8?B?cWlGOGVldyt4dVdwSG4wcDUvcGpqZC9CNW90bUI5aWtjb3BlWjMxWE94eG51?=
 =?utf-8?B?ajRSaWdSU3Q2THZqZjg1c1FOdG5PTEs0SVRKVklZT1RXR2g1UzVsY1FXc1lF?=
 =?utf-8?B?WXJHaHNHam1IeXNiMzIrN1V5d0w3bllodUpxZlo4N2xyTkRoKzc1bzJ3K2hJ?=
 =?utf-8?B?dUNoOFBtL0lBWEh6YkVqSkt2N2pOZWlibHpSaHpJSUpYcVJDOGx3bW5OQzk4?=
 =?utf-8?B?aGZFK3gvWG42K2I5azJ2TzE1V0dZcXUxQndjWXB0NWQ3K0lQY1B1VG1GWFdP?=
 =?utf-8?B?dHQ4b251SEFrQThBR1lqOUhDWXlMYzFaUURtYnhsQXpxc2NDaUpYaENGYTlB?=
 =?utf-8?B?Rmp1dHdHQ2ZsZmN0WVlVb0NJZjBURmpnMldOV1N1dFBLVW9FcGN4dERnY0pi?=
 =?utf-8?B?b0Nob2hESnIrckNQcDZSdmEwS2lxSDBwTEd3alRZN3RCVlRHMS9ZS2lPcTNH?=
 =?utf-8?B?YjY0eldYVENvdWozM0JYQXIxS0VyWEpQMFVEZzl5ZUpTZE00MDIvU3B0Q0lB?=
 =?utf-8?B?M21yckRDQ01pZUVqckZnWEx5cWtTRS8vc1I1R2UxS25ENHpmVzhuU1pVc2Rt?=
 =?utf-8?B?RTVNRlVlQW9MckY0L0ZKN1hBUkd4VzVOaWdpc3RnMFFxSEk0N01uTUFYQ2Fl?=
 =?utf-8?B?alBYM1ZENU54cWVZOGQvOWp5TDdxbjAwTUg3djhjN24xTEpoTWZOUEloRzhy?=
 =?utf-8?B?Zi94dUdTNUlCL2p3dHRoM2FKQ2dOTk00cTE5OHd5aFAzR0Q3Zmg2MnZqM1pT?=
 =?utf-8?B?VmpFM09mTGhXUXRuVHc0czNLSFNnRWJOeTg4UzA0UFFJNjVCTk5Wdk9Ka3Za?=
 =?utf-8?B?SVo1TzJhRkhTbU1ob0hTRkp3U2RkRzhuS1JjdzNNcGVEU3RSTlBxQnVKb3lK?=
 =?utf-8?B?TFdkVm1SVDRzSUhLRnByZzNrWEZCVlY4LzRKS1I4ZlpYUEtMZVl4d1VTdThs?=
 =?utf-8?B?eFM4ZkFaK0N5enlDdmxHdnBjdVlLSGJuRHNTQ1NISzhwR2tPWEpGazVFdXVh?=
 =?utf-8?B?SXhyRk1QS0pUYi90OHRHSFVtNUdqSXVWb0twRlYrWFJYUFRXL0ZEMHU0VmxM?=
 =?utf-8?B?R0RXTG5YRjVZb0hzVHhzWERCZlZJSlF3aDZZSjJrUE5wektTalVHQ1BoaFdC?=
 =?utf-8?B?WWlXWUJNQUZqVDcyeWxBd1ZFdHJJeHY1RTY2YzhxT3dDY3JXRG94cGs5eHNp?=
 =?utf-8?B?M0ZsdjF0NUVZR3ptcnJFYWtxblpyUjFkWXA3T1pwVjRzYVRnUVJtZ0ZsOVR3?=
 =?utf-8?B?UEdpTGc2Z2V6UTg4K09qSUN5UFRRZ0lDeXhpZjFHNnQveHNQYUZMTnFSK3d6?=
 =?utf-8?Q?ldjAaiFCQ/thR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9lZ3NoTEl1STdsOXVXMUxpeEQ5MU1haEpiN2FTeEVZSmF1aGVIWGFIbnd6?=
 =?utf-8?B?aUVLdmtnc2pOOG1xWGRTb3E4WXd2Sm5OUmVYR0NoS1ZxWExiNSszaWJxcmdS?=
 =?utf-8?B?SjhwdVhaMURCU3FkUW1sV0NhcnVLZU9kYXBMdmZNbWxqaTFxcGxrSjcrMUpB?=
 =?utf-8?B?anJGaWtNWDVBZDZpNi8wMk9DS2o3U0dBMUhwL1YrN1RSdlVuM0VxRnFNbzRV?=
 =?utf-8?B?QmdPK1J1REQraFd0WXQ4cE0yaWgwc25sSGFVZm9PQlFNQWlyU1hYWGRaZWV2?=
 =?utf-8?B?Um5LUE51YnRTWElaY0c1ZUhMQzFUSVJZRmhQQkhuaGRSd1lJZkhQblBrZTFB?=
 =?utf-8?B?SXBWb3NYUnBDSmRzSUVUNTYyY2ZqUDlIZGNEaVJ0aXluNlBGWVc5UkJtVUR1?=
 =?utf-8?B?TnJONDZvcHAvSDNxUWh6S3RiT2VrYlFwdi9VaU9FK1daMjhRd2diVWhQRHJV?=
 =?utf-8?B?NlJERmdob0ZFb0dkdWZCdlFjOElQWmQ5TEhQeG5wYlRqcUY3RS9HYlp3cEYw?=
 =?utf-8?B?RkdkdXppRUlXaTVNR0M1azNMVXg5VS93WCtZUDFKRVk5Rkk4Rkt3Ky9NUWNL?=
 =?utf-8?B?bGk4UFowajFHbDRkd3dzUTFBL0lCWWxUZ0tpWmpGS015RDlkeUs2MUhxZm9I?=
 =?utf-8?B?Zy9GSmxsSnV2cmR0aCs2dkJhUmQva3J1NDJGbjZnSXJ6eXdua1JUNGwzeS9C?=
 =?utf-8?B?UTVDdzNUL2drVU1TeDFwYXEwM2VNclZGM2NyRWZTd1dCNi9UWTZlNitmQ3Jh?=
 =?utf-8?B?MmlpalE0OE5xTUh4MXhzakJCbkJBY0o3Ymp0aGZMbzRIQ2o3SDJkaXNOYWFO?=
 =?utf-8?B?ZlF2WjRTbVp1NDJSRXpGd0lTcFREYlRIeE5tbmFYallKOXduYzcrZG16WlMx?=
 =?utf-8?B?bzViOXBEby9oYnFsK3A3L1JYVEpvcUtFa2phK1NXVVdwLzRId2cwVzhjaktC?=
 =?utf-8?B?YStvSnIwWUVVSDdNb21EN29uc3VOdHY1WGg2SmpzNEtidGs3cXBtem9xTXhj?=
 =?utf-8?B?TkloQkxVekVCeTU0SkdaMTFrWXFvME5nTURTT01oQSsyK2lTbGJEbEp0ZjlW?=
 =?utf-8?B?dWQ5ODJkQyswUmQ3SzRiN0NJYVlKTE1NSUo4SzVsMkhkTVlqSFpuaVhlZ0pH?=
 =?utf-8?B?YkJkV2Q3OStxRmphTUQyMHlFMmNOUDQ2bFZWeGRzbzc0VVhHUVMyMlhtZTlM?=
 =?utf-8?B?WHYvR2ZDTUsvQldQSlVIWURHMStmYVNqMUJpUmVRUVRhREIrd05GaTIwSTln?=
 =?utf-8?B?bzNYT2oyellZSVZBR0xuWVc1RitIZitRTG1KYVlxTUFDMlowT1JsVU1tYVk0?=
 =?utf-8?B?MjFRbDdqZlJwdW1aclBVaWM5Q2J1dC9nN05hWHBrRllLQ2xJc0FHUzlqdXgx?=
 =?utf-8?B?d2pDeVBxRTN2U1pYRWhoS1NieXFPbmh2dkM0bXNmSzJjd25NRkZpYnF5clNR?=
 =?utf-8?B?NlIyNDU3NkZmTnZ1WVpld0oxTlBsVkk1T21raFpUNlRaam5TdElYM1daRFhE?=
 =?utf-8?B?cnVSaGdNamJRWjArN2llQlRzUWQ0YitJSC8zNUlLTzRYaGZadjZpWEZtWWVk?=
 =?utf-8?B?NjNkVzBWVUtlMGc5THJkSUswcHVSQXE0cWxMemxML1YwVHo4VFBkK2wxWDhU?=
 =?utf-8?B?S3o0cUpKM3BxSjQ4c25YNEo3bWRyYTVRMmhablc3bTZpR2ZZYzQvZ3A1ZVdq?=
 =?utf-8?B?L1hJZzcrc21mSVZPd0xuaC9haHVDaG9mZnliaFlvK1NORVV1TFFKOHBOSnVY?=
 =?utf-8?B?Zjc3dDcwYnZMWkpFRmpXZzViTVRhelp2WDhiTmI5Vjd3ZjJlcXExNjhnY01h?=
 =?utf-8?B?dkFkSlViak9BcEJ2bmxKVUZtZXQ5SUdKTTUwY3pmK2gvclFuQlN5MVpGUUk2?=
 =?utf-8?B?YktaaDdTTjV1TWhNY3ZkRDBESXQ0TStVUkQvWDJjMG83UlZpMUpGWHpzRWxq?=
 =?utf-8?B?ZytFVDl1ZUJuMUJkZmRUeENhbklQNDFlMDFtNUJLV1VSU2RyNlpIeHA2QlY2?=
 =?utf-8?B?eTZBRTNFVURtbUtkNnBjNU1VY1ZsbFZ4VmRDUElGL2gyRXRoUElVb29YdDJF?=
 =?utf-8?B?MEVWd3Q2TE9KZEZtVllYcU5Vb1F2U2liU3ZRczg5cVJ0RU82YkpCQndyZzhn?=
 =?utf-8?B?OTA0a2FTdS91Sm4va1BtVzVZOTdiMEdBOVhOa2l6SHFGUnQrVCt4TmdHT2x0?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92599cfa-904f-49a3-5695-08dd6cb45140
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6113.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 22:19:48.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4FMvKqZS16CYYqlRn/9y7a1mqLXvb9ros7OkwBoeNGueocxZ00Pa0P5AvU3rhL5wjxb/jHa2pFjfOzHJEbLMR1q/gMivOCdj7o6tBe10/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8585
X-OriginatorOrg: intel.com

On Wed, Mar 26, 2025 at 02:12:17PM -0700, Samiullah Khawaja wrote:
> On Mon, Mar 24, 2025 at 3:32 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 03/20, Samiullah Khawaja wrote:
> > > Note: This is a benchmarking tool that is used for experiments in the
> > > upcoming v4 of Napi threaded busypoll series. Not intended to be merged.
> > >
> > > xsk_rr is a benchmarking tool to measure latency using AF_XDP between
> > > two nodes. The benchmark can be run with different arguments to simulate
> > > traffic:
> >
> > We might want to have something like this, but later, once we have NIPA
> > runners for vendor NICs. The test would have to live in
> > tools/testing/selftests/drivers/net/hw, have a python executor to run
> I agree. I can send another version of this for that directory later.
> > it on host/peer and expose the data in some ingestible/trackable format
> > (so we can mark it red/green depending on the range on the dashboard).
> >
> > But I might be wrong, having flaky (most of them are) perf tests might not
> > be super valuable.
> 

As you said it's benchmarking tool so I feel like it should land in
https://github.com/xdp-project/bpf-examples where we have xdpsock that
have been previously used for benchmarks.

