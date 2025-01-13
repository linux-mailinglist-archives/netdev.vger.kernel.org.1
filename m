Return-Path: <netdev+bounces-157897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A79A0C3EA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E78E3A66B7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDC1D63DE;
	Mon, 13 Jan 2025 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fluvwW82"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029EE146A66
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804450; cv=fail; b=mOLpt8O1mWAlQfsBmPHpdaluecsvy5d/aE8rOVtqL436QjeIXT7KeGsinxcMzXYr9EmxCmTmaMIr8yttvg5jVUauyt87mLuIPQnkYqrylmO+lY7hA7zRaOTf/soKwosDilhnl4gEECYDPmArBC7EN1NJNpbjXjSqLqouAwCZswM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804450; c=relaxed/simple;
	bh=7Z+8ZASEGQT3ItpUdg8wZA0jGv2ChG9t7MWdgV0xRxA=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E/r6D0olTwca0nZNgtJIiV09NcAWTcDziVcdD6h1GNB0JYN5ECAb9K+HNjNTsnu2L0utQEIICexHhCr5cWRJ0ae9dWmEmfTQ4keq+PDG8px2nVly74jrOX+safuhko5sT4s8HNXlAk5NWJPnbhXClt9LWtqrH137MzW6Idz8XO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fluvwW82; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736804450; x=1768340450;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Z+8ZASEGQT3ItpUdg8wZA0jGv2ChG9t7MWdgV0xRxA=;
  b=fluvwW82n5oR0kLrzTt/7/CsGi/mwrWCFv7pcjgUhQhx1Th1MszUKSlm
   onyvPDPBIJ/jf/hKlTNSeZTxJMIuBvAV6OH9XB8sQwi8Zau+1r5dNAGp0
   GF0MMRiOCVtgYb+uQAru4OaPj671CGwUdJu+9vNyMeDtAPu6NQDikQAGB
   dfAxSDst9aLFPnZJLmaI1pnlBNfL/ONdxnTJewBJjOf5wObpeb8klZsvE
   AIFTQc5Yq3oKSQqzkeXojijPR/fFgUET7TN+CtuRfqyLsB/dcbyt61ikl
   Nb9Pz9ZYPctJQ0IzSADCwxVsgWsdgS3UCXwlLd+9KS4xtMod34/wplSW8
   g==;
X-CSE-ConnectionGUID: vmwacrpHQfGpXNA5uFB+sw==
X-CSE-MsgGUID: +aNcnHk0RoyWPB8PjB88EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47578187"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="47578187"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:40:49 -0800
X-CSE-ConnectionGUID: ZOlVK3hARs6muCnnLK3xug==
X-CSE-MsgGUID: Ga95KHxDT0qTbm1AwS8wWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="109541616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 13:40:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 13:40:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 13:40:47 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 13:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRP8cPanYsTTjRKBiy63J238ruyKfRf5C2YajRQ/N66TWKluYuePnIBGtYYDW91el7coo+kcxQCnoURBsRu3I/bBBrItPTOXQRmLHX3v+cabcBZdnURm5dumTNemec7uUs01ARbSKku8i8O7FXXiAisBkFAI2lxzy6QqubtlvJNFdOz0/gYEiNcISs0I4WMZCjMogGY/4hkukR5gNOAhGrp/4Ij19Bzb9PPy64o1JSS8KkRIVqsY+1gl9WWtWZ0C+qYeIRhMAv5a3LD/zxLSSv30vWAd6M0SIrwv9r8a9sk9HqxsZ7lVgsjXStmbzR/5ZPslxdK8taMwM+8CrblF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+jgqFrEBS5BczQ4QVKW+YkQmiQVpaBnTDQI0pl3Y18=;
 b=K5OOfcaDeIaIk4mcLtizMkJ5PhuBqclH/qOHtJMY+mWV0tHLtyzvoJRvBnYRlEgdVyOcebjLyMTSyhxgOWa3DW6ofOZ1OUbuHw9mHtJCqjBgeBaYR480HI+TZU1tRVsVGOezgDoqJMdLx4FdZ696Sp/sfFMTo5K/G1tFJQujeG6rzadnoLSeFLKKRGNM7/KbWF6ecmrqbA0xX1Xy1xuL+8ODhxKaAkoNOSwgjh1XGt1x0SRZmmDn7c2Gn8DyA8u3gVhQiggAQRF5qrhK5nelADJQeizGbUv3uJRTToniBiYws7OkTIxMuhERBq8XYkQV90+7axr9Vfz1OY1abTZgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7161.namprd11.prod.outlook.com (2603:10b6:303:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 21:40:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 21:40:30 +0000
Message-ID: <a8dcf9d5-14d6-4765-9fba-ae2ca0bc9dd3@intel.com>
Date: Mon, 13 Jan 2025 13:40:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/13] ice: implement low latency PHY timer
 updates
