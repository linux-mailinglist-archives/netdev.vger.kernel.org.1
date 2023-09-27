Return-Path: <netdev+bounces-36484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFA27AFEEA
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 319F6283C89
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CC1BDCC;
	Wed, 27 Sep 2023 08:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE714F82
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 08:48:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79701A6
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 01:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695804487; x=1727340487;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=B/JLGvmucruz7LghS/YX1O3G7jgyuz+6yoM29gJ8ssg=;
  b=JHejlUts2XQGvckLfW689QxPXsnIpFrKBo1FsAkxDtfphtTBOe31rN7o
   yam+pulVj5JDbCjO+mC2ajlslU0A0WnXnue4nKHLHjMISxDmgLbBJUgn0
   +ECXaJKVyqon1mn3gi4DGbqNqTAtnTyoeC0XihSxobX1K8FM9twOc9Mmy
   C684np5HaOljTFdsryzKViZFs0QoNTpvOuLZaA1Wci9Ip3ANT0ziDnlZF
   Zlg71cjsUjoy1JBhwYpBi7XUQ4HQe6kQPZEhNDbL4r4ho7W/2C7RRDVfI
   mRZJQMLHGJgKxBXiX0yHzE4UtexhmIYLagfcXWGrDjuyfYptwWP04ENJS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="379047836"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="379047836"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752487958"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752487958"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:48:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:48:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:48:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKn1lI1LpHjGPygWX53Jlg/5rgUDud3opTIg5D5yCk8PNzdaqPl7gZmHGgd3B3d1D7DFgmcEO6RjG/ZmDTiboOIw2Yujqs3UMTvA/RrwcD9tSPAKeSNhiHntzg4RgND81+QC0XeU3Lh3iKLVU8ji70u/UfMcXDHijhqrAcvZn79YplOejl6ZbbKCcV+kyZqxczXG+7kZF3oXOqOjZuij2NFgEcYFG3GhkzoFrv7FQ4SplPRx2cTklzfBFnjX4r52poJs4Ggs850fr8LO562i1m6EmT/3NwFp0XP0iiGPAV1R20G3qZMhUmog9N1fsmhpysne0xeuoWAaToSTdTRmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ui0bzTDsrSY3tsL7vpE7iSUIWE5/Z3HSgjjzeZx5sY=;
 b=PmwapM3voJWtyHfk6Ik8VELogJsEVj1+4X1INDuBiKzhX/RySO9xLAD3fPxeJW40E83mu09xhvDeFtjU7L1VMymWagoNmcE34QQaZLmFGJ6AQBKyPE/ER++WE+2+4X8ES8kc5dsIB6J7gTsI0EokKeNvfasxay4kSHePoacLihQ3+lb9RKETRzidP62q3KN8l4E9CnfRxA3sXBz1/YeuRhjIdXNUpQRcwYo713/MKDs/48/qwRhpQp2r+3STLipJeL/rGMkzm5wDYlrIjqszjaNTwHTkKPgzYmMKDqN4F7zFKZZ5FEBMGzVmAthYJk1YiggrUmBb1kEqRKHk4Uc2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 08:47:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 08:47:58 +0000
Date: Wed, 27 Sep 2023 16:47:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Florian Westphal <fw@strlen.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<nharold@google.com>, <lorenzo@google.com>, <benedictwong@google.com>,
	<steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>, "Florian
 Westphal" <fw@strlen.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH ipsec-next 2/2] xfrm: policy: replace session decode with
 flow dissector
