Return-Path: <netdev+bounces-155163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F0A014E5
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 14:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5181816141E
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104323E49D;
	Sat,  4 Jan 2025 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RDeI2xgS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CE1DA32
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735995878; cv=none; b=oryzSmkMdf4cHGnLPuhi8PQtUH7X/GDGsD84Yi/iBfe6sx5n6zd+F1bHRx3vmYPlje1JYNqtutls/MO+C4PRBiRqzo5P3X3x/M5CVCSVTgqt9gX3oZow5BeN2eWRGgkDotIKJC1cB7bw4VwT+td4s48Bdiqg+gb5tgme7LGJ09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735995878; c=relaxed/simple;
	bh=JTpwKEeauwnLtZZ9wCrKCc+kFchiTHPNdQz9vvRAW94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ56SZTO2vaCAL+P9x5eeATcUQZTm6+pNOt2GOVjStJtct2BwN2dlj5wiDalRG0DaIb0HbdbiscykjHVB4Qi+YSQhK/NjxiZmRIG2ZYSHIHKQWMhIsPVK/pkNrT4uukvaliVJcg166fX5yhB43eRftEOyr0ZGr6y4DaGY5/mCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RDeI2xgS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735995877; x=1767531877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JTpwKEeauwnLtZZ9wCrKCc+kFchiTHPNdQz9vvRAW94=;
  b=RDeI2xgSBEICW5Wv7uTEOCySCYek0u6JYUTtrkWYBvdgHE0OuYlPTog5
   NRRk7RLEcebgu+ENk7yBw63EtEgOPN0HSOAQ9tr/LAYhmQwS/GC6zKhDs
   srFo59pvC/1Mqtlr3T0/dEDAyH3sZIUAn+jNW/rEV9IwnSnRxfaUcuAHY
   Hhi3wXBEs9DFbdoYNOKY3obHrIjac7Lg6Wc/Ihg8Brx51f2cm1Vg2K3Hi
   JiGHZHB45q/4KWAH7pD/F4v9zrI+IzYHgYxTBh8Z+SzIOFHzP6p7w/9T0
   cbOpIGWYFSdbWMxSVTEbgBkaz0T84SP9to02pWrMfoUntoWAngOdxkdHN
   Q==;
X-CSE-ConnectionGUID: /D9GXzF1RAy8gEffXW0SBA==
X-CSE-MsgGUID: qflGP3osR16JNLMyEsuJQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11304"; a="61587790"
X-IronPort-AV: E=Sophos;i="6.12,288,1728975600"; 
   d="scan'208";a="61587790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 05:04:37 -0800
X-CSE-ConnectionGUID: kcBQ+cHERjiaWxsC721hng==
X-CSE-MsgGUID: U+axFSXCRdi3vWtyWEs6Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="132931847"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jan 2025 05:02:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tU3na-000Av1-0X;
	Sat, 04 Jan 2025 13:02:38 +0000
Date: Sat, 4 Jan 2025 21:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
Message-ID: <202501042032.NTXMscn3-lkp@intel.com>
References: <20250104004314.208259-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104004314.208259-2-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-move-ARFS-rmap-management-to-core/20250104-084501
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250104004314.208259-2-ahmed.zaki%40intel.com
patch subject: [PATCH net-next v3 1/6] net: move ARFS rmap management to core
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20250104/202501042032.NTXMscn3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501042032.NTXMscn3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501042032.NTXMscn3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/amazon/ena/ena_netdev.c: In function 'ena_init_rx_cpu_rmap':
>> drivers/net/ethernet/amazon/ena/ena_netdev.c:165:16: error: too few arguments to function 'netif_enable_cpu_rmap'
     165 |         return netif_enable_cpu_rmap(adapter->netdev);
         |                ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/net/inet_sock.h:19,
                    from include/net/ip.h:29,
                    from drivers/net/ethernet/amazon/ena/ena_netdev.c:16:
   include/linux/netdevice.h:2769:5: note: declared here
    2769 | int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs);
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/amazon/ena/ena_netdev.c:169:1: warning: control reaches end of non-void function [-Wreturn-type]
     169 | }
         | ^


vim +/netif_enable_cpu_rmap +165 drivers/net/ethernet/amazon/ena/ena_netdev.c

   161	
   162	static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
   163	{
   164	#ifdef CONFIG_RFS_ACCEL
 > 165		return netif_enable_cpu_rmap(adapter->netdev);
   166	#else
   167		return 0;
   168	#endif /* CONFIG_RFS_ACCEL */
   169	}
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

