Return-Path: <netdev+bounces-153861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2859F9DDB
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 02:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099E2188EFEC
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C5741229;
	Sat, 21 Dec 2024 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcoyZn+G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8C25765
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734746083; cv=none; b=u1tw08zhxE6l/9vM72uElLph7jx2AqJvjoytF4JwTI5bLuRGNcrEgmi60sjGPESyVA7EAm+t8gOvrEhHwGvTdeH432ptMmqUt3vW2MmQ5fZ/O96OC97hQlBQeEzxlG8y8X7pQs6HeZM8BCNpC1gmefgYIs33n1bqsmJYJkKGHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734746083; c=relaxed/simple;
	bh=oMjl6V2bEKyzo5TJlnDkh03pnMhR7pZsYgKCMUNJuMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gWTCzH3IgqeEHfj7SaEz9M+6gPGuSjV5TXikgk9hB0IUwSirvNVP8h2CNO603qXVUwr2mPgxecKuOpRjN1bb5eGTdGEf4X7JUAfG67X1etN/MyPNrkMNGQIOJIgmhmWE9qzEjNCN8iNUQTvtuxynwlmY1qaZWd5hz/xXUMTm480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcoyZn+G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734746082; x=1766282082;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oMjl6V2bEKyzo5TJlnDkh03pnMhR7pZsYgKCMUNJuMg=;
  b=HcoyZn+Gi3B2Q2oBRWrl+9qGLOpZR8Z+ZOfWdK05NepfWGGlXmbe6I2g
   J3fv9u7VvWRx37Tq7KHxpXbKF8C5bsLiyju7RmY49BzpOFT09Xh45V59G
   Ww/M39CHRoFCtV5PrHdKrjR6Yx0Hyi0/sWfDNx2EF2SVAKQtMDaAAgq8f
   zU6eI/bBhVGcBB+WKvIyBtJjVLmJSz+7VkgVW63H56ITcmVs466cgd+wR
   N7tw/2YtviGVpW0p8F+uZZ4/ZSoFmf9574t9zy8Y3cy4e6YJkjVyEoUth
   aXcESLqiW7QV1Ze4qHt7ZO3bOMIiNV1yT6w64E0zG9pirAMLDaUx+p+Ks
   w==;
X-CSE-ConnectionGUID: udNFkvJWQ+WFAxL3U15tBg==
X-CSE-MsgGUID: +FYw2kF1Ssu1UXbhfdAVmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="38985227"
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="38985227"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 17:54:42 -0800
X-CSE-ConnectionGUID: CFAIdyGTQCKZMzDN2bbkFQ==
X-CSE-MsgGUID: V5x98TszRqW0sA8j5WVKcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,252,1728975600"; 
   d="scan'208";a="98474690"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Dec 2024 17:54:39 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOohR-0001qt-2p;
	Sat, 21 Dec 2024 01:54:37 +0000
