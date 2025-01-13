Return-Path: <netdev+bounces-157893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63044A0C384
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F9C3A8461
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2802C1C5D7B;
	Mon, 13 Jan 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM7vECLw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E31BDAAA
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736803092; cv=fail; b=ahfIaxnhqgEswQTB2ghfGXPEucLdyYjCftp/9ewQI6ZXxCuF8ARzT4wmxbo6mFfvhR//6ZI/OHLu4GZ1w4MCLsEVnVbSR4N4awX9udK23n+l/RFtpleRMclP7GTAe/GtCsTuf5F9KTKn7hff54JyloyyA6gtrcyylWV/cvF4e0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736803092; c=relaxed/simple;
	bh=MMSKT6u0lQc4H95DC3LU9kxEt7m+ToVwlIbsy4syvBY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V8X/LpDQ8bkSS/qU/jBawmITcJ+PZa4E2wLXdbEz0nskOaMkaTzPuI+KbQzvS/cqws9sk/yPYiOcUJYyIw7F3A1vM8KR/D3+5Fksh39zlZQuE3h/bZynxhXFhYLGVuaXfoihom0lOaGpUU0VBRjhVMhFlW5MvAnwapErvLagkO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM7vECLw; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736803090; x=1768339090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MMSKT6u0lQc4H95DC3LU9kxEt7m+ToVwlIbsy4syvBY=;
  b=gM7vECLwd5AETEz1LVJUg+bSMEzP+lm+gR6bvn5U+tR6pnW/ZagJnGUA
   ty2W+I43ga52VldKTYIDsUheuHk8T3Ko5TBqRIfmBN1zhIMCo/xBazcu1
   +V7IxMP5BYQcnACzajxeNZFVvjAS7+DcVpN2a2QjIJqb7/18mR6OIOz+3
   U5YxF++Ff3KDILujPDtqaO0faB2QSmkf2v2BI0epCYI2SSnSQzKBVXMiG
   HKw8iw9dZqAiQ3EMk9E8uzwjBRSLWcFk+5O7fUEiW6i21WdHKrNJraZVA
   pwBmihCuwoESmJEMjEGx5uqoY/2okoY2ackcuKtzUxq0Zu3o0rJ8+RfA+
   g==;
