Return-Path: <netdev+bounces-148621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA299E29F9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF18A1608E6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DB1F891C;
	Tue,  3 Dec 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHZZZ5/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD541E500C
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248241; cv=fail; b=q6KnmM/NEylSZES1blYV4eoYsu04jAvOUhERJp+OeA4qmeqgrRtRUnPr0JW+M+mPYRrlHB5nmeUoNc8q6VleHNqBTFw3eHs9dKIty1xvoT0JU0+h0msO6a3mR8Y2O1nurEykcv5Z8Dguu38k7hgSpRm+dHQKUucwOfN7kiXgmBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248241; c=relaxed/simple;
	bh=VbviFc9YkPAxVxrGGoUFQTdncKaLNaDrjPTLs0KG48w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flNxPLmnQPfYrJ97Op+iIPAsi9mPcJ6nhO5vU7cMiW1YzbmuKc/DaR+ZyfXZlYX3aWeensoKF1d0K8aWKMGZu8gOC3VzFTHjy+YU0+ra3Ajjui65BrPW703U3PC3uElJBbzffiwmqP0PPcZIsRQlwvArFM/pnml6exd1tsWRkRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHZZZ5/Y; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733248240; x=1764784240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VbviFc9YkPAxVxrGGoUFQTdncKaLNaDrjPTLs0KG48w=;
  b=UHZZZ5/Y6cbI3MZ0qAFYzPl0ek4k+IYSmrztfr0cHIvYvAWv+b3fjuXT
   /R3Sr37vuAWeTMfeCI06oouvfb3ovJ2oSwexDE81q4iIQy7uCRdfiX058
   UqpjBAhliolyRmCQL7UApc+xoG4ZIKRq1ruY4Hwe0LR0r8WEy0kMeEzWm
   h8JE7UQ4pGrr9itVT/somfAUUOg7SKrK/TmHAmyaH3sdQdIsjPtPYyq+I
   O505jP8Dbjowh7d74p5hCBc7RXKS0tj+8NRf5H1xIvdlTi8B8Lra4lCG8
   WTlN9yJrO5GofT7TwSjovKnh4oLXUmGMqYI0A8w2H1O8W4tdEOpDoA7gg
   g==;
X-CSE-ConnectionGUID: Xi5YCOoGR4uMU8WRApnuoA==
X-CSE-MsgGUID: JDeuwg+oRAuSAm0X2Z1rvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33537797"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33537797"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:50:40 -0800
X-CSE-ConnectionGUID: oE10g6pQRGG41ICJVEHVnA==
X-CSE-MsgGUID: 8I1E0fcPSvK8z7DQx1pxBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="93707323"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 09:50:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 09:50:39 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 09:50:39 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 09:50:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHlw2vikRftwGF/aomCelyJE8zhNNrmDlvkWyXeDUWOohRPig0K8SdnGsrfEgWHtbUSAjYuv7x1B/RWks313mpXXKxD0mmsqfK4VxjpRkFXDV9BkohRfIT3MZWSXQZs3N1GQ7M56sx3gHEpS4Jgpel1eHCNWVnLz60g9HXEqJa5gXU7pdp7xZNPat0Qm1YeTQP3I1PQRwuHsU+NmDC8SoOZkJEE9S3hPW+rWPxKWfbkoLx9RypGx9WSlfj+7WJnY6iPdq/+IfcF+PF4ean959LFvLAri8XnMourWuBqpQNbd1oa1Yv3rL3/CrWjF5MHUH9yHFYSOHdSC1ngD5zfLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9dszDQ0zuniJT6nb647Bzm23N2dNlscF8xYao2BX4g=;
 b=RFK3G9uYoRYAMxejJnRAgynsdI2C2HBN3WTgYnB7iELJ9ncUrtRiP/yq3KxacQmXe3Hs5MaKrn24D9rPONQGHByA28RVK+WqUuIYa/ozhRhlLqHQ7GrrG7oGO2RecZROfjzw6wa5U6pqtCFm8KF56NwFcIEUcgSGZ7e+32TKdrX1VbQG/lNC/seqcXdHSwuVmUfhWOVMLxaIldBmTT7mIP3ed2g/dEkwrHLx39BStTnrscuRGndkT+FSeDRJMqa5cSbdlhnsH9SLUgr+Z77I/8ZwJEXZQ7bS9OzjZgO9/DptPpbQdb13Hf3zLuc6XAGF+bDIw6O5Do/L3mGM57+ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7057.namprd11.prod.outlook.com (2603:10b6:930:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 17:50:36 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 17:50:36 +0000
Message-ID: <7c454873-297d-4a70-ad37-975d2f22864c@intel.com>
Date: Tue, 3 Dec 2024 09:50:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/9] lib: packing: demote truncation error in
 pack() to a warning in __pack()
