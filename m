Return-Path: <netdev+bounces-185644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753EA9B320
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CA465F8A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B05527F744;
	Thu, 24 Apr 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKWTVVoS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE627E1D0
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510116; cv=fail; b=nQsEGebDxe6SiQQ19sx4Gfrx5qYkwrsl+OdNF3NzmmGLEB/rAzmjSyU2hkBFMJVSdkR1C4Tf3VXWqEUYAyi5wLw+WfWjkKjiFhGGdsBUnyZvN3cFq6koG+PBpvxw0rLaPXlOxNc6f6VyUKPZUzHcOf3vi1dFFTDcnE3tpC52CFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510116; c=relaxed/simple;
	bh=0FJsdhI3qyGJKyPhkdG4d7FggY9RxNVxsCNP5v36y18=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfRZj9g7G4P54qbEJUgT8MlKmUt1fnOHvBamjwZSCj2O4BgWyKLAzRYZalXH7ewdhDfWC7xVBlS3A1ncbm3SqVAb+CeXE16K5rSPsMyCStXES+2DgFaJwXj8AKR6AGN5F0zbzEUKKBba3N20zjb+06zbN0X8+ooZMRyRAdAylGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKWTVVoS; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510115; x=1777046115;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0FJsdhI3qyGJKyPhkdG4d7FggY9RxNVxsCNP5v36y18=;
  b=GKWTVVoS96lrGPXT/0UVKeO0YEgq8ARxoFNzwzNY+a9XyKSPCwXRzc2u
   3X2sw1j3DtsWDKY6sEiMq9PQMAjk+QMD5MhtHGhpZJoIQ6dHthEfeEvKr
   ITTzdHkngopwg8AmyPwo3QA2CuOYlAlZ/rOS/Tq4+SjnYzwFmVPR7FXab
   Y0gQZ9muMfdu8NmZiqw4JccrvegqydCmZOdMT9EAwo8xtK5yvx9yFEmKT
   UNgQ/OAldXpdkJC2ElZhvUy6cS5gau7EBAlIlbWkiy0ASTc9QdvyuhLqE
   GwpC/kp2PuhxDDb0bNE10GIeb2XhedRpzuReaUSOHiTF450fhV085YYJL
   g==;
X-CSE-ConnectionGUID: YsQd+FLHS3y3GLTWBPFfuw==
X-CSE-MsgGUID: UPsSYL7LQ4O0sKlFeiGsqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46273248"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46273248"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:55:14 -0700
X-CSE-ConnectionGUID: SJrwFh8sSf+yJgFyXLY90g==
X-CSE-MsgGUID: DI+0jU6TQiu+0CsvjFlUMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132963365"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:55:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:55:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:55:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHhXluaddlsKcsjpMoQ4HqAuaJ+WiKXUqrPppAk/eohhpntfVmV6U4c1x2divcysv85EyX/HT3Nsq6Fyokdz398SvgsfjfFfvotOM8qqekAq+WcQxdseg5tZBeTEiOJiY5DRnd8XkdOaq4rLwL+N0OrtkA88staAJvVZGQyICf7OSgl2pEA4I6eVYuPBV7QZ98ssRHi6D8/zPs1Hwpwts8MzqNG9fLbtQAp/hivndhrNh3k1dqeK7r6LHmqqUjY8jEUHYVDSNeBf4ykQZ8rw+OtVBM2OaR7CjP2OLODjzpBUHIsvoO8xuzdRRpJGevgJqtXOYbjIIsPWtjEfa5mLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXlfTNJVR+k1MheJhofd7eXvp2cFI+21DFzKZKjsNF0=;
 b=Rv8ud9xBRqW2BJAJQu3qQIfpMG4qPqd0wC2qnMw88rmOuqTOUMP4gu9nCJXu4HfJj+VoXtGSYC/rJo5/GtGb7ftI0SZ1P+LRSKwrBBwijRxHGDPnjfzGbN/sbP/UWhaLnv/3799tKk84teL4DvfF4TsCMYL+SvTQUNOvz0WWn4WDzqcG2h2EG29RlzYpZlFhSPALL9CSZyLRm5hSFNebuADcDWWBESkV+iOG8WCGEZexV0zewcITY6MS9Uwt+n0eNz74cbo2H9B6SQp/K+vBKr9c/O0qI4xxQQaudEksFrpGVt+x02erfhhh+6w0VnwQazx5skI9iEogGU0caWH7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:54:29 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:54:29 +0000
