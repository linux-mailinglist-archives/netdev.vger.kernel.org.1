Return-Path: <netdev+bounces-44203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C057D7078
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDD5281C1F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041F2AB36;
	Wed, 25 Oct 2023 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYcD/Bw3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76C2AB33
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 15:12:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96E7129
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698246756; x=1729782756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9rzsx29kZS6KpEnlKOy0PZngKBZ3kVRyAf7v6AgPYXI=;
  b=gYcD/Bw33+V48/M3dWsL3iY9K420CGGa66czN+oItB/Sxf58WZTUMSyv
   sX9QiVb5uscXOOv+Q3OAlszJHsWTRhXR6gSXVvxAcKYxDPOoSijKdmgc4
   qSSOCo7w40IGlp5vREOFEhJsxM9YGYKyZ8QQGiuj97ptgFtEg5MnV3SsS
   J40l+dpnpWF3mTGPVv+F0UpyY6OKQevJux+SvkM3+v+58eVIjU/tDjajf
   Nd5qvp1OjVesk51qXJ4YlUbUxSXJhJvd9aNwWMJg86w8/nmffonTReE+b
   SgDPUJj8rQ+eIspQCRIfA+atznFebb4wkUdXCGfoU8Fhv52kU/jHGAgWd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384537082"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384537082"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6878981"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 08:12:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 08:12:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 08:12:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 08:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA7FbCA+5Im2pTyx0aYtMlrBPGz7Eljq+bu+D7SstLTv/ny4AQzIcjVyKm1TfJy8kN1HJ/a/NpGRzG3L6sOEkEC7GM+APenbtGHfowzibTfZmj5MAFJOFrkwEUcWKD/ypTx+t83l3YTsMaPWvqwYk4UECGqTt6MLKTaOQi5m4n8oQe6WVoXZlgbaNyXpdwuPmFLWLd9kz9S9e/km7w5UOZac/VEDtjQBF2C+wDrTN967/P0JwiTBA9udMaJBeRZUSn3POgrqhDKGGGAFkdJRJel4qEeDrpEm1JDcuwn6jTZe1U4fMMtRJP3E7/m2AxjkTP+jRFybfJ6G2WVT7seBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgCsiIb29AWRP4Tx6eJoSEwWmQKsb/ZB6CTLs3rA//c=;
 b=NWuGzsX3Tc+o0g6x1socXK39sAVL5lKkjrbYpeU5tawtCPQoMJ8UD4yiCwD53DyhwWGE+Yxc3AZE0OeiWcHr2DNVmN3U4L/G6DLe1loqqgbxFKj7pmJSNxrIcA84udCdwKBk0P9qfrZ+orqR6emY01P37a5j1pSMuaa44VKVtBifPMNhcKAl6cXjwcmayaXc2uzOz61W98ce/l3F9Lr16D+/QnWcUd+v0LS9F84WeVFGKpG2yCoMo/jprM5u0aBtFIQ6atJjbCcoZIKtSdGStrBUExoF7EWg2XENXCAOYZp+UJ7abs8YbJsr4HNfo6xUb0ew3FhYUO8dDriinfRJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:12:33 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:12:32 +0000
