Return-Path: <netdev+bounces-103522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A019086B6
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8071F21F11
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651EA191493;
	Fri, 14 Jun 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlPqCobT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007419148D
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354951; cv=fail; b=YG00VM9CNTPcJVAinK+8uAFTFD5OHZosZfKOx9KDyl+MHl4/E7a7AQ/5L+K5Bt3k8gVCyoliU/EQgOf/CArqfd9KijW8xqMBJucyygOkR1SHJtSuRJzliP2yku3Uv+rPp7KWQSLel+B1/vNJ1erc3l7pB4oRuGD3Eaj9nBkPJtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354951; c=relaxed/simple;
	bh=E3X4liueUQGoQFCSKPbz3124mPO0g1kBFcLMr9KdD5E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=CUNstYOJ3iKFLQt3TZb0kGtOgnAvjprurblVZOY/ClGrTa4utuC8lic/kpIqMWRLnEpFMd6tbUmYqhTYmXhHZ83y6nA77Rb77JLSJ590OaSrfRq21tMqHxL9DgaYBvhxRuvdBtpCzaMgbol8FE1uYGg7YnBI0eb1vS4vwbz7VGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlPqCobT; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718354950; x=1749890950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3X4liueUQGoQFCSKPbz3124mPO0g1kBFcLMr9KdD5E=;
  b=GlPqCobT2Eknwr37WfUz1ojtI0qztHQ1pvodqH4iUCeQnbnWteiV8z/y
   xUk8sGjjfXHuyzxKKuR4UT9za0GZJrCdYe4lq8zgvHQ7/NZkXQSPbEP/M
   cvo8mwiGosR72EHHGoKW0LqFaPn3lK4GSZR7eTlwQvUYaL5xHv+LnzDCD
   VSnlryljTbK2kr6j3CEkOI9QD9WwNtG82OtRxmFuJA20zvovqus+u9V1o
   /ZqM6ydyu9LnzAWzZZ6QQsqYW51nSCfI2heBbxhh4h4U6+pFTFD1UaOK4
   EQe7tNeBR8KUx/LdvanlnsdDm246dyYDGlu4qHj4ghAIHQ4VK80ZzuS2C
   g==;
X-CSE-ConnectionGUID: +2GGU73iQjeBqerwmSxIWg==
X-CSE-MsgGUID: HUqRiZKUTDSfUnDLkAUiDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15355321"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15355321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:49:09 -0700
X-CSE-ConnectionGUID: RqfSxSfiQlmBykF/mJqVQA==
X-CSE-MsgGUID: qGJ6LPE/RMSQ7tJ9FE/vag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40402383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 01:49:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 01:49:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 01:49:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 01:49:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Uw4B7oG44iDLADW977+NyKNznj71p2kKAbxfcYjSh9XvcXmnIb/8JiuLatZhF3LflwS89zsM8YzCZwUodRv0ITCLm/vXJUj3r7KHjtPARA0QnuL+etfmu2FOHxPpYOfTY6HHFDVBqhnVy2nIOKz8uM8+8AxIOwtKKv+9iQxKXNHNCxv2XMoJ4NKU8pm9NO9YR3Bn8IDfygqivE9HpLiy2My6H6p+L1szSSOXWdZkNZXa2NF5J6PJT1sAoDBE9spoQ45uYvr4gdR+KOvI+1BWIxgfL8bB1ZoytaLHc5DrYqI2YaKx/NN5lcAoxs15OrGkSy9znaJA30Fg32ilr4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qty7JqTkulVEYGmE/ZWX1C48YvJZ3W99Ay3QODxokDU=;
 b=PzZCO8iCpX6MoHseI7PdQZ6D31tX5mD/jO3Dxuk9LcFUAJ876//Ty0Msfd0XuTn6vZRa2X8AqPetcxMJUUT0hUrHteyGulbvAmWwTOrPutR9U67XKi9vgfeBlTVg5cFSfYm4Fqf8MOGNq7fFMolT1IO/5fdv++Swr37sPMHtkU4baWjHSaCZwFQ6eMySwvpb0mL4qBcMs+e78Ubq5+tv8wLot/gCCBy113cy9UoEIcyfO6fmNVStsLyf3cEhLulS+KAw00VKfmuI/uqFjJl9gXbgqHxRQOaejLqjDPKBqbvyeVFwtBepIs1PxnQE8VCiJ880gHEXc1ci6LPSsmnNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 08:49:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 08:49:06 +0000
Date: Fri, 14 Jun 2024 16:48:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rtnetlink]  8c6540cb2d:
 hwsim.mesh_sae_failure.fail
