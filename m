Return-Path: <netdev+bounces-49368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B791E7F1D6F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C451F25A8E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5636AF7;
	Mon, 20 Nov 2023 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJI/HRGW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC736AED;
	Mon, 20 Nov 2023 19:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532A4C433C8;
	Mon, 20 Nov 2023 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700509275;
	bh=Lr3mKQ94fwm7siGM06WAsHZ8psEWqwiymuFwzRs9H0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJI/HRGWLBCNAfUdKjEafFXsUs6lQCId2SUGlEjK3LuCHq9Kmbgo5iHeFgoWXQ2S6
	 +RgeZq6OeNOlh60XpJHMsZIXlmAlEOUgLrlgCTv9TIzMDEb7JPU4WikKRSLZh8NRC2
	 qqoqn7e7S2csqdSkdHHwhYwLbM2U/56X1onLjq3DTzZ/EG2xjBcsrszP3K+xDTUNAe
	 tISdYEU3IBiklSIo+UtM21si2q287vn6eUR3BJRf8YnjKsd6FlYoE/2b4m21zVWrM2
	 DPZLBRQT/OQBkyrSBRjHxTDDP7g1+9MKS2hEO0Ebpd1xlQt3TE0+nF9ybw63PRLnOP
	 mYTf0zFcecjjg==
Date: Mon, 20 Nov 2023 12:41:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Coco Li <lixiaoyan@google.com>
Cc: kernel test robot <lkp@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>,
	Pradeep Nemavat <pnemavat@google.com>
Subject: Re: [PATCH v7 net-next 4/5] net-device: reorganize net_device fast
 path variables
Message-ID: <20231120194112.GA276812@dev-arch.thelio-3990X>
References: <20231113233301.1020992-5-lixiaoyan@google.com>
 <202311162002.m26ObVLU-lkp@intel.com>
 <CADjXwjjPrhDF3hfPWKrXxCkJjwBJDfumFkAvCPg2gvOBme2sTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADjXwjjPrhDF3hfPWKrXxCkJjwBJDfumFkAvCPg2gvOBme2sTA@mail.gmail.com>

On Fri, Nov 17, 2023 at 11:44:41AM -0800, Coco Li wrote:
> Spending some time setting up a clang17 compatible environment, will
> update soon.

In case you have not seen it, I have prebuilt LLVM toolchains available
on kernel.org that should make working in your current environment
easier:

https://mirrors.edge.kernel.org/pub/tools/llvm/

For example, I just tested with:

  $ mkdir -p $HOME/toolchains

  $ curl -LSs https://mirrors.edge.kernel.org/pub/tools/llvm/files/llvm-17.0.5-"$(uname -m)".tar.xz | tar -C $HOME/toolchains -xJf -

  $ curl -LSso .config https://download.01.org/0day-ci/archive/20231116/202311162002.m26ObVLU-lkp@intel.com/config

  $ make -skj"$(nproc)" ARCH=powerpc LLVM=$HOME/toolchains/llvm-17.0.5-"$(uname -m)"/bin/ olddefconfig net/core/dev.o
  net/core/dev.c:11547:2: error: call to '__compiletime_assert_971' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct net_device, __cacheline_group_end__net_device_read_txrx) - offsetofend(struct net_device, __cacheline_group_begin__net_device_read_txrx) > 24
   11547 |         CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 24);
         |         ^
  include/linux/cache.h:108:2: note: expanded from macro 'CACHELINE_ASSERT_GROUP_SIZE'
    108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
        |         ^
  include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
     50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
        |         ^
  include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^
  note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
  include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
    423 |         __compiletime_assert(condition, msg, prefix, suffix)
        |         ^
  include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
    416 |                         prefix ## suffix();                             \
        |                         ^
  <scratch space>:11:1: note: expanded from here
     11 | __compiletime_assert_971
        | ^
  1 error generated.

See the Kbuild documentation if you have any other questions (or just
ask me directly):

https://kernel.org/doc/html/latest/kbuild/llvm.html

