Return-Path: <netdev+bounces-157330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD2DA09FC5
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B5D3A8BDE
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC9C8CE;
	Sat, 11 Jan 2025 00:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1g6Ex6K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A2139D
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556813; cv=fail; b=Xi/olz74jMDxjY8MUqyD38tiRrfoHIgEi7qtUO3fx2qBGniPtditW2OleXcXXnJwtGtmw/9CiJWqG0FzBu8InmmNZ4tk2j3yX5hh4719ceo/QdZCuG0FExFCku6St1DnN+6jA0Z//SWjMZOD6pJfvDDhuxc8MXUWPpLdJFugzIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556813; c=relaxed/simple;
	bh=N0hfA0am74YnbTWf00PDJVt4tCd1bhvcAyWYvGa4u7E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VHnysIjTMP3zlA3ASDJfDp9FnE+10/Z/JCn/rvycakBXEfoZl8ZsE4W3rl/CcRB0Qf9JfISR2xzg3HA1VxJNSbfa+lPrIDASdO2OYiIlgeEsBJw0mxCOF89BJbYlICD1kg8I6RA52NrP8UBAFWIRpsJ0oot2pb+XGV8vzYo8e58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1g6Ex6K; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736556812; x=1768092812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N0hfA0am74YnbTWf00PDJVt4tCd1bhvcAyWYvGa4u7E=;
  b=k1g6Ex6KyibTGJQz3U7Xhmt9uKB4ibfM9rtAY7ZYF7EQTuYOF1PbTpxj
   aZBa9gJjM4Q6pqhuzDlIJlRNeCPKx1ADhYIs3Lsj4R0YrcxZ6su850ED0
   qrabUqtNRT31txLyLjrWKxhRwdvWcq8QL64nqg3IAixtkfswFVHnu/QBE
   BpygLbLR5+UaHlpMODTQZE7e7aPTpVJBJuxXbsa5WUO3eXDp40xAmQFIV
   6vwmumF1sSVm+N9cS87XClVolEafqYzFi2Itm7M/3tcONarXf0eZqcJ8L
   z4c29LNZqhE0a2pcRYtoP1EtKFZvd4HBU/hxq+Dz/g683RhGvL1siqURp
   w==;
X-CSE-ConnectionGUID: exU3VORtToqmI+cYNTHmXw==
X-CSE-MsgGUID: GQ5+w1b+QuuetR3MXaevoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="37026026"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="37026026"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 16:53:31 -0800
X-CSE-ConnectionGUID: WB6NZ0P+RDOHgPEBc1b1tQ==
X-CSE-MsgGUID: Am9mNvaiRrix/7U7BlDuCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="104398770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 16:53:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 16:53:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 16:53:29 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 16:53:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSAGy+pWQ0OlrpwXlcAu1pIyVsVkNOCEmn0eME6qEtQ83CnuouWbSluFlkAE7d/IyaKLBDPmWkZoPyDfP6NGF8Z9tqdKPQJuBoO/W2rDswGpa5rvvGj2XQUt2Q9Z1fdnzlcupBtcG+PNvODlTvOt8vJapI3w/Xe9q+XZpmfZGQ1C+pHEuTeqdy2J+9/+40gP1jrqJfFNJFZ+iJp6fLQFultyvbDxzgmTz977Oc/qHd2NLBTE13YRuj7GCuxEI2lgMZ514KCqM2r2Mh9EoBOWmwVZOVdxzxG23KF9Xtgl3GVJmFK6wxREKfFuhKzC3Hp8ZV2Wxy2qyzRGSt7nzAlp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QAUTA5wJQ4qGKdDX5HgV8qbugaskFRWz4/oHBMNFDE=;
 b=u0dQYSTVF3CA4X/7Uz9Q8nWqPY0jV0iTAaMy8JgehgXO438dVCBuZf9Okb0m4282Iu1R45FK5+V73Nb4ORTDCVFpafGMa8ma3BHX3XrstjqzIvsW00bOF70K0pN3EQjRa+GiRSdmHtrl7JS3TlEEL5vR4/Gtcey0dVk2Mlzk8OTDvOR1WTBhqAlokqKNoT3etglL70pfIQbRIIH/ymb2km5J8gY1wurZSgfpnMKWfbeHRGU7a2Az6Fxt9xdkjUQ+ry1HNaFX28oB58peDDqOHRbZwoEknh+RQjvwKmmfm7rQMvfOxyVQohZwHBj93pkU5UfjGnKataD9AJq64ORa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Sat, 11 Jan
 2025 00:53:26 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Sat, 11 Jan 2025
 00:53:25 +0000