Message-ID: <202406141644.c05809af-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3069b01d-61a7-4956-b149-08dc8c4ed9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/P1B4hlvC85hSLi3g3q6LMiFA6/k+T+mn5F4tgcaHFnyUAd+alh+ySYZWOt/?=
 =?us-ascii?Q?Fo7DZjSun0s36hkvF2yoL6vH1i1EQRP7e3nq9IrBAJwpjO+XDdg1CQDChhmi?=
 =?us-ascii?Q?NQNfokOh5JewScVDzuizCpZCtx3PWyIfK9UxmKTteffzaEHovOQyRBM5MSJG?=
 =?us-ascii?Q?7JTgJXsT9QoHApIFR7ASyL/yJkrahOfoYZKh77s/LgP0o2dsEGfeWTkt717W?=
 =?us-ascii?Q?ONiQjqRl3ztDtTcMlYSrJ7Mb3BT3OEVz8d41+nRm8z5ijfqmhiOcUEozBdEy?=
 =?us-ascii?Q?yhru6Uo2gGJV1I8Mr627qLVTlx9eNZMhxh0uCt/B31rlleh17DFGeHRZUZuw?=
 =?us-ascii?Q?ItPTSMqaFNmMvhXY5QSt8MDuYaW1VfIc+8WTIdaVThJmMX30Ozmt8xn/H2Hy?=
 =?us-ascii?Q?OLtn3R3BdSB8Vk/jeYkRa7sBmxdlq7Zz9qABmP7IDjHz084+WwQ2Vfp/qSjY?=
 =?us-ascii?Q?9gWfaJTmFgJKMaxRkCOo0rk07lkpFYFG9+ySmIzymHIOHUaf8IG9fg07kuky?=
 =?us-ascii?Q?PFXd4utbxf1BmZ/iU1aP5dC6MjHWfs83dy0FMXeUiK8VC7KaJeeQ2Pne/9vK?=
 =?us-ascii?Q?wIY2vvy3imTJ0XfjChh7qufDg7yStsRwM1/7DLJXyd1PWlIKsRe/NmndMBWF?=
 =?us-ascii?Q?G2qUPFksOb6LCbStV08DB88HPuckUwvF2Qjvhfdhex+Bxkf1xKJjR1HHfLzO?=
 =?us-ascii?Q?hBB40KW38SmVIdwF0ugQEhezHvcLq2pKaxzlx71yHQNQUHEZB8KJqNSzVLcq?=
 =?us-ascii?Q?Wh2Hpdpfh6I0ZtM3nCTiX0JMcTEVPx5Np9/4nW18QLDhG0RhMlgdjuAmjThr?=
 =?us-ascii?Q?+CFbR/NXix0vBOhiJwH2KsCqi+pA8eTqY1sFTeqzGRfcVxuR92Adk9WTq4E5?=
 =?us-ascii?Q?RCmdUjSTNk2EFHEAMU+DlxRqXgpz1urQM9QdCJhoPhrx2RtSN21wg5HiQTjL?=
 =?us-ascii?Q?bmccnHWp+ypm2cUQXS/2QHIoE6pJ8qSU68jPG1pVkOHHBDs5//wA/cjAzoFz?=
 =?us-ascii?Q?I3+dRlCUV8pO/PD6HG2OnG/ZDRRFvH1tce4WRuvS2qMbHVIaictJZ3/LNZrL?=
 =?us-ascii?Q?mtklJ1d5mSEXQKPVYR/djxHAhgtJVwDjBVI79BHF0uebFkJHujPvq4QF+oZu?=
 =?us-ascii?Q?UNC/wKhf9zKNetsVwA4VQHT2qqzuCrD5JdY+4sIXAn5CM1UxJQFLbu04gYu1?=
 =?us-ascii?Q?2u3vEYEybzqBleDh7lK/wwslvM9Ni5T9iMyFva9mfCJv+eGCfnPH6q2+bqve?=
 =?us-ascii?Q?p7e+D7i6VAeA7UccCNLBvN7C2x3HVM83Qe+CfOTlOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oxz2BZSW+o16TAWRTCc3xblF82okbzTdr1I8FWyl51slbrWK/alkXZmrYxpu?=
 =?us-ascii?Q?b5bWvlcCJ5gnk+O3uY3T349mdIkmqOg4WtvyhylTO3qEoiiB141iRCtBpW6B?=
 =?us-ascii?Q?YMDZnqjNDtRKmWgd+MwH28/Jatgdz7aosaNsWXYWfNvU+rx3RHZm7W57Jn37?=
 =?us-ascii?Q?kJ6k3WR68MrIIIYUDc0CeJVlOBae2jdYQcvJIwk07Y9SePE/svN7kpRNRkPS?=
 =?us-ascii?Q?t/xRIjtkD4b8ijYfamUmU3Z3oJaOO2J0R59WsHWg2EtN3VpAYP6++m+Xtr/R?=
 =?us-ascii?Q?yRx5fn9IrE5oWI1uBga9wGHHvyJluof77W+kJ1yFouKouYLRaRFo0QWfM4Q4?=
 =?us-ascii?Q?DNzTpIrjHuZdkuglfoyOsJrjRfYzfmuMTjtawFTJpM0CZrh4TpkAcIJAN56F?=
 =?us-ascii?Q?tG9K6q1nLVnLRWfmhvGnpANy1pAnXPIeiSK0lPk118q22obSwxM+9IMJGtd7?=
 =?us-ascii?Q?fj55lRvhWAuCEnoQm2uCsULwSIKOdq2K8Aost/DnRJuo0bfBN9QsC4nrkIw7?=
 =?us-ascii?Q?Wio7580W2ai+3J+d0n8hCk9GQerD6bYw0XqAGbrqP30f6M5017lRlms9cX2b?=
 =?us-ascii?Q?dSX2+e8GqMQL9qJ0wAxvP2VJ2jbmrmaVLQCEzA82+GFpRcwnXrg70vjWCnE2?=
 =?us-ascii?Q?m/Jux0frDB00UxA3DA/TyerQKljB9DH5foLOQaj408ArkkKn5xMW3ZbeB/GD?=
 =?us-ascii?Q?zz9wC4W8TiyB8av5tDDjjVG+QGKV89GrhWl3O1OTVRsXZHQItFspJ7aWC5yc?=
 =?us-ascii?Q?5CZRo1pRj+Y5jrYiYG/ne2pxtj0gM9P2ptx4IBkpV6WoQLid3UHqsUO99ayx?=
 =?us-ascii?Q?hg+mPqzg1xQXYnaxf3X4g1kehMbQto5t4lCIC7RDI6BNG0r+HKc+TGP2TErM?=
 =?us-ascii?Q?eJFBsvzpuiH6Be0ZkXgLWquJTEBRZAWU5DK001w+WP2b1l9UQwzbdyll8gAD?=
 =?us-ascii?Q?5ndjXDt05RcSu1EVdYeh2AoMtuFJpYzPHcru8Ren9RAjIhBNgqFR07vpLLAY?=
 =?us-ascii?Q?L4PQCm7i8kXYpc/nPu6Wn+04CPcOwuJRLabhaI+iHKQ6iL84ABCtEyvysJ9m?=
 =?us-ascii?Q?wQUIyKHpg2chyJ0Giu8CNLD7a88TymOzAWvvJrZTngb2d1fWi4JH8xfMaRSw?=
 =?us-ascii?Q?hrj9R81kJLmH73RYpdpqJgqstVLd4k8LxtA1rQg9zVaMFH/X5gzGZZsMWneQ?=
 =?us-ascii?Q?Wqko4fFskfIvziiPm+jKgW1r0EQPScbD8AGjqQp0Q53gwVjgW53ZsE/bDNHb?=
 =?us-ascii?Q?cE1GxeglzquxIXL6kkWjxx3kiRjlOq4LfBCfZuxoqCPGR6RWH7fzAQUPZ60u?=
 =?us-ascii?Q?N/ScSUw8JMA9dyn1CNwoqYmQggtL7NCtuDUT+LOIhsV9BGvnzkE12vU/jI3l?=
 =?us-ascii?Q?XDPzD70gb0YcnkysbAmHr8VbWzgretmhv6Fo17958D+aWc8fpDHYDEBtkr+b?=
 =?us-ascii?Q?SpIYo9gBQUpjmxbpj3iKbBtwUPt2afGQozwl9EB7IVQlTenazx5KDkx2nVVr?=
 =?us-ascii?Q?Tqpt37ou99qgRypXcyVGbzvrCTSRDfSVBqytk9EC7FtQLFZKc8xoJ4YUE1Pz?=
 =?us-ascii?Q?6YYLaQ+pO99P9QU2LVfLUNtQhaMgl5dqw9L3798E6ntUFHsJ8DIxa/e+OJDj?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3069b01d-61a7-4956-b149-08dc8c4ed9ac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:49:06.7783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1BwTGwh0XWbREZolqRs3Tr91IHCVrUubtP6vYW51k+6IKe4Bd4D2apm68VWkTQxCAQcGHgE8IAq0rC+wnOmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.mesh_sae_failure.fail" on:

