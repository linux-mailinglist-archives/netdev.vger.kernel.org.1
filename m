Return-Path: <netdev+bounces-137998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B09AB67E
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63401F21D9B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAD1C9EC0;
	Tue, 22 Oct 2024 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPzKqWui"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4251B19DF9E;
	Tue, 22 Oct 2024 19:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624356; cv=fail; b=X64pAlNwBwuMIxOr86J3IL47d7aSUNIRMIKs/qwzh0vHXGKIHjVaPNgE31fp3brFV/EV6AtF948HwK7wg97q8Kb6ZKfWs8H2M/nduiMSVBoSes9D58SO21szZuVEMIZ9ZrmfVh7K2K2PES6nDZmO9D/mbtcoZE0SgBxL8VmW/Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624356; c=relaxed/simple;
	bh=WNo6JMasQ/0UAMkfpm0bewfwssdF2THrXuofX9oj7KE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/8oSLMisGLn/x1WgEMlUINtd2bhKnY60YZYIgRTETu9Y1oFQQW94bYhf/K+6398cACV35zezgrfBPy5/GvRCdTvCMR/ESbwdZYttHeIr7FyJD46XGjFqPCKWRzp1tt1QASlGiARWDKxJFJN6DvNxxSrcqIx4shJ1jHFBJvvIX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPzKqWui; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729624354; x=1761160354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WNo6JMasQ/0UAMkfpm0bewfwssdF2THrXuofX9oj7KE=;
  b=lPzKqWuisB4Rbeht7qqqHUaHjl6LOgQFGkWQ6MbJNAcA9xXCPdrsZmQz
   EBifCnV8tK96Fz4NKrY/hWxfoIrjQbYZYE1Nzc6ahODT6zosOmHbqcZAu
   89mscrNicvQYheWk36q1VaeAOq9VaP/Cs4uPMdCft7rOYKGxvec5Xd3/O
   Pg9zgfD0KVWHO2Dz5SzeuFmR1KVsBbyB6VYLM5YKPt03k/DuIqsyZxl5B
   lKJZ0jHOWdCQOVBn/ddtolsxdk7pJNAyQ0evSSCoPdzT87fPWMA21ERDi
   iFaxXWBIZxYqoM/FucMUoBUou/e05AsRcUonXrBfcgrkdXz/NeBjIt7nF
   A==;
X-CSE-ConnectionGUID: 2F8AUIZbQuK0wie9npr6pA==
X-CSE-MsgGUID: v28T0PYaQguRiLKmmb+9pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29293364"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29293364"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:12:34 -0700
X-CSE-ConnectionGUID: BqIYIlXuRs+xn1O9S68VuA==
X-CSE-MsgGUID: kN2W2UsRThGEXaGJDkx3sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="85045668"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 12:12:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 12:12:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 12:12:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 12:12:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7Bvk26QYGS6485m1hAPYuA48rkyICfXgakvqWwvs/oMJuoK8XBLLjydYSZWpvGXD1rQMhVrrjVvfqrkmiZdQLOmITZHwbHKzgw8jesP5UlbBWwQ+Ib2ZghYrHhlGamoQ8EjNluuZTgCJYmsxs+JCiEqpvuf+Ax0L1j4Fx/e/9IMGdw4AR1WyJbH3ZhR8XUyriCA4S/K/8TuXk4FcNq/bsnbisgFRYFDFNNLn9WjadXUe5bl4hXzz3jdDRqDoCvdf+d+vdsTfvzoppKhhVVryE2qogyjKQ6ibeV0O6IbYGdQ1YftbN8wmAbU4Hbayjx7V1gXrtKLxtpnEft58P/2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmzVUDuKCitbuO5nsZlPD3mLjF57/DXbWM1N5C8I6Ck=;
 b=jpfjw/l12Z+V8JFMPO543kYvIP1mZFsOvynvjNiE5GNvOuL/ZTxvDOVXeUwzS/aaehV8hZwMdzJJFYbNiwvh/pTPdRmAohhH9fmPpprxqLYnm0GasJ3BpW6G9itQT4VicTbPUYR559WjNmMpusQ3t+iu+0FR29xhEi+V6PST9KkJ2jObPRY31/xVwQyI8OPe/XblmL/lypa1T7TbyJBEBBP68VoGdxy6xPgdd6ixX76xDxC2+5TdwJ04IQYTXui48Hobjf1CLqsTS+4WWlka3QGvhwxs2znDddIGUQxucQVhiKV2GbgyZcAFyHkoqeg1jTM5elzO2iCNhkLjFnVrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 19:12:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:12:24 +0000