Cheers,
Nathan

> On Thu, Nov 16, 2023 at 4:40 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Coco,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Coco-Li/Documentations-Analyze-heavily-used-Networking-related-structs/20231114-073648
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20231113233301.1020992-5-lixiaoyan%40google.com
> > patch subject: [PATCH v7 net-next 4/5] net-device: reorganize net_device fast path variables
> > config: powerpc-mpc8313_rdb_defconfig (https://download.01.org/0day-ci/archive/20231116/202311162002.m26ObVLU-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311162002.m26ObVLU-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311162002.m26ObVLU-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    net/core/dev.c:4079:1: warning: unused function 'sch_handle_ingress' [-Wunused-function]
> >     4079 | sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
> >          | ^
> >    net/core/dev.c:4086:1: warning: unused function 'sch_handle_egress' [-Wunused-function]
> >     4086 | sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
> >          | ^
> >    net/core/dev.c:5296:19: warning: unused function 'nf_ingress' [-Wunused-function]
> >     5296 | static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
> >          |                   ^
> > >> net/core/dev.c:11547:2: error: call to '__compiletime_assert_971' declared with 'error' attribute: BUILD_BUG_ON failed: offsetof(struct net_device, __cacheline_group_end__net_device_read_txrx) - offsetofend(struct net_device, __cacheline_group_begin__net_device_read_txrx) > 24
> >     11547 |         CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 24);
> >           |         ^
> >    include/linux/cache.h:108:2: note: expanded from macro 'CACHELINE_ASSERT_GROUP_SIZE'
> >      108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
> >          |         ^
> >    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
> >       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >          |         ^
> >    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
> >       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >          |                                     ^
> >    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> >    include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
> >      423 |         __compiletime_assert(condition, msg, prefix, suffix)
> >          |         ^
> >    include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
> >      416 |                         prefix ## suffix();                             \
> >          |                         ^
> >    <scratch space>:11:1: note: expanded from here
> >       11 | __compiletime_assert_971
> >          | ^
> >    3 warnings and 1 error generated.
> >
> >
> > vim +11547 net/core/dev.c
> >
> >  11515
> >  11516  static void __init net_dev_struct_check(void)
> >  11517  {
> >  11518          /* TX read-mostly hotpath */
> >  11519          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, priv_flags);
> >  11520          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, netdev_ops);
> >  11521          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, header_ops);
> >  11522          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, _tx);
> >  11523          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, real_num_tx_queues);
> >  11524          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_size);
> >  11525          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_ipv4_max_size);
> >  11526          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, gso_max_segs);
> >  11527          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, num_tc);
> >  11528          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, mtu);
> >  11529          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, needed_headroom);
> >  11530          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tc_to_txq);
> >  11531  #ifdef CONFIG_XPS
> >  11532          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, xps_maps);
> >  11533  #endif
> >  11534  #ifdef CONFIG_NETFILTER_EGRESS
> >  11535          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, nf_hooks_egress);
> >  11536  #endif
> >  11537  #ifdef CONFIG_NET_XGRESS
> >  11538          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tcx_egress);
> >  11539  #endif
> >  11540          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_tx, 152);
> >  11541
> >  11542          /* TXRX read-mostly hotpath */
> >  11543          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
> >  11544          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
> >  11545          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
> >  11546          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
> >  11547          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 24);
> >  11548
> >  11549          /* RX read-mostly hotpath */
> >  11550          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
> >  11551          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
> >  11552          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
> >  11553          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
> >  11554          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
> >  11555          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
> >  11556          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
> >  11557          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
> >  11558          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
> >  11559          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler_data);
> >  11560          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, nd_net);
> >  11561  #ifdef CONFIG_NETPOLL
> >  11562          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, npinfo);
> >  11563  #endif
> >  11564  #ifdef CONFIG_NET_XGRESS
> >  11565          CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
> >  11566  #endif
> >  11567          CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 96);
> >  11568  }
> >  11569
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

