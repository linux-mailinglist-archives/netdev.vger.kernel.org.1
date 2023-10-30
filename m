Return-Path: <netdev+bounces-45263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8077DBC0C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA017281412
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353C17981;
	Mon, 30 Oct 2023 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4gEaPQz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96B12E5A
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:46:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4ADC6
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698677179; x=1730213179;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/DvCn/4whddg/gc4zkCyRUcJmB+z0Nh2Nt3BTWvcTNE=;
  b=P4gEaPQzx8w7S6+cb4BlKKE1pobP/Q81m+mDHGrh3QyyYNF6tSlEp51f
   aSOlIg7oyK/IZZyW1lUfqe5Q9Syk6HjTME+vgLVKTOFqvfpDZVnXAeRbq
   Hkitu5o88PTuAu/J5Bh1QOsBELXAAWhS1b4jk4mZDqlIRC++mByT9Y/78
   cucpnYaoEiN78ltyLNqor1qU3KLQ77Sm3m1W2ouRg4EGM3YJLNxOtyNq6
   zb251I2Rd2cQkXVPMtfpIg0JbqtJptLLgPvcwGEUUSlRddR3tcNjmtO5W
   k3IeNf5Pro50QhnkZdUf48tbIKZmjohfB6g+iFoGlZPseBBkXx6sGl0wx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452340709"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="452340709"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 07:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1528928"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 07:46:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 07:46:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 07:46:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 07:46:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 07:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcI7ZJMEYWfMN0bIL9sZNaS/OumRn1f0OSoO/Qv1oKG7RvC6aHqtJzM2fxpR2FfQpkxL04koRVv9h0j//6TyPJD2Ry9edHZ3qCDC769K1jvsABw150vQ4ruorT5KjGeQs6h7f52L/MHPejBzgAgeMp92Rk7yMkRzMs1zIp6u/FqbGRalHU/Vg0nGWGZfa+bXfwDTs0jRc3Q+eIBAR+6YdiMw7A/1mTvVK/M9f7gGI1PU3QYk3wZtsZ1ILvhrA6WrAcJN6jeJSHVERvZfLSHfjvC5CIBQy11s1QhzauV0OrujVKRScEAMGOZ4W62xCnaXX9xFPyhPksSCestwqKdcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bgBPy0gWFiknXx2JW7yN6XHv4oOS8rBD8N4nKEKfK8=;
 b=oDtLFKVmy0rMdm2V/poTlp7+ZoZvCBb4qgxRRjNynVun5G8S8jEU79dE7g+zytZRh6bfDdtGIgmXMk7MZ6naDix88WZ3xiOKb0ynkao+UiEzv9J3KZVpsV4qr6eBp7if+YErhPx+NvK2nSZY3eZgGJxda4KrI13kM0Y+rOFGn8AOz3uT4lizSGEL6MiyB27KoJ7FGpvXAasptUE7zXJ2iKY4ull7n2picdIAkfTOF5HhlTrkS87wU5PkLTrZTyLdYnnHS1pDZiH2uNMW5tid4yxlwAcVoBYmGiPKPvPOZQmckZ4jyHE6MUlQOQJB55PDy+AKkG1I5Bb91PImWBtoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 14:46:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 14:46:13 +0000
Date: Mon, 30 Oct 2023 22:46:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, "David S. Miller" <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [tcp]  614e8316aa:
 packetdrill.packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps_ipv4-mapped-v6.fail
