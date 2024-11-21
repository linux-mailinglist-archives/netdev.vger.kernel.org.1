Return-Path: <netdev+bounces-146725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085279D54C9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787C8B214D6
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001401DBB19;
	Thu, 21 Nov 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw6bA6+G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C61AAE06
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224839; cv=none; b=Oabd6MVvGJtq2YwHQA3iI6OVqy/8+uiYfNJUOzrwDG5yAnKUH+/FV7VWfkCzoCEs5cEq/3y61RyeYGdwCsVd3Uf9nMRkQe/34NRv4LupMVR5noOub5qt4I0yP+ZS4tkmMYEx6qHJzs25O7oI9VbvkT6G3OukMAQN6C8yVTok2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224839; c=relaxed/simple;
	bh=QbFw27QA0ZPNFGPOesThPIeAcu5ekLgkydYw5duIS8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe5DL0dwL/mgrjDL5XLKvxS72tt734gQECY5OO6b2VLls37fciISYwSoNTwWdDL4Zkp0gkhH2jb86Vff2DZ81aYX1HqSjxVsMaX+z9aXOJ+Y5noy8ElKiO2zvQRKc9vIaiPWMnnZ+ajDFOctnVkaTrawVOTkkxj8HWFgVHgW+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw6bA6+G; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732224838; x=1763760838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QbFw27QA0ZPNFGPOesThPIeAcu5ekLgkydYw5duIS8U=;
  b=Gw6bA6+GKs+o7CJMf6WcZsoevonq9dOLtkQYpvMwzeCzkc7lR203zPdE
   0mRLwQiNEhORorumw0VCJL41iXRL487t5OiWoL6oaqw7eHxP00aKJl3ac
   oD0o4XYqh55n42cWe7A4C5bg+Ljh5V1uXkDFz7LP0ylP3U3um6WmoGUHt
   AQ2Q+kfA2SSZ+rAxTFTm9mLeX4qGuJPekRzy+pmlZn4JkNQSEN64Yf7jz
   V2yUvTOTe+5wfsIBej+H0Y9cPo9y8pmCgkc4lcnn8/uxNdK4oPQiObuyD
   05QxCa5zffqHAxsKEeGjVbnDNOzCfH3kuOp08e7QtKV8w/X1+4d5mWk/w
   g==;
X-CSE-ConnectionGUID: SoI1XEMQTtqNBSCZ4rRQjQ==
X-CSE-MsgGUID: SpyvNeA6RIeCbzIXsEwagg==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32293870"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32293870"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:33:57 -0800
X-CSE-ConnectionGUID: yGBf6Hc7QueNpLXaOovkGQ==
X-CSE-MsgGUID: KizCfiX8SbSYWLQgfTi2zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90370957"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Nov 2024 13:33:54 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEoB-0003NF-0M;
	Thu, 21 Nov 2024 21:33:51 +0000
Date: Fri, 22 Nov 2024 05:33:30 +0800
From: kernel test robot <lkp@intel.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	roopa@cumulusnetworks.com, jiri@resnulli.us,
	stephen@networkplumber.org, jimictw@google.com, prohr@google.com,
	liuhangbin@gmail.com, nicolas.dichtel@6wind.com, andrew@lunn.ch,
	netdev@vger.kernel.org,
	Maciej =?unknown-8bit?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave
 notifications
Message-ID: <202411220556.9IxBYuBa-lkp@intel.com>
References: <20241121054711.818670-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121054711.818670-1-yuyanghuang@google.com>

Hi Yuyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12]
[also build test WARNING on next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuyang-Huang/netlink-add-IGMP-MLD-join-leave-notifications/20241121-154542
base:   v6.12
patch link:    https://lore.kernel.org/r/20241121054711.818670-1-yuyanghuang%40google.com
patch subject: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave notifications
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20241122/202411220556.9IxBYuBa-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220556.9IxBYuBa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220556.9IxBYuBa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/mcast.c: In function 'inet6_fill_ifmcaddr':
>> net/ipv6/mcast.c:912:12: warning: unused variable 'scope' [-Wunused-variable]
     912 |         u8 scope;
         |            ^~~~~


vim +/scope +912 net/ipv6/mcast.c

   906	
   907	static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
   908				       const struct in6_addr *addr, int event)
   909	{
   910		struct ifaddrmsg *ifm;
   911		struct nlmsghdr *nlh;
 > 912		u8 scope;
   913	
   914		nlh = nlmsg_put(skb, 0, 0, event, sizeof(struct ifaddrmsg), 0);
   915		if (!nlh)
   916			return -EMSGSIZE;
   917	
   918		ifm = nlmsg_data(nlh);
   919		ifm->ifa_family = AF_INET6;
   920		ifm->ifa_prefixlen = 128;
   921		ifm->ifa_flags = IFA_F_PERMANENT;
   922		ifm->ifa_scope = RT_SCOPE_UNIVERSE;
   923		ifm->ifa_index = dev->ifindex;
   924	
   925		if (nla_put_in6_addr(skb, IFA_MULTICAST, addr) < 0) {
   926			nlmsg_cancel(skb, nlh);
   927			return -EMSGSIZE;
   928		}
   929	
   930		nlmsg_end(skb, nlh);
   931		return 0;
   932	}
   933	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