Message-ID: <202309271628.27fd2187-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230918125914.21391-3-fw@strlen.de>
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV2PR11MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b764af1-52e4-4697-347a-08dbbf36732d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDkMchFtVvbEmhzYF+FLYePdI5ZDwXBW/2cDrpugcz/VqGsgvIqqzAEDs5e738JSWjqclzKPjvxrVlpjMkIxoGsWqPk3dvRMoitFWYmdC3SHarna9DCgQqw0RrJ+skgvo/qVqCD53lpwpRSDbRgOUgR55wospSL/BECbHof7VIjrRoMwm1k1TqG5sOsjGkPO7VtpS5UiNSCDzkg1/lhNWzNFOK6T1RI/zwbQDzvgYtwgkG4RXxO0wpJvDun2wv7kE22CqCuqHr6JV/gr2DbexOqGJUChj3dhUJSbXyKGrebfjKml76Ar2GHWLqm+ZE9D5BZEbfdOQnrVTLnFH+M394I1Fstx0ftZ9DCSHMD3NLgOu7axNa3YQ4BJ0yGPDmIu5e4PQmv6p6jTbt9ZUd9jmNXDnaZVQ0SJJaN704ulRMTSda3FT655cnLp7Z7o5SbI9gKIbTupFoy1IAXuvVcUIh1GJ4wkTEkdS+VlgDk3ugK5J8otLZGCyAnbQkEjrHC8hHJrkkqgTC+0p4czozX1pnxuN0hstkzczwxZSf5PCmWmiZFw4RqjCMf2s1+vuBIXMACgDLSO6rLl0W2XURhDUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(36756003)(6506007)(6916009)(6666004)(6512007)(478600001)(1076003)(107886003)(41300700001)(26005)(2616005)(82960400001)(66556008)(38100700002)(66476007)(45080400002)(966005)(316002)(30864003)(66946007)(6486002)(2906002)(83380400001)(4326008)(5660300002)(8676002)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YmyRFEBIbgzEsHjWdM5vdb7eWpqkahDx9edfw76sBRaP/OtsG3GJ2WTI7qGt?=
 =?us-ascii?Q?ai9bA6yFPn3qra+hjSFZ02nrlDbmU1TdJmh7Pzw36FPXY1uTE6nCOu4fjyXg?=
 =?us-ascii?Q?LemFfwyvH1rkAT8hMry9QL4DjA4rDWuEJynGtvwFNn/VmEkldQzf0n9kewtb?=
 =?us-ascii?Q?KCtRJF7ODSP1Bl2SvrbsiaLgrwqZx5Esx+6FQhM63AB8rTiJvUj9QueUCE8p?=
 =?us-ascii?Q?mri1xYW+6disXBmJlfedalFcWnQGxnE/y+XdDoFf24A8BWjxILVnHT7tbbnL?=
 =?us-ascii?Q?onD1zQutSAW8obks85tTR1V8qWVVzqud/7a8crFJPyKSQsRdKXAW4epc0hH2?=
 =?us-ascii?Q?bQ0UwTqZZqYrJ5ssX4HIUY9sUlHtLRXHk5cmizQoq/kt36hhAlgS5OsnNPE4?=
 =?us-ascii?Q?NVWBdzV6AKCL4UyXAEh3ymIhyMbSpZycqRVU1PRaqRwHPV7Cv0+A2e4iWrP7?=
 =?us-ascii?Q?hdyBEH3kqscmq7Yz+8Y927+U5L/oBD0s1A6iqXwxr3Y/MUyWwfAgmVMwcNKa?=
 =?us-ascii?Q?Epc5NCIn3QZrrkulVWBNTvFlE2LVb2k71p2CzR9+J/q+gdNkyeZvfy9o1opI?=
 =?us-ascii?Q?n2k41PumhlyhdzmfN3WDuj3vW/Fs60f0d5jHedbz+5Y7NrKmZuXvGK29/xIZ?=
 =?us-ascii?Q?V/qMxMOhy3Sygvb0CseTGPlNVzCieLi76Tt77BZpyB8stGcPDghm4TfnsIky?=
 =?us-ascii?Q?vSXpg4ybPlii5hy/GvK/umNuFlCMTfAeoq0aRLqeEQRFBMJjVJrFSK6lZIcu?=
 =?us-ascii?Q?Zdvpccwh9o/5oZxvfvAaaekSycnxUFZs8tvleBnBWli9y5Ko3/uDj9wso5ia?=
 =?us-ascii?Q?ImfC+KQk7ROw9pBvvB2ki0w065zynG4bfVpLsg+de+TCvmOCIsUUPUsWBUMv?=
 =?us-ascii?Q?OTvVagSzGcTgT9c6M6iHQdwOupu5AECut3WTebeNW/iW4YN8S9+pIZaYUJlB?=
 =?us-ascii?Q?LscG2F/hlAeD54fThtJnP/zRHrr49enIH02XprxgKMZXP6u829xZSUsr1qzU?=
 =?us-ascii?Q?w0CpPuJ64UC0bQDccREszn3eRqXc2/pNf/2OxFtPvkqoFIsSRGXRa8JpoJX6?=
 =?us-ascii?Q?poFad+0Z/GPXZORU+G47odxr/Q8jH1ErWmAzw28NQNI0kQ8riBT31xZ/pGEj?=
 =?us-ascii?Q?+yrWZ5P6pjWL46eZdEzJch++1pJ7Bxo9jGPNGnNapOecM2R83kzoEs9k8yT3?=
 =?us-ascii?Q?haQbYIjTcZyhWoBNfGzkmau/YZnhl7Ae83VkZ2v3Cb3QW0VdEUh8OPvpcK9g?=
 =?us-ascii?Q?AlqavyoS5vRndvLPQ2n3hYAl8jDp75+yZcxWXh35extU678cbRiZObJyt6cA?=
 =?us-ascii?Q?suM4Q1qXmspNXmy9p80JJpJ0WTbpzv0ekt2aNvDtkvCJUXMpv29p3Bxgdx98?=
 =?us-ascii?Q?Z57CqPT0KoIN/UDZP+vQR55U4/VeNGqmiy3HZ1EsPEL6hlF/aeONHmMlAOZf?=
 =?us-ascii?Q?nso4aNH2l80QFwfzUE6zXPe7lehlIgx4RMW86yaHrpI0m85b18Cunm9+6Hy2?=
 =?us-ascii?Q?vPK16J8m1GnA+L947juP6rA173dAifimcZVN1UhECSf0GkcKY+QGkA7tNeyZ?=
 =?us-ascii?Q?yWtEd7P8ag7Uad7qJjUQsnCuXGuFLHDOq5Jj0G9dwwS1y0HxKykt1VTRCZNu?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b764af1-52e4-4697-347a-08dbbf36732d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:47:58.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLq30A2rmbshw36dp0kWSl20tRucb1RFSJO5/fzJ+Qr88SHOEIYqgSE5WnWa56zRQEcd+qHubm4saaB1HbPVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Hello,

