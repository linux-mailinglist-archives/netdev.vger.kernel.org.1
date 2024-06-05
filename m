Return-Path: <netdev+bounces-101144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AF8FD78F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47EAC1C21DAC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A5F15ECD5;
	Wed,  5 Jun 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdYzRiQS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AD19D89D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619630; cv=fail; b=eqNS7o5/SG1XpRjj7QExT7QFFixSGxTW1o/rde3qfD6iClBNhKRsqvbO4lkQ9tkcaSXrJRXFJZjVFUgePvcf5P8A7BXpZLNZHxgso3fu1OUsqPCHp2zmOBKPNowGycCX5SPxtD4jOfwf+oKohL4XlQZVkcN9VWArebXMpQWg8mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619630; c=relaxed/simple;
	bh=quTPKzz3otLfSN6/t7jrDhE25zbO7E7TM4if5wvulQg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ar2Ca0WGoSbGe0ijvEdJ0AMS17aXIXidmRzIs56D/NxzJrdK34WQ7TjunNDSNz4haIb2ygPQYjdCt8T9iNvbkcgRwbtbOG44M66V4Z1DaDF95YpZDTPkY6Z867I8EFLP4WabVRJR+ie2d5XR5fWkvtvjrBhNrNSb8TUI8UUxbso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdYzRiQS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619629; x=1749155629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=quTPKzz3otLfSN6/t7jrDhE25zbO7E7TM4if5wvulQg=;
  b=BdYzRiQSUjnTUwgo/U7/97DbryI41jv/C6XN/HosRlhDuiCBzlEGZPfH
   CGA/Tnhsz3UQzgfgxFCXiJKcL42AWbjrkKGJRWq75OnkiBl46LouNJOL5
   vov2GTj0S4y9MCW5lyyG6Wbc12oluXHMdz6ZUCIRTfYGDYWVdr+OWUpdk
   degwhDWjyX3cGu+NmT78vgUckCK1UK0YI03HRYw9WJL6lnGwwNwbqrQxq
   okIgvKIZb3yMQBdkMZSFt1Ffc81EhFLnvZhOuFSByfDGIhEvmqWUocBwy
   jxbCQrPvw+0EgAxGDxbvKoC3Q0bbx6ek6R7EF5SqASJF+YTFCCOxryLAN
   g==;
