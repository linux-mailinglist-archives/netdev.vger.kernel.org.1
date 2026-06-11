Return-Path: <netdev+bounces-297981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iTmSHbViKmo+ogMAu9opvQ
	(envelope-from <netdev+bounces-297981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:24:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEECB66F5B8
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:24:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GrJBs8Sk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297981-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66866303CE16
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273591F5821;
	Thu, 11 Jun 2026 07:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11032937A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:23:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162605; cv=fail; b=qRZU5l3bd7bHXVFfXmcv0lZeomZ2GnBwEBnt74KTkSbV2S3eadgH0zhABtumXizWkePXe6+hW/DOiyc66Qyn2NzShYyfbA8D5ER+Lge09pwap+8FsuS4aRNq+GgNeYtY/yxie8nYa0Vy0IozosYkWGyVp+smSfB9+5+zbyoyBac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162605; c=relaxed/simple;
	bh=duSVY9OZ+4LWjoNCsTGJ8E6Maf5nVzXO7TdN3s9O+5M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tS5Zljxiv3om9dzvTIxN3wUf+Ei6n48HC9Jgb1hadaMXklmUqUdjaJiZ7b9K8M+mbEN87wy0d+uO9m4R1uHoB/DYeLjdh69lVLrAK0YbW7kujNeo2T4myBt+1hJZG7pZMMIQl/G/+Wtcp1HjXCjD2wuXHeApvrVpLVtRdQldJWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrJBs8Sk; arc=fail smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781162602; x=1812698602;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=duSVY9OZ+4LWjoNCsTGJ8E6Maf5nVzXO7TdN3s9O+5M=;
  b=GrJBs8SknGNYGWkcxR08+arvipb715Cqfr6UwPNnGnYk94Qe/O16/ZqQ
   eQcqDlAACF1BsB3XGJ8Qdc7BmM12bQRD6YE2wNTY+AhVq1XQmyTPJdlru
   5js/wR9vGWAUeNvSIIjICQOZdkw/z39RChyRUNtMUVZGfjHHGMqaDHbaJ
   8Pl50N3bfzhSq3T1J16EdylydJPyL2HJeNDpnNjNoKHgTkoAxYUizAxbo
   aGLivyLwOCIVAeKev/0QkkFvKcSW965MNK0O8HqS/qHv03/5FbMtDeLct
   Jf0DpV3D9Q8QPh+423da5ieBYbkTdFm9l/Z513VgKjS2uMX8IksTpfBJE
   Q==;
X-CSE-ConnectionGUID: SDeFruEaSV27vQNNNayzdg==
X-CSE-MsgGUID: AMebXd+sQz6DWTOk43yPrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92645793"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92645793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:23:22 -0700
X-CSE-ConnectionGUID: akNaJAUdTymBTLofTY1/Lg==
X-CSE-MsgGUID: 5Kl/z+IWSa6eZeKn7d6v7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="250324540"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:23:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:23:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 00:23:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdiOg0vVNq71zamfYf9NIn8dYCW4YMEhCTp6Lr7Q1lm0iU0O8QF8PXqbdHGeGFBoaasJSbl1BcWGRDnPPuwXZuD0kFEOkqKieW2x3wpMOUDZ0Q7tKBQ4pHthlaBiXJOz0HqVM6qWGmFoCrKVSrRkr+Kha/Djijru3J/YmTQsaal4O3oNNGEPTmMd8d9trbYkTblOC5TkZpjmzsN4bX+EvXbuoq1377RIKNMMbJB6XPREZqJa1zQQqpJUocnA1H4YO5+EJW3zDvUgRYOzj+Q6YRHpiqUk35lspdew+4zfRJ32k8UhjGN25EduqkKPvCAN6BxyF9+3S0U20MT5BPDs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21HmA15iJOAH/wKM0zAjWuu0ahgyZlgXgdEPX/MiCCA=;
 b=lH/0ZGYsLpKsEMPo2YJQq6JiC8c5LBAPIEKY0GK7hJapA/7RbM5lRQviw3Ku2V6/W8D1CupOxfbkNuYiD0j/3moUh75o0aOkAXeYeO6eabQ06QBag+Q6pko0ze2y8brVeyoP9CwNjH//H99uIiyDijryDOlqY4wQDrkGhYFD7w+swXZREanC/4LqbEjXtuYUEHd2wE2i/Y0CBti70znXeVYAKmH0AD+pjYznoJIuiLJPnTBGTXpjis6TESzL0CJrh9/R7VBOhSnFQAOVqTb5bnNI2T1tTztgJWcufZX45aLIzTwMbg5S1KQVJbDiqbZEkB7vKOqAXZnPaskj4MFm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 11 Jun 2026
 07:23:11 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 07:23:10 +0000
Date: Thu, 11 Jun 2026 15:23:02 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [selftests]  a3f88d89f6:
 kernel-selftests-bpf.net.test_bridge_neigh_suppress.sh.arping.fail
Message-ID: <202606110955.8f29025d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU2P306CA0038.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::8) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SA1PR11MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f97819e-7aec-41ed-6da5-08dec78a4aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1fbBvLLRR9dV0pSVzJkl8fEv6fqVXwuPsR+3iTLNjvPE4VF3F88xXexQiN1g6gbmsCVxrsKDDvnWwjEpgzR0U6sTUBriwVkc7tkEFojGcKK3PPdmJGbghDe7pnrPayiiOOB2yD4xnLbFMryYBpVXKlo441f+0RWE5X1TaDu1vTpKSANAGBV96gfxOs5lKLg0Oj0wieBLVKKobTScGpe7XeHEZyPgbrXcuud6xWa++OtNyWSBz3gK/mb4y4SMHeIr9hTfDoi+LmGz2BFtB2epxVMlxcfiBUmjCiCF/PgD+eSOqZcjuccTaJn5I7AGVb5h1PaRkxQwh46DA75yoP8yxaMe5nsL+aQW4gKxNO1VjrKjnyOiiM1+WC2mDmrrp8peMXQzc4y3ZTg4gLHOdZZyVNoR59IFhDtsnZxnmKAYuFZcY5Md1ntjQG/xrZiGJO6aN0vfGWg5TOiKK3Dkh9DrRTL39BJKqke+kcdRd9tt2NA6UfUSFuhIiPLCuIdbnt799hEm0x6PbsPuARAS0bBkK3FryOTwgN4SwKN77kz60BOCy2n1TxSH2vPcPVNUnnHq3Dt5UqfL5iXfMnRh7Xab3LXGElZSF0yxmGT558rYjuFzMbTl+dj4JplX6y3YQapXNI2wiBrqfdeXMg+Ya5P9LI5+JWqiqQUfq0TueRRWIhaqga7nb6FMAtlTbpZ78MFTH8Wqfr3FpjjjhD18hrFGeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sTKwj9cJz4uQXacTn+nwJuyYEVzwrZGvyG3RyzaJgdBkWHLxlTPgee0xYrfE?=
 =?us-ascii?Q?GnoqCD4UOpOfmu7OK/16jZ75pAJuMqIq3sOOFmVorjNN7crebQ6igXItPTgN?=
 =?us-ascii?Q?iyKm/rl0uAY8eC02azotg/G8dNmZUYti0ERfx/KUQZ8vUKSfHWWv6HP98CHW?=
 =?us-ascii?Q?yAE1v8lyw3R+E8xKf95DRQSrJMWF/PJ51ZcFlqDO8SumOliI00V00DDVccJu?=
 =?us-ascii?Q?1Ela6E2eBY6TBTxBerW8TXkEqGc8Nxjk7NKHsf9E2I/82ZXwU3AGImk0pjli?=
 =?us-ascii?Q?JnTddEooA2+JNSBE+ZJ5WC83Y8TS6BqZlHE6kGnCpXMe7bsAj6MhOxP1CWrS?=
 =?us-ascii?Q?kwnVXhTh7eULSkWQM/2vjyrMsBIToaYKvCtPkxTjf7x6MKF8T1R9HAfHavwc?=
 =?us-ascii?Q?lpXK0leTJzfk0iXwHSPqUgq69vvW/w71g/+HyrN0viFlPmr0kRGID04fWt7t?=
 =?us-ascii?Q?eDW4F/WSmrZnZctjlQgKqcjNrMJIO/cNGYhuFfnmfcY0niZzM9avBZTUGf2Z?=
 =?us-ascii?Q?Wt7mxYyyeNgYPLyU2KwutLUB4EmIPUkkIR44uV3zTr45jh7ZwaiJOms64z0K?=
 =?us-ascii?Q?j6+Fj+mCyjk84AAYSRWCYS1HKVwMeBFcPQCh5lCdDqa9krY47+joci0+Ah+U?=
 =?us-ascii?Q?nvwOz65VOLsDKSesdla3DtJL/XsOkC1KTyGgz0nRdlis3Daw1vq1WP846Syf?=
 =?us-ascii?Q?/ZHJo9MxDMVQisMFfqad5vhyFkgPez0znMvIUFvLSdWmK921T8zKC+bwAEhv?=
 =?us-ascii?Q?RKLACYUHAByR9m4Rr2IrwmzyZYVY5CerCgXIuelKqVYgETL2xIBHATkGnRHP?=
 =?us-ascii?Q?LQwehYXV+a0/qtNNVmOGt1qXX/zCQeRPmJfQNrJTP9/HM7G++VmJxiGlRbJG?=
 =?us-ascii?Q?SCn70ZD7PvH5UQHOuEAscKPJWV8jriRMZJ83MMRALOIc9FJfonhtxxdG1lPG?=
 =?us-ascii?Q?/6wXbN3IgTiRJ+6KGzTA96D733NLr6yzK1aKoPcDiBo0tiPF4EE+gS8E2gvp?=
 =?us-ascii?Q?x3fVOPh0Td55ZkLvN1zqCnWXlWYltidawHanOWpf1l7r5hScRV/cXnIZybVH?=
 =?us-ascii?Q?yni/DZfsOGEngIdoDcTdtxRPFM7Y5xpjI8nkJqFFsy47xFmqJUD6Z6GCXIWb?=
 =?us-ascii?Q?fHvdcHpV+rw0xBlx10IhCmmpm2Sp/dlspZ2ldRTh4VTCvGsMJ8QfGPNGOMlu?=
 =?us-ascii?Q?Y0l3d8wxoJgFC14zrGLuGUMF+3ugipHwsqdW+MiVy+0Ma57LGfxUMioPfQ6U?=
 =?us-ascii?Q?/qR/pRDKjv4ywm/7Enos12KL+OYCwXCMTyuClaN3UW/oORNvIccTPmQz5ygH?=
 =?us-ascii?Q?42c4WOEyFwhtpc/Ig1LcKUkdi1QZeGC7v+jHUsifBXwHNjVfOw1+PUUOSD0G?=
 =?us-ascii?Q?E+YGWWtwvRjSism25uevB5tsDgSXE1IPhmW2qO7iiCMO0yJLXwtDqlqPflCl?=
 =?us-ascii?Q?ly8oKiNEwrcP6udF9hmVBNgUwXV+yr17oTjTugnxe6a0JtuuZC1CqSqVYeLP?=
 =?us-ascii?Q?AECISBikmNmi4Ssg1nNP0NV7uy3GV0dv1fapDGCkunWu6jQi64xvaV/sK5VN?=
 =?us-ascii?Q?H7/fA07Oa0JkG8bzE25jRG00U3bMJH3Eol0NT1Z3LEYXW038X6XzCc3qg2D+?=
 =?us-ascii?Q?CCKjLJMEDBxnDohVc4gwPhTS3PuwGz6CWx1d4oKhq1E9eiY9NNb3mYoqYQrh?=
 =?us-ascii?Q?ba9UXEIJ3rOLrls2aHAoQPteGr0NdvEyLUjFwAVZdbM4eXZXj4KvaBlD5aDs?=
 =?us-ascii?Q?KjP4+p6jWw=3D=3D?=
