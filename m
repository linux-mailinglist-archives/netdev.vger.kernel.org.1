Return-Path: <netdev+bounces-120682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6F95A335
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6891E1C2142E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85681A7AC6;
	Wed, 21 Aug 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFGP+2ov"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249CE14E2EF
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259175; cv=none; b=oY3XK/vQOGRnlsqrHCnzD5v4hBLTb8yYpZstZwWKn0SDx3G2ruX/JPm+Z54m/2cfx+FOyU8BsSbl6w/jyyXvjTh5Dqxpg2Vi2gygQYITaOiihVaZa4Co/MMWGt++6rMKidctTo5iSX76lPb0vLRSm0Tg+8vK/QFkzDbQSJ3Yu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259175; c=relaxed/simple;
	bh=Y/TI49HrIoqduIXBi9wKMVRCJUI6A0xpIOJpE8a7hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8iXAbq8BrXEHuXidh2N5FcZQPGfgbckDg3Lrj3xOZvzRYzR3IQxExlikDIFPGuc2cSMMwELTIOGQwOXUn/zzQVquhK/GKk0LDz56nvsQKwrtr/lPnjnqPkyxkCGlrXO9LuZhEgKTnkQ9TZwLJSHtXA+zrCcLZWNNZu4qtne9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFGP+2ov; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724259174; x=1755795174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/TI49HrIoqduIXBi9wKMVRCJUI6A0xpIOJpE8a7hpg=;
  b=lFGP+2ovAyG9AmutVs5Wef2CKrvv50zmXOgWfPfeyyCPr3as2i0d4pZt
   vQzRz8pyNjHs/qQK6KP/q/ESO1To1+5bcN/heqwBrscpRObpWWz9sgwB8
   d4mlir4bbT+JdZsW/6GDHoTNF3BxpP2lfYyMdQVsqwMzlKOlkStsdR/7i
   EzCyRGscs5iHanMcm3PKmWYf15hTQeMyVS/s4OA4Bs/EOjfnFeuH03Xul
   tNo7fDHyMaTA5n/AFWhr4wIk/4KzvJ8nKzSPelgLAYZ4H1fDVQVfb1YpA
   UIGWWZBgrvXTx5magHYrs4UiKWtk5NiCi2wgESSTCX/BOq0GjSGKmUMrS
   A==;
X-CSE-ConnectionGUID: 0a+EPoSnQWaos4Xf6c3O5Q==
X-CSE-MsgGUID: kkOQwh42TGGRHZ1AjHT4tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45157831"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45157831"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 09:52:53 -0700
X-CSE-ConnectionGUID: +8lGa9ZyTDK1AhFAGgDOeA==
X-CSE-MsgGUID: LtjGAxhITau560W6TWbwIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="66036904"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Aug 2024 09:52:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgoZj-000BiK-31;
	Wed, 21 Aug 2024 16:52:47 +0000
Date: Thu, 22 Aug 2024 00:52:44 +0800
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
Subject: Re: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
Message-ID: <202408220027.kA3pRF6J-lkp@intel.com>
References: <4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/tools-ynl-lift-an-assumption-about-spec-file-name/20240820-231626
base:   net-next/main
patch link:    https://lore.kernel.org/r/4cf74f285fa5f07be546cb83ef96775f86aa0dbf.1724165948.git.pabeni%40redhat.com
patch subject: [PATCH v4 net-next 09/12] testing: net-drv: add basic shaper test
config: hexagon-randconfig-r112-20240821 (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce: (https://download.01.org/0day-ci/archive/20240822/202408220027.kA3pRF6J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408220027.kA3pRF6J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/shaper/shaper.c:227:24: sparse: sparse: Using plain integer as NULL pointer

vim +227 net/shaper/shaper.c

d8a22f9bfdaade Paolo Abeni 2024-08-20  208  
d8a22f9bfdaade Paolo Abeni 2024-08-20  209  /* Allocate on demand the per device shaper's cache. */
d8a22f9bfdaade Paolo Abeni 2024-08-20  210  static struct mutex *net_shaper_cache_init(struct net_device *dev,
d8a22f9bfdaade Paolo Abeni 2024-08-20  211  					   struct netlink_ext_ack *extack)
d8a22f9bfdaade Paolo Abeni 2024-08-20  212  {
d8a22f9bfdaade Paolo Abeni 2024-08-20  213  	struct net_shaper_data *new, *data = READ_ONCE(dev->net_shaper_data);
d8a22f9bfdaade Paolo Abeni 2024-08-20  214  
d8a22f9bfdaade Paolo Abeni 2024-08-20  215  	if (!data) {
d8a22f9bfdaade Paolo Abeni 2024-08-20  216  		new = kmalloc(sizeof(*dev->net_shaper_data), GFP_KERNEL);
d8a22f9bfdaade Paolo Abeni 2024-08-20  217  		if (!new) {
d8a22f9bfdaade Paolo Abeni 2024-08-20  218  			NL_SET_ERR_MSG(extack, "Can't allocate memory for shaper data");
d8a22f9bfdaade Paolo Abeni 2024-08-20  219  			return NULL;
d8a22f9bfdaade Paolo Abeni 2024-08-20  220  		}
d8a22f9bfdaade Paolo Abeni 2024-08-20  221  
d8a22f9bfdaade Paolo Abeni 2024-08-20  222  		mutex_init(&new->lock);
d8a22f9bfdaade Paolo Abeni 2024-08-20  223  		xa_init(&new->shapers);
d8a22f9bfdaade Paolo Abeni 2024-08-20  224  		idr_init(&new->node_ids);
d8a22f9bfdaade Paolo Abeni 2024-08-20  225  
d8a22f9bfdaade Paolo Abeni 2024-08-20  226  		/* No lock acquired yet, we can race with other operations. */
d8a22f9bfdaade Paolo Abeni 2024-08-20 @227  		data = cmpxchg(&dev->net_shaper_data, NULL, new);
d8a22f9bfdaade Paolo Abeni 2024-08-20  228  		if (!data)
d8a22f9bfdaade Paolo Abeni 2024-08-20  229  			data = new;
d8a22f9bfdaade Paolo Abeni 2024-08-20  230  		else
d8a22f9bfdaade Paolo Abeni 2024-08-20  231  			kfree(new);
d8a22f9bfdaade Paolo Abeni 2024-08-20  232  	}
d8a22f9bfdaade Paolo Abeni 2024-08-20  233  	return &data->lock;
d8a22f9bfdaade Paolo Abeni 2024-08-20  234  }
d8a22f9bfdaade Paolo Abeni 2024-08-20  235  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