From: Jacob Keller <jacob.e.keller@intel.com>
To: Michal Schmidt <mschmidt@redhat.com>
CC: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<anton.nadezhdin@intel.com>, <przemyslaw.kitszel@intel.com>,
	<milena.olech@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
 <20250108221753.2055987-13-anthony.l.nguyen@intel.com>
 <20250109181823.77f44c69@kernel.org>
 <961f010f-4c53-4bb6-a625-289b6a52525a@intel.com>
 <CADEbmW3As4t9LbZqvjKe0CyWQkYMOVKMzQgtmJdcqkQbyayP1w@mail.gmail.com>
 <5ee4a134-009b-4ba0-a25c-f5f8a955da22@intel.com>
Content-Language: en-US
In-Reply-To: <5ee4a134-009b-4ba0-a25c-f5f8a955da22@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 87212304-b066-4cb5-b037-08dd341ae6f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjFXYnhrOWVpU3Q0ZXlQUGJuRGtvT3d6S2dVYWlhVllOc0hBMXBYNmpZZjRv?=
 =?utf-8?B?U2lSVXU3TU5Hak5tbmd0bDQ5dHJoVGo1R2FWbnVHZlhsdVFmTzNnY2p4Q2Vl?=
 =?utf-8?B?dzdZQ1FBcUIzQmY3OTJmMzlCdkI3aU0rTldHaGNZaWR6YmdqZ1VaU1lQajJ4?=
 =?utf-8?B?REVJc1FFUHRpVVZFdWFTSWpCazE4Q1g1dlM4dXRCdlRVTi96R0xnYzNaNWtL?=
 =?utf-8?B?SFRGL1JFUVpyaFNvRWkzbDhraGprQW02bXREUW5IYnJINW5Ud2h6d0R1a1BW?=
 =?utf-8?B?Z1ZXc1NMVXFvRllqRXd5MXZzeE1pQkJaQ0hFQXFmUzVycENEbmFQbTI4dy9o?=
 =?utf-8?B?R2RmRW1Qc0d5UkE2NjdWNUZIN3NyZ1BIUmk2UVFGNzJoSmx0QWRldGY5NUR1?=
 =?utf-8?B?UzlCSEhHOXRxYWt5RHNuWUhjZlBpTkdJOXJQV1VuT0kvNXArSlZzL2srUzM2?=
 =?utf-8?B?OWhtMW5RcG5CNVVldjRHdHViM1FMcnpaUGdWejdCelYvK3hET0R1UUpudTVv?=
 =?utf-8?B?Q1kwN2NSWHp6WG11dFJ5NkNFRmtHZ0dKeXlqZHFzSzhjUitpcVNGcktBcjEz?=
 =?utf-8?B?dXcyV0twUEdYY3FIRkNhK2w2SDB2cmlCcEVleWpHWHA2QysxbFZHeFF2Sndq?=
 =?utf-8?B?SlhvNnVjc2k1UmRwL0U4Z1k2QWY3bmxzY1VQcnpCditTc2xENkVCVTVKS3lh?=
 =?utf-8?B?c1BJbUgyemZudmZtazNoNFpYY0xlMFU5NmxqRTBJYldoQzA3Qk43MEc3ZmYw?=
 =?utf-8?B?Q0I4RjJnZzh1VXExZ01tei9FcHozZ3pDbW10bUVnbktGd2Y1MW5CbzlqY1o2?=
 =?utf-8?B?YStrRG81R0ZSR3VRMllIanlJeXdyWU1pemRoOGc2Wk44WXdMS0JJOXFtd2xR?=
 =?utf-8?B?N1luY0hWbWc2SE54anJ0WGgyWkRuWEMvRTFmRVdEZGZiM3Z0b2dCNHNKZ1FG?=
 =?utf-8?B?N3U0SnRFSXRIWnAzcnVxOUpkdVpLRm45RmVBZStyKzlYdDV5aEV4dXdRQkNS?=
 =?utf-8?B?RmxLS3Q0NVdrWXNseDZkT0lVY3pFS0EwWm96Z0xQQVU0VExGTDUrOTM3ayty?=
 =?utf-8?B?YkRmcW9lWHoyMWJEV1FQTy8vN0pYeHhNYmg0Q3ZVL09TWDZxbEZjMGRDME13?=
 =?utf-8?B?WkxXbit1VGpDOXFKd0dBbUtnc0RpWEtFc2xib3Q1WEF0aWpUbnp1di9BaDJP?=
 =?utf-8?B?U1BWamZ0Zlc4STF5bktPUmx6SlJMMWFtaDM5b2ZWQU9rcHFEbjRsU01tTHNB?=
 =?utf-8?B?dlRzSDNDSGdrSjlCVkNIc2ozUHE4eFd2c3NLVnd6RFY1UTV3VUkvcGk2U2xx?=
 =?utf-8?B?MTlGek9odElzbmVCN0hnQWhhWU5PcGsxb0UybnJmc3Fnd0YwMnhZTHdCdERL?=
 =?utf-8?B?ZDdON01LM3NaTE93azRnbnI1bnk3L1FDWjJFOGdzUlNiZkM2OHFURjI2MzlB?=
 =?utf-8?B?eTd6amdLVHp3SjZRS3M1NE5wbklFdUlBSHdoR1J2OHBlbGVxRUNocG5ITUNI?=
 =?utf-8?B?YW9Kb25iQ3BUczRaOHRRVWp4cldHdHo3bDJiZlFWUFVNR0JCZXZMWjY1WWVn?=
 =?utf-8?B?c2t6Q1RObktiVlRNdmw3SmtSaW9tRy9EYnF1NG9JVzJJVjVDS0JpWWlqczVs?=
 =?utf-8?B?eFBqZ0tqeXBsWFRybkx2cVAvUmJQMlVCNXlYZEVMa3U2cGU4K0NlQWxCM2du?=
 =?utf-8?B?MmhzazlMS01HYSt4WlhsL0pGMGlpcjhaenBrUWwrM2UxVzRyWGlIblQxRnJv?=
 =?utf-8?B?NVFQTXFpYWd3ZjAzcm96UmwzOHk3NXRYcHNJTk92U3pVeVJvOGhOSlByc0cx?=
 =?utf-8?B?MjI0YW1QeVNORTBuVnRrWW0vTFNOWStjSTJxYThxd2t3YjFHcDFITGI3N1JG?=
 =?utf-8?Q?et+ZCoCItR+Sw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDhqMkhva2d0S0VHcFAxQ1VzQUlaQ2QyWkpIMzdzeDJBODB0ZnY2eVg4Q1BT?=
 =?utf-8?B?aEc2UDY2Q2E5c2NZTmxQOHA4bzBUT0ZBMjY2a211OExJTTVWMXV2Q1RKazhs?=
 =?utf-8?B?bElweXljaXdYZG9Tay9Vd0w3R3hJVk1iaG9Mc0RNWm11QUFhY3pVaW1Ec3VR?=
 =?utf-8?B?bFE0VkJJbTJCRHRjR3NmanNET2w1bEl2OVNxM0hPWVQ3WmlNRzRQWVE0UUl3?=
 =?utf-8?B?eCtpR0xJdmJCUGU2eExORkQ5cGxtTCsyeFBTVEFsaWVZVFhOVy9QS2grUnhC?=
 =?utf-8?B?NURCbVNxeGo3T05ySmNGUHlmbnE0WUtZY3JZN1hxSVZkQ1dKcjNtcEVGU0t6?=
 =?utf-8?B?KytlZDFaZkV0SjJKWnViZmt4VW92VDJ0dUdoQi96enVNWG5EUmY3ai8vcHNy?=
 =?utf-8?B?aEg4ejJzV0YrdzR3amhmUFpmNVNMN3gwU1ZOcnpSc3lTalRLQVVxQzRreFR5?=
 =?utf-8?B?bGZrLzZkTkk4R0lPb2ZPeks2LzM4WXo3a3V3SUFKQ0FIL1lxdEdkTHhtL2tm?=
 =?utf-8?B?S2YwZXpjNjV5TDhtUHBmZyttTnpFYUt5WXc2K0VMS2tPR1EyT3N2ZDRjdkZR?=
 =?utf-8?B?MW5jRTJCMlhnOWR2eDhWYlpWWjdLMzRkU0pMbmJZMzBjWDYxMlJFSjcrbGhY?=
 =?utf-8?B?cllQcXFqTm5hbUdlM3ZZM3J0RTFqWFYwVWx5dE9nazZBeGprWTNtTk9sb2pB?=
 =?utf-8?B?aXVEc1RMcDF2ZzlFZ1VZYWtZTG1TcHFMWGxqc09NUzVGbXh5T2RYS2Jwak1B?=
 =?utf-8?B?K2tBUnFlSDl2akFkR20rYldid0k3V01XLzl4cVczbFg1cGJyeWlTcVlFVVFk?=
 =?utf-8?B?Q3NtdGgxOHFIbGVRN0l5cXJDVU5XYitLTTk5YS8xN2U2VjRlNUxSeXFOU0c3?=
 =?utf-8?B?dno4MzB1WEFWYS9MTGllN0c5SlF0RXozUG0yNG1zRjRMbjdCelp4V1VnU2pV?=
 =?utf-8?B?K0czNUF2UHBoQ2dpSTRMRVdtTlBxZEVQeFpXWDdIY1R6dHdnNTZqeWd2TU4w?=
 =?utf-8?B?bzRQcDJDQWpKVnp1aExUNithcDJWbkJPU1djVHlWZ2lWd0x3anhILy9waHhk?=
 =?utf-8?B?d1hIMmdTSml5Y3RuTnhpRmZVWHVmRG4wa1l0eWtvMEliaHZ3M3c5dEgwelZX?=
 =?utf-8?B?cUI5eVRzR0JmbVF4a1R0Mk04YnN5RWtWUW51OGFXN2FYblVjaVFiTXR0a0pX?=
 =?utf-8?B?TnI5d0FPOFR1eDdUQWljKzlkZHRYZFpHZXNreCtCMHJaRHkzMVJEaUo2OHor?=
 =?utf-8?B?b3JIZjF3OWl6ajV4OWVQUzBZZ0dRY0JiRUdDR2V4TkZWdnpmSTU0YnRmeGNK?=
 =?utf-8?B?anI0R1puRi9zNGE0dmNVNUtrbWdTd2picVlySDU3K04yQ3lBK2lLN3gvU0Zm?=
 =?utf-8?B?VGJocEVuTDlLWDlvM3hWSWIxaGJ4dHpvNFc4Q1UvRElLb1NjRFZ0Q2R5Q3ov?=
 =?utf-8?B?cWhPVlMvVXoyZDMwVlFUM1pvMG03NFExM1IveUlwTnhBZitwMDBjWkV2M1Fl?=
 =?utf-8?B?aFhHQnhadW4wVThjRGZBWmEyR0FJK3hqY3NPK01KQ3RlL2ZqSlUrc2RENUxW?=
 =?utf-8?B?aDlOdUkzNmNXS1hldDZMZmhCL2xsRFBvNkM3UEJsL3poeXF3ZGpsV0hDeWor?=
 =?utf-8?B?eWhiUmxCbFJnWjJyaFVuRUtuOEZhbUtpZXhlUUl1SnFNUGlNem5xUStSMTIz?=
 =?utf-8?B?ZHNHbjhxa3haWmdYY2RkM2hVN2V3bEd5bHEwbndBdklWTVhaVXRSaysxemZs?=
 =?utf-8?B?ZDROVDI5d2tGQjlNaXJ3ZTBocXpYczBMandCRzNRM2QvUEFoWW1qR1J6UDh2?=
 =?utf-8?B?VWhLNkgxSDdKeHR3cHhDSW4rZmFvTWFUbnBESzU1VWViK0YzVWZVN1FGSjBt?=
 =?utf-8?B?RVpZUDlRNmtsMFZlSkp2VDlhVVBSd2JkUWllTU9JbGdCL0M3K1ZmTHJjQno3?=
 =?utf-8?B?WHVPYmhNVHczR2xKeGkwOG92ZGx1dlM1S3crVEozTThEd0dJNCt4QnQ4WTBM?=
 =?utf-8?B?NkxPRjZyN1oveVQyckd0cTZvb0VCcytsMWhUTlI0WnVzK0FwblNuQVFaczF5?=
 =?utf-8?B?bjdRaHdrb0M1ZE1MY0NKM1VkRCt6akFLMUNMbUtJcW90RWxvNnlrcVN4MDhk?=
 =?utf-8?B?WmZvRHVqQ1VIenZqanRCYXBWT3E1VVdpT3BORGZLUEcrQWZ4TFdkTG5BTDAx?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87212304-b066-4cb5-b037-08dd341ae6f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:40:30.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEQlYBXTvkoyNAvXZa71IcOrGbWf9bu+1ynCAF0rp8rS0K+rdWCLEVd+DxTugG50nKPcH6kf++tRuKJ2F7yzYRdSFAwPXhqdAhMTXWR83LA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7161
