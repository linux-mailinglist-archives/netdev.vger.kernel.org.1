Return-Path: <netdev+bounces-35028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6717A67CC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120D4281885
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD0F3B7B3;
	Tue, 19 Sep 2023 15:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC63B7B0
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:16:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2C94
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695136563; x=1726672563;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LEs9E3JP0WZT8PiKdpFBgzJbPfqOFvzb8xKUsZAFN2o=;
  b=FzJForRfsBkoNIPr7CcOUyO1OLkRj2G4epqPKBqKI8HVmb0cGyCLA++X
   zNQg8FuujED04PLF4hxMq4gMjvs99hI45RJ1Or89cHCkIJsKy2P0p8fha
   o1XiYfAyrAgXag+EL0I9ktV522Katl2WLtjkOUSqXFVxK+2TkpS7gpOIP
   nHZHJjB91RRlBQG4j/J+Pwje4GHIOOwCkFBU8/utWD7qK2wYqow7rWeHn
   6/+6Mwp4DU1MP7p2qYg7OeT2hmE/J8B9FLhFlALDaWA78kFmFxC4ivgK2
   zafnLwj7Lo/uMpYVUq7HtwU9weTkNjW/TXmxb/BBQwJHIM3SdhhpZfwqH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="444054467"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="444054467"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 08:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="775595054"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="775595054"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 08:16:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 08:16:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 08:16:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 08:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPj8erlPYjGA7l3EkvfWZJCpL6CluEfXA7WUzJn8Cu25XukjrG3aEoGNSu46RNmcfKky83GYKlN+FsaGzUeIa3Z3TFlKJ4uFGAGsYXc888UlQ/882AD4ilM+MNUJ45gHRiLlc0U3Oe5KvXJ19xC3DPuH4Ouhqfu6oDAdIhWi+vgIXDnEpjzxFHDASotXMAEqN20azP3m1nVh8GSOl5lJzA6GK02qGB5X+ae0qP5rFdREHb15Xol2ujjJeMHx4hYYdejERv0jHxdS+0WEY8um1WOgB4PsC4/YKrCFNuGFMTYy+cmnboiQMh2d29AERZQQmqRC+U2BeoHZJ0HmlHickw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTEKTp58GG5gdTU1rpOXm4n0LvWKa4GpFte1FZzyq7o=;
 b=JOF+aggOMGRC4tvzBpyC7K5YKDU1k7kSU0AXVW4nRUbEjBI304QzsWKfiPJk+7tbUo3fZA7RMSdptToxoWXVULUpKdeOFx2krad5yLuRljZenwWhXy+07hhEVHAC1RsEkiAAii0mXv13+wXg3LhkiBe2nDQIiIYrYkrcVlVu+SoMhxOqSV6QcqOO6X7BPF7xfWSTovMx9yDvzmyVDMFP1dswJnYMqev0rQQLAAQdLz9AgARgUW1nN5JHmEHSOS69v/jx6KNg8WP2qPZ7GqVDhXgHyyUUlaNkX9c2RmgxZxK3feZ+J8QVedGyvIS0yCOc5UQsd3PilJlDJCv7aaU9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 15:15:47 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:15:47 +0000
Date: Tue, 19 Sep 2023 23:15:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xabier Marquiegui <reibax@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Richard Cochran
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>, <horms@kernel.org>,
	<chrony-dev@chrony.tuxfamily.org>, <mlichvar@redhat.com>, <reibax@gmail.com>,
	<ntp-lists@mattcorallo.com>, <shuah@kernel.org>, <davem@davemloft.net>,
	<rrameshbabu@nvidia.com>, <alex.maftei@amd.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next v2 2/3] ptp: support multiple timestamp event
 readers
