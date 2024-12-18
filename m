Return-Path: <netdev+bounces-153010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8C9F6921
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4241639F1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838A1C2304;
	Wed, 18 Dec 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAGFB40d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA21C5CC9;
	Wed, 18 Dec 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533393; cv=fail; b=Jfu6T8GD8UESTWDXJMw5UTfFV+k/W70rKALt6+bAUh0amhZFukcM6uF4OD7sXevhpkIc38O/9qvK6SvOtbkOYtlpcwaFUBv1BOVD3I1/UVmYefsdCXZ8uLhbIVXE4x73ZJgvT7k4IEz5liFCJO/bu/AhUCmQt45nNmiLgFi4P38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533393; c=relaxed/simple;
	bh=RqvYQki4Rb4lhQbXG3AGYskCSeSIzg/a7KJZTXtaYw4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqhnGfVTx9pY9XiinkfZUxE02/k+25vPGQSbkYHAm1LIxeDhJbcApiQHzfowUrdRv+OAsWqymKeAFFGnxiujldRHrM1xBWjFX45GvBwM86YcZOuVoS8qJvd8arkMk6EuZF2LlkOElI8meT9M2FreN/VVCMzgOsVd/Wbm0YSPUwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAGFB40d; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734533391; x=1766069391;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=RqvYQki4Rb4lhQbXG3AGYskCSeSIzg/a7KJZTXtaYw4=;
  b=lAGFB40dSzDkX3pewj/tLsZZ4RzJzOTYelxtU1aYcPLKHbcV0qLUXRoJ
   xkeNFkFxf5yOAh9574AZD7s4HgDTDijwDYFbZGHBD4c4qiNJ4AVNHS/nD
   cJGC0LmqbVxXPIaLhFBhBTImEgwj4jYj2FtEB8eQho0IZ/E1z3th4uqtL
   3rn0CCJUq9/9iAw3V3qvJ/Zb31Zys3rFOIRegrz5VvAvEo37OeiexzdNB
   rzyHS+FTGyoUC0WTGBOxWg5VInnBWWqpOtdsML8112Fe4lSoxKGtb7YMG
   2jcMnpWc6v4wHhJEABlTDjxuCFuGzFU0PFhpgp0DX21eBHggsfBP3Odqg
   Q==;
X-CSE-ConnectionGUID: Ifo/VLspQ9O+Cuu2fR/ygw==
X-CSE-MsgGUID: yH80X8INQFG4Xwbd8iLQ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22599197"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22599197"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:49:50 -0800
X-CSE-ConnectionGUID: AneW5OB/R8C8iXo9TczW9Q==
X-CSE-MsgGUID: NtnSaYlDRxWYWaASRvfeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102976477"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 06:49:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 06:49:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 06:49:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 06:49:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1NmLuWcXMEtq/1vU1AV+x5rCC3c+h2HPjEk0aRosauq+mubcY3+RD8Xh0VeZ1QuDptj2/1BkMhJR08Y+NLoT6FRb2wsKCeFyU/jhnvN6ky85qJc02tJD2Bs4Nw1fRYvXabNHm6QomocrtAzRfgK/lHsDSHOWjPwsZ24nKLB986Vz0oQzRqCCOeXw+RK3Xe8rpXXMF/jAicGGsya/55BpLKmZJMXmgi30F+AshuSTwbpT8nnuiPQaSDH93FtYaUvC+/9kOkaG9qxtiBArNCnBX8/RJtryP5RPu4Zojn4hULb46iqv4LXts9/9XcCuo6nBmBCMmz+6sniTK63EsKe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwz0sq5BIixk6YyRmz7L28M7T1z4/6478idEipeI6iU=;
 b=koEVHc+GTQn4ToWV0HhwxmZ/WiNW0B+K2EBL6QitgSgM4qhRYURXn/Cfc2QkCZi7MUM6euEZeSdQPn/6TsectmdmMZZYyP7RzfXcrNfd2URaH3Nau+nzDIA66uDBWyIFx3/PaY2nwOw8FOXhrB8o3CdECyFVc/eG34T9yO50Vn/MvY8WbCraKMSEqiMldVQW56RMMAmp24CGHvkqNkW5FkpxsUf8hTn2FxE/fwRr2w13cwcCRLPPv2YDuz7XI3PJy7QMKy0FsMGd/cs8Y8gxPhPfyZjM8r9mIGKnWvIcJBDt2wu6AzycfOdoT2b2P1J6fo/oHsFp0NjsuH6qYztm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB7296.namprd11.prod.outlook.com (2603:10b6:208:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 18 Dec
 2024 14:49:44 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 14:49:43 +0000
Date: Wed, 18 Dec 2024 15:49:32 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: Shinas Rasheed <srasheed@marvell.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, "Sathesh B
 Edara" <sedara@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
	"thaller@redhat.com" <thaller@redhat.com>, "wizhao@redhat.com"
	<wizhao@redhat.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"konguyen@redhat.com" <konguyen@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "einstein.xue@synaxg.com" <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Abhijit
 Ayarekar <aayarekar@marvell.com>, Satananda Burla <sburla@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 1/4] octeon_ep: fix race conditions
 in ndo_get_stats64
