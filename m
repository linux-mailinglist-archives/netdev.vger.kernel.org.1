Return-Path: <netdev+bounces-134500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F0999E10
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515D628A163
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 07:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75730209F35;
	Fri, 11 Oct 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VcBo70I/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B069209F32
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632227; cv=none; b=XqIJMZBMfbTg4DYLGaVNxcoNrxijk+NmEziwhwjVJLiNsG2IcgJdgSKSyMRHmuUmoLBo9Ix+sDWpaO8uAzXUf9qnpg77ROHU4n6EJ5epS1tyQ4SmSgzVBcg9NBlWREA/LlQDZ9xF+RDLr3Peew2gdSoIXcI3KIJJwGb3l5WTq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632227; c=relaxed/simple;
	bh=s4RuEDltlOx33XubHqRMeZqvqZx3eBzoF/ha8Wdypyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6Qsp0O5cgp5ikutiAg9o0p4/FzAWBBINGKoFJjvlPb241WMknXOPkYTDxkqiIkQ9afRV7GscGtPVBCG6ZVPMf5DFlxZtalA5nxakp3s/UAMtxRzCELAFRs5j3Go6hogQudb8CN/ZGCgXW0a+dxb8KqpTfojvqqEJj3MAfOF9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VcBo70I/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728632226; x=1760168226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4RuEDltlOx33XubHqRMeZqvqZx3eBzoF/ha8Wdypyg=;
  b=VcBo70I/jJNU9dAIZTq9y6m0GRwDA9zFnq19zEdzsu5aqsDeN92Wwsaj
   MSF8CUkpTg6cFoN1p54ibeV+832SvG0oME/THoPiExwKoImepBhZm3iyh
   IqIqXzbNmhOeYOs1sqAb0rxmMXLF3nBPimewm3vNAOTRPAfZD4sQQ2vBK
   s6pduam2n3AfTqosipl+u43ePLM0SW3nAu7HY7Yi/W8FVIYFJeYTn2s//
   +N76WHi/Le39mUonT8CLgADakRYB7OqTX0v/hVCXJLbDmsxSzJOIb8wol
   eeczzvGps1Bd5LYifoQ4LHPLlintVsOz2GtG++i5Q0TbKLEq7lrjPF1pM
   g==;
X-CSE-ConnectionGUID: F1vc2/GdQ0S7FwRaFi6AKQ==
X-CSE-MsgGUID: sTUloiK7SWWDR8fICkaWHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="45535166"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="45535166"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 00:37:05 -0700
X-CSE-ConnectionGUID: OAH9lEStTmSICSvgwIVnGQ==
X-CSE-MsgGUID: BpF+X5SETbKLWMYX+Mj5LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="77146119"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Oct 2024 00:37:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szACq-000C0X-2c;
	Fri, 11 Oct 2024 07:37:00 +0000
Date: Fri, 11 Oct 2024 15:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 12/13] rtnetlink: Call
 rtnl_link_get_net_capable() in do_setlink().