Message-ID: <202309192210.a6367ad9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912220217.2008895-2-reibax@gmail.com>
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BY1PR11MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f598e9-6a4c-4db2-1c1e-08dbb9234ce8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hq8aqw9WNB+3ttxaa3tFadJsNx1COjaagrNcDhxtErkCpDQzyM09u1oPp7+BVV4+6D82qYMaGvgxQXx9YOs4u371KUB7MaR9zKRkPXwm8JHchjcKf9pV+ZB/KNZ5gj5V7bxiX2X5kN2ldixvhuPAfB187p2BqbCfB1mrdDGatfLTVw5I3l+FqF4iBZD3Jdn9MD0hQmuakPupR2OJvPmUzrngt6JZuSLkaOfqfTEpCecYvSd0clYaljR4WUoaI5tWHmCYmxogF4nPX3jguD3SxP/g/gQ58xNXVU8yh25eIerA355NmrpH/Fjj39teFJCR6efaBwb7atzG1zT/GjkJ9XCWHEAzQBpI9Tsk3a2Tb6bx0iGjWwSxNtugFuOsrXwU+Hcrgjd2EINbijf5EQkC+pTVyz2taks+FcdwFfjGu/vN+1/lVkzpDUhyG5cPxLyD6HSvmQaJopU3CC9jpnqmFxwYs4pLUjWIB3TvAy2NbXCmtEqwfjw0PNXoc1fO6sFuXlayiR+OW/y1ZmwZPceD7vUnJsa7z87c3NMDpqh8QLBltmt8p0GvspMbG38e0UjlPQL5L2W841RKRZm8U45NmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(1800799009)(186009)(451199024)(83380400001)(6512007)(6666004)(82960400001)(6486002)(6506007)(36756003)(45080400002)(41300700001)(2906002)(66946007)(66556008)(66476007)(316002)(6916009)(30864003)(5660300002)(4326008)(8676002)(8936002)(7416002)(38100700002)(478600001)(966005)(86362001)(107886003)(1076003)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTwo9TEy2GECSzRv3JRunNiGdV2ehI++jm5PfU5gzQbbbdj3auRZ6suHQkL1?=
 =?us-ascii?Q?fLMeirV0MPMF2qu+SwJoNQVo9zJLYJ9dGzygYcMAx+GeXPISco2tkjUU+E1P?=
 =?us-ascii?Q?+CiHumN8YzSC1jBgOAP1JK1OvBAB7XkDlM3uzYaXUWUiAk0tLkWGaMd2iLCc?=
 =?us-ascii?Q?hvY6VQrhnJPDlbFSF+nJGIDdwVEYEjcq6BI4N9MQdHDNxWk/bTp7Bg6UofNz?=
 =?us-ascii?Q?IZndHzxz1eH4qWLgee555Sug6NdTKK7n9F1Zbj+H1iDGjFiR8KkbMD2KwGEh?=
 =?us-ascii?Q?83Sz5zrgZ/xtyPpCnHQwDQ1JELawPRtgR0E0cBW3cywxJ0rfRnyUyc5VWzus?=
 =?us-ascii?Q?UWT0hLP9l0OgATdOa8gNDYyUq22uFTC2wohrcRw4L0Xpj3RJxfH+HgCzE87q?=
 =?us-ascii?Q?XOm7O1nmPPlRGgPDlJCyB2cIOereDiOYw4ypqugBg9jVRJ9A24dnakY3qJgr?=
 =?us-ascii?Q?6NgQubf0Cs1naVGaVjgYtAzLRDAA9kSZd7sCQxCahBzMSuiwVQdl6njDvBGQ?=
 =?us-ascii?Q?SpwxZvc6IwtyjoUrsda6sJ4v4sqx0/5XWSWCrq4teDiQa/ugWLfSrdmJh+Zr?=
 =?us-ascii?Q?vVIXpGceVXQqtpetYIOI+GbCNELNYos6fd3yXwnIe1Rql+fO7U7dxzOJ9YOK?=
 =?us-ascii?Q?7/GE+gu88XKUAPa6TLrHQwjtyR9JsV37qleNd9seCLwQEWuWTawXo+U24L0y?=
 =?us-ascii?Q?YWcW7k+HfGrYgLe4F/puMxl8fAD+LdYJs9pNEAOPOpVjhMXPXx6v5CTa7FAq?=
 =?us-ascii?Q?sR5YT0JWyrFoxYEvkl4/zvbgMna+kMD2nKWGDl0hrayx1n3Rb8NQ45XxwJWN?=
 =?us-ascii?Q?JXT+pUm894XJ/jkhDOwkiyoA9E1/PD3YcKmbaBXwlwQmBNcp7iK1pqjgRjAH?=
 =?us-ascii?Q?oGD8PQHJFUeGJu/bfH8QpnPb2H/fSNVJciPAKR8XR9lKjJASkDc+KdAve7pP?=
 =?us-ascii?Q?is66hZBPtcHERwAdQG0cq1nfYhOax1KalNSRdJutVtB87GcBbSFOVrhLskSE?=
 =?us-ascii?Q?6Z8TO140Y4rDxhqtrPqQDJ9mX4IIxAR+isYmVntGXrRyVMyDq6e1f8WKPV+S?=
 =?us-ascii?Q?xPljGLhRBtX1PQvRRk5YFlvEsVSsR3RYpXsCLQf2MDA45y56qr0qp33IkyP4?=
 =?us-ascii?Q?VYG4ySZQKqdpPg9c3u7CAHhBsC8g1sTHozemKy7JGxtSfw2f16xkOw2rSMSr?=
 =?us-ascii?Q?z9eSCBaA0ewkHwcB7kQqPU8NCpspeeH0PUWLhI6MfOs6YI/tIVEEjquciUB3?=
 =?us-ascii?Q?IGNBZ7e/Zil4irDCokDSlogtWHrwMSCa8Ztk4Vx+cblIQPPCsRxr8rwde8wD?=
 =?us-ascii?Q?x7yZJLhqXm22+OffvZRt6F/AIkXnSMtHujyViQAQlal2yMjpJFKJL+6wFg6n?=
 =?us-ascii?Q?Q4o/+yrvOa9ZL9LZRN/zdab9C717Hb4X5k4L4WbBeSAOqdA9l5nJOWcqkmuH?=
 =?us-ascii?Q?ERl5BNQ+2SmPYNM+CEBGm3VdfRta6lMHibuVW8f5U2Cj18quWX/q2k/FhDVl?=
 =?us-ascii?Q?HiJ5B6Fvndl5JyqpjhC4ktz8M9Od2JglOL3wtzVIC31Cita1FXBPf1OPdx6u?=
 =?us-ascii?Q?Qz8y1ds1q/trppUGFer7GXYPRICFlHdQzt/kjDinFRI1ru8UVjZuFPt04JTl?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f598e9-6a4c-4db2-1c1e-08dbb9234ce8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:15:47.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIfNwKp77iVgn7OF4G+1Scs0+C3zH9JqgnwKskjNgdo2x6XFQ5xFowJHpbNdvXfnlW5/b/d9pwM6wIcMz08tcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Hello,

