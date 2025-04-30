Return-Path: <netdev+bounces-186924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D258EAA40BE
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 04:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0743B0A70
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8013E02D;
	Wed, 30 Apr 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKGTTOeN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314829D0E
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745978390; cv=none; b=qyGnjd7p48d5WAxkTr+SH2m3bxnJomlQy5qhsN3IkFuNpbs12Y8bgsJofOyu1ASh12lGkTnzKDCpQq/VchvSCwdY3DPoqZPPA5Gu2T6sdMDtj0HjFEz9HMTIpJyhHpWU7oPdNt+WvR9j7i0FuYi++O3LpDPoJKuNVIA8HnPTzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745978390; c=relaxed/simple;
	bh=jeoxmcc//SJas5RBYkbSkdSA1+ZU2zRjmq2M/xb0xBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb9SxYqfKIikgLlh/wi63t3IdBjtVt7akDyDPGASFZdH3BwkU2Y789wKe+WXboozgavtsICMkbcqG8Om73pNE5zVWoNcqCI9foWf6OaFPSZ4mk60b3uvl64q3uNw5Q5RvdUKOfSbMgOv+6n9jkJDdJmVMlCw9JFEMLuMs/QFICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKGTTOeN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745978388; x=1777514388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jeoxmcc//SJas5RBYkbSkdSA1+ZU2zRjmq2M/xb0xBs=;
  b=NKGTTOeNFrWp3Q8gdT4ENZxSGABRg2iwnrLuLIJEVIAS/mcGEK6T1VC0
   i1Ns+IdF5DwjSGrJSiSllUGaKjaz9ZtJq1Gi41gnn1Ashf7ntJOAv6GwS
   UhizdgHb0Vf2YmPoj0eQ4BA8zaiw+OBCZzvfLtoHWT8ZCqszmhxOGhcw3
   Q41EA0q56nMTepV3+Wt31wmZthkzvrsJrsl8AdfNWxvDBHCxwF56td5OX
   /DA0JwqYXdTF43PGXfrpxcDA/kkDsJjLFK9ujehfUeFSVUwsaXUx2ACHA
   4BltT6QvhtgfPh2eEMkFxbMMaJSXpVs0sZXfSgiMEX+F35mO599tCIgYc
   w==;
X-CSE-ConnectionGUID: RS9QltZ2SXuKd2cjg6gYAA==
X-CSE-MsgGUID: /iSEvx/WSF6r7BWV+HgMDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="57821230"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="57821230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 18:59:47 -0700
X-CSE-ConnectionGUID: nCYOM6crROW3AQMjujUhEg==
X-CSE-MsgGUID: JTL3TYkCTIiRHzZrxvla2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="133881483"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2025 18:59:45 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9wjd-00035x-1w;
	Wed, 30 Apr 2025 01:59:41 +0000
Date: Wed, 30 Apr 2025 09:59:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH v1 net-next] ipv6: Restore fib6_config validation for
 SIOCADDRT.
Message-ID: <202504300946.ZH4g32Gw-lkp@intel.com>
References: <20250429014624.61938-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429014624.61938-1-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/ipv6-Restore-fib6_config-validation-for-SIOCADDRT/20250429-094825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250429014624.61938-1-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next] ipv6: Restore fib6_config validation for SIOCADDRT.
config: s390-randconfig-001-20250430 (https://download.01.org/0day-ci/archive/20250430/202504300946.ZH4g32Gw-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250430/202504300946.ZH4g32Gw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504300946.ZH4g32Gw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv6/route.c:5715:29: error: passing 'struct fib6_config' to parameter of incompatible type 'struct fib6_config *'; take the address with &
    5715 |         err = fib6_config_validate(cfg, extack);
         |                                    ^~~
         |                                    &
   net/ipv6/route.c:4499:53: note: passing argument to parameter 'cfg' here
    4499 | static int fib6_config_validate(struct fib6_config *cfg,
         |                                                     ^
   1 error generated.


vim +5715 net/ipv6/route.c

  5704	
  5705	static int inet6_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
  5706				      struct netlink_ext_ack *extack)
  5707	{
  5708		struct fib6_config cfg;
  5709		int err;
  5710	
  5711		err = rtm_to_fib6_config(skb, nlh, &cfg, extack);
  5712		if (err < 0)
  5713			return err;
  5714	
> 5715		err = fib6_config_validate(cfg, extack);
  5716		if (err)
  5717			return err;
  5718	
  5719		if (cfg.fc_metric == 0)
  5720			cfg.fc_metric = IP6_RT_PRIO_USER;
  5721	
  5722		if (cfg.fc_mp)
  5723			return ip6_route_multipath_add(&cfg, extack);
  5724		else
  5725			return ip6_route_add(&cfg, GFP_KERNEL, extack);
  5726	}
  5727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

