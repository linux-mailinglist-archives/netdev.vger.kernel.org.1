Return-Path: <netdev+bounces-56234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64B80E383
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0690DB21911
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C442F9DB;
	Tue, 12 Dec 2023 05:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ir03hDQV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA7BF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 21:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702357510; x=1733893510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=moFJr5ZDgmL8y0NBQdXd2gDRxo/DAIyEBb0LU+Ol9uc=;
  b=Ir03hDQV3aWVjFfaSFuIaH5kGHRlEy5oW7i/Ak+daF8g5Vk98fGtEnNS
   7YROxMZpJme926M2UbsnchTR4Q+I3kmWHqi7CDEhkrcgSNjyIwGDhYlFG
   plfbgKTY0iLUh8Hlm602m555gZWKywpbypDjTD5RY0KCTs/g0W+HHqozq
   257I7k5GFZrzjzYRxkFhfrO2gvRTDhdhoQ4tvogfZ2pzxHVVQOEk7PRKK
   4RCl4qxy5P7NUvFtodHlqT4FbQOEGOEqus1rgJGdzNJWHHXizN7hd+ndO
   IhjgA6eqqgTIlHRLxar9yPDG4hL2HGs4rAYfkAcMTsXJIFRf2/X4GqzPK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="393624822"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="393624822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946624712"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946624712"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 21:05:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 21:05:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 21:05:08 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 21:05:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilG531lAcD1DgBpS2UChHE3OOl6xGdu+BKygyTuTbwvkM/bor9xaOCMDdJGv6R8Rg/vmJo/a5yKmAeWK5C3ahs6FEv6X6Mg+ozp/RtgsHTmo2zxJWyrreUFKGMZsDJJ/pebl+dah3UlKYyw4qUOLRVmmo5l2i/fk/lg76LrcXJA61ev5Hg6dBgyQNkPh/ATotiR6myTOQilY4tQuMlVmlvgLGMxPJcg51wr/+CZp8lXmJlOCiImni4y7rvFhKq4+iQwKUFV61g1+R5ooyVZWchByxdoTher3RXUPAhtoyJ1hpDeoz31DxiGg3WYmqEc+spMs+eGUVezalYHd2VzwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS+bUR/dAmDFjMykozjWheof8jJL6R0F8F9pJZw9514=;
 b=TFcGEjnwgwwwDBkCSgl5vuw0fKW5SX/Dn75ObEsCnrsHL7utT5WufnIjTGCvON7HsxtGPzub6i5rKLhJSOf2oXKzatNrDg6Kmh/XHJpLgCq58WDZ2Tc2TO51KAavetMuEDY2nCbxrYtO5M4RTgnWr54qqKWbnqwjbODutJ10QOoT4u4d5i08NNfkdW+ywIII3JDst45/KDyYrVlgrUdIc3OZt7b6/VZFq12Lw9LIr6PBJDGcap+Cr1JY7l2sXyctxQIkp3UkopFlNK+iKUWi+zXN/M9hYw0uE4LLABLYnR6vMsqUQAmvANxUcUn87Fi2PNjyFujsiffN5dF5nuRC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 05:05:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:05:04 +0000
Date: Tue, 12 Dec 2023 13:04:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  b8dbbbc535:
 INFO:rcu_sched_detected_stalls_on_CPUs/tasks
