Return-Path: <netdev+bounces-89926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF08D8AC3D2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 07:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB52282C42
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933A1B28D;
	Mon, 22 Apr 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz40AVDi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E231AAC4
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764461; cv=none; b=kffUzvJdUwo9JUPr0Bh0oFrspkP6y7scCBl9rZ9tIa7kH5gdxnjg/DHET7AmKlferKB1QG0tOqR5HrhSe4va7/Q2CdJkgcCU6o/+UoiQIJP8NHb5TyVOIKbw7L5JdLDmC7mGc2hch8njF5mnRBSC8lWAu1SSlLKtwy4iFSGPVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764461; c=relaxed/simple;
	bh=4f6CdVZ5/bQHnDzzB+jKjXSkyvjb7mGhj1xr4FJ1NXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4B6jZSTrKgitAymMrKa8uExgGWsjC58otR5L4L7/1wYU6hsgDmn6U1HQjP+i4Beov0144X56IQHHpNO+dq2BIBuHcoKQVLlHZODeI4yHDahjyqww8KJ98+yrJzpcW6Wk3HdbM9acpClwTD7OrNJuGod3xbBhh57CzOd2+2Xi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cz40AVDi; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713764460; x=1745300460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4f6CdVZ5/bQHnDzzB+jKjXSkyvjb7mGhj1xr4FJ1NXU=;
  b=Cz40AVDipCxa3y84OMnQbZV8olw1FeNbASmkffQ/p93mX7Tr1kqAk8rK
   +3FnhYkFsgJxvSL34md8hI9WBr70J6CoNssZTQ5CRqMpFZYgorqt2JFTs
   T7XpiJCwsFh2x/ScgKq+yZQgH24Cun5izxHnxQKsOBrqxW4i5XhOxiukW
   NQgSDYFW2Euy0UW65Ddrn7Pmy5qciTQNOoVvs//FAiIV3QhR4whr6Yp/b
   B/AzbWfE76NA8LEraZxTCg6neCgmsh0KegtttN7ZcpG9Kp0Hca7/J6CRI
   ye38Pg08/W/JbDhmCm3tmAZRKo6i2h2nvbjyCj/TeFZK2cyid2JHot4hY
   g==;
X-CSE-ConnectionGUID: ZZ9MipmGRaG+G6TsWdBRxg==
X-CSE-MsgGUID: Op35Cuk4R2mlCt+BHh5alQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19979107"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="19979107"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:40:59 -0700
X-CSE-ConnectionGUID: Ro3ADAh8TFCg2nG0IOhj0g==
X-CSE-MsgGUID: nzk5TxXNSD2OVP7IlAD3KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="28678007"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 21 Apr 2024 22:40:57 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rymQA-000CKy-1Y;
	Mon, 22 Apr 2024 05:40:54 +0000
Date: Mon, 22 Apr 2024 13:40:27 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost v1 4/7] virtio_net: big mode support premapped
Message-ID: <202404221325.SX5ChRGP-lkp@intel.com>
References: <20240422015403.72526-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422015403.72526-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.9-rc5 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-dma-map-api-for-page/20240422-101017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240422015403.72526-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost v1 4/7] virtio_net: big mode support premapped
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240422/202404221325.SX5ChRGP-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240422/202404221325.SX5ChRGP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404221325.SX5ChRGP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'page_chain_get_dma':
>> drivers/net/virtio_net.c:468:30: warning: left shift count >= width of type [-Wshift-count-overflow]
     468 |                 return (addr << 32) + p->dma_addr;
         |                              ^~


vim +468 drivers/net/virtio_net.c

   461	
   462	static dma_addr_t page_chain_get_dma(struct page *p)
   463	{
   464		dma_addr_t addr;
   465	
   466		if (sizeof(dma_addr_t) > sizeof(unsigned long)) {
   467			addr = p->pp_magic;
 > 468			return (addr << 32) + p->dma_addr;
   469		} else {
   470			return p->dma_addr;
   471		}
   472	}
   473	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

