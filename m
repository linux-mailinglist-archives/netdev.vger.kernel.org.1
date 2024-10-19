Return-Path: <netdev+bounces-137236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544079A50E8
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5951B1C213F6
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8219259F;
	Sat, 19 Oct 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AU4oCZjc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF1192590
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729371572; cv=none; b=cc4YzdXcWh4addMCFXHy6KScH9mFfRbrtUJSHXQ6v2pMMPJbJsgXTbeLY5hc6UmIa1RHiGTc/aIkZ3X0rGvhvV6mdN3wl+h/ifAVxJjFXZ/GNW+g2D9ZOY+QblvFbpCMf9y1k+CfwVyIM6Wgo+DI4B7IUNxprE1afqJef8AyLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729371572; c=relaxed/simple;
	bh=z/NcOMAVpievxejdRWYqIblCtes8bLGj/AFsTBW1igw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXUkGfaueReCNukklDfD2vvCHKmmukDIXboEq94A1UR8c+6iJudYp/iVI99iXNbtPNEfjI2sGBV5IG3e2Xbx5CXEA5Rw8pHbG2XD6sbzT5SgxOhCmboyICRDoDbpZzrbXAolUMRIAVu4lENwhM7r2Us5LLXUUpBLUCILDwWev1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AU4oCZjc; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729371570; x=1760907570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gz+UZjSd0pc/OLGdmzs7Q04lzPyTdAZwkIkl0zUku5s=;
  b=AU4oCZjc4nHy8RoKjVoaSfMniaxUq/TO723ZPoDvBNae/VkiY0jJ1MJz
   66KVPDYzbxouhmwlLr5wM8q+Bqdr3tF1mrwDB7SNl3IW5We2wWd1r4zvm
   7i6aiNue5HiARj1PVPRU0yD4vGiShmnOiUpvNuO2iHggRQzre5yUS2VFv
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,217,1725321600"; 
   d="scan'208";a="139622528"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 20:59:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:51653]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id f037887e-849e-4918-9c69-46fb4075d48d; Sat, 19 Oct 2024 20:59:28 +0000 (UTC)
X-Farcaster-Flow-ID: f037887e-849e-4918-9c69-46fb4075d48d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 19 Oct 2024 20:59:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.142.233.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 19 Oct 2024 20:59:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
Date: Sat, 19 Oct 2024 13:59:23 -0700
Message-ID: <20241019205923.67706-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <202410200325.SaEJmyZS-lkp@intel.com>
References: <202410200325.SaEJmyZS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: kernel test robot <lkp@intel.com>
Date: Sun, 20 Oct 2024 04:03:55 +0800
> Hi Kuniyuki,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Define-RTNL_FLAG_DOIT_PERNET-for-per-netns-RTNL-doit/20241018-092802
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241018012225.90409-6-kuniyu%40amazon.com
> patch subject: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
> config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241020/202410200325.SaEJmyZS-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200325.SaEJmyZS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410200325.SaEJmyZS-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> net/ipv4/devinet.c:941:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_list @@
>    net/ipv4/devinet.c:941:9: sparse:     expected void *p
>    net/ipv4/devinet.c:941:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_list

Hmm.. when DEBUG_NET_SMALL_RTNL is off, we use static inline helper
returning (void *) to make sure net is always evaluated as requested
in this thread.

  https://lore.kernel.org/netdev/20241004132145.7fd208e9@kernel.org/

But it seems we can't do that when the pointer has __rcu annotation.

Also, this (void *)net evaluation  in turn makes build fail due to
-Werror=unused-value.

  #define rtnl_net_dereference(net, p)			\
  	({						\
  		(void *)net;				\
  		rtnl_dereference(p);			\
  	})

  net/ipv4/devinet.c: In function ‘inet_rtm_deladdr’:
  ./include/linux/rtnetlink.h:154:17: error: statement with no effect [-Werror=unused-value]
    154 |                 (void *)net;                            \
  net/ipv4/devinet.c:674:21: note: in expansion of macro ‘rtnl_net_dereference’
    674 |              (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
        |                     ^~~~~~~~~~~~~~~~~~~~


So, we need to go back to the simplest macro.

  #define rtnl_net_dereference(net, p)			\
  	rtnl_dereference(p);

I'll include the fix in v2.


> >> net/ipv4/devinet.c:941:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_next @@
>    net/ipv4/devinet.c:941:9: sparse:     expected void *p
>    net/ipv4/devinet.c:941:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_next
>    net/ipv4/devinet.c: note: in included file:
> >> include/linux/inetdevice.h:261:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_device [noderef] __rcu *const ip_ptr @@
>    include/linux/inetdevice.h:261:54: sparse:     expected void *p
>    include/linux/inetdevice.h:261:54: sparse:     got struct in_device [noderef] __rcu *const ip_ptr
>    net/ipv4/devinet.c: note: in included file (through include/linux/inetdevice.h):
> >> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
>    include/linux/rtnetlink.h:147:16: sparse:    void *
> >> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
>    include/linux/rtnetlink.h:147:16: sparse:    void *
> >> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
>    include/linux/rtnetlink.h:147:16: sparse:    void *
> 
> vim +941 net/ipv4/devinet.c
> 
>    935	
>    936	static struct in_ifaddr *find_matching_ifa(struct net *net, struct in_ifaddr *ifa)
>    937	{
>    938		struct in_device *in_dev = ifa->ifa_dev;
>    939		struct in_ifaddr *ifa1;
>    940	
>  > 941		in_dev_for_each_ifa_rtnl_net(net, ifa1, in_dev) {
>    942			if (ifa1->ifa_mask == ifa->ifa_mask &&
>    943			    inet_ifa_match(ifa1->ifa_address, ifa) &&
>    944			    ifa1->ifa_local == ifa->ifa_local)
>    945				return ifa1;
>    946		}
>    947	
>    948		return NULL;
>    949	}
>    950	