X-Exchange-RoutingPolicyChecked: XTXllQVVodIlUMH7w+y/XLpX1DGEb7mLYqMmBFwQZ8wvnNtyJLOUSPdCUUpe9Ll26iPJAtXWrN6NeuYVJTB2EGIuo3aRHJcK5BIY5sN0HDUgcXXCjC0TCK9IihD0fZpi7qpK6Y2PRu+VfHGkl2ExtKvIhvpIikkCxx8L0LsXDQSHvA7xwys6QD6plF6co2kCw5a1D4KA89ccIEtbRgzsAcKOknEG1bLpxKmRdUeyXhDcYpPDbRX8j8iymTm7+k4ot2EX0+xrcD8iI6wmj0uY/UiBwSfwWOVhT4tCeXdgyupYPrMcEfQ+9oJyPqxYpd+lvnDpVRHZL4LAl1O0bK0h2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f97819e-7aec-41ed-6da5-08dec78a4aa2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:23:10.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ruJidtYWQtxZX+LiaH/1/EviuQKLdfbA2NH20AyLXgivhqHGxG5KyMZa4GILu2+u4Ad4llZi4UORvFTOqMPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,test_bridge_neigh_suppress.sh:url,01.org:url];
	FORGED_SENDER(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:danieller@nvidia.com,m:oe-lkp@lists.linux.dev,m:lkp@intel.com,m:kuba@kernel.org,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:oliver.sang@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEECB66F5B8


hi, Danielle Ratson,

for new added tests, we still found some failures in our tests, not sure if
any dependencies we missed? thanks


Hello,

kernel test robot noticed "kernel-selftests-bpf.net.test_bridge_neigh_suppress.sh.arping.fail" on:

commit: a3f88d89f698743a8cd91fb43f997e2d292a168d ("selftests: net: Add tests for ARP probe and DAD NS handling")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: net


config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606110955.8f29025d-lkp@intel.com


# timeout set to 3600
# selftests: net: test_bridge_neigh_suppress.sh
# 

[...]

# 
# Per-port ARP probe suppression
# ------------------------------
# TEST: ARP probe suppression                                         [FAIL]
# TEST: "neigh_suppress" is on                                        [ OK ]
# TEST: ARP probe suppression                                         [FAIL]
# TEST: FDB and neighbor entry installation                           [ OK ]
# TEST: arping                                                        [FAIL]
# TEST: ARP probe suppression                                         [FAIL]
# TEST: neighbor removal                                              [ OK ]
# TEST: ARP probe suppression                                         [FAIL]
# TEST: "neigh_suppress" is off                                       [ OK ]
# TEST: ARP probe suppression                                         [FAIL]
# 
# Per-port DAD NS suppression
# ---------------------------
# TEST: DAD NS suppression                                            [ OK ]
# TEST: "neigh_suppress" is on                                        [ OK ]
# TEST: DAD NS suppression                                            [ OK ]
# TEST: FDB and neighbor entry installation                           [ OK ]
# TEST: DAD NS suppression                                            [ OK ]
# TEST: DAD NS proxy NA reply                                         [ OK ]
# TEST: neighbor removal                                              [ OK ]
# TEST: DAD NS suppression                                            [ OK ]
# TEST: "neigh_suppress" is off                                       [ OK ]
# TEST: DAD NS suppression                                            [ OK ]
# 
# Tests passed: 124
# Tests failed:  56
not ok 110 selftests: net: test_bridge_neigh_suppress.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260611/202606110955.8f29025d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


