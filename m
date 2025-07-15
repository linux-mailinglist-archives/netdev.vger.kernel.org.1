Return-Path: <netdev+bounces-206959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DCFB04DD3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8AD3AC5DC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D82C375A;
	Tue, 15 Jul 2025 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKx0vpof"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F0155A4E;
	Tue, 15 Jul 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546418; cv=none; b=qJX38F/QKDlubQC7hchpsqwPsHRFJ4NY9iaE0dW2+Xh7TXmGl12k2v2+orY/Q1lLW+xKoy4+eOH1qgR8fSWce/nmo4o89i9bBJbFtOvPPBYPa4ecftE0vs9KcfC2pBR8+v/6xJbB7c43cfchcmAu0Lp20J22qAmlEMpT958xzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546418; c=relaxed/simple;
	bh=Ujnob99Q1tbnulMBj8KaddK7Fv/QJIO7q/kyxmWNnkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6ko/v0cXDsZmiTJZ3DjzSBJxrwRBVgtHrVIxtGLgfv5hKX8/GlpQ9Dt1Kiny0u8vTVdg6MueMJ4JzL3I+L91NFMHFwHLcQvCylKAH2OtbRFFfG4EIu65rvxiZzP8/Yo0oQg3ami/AdMUS2SP4LXP79PNRvB/D37yQhf00dyLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKx0vpof; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752546417; x=1784082417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ujnob99Q1tbnulMBj8KaddK7Fv/QJIO7q/kyxmWNnkE=;
  b=CKx0vpofX0e0YhJ2FQXbvN37TKF+llqoa+03u69BAlG4/Y1DQtGbRw7n
   oJajDZT6b/8uO7T5goPbG8dumO8pJ+Bqizq777KyX5XdWCDTtqSmudmpe
   XKb0OGvRLM/xay20jY0kzaTd0O+l0mR4s5DkpboHvgoS2wGu88SyrsYc+
   3YEMM4E2ead4ef5RF142m4seELIUj5eRAu4KFVIPlFP+IAS9jT7ecJ3fy
   FFUw5FwxA2SjmdcU5y+QO4d6Y1BjbWNSzYUGBZdomD5DUYRjiTUSby0rv
   ExDwm8qHeru659RRIrvCiZRms8sOIqicIWDqmE72M0fUiKmzNzfwh/4bj
   Q==;
X-CSE-ConnectionGUID: VXqcR1aPRwO2KTtvFt1/SQ==
X-CSE-MsgGUID: 1yZQUItIQcKKpxRqURyQnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65820894"
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="65820894"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 19:26:56 -0700
X-CSE-ConnectionGUID: 9uw3vWQIQwGO/ZRug3zguw==
X-CSE-MsgGUID: Eva3mBvYT228wfLZ819tDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,312,1744095600"; 
   d="scan'208";a="156509551"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 14 Jul 2025 19:26:53 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubVNa-0009YN-38;
	Tue, 15 Jul 2025 02:26:50 +0000
Date: Tue, 15 Jul 2025 10:26:34 +0800
From: kernel test robot <lkp@intel.com>
To: aspeedyh <yh_chung@aspeedtech.com>, jk@codeconstruct.com.au,
	matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bmc-sw@aspeedtech.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Message-ID: <202507151015.GPkeA21H-lkp@intel.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714062544.2612693-1-yh_chung@aspeedtech.com>

Hi aspeedyh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.16-rc6 next-20250714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/aspeedyh/net-mctp-Add-MCTP-PCIe-VDM-transport-driver/20250714-142656
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250714062544.2612693-1-yh_chung%40aspeedtech.com
patch subject: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20250715/202507151015.GPkeA21H-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507151015.GPkeA21H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507151015.GPkeA21H-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/mctp/mctp-pcie-vdm.c:491:4: warning: variable 'vdm_dev' is uninitialized when used here [-Wuninitialized]
     491 |                  vdm_dev->ndev->name);
         |                  ^~~~~~~
   include/linux/printk.h:631:26: note: expanded from macro 'pr_debug'
     631 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:270:22: note: expanded from macro 'dynamic_pr_debug'
     270 |                            pr_fmt(fmt), ##__VA_ARGS__)
         |                                           ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcie-vdm.c:484:35: note: initialize the variable 'vdm_dev' to silence this warning
     484 |         struct mctp_pcie_vdm_dev *vdm_dev;
         |                                          ^
         |                                           = NULL
   1 warning generated.


vim +/vdm_dev +491 drivers/net/mctp/mctp-pcie-vdm.c

   481	
   482	static void mctp_pcie_vdm_uninit(struct net_device *ndev)
   483	{
   484		struct mctp_pcie_vdm_dev *vdm_dev;
   485	
   486		struct mctp_pcie_vdm_route_info *route;
   487		struct hlist_node *tmp;
   488		int bkt;
   489	
   490		pr_debug("%s: uninitializing vdm_dev %s\n", __func__,
 > 491			 vdm_dev->ndev->name);
   492	
   493		vdm_dev = netdev_priv(ndev);
   494		vdm_dev->callback_ops->uninit(vdm_dev->dev);
   495	
   496		hash_for_each_safe(vdm_dev->route_table, bkt, tmp, route, hnode) {
   497			hash_del(&route->hnode);
   498			kfree(route);
   499		}
   500	
   501		if (vdm_dev->tx_thread) {
   502			kthread_stop(vdm_dev->tx_thread);
   503			vdm_dev->tx_thread = NULL;
   504		}
   505	
   506		if (mctp_pcie_vdm_wq) {
   507			cancel_work_sync(&vdm_dev->rx_work);
   508			flush_workqueue(mctp_pcie_vdm_wq);
   509			destroy_workqueue(mctp_pcie_vdm_wq);
   510			mctp_pcie_vdm_wq = NULL;
   511		}
   512	
   513		while (__ptr_ring_peek(&vdm_dev->tx_queue)) {
   514			struct sk_buff *skb;
   515	
   516			skb = ptr_ring_consume(&vdm_dev->tx_queue);
   517	
   518			if (skb)
   519				kfree_skb(skb);
   520		}
   521	
   522		mutex_lock(&mctp_pcie_vdm_dev_mutex);
   523		list_del(&vdm_dev->list);
   524		mutex_unlock(&mctp_pcie_vdm_dev_mutex);
   525	}
   526	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

