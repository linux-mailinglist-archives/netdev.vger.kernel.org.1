Return-Path: <netdev+bounces-159528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B05A15B1F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CF13A843F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3840855;
	Sat, 18 Jan 2025 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lh3Egm+N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968F1F60A;
	Sat, 18 Jan 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737168090; cv=fail; b=AFn6JOpti8YrXl5jHpoMqA499aaR7Y1ARXOJ6qWDO4Aef42IqbDvBWwlusYUUGRnuuS8I47H/NdUKYPrIi3BmBTzJm3rwr9elzX1crgqQ1znzmHWBYpiUjeCEMC7XbAGeymfHA2VNLMljx4fw8j1i9U9lW4Lp8RA4qfXeZN34Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737168090; c=relaxed/simple;
	bh=DLEXaUpVxchgtABKlJLPcLkiMJkcjjBA5GqBE+Rtepo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ed0IRk1Jm9mlvSPG+9aEGO21ZepcNS7Ykj9CNH48V/eZrNZjadSI9+Jd5dHVa3OQ2938/cHtgLjEYp+ZBeaPEfITGhGJRdRLts7e30CvIPk9gDL2s7EykAWjw6AVnOIUITwj3ngX6Iv8UIctnnNIIeDE3oWfY6w0KkxfUNc5Pdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lh3Egm+N; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737168089; x=1768704089;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DLEXaUpVxchgtABKlJLPcLkiMJkcjjBA5GqBE+Rtepo=;
  b=Lh3Egm+Nf+TAp0AqkoUDAf1kg9sVcgtxAc+rkvGlzGmVM+CXb6kNkRSA
   KBZLPPDeUXgcj5M4aaABfj1u2leNyG5Q/Vhd0FQ03GpyqAZ5ZcaOBppFO
   g4o6oOZ5hEq6RkzNvyqg21qJ5aZEyrpbppgthB4sOkPbe+puN4GLr6Ijs
   Wh/mlo3svDUIrE0dKQ9BDzgoDM/Xn/CyUZlMvQLtpIsZtdR5WgMf8kvDz
   qStlNYFJ+WVaaif65E0y3vKPJ1kiHbA2/6CxHBtHXaH0OffnsDmR0xUg8
   oq+PZYGnEgAysFPGREXsskWrAPBh/m3hEB5PiIG8awYu631PyNXCehvBG
   Q==;
X-CSE-ConnectionGUID: 5caTXQ0rSPyYqXe2/Yqjag==
X-CSE-MsgGUID: o/oED2+ERl6YacjWtFr2DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48284428"
X-IronPort-AV: E=Sophos;i="6.13,214,1732608000"; 
   d="scan'208";a="48284428"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 18:41:28 -0800
