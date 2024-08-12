Return-Path: <netdev+bounces-117555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D610494E4AC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 04:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A1F1C2137C
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 02:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFD74D8D1;
	Mon, 12 Aug 2024 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfUWab1O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F737700;
	Mon, 12 Aug 2024 02:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429005; cv=none; b=AdFHmLMvyqIBEmoPGWE3dzhASFpqQkT8DfcGf8TjWbnxuzBTtnmux5uqJJ5fxq3ZF/Jxw6o5cMGICZZxl2yQ6xOp5cGB3V0sjGZLGdzqeKfuXHuluQTzpvHOVHzHYpLqWxhffuzFzNzTERC+DppqmAmfFSbtOBgxLGYe+pITyCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429005; c=relaxed/simple;
	bh=5MYDHW8Ntrx9JK0iCo47kgCMiUvn00RyAYS0dDizyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkfm+09tj0072Qqz1OfwRQHPwglw7fuIWQIw3FqTEIbyFERAk3f4cbZzmCRoiMpQ0WMBWzLIncMxh2BB9+VK0WeoT8hDycsxssWpdr1bU4H7TUgKgy6VQzDrXvCcYCAUoGm210WiBTIr5TiJZouEUvYz6Hj7CvekKFyEgw1MCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfUWab1O; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723429003; x=1754965003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5MYDHW8Ntrx9JK0iCo47kgCMiUvn00RyAYS0dDizyb4=;
  b=AfUWab1OK8TKFnCWbsQ/ut5uMVzGj93zhorX5v05MZHhYsY6X3v3U8Zp
   Nzg5CA5b02AaW0iKWx9B9y89dv03013dDE1nRtiEva1S/RCgmo+RZ99Xa
   YNlmLucbN7aThq3Y0gosZcZtGUCWYED9MHlF2fV3KjZ85lIyjA3nDr+L1
   bQGmMBCZxskkFoJMd+pBkoo4TI7Lxr8uJqA/wurFS5aqJGWtwWfL3vN1Q
   cKTxjuJqSfPJ+l/d1Ich1LfmVunTgS4snT4HvE6W99Cf09nhfJaxnJIS9
   zyGvf7yipEgVXNSYk80gWbAaxu//9OgyIB2InjH+/oq1vno0KcfCid78/
   w==;
X-CSE-ConnectionGUID: OaiTbssRRPKoSjrUXmLUWg==
X-CSE-MsgGUID: HzQcTJ30T3qg5BCxzmfA3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21178616"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21178616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 19:16:43 -0700
X-CSE-ConnectionGUID: wSCFL66dQdOmgnaUlzfcYQ==
X-CSE-MsgGUID: C39OJgj3S8+gxxwICPkdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62957247"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 11 Aug 2024 19:16:39 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdKbf-000BJm-0j;
	Mon, 12 Aug 2024 02:16:28 +0000
Date: Mon, 12 Aug 2024 10:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, eladwf@gmail.com,
	daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
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
Message-ID: <202408120923.HUpL6sBp-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Yifee/net-ethernet-mtk_eth_soc-fix-memory-leak-in-LRO-rings-release/20240812-025108
base:   net/main
patch link:    https://lore.kernel.org/r/20240811184949.2799-1-eladwf%40gmail.com
patch subject: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240812/202408120923.HUpL6sBp-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408120923.HUpL6sBp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408120923.HUpL6sBp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:14: error: incompatible pointer to integer conversion passing 'void *' to parameter of type 'unsigned long' [-Wint-conversion]
    1768 |                 free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                            ^~~~
   include/linux/gfp.h:372:38: note: passing argument to parameter 'addr' here
     372 | extern void free_pages(unsigned long addr, unsigned int order);
         |                                      ^
   1 error generated.


vim +1768 drivers/net/ethernet/mediatek/mtk_eth_soc.c

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