kernel test robot noticed "kernel_BUG_at_lib/list_debug.c" on:

commit: bb1445038f83a91450bc74ccc5a6f2b702233584 ("[PATCH net-next v2 2/3] ptp: support multiple timestamp event readers")
url: https://github.com/intel-lab-lkp/linux/commits/Xabier-Marquiegui/ptp-support-multiple-timestamp-event-readers/20230913-060341
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 8fc8911b66962c6ff4345e7000930a4bcc54ae5a
patch link: https://lore.kernel.org/all/20230912220217.2008895-2-reibax@gmail.com/
patch subject: [PATCH net-next v2 2/3] ptp: support multiple timestamp event readers

in testcase: stress-ng
version: stress-ng-x86_64-0.15.04-1_20230912
with following parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	class: device
	test: dev
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309192210.a6367ad9-oliver.sang@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309192210.a6367ad9-oliver.sang@intel.com


[   42.745852][ T4208] list_del corruption. next->prev should be ff11000108593010, but was ff11002089351010. (next=ff1100011152b3f0)
[   42.745864][ T4208] ------------[ cut here ]------------
[   42.745864][ T4208] kernel BUG at lib/list_debug.c:65!
[   42.745870][ T4208] invalid opcode: 0000 [#1] SMP NOPTI
[   42.745873][ T4208] CPU: 14 PID: 4208 Comm: stress-ng-dev Not tainted 6.5.0-12685-gbb1445038f83 #1
[   42.745875][ T4208] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[   42.745876][ T4208] RIP: 0010:__list_del_entry_valid_or_report+0xbe/0xf0
[   42.745884][ T4208] Code: 0b 48 89 fe 48 89 c2 48 c7 c7 78 c0 71 82 e8 99 53 a3 ff 0f 0b 48 89 d1 48 c7 c7 c8 c0 71 82 48 89 f2 48 89 c6 e8 82 53 a3 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00
[   42.745885][ T4208] RSP: 0018:ffa000000ef47ec0 EFLAGS: 00010246
[   42.745886][ T4208] RAX: 000000000000006d RBX: ff11000108593010 RCX: 0000000000000000
[   42.745887][ T4208] RDX: 0000000000000000 RSI: ff11001fffd9c6c0 RDI: ff11001fffd9c6c0
[   42.745888][ T4208] RBP: 0000000000000000 R08: 80000000ffff8c59 R09: 0000000000ffff10
[   42.745889][ T4208] R10: 000000000000000f R11: 000000000000000f R12: ff1100011152b000
[   42.745889][ T4208] R13: ff1100208a28ad20 R14: ff11000108fe40c0 R15: 0000000000000000
[   42.745890][ T4208] FS:  00007f28c2aa0700(0000) GS:ff11001fffd80000(0000) knlGS:0000000000000000
[   42.745891][ T4208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.745892][ T4208] CR2: 00007f28c2a9dbf0 CR3: 00000001dd39e003 CR4: 0000000000771ee0
[   42.745893][ T4208] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.745893][ T4208] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.745894][ T4208] PKRU: 55555554
[   42.745894][ T4208] Call Trace:
[   42.745896][ T4208]  <TASK>
[   42.745898][ T4208]  ? die+0x36/0xb0
[   42.745901][ T4208]  ? do_trap+0xda/0x130
[   42.745904][ T4208]  ? __list_del_entry_valid_or_report+0xbe/0xf0
[   42.745906][ T4208]  ? do_error_trap+0x65/0xb0
[   42.745908][ T4208]  ? __list_del_entry_valid_or_report+0xbe/0xf0
[   42.745910][ T4208]  ? exc_invalid_op+0x50/0x70
[   42.745915][ T4208]  ? __list_del_entry_valid_or_report+0xbe/0xf0
[   42.745917][ T4208]  ? asm_exc_invalid_op+0x1a/0x20
[   42.745920][ T4208]  ? __list_del_entry_valid_or_report+0xbe/0xf0
[   42.745922][ T4208]  ptp_release+0x4c/0xb0
[   42.745928][ T4208]  posix_clock_release+0x28/0x70
[   42.745933][ T4208]  __fput+0xea/0x2b0
[   42.745938][ T4208]  __x64_sys_close+0x3d/0xb0
[   42.745940][ T4208]  do_syscall_64+0x3b/0xb0
[   42.745942][ T4208]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   42.745947][ T4208] RIP: 0033:0x7f28c52acc2b
[   42.745949][ T4208] Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 a3 4d f9 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 e1 4d f9 ff 8b 44
[   42.745950][ T4208] RSP: 002b:00007f28c2a9ebf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   42.745951][ T4208] RAX: ffffffffffffffda RBX: 00005629082e0920 RCX: 00007f28c52acc2b
[   42.745952][ T4208] RDX: 0000000000000062 RSI: 00005629096837d6 RDI: 0000000000000007
[   42.745952][ T4208] RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000000
[   42.745953][ T4208] R10: 0000000000000001 R11: 0000000000000293 R12: 00005629096837a0
[   42.745953][ T4208] R13: 00000000ffffffff R14: 00005629096837d0 R15: 00007fff201baa20
[   42.745954][ T4208]  </TASK>
[   42.745955][ T4208] Modules linked in: rfkill uhid vfio_iommu_type1 vfio vhost_net tun vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb intel_rapl_msr intel_rapl_common btrfs x86_pkg_temp_thermal blake2b_generic xor ipmi_ssif coretemp kvm_intel kvm irqbypass raid6_pq crct10dif_pclmul libcrc32c crc32_pclmul sd_mod crc32c_intel sg ghash_clmulni_intel nvme sha512_ssse3 nvme_core rapl ahci ast t10_pi intel_cstate libahci acpi_ipmi drm_shmem_helper mei_me crc64_rocksoft_generic intel_uncore i2c_i801 dax_hmem ioatdma crc64_rocksoft megaraid_sas ipmi_si crc64 libata drm_kms_helper mei joydev i2c_smbus dca intel_pch_thermal wmi ipmi_devintf ipmi_msghandler acpi_power_meter drm fuse ip_tables
[   42.745984][ T4208] ---[ end trace 0000000000000000 ]---
[   42.747395][ T4218] list_add corruption. prev->next should be next (ff1100011152b3f0), but was ff1100029b963010. (prev=ff11004063643010).
[   42.747406][ T4218] ------------[ cut here ]------------
[   42.747407][ T4218] kernel BUG at lib/list_debug.c:32!
[   42.747413][ T4218] invalid opcode: 0000 [#2] SMP NOPTI
[   42.747416][ T4218] CPU: 61 PID: 4218 Comm: stress-ng-dev Tainted: G      D            6.5.0-12685-gbb1445038f83 #1
[   42.747418][ T4218] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[   42.747420][ T4218] RIP: 0010:__list_add_valid_or_report+0x78/0xb0
[   42.747427][ T4218] Code: a3 ff 0f 0b 48 89 c1 48 c7 c7 c0 be 71 82 e8 9f 54 a3 ff 0f 0b 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 18 bf 71 82 e8 88 54 a3 ff <0f> 0b 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 70 bf 71 82 e8 71 54 a3
[   42.747429][ T4218] RSP: 0018:ffa000000fdffc28 EFLAGS: 00010246
[   42.747431][ T4218] RAX: 0000000000000075 RBX: ff11004063640000 RCX: 0000000000000000
[   42.747433][ T4218] RDX: 0000000000000000 RSI: ff11003fc335c6c0 RDI: ff11003fc335c6c0
[   42.747434][ T4218] RBP: ff1100011152b000 R08: 80000000ffff8c89 R09: 0000000000ffff10
[   42.747436][ T4218] R10: 000000000000000f R11: 000000000000000f R12: ff11004063643010
[   42.747437][ T4218] R13: ff11004063641010 R14: ff1100011152b3f0 R15: 0000000000000000
[   42.747439][ T4218] FS:  00007f28c129d700(0000) GS:ff11003fc3340000(0000) knlGS:0000000000000000
[   42.747441][ T4218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.747443][ T4218] CR2: 00007f28c129abf0 CR3: 00000001dd39e001 CR4: 0000000000771ee0
[   42.747445][ T4218] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.747446][ T4218] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.747447][ T4218] PKRU: 55555554
[   42.747448][ T4218] Call Trace:
[   42.747450][ T4218]  <TASK>
[   42.747452][ T4218]  ? die+0x36/0xb0
[   42.747456][ T4218]  ? do_trap+0xda/0x130
[   42.747458][ T4218]  ? __list_add_valid_or_report+0x78/0xb0
[   42.747461][ T4218]  ? do_error_trap+0x65/0xb0
[   42.747464][ T4218]  ? __list_add_valid_or_report+0x78/0xb0
[   42.747466][ T4218]  ? exc_invalid_op+0x50/0x70
[   42.747471][ T4218]  ? __list_add_valid_or_report+0x78/0xb0
[   42.747474][ T4218]  ? asm_exc_invalid_op+0x1a/0x20
[   42.747477][ T4218]  ? __list_add_valid_or_report+0x78/0xb0
[   42.747479][ T4218]  ? __list_add_valid_or_report+0x78/0xb0
[   42.747482][ T4218]  ptp_open+0x6a/0xb0
[   42.747487][ T4218]  posix_clock_open+0x47/0xb0
[   42.747491][ T4218]  chrdev_open+0xf7/0x270
[   42.747495][ T4218]  ? __pfx_chrdev_open+0x10/0x10
[   42.747497][ T4218]  do_dentry_open+0x200/0x4f0
[   42.747499][ T4218]  do_open+0x291/0x430
[   42.747503][ T4218]  ? open_last_lookups+0x8b/0x430
[   42.747505][ T4218]  path_openat+0x130/0x2f0
[   42.747508][ T4218]  do_filp_open+0xb3/0x170
[   42.747512][ T4218]  do_sys_openat2+0xab/0xf0
[   42.747515][ T4218]  __x64_sys_openat+0x6e/0xb0
[   42.747517][ T4218]  do_syscall_64+0x3b/0xb0
[   42.747521][ T4218]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   42.747525][ T4218] RIP: 0033:0x7f28c52ac1a4
[   42.747528][ T4218] Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
[   42.747529][ T4218] RSP: 002b:00007f28c129bac0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[   42.747531][ T4218] RAX: ffffffffffffffda RBX: 000000000ee6b280 RCX: 00007f28c52ac1a4
[   42.747533][ T4218] RDX: 0000000000040802 RSI: 00005629096837d0 RDI: 00000000ffffff9c
[   42.747534][ T4218] RBP: 00005629096837d0 R08: 0000000000000000 R09: 00007f28ac000b60
[   42.747536][ T4218] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000040802
[   42.747537][ T4218] R13: 0000000000040802 R14: 0000000000000000 R15: 00007fff201baa20
[   42.747539][ T4218]  </TASK>
[   42.747539][ T4218] Modules linked in: rfkill uhid vfio_iommu_type1 vfio vhost_net tun vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb intel_rapl_msr intel_rapl_common btrfs x86_pkg_temp_thermal blake2b_generic xor ipmi_ssif coretemp kvm_intel kvm irqbypass raid6_pq crct10dif_pclmul libcrc32c crc32_pclmul sd_mod crc32c_intel sg ghash_clmulni_intel nvme sha512_ssse3 nvme_core rapl ahci ast t10_pi intel_cstate libahci acpi_ipmi drm_shmem_helper mei_me crc64_rocksoft_generic intel_uncore i2c_i801 dax_hmem ioatdma crc64_rocksoft megaraid_sas ipmi_si crc64 libata drm_kms_helper mei joydev i2c_smbus dca intel_pch_thermal wmi ipmi_devintf ipmi_msghandler acpi_power_meter drm fuse ip_tables
[   42.747587][ T4218] ---[ end trace 0000000000000000 ]---
[   42.766845][ T4216] list_add corruption. prev->next should be next (ff1100011152b3f0), but was ff110002610fb010. (prev=ff1100026116b010).
[   42.784805][ T4210] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   42.784808][ T4210] PM: hibernation: Marking nosave pages: [mem 0x0003e000-0x0003efff]
[   42.784810][ T4210] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[   42.784813][ T4210] PM: hibernation: Marking nosave pages: [mem 0x6702e000-0x6c1fefff]
[   42.785002][ T4210] PM: hibernation: Marking nosave pages: [mem 0x6f800000-0xffffffff]
[   42.785751][  T988] 
[   42.785855][ T4210] PM: hibernation: Basic memory bitmaps created
[   42.803384][ T4210] PM: hibernation: Basic memory bitmaps freed
[   42.803908][ T4210] random: crng reseeded on system resumption
[   42.819198][ T4208] RIP: 0010:__list_del_entry_valid_or_report+0xbe/0xf0
[   42.819207][ T4208] Code: 0b 48 89 fe 48 89 c2 48 c7 c7 78 c0 71 82 e8 99 53 a3 ff 0f 0b 48 89 d1 48 c7 c7 c8 c0 71 82 48 89 f2 48 89 c6 e8 82 53 a3 ff <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00
[   42.819209][ T4208] RSP: 0018:ffa000000ef47ec0 EFLAGS: 00010246
[   42.819213][ T4208] RAX: 000000000000006d RBX: ff11000108593010 RCX: 0000000000000000
[   42.819215][ T4208] RDX: 0000000000000000 RSI: ff11001fffd9c6c0 RDI: ff11001fffd9c6c0
[   42.819217][ T4208] RBP: 0000000000000000 R08: 80000000ffff8c59 R09: 0000000000ffff10
[   42.819219][ T4208] R10: 000000000000000f R11: 000000000000000f R12: ff1100011152b000
[   42.819221][ T4208] R13: ff1100208a28ad20 R14: ff11000108fe40c0 R15: 0000000000000000
[   42.819222][ T4208] FS:  00007f28c2aa0700(0000) GS:ff11001fffd80000(0000) knlGS:0000000000000000
[   42.819224][ T4208] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.819226][ T4208] CR2: 00007f28c2a9dbf0 CR3: 00000001dd39e003 CR4: 0000000000771ee0
[   42.819227][ T4208] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.819229][ T4208] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.819230][ T4208] PKRU: 55555554
[   42.819232][ T4208] Kernel panic - not syncing: Fatal exception
[   44.547139][ T4208] Kernel Offset: disabled



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