X-CSE-ConnectionGUID: t4TOLmjESMiqNLhma1fpaA==
X-CSE-MsgGUID: /mSaceSBQRmnc5crJEOueQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36771221"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="36771221"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:18:10 -0800
X-CSE-ConnectionGUID: T8Os2vWQSACo4LoCwAEGjg==
X-CSE-MsgGUID: xFWHgf9/SZ+tXpyZFiCkag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109731877"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 13:18:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 13:18:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 13:18:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 13:18:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHQDzTMz+Y7ZNvRZNBHCt10lNvwTG17/7+EfLprPOLkmtHBVcTt91JczrcBulp83Lzl45d/1zIaoTq2pNVCF7ddFbVeDzPjlfhQk/HTqZhU/zzL1qhCXZNeMgPABwkO5ARPQ1eA9nvjs7qtabKYy7q0DvYHquPjNcjS7lNDAYSMGwvVlHHSk13MJkpOyxGNDqmmJyU1jEElg94vBc5hh479XSfgntedldqR4v0zSI4O8xFE6TiBqvuH+lDLZbFLU7yWMeZ/qitgmYRee38gnQJRePG5JH9CTOK8WTwLJjV8Lz/QlVx1/Sne1fJjcaCp/zQ5O1EWKljGQG0tLUohrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R5GwCsa/1KHi047QyfHEmomzr8IJYZC9ZmqZOsGegQ=;
 b=I8HV4IVPoV9ScFCdkQzaFsJe644uLj5nY6gpjHCzezwoG2YdCi81t0gd9HGIE1RS06uOzzRfCsqg/avfuMGenmp58mQWeqi28L7WhwMo3PRolgdH/8ol3ng32h4wl2C9Q3ZT9VGQJz3MnGL8Qmwqf95J9I0ABPOfYODN0rbaQTKVlq+ccJWqMop3i8yyZ0QZ4JR0XZtABHD1qsd4B3fFLlFDF3b1Khz+MDvrnodWXnh1uKqHCe1AOkA9N7JrBKI+Eiy2idyHQ9niE0TzsB5EeUmxL9OwmMDPnMhCN+PmcYYKHGZBmOylNa1pNQHM+rBi3xRXS9AMI59KOUq60GBIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6794.namprd11.prod.outlook.com (2603:10b6:510:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 21:17:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 21:17:48 +0000
Message-ID: <5ee4a134-009b-4ba0-a25c-f5f8a955da22@intel.com>
Date: Mon, 13 Jan 2025 13:17:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/13] ice: implement low latency PHY timer
 updates
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
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CADEbmW3As4t9LbZqvjKe0CyWQkYMOVKMzQgtmJdcqkQbyayP1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: ee14b7c8-72a2-4c38-f5bc-08dd3417bb39
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHIwbThBa1g4S3BzUGxaMG9oNU1KRU05UU50U1ZVbHB3UXEwR2dxOUNwSDJU?=
 =?utf-8?B?VkhVWWo1cVNwLzFRMEUvejNaU2hpQmdXUVJNU3NQOEwyU2tBS1VnMnF4UnRZ?=
 =?utf-8?B?dDRZbk5qVnp2Zm80MCsxZ25MTWFabXpDcDNZN1d3bURPSzNMRVhaR1M3dngx?=
 =?utf-8?B?Z0orN1FWa25TblRoc1VOQVd4eW5lYlY2ZEEwQkxoTXFObjMwcFVobkQ2Zk8x?=
 =?utf-8?B?Q2pyUnNERi93NEJFUGhhUzJLVElNVWhPMG9vendaWWg2bEZUVnpYT2hadlRP?=
 =?utf-8?B?VmF3N2E0TkpKM21Hb2kybVowNllOeEdSajlQOHFSbElURWpQa1JTa3VRREM2?=
 =?utf-8?B?bTl2OXl2ZHczNVo1NkpOTnl2cDZLNnl3Z1ZoSm5pYmNsV2lULzUwaDF6cEhJ?=
 =?utf-8?B?SlB5UEx3RXBOemJFRDNNK0hsS3h3dVpyQ2srTkU2Y1pyUUM5MmRMVUhzU2Mv?=
 =?utf-8?B?YnpJdlVqbzhnZzdaTjU2d2FOWVlYc3FoQUhGZDBGY0luNkR0WWpjZzY3d0Nj?=
 =?utf-8?B?cFFob0t1c0pQT2JsUUo0d0tlOWJ5ek54Yk5neGFvbmdxemR3bWpRdWtpQ1pm?=
 =?utf-8?B?ZjlZbnZRTlZqTzNLbHZNcitVQkJVNTEyS0hZblhzUVVxZmVkWkNaaUNQMitq?=
 =?utf-8?B?NGhXV1JQMldPS3pxOUZkTmF0c1BJQ20zb1JxMTg3NzZia3AyVVJteVppcnht?=
 =?utf-8?B?L3VXRzVaVE9qczBYU3lMY3FGWjY1LzVKQVBTVTRqTFd4ZkhPa0V6bW1wSlpV?=
 =?utf-8?B?a2piTUhXR0R3Zyt1UVdJUlIxdnBPWEI3cStJYjVNbk5yNFI2UGhucWVzYVcy?=
 =?utf-8?B?azA3eVplY2N0OXhQQnBPYTBJN2VxckYyeXgxbklQTTIzMzIwMEZ5VkYrVHNw?=
 =?utf-8?B?WHlJRnJoQmZTQWFSc1NWOThkMWVsNlBkcXNYaWUvOVE0cFRYSnRyT21iSG5u?=
 =?utf-8?B?WVRTUHpuU0tERTJLajY0K0dLWStIOTI5NHZnYUFEcXNuc1JBMWtvWHdEeVZZ?=
 =?utf-8?B?V3ZnbE1wWTErMUlPK1Y0Y3E5cWNmTEpzSjBnTE80cHF3Q3l5STI3L2xyeTNQ?=
 =?utf-8?B?dTQ0UStEYVE3djJyRS9VU01IT0hCZ1h6bzBJN253ZlRKT2pYRU9FTnZiSSs4?=
 =?utf-8?B?SHJiN2xHaDFaMmhUUW9CbWt5ZVJHMVU3SS94bERmbndVZHUraTZ4c1RhQWxL?=
 =?utf-8?B?b3FJQ1dxYmNKUjBveG5zNm55cHZJN0tBeklpSDh0SVh6bVd4dlRvODZqUDBM?=
 =?utf-8?B?VVF3TE51MjJudjlQbUFwQTYyUFkrQk10SlM1Y2dSd2VvK25OK1VpTjVRdjZE?=
 =?utf-8?B?V0tvNGNPN1V3b3lJMEpwQ0Q5d1lPVkE2THliUHhYenlvLy9nVjN0WlFXOG5r?=
 =?utf-8?B?MmJjY3QxVVlLSGNJZzVvZ0JtWWtCVTNGTTRoMkI5UE0rU3ZWamJ3b3NFWnkv?=
 =?utf-8?B?YTdSQ0RPdTg0cTJRd2JUd3FJQ0hZa3phcERBNEY4VUJsb05MNlFPbXkrRlFi?=
 =?utf-8?B?Q1pzQXM0MThBdE9WU1FSTzdyakFBVzl6NjY5T2VDNUt2SGU4SnRsK1RlWnB5?=
 =?utf-8?B?TXl1YmJ6SWFpRDZsVW9hSmxiWEtYdlVkV05ZN1FESVdBUmt6SjRuZFVIb01U?=
 =?utf-8?B?ZlFCMk94eDl0dEtqYW1HbmRzanpYQkljTjlselRQQzNoNlh4aE1qR0V1S3lh?=
 =?utf-8?B?a0xwUUtnaU8zT0FZYWFPY0oyNWFQUU9PQmZpY0o1N1c5TlNOWU1lSHVaeCta?=
 =?utf-8?B?NjFFS04ydXdqTHVjNmk3VVhNQ2ZCbnJjOFBlWVdkVTBUZmdFYlRtLys0SEls?=
 =?utf-8?B?U2ZDcm1zWEJ0Wm1rdjQ0c0NYYXR5dXg1eHZvR0JBenRGM3k3TGw4NVB0d3cr?=
 =?utf-8?Q?3gv424eoszoLZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2FENE9pYjRKRXd2WFl5eUtvdmZvbThZbVJ3c2xrekhMWThpNWNRTVU4dmZx?=
 =?utf-8?B?aVdzMkhENVU3bEVaemp4Rlp3T2lLTzBTc1dTSXFPUlVFcXlpcnhqcHV1SVEr?=
 =?utf-8?B?L2VNVUZQR1BXTjdqZ0ZsdS9CT1l3a3FubkliTC81MzJ2MVVhamkzRHNrVFdI?=
 =?utf-8?B?eW10RE4xWVJySFZtTVhlMmgraVJVSDBPWDVmZjBpQ1EzT0tHZzNBSWNCSVdj?=
 =?utf-8?B?dU5Ddk16UVF0U3BMS0NuK3gyZkNVWkMrOUFqNDVYUGlxSTc2cjYyOUdlNFp5?=
 =?utf-8?B?ck1WNzVEVW1nbXJjRnB5Y3JZNW5NbXNnaWRCdU5TSkR3ZW1vRnpmY2xvSm5z?=
 =?utf-8?B?K0w3YUtXd0N2cFduT1V4YkZGNmdreEkva0s1aXN5d3BpSzlFKzJpZGJnR0ds?=
 =?utf-8?B?QTd2VWhVZTZZVjBXRm1LNnZGL0RkeHRyWVhmaHBMbFNMR2UzQjRHNzFKcEpU?=
 =?utf-8?B?NHZ6SUxPb0RrUituUWNEUE5zMUV2dnNkL1hiVm9PMGhZNzZLeXByTFFQZkNG?=
 =?utf-8?B?V3BHZytvY3VLeCtDY3BqMVNDM0loaE1hakRaSzBOR3BGQmNNUElITVpQekpY?=
 =?utf-8?B?UFV6VWdpWGNPYVBLNmdTdTBKZkJMalJiZkZOR0hrMlhESEVZNEpYc1I1T2tL?=
 =?utf-8?B?TTFQTUZ5N2Z2WnFhUW1oY3EzdjYzUE1nRlNHRHRISkRPL2VWdGhxMDZYZ3U3?=
 =?utf-8?B?UGtJMkFzTlFsUHRVTFd1VHpvSWZzYnZ1NE8rRHh1TXhXdkJPdi9NcWZBalpx?=
 =?utf-8?B?WVBWN1N3Zk82UGRWZUwrcHJHT2tyeDNyVmxhL0xEcmFHU2N5OHZGVWtrQXZT?=
 =?utf-8?B?Y25MWFlFSGE2anlSS0JMMmYwaUVjS1EvN2RQOGVzSXJ5bHVCL0tQZk5oYnNw?=
 =?utf-8?B?KzdFTTMvMzhlZ1ZvcHN4a2lFOWw2a2ttSVF5b3o3cGdvWUxNYzNadyt3MjBM?=
 =?utf-8?B?L3MrLzA0cjlLNVpNZG9FRjZPcFBEY012dEY0V1RMWnJ0azBFbnFUbXVhTklm?=
 =?utf-8?B?TlRYOTBnS3ZQb0hYVGVuck9DNVMzdGtCenI1MTN6ZnZLZFZHWlQyT1BIK0k1?=
 =?utf-8?B?YUtuaDE0ZzJ1dDFoSzhHM0MyRFhydlVtZjBtR3YwTEJnclhqYkJLTnFPTTBT?=
 =?utf-8?B?Qy9HWmppQTdvckcxZ2ZSM3k1bk51YUYwYXZRTTZRSnFRS3ZPM08yeDJmbHNo?=
 =?utf-8?B?cTJEeWF2eDNrclJ0TWtIVHBPeVZDRXgwR00wd0N3akdnYUxSUWM2K2Z2b0JM?=
 =?utf-8?B?QURjU2liM2JuY0JnbUZLc2VETGNPZW9rdTJSNHZmVmFzQXNMM2tRcDRST0VT?=
 =?utf-8?B?KzQxaEpZcHYxZGc2YXZFMCtCZ3ppRWl0Y0JKRU9xellkSHptNzI0TEkwYkJj?=
 =?utf-8?B?ZjN4YW44M0MvY1oxT3AxdFNvdzVVY1pnaVRnTnUyc0puYU1NSFl0YnYzMlIx?=
 =?utf-8?B?QXl1WTBSS3p6Q1JaczRwSXBxQjQ2eXBYSmNQYTBJUjBpTEcrV0wvT1RSL1ZL?=
 =?utf-8?B?L3N4ZmJoUlplek5yU0ZYQ2s2UXUxb2hPaU1jcWRtN3FuM2x4RzJwL2VkQVVW?=
 =?utf-8?B?Y0o3VUJBSkhPVzVvL2N0TENRSzZkelpJT2U5cWZRMmVmR3IyalRtOEllSGxQ?=
 =?utf-8?B?WTY3eDE2RzAxUmg3cVVneDJpVXNydjRPVEREUEpWdmgzQktSMCt6R0w4KzR6?=
 =?utf-8?B?OVlqdDYzWnhzRGhIYkgxMXdkd1Fhb21hSkoxSkdWYnBWeGNyQ1JhZEhGMEk1?=
 =?utf-8?B?Z2dCeis4b1RzRmxpaDcxa0hzdHV4RzEyTWczU2RYYlE5UTBoVmkvYnpJUlhG?=
 =?utf-8?B?dElzWS9iU0VUZ0Jmc3lNUFkxRmhOcTRRQzV2Y1NWSm5LMm51ZHJZKzRQN0NN?=
 =?utf-8?B?M3VRRStxSUFxMEVTaGRHRlcvTkZLVllmWXc1Tm5xbG9TbENhQVdKOXBnUitB?=
 =?utf-8?B?QU8xQWpPSXptMW5ZRzR5MzRLUmorLzVlQTBOdEpKeHVSMFNKckMwQWZxc3Np?=
 =?utf-8?B?L2lWWEV6V1RGOFRLWExQY0xNTW1xZVdhRGFOc214bDYvOUMyZ1ZKMWZPVHdp?=
 =?utf-8?B?M2Q1b3hrWGM0TU5Pa05lWnFIUW4ycXJjMFhQdlptN3o0N1pvR0pOaFRUSFoz?=
 =?utf-8?B?UFFkUllERFdXcTQ4ejJ3SUU3WlU5MDU2dE9WZkFpZlNlUFhOdjd3ZkpSTUVi?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee14b7c8-72a2-4c38-f5bc-08dd3417bb39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 21:17:48.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPizyJJE7eHI/i/YasN74Tu4gHVnSo4uC/dCvGeiWIuMVdg8d8IpYNx8RpPSjuKwJwMWOhlmc9ft6G6XnZw1sPQrvtclErh/m9LFET3HsVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6794
