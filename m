Return-Path: <netdev+bounces-150840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE359EBB6C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB25166EEC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324F22FAD7;
	Tue, 10 Dec 2024 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFvEKVAF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CA1BD9E9
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864542; cv=fail; b=S9doaZVXX/bLDolqYAtvzdj4op4v5RWPiyBfWy6U6dSVG2huFmWGx+QlkGIeRMq58xgWoe3jwrYs+w/8JcA89zGafcXVeIEMkzK/KhYHOO1JzvmnfOPimFJDLItuZYkI+lyFLPiOhtNCn4ZENJC0pXFgYjMo4R9RDyQ0i2SmXaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864542; c=relaxed/simple;
	bh=iCyyKFg98WVI42cjpRPNBQjDV/GtJ6sKW2E4AnQ8CPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tNOd/peENeiGyQdjRfU1dtSk64jRu85UU6rXLtYI4jpKZIKBrfarzrmvTH2IE4OA0STQ1zbQiTxIFECah58ECGAaWrsjPflUZ9m/qH/e0ywsdolKwWlb64HrpfWdSFxRwbVvR164nbr1yTaJARQcZ1z97W55XWFY5F4Pk9Oqn50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFvEKVAF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864540; x=1765400540;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iCyyKFg98WVI42cjpRPNBQjDV/GtJ6sKW2E4AnQ8CPk=;
  b=oFvEKVAFk8XJynDaN4khyEYP+6IaehRbp+JwHNezy7fNanx378VS8wU3
   77zqOyFfEdAzQp9JKAAYyIgyCpAr6Ej+w+Vqq2oPR8jv/gm0yd1hiYpDs
   4WMgZQ64Dz6UbZyiAcqY6foMKsNUZ/mQ4uIKnnYU5NavaopKxiRecJzob
   jWhWn1R8jx+xgSAS7lfm67ox9ZwlSORgRJ+18VP3uqRaBcFlmoTK/0lFb
   Viosn7SZuHdj6yT+aaPMZLv5NWKCqirM0HjVSO+2KA07zJhLk2bQXaCgl
   F40tEajvd7j1QOyZ5DG8VSWp9Yrx8FipM1Sx/i+K1GuQiZ9Zzk1ezK2I8
   A==;
X-CSE-ConnectionGUID: riVomnxOT56IM9rsnwKwAQ==
X-CSE-MsgGUID: WCM0kLNFSFGAGOXyLEWN6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34132316"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34132316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:02:18 -0800
X-CSE-ConnectionGUID: WcextLKLSxiEn0lWTi5s8A==
X-CSE-MsgGUID: qJ8LC5siQjKqhtHejZjmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95221655"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 13:02:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 13:02:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 13:02:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 13:02:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc6Rpf804nm6YdgLVwNpvMH+SRkfmsSxY8ovFh1LM9D0czs+KvJ1WgQpX1bLzi2Fknm1bN63Z/h3/ZCvfSQzASwQZPKxYpVxMIsWz98n1va96L3qmpfaCgq3eqZxfLjGSecNBQ/daIKS4XyHP+8i0H4reLy1Hm1jrQ9y1pp9q92i/cE0Z+a9wkhEM/0MVoqDhWKtNaSd/xnZcXCMXMwTuQZJ0E6VtI5cj9aERyoJTzqZ4PX7sfs9LYC9due1gLEh1+1GEvib0XB3vVk5hs6Hb7whm2t/iz2i0humfHkxVj0kXNvM/PFHGbTnAWIBqQ4d8aQv/2+GTvLhvfzTePKrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5oLSEL8y62H6UUZSvYTYitPjxS2QSraCH6yr61XfkM=;
 b=pEbfBmZlph51W4X/I+GzLJIUxwClFDJ2d7Y2MW+6qu2IAqXwstuemyfbY1gR8AYWi3hVwnVFNqpaqzJ3F+y47tFVXnw9llwOr9NVP/hex8A3j+uCBeMhQsFpTEQBIQQ2c27kk3X3dEJHYi6i4pWOjY3yCpW2oVCj3ACk+7uVVBRIXGTFYR3ta8m/Yl+4lQj7xrCfZUMyZBwq8nKFk/UFE3e1rQktnym1GVCcwiAYLpfMhVPEnOYprctEtjYtq57vV12c+W/bWDIGB3ImZfKRK3x5ovlsS5Dt7u5lxXjnRKAmhk3l0U5kwd0BpLTLtQytwUE98RoZKS8t3zEpumYLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 21:02:11 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 21:02:11 +0000
