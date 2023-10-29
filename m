Return-Path: <netdev+bounces-45074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EB7DAC58
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 13:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C7A281648
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70DCA4E;
	Sun, 29 Oct 2023 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+nUw8y2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05163C7
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 12:12:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6723BE
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698581523; x=1730117523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H+kW9Ki+BwZeghYgj2xo4sHat2QYvSgk+7Mao8P//Os=;
  b=a+nUw8y2itfxWntYoIFTzr5mJ3axi8WPFxah7bTu7+pM/OrCcWyr/3mK
   FQmvryNhjtpIsYD8j83LeM8zRxufOIHNV9JIcJwsVr+WLWUgaw9NsnwrI
   io78flLJJOy8ZwnOYS+rE/3mYKCJcD8xdyg0GFZNv/j6BqC8DesKpc6D4
   cHDzFTzhXvCCArQaq1iiABrTRIGCmaJKyMQXPTvX45pJjovw1gGv+uWpp
   /mImoAG/nRALKsRm1QsGJ0X3YBDR0YkHaTV0cFmfFnfTJi7L8FXiCEd5G
   GdxQ61Wz3af8vu5+qLoECMsWrZPg4rdIn13/ou7yo9K7ZEJHcZ+ErjKgI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="452200333"
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="452200333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 05:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,261,1694761200"; 
   d="scan'208";a="1230522"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2023 05:11:22 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qx4e5-000CY7-0G;
	Sun, 29 Oct 2023 12:11:57 +0000
Date: Sun, 29 Oct 2023 20:11:20 +0800
From: kernel test robot <lkp@intel.com>
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	Pradeep Nemavat <pnemavat@google.com>,
	Coco Li <lixiaoyan@google.com>
Subject: Re: [PATCH v5 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
Message-ID: <202310291919.kni6w2ii-lkp@intel.com>
References: <20231029075244.2612089-4-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029075244.2612089-4-lixiaoyan@google.com>

Hi Coco,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Coco-Li/Documentations-Analyze-heavily-used-Networking-related-structs/20231029-172902
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231029075244.2612089-4-lixiaoyan%40google.com
patch subject: [PATCH v5 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast path variables
config: riscv-randconfig-002-20231029 (https://download.01.org/0day-ci/archive/20231029/202310291919.kni6w2ii-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310291919.kni6w2ii-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310291919.kni6w2ii-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/net_namespace.c: In function 'netns_ipv4_struct_check':
   net/core/net_namespace.c:1127:9: error: expected expression before '/' token
    1127 |         / TXRX readonly hotpath cache lines */
         |         ^
   net/core/net_namespace.c: At top level:
>> net/core/net_namespace.c:1102:20: warning: 'netns_ipv4_struct_check' defined but not used [-Wunused-function]
    1102 | static void __init netns_ipv4_struct_check(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/netns_ipv4_struct_check +1102 net/core/net_namespace.c

  1101	
> 1102	static void __init netns_ipv4_struct_check(void)
  1103	{
  1104		/* TX readonly hotpath cache lines */
  1105		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1106					      sysctl_tcp_early_retrans);
  1107		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1108					      sysctl_tcp_tso_win_divisor);
  1109		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1110					      sysctl_tcp_tso_rtt_log);
  1111		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1112					      sysctl_tcp_autocorking);
  1113		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1114					      sysctl_tcp_min_snd_mss);
  1115		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1116					      sysctl_tcp_notsent_lowat);
  1117		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1118					      sysctl_tcp_limit_output_bytes);
  1119		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1120					      sysctl_tcp_min_rtt_wlen);
  1121		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1122					      sysctl_tcp_wmem);
  1123		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
  1124					      sysctl_ip_fwd_use_pmtu);
  1125		CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_tx, 33);
  1126	
> 1127		/ TXRX readonly hotpath cache lines */
  1128		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_txrx,
  1129					      sysctl_tcp_moderate_rcvbuf);
  1130		CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_txrx, 1);
  1131	
  1132		/* RX readonly hotpath cache line */
  1133		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
  1134					      sysctl_ip_early_demux);
  1135		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
  1136					      sysctl_tcp_early_demux);
  1137		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
  1138					      sysctl_tcp_reordering);
  1139		CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
  1140					      sysctl_tcp_rmem);
  1141		CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 18);
  1142	}
  1143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