Message-ID: <202410111515.TbOH4hSS-lkp@intel.com>
References: <20241009231656.57830-13-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009231656.57830-13-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Allocate-linkinfo-as-struct-rtnl_newlink_tbs/20241010-072158
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241009231656.57830-13-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 12/13] rtnetlink: Call rtnl_link_get_net_capable() in do_setlink().
config: x86_64-buildonly-randconfig-003-20241011 (https://download.01.org/0day-ci/archive/20241011/202410111515.TbOH4hSS-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111515.TbOH4hSS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111515.TbOH4hSS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/rtnetlink.c:3281:6: warning: variable 'tgt_net' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3281 |         if (err < 0)
         |             ^~~~~~~
   net/core/rtnetlink.c:3301:10: note: uninitialized use occurs here
    3301 |         put_net(tgt_net);
         |                 ^~~~~~~
   net/core/rtnetlink.c:3281:2: note: remove the 'if' if its condition is always false
    3281 |         if (err < 0)
         |         ^~~~~~~~~~~~
    3282 |                 goto errout;
         |                 ~~~~~~~~~~~
   net/core/rtnetlink.c:3277:6: warning: variable 'tgt_net' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3277 |         if (err < 0)
         |             ^~~~~~~
   net/core/rtnetlink.c:3301:10: note: uninitialized use occurs here
    3301 |         put_net(tgt_net);
         |                 ^~~~~~~
   net/core/rtnetlink.c:3277:2: note: remove the 'if' if its condition is always false
    3277 |         if (err < 0)
         |         ^~~~~~~~~~~~
    3278 |                 goto errout;
         |                 ~~~~~~~~~~~
   net/core/rtnetlink.c:3272:21: note: initialize the variable 'tgt_net' to silence this warning
    3272 |         struct net *tgt_net;
         |                            ^
         |                             = NULL
   2 warnings generated.


vim +3281 net/core/rtnetlink.c

cc6090e985d7d6 Jiri Pirko        2019-09-30  3264  
c21ef3e343ae91 David Ahern       2017-04-16  3265  static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
c21ef3e343ae91 David Ahern       2017-04-16  3266  			struct netlink_ext_ack *extack)
0157f60c0caea2 Patrick McHardy   2007-06-13  3267  {
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3268  	struct ifinfomsg *ifm = nlmsg_data(nlh);
3b1e0a655f8eba YOSHIFUJI Hideaki 2008-03-26  3269  	struct net *net = sock_net(skb->sk);
0157f60c0caea2 Patrick McHardy   2007-06-13  3270  	struct nlattr *tb[IFLA_MAX+1];
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3271  	struct net_device *dev = NULL;
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3272  	struct net *tgt_net;
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3273  	int err;
0157f60c0caea2 Patrick McHardy   2007-06-13  3274  
8cb081746c031f Johannes Berg     2019-04-26  3275  	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
8cb081746c031f Johannes Berg     2019-04-26  3276  				     ifla_policy, extack);
0157f60c0caea2 Patrick McHardy   2007-06-13  3277  	if (err < 0)
0157f60c0caea2 Patrick McHardy   2007-06-13  3278  		goto errout;
0157f60c0caea2 Patrick McHardy   2007-06-13  3279  
4ff66cae7f10b6 Christian Brauner 2018-02-07  3280  	err = rtnl_ensure_unique_netns(tb, extack, false);
4ff66cae7f10b6 Christian Brauner 2018-02-07 @3281  	if (err < 0)
4ff66cae7f10b6 Christian Brauner 2018-02-07  3282  		goto errout;
4ff66cae7f10b6 Christian Brauner 2018-02-07  3283  
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3284  	tgt_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3285  	if (IS_ERR(tgt_net))
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3286  		return PTR_ERR(tgt_net);
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3287  
0157f60c0caea2 Patrick McHardy   2007-06-13  3288  	if (ifm->ifi_index > 0)
a3d1289126e7b1 Eric Dumazet      2009-10-21  3289  		dev = __dev_get_by_index(net, ifm->ifi_index);
76c9ac0ee878f6 Jiri Pirko        2019-09-30  3290  	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
5ea08b5286f66e Florent Fourcot   2022-04-15  3291  		dev = rtnl_dev_get(net, tb);
0157f60c0caea2 Patrick McHardy   2007-06-13  3292  	else
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3293  		err = -EINVAL;
0157f60c0caea2 Patrick McHardy   2007-06-13  3294  
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3295  	if (dev)
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3296  		err = do_setlink(skb, dev, tgt_net, ifm, extack, tb, 0);
3a6cb17da69fbf Kuniyuki Iwashima 2024-10-09  3297  	else if (!err)
0157f60c0caea2 Patrick McHardy   2007-06-13  3298  		err = -ENODEV;
0157f60c0caea2 Patrick McHardy   2007-06-13  3299  
da5e0494c542dd Thomas Graf       2006-08-10  3300  errout:
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3301  	put_net(tgt_net);
b27f78e2575aa2 Kuniyuki Iwashima 2024-10-09  3302  
^1da177e4c3f41 Linus Torvalds    2005-04-16  3303  	return err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  3304  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  3305  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