Message-ID: <a4f1acf7-6bdd-4865-a13d-945791917afb@intel.com>
Date: Tue, 10 Dec 2024 13:02:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ionic: no double destroy workqueue
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-3-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210174828.69525-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 81badbbf-2356-4dee-a680-08dd195dea37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1NXUUR2TThSVVlUN0FKRmpMZS9rWUxSOHZCS0owNWZsYyt1RktPOGgvekJX?=
 =?utf-8?B?YmkwM01mL3duVmdqYi9hUVd6Tzlld2o1N05vZEdGb1BsQm1UaWJmWHZmb05w?=
 =?utf-8?B?TzRKRmNSQXFKdWlNNGFQYXB6ekk5eDA2Z0V0YkRGVzJrM0dYU3dGMDhFb2x6?=
 =?utf-8?B?M2J2dXBlUGhucTY4bjIyMm04NGpzZjAwT25KdzJVSUZWZEFWa3F4dDBwTUtX?=
 =?utf-8?B?Qk9PQUg4MjdDUFFQOWdvVGpSVmpNK2NaQ1plbFRvRFNYK3RFdGdqN0J1QjZ6?=
 =?utf-8?B?cnBNMkZyaG54VzFOUG0rKzhZRHRnTGs4ZFB6cjBpZjVLSDlXMEVGMmwwODhn?=
 =?utf-8?B?NW1tV014VXMyUmNLcy9GcDBHSDUrTUZiZVFKMUxjeWx3cit0c2hqU21IdC95?=
 =?utf-8?B?VVBNSW5aWEF2eDBubElUNGdpWHZpbHArcGN1bXNlVmxiWEZWYjRzYUl4dnh2?=
 =?utf-8?B?Wnh5Q3Zhd01zNGxGQmNWU0h6MkdWZVFxbm4zRitwU3VwQllMeHE5UnlvQU1J?=
 =?utf-8?B?T3BhNDJGQkQ3emE3UzJ3RWtjazZ5NTJKSHJ6N0JtMytyRExHU05FSnZmWlJE?=
 =?utf-8?B?K052b0JJQkxyZWFKRVlTelVQMU1qNnFQNUFkSDhRbm9YS2ZIOWo5cDR3VWdY?=
 =?utf-8?B?SVZnYTdCdVhBeTFCNUM4SVFIT3hKT3NTVm9jUnl5RzJvYmxMODV3cEhCeU5R?=
 =?utf-8?B?RVRwRHlBTnlsK212dXdlQ243NkE1d2ljYWx5U2JKTUlSTFBTWEFiT1hjYXNR?=
 =?utf-8?B?RXdFQzZaN2hRTWxkTHA3eTJsMkUyMlIyeCszMU15c3o3YjM0cFNhYk9BRUVM?=
 =?utf-8?B?OGVBOWQ0czJXRm1kQ016UmZyWGtYRjNSaC8vNFJMNDlDalFjNTdqZllNQkNR?=
 =?utf-8?B?N2NlSkU5SzFtbTFlZGFPc1VHNzJKWGt1M21aSnd4ZHN1SUVORVF5QVRCeHVC?=
 =?utf-8?B?SkgrL2c1NURIcC8wemN6d0UxS3hKSU1zMXpnempjZHV3T0tyVkNMViswMUZU?=
 =?utf-8?B?S250Z0ZYV0lvRCsxL2U1UmkrV0dHbFFKVnl1WmNFcjdFUnlid2FNN1AwdDdM?=
 =?utf-8?B?K1k1anNsUUlQRFZmdGtxc2R1YU8vNWgyMFMzM3hMWHVYZ3dCVmZ5bGk0akZr?=
 =?utf-8?B?RjE3MHJmVDBqTlNQd05kcWxQT0lmQTJ2VnhOT3dvSWlJaVpJb3FtcWE1RVo4?=
 =?utf-8?B?YklrQkx1MHVnNEZDRHdSUGc5emplMm5lcmdRUHBFMXFWanI0V25IZXFwVDhJ?=
 =?utf-8?B?TlN5azdhQ3FsRmh3L0gzSXM4TVJkLzJqTVFHVWNPN3BmMW5GV0xIQ1FDa1VR?=
 =?utf-8?B?V05pY29sdXJ4Y0k2Z3RJMVNZa0lhMkFmcGhFT1BRUGlpbndwQy9yTFFpL1Nm?=
 =?utf-8?B?Q0Jsa3o2NmdlaUhVNDcyd2hSNDlCMUZpZ0lsWlJMdWVPbC8yUTNWcUNNZFR5?=
 =?utf-8?B?NUMzN28vYjMvUC95QkQwa1YrbWZtK3hSSHovRXdVdHpENmFHUnh3QXFPSmxW?=
 =?utf-8?B?RXJyZVJzWFNlemtnRk1ISVV1QVU4ZzNlSWNPcEtFNkRxdC8rODl6M3JiQ25P?=
 =?utf-8?B?Y2U3cDUyNS95WFlhbUZNRGpLMUN5MU1hZFpEVmlKckFEZnBKUGp3UTFKR3Bt?=
 =?utf-8?B?YzVmeEgvazRIUHZ0cVpaQkd0QnBOYThDZFVIblBpSDNOTVdua2YwdVYvajBO?=
 =?utf-8?B?ZmVEWmZseTQwQ2VjS2dsYXQ4VzFSUHBGeXR4SkE3RjhVR1RhbGZiUnRUOXZw?=
 =?utf-8?B?clhqM1d2QUVtci85NnhPNXIzV2dDQk15REtvckR6bkd6SlRuS1l0RS9abWZQ?=
 =?utf-8?B?YXp6RmhKQXM4NnAydnZRdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVLTkU0eDVHNDhocmJoTTczTWtDZXNGdENLUklKTHVDSERMejJZMlNFdHlH?=
 =?utf-8?B?aytycEozNXZzcUJ5OWdjOXRNcGxRWk9tRjhjMnc0N1hDNVJSSzFseE5GeXd3?=
 =?utf-8?B?YmExRFdlTzlRQXN1dFRxemtUZkZTTVpjanNYOUc5bEVxRFRPbjRab2FOQitQ?=
 =?utf-8?B?Q0Z0Si9VN0V5WjVoNUlKaERKN1RCMkdOSzF5bnNRMUlBZXFUVGNwOU1STUNh?=
 =?utf-8?B?Ti9pRWc5VllkSXZzdXduelhNOGhWaGNLbXpiUmUvSVFUUlBWQk4zRWVVc2V6?=
 =?utf-8?B?OEh1dHdSSGk4OEtSbFMyQitGd0QzU0diVE5vNE9GY2VPZFg4YytvUm80QlFJ?=
 =?utf-8?B?MzRWTTFQWEdoRkE0OHQ0M0FaemFJeWcxUzJEVXUrdVI5dnhPZWVuMnJxRldr?=
 =?utf-8?B?djhtalcyV0dRc29oMythRUsxZVhNS2tqUndSYjlRQ0FpOERhTTBoVWxGdlhS?=
 =?utf-8?B?UnhZRzM1N2xPdHN3SGF1RGJwMXdhbjJMb0dSeDd4NkEyOXl5UUtmOVpudC9X?=
 =?utf-8?B?ZFQzQTJsMCthR1RSWmhNWkJnYjhFRC9uTm9yeHJ1Z3J3ZFJlZUdmL0YyQ3lh?=
 =?utf-8?B?RS9RajhrcmlNZjdiYmVsWElKU1VLZWdZSU43Vkw3aVdSUXlOei9BWFR2RVFN?=
 =?utf-8?B?TnI2ZElaWjJmTERER3B6MWVZZC9sMEdnZlA2RkhVdXVPQ0J0UWVnUjBkZzMy?=
 =?utf-8?B?dTA4ajFYbFE5NHlRbTFIR2kyOUhDSWJnZkpscUszeXJkZkxmUHlwNUdkVmNs?=
 =?utf-8?B?SUtqeG8raENBMWxzbzVwNnNHQk4yMFpaLzkzZTErb2Ywb3Z0UkhVUkpMc05O?=
 =?utf-8?B?Tms2SWo2ZS9Vcys0c2dscEpSTlN3SXNiclNsL0VaNnB3bDFTUWJMN2p4U01v?=
 =?utf-8?B?SXJZa2phN0FrSXBSTDNyZGxJZldPZ3hWdEpsbnVZVWRncG9UaGxVRFlVQm5U?=
 =?utf-8?B?SzNoMEk2YjdUSWhSSi9NMmJrVVhOdWpsWHVsSmtvOG05MFFIUUEvZEcrTXZW?=
 =?utf-8?B?UzFoNlZXTXhkVld6M1BrUTY5bVVaVWh4QTdMcjRtQ2JzNFI4Z3FQUHRBaWNT?=
 =?utf-8?B?QUxUN09NQW1zSlRKaHB6RXpYUERhVXNtVzdHcEJDS1UvUTY0N0QzeDFuOCtj?=
 =?utf-8?B?bkpXeHMwbU9BWTNVTm9oeWtteG1MZWErRTBtbkpnRUJOV3Jya0VXeEdRUmtM?=
 =?utf-8?B?aGF2dDVhSzJuQlV4UEhjK2tER0VUdXU1bE8rYjFreEI2bVpUU3E3Q0NzNkZj?=
 =?utf-8?B?bFRNbzRPd2I4MlpWTkc1cXhxYkZBbVF5UE51V24rN0UvZnU3Z25PandTd3l4?=
 =?utf-8?B?bURrOXNSQVVmODNLL2x2bE9ZT2tJZjZueXY5UVVxNXFPZHluenZWN2lVTkNZ?=
 =?utf-8?B?T3VXNEFjRjJVck9RNk1kbUpTQUJ3S01ubWYwbUZOeXp0eWY0ODRzZ2xpVUo4?=
 =?utf-8?B?ZlVwaGtlRTQ0RFUzcTlUVFRFbFdXaW4rL0VualhaYXhFc2RQQ3RCZkF3V1dK?=
 =?utf-8?B?Z1ErYWFrNzc2VG5SZnhrTjljdTQvWGVhdU5CdGNmVUhyNU5hYmlkck92RkIz?=
 =?utf-8?B?SmwweWNFREpYSSszd25oTS9ydisySzJBZ1FtNGlSUXlWa1IxSmJreThwcW5P?=
 =?utf-8?B?ekxnakFSNXV3MWsrVk9Yb2srWG96Vm9jWkM3TldldlhyTGJhSGlDR2sxV0g2?=
 =?utf-8?B?MERvTEtXNkhoVCt3NEw3RWM4Y3dJTGprOGtrK2NwbFo4TlJ1M214dmZOMmpL?=
 =?utf-8?B?bTV2c3hzV2JJamVSUGY3dlB2bUdkQ0E1bnRBNnBPT1pPVHpkOS9INzltZzh6?=
 =?utf-8?B?YWR6c0ZkK3REbk1reDZvMU4xNmx1Ym4vbnhpOWlyTGY5ZXVoUjFReURrVFR6?=
 =?utf-8?B?ZVFyclVweitnSTJEdGswVHVwd0FTaW5Udi9xaFEvT21yVDNjR2dqeDlSREc2?=
 =?utf-8?B?MlgyL0dwSVVkZU5yS2VnZng3V29rZnJJLzdJL212TDVzeFEvTGhxa3huMUxj?=
 =?utf-8?B?N1FCb25ILzFDcVBlOHpOVzc1RmNCNUs5YUNFcmpaNG50aXUySi9VaEhkclNp?=
 =?utf-8?B?MTV5bVl6YlNZcGJpci90UE94RWZTQktpT3lQN0NvbEhtVWdxTjYwUTRPQzF5?=
 =?utf-8?B?eFN2WU5odUt6SUFUUjdkeDF5SWVpTnBvby90TUUwTktITkNmVExJL3dxOVF4?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81badbbf-2356-4dee-a680-08dd195dea37
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:02:11.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dc9TCB5rrnl4kfG30JB2xq4BsvDDXlSOxQAz6sM9upBWZRp81Bfz8uRtn5B6C/OgNqO7kvPE/VVrpIp9Z9RHD8KwsJGvAeKjCPDWZqxfTQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
X-OriginatorOrg: intel.com



