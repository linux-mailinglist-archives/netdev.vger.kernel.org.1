Return-Path: <netdev+bounces-78939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E8877045
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 11:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF601C2094C
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA66D381D1;
	Sat,  9 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ES3Zz1Hi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282337143
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979387; cv=none; b=oBmRvGXyo1jvSpTay1JNuWxpT6jR3BJT26Jo5NDVFkxirjLh6w9nj+wA/6hdBj64v9ipkf2otHwL4kWrtuDzXFSrO7wS/3PQiEP32qxbHM7wNElZhhW5BBiy1xc/L7+ejV/jGkbSBQNZz5FffJJU+dTU0VAx5eqdggjjlvcpzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979387; c=relaxed/simple;
	bh=R6YWvxgH9CE3CisoJnp7PZcrDVcPnbLmLxxymhmZHSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvMr8jztlsXeb4Dh9N1rsQo5arHLquIeLsvCHPPFxVsUsBQ6QQzAEcgY2vdzXHtWHDp1KCCNNqyDI2soESyMCHMDRMJVky+BOeuCGK6q6tMMtQXKwdiPhs9bEE4+JcXtpNOewyi3nFBhxiu/VC+vZ/hu8cOTesEXQe5tkuR2TSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ES3Zz1Hi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709979385; x=1741515385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R6YWvxgH9CE3CisoJnp7PZcrDVcPnbLmLxxymhmZHSk=;
  b=ES3Zz1HiDe2grJs5H419ZPnBy3Go0q9l+DDTecZ7/s9ZxhzuDyYUiLOB
   pl673JSkBXicYBMCYiJ0tvX1XS5mvWUa4+q+idi7J938I8V5S0N6IzgoC
   BO/fk828cW/7S03G4BBaEGsKWkxB4ZFkLDbYj6MKaxe189RmlZdFGFHpc
   pgXnz6IOGmfswnqYfX57/bAc3HmhjYuAuOtCj+uqYKEujIIb5aQbd70Ra
   RTJtWRAJFFv5fQk/TFt1gNQG0YYyk6nCFRcqhpCfP/L6wL02o8oINAYsR
   34g9ls3/lQHFfJj7kyVuiOk7ktW4KTbFfNt2gSr7VSyGtrjKUEIGyqjFz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="4567547"
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="4567547"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2024 02:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,112,1708416000"; 
   d="scan'208";a="10763951"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Mar 2024 02:16:22 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ritkZ-0007FH-2m;
	Sat, 09 Mar 2024 10:16:19 +0000
Date: Sat, 9 Mar 2024 18:16:06 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
Message-ID: <202403091859.HD1Dnk2H-lkp@intel.com>
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
config: sparc-randconfig-r051-20240309 (https://download.01.org/0day-ci/archive/20240309/202403091859.HD1Dnk2H-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240309/202403091859.HD1Dnk2H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403091859.HD1Dnk2H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ovpn/peer.c: In function 'ovpn_nexthop_from_rt6':
   drivers/net/ovpn/peer.c:170:24: error: invalid use of undefined type 'struct rt6_info'
     170 |         if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
         |                        ^~
   drivers/net/ovpn/peer.c:173:18: error: invalid use of undefined type 'struct rt6_info'
     173 |         return rt->rt6i_gateway;
         |                  ^~
>> drivers/net/ovpn/peer.c:174:1: warning: control reaches end of non-void function [-Wreturn-type]
     174 | }
         | ^


vim +174 drivers/net/ovpn/peer.c

   165	
   166	static struct in6_addr ovpn_nexthop_from_rt6(struct sk_buff *skb)
   167	{
   168		struct rt6_info *rt = (struct rt6_info *)skb_rtable(skb);
   169	
 > 170		if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
   171			return ipv6_hdr(skb)->daddr;
   172	
   173		return rt->rt6i_gateway;
 > 174	}
   175	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

