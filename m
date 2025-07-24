Return-Path: <netdev+bounces-209728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E0EB109CC
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859137A2843
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83102BE7A7;
	Thu, 24 Jul 2025 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWf7D9Kl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539927F005
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358422; cv=none; b=djbwknUrgUz8UHVdAkcfVokl4NSVTadioZmC9cvXJBP84or/bCBAu+8fLaCdZMu+GWPbO6mdApHuQUMV0yo2D+13EKeQKDELpC7TYYnbH2WTAst1iyrLMrAX2spvkIyI+Hd6Ze2SMmBgtwOoOOe/VQMv2rULJn4Ry7EzLY38G7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358422; c=relaxed/simple;
	bh=neWN+RsKK5xahj60EuUIzVaJh8Zt6T4jsM98KeOqU5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/aEgFiwsuNrCau11JGxFmvaaTqAw58epOhD04AKnLxE0KUogSR0cyI7uge0ktHsAkYD0FHmsaVlzTBX0VjWcyL9+Z8T7udFEkp0uPf0hu4PdcQ0+q0aoAq0bE1p4cvEjvQekuUWuQH1s+4DV3WxDK1Cw65rXbHqBc2C6HBCizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWf7D9Kl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358421; x=1784894421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neWN+RsKK5xahj60EuUIzVaJh8Zt6T4jsM98KeOqU5g=;
  b=RWf7D9KllCv6d3ZQ4GPAIcx2BIpjcPwReHgSix6/keY39Cw0UbsZf6ec
   5cryeAz1T5se9d8TSXs9TE7bRz8GA+JputPFyQUOUjNbgiynMFGNub88i
   dWCf70Y8wx7B1dE5x4FErUR4xe7sMRmYZsIsyozRNo8icxr4p6oyd8Juh
   x2TJG8A6Jdx7xl57s8YPssBMjM5lTqqvC34PqdWSyfFViOSw93e1IB5gD
   8M6dEKJ2DpaGOBdJYmLdTuDSEHxEarn5UmQiqtwcoi7NWsTYVWKRsrHgI
   L7jCLqjRZZecpAVUCOJqOATRZcI86prB/6LNkLdWIpdlv0jALspP1G4Js
   w==;
X-CSE-ConnectionGUID: b1Hi9PeqSNW47a0NxADciw==
X-CSE-MsgGUID: v+3rN+KxSy27kpCmVwojjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55635937"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55635937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:00:21 -0700
X-CSE-ConnectionGUID: vOmJbI0aThK7xtPKnB5sYw==
X-CSE-MsgGUID: jDlK+BZLQmiVJlB7l67yww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="165734121"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Jul 2025 05:00:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueucR-000KP5-3A;
	Thu, 24 Jul 2025 12:00:15 +0000
Date: Thu, 24 Jul 2025 20:00:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kees Cook <kees@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 4/6 net-next] net: Convert proto_ops connect() callbacks
 to use sockaddr_unspec
Message-ID: <202507241955.kFMs4J5b-lkp@intel.com>
References: <20250723231921.2293685-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723231921.2293685-4-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250723]
[cannot apply to net-next/main bluetooth-next/master bluetooth/master brauner-vfs/vfs.all mkl-can-next/testing mptcp/export mptcp/export-net trondmy-nfs/linux-next linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5 v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/net-uapi-Add-__kernel_sockaddr_unspec-for-sockaddr-of-unknown-length/20250724-072218
base:   next-20250723
patch link:    https://lore.kernel.org/r/20250723231921.2293685-4-kees%40kernel.org
patch subject: [PATCH 4/6 net-next] net: Convert proto_ops connect() callbacks to use sockaddr_unspec
config: x86_64-buildonly-randconfig-005-20250724 (https://download.01.org/0day-ci/archive/20250724/202507241955.kFMs4J5b-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507241955.kFMs4J5b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507241955.kFMs4J5b-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mctp/af_mctp.c:632:13: error: incompatible function pointer types initializing 'int (*)(struct socket *, struct __kernel_sockaddr_unspec *, int, int)' with an expression of type 'int (struct socket *, struct sockaddr *, int, int)' [-Wincompatible-function-pointer-types]
     632 |         .connect        = mctp_connect,
         |                           ^~~~~~~~~~~~
   1 error generated.


vim +632 net/mctp/af_mctp.c

63ed1aab3d40aa Matt Johnston 2022-02-09  627  
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  628  static const struct proto_ops mctp_dgram_ops = {
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  629  	.family		= PF_MCTP,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  630  	.release	= mctp_release,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  631  	.bind		= mctp_bind,
3549eb08e55058 Matt Johnston 2025-07-10 @632  	.connect	= mctp_connect,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  633  	.socketpair	= sock_no_socketpair,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  634  	.accept		= sock_no_accept,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  635  	.getname	= sock_no_getname,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  636  	.poll		= datagram_poll,
63ed1aab3d40aa Matt Johnston 2022-02-09  637  	.ioctl		= mctp_ioctl,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  638  	.gettstamp	= sock_gettstamp,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  639  	.listen		= sock_no_listen,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  640  	.shutdown	= sock_no_shutdown,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  641  	.setsockopt	= mctp_setsockopt,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  642  	.getsockopt	= mctp_getsockopt,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  643  	.sendmsg	= mctp_sendmsg,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  644  	.recvmsg	= mctp_recvmsg,
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  645  	.mmap		= sock_no_mmap,
63ed1aab3d40aa Matt Johnston 2022-02-09  646  #ifdef CONFIG_COMPAT
63ed1aab3d40aa Matt Johnston 2022-02-09  647  	.compat_ioctl	= mctp_compat_ioctl,
63ed1aab3d40aa Matt Johnston 2022-02-09  648  #endif
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  649  };
8f601a1e4f8c84 Jeremy Kerr   2021-07-29  650  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