Message-ID: <5335da20-7c44-4178-b30b-779500b5c0bb@intel.com>
Date: Fri, 10 Jan 2025 16:53:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] r8169: remove redundant hwmon support
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
 <c7e6dbfb-b5ae-4953-ad35-899341083723@intel.com>
 <b0d6a4d5-f8ab-4d6d-9b47-e076c5402865@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <b0d6a4d5-f8ab-4d6d-9b47-e076c5402865@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9c0f95-7772-4c0c-087d-08dd31da5b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0lZeXBUc0JtVGMraDhjL1BiRWE1S3R3MERkRkw1ZnRmRlo5MUltQXphS0ZG?=
 =?utf-8?B?bkNhNjFqcHJ1cnBvcW1oL2NzZ0hReDRHclUrQlpKTEIrWklOT1lnTlorbWFI?=
 =?utf-8?B?YnJMNjk0eFdBeWQwM3RuUGw2cWFmL0s5L2R5UTM1aU5obVpWcUorUHphd0RB?=
 =?utf-8?B?MXVXMFRJd0lXbktkTSs5eVFVWmg0Sk52bXI0SllXV3RVTi9xVkNEd1cvbTd3?=
 =?utf-8?B?Nnk5eXFpRWszeUJqaTIrT3RIdng1WTd1WFN5ZFR5ZG9nSFVuOVp6NEZlN1ox?=
 =?utf-8?B?WGlZQTluNkdna2thNFk0YS9PVkRZdVpZQVJJNzZVYlNmbWhUMkVjYUNFV2E4?=
 =?utf-8?B?Y3NTTzJZSGJwcnBmVG9lTEVSdUVTc1hIVGRxM0w0dG5TTDl2ZjI3V1ZmTmVi?=
 =?utf-8?B?S2NJL1dWREtHUkFBVXJZRlE3bUdsc0prUDI3RFc4dGFUblE5eGxPOU5acDV4?=
 =?utf-8?B?a1ZURVhyRUdvemhsZmZoemttYmRGem11bXRtaWFUdkN0Ky9LMVVOSCtSRll3?=
 =?utf-8?B?dVpNRzBaM1h1SlYrSkhFSEhpRDZrL1R1M2hKa0YySGFUalB5anRScWtOV1Ri?=
 =?utf-8?B?WVlVQjlkbE5iZkdFTWlyVmJrNFY5OGUybHFBeHJpMms0VEJhZHRWcHZuYWNp?=
 =?utf-8?B?OGJ1Zlk2U2lFQVBnMkRyeThQY0EvL0I5b0w1dTQ0MXBKL01zbnJ0bkhRUTU0?=
 =?utf-8?B?L0s5WFF5aWVDTStuQldBbGdFaVAwbUlwaG5teWUrK2E5a0NSbHBLbk05OW55?=
 =?utf-8?B?czA2a0x2eC9VRlBqZ1oxZStDWWRqRXhDci9aaEliN1lHWGRzNVYvZjlJalFY?=
 =?utf-8?B?SEhjMUhqaGRDeWY5OWpMdHhlbDN4K3pwZmJRd0w2elFIOXJhNklVL0U2TWRE?=
 =?utf-8?B?YW9YYTBZZ1JkbmRBSTZOaTM3VlNzeHdyQ2lza2xrU1ZYeE9BQWhENnN3Nzkx?=
 =?utf-8?B?T2FSQUxHM3NRZUpQK25PTzRuWjJlKzlnYzZaTTZaMGtmNjBBUG5qOXMySGVH?=
 =?utf-8?B?ZTlxYUtnVHc0QXhkaFVZcHpienF3ZFhVbGJaNGFXeU9YL0FpeXMrQy8rNUpI?=
 =?utf-8?B?SEQyZG5oaUdGZm5QWTNhVjh0NW91YnpEWHUxZ2t3Uld5TzdheVBjNXpwZ3dF?=
 =?utf-8?B?ckJFOEl3ZDY3b3RIa25zR2pTUVJZbVpFU0xQdVpaUHhlUzdZZ0xFeVdjUTcr?=
 =?utf-8?B?OWJ5Z25WRGtwd0JaKzZhbkpaTTA0TUFnN1piMm13eW1rQmoyNEpkaHJWREY2?=
 =?utf-8?B?VEhTeFlYbzNMWW04VU1VWmlwQVN5VldTUitoMWlKSVlVVjBYTWxCak44bGhN?=
 =?utf-8?B?SXFZVGIrLzBwZXc4Qk0xMlhoekFGdWljd0l0ZW16K0U1b1dsMlBZdFI2bjlU?=
 =?utf-8?B?RzJWdysvZTcrMTVBTEc0M2NCWXhhdEtJSHp3MldUa2N0akZiZW8vL2NsLzVr?=
 =?utf-8?B?NVVxbjE0NzRrZFlBSVhreEYzbmdxSnZsc1M4Vm1BOTd3N2NRUlcwNDNWNm0y?=
 =?utf-8?B?NTE1dUFYOWp6N0ZMZ0s3QktsYnhOeUh6NTRYS0lPT3lVNmsvbWJMREdONkFH?=
 =?utf-8?B?K0FnVUplK1RXYTRSSVlYZ3k5S2tOb0JyU2hPNEFEYjJCT1NQL045WDlLWU5G?=
 =?utf-8?B?SkdDa0JQQnF0SUkzcjlYcWY1SlBtZnR3RUlwM3VJRUFJSVhobkE3bmQxekp2?=
 =?utf-8?B?ZlVMSHd6KzVscG9MWkpYdG14eFVLUzRXZEtvNnVsdXZRTlpiOUkxdGQzT1Q0?=
 =?utf-8?B?T3ErenVPWVJhcDQ1bXozdEZUOERlS00xQ24yZ0hUcEl5RTZ4a0ZFelFJa3pa?=
 =?utf-8?B?Nk5LUXZJbGhKaE9JT2FLcklLamhBLzhWRmNiaFR1enlWOWo0aUZmdEg5bTZM?=
 =?utf-8?Q?SCGMgi9VHsQsT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rzc3U3JzMFFncWNqTGhMOVZsOXNudWxpS2I1SmF6OTdLWWFNU3hPeEFrSEFY?=
 =?utf-8?B?Z3ZMN0JQN2R3WU1odHZmOGRRdHltUTZHNGpjbVllaDVMVTlFWW13aVM1bDhW?=
 =?utf-8?B?YTNjS05VdmFld2toTUVmL2J4blh6VjRIWVY0ZHc0WXNPMFR2RTBScjlXdDB3?=
 =?utf-8?B?eU91ZU45bWdFMWpKV0UrQ3FIU3luUERpY3dEb2VsSFdMY2VUZitPWCtBTmth?=
 =?utf-8?B?SlJheDNjSlFNMkJZSWtONitZVi9GNGlVWE9OVnNoUWV5TTRhSHBvak45WEdt?=
 =?utf-8?B?K1VvSzJHZUZDbWhQUW0rSnV2UkN0ZUZzdmRDZy9PRUhac3lhRnY4dWhuZGV3?=
 =?utf-8?B?Q3Y5VzZ2aFViNUFvMi9ad0tqM0MwRXRwMTBaY3JEamllUGphZUIrUGVNRGoz?=
 =?utf-8?B?OWk3UW1tUkRTWnZ1V3hxWGZFdWx3RzF1NHIvdTZ2UjV6SlVWS0M1dDJqM0pG?=
 =?utf-8?B?bVROM09GY2NrdGJKdzdHNms3ZmQ3UWt0NzdNd2poK2ZiMG41L0xtSTRyek5w?=
 =?utf-8?B?bnlkVWVaOFJVMXRsVUhvd1VmSU8xVEJ5SnFGL29DeWtZSHRmTzRHeWdoUXhr?=
 =?utf-8?B?ck9oWkRVZUlmdjN4a3ViblZ6OXc1SVh2NE04c29JY3E5RjJmYjg4YnNBUklS?=
 =?utf-8?B?UkRYZXFPdCtMeFBOZ2MxK0w3cnZQNzN4dG1KeVZ6SURRcUFlSFVKUlZNTnFK?=
 =?utf-8?B?RXZ1dFR1S0tFcVVUQ0lNMzlNd2FueTYrYVMwRjRYSzQ4U1dneEVVNjluVUgx?=
 =?utf-8?B?elA1TEFqSm1reGlWYkNqL3JPcGI2djBXWTRUTFcrQXlYMXlRVDRuRUx2ZE85?=
 =?utf-8?B?Y2czdnNxY3plMWNKaHRzNVVJY3BUeFQ0aWl0QjVHSWhQckcxM3ZsVjU0VmRJ?=
 =?utf-8?B?aFZmcThYaEpaaHJoSlVIVktZRWE2SXJuR1h6ZzNZTkExZUF0bHFadkI1clNs?=
 =?utf-8?B?c29JRUtiMUt2YjlDTzdGclg0NjBWZTFzMzJPOTgyTU1xQnF2R3lZaDlqdDQ5?=
 =?utf-8?B?S3hYSnpuemx1dDByUU81VDFWRGthazJrbWtjTkhXNGVvVm5Tcjl2L0xoc01B?=
 =?utf-8?B?T3FhVU1GK3krYlV1Ykc3dlJOVCtmeU9vdTFDQUhtME9tb050Sm9BVkFUanNP?=
 =?utf-8?B?U0htSmNqSEFPYlFUeDFWc3QrTmN3cmJYaEtSZzBFMzIwcm9HNm9VbWNLTWVv?=
 =?utf-8?B?QWUzZWJkWG05QWgyMFFtZDdpMFBNQzRHNWNOVXh4YmllZ0pjZUs2dS91MjlJ?=
 =?utf-8?B?a1Y4TzJSYWpnVW1mdHFlSGV5eTczdmpQQi9FSkpOcGQzR3g2YUpoZnRvbGZI?=
 =?utf-8?B?a09oOGVWaTR3RnF2QnpzSCtVR1pIZ0QxcGhxY2hRdmZJTnhDNUtVZVl5dWFx?=
 =?utf-8?B?NnZ3YnAwcFdLYXNvL1UxbFlEMTE0Sm5QVW1qY2NtZmlwQU1BbTA2T29BQ0ts?=
 =?utf-8?B?WE00blZkc3piQ3l0RGV5Y1RURU45WHN1anJNbWM1QWt1eUNURXk3YlVLZ1lT?=
 =?utf-8?B?bnlPenptN3k0akMvcWdDak5FYjFIVXBFa0dVYkpkcklPUUJGNnVJa2FqSlY0?=
 =?utf-8?B?LzI0WnZZVzR2aVBsSnVNNmJ0OUI2YkdOTWM2eGttRHVlSU53Ri8zdFZ3OWFl?=
 =?utf-8?B?YWMrbVRLcmc5MGxWcEw3bUJMZG55UDIrKzYxeUhqRG96bGt3TkYyTERaOHFD?=
 =?utf-8?B?bmJOWDk0YWV6ZUYrN0s5eUtvS2NJQ3huTnV2aUxVUkorZWczVmEvR3BLQXdT?=
 =?utf-8?B?NTJ2UHdheHN1cEpHME5SSml3SDBpVmtwWEdFUUhyTUlMNkczaU02YW01alF2?=
 =?utf-8?B?bE9GVU5vZEUxL0VQbGJpTElJcmdkMXAzMjRjcjF2VnpqejUvZVI3OVMwL2V5?=
 =?utf-8?B?SnVyOEFoQ3pOb0NxRnNBMkFyZUVIakEzR29zNitodWtVVE1xOGtDM1R0QWtV?=
 =?utf-8?B?OHpVcnBjRi90cENMZ2wyN3VvM0RoUCtPMlNsaVBWWk5vamRVQW0rN0FpRzlO?=
 =?utf-8?B?Sk9qMy9WYTVRem9tOUQ0RVVDT1RnRi83amtWQjNMK04rYW42WHJDQ3VKUWlm?=
 =?utf-8?B?TG8vM0t5RWR6Q0RIYksxbUsraC9BQmg3a2c4Ym5JTGwxTTIyR3NRSlBuUEY3?=
 =?utf-8?B?TWs4UFNON2tzQndQUUZycEJRYmNHOEZWMXc2TVVuMUN6UXlXaFErcFpKc3NS?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9c0f95-7772-4c0c-087d-08dd31da5b16
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 00:53:25.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUo1byX2KMC7sSS5gMx7FeBwXmCsItPPJ7ozU0c1JgHnz3mbIlP2ASTUamDb2ZT+mvwUuLKBkDpxwH4+sPDCmTycQxXDrMzF79kfdnQhK0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-OriginatorOrg: intel.com



On 1/9/2025 10:45 PM, Heiner Kallweit wrote:
> On 10.01.2025 02:14, Jacob Keller wrote:
>>
>>
>> On 1/9/2025 2:43 PM, Heiner Kallweit wrote:
>>> The temperature sensor is actually part of the integrated PHY and available
>>> also on the standalone versions of the PHY. Therefore hwmon support will
>>> be added to the Realtek PHY driver and can be removed here.
>>>
>>> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>
>> Can you explain what user-facing issues this fixes? Do we get conflicts
>> when multiple hwmon sensors are registered? I'm not sure this counts as
>> a 'net' fix, unless we can identify the user-facing behavior that is
>> problematic?
> 
> The same sensor would be exposed twice, by the MAC and the PHY driver.
> Support in the MAC driver was added for 6.13, so it's still in the rc
> version only and not yet part of a released kernel version.
> 

I guess I'm failing to understand what the user repercussions of having
multiple sensors would be?

I suppose that it is confusing and could lead to issues when userspace
is checking or controlling the sensor, and fixing this via net before it
makes it into a full release is good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