Message-ID: <eb9dd8d7-a17c-4fa4-ae80-3f53c4260c84@intel.com>
Date: Thu, 24 Apr 2025 08:54:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/12] tools: ynl-gen: multi-attr: type gen for
 string
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-8-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-8-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a82ca2-d2ed-4c93-eb4a-08dd83484bab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anYvREhCNmo2QkhmUWFIeTZzSzJVUnNweTNPZlpHbTgyRHZZRzV6Ym12VTRv?=
 =?utf-8?B?Q0o0UWxVWGVwOTVqNEUxS04rOXV6cWpLaG5EdWZyeWYzYisrWFZEZzV6TVor?=
 =?utf-8?B?SGF6T3ZVUVdySHFmRnRDTUl0Z0FqNTZoZFpzZlVEQVNEZ1VjZnBoZWZ2dUsv?=
 =?utf-8?B?b3A0ekc1bnE1ZlNFL2ViWHlicWZiTHFzWHQvT2tuL0dHaVlVNFFVbUo4ejU0?=
 =?utf-8?B?S24zT1JjK3d0ajIveDVzUmIzVzhNV0R6YlFqcU9Qc3R1OGtYQldhc3E1cGJV?=
 =?utf-8?B?SnRUSXNkOUFpOVVqczNxYWJHM3ZYV09OWlhOL3RpZzM5cDhNaFplNWVBSkZ4?=
 =?utf-8?B?R2ZzbEt6UDZWc3BhUHVvdEpudk9jTGp5TzlHVXZxUzFrYytVU3NjQ28rZ1c5?=
 =?utf-8?B?VXBQdElHTUMwTUVncDQyNzFqMnBZREtPK0dZeUErWEkxdXZxMUcwdzN3VHZH?=
 =?utf-8?B?R0JyRE8zWlo1VWpLazRtZlYxeGxOQUVrQ1ArUDRJV3VDRHNNdG93dVlQWU5r?=
 =?utf-8?B?WjdQUnRwMXZ3eTAzb1J0OHp1OGpzRXNaTHZMKytoSVA3VWY0Zk52ZW8vd2hs?=
 =?utf-8?B?SXdPS2loNVlGdms5amhhNXFVa3pONUYvY2xnUVBlYzEwNExKSld6NFBEeDg1?=
 =?utf-8?B?TG8vYW9qOTJNTEVvSWVKY3ZFSWZ0SUU0M3Z5TUFvVnlZUjM3QjdWZ1k1YTVK?=
 =?utf-8?B?UUNETHY3WTFVdjduK1FXVU90VUl3YlR2Z0VTOFN0ejN2aVd2Q2ZLVVRFdE4y?=
 =?utf-8?B?T1cvNXd5NkNRek9VVG1ydytiQzk0NHpHKy9aS1lHYWhDRlFac1lPSW9yNHNK?=
 =?utf-8?B?eE5UZ3pzRmdSaFFudVQwN2I3R3hiT2ZNa0NMQWkwb1ZLeVRhWi8wTkJXUWdM?=
 =?utf-8?B?L1U4Mk1GSUxqTWxBS0xaTHJUUktGaUZTTktCWm0wMDloUm96WkwvUWl3enlZ?=
 =?utf-8?B?QzJkM1hLODZQbVJpdVNKYlBqT3lzV1Q3NHRxR2g5VzNLWEx6R3BNd012S3VE?=
 =?utf-8?B?NlZtUXNtdWVZdC9sTEJseEVRaHd4bGdvOTdPMUtnaUttVm9mSzFzblI5Z0NF?=
 =?utf-8?B?TC9SYzRvdkNvRkwrREVRVGRwdUpYc3BERlBqWXNFcHBVcGp5RTFkZFRiVFZr?=
 =?utf-8?B?QXNTdmFxRmhNNWpaamdMMjVFTGFNYkhZSGg5RDlsRS8ydi9sc3crZGZ6aVAw?=
 =?utf-8?B?RkxyN1lpWXZCZGlvZTZ1MHBlRDArM0NLZk9oUmpmQmxicmgzZndtQlRKa2wr?=
 =?utf-8?B?R1JqT3dBeU0zTFlhODczS1I3OXFick5PWWFzK0w0a1lDMERBeE56NFVCM1lL?=
 =?utf-8?B?Mm56OStjU1RuM3JlYS9tczRrQzZVVnJkdWZEQUVOOTJETkZDb0ZEdXRaSUNW?=
 =?utf-8?B?R3BFY3BqT3AxR0NTQVdjUVFaRkFhS1pOSmlIMGZ4cFBxUFRGKzNKQTUvejRY?=
 =?utf-8?B?MHgvQ1FkMzhGdGlNeXNzdXRTSW5Ic1pLR2dVMmJ6SEs2RUt0dDMxK3ZKSndW?=
 =?utf-8?B?dytldlFhc2dubHBkT2RmekR6K3ducitiaWUrckR5Mjc1N0JxMWhrckdSZ0p4?=
 =?utf-8?B?Mk5LSDQ1dWQvRHVpclRYbTBDSTRESmtSQ0xENWxtb0MyN25MRkE0eGdDNUF0?=
 =?utf-8?B?TlJBdndzYVlPTkIvZ0Z4OVllVU0ySUpzKzlEKzZhbWNYOWtIS2JQYWFSbWtH?=
 =?utf-8?B?cGdWME45ZDBkUXVjOEV4K3ErMy9JSVdFVzR0ck9sZkFkRXBSb04xZEg3QnJZ?=
 =?utf-8?B?M0Q0ZWZIOS84bmxFT1AwUjgvNTdITWFVMi9LWWVzTFVGSEUxN2tTQTgxWXFl?=
 =?utf-8?B?cU5tK0VncUs1cnIzdXBUSlMxeXRLNlNQdm8yL0wybFE1cElycE44azVJYU04?=
 =?utf-8?B?Mjg1NUZIVG5lUXowNFlUN2M5UWpxTTRsd0FxSnViMGJtdVFaSFRtZUJaait3?=
 =?utf-8?Q?N1PyMvw17QM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c293OEtDZ282NGlzTlNkdlpxUVBoRWlsYzR1UThyRjBhamxhMmJxWm5rbXZB?=
 =?utf-8?B?bHNzNnhEalJBVFY1MWdudEVNa2RibUpEZm5LYXZlM011anA5OWsyQ0xVbWxU?=
 =?utf-8?B?VkowN0VFTnZNM0NsTUlqTmZyUnRjK0hCeW8rdnJrakVkMWVvS1NKNmJCaDls?=
 =?utf-8?B?bVNoMHdQQVRmaDViRlRsZEVzbm1uSTYrM0xpSUkwYW9BdW15cW9sRzdUZzJD?=
 =?utf-8?B?WW1WSXQzckR6ZzBlc0J4NjBqMVVxOGFKeDNYZWU1b2xQOTRTYmNXQW83V3ZZ?=
 =?utf-8?B?dlVBaTdUZEx0blZHRGFmbmFSR0ZvMzQ4dW8ralZmQXUyd0xKeXd6ZmRmU2hn?=
 =?utf-8?B?dDBVeUJsMHFtbkIyZk5LR1o3MWd0bElBdTAwY1JDRTJZM2dnUHZGL2VvT1px?=
 =?utf-8?B?aWczUzhlMGxQcDRNNXEzYytNQU1QU1dCeXltQ2F5M0NTL3pacHI5RXB2OXFx?=
 =?utf-8?B?Y0tlZnlnZVJzYkRyUXNsUEpsdW05YzdQc1IxWFVnWHFzUFNQSnRmYUxFWHhj?=
 =?utf-8?B?bWVHSW9RZFYrd0ROVmxCOGo4Q2UwSVdoWE9GNERZMEg3Njk1ek1xemIwaEpY?=
 =?utf-8?B?ZjFyeFBBa3U5ZXJnZHhQUFRiKzVmZ0NIV0c0bnVBVnhPUVFRSGZXTENqNkpR?=
 =?utf-8?B?bnR1RDZTcTg2TEVOUWlCbTc0R0VKTmdpK25EY2tzRU82YlNNcllXMGREYXlK?=
 =?utf-8?B?bkoveGtWYU83UnZUSWV1eWtESmR0dFluYVRrckF6VXFuRExRNWIzL3BDQzNI?=
 =?utf-8?B?ZndPL25RaVVlYkZKZFhyanBVRExQSUVveU8xWmhTY3E3dFltZ1dtYlFZL1ps?=
 =?utf-8?B?VmF0akF2SU1kcVNYSmVHcVNoOFp4SStNajhpUlFZWDVtNURoZG1FRFdYSm4z?=
 =?utf-8?B?SEJaa3pVUXZkVHpJRFNtMTU1dHg3RkJvNlpkVGdXWWpOVlV3NUFPZkZ3cnpl?=
 =?utf-8?B?WHkvTUJPQTVFK0xSTjBjNFl5VTdWSWVCYUdpZHhydDVDdTg1VjVud24wZ3hT?=
 =?utf-8?B?YSt5c0k5SCtERFFoUHBtd3liNzE5d0lYKzRvVmw4SG9adThvckRMQW91RjJs?=
 =?utf-8?B?cGxhZFpaN3ArMU1pSG1hczJNL0dBcjZRL0Iwajc2ZWxraUt1b3hUZHlsNlRP?=
 =?utf-8?B?Z3V3QkxCMFRIZXd3akFHbGhSU0ZLNmx4cmhBQ3k5N3BGNVhIQkFlOWNUNkxr?=
 =?utf-8?B?NnRVcjRuSEhqazhKVVdJbTZGSCtrNEwzUnlJbzIxcVd5MGhIV1ZSQVVBVXZB?=
 =?utf-8?B?d3R1RUFrZk8zYk5CdzFBRmIvOGNIbUpHSzh5cjF2Zmx4YmdJOXlJQlp4ZDYr?=
 =?utf-8?B?R1pzcXZKUnIvcVd0WEg1YkFsWnJUMk8wdFNRWm56WElaM1Ntem1VOEFpSngx?=
 =?utf-8?B?OEJwRHV4c2VnOWE0SDlzaXN4eHQvalB3VmVQOFg5Z0M2NHlmbm1ETFdMV0Fp?=
 =?utf-8?B?T3lRSURCM0t5MjEwT1RDN0FLMjlRRW8va3pFbG9JaXJ6VTFaZnQ3d2RCVHEv?=
 =?utf-8?B?T1dEZ1V4OU1TV2dWdlZXaFZwcXNESm1jb0paWFRGVHJIU1E4Sjc2Ly9iajVy?=
 =?utf-8?B?OWhBSmh4R2Y5SG1nMFR2ZTF0MDdOY1FYMXNKNnFuS0ZIVEhkSDBQUVRRSE9O?=
 =?utf-8?B?cVhuc0U3VHYyTkt1bTJDZHNPUlh2UXFxalptWnJEMjFrME1vNlpEWGhHcjFh?=
 =?utf-8?B?Q1VWMUw1dXg3Q1BqWmpFVEh0d2pEMU42am5IWDZmN3lJbncyRFhMajliQVVJ?=
 =?utf-8?B?RlVPaWZzcCtiMnBBK0JkdXh6NWFyc0F4dkRBR3dOY2o1SjhYSDh2b21oTHIv?=
 =?utf-8?B?YVN4bXdvVzZKWTluWDM5aXNLeEgzVStpNEhWcDlBblI2b0RWTUJVT2w3RkMy?=
 =?utf-8?B?bERrWkNNTWN4Q2dpT2dBU2txUERCZ3BUcnFBU29IQ2tEMDZzTWs3SjZaSzNI?=
 =?utf-8?B?QUc3R090SjRaS05FbWYxNWdyRVkyaW1TTGFNdVZiTG93eEVjd3JlRUhqdEs0?=
 =?utf-8?B?WmZ6ZW5LMlJyZUtpV3dFSzRLa1AvU2ZackUwOEJQQVd5NmhxV1BCdzhNc1FS?=
 =?utf-8?B?c1hnWVpzY2FQcTNQbXcvQUtQd0NLa2EyWWVERGVuTDVXZ2w1eGE1eUJQYXVM?=
 =?utf-8?B?MHhJRjFKRERvbGJQNjdHNFdVUFVJYlZhZUdnTTNBUy9tRXlHRHNOS01QbVBR?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a82ca2-d2ed-4c93-eb4a-08dd83484bab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:54:28.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bv/yj179Rw6g+PGYzaElIa/me+eLJUQXuFXvoYfvWplZSFy6DPuvd22NFz23Nt/kd5TdgmcgTsZy7xzLVshVhXNRf4dfNhooPZqawxPWrUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> Add support for multi attr strings (needed for link alt_names).
> We record the length individual strings in a len member, to do
> the same for multi-attr create a struct ynl_string in ynl.h
> and use it as a layer holding both the string and its length.
> Since strings may be arbitrary length dynamically allocate each
> individual one.
> 
> Adjust arg_member and struct member to avoid spacing the double
> pointers to get "type **name;" rather than "type * *name;"
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

