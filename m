Return-Path: <netdev+bounces-42906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7387D0944
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D806D2823AA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E97D2E0;
	Fri, 20 Oct 2023 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4Jgk+IU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A508D2E2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 07:17:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446ECA
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697786276; x=1729322276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0oRDiagamgOL9wMm0f0sqWfuKq4kagxbAnKCq+LxefQ=;
  b=D4Jgk+IUs25QT0EYNgIzvaaGxVg80j6PGd6Y09LCQJyhlTFuBKm2gdO+
   EUduOz8D2G3K7ED/631GpHpJ4RH6ZyJ5jKhWtwIyCDnhUpQ+rF3iuacTi
   iBXpjWivJsuYmMje3iPucAwN4RS1sDr+xk/xGIb/FqGQyc0aVIHVy9Zzm
   +nqbYm8e3TH3MEiPTlVz+1UqlJqWS/GXbQFaAHLc2djfWfT7u/VBiq9U1
   p3O2cU8x4Y8rh7rss8IUT46uFHu4UeXw+lurklnoBnJ6qp3CawVvUy8PC
   pGaSA0Xnp+O+ucFVrox4T8iOORRXdSRwSNVbuk/Y82xCk0wV5sej6Ji8t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366677773"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366677773"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 00:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="847998424"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="847998424"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 00:17:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 00:17:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 00:17:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 00:17:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g10mwkEOt+jDZjc3++ElF6vYTD6CqZhlOrKMGAz9+8G7rOyP/Yb+H3nSHgPfs0pu38UsVZjhpKX5r4VJdGVZM5JdZWesg9d3rXldDeRiQWXuSduzpGDq3/osLLsP77NAJU99oQ74PsfroRlZroINfErfVZ2S0u8AUl36jqtyjutwiQxPrTUsE+BoZIUZA/2Cf1MzImSZoQqUGwW2W14hvrfWEH+apkPw47iYX8M65oTaCEwudiuaacd3V+4pW2i82L2P8sX970ygqa5xgCsWoU+4jTsaMQn2OHBkfZzsspmUYt1dswwuiPLwJl3sLxG1lNLcer+U48WhOcfsNPBhjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPLRWwZ3HD2Q20r76bUTEslygPGI6965gPjVgh40a84=;
 b=Ht5C5zxEZFFom3DNqhMes3CEElMjomhlLyQCz1RZPIfSLVHqVtRL0CrH5s96CkC9nyDGb5lXlLdI1VTP3Yod6zyn1CTcFkd8sbdAxa6PldDxl/wDgj5Xyh5tSZgOzy0Tia+v6isQsbPIZ9g3AXikBOxyMzU9YK7NONyhMIx3P/8gKCeUdeTqRy6lLVddHuS2XCroa8bXXrmFMnXYefzArDSunYx3Jg7Slvae3tUJg/mVigURvt9iQ7pn1a019w3Hp77q4u42KcDLA0rXzSKWPheXxjGM+zM4tcBVr34HYNCSiV94s+eM5GVc6ug/UwWaWRy0hIlkp5PdOE7RioYGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 20 Oct
 2023 07:17:52 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 07:17:51 +0000
Date: Fri, 20 Oct 2023 15:17:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Paolo Abeni <pabeni@redhat.com>, Dave Taht
	<dave.taht@gmail.com>, Willem de Bruijn <willemb@google.com>, "Soheil Hassas
 Yeganeh" <soheil@google.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, <netdev@vger.kernel.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net_sched]  29f834aa32:
 kernel-selftests.net.so_txtime.sh.fail
