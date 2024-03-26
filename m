Return-Path: <netdev+bounces-81973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74A88BFC3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDD1F36E0D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D123B1;
	Tue, 26 Mar 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI9T0R6u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A13DAC02
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449721; cv=none; b=IIH8HLsMwLmu96J7yGivOXjdCD1AAaZWL8vX72fZYFCIzqK4x8KHLBtd0xBO2b5Rbx0JvIpkc+41evBb+WtEmQcaq8KphrgAZNivEalwZl7XtT5zUeidQwsqxV7d11ktlVsApOQtt08j4tdgc9WwXHIXMNpZww4ezhTrs7Ve7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449721; c=relaxed/simple;
	bh=V0xlVSPY1eZM/K/aJRiwX1434ypYi8e5VdyelvGCwYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsVHFimk4WI9VoJTGPKIa2QkAXMyvXnE3uT78F7j+CRyfXfSsOpb0j6H5/s93oE+I0LnpZhiHgWHAEgqU+ZhDrL/m6/rr+eqnK1Y3r0K5t9SbgmhpMxGF5fLIzrhiAglwuRyv4YPetV9TyedbVD9zgMTxiDk0C7KPQZ4RZPLyRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI9T0R6u; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449719; x=1742985719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V0xlVSPY1eZM/K/aJRiwX1434ypYi8e5VdyelvGCwYw=;
  b=HI9T0R6upCuFwXgf8NNaVIz7eW1bODXV/VWt3DzOvvyNyr4V3vO+oUSu
   /TH/tjmANmVgLSysgqssUHur1xaUkuF79plba6qlaIE4gFRpK1p7yYvgZ
   1StdD94hO+ctckdXC44sdcPP/y3D83D4lxhul+WhZmxvBZzXvX0KF6Zyg
   8ND6XUyp03alvPZ4D594Ru1UKFzf0UfOyWS7Onsgqt2J+bCwrl94IvW9a
   Sp2wgLUlCEIqHFCxJCo6RbRI5v4IsTkXg5Jza4XxXSL0NQm0yhsybovxm
   iFCxQ/IwBPLf6lrAp5acKabqCq4dKi+Z7FN4pCelFjdKk7jsxdnBF89V4
   Q==;
X-CSE-ConnectionGUID: I+YdFdbDTCGmUHw5ul7aiA==
X-CSE-MsgGUID: 0Lk8KiD2Rq2zyImThlRqOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="31929309"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="31929309"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20476262"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2024 03:41:55 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rp4Fd-000NJC-0b;
	Tue, 26 Mar 2024 10:41:53 +0000
Date: Tue, 26 Mar 2024 18:41:30 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only
 wildcard and v4-mapped-v6 non-wildcard addresses.
Message-ID: <202403261847.wj7EwLat-lkp@intel.com>
References: <20240325181923.48769-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325181923.48769-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp-Fix-bind-regression-for-v6-only-wildcard-and-v4-mapped-v6-non-wildcard-addresses/20240326-024257
base:   net/main
patch link:    https://lore.kernel.org/r/20240325181923.48769-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240326/202403261847.wj7EwLat-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403261847.wj7EwLat-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403261847.wj7EwLat-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/inet_sock.h:22,
                    from include/net/inet_connection_sock.h:21,
                    from net/ipv4/inet_connection_sock.c:15:
   net/ipv4/inet_connection_sock.c: In function '__inet_bhash2_conflict':
