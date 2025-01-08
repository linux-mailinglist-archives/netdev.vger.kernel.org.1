Return-Path: <netdev+bounces-156127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D6DA050CD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AEC1684EF
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC711A8400;
	Wed,  8 Jan 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITjoZ9d4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BA1A3056
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303364; cv=fail; b=dSeMKeQWplASa7Fhiuuiw0EHamMmhU6DL9sGqAVc5PvM/DKODWh2WDQ1d5Fceri9V3o2Ntemhq+q//7A94Y0/WLCAU5IPDaPkU3oN5iq1dtc0HtrCG/tVGD0Nunz6Mb/J96kpuCkc+OkKcq2ZwtFIB7BmZiTENR5FuEx10HyhEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303364; c=relaxed/simple;
	bh=7C1nIb77IR4NtHIHrsM3mY0tsvcWhdIocBZ4RfWP3Yc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aI5LyYXONo6nfTDMZRZ/3dwdUYtnalp3k8U6Dx3NCIVLR80AeNz6+Th0859iwTWqVm9G0xCqLYa+AG/gvdmz3bGnwRv8S+bDmHCiEeM3Jcv35/KATlkbhWEjIu8QaCp0C4oWpDmZj0RwpQEpBJmSLBHfrLVzDPKE5xS3DIp+EPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITjoZ9d4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736303361; x=1767839361;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7C1nIb77IR4NtHIHrsM3mY0tsvcWhdIocBZ4RfWP3Yc=;
  b=ITjoZ9d4O8vRyTU1WZP9OO0Fw0Lc9uhfXA9sF1rDlKLeCzT7OJCiu+jr
   snM94XZa83fQtqkeg6Z5jbSrjiNJeRRGFXvKIb2FRWb/OYGvWmpuquuTU
   +WisdI7MfwNsXNPd41jFSHfP/5vCRJhZ3MFMj7/Mi3l3g55kdFcNoUFA9
   erVNlhLGH20enJLjmVj/QPQcOAQh1CMxAzkxkYW3fVuNUdGj8YR9LfXSW
   F4zC4nmfMYfMhAWO5JcVtuQZMeClhE1fP+X79PTrvT0jHnyTOXTA4ePel
   kI2fgaBQ1SRCtfxRE0wQIneYKmQhrHyZT40TQO1QP50tZV9M7fOMoX6Lk
   w==;
X-CSE-ConnectionGUID: KItLPri3TwGe0UKNCcT3og==
X-CSE-MsgGUID: CewD2DHSS1Ss3kGWPR5D8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47928632"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="47928632"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 18:29:18 -0800
X-CSE-ConnectionGUID: QuR56OAtQvKsZ1UfcW3HpA==
X-CSE-MsgGUID: wBUs5AhSRjKPQ6qKY0N8yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="102863872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2025 18:29:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 7 Jan 2025 18:29:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 7 Jan 2025 18:29:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 7 Jan 2025 18:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgsbe90bfaaKEg2ohAvB+xOEV95YrmvQHYA8vLNVrDkU5A6NpmSyIiQwL5O4URX/fUwFtrbN1EsE9FH0UFLqBhLjrOP/UAu/huCrZJ3NHHbjbZ+tV7e/boSex+tUY8EGqAQvqE9Oz0EDs3AM8vkRF56hXAqPsUpk8sM0pNzwVs6sR3IQlcRuKXDPrMVFSHJExgIswClc08SAlTfWvjUr8wfnEOiwnI2E3xN3MWMqVoWXsan9aYInFN/OtYK7xiVod/06HvhxFCgXkvPbdNGpUobFbmWJSeqaFVi/O/e3lxYbW/TVPuKDlxzll3eGAgDjclLzvlXKuv+1yUzELwSbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmDWhnLkOp+0JkZ9DpfXEOveMqT/GKAd0AKXTfYMoMo=;
 b=k3jRn8SYtNZDbf7Mw8CjbsRpM5jxGTezY3qGAbRvlcReJ2GetKBuIc9xS7SeOhE5+pWmHoxA9tBYI4y5EQ353Vic121L7tKIMhRo09I0Zp9aJaQJ//eDPmQ4UptVNBTESIRGpSNyNNbdmidyzjU9KxWfCKPHF9U8TGLx7FgOBa5GwP4XjZQDj6i7yrjAmU1/5Rd7/yjhMxorEp2sd+dK56qw3olBcfvPpa602A3l25y6eJruOsLNRTCAhFAu4/QXcEhZmiFP38Or7jais3v2Hde0j3lMvGyIxSre0ffzelPP2f7q7KqWqnNeSUt/mRPpBKSK6WfEq8SM1rrAz1qawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 02:28:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 02:28:57 +0000