X-CSE-ConnectionGUID: /tAVyG8tSvirbv+tvV4YYQ==
X-CSE-MsgGUID: qoH0Wu1ZTiGxMQWbM2XZ7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18102443"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18102443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:33:46 -0700
X-CSE-ConnectionGUID: wmSHhfh1S/2iuDj+ZlOpGA==
X-CSE-MsgGUID: GqZNIpNbR86g0FLJmUgtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37822637"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jun 2024 13:33:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Jun 2024 13:33:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Jun 2024 13:33:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 13:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBbyrdrp46fFU/2H53dLsppDJV58jgbB4TzhHdrLhOHwpn2G5l/hJjC6casJCKBi4mP6fn+v7mZyBBi70vTs3gL92a7LgBDv4H35V/nULT/Fy84/ZZ0vu1+Rgv0zyFwEvsKGQBe3021zWk0/M4dppt4bjRHIBnVKVwh2jZYhzlPFOK4vwkx+Mi8RfcgADGpbCrC5LSypTI3nTIaBG4g2Lbv8ekx1IC6pAISqp+jU+VWuVvjaBJWJx4YBDLzE7nMaPRBm9WaoZIOn5z6Ft5+gYcNDpvai3aY02gu74AO8izUgXbsGimpuDB5l6ekCACKEvEJQHN945awjroIC+Bmw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax8BqXqo0H3fQPrOjjzuq21UEH3GI2IQ8bGBzg/MJtE=;
 b=eUEQNP+dotpyI9dArdyTQoi+Lo5c+tVaTkPdOIBWXFzBaUpgEZmEeGGknOXpZUrLnTSK/mfrBX2Lcmt6OrFbfgFwC4IXKFdW8j4Oxm8hInhgggBIbe8qIjhvtr+oS1twRpBNYdMfy3Qed3YVkJVeF084kyv1kMjOWX/wyVWXrilZmLf4MAzLuzSFu9Cr+IxFuRGePCag9KDtMUe38zxkaUMsXtdFBOswEhPYPUAZcMYl0+MROEowCGIpgOXiwAnG1Kaozt7CaSOzfX2qfiy3u/57QBLXpl4iUQLMGwhMx0Dac02xVTCi0G3+Hmd4n3XT2ITu+FNRmvG5vRFFwi5kbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4975.namprd11.prod.outlook.com (2603:10b6:a03:2d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 20:33:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 20:33:37 +0000
Message-ID: <ec1d55e0-f8df-4db1-a8df-22eab733e107@intel.com>
Date: Wed, 5 Jun 2024 13:33:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] igc: add support for ethtool.set_phys_id
To: Andrew Lunn <andrew@lunn.ch>, Vitaly Lifshits <vitaly.lifshits@intel.com>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Menachem Fogel <menachem.fogel@intel.com>, Naama Meir
	<naamax.meir@linux.intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
 <20240603-next-2024-06-03-intel-next-batch-v1-9-e0523b28f325@intel.com>
 <f8f8d5fb-68c1-4fd1-9e0b-04c661c98f25@amd.com>
 <dc0cc2ca-d3f4-4387-88bd-b54ea6896e0f@intel.com>
 <d27f050a-26db-4f08-aa19-848ae2c6ed2d@lunn.ch>
 <65068820-f8be-4093-800d-cec673d55b9f@intel.com>
 <202e55e2-be5f-4c7a-955e-fd726963c19c@lunn.ch>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <202e55e2-be5f-4c7a-955e-fd726963c19c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ba2268-6a17-42b7-61e5-08dc859ec706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCtmTWszUkNVNFk0disybXNWZTFTUGZZbzdhSzZzU3FIeUkwL0JZNDBqRldB?=
 =?utf-8?B?Y3A1SmtJd1BmSlRweUppejQxc3p4ay92Y3I5SHpvTVhWS3dMbk15VFplVXp0?=
 =?utf-8?B?ZUpMenMyL2FJNmMyeERTRDYwVkVsNmd0UWl1d2NPbmxoaE9VeEwzcnZEdHRI?=
 =?utf-8?B?NHJoM2t0T0tMR2VnV09ETHEzV0tqTm1jNHJtampOc3BBWjRsWlZUR1RGOCs4?=
 =?utf-8?B?TFFFbVBHUzVkRDFwOWZrSFAzaStBeDdpaFErQ3hObmk3c0RPeVZnTXJsOTBK?=
 =?utf-8?B?NlhSdk9sYnBwUmVucmlmV29FWkhqVWNYK1FHeENWZ3hGNm15QVpvdkc4NDhZ?=
 =?utf-8?B?c2FScUJqTnBDTjdJK0E3bFhTQW51OHpOSis4VjFVLzFXb3lROGJEWW1IeFl0?=
 =?utf-8?B?dExYMFVINUZvL3FObkwrTnU5RmRhb2ZuSlVYSFlqdGpZQUFNQ2JqRFlRcXN0?=
 =?utf-8?B?QXVZQzJUNXh3RUZieEQwU1dPTlpKS2lIZjZkbXIyMEEwdnAvdnpPZFhNams5?=
 =?utf-8?B?UXE2OWQxYVRWN0s5OFZybkhxNi9GbjhNZzRraXBCaFBqeWowVmFGb1BlUUxQ?=
 =?utf-8?B?Y2UvbndZMHpXVFJxWUlGUzVCYjJQekExTzAwN3lGZjN4Q3A0aG9ISFFWeVVj?=
 =?utf-8?B?b01qOHVHOFJYQng0b2VnYU9raDVSYlRYelUwRHJyWTNuSE5xV1VnNW5IaVR2?=
 =?utf-8?B?SGhzV1pSOFRXckJnRXNTdFFFVnVjUHpFaHBaQWNuanZoVE02dUk5TlZhWVA2?=
 =?utf-8?B?SGVlcWJ1RGI5U1l0OVBjZDh5UENPOU9yKzZncUZxcHFGazBiUmhTblRsTzFh?=
 =?utf-8?B?amhscWdGMG4xMDRBeXVtWnloRE4xSkN6cTZyb2NXcUliQUpLbi81cW5SeTh3?=
 =?utf-8?B?Vm5sb3BwTm5PTnRnTlZCRkhWOVdVd3F0SjVTbGpNNHlieEpBK1JUVk8vSVJh?=
 =?utf-8?B?cFNJNVFGRnhEWERHc2hDZ1lVcFZLVVBVd0p1SUNKOVRNVHBDL0pqQnQwVzZs?=
 =?utf-8?B?SlE4Ri9iL1dOVS90d2JoSzIwNVkyenVYb1ZrNDg4OWQ4UkpENDhCeEVFL3E3?=
 =?utf-8?B?bzU3VGg4djYwOTdraURnT0Z5OVZkY1pXMnUzTjFBMExYRWJ2ODBCU0Fxc3Ex?=
 =?utf-8?B?S0JiRDJpSDJreFMzL2pDOUFSK2FMNjVndGROcHR0amdzMjJlbWNWTWRMZGhE?=
 =?utf-8?B?WSsxVTZYUGZURUlJOG1zODZyamVkcnR0ekxTZ2h0VS9sY2dzUklOUmtVcHVJ?=
 =?utf-8?B?cEZtbWNQOW1zMmx1YmF6MXZmQjd6eXFMMElGMEJkcVJOV3RaYWdvYTFTbkdw?=
 =?utf-8?B?bUpLcWNWbWtXQlFZSnFaeVUyT3lyd25WTjBXZmlFWlQwSFVxTDQ2OTc1bGFa?=
 =?utf-8?B?OUFQeS9sVXFkZEc5MlZOU3Vkc0xtVVRYaUdJdXBqcFFjTkpremRLVk9EMW5J?=
 =?utf-8?B?ZVBFZndNYnBBcTBRZkhPblhuWTIyaDJWQXNWNkYrbm9UUUlsWm1SRFBwVmtN?=
 =?utf-8?B?WnNtZExWYVlrM0kvQXZJVFB2QWZhdWEvdVhsb0ZTWGJqUjF2MVpvRkc3ZHE0?=
 =?utf-8?B?eHhSVU5LRVJqN0xEenZmY3laUitoT2RlWlhIa2RZUm8zbDZET1YvTzZUdkJC?=
 =?utf-8?B?MndWWGVhbEc3dGU0dEpjYTdSWFZva3F3L0NraFlKNVdYUkFIU3YyV1NUZzF3?=
 =?utf-8?B?eGVtZ1NxZDgwTHZSWjVDampMN2wwYXlGMlAyZ0FOY0pSTmxGaUFXZEt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVgraXV0UW01d2ZWRkE3WUFMSm0xZWlXMktsbG9mdkVHd1BmeXN1R05EVEFP?=
 =?utf-8?B?VC9TSkxFdWZzVHhQeHVJSVkrdndVU3JKQTRBbmFYcjE3eXRseXFreE9HQUVL?=
 =?utf-8?B?UlV6MkV2MTY4OTFXQUhpSFB1SmdicTByaFFvWnZjamRPT1RGYlRjb1NCczJ2?=
 =?utf-8?B?VitKZDVjOExQdXJtQzlYWFZiQ0puQkc4MFFoZWRMODNpdVB2TEcvc3F6RXFW?=
 =?utf-8?B?Z1JKYVVOeEFwWDVUWWtXOWJUSW54Sk9XNFBYd1VoQXdOc0VubXV1djBuYTk4?=
 =?utf-8?B?VUJWRVJnaWlla3JDWnpuVFBiLy9Qa0RjM1RKV1FHclc3ZW1jQ3BlUklEWjJR?=
 =?utf-8?B?ZGplY2RwT3Z2elZaOTlyYWhkd0wzRFlOc1UzT3JLTzg5cTMvc2FreHlNTU1F?=
 =?utf-8?B?bmtkdVZzNXgxMHE1YXhqbG1TV2JucnFZQzA2L3J2SHU0aE1yb0lqemJBTElN?=
 =?utf-8?B?M2lLdlkwbFhkL0dHZVh2bEJGSm92YTZLdTMxV3h0dVkwancwVmhXUXBwV2Rr?=
 =?utf-8?B?STV0WHdEVW9NMWVja3Y2RVAvVEhYSk9pK3V5V3U2SUxlQ1NBb0hndkVmd3d2?=
 =?utf-8?B?QzM2d2M0QmUvUVBvdUJWTjNqNmhxcEN3TGFRbUpxUk1hWjdad3dyUUxLdGN2?=
 =?utf-8?B?dlBCNHlueXVERDF5cWRDUFJUSTc5aWNHVEFLUmdjQlFGNjlwdHhRdzZNWXgr?=
 =?utf-8?B?TlFMRGtYRGw4dUUwRG5ncE5JbzRQYWVUNVphbG9xRUxyS2ptS01GeDFVWHJj?=
 =?utf-8?B?VU5kOWEwQjNWT2EwSlhWZFQ0Q1lNYVFLSUlabXY3MWxWVXF4UTMyY0I2cnZZ?=
 =?utf-8?B?NHpKMmRiZHR3aUg1ZkpINHA2bGNjUEdvZkExVHJYL21BRE9XMytvb2hTVHNI?=
 =?utf-8?B?ekk3VFRsVWdzUjdmM05kdG5TanBYTmN1cER4U0JmbUhERkkwUmszL0dYVENS?=
 =?utf-8?B?V05WcThTTFNzZmxWY0hHWkRIc1JaVHlHcGJ4WklqM1hmV3pQbEtKTWs4QlAw?=
 =?utf-8?B?RWRpR0Y0Q2FSWUFQbW9xODhGVmFISGozS3k3U3ZPU21oVWZ6MGt0TlB2d05J?=
 =?utf-8?B?ckREdklnTnZDejkrd0RXalp4eG94T2JZblV0Ri8rWmw0Nmd5ZVJDVnFtV09t?=
 =?utf-8?B?TlRZd0hMN2FlbGxZazVPdVlNc2lnalVMcVdPZFdoRVZ3VFVZcUpYenE5R2g4?=
 =?utf-8?B?bmo3QmdRc0FPT1dkeGxVaVlBQ3hmMDdpdGNaUDBpYlVXTjk1NElUSkRsME5v?=
 =?utf-8?B?R25IZ0dUZjlhcE04YzRtSFc0dHJBRjNhUnl2UUJXMmgwN25pNU54Rkp5WHox?=
 =?utf-8?B?cEhDWUlEWmRqQk5RZnMwRytiN05JSit5bGRCdWZYK1prWmxxczYycm9lZUZU?=
 =?utf-8?B?NFV2WitQemNGUm05SGlhOUk5eDFOUEhUUllJUndtRWV0SFlNS3Jtb1BQVDZ4?=
 =?utf-8?B?eXl0UENGZy81YnJjMXN6ZU93Mm9VYnFzazEvRm11L3RJdEpZQ05aVWhMeG43?=
 =?utf-8?B?OUtvV0cyNXloV3FSeHBkM0p1a0lEMVVtRnpvbHNFdHdMWWZBc2kvcU5yNkd0?=
 =?utf-8?B?QzRPcUxjN01vRlBHZFJMak9DV1RYbWRwcTZ2bDJsZ0Nxck9seG02KzVZZEN3?=
 =?utf-8?B?UnhVOHhkZWtEVjZ6UU1ZWjcyakpCbXpuUm1hVnkxamh0aEhROGQvNTNaY3lp?=
 =?utf-8?B?ZzhGOGVMdlVxYnp6QVdvNGRObnpldCs3WUVLdnB0Mk1oaFdFM1B1dGRobGVu?=
 =?utf-8?B?NjJXOXdoYmF1ZEJrL0JqQmJmZHhzWTZMZE9wZkk4cWxXNTRSWFdOTzR3QUcx?=
 =?utf-8?B?UnZpMnVpc0JnaTdlY3M0aVRGY3RKdDN5VER4cFF4dER6TlVCaFBmOWZEbmd4?=
 =?utf-8?B?bjNyQm9aV1pYai80VEhta1ZoekdzSWtReWIwNVRkankrano1K2JJRnN3ZUxn?=
 =?utf-8?B?YVRaT2NnUnNTU0IzNXlpTE9sdytjbkxPdXhJSkVLSTNHS00wMktQQVdQdG56?=
 =?utf-8?B?UHFqRSs3MEE5K0J5eDQ2VEVacU5vMlBNWFl0RjJQK3VUUDZ4RzBqYVB2eXE1?=
 =?utf-8?B?OWc5TUVWVDAyaElnWUNYbU13RWxCR2l6NXlSTGc4clNFOEZoUjdxOUdyNVVw?=
 =?utf-8?B?Rmo5YUl6OFVEK0wraTcwL1lkelc0VWVCY3pweWplQ3pnMGxvcDdKTmU2U01B?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ba2268-6a17-42b7-61e5-08dc859ec706
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 20:33:37.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXL5JX2/DmKslJYkW3+C7F+8V1qee2tCHFZrrhU7THglH56saBW9l5zoZAUjCKa3eZwv0sZ6Wbc5BAFBKREK7lvY+1Q7mmjVf0Lo7Tx/UIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4975
X-OriginatorOrg: intel.com