On 12/10/2024 9:48 AM, Shannon Nelson wrote:
> There are some FW error handling paths that can cause us to
> try to destroy the workqueue more than once, so let's be sure
> we're checking for that.
> 
> The case where this popped up was in an AER event where the
> handlers got called in such a way that ionic_reset_prepare()
> and thus ionic_dev_teardown() got called twice in a row.
> The second time through the workqueue was already destroyed,
> and destroy_workqueue() choked on the bad wq pointer.
> 
> We didn't hit this in AER handler testing before because at
> that time we weren't using a private workqueue.  Later we
> replaced the use of the system workqueue with our own private
> workqueue but hadn't rerun the AER handler testing since then.
> 
> Fixes: 9e25450da700 ("ionic: add private workqueue per-device")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
> index 9e42d599840d..57edcde9e6f8 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
> @@ -277,7 +277,10 @@ void ionic_dev_teardown(struct ionic *ionic)
>  	idev->phy_cmb_pages = 0;
>  	idev->cmb_npages = 0;
>  
> -	destroy_workqueue(ionic->wq);
> +	if (ionic->wq) {
> +		destroy_workqueue(ionic->wq);
> +		ionic->wq = NULL;
> +	}

This seems like you still could race if two threads call
ionic_dev_teardown twice. Is that not possible due to some other
synchronization mechanism?

Thanks,
Jake

>  	mutex_destroy(&idev->cmb_inuse_lock);
>  }
>  