commit: 8c6540cb2d020c59b6f7013a2e8a13832906eee0 ("rtnetlink: print rtnl_mutex holder/waiter for debug purpose")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: hwsim
version: hwsim-x86_64-07c9f183e-1_20240402
with following parameters:

	test: mesh_sae_failure



compiler: gcc-13
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz (Haswell) with 6G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406141644.c05809af-oliver.sang@intel.com

group: group-20, test: mesh_sae_failure
2024-06-14 04:11:22 export USER=root
2024-06-14 04:11:22 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-06-14 04:12:20 ./start.sh
2024-06-14 04:12:24 ./run-tests.py mesh_sae_failure
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_sae_failure 1/1
Test: Mesh and local SAE failures
Pending failures at time of exception: 0:auth_sae_init_committed;mesh_rsn_auth_sae_sta
Test exception: Remote peer did not connect.
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 1942, in test_mesh_sae_failure
    check_mesh_connected2(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 136, in check_mesh_connected2
    check_mesh_peer_connected(dev[1])
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 122, in check_mesh_peer_connected
    raise Exception("Test exception: Remote peer did not connect.")
Exception: Test exception: Remote peer did not connect.
FAIL mesh_sae_failure 41.682039 2024-06-14 04:13:15.904346
passed 0 test case(s)
skipped 0 test case(s)
failed tests: mesh_sae_failure
2024-06-14 04:13:15 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240614/202406141644.c05809af-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