Message-ID: <202310302216.f79d78bc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb607b6-84f5-4077-189b-08dbd956f6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIZJc+Jb+1uqy6YqlSKeydD1wdMFO2uNMEZsKS1Dp7JuNcODcpQMSZtWau8kpbsIZH/plqROYm1Rh2SG2j1fPu2dZHeWd8CK0Zvj8r4BmF8mE+TRx0clJzXecKOvqj3AhqM+Lu+/E8C7FqJtGYimLjrebpTmUmChyw6Tk6ZjPFaLx249pqCEtHo7+NdXN2WIXKRWH5ryn9dTt7RT3XWTz4TabIt/dzw+sDW4d3hEQkl5NbuSScvXjMP7IUoFv9olA9QV548m+H+c1iB32JVZcDP24f1maC0HrXQx1pybGC4gqzuSvl1JhAanaIu632ZL67FB868BzlYUT3KwRuMH3fSbxMKAOOtH2jlMT6aQ1MApDH0wAhzX9P5jqzEEtyxbUEBmn+srAlK1J7W1o+RdoF14uLa/TmaOns+6tzEL9f5nKUYFkOLNtQ9A+qPBXBbqhXe61D8REBCgyjpdnE9LVMs9DJyIKa3ogeQfxuwNkFjsn+18D1PgZQm6N01VfbwEyg8mi40c01ltPOWLNjAWORyVw2KI17SVqo1vx4G5CYY5pwxw28zbZsJMCafAELx1uexS0iB6+66p/HNq7w2ACg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66556008)(66476007)(6916009)(54906003)(82960400001)(316002)(38100700002)(6666004)(6506007)(6486002)(6512007)(478600001)(966005)(2616005)(83380400001)(66946007)(1076003)(107886003)(26005)(5660300002)(41300700001)(2906002)(8676002)(8936002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LbmWMp1ezqhK6zSTA7l2vZ5NsEP/RFdQcxgkolHWpsnWT+gJX1EMsGL4ZmVV?=
 =?us-ascii?Q?W9dGpxt9VzURX79wpvwP1t0QFE07sPnE9WT1LKGS//8CwmUKp4tn5oDk33qi?=
 =?us-ascii?Q?KJ6IBalhfWo19ZtcsoG1OECuwf2pMsPBb7/byz5PrFSw30CetNOTDzqU3h33?=
 =?us-ascii?Q?JkTu6Kz9m3RCFYg8iA8ku+DXcNZbgsJI4j4pe6FEX5qijdLVq0R2RSeBLYup?=
 =?us-ascii?Q?uvCY7Z826zRipKHvgy5zPzwZe1p5n6vTwoJxg9OQldymdfGKFABgBK3n2E4Y?=
 =?us-ascii?Q?9LteBj7pkp7AXxy72ujYNSFrMhym2TwGN8+dyFo0sHqp4xdM63UGc+oXcLG1?=
 =?us-ascii?Q?9kKXLGpbF7rxfyNs8wFOF6baw4eNaUu1FqQcINhf0vsZ3Txa4qWx9w5F3Rni?=
 =?us-ascii?Q?rTbo28032o+IhcHFTWviCWBkDwQFzcPYIXg/oj24Cp36g7+ziB7Sxo+KCp8r?=
 =?us-ascii?Q?kP2sY52PPRG211+Yn5QVCIHTGTMjIivJZnCcRvUewiAXqjrmzLT33lUpyBad?=
 =?us-ascii?Q?Wl7foRrqTX17ggzYmCadkCIT82wE6UCxjMaOFKYnlt4SWiR/aU8pBWFj1RYw?=
 =?us-ascii?Q?66YHJ7Tnr13w1zV0DrXyhpjKfHE/POtAX54zUDLPcYS9tv7gNmkKnnJsEGrs?=
 =?us-ascii?Q?oXjDEZBUTl/fhnvtjQyi26x0bkAyPn6SHWg1Yg3JfdrOb3/xjkDikMIu8V9n?=
 =?us-ascii?Q?ub1WxqwJM/HRfMS39ZX2JkqhViI59FyeYa+FoSY2wV4XmTUtV+PAnotnacEI?=
 =?us-ascii?Q?jJFnHHqVYxRsKd7M9mqAcLSgoLGajuT5G8IzQP8IHe7S8YuxQ4V1ke4+71yP?=
 =?us-ascii?Q?i/1MNqjGbDJ594TSP44ucRqJhRYccuZBYuaE4GhJ+kfmXtWl4M/Z+A57T+4K?=
 =?us-ascii?Q?hHawIaz1S9UcXcDvhzSdQZa5dLaWtowd0KPukVchS9ziXQvt1wEo0jABU+pI?=
 =?us-ascii?Q?0/yy22d/X01KInyhq1/1iRW11V0+10fery5tMleinYRlQRQjFP/+U+K4efbY?=
 =?us-ascii?Q?9uRZy1XI1p0I8ZHkxWt9Q+QjBuHUz0Ow1U5QeOsR1uEgIS6OWndRF/gQWHBj?=
 =?us-ascii?Q?k8UbTpiSwuEH0TzjgVbGIFn1L9luc/Q81DwGr6H4O4MS8edPEqtheD+GB027?=
 =?us-ascii?Q?Cwu3uxi3N7QrjYgBecvS+UL/QHHmIFO+B6cM3fkvshcro72ei8UpRHFvJG0G?=
 =?us-ascii?Q?NiPrv9pM9Ig0INQEthXXoMMiRxuvGRbbXxe9POWGCO2elkpTtiQ4IWN/GWi0?=
 =?us-ascii?Q?vf75swYz26Awj0xkKLMBaItnSZfxOlgz4BM9guBAtGPSkJd4J/1NY1iOC0ZO?=
 =?us-ascii?Q?kTR0sb5+lj9qdybkxNJ3NwR1qPahHrMaWSTmeyOww3yhGReP2OSR7awXkQLo?=
 =?us-ascii?Q?LnPv5lzLDPBdnZ/qB7u6qiwHK9j/sOWu0rcKj1Rh9WbP7Vckt2wHpsaEKpbd?=
 =?us-ascii?Q?eXdVz5H9/DzakZX7t4lBULZWYGE+CUUjV9fccQR8s/qrLLdtUrtTz4GWILS8?=
 =?us-ascii?Q?zN6syHbA/jf34QC2SR3IhznGb8mkF9P3KF/DRn63UUAU5/UiNqLU4SNBVCR+?=
 =?us-ascii?Q?dhSmQy+aWQbu3dXXVuJkyznKgMfj+DbyboZRs9G3e4Evq0H8kaTKkEQee0lC?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb607b6-84f5-4077-189b-08dbd956f6cd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 14:46:13.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6mHJGV6NCkozesJYzyNOI6YSQDoBLJMRWLpPQgyy0b9Y51n6VAxSxigqNgKHNXK5tbG18xbZYuclTWd24tdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps_ipv4-mapped-v6.fail" on:

(in fact, we noticed 3 tests failed on this commit with high rate, but keep
clean on parent

af7721448a609d19 614e8316aa4cafba3e204cb8ee4
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          55%          11:20    packetdrill.packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps_ipv4-mapped-v6.fail
           :20          70%          14:20    packetdrill.packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps_ipv4.fail
           :20          45%           9:20    packetdrill.packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps_ipv6.fail
)

commit: 614e8316aa4cafba3e204cb8ee48bd12b92f3d93 ("tcp: add support for usec resolution in TCP TS values")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 66f1e1ea3548378ff6387b1ce0b40955d54e86aa]

in testcase: packetdrill
version: packetdrill-x86_64-31fbbb7-1_20231004
with following parameters:


compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310302216.f79d78bc-oliver.sang@intel.com


...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv6)]

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv4-mapped-v6)]

...

FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv4)]

...



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231030/202310302216.f79d78bc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