>> include/net/sock.h:375:37: error: 'const struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
     375 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
         |                                     ^~~~~~~~~~~~~~~~
   net/ipv4/inet_connection_sock.c:207:66: note: in expansion of macro 'sk_v6_rcv_saddr'
     207 |             (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
         |                                                                  ^~~~~~~~~~~~~~~


vim +375 include/net/sock.h

4dc6dc7162c08b Eric Dumazet             2009-07-15  354  
68835aba4d9b74 Eric Dumazet             2010-11-30  355  #define sk_dontcopy_begin	__sk_common.skc_dontcopy_begin
68835aba4d9b74 Eric Dumazet             2010-11-30  356  #define sk_dontcopy_end		__sk_common.skc_dontcopy_end
4dc6dc7162c08b Eric Dumazet             2009-07-15  357  #define sk_hash			__sk_common.skc_hash
5080546682bae3 Eric Dumazet             2013-10-02  358  #define sk_portpair		__sk_common.skc_portpair
05dbc7b59481ca Eric Dumazet             2013-10-03  359  #define sk_num			__sk_common.skc_num
05dbc7b59481ca Eric Dumazet             2013-10-03  360  #define sk_dport		__sk_common.skc_dport
5080546682bae3 Eric Dumazet             2013-10-02  361  #define sk_addrpair		__sk_common.skc_addrpair
5080546682bae3 Eric Dumazet             2013-10-02  362  #define sk_daddr		__sk_common.skc_daddr
5080546682bae3 Eric Dumazet             2013-10-02  363  #define sk_rcv_saddr		__sk_common.skc_rcv_saddr
^1da177e4c3f41 Linus Torvalds           2005-04-16  364  #define sk_family		__sk_common.skc_family
^1da177e4c3f41 Linus Torvalds           2005-04-16  365  #define sk_state		__sk_common.skc_state
^1da177e4c3f41 Linus Torvalds           2005-04-16  366  #define sk_reuse		__sk_common.skc_reuse
055dc21a1d1d21 Tom Herbert              2013-01-22  367  #define sk_reuseport		__sk_common.skc_reuseport
9fe516ba3fb29b Eric Dumazet             2014-06-27  368  #define sk_ipv6only		__sk_common.skc_ipv6only
26abe14379f8e2 Eric W. Biederman        2015-05-08  369  #define sk_net_refcnt		__sk_common.skc_net_refcnt
^1da177e4c3f41 Linus Torvalds           2005-04-16  370  #define sk_bound_dev_if		__sk_common.skc_bound_dev_if
^1da177e4c3f41 Linus Torvalds           2005-04-16  371  #define sk_bind_node		__sk_common.skc_bind_node
8feaf0c0a5488b Arnaldo Carvalho de Melo 2005-08-09  372  #define sk_prot			__sk_common.skc_prot
07feaebfcc10cd Eric W. Biederman        2007-09-12  373  #define sk_net			__sk_common.skc_net
efe4208f47f907 Eric Dumazet             2013-10-03  374  #define sk_v6_daddr		__sk_common.skc_v6_daddr
efe4208f47f907 Eric Dumazet             2013-10-03 @375  #define sk_v6_rcv_saddr	__sk_common.skc_v6_rcv_saddr
33cf7c90fe2f97 Eric Dumazet             2015-03-11  376  #define sk_cookie		__sk_common.skc_cookie
70da268b569d32 Eric Dumazet             2015-10-08  377  #define sk_incoming_cpu		__sk_common.skc_incoming_cpu
8e5eb54d303b7c Eric Dumazet             2015-10-08  378  #define sk_flags		__sk_common.skc_flags
ed53d0ab761f5c Eric Dumazet             2015-10-08  379  #define sk_rxhash		__sk_common.skc_rxhash
efe4208f47f907 Eric Dumazet             2013-10-03  380  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  381  	__cacheline_group_begin(sock_write_rx);
43f51df4172955 Eric Dumazet             2021-11-15  382  
9115e8cd2a0c6e Eric Dumazet             2016-12-03  383  	atomic_t		sk_drops;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  384  	__s32			sk_peek_off;
9115e8cd2a0c6e Eric Dumazet             2016-12-03  385  	struct sk_buff_head	sk_error_queue;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  386  	struct sk_buff_head	sk_receive_queue;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  387  	/*
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  388  	 * The backlog queue is special, it is always used with
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  389  	 * the per-socket spinlock held and requires low latency
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  390  	 * access. Therefore we special case it's implementation.
b178bb3dfc30d9 Eric Dumazet             2010-11-16  391  	 * Note : rmem_alloc is in this structure to fill a hole
b178bb3dfc30d9 Eric Dumazet             2010-11-16  392  	 * on 64bit arches, not because its logically part of
b178bb3dfc30d9 Eric Dumazet             2010-11-16  393  	 * backlog.
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  394  	 */
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  395  	struct {
b178bb3dfc30d9 Eric Dumazet             2010-11-16  396  		atomic_t	rmem_alloc;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  397  		int		len;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  398  		struct sk_buff	*head;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  399  		struct sk_buff	*tail;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  400  	} sk_backlog;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  401  #define sk_rmem_alloc sk_backlog.rmem_alloc
2c8c56e15df3d4 Eric Dumazet             2014-11-11  402  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  403  	__cacheline_group_end(sock_write_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  404  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  405  	__cacheline_group_begin(sock_read_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  406  	/* early demux fields */
5d4cc87414c5d1 Eric Dumazet             2024-02-16  407  	struct dst_entry __rcu	*sk_rx_dst;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  408  	int			sk_rx_dst_ifindex;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  409  	u32			sk_rx_dst_cookie;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  410  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

