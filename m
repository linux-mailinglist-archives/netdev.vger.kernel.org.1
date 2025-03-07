Return-Path: <netdev+bounces-172918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88DA5677C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105EE174806
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E92185BC;
	Fri,  7 Mar 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5va7NwM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6C221767D
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349209; cv=none; b=GFc/m0X1zUQUEulLP478APt5PMkdps3YZ/cNK1ltSILqawHgZuy0eVw7jVyOBK1+CndAXIX1bxEbPb0651vgzD/2wBr3sUv899e410YMwh1BVrhaIVDcRX0Kh3Pa9hYMp+LAx8rB/bol1YuUJw/4lB1qVWQBwXSrdg5+cujrph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349209; c=relaxed/simple;
	bh=DeTqmEGJpgLjw1WkILyNYBLvvL+fu8TabnQD5UdHxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBi6EV5WqRwiWJzawdk5Txn6/oSKZ4gXXU+GLUbFLj4p+bLBX3qqQxXUbDWi8genLu8M9EkkYFJ6gKK1mKo4DyagSsocMVSirvA7x4ECKwvalABzxKPvRtxWaEFmXa8E/ZjR8YM4s9mznqMivbtIAqF5OI0jYp7kPxi7twACLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5va7NwM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741349207; x=1772885207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DeTqmEGJpgLjw1WkILyNYBLvvL+fu8TabnQD5UdHxBM=;
  b=P5va7NwMTu3FNG3PYly70XEFEmYf9gogkSvCF2PCCwitFczvddvv0LIf
   OMLypmfNt1TcvF2RNPP2aTJW9Tub2Wz89xDP2nMRSN6b41SUIFsz4WR+m
   P2W69i8Gv51iXqMeh/ejSIQNJs3WHCHQAhOYufgfEBGNomd4csUKPForw
   nZentFFTbiMWc/+W2ln0GHXFdXf5nXGhXo4ESFfNgJ9rN+TfjeFQLnOGd
   7UZoDG+9xGeljlWTXDtyaulsikFv8yB0ys+RG0evJJJwFh6ZA9eXMV/Xh
   T8qsK2NH/dcMuH2bet8lO7db1wFD8m6bN5v1mYsc2uzKHJYv2iy6Y98Nt
   A==;
X-CSE-ConnectionGUID: rQmgkHa9TiquMfOpXCfDtA==
X-CSE-MsgGUID: nHbJmjDyQgGWHLUUyotIXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42250762"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42250762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:06:47 -0800
X-CSE-ConnectionGUID: 8zz9i99HQRyf+0so0hEGBw==
X-CSE-MsgGUID: KApKi7SZQC+TTI+NUBhZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119476458"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2025 04:06:46 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWTS-0000Qr-0a;
	Fri, 07 Mar 2025 12:06:42 +0000
Date: Fri, 7 Mar 2025 20:05:48 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
Message-ID: <202503071931.FDaDRKvW-lkp@intel.com>
References: <740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/udp_tunnel-create-a-fast-path-GRO-lookup/20250306-235952
base:   net-next/main
patch link:    https://lore.kernel.org/r/740cd03d2982943c313de334977e18cc9de1bc3e.1741275846.git.pabeni%40redhat.com
patch subject: [PATCH net-next 2/2] udp_tunnel: use static call for GRO hooks when possible
config: mips-rt305x_defconfig (https://download.01.org/0day-ci/archive/20250307/202503071931.FDaDRKvW-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071931.FDaDRKvW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071931.FDaDRKvW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/udp_offload.c:172:9: error: incompatible pointer types returning 'struct sk_buff *' from a function with result type 'struct skbuff *' [-Werror,-Wincompatible-pointer-types]
     172 |         return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv4/udp_offload.c:782:5: error: incompatible pointer types assigning to 'struct sk_buff *' from 'struct skbuff *' [-Werror,-Wincompatible-pointer-types]
     782 |         pp = udp_tunnel_gro_rcv(sk, head, skb);
         |            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv4/udp_offload.c:932:14: error: use of undeclared identifier 'udp_tunnel_gro_type_lock'; did you mean 'udp_tunnel_gro_rcv'?
     932 |         mutex_init(&udp_tunnel_gro_type_lock);
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
         |                     udp_tunnel_gro_rcv
   include/linux/mutex.h:64:16: note: expanded from macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                       ^
   net/ipv4/udp_offload.c:168:23: note: 'udp_tunnel_gro_rcv' declared here
     168 | static struct skbuff *udp_tunnel_gro_rcv(struct sock *sk,
         |                       ^
>> net/ipv4/udp_offload.c:932:2: error: incompatible pointer types passing 'struct skbuff *(*)(struct sock *, struct list_head *, struct sk_buff *)' to parameter of type 'struct mutex *' [-Werror,-Wincompatible-pointer-types]
     932 |         mutex_init(&udp_tunnel_gro_type_lock);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mutex.h:64:15: note: expanded from macro 'mutex_init'
      64 |         __mutex_init((mutex), #mutex, &__key);                          \
         |                      ^~~~~~~
   include/linux/mutex.h:89:40: note: passing argument to parameter 'lock' here
      89 | extern void __mutex_init(struct mutex *lock, const char *name,
         |                                        ^
   4 errors generated.


vim +172 net/ipv4/udp_offload.c

   167	
 > 168	static struct skbuff *udp_tunnel_gro_rcv(struct sock *sk,
   169						 struct list_head *head,
   170						 struct sk_buff *skb)
   171	{
 > 172		return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

