Return-Path: <netdev+bounces-156940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CCA0856B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728AB188AB08
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295D1E0E0B;
	Fri, 10 Jan 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVkIOIdY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7A1C75E2
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476757; cv=none; b=tdH7SKH0i2FjWpdRbvk3y4o9yF/mDJ0up8/WgyLYKVvMRenu4gswX9hRfe02H/91ZKLVf1SBOCnwBxN0sMon/pcwZn4zyCCYprXuD3qtfX0Jwbb1O5FTonH2+Wr3OoiVVlM55BHn0VOsrElf+eLtDkIW9gnazsZDbxGe24e7MPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476757; c=relaxed/simple;
	bh=UriMJMrFhxD4lAQ8bk3XXaFFxLoohw3ermeHAyloqSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXJxRdZIb1inK2Hrt3WkPHCnEyemKm7ZJE/EGHg5gCJu6TH79ewaoGkoKhYgXchWHUAyEIzzz51vGIGQSL7JmSeHaa5tINIsKOM0ANbbvFKR2XMRlJgO7K6iDA2n1g44/BwBK+hkxFIfiaq508ujonuo7QFitLucllohXLK1nHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVkIOIdY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736476754; x=1768012754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UriMJMrFhxD4lAQ8bk3XXaFFxLoohw3ermeHAyloqSk=;
  b=LVkIOIdYi5smj4nysPt5tfaBuJ76u/wzrtT2sQ7fP2uvovI82T+Ne/Ph
   YJjKJI7/Ode8E4reBedrurYPFDXY3oGwf5OOEfsR8pzb6aTNdarQh0+W2
   95b45QzSxOQvDNujBI0yuW01CN83BvDjvnEJHnCfarAjM7G0Q0SQY7UnM
   GAoMNgSxykh0YHeh3G8ETd25lm1n7Jk5IUdCAwly4oXZndFwcU5sznbR/
   OWyHW5KBNXWLdmH5tRMsN6X21mylGdWhjfCi3kQbWFiO3ul4VvAq6iOXG
   ZAkOZ3E1o3TQE9doTkOSblM93FWruM4tsM9Guj7B0SwkPqaiN8cMEl3Ol
   w==;
X-CSE-ConnectionGUID: j3M5H/++TiCpr68LEARqpw==
X-CSE-MsgGUID: JdWaYZ1HS1Wzlsic2xKD0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36923928"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36923928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 18:39:13 -0800
X-CSE-ConnectionGUID: b1eZuUrnR2Gdxn3MQHoIfg==
X-CSE-MsgGUID: jBXC0OYkTLONobgPiJTJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108699400"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Jan 2025 18:39:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tW4vU-000IR1-07;
	Fri, 10 Jan 2025 02:39:08 +0000
Date: Fri, 10 Jan 2025 10:38:36 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH v1 net 1/3] gtp: Use for_each_netdev_rcu() in
 gtp_genl_dump_pdp().
Message-ID: <202501101052.pULMpd2R-lkp@intel.com>
References: <20250108062834.11117-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108062834.11117-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/gtp-Use-for_each_netdev_rcu-in-gtp_genl_dump_pdp/20250108-143107
base:   net/main
patch link:    https://lore.kernel.org/r/20250108062834.11117-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net 1/3] gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250110/202501101052.pULMpd2R-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501101052.pULMpd2R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501101052.pULMpd2R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/gtp.c:2276:18: warning: variable 'gn' set but not used [-Wunused-but-set-variable]
    2276 |         struct gtp_net *gn;
         |                         ^
>> drivers/net/gtp.c:2288:31: warning: variable 'gtp' is uninitialized when used here [-Wuninitialized]
    2288 |                 if (last_gtp && last_gtp != gtp)
         |                                             ^~~
   drivers/net/gtp.c:2271:64: note: initialize the variable 'gtp' to silence this warning
    2271 |         struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
         |                                                                       ^
         |                                                                        = NULL
   2 warnings generated.


vim +/gtp +2288 drivers/net/gtp.c

