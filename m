Return-Path: <netdev+bounces-129888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE502986D69
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD6BB21AA8
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABCC188CA5;
	Thu, 26 Sep 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="becLAetR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F802224D6;
	Thu, 26 Sep 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335267; cv=none; b=VK1mHTGwlbd9cFxGwpihhhJ+jJRZNhZlhivScklRExcb6TVJniMaZtg2jIdhx66ByMWO8cjAR1CZCcJwISBG0c9loycr0Z+dVb5MjOuXMh9o9OGNuUT6+LWFbFHUJVPIN2ZVUeIXl9gg05eEVos9Q28BeyDLEpQSF5RkVsfkq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335267; c=relaxed/simple;
	bh=itYl6g578kw6xUZCVYmAQSs22VA2Hmzh6VcRzWPVO4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiRkU3++4Wr7PBwR08WjenZF8xNCGCPai3GXibKfdTubUDMxn4dywZH8sYE6YTGKk/taNkk7CKdPP7IoZf3B9wtgSPwvWz0VTsr2hRFZXkgh0Y0dJ+iK28b+z0ZLRGO0wyToHQbXVeMPk2lqqGg7Fb8SzKe+e8by8PbxylOjhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=becLAetR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727335265; x=1758871265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=itYl6g578kw6xUZCVYmAQSs22VA2Hmzh6VcRzWPVO4I=;
  b=becLAetR6FNU7OQS/ne9eiMebZB3QJxgkbXMnoquXsl5tuxkt9V3U7s7
   bjlF8WrdK+qeR6a/1R09OYtBsyN46rHkmGmH+Hg0osCZbBMV29mfHrt20
   o8mXiqYMB2p081XEVe8gXE3ARr/ct2CJhN7DUc9sJ05KZN/FxF69z2ZEv
   Zu423H3pZpip1HEJoLZISSsDsrlNWITuNZn+0Clv+HIXP2qtfxxdJhCxB
   vGZkPBMzg3Fww55x1DXTzbGqT43TeZkTQ/3fjRSVlRyzLg8+/upWCYm22
   gmtnL4TWcLPju9D8FFkyu0t1EdN4R7/qoezaRIh4N9OFBF8R+HyjzBHpL
   w==;
X-CSE-ConnectionGUID: wa/XsssGRwONBwh5qZwWHg==
X-CSE-MsgGUID: BH2xUk5dR5qDdfFpjqB3kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37770155"
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="37770155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 00:21:04 -0700
X-CSE-ConnectionGUID: rYx1RBzeRPOiwZUQW4dXLw==
X-CSE-MsgGUID: hWxP0pVgSWCBB7rqCDnTbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,259,1719903600"; 
   d="scan'208";a="71711597"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 26 Sep 2024 00:21:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stio7-000KON-0V;
	Thu, 26 Sep 2024 07:20:59 +0000
Date: Thu, 26 Sep 2024 15:20:08 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: systemport: Add error pointer checks in
 bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
Message-ID: <202409261447.R2kfrGVq-lkp@intel.com>
References: <20240925152927.4579-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925152927.4579-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/net-systemport-Add-error-pointer-checks-in-bcm_sysport_map_queues-and-bcm_sysport_unmap_queues/20240925-233508
base:   net/main
patch link:    https://lore.kernel.org/r/20240925152927.4579-1-kdipendra88%40gmail.com
patch subject: [PATCH net v4] net: systemport: Add error pointer checks in bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409261447.R2kfrGVq-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409261447.R2kfrGVq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409261447.R2kfrGVq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bcmsysport.c: In function 'bcm_sysport_unmap_queues':
>> drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: error: expected ';' before ')' token
    2401 |                 return PTR_ERR(dp));
         |                                   ^
         |                                   ;
>> drivers/net/ethernet/broadcom/bcmsysport.c:2400:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    2400 |         if (IS_ERR(dp))
         |         ^~
   drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2401 |                 return PTR_ERR(dp));
         |                                   ^
>> drivers/net/ethernet/broadcom/bcmsysport.c:2401:35: error: expected statement before ')' token


vim +2401 drivers/net/ethernet/broadcom/bcmsysport.c

  2389	
  2390	static int bcm_sysport_unmap_queues(struct net_device *dev,
  2391					    struct net_device *slave_dev)
  2392	{
  2393		struct bcm_sysport_priv *priv = netdev_priv(dev);
  2394		struct bcm_sysport_tx_ring *ring;
  2395		unsigned int num_tx_queues;
  2396		unsigned int q, qp, port;
  2397		struct dsa_port *dp;
  2398	
  2399		dp = dsa_port_from_netdev(slave_dev);
> 2400		if (IS_ERR(dp))
> 2401			return PTR_ERR(dp));
  2402	
  2403		port = dp->index;
  2404	
  2405		num_tx_queues = slave_dev->real_num_tx_queues;
  2406	
  2407		for (q = 0; q < dev->num_tx_queues; q++) {
  2408			ring = &priv->tx_rings[q];
  2409	
  2410			if (ring->switch_port != port)
  2411				continue;
  2412	
  2413			if (!ring->inspect)
  2414				continue;
  2415	
  2416			ring->inspect = false;
  2417			qp = ring->switch_queue;
  2418			priv->ring_map[qp + port * num_tx_queues] = NULL;
  2419		}
  2420	
  2421		return 0;
  2422	}
  2423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

