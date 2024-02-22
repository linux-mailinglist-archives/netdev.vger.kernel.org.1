Return-Path: <netdev+bounces-73869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDCB85EECE
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 03:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D521F23516
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDE5134CD;
	Thu, 22 Feb 2024 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANnrE3li"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B412E4A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567242; cv=fail; b=r+hvjkjXuuic5UIm08XOHR7QeGeAuyn2IUhAFgUMs3IFJaIrk/WtccPRdLByow+QsiLtptfFgaKX8q2ebe+bSJoDkzU7qD8io13vL6ZC4wH1p5G/YQ3ZdHhwy6uE/O+otQnGCA+XOVDxs0/kjs+LpWpHyg/lEvU849he3SAbq+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567242; c=relaxed/simple;
	bh=nxNa6NyWqQ/xYKDid4v2dYBl219mQgtAQGC2G+gosQk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aG9xskJs0T67C3nT4L7eYDRPUBSSmxLhsJw8r5h6ViIVf8qY6ivigrzwoChC786w7+tkOKnq0rOXFdRBCXEfPxK1LlUuaJRNSl3cimyrO+XLDLxTA0v+Ec8PYhYU9bK4SFL5FKlfH4ktLWs0/jxd8pafZMYEcToqpeW5zYMz//0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANnrE3li; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567240; x=1740103240;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=nxNa6NyWqQ/xYKDid4v2dYBl219mQgtAQGC2G+gosQk=;
  b=ANnrE3liUDB8C8E5ApW95AaxcFj0q3A1iEXtyz8cBbkbdodycg+8kd8L
   Yqh0fxsmgNG/ODege3poGJ16bGrjJXcroK1jwGHH1Jn5iG+hCxtEPcciz
   7Hoe/biSJbIfy/TmL9G7LFpWXVX5TKkYWiodEd23dLquKQZxe0F1wnK2i
   wxCOqj1D53m0LEGAz7//gJ39usosQ6cV315GLm+HarHqOu105g+n+J2nD
   VrdZYE+pKdQvS4W4PF+N2MTOlt1OKsFUGCxiPlwIMsCOlXjMjs9qSNmfK
   HzR4J1h08mbyw90KVHjh9l8cC3ApxIpLHclFOy6KtyWpgIUvpg1bKMUpL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20198224"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20198224"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5691436"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 18:00:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 18:00:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 18:00:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 18:00:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkUZiYx8Dgr//lbHpX0L7WpY1EhxmiBGItqCWvWqX+0bECBvd3tPgqI796QbD4WGHkSrYuT7ydJ2sTjipJ8MEwp3MPdfPldtMQU1iNEZAPaJ0Wx0/IlUQCvaJlOFChMgmz/ktKi4tiKyyE812fZRTHm2quMp7GLOTOGgZLYc9jr354SwXhWRuGpKmQ/skdV4I61wBioDHTJ4b9vK6DnAbQCFR6eNNjIHcWO90GcynStwPSfCVKUu+x10p/oOCZOJqdP7jJIsWYntgHovMCZ0/n0L8ZuQwO6Khc0lQrWqHNTmtTNHZF+sn1DMD3ia2NEhCPq4I8AqsZo7wHYgAgAgjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjUgPEF+FMgEsxtaB4tKQkHSuNU+/LoYNG8RXYeEejA=;
 b=T7YltdLlv9tHQJfruZZ6m4BzzU6nUGEA/qnmwQfAtECXjgLGlgRzItz5AAlBVskte00LFmKNT3q4ZJWe1Y5YFfk1Dmna4l91KgYAU5xKUzxbr6IsEybOHDRCtm7iGiAk0IFGBsAm7uCikpiUO90HS6QeKKaPrj6D2whh9r159NrsJho/Bn7dxy5mIjd3Xy6238eObNzwasdL2grEpvDx2HNoOzddZZFNaOF6tK9Q75ZM/WFsnxffYtLFfdu62+wFV6kCB4V39WtHNqTZkTQBcrgCg7hLruIomYWrT5QImWzcV7vBoG6DLocYld6TmFUjvD1JwCj4MTBA2Ke02gXYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 02:00:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 02:00:35 +0000
Date: Thu, 22 Feb 2024 10:00:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>, Antoine Tenart
	<atenart@kernel.org>, <netdev@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  fd4f101edb:  stress-ng.msg.ops_per_sec
 29.2% improvement
