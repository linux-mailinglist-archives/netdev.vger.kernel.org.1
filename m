Return-Path: <netdev+bounces-40002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E077B7C55E6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D00281FF4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08443200B4;
	Wed, 11 Oct 2023 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLmzF301"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014A1F94E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:51:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA890
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697032258; x=1728568258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X0OyT6u+LjJuZ5yvuVSqjH702GBW8szKqGumvqJ+oW8=;
  b=BLmzF301CjwSCDACxb57/gHk2t+LD7XAzb+tSzt89LOeVJlANakLRnRf
   lRppv3qr+YwGYPwbscOBghZEQEzVPyZk+bTj8aFzFc1I7HhL8dis/yQdV
   pkanj/ev3ZXUg+ftvDJNbIF84SICRlzPQ2p2nz9hyLKJXDmcecHET5/ee
   h1j/mBZPPlyFZkoMt6j811eMS26YfHgvYtFXn3JD9ab+i6WJ19sZjD4jd
   BZl/LKjvVm0Yei68pGGG7dEGfXQeKFXIDvku6uqk9uTVwmxRVq09pPZtt
   yNhwYvwydz2ro8EWOxS9sdomp4uU4ATIaHRTezvSQyBIG6Ry0Z8lqqm38
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="375007681"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="375007681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 06:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="819701704"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="819701704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 06:50:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 06:50:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 06:50:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 06:50:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaAswYvELg/3l+b7XRZTgjVy+ZMR+Thwutdso0wBQm5M9g6O2VI7vN5VItLOogzVv05ZKZLws7Dz/iJmqyqMCeixBTR4ZR9Z1bIsLjTM65WjZguKLVBgiYgHYo8jqy/x49mO02T0hxGWyWbGOVcw+CcOw6sfNmvaKVDN2jA0xkZRXVlc3v4Jj7Ka4XLv7FlqeK79lDyLUGbBSzc4u2R1LHpiNiAbGRX4slv/QZ9h+Ugm98SNtzuEpSBmMCIik79yQ8X+J9RqxOSZmtSfcMG0uWTV0yVtswsO41W5NVwoKR97Mry7P3hibq6QsRbVAND3ZAPsBQPhT2tUIH7RWj0Fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUK5605qaeiCbZsVZ9sXfts+Rea90BFCo5V9LPnbBmU=;
 b=gxWlUKExZ7BxaAI4xat30Bpr5087OPbJuZT2nhNHW5+0DYIaryqvJH93NKnOcq94FJp88RUoC49CBL8vh8UaR4FpWG5m+pF5+pRYiuTiOJY0qRMQCep8zHwlxqHfKYbeTWy3GgNZLv/JiYE0FaOvA+L56dc34wO2X1Unj2cgxG1JzW37+Uli84wcVtLQTHRyIsSOusmLOOWO4XvfPXCGCQprhX3SWujXW3lHHyzgxbC3UNsqfN46gGNxdoeIUG7c8wTstCpCeJT2QxHlE3+6HqU3VpD+W0aWraxWICg5X5FhBiRb/Rf+nCTwRG8/eeVT4iCn8Xl1u9IDPKRPGblJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7911.namprd11.prod.outlook.com (2603:10b6:208:40e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 13:50:54 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6838.029; Wed, 11 Oct 2023
 13:50:54 +0000
Date: Wed, 11 Oct 2023 21:50:46 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Mendes <dmendes@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [kselftest]  9c2a19f715:
 kernel-selftests.net.rtnetlink.sh.gretap.fail
Message-ID: <202310112125.c5889283-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 7090b310-e967-48ac-0254-08dbca611618
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIvIlaBNgAru38Oz07kcOfOHZmt/fbAT5DtSpT0k7SYWabt41jqI2Yyk6VgOkuqMw7UO2PXvCzsbfMmTrmkmHSslzc/gORxNuzU3ElazJQVf5qo32MbHGQQVphvyeXNxbu0ijZtjHQQqSOCLnReG+9DAxUAp6loGwGkPDslOweTLcJ0CaZ88jNtbfMC3B+4CHqKdh4NXdQUUCETZNEk5tQDmMb78Fx30CK+QMc6H1NC9ClcXXEoCAoi1obv6AB++ltoe4rT8BSYVMdjNXTBnztvJk3daKHrHyyqv8pfLiB1y3JM+bt8zOe1Ph24w1KP6wqFYobuL3ZTB5MJm7iLXVx/nuFM0IqNUSE7ZAhFXEnNrxuq7MCmwHcZDUoOiiE8LnaozhgVu8OZXGUdKrSChB86+xDc/RQ4BXEicz9LknOdGjtR0GypRHLj3zD6WDWXw+SfjWqS1mCWP/YcHMwwd4vW5cw43XN3o3X4W0CwwK4ScccupP+mJbjvTX+CHqZxh7NGCG6TfxJBSLlb0v+9ZH/3llqMZrun0fQTX4jZPQVN0si25K5r0B960XtaLqosV/36XkE/gC1H7pnwZGN+5YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66556008)(1076003)(107886003)(6512007)(82960400001)(86362001)(36756003)(38100700002)(6506007)(26005)(2906002)(83380400001)(966005)(6486002)(2616005)(6666004)(478600001)(8936002)(8676002)(6916009)(41300700001)(4326008)(54906003)(66946007)(5660300002)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6z4fSsm3tRLErDWQ5vXXrCc7ZoblE4T34bu7FUyzhJTNm4SDKvKVwb4zuLCO?=
 =?us-ascii?Q?ZMfRLFVSJlMcWGCd39ijFHKrqEySWi/w6CrAtsgMuX0F2kDDyTX/81lok8Qb?=
 =?us-ascii?Q?TDM4u95sPgEKqko2s3hksx9MieCw9FvaACLkR39N5CuvGl+J6hjc0Am9h8Ov?=
 =?us-ascii?Q?2dm67j7qAN5YY0n5divrYYMQR5zeO8wNut4v1ILF4L4m5OfHY8mzlZL/zjDo?=
 =?us-ascii?Q?Pi1pgDNq/FZKs26Gtuaq0MHxg4oz0mSecKMlYbKAkGO/oYts5IIDyUNV+YJv?=
 =?us-ascii?Q?HV5AjuNBkvmPScmpOXwschr7m8mZOqy394QfRx7TmgYAsj7vW1fy7h+wGPhG?=
 =?us-ascii?Q?CwESOxzQVx9Pbq2fzTY9MCN37oaYgn8rJ1HmFh9xnBiVOspuoyRScyZkKpXX?=
 =?us-ascii?Q?iX92IxYU7BJtOHcPT9VADlsuj8pjyPWD44gL4/kT/TS7sYkf3+fRD2nerBam?=
 =?us-ascii?Q?jZSo4tYhv/nhKbV3wMpnUTbKl5EJrniuSl0yogzCAkhEI/nhLS1SmNct939h?=
 =?us-ascii?Q?jFNPFymGfGdPV+q1dMq7jDwRjoA+k5iIO6xbZehvW6x/sJoOaOGThc38VZ3Z?=
 =?us-ascii?Q?oq23CDxO3Y+WP/+U+8EGvQmSRWFK1g/MtNoWA1El3U1Lix5ONtilGjLCkxBR?=
 =?us-ascii?Q?nVJDyHsaf2k4ItncmVlKPk7aChoAc9sIG8KkvtnP241ABDfFn/gk777TkELX?=
 =?us-ascii?Q?Jx6T7v40gy1JVPAahZZq3j2alQa6TM823jgl/0t6sMlYbc546oBbtZE1Vxgj?=
 =?us-ascii?Q?9PKbhzy3RTLhVmPhVC2b0CrWbEsuCgs+BGE7GRvGIf1zj9UTyU11vHF9x8Fu?=
 =?us-ascii?Q?rqVYBvK3td0vKqdvd9C3OgXO2RRvOybDSv/25Tbr8XVy1YrYI5g6DJeSILXE?=
 =?us-ascii?Q?QTFm+zjEm4jiSWSGIDo+CCl+A3mhSc4endEeyjbbKjfPRHkjEsWdjqhv8uB0?=
 =?us-ascii?Q?jcvTRQdB1EkOMBznNLY61r5zzBeD+aVOKj/hNMo0xhWGM3vUn+pIk1pKcwh1?=
 =?us-ascii?Q?EwXd406yWWh7ecJ/LgjUTwZXHa+1St4FeQJMcoXtl30W+A0cX/z08dAY9YNk?=
 =?us-ascii?Q?4mHGfx4fTtyobTOHfr+yzcTSXdxG5QipkcY7jxkCwsDEHzjoxDtyYqVgLheE?=
 =?us-ascii?Q?PCSmRD7Hn6yFdNKzpVOFzPSS8cRRdSR5nn9CJ3iEn1NlexlumKw+rAU8Mopk?=
 =?us-ascii?Q?QHxUoQ8l7gJwSdk1J6ihEAkdT5wQBPkA/y4xRr2mZGmdkpVTOXjvOwl+IWFG?=
 =?us-ascii?Q?hkJwasRODvkC0XEPc8Sbbh9WYu0BOOz0t2fbIi5NHTdKIycJTHC3Uev2GsxN?=
 =?us-ascii?Q?k4a6b8/0FkuemNAXvUsSiBfiPXkxYKPYM103LIPs4LakD7UkyVF44Izo0V/O?=
 =?us-ascii?Q?ejAFbJQUys8ScfQ4z4aFfjCJQ04MqsjbkT1mI6lzTaU+GNtRWZvch9JYUmOB?=
 =?us-ascii?Q?K1HbwkEFYFlT1ut3FwXmN3skViTFQgpsRfByPtROjhb/yWx8LLjYl4WqHRPV?=
 =?us-ascii?Q?9bwlOih6SlML3a4p11EGwp+TK3/0RAzWSokH9X9KNfG1Ylsr4sox5svfBnxs?=
 =?us-ascii?Q?bey0Ryipp+kuUxEXfUqyNcWly+Qs4Fv4wLaR+G4VJ+LFzH09uYZAFCfTUt4Z?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7090b310-e967-48ac-0254-08dbca611618
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:50:53.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtfCadACBtalH/Vajjn1o1/FbEtMFDvwnkR4AU2AAZyXK89+JpLTpTjQUMGxRLzKfP6afq8RTDXZ22wtBr6C9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Hello,

kernel test robot noticed "kernel-selftests.net.rtnetlink.sh.gretap.fail" on:

commit: 9c2a19f71515553a874e2bf31655ac2264a66e37 ("kselftest: rtnetlink.sh: add verbose flag")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 18030226a48de1fbfabf4ae16aaa2695a484254f]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310112125.c5889283-oliver.sang@intel.com



# timeout set to 1500
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# FAIL: gretap          <----------
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias f007c594-8cc4-4bfa-bf82-fef2dfb81ad2 for test-dummy0
# PASS: vrf
# PASS: macsec
# PASS: macsec_offload
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# PASS: bridge_parent_id
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: ipv4: Address not found.
# Error: ipv4: Address not found.
# FAIL: address proto IPv4
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: ipv6: address not found.
# Error: ipv6: address not found.
# FAIL: address proto IPv6
not ok 15 selftests: net: rtnetlink.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231011/202310112125.c5889283-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