Message-ID: <3c8a4439-f79b-4791-bb25-09e4e2238653@intel.com>
Date: Tue, 22 Oct 2024 12:12:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] lib: packing: create __pack() and __unpack()
 variants without error checking
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Vladimir Oltean <olteanv@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
 <20241019124537.mzhrgg2dj4msrycx@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241019124537.mzhrgg2dj4msrycx@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 561e6650-f110-48b2-1496-08dcf2cd7648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFg1dFUwbmN1aTgzYmk1c1B0c2Q5SEtoN0dRWGRDWDNkcnlLLzBVcTlqN0Uz?=
 =?utf-8?B?ZW9QaFo5NFRES0dpeFVKeThqOWJ1TVFjRHZFQlhRZ3JEc3ZPRFJLOHNUdm9R?=
 =?utf-8?B?bjIrU2crT1dLQm05NWRXWnFsbEhuQnlybVhkRkZVVFczWnBxcW4yaTBGRjhK?=
 =?utf-8?B?UWRQUVJ6T0JoOTk0MmdvVTFicEJXcFVWc0hEMEJUQUhGZFhXWkcyOVl3TmJ4?=
 =?utf-8?B?ZVNQVTBLbkxaVHhtdlFtbHlBcUZnczhoVTNzbG0rVkY2Ulc4SGs3N0M5OGx5?=
 =?utf-8?B?N1VEWWVDREpmMjlDQWJRMHN2NDVWeThJdmxVcE0vdnhqYURHYzVTWXBmbVAv?=
 =?utf-8?B?bk5kVHhRVGxuWlpPY2VLeFVsbDlGbVJ1ckhRSldhUXZZMU8wZjcraER2RHFS?=
 =?utf-8?B?L1BRbVZSODFyeWZQaFVuSFc4SEtNNldrMWIyMk5SK0YzOEZDaWdyS2w3NURt?=
 =?utf-8?B?ajc3VExpaFhweXBDc1IzSGlVTkc0ZkFvUGNLVk1GcmdtN3RWV3FGRWJ2QTZt?=
 =?utf-8?B?MVpFbWkramVUdG1HNWU5RUNESnphbEJMd2o4dVpOdjg1RWVZdDdKdlFIV2Z6?=
 =?utf-8?B?TmQ2b3QxV2VDUUU1Qm04VHMvbWhocThWR2I4c0phS1RDenFiSk5aVFk2RVUz?=
 =?utf-8?B?OFlEa2RJZmxPcWgvY1N4RFU1M1p5ckM0MkNpQXFscTNYdFAyODBlUm1JRXB4?=
 =?utf-8?B?MVhLYmhwN2NZUVB4ZElqMkJoaWkvUmF6aUVzbEthWnJxQldReG1qaDJSais1?=
 =?utf-8?B?RWxCREtvZ0pCKy9qOWhBNkFOQS9uVWI2U3lxaEpjREN1VzdGc3JxQnJTT0Q2?=
 =?utf-8?B?OUdka2FDYk5xYmdML0hZbXhrdHBERUkyZ1NKaWllL2x2NFVWR0tJcVZCSGgw?=
 =?utf-8?B?cXJJeFpGVTc2eHc2MzNZZlBvc0d6WjVFZFpJMmR6dFQydXhQZWd0ZE0yaExD?=
 =?utf-8?B?QUJSNlBWWUpyTDdDaS8vN2tNV215Y3VDUGlUdHJibUhHMFllNDZ0RnB6akxy?=
 =?utf-8?B?c216bm0zSlJBbHZlT0haUk9Bb1VZWTdYdTI2TWkxNnJCZjhFd2Nac0F3V1dZ?=
 =?utf-8?B?S0dGMWY4V0g2T2MrR3ZhL1hsNkYxUGE0a3NPY1RRNEdZUXdzK3E1SVN5RzhO?=
 =?utf-8?B?VGV1YU1BbUtxSk1WTlVDWkRWWnVESWJPa082a2ZwWTc0cWZNWDZsN1dWQVNm?=
 =?utf-8?B?VDk3UnREb2c5ZXlZOGJYejJxcHZrTnJVQVBBTXhOckkxTUQ0aUovZDJUTm4y?=
 =?utf-8?B?cVFIdmhIdlRrdklkeHEzaGxZTm01TUJNVzI5UmFIeWFhOVAreWQvdDM3WnJH?=
 =?utf-8?B?MDhIblBKNlF3MzZmVDArc2NSY3E3bVpUOWdhZlg1dU0zQjhIRmdaTUxXNnlP?=
 =?utf-8?B?UXh1dE5qQnRwSEF6VW1vRno5NjBaaXVheC9lWE1hNjR4a3ZoZHUxQ0tqSldM?=
 =?utf-8?B?V2ZNK2dxYW1XV05GMG5QdnhQR3dKb3hiY0V6UGx5Y202ZmN2OFVjTm9uOVVh?=
 =?utf-8?B?NWZrQ1g1cVN3WDZXaXpncWhIY1ZMeUxoYlpFMXlyNERoSVl0d3VrVjNsTkRC?=
 =?utf-8?B?Y0R2Z3lRVVBjRVkvZEYyWnJ6UCtoN01teENLbTJsZUl2ay8zVC9kWkh0ZUxu?=
 =?utf-8?B?eGhyY3hJbjh2ekY5WE54RmRhWkh1NWV2UW55UVVsRGlKY3FXcDk2L2xWL3E0?=
 =?utf-8?B?VTMzT2ZCQ3IvVmxoMzBjdTdLR3V2NHU3aTFsdk5VRFlVWFlaeDJtUUFBY1lW?=
 =?utf-8?Q?1pVU+jGDkzKrclpiFo0FGWOkas1wxmOB46zD1qM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0R3MEQ2d3YzMVFKd0dxWDZHRXA5QVNCNG9jd3BhYkpNM2NPQUIvRENQYnNq?=
 =?utf-8?B?YzN1WHpNa3pScldCNHR1KzdtdWJoeFAzK3lCYTJoeWlaUlYrRC82ODVtOFBG?=
 =?utf-8?B?Mm9YUzhkY1gwS0ZRaE90TGlEMEljQVZnNTVHRWZ6TkhvMHlhY2JkT2tuU1Y5?=
 =?utf-8?B?bFlSNzNUazgvblJUNnBVVkRIY1d3QnRHeUJUWGxUNSswSFNnTnIzUklRUmlH?=
 =?utf-8?B?WTZYSkdqN1hxaEhSWWlYMmg0YVpDOGF5OHE0Y1Z5Wm5Ed1dzbXZaUWxxcjJS?=
 =?utf-8?B?VUdUL0x5d3dvRDQ0WG5Xd2VhMnV4RU94NHl1bThKWUxuV00rRytCcWlWamNy?=
 =?utf-8?B?UUNRdGM0T2pOQlJXOXpqd3NOZGwvQVl0bUJGWHNxT1FsTHVIbHhmazVvZGRj?=
 =?utf-8?B?Y3hWeTRJT000c2JyYjlrSjBNQVpTOEliVkcwNXE1S3RucVBSaTVmUTJZY3hW?=
 =?utf-8?B?SmNURmtLakdwd0FhQjZjNHZQYlY4WUtlQmJUekl0SFI3MUtKQWRGZzRPUDJE?=
 =?utf-8?B?bjg4LzQ5bEZKcUZKdTJlYmE3ZmE4c21qWGN5NS9lV0tGL0VqbkFyZnVMdjgx?=
 =?utf-8?B?TXNIdG9XWmx1OXBKc0dPUjVYbFQ3UVRvalV6Y2NRL0YrekZkdHROelovNHhv?=
 =?utf-8?B?NzVlSzBOU3BUZW9HY1pCSVBic3llSmovOTRNaHR3cmNSc2xSS1hweERoanAz?=
 =?utf-8?B?NUpkSDNFVU9xUmgzK1YzZFpDS0NpRlRFQ0pJWWNnZkVXL2UrWlA2S3R3a3dx?=
 =?utf-8?B?T1QrQTV4SWNLSXhOMW8rWWJtV3F5bHhncldiUGZWaGk4NWVzRDRmNkh3MnNY?=
 =?utf-8?B?NkZpRXgzSlBzelBPUUhMaEtWbHJ0Q3dGNGNlUkZSTS9MMDFuYlJZL1U1K3NB?=
 =?utf-8?B?NjNsMXpIeXlCNTlhTkFVdXM1TDNjODNUWHM3Ry8zcnRyb1FhVlhWd2tQZk1t?=
 =?utf-8?B?V1pjOGtObEJRdmthMHJEOGttbnM4NFMvRzltaGY5YzJ6RjhsaWxWTlJBcTQ3?=
 =?utf-8?B?T0prZVlsUlZLczZmMFY0aDFCY1ZuTVRkbHFLQXppYWlEaXZoL1dvRWhpdlZV?=
 =?utf-8?B?OVh6SkxTRTM4S21hWHQvRUxiV3YrMDNkYkxMZEtQdGIyZVlPU0dSN0tMZmVa?=
 =?utf-8?B?eVRpeXJ6M00zSTRqUm1QMC94c0YzQ2o5dlJWSG82YWlLaTdMc1dRZ3ZqK3BF?=
 =?utf-8?B?MmdDM2dTT1VjbEVZblkvb2ozRkpUNUk1UmRLd2lFS3l4c0VmRXNvanhxOXBJ?=
 =?utf-8?B?Ty8waHJPRjhYZVVKVmZYUjNQR2ozR1hjYkRLalJ0b2RXcjQzV1B0WUErNUNa?=
 =?utf-8?B?U3ZEK3NzRFBvL042cEZNM1FRTWg5SDl0TThZSG1mcFRLZFlITGVEUFZqMVpx?=
 =?utf-8?B?TkhEMk5KNzQrb0ZlaE85ZTEyK3c0cnJzQ05pOW5VVkQ2ZVd2U3VnU0ZoTnda?=
 =?utf-8?B?dXRxempZVkRzUjVzUW5hb0xlSnhhbmNraTdIRVNmSGtwWmh2VDBZVWQreXFW?=
 =?utf-8?B?cXp3Q2RzTVhuYzE1aG9YbnhRem5oaU9VTlFMaHc3UE9wMTdSSHQ4cXNhWWNu?=
 =?utf-8?B?QnZIcHNpaU9qMVAxM0gxbXJaemJqR05IK3RYVXNsVE5yUzdMbFlJQkV2V2VQ?=
 =?utf-8?B?TnRSRy81SEpiVS9uRkFzUUNNV0wwcHByVjhJNlhJNTczQUdvU2ptTmdVK2Js?=
 =?utf-8?B?ZGxGMWIzQ0lqblcvTHd5aGtjajlxRkNTMytSSEZ4SnNHNEdUbmV1bG5Ga1I5?=
 =?utf-8?B?SmhXa0RCeGtVT21hbThEUlkrSFd0RlYrY012alZvNnNmR1V3bEdLdXRiNkc0?=
 =?utf-8?B?Wmk0cmdaOHRMTEFwTXM1V3YzTVJPMWEya2h4S09lSE5VTUFlSUl6bUh3RVZi?=
 =?utf-8?B?em9jR041MUxyUXZ0UGE5dWlTWnhRZTROYURtSnIxeUU0dC9MK3FyaXR1ZkpM?=
 =?utf-8?B?QVFJV3NTMGVtekxqbkJ2UXMwRUVvQ0R4ZlJoa2kyUExYanlPMGJCcW1JZFRz?=
 =?utf-8?B?M29rd2RxUFJZUXY1QVoxUVNONWdKR2hYcFNSaCtSOUUrdU0vK2tnMDBkdE9n?=
 =?utf-8?B?ZjNUVCs3TnorQkppNWVSWHJIdm5SRWJsNFFmRzh1cDFNY0FBK1ZJcjhwQzUy?=
 =?utf-8?B?MXg4RW9TNUJoRnptZ1ZRMEkvaWhrS3B6Y016U3VOcER1d3ErOS8zZ2p0WFV0?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 561e6650-f110-48b2-1496-08dcf2cd7648
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:12:24.7489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chzznGbwhnpzMzmoVP0U0lXpb/Lgls8nrQw6i7sD8abFx9jbp9hd+J2ovsN1vQeW28FPBtO8zIWbKZLDS2j6G9YZtK9XG6uHEV9N/21mCak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com



On 10/19/2024 5:45 AM, Vladimir Oltean wrote:
> On Fri, Oct 11, 2024 at 11:48:29AM -0700, Jacob Keller wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> A future variant of the API, which works on arrays of packed_field
>> structures, will make most of these checks redundant. The idea will be
>> that we want to perform sanity checks only once at boot time, not once
>> for every function call. So we need faster variants of pack() and
> 
> The "idea" changed between writing the commit message and the final
> implementation. Can you restate "sanity checks only once at boot time"
> and make it "sanity checks at compile time"?
> 

Will fix.

>> unpack(), which assume that the input was pre-sanitized.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> ---


