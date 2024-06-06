Return-Path: <netdev+bounces-101562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E88FF65C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3341D28873E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFA21990A5;
	Thu,  6 Jun 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH0dHmr8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767844C68
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707995; cv=none; b=DZRuNwu0+lF+HJ4wd4XckbBaNlsHeINzk9zguUDpYVzwGsop14OL+hhB9/P5j1MBEZbVUpGVeatVxl/4tD173Q3wHZeZA+3KQIz2VsOdjdcs6R04utY1qRtWpevCfc3pZjzaPOxejgKz0MLxTL6U9voncBlIIbA3qrJ2TpxLELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707995; c=relaxed/simple;
	bh=dTvaYVKRkBoEzX6rl/ZHUdPy2G40HXsX2n/BVVIdaHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGR+lJJOaRPbebPPNferSJeQVBsL2kH+MyHGlE5zt3Sp4KKIRbCi0bbQft/76RLtXbdbXvxKwbFEH1uTu1HgNhCD0MxxzS/YJ2IURKLHlWOQ1DwdSLlpzzHTVsW6g5JzR6pLiQJvuxCxFzuxKwtaLkLQjz687r6Zf+xhUej0m+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WH0dHmr8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707994; x=1749243994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dTvaYVKRkBoEzX6rl/ZHUdPy2G40HXsX2n/BVVIdaHA=;
  b=WH0dHmr8/ykXTXxe1LBYUcpPyqrUvRqa9bzGjZUMgMi30Zt5gourtNo1
   VFSLbdwVxDNVNorvovwlb/dbfyWh26E1z73A4iRRHbZkDNgdR4uk1yCal
   phrpLANJlrF9yzx8rpbpclGiYKy8DaKfHHyUj8mklYqfsIBozGSrnEmWR
   CPRFN2nUjhSowbVIq4xlXxViVTjHtW8LKpIjgSG1Nk6IFwLAXvbc7DU/5
   Qrk4RLyzSU2tJ1siY4adRYYt4l4aFwfj2NAUtpE8AOA6SLyuBwOaCDpTq
   juHK0k53er8SFJo6O9pz/T/0vGnxvD47mouw7+MmPERkX+0kG0TyjNtEJ
   g==;
X-CSE-ConnectionGUID: cZ+TQzlnQl2wdrXZMEb+cA==
X-CSE-MsgGUID: vYuvklscTB+C6/3DXikxZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="36933988"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="36933988"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:06:31 -0700
X-CSE-ConnectionGUID: mvxFFOd+QxChAKTmSxsjnA==
X-CSE-MsgGUID: tIgZCN56RLKiTDUiYI46zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38048842"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jun 2024 14:06:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFKJW-0003j0-24;
	Thu, 06 Jun 2024 21:06:26 +0000
Date: Fri, 7 Jun 2024 05:06:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net: core,vrf: Change pcpu_dstat fields to
 u64_stats_t
Message-ID: <202406070424.JtWImJfu-lkp@intel.com>
References: <20240605-dstats-v1-1-1024396e1670@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-dstats-v1-1-1024396e1670@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32f88d65f01bf6f45476d7edbe675e44fb9e1d58]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-core-vrf-Change-pcpu_dstat-fields-to-u64_stats_t/20240605-143942
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240605-dstats-v1-1-1024396e1670%40codeconstruct.com.au
patch subject: [PATCH 1/3] net: core,vrf: Change pcpu_dstat fields to u64_stats_t
config: i386-randconfig-062-20240607 (https://download.01.org/0day-ci/archive/20240607/202406070424.JtWImJfu-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070424.JtWImJfu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070424.JtWImJfu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/vrf.c:414:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct u64_stats_t [usertype] *p @@     got struct u64_stats_t [noderef] __percpu * @@
   drivers/net/vrf.c:414:35: sparse:     expected struct u64_stats_t [usertype] *p
   drivers/net/vrf.c:414:35: sparse:     got struct u64_stats_t [noderef] __percpu *
   drivers/net/vrf.c: note: in included file (through include/linux/smp.h, include/linux/alloc_tag.h, include/linux/percpu.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +414 drivers/net/vrf.c

   391	
   392	/* Local traffic destined to local address. Reinsert the packet to rx
   393	 * path, similar to loopback handling.
   394	 */
   395	static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
   396				  struct dst_entry *dst)
   397	{
   398		int len = skb->len;
   399	
   400		skb_orphan(skb);
   401	
   402		skb_dst_set(skb, dst);
   403	
   404		/* set pkt_type to avoid skb hitting packet taps twice -
   405		 * once on Tx and again in Rx processing
   406		 */
   407		skb->pkt_type = PACKET_LOOPBACK;
   408	
   409		skb->protocol = eth_type_trans(skb, dev);
   410	
   411		if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
   412			vrf_rx_stats(dev, len);
   413		else
 > 414			u64_stats_inc(&dev->dstats->rx_drops);
   415	
   416		return NETDEV_TX_OK;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

