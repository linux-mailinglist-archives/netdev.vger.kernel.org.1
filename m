Return-Path: <netdev+bounces-202093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B486AAEC35F
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 02:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BCD31C408FC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B8634;
	Sat, 28 Jun 2025 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXmqfApS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC328635
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751069222; cv=none; b=Ybjnh8g76U51HITU4tDI56nkJGfz3I6aVIdJInm1ItBH2nrGiQ23Ehm7vabzy4+lRTHmyco5SkTmmjRI+jJFp4p2Kuw6kKeQV30jiuNGVNKynIONFnVC8zlOaACu+43ydGlDPoEc2UvnFDWFzcTa+Rln8RxQ2i95LyYMK4kFXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751069222; c=relaxed/simple;
	bh=XdHIgdxIP4jPkK5batoO/4PuE5reCfYo73kp4Brc0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnkkczbipRkuaq0G3Kmna2lqQ2CTWAGu0fSZQ1cD4hF2xvrWMja5/AzkQlPk7TQMrgrwaU0mmmQqGbrAw5sYqtGoAmICl0YSO+yodLW5Y+0EDlWIg3bNtZpGlF/HBdOk3GhEPtaBKaPWyIhhgi4CRDXPdYh4QY28Y0yjYz5dSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXmqfApS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751069221; x=1782605221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XdHIgdxIP4jPkK5batoO/4PuE5reCfYo73kp4Brc0bQ=;
  b=TXmqfApS//cYb6wdwRR/3l9UzI7Ld80NdQdcDxx3vBEeIzySF86rx5FQ
   jT01tkOlR0nY+aYIeAGXfyMkwVpJO+WTL5viub+Z3Xr2paWypQJMKK7gq
   aYwHMpTP1gsk5HcP0F7XO5VVX1mzIB1pdupGkxtAXpRpo+ffBLj+gJRGn
   3tkIEYzFedCzI710R4oUmnhTqIQhZKfvKBrGNSGpR9pvsHKtxRVxfgKa+
   buRsvLcLd4w/BrYFnO0ZODSKhHejtO13RrNwdK3zcgaWIb4suzsVEQjxa
   lHP8dDfTEpMgd+WKcR9cNqQqqPilUodQ13qKKCwKsnT2mIX4/4cSA7hr7
   Q==;
X-CSE-ConnectionGUID: yu8STTfjQSWgxcgBPCNP3g==
X-CSE-MsgGUID: URt1lxcvTxOrDCAm+V9XRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53476424"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53476424"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 17:07:00 -0700
X-CSE-ConnectionGUID: D8sJIyE2RUmFALSO847xhw==
X-CSE-MsgGUID: pEV3p65mR/OCN0zunmmfQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="157213860"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 27 Jun 2025 17:06:58 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVJ5s-000Wck-0k;
	Sat, 28 Jun 2025 00:06:56 +0000
Date: Sat, 28 Jun 2025 08:06:22 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH net-next v2] ip6_tunnel: enable to change proto of fb
 tunnels
Message-ID: <202506280734.J8kwhuua-lkp@intel.com>
References: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626215919.2825347-1-nicolas.dichtel@6wind.com>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Dichtel/ip6_tunnel-enable-to-change-proto-of-fb-tunnels/20250627-060113
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250626215919.2825347-1-nicolas.dichtel%406wind.com
patch subject: [PATCH net-next v2] ip6_tunnel: enable to change proto of fb tunnels
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250628/202506280734.J8kwhuua-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250628/202506280734.J8kwhuua-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506280734.J8kwhuua-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/ip6_tunnel.c: In function 'ip6_tnl_changelink':
>> net/ipv6/ip6_tunnel.c:2068:33: warning: unused variable 't' [-Wunused-variable]
    2068 |                 struct ip6_tnl *t = netdev_priv(ip6n->fb_tnl_dev);
         |                                 ^


vim +/t +2068 net/ipv6/ip6_tunnel.c

  2056	
  2057	static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
  2058				      struct nlattr *data[],
  2059				      struct netlink_ext_ack *extack)
  2060	{
  2061		struct ip6_tnl *t = netdev_priv(dev);
  2062		struct __ip6_tnl_parm p;
  2063		struct net *net = t->net;
  2064		struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
  2065		struct ip_tunnel_encap ipencap;
  2066	
  2067		if (dev == ip6n->fb_tnl_dev) {
> 2068			struct ip6_tnl *t = netdev_priv(ip6n->fb_tnl_dev);
  2069	
  2070			if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
  2071				/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
  2072				 * let's ignore this flag.
  2073				 */
  2074				ipencap.flags &= ~TUNNEL_ENCAP_FLAG_CSUM6;
  2075				if (memchr_inv(&ipencap, 0, sizeof(ipencap))) {
  2076					NL_SET_ERR_MSG(extack,
  2077						       "Only protocol can be changed for fallback tunnel, not encap params");
  2078					return -EINVAL;
  2079				}
  2080			}
  2081	
  2082			ip6_tnl_netlink_parms(data, &p);
  2083			if (ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p,
  2084					    true) < 0) {
  2085				NL_SET_ERR_MSG(extack,
  2086					       "Only protocol can be changed for fallback tunnel");
  2087				return -EINVAL;
  2088			}
  2089	
  2090			return 0;
  2091		}
  2092	
  2093		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
  2094			int err = ip6_tnl_encap_setup(t, &ipencap);
  2095	
  2096			if (err < 0)
  2097				return err;
  2098		}
  2099		ip6_tnl_netlink_parms(data, &p);
  2100		if (p.collect_md)
  2101			return -EINVAL;
  2102	
  2103		t = ip6_tnl_locate(net, &p, 0);
  2104		if (!IS_ERR(t)) {
  2105			if (t->dev != dev)
  2106				return -EEXIST;
  2107		} else
  2108			t = netdev_priv(dev);
  2109	
  2110		ip6_tnl_update(t, &p);
  2111		return 0;
  2112	}
  2113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