Message-ID: <Z2Lg/LDjrB2hDJSO@lzaremba-mobl.ger.corp.intel.com>
References: <20241216075842.2394606-1-srasheed@marvell.com>
 <20241216075842.2394606-2-srasheed@marvell.com>
 <Z2A5dHOGhwCQ1KBI@lzaremba-mobl.ger.corp.intel.com>
 <Z2A9UmjW7rnCGiEu@lzaremba-mobl.ger.corp.intel.com>
 <BY3PR18MB4721712299EAB0ED37CCEEEFC73B2@BY3PR18MB4721.namprd18.prod.outlook.com>
 <Z2GvpzRDSTjkzFxO@lzaremba-mobl.ger.corp.intel.com>
 <CO1PR18MB472973A60723E9417FE1BB87C7042@CO1PR18MB4729.namprd18.prod.outlook.com>
 <Z2LNOLxy0H1JoTnd@lzaremba-mobl.ger.corp.intel.com>
 <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJXNYRNn7N9AHKr0jECxn0Lh6_CtKG7kk9xjqhbVjjkjQ@mail.gmail.com>
X-ClientProxiedBy: VI1PR0102CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ce2f0e-6a76-4ed1-9100-08dd1f733570
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjFmallSVmtrbHZWaVI5OExHcGhScnE0aUlHVk14dlo4UWJmMGhEdUpuVHlm?=
 =?utf-8?B?MUpFTjlSdWphNVZXbVh0dTNQbHhXUHdoZS8wUzZUWitrNTAzUTZZaXhKbDIv?=
 =?utf-8?B?NStWeFJpVHIrbCtGVzB0eDdyejlGcDdpR0NyV2kvcjhuZ1h3Q3J2YXRLeXNK?=
 =?utf-8?B?QmFQR0NYay82Y2FLdUtwbkNHSmNSb0I4bjJuNGxmWjl1cXc1OGRDWWwrT3BH?=
 =?utf-8?B?SGdZYjIwVEI1blkwcjEwTVI0MGxiSG1JKzBoM2kxOTlUSFFaTXJFaDZSWHNz?=
 =?utf-8?B?RHB1cUg5L3AwMFFodmFnR3VDblVFcG5SMFNsZHJUNHNTZVpyOTlqbDhFWCtS?=
 =?utf-8?B?U0xybm5lUGNaRUVPRmpzWHJ6c1Ywc2d6WHAvOUU2NFhieDk5WjdjWTFvaGN4?=
 =?utf-8?B?ZXNSQ0lUbDVTN05OWTRBQjhXL3NhLzZER21uRmttTlp5Z3lNcjVjeVYyUjlM?=
 =?utf-8?B?ZC9PaFlXZUk1ckRzbUJldzROK0o4a0h0aEhpL01oTnJwQ2ZjWkhmYkhpdWEw?=
 =?utf-8?B?dGNESjVmSVIrS1N2OHdGNnB0ZE1tc2xUWGRQS1Z0Q2J5ZEZBb1A5djRiZGI4?=
 =?utf-8?B?dHBadDJVWmtJWmlpOGxjUjdaRVdqZ1FCelAvMENPaWlsSDJwbkZLa3pqMGpU?=
 =?utf-8?B?eVRYY2piaU9nV2VjS2RvOVlMcldndTRkWGZnZ1U3RlBWcDQ2WlVRVHdSUzlu?=
 =?utf-8?B?RitDTVB1cVFEV0o3WG9xOFhXemlOZnF1MDcrY0lyc09JOFFZUEYwdjNzaGE0?=
 =?utf-8?B?NnhnTVdXazJtS0V3WkR3OUVjTGF3Z3g5czhKZEdHTitXN1FmOWNrN00wWXVV?=
 =?utf-8?B?Q2tvTjNxV1FNQWpVeWdhUnlMYklHMFBPTjRPalZJVWJEaVJTRzNYc1hnY1Va?=
 =?utf-8?B?cjJNd1l6Tm9FblYxU3pwYmpDL3BaeStVVUxweG5CNTNtQ1pDVUJyYXRpSHpp?=
 =?utf-8?B?NFNkbkplWUxJOURZOElld3JBZUhxMlN0NTVEU1VjckVmWTk0WnczZ2p3VjR4?=
 =?utf-8?B?c3dmaFFTWGtLSVArNWRBc2ZlRCtGWnJtYlJpSFhqTW1LUTNLYnEwM0R3S1BL?=
 =?utf-8?B?S0l0eGtDSU1aeGxCb0JURXBwQjdHU0UxNkNKZGMyN0JWRUwwVmZnVjFXc21l?=
 =?utf-8?B?dDY5dC9vSFZyakN6dTRSaVA3VkVVRTJHcS9SN2VNV0FwZExkbXdCUCtiNmV6?=
 =?utf-8?B?bTFWU05zQVJzUDhLSUZYVGdPcVhuV3BwdkR0eS9DODZlRzIwUDZVbTMycEc5?=
 =?utf-8?B?WDUxSkZvL2lzeC9zSUtBZWdrdmV3TkEvYko3RjBKRlh2dXp6dE5hakp3ZnZ2?=
 =?utf-8?B?UGRXamF1S2IxNlBRTG9XalJHN1JhMUljaFIxYTA1ZFNVVFRldmxycFo2eG1B?=
 =?utf-8?B?SlpZa095b2tkaUNaRm9WV0t2RTJ3V0crTjY1N1lYbjlzTGZVZThhSnRnTnRM?=
 =?utf-8?B?Y25Ob1lnUFZrTkkxVjZxN1U4dllsc2I4VEo2bFkwTS9UZ3hkQzBPbUNHeUxF?=
 =?utf-8?B?Q1pTTTU2aDhzUjVxQzNwSHBxU1d0Z29nOTE3NzBlbHdWcGJ6NEQvMXZScGdO?=
 =?utf-8?B?RXA4WDhHKzFnNmxqTVhmSVNDcVBnY2l2eGRWMFgyZWYrQWpGdyt2d1Q3REho?=
 =?utf-8?B?TXpmZks5QkkrTElyamxSa00rWWdWTkMzMGEzRTVwR3dtU1Iwdm1mWFljeTZm?=
 =?utf-8?B?alpmbjhpSW9LdGdwN3N2Tmhmc3ZOb0Q0Q3JGV0s5VE9DbGhUbVkrbTNVWi83?=
 =?utf-8?B?SDlaMEYwR3UyN05qeFBrNEQ2b1ZJSG9KZjdzMWZUcWJ6bGw5SUZxemJBRlNE?=
 =?utf-8?B?NEpWYTlMWUdoNmNrb1dwRkVLK1N3U041RlJLdFUzeUhaOG43aW5iMHcxN05t?=
 =?utf-8?Q?p2O3yUIioMku3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUhkK3ZxZ3UvajNHaVFEckcyYWd5YlNjY01ER3BpdTAzVjJ4WkorYmkzMXNq?=
 =?utf-8?B?eFRnMmcvdnc5eHI3cHRQUXlrNkVvbVlVU3lPRUJJMkQ4UkExV0ZJSEs2K3NM?=
 =?utf-8?B?bkNGNEgrWmpYMG1XMXNpcysvK0xWRzNBY2VRaHR5TGZYeCtHMFhLSHFvcnF5?=
 =?utf-8?B?azVPVHp5MWwzeUJmM0dUa0Zvak0veVVKaXFVL294aWZtU3pKWWVZMnB5UjMw?=
 =?utf-8?B?VW91aVJ1ck52QW1qQkVjVlRGS29NMXlBM2NCSUoxM2I1OFRSeE9vVjlYdmZE?=
 =?utf-8?B?WVhhY2Z3M3JtTmtqZTg1ajd6WVpKTHBJMXZJclVZZEVoajViYkJFSWZwVlhl?=
 =?utf-8?B?NUFMOW5RNFlKYWExN2ZodjMvWk9wYkxFYUg0bVU4Z2JKM21yNkxFWlF2cVAw?=
 =?utf-8?B?d0dtaHZST2FlSkpZOWpobU9Id2RIQzBuRWV2RVgvVzZlMDNuaThhZTM3QnB3?=
 =?utf-8?B?eXNUSVY4bkFTTkROK3AwYnpZNHJ1d1ZQbGFHRzdqTmIrNElzQm0vMDJYWWUy?=
 =?utf-8?B?K2t2QVpoWkRrTWtyREVPV1NrRDBJWjlOYTlaTmJDd1VGdkEwaVNRTjd4OUlG?=
 =?utf-8?B?VDU2LzV3czgyK3N2WjlhRHJ6TFlxNHoybUdyOFhkV2tHY0grdFpqUWJyTWJo?=
 =?utf-8?B?aThzSmF2bUJHbTgvaGFLTnhJdjBYVkxYTkx2WGVuNVFiandlbE1hbDdOSCs1?=
 =?utf-8?B?WXpSQU1FSm5ZU24xR1lxdWhqVnk0RUhHSElHc1NiMHJLc2pYYm9uQUVHVWRN?=
 =?utf-8?B?TVY0V3BvaU9xQkt0TUVFazNNdGRCTUlkYnBpRjNaTGF3YlhkTkV2L3dJZUll?=
 =?utf-8?B?TkE1bEJJa3JxbTdzaHQ1TlpnR1h5TUFsQ1BTelo2dmFlRjdXNWtyODEveVZH?=
 =?utf-8?B?Y3ZvdWoyQ0dmc2xacGlHUFpYL200SFd6d3VXMDhaSWdPR0I5ZHJJaGxnM1cv?=
 =?utf-8?B?MDlhdXVXMDYyQzlwazJCdTlJZmtuUnhLdjIwMXFrK082K1oybWJIOHQzMGIv?=
 =?utf-8?B?Vms2ejh3MzRQbUdvYm1aVUFKRmJQN3VXNWpRT1Iya1NmYnFoaWg0ZmwwanpT?=
 =?utf-8?B?TXl0cTRMT1BpSXhjOHpnQWRlQWp1OVFCRmkvMnhyNmRFdVp4TDlBY3RsQnRi?=
 =?utf-8?B?UGtpQkJzbDhteWhmWHJvbE1lc0NnenNkWFQvMVltVjhmc0syMUFXSXJ3N2I0?=
 =?utf-8?B?d1dYK1g2VjVDUnlmM0o5V3FUdmc5ZWFUNzIrSExxUVZuRnloQkhnMy9xY3BV?=
 =?utf-8?B?UjBSWS9jeG54NkFEM01WZXZWZGp5YW1JQkExS2xad2JnTnFmMzB6VWdFY2FH?=
 =?utf-8?B?TGtPZjFSNkNwNngrakFKbkJmd3lFZHN5NDB3WFRuZ2xXMmMrSVB2K3JxaU9J?=
 =?utf-8?B?S29RSHZmVkQ0ek1MZ0puanJzRS9YK1dkOXBaeFhtRGloMjVRdFZZM0I5NnNk?=
 =?utf-8?B?WnNCZ2xOcC9yc24vOTJvdmkzUFNTL00vZEZ3d2k3RWd2bWpFZ1pEZDBaYmFE?=
 =?utf-8?B?OFBvZ3YrTVEwK2QwYWFFdkVlZkE3c2FrMGJUWW9XNHBEcFVlZXE0OHpBYUVP?=
 =?utf-8?B?QlhPM2JMMitKTGtoSDlOQzF4K2o3N2Vra1M2OHlkZnR6MXZsK0NiZk5tYkpK?=
 =?utf-8?B?bVQwVW80cHM2aXU5eDdGODB1czdDQlYwT3dncXlaU25GanorUDIvQmNHeUtF?=
 =?utf-8?B?UXZYR0ZSclNvVE40VHI3R3BvNTFkY1FIK0JyMGdYODJqS2xRY3kvUi90bVdH?=
 =?utf-8?B?V29pTW1GYThKZE9JTDdrMFVJekdjOWtGMTlUUmlEL1RSNTJPdlJqUWpWWXFZ?=
 =?utf-8?B?aDRmcTViLzZhZnRTN1J5dU5zUnhvdFMrQ25PdXhnZVVDeUUySjR6YWVJVXRP?=
 =?utf-8?B?TDI1MDNiRW02YmRCUFI1RytmZGxFOUlqTDhqQmU5RUEzSHErNzhVRmt1QWFr?=
 =?utf-8?B?d3M2aFEzL2JSSmlwYnB0NnU0ZmZtOTZiUjc3TVFsYUVzZ0lFWDc2K1BacmpU?=
 =?utf-8?B?aXJ6aWhaSUJHTU9CNjFwaG5hb0xqZWpjTzlUZDNPUGlybm5HRmdmUko0Nzh0?=
 =?utf-8?B?Vk0xSTJHMmc4UjNmTGZqdHRrSUhTZjZmckkyN29Bb1JHUjVXOVBwaHNjMGxz?=
 =?utf-8?B?eFJBS2NXZG9aQmNvVEFvY0hhd0NOUURpSTY3dHBUZzNtVUJOcnlsM01jVXVn?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ce2f0e-6a76-4ed1-9100-08dd1f733570
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 14:49:43.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/qzRq+XeTTVfy/4gAN8du8U8kYtvQmoia2vOMmZaUc/T7Re4DdUee6scabVMQBLlyLFZ/gaaaTScpYYYYZC85pbciUgniaXIFvInuIEdiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7296
X-OriginatorOrg: intel.com