Date: Sat, 21 Dec 2024 09:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: kernel@openeuler.org, "David S. Miller" <davem@davemloft.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: [openeuler:openEuler-1.0-LTS 1334/1334] net/core/sock.c:2813:33:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <202412210915.kToB6vsf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://gitee.com/openeuler/kernel.git openEuler-1.0-LTS
head:   02951ceaa6d546dfa0f741f52f6d47e0fb0ac7b4
commit: e6476c21447c4b17c47e476aade6facf050f31e8 [1334/1334] net: remove bogus RCU annotations on socket.wq
config: x86_64-randconfig-r112-20241218 (https://download.01.org/0day-ci/archive/20241221/202412210915.kToB6vsf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412210915.kToB6vsf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210915.kToB6vsf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/sock.c:2813:33: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct socket_wq [noderef] __rcu *sk_wq @@     got struct socket_wq *wq @@
   net/core/sock.c:2813:33: sparse:     expected struct socket_wq [noderef] __rcu *sk_wq
   net/core/sock.c:2813:33: sparse:     got struct socket_wq *wq
   net/core/sock.c:1799:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:1803:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:2922:6: sparse: sparse: context imbalance in 'lock_sock_fast' - different lock contexts for basic block
   net/core/sock.c:3397:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3409:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
   net/core/sock.o: warning: objtool: sock_warn_obsolete_bsdism()+0x31: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_mc_loop()+0x91: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_set_memalloc()+0x76: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: proto_register()+0x548: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: __sk_destruct()+0xd3: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: skb_set_owner_w()+0xf1: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: __sk_dst_check()+0xa2: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_common_release()+0x1c2: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: trace_sock_exceed_buf_limit()+0xf4: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_clear_memalloc()+0x7c: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: trace_sock_rcvqueue_full()+0xe6: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_def_wakeup()+0x10e: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_dst_check()+0x179: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_clone_lock()+0x92f: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_def_error_report()+0x14d: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_def_readable()+0x14d: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_alloc()+0x868: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sk_send_sigurg()+0x16f: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_def_write_space()+0x36c: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_setsockopt()+0xeb0: sibling call from callable instruction with modified stack frame
   net/core/sock.o: warning: objtool: sock_getsockopt()+0xab1: sibling call from callable instruction with modified stack frame

vim +2813 net/core/sock.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2795  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2796  void sock_init_data(struct socket *sock, struct sock *sk)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2797  {
581319c58600b5 Paolo Abeni       2017-03-09  2798  	sk_init_common(sk);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2799  	sk->sk_send_head	=	NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2800  
99767f278ccf74 Kees Cook         2017-10-16  2801  	timer_setup(&sk->sk_timer, NULL, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2802  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2803  	sk->sk_allocation	=	GFP_KERNEL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2804  	sk->sk_rcvbuf		=	sysctl_rmem_default;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2805  	sk->sk_sndbuf		=	sysctl_wmem_default;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2806  	sk->sk_state		=	TCP_CLOSE;
972692e0db9b0a David S. Miller   2008-06-17  2807  	sk_set_socket(sk, sock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2808  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2809  	sock_set_flag(sk, SOCK_ZAPPED);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2810  
e71a4783aae059 Stephen Hemminger 2007-04-10  2811  	if (sock) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2812  		sk->sk_type	=	sock->type;
43815482370c51 Eric Dumazet      2010-04-29 @2813  		sk->sk_wq	=	sock->wq;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2814  		sock->sk	=	sk;
86741ec25462e4 Lorenzo Colitti   2016-11-04  2815  		sk->sk_uid	=	SOCK_INODE(sock)->i_uid;
86741ec25462e4 Lorenzo Colitti   2016-11-04  2816  	} else {
43815482370c51 Eric Dumazet      2010-04-29  2817  		sk->sk_wq	=	NULL;
86741ec25462e4 Lorenzo Colitti   2016-11-04  2818  		sk->sk_uid	=	make_kuid(sock_net(sk)->user_ns, 0);
86741ec25462e4 Lorenzo Colitti   2016-11-04  2819  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2820  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2821  	rwlock_init(&sk->sk_callback_lock);
cdfbabfb2f0ce9 David Howells     2017-03-09  2822  	if (sk->sk_kern_sock)
cdfbabfb2f0ce9 David Howells     2017-03-09  2823  		lockdep_set_class_and_name(
cdfbabfb2f0ce9 David Howells     2017-03-09  2824  			&sk->sk_callback_lock,
cdfbabfb2f0ce9 David Howells     2017-03-09  2825  			af_kern_callback_keys + sk->sk_family,
cdfbabfb2f0ce9 David Howells     2017-03-09  2826  			af_family_kern_clock_key_strings[sk->sk_family]);
cdfbabfb2f0ce9 David Howells     2017-03-09  2827  	else
cdfbabfb2f0ce9 David Howells     2017-03-09  2828  		lockdep_set_class_and_name(
cdfbabfb2f0ce9 David Howells     2017-03-09  2829  			&sk->sk_callback_lock,
443aef0eddfa44 Peter Zijlstra    2007-07-19  2830  			af_callback_keys + sk->sk_family,
443aef0eddfa44 Peter Zijlstra    2007-07-19  2831  			af_family_clock_key_strings[sk->sk_family]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2832  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2833  	sk->sk_state_change	=	sock_def_wakeup;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2834  	sk->sk_data_ready	=	sock_def_readable;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2835  	sk->sk_write_space	=	sock_def_write_space;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2836  	sk->sk_error_report	=	sock_def_error_report;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2837  	sk->sk_destruct		=	sock_def_destruct;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2838  
5640f7685831e0 Eric Dumazet      2012-09-23  2839  	sk->sk_frag.page	=	NULL;
5640f7685831e0 Eric Dumazet      2012-09-23  2840  	sk->sk_frag.offset	=	0;
ef64a54f6e5581 Pavel Emelyanov   2012-02-21  2841  	sk->sk_peek_off		=	-1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2842  
109f6e39fa07c4 Eric W. Biederman 2010-06-13  2843  	sk->sk_peer_pid 	=	NULL;
109f6e39fa07c4 Eric W. Biederman 2010-06-13  2844  	sk->sk_peer_cred	=	NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2845  	sk->sk_write_pending	=	0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2846  	sk->sk_rcvlowat		=	1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2847  	sk->sk_rcvtimeo		=	MAX_SCHEDULE_TIMEOUT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2848  	sk->sk_sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2849  
6c7c98bad4883a Paolo Abeni       2017-03-30  2850  	sk->sk_stamp = SK_DEFAULT_STAMP;
52267790ef52d7 Willem de Bruijn  2017-08-03  2851  	atomic_set(&sk->sk_zckey, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2852  

:::::: The code at line 2813 was first introduced by commit
:::::: 43815482370c510c569fd18edb57afcb0fa8cab6 net: sock_def_readable() and friends RCU conversion

:::::: TO: Eric Dumazet <eric.dumazet@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

