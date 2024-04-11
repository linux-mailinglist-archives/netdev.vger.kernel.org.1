Return-Path: <netdev+bounces-87110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4B8A1CB6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6960C1C23040
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D603FE3D;
	Thu, 11 Apr 2024 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wguqg7O8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECDD51D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853310; cv=none; b=EKBMyZ9k4aSlpINNGFoX3fDFRt1W0sF4co4s+N75R87iOXu+ix8Il7MqmmClHUiLPbh/AUbFqmqb/JJ3W3HQKs7UbzFyZkJEaIfXVtHFfWR0837hAj3vCGzNQt3VuY3YKodjnOV4NDz9J9DLLRsdNKT9iipkNjBw509vpD8rzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853310; c=relaxed/simple;
	bh=t/v7GqviUGNbcu5JjBb89K1tBk5eKiEGunkT7kINhOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H469y0YpH5LgVoEzsPv4tMpAbWCwoM3mFoGNuxtz4Rst51FcnNRM1rI4D0Jutf1/jWOLqTJunA33D5n6xJhia6pQeTNzk8DMQChCw+qt5tOVb5nIlDSbu9c1SMY6F4W9+/aU1KG/pjvd7y8C5mQg+jhyW2szFzJ6QwZPO5uOg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wguqg7O8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712853309; x=1744389309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t/v7GqviUGNbcu5JjBb89K1tBk5eKiEGunkT7kINhOE=;
  b=Wguqg7O8Ds3jqsf4QGjAaDN3Y79rgtTQZ7y20+P/lFYl2c1HjpCiEvzm
   cfpIoWQdwH8qDBpZcmtT78PGlKwsYDceN6PNQGs4KKVDXbTfNGahCllqk
   abl4pFNM3L7c6OCD2Rsk4NG3ySkxov5M+rcx5f4ZlCf3zUMbQT5wD1Ph2
   U8FBVUuRu7nkJkMqfiA0zSs4E/YKgZVvz/vykPR59JaF1eUJJsmR2KdmR
   tsov/ghwoG3RN/sVcvPQEufKEkhg8Bct8nMaiwfF3fJJtMhxrZke/0d9E
   wAVbgv5sY/nxGquzWJgG6SE/tV7CmOFa6SfkWn7s7OCnvxSra/PGRDkl0
   w==;
X-CSE-ConnectionGUID: kUe/Rsw6RBmJ9/KlosGf6g==
X-CSE-MsgGUID: V9peDNBPSb+EUKI7MpHNeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18838649"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18838649"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:35:03 -0700
X-CSE-ConnectionGUID: OGiv2yLhTM6J6yDAqqzhEQ==
X-CSE-MsgGUID: HhEIXW/IQcawTtl6wv49Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25423885"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 11 Apr 2024 09:34:58 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruxO4-0008ob-2J;
	Thu, 11 Apr 2024 16:34:56 +0000
Date: Fri, 12 Apr 2024 00:34:28 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Message-ID: <202404120044.VKtjHMzy-lkp@intel.com>
References: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.9-rc3 next-20240411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-dma-map-api-for-page/20240411-105318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240411025127.51945-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 4/6] virtio_net: big mode support premapped
config: i386-randconfig-016-20240411 (https://download.01.org/0day-ci/archive/20240412/202404120044.VKtjHMzy-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404120044.VKtjHMzy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404120044.VKtjHMzy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio_net.c:449:21: warning: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'unsigned long' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
     449 |         page_dma_addr(p) = DMA_MAPPING_ERROR;
         |                          ~ ^~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:75:29: note: expanded from macro 'DMA_MAPPING_ERROR'
      75 | #define DMA_MAPPING_ERROR               (~(dma_addr_t)0)
         |                                          ^~~~~~~~~~~~~~
>> drivers/net/virtio_net.c:485:26: warning: result of comparison of constant 18446744073709551615 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
     485 |         if (page_dma_addr(page) == DMA_MAPPING_ERROR) {
         |             ~~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +449 drivers/net/virtio_net.c

   443	
   444	static void page_chain_unmap(struct receive_queue *rq, struct page *p)
   445	{
   446		virtqueue_dma_unmap_page_attrs(rq->vq, page_dma_addr(p), PAGE_SIZE,
   447					       DMA_FROM_DEVICE, 0);
   448	
 > 449		page_dma_addr(p) = DMA_MAPPING_ERROR;
   450	}
   451	
   452	static int page_chain_map(struct receive_queue *rq, struct page *p)
   453	{
   454		dma_addr_t addr;
   455	
   456		addr = virtqueue_dma_map_page_attrs(rq->vq, p, 0, PAGE_SIZE, DMA_FROM_DEVICE, 0);
   457		if (virtqueue_dma_mapping_error(rq->vq, addr))
   458			return -ENOMEM;
   459	
   460		page_dma_addr(p) = addr;
   461		return 0;
   462	}
   463	
   464	static void page_chain_release(struct receive_queue *rq)
   465	{
   466		struct page *p, *n;
   467	
   468		for (p = rq->pages; p; p = n) {
   469			n = page_chain_next(p);
   470	
   471			page_chain_unmap(rq, p);
   472			__free_pages(p, 0);
   473		}
   474	
   475		rq->pages = NULL;
   476	}
   477	
   478	/*
   479	 * put the whole most recent used list in the beginning for reuse
   480	 */
   481	static void give_pages(struct receive_queue *rq, struct page *page)
   482	{
   483		struct page *end;
   484	
 > 485		if (page_dma_addr(page) == DMA_MAPPING_ERROR) {
   486			if (page_chain_map(rq, page)) {
   487				__free_pages(page, 0);
   488				return;
   489			}
   490		}
   491	
   492		/* Find end of list, sew whole thing into vi->rq.pages. */
   493		for (end = page; page_chain_next(end); end = page_chain_next(end));
   494	
   495		page_chain_add(end, rq->pages);
   496		rq->pages = page;
   497	}
   498	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