kernel test robot noticed "WARNING:at_net/core/flow_dissector.c:#__skb_flow_dissect" on:

commit: 7a6420ac36c0355d4d370cce83343dcefa58a1c4 ("[PATCH ipsec-next 2/2] xfrm: policy: replace session decode with flow dissector")
url: https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/xfrm-move-mark-and-oif-flowi-decode-into-common-code/20230918-210254
base: https://git.kernel.org/cgit/linux/kernel/git/klassert/ipsec.git master
patch link: https://lore.kernel.org/all/20230918125914.21391-3-fw@strlen.de/
patch subject: [PATCH ipsec-next 2/2] xfrm: policy: replace session decode with flow dissector

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: netfilter
	test: nft_synproxy.sh



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309271628.27fd2187-oliver.sang@intel.com


kern  :warn  : [  173.147140] ------------[ cut here ]------------
kern :warn : [  173.147759] WARNING: CPU: 12 PID: 2260 at net/core/flow_dissector.c:1096 __skb_flow_dissect (net/core/flow_dissector.c:1096 (discriminator 1)) 
kern  :warn  : [  173.148709] Modules linked in: nft_synproxy nf_synproxy_core nft_ct nf_tables veth nfnetlink openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 intel_rapl_msr intel_rapl_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp btrfs coretemp kvm_intel blake2b_generic xor raid6_pq kvm zstd_compress irqbypass crct10dif_pclmul libcrc32c crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate nvme nvme_core t10_pi crc64_rocksoft_generic crc64_rocksoft ipmi_devintf ahci libahci ipmi_msghandler intel_wmi_thunderbolt wmi_bmof mxm_wmi i2c_i801 wdat_wdt intel_uncore crc64 mei_me i2c_smbus libata ioatdma dca mei wmi binfmt_misc fuse drm ip_tables
kern  :warn  : [  173.154193] CPU: 12 PID: 2260 Comm: iperf3 Not tainted 6.5.0-04033-g7a6420ac36c0-dirty #1
kern  :warn  : [  173.155024] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [  173.155977] RIP: 0010:__skb_flow_dissect (net/core/flow_dissector.c:1096 (discriminator 1)) 
kern :warn : [ 173.156562] Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e4 39 00 00 4d 8b b6 a0 05 00 00 4d 85 f6 0f 85 9d f9 ff ff <0f> 0b e9 0f fb ff ff 66 81 fb 08 06 0f 84 ca fc ff ff 44 8b bd 00
All code
========
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	(bad)  
   8:	df 48 89             	fisttps -0x77(%rax)
   b:	fa                   	cli    
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	0f 85 e4 39 00 00    	jne    0x39fe
  1a:	4d 8b b6 a0 05 00 00 	mov    0x5a0(%r14),%r14
  21:	4d 85 f6             	test   %r14,%r14
  24:	0f 85 9d f9 ff ff    	jne    0xfffffffffffff9c7
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 0f fb ff ff       	jmpq   0xfffffffffffffb40
  31:	66 81 fb 08 06       	cmp    $0x608,%bx
  36:	0f 84 ca fc ff ff    	je     0xfffffffffffffd06
  3c:	44                   	rex.R
  3d:	8b                   	.byte 0x8b
  3e:	bd                   	.byte 0xbd
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 0f fb ff ff       	jmpq   0xfffffffffffffb16
   7:	66 81 fb 08 06       	cmp    $0x608,%bx
   c:	0f 84 ca fc ff ff    	je     0xfffffffffffffcdc
  12:	44                   	rex.R
  13:	8b                   	.byte 0x8b
  14:	bd                   	.byte 0xbd
	...
