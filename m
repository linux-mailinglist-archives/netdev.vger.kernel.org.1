Return-Path: <netdev+bounces-44112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCF7D651C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 10:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01144B20FB8
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E41CF8F;
	Wed, 25 Oct 2023 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lczQ++1E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C38154A3
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 08:31:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F07192
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698222665; x=1729758665;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ONmrgJT3TPmMM9+MOCImm4EW+pJIYCkXgfD07uFv4nM=;
  b=lczQ++1En/S0JYWfh9KxakkZoweeVA1ahRaOWjbqbUflIV45iNfXVd8Q
   RlMaCpDuftE+SXAYIJ+1qCLRq010Gx6ceYEcHg1HQol+zZGI0JlPsToqU
   ij/R13ygfmz73nrEd1ilaf57f04ERviEoAMCqmsGWc9+m/eFwv3Wj4lyd
   kOaAeHixJND6nHa3Bn6A50AApamBgBbQoRQVok12zjWSv9LXvmOwqv2sp
   FCDh4VEvS/F7gyIhWmGsQFXbv+K8w1Hc9M4ZN987OIqEVnKT00ocdRkv9
   sP3WKwqpVV3E91/kjTSf3Pdj+qUK4NFIdHtNE3vHf0kWJqeruDjzZfpvm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473499301"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473499301"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 01:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="793788222"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="793788222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:31:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:31:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:31:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 01:31:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:31:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOVre0wG7BxzpPdZNedcwU3JBcoLlvbN5grWWPFFPavgS6470dqod19ofYiKu49Wa3BrEuUcrLMSurN8bil/EYvvZnhQm3FGYkg5oh6JYoiPOC1EP6c+10GxFOh/MF65o7nGBfbWaaIznL0CwEKXFk9maGj1mzE3pA9x0cH2eMNUuHEYKvv3MI443in/GsfqcFLyx545g8g0ayUv+f9ZwDyaWrIv4fyezh1PyFWQLzHz2ZqW+6PDJBaCio29wUzciMV9osD9wlEcq4+1eFFyW17JTner5kP/bnDSsvpjEMpD4Q10gsN9TdEqe4h44tSVBaPtyZ8w4+oITbks+8nspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBauPhi2A4NJskmzDSokOPPxEqtxTFR9EXmxx2G1mnY=;
 b=AfY3WmYKB51xRB8Lnie6TzHwvK0E2y/PG0pbsJNE+ZEunuiIPouc7ZASvaHS5BpH4d+Q2irpwt18KmWDnkg1FjpN7aKrQmWzl6da35sP/LO7wraFO9t7gJf+ifGkhBLI+6+IfOTlu1O24JjkNOkrFgfcstm5t/coxwIa5Qik2VTIlsZBS/ThhV1xPyYukklLyGGS/CysEhISPbrSmA0nv20p87bUrtTvpMtIw6uaSCGD35gb4lUkrAnpDgMWh52vVnku08cUHOvmfiZJGFF2LGk4/N/86O8m7XovGixBOwKcPDhAzNQgb71y5SXVa5k7BwZ3emlJToRw9BQaUg7j0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6799.namprd11.prod.outlook.com (2603:10b6:806:261::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:30:59 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:30:59 +0000
Date: Wed, 25 Oct 2023 16:30:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pedro Tammela <pctammela@mojatatu.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Paolo Abeni <pabeni@redhat.com>, Davide Caratti
	<dcaratti@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [selftests/tc]  d227cc0b1e:
 kernel-selftests.tc-testing.tdc.sh.fail
Message-ID: <202310251624.5ce67bed-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fbafe6-3a31-41a4-d66c-08dbd534b758
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gM/ygGcwPp1a6ac4GlOjdpp1q74RuBAKJoyF56QgpOQF2M0AzOWcG6UgJiIYDbHaIqHpyHxkYjK35ueffazxaMomRPuLbcAzvquX2aNQmyp9LgaAcb7MLk5DUiritM+0bac2ykjCMaoUYVjrmA5LKY7gQxy2CIviHKL1b5qJLGFRYMU0uqdIzgSYdBumJ+CeCoFRVBHpJRkx22bg1OQni+Z8j5mESWWOu9yWhPtMKoAqccT7yAj/+Z19sBbEpJ3V3EPiDQGRgr01GafIqFHg4PzvvdhY9qKaafsUKWepd6inxCm8XTD7CBs0e93C1d2921lZz0EO6+diSJ0Y5wsZUNrPZYBaSwgcr/EgEDxJ0tuSkyQIdvBo8q+XkkGmiHa8V3Ow6HEhGUSYyFX7+jR4wCTfbwoywDtVXW6Ofq88Rbk+nEwSSvmUSy+uFwax+RxqJMBVMFM25wVL3GTNuL0zbCOoRZUFuBM+d54vgRfD+Y9p/QhQyIf+pAZjZW8GBTBrp+fWdHm8QIvoAf4swCfI/7/M9lfsq/NsL7uJfk3+4WiLpDTL22y8/2jvlHO3zbQHMQm/x0DK8/t21UnSbDJvKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(2906002)(66476007)(66556008)(54906003)(66946007)(6916009)(38100700002)(82960400001)(6506007)(478600001)(6486002)(107886003)(1076003)(2616005)(6666004)(966005)(6512007)(83380400001)(4326008)(36756003)(8676002)(5660300002)(41300700001)(8936002)(26005)(4001150100001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhc3rBSzTTWZACM/b0hQr43hZ4WKD7h2AcmQHy81B3hNNphc4Uw99xWX0jey?=
 =?us-ascii?Q?Tws3YzlOAPe8DN91+nGumYolwkaxbpBo7y9uYmedGckJCaTshmB5mpyNTKvW?=
 =?us-ascii?Q?fe0VB/DDFxTOSJ0hnLQwgLaxqDf8EEkL6N5ZdUH/TAr1kSkxrflztB58xNCt?=
 =?us-ascii?Q?stgGDbV/3RBF+tQPJuPPTnQQu/jowcwv1urB3ESxJNqp3c9ssQ/J6PNTHnV1?=
 =?us-ascii?Q?eYFukzsyWveFVnZTNEIoFh0s1WEGIuMuyAC7DF0k+paal0J1bpV3dRZOJYOz?=
 =?us-ascii?Q?6dwwORVWmbe/MaEai3KpterteSElOk9IZhPOsQRtx4uVELxF7EAlCq6c4a+H?=
 =?us-ascii?Q?1QHJP2P14AnFq7ONB5vHDOUaIw9iYEYDi+qqcc16lj4uuIRtLCTrvajpT0Hh?=
 =?us-ascii?Q?8/3Ma+rVMykcn1ubDFdBTMGCHPeVtXDafEL75h/Ro5P7D1b6JhVXHcRSUmAE?=
 =?us-ascii?Q?/ojKNYLsq5g/e4rbFZfOwrhf5hm8GTK0SW6ZzNwSLLEHl8XSQOONnZ7fQLsU?=
 =?us-ascii?Q?r5+2LFTeM9CjQ5GekRGnxDhg/n9iWEdoi8T0edmxQ+5pDbbYCATE7uM9MtnN?=
 =?us-ascii?Q?vpdojCdQ1bON9i9qrhDmZeIp2vWE11J4atwaE5xErt5khMHHQJHlmWinxbdC?=
 =?us-ascii?Q?B7iWv0FjDxYbWhEEpkBtYjU5pSdXz+rhTCiVE25M/4Opl/DihkUqI7QbYt8h?=
 =?us-ascii?Q?4kfnDkN8MVtAxLwZgsHTOpatymoef2m68N0EjL6Zb5czcC3LWSSutjVp2UAO?=
 =?us-ascii?Q?9UDrBlB9fZm3MOblUuMwrYCVsValkjDFouyST4XdHiV+BCbbRF1ueoX+Dw6O?=
 =?us-ascii?Q?sEpV0kmjpSGGwtAEtJUiPpq6BvHFIIEQRGN2Do7+h3TKD2df/L5/HQwFFCpb?=
 =?us-ascii?Q?3jDv7cZiaHylfo4rPgpzPYsLg3mDYqhjcTm+bseE9PxHjHHSr4TPzDQNw0kR?=
 =?us-ascii?Q?OIbqpirjytdIN9e5sKkxa41Gim4eRxdN0VYc8gH2jtof3dgA0yOZr0w080zw?=
 =?us-ascii?Q?YdZj9dc1KP3DpNCY3cmzM3YYOTpwEz1Km9syW0Y0YpYAtS9uFK9xlnzdmsGl?=
 =?us-ascii?Q?3XCEjf9d5bnHnageSxI7ukHPbJfmEXi7su7lfERrKdQVGXwKKNmV2slai7Ed?=
 =?us-ascii?Q?05rgGL7FcGwOSZfXXisnE0ThJGil+5PE8nDfKOtQKiXcXXDvZ/woRVuoa9XI?=
 =?us-ascii?Q?D6j36KSYXV+BntkMHBaJhYnejKpwUKeOuEXPmTR4n0lfo28H9KTcEaFRsu84?=
 =?us-ascii?Q?I+g9o5XgyLjUg0TDbSPrSgyOxmyPm3fRtinAWtwisTTAcKibBipO0w2Xfoyz?=
 =?us-ascii?Q?pQ+4mzKRP5oAKILKWHvWGrkrrSW4R4wBEm+EA6Zrz6JpXAJ4w9k3sLOd03b0?=
 =?us-ascii?Q?XobWXAVpOKXT+31Jr+H/R+kZAo0lmlrGW13pv8UYEfDpUhhArsw6f9S08Y8i?=
 =?us-ascii?Q?zxelx8tL5am1qGZjGaBks/SD/JPbGNAhMliFT3Iidb93Ve9pD20y0D6FUbdt?=
 =?us-ascii?Q?lYV9lmY62g48dq9Nn5yj3NuIQye/xSTSe2GDNcXFv6Qs39SI2xyWMH/eFWM7?=
 =?us-ascii?Q?5YRKjUiLcZgSIiBQC338fzIDIuCn0w0D2+URIHgaCtn1BwRWXmgOnPs78dC7?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fbafe6-3a31-41a4-d66c-08dbd534b758
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:30:59.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luulH3pMBgJj5JUOmGMIC3NOhMA9ttv7vRBRxDeRInddKzlfVlnvK/P1FCv+fwoQSiDGgB2bvjbmyM14onYHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6799
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.tc-testing.tdc.sh.fail" on:

commit: d227cc0b1ee12560f7489239fc69ba6a10b14607 ("selftests/tc-testing: update test definitions for local resources")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2030579113a1b1b5bfd7ff24c0852847836d8fd1]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: tc-testing



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310251624.5ce67bed-oliver.sang@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607
2023-10-15 09:16:35 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-10-15 09:16:35 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-10-15 09:16:35 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
LKP WARN miss config CONFIG_ATM= of tc-testing/config
LKP WARN miss config CONFIG_PTP_1588_CLOCK_MOCK= of tc-testing/config
2023-10-15 09:16:39 make -j36 -C tc-testing
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
clang -I. -I/include/uapi -idirafter /opt/cross/clang-4a5ac14ee9/lib/clang/17/include -idirafter /usr/local/include -idirafter /usr/lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include -Wno-compare-distinct-pointer-types \
	 -O2 --target=bpf -emit-llvm -c action.c -o - |      \
llc -march=bpf -mcpu=probe  -filetype=obj -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing/action.o
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
2023-10-15 09:16:44 make quicktest=1 run_tests -C tc-testing
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'
TAP version 13
1..1
# timeout set to 900
# selftests: tc-testing: tdc.sh
#
not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 900 seconds
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-d227cc0b1ee12560f7489239fc69ba6a10b14607/tools/testing/selftests/tc-testing'



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231025/202310251624.5ce67bed-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


