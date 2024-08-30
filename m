Return-Path: <netdev+bounces-123767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA62966760
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05826287399
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA11B81AB;
	Fri, 30 Aug 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MH0Fdwg4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C371B3B2D
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036684; cv=none; b=bGG4RbRHKnr6/c77h1KW6DYG7U4BnetE19+A4kxQ+EKUrTMToVjbftfdh4yzdWlJxfSvgiaiN376NE0SqPvTZq32bWFKbwT4ykbcoq6c5OsWDec1Sdxj55bqHwFzgUZOhbCPDTLYiAZe4tq9p9P30C/uMbcqIebmq/rJiQjZkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036684; c=relaxed/simple;
	bh=Iq/PlQ0yx1Bd1zYioCHm6mkU9HPZU6u+XnA/pioBcs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZoq3xVMJ2mTcWP6/zjmbFc/lCeMvdvYRCGZoS1EAV6VNndzlFf9FhPLgShbnlV/tyfV4NadepufA4d6bnJOk4AnO8CdYojrOf/n2jh0xwcMvU44mZtliGt1s0kMAW3IsX1VxJKojbDsA+bVrFjMoz+JFSEcqBpmYC0hnN7eW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MH0Fdwg4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725036682; x=1756572682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iq/PlQ0yx1Bd1zYioCHm6mkU9HPZU6u+XnA/pioBcs0=;
  b=MH0Fdwg4bAr86CgzZ5mMWJt+OaKfpdO6ipphexywa7poidihNCueZ5Jk
   9pSeNnXdp7r137Fwo30i8JdQEeKkdDCxVtEEx/UcXorU5VEsvQRZG4lQg
   f3+eYt8wLCNA49jL5DdAIPnbq/Fs70Ucnhxpzhlx9Emp+BhjUxgdNbBXQ
   nUFOGApAP7rJ80r5gyeJnBCqeehqAE3WYEXkgfpzdlFs8izPFzrwQasAa
   qdRoE1iJpSaedEoJ2drEKS4kCPl0HsrpNdtVn0HxNmaehhCVnlqMaE31I
   HPNCHTXsH4iyZYpkaTVVdF5N4O7a7a0RUAYpQ4R6WJLMo4V9sR1F63Ikm
   w==;
X-CSE-ConnectionGUID: X+wjfDsBT56cCt7EUekeBA==
X-CSE-MsgGUID: PT4KYHIgRWywjRFXour2qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23870837"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23870837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:51:21 -0700
X-CSE-ConnectionGUID: Gq/NVGUiSEGiJYHuWxrBKA==
X-CSE-MsgGUID: BlWL1ClzQGaOeFbi0Z7cmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63649911"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 30 Aug 2024 09:51:19 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk4qC-0001fi-2H;
	Fri, 30 Aug 2024 16:51:16 +0000
Date: Sat, 31 Aug 2024 00:50:36 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Message-ID: <202408310034.uyJpRXb7-lkp@intel.com>
References: <20240829204922.1674865-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829204922.1674865-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/selftests-txtimestamp-add-SCM_TS_OPT_ID-test/20240830-045630
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240829204922.1674865-1-vadfed%40meta.com
patch subject: [PATCH net-next 1/2] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in control message
config: mips-gcw0_defconfig (https://download.01.org/0day-ci/archive/20240831/202408310034.uyJpRXb7-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 46fe36a4295f05d5d3731762e31fc4e6e99863e9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310034.uyJpRXb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310034.uyJpRXb7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/sock.c:91:
   In file included from include/linux/errqueue.h:6:
   In file included from include/net/ip.h:22:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/mips/include/asm/cacheflush.h:13:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/core/sock.c:2862:7: error: use of undeclared identifier 'SCM_TS_OPT_ID'
    2862 |         case SCM_TS_OPT_ID:
         |              ^
   1 warning and 1 error generated.


vim +/SCM_TS_OPT_ID +2862 net/core/sock.c

  2828	
  2829	int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
  2830			     struct sockcm_cookie *sockc)
  2831	{
  2832		u32 tsflags;
  2833	
  2834		switch (cmsg->cmsg_type) {
  2835		case SO_MARK:
  2836			if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
  2837			    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
  2838				return -EPERM;
  2839			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2840				return -EINVAL;
  2841			sockc->mark = *(u32 *)CMSG_DATA(cmsg);
  2842			break;
  2843		case SO_TIMESTAMPING_OLD:
  2844		case SO_TIMESTAMPING_NEW:
  2845			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2846				return -EINVAL;
  2847	
  2848			tsflags = *(u32 *)CMSG_DATA(cmsg);
  2849			if (tsflags & ~SOF_TIMESTAMPING_TX_RECORD_MASK)
  2850				return -EINVAL;
  2851	
  2852			sockc->tsflags &= ~SOF_TIMESTAMPING_TX_RECORD_MASK;
  2853			sockc->tsflags |= tsflags;
  2854			break;
  2855		case SCM_TXTIME:
  2856			if (!sock_flag(sk, SOCK_TXTIME))
  2857				return -EINVAL;
  2858			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u64)))
  2859				return -EINVAL;
  2860			sockc->transmit_time = get_unaligned((u64 *)CMSG_DATA(cmsg));
  2861			break;
> 2862		case SCM_TS_OPT_ID:
  2863			/* allow this option for UDP sockets only */
  2864			if (!sk_is_udp(sk))
  2865				return -EINVAL;
  2866			tsflags = READ_ONCE(sk->sk_tsflags);
  2867			if (!(tsflags & SOF_TIMESTAMPING_OPT_ID))
  2868				return -EINVAL;
  2869			if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
  2870				return -EINVAL;
  2871			sockc->ts_opt_id = *(u32 *)CMSG_DATA(cmsg);
  2872			sockc->tsflags |= SOF_TIMESTAMPING_OPT_ID_CMSG;
  2873			break;
  2874		/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
  2875		case SCM_RIGHTS:
  2876		case SCM_CREDENTIALS:
  2877			break;
  2878		default:
  2879			return -EINVAL;
  2880		}
  2881		return 0;
  2882	}
  2883	EXPORT_SYMBOL(__sock_cmsg_send);
  2884	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