Date: Wed, 8 Jan 2025 10:28:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 net-next 1/4] net: Convert netdev_chain to
 blocking_notifier.
Message-ID: <202501081030.464a8d0a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250104063735.36945-2-kuniyu@amazon.com>
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8a02a0-1b20-4efe-c7ec-08dd2f8c33bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TKju6M6RUyFTf/Z4vykHFZ6PjDuUuZWvMVsrDWkEF6UbCvQCnpYe5SoptN0j?=
 =?us-ascii?Q?hx8ouY+8DQBWqHVMQOBe9uIk1iCZ8tQOL647trL2iC5qpwh5X1h50tK5e83H?=
 =?us-ascii?Q?GgIM4a9GRM7tIPpVmIVQ/ZZtbEnMPdU4b3K8jtlPkwexjsM1QUDy8rRLhzV4?=
 =?us-ascii?Q?S7MCWURHVLR75lNN/snojRk1n7KUr5ReeIVReJ6llQcdXBt3DQq8o7Vc/IW6?=
 =?us-ascii?Q?utn3bVamGFC03gKIsKX23ZQuAXg8bD7ydOSxi2mSbekItZOUJynA5pM4/Z49?=
 =?us-ascii?Q?1VTzoLEPXtAnY8ANHZRRKwcbICpxkjwMrtsyVAMg5YldUnWV0lLua8UZFjAX?=
 =?us-ascii?Q?O2iGfRumgA8f+tyk6oTLrTTQfo6sEDXTCr4b/hG1CibnfAI5v1fNeanQ39GU?=
 =?us-ascii?Q?pVegM3g0HMoA2qhyLsQJjIcddyJuXyiwJMu3QBniK8MfdoGcKXrH6pY4vboZ?=
 =?us-ascii?Q?5uD+trNwzRBpvsk7taKrCyOYbh6bZ4Cef9Ke5UAXp4mF5zpkzrv0k8/MtW5h?=
 =?us-ascii?Q?ZW7zVy4bQyKpvgPMDCfYrbMCVqcN+QSRGvf4/1jMA3AEDHBM65iw5x1ZDQ2A?=
 =?us-ascii?Q?3B5e2q4JVa/YM0BU/Eh5IbqvxJqnoBL7w6/IakGUW2FstwlnSEsImyqmeRXa?=
 =?us-ascii?Q?FKnr5oP5WQclxeIGuEqeEnfVbGda2hXDgt0g/mZLrKbWshtXKHd8Bc+4xyQX?=
 =?us-ascii?Q?pwsaR+f1ZUUxSZ95vvjG9KckJtauhlbOeyFYt9uEaCXxgamBQkPCto4lDbfY?=
 =?us-ascii?Q?JXUcEKnkJYw+IWuN1L+M/qxSPcZKgDJELA2en6aFD6PLTj7Fw/ZwHa7ITMXK?=
 =?us-ascii?Q?UYyj95s9PZGISWfE7IeAvd0kE3XZLVlfxrCUXGIg+9rRKa8WUCnuTHY8vsIt?=
 =?us-ascii?Q?d0pJ0zmYGq+86xUL5P+SJLLYh8pef34nzvNuxUEL7nAC+b0d4OqgErw/c2WM?=
 =?us-ascii?Q?o2r884BwqNRPZ2rL80Ljviz33a8W4wMw04anwaYbs1fuVZkW0n44/Y0I9wOX?=
 =?us-ascii?Q?ujSdE52PH5W0UsaYBxGEF/RejPixorYO2GCKgI5ZjkR13v2yx3CZKbgSb6X7?=
 =?us-ascii?Q?APSSG7EGfWt79QZRhVcTX3hhlYC8WoWpZkqgvcio6huKafeIOxUHPGisMinx?=
 =?us-ascii?Q?WSPFTKhSNUVi3peFffZI96nwNOEpx3Jh3Yq6nHBanJKLG0bmKXOEjJBPUqyn?=
 =?us-ascii?Q?MDaol07yHQp4zHH8pXOjQpj/pjUKUq1XCOc6Uza+bV7/cLtRuD48EeYRrWM+?=
 =?us-ascii?Q?c6JiT5Q90wVf/e8rFIbav4F27sZWHw34T07y6eELmEcz4Was+BNHy+dAsKhm?=
 =?us-ascii?Q?zVwxdux/CgtF3zxYnsDWD5PSbRoxED1+T+5tNPjDUI+1dg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MdqPGwUL4sd1bvr0Sum7H5jjIWsssh59/OETvTxZaCKXZ3UDfCiks6oyJclJ?=
 =?us-ascii?Q?j7ygVRWS2T8gS4zKl0nvWTZ8+BHrNJEqM+wgsriad9NBy2Z2+HwQM6ZR8/Zl?=
 =?us-ascii?Q?9kDrM0IHpxaGrqTes1j3R0NGsW7XSwYQExtyHbp2mZwfQ3+PVrx+EbgMOUZX?=
 =?us-ascii?Q?YSIdrJLueKeqPpXQdycLkpSjdZOo4noOAtGNTdMdO3dt0D4XjMv9dBEq6pVS?=
 =?us-ascii?Q?NazF31kIT+cTA1sAh4vaOPXu9qE+h1pPQv0G3oQ6rNsP+A1CczdHFv5BxOjm?=
 =?us-ascii?Q?rAJg+SNy+n3E4TGpkpus8oR9m5gyxJ9B1k/JA9e7c2tRyqCUbk+aNXQ1tHa9?=
 =?us-ascii?Q?ofUAGMDs4D7h9YRiHoLLAL7Bsr4a09QyNN1cGNjEoAlmaioRbr4vLI8p2dxc?=
 =?us-ascii?Q?2NSjm9NMNmpW38x+DDnNz9TF6SWzqeOMcdHpdxUWZMaebXpP3gQHE7gDv4V5?=
 =?us-ascii?Q?1WDUJH4rwszlcccHBHkUWJxJXszi0Mp8c9B9drmhHk9c+a8iqAFRkLcc/DL0?=
 =?us-ascii?Q?r9oupJ0GKRccM2XXcQdKEhM6flGaKE00b7qSVL84Cx6yRjH0FpDhoDPqqDu2?=
 =?us-ascii?Q?M4rmPxMv0g3GVoMLAB95PvfCquVeJzBWcAbMsJwL/rIroSxEy9NsKTvjSRMh?=
 =?us-ascii?Q?G+a1UX35AvPw7tIM/JzvhGJZkU3xaJqHuqjU+zq/hDlDwCobdfsqJzyjUxXK?=
 =?us-ascii?Q?voLM7h+tcwM10Vs0ciQkUYkVwM7VvBcu+QwcGpyok3m+IZwLeAGukHm6GkRk?=
 =?us-ascii?Q?otk0TgRS+ESBRaDPQC80KigVZayqmImzJR9TcYJw3zPW8afWKg7M7cU514Ys?=
 =?us-ascii?Q?jwzk52DHK2gwa4AoVlDfD9SGpjKEbLvdnjr+PxcgBw9Uhf97LmpHoOoRKf7+?=
 =?us-ascii?Q?WCF17sePHPV4BOWqHB1P1JWWlEtP0QkgstMBmbijACqHt8Xud9dXtZfRAZ5a?=
 =?us-ascii?Q?oEEdFFE0496bOxf+ILzPR0yzIz3GTwby0MQiNJs41HOYK7Sa1iEl6U0MSD5p?=
 =?us-ascii?Q?Tp1v42v93JMx87R9u+YzTCsJ9X/OEF9GXn/WDaux5G0+uSkYabXZnDvB01g+?=
 =?us-ascii?Q?lucuTwoyXDnxoL5D2QWpMe+zsc/Tmv0mbV77vm3kRKOAMAfH7zQeyE4Oociy?=
 =?us-ascii?Q?Fc8jzCYhwrLSsgv4Q8aRnHJ+p4fSE2imFhop89i/M9mo4Muz8oEk5vZc7HUs?=
 =?us-ascii?Q?a4VVR69O9b8OvlvvaHpMEZ94J604tsICAs89ce/biUAWiDfWM6kv+b9V/ugh?=
 =?us-ascii?Q?2v2LW5zuTWCx9LUr7Ep1PAFCtFV9gMyxA+ZuVNKhe7K6ImvJpsQ5lAqdSSBT?=
 =?us-ascii?Q?ZoSsnGKjPXgp6WoKYJyxNIn8PxGbtVmESzkbWNaXKOy2vjH4f8M7rfGHwRws?=
 =?us-ascii?Q?mf/H1RkqU4dIUTkIXoh8SsEFc8aQijzk8lLLs1B6IlLzLeDoM6nw81LPpOHu?=
 =?us-ascii?Q?NzKpp0x2haoOXTDQD72XH1lP9piWXZnAmvnwj7zcly3gH1e5bzDE8VobOn58?=
 =?us-ascii?Q?tZumgZ9NBIDVQd+BZs4re6QPEvNYILWZpUvQPyDpUzz3QEyeSvngRRxR0nrw?=
 =?us-ascii?Q?oj9/gEPg/4w/ruxapww6yB0E6y/p8vLuq4QDsbgLCiMMfJO2gT4etY0j+h+9?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8a02a0-1b20-4efe-c7ec-08dd2f8c33bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 02:28:57.4781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrikCetHj6MrwVa8DDfDMYF8dvLqY+wBIarGYRD4MERcyWtKQLGLHptCYXs2jD7HStgmLJSWK+9bKvqV6p68+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_recursive_locking_detected" on:

commit: a105e36eac9fc55523ee0157ab2aeaf0ebe949ae ("[PATCH v1 net-next 1/4] net: Convert netdev_chain to blocking_notifier.")
url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/net-Convert-netdev_chain-to-blocking_notifier/20250104-144302
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 385f186aba3d2f7122b71d6d4c7e236b9d4e8003
patch link: https://lore.kernel.org/all/20250104063735.36945-2-kuniyu@amazon.com/
patch subject: [PATCH v1 net-next 1/4] net: Convert netdev_chain to blocking_notifier.

in testcase: boot

config: i386-randconfig-011-20250106
compiler: clang-19
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501081030.464a8d0a-lkp@intel.com


[    5.611439][    T1] WARNING: possible recursive locking detected
[    5.612070][    T1] 6.13.0-rc5-00768-ga105e36eac9f #1 Tainted: G                T
[    5.612838][    T1] --------------------------------------------
[    5.613448][    T1] swapper/1 is trying to acquire lock:
[ 5.613981][ T1] 8bb1f2c0 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain (kernel/notifier.c:?)
[    5.614973][    T1]
[    5.614973][    T1] but task is already holding lock:
[ 5.615681][ T1] 8bb1f2c0 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain (kernel/notifier.c:?)
[    5.616710][    T1]
[    5.616710][    T1] other info that might help us debug this:
[    5.617477][    T1]  Possible unsafe locking scenario:
[    5.617477][    T1]
[    5.618212][    T1]        CPU0
[    5.618531][    T1]        ----
[    5.618867][    T1]   lock((netdev_chain).rwsem);
[    5.619378][    T1]   lock((netdev_chain).rwsem);
[    5.619874][    T1]
[    5.619874][    T1]  *** DEADLOCK ***
[    5.619874][    T1]
[    5.620686][    T1]  May be due to missing lock nesting notation
[    5.620686][    T1]
[    5.621503][    T1] 2 locks held by swapper/1:
[ 5.621956][ T1] #0: 8bb1fd24 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock (net/core/rtnetlink.c:80)
[ 5.622737][ T1] #1: 8bb1f2c0 ((netdev_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain (kernel/notifier.c:?)
[    5.623745][    T1]
[    5.623745][    T1] stack backtrace:
[    5.624307][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Tainted: G                T  6.13.0-rc5-00768-ga105e36eac9f #1
[    5.625360][    T1] Tainted: [T]=RANDSTRUCT
[    5.625789][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    5.626829][    T1] Call Trace:
[ 5.627162][ T1] dump_stack_lvl (lib/dump_stack.c:122)
[ 5.627595][ T1] ? vprintk (kernel/printk/printk_safe.c:?)
[ 5.628004][ T1] dump_stack (lib/dump_stack.c:129)
[ 5.628427][ T1] print_deadlock_bug (kernel/locking/lockdep.c:3039)
[ 5.628931][ T1] __lock_acquire (kernel/locking/lockdep.c:3089 kernel/locking/lockdep.c:3891 kernel/locking/lockdep.c:5226)
[ 5.629437][ T1] lock_acquire (kernel/locking/lockdep.c:5849)
[ 5.629883][ T1] ? blocking_notifier_call_chain (kernel/notifier.c:?)
[ 5.630484][ T1] down_read (kernel/locking/rwsem.c:1524)
[ 5.630907][ T1] ? blocking_notifier_call_chain (kernel/notifier.c:?)
[ 5.631522][ T1] ? notifier_call_chain (kernel/notifier.c:?)
[ 5.632054][ T1] blocking_notifier_call_chain (kernel/notifier.c:?)
[ 5.632631][ T1] call_netdevice_notifiers_info (net/core/dev.c:1997)
[ 5.633224][ T1] register_netdevice (include/linux/notifier.h:207 net/core/dev.c:10597)
[ 5.633717][ T1] bpq_device_event (drivers/net/hamradio/bpqether.c:500 drivers/net/hamradio/bpqether.c:542)
[ 5.634190][ T1] notifier_call_chain (kernel/notifier.c:?)
[ 5.634710][ T1] blocking_notifier_call_chain (kernel/notifier.c:380)
[ 5.635284][ T1] call_netdevice_notifiers_info (net/core/dev.c:1997)
[ 5.635875][ T1] __dev_notify_flags (net/core/dev.c:8995)
[ 5.636372][ T1] dev_change_flags (net/core/dev.c:?)
[ 5.636833][ T1] ic_open_devs (net/ipv4/ipconfig.c:242)
[ 5.637265][ T1] ? wait_for_devices (net/ipv4/ipconfig.c:?)
[ 5.637736][ T1] ip_auto_config (net/ipv4/ipconfig.c:1515)
[ 5.638192][ T1] do_one_initcall (init/main.c:1266)
[ 5.638656][ T1] ? root_nfs_parse_addr (net/ipv4/ipconfig.c:1477)
[ 5.639169][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4670 kernel/locking/lockdep.c:5180)
[ 5.639684][ T1] ? ktime_get (include/linux/seqlock.h:368 (discriminator 3) include/linux/seqlock.h:388 (discriminator 3) kernel/time/timekeeping.c:815 (discriminator 3))
[ 5.640142][ T1] ? irqentry_exit (kernel/entry/common.c:?)
[ 5.640619][ T1] ? check_preemption_disabled (lib/smp_processor_id.c:16 (discriminator 1))
[ 5.641205][ T1] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67)
[ 5.641755][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4468 (discriminator 5))
[ 5.642293][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
[ 5.642800][ T1] ? irqentry_exit (kernel/entry/common.c:?)
[ 5.643271][ T1] ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1049)
[ 5.643776][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 (discriminator 6))
[ 5.644336][ T1] ? handle_exception (init_task.c:?)
[ 5.644843][ T1] ? next_arg (lib/cmdline.c:273)
[ 5.645293][ T1] do_initcall_level (init/main.c:1327 (discriminator 6))
[ 5.645781][ T1] do_initcalls (init/main.c:1341 (discriminator 2))
[ 5.646223][ T1] do_basic_setup (init/main.c:1364)
[ 5.646697][ T1] kernel_init_freeable (init/main.c:1579)
[ 5.647216][ T1] ? rest_init (init/main.c:1458)
[ 5.647671][ T1] ? rest_init (init/main.c:1458)
[ 5.648135][ T1] kernel_init (init/main.c:1468)
[ 5.648604][ T1] ret_from_fork (arch/x86/kernel/process.c:153)
[ 5.649060][ T1] ret_from_fork_asm (??:?)
[ 5.649533][ T1] entry_INT80_32 (init_task.c:?)
[    7.669903][   T35] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    7.682723][    T1] Sending DHCP requests ., OK


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250108/202501081030.464a8d0a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


