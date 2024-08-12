Return-Path: <netdev+bounces-117572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4594E5BC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAD281D62
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2661487F9;
	Mon, 12 Aug 2024 04:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAem5qom"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684114A612;
	Mon, 12 Aug 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436632; cv=none; b=gM9Nym0srd1CUppakeLRXU7RWOQ5zKgezUBsWF3N9kbflBHfMrc6Isj/+T4xq0NLN4oWl+o6ILqYQYh1sXQBejIgjsIfp2kWHHklxEQ+uypQuqGqPzV2Qk+CTiSGuCTNKbaBQk2w5pIaq6V4TDj8G3ezLFXgkmJI/CUfR8qc9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436632; c=relaxed/simple;
	bh=ToASbl6WYvykfcZHGtIUGtGq6btyZKGTzfSTgNkgSIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAIJYqLjzAnGeIwF3MZmW33ZhmNuY5y7GHJ7gh1L3y7QcuUKiFQx2nBU5XfzS6nF7ZEHdO/ZmiPtZMKrS7XbvdbtYooHBVjh0SOD7dU8rRZZSQ1M8t5kLH0C11lF963Jj8RKtbuG4Ttk0zl5biGQqdRBOfpsw5dNLRZPqR+I7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAem5qom; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723436629; x=1754972629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ToASbl6WYvykfcZHGtIUGtGq6btyZKGTzfSTgNkgSIE=;
  b=dAem5qomS8clnvNP+VtqRa0v7uhryeaXIZFQSoSpsxxcmVd9i3sK3dBy
   3wAmCrhhYCTyXWjfFGba3oNad3M2y/jkqVpcAl1Q2ahc7o8VR/FtMd9/b
   0pOeJW/P4w+WKUn04zWVxG+lNHZI5sL/Q3FeKbPZHgUtVJlV7Fh5Wh8Nv
   w+hlGCtYWAmSV3ikXHDsDH+lEDa0dKTDyzsf8LZK+9ttze7JOznstBnkD
   olbkKqHhIcy5RXTDTotRn31T/DcPfJVmZ00hzxGQvH5QVzfX+1J1YhJtU
   ouqklmuu9vybI9QYudzQ8QpwPT4K8WfEl+bqnn7aXg0It5mv3hYaoZFv4
   g==;
X-CSE-ConnectionGUID: mJv6VQNxS1W4SQt77aNQ0A==
X-CSE-MsgGUID: BLu7esHKSy6V6B1QyfuImA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="44047057"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="44047057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 21:23:49 -0700
X-CSE-ConnectionGUID: 8SKmKoEjQAeQS/gSImkEAg==
X-CSE-MsgGUID: 4c6qJc1OTyemFB2BBK65XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58858682"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 11 Aug 2024 21:23:44 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdMas-000BNm-0m;
	Mon, 12 Aug 2024 04:23:42 +0000
Date: Mon, 12 Aug 2024 12:23:41 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, eladwf@gmail.com, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO
 rings release
Message-ID: <202408121146.9ulfLUnP-lkp@intel.com>
References: <20240811184949.2799-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240811184949.2799-1-eladwf@gmail.com>

Hi Elad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Yifee/net-ethernet-mtk_eth_soc-fix-memory-leak-in-LRO-rings-release/20240812-025108
base:   net/main
patch link:    https://lore.kernel.org/r/20240811184949.2799-1-eladwf%40gmail.com
patch subject: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240812/202408121146.9ulfLUnP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408121146.9ulfLUnP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408121146.9ulfLUnP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_rx_put_buff':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:28: warning: passing argument 1 of 'free_pages' makes integer from pointer without a cast [-Wint-conversion]
    1768 |                 free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                            ^~~~
         |                            |
         |                            void *
   In file included from include/linux/xarray.h:16,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:18,
                    from drivers/net/ethernet/mediatek/mtk_eth_soc.c:9:
   include/linux/gfp.h:372:38: note: expected 'long unsigned int' but argument is of type 'void *'
     372 | extern void free_pages(unsigned long addr, unsigned int order);
         |                        ~~~~~~~~~~~~~~^~~~


vim +/free_pages +1768 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1759	
  1760	static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
  1761	{
  1762		if (ring->page_pool)
  1763			page_pool_put_full_page(ring->page_pool,
  1764						virt_to_head_page(data), napi);
  1765		else if (ring->frag_size <= PAGE_SIZE)
  1766			skb_free_frag(data);
  1767		else
> 1768			free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
  1769	}
  1770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