X-CSE-ConnectionGUID: tqyELguYSIGRKkrRMVMsNQ==
X-CSE-MsgGUID: WzGSMFyNR1G3JUUupb8w/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="110963473"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 18:41:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 18:41:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 18:41:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 18:41:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPBzVIb49fH4Tb6s2XDI+o5gSYf5X5YTDXgCBV7B9WMFTMBJsSVObzf0+mvkLIApTjA8Zt3lUP9P66YzkE0edRGPPa1MKF3rXIAZ+cRhTKVe6fuf4nZ8D4cc1czr7hzQvSrtdWc2BxGqXRn44sVfYbytHKicIjJ+7OWZhaEJkcyLYpY8z6LEqYH32pDCOOBtDp9eflM0hkX4zX5PSX5qn2xxUZYOhky9d17L71U5BthAzXYAZZc6S/8l16IwSHq+WkYxCC17FvABsJx8qCgUtlQzVud7VIAanhV8uoEkebmKxkIAPl9O0kGS00m0c7bE/qeoE6McqLJ2R6eGupAtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFvqbqBAF15mTxoUYxMjmU7tx+xDe5kFmtwJsrc2pjI=;
 b=m14qyW8+BO4d6PuSjWlGNA/Fgmd2lYscxMfCZi2ZrxYRzzTdAM3TWgHqmnDc2V8xURfr5d2Sf0VkTWJDBRxFIy8EKJsExX4F+pXfEUjpb2Q3yogYmKReGnHT3s8lhkES/ZUKcAl1GsGyzOfSxPUo7zavl8h3dbhkqmauFjR/D9SYY4tCtDyAy3VILzrP0jhsfOdR/DKv2vT0arISC3HpP8BUQBzVauJsfFFT6+rgCg+7/G55kni6PCeySN6eSkILS1fGsA3XX7LmqYajNBqu9N0sxz1KQVii/y9yaCLsjYrVfkENnVgw+ZXCTnvVYyBZ1qJIoXROpKppB8CqVk1LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB5864.namprd11.prod.outlook.com (2603:10b6:510:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 02:41:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 02:41:22 +0000
Date: Fri, 17 Jan 2025 18:41:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v9 14/27] sfc: create type2 cxl memdev
Message-ID: <678b14cf84ccf_20fa294f4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241230214445.27602-15-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea6858e-90e0-42d8-d3a4-08dd3769980c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5Ts1SGLRRNXMEFhjw6L4+i1k07HaLZJsXrP/9y7dSvYA1PhFrzXwB+9uDCs?=
 =?us-ascii?Q?R4jhpfF5ivji2SPudnAbM0T4wcovfIE6UOPj3AhvEAW3yRcfbPClIQGIkLTW?=
 =?us-ascii?Q?MZTsaXO+U78xzArb4UPpTDXfOTye+aWnTV50Vgt29gHDIPqrDJoPTzG47kYZ?=
 =?us-ascii?Q?GkYwKj0B7cJsIym+7Mtz3fCzxricOKKdQ9QCER1q6zwk8QftvOPsIopPrVrq?=
 =?us-ascii?Q?HysX8GwmDYm0bUaO/fqgfmQRiYAaTRJax2OPKgy+9PVZe0jqncJJBFWpxw1u?=
 =?us-ascii?Q?J9YR4PyMCzaKhr/9IrMtmDTm6cN3mtVNRrnNLwzGj+lLEI8VQUJkUdiZzCsH?=
 =?us-ascii?Q?FF0aVo45Nebw4CV/wfu0Lp+MTireTTYg2sHqU6Q3QgjHthpOL9Z44kphQlqw?=
 =?us-ascii?Q?s1sfqS2bbiDX7PNwSX3OP18KXYpHm3auxLF8dG0+U0WH2ooxT3vFXjiSi7r8?=
 =?us-ascii?Q?VSw61YST8d33l1P/GpLUytevAAs6FRTzF04SUjzCShYxWqgq4CL6LjjB27g7?=
 =?us-ascii?Q?ik4tgFbYFgZ3QxbPrbJq1Ct6HDf5CFpGfy7pHABZjaVjQcUSNGIc6cqm6MUT?=
 =?us-ascii?Q?BZF4uN3yI95kvRbCcGnOnESrJSU+Z6uZ7c32kVT8lw5ikt70NsKnOtaM5nSZ?=
 =?us-ascii?Q?UXbLvIFOmWa/KLD/e3RMm/dTb1Llehs/bSrrqbNE1exSYFdA5D4u4k5bJ7q3?=
 =?us-ascii?Q?55gP3sa1bGX7hwmYk8lVGLWjru9R/654O8bBjHpZjEsJthBdu3/zNOHaJ83H?=
 =?us-ascii?Q?lJI1vO0tx7e9Yc9SqbmG7joyQvHz76SnjZKF0HbuqNDtL0NVrnVSa9tJYSEc?=
 =?us-ascii?Q?F9vbTGZX6cYGYjCyv6u3I59soYXOjQUtX1UkVEIecVEkptDWOZVIpz3hpJsT?=
 =?us-ascii?Q?wHlk+zdSAJfH2wWAIKbNwQf5dXbX4avfCaK1Nx/hwP5l/uvizwqomIQWoxvQ?=
 =?us-ascii?Q?a6gRoDJxrMUr/dDd5uOcHCYrOPY7FXwngeKg5XJCWWeIOkGtNeQEj5cuSJJG?=
 =?us-ascii?Q?GOpauRIA7HTWwIsoOgX6wZ7sdBehAdDN+CwO7xt+ADLFFCcIUUj8S9/jU5Pu?=
 =?us-ascii?Q?iNbm06iokDZPc8MMH2Njffdv2jCL/Cjw+D9qUj/rRpd2odWcsygobxxPm2p5?=
 =?us-ascii?Q?thdSA8UWAVC4aNgdU5po4Uk+brJvaU/oALVqyqqs5UP4F1snBFrkFbAin95u?=
 =?us-ascii?Q?M1EqSkRFViq3cc4BFnVlactV8gbv0EaL/I+qsMQ0Xn1GFXpx+kn2w8HG6CQq?=
 =?us-ascii?Q?M9+oJZCbUo2x/ruqhCz9TQLvLp0RGoYwmL//QUA0jwQx4QY1YaCZTIgA4OdO?=
 =?us-ascii?Q?1gQ1h8V6EC+wkIET9xR5z1Bk2FsFZL7h9FW8Sc5bdEMfQoJXmZWV4Xjmaadb?=
 =?us-ascii?Q?fijorfPNWYAVHS47t07E3zdffzOzmNRhiViCgAZN+4cnqCTuLbAO/ewbIzfu?=
 =?us-ascii?Q?CB/uel9z354=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vsW8qOFeFJyd7YK9bpFN2w7xfC21mSl8dywaTbhvoRxUKszZ/5AsyQVe0PwX?=
 =?us-ascii?Q?ialNJfRjlF4KgzGZbYHDXCbbOXUmj6/3Aw+cH3pBMR8P8HGgCr2Jb6J8iOcY?=
 =?us-ascii?Q?4Qt7t1rPQEOv6Xp+nykqCi3YedF/lONVJ+R18hm0qi6ao/yQsgOIzZOCSOQi?=
 =?us-ascii?Q?mAh+RGqw9/wewacTZZ8/nfNjIMNBA4qo7GeAWtoZA4IisnjeNxtZcBNnjLXT?=
 =?us-ascii?Q?KpclNda+w8rwsUCuis0Ni6mLrP55bFirwjXWs4kq9MNCRAPONOxjCqbjLgXO?=
 =?us-ascii?Q?NnhClo3E4TI2I+KgDbpl0LcsKcE5VbRO/UQ31Vn9PbYyaXARkDU4MK3Pr7XG?=
 =?us-ascii?Q?olVbUNZKS3pgV8vqD4Ju2nRbHL7sCVRAMLAWSU0cJhZ3mPyN04whBhB0vJap?=
 =?us-ascii?Q?So2Vl1e7Lk9AYFh8T5t9HUyVnjnrHa24TTUKYMJrU+zYqcAjNY+9drgnhGeg?=
 =?us-ascii?Q?pae6+/AaXfTQh3urOr8SmeUGqA/VkbkJS43/KCDCDOmNFQA9KbtJZNJbXeJI?=
 =?us-ascii?Q?bZqtn3RzpenoNfm08DdaEqPvtZ1FT/POI9K27y9mtoiQgyxgFkC3bj9UURH3?=
 =?us-ascii?Q?aJzoRF0WKaN+l41wVNpfm092CbY21DZ8eJ3+ptBzUUo9mCkgqpWkenoxjuto?=
 =?us-ascii?Q?yVCrdsvjrI10PbXop7FqDRd0iuSjNdblIS4I3gBzy0Ryz6gRU8ozYQAG3vwU?=
 =?us-ascii?Q?r3fSuUsHc7y3JXKDKRXtkPeExexmKpCFfboqs1AFNOwZ9qXk2g2T9jkdDcD2?=
 =?us-ascii?Q?hbEtxy4q+5zCgNq74EoBYHgathePYxoRyJ8WYvtDtGGt9zBOJEB3P/V8RRZ4?=
 =?us-ascii?Q?1prnAqiCdts3n+j/fsoLB7e/RlN0RH9quwk2w7y4lgwc7dZcfGTMdPwn/OaO?=
 =?us-ascii?Q?1kn9ngijkwlN4FKDOtDNtRYkiCyhGjhc+U1jkhuvsWEZBxVu/AIxZtuCZi3F?=
 =?us-ascii?Q?ckJGA4zFfAp1pAolP/XzQIhBIny3Q6oEoVdtWWUw2IY8fcoIBuggFiCvkmqm?=
 =?us-ascii?Q?W9wYNmjNk4hD82XjUsH8uzw4vABtfWfp6g1mwbdZyKpwld2pHlTxoMT9iI11?=
 =?us-ascii?Q?su5C6C1asoMFUMAAZN5CXoAOZioAH35fpGsdfqMVkJzgVEqD/LT/jfnZWRHb?=
 =?us-ascii?Q?i4bG2tC8/ljrEGvENIqJshyf3toBxtTAiNgXFxMePdCXW0cAb7yd7VQ5P9LF?=
 =?us-ascii?Q?cDzI1zuZIJVu7N/SjYj1ymmho9+9PKvigjL94FYvsJrF/o0v4eAvpTKQMT2t?=
 =?us-ascii?Q?jIfA+nLXs6bPAPDESFp9EIUXOHH3gYLSEqEW1DGA1SW0UK/yGIGTGa4Xm8s0?=
 =?us-ascii?Q?Ohc6flKKdb3WQ/QkMmVClBiP5IRQ7HhQ4Of4TEPPEqtTN45/cmLV+3GK8HKI?=
 =?us-ascii?Q?QQ7G7H2NhS2QVCHJQytoWotzvjOTDYlZICYVkubU9Wk5eFVSW9qX8lH0mDyo?=
 =?us-ascii?Q?KNt3cwsm7rWS7zYnw09ZuTEL3NdP6uja+udHU70H63feMP1Vk7skYeKEzOjl?=
 =?us-ascii?Q?6t5MUqtZ9n42sp7XMTcoXq7G1BzT3bwLb8acy91GtblQUjUIATpaNaY78ctS?=
 =?us-ascii?Q?0ZmdtOKVfXvu3/R1GSt1Y7Fvei5/gxSKEWa4vMGgGMbOuzPM7/8fqzTLMWqu?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea6858e-90e0-42d8-d3a4-08dd3769980c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 02:41:21.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiH5V3p6bL5s21070jU0iFj4z7oCxdHJVJZfSoot7jyGtfq1FpLCRpAnouavpynMgbAfOUSCzb1F5bLsOTmXjhwOAz2s/mn2f26lMXpzDCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5864
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl API for creating a cxl memory device using the type2
> cxl_dev_state struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 911f29b91bd3..f4bf137fd878 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -96,10 +96,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	 */
>  	cxl_set_media_ready(cxl->cxlds);

It is unfortunate the media_ready is just being used as an
offline/online flag for memdevs. I would be open to just switching to
typical device online/offline semantics and drop the "media_ready" flag.

>  
> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> +	if (IS_ERR(cxl->cxlmd)) {
> +		pci_err(pci_dev, "CXL accel memdev creation failed");
> +		rc = PTR_ERR(cxl->cxlmd);
> +		goto err_memdev;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
>  
> +err_memdev:
> +	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>  err_resource_set:
>  	kfree(cxl->cxlds);

In general a function should not mix devm and goto as that is a recipe
for bugs.

The bug I see here is that devm_cxl_add_memdev() runs the teardown flow
*after* efx_pci_probe() returns an error code. That happens in
device_unbind_cleanup(), but when it goes to cleanup endpoint decoders
and anything else that might reference @cxlds it crashes because @cxlds
is long gone.

So if you use devm_cxl_add_memdev() then cxlds must be devm allocated as
well to make sure it gets freed in the proper reverse order.

