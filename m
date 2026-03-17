Return-Path: <netdev+bounces-268677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHOmMcV/uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:22:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4132ADDD5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 274B13076535
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B02D8768;
	Tue, 17 Mar 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/Oi+9Uu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8246819006B;
	Tue, 17 Mar 2026 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764156; cv=fail; b=fXbA6mMzvZEpK/gJxbN9bUwXqs+YEovZ32LAuOGKv0z3Xj2zBzwRwmsM6epZzrYGvzh8jxUFgAUETKWywd6Aa8QOFU4nlx+AU9KejDm9+GSo05EnZQlDy4a5Kooi0bCTmsw5+TQ8biL0Jv4aSe1QNvMA7CBmd5iz7JhoWrGRy7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764156; c=relaxed/simple;
	bh=CoSLtblAPrOoQ8Q1uunE72dYOt8d9G1hNMFL+Z7fFUI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rWF6uK/yUyw4TZ80S82GhBcK+9UbSlvv5yrwVMzKqA7tqdzw8k4YEFwVqSVttVMVXKPu6gFyi/mjjVBFyCriX4Badq8yJ9zOI+I88nuLRyBwf5p4BfdRG/z04YU4ZNIcsW0JuHrvEB7QN1pptnqWJjekgfokIxPqbZAFSOntNLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/Oi+9Uu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773764154; x=1805300154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CoSLtblAPrOoQ8Q1uunE72dYOt8d9G1hNMFL+Z7fFUI=;
  b=E/Oi+9Uuk9L58OwHb1y6F5X0QAMsk6YegPQD+C4uTIeaZVtXt3FgiU/p
   CfLVnmo/nK2iNBDYmFmOpN0nPJls2c0bN22ZcHL/nZejJS6aH6t+okvdb
   ji73odfAHsJonvAYkpuwcNGsHUvLDIj517QZ7/M2/bGzwQZgGKj1sF6Rr
   TnTl8BsbMAwA/Xs4wFr64oUTYkrBhj0D07LkQK0pfbV0p9YvGEn6/QgNd
   a0X5igO7Hby4bfukss0i+/AiGjS5nOfzF7DVL8X2vVTY0jHjSs0Os1ngN
   FjXSJzx2BZmk4FHvV20JOwOUQuivtooiYhFtk8Cw9raJpJ/FOiw5I70CY
   w==;
X-CSE-ConnectionGUID: QWcR9fZ4Rn2vsFU65e9ydQ==
X-CSE-MsgGUID: TGi1TpTcQJ2JzN0HnQhLxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78697215"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="78697215"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:15:54 -0700
X-CSE-ConnectionGUID: BysgnVqOSROUaKUnVk0eoA==
X-CSE-MsgGUID: E/Kx0KzJQquYIwXtNIGOBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222368025"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 09:15:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:15:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 09:15:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 09:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9hzlTeiBGpUIEq0pbgP0+j9Clh4WQ6wqrF+ecxrB5zAv2ktoeBDEoLhS0gusoeta6xj0jzazyWfWjzbfMMWVNyEzcXBUx73aVzLWYHYMPL9c2RkiMQ/DRJmgM6RBkIl2UblVl0zAuDoa1ZWIhtBGmmTf6mCUR79bqrCXH7TzccQkotvLFzDta8kdE1e5437WcbWTLGe/LCNYT0dWofwor1k6qvV/19GPrkxgEloItpcVlzcoClegDGywBDfgAr7x7809coh5Fnr5l84o+6p6sKWKB6ySi5jZPYAFq+JabBv7zK6CxY91XOXe8Yz050jb0tkk/4W1v/x3Tj3HNgetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmKkdvh5JzpFxVjqrMvplcBm0yYhMm6dA+uhyffewgE=;
 b=g/uuqFcxk2QQoVqwTf5y6ywq5lqRuemHhOpXUvVz7yqdgGk27nHAULWCX52Gnecdwf8J36iLJwBdv2aw0ewodPuY4gAnUx2Ii6QMPjSAU3o+5mPsYjYtXNhztABpziP/hMwxgw9ljvNvtb2evR4DV5lGDF0CVcaH9gvHZlD5cmylhVBVFjkCXg7rE/LQc+NjBhQ2NxSbJuvq5wnZwSdK3gpcfJ7hMhV9detYoXwBjOJFjpJgzuLy0pgLAPrgKqYobB5N08uuM9A/mN4JjkfGoe6fni7BiTR2IUsvJg659vVO8nSJNpw+WOFtviu1YevgK1O63vEawvqCTdO5Ii00Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:15:49 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:15:49 +0000
