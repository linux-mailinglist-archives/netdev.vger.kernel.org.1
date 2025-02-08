Return-Path: <netdev+bounces-164347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B52A2D754
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 17:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5077A174E
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0322E01C;
	Sat,  8 Feb 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H55Z/Xm6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9C22DFF7;
	Sat,  8 Feb 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032052; cv=none; b=dhB0Ef51b6pqP2zvrMbE5rnmuGtnRMWkkMUEIIyfozhMyDHbKJDbl6fNUyl0ACE/BkzU/ST3pqMQNJBjDJ2yD6wNSTvX+9YTbWBbSb76RoQQrLtRxD6HXAuB8iJcFipO9zgJtskRcm8lARzGSMO54N5kUOs35e9zCbbOhu+nEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032052; c=relaxed/simple;
	bh=dj0OCXVbhkh8hV0+o02O/c4Nm3lkeARvpTdqlPVoXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGiWCplDCz9CRFDxKEZjBDvzU+X/FuDP+lIcSfJ5O7gg/uQyQfV7MXbGg9xo+CfC5Zs2mZnWoC5sDDVIqyu+7BqcykY1jMFYbo9LTvPCJEj4n86KgvG7iz5ZUVGw9pG5dprm0HMvrJxBZ4O2zb48QmS2aUct+Vgn8ajzDshDVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H55Z/Xm6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739032051; x=1770568051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dj0OCXVbhkh8hV0+o02O/c4Nm3lkeARvpTdqlPVoXA8=;
  b=H55Z/Xm6eE73wCf5hzp4owabcoEJvYT58XOWd/58w1eGcZKRUsIfFJhC
   T4KSi+0jRfM+jYSvjR3bBcadISHpmmZu4rsz+QDyQOVyR2dWbRWJPAgdd
   /OO8VgfVs0Xbnq+MfvImL1OMM/uY/MWmganG/OcT0mGwhcVND5RxS0Wf2
   wh/M7FQPMtnH+Q3uCIv47Rw0JstJjQVsFl+AJ6RCTp6O44Mn8pg6aGjrW
   AaaB4P2/HHq6xGkChNwiZyabNpcnolUXkxNXR0OayGDed++CBGG30G0O1
   cbRLV/z4HZgSntBKnyjpaXXbTl679AafoOPSh1hIYD7uwLfGqpydEkW6D
   w==;
X-CSE-ConnectionGUID: scsKfmNGSrKhobTbwjPUWw==
X-CSE-MsgGUID: LzuUZ5tsQ7Cb35U0kN1Xjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="49898105"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="49898105"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 08:27:27 -0800
X-CSE-ConnectionGUID: O7266KfJSq2Y6K1uIKuObA==
X-CSE-MsgGUID: w/J60tw/T2yj85XNyVuLgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117003987"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Feb 2025 08:27:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgnft-0010Kl-1g;
	Sat, 08 Feb 2025 16:27:21 +0000
Date: Sun, 9 Feb 2025 00:26:30 +0800
From: kernel test robot <lkp@intel.com>
To: Liang Jie <buaajxlj@163.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Michal Luczaj <mhal@rbox.co>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liang Jie <liangjie@lixiang.com>
Subject: Re: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets
 autobind identifier length
Message-ID: <202502090018.NcW3Qcd3-lkp@intel.com>
References: <20250206054451.4070941-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054451.4070941-1-buaajxlj@163.com>

Hi Liang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Jie/af_unix-Refine-UNIX-pathname-sockets-autobind-identifier-length/20250206-134846
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250206054451.4070941-1-buaajxlj%40163.com
patch subject: [PATCH net-next v2] af_unix: Refine UNIX pathname sockets autobind identifier length
config: csky-randconfig-001-20250207 (https://download.01.org/0day-ci/archive/20250209/202502090018.NcW3Qcd3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090018.NcW3Qcd3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090018.NcW3Qcd3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/unix/af_unix.c: In function 'unix_autobind':
>> net/unix/af_unix.c:1222:52: warning: 'snprintf' output truncated before the last format character [-Wformat-truncation=]
    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
         |                                                    ^
   net/unix/af_unix.c:1222:9: note: 'snprintf' output 6 bytes into a destination of size 5
    1222 |         snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/snprintf +1222 net/unix/af_unix.c

  1190	
  1191	static int unix_autobind(struct sock *sk)
  1192	{
  1193		struct unix_sock *u = unix_sk(sk);
  1194		unsigned int new_hash, old_hash;
  1195		struct net *net = sock_net(sk);
  1196		struct unix_address *addr;
  1197		u32 lastnum, ordernum;
  1198		int err;
  1199	
  1200		err = mutex_lock_interruptible(&u->bindlock);
  1201		if (err)
  1202			return err;
  1203	
  1204		if (u->addr)
  1205			goto out;
  1206	
  1207		err = -ENOMEM;
  1208		addr = kzalloc(sizeof(*addr) + offsetof(struct sockaddr_un, sun_path) +
  1209				UNIX_AUTOBIND_LEN, GFP_KERNEL);
  1210		if (!addr)
  1211			goto out;
  1212	
  1213		addr->len = offsetof(struct sockaddr_un, sun_path) + UNIX_AUTOBIND_LEN;
  1214		addr->name->sun_family = AF_UNIX;
  1215		refcount_set(&addr->refcnt, 1);
  1216	
  1217		old_hash = sk->sk_hash;
  1218		ordernum = get_random_u32();
  1219		lastnum = ordernum & 0xFFFFF;
  1220	retry:
  1221		ordernum = (ordernum + 1) & 0xFFFFF;
> 1222		snprintf(addr->name->sun_path + 1, 5, "%05x", ordernum);
  1223	
  1224		new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
  1225		unix_table_double_lock(net, old_hash, new_hash);
  1226	
  1227		if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
  1228			unix_table_double_unlock(net, old_hash, new_hash);
  1229	
  1230			/* __unix_find_socket_byname() may take long time if many names
  1231			 * are already in use.
  1232			 */
  1233			cond_resched();
  1234	
  1235			if (ordernum == lastnum) {
  1236				/* Give up if all names seems to be in use. */
  1237				err = -ENOSPC;
  1238				unix_release_addr(addr);
  1239				goto out;
  1240			}
  1241	
  1242			goto retry;
  1243		}
  1244	
  1245		__unix_set_addr_hash(net, sk, addr, new_hash);
  1246		unix_table_double_unlock(net, old_hash, new_hash);
  1247		err = 0;
  1248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

