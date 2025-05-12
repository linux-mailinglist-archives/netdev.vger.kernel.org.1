Return-Path: <netdev+bounces-189708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA21AB3439
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E217CCD4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0125F962;
	Mon, 12 May 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPQD7xuC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05A25EFAA;
	Mon, 12 May 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043846; cv=none; b=Xg6Efg3YlOUnyiKwM5AeUgvlYUaR/UZkyayu9Er2ZUfs+xlMZiSbR6hRtrZ41F+HcTz2Lun6BrVzkhDbfG+ij23vLA95ChrIUjeZRYF3kZHKb+aw0hzweGnLeyKJxdAurF7nMZLGF5Et0Jfkj8PKEtohzYLvx2xdWsfW/rEQpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043846; c=relaxed/simple;
	bh=OVrrVmmE+WpbFZ1HWOWb7g8y+PYT8XxY5T8O7Y6OWRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3YjUAs8WMnNnx7Meo7xRb511l0SxQFdYYD8iOpjEAFvyKXmyzco53362WZnWjnay/ZhriN8zqflK6Lem3sqGtt7PMyDySEsZun1swxoOMBF3kzFPSRSCiQ0Tjdo8vrtvlNK0XGXa9Y/jvsRCEloDKfKwuUXyA2dVoj3ROIkfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPQD7xuC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747043845; x=1778579845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVrrVmmE+WpbFZ1HWOWb7g8y+PYT8XxY5T8O7Y6OWRs=;
  b=KPQD7xuCWVrHAqoPXlln22QylRDvxOEuQZVYXDO4wNfUVNp2PzgQadUP
   ehJ/T91x7pZCv0CYB3ArGMseBKL6t60m/ft+Pt8LJxFEPzA2Py5JN5rFd
   iWrkXK9Kap59VOfx/Wi/wwhmvkGGtb9es1e2UYSTFIYOdUcuDaBmk5X7D
   zuuJauUo9lJFYuYStvliNbx3ygKj7lGGmoa6LxgA3myQTw+SO+pYt36pP
   WEeFZgijVKgayaK9UjwEeLk6vnwkhXInmPXsfghLEGFtUioXp1+NmGLyu
   kp1rBHtRZixQIinVhS8tTHl9wfzwt+oePceh6uAqqA1ii0qcmyRizE+jx
   Q==;
X-CSE-ConnectionGUID: 1zVaq6IOQjG4sYt9hOkBYA==
X-CSE-MsgGUID: MtXVDwhmTgGtX1uvtSN4jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59833524"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59833524"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:57:24 -0700
X-CSE-ConnectionGUID: /4gs+ntqQIWpW1pN6xvDAw==
X-CSE-MsgGUID: rXSkwKtQS7mezoUXuArdLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="168393831"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 May 2025 02:57:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEPuQ-000ELv-0M;
	Mon, 12 May 2025 09:57:18 +0000
Date: Mon, 12 May 2025 17:57:02 +0800
From: kernel test robot <lkp@intel.com>
To: zakkemble@gmail.com, Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Zak Kemble <zakkemble@gmail.com>
Subject: Re: [PATCH] net: bcmgenet: tidy up stats, expose more stats in
 ethtool
Message-ID: <202505121424.5NKdmAPP-lkp@intel.com>
References: <20250511214037.2805-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511214037.2805-1-zakkemble@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.15-rc6 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zakkemble-gmail-com/net-bcmgenet-tidy-up-stats-expose-more-stats-in-ethtool/20250512-054217
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250511214037.2805-1-zakkemble%40gmail.com
patch subject: [PATCH] net: bcmgenet: tidy up stats, expose more stats in ethtool
config: x86_64-buildonly-randconfig-003-20250512 (https://download.01.org/0day-ci/archive/20250512/202505121424.5NKdmAPP-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250512/202505121424.5NKdmAPP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505121424.5NKdmAPP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/genet/bcmgenet.c:3552:31: warning: variable 'broadcast' set but not used [-Wunused-but-set-variable]
    3552 |         unsigned long multicast = 0, broadcast = 0;
         |                                      ^
   1 warning generated.


vim +/broadcast +3552 drivers/net/ethernet/broadcom/genet/bcmgenet.c

  3541	
  3542	static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
  3543	{
  3544		struct bcmgenet_priv *priv = netdev_priv(dev);
  3545		unsigned long tx_bytes = 0, tx_packets = 0;
  3546		unsigned long tx_errors = 0, tx_dropped = 0;
  3547		unsigned long rx_bytes = 0, rx_packets = 0;
  3548		unsigned long rx_errors = 0, rx_dropped = 0;
  3549		unsigned long rx_missed = 0, rx_length_errors = 0;
  3550		unsigned long rx_over_errors = 0, rx_crc_errors = 0;
  3551		unsigned long rx_frame_errors = 0, rx_fragmented_errors = 0;
> 3552		unsigned long multicast = 0, broadcast = 0;
  3553		struct bcmgenet_tx_ring *tx_ring;
  3554		struct bcmgenet_rx_ring *rx_ring;
  3555		unsigned int q;
  3556	
  3557		for (q = 0; q <= priv->hw_params->tx_queues; q++) {
  3558			tx_ring = &priv->tx_rings[q];
  3559			tx_bytes += tx_ring->bytes;
  3560			tx_packets += tx_ring->packets;
  3561			tx_errors += tx_ring->errors;
  3562			tx_dropped += tx_ring->dropped;
  3563		}
  3564	
  3565		for (q = 0; q <= priv->hw_params->rx_queues; q++) {
  3566			rx_ring = &priv->rx_rings[q];
  3567	
  3568			rx_bytes += rx_ring->bytes;
  3569			rx_packets += rx_ring->packets;
  3570			rx_errors += rx_ring->errors;
  3571			rx_dropped += rx_ring->dropped;
  3572			rx_missed += rx_ring->missed;
  3573			rx_length_errors += rx_ring->length_errors;
  3574			rx_over_errors += rx_ring->over_errors;
  3575			rx_crc_errors += rx_ring->crc_errors;
  3576			rx_frame_errors += rx_ring->frame_errors;
  3577			rx_fragmented_errors += rx_ring->fragmented_errors;
  3578			multicast += rx_ring->multicast;
  3579			broadcast += rx_ring->broadcast;
  3580		}
  3581	
  3582		rx_errors += rx_length_errors;
  3583		rx_errors += rx_crc_errors;
  3584		rx_errors += rx_frame_errors;
  3585		rx_errors += rx_fragmented_errors;
  3586	
  3587		dev->stats.tx_bytes = tx_bytes;
  3588		dev->stats.tx_packets = tx_packets;
  3589		dev->stats.tx_errors = tx_errors;
  3590		dev->stats.tx_dropped = tx_dropped;
  3591		dev->stats.rx_bytes = rx_bytes;
  3592		dev->stats.rx_packets = rx_packets;
  3593		dev->stats.rx_errors = rx_errors;
  3594		dev->stats.rx_dropped = rx_dropped;
  3595		dev->stats.rx_missed_errors = rx_missed;
  3596		dev->stats.rx_length_errors = rx_length_errors;
  3597		dev->stats.rx_over_errors = rx_over_errors;
  3598		dev->stats.rx_crc_errors = rx_crc_errors;
  3599		dev->stats.rx_frame_errors = rx_frame_errors;
  3600		dev->stats.multicast = multicast;
  3601		return &dev->stats;
  3602	}
  3603	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