On Wed, Dec 18, 2024 at 03:21:12PM +0100, Eric Dumazet wrote:
> On Wed, Dec 18, 2024 at 2:25 PM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> 
> >
> > It is hard to know without testing (but testing should not be hard). I think the
> > phrase "Statistics must persist across routine operations like bringing the
> > interface down and up." [0] implies that bringing the interface down may not
> > necessarily prevent stats calls.
> 
> Please don't  add workarounds to individual drivers.
> 
> I think the core networking stack should handle the possible races.
> 
> Most dev_get_stats() callers are correctly testing dev_isalive() or
> are protected by RTNL.
> 
> There are few nested cases that are not properly handled, the
> following patch should take care of them.
>

I was under the impression that .ndo_stop() being called does not mean the 
device stops being NETREG_REGISTERED, such link would be required to solve the 
original problem  with your patch alone (though it is generally a good change).
Could you please explain this relation?

> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2593019ad5b1614f3b8c037afb4ba4fa740c7d51..768afc2a18d343d051e7a1b631124910af9922d2
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5342,6 +5342,12 @@ static inline const char
> *netdev_reg_state(const struct net_device *dev)
>         return " (unknown)";
>  }
> 
> +/* Caller holds RTNL or RCU */
> +static inline int dev_isalive(const struct net_device *dev)
> +{
> +       return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
> +}
> +
>  #define MODULE_ALIAS_NETDEV(device) \
>         MODULE_ALIAS("netdev-" device)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c7f3dea3e0eb9eb05865e49dd7a8535afb974149..f11f305f3136f208fcb285c7b314914aef20dfad
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11044,8 +11044,13 @@ struct rtnl_link_stats64
> *dev_get_stats(struct net_device *dev,
>         const struct net_device_ops *ops = dev->netdev_ops;
>         const struct net_device_core_stats __percpu *p;
> 
> +       memset(storage, 0, sizeof(*storage));
> +       rcu_read_lock();
> +
> +       if (unlikely(!dev_isalive(dev)))
> +               goto unlock;
> +
>         if (ops->ndo_get_stats64) {
> -               memset(storage, 0, sizeof(*storage));
>                 ops->ndo_get_stats64(dev, storage);
>         } else if (ops->ndo_get_stats) {
>                 netdev_stats_to_stats64(storage, ops->ndo_get_stats(dev));
> @@ -11071,6 +11076,8 @@ struct rtnl_link_stats64 *dev_get_stats(struct
> net_device *dev,
>                         storage->rx_otherhost_dropped +=
> READ_ONCE(core_stats->rx_otherhost_dropped);
>                 }
>         }
> +unlock:
> +       rcu_read_unlock();
>         return storage;
>  }
>  EXPORT_SYMBOL(dev_get_stats);
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 2d9afc6e2161efa51ffa62813ec10c8f43944bce..3f4851d67015c959dd531c571c46fc2ac18beb65
> 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -36,12 +36,6 @@ static const char fmt_uint[] = "%u\n";
>  static const char fmt_ulong[] = "%lu\n";
>  static const char fmt_u64[] = "%llu\n";
> 
> -/* Caller holds RTNL or RCU */
> -static inline int dev_isalive(const struct net_device *dev)
> -{
> -       return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
> -}
> -
>  /* use same locking rules as GIF* ioctl's */
>  static ssize_t netdev_show(const struct device *dev,
>                            struct device_attribute *attr, char *buf,