Message-ID: <21a23b98-5014-4330-998f-53acfe705d67@intel.com>
Date: Tue, 17 Mar 2026 09:15:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
To: Jakub Kicinski <kuba@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: <horms@kernel.org>, <edumazet@google.com>, <sdf@fomichev.me>,
	<aleksandr.loktionov@intel.com>, <ast@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <hawk@kernel.org>,
	<nxne.cnse.osdt.itp.upstreaming@intel.com>, <magnus.karlsson@intel.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
	<maciej.fijalkowski@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
 <20260313014628.1509116-1-kuba@kernel.org>
 <4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
 <20260316161630.2d9ac04e@kernel.org>
 <a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
 <20260317085025.6459821c@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260317085025.6459821c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 94700fc1-90a2-4df3-2c80-08de844073dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: B0FmpdAoMmFVHeQS+E6ae/yQxDumMxEq6a/uPa1JlSl7soNORTfUtu9Qrecltm7y03AVllOJCBPiF/4E5drV6kPAeM5SToHwrDt8l5cAmQdAxZQaTHWZ2G8eQqm0KkfchxVb9FWn5Oiwb2fLbCIaQb5NH6/MYxIqMNwhrE6Wf1UFvsSO2LQbBudhx0bLuVpMRwD6lkIYsQ6L775U4XE3jhb08xTvCQMg8K5TUO9FhaCr98MfM4zqACpgCaSsIPAPtxb1+UtSELTSh1nGrI9dS/Q+UGFYVkrEuNaFX8CGN8ggVyh/aCmOMLBR1Hb5IGmTZmb9DiF5h4VlyM9mSs5N58hPum/QICOmm85X2W6FI+3aXzveAVfJbUJKH/vil5cG8cEGhq/nZkp3QJShR/t4Vx3CviOboPExAK9Sp5RIGPqYIiLnPH64/Kari1t7Abjx8e1waaLRa0RWsBKbe+Rh/XoW/FheXsUhDlV4W9syD7zMhmUob+F0B771Hr9XV8qWSarptTG/ahKGU/J77FQJhLglsvhB7Z4dG1tjhz/UWIsQ5to/AZR/qAX5vDCtpULaqMxG/JFNarcyAdK9Opvd5yel534ML/82lhe/FDwpCNq05fV6R/Q0myyZKOnmMvTG328Kp/3AHkDRpLVvlVMR2qhyZIoKIJRVZCcXM7YcLb3GouU1R7I6WJEZ9Pstt36sRguV0WHW2S9mg30zsvk8Eyw6lp9bngxUTUst4tPjhQsspcOY4cFaj/CYvvFOnoTN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTY0M1JRampadXVoYUd6dnhnajhXMVFyeDRDdWhTTGd3U2RDbG9Pa1VYUldJ?=
 =?utf-8?B?elRZajBzRXBJeVhNUjk4ckVGWk5iSWVXWDBsK3gveVA1S2QvYm82emc3OGNx?=
 =?utf-8?B?VllMbDNPaG5Oak80SDZDRnFXRmhhQlFEN0lHNzl1eTluU0toVW1ZcG52RFB1?=
 =?utf-8?B?QjRZUVNjN0N5Qnh6RVFVbjRMQ0YzZGdGSHZuYTRSZytnbExtUThHb0kvZ25q?=
 =?utf-8?B?QkNvbHF6REttSEZmUFBDUlU2MFpDTy9RMnZ4SGE0SkZZQ2FnM2xHU0pJdVJm?=
 =?utf-8?B?SXR5YTVKaUFCWWhiRVhTNzY5UHc0cFg1bmlBQ1JOTTJHb0hnaWoyZFYzOE9B?=
 =?utf-8?B?N1VCWmRTeFhFZi9uUmJESWdIb00vRnlsMXFCMjlFWENCWG02MHZGU25wMUZK?=
 =?utf-8?B?aG1xczFlZGwxdEFtV3dwVHMzTERJUWFodk51bkJ5bjV0UTdlQi9GUnBLREhw?=
 =?utf-8?B?Q2poc0lucXJXcHFxdUNhNFhVZFphNjRSbEljaTE0cDIxaDFEREVGWGc5dlNl?=
 =?utf-8?B?MVF3WitZaWhYcnhuMUx2M29sUU5IVmFZSTZrdFhiWk1zMHRwTUJuOGFmbmZW?=
 =?utf-8?B?cElXYkNyKzg1MVk4SDBPOGlHQmZLTTN3ZTYrQXgvblFCdVFnZmhNTEFJWVZs?=
 =?utf-8?B?eXpqM2dEK2FqaUxFdW1lWHE0TVg3Zk1YTGFUNEhNUXovcVFYM2xIc28rZmdl?=
 =?utf-8?B?ZTIrTFZ5QWxaeEMrWU5Ud2t6NUNEdEJEcFBDTUtiZVJmY1drcXg2bmNPaGwz?=
 =?utf-8?B?UHU2WW9tZlIrckxDc0V4LzhVcURFTitkMDBncE5MSGgrMytpbTlySXlGUmNs?=
 =?utf-8?B?MVB3SkV3a0JRYnIxOXRhOWJ5VFBKWjdDWklzSWlQMzhRUnZRMlNrajdxeGt0?=
 =?utf-8?B?UWhJRWluR1BUQWVxb0djNXVaTjBlb3JoWW8vMDZDNDR0MTlCaHFjd3RwNnpv?=
 =?utf-8?B?UVR0dmVxNXNGTDQvMGptKysxTFQrb1hPZlUzT0xwbTNpWUNiTm8zczlYdWpJ?=
 =?utf-8?B?REduZEZCK2tKam1NUytpSVBQK2dEMEFzTmJ2d25GdW83OEt0cktqZE15Y2Va?=
 =?utf-8?B?VGFMeVRpV3ZzeXNZSlkxeW9sRW5Jd2x6bG8zZmFUY3dKN0w2cE82VEZhbUMr?=
 =?utf-8?B?bWpMNEJkYm5kd3o0WFlqbXRaeGw2Y25LMmtGRnl2ajJqeEdZb3FzY1RlQito?=
 =?utf-8?B?TFFENzdVRmlNT0FudTdsYTB4WDRjaE1rS3EzMnJySG4ydm1NZEY0aUM1dWxk?=
 =?utf-8?B?YjBSV3lvZXhDSGt4clBXdXordkdveHMwNTUwMjRXQmhQeGlXY2dZY3RoMG5q?=
 =?utf-8?B?eHcza2NuNVlNQWlHZFZvYitWYm1wVjkwWDZOMkE1VmJhdWtaSWNFcDBScS9w?=
 =?utf-8?B?NFVFWmxEeXZ4dW0wRWhOV0FTb2RTOUc0VDNPRklDY3IzaUIxV0lUR1dhOG9W?=
 =?utf-8?B?c1djaEVWTW5mWnAraEhJTVhScUh3LzUwV3VFcC9kMG9mbHhSdGVtWkg2YTV2?=
 =?utf-8?B?OTM4OWd5WWtHamNJSTh1ajZNUGlwc25UcEk4WjNiRjQ5dlhjelZYUGlaN2VS?=
 =?utf-8?B?bXdBUVl3OXZYcHY3TDNKYUhVL0I1QlFTL25wSVUyeFJpemVzbkcwQk9oWUx0?=
 =?utf-8?B?K1c3ZHljdzhkWjZPQTZZbE1EVjQvNFhaanl4Wk1OVzRzNjlTeEhuN3BUMHFj?=
 =?utf-8?B?M2dpd2VMWnNsczg2TTZqQW5nMkJQbFh5cTh1NEV3MmFJdEt2aWFQZEhZcU8z?=
 =?utf-8?B?QTJQZGJNL01CR3J3Kzh1NzlDajRUKytrbXJOcmRCOUdXcEQ2aUMzM0pyTFpO?=
 =?utf-8?B?eFVmT0dmYlVGS2ZRaUtTeGVJVHhibFFjamUrSi9jZExadUNNR1NPMDBPRGRC?=
 =?utf-8?B?MENNTXB4cEdycThxYmRLcWZacTI3ejdSUEUwVjlFaGpJWkhUa1Q1UDBrMW41?=
 =?utf-8?B?eXR3K2RxRVoxWkgwYjBsUEJpQjBReGxRSGJuOWN5K0lBeGVuL3M4Z2tVQnEy?=
 =?utf-8?B?VHdzWTY2SGtkcmdsRElWQ0IxV0tjbk42V1Q2QU9FNENQdWlpY29rWkdDSTZz?=
 =?utf-8?B?VzlIVkpFd0tJd0puV21oTnFoMlIzK1JuYmNCeVI3Q29XVW1vSGxKNDNKUWlV?=
 =?utf-8?B?REF4bU52SWRnOXYwUXNMeVpqN01vbERlZk5tVGQwNXFVVEJvMHlxNVRnQzRx?=
 =?utf-8?B?Q2FQU29MVmlUMytjVUtOcDcxMmkzenhjRlpmREhIMXMxRE52a3BEYmFoYjRY?=
 =?utf-8?B?eGc4cnJEV3RGcVN4aTF3L0hZY1NINDdCcnhMNkJMeGNocnJ3aU1VdkkvWUIv?=
 =?utf-8?B?UVhEUXd2UUdpcVZvTWpieVlQYlpucVdsT3dIeDBxQ0pOYThBcHhPSHI4a0Zk?=
 =?utf-8?Q?XuGuZuJBKlLtRVPQ=3D?=
