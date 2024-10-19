Return-Path: <netdev+bounces-137242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96D9A51B6
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF06B23A2D
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 23:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A34192D86;
	Sat, 19 Oct 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU5BPz9b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04142192D6A
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 23:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729378810; cv=none; b=qWNLsGW+utnvyPfLjK87eNWF8MkOEuL4LQZZxrLKBd6tve4/Ju2gTB7MzTvMN+2mnvT6U1aNjqJKCWFvt0XfrMCoQAMcRjxgTbWL8bH3AxURT8Y4ozZ7k99nIuWL0TQCIYbgWH3zZGXCiE2JMcapvQ6qhO4uU8fSwoW+FkA+ZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729378810; c=relaxed/simple;
	bh=4Zf0hmLiI660MDGGJCXAGH0gboX7IjSl74L3md8rYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAMlT0wEXdrlhxSBuaPVuTUer+w6qpZBtqlbwiupBNmUC7SLVNoo1aI1bETp3ZNk5IZ8sXa9I6EeSQ+qDmNxJCN5IM31mpk7RnOwwuSIuCVA8ok/HxOxyxpbYldbu7pSr0KkD+2j0DyYIFzxznoLAvWQ4GSK0xtZXpHzmZ0DAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU5BPz9b; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729378808; x=1760914808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Zf0hmLiI660MDGGJCXAGH0gboX7IjSl74L3md8rYRU=;
  b=gU5BPz9b9kCScGrhMI/65hLzUaUkbeX66p0e99F+/DYFmV5L9IVAV0uU
   d59K2xrxA7ZcK6SIoShl/JovplbbcqOYoJYHHruufne/j4vi2FbYjEcij
   6UjTb7j5wgwWm9lnhZNpFySWZKq9JaJzVMvPM8cOJwUCfuZ8E23mOqwlK
   2oTSe591aUVrwZPXffvQVHXbdR455Moa9vC40pPtY0S2Z+vsbK8L7i2BH
   rL/zUonlrNNGWuqPygCgY1TX4yeHZc5es+uLQuznTmedB+onnLCIazi9f
   EGaWdSex7G+cLFeQql0TwDt9u2Dpu5mjpzhoDi839wpiLeVKxXu7GMMCs
   w==;
X-CSE-ConnectionGUID: Kx5dsEPUSpiXi4YVfnVwDA==
X-CSE-MsgGUID: TWsgu8cDTnmST8KPobkFgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40282443"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="40282443"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 16:00:07 -0700
X-CSE-ConnectionGUID: k8HbpntBQrCuwhn6GLhP+Q==
X-CSE-MsgGUID: VTp8BjJ9SH+zzDFZYJv1Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="83966234"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Oct 2024 16:00:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2IQT-000PdD-2x;
	Sat, 19 Oct 2024 23:00:01 +0000
Date: Sun, 20 Oct 2024 06:59:32 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 06/11] ipv4: Convert RTM_DELADDR to per-netns
 RTNL.
Message-ID: <202410200600.GGC28WrU-lkp@intel.com>
References: <20241018012225.90409-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018012225.90409-7-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Define-RTNL_FLAG_DOIT_PERNET-for-per-netns-RTNL-doit/20241018-092802
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241018012225.90409-7-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 06/11] ipv4: Convert RTM_DELADDR to per-netns RTNL.
config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241020/202410200600.GGC28WrU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200600.GGC28WrU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410200600.GGC28WrU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/devinet.c:676:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu * @@
   net/ipv4/devinet.c:676:47: sparse:     expected void *p
   net/ipv4/devinet.c:676:47: sparse:     got struct in_ifaddr [noderef] __rcu *
   net/ipv4/devinet.c:946:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_list @@
   net/ipv4/devinet.c:946:9: sparse:     expected void *p
   net/ipv4/devinet.c:946:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_list
   net/ipv4/devinet.c:946:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_next @@
   net/ipv4/devinet.c:946:9: sparse:     expected void *p
   net/ipv4/devinet.c:946:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_next
   net/ipv4/devinet.c: note: in included file (through include/linux/inetdevice.h):
   include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *
   include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *
   include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *
   include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *

vim +676 net/ipv4/devinet.c

   647	
   648	static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
   649				    struct netlink_ext_ack *extack)
   650	{
   651		struct net *net = sock_net(skb->sk);
   652		struct in_ifaddr __rcu **ifap;
   653		struct nlattr *tb[IFA_MAX+1];
   654		struct in_device *in_dev;
   655		struct ifaddrmsg *ifm;
   656		struct in_ifaddr *ifa;
   657		int err;
   658	
   659		err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
   660					     ifa_ipv4_policy, extack);
   661		if (err < 0)
   662			goto out;
   663	
   664		ifm = nlmsg_data(nlh);
   665	
   666		rtnl_net_lock(net);
   667	
   668		in_dev = inetdev_by_index(net, ifm->ifa_index);
   669		if (!in_dev) {
   670			NL_SET_ERR_MSG(extack, "ipv4: Device not found");
   671			err = -ENODEV;
   672			goto unlock;
   673		}
   674	
   675		for (ifap = &in_dev->ifa_list;
 > 676		     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
   677		     ifap = &ifa->ifa_next) {
   678			if (tb[IFA_LOCAL] &&
   679			    ifa->ifa_local != nla_get_in_addr(tb[IFA_LOCAL]))
   680				continue;
   681	
   682			if (tb[IFA_LABEL] && nla_strcmp(tb[IFA_LABEL], ifa->ifa_label))
   683				continue;
   684	
   685			if (tb[IFA_ADDRESS] &&
   686			    (ifm->ifa_prefixlen != ifa->ifa_prefixlen ||
   687			    !inet_ifa_match(nla_get_in_addr(tb[IFA_ADDRESS]), ifa)))
   688				continue;
   689	
   690			if (ipv4_is_multicast(ifa->ifa_address))
   691				ip_mc_autojoin_config(net, false, ifa);
   692	
   693			__inet_del_ifa(in_dev, ifap, 1, nlh, NETLINK_CB(skb).portid);
   694			goto unlock;
   695		}
   696	
   697		NL_SET_ERR_MSG(extack, "ipv4: Address not found");
   698		err = -EADDRNOTAVAIL;
   699	unlock:
   700		rtnl_net_unlock(net);
   701	out:
   702		return err;
   703	}
   704	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

