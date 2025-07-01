Return-Path: <netdev+bounces-202731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA8AEEC56
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E236117C56E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D76195B1A;
	Tue,  1 Jul 2025 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bMtO2tJM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9111922FD
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336052; cv=none; b=huVNzbndQ1xGYGPlEM0hkOLhnWnusbIpqtwTJZu1Zxw0NEfqzhbN7JRyGOJIZPltEyJRdcoFusF2U+6zN1kLP8dBZz5Mf+RyJ/zyKdQCZu2ctBDCStVXo9A96I7rFbOitafv3gPYzrWZJVn+CNV50QnOsMXmRYKhthiE7cPhLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336052; c=relaxed/simple;
	bh=iPHCxGZDszhwtGJxO9kjQMnmNPNyQE/71FPYd8N9Fnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbXhhoYTeO84B3lEHSCKZ05jZclSEkQ2FYrVnjbFyrIOquoj9A8WhR/eaXQv/YM+wTZX1eNmF9HZzryV7x3Vmck4RhTMoiPkMisx7AuTr4g3mise/7dDqoDqSPlG4TsvMh+pF/OlIeiw7d8Rqn1Od14gS72BtIjLN4k87BjtPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bMtO2tJM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751336051; x=1782872051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iPHCxGZDszhwtGJxO9kjQMnmNPNyQE/71FPYd8N9Fnw=;
  b=bMtO2tJMKEeCVZs1qhenyiwS25JaYfLF5BpN4b5IAVKkJwx4wry0bMNr
   OVzwQ6+xjT0mIwzgpNPMoc2aA8M7IO9XUzBGn97Sjm20Kb3mWIVpK2zxU
   icvJyPFEce/RtWQi1wONgCHIqR0r61hPbPqu4cyZ+zU+8IfuJbY6BBUI6
   rai0KRjDvKeQPu9xdOZbYJLYtTui+F8nJUcCkKzVrth/iFI7BUM3ucOE6
   z5TnlPt2UvSyIowlfOLxzq8u0lK0jIlgQSvy3cDcuDhVbJYiU//uNqlLm
   T1mkOXxRIuF6EKzW7Xn1oDDQYSzemZhL5FeFrkR4Clvvu5orsH0oZubgj
   Q==;
X-CSE-ConnectionGUID: 2bFI4zt+TbiGHxrtoGH4wA==
X-CSE-MsgGUID: hKextEThTXup4qCteHuVQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53540692"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53540692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 19:14:10 -0700
X-CSE-ConnectionGUID: mD+MqkI4RDeyPuxCjz96rA==
X-CSE-MsgGUID: G6i+c8aGQMq5BR9v5c7hyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190798362"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Jun 2025 19:14:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWQVX-000ZXS-0l;
	Tue, 01 Jul 2025 02:14:03 +0000
Date: Tue, 1 Jul 2025 10:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, andrew@lunn.ch, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
	gal@nvidia.com, ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 4/5] net: ethtool: remove the compat code for
 _rxfh_context ops
Message-ID: <202507011009.04sxbKvR-lkp@intel.com>
References: <20250630160953.1093267-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630160953.1093267-5-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/eth-otx2-migrate-to-the-_rxfh_context-ops/20250701-002143
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250630160953.1093267-5-kuba%40kernel.org
patch subject: [PATCH net-next 4/5] net: ethtool: remove the compat code for _rxfh_context ops
config: arm-randconfig-r072-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011009.04sxbKvR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011009.04sxbKvR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011009.04sxbKvR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/dev.c: In function 'netdev_rss_contexts_free':
>> net/core/dev.c:11981:43: warning: variable 'rxfh' set but not used [-Wunused-but-set-variable]
   11981 |                 struct ethtool_rxfh_param rxfh;
         |                                           ^~~~


vim +/rxfh +11981 net/core/dev.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  11973  
6ad2962f8adfd5 Edward Cree    2024-06-27  11974  static void netdev_rss_contexts_free(struct net_device *dev)
6ad2962f8adfd5 Edward Cree    2024-06-27  11975  {
6ad2962f8adfd5 Edward Cree    2024-06-27  11976  	struct ethtool_rxfh_context *ctx;
6ad2962f8adfd5 Edward Cree    2024-06-27  11977  	unsigned long context;
6ad2962f8adfd5 Edward Cree    2024-06-27  11978  
87925151191b64 Edward Cree    2024-06-27  11979  	mutex_lock(&dev->ethtool->rss_lock);
6ad2962f8adfd5 Edward Cree    2024-06-27  11980  	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
6ad2962f8adfd5 Edward Cree    2024-06-27 @11981  		struct ethtool_rxfh_param rxfh;
6ad2962f8adfd5 Edward Cree    2024-06-27  11982  
6ad2962f8adfd5 Edward Cree    2024-06-27  11983  		rxfh.indir = ethtool_rxfh_context_indir(ctx);
6ad2962f8adfd5 Edward Cree    2024-06-27  11984  		rxfh.key = ethtool_rxfh_context_key(ctx);
6ad2962f8adfd5 Edward Cree    2024-06-27  11985  		rxfh.hfunc = ctx->hfunc;
6ad2962f8adfd5 Edward Cree    2024-06-27  11986  		rxfh.input_xfrm = ctx->input_xfrm;
6ad2962f8adfd5 Edward Cree    2024-06-27  11987  		rxfh.rss_context = context;
6ad2962f8adfd5 Edward Cree    2024-06-27  11988  		rxfh.rss_delete = true;
6ad2962f8adfd5 Edward Cree    2024-06-27  11989  
6ad2962f8adfd5 Edward Cree    2024-06-27  11990  		xa_erase(&dev->ethtool->rss_ctx, context);
122f0aaf307490 Jakub Kicinski 2025-06-30  11991  		dev->ethtool_ops->remove_rxfh_context(dev, ctx, context, NULL);
6ad2962f8adfd5 Edward Cree    2024-06-27  11992  		kfree(ctx);
6ad2962f8adfd5 Edward Cree    2024-06-27  11993  	}
6ad2962f8adfd5 Edward Cree    2024-06-27  11994  	xa_destroy(&dev->ethtool->rss_ctx);
87925151191b64 Edward Cree    2024-06-27  11995  	mutex_unlock(&dev->ethtool->rss_lock);
6ad2962f8adfd5 Edward Cree    2024-06-27  11996  }
6ad2962f8adfd5 Edward Cree    2024-06-27  11997  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