X-OriginatorOrg: intel.com



On 1/13/2025 1:17 PM, Jacob Keller wrote:
> 
> 
> On 1/13/2025 12:46 PM, Michal Schmidt wrote:
>> On Mon, Jan 13, 2025 at 7:51 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> On 1/9/2025 6:18 PM, Jakub Kicinski wrote:
>>>> On Wed,  8 Jan 2025 14:17:49 -0800 Tony Nguyen wrote:
>>>>> +    spin_lock_irqsave(&params->atqbal_wq.lock, flags);
>>>>> +
>>>>> +    /* Wait for any pending in-progress low latency interrupt */
>>>>> +    err = wait_event_interruptible_locked_irq(params->atqbal_wq,
>>>>
>>>> Don't you need an irqsave() flavor of
>>>> wait_event_interruptible_locked_irq() for this to work correctly? 🤔️
>>>
>>> My understanding was that spin_lock_irqsave saves the IRQ state, where
>>> as spin_lock_irq doesn't save the state and assumes the interrupts
>>> should always be enabled.
>>>
>>> In this case, we lock with irqsave, keeping track of the interrupt state
>>> before, then wait_event_interruptible_locked_irq would enable interrupts
>>> when it unlocks to sleep.. Hm
>>
>> Do you even need spin_lock_irqsave() here? It seems to me that all the
>> functions where you're adding the
>> wait_event_interruptible_locked_irq() calls are always entered with
>> interrupts enabled, so it should be safe to just use spin_lock_irq().
>>
>> Michal
>>
> 
> Thats a good point actually, and would be much simpler than adding the
> irqsave variation wait_event.
> 

Looking through the code, the function is called ultimately from either
a thread function of a threaded IRQ, or from a workqueue thread. I think
those are both safe for spin_lock_irq. I don't believe this function can
ever be called from a path where interrupts were disabled. I don't think
this code can be called from a path which uses spin_lock_irqsave
anyways, since we need to sleep and its hard to imagine a flow where you
want to sleep but also have interrupts disabled...

It would also make sense why we don't see any issues with irqsave in our
tests: interrupts were always enabled so its effectively equivalent to
the non-save variant in this case.

I believe we can respin this to use spin_lock_irq.

