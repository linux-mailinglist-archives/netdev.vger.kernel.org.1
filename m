Return-Path: <netdev+bounces-164318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2518A2D5A6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 11:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBF03A60D6
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 10:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810391B4132;
	Sat,  8 Feb 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1rPeHMO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A3D1624D0
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011306; cv=none; b=CQnwoy+iS5b+cek8H6RUfuE+Fva8SESj07RzeYJSz45Zwin0Riy3zGQeP4WDgjcwDfx2Q5CbwX3p6HBrnSUIncWDdWyOOisGahHcfpK5v3PSIF5Yvw+4/2fbXdVWb/sGsxATLLiCL8aMx8dWJVCr8j0BmNBqeVO17wG556EDXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011306; c=relaxed/simple;
	bh=MWG+6WKuPs6vj1SH93Cdkkga8aIS5/n3tbVO+NuMbIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D01AyEAHX+jKcThwZKYtlWflBYVKKM7UCHC3bSpadh9vr8fDBPkhXzceLk9qCXJFFUA3goFacAK8Ko1HknPuh+9DwEOSnWX3JTtv45UdsYX3OleGxOxi9DUJ8/R0KYjZv+mUlSvov0gqO00dI4+OiymSDKcU3sjXLcCYgTWsZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1rPeHMO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739011304; x=1770547304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MWG+6WKuPs6vj1SH93Cdkkga8aIS5/n3tbVO+NuMbIk=;
  b=I1rPeHMOgSCdgC7U++V9J+TJcIFNUOJuG2Jnr6rTZlswymIvHCthfQsb
   hhkUdwF9ulv9Rqe4W3VwCwvmQ1wf2WRYS2eRGl0zmdSu+CRwW3VxX9p5C
   kHnjpSss6w4SRdMAuOK+TXqvxFhigNmajq/03ZTMaCM8qtho3BVTv84UY
   yODYvaLCyxmtyFz6MyCvuvzoBhqpCSq0Ccc3cIHY+C7qvaUUBCosHW8K7
   jJEa7+4JmikMQBDUhr8Bqx30Aplu2iwuj+lyeqJ9ywBQhY9cuVDvFSET6
   DGQ+ddL54cuYYEJXV2z3DTapzVKktTRXtux6Wk6dB4rTkbBR3BA1Q+MX5
   w==;
X-CSE-ConnectionGUID: 7jud809vSJOV9i11n4/YkQ==
X-CSE-MsgGUID: a7NIaoklRCWkXDQp/v5KVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43570979"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; 
   d="scan'208";a="43570979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 02:41:43 -0800
X-CSE-ConnectionGUID: xNCE5HYdSH2fX+RnJcWXRQ==
X-CSE-MsgGUID: rwzju1O6RKalfAEbK8WziA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116697290"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2025 02:41:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgiHJ-000zrX-2T;
	Sat, 08 Feb 2025 10:41:37 +0000
Date: Sat, 8 Feb 2025 18:40:50 +0800
From: kernel test robot <lkp@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 5/7] icmp: reflect tos through ip cookie rather
 than updating inet_sk
Message-ID: <202502081845.hsTDUryC-lkp@intel.com>
References: <20250206193521.2285488-6-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206193521.2285488-6-willemdebruijn.kernel@gmail.com>

