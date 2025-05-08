Return-Path: <netdev+bounces-188921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A69AAF633
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCBFB9E052C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E32144BF;
	Thu,  8 May 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDFg46TJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4692557C;
	Thu,  8 May 2025 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746694846; cv=none; b=Yw61jvz2A3uV6R6AsIam3IqXWG5lNCjbODV4CuJi4XEq7mGp+8Kza7QlkpwpNNTa9KL9h8abTkZanhYLFpdYcy7um44bPGVW/VNHhVeARhsb4NbQBA/Z/o/rUhLdsVvrBOrlFragLU+QDGjCnwVhqg1JiR+Coy00uzgX7FFMyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746694846; c=relaxed/simple;
	bh=ROSi/Orgbexv11jRgsW2OyCxC3aIhDhDNPIcDThao00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7Umajn2sycXOmtz0YHQ8txJndnQOKtB1DyCGLUsdLIvG3h5BT2DBUl4L3thDnQN0GWCWddnektnnxPvEJ0fC/rTZUXvBP8HSrCeO+a+LUo73Kqi7N2Ugjrksbg1jYCz+6EexXM5Y1T79PAfCba57nostVHpfQWXVu1x3HNSXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDFg46TJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746694845; x=1778230845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ROSi/Orgbexv11jRgsW2OyCxC3aIhDhDNPIcDThao00=;
  b=fDFg46TJ8pCHlpQUuAVymCLoE4TQ5iFCpZyz9yRcwx6fNKFOVcNEnvKJ
   FHUFzr6Y+6Bf7CgLKuobUMCtOPFvBHM2iMaAuZos2F0xEWRjHEDAG5ao9
   4huP6cT9Zqaqo4K2jNZORrkscBqoVyaKEEfbHACN483rxB6mq6ypxyNbM
   UXJlrloYnzKId5ILOrnf7T3WoLDfbYAtJUqnqamGVucUgT9xyIUe5KG3A
   gwL5u5NfXZNYxOqyCkLKtAXwLPwKVsU3j1B8cGfcdyuTtB+pczOWcF412
   Bdd2y5RSI6ef6d4DjCIethDhOQMdn0jG+Y5m5Y0DNexOz2xKdNtmHypKl
   A==;
X-CSE-ConnectionGUID: iA2pm336TiqfFxJwKo0WHQ==
X-CSE-MsgGUID: +PvKgsoHTmC3GxkOw4gm4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48550097"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48550097"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 02:00:44 -0700
X-CSE-ConnectionGUID: 8ne1VkpKSKGUTK3JlySqFw==
X-CSE-MsgGUID: 1IfokcpxT6e6H6SFHsVAmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136160406"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 May 2025 02:00:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCx7L-000AoB-3B;
	Thu, 08 May 2025 09:00:35 +0000
Date: Thu, 8 May 2025 17:00:04 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
Message-ID: <202505081612.wbRgFMC7-lkp@intel.com>
References: <20250505142427.9601-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505142427.9601-3-wahrenst@gmx.net>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wahren/dt-bindings-vertexcom-mse102x-Fix-IRQ-type-in-example/20250505-222628
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250505142427.9601-3-wahrenst%40gmx.net
patch subject: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about IRQ trigger type
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250508/202505081612.wbRgFMC7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081612.wbRgFMC7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081612.wbRgFMC7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/vertexcom/mse102x.c: In function 'mse102x_net_open':
   drivers/net/ethernet/vertexcom/mse102x.c:525:37: error: implicit declaration of function 'irq_get_irq_data'; did you mean 'irq_set_irq_wake'? [-Werror=implicit-function-declaration]
     525 |         struct irq_data *irq_data = irq_get_irq_data(ndev->irq);
         |                                     ^~~~~~~~~~~~~~~~
         |                                     irq_set_irq_wake
>> drivers/net/ethernet/vertexcom/mse102x.c:525:37: warning: initialization of 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/ethernet/vertexcom/mse102x.c:535:17: error: implicit declaration of function 'irqd_get_trigger_type'; did you mean 'led_get_trigger_data'? [-Werror=implicit-function-declaration]
     535 |         switch (irqd_get_trigger_type(irq_data)) {
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 led_get_trigger_data
   drivers/net/ethernet/vertexcom/mse102x.c:536:14: error: 'IRQ_TYPE_LEVEL_HIGH' undeclared (first use in this function)
     536 |         case IRQ_TYPE_LEVEL_HIGH:
         |              ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/vertexcom/mse102x.c:536:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/vertexcom/mse102x.c:537:14: error: 'IRQ_TYPE_LEVEL_LOW' undeclared (first use in this function)
     537 |         case IRQ_TYPE_LEVEL_LOW:
         |              ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +525 drivers/net/ethernet/vertexcom/mse102x.c

   522	
   523	static int mse102x_net_open(struct net_device *ndev)
   524	{
 > 525		struct irq_data *irq_data = irq_get_irq_data(ndev->irq);
   526		struct mse102x_net *mse = netdev_priv(ndev);
   527		struct mse102x_net_spi *mses = to_mse102x_spi(mse);
   528		int ret;
   529	
   530		if (!irq_data) {
   531			netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
   532			return -EINVAL;
   533		}
   534	
   535		switch (irqd_get_trigger_type(irq_data)) {
   536		case IRQ_TYPE_LEVEL_HIGH:
   537		case IRQ_TYPE_LEVEL_LOW:
   538			break;
   539		default:
   540			netdev_warn_once(ndev, "Only IRQ type level recommended, please update your firmware.\n");
   541			break;
   542		}
   543	
   544		ret = request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
   545					   ndev->name, mse);
   546		if (ret < 0) {
   547			netdev_err(ndev, "Failed to get irq: %d\n", ret);
   548			return ret;
   549		}
   550	
   551		netif_dbg(mse, ifup, ndev, "opening\n");
   552	
   553		netif_start_queue(ndev);
   554	
   555		netif_carrier_on(ndev);
   556	
   557		/* The SPI interrupt can stuck in case of pending packet(s).
   558		 * So poll for possible packet(s) to re-arm the interrupt.
   559		 */
   560		mutex_lock(&mses->lock);
   561		mse102x_rx_pkt_spi(mse);
   562		mutex_unlock(&mses->lock);
   563	
   564		netif_dbg(mse, ifup, ndev, "network device up\n");
   565	
   566		return 0;
   567	}
   568	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

