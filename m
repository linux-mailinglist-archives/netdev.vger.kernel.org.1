Return-Path: <netdev+bounces-66438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E9D83F10D
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 23:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B03B25A0F
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486EA1E52B;
	Sat, 27 Jan 2024 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ooc40oFl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598331E536
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706395749; cv=none; b=vFDeXa4E4m3SEPQsbOSAxeq2Mn/DhkmJvtlarVZYUMyUs6DxXwCCvFh2qqDdhhTaKdnoRTUnemUF+VElCI5cExjhv+LTzBaLwpTRMYhdYQudF+Y+O0lmT7RbWOjvnvWBIMrTwX4P9XDrO959DCo3i/3fdzc5LuxbI5k1NPo2jqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706395749; c=relaxed/simple;
	bh=lU1LsnoY/AjObB6vlgiL4qIFVyJDnA7AnrXnRq0imGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn3gSsH8tPFmVU7s61qM8BIfY4su+PvuAfEW0MVLwgeo5M0d34OWC4T6KV//0cgYN6zYebUpDORKCw4uqMgoZVYx7pRe6kCxfcxDki69VxADpamuc3lpwfQwzr8f91ZQWV7SavVMv8kUJjWUqSjEKKF+FWVw8FVNsx0U6TtZWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ooc40oFl; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706395747; x=1737931747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lU1LsnoY/AjObB6vlgiL4qIFVyJDnA7AnrXnRq0imGQ=;
  b=Ooc40oFlvF2zbd84araxoc/587ULyFaK7giWgW8WMK1ZHx9qrZZ4Wdoo
   5XUnz0MNFEmVKrvi9+uUdSiYHdEpVr+mX+9eaEEU8XZ+8b3N563WX4h06
   UxQ0/z4obDN/O+BWkBdCwjOpq3NSkoeFvXu/9eaVKyelpswvWDq6GuEi9
   3G3aWogee+NVHHOdHoilon5U+GPe55gTewqYlCMp7PzbacPTZsJNpQtM+
   qwqBmrNCaj8wMAsm5m+EXjp5fJuD6z4E7ESGpSekgsauBenSZXtP2d0DY
   poCpEydw2lSFIWcx7ZxwCajKiUI9Ko34kInRx2Csn3kl0WHhsaPoHglzs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="393147535"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="393147535"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 14:49:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="29152736"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Jan 2024 14:49:05 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTrTx-0002oo-33;
	Sat, 27 Jan 2024 22:49:01 +0000
Date: Sun, 28 Jan 2024 06:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7 1/4] netdevsim: allow two netdevsim ports to
 be connected
Message-ID: <202401280644.lnmk82jI-lkp@intel.com>
References: <20240127040354.944744-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127040354.944744-2-dw@davidwei.uk>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wei/netdevsim-allow-two-netdevsim-ports-to-be-connected/20240127-121234
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240127040354.944744-2-dw%40davidwei.uk
patch subject: [PATCH net-next v7 1/4] netdevsim: allow two netdevsim ports to be connected
config: x86_64-randconfig-r122-20240127 (https://download.01.org/0day-ci/archive/20240128/202401280644.lnmk82jI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401280644.lnmk82jI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401280644.lnmk82jI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/netdevsim/bus.c:349:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct netdevsim *peer @@     got struct netdevsim [noderef] __rcu *peer @@
   drivers/net/netdevsim/bus.c:349:14: sparse:     expected struct netdevsim *peer
   drivers/net/netdevsim/bus.c:349:14: sparse:     got struct netdevsim [noderef] __rcu *peer

vim +349 drivers/net/netdevsim/bus.c

   311	
   312	static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
   313	{
   314		struct netdevsim *nsim, *peer;
   315		unsigned int netnsid, ifidx;
   316		struct net_device *dev;
   317		struct net *ns;
   318		int err;
   319	
   320		err = sscanf(buf, "%u:%u", &netnsid, &ifidx);
   321		if (err != 2) {
   322			pr_err("Format for unlinking a device is \"netnsid:ifidx\" (uint uint).\n");
   323			return -EINVAL;
   324		}
   325	
   326		err = -EINVAL;
   327		rtnl_lock();
   328		ns = get_net_ns_by_id(current->nsproxy->net_ns, netnsid);
   329		if (!ns) {
   330			pr_err("Could not find netns with id: %u\n", netnsid);
   331			goto out_unlock_rtnl;
   332		}
   333	
   334		dev = __dev_get_by_index(ns, ifidx);
   335		if (!dev) {
   336			pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx, netnsid);
   337			goto out_put_netns;
   338		}
   339	
   340		if (!netdev_is_nsim(dev)) {
   341			pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx, netnsid);
   342			goto out_put_netns;
   343		}
   344	
   345		err = 0;
   346		nsim = netdev_priv(dev);
   347		if (!nsim->peer)
   348			goto out_put_netns;
 > 349		peer = nsim->peer;
   350	
   351		RCU_INIT_POINTER(nsim->peer, NULL);
   352		RCU_INIT_POINTER(peer->peer, NULL);
   353	
   354	out_put_netns:
   355		put_net(ns);
   356	out_unlock_rtnl:
   357		rtnl_unlock();
   358	
   359		return !err ? count : err;
   360	}
   361	static BUS_ATTR_WO(unlink_device);
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