X-OriginatorOrg: intel.com



On 1/13/2025 12:46 PM, Michal Schmidt wrote:
> On Mon, Jan 13, 2025 at 7:51 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 1/9/2025 6:18 PM, Jakub Kicinski wrote:
>>> On Wed,  8 Jan 2025 14:17:49 -0800 Tony Nguyen wrote:
>>>> +    spin_lock_irqsave(&params->atqbal_wq.lock, flags);
>>>> +
>>>> +    /* Wait for any pending in-progress low latency interrupt */
>>>> +    err = wait_event_interruptible_locked_irq(params->atqbal_wq,
>>>
>>> Don't you need an irqsave() flavor of
>>> wait_event_interruptible_locked_irq() for this to work correctly? 🤔️
>>
>> My understanding was that spin_lock_irqsave saves the IRQ state, where
>> as spin_lock_irq doesn't save the state and assumes the interrupts
>> should always be enabled.
>>
>> In this case, we lock with irqsave, keeping track of the interrupt state
>> before, then wait_event_interruptible_locked_irq would enable interrupts
>> when it unlocks to sleep.. Hm
> 
> Do you even need spin_lock_irqsave() here? It seems to me that all the
> functions where you're adding the
> wait_event_interruptible_locked_irq() calls are always entered with
> interrupts enabled, so it should be safe to just use spin_lock_irq().
> 
> Michal
> 

Thats a good point actually, and would be much simpler than adding the
irqsave variation wait_event.

>> So this code will correctly restore the interrupt state at the end after
>> we call spin_unlock_irqrestore, but there is a window within the
>> wait_event_interruptible_locked_irq where interrupts will be enabled
>> when they potentially shouldn't be..
> 