Message-ID: <202402220952.7141823b-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: c149ae91-9417-4f73-3455-08dc334a0ed0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDG2jdbRyewHRXX2806U1Q1vwZkpT03Xwlo5wBjk8/Yf4l9lJM5V10ft3dMYKLofNx5hIUROzDaZTM1wJrn0aOlDvy5WSVXRn7gTeevga54S0zTI/ouIJ/8lkpRB4IGoZd1whE5778crF8xrCZlKVB4Dah/d8AA2VMVx+tEf1c85uH7Hyd+O6lkxzoL7Pa4Peqm+YgdON9JJwZAQo521mFxR/2dopsrIj/qtk4epuAFJb+NQHsNvNZ9gu4uI0aAeViGNWm6Jb7DhdBPmbweOpm17s1CC365/PVLgQjBySnKcc9bGFSzKLzwNFRfhHQ+ELa631XrOmk1/3Ya9+4cp+WY/0DNlXdh5d9Y5KiSq1+SotkiP3NDJbjNPrDvwF4DDyXnNmc2V8ctQFWIGsyGFEJ3O7TuVFYRp1wVEdml1x5io5cJQWclUsa0Ye15AZaX5uzr/lbrtRrHsAivf/TKI/fTMzfCK9lINwnqHetm4IgEWQUGAafegFsxnDK3zy0XUMJcq0p0vT9nGwO8JxFKLc7rfTlWIkba1NWL48KlFStKLdOANG4O+ckddXrFjj1Sf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?aGxIHAaAK8jASVIiAQHHNxEEd+Anl+flk1BGADG8X8yNXPeSosDSLBoXZz?=
 =?iso-8859-1?Q?ofZHCDbbv/RBYEFMypWUXdHk9tGsFhNFmTgEDZZtJxKKH8zL7CW8X1sION?=
 =?iso-8859-1?Q?ey4SzYBt7uWUzqOohzwHAq7VfuXCSG0JpbREzdVPWVzRnSvqTHNUSnT4HV?=
 =?iso-8859-1?Q?qY0xSukvvPkP51cUf5/eWRXFEgjI3QJUruMTS3FIQ2eHUSBBRXREZCQDiz?=
 =?iso-8859-1?Q?w8hzVXOyURMPJsZiV569FpIpvzb1AdF87xEUvo5NWQEe8WOfmasP9WAcXi?=
 =?iso-8859-1?Q?LQDJXOPPMftjyROlfxFzPTO72MdCsYuWoHMiItADcQVufzSp4Uib7HtK2R?=
 =?iso-8859-1?Q?fRwZtwvQ4k0oMpM2QKbn89wfRMNYZ5bxeR9kYEw+YaWJYexrEw20skb/nO?=
 =?iso-8859-1?Q?0NvAkMmqxz1Xe1lTEa1L3TL15HolNHVIEffbIt4hqgOQR2CxVPb0+L2ETr?=
 =?iso-8859-1?Q?Cma/EziFAAsd8TJNcxWhllT6lvIvUY6NW6Uf2OrOO6T2hmlRZe6p7xv5xB?=
 =?iso-8859-1?Q?j+mJ3fVy0aHwNhIYrdpPQlTe4rGyXxQYg15uDHFNkdcTrS3nWTkex9VSZB?=
 =?iso-8859-1?Q?qtMmcPiIl3rc13YN2p9Io6t6dWxrAee4gZso+ZhcaCBMyvARQlPQHRe4EP?=
 =?iso-8859-1?Q?Mc6I8B+8ZtkQ//upy9m+XEYeV73wRCnpf7SAx+I4/Q5VdQLikH46LUyAR4?=
 =?iso-8859-1?Q?j8UaUO3R62qthTQ9NCF2HgpVdLrpaBLYpirX7/3HlxqDZpz6C+1C13apfO?=
 =?iso-8859-1?Q?oi2g18595kQUvzaFPOXZaeI/z9PPh1TiEeMjyUlXhjxWgFCDxd75qk8e0B?=
 =?iso-8859-1?Q?NC61YMV1070nvzZTbb+FS/1RADDmKkMR2Zq+q/2S4u8UnPWZdfuGR54AP7?=
 =?iso-8859-1?Q?JNc59oe2VJGHtLRMyj2v61ZqIUdte6IGCHIz027xM1jxgCcV3oMqi1d5qW?=
 =?iso-8859-1?Q?L7CLMRmxIn2D7iVmxUqjVas/Um8GVaD7z8428q5D6YS4dSRotMgMGlliXD?=
 =?iso-8859-1?Q?QbVG+tdEF5ILCa+Bt3K76O8H+cl2akN/fucyjcnnztK+jmci4mrn0xdGPv?=
 =?iso-8859-1?Q?yVAg2J49ndRAW901sfJ9bT5p6LcDlxS/XonmcmR8m5VDA0lU61+dV9jvUv?=
 =?iso-8859-1?Q?iBvbazg0mj5FtCAHMHG+CabTO0rDDO+rFH6gtwry6/sxr/2uf/si4drn7S?=
 =?iso-8859-1?Q?C6DIXg0XERqtnqJZ7WtffQSKmdNgDZeNaQBqjkhraB2yuiz//C7UbBSnh+?=
 =?iso-8859-1?Q?58ECCwEE6XSLRr+7dLqOinLo7w5LMBJzzyuZkILWtlqtRV7cAmvuFn10ax?=
 =?iso-8859-1?Q?NQb0cLRLCrbs35A7rwLKUTIKxCmxAj5uXNKCXLguooq8LaeY94vH7jbr5k?=
 =?iso-8859-1?Q?LlxSVAVmTP7I6nHuzei6AGgmonHwmj2GzxYxpUAtmGZEbvy5MEvYvPCdkr?=
 =?iso-8859-1?Q?Gl6gsn3hBpdbDqpD0gSP4qRTgV33dIHFIlSarpjYeXpderFRsl+EFWq9UE?=
 =?iso-8859-1?Q?jabM1UJ1T6VldHV2xV44qUSY+6q/rLPv7uYK0qFypMnvRHt+psRecXfFGq?=
 =?iso-8859-1?Q?e0IHQxupiNQPnDx9C3dyT8JjlEZOsb9liQrYljBl+ilTCC/fhscOqjnyjx?=
 =?iso-8859-1?Q?4tZf8i6YYzLkrRmOx4AVQ0mO5q4O0Ckr4S7UBGqbl+ysExtWTAbxUf5Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c149ae91-9417-4f73-3455-08dc334a0ed0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:00:35.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJKzbhA1Vt3cDVGwQJqtHPZBSpPnlGb9X5WCgOK2rcEP2gm/vl5VJDS/bsR26grCWMfWcjiLZpSlKfuKEULMcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 29.2% improvement of stress-ng.msg.ops_per_sec on:


commit: fd4f101edbd9f99567ab2adb1f2169579ede7c13 ("net: add exit_batch_rtnl() method")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: msg
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240222/202402220952.7141823b-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/msg/stress-ng/60s

commit: 
  a1e55f5103 ("Merge branch 'mt7530-dsa-subdriver-improvements-act-ii'")
  fd4f101edb ("net: add exit_batch_rtnl() method")

a1e55f51035e6aa6 fd4f101edbd9f99567ab2adb1f2 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   8563778           -13.4%    7417130 ±  2%  cpuidle..usage
      5.49            +1.7        7.21        mpstat.cpu.all.usr%
    120292           -10.2%     107984        sched_debug.cpu.nr_switches.avg
    240634           -10.2%     216144        vmstat.system.cs
     98456 ±  2%      +5.6%     103994        vmstat.system.in
      0.02 ±  2%     +13.2%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.34 ± 39%    +930.0%       3.47 ±140%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    188902           -11.5%     167109 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
    681475 ±  5%     +42.1%     968696 ±  4%  numa-numastat.node0.local_node
    717355 ±  3%     +41.1%    1012165 ±  4%  numa-numastat.node0.numa_hit
    734494 ±  4%     +37.8%    1012229 ±  7%  numa-numastat.node1.local_node
    764874 ±  2%     +35.3%    1035011 ±  7%  numa-numastat.node1.numa_hit
    717320 ±  3%     +41.1%    1012083 ±  4%  numa-vmstat.node0.numa_hit
    681441 ±  5%     +42.1%     968614 ±  4%  numa-vmstat.node0.numa_local
    765007 ±  2%     +35.3%    1035046 ±  7%  numa-vmstat.node1.numa_hit
    734627 ±  4%     +37.8%    1012264 ±  7%  numa-vmstat.node1.numa_local
     49.33 ± 16%     -28.0%      35.50 ±  7%  perf-c2c.DRAM.local
     10066 ±  5%     +21.5%      12228 ±  2%  perf-c2c.DRAM.remote
     19015 ±  5%     +14.0%      21668 ±  3%  perf-c2c.HITM.local
      7769 ±  5%     +24.4%       9664 ±  2%  perf-c2c.HITM.remote
     26784 ±  5%     +17.0%      31333 ±  2%  perf-c2c.HITM.total
     38307            +2.5%      39280        proc-vmstat.nr_slab_unreclaimable
   1483925           +38.0%    2048531 ±  4%  proc-vmstat.numa_hit
   1417665           +39.8%    1982280 ±  5%  proc-vmstat.numa_local
   1528928           +37.1%    2096049 ±  4%  proc-vmstat.pgalloc_normal
   1319628           +43.1%    1888225 ±  4%  proc-vmstat.pgfree
 7.289e+08           +29.2%  9.419e+08        stress-ng.msg.ops
  12147934           +29.2%   15698485        stress-ng.msg.ops_per_sec
      6837 ±  4%     +28.9%       8816 ±  7%  stress-ng.time.involuntary_context_switches
      3798            +5.5%       4007        stress-ng.time.percent_of_cpu_this_job_got
      2105            +2.9%       2166        stress-ng.time.system_time
    179.40           +36.0%     243.99        stress-ng.time.user_time
   7981626            -9.8%    7198840        stress-ng.time.voluntary_context_switches
      0.03 ± 11%      +0.0        0.05 ± 14%  turbostat.C1%
   8400990           -13.6%    7255025 ±  2%  turbostat.C1E
     35.76            -3.3       32.44 ±  2%  turbostat.C1E%
      0.10           +20.0%       0.12        turbostat.IPC
      7496           -14.0%       6449 ±  2%  turbostat.POLL
    209.64            +3.0%     215.93        turbostat.PkgWatt
     60.82            +2.4%      62.30        turbostat.RAMWatt
      1.42            +6.5%       1.51 ±  2%  perf-stat.i.MPKI
 6.984e+09           +25.4%  8.757e+09        perf-stat.i.branch-instructions
  33123635 ±  3%     +19.3%   39505381 ±  3%  perf-stat.i.branch-misses
     25.73            +2.1       27.86        perf-stat.i.cache-miss-rate%
  53181495           +33.9%   71212733        perf-stat.i.cache-misses
 2.069e+08           +23.7%  2.559e+08        perf-stat.i.cache-references
    253077           -10.6%     226239        perf-stat.i.context-switches
      3.32           -16.5%       2.78        perf-stat.i.cpi
 1.243e+11            +5.1%  1.307e+11        perf-stat.i.cpu-cycles
     64512           -10.9%      57474        perf-stat.i.cpu-migrations
      2344           -21.6%       1838        perf-stat.i.cycles-between-cache-misses
 9.334e+09           +25.6%  1.172e+10        perf-stat.i.dTLB-loads
      0.00 ±  3%      -0.0        0.00 ±  4%  perf-stat.i.dTLB-store-miss-rate%
  5.75e+09           +26.7%  7.283e+09        perf-stat.i.dTLB-stores
 3.748e+10           +25.7%  4.711e+10        perf-stat.i.instructions
      0.30           +19.6%       0.36        perf-stat.i.ipc
      1.94            +5.1%       2.04        perf-stat.i.metric.GHz
    838.40           +33.4%       1118        perf-stat.i.metric.K/sec
    347.81           +25.7%     437.34        perf-stat.i.metric.M/sec
  34306768           +36.5%   46843727        perf-stat.i.node-load-misses
     68.86            +1.2       70.02        perf-stat.i.node-store-miss-rate%
  12534831           +32.0%   16551293        perf-stat.i.node-store-misses
   5731642           +24.3%    7124000        perf-stat.i.node-stores
      1.42            +6.6%       1.51 ±  2%  perf-stat.overall.MPKI
     25.67            +2.1       27.80        perf-stat.overall.cache-miss-rate%
      3.32           -16.4%       2.78        perf-stat.overall.cpi
      2338           -21.5%       1835        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  3%      -0.0        0.00 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.30           +19.6%       0.36        perf-stat.overall.ipc
     68.65            +1.3       69.93        perf-stat.overall.node-store-miss-rate%
 6.862e+09           +25.4%  8.603e+09        perf-stat.ps.branch-instructions
  32461333 ±  2%     +19.3%   38712892 ±  3%  perf-stat.ps.branch-misses
  52246451           +33.9%   69968172        perf-stat.ps.cache-misses
 2.035e+08           +23.7%  2.517e+08        perf-stat.ps.cache-references
    248804           -10.6%     222334        perf-stat.ps.context-switches
 1.222e+11            +5.1%  1.284e+11        perf-stat.ps.cpu-cycles
     63409           -10.9%      56477        perf-stat.ps.cpu-migrations
 9.174e+09           +25.5%  1.152e+10        perf-stat.ps.dTLB-loads
 5.651e+09           +26.7%  7.158e+09        perf-stat.ps.dTLB-stores
 3.683e+10           +25.7%  4.628e+10        perf-stat.ps.instructions
  33708514           +36.6%   46037634        perf-stat.ps.node-load-misses
  12318130           +32.1%   16266427        perf-stat.ps.node-store-misses
   5625564           +24.3%    6992913        perf-stat.ps.node-stores
 2.225e+12           +25.9%  2.801e+12        perf-stat.total.instructions
     11.56           -10.6        0.92 ±  5%  perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.36            -9.1        6.26        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     10.06            -9.0        1.02 ± 10%  perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.53            -7.7        6.84 ±  5%  perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      7.23            -4.0        3.18 ± 56%  perf-profile.calltrace.cycles-pp.msgctl.stress_msg
      7.15            -4.0        3.12 ± 56%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl.stress_msg
      7.16            -4.0        3.12 ± 56%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl.stress_msg
      7.06            -4.0        3.06 ± 56%  perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl.stress_msg
      4.18            -2.0        2.21 ±  9%  perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.52            -1.2        0.35 ± 70%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl
      1.66            -1.0        0.63 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
      2.53            -1.0        1.54 ±  9%  perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      2.38            -0.9        1.50 ± 10%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.38 ±  2%      -0.8        0.60 ±  9%  perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61            -0.7        0.90 ± 10%  perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.16            -0.7        0.49 ± 45%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      1.50            -0.6        0.86 ± 10%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      2.79            -0.5        2.27 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.74            -0.5        2.23 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.74            -0.5        2.23 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      2.74            -0.5        2.23 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.82            -0.4        1.47 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.67            -0.3        1.34 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.69            -0.3        1.36 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.28            -0.3        1.01 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.68            -0.3        0.41 ± 71%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.68            -0.3        0.40 ± 71%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      0.68            -0.3        0.41 ± 71%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.73            +0.2        0.88 ±  9%  perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.32            +0.2        2.54 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.__kmalloc.alloc_msg.load_msg.do_msgsnd
      1.10 ±  8%      +0.4        1.48 ±  5%  perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.79 ±  2%      +0.5        1.30 ±  8%  perf-profile.calltrace.cycles-pp.___slab_alloc.__kmalloc.alloc_msg.load_msg.do_msgsnd
      0.09 ±223%      +0.5        0.60 ±  4%  perf-profile.calltrace.cycles-pp.__put_user_8.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ±223%      +0.5        0.60 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__libc_msgrcv
      1.94 ± 10%      +0.5        2.48 ±  7%  perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      3.22            +0.7        3.93 ±  5%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      2.14 ±  6%      +0.7        2.86 ±  5%  perf-profile.calltrace.cycles-pp.stress_msg_receiver
      3.09 ±  4%      +0.7        3.82 ±  3%  perf-profile.calltrace.cycles-pp.__slab_free.kfree.free_msg.do_msgrcv.do_syscall_64
      3.06 ±  5%      +0.8        3.87 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      0.78            +0.8        1.62 ± 54%  perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.96 ±  5%      +0.8        3.81 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kfree.free_msg.do_msgrcv.do_syscall_64
      3.11 ±  5%      +0.9        4.04        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      3.88 ±  5%      +1.0        4.87        perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      4.68            +1.3        5.95        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      5.33            +1.4        6.77        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.67            +1.7        8.33 ±  2%  perf-profile.calltrace.cycles-pp.kfree.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.41            +1.7        9.08        perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.27            +1.8        9.10 ±  2%  perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      8.02            +1.8        9.86        perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      4.66            +1.9        6.59        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.38 ±  9%      +1.9        4.31 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.24 ±  5%      +2.0        5.22 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      5.57            +2.2        7.77 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      7.03            +2.5        9.56 ± 10%  perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     21.82           -19.6        2.26 ±  3%  perf-profile.children.cycles-pp.idr_find
     30.06           -16.9       13.21 ±  3%  perf-profile.children.cycles-pp.ipc_obtain_object_check
      7.28            -2.8        4.44 ±  2%  perf-profile.children.cycles-pp.msgctl
      7.07            -2.8        4.24 ±  2%  perf-profile.children.cycles-pp.ksys_msgctl
     87.96            -2.5       85.49        perf-profile.children.cycles-pp.do_syscall_64
     88.53            -2.2       86.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.19            -1.9        2.33 ±  2%  perf-profile.children.cycles-pp.msgctl_info
      2.19            -1.3        0.87 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.53            -0.9        1.62 ±  3%  perf-profile.children.cycles-pp.msgctl_down
      2.39            -0.8        1.59 ±  3%  perf-profile.children.cycles-pp.__percpu_counter_sum
     43.44            -0.8       42.65        perf-profile.children.cycles-pp.do_msgrcv
      1.47 ±  2%      -0.7        0.73 ±  4%  perf-profile.children.cycles-pp.down_read
      1.61            -0.7        0.94 ±  5%  perf-profile.children.cycles-pp.down_write
      1.50            -0.6        0.90 ±  5%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.67            -0.5        0.12 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.23            -0.5        0.70 ±  5%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      2.79            -0.5        2.26 ±  2%  perf-profile.children.cycles-pp.do_idle
      2.79            -0.5        2.27 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
      2.79            -0.5        2.27 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      2.74            -0.5        2.23 ±  3%  perf-profile.children.cycles-pp.start_secondary
      0.88            -0.4        0.51        perf-profile.children.cycles-pp.rwsem_wake
      1.85            -0.4        1.50 ±  3%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.72            -0.3        1.38 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      1.71            -0.3        1.38 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.42 ±  2%      -0.3        0.09 ±  4%  perf-profile.children.cycles-pp.up_read
     45.44            -0.3       45.12        perf-profile.children.cycles-pp.__libc_msgrcv
      1.30            -0.3        1.03 ±  4%  perf-profile.children.cycles-pp.intel_idle
      0.89            -0.3        0.63        perf-profile.children.cycles-pp.try_to_wake_up
      0.69            -0.2        0.46        perf-profile.children.cycles-pp.up_write
      2.50            -0.2        2.28 ±  6%  perf-profile.children.cycles-pp.__schedule
      0.42            -0.2        0.20 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      2.23            -0.2        2.05 ±  7%  perf-profile.children.cycles-pp.schedule
      1.34 ±  2%      -0.2        1.16 ±  7%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.58            -0.1        0.48 ±  3%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.57            -0.1        0.48 ±  3%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.26 ±  2%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.msgctl_stat
      0.14 ±  2%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.15 ±  5%      -0.1        0.07 ±  5%  perf-profile.children.cycles-pp.osq_lock
      0.48            -0.1        0.41 ±  3%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.44            -0.1        0.37 ±  3%  perf-profile.children.cycles-pp.activate_task
      0.42            -0.1        0.36 ±  4%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.36            -0.1        0.31 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.32 ±  2%      -0.0        0.27 ±  2%  perf-profile.children.cycles-pp.select_task_rq
      0.29 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.schedule_idle
      0.31 ±  3%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.28            -0.0        0.24 ±  5%  perf-profile.children.cycles-pp.enqueue_entity
      0.37 ±  2%      -0.0        0.32 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.30 ±  3%      -0.0        0.26 ±  3%  perf-profile.children.cycles-pp.dequeue_entity
      0.41            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.13 ±  5%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
      0.16 ±  3%      -0.0        0.13 ±  4%  perf-profile.children.cycles-pp.select_idle_sibling
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ±  3%      -0.0        0.12 ±  8%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.wake_affine
      0.08 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.select_idle_core
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.task_h_load
      0.08            -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.update_curr
      0.08 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.amd_clear_divider
      0.08 ±  7%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.security_msg_queue_msgrcv
      0.06            +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.11 ±  3%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.format_decode
      0.15 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.check_stack_object
      0.06 ±  7%      +0.0        0.09 ±  7%  perf-profile.children.cycles-pp.allocate_slab
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.number
      0.04 ± 44%      +0.0        0.07 ±  9%  perf-profile.children.cycles-pp.shuffle_freelist
      0.11 ±  6%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.18 ±  4%      +0.0        0.22 ±  4%  perf-profile.children.cycles-pp.task_tick_fair
      0.14 ±  5%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.security_ipc_permission
      0.18 ±  2%      +0.1        0.23 ±  4%  perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.21 ±  8%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.get_partial_node
      0.68            +0.1        0.76        perf-profile.children.cycles-pp.seq_read
      0.68            +0.1        0.76        perf-profile.children.cycles-pp.seq_read_iter
      0.69            +0.1        0.76        perf-profile.children.cycles-pp.ksys_read
      0.68            +0.1        0.76        perf-profile.children.cycles-pp.vfs_read
      0.70            +0.1        0.77        perf-profile.children.cycles-pp.read
      0.31 ±  2%      +0.1        0.40        perf-profile.children.cycles-pp.vsnprintf
      0.33 ±  2%      +0.1        0.42 ±  2%  perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.31 ±  2%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.seq_printf
      0.36 ±  2%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.ipcperms
      0.40 ±  4%      +0.1        0.49 ±  5%  perf-profile.children.cycles-pp.__check_heap_object
      0.38 ±  3%      +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.41 ±  2%      +0.1        0.52 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.67 ±  2%      +0.1        0.80        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.45            +0.1        0.58 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.36            +0.1        0.49 ±  3%  perf-profile.children.cycles-pp.ss_wakeup
      0.61            +0.1        0.75 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.52            +0.1        0.67 ±  2%  perf-profile.children.cycles-pp.security_msg_msg_free
      0.51            +0.1        0.66        perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.45 ±  2%      +0.1        0.60 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.65            +0.2        0.82        perf-profile.children.cycles-pp.__put_user_8
      0.77 ±  2%      +0.2        0.98        perf-profile.children.cycles-pp.mod_objcg_state
      2.40            +0.2        2.61        perf-profile.children.cycles-pp.wake_up_q
      0.92            +0.2        1.14 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.24            +0.3        1.56        perf-profile.children.cycles-pp.entry_SYSCALL_64
      2.35            +0.3        2.70 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.68            +0.6        3.25 ±  3%  perf-profile.children.cycles-pp.check_heap_object
      0.79 ±  2%      +0.6        1.38        perf-profile.children.cycles-pp.___slab_alloc
      3.18            +0.7        3.84 ±  3%  perf-profile.children.cycles-pp.__slab_free
     34.94            +0.7       35.63        perf-profile.children.cycles-pp.do_msgsnd
      3.07            +0.8        3.87        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.85            +0.9        1.75 ± 54%  perf-profile.children.cycles-pp._copy_from_user
      2.68            +0.9        3.61        perf-profile.children.cycles-pp.stress_msg_receiver
      4.08            +0.9        5.02        perf-profile.children.cycles-pp._copy_to_user
      4.13            +0.9        5.08        perf-profile.children.cycles-pp.__check_object_size
      2.74            +1.0        3.73        perf-profile.children.cycles-pp.stress_msg_sender
      5.13            +1.4        6.50        perf-profile.children.cycles-pp.__kmalloc
      5.35            +1.4        6.80        perf-profile.children.cycles-pp.alloc_msg
      6.45            +1.7        8.11        perf-profile.children.cycles-pp.percpu_counter_add_batch
      7.46            +1.7        9.13        perf-profile.children.cycles-pp.store_msg
     38.25            +1.7       39.94        perf-profile.children.cycles-pp.__libc_msgsnd
      7.15            +1.8        8.91 ±  2%  perf-profile.children.cycles-pp.kfree
      7.37            +1.9        9.25 ±  2%  perf-profile.children.cycles-pp.free_msg
      8.28            +1.9       10.18        perf-profile.children.cycles-pp.do_msg_fill
      9.52            +2.1       11.65 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      7.23            +2.6        9.84 ±  9%  perf-profile.children.cycles-pp.load_msg
      9.51            +4.1       13.62 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
     21.66           -19.4        2.21 ±  3%  perf-profile.self.cycles-pp.idr_find
      1.30            -0.3        1.03 ±  4%  perf-profile.self.cycles-pp.intel_idle
      0.50            -0.2        0.29 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.16 ±  3%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.17 ±  4%      -0.1        0.07        perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.15 ±  5%      -0.1        0.07 ±  5%  perf-profile.self.cycles-pp.osq_lock
      0.06 ±  7%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__schedule
      0.10 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.task_h_load
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.06 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.enqueue_entity
      0.06 ±  7%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.07 ±  5%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__cond_resched
      0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__x64_sys_msgsnd
      0.08 ±  5%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.format_decode
      0.08            +0.0        0.10 ±  5%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.06            +0.0        0.08 ± 10%  perf-profile.self.cycles-pp.security_msg_msg_free
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.alloc_msg
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.security_msg_queue_msgsnd
      0.10 ±  5%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.number
      0.12 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.check_stack_object
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.vsnprintf
      0.13 ±  3%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.store_msg
      0.12 ±  4%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.security_ipc_permission
      0.18 ±  9%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.17 ±  4%      +0.0        0.21 ±  4%  perf-profile.self.cycles-pp.refill_obj_stock
      0.21            +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.32 ±  2%      +0.1        0.40        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.33 ±  2%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp.ipcperms
      0.28 ±  4%      +0.1        0.36 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.37 ±  3%      +0.1        0.46 ±  5%  perf-profile.self.cycles-pp.__check_heap_object
      0.28 ±  2%      +0.1        0.38 ±  3%  perf-profile.self.cycles-pp.load_msg
      0.35 ±  2%      +0.1        0.45 ±  4%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.36 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.41            +0.1        0.52        perf-profile.self.cycles-pp.do_msg_fill
      0.42            +0.1        0.53 ±  2%  perf-profile.self.cycles-pp.__put_user_8
      0.58 ±  3%      +0.1        0.69        perf-profile.self.cycles-pp.do_syscall_64
      0.16 ±  2%      +0.1        0.28 ±  6%  perf-profile.self.cycles-pp.free_msg
      0.34            +0.1        0.46 ±  3%  perf-profile.self.cycles-pp.ss_wakeup
      0.42            +0.1        0.54 ±  2%  perf-profile.self.cycles-pp.__get_user_8
      0.51            +0.1        0.64 ±  2%  perf-profile.self.cycles-pp.__libc_msgrcv
      0.51 ±  2%      +0.1        0.64        perf-profile.self.cycles-pp.__libc_msgsnd
      0.45 ±  2%      +0.2        0.60 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.67            +0.2        0.87 ±  3%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.72 ±  2%      +0.2        0.92        perf-profile.self.cycles-pp.mod_objcg_state
      0.89            +0.2        1.11        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.96            +0.3        1.21        perf-profile.self.cycles-pp.__check_object_size
      0.59            +0.3        0.86        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.90            +0.3        1.18        perf-profile.self.cycles-pp.kfree
      2.08            +0.3        2.36 ±  4%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      1.56            +0.3        1.90 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      2.18            +0.4        2.61 ±  3%  perf-profile.self.cycles-pp.check_heap_object
      2.20            +0.4        2.64 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.47            +0.5        1.94        perf-profile.self.cycles-pp.wake_up_q
      0.68            +0.5        1.21        perf-profile.self.cycles-pp.___slab_alloc
      2.32            +0.6        2.90 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      3.10            +0.6        3.73 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.81            +0.9        1.69 ± 56%  perf-profile.self.cycles-pp._copy_from_user
      2.64            +0.9        3.56        perf-profile.self.cycles-pp.stress_msg_receiver
      4.04            +0.9        4.96        perf-profile.self.cycles-pp._copy_to_user
      2.69            +1.0        3.67        perf-profile.self.cycles-pp.stress_msg_sender
      3.02            +1.1        4.11        perf-profile.self.cycles-pp.do_msgrcv
      6.32            +1.6        7.95        perf-profile.self.cycles-pp.percpu_counter_add_batch
      9.42            +2.1       11.52 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      6.63            +2.6        9.21        perf-profile.self.cycles-pp.ipc_obtain_object_check
      3.75            +2.7        6.46        perf-profile.self.cycles-pp.do_msgsnd




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