To: Vladimir Oltean <olteanv@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Masahiro Yamada
	<masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-2-ed22e38e6c65@intel.com>
 <20241203124316.er7w64rdkc4nedno@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241203124316.er7w64rdkc4nedno@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c73331-df97-43f6-fa23-08dd13c2fd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uk9KdGdyOUJXSjZRNG9EUXk4SHFBYlA3bVV0MzEvYXJpNkE1K0VubE1YWHdK?=
 =?utf-8?B?MzB0M1N3bVdXMUFLL29wSGpLZ3hxYkJYbzlDZERBT1I2SkFNdTNYYTcrelhh?=
 =?utf-8?B?WE4vcjh3T0ZHMGVZblhvOUM2d1pjMmQ3aVJ2THdZUkY5V0VRWTBTN1FCU2ZX?=
 =?utf-8?B?NHB0cHpiWm5qdCtTRVZzUkI4MmNRVG4vZ0Q1WVRLb3g5V2FVVzBId1Z0dVB0?=
 =?utf-8?B?cG8yVUhDWGNQNVBlWEtCYzEvald1cXBkWHFsbStKRDV4ZUw2cVhwdnpuZDZp?=
 =?utf-8?B?aXNmNnFDWnhWeGx6STE5WTIwK2JKYmJOVTd4UExyWkl6MlBmcVdqc1V0cURs?=
 =?utf-8?B?enhUYUlPcXpMRG5vejF0bVViMEpmOVNvNjBaWVR5N2owNUdFOGEzanRiMisw?=
 =?utf-8?B?bkVlWGVNM1liMkJZeG1ienl3ckZCa1lYc3RaanVmTHZTRDJkSFhrQWNzekFQ?=
 =?utf-8?B?TTRUZmZ3elJwVk5mZFZkcjRaa3lzU2lGUGIyUWJEdis2OTNRZFRSS2pPbXNz?=
 =?utf-8?B?Y1NMSWVvUzh6TDBiSGxhUEtMaTUrOHJwMzhDRmJ3TW1zZXR3cWwxbisrc1JR?=
 =?utf-8?B?V2FGUlVIR05lR1grLzNYeUJOTTFRRzZyKzFqbzlGNURJNW84TjNwQXVRbjJ0?=
 =?utf-8?B?K2VzNTNtVktlTHprUXlrRS9rVmg1eWJFVXp4Z05lUGxsUjFuUzhGbWVZYVVT?=
 =?utf-8?B?YmJsN0FtNHZkQnFPYW5kejZrUmc4TEZqQU95eEkvOWZwTklhY1JYT0NobmpK?=
 =?utf-8?B?aTZheEwraElGcU5PempWTG5nd1VpOG9iYzUrbjRCWVNMYmdZbjJ5MzlwLzRz?=
 =?utf-8?B?MHFKWEp6MDNHQnZERHV3TFZub2hCeU50L0laYjhVWUhCQW9oQkZlV3hjNGE1?=
 =?utf-8?B?dEphcGRiMjFLa2N3QXJTQ3Zqd29TeGxxekdlYXdCMmQzM3hHTURTSUFRWStI?=
 =?utf-8?B?Q3pkSUU4Mjk4NjNyellpOHM4VFBqME41Z3U1NHJ3S2tpTFBDV3RWbm5FZ2lo?=
 =?utf-8?B?bnhpZEM0dVFDSWgxd2thejlFRFhmUUN5WlRnTDFMVUM5V09TdHNKbVFEUzNu?=
 =?utf-8?B?Qjlhcjh4U01QWHJzMXVYNHZhSm9GUDNsdmRhNGcybjU1Y1NPdlkwT0pua2pF?=
 =?utf-8?B?T29FRGRvM2lvM2w5bDYxVE1ma052bHovbUd0TnI2ZE82cStsUW9nVTZ3WjFQ?=
 =?utf-8?B?NS81WEF3VkNhUGMrZDUzcDd1RDcxNTdRTFhERmdVMG5Ddi9uekhrKzcwK1Z4?=
 =?utf-8?B?c2IzdlhmZEFyRmY2T1NzT3E3ZEsyNEIyNW1BN2RhaVdibnlpSTVGN2ZCVzh2?=
 =?utf-8?B?ZGQ3bG1mVi9FYmlJaWQ3UWs4aWYyVjM0WW1sUTJMZDMyMDd1UmlyaVRzSjRR?=
 =?utf-8?B?T1BzdGFGZjZ4SnBlWWNUV05jZUpreTgrWHhUeE82MkZGa3pZTlRqWkJMNFNm?=
 =?utf-8?B?VnpBTjVnWGRQVEhVVXZEQ0JMSnN4TjJOaElFSXZaM1lLOXREbW9teG1kUE9x?=
 =?utf-8?B?eUFxZkRKUnZscnN1cTBEU01hTlNVODdBaHN1Q2JxSkhBa3VHVGhJb1NIRStr?=
 =?utf-8?B?M3NiZThKa1psSDRpek9KNHEyZTZKWW1nL0FmcnRqUEZiNFJIZmFYNEhQRDUy?=
 =?utf-8?B?NWJBS2psRk90OVhSVHVnRzhlc2N1dE44TzljWG1jblJkSE5BOE1acm9yQlI0?=
 =?utf-8?B?NjBDQ3FYNlVxWEFmeUFoMEZkb0t3MVBmMzQ0RGFDN3JiYnJoZkozQzM0a3Z3?=
 =?utf-8?B?dmZSYUF3NjNGY2JQQUN4ZDdqeEM5ZzZVaVpzaGpia0M1bWgxWlNDUk5tU2dI?=
 =?utf-8?B?aFI4ZVJ5V2d3anhSbDBNQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9tOEYweUw4YzNvZEU2U1pueEtUbEY3cjN4VjdZVkcyTEFXVDIvMEtBWWN1?=
 =?utf-8?B?RkZhUXRHUjdzVWVHcWo4SlBFS0UweUV6OFhyYlA3NzFrdGRSMmZtWmwrL1J2?=
 =?utf-8?B?SmhqOFlXUUV0OUR4UzFBaWduTmgvd2I4ZWViVnRXdjR6eGNjYjRuVUplNmkw?=
 =?utf-8?B?ZkF1b0pvYytXYU9WK0hDY0Zzdmd3eWdBOCttdjBicDkxMDcvV1FWeUFOV3BJ?=
 =?utf-8?B?SzVDcVhreTY1dDVYaDNtQVhXRHlidDczSkQ4TkEzRWtiVW4xdzZFOFJGL2w1?=
 =?utf-8?B?eUNEN3V3R3FYdlRvSm1MODBPUVRSdmVkMEtNbkRVMVYzVG1adXg1QThUZ2Ew?=
 =?utf-8?B?aVk5OE94UjMyTmhOalZWb3dOZzFpWmdzZ0FLbC9nckJ2WWZ2YVZIMDFmWXN4?=
 =?utf-8?B?ZTdoVGlnYXdRMXBFQTZ5bjdEQkp6cElFRk1iSkIxUHBKMGpqZlRRaExlZEJa?=
 =?utf-8?B?dE9nMXZKRFBJMDI0VU1WNm5Fa1ZpMGNaRm1FdERMeFVZdXV0clBuMkxUVEtz?=
 =?utf-8?B?V3VGdkxDMUFMZVg1ZXUwUXJ0Q3VibWNBVGVoRk9tTGxpMlBqMGwzM3J6MlFk?=
 =?utf-8?B?UFZIU0lUcjFSZmhMMi80RE5ETzZ1V2ZobGlNUW8ramlzV3drRWtHbng4SHU1?=
 =?utf-8?B?WDFyK2xHTUhpSUpHeW1BWG5rME9UeHVPQlVydnpMZ0dNSzJUdHNQNjRyVm5B?=
 =?utf-8?B?eXNkcnlaYmN0WFpYbjZxR3RiVGpMOXkzL2lDajh5bVFJZkRNMFE3UjhnWGJ0?=
 =?utf-8?B?US9ScXByK2NyWUorK3FkMm0wWmI2VXgzWW81bm5makkrelFKd2RWMTRuRXcy?=
 =?utf-8?B?UVVocnZseitrY3ZDTUpXbnMwMmEzQU90a1Raa0V0dXVUMGM1akM0VlBueS9p?=
 =?utf-8?B?bWRaWnJQenlsYlYvcElwOVR3cGY1K2dMcWNyYU1hT0dyUkdXUWs2dXhmYnJa?=
 =?utf-8?B?L1FBdFpESDNRSEw2aG92ZWpudzUrZ3UzcGxOUzFtREI4UVljbFlaZXE0ZkZK?=
 =?utf-8?B?aGdEQ1B1M1NOczNteElDYVJaaDJTQStvY05KWGNyTXZGS1NpNkhCSDdoanBW?=
 =?utf-8?B?WHd5Wmh1cDVnQUg4c3BxYzI0YVJjSEhhdGN1Q0pkOVhiQk9LTnN4ZnAyWk5h?=
 =?utf-8?B?UzYwckRPemZvQmJBdS9xd2M5OEFLeitQU2ppN2hiQ1JwOXYyY3h4RG5DMWtE?=
 =?utf-8?B?VDZhSms4Zmh0WUhwOFpid0xxb0lJQ3BJNUdpeC9UVUkrZUlrTG5HRjBxckpi?=
 =?utf-8?B?OFVoeDRDWEFjRmpRcjltRjdXZDV1NUZZS0ptRDFvT3BhdG5Md0JqV3Nrb1dv?=
 =?utf-8?B?dTFyTitZeDkxdnlOR0Y5dS8yUHpXYTdpWHNpeUZGeFljU0dOUkpsUVp6aUdr?=
 =?utf-8?B?Z0pnWWp5b2ZaZDF1TTBYeXhBRUlzdkltZXUyU0JZSlBtd2JxRlNUWkRUTldL?=
 =?utf-8?B?ekYzTndpUFQ2Y3BuYmhjRGtMT0wxT2NhdVhnQjI3elNkQkk2cExpMVJCcDdi?=
 =?utf-8?B?RHNtU2Vyd3B6bFFvSTh3VE9qV1Y2L3NLVDIrVDBhUVhyQWhkNkRFN2JWeWFS?=
 =?utf-8?B?cDV4M3pLZUMyd0JBOFFldkdLaFJrYjhjd0ZUd2U2czNsS3dLWDlOTXJrdks0?=
 =?utf-8?B?bzZZT3pJRUdUeVg5MHh5K09vNzJOWkhDOFdZMUlsM3RYbG9uQjZhNC90RjJh?=
 =?utf-8?B?emZRT1JLbEtjNTREbFJZT3ZjOXlMRi9RVDA0SEFReGk2ckUwQ0cxTDBOU3I3?=
 =?utf-8?B?L0l6WkxjdENDZGdnY2QyWTc0Q2ZYSGtpQ1FrWGl5T3lWdVFWTVNRdVVONURh?=
 =?utf-8?B?MFN3eVdWYlp4bk9oMmFEWlp5emZGNHVsQ0V4VlE3WjBMRjRYaTY1N1VLbnFJ?=
 =?utf-8?B?andVZ3NRekhrQUpiU3RCcVhwMmlKaDJ0d2tKUTZuTFJBR0E3T3R1QTM2MGx3?=
 =?utf-8?B?aXpjdmx0MkxEaXlQMEI4by9jUUxVMXZnbVF6SVhJL1ExWklXckRJNVJRRUFG?=
 =?utf-8?B?K21aMjI1aDB4aWJjekF5Yk9La1BncUVVblVMeGtnV2lyd2VSb21nL1hrUTRM?=
 =?utf-8?B?RWwwZ3JOQUEzMDZoNTBMNWtjQUczdTM3QXlyN3pxOWhBUzk4TW5xV2dmMDRI?=
 =?utf-8?Q?tk7HuQls4Id6mKI6f8yawYVCp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c73331-df97-43f6-fa23-08dd13c2fd2d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:50:35.9058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8OR2pfbq4uM/JFhyGettJgpfeCdoSdXtplbAASkqantrB3V3XxKsOwPFMwlwhNExKckYv80lPtsEaSdDgO3pwHfzD4oN0d/80WcnGw/sls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7057
X-OriginatorOrg: intel.com



On 12/3/2024 4:43 AM, Vladimir Oltean wrote:
> On Mon, Dec 02, 2024 at 04:26:25PM -0800, Jacob Keller wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> Most of the sanity checks in pack() and unpack() can be covered at
>> compile time. There is only one exception, and that is truncation of the
>> uval during a pack() operation.
>>
>> We'd like the error-less __pack() to catch that condition as well. But
>> at the same time, it is currently the responsibility of consumer drivers
>> (currently just sja1105) to print anything at all when this error
>> occurs, and then discard the return code.
>>
>> We can just print a loud warning in the library code and continue with
>> the truncated __pack() operation. In practice, having the warning is
>> very important, see commit 24deec6b9e4a ("net: dsa: sja1105: disallow
>> C45 transactions on the BASE-TX MDIO bus") where the bug was caught
>> exactly by noticing this print.
>>
>> Add the first print to the packing library, and at the same time remove
>> the print for the same condition from the sja1105 driver, to avoid
>> double printing.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---
> 
> Somehow this is missing your sign off.

Oops.