X-Exchange-RoutingPolicyChecked: WSYsFPPs0n97jrhBUNDjohlMxQPndUN6QcDsnpqaS0dVQbJAMqepXFGgM3690bVHY/pSIUSRVjZ4DkXre17v69KGFeVP/8GOfugAqucxFKjBa2Snbj6BlVuxO58iKv0CmWrHxj17fAhDpunBvwBRVfb/FM6cg+vANVc/BHQaDfhhr4PA5hz7ZepBzS2ZvVYnne/2Twh08T8nb9Zle7zjjsH1FdryQoz/kGUBFycCAlZoPcpsdcyvBnPLpmF0V0K8TXIiJ4z1q/746W2JGl+CKlC1nlwWzEX3L29W2c7wuP3+dJRrobvjQXwAgTvo7UTACxAHZKdPWizUrKO0cFjExA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94700fc1-90a2-4df3-2c80-08de844073dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:15:49.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArLRoT4n0ExxNEDLNK+lZlqJRmroSbvE1Re05u9/UuRCH7MsZgF5qmJF0Oi+7J2FH7h3aiqRUUGfX/NhJUJ9PviYGQl0ibTf4v2QM8/npBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268677-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,fomichev.me,intel.com,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2D4132ADDD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 8:50 AM, Jakub Kicinski wrote:
> On Tue, 17 Mar 2026 16:30:26 +0100 Alexander Lobakin wrote:
>> BTW, if it's not top secret, how do you run these AI reviews? Because
>> Tony used the same link as these reports provide to deploy a setup, but
>> we didn't manage to get as meaningful results as yours. That's why
>> several respins of this series only due to your AI reviews, sorry =\
> 
> Nothing secret, I didn't push it to the main NIPA repo because it
> mostly vibecoded crap which is embarrassing. You can see it here:
> 
> https://github.com/kuba-moo/nipa/tree/air
> 
> It is just Chris's prompts + semcode. We run the prompts with
> sub-agents enabled (the "orc" prompt). Right now it runs on Claude,
> the subagents are supposed to pick the model by themselves depending
> on complexity.
> 
> I don't think we do anything special, if anything it's probably the
> mode (orc mode thing) that makes a difference?

That's possible. I'm still pursing it but, at least so far, I haven't 
found a way to get orc mode working with my tooling.

Thanks,
Tony

