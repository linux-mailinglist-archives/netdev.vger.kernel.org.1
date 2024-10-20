Return-Path: <netdev+bounces-137245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253659A5206
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 05:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9862827AC
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 03:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0388A440C;
	Sun, 20 Oct 2024 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhHioePn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52E3D6B
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 03:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729393696; cv=none; b=RxHoYIuOlJuQuHw+Q6UQ/kLGVtfs0V/UtzCjiKDkCQhriL732l4gs1D/zwLESVlDIzHoe+wrHaTpKNh592WPNjsFV7xuIUJKOkJHrP1g/11izB/lKYdjo5R2CjuShb+csplWE5fdFSJ3y3tm7nfWX/R3Mc4CUGteVqZ2zhf9mJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729393696; c=relaxed/simple;
	bh=QPgWS4lMtZvAEVX6HvEVtO7MZw8iCYgJoBHYExlFH6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7DdxpT/RuFOlF3NvO4RjCFBEgDSxCpHjyDyAJ+cQxZd9T0IIZv3l+/32TUCMpiBUqlSxLDdc6c1u0+fvOmZ+WiMnPRgYpKOCTSi+OFh6FPvpwQ3/kIUyYe8WZoKvsSq+G2sPVSEt0ypgv43izw8BTXjli0YJsRz3fmp6mDjNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhHioePn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729393695; x=1760929695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPgWS4lMtZvAEVX6HvEVtO7MZw8iCYgJoBHYExlFH6E=;
  b=KhHioePnIxEhs1Lx3KJbjZCs7M+KI+QaxjnA09PG7mKBeT5kv4lXUbcz
   HPEsLslUmkZFQkx4F3oJ5rikQ+15dzgdw2Z8Y/ltvtnPlh+F790WoC/RZ
   z3/po3lxjx80yJccCSNy7qKnRiGsejIpA5ao6yW0SzFXGpo9Ae1SQS6u3
   d/aWJePtlGEhnsyE7jE4ZwP0knRfcyX1w86kZXelhUDuHpKK/3fOsWgEH
   uHB8ChG16xn5Zrr1r05wL68Z7SMgydC86hecK3b+pDB7KOObGNH1vkJps
   Dn2i64bKIEdOtcjElCheGLk9lh2csVD+1EHKOC0SXvaKfr9tMenXe/Rfo
   w==;
X-CSE-ConnectionGUID: xdokhVtoSPG5VwtpCTBDSA==
X-CSE-MsgGUID: owBJ4HbnSbqfOjG6OBCEIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39442882"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39442882"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 20:08:14 -0700
X-CSE-ConnectionGUID: MdjTsAKQQnyxHlxAZJYBCA==
X-CSE-MsgGUID: hr4+EkSsTbSJEgiov9URhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="79167636"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 19 Oct 2024 20:08:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2MIc-000Pod-03;
	Sun, 20 Oct 2024 03:08:10 +0000
Date: Sun, 20 Oct 2024 11:07:43 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 11/11] ipv4: Convert devinet_ioctl to
 per-netns RTNL.
Message-ID: <202410201022.bZkEgzK5-lkp@intel.com>
References: <20241018012225.90409-12-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018012225.90409-12-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Define-RTNL_FLAG_DOIT_PERNET-for-per-netns-RTNL-doit/20241018-092802
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241018012225.90409-12-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 11/11] ipv4: Convert devinet_ioctl to per-netns RTNL.
config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241020/202410201022.bZkEgzK5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201022.bZkEgzK5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201022.bZkEgzK5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/ipv4/devinet.c:674:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:674:47: sparse:     expected void *p
   net/ipv4/devinet.c:674:47: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:775:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:775:65: sparse:     expected void *p
   net/ipv4/devinet.c:775:65: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:783:73: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:783:73: sparse:     expected void *p
   net/ipv4/devinet.c:783:73: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:945:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_list @@
   net/ipv4/devinet.c:945:9: sparse:     expected void *p
   net/ipv4/devinet.c:945:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_list
   net/ipv4/devinet.c:945:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_next @@
   net/ipv4/devinet.c:945:9: sparse:     expected void *p
   net/ipv4/devinet.c:945:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_next
   net/ipv4/devinet.c:1135:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:1135:63: sparse:     expected void *p
   net/ipv4/devinet.c:1135:63: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:1149:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:1149:63: sparse:     expected void *p
   net/ipv4/devinet.c:1149:63: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:1313:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_list @@
   net/ipv4/devinet.c:1313:9: sparse:     expected void *p
   net/ipv4/devinet.c:1313:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_list
>> net/ipv4/devinet.c:1313:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *const ifa_next @@
   net/ipv4/devinet.c:1313:9: sparse:     expected void *p
   net/ipv4/devinet.c:1313:9: sparse:     got struct in_ifaddr [noderef] __rcu *const ifa_next
   net/ipv4/devinet.c: note: in included file:
   include/linux/inetdevice.h:261:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_device [noderef] __rcu *const ip_ptr @@
   include/linux/inetdevice.h:261:54: sparse:     expected void *p
   include/linux/inetdevice.h:261:54: sparse:     got struct in_device [noderef] __rcu *const ip_ptr
   net/ipv4/devinet.c: note: in included file (through include/linux/inetdevice.h):
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *
   include/linux/rtnetlink.h:153:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:153:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:153:16: sparse:    void *

vim +1313 net/ipv4/devinet.c

  1299	
  1300	int inet_gifconf(struct net_device *dev, char __user *buf, int len, int size)
  1301	{
  1302		struct in_device *in_dev = __in_dev_get_rtnl_net(dev);
  1303		const struct in_ifaddr *ifa;
  1304		struct ifreq ifr;
  1305		int done = 0;
  1306	
  1307		if (WARN_ON(size > sizeof(struct ifreq)))
  1308			goto out;
  1309	
  1310		if (!in_dev)
  1311			goto out;
  1312	
> 1313		in_dev_for_each_ifa_rtnl_net(dev_net(dev), ifa, in_dev) {
  1314			if (!buf) {
  1315				done += size;
  1316				continue;
  1317			}
  1318			if (len < size)
  1319				break;
  1320			memset(&ifr, 0, sizeof(struct ifreq));
  1321			strcpy(ifr.ifr_name, ifa->ifa_label);
  1322	
  1323			(*(struct sockaddr_in *)&ifr.ifr_addr).sin_family = AF_INET;
  1324			(*(struct sockaddr_in *)&ifr.ifr_addr).sin_addr.s_addr =
  1325									ifa->ifa_local;
  1326	
  1327			if (copy_to_user(buf + done, &ifr, size)) {
  1328				done = -EFAULT;
  1329				break;
  1330			}
  1331			len  -= size;
  1332			done += size;
  1333		}
  1334	out:
  1335		return done;
  1336	}
  1337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

