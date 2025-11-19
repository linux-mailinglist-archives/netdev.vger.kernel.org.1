Return-Path: <netdev+bounces-239813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED8C6C9B8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4A4F1A53
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BD248176;
	Wed, 19 Nov 2025 03:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7YbTrfa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF471FECB0;
	Wed, 19 Nov 2025 03:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522754; cv=none; b=cCS2upDBt87baGR11p2Euk7vOOJZdNPiJqxuluICkVKtrj2VVRSFwQxLkcKZwZCSyHB7+IicUTcALdq7FWc0dVa4iQQCG21Gb9DS2ISkI7Fjb0qwD4i2ajHiEbt+XSobUHYQixJw24D9kirVJLIBXDgvG4oDgYyog7aJUJk6RqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522754; c=relaxed/simple;
	bh=BPf5i/Lp7nFs9XoGqVWZrlvAQlPia3cBuSHUPFmcbYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isd788E4FE9sCTkAmtIggmD3OLPpHXMEGn6WxfmhcSup2srYq96Sc6B4ou7CNQqpRlAQpHJ+t5aCK363wLvk6jHqieeSsbyRNGMg316GMGa3uG78c52t1qBJhIvziYsgzKvmjfc7GKtAGHynQSXyOSt0hMS1IAiEnfDH6MK4KC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7YbTrfa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522752; x=1795058752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BPf5i/Lp7nFs9XoGqVWZrlvAQlPia3cBuSHUPFmcbYE=;
  b=I7YbTrfaTgug6VH58mp1tx6TyTcixT5haiTHTb9mMrzwde1Zp9cP51o2
   U+rbd4iKv2B1XDYCLO8MEgv0bkZXWHVkFz/5qOJFc/kQ/DblRIz//TUTx
   XX45i5xQLaHNEJT3tKdkC3EAcuu1NHdMWEfzpB5qLGGvLpecqwFWxh1xW
   LtqBv3zlTAUYJdN2B/Dmd5pAKWYh11qiG4vhzrpn+YtmMsz5SCikLEM9Y
   peRq5+UGmAN1bTi2nhKkpvKXe5A/U4427NESMYKqT+/2hmAp2ow3G9mVT
   LrT++ZWo9k+8R4oH6YBF4iTum4ePGN7iadBlg7SrMe2Cpxfq4884AxYC8
   Q==;
X-CSE-ConnectionGUID: GiC5UsX9T1qxJwsvNHjk+A==
X-CSE-MsgGUID: yio2l51jR3yAiSa3jef5gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68163319"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68163319"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:25:52 -0800
X-CSE-ConnectionGUID: iR9mrOyrQt2CN3zMzi8uRg==
X-CSE-MsgGUID: M19PcOcSTYOL1ZF5Xb2b0w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 19:25:50 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLYpH-0002Ol-2Q;
	Wed, 19 Nov 2025 03:25:47 +0000
Date: Wed, 19 Nov 2025 11:25:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrey.bokhanko@huawei.com,
	edumazet@google.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 04/13] ipvlan: Support IPv6 in macnat mode.
Message-ID: <202511191026.AhVx4Zqc-lkp@intel.com>
References: <20251118100046.2944392-5-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118100046.2944392-5-skorodumov.dmitry@huawei.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Support-MACNAT-mode/20251118-180814
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251118100046.2944392-5-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 04/13] ipvlan: Support IPv6 in macnat mode.
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20251119/202511191026.AhVx4Zqc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191026.AhVx4Zqc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191026.AhVx4Zqc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ipvlan/ipvlan_core.c: In function 'ipvlan_macnat_xmit_phydev':
>> drivers/net/ipvlan/ipvlan_core.c:343:25: warning: variable 'orig_skb' set but not used [-Wunused-but-set-variable]
     343 |         struct sk_buff *orig_skb = skb;
         |                         ^~~~~~~~


vim +/orig_skb +343 drivers/net/ipvlan/ipvlan_core.c

e9103e24d10046 Dmitry Skorodumov 2025-11-18  337  
26dcd46025738d Dmitry Skorodumov 2025-11-18  338  static int ipvlan_macnat_xmit_phydev(struct ipvl_port *port,
26dcd46025738d Dmitry Skorodumov 2025-11-18  339  				     struct sk_buff *skb,
26dcd46025738d Dmitry Skorodumov 2025-11-18  340  				     bool lyr3h_valid,
26dcd46025738d Dmitry Skorodumov 2025-11-18  341  				     void *lyr3h, int addr_type)
26dcd46025738d Dmitry Skorodumov 2025-11-18  342  {
26dcd46025738d Dmitry Skorodumov 2025-11-18 @343  	struct sk_buff *orig_skb = skb;
26dcd46025738d Dmitry Skorodumov 2025-11-18  344  
26dcd46025738d Dmitry Skorodumov 2025-11-18  345  	skb = skb_unshare(skb, GFP_ATOMIC);
26dcd46025738d Dmitry Skorodumov 2025-11-18  346  	if (!skb)
26dcd46025738d Dmitry Skorodumov 2025-11-18  347  		return NET_XMIT_DROP;
26dcd46025738d Dmitry Skorodumov 2025-11-18  348  
26dcd46025738d Dmitry Skorodumov 2025-11-18  349  	/* Use eth-addr of main as source. */
26dcd46025738d Dmitry Skorodumov 2025-11-18  350  	skb_reset_mac_header(skb);
26dcd46025738d Dmitry Skorodumov 2025-11-18  351  	ether_addr_copy(skb_eth_hdr(skb)->h_source, port->dev->dev_addr);
26dcd46025738d Dmitry Skorodumov 2025-11-18  352  
26dcd46025738d Dmitry Skorodumov 2025-11-18  353  	if (!lyr3h_valid) {
26dcd46025738d Dmitry Skorodumov 2025-11-18  354  		lyr3h = ipvlan_get_L3_hdr(port, skb, &addr_type);
26dcd46025738d Dmitry Skorodumov 2025-11-18  355  		orig_skb = skb; /* no need to reparse */
26dcd46025738d Dmitry Skorodumov 2025-11-18  356  	}
e9103e24d10046 Dmitry Skorodumov 2025-11-18  357  	if (!lyr3h)
e9103e24d10046 Dmitry Skorodumov 2025-11-18  358  		addr_type = -1;
e9103e24d10046 Dmitry Skorodumov 2025-11-18  359  	else if (addr_type == IPVL_ARP)
e9103e24d10046 Dmitry Skorodumov 2025-11-18  360  		ipvlan_macnat_patch_tx_arp(port, skb);
e9103e24d10046 Dmitry Skorodumov 2025-11-18  361  	else if (addr_type == IPVL_ICMPV6 || addr_type == IPVL_IPV6)
e9103e24d10046 Dmitry Skorodumov 2025-11-18  362  		ipvlan_macnat_patch_tx_ipv6(port, skb);
26dcd46025738d Dmitry Skorodumov 2025-11-18  363  
26dcd46025738d Dmitry Skorodumov 2025-11-18  364  	skb->dev = port->dev;
26dcd46025738d Dmitry Skorodumov 2025-11-18  365  	return dev_queue_xmit(skb);
26dcd46025738d Dmitry Skorodumov 2025-11-18  366  }
26dcd46025738d Dmitry Skorodumov 2025-11-18  367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