459aa660eb1d8c Pablo Neira        2016-05-09  2267  
459aa660eb1d8c Pablo Neira        2016-05-09  2268  static int gtp_genl_dump_pdp(struct sk_buff *skb,
459aa660eb1d8c Pablo Neira        2016-05-09  2269  				struct netlink_callback *cb)
459aa660eb1d8c Pablo Neira        2016-05-09  2270  {
459aa660eb1d8c Pablo Neira        2016-05-09  2271  	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
94a6d9fb88df43 Taehee Yoo         2019-12-11  2272  	int i, j, bucket = cb->args[0], skip = cb->args[1];
459aa660eb1d8c Pablo Neira        2016-05-09  2273  	struct net *net = sock_net(skb->sk);
766a8e9a311068 Kuniyuki Iwashima  2025-01-08  2274  	struct net_device *dev;
459aa660eb1d8c Pablo Neira        2016-05-09  2275  	struct pdp_ctx *pctx;
94a6d9fb88df43 Taehee Yoo         2019-12-11  2276  	struct gtp_net *gn;
94a6d9fb88df43 Taehee Yoo         2019-12-11  2277  
94a6d9fb88df43 Taehee Yoo         2019-12-11  2278  	gn = net_generic(net, gtp_net_id);
459aa660eb1d8c Pablo Neira        2016-05-09  2279  
459aa660eb1d8c Pablo Neira        2016-05-09  2280  	if (cb->args[4])
459aa660eb1d8c Pablo Neira        2016-05-09  2281  		return 0;
459aa660eb1d8c Pablo Neira        2016-05-09  2282  
94a6d9fb88df43 Taehee Yoo         2019-12-11  2283  	rcu_read_lock();
766a8e9a311068 Kuniyuki Iwashima  2025-01-08  2284  	for_each_netdev_rcu(net, dev) {
766a8e9a311068 Kuniyuki Iwashima  2025-01-08  2285  		if (dev->rtnl_link_ops != &gtp_link_ops)
766a8e9a311068 Kuniyuki Iwashima  2025-01-08  2286  			continue;
766a8e9a311068 Kuniyuki Iwashima  2025-01-08  2287  
459aa660eb1d8c Pablo Neira        2016-05-09 @2288  		if (last_gtp && last_gtp != gtp)
459aa660eb1d8c Pablo Neira        2016-05-09  2289  			continue;
459aa660eb1d8c Pablo Neira        2016-05-09  2290  		else
459aa660eb1d8c Pablo Neira        2016-05-09  2291  			last_gtp = NULL;
459aa660eb1d8c Pablo Neira        2016-05-09  2292  
94a6d9fb88df43 Taehee Yoo         2019-12-11  2293  		for (i = bucket; i < gtp->hash_size; i++) {
94a6d9fb88df43 Taehee Yoo         2019-12-11  2294  			j = 0;
94a6d9fb88df43 Taehee Yoo         2019-12-11  2295  			hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i],
94a6d9fb88df43 Taehee Yoo         2019-12-11  2296  						 hlist_tid) {
94a6d9fb88df43 Taehee Yoo         2019-12-11  2297  				if (j >= skip &&
94a6d9fb88df43 Taehee Yoo         2019-12-11  2298  				    gtp_genl_fill_info(skb,
459aa660eb1d8c Pablo Neira        2016-05-09  2299  					    NETLINK_CB(cb->skb).portid,
459aa660eb1d8c Pablo Neira        2016-05-09  2300  					    cb->nlh->nlmsg_seq,
846c68f7f1ac82 Yoshiyuki Kurauchi 2020-04-30  2301  					    NLM_F_MULTI,
94a6d9fb88df43 Taehee Yoo         2019-12-11  2302  					    cb->nlh->nlmsg_type, pctx)) {
459aa660eb1d8c Pablo Neira        2016-05-09  2303  					cb->args[0] = i;
94a6d9fb88df43 Taehee Yoo         2019-12-11  2304  					cb->args[1] = j;
459aa660eb1d8c Pablo Neira        2016-05-09  2305  					cb->args[2] = (unsigned long)gtp;
459aa660eb1d8c Pablo Neira        2016-05-09  2306  					goto out;
459aa660eb1d8c Pablo Neira        2016-05-09  2307  				}
94a6d9fb88df43 Taehee Yoo         2019-12-11  2308  				j++;
459aa660eb1d8c Pablo Neira        2016-05-09  2309  			}
94a6d9fb88df43 Taehee Yoo         2019-12-11  2310  			skip = 0;
459aa660eb1d8c Pablo Neira        2016-05-09  2311  		}
94a6d9fb88df43 Taehee Yoo         2019-12-11  2312  		bucket = 0;
459aa660eb1d8c Pablo Neira        2016-05-09  2313  	}
459aa660eb1d8c Pablo Neira        2016-05-09  2314  	cb->args[4] = 1;
459aa660eb1d8c Pablo Neira        2016-05-09  2315  out:
94a6d9fb88df43 Taehee Yoo         2019-12-11  2316  	rcu_read_unlock();
459aa660eb1d8c Pablo Neira        2016-05-09  2317  	return skb->len;
459aa660eb1d8c Pablo Neira        2016-05-09  2318  }
459aa660eb1d8c Pablo Neira        2016-05-09  2319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