Date: Wed, 25 Oct 2023 23:12:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [ptp]  8f5de6fb24: kernel_BUG_at_lib/list_debug.c
Message-ID: <202310252217.816dfed6-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 237befa8-e1d7-4a51-112a-08dbd56ccfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kps26Rlk8mN3MFGMDikb6aQBx9x5LHMAkVDRLRrR1WWl8zX7qSDNtXSpJPUD76+qzF9rmj+AUxdzs8WeTIN1KsxVQWk4PsqI5Mn85NruvSHwzGcwD12DrMcsG6fQEgedASqEBNUMd6H5OiFA5eOJm4wwnnqj+sNETtu/CTauUyjqSwW0d2EfC+StKhjXq34zkoWViOA+NIrviVD+G9Fu79bq0TWtbKPiUVAQ+2udUCIIO1TQ0+zy+MUZqz1WlRUu4WcLdSs3cCyPXLDZBqPeFYfB2fZk1+Tv71eHe64lCjqjzjl2c/cCbeoeg6H+zR5Uiz6dVUMJF1J+D4K+rZrlxylDnCeaWxUKx83y9KjeoLYN/QY1diMnH96PjX97GL2gfYAlxIK/r0bD8CSALazNO7KdBZOK2Sm8yEqGGdkp3STodSykMuBDT6kg9JhMD7koPWmwHn1y4ZEX+ixXyLVrrjflwq5QOm8eaw5q2qgdhzUUP7wmifn/6V4O6K41ZRTu8G/WnrO0IgD/SO2VDeCKccVLHNEqeWL9Ij/6U57eCRZc1iGfV1zDiGrk8pZa95ft2banlpJnD6qXUD48RA8hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(36756003)(38100700002)(2906002)(41300700001)(5660300002)(86362001)(316002)(8936002)(8676002)(4326008)(1076003)(107886003)(478600001)(6506007)(66476007)(82960400001)(66946007)(6916009)(66556008)(54906003)(2616005)(83380400001)(966005)(6486002)(6512007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3SuM7ezSXWUcPcJ4PlW+G6tLfWeUf7VHQYT7Xm3RH/4c5Gp4eoQ8PX/5RtOF?=
 =?us-ascii?Q?h3pjCRstfMQZ9hMZBrSx74oyXgPn7otFAOVF/D3OdeJe/iVTGEY6YOXFsNHx?=
 =?us-ascii?Q?TsnMAoQ+dyawYs6grSrZdmpC08ab1AUMaFJNSVcoz3P1MBHG78PSiptblalt?=
 =?us-ascii?Q?WaJsjQ+/SGhkh2YQCw2EiBhI3sBYNTdkexTuaPURRXTNBg5KuZyZs3X/Iu8b?=
 =?us-ascii?Q?H3qJdVNtYEi4I2V3wjzNODSOCl1UBh/84rbEaCVugSP2HmvGurQAm5tfFXdv?=
 =?us-ascii?Q?iyvCFCmqEaUJM/F9LpG9HB+VCpRo3I8Nl6ZXmh9fBRNbMfJs+PlmxiwYxXQv?=
 =?us-ascii?Q?2Pp/DNkGWjs7zDICkI7RJCvVrfNRemT4Sn6+usaP+A1u+DQctLlXgEuM3mbV?=
 =?us-ascii?Q?zF9Cc58wnQl5FXlK4LYSc4tqycSq0WFfcUGRIa8PLU0t7EhjsgoMUGthdD1v?=
 =?us-ascii?Q?aFAY/yLTa6N5N+GO0iSWnDQSSi7a1MHW7/ZuVMBrg3nzwfOu+TFLJgWcnm5R?=
 =?us-ascii?Q?6CAWHqWghmbrWmsXzDpHbCwqz2iMMUIgQTN2aVeVbPtlzs1ghLjBKI7rVEVI?=
 =?us-ascii?Q?LfAjSoi2xauUZyWgcVAXIoB6LLnkE1Qkj2xuRPDb2m757rh3bF9l7i919kkk?=
 =?us-ascii?Q?yamwl0pYfgYLkJbSGOup0kG88fJaE1Cli7/lzdgDaZdAF0qln8n8OoLeuoXl?=
 =?us-ascii?Q?Pv4VkFdK1vUOnU16gp6m2C6Yb0ASgP3pFeKBjCUrL5MDctyTmqm5RAlXpWg0?=
 =?us-ascii?Q?CPNOxl5z4y4fYUkK6gT9RWH+OO5RIwAXsI0CYOxvwAC/MFBuyThzBQnKrhdk?=
 =?us-ascii?Q?gpZU/tB0LWJnuKYi948qz0dn7KmNIo5m5ry475uPJ51yB5PX9biSRjCWn+Vd?=
 =?us-ascii?Q?KVlfB+ICsern/weCfl7xfaOrsvnd4qdOo8AHVQscVQEcxUQvFHU6NMaM2A6i?=
 =?us-ascii?Q?tOA9yU07i+TtWBO1zmNK6GG/4tYKjmqKcNN8nqtCNktKC8R7CTj985G3Mgd7?=
 =?us-ascii?Q?Rl6FHAugP2kYDuUi8jDmrczUUMbekasgx2oKUvx3fUKAN2Y3gszhn8iBSVPZ?=
 =?us-ascii?Q?Iymp50UxPP9X12smjkoNlnFrklTYBW/tju/st/xYmTnEUJv/2lU55HMq3YeS?=
 =?us-ascii?Q?XNOA8x36hxQZ88dmsfGl7J4agXPGsw+48f0t8XqBUSRqNiNQ0CYFI1sRBN/z?=
 =?us-ascii?Q?RqHhST+UAmM/H2hRuysVJWZmXv8vSY9YAXdC/v90ehiUpuCEsPU2bHFKKLR2?=
 =?us-ascii?Q?PKQrPXjAltxvl3Zd3C4cH5yBxqOFLZCWnoHMKMeOYploE1H2DHQ+YfzoA7Cr?=
 =?us-ascii?Q?0SXhb/QCNU05oOMqf66RxxpehPH6rBY3R2LND5HeFn/MX//ObKkUsOg3DrvS?=
 =?us-ascii?Q?IvujDm01iek2zEk3LH/4GvHTi7Z7PJBCUE7k0CWVQItJQ3ldVr17p+anVjdP?=
 =?us-ascii?Q?T/eFBtCzAPNYDE5YR0z3gMryymfMhl1mgJaxUO5AFkl7k2V9o5tUClmkz+7z?=
 =?us-ascii?Q?WKqoa5EW0ifXU0uBuHuKkdRU5BV/ZVnNWLmAdAJXHuMqpNHJoWrFaNk1HT6u?=
 =?us-ascii?Q?g6j8loUfkTMn0wNxxmIGxNpIB8VhCxoGvtzoeV4MsGtGyc6Q7MiArmWnrSld?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 237befa8-e1d7-4a51-112a-08dbd56ccfc3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 15:12:32.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ1gmt+eEY2V5o179goaWhvJeqOuzluOae8FIdichI8gY+e8SBDnK6sI+GBjxd37RQ7WncBCsNriCjS/c7uRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: 8f5de6fb245326704f37d91780b9a10253a8a100 ("ptp: support multiple timestamp event readers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2030579113a1b1b5bfd7ff24c0852847836d8fd1]

in testcase: stress-ng
version: stress-ng-x86_64-0.15.04-1_20231012
with following parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: clock
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310252217.816dfed6-oliver.sang@intel.com


[   58.146527][ T4761] ------------[ cut here ]------------
[   58.146528][ T4761] kernel BUG at lib/list_debug.c:32!
[   58.146534][ T4761] invalid opcode: 0000 [#1] SMP NOPTI
[   58.146537][ T4761] CPU: 55 PID: 4761 Comm: stress-ng-clock Not tainted 6.6.0-rc5-01265-g8f5de6fb2453 #1
[   58.146540][ T4761] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 58.146542][ T4761] RIP: 0010:__list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146552][ T4761] Code: a3 ff 0f 0b 48 89 c1 48 c7 c7 08 c8 72 82 e8 1f 31 a3 ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 60 c8 72 82 e8 08 31 a3 ff <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 b8 c8 72 82 e8 f1 30 a3
All code
========
   0:	a3 ff 0f 0b 48 89 c1 	movabs %eax,0xc748c189480b0fff
   7:	48 c7 
   9:	c7                   	(bad)
   a:	08 c8                	or     %cl,%al
   c:	72 82                	jb     0xffffffffffffff90
   e:	e8 1f 31 a3 ff       	call   0xffffffffffa33132
  13:	0f 0b                	ud2
  15:	48 89 d1             	mov    %rdx,%rcx
  18:	48 89 c6             	mov    %rax,%rsi
  1b:	4c 89 c2             	mov    %r8,%rdx
  1e:	48 c7 c7 60 c8 72 82 	mov    $0xffffffff8272c860,%rdi
  25:	e8 08 31 a3 ff       	call   0xffffffffffa33132
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 89 f2             	mov    %rsi,%rdx
  2f:	48 89 c1             	mov    %rax,%rcx
  32:	48 89 fe             	mov    %rdi,%rsi
  35:	48 c7 c7 b8 c8 72 82 	mov    $0xffffffff8272c8b8,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	f1                   	int1
  3e:	30                   	.byte 0x30
  3f:	a3                   	.byte 0xa3

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 89 f2             	mov    %rsi,%rdx
   5:	48 89 c1             	mov    %rax,%rcx
   8:	48 89 fe             	mov    %rdi,%rsi
   b:	48 c7 c7 b8 c8 72 82 	mov    $0xffffffff8272c8b8,%rdi
  12:	e8                   	.byte 0xe8
  13:	f1                   	int1
  14:	30                   	.byte 0x30
  15:	a3                   	.byte 0xa3
[   58.146554][ T4761] RSP: 0018:ffa0000024d03c28 EFLAGS: 00010246
[   58.146556][ T4761] RAX: 0000000000000075 RBX: ff110020890c2000 RCX: 0000000000000000
[   58.146557][ T4761] RDX: 0000000000000000 RSI: ff11003fc09dc700 RDI: ff11003fc09dc700
[   58.146559][ T4761] RBP: ff11002086fa9330 R08: 80000000ffff8b8c R09: 0000000000ffff10
[   58.146560][ T4761] R10: 000000000000000f R11: 000000000000000f R12: ff11002086262800
[   58.146561][ T4761] R13: ff11002086aa1010 R14: ff110020890c3010 R15: ff11002086262bf0
[   58.146562][ T4761] FS:  00007f2138c47740(0000) GS:ff11003fc09c0000(0000) knlGS:0000000000000000
[   58.146563][ T4761] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.146565][ T4761] CR2: 00007f2138c1e8f8 CR3: 00000040581c0004 CR4: 0000000000771ee0
[   58.146566][ T4761] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   58.146568][ T4761] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   58.146569][ T4761] PKRU: 55555554
[   58.146570][ T4761] Call Trace:
[   58.146572][ T4761]  <TASK>
[ 58.146574][ T4761] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 58.146578][ T4761] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 58.146589][ T4761] ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146592][ T4761] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 58.146595][ T4761] ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146597][ T4761] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 58.146603][ T4761] ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146605][ T4761] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 58.146615][ T4761] ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146617][ T4761] ? __list_add_valid_or_report (lib/list_debug.c:32 (discriminator 3)) 
[ 58.146619][ T4761] ptp_open (include/linux/list.h:150 include/linux/list.h:183 drivers/ptp/ptp_chardev.c:114) 
[ 58.146624][ T4761] posix_clock_open (kernel/time/posix-clock.c:134) 
[ 58.146632][ T4761] chrdev_open (fs/char_dev.c:414) 
[ 58.146638][ T4761] ? __pfx_chrdev_open (fs/char_dev.c:374) 
[ 58.146640][ T4761] do_dentry_open (fs/open.c:929) 
[ 58.146644][ T4761] do_open (fs/namei.c:3642) 
[ 58.146652][ T4761] ? open_last_lookups (fs/namei.c:3586) 
[ 58.146655][ T4761] path_openat (fs/namei.c:3797) 
[ 58.146658][ T4761] do_filp_open (fs/namei.c:3823) 
[ 58.146661][ T4761] do_sys_openat2 (fs/open.c:1422) 
[ 58.146666][ T4761] __x64_sys_openat (fs/open.c:1448) 
[ 58.146669][ T4761] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 58.146672][ T4761] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[   58.146676][ T4761] RIP: 0033:0x7f2138dd5127
[ 58.146678][ T4761] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
All code
========
   0:	25 00 00 41 00       	and    $0x410000,%eax
   5:	3d 00 00 41 00       	cmp    $0x410000,%eax
   a:	74 47                	je     0x53
   c:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  13:	00 
  14:	85 c0                	test   %eax,%eax
  16:	75 6b                	jne    0x83
  18:	44 89 e2             	mov    %r12d,%edx
  1b:	48 89 ee             	mov    %rbp,%rsi
  1e:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  23:	b8 01 01 00 00       	mov    $0x101,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 87 95 00 00 00    	ja     0xcb
  36:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  3b:	64                   	fs
  3c:	48                   	rex.W
  3d:	2b                   	.byte 0x2b
  3e:	0c 25                	or     $0x25,%al

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 87 95 00 00 00    	ja     0xa1
   c:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  11:	64                   	fs
  12:	48                   	rex.W
  13:	2b                   	.byte 0x2b
  14:	0c 25                	or     $0x25,%al


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310252217.816dfed6-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


