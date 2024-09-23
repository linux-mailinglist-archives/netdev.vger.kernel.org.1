Return-Path: <netdev+bounces-129370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E697F135
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135B8282EBB
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AFF19F470;
	Mon, 23 Sep 2024 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhGKvI/i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B281990BE;
	Mon, 23 Sep 2024 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120087; cv=none; b=Soh83WFm15dksOMaAJczzCfKCwTTD3K6l5Kg0JeeD5Om0a0i5Ws6OOqiLhd0OgBLZiTQjvMIfKOCmk+QxyL3xY09unRj3HelgnU8XiX5X5js+XLHfuGSnfztlLq56vJZlQ5MAQw1XZPg0cTaCFqnt+8psrWu2HdJxTLCwXX/3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120087; c=relaxed/simple;
	bh=biyHAEvDNhcaETv/82KwAxsk9sxH7MzhnIvKQ2imhro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utGirms9NTSZeTsgYF0fY22/XV8Jx8Qr4nZxP25/QHiYFSnhEhcbbjnLolRgsHeOY5Mk1wpHhLvXJYj2ZHj0UdIoGhY/nN50H7rXTPPrMRW1hDceyhRIoFWkXjlMhtS5QYTOmuZ2Ocror+6hLbXKMIbyqim3FGr0AbQRWbrZh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhGKvI/i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727120086; x=1758656086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=biyHAEvDNhcaETv/82KwAxsk9sxH7MzhnIvKQ2imhro=;
  b=KhGKvI/i7Ar9vuENILnrhfp3Udq5afwMAn7/i60FSVcW2ZHC9pjnvrAr
   QNXb9G5pa1vgdAMAeqIcfaX0rOM5f9TAeWn2Lnw84PDdMfAKckZYItc6w
   +aJdsSR8Aica0MODj6ec4Sswzl5v8pMx3lcfGhnWs+mCHEP2z29agdEVN
   RlmUeOZD4RIKx+GrOUZEseLBwboV2EnNYuE1lwKRcACyERLmRGoGRWnQI
   O0tzpDCV92ZGMSVd++wQ9d8Svu3CIXoZI+w6DgC2DiaYVxlhLfHjzsm4d
   72/afzKQR5epn9IKOoI2f2e2veTFKaLzRgb6oERgvT3lCMrMM3V0yhXo/
   A==;
X-CSE-ConnectionGUID: BLeTXRSIRLWGzshW6Vyj2g==
X-CSE-MsgGUID: c5J75qcXRweHM0U4SdfRdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26237739"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26237739"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 12:34:45 -0700
X-CSE-ConnectionGUID: hjUbnBAdTUiViA+UhhG5SA==
X-CSE-MsgGUID: W3oIlJfKSAa45oNHKW0Nvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="101896288"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Sep 2024 12:34:42 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssopT-000HXm-2S;
	Mon, 23 Sep 2024 19:34:39 +0000
Date: Tue, 24 Sep 2024 03:33:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dipendra Khadka <kdipendra88@gmail.com>, andrew@lunn.ch,
	florian.fainelli@broadcom.com, davem@davemloft.net,
	edumazet@google.com, bcm-kernel-feedback-list@broadcom.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dipendra Khadka <kdipendra88@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
Message-ID: <202409240323.wQPM6V1v-lkp@intel.com>
References: <20240923053900.1310-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923053900.1310-1-kdipendra88@gmail.com>

Hi Dipendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dipendra-Khadka/net-Add-error-pointer-check-in-bcmsysport-c/20240923-134407
base:   net/main
patch link:    https://lore.kernel.org/r/20240923053900.1310-1-kdipendra88%40gmail.com
patch subject: [PATCH v2 net] net: Add error pointer check in bcmsysport.c
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240924/202409240323.wQPM6V1v-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240323.wQPM6V1v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240323.wQPM6V1v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bcmsysport.c:2341:10: error: call to undeclared function 'PRT_ERR'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2341 |                 return PRT_ERR(dp);
         |                        ^
   drivers/net/ethernet/broadcom/bcmsysport.c:2341:10: note: did you mean 'PTR_ERR'?
   include/linux/err.h:49:33: note: 'PTR_ERR' declared here
      49 | static inline long __must_check PTR_ERR(__force const void *ptr)
         |                                 ^
   1 error generated.


vim +/PRT_ERR +2341 drivers/net/ethernet/broadcom/bcmsysport.c

  2330	
  2331	static int bcm_sysport_map_queues(struct net_device *dev,
  2332					  struct net_device *slave_dev)
  2333	{
  2334		struct dsa_port *dp = dsa_port_from_netdev(slave_dev);
  2335		struct bcm_sysport_priv *priv = netdev_priv(dev);
  2336		struct bcm_sysport_tx_ring *ring;
  2337		unsigned int num_tx_queues;
  2338		unsigned int q, qp, port;
  2339	
  2340		if (IS_ERR(dp))
> 2341			return PRT_ERR(dp);
  2342	
  2343		/* We can't be setting up queue inspection for non directly attached
  2344		 * switches
  2345		 */
  2346		if (dp->ds->index)
  2347			return 0;
  2348	
  2349		port = dp->index;
  2350	
  2351		/* On SYSTEMPORT Lite we have twice as less queues, so we cannot do a
  2352		 * 1:1 mapping, we can only do a 2:1 mapping. By reducing the number of
  2353		 * per-port (slave_dev) network devices queue, we achieve just that.
  2354		 * This need to happen now before any slave network device is used such
  2355		 * it accurately reflects the number of real TX queues.
  2356		 */
  2357		if (priv->is_lite)
  2358			netif_set_real_num_tx_queues(slave_dev,
  2359						     slave_dev->num_tx_queues / 2);
  2360	
  2361		num_tx_queues = slave_dev->real_num_tx_queues;
  2362	
  2363		if (priv->per_port_num_tx_queues &&
  2364		    priv->per_port_num_tx_queues != num_tx_queues)
  2365			netdev_warn(slave_dev, "asymmetric number of per-port queues\n");
  2366	
  2367		priv->per_port_num_tx_queues = num_tx_queues;
  2368	
  2369		for (q = 0, qp = 0; q < dev->num_tx_queues && qp < num_tx_queues;
  2370		     q++) {
  2371			ring = &priv->tx_rings[q];
  2372	
  2373			if (ring->inspect)
  2374				continue;
  2375	
  2376			/* Just remember the mapping actual programming done
  2377			 * during bcm_sysport_init_tx_ring
  2378			 */
  2379			ring->switch_queue = qp;
  2380			ring->switch_port = port;
  2381			ring->inspect = true;
  2382			priv->ring_map[qp + port * num_tx_queues] = ring;
  2383			qp++;
  2384		}
  2385	
  2386		return 0;
  2387	}
  2388	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