On 6/5/2024 1:31 PM, Andrew Lunn wrote:
>> Maybe I'm misunderstanding here. Are you asking us to expose the LEDs
>> via some other interface and extend ethtool to use that interface to
>> blink LEDs?
> 
> The LEDs are already exposed:
> 
> commit ea578703b03d5d651b091c39f717dc829155b520
> Author: Kurt Kanzenbach <kurt@linutronix.de>
> Date:   Tue Feb 13 10:41:37 2024 -0800
> 
>     igc: Add support for LEDs on i225/i226
>     
>     Add support for LEDs on i225/i226. The LEDs can be controlled via sysfs
>     from user space using the netdev trigger. The LEDs are named as
>     igc-<bus><device>-<led> to be easily identified.
>     
>     Offloading link speed and activity are supported. Other modes are simulated
>     in software by using on/off. Tested on Intel i225.
>     
>     Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>     Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>     Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>     Link: https://lore.kernel.org/r/20240213184138.1483968-1-anthony.l.nguyen@intel.com
>     Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> The Linux LED subsystem knows about them.
> 
> The Linux LED subsystem also knows about the qca8k LEDs, rtl8366rb
> LEDs, mediatek-ge-soc LEDs, air_en8811h LEDs, broadcom PHY LEDs,
> Marvell PHY LEDs, dp83867 LEDs, etc. There is nothing special here
> about igc. All these should be capable of blinking.
> 
> So what i'm asking for is you add an ethtool helper, which implements
> this using the Linux LED subsystem to blink the LEDs. The same helper
> can then be used by other MAC drivers to blink their LEDs when they
> use the Linux LED subsystem.
> 
> I'm sure there are a few different ways to implement this. One could
> be to extend the existing ledtrig-netdev.c. Add a call
> 
> int netdev_trig_ethtool_phys_id(struct net_device *net_dev,
>           		       enum ethtool_phys_id_state state)
> 
> Which if passed ETHTOOL_ID_ON, ETHTOOL_ID_OFF, ETHTOOL_ID_ACTIVE,
> saves the current state and then sets the LEDs associated to the
> netdev to the requested state. If passed ETHTOOL_ID_INACTIVE it
> restores the previous state.
> 
> 	 Andrew

Makes sense, thanks for clarifying.

@Vitaly, please look into this.

Thanks,
Jake