Message-ID: <202310201422.a22b0999-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU1PR03CA0035.apcprd03.prod.outlook.com
 (2603:1096:802:19::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5f135c-a06d-4d74-6df7-08dbd13cac0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrBtMe0XF8kdCIRNQh85DQnMCaOrXvyQu6840nNaQ4IH5r6p+KLSxXK9A+7CFw8Q86o90lju9/xCkd8nVQf88c5KqqRijxCaAaTnibR5Mjx4HZk9mK9bF/TWqDP0zl7bAyQODsKz/GH5sL8eJ6GwjeWSR7w6nO+gm6IHlNR/VqI9Pt8Obd+IyUl+GBioIrOt//iTR/suDM9I5cynFcIkqyd8tq2YYeiRA3j//nNPz1lbTE8CwYvJoWi/Bv3NC5C5lG+y6HcvDsetswOc3UkYxcIQcCPyk76wj8TSgijV3jEHr0NQNN1iOTNnAnbRZ9A5SzUw3y91Pddiv9AwCFVZH1g7J+aM8Ts4bLP/Y599wmL1K8dxUfNi0I+sLtuugdNFldPaDdzqpalehtQY0FQ9dZvXv1F9wY8SJnsdYoANDTqTQxhHXq9khgpDZwZKu73SrrSu8CtHj82ex9Og+HP1u9+TfzAx5cuzonbq1dE0EJUhXYs+V2/T3sCOt23+B6srl+/ClaD4tzoaVlwxrfH9jbdPb3mNUkwkMtS+fmDPv4/r9qwvID0buhDJcmRCleaV9O2IjdvwBgYtocCvEtr20w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(7416002)(6512007)(38100700002)(26005)(82960400001)(6916009)(6666004)(1076003)(478600001)(4326008)(8676002)(41300700001)(5660300002)(6486002)(966005)(54906003)(66476007)(2906002)(86362001)(36756003)(8936002)(66556008)(66946007)(316002)(2616005)(6506007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UE4Fo8jKEhKlmOlmC0FiJfDdvZHDpxHWA7ulUW5BmHELmXEcM8e9ezbs6pzN?=
 =?us-ascii?Q?pPUZn+Q2YP2h6yix71GEMz9zYJO0Py6QfBh23HFAcjaezq9BcCn51OKlyqNr?=
 =?us-ascii?Q?vl6yR3TDRYfIe3z8yIL7jHjL4yXUHhKF0cRMaP3IJCiymYC4uYpn8iL2I2ps?=
 =?us-ascii?Q?Pu6VyU1oTCRuVq3FXVBQYAaBcUXq2EaDcU48Z/VKLE/a1kAx+MP3kSFFQtbH?=
 =?us-ascii?Q?sEBQ18Ke5/FCfCUblAsat5MpLXzibu4LVsIA5iqD5ZsYy0nz4wBQ9eaTV6qB?=
 =?us-ascii?Q?lI0WHArriyLMZTqxHL5S85KZYGqUVz3XUTjYvGTNPKtx8jUWpbfhWAe1FklA?=
 =?us-ascii?Q?3pUtxSBNhCXgMr4gv2Atgiz0Q2sfCFFHysMjqwPGY9RKqaf8vPkwMDzYluUX?=
 =?us-ascii?Q?kggCE6OAvR5hD3rhAjeFwkiNtsEiQ3Djg4+Og/gR0K9IW51b74+k/eW84VAn?=
 =?us-ascii?Q?hIxTPCYFhntdAOyXIZUBnTKjSof+c7iZck7JCYUzZMilb9vbZhXQn9cT3ZPG?=
 =?us-ascii?Q?ES0dXB9YZqgLJ1FoKopuV5cZRerw/hBz3PaRx1GXTXCiQ6GUb9vlnaDBt5LD?=
 =?us-ascii?Q?Csfb331AxNVj2uWwRQG0gHQRm1jv/ikZqnb/lY9PC24Eh2DpbWy1zCPFnIAw?=
 =?us-ascii?Q?XRHhduZDv1psgsFqc/XJKbWKnMykac0U/EfqsNSjYAn5QDPi/bM3CePLoAY5?=
 =?us-ascii?Q?GZL2XviuOkSKnybnak5UeVszK30tgjFYvxm2CDDksMUG9ztfipLIyUiwH3Hu?=
 =?us-ascii?Q?fyPdl7fCgJxy8zruLdZnAVxzdN/OSdD8+Bax3o9w9hX+QhbXgOOLyK+txfJ0?=
 =?us-ascii?Q?KYtwd3d2J0QkcKsgBOGvi/toVfiRUKmjyXaXumZpJvsphVZOGnPuMAiRV5Zc?=
 =?us-ascii?Q?8n3mMAj8jb1rDlg+odRn/ifFeLBok/aoQdv7MM3sXfDYO5CLoewjUVT2Lqfz?=
 =?us-ascii?Q?JaidWNWrR7+vlBwjodQDd77kDPkvfgSPTGKMcOMEmTTqNkwC2h8N4nU2MWSa?=
 =?us-ascii?Q?DiuPivWjo+wm6B8Rlr9YzRF7YN/URLnP05zSKd1If6XnA0PsKgJIXYC2U6iV?=
 =?us-ascii?Q?wrj5Fx9Rj0ENozH/kOS53EzmEGWtNM8ddAswjFS7lIUe/y1zN+iZYBQDRC+q?=
 =?us-ascii?Q?/sxGQA4YNBUSP7Yrah0C2hwamuAWGGRWjC5fWjz3XCYcWrlV85RI1oadUHyH?=
 =?us-ascii?Q?vEPESZVv2DmBdw01JDWbDpwVTuwMTJ82E/ECiAd5+zO+/n5NpxyC7J3sCsdP?=
 =?us-ascii?Q?U+Yir4WCmamV7fT31v6YGUzm2AIvP/7Sw0ekCGl1yBNmAXrIS7XLJDZ/bkIP?=
 =?us-ascii?Q?fDwDimvRk3hS2HphLzifT/2A10DRpFLO9nKp1Xf0ROQfvxAVkHDvxGnPHSKN?=
 =?us-ascii?Q?y+PbMbk8iGc6PY+d0MT5aSPZLoHyh3LTuj6JbAbYqgub/fH2BFZYL30p10l/?=
 =?us-ascii?Q?zHWpbYZMytKoaKZiNUEiXF40lkeLxxHZ2gG9TAE96h2Ov58JUW0dnxg8kYGd?=
 =?us-ascii?Q?f0uku/8pZeCxh8TRgWshw7KMtZ14fFBAosLVkhfysnzc+xT5DBvLczLe204R?=
 =?us-ascii?Q?9LkZUwmVMIORpUfbphB+I0+KbHyunlEIxJ4JFS3Y8YMRUN043PkoWawIOM1T?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5f135c-a06d-4d74-6df7-08dbd13cac0e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 07:17:51.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQwXsTBRZZWCLMbR/HWkG6E/T8R3t0o+zjtqobq7GiyHuFovAy/ZUbSFszg58K1nuuXjS2TOp9lPeY1Av7OcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.net.so_txtime.sh.fail" on:

commit: 29f834aa326e659ed354c406056e94ea3d29706a ("net_sched: sch_fq: add 3 bands and WRR scheduling")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master e3b18f7200f45d66f7141136c25554ac1e82009b]

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
| Closes: https://lore.kernel.org/oe-lkp/202310201422.a22b0999-oliver.sang@intel.com


besides, we also noticed kernel-selftests.net.cmsg_time.sh.fail which does not
happen on parent.

5579ee462dfe7682 29f834aa326e659ed354c406056
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kernel-selftests.net.cmsg_time.sh.fail
           :6          100%           6:6     kernel-selftests.net.so_txtime.sh.fail



# timeout set to 1500
# selftests: net: so_txtime.sh
# 
# SO_TXTIME ipv4 clock monotonic
# payload:a delay:296 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# payload:a delay:279 expected:0 (us)
# 
# SO_TXTIME ipv6 clock monotonic
# ./so_txtime: recv: timeout: Resource temporarily unavailable
not ok 30 selftests: net: so_txtime.sh # exit=1

....

# timeout set to 1500
# selftests: net: cmsg_time.sh
#   Case UDPv4  - TXTIME abs returned '', expected 'OK'
# FAIL - 1/36 cases failed
not ok 59 selftests: net: cmsg_time.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310201422.a22b0999-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


