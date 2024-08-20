Return-Path: <netdev+bounces-120371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1419E9590DC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384601C21BE4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7841C8245;
	Tue, 20 Aug 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GW27gIvG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A91C7B86
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195044; cv=none; b=WQDjJ0rHHn0X/eGEaY2/0qWr136fZljwBR2wIdQgJDZcHgifJkVG2TFr33rRRwK6RET2UiuiFpPHFT53MGSeAF8LOKe39PQGUvtY5Aa3sWAROkf88ESuc8ERnKSYxNV1A6wUwa51lhGaSJtPAaSGkPsGoAaTKzpudgi5CW4q064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195044; c=relaxed/simple;
	bh=ShNLlWk7ogV9WkoTi36/tL1R4DYqZHbh/MEP4HqAa4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOz+3jC3VBv4adQG6YZA1eP4tOShCiKsmqjeX7lwGpaOAbR2A5VPuutMFARp6WIqtDtM9HPk9ZS0g4qJl4XvZmcCsN7z2bb+bclrRieOqbjisg1Lq3DJ3PxmNUFVV2hpxvWLcLeP0Dxq70YOswuxZjm6qveeg0+7iFY24U2TOYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GW27gIvG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724195042; x=1755731042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShNLlWk7ogV9WkoTi36/tL1R4DYqZHbh/MEP4HqAa4E=;
  b=GW27gIvGSd7DmIJAqQy75FpoHGIZAA/o4z88JGHA8aXeifDMJUWI4e9B
   In8Q9hSb5QQi+txN214Ft7NQgCAaicA4/uPnxNGYUL/n3riz9isRnl4ML
   xHzXkgoTT4QeDUafG4x/j4MY32+Kr41YtG6tpwr1JT4dH3D+KRRA0t7+h
   UUQFwYoIYfB3wa9pFBWzWtOOKgEbg+m75OHt7utcVT4H45zymSdhH5r9E
   38OCPieQClMkm9NpDR7brKHv+/MhxjfoF/I74JjzI60gf5QcxssIxkW3P
   Yh6/HP3bNKomdup9Vh+HKcAxdAXRNdZKT/FlhwN/jQhuHCE35DvsTWn+r
   Q==;
X-CSE-ConnectionGUID: wmPEUcRVRyinr8n5WJ4SBg==
X-CSE-MsgGUID: 00CUZ9kpTdCIHB2eSR8ktQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22716753"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="22716753"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 16:04:00 -0700
X-CSE-ConnectionGUID: XkQ5JnkxR3u+KZamODQoQg==
X-CSE-MsgGUID: 1MWX7IOvS92mclfH/3akOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60846837"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2024 16:03:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgXtK-000AgC-1Y;
	Tue, 20 Aug 2024 23:03:54 +0000
Date: Wed, 21 Aug 2024 07:03:42 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 12/12] iavf: Add net_shaper_ops support
Message-ID: <202408210617.aCdtdwAt-lkp@intel.com>
References: <08cd87e754552c5f413ead220abdaf1ccfadf21c.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08cd87e754552c5f413ead220abdaf1ccfadf21c.1724165948.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/tools-ynl-lift-an-assumption-about-spec-file-name/20240820-231626
base:   net-next/main
patch link:    https://lore.kernel.org/r/08cd87e754552c5f413ead220abdaf1ccfadf21c.1724165948.git.pabeni%40redhat.com
patch subject: [PATCH v4 net-next 12/12] iavf: Add net_shaper_ops support
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240821/202408210617.aCdtdwAt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210617.aCdtdwAt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210617.aCdtdwAt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_main.c:4965: warning: Function parameter or struct member 'handle' not described in 'iavf_shaper_set'


vim +4965 drivers/net/ethernet/intel/iavf/iavf_main.c

  4948	
  4949	/**
  4950	 * iavf_shaper_set - check that shaper info received
  4951	 * @dev: pointer to netdev
  4952	 * @shaper: configuration of shaper.
  4953	 * @extack: Netlink extended ACK for reporting errors
  4954	 *
  4955	 * Returns:
  4956	 * * %0 - Success
  4957	 * * %-EOPNOTSUPP - Driver doesn't support this scope.
  4958	 * * %-EINVAL - Invalid queue number in input
  4959	 **/
  4960	static int
  4961	iavf_shaper_set(struct net_device *dev,
  4962			const struct net_shaper_handle *handle,
  4963			const struct net_shaper_info *shaper,
  4964			struct netlink_ext_ack *extack)
> 4965	{
  4966		struct iavf_adapter *adapter = netdev_priv(dev);
  4967		bool need_cfg_update = false;
  4968		int ret = 0;
  4969	
  4970		ret = iavf_verify_handle(dev, handle, extack);
  4971		if (ret)
  4972			return ret;
  4973	
  4974		if (handle->scope == NET_SHAPER_SCOPE_QUEUE) {
  4975			struct iavf_ring *tx_ring = &adapter->tx_rings[handle->id];
  4976	
  4977			tx_ring->q_shaper.bw_min = div_u64(shaper->bw_min, 1000);
  4978			tx_ring->q_shaper.bw_max = div_u64(shaper->bw_max, 1000);
  4979			tx_ring->q_shaper_update = true;
  4980			need_cfg_update = true;
  4981		}
  4982	
  4983		if (need_cfg_update)
  4984			adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_QUEUES_BW;
  4985	
  4986		return 0;
  4987	}
  4988	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