Hi Willem,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Willem-de-Bruijn/tcp-only-initialize-sockcm-tsflags-field/20250207-033912
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250206193521.2285488-6-willemdebruijn.kernel%40gmail.com
patch subject: [PATCH net-next 5/7] icmp: reflect tos through ip cookie rather than updating inet_sk
config: x86_64-buildonly-randconfig-002-20250207 (https://download.01.org/0day-ci/archive/20250208/202502081845.hsTDUryC-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250208/202502081845.hsTDUryC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502081845.hsTDUryC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/icmp.c:408:20: warning: variable 'inet' set but not used [-Wunused-but-set-variable]
     408 |         struct inet_sock *inet;
         |                           ^
   1 warning generated.


vim +/inet +408 net/ipv4/icmp.c

^1da177e4c3f41 Linus Torvalds         2005-04-16  395  
^1da177e4c3f41 Linus Torvalds         2005-04-16  396  /*
^1da177e4c3f41 Linus Torvalds         2005-04-16  397   *	Driving logic for building and sending ICMP messages.
^1da177e4c3f41 Linus Torvalds         2005-04-16  398   */
^1da177e4c3f41 Linus Torvalds         2005-04-16  399  
^1da177e4c3f41 Linus Torvalds         2005-04-16  400  static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
^1da177e4c3f41 Linus Torvalds         2005-04-16  401  {
^1da177e4c3f41 Linus Torvalds         2005-04-16  402  	struct ipcm_cookie ipc;
511c3f92ad5b6d Eric Dumazet           2009-06-02  403  	struct rtable *rt = skb_rtable(skb);
d8d1f30b95a635 Changli Gao            2010-06-10  404  	struct net *net = dev_net(rt->dst.dev);
8c2bd38b95f75f Eric Dumazet           2024-08-29  405  	bool apply_ratelimit = false;
77968b78242ee2 David S. Miller        2011-05-08  406  	struct flowi4 fl4;
fdc0bde90a689b Denis V. Lunev         2008-08-23  407  	struct sock *sk;
fdc0bde90a689b Denis V. Lunev         2008-08-23 @408  	struct inet_sock *inet;
35ebf65e851c6d David S. Miller        2012-06-28  409  	__be32 daddr, saddr;
e110861f86094c Lorenzo Colitti        2014-05-13  410  	u32 mark = IP4_REPLY_MARK(net, skb->mark);
c0303efeab7391 Jesper Dangaard Brouer 2017-01-09  411  	int type = icmp_param->data.icmph.type;
c0303efeab7391 Jesper Dangaard Brouer 2017-01-09  412  	int code = icmp_param->data.icmph.code;
^1da177e4c3f41 Linus Torvalds         2005-04-16  413  
91ed1e666a4ea2 Paolo Abeni            2017-08-03  414  	if (ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb))
f00c401b9b5f0a Horms                  2006-02-02  415  		return;
^1da177e4c3f41 Linus Torvalds         2005-04-16  416  
8c2bd38b95f75f Eric Dumazet           2024-08-29  417  	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  418  	local_bh_disable();
^1da177e4c3f41 Linus Torvalds         2005-04-16  419  
8c2bd38b95f75f Eric Dumazet           2024-08-29  420  	/* is global icmp_msgs_per_sec exhausted ? */
8c2bd38b95f75f Eric Dumazet           2024-08-29  421  	if (!icmpv4_global_allow(net, type, code, &apply_ratelimit))
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  422  		goto out_bh_enable;
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  423  
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  424  	sk = icmp_xmit_lock(net);
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  425  	if (!sk)
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  426  		goto out_bh_enable;
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  427  	inet = inet_sk(sk);
c0303efeab7391 Jesper Dangaard Brouer 2017-01-09  428  
^1da177e4c3f41 Linus Torvalds         2005-04-16  429  	icmp_param->data.icmph.checksum = 0;
^1da177e4c3f41 Linus Torvalds         2005-04-16  430  
351782067b6be8 Willem de Bruijn       2018-07-06  431  	ipcm_init(&ipc);
bbd17d3104f5a7 Willem de Bruijn       2025-02-06  432  	ipc.tos = ip_hdr(skb)->tos;
0da7536fb47f51 Willem de Bruijn       2020-07-01  433  	ipc.sockc.mark = mark;
9f6abb5f175bdb David S. Miller        2011-05-09  434  	daddr = ipc.addr = ip_hdr(skb)->saddr;
35ebf65e851c6d David S. Miller        2012-06-28  435  	saddr = fib_compute_spec_dst(skb);
aa6615814533c6 Francesco Fusco        2013-09-24  436  
f6d8bd051c391c Eric Dumazet           2011-04-21  437  	if (icmp_param->replyopts.opt.opt.optlen) {
f6d8bd051c391c Eric Dumazet           2011-04-21  438  		ipc.opt = &icmp_param->replyopts.opt;
f6d8bd051c391c Eric Dumazet           2011-04-21  439  		if (ipc.opt->opt.srr)
f6d8bd051c391c Eric Dumazet           2011-04-21  440  			daddr = icmp_param->replyopts.opt.opt.faddr;
^1da177e4c3f41 Linus Torvalds         2005-04-16  441  	}
77968b78242ee2 David S. Miller        2011-05-08  442  	memset(&fl4, 0, sizeof(fl4));
77968b78242ee2 David S. Miller        2011-05-08  443  	fl4.daddr = daddr;
35ebf65e851c6d David S. Miller        2012-06-28  444  	fl4.saddr = saddr;
e110861f86094c Lorenzo Colitti        2014-05-13  445  	fl4.flowi4_mark = mark;
e2d118a1cb5e60 Lorenzo Colitti        2016-11-04  446  	fl4.flowi4_uid = sock_net_uid(net, NULL);
0ed373390c5c18 Guillaume Nault        2024-10-22  447  	fl4.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(ip_hdr(skb)));
77968b78242ee2 David S. Miller        2011-05-08  448  	fl4.flowi4_proto = IPPROTO_ICMP;
385add906b6155 David Ahern            2015-09-29  449  	fl4.flowi4_oif = l3mdev_master_ifindex(skb->dev);
3df98d79215ace Paul Moore             2020-09-27  450  	security_skb_classify_flow(skb, flowi4_to_flowi_common(&fl4));
9d6ec938019c6b David S. Miller        2011-03-12  451  	rt = ip_route_output_key(net, &fl4);
b23dd4fe42b455 David S. Miller        2011-03-02  452  	if (IS_ERR(rt))
^1da177e4c3f41 Linus Torvalds         2005-04-16  453  		goto out_unlock;
8c2bd38b95f75f Eric Dumazet           2024-08-29  454  	if (icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
a15c89c703d434 Eric Dumazet           2022-01-24  455  		icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
^1da177e4c3f41 Linus Torvalds         2005-04-16  456  	ip_rt_put(rt);
^1da177e4c3f41 Linus Torvalds         2005-04-16  457  out_unlock:
405666db84b984 Denis V. Lunev         2008-02-29  458  	icmp_xmit_unlock(sk);
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  459  out_bh_enable:
7ba91ecb16824f Jesper Dangaard Brouer 2017-01-09  460  	local_bh_enable();
^1da177e4c3f41 Linus Torvalds         2005-04-16  461  }
^1da177e4c3f41 Linus Torvalds         2005-04-16  462  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