kern  :warn  : [  173.158315] RSP: 0018:ffffc900008e7e10 EFLAGS: 00010246
kern  :warn  : [  173.158889] RAX: dffffc0000000000 RBX: 0000000000000008 RCX: ffffc900008e8240
kern  :warn  : [  173.159631] RDX: 1ffff1103c1ac95b RSI: 0000000000000000 RDI: ffff8881e0d64ad8
kern  :warn  : [  173.160365] RBP: ffffc900008e81e0 R08: 0000000000000000 R09: 0000000000000000
kern  :warn  : [  173.161114] R10: ffffc900008e81f8 R11: ffffc900008e8240 R12: ffff8881e0d64ac0
kern  :warn  : [  173.161871] R13: ffffffff8472b660 R14: 0000000000000000 R15: 0000000000000038
kern  :warn  : [  173.162612] FS:  00007f4db0039740(0000) GS:ffff88880ea00000(0000) knlGS:0000000000000000
kern  :warn  : [  173.163426] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  173.164051] CR2: 00007f4db0741f8c CR3: 000000087dbda001 CR4: 00000000003706e0
kern  :warn  : [  173.164808] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  173.165549] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [  173.166282] Call Trace:
kern  :warn  : [  173.166620]  <IRQ>
kern :warn : [  173.166916] ? __warn (kernel/panic.c:673) 
kern :warn : [  173.167316] ? __skb_flow_dissect (net/core/flow_dissector.c:1096 (discriminator 1)) 
kern :warn : [  173.167837] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  173.168293] ? handle_bug (arch/x86/kernel/traps.c:324) 
kern :warn : [  173.168724] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
kern :warn : [  173.169173] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
kern :warn : [  173.169668] ? __skb_flow_dissect (net/core/flow_dissector.c:1096 (discriminator 1)) 
kern :warn : [  173.170170] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:27 (discriminator 1)) 
kern :warn : [  173.170643] ? bpf_flow_dissect (net/core/flow_dissector.c:1029) 
kern :warn : [  173.171125] ? native_queued_spin_lock_slowpath (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/atomic/atomic-instrumented.h:33 arch/x86/include/asm/qspinlock.h:25 kernel/locking/qspinlock.c:353) 
kern :warn : [  173.171729] ? .slowpath (kernel/locking/qspinlock.c:317) 
kern :warn : [  173.172143] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5763 kernel/locking/lockdep.c:5726) 
kern :warn : [  173.172601] ? __create_object (mm/kmemleak.c:678) 
kern :warn : [  173.173076] ? set_track_prepare (mm/slub.c:3016) 
kern :warn : [  173.173555] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4663 (discriminator 3)) 
kern :warn : [  173.173978] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4663 (discriminator 3)) 
kern :warn : [  173.174398] ? reacquire_held_locks (kernel/locking/lockdep.c:5412) 
kern :warn : [  173.174913] ? mark_lock_irq (kernel/locking/lockdep.c:4646) 
kern :warn : [  173.175373] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.175841] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.176296] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
kern :warn : [  173.176849] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4574) 
kern :warn : [  173.177468] ? rt_cache_route (net/ipv4/route.c:1485) 
kern :warn : [  173.177925] ? find_held_lock (kernel/locking/lockdep.c:5251) 
kern :warn : [  173.178384] ? __lock_release+0x111/0x440 
kern :warn : [  173.178905] ? ip_route_output_key_hash (include/linux/rcupdate.h:781 net/ipv4/route.c:2643) 
kern :warn : [  173.179442] ? reacquire_held_locks (kernel/locking/lockdep.c:5412) 
kern :warn : [  173.179960] ? __mkroute_output (include/net/lwtunnel.h:140 net/ipv4/route.c:2618) 
kern :warn : [  173.181387] ? __xfrm_decode_session (net/xfrm/xfrm_policy.c:3451) 
kern :warn : [  173.181904] __xfrm_decode_session (net/xfrm/xfrm_policy.c:3451) 
kern :warn : [  173.182398] ? ip_route_output_key_hash_rcu (net/ipv4/route.c:2629) 
kern :warn : [  173.182972] ? rt6_get_cookie (net/core/dst_cache.c:29) 
kern :warn : [  173.183449] ip_route_me_harder (include/linux/skbuff.h:1121 net/ipv4/netfilter.c:66) 
kern :warn : [  173.183941] ? nf_ip_route (net/ipv4/netfilter.c:21) 
kern :warn : [  173.184369] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.184831] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.185293] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
kern :warn : [  173.185849] ? cookie_timestamp_decode (net/ipv4/syncookies.c:48) 
kern :warn : [  173.186377] ? __alloc_skb (net/core/skbuff.c:666) 
kern :warn : [  173.186829] ? lock_is_held_type (kernel/locking/lockdep.c:5502 kernel/locking/lockdep.c:5832) 
kern :warn : [  173.187312] synproxy_send_tcp+0x2aa/0x540 nf_synproxy_core
kern :warn : [  173.187988] synproxy_send_client_synack (net/netfilter/nf_synproxy_core.c:484) nf_synproxy_core
kern :warn : [  173.188699] ? synproxy_send_client_synack_ipv6 (net/netfilter/nf_synproxy_core.c:450) nf_synproxy_core
kern :warn : [  173.189444] ? hrtimer_nanosleep (kernel/time/hrtimer.c:337 include/linux/hrtimer.h:255 kernel/time/hrtimer.c:2099) 
kern :warn : [  173.189947] ? ktime_get (kernel/time/timekeeping.c:379 (discriminator 4) kernel/time/timekeeping.c:389 (discriminator 4) kernel/time/timekeeping.c:848 (discriminator 4)) 
kern :warn : [  173.190388] nft_synproxy_do_eval (net/netfilter/nft_synproxy.c:60 net/netfilter/nft_synproxy.c:141) nft_synproxy
kern :warn : [  173.191004] ? nft_synproxy_obj_destroy (net/netfilter/nft_synproxy.c:109) nft_synproxy
kern :warn : [  173.191653] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4663 (discriminator 3)) 
kern :warn : [  173.192073] ? lock_is_held_type (kernel/locking/lockdep.c:5502 kernel/locking/lockdep.c:5832) 
kern :warn : [  173.192563] nft_do_chain (net/netfilter/nf_tables_core.c:290) nf_tables
kern :warn : [  173.193119] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c:254) nf_tables
kern :warn : [  173.193784] ? __create_object (mm/kmemleak.c:678) 
kern :warn : [  173.194274] nft_do_chain_inet (net/netfilter/nft_chain_filter.c:145) nf_tables
kern :warn : [  173.194856] ? nft_do_chain_arp (net/netfilter/nft_chain_filter.c:145) nf_tables
kern :warn : [  173.195420] ? NF_HOOK+0xca/0x2b0 
kern :warn : [  173.195924] ? lock_sync (kernel/locking/lockdep.c:5729) 
kern :warn : [  173.196354] ? skb_release_data (arch/x86/include/asm/atomic.h:85 arch/x86/include/asm/atomic.h:91 include/linux/atomic/atomic-arch-fallback.h:778 include/linux/atomic/atomic-instrumented.h:290 net/core/skbuff.c:968) 
kern :warn : [  173.196837] nf_hook_slow (include/linux/netfilter.h:144 net/netfilter/core.c:626) 
kern :warn : [  173.197269] NF_HOOK+0x17f/0x2b0 
kern :warn : [  173.197763] ? ip_forward_finish (include/linux/netfilter.h:298) 
kern :warn : [  173.198248] ? ip_route_input_slow (net/ipv4/route.c:2487) 
kern :warn : [  173.198772] ? ip4_obj_hashfn (net/ipv4/ip_forward.c:66) 
kern :warn : [  173.199237] ? tcp_v4_early_demux (net/ipv4/tcp_ipv4.c:1796) 
kern :warn : [  173.199739] ? lock_is_held_type (kernel/locking/lockdep.c:5502 kernel/locking/lockdep.c:5832) 
kern :warn : [  173.200221] ip_forward (net/ipv4/ip_forward.c:162) 
kern :warn : [  173.200665] ? lock_is_held_type (kernel/locking/lockdep.c:5502 kernel/locking/lockdep.c:5832) 
kern :warn : [  173.201143] ? __xfrm_policy_check2+0x460/0x460 
kern :warn : [  173.201747] ? ip_rcv_finish (include/linux/skbuff.h:1121 include/net/dst.h:468 net/ipv4/ip_input.c:449) 
kern :warn : [  173.202205] ip_rcv (include/linux/netfilter.h:304 include/linux/netfilter.h:298 net/ipv4/ip_input.c:569) 
kern :warn : [  173.202596] ? ip_local_deliver (net/ipv4/ip_input.c:562) 
kern :warn : [  173.203078] ? ip_sublist_rcv (net/ipv4/ip_input.c:436) 
kern :warn : [  173.203548] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5763 kernel/locking/lockdep.c:5726) 
kern :warn : [  173.203997] ? process_backlog (include/linux/skbuff.h:2360 include/linux/skbuff.h:2375 net/core/dev.c:5963) 
kern :warn : [  173.204489] ? ip_local_deliver (net/ipv4/ip_input.c:562) 
kern :warn : [  173.204967] __netif_receive_skb_one_core (net/core/dev.c:5516) 
kern :warn : [  173.205527] ? __netif_receive_skb_list_core (net/core/dev.c:5516) 
kern :warn : [  173.206101] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.206571] process_backlog (include/linux/rcupdate.h:778 net/core/dev.c:5966) 
kern :warn : [  173.207027] __napi_poll+0xa0/0x530 
kern :warn : [  173.207546] net_rx_action (net/core/dev.c:6596 net/core/dev.c:6727) 
kern :warn : [  173.207995] ? __napi_poll+0x530/0x530 
kern :warn : [  173.208530] ? reacquire_held_locks (kernel/locking/lockdep.c:5412) 
kern :warn : [  173.209039] ? asym_cpu_capacity_scan (kernel/sched/clock.c:389) 
kern :warn : [  173.209581] __do_softirq (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 include/trace/events/irq.h:142 kernel/softirq.c:554) 
kern :warn : [  173.210021] ? __lock_text_end (kernel/softirq.c:511) 
kern :warn : [  173.210471] ? irqtime_account_irq (kernel/sched/cputime.c:64) 
kern :warn : [  173.210966] ? __dev_queue_xmit (include/linux/rcupdate.h:308 include/linux/rcupdate.h:817 net/core/dev.c:4367) 
kern :warn : [  173.211454] do_softirq (kernel/softirq.c:454 kernel/softirq.c:441) 
kern  :warn  : [  173.211870]  </IRQ>
kern  :warn  : [  173.212170]  <TASK>
kern :warn : [  173.212479] __local_bh_enable_ip (kernel/softirq.c:381) 
kern :warn : [  173.212965] __dev_queue_xmit (net/core/dev.c:4368) 
kern :warn : [  173.213441] ? mark_lock (arch/x86/include/asm/bitops.h:228 (discriminator 3) arch/x86/include/asm/bitops.h:240 (discriminator 3) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 3) kernel/locking/lockdep.c:228 (discriminator 3) kernel/locking/lockdep.c:4663 (discriminator 3)) 
kern :warn : [  173.213881] ? mark_lock_irq (kernel/locking/lockdep.c:4646) 
kern :warn : [  173.214352] ? netdev_core_pick_tx (net/core/dev.c:4249) 
kern :warn : [  173.214861] ? reacquire_held_locks (kernel/locking/lockdep.c:5412) 
kern :warn : [  173.215369] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5763 kernel/locking/lockdep.c:5726) 
kern :warn : [  173.215828] ? mark_held_locks (kernel/locking/lockdep.c:4281) 
kern :warn : [  173.216286] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4573) 
kern :warn : [  173.216902] ? neigh_hh_output (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/seqlock.h:104 include/linux/seqlock.h:837 include/net/neighbour.h:496) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230927/202309271628.27fd2187-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