Message-ID: <202312121032.40bab6f5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: b5bb2b58-6a83-464e-3611-08dbfacfe633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNuY1t91yaObGyJQW6UGhWCNRzanG+17EiJ2dcj42AdajMWDs9DQiDxcZn4jZxb3lAe8aL5lzAG3QqOlcfrh0Uk4JTIDl72gAMkmc9xFQQmH7E3p7M/CL0h0CPzyIXjTMkTM/ij3eO7Y1ck8IVx4G5v7wtBr9YnjnNFlO5BELmD0TXpLS9rhUrw1W5uCG1/3W0QoSyoHBtfa6AKcy7h47fVDasJ3EEKgSHh+WHUukPQ0UQmGGnlFKxveaEFEuOKkWPwjmEiVRxzQNe/XAjxPsFWXD0sWvYQzg3TB8sHFA0dSNkx3zr/0pewyPZZZtcKKEyO24cYCKnGS0wNYcC23qd9X3fT3AJfhHVVnlVtwKYSsYJZJz0OVq3kdYCLD49zgTr9OVsBbWe8A1X99vnp1JAsC3TgOnTjOKvFk1zteKzgwz2TDlDPIfhbR/NdpVp8Q2YytZitbGcRNMFCr2ARHBsvuZJjsS9yPPgzDlDBBTsWj40yy74ksbLTTZlMCaiJSAwHG9hJhXrp5orzQJ8bTwlvm9+R4gQ14BlfoZdK5PbeXdhHgBhKiqaiItKx69+XfHWGTP9useK5zZkJ2nN3GkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(107886003)(1076003)(26005)(83380400001)(2616005)(82960400001)(36756003)(38100700002)(5660300002)(316002)(8936002)(8676002)(6862004)(4326008)(2906002)(86362001)(6666004)(6512007)(6506007)(6636002)(66476007)(54906003)(66556008)(66946007)(37006003)(478600001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ehok9FSBsZL8QZsVOLK5GokBebNmEEi+YfinJ46PKNZweJ8HK7gy2okU42lZ?=
 =?us-ascii?Q?ANpFmvHN+2uu+61EcN2llNdGsfMOozeflkWettlM3OK2EO7FJgC8v3m2R+r7?=
 =?us-ascii?Q?Dg2+tyvgup9F8I9i/vNDuQ3vNkbyIeuZO6d9yR70NedUuRFfN5BOxcVhkzF+?=
 =?us-ascii?Q?Yd8qroCH6eMfBkLfzdJTF+1Qhne7Pk2/J7ZPDtdTrV2RJ8LNrS5+ZGDntjhL?=
 =?us-ascii?Q?MzlYBpRJ7vLta+graT7FFdvJIdJcIlyXNF1CQWRT72VBUG2nseJlY2gn4uNR?=
 =?us-ascii?Q?u7mQouH6Ef7N9Hab00auzIKTmafIskVa5wdZJ6pUT701I5t/cXDSzIrXx4Yu?=
 =?us-ascii?Q?sX/WzTf6qSjeU6ar/v2jsj+/UDx6/qYV6FNBVUwheMzFQ2ZN5QJ5qdQ7c9tz?=
 =?us-ascii?Q?mUdb1ZzSVPp4TZOu1gBfK0smEvdvhKTSjWIy+LQPb+U4ndkJBeYwdxYrPMwN?=
 =?us-ascii?Q?Q5dSXemdKDacd1IybfJwz50D1FvLvRRV2taVGPS6LhII1IBDR0vHRnR+VROm?=
 =?us-ascii?Q?bWxSx9ftDQrBH6xteEAGP+vsUmw+bcPfZ4wmsmSC0pn7zkkBBAm4XGuZpPWk?=
 =?us-ascii?Q?XpOenmEHNwCV8VQsx4MauQnR0VSfX+tlqLWfuQ/3Mwb+9dOd6JdmHr+BlR+V?=
 =?us-ascii?Q?+Kq2VEzdcXUVCcUfSzVC2BCSW1558KER96UE+dLEWbyDIqBfODZhQ905EMW7?=
 =?us-ascii?Q?Bs1pJ57XNorITQ2zuLbL+gxEtqJ9MGt7/vrljxOa+bdRfTjTSDqQwE4jCvsg?=
 =?us-ascii?Q?5/4h+FdBZp6KVOK/Ol2VF77wDI3TXHIgwyPUsYr6mD/sWfwMBwf+rL9Oshqk?=
 =?us-ascii?Q?jqYdQQZ+4VC+TIJDLU2jJ9fm9y/1X2dDknHx6LeXijZidzBGYu5VfKOpsLR0?=
 =?us-ascii?Q?XzQzuJTdWXV5qkWAJhJK/SeulZYM8aROPF7sqfqMKEDWkpZxg/JB2vbl4yT/?=
 =?us-ascii?Q?/guE/gO0G18aLQfeWrqAdOOJI6gTrVRpTr75+pDElSOmeQ6gvol5D6YPAMKH?=
 =?us-ascii?Q?1Bs7rlbUf9g1iiQtO+FzVmquS5oZYkBHv1KBxb8yGJMRrYsnYk3R+y+YWdyC?=
 =?us-ascii?Q?0QLCHrqfUEimEw3qZuRNVov/6GZhibsef1Eo+RvhN07r1qVVrVvn7CCmFIb8?=
 =?us-ascii?Q?6epxRDZ7pI1LI1j3GmfJYtMbAtAxFp7RkNYGGkQbNLzzIf0SN0BuSF5aQDbt?=
 =?us-ascii?Q?MLS8XpsPw5kAzdpBrIqWAxj3DUsxCPE7s8UEj7/HfQnKSqaUZnJtjQeMTSzD?=
 =?us-ascii?Q?l14TIz6KDnfE91dU4NzscqWGkdDGJte/H0MN8ORjr1k5cQdwaoXKsrnA05BW?=
 =?us-ascii?Q?WsP/3yxB+nqe7I8Lb1ZmOFgyQyl0P7u63Ya6eNNu7Ok8BOH/owbQolMuCxlJ?=
 =?us-ascii?Q?6o+VuKuKZIoyKwqdEDSmYkLXmXKHoKa1waFYDMyLWS1Dgh+0fJpcWTMRVFAk?=
 =?us-ascii?Q?OAXfFBjs1hl9I7SNXteI8LtRMZyfQEqb8hQj9MyvIRvMQNOMTTQvvf6RTT3F?=
 =?us-ascii?Q?yJ07qRqq50yxpJI1l5dyb6YY8Q/BIRpvFnVsgJPtuz3yy21BeiqWJyPk0emG?=
 =?us-ascii?Q?xOVFtJsRil8HttZT1xB5QVhDaq5eKMU+oglORSYLqmxcSR2Tj6e3rAHCgyXl?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5bb2b58-6a83-464e-3611-08dbfacfe633
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:05:03.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEF0AP1QzjGVmGRxkjRf3EU1nkRdqVialuQJ5FsfGL/PFL2uqeuxDrsztiW8I8j8Fy+FM1lqCNamblrB1T7mVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:rcu_sched_detected_stalls_on_CPUs/tasks" on:

commit: b8dbbbc535a95acd66035cf75872cd7524c0b12f ("net: rtnetlink: remove local list in __linkwatch_run_queue()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------+------------+------------+
|                                              | 5a08d0065a | b8dbbbc535 |
+----------------------------------------------+------------+------------+
| INFO:rcu_sched_detected_stalls_on_CPUs/tasks | 0          | 6          |
| EIP:__linkwatch_run_queue                    | 0          | 6          |
| EIP:linkwatch_urgent_event                   | 0          | 6          |
+----------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312121032.40bab6f5-oliver.sang@intel.com


[  310.105890][    C1] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  310.105890][    C1] rcu: 	0-...0: (0 ticks this GP) idle=a59c/1/0x40000000 softirq=123485/123485 fqs=12537
[  310.105890][    C1] rcu: 	         hardirqs   softirqs   csw/system
[  310.105890][    C1] rcu: 	 number:        0          0            0
[  310.105890][    C1] rcu: 	cputime:        0          0            0   ==> 52504(ms)
[  310.105890][    C1] rcu: 	(detected by 1, t=26252 jiffies, g=55465, q=13220 ncpus=2)
[  310.105890][    C1] Sending NMI from CPU 1 to CPUs 0:
[  310.062003][    C0] NMI backtrace for cpu 0
[  310.062003][    C0] CPU: 0 PID: 192 Comm: kworker/0:3 Tainted: G                 N 6.7.0-rc3-00806-gb8dbbbc535a9 #1 201d78f7550731bd41da838527871846012af2c0
[  310.062003][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  310.062003][    C0] Workqueue: events linkwatch_event
[ 310.062003][ C0] EIP: __linkwatch_run_queue (net/core/link_watch.c:224) 
[ 310.062003][ C0] Code: 96 81 c4 fe b8 80 73 c5 c3 e8 22 0e 34 00 a1 a4 73 c5 c3 eb 40 8d b4 26 00 00 00 00 8b 45 f0 85 c0 74 0b 89 f8 e8 7a fc ff ff <84> c0 74 5c b8 80 73 c5 c3 83 ee 01 e8 e5 0f 34 00 89 f8 e8 0e ff
All code
========
   0:	96                   	xchg   %eax,%esi
   1:	81 c4 fe b8 80 73    	add    $0x7380b8fe,%esp
   7:	c5 c3 e8             	(bad)
   a:	22 0e                	and    (%rsi),%cl
   c:	34 00                	xor    $0x0,%al
   e:	a1 a4 73 c5 c3 eb 40 	movabs 0xb48d40ebc3c573a4,%eax
  15:	8d b4 
  17:	26 00 00             	es add %al,(%rax)
  1a:	00 00                	add    %al,(%rax)
  1c:	8b 45 f0             	mov    -0x10(%rbp),%eax
  1f:	85 c0                	test   %eax,%eax
  21:	74 0b                	je     0x2e
  23:	89 f8                	mov    %edi,%eax
  25:	e8 7a fc ff ff       	call   0xfffffffffffffca4
  2a:*	84 c0                	test   %al,%al		<-- trapping instruction
  2c:	74 5c                	je     0x8a
  2e:	b8 80 73 c5 c3       	mov    $0xc3c57380,%eax
  33:	83 ee 01             	sub    $0x1,%esi
  36:	e8 e5 0f 34 00       	call   0x341020
  3b:	89 f8                	mov    %edi,%eax
  3d:	e8                   	.byte 0xe8
  3e:	0e                   	(bad)
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	84 c0                	test   %al,%al
   2:	74 5c                	je     0x60
   4:	b8 80 73 c5 c3       	mov    $0xc3c57380,%eax
   9:	83 ee 01             	sub    $0x1,%esi
   c:	e8 e5 0f 34 00       	call   0x340ff6
  11:	89 f8                	mov    %edi,%eax
  13:	e8                   	.byte 0xe8
  14:	0e                   	(bad)
  15:	ff                   	.byte 0xff
[  310.062003][    C0] EAX: 00000000 EBX: c6de2380 ECX: 00000001 EDX: c3c573a4
[  310.062003][    C0] ESI: 000000c8 EDI: c6de2000 EBP: c8619f04 ESP: c8619ef4
[  310.062003][    C0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000092
[  310.062003][    C0] CR0: 80050033 CR2: ffd39000 CR3: 03e7d000 CR4: 000406d0
[  310.062003][    C0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  310.062003][    C0] DR6: fffe0ff0 DR7: 00000400
[  310.062003][    C0] Call Trace:
[ 310.062003][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479 arch/x86/kernel/dumpstack.c:465) 
[ 310.062003][ C0] ? nmi_cpu_backtrace (lib/nmi_backtrace.c:115) 
[ 310.062003][ C0] ? nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:51) 
[ 310.062003][ C0] ? nmi_handle (arch/x86/kernel/nmi.c:151 (discriminator 7)) 
[ 310.062003][ C0] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719) 
[ 310.062003][ C0] ? default_do_nmi (arch/x86/kernel/nmi.c:351 (discriminator 19)) 
[ 310.062003][ C0] ? exc_nmi (arch/x86/kernel/nmi.c:544) 
[ 310.062003][ C0] ? asm_exc_nmi (arch/x86/entry/entry_32.S:1149) 
[ 310.062003][ C0] ? __linkwatch_run_queue (net/core/link_watch.c:224) 
[ 310.062003][ C0] linkwatch_event (net/core/link_watch.c:274) 
[ 310.062003][ C0] process_one_work (include/linux/jump_label.h:207 include/linux/jump_label.h:207 include/trace/events/workqueue.h:108 kernel/workqueue.c:2635) 
[ 310.062003][ C0] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 310.062003][ C0] ? process_one_work (kernel/workqueue.c:2730) 
[ 310.062003][ C0] kthread (kernel/kthread.c:388) 
[ 310.062003][ C0] ? process_one_work (kernel/workqueue.c:2730) 
[ 310.062003][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 310.062003][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 310.062003][ C0] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 310.062003][ C0] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 310.062003][ C0] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  315.849979][   T61] rcu-torture: rtc: (ptrval) ver: 5490 tfle: 0 rta: 5491 rtaf: 0 rtf: 5481 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbf: 0 rtb: 0 nt: 30811 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0 read-exits: 224 nocb-toggles: 0:0
[  315.852036][   T61] rcu-torture: Reader Pipe:  50990989 932 0 0 0 0 0 0 0 0 0
[  315.852728][   T61] rcu-torture: Reader Batch:  50985846 6075 0 0 0 0 0 0 0 0 0
[  315.853487][   T61] rcu-torture: Free-Block Circulation:  5490 5489 5488 5487 5486 5485 5484 5483 5482 5481 0
[  315.854460][   T61] ??? Writer stall state RTWS_POLL_WAIT(17) g55465 f0x0 ->state 0x402 cpu 1
[  315.855292][   T61] task:rcu_torture_wri state:I stack:0     pid:55    tgid:55    ppid:2      flags:0x00004000
[  315.856251][   T61] Call Trace:
[ 315.856601][ T61] __schedule (kernel/sched/core.c:5379 kernel/sched/core.c:6688) 
[ 315.857054][ T61] schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6764 kernel/sched/core.c:6778) 
[ 315.857474][ T61] schedule_hrtimeout_range_clock (kernel/time/hrtimer.c:2308) 
[ 315.858071][ T61] ? __hrtimer_init (kernel/time/hrtimer.c:1938) 
[ 315.858559][ T61] schedule_hrtimeout (kernel/time/hrtimer.c:2390) 
[ 315.859032][ T61] torture_hrtimeout_ns (kernel/torture.c:99 (discriminator 4)) 
[ 315.859522][ T61] torture_hrtimeout_jiffies (kernel/torture.c:141) 
[ 315.860053][ T61] rcu_torture_writer (kernel/rcu/rcutorture.c:1502 (discriminator 3)) 
[ 315.860563][ T61] ? rcu_torture_pipe_update (kernel/rcu/rcutorture.c:1354) 
[ 315.861116][ T61] kthread (kernel/kthread.c:388) 
[ 315.861517][ T61] ? rcu_torture_pipe_update (kernel/rcu/rcutorture.c:1354) 
[ 315.862074][ T61] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 315.862619][ T61] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 315.863065][ T61] ? kthread_complete_and_exit (kernel/kthread.c:341) 
[ 315.863604][ T61] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 315.864075][ T61] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  315.864532][   T61] rcu: rcu_sched: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x0 ->rt_priority 0 delta ->gp_start 27691 ->gp_activity 3 ->gp_req_activity 27691 ->gp_wake_time 1439 ->gp_wake_seq 55465 ->gp_seq 55465 ->gp_seq_needed 55472 ->gp_max 3132 ->gp_flags 0x0
[  315.866693][   T61] rcu: 	rcu_node 0:1 ->gp_seq 55465 ->gp_seq_needed 55472 ->qsmask 0x1 .... ->n_boosts 0
[  315.867624][   T61] rcu: 	cpu 0 ->gp_seq_needed 55472
[  315.868131][   T61] rcu: 	cpu 1 ->gp_seq_needed 55468
[  315.868644][   T61] rcu: RCU callbacks invoked since boot: 8906368
[  315.869246][   T61] rcu_tasks: RTGS_WAIT_CBS(11) since 78426 g:8 i:0/0 k.u. l:63
[  315.870003][   T61] rcu_tasks_rude: RTGS_WAIT_CBS(11) since 78454 g:8 i:0/3 k.u. l:63
[  315.870798][   T61] rcu_tasks_trace: RTGS_WAIT_CBS(11) since 78577 g:8 i:0/0 k.u. l:63 N0 h:0/0/0
[  315.871659][   T61] Dumping ftrace buffer:
[  315.872108][   T61]    (ftrace buffer empty)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231212/202312121032.40bab6f5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


