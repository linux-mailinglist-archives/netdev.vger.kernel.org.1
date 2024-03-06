Return-Path: <netdev+bounces-77724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962D872BA5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC831C21530
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2220FB677;
	Wed,  6 Mar 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T078iEeZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C846B
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683930; cv=none; b=c8ZjSYurvxHdMHQjq0xhW6XH+l8zzZIFnynjF8rDmx5OOI6xio3YioAXbnaj8hVLaCza5BA9qLW52Xy+b0whDCaxD4VeK42vpRenXRbirnoc3EDEK7kraXggPL205jIPu28k2T8t3srgDkwKZfbE/I+YsUzhc3yKr3/PIrWMOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683930; c=relaxed/simple;
	bh=rIKkTtnsuXfhoePYJV76asTDSBmLlGQBll0nJfQ3scU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAZvqAIvPecCGNKnGptTuj30ZhK2BrCFVFR/rUWIEQBzaQ5FCQX+6tTrm40HUwtbSfV8dIzYhMeyYSAdqM2Q+JfHb/04vyXHdzdCqwd/bnyfTot1Kp/q4IQcq5rrxdj0c7S+hpLyUV67fbwnzMomFDdsLLhF74uwKMDkwHZ21DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T078iEeZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709683927; x=1741219927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rIKkTtnsuXfhoePYJV76asTDSBmLlGQBll0nJfQ3scU=;
  b=T078iEeZRF27v5rWIHa4bWzTt6tyminidy8ehGny0cCtZje0MW0coKgn
   cMsu92ZRP/q9lgZlzwvk4a9DhMO3XSIEBS45SK+9DTLtM1Ozevt0ckcN1
   66zEZd4uQESZn1AIj1yW+/NZrBWtQ/fTSxgkFzBUppaefWXky64zTFFre
   QHBkxeiRzs+G0u/4VoLEV2140EQIVHgQuRSIGQLZJonHrRVBq9+QINgIe
   2/hyZa7foPAnAM4E4JUUGIbo/NBte9A9giX1sPqcOvn+X/dxlXuKVvH1C
   9t8RaACqsigmuV5M+QXSwQx5SgrqR2i6oyKzKzJf9+ZzzWcWPUjW0NzI2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8092127"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="8092127"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 16:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="40554566"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 05 Mar 2024 16:12:04 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhet7-0003ll-2O;
	Wed, 06 Mar 2024 00:12:01 +0000
Date: Wed, 6 Mar 2024 08:11:04 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
Message-ID: <202403060715.DDWfl06q-lkp@intel.com>
References: <20240304150914.11444-15-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-15-antonio@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20240304-232835
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240304150914.11444-15-antonio%40openvpn.net
patch subject: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240306/202403060715.DDWfl06q-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060715.DDWfl06q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060715.DDWfl06q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ovpn/peer.c:289: warning: Function parameter or struct member 'src' not described in 'ovpn_nexthop_lookup4'
>> drivers/net/ovpn/peer.c:289: warning: Excess function parameter 'dst' description in 'ovpn_nexthop_lookup4'
>> drivers/net/ovpn/peer.c:325: warning: Function parameter or struct member 'addr' not described in 'ovpn_nexthop_lookup6'
>> drivers/net/ovpn/peer.c:325: warning: Excess function parameter 'dst' description in 'ovpn_nexthop_lookup6'


vim +289 drivers/net/ovpn/peer.c

   275	
   276	/**
   277	 * ovpn_nexthop_lookup4() - looks up the IP of the nexthop for the given destination
   278	 *
   279	 * Looks up in the IPv4 system routing table the IP of the nexthop to be used
   280	 * to reach the destination passed as argument. If no nexthop can be found, the
   281	 * destination itself is returned as it probably has to be used as nexthop.
   282	 *
   283	 * @ovpn: the private data representing the current VPN session
   284	 * @dst: the destination to be looked up
   285	 *
   286	 * Return the IP of the next hop if found or the dst itself otherwise
   287	 */
   288	static __be32 ovpn_nexthop_lookup4(struct ovpn_struct *ovpn, __be32 src)
 > 289	{
   290		struct rtable *rt;
   291		struct flowi4 fl = {
   292			.daddr = src
   293		};
   294	
   295		rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
   296		if (IS_ERR(rt)) {
   297			net_dbg_ratelimited("%s: no nexthop found for %pI4\n", ovpn->dev->name, &src);
   298			/* if we end up here this packet is probably going to be
   299			 * thrown away later
   300			 */
   301			return src;
   302		}
   303	
   304		if (!rt->rt_uses_gateway)
   305			goto out;
   306	
   307		src = rt->rt_gw4;
   308	out:
   309		return src;
   310	}
   311	
   312	/**
   313	 * ovpn_nexthop_lookup6() - looks up the IPv6 of the nexthop for the given destination
   314	 *
   315	 * Looks up in the IPv6 system routing table the IP of the nexthop to be used
   316	 * to reach the destination passed as argument. If no nexthop can be found, the
   317	 * destination itself is returned as it probably has to be used as nexthop.
   318	 *
   319	 * @ovpn: the private data representing the current VPN session
   320	 * @dst: the destination to be looked up
   321	 *
   322	 * Return the IP of the next hop if found or the dst itself otherwise
   323	 */
   324	static struct in6_addr ovpn_nexthop_lookup6(struct ovpn_struct *ovpn, struct in6_addr addr)
 > 325	{
   326	#if IS_ENABLED(CONFIG_IPV6)
   327		struct rt6_info *rt;
   328		struct flowi6 fl = {
   329			.daddr = addr,
   330		};
   331	
   332		rt = (struct rt6_info *)ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
   333									NULL);
   334		if (IS_ERR(rt)) {
   335			net_dbg_ratelimited("%s: no nexthop found for %pI6\n", ovpn->dev->name, &addr);
   336			/* if we end up here this packet is probably going to be thrown away later */
   337			return addr;
   338		}
   339	
   340		if (rt->rt6i_flags & RTF_GATEWAY)
   341			addr = rt->rt6i_gateway;
   342	
   343		dst_release((struct dst_entry *)rt);
   344	#endif
   345		return addr;
   346	}
   347	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

