Return-Path: <netdev+bounces-202204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD9AECAA0
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 00:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7313B7D2C
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4023536B;
	Sat, 28 Jun 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ej4qW57W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354D221566;
	Sat, 28 Jun 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751149521; cv=none; b=fFM7kmKADxSgPJ8g37aqvZm5LBQNDn5YhjCd3b51GBsn6DrJzFmGt6TUGHf7kBTT6lNYOdHUZ6RApqh03U8Gt58VfL8DCMfijlX042IZ6EKGzIjTrLC05XPvsOFlofcP6kqAtsTS1Myx+GNQIwY9hy9TNJWG/pyTSzaqLP86Y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751149521; c=relaxed/simple;
	bh=NlE2HCBxhFmElmkcJijAmIgQDwbR3P7Sc58DdxZL8NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyoLUyPx02NXIBGfz2oWbwxwfC60uuODFSfvJ4yieEh+TD8rHhbCvPwbNql38XNWpUQ56ixNdj3YkGzts/V0cLSqSofRhgf/wF5sre2gYLYvcPW1awfCfgEX5YjbEW34/FVR9ipIzXK2NmQdKyOctYpKWpZjWyHkewWCPGU/bT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ej4qW57W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751149520; x=1782685520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NlE2HCBxhFmElmkcJijAmIgQDwbR3P7Sc58DdxZL8NQ=;
  b=Ej4qW57Wxe607qhsSkUOXVbit4b/hxxlIQe10jiCWDpZM6KOCiV1zyDh
   fCULyn4LVRLsSS6xjhN9qoW61eJl5jXZjt3ftQk9s2J5WRU9SInehRKKu
   9GzNBLVMlHeOC43hxvoIGYMUWp+0KkR0D8E15E6DS7oQH9Sa3Y1auTZjM
   AwI4zKm23AAfrymXtDceVV2y+f7DlNOtccpCdANXRNOIfQJwmJ4QEaGw7
   IdGJLGxjtiATa7gmiCxeF08UClmT2YCxa/DxYLBqWYrHyOuJfWOxYpwsO
   VECNcQi2BJ+lA0d8YRpPt87oQWVQInGk+GzmCgmMVrgnnmRtvhjlbxpc4
   w==;
X-CSE-ConnectionGUID: uQmdvzmeSr6bjO3hLS+FPg==
X-CSE-MsgGUID: WuKlOW/vSwaKfpLF7VKFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="52650287"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="52650287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 15:25:18 -0700
X-CSE-ConnectionGUID: /EELPRmGSAWN3g5MCHDQvw==
X-CSE-MsgGUID: NvdqI8dOQNC2hVqoWqivTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="153647705"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Jun 2025 15:25:13 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVdyx-000XRO-1J;
	Sat, 28 Jun 2025 22:25:11 +0000
Date: Sun, 29 Jun 2025 06:24:53 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <202506290627.8dPD2PJ1-lkp@intel.com>
References: <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on next-20250627]
[cannot apply to net/main linus/master v6.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-ethernet-mtk_eth_soc-improve-support-for-named-interrupts/20250628-093324
base:   net-next/main
patch link:    https://lore.kernel.org/r/566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel%40makrotopia.org
patch subject: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool allocator for SRAM
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250629/202506290627.8dPD2PJ1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506290627.8dPD2PJ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506290627.8dPD2PJ1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_dma_ring_alloc':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1282:24: error: returning 'int' from a function with return type 'void *' makes pointer from integer without a cast [-Wint-conversion]
    1282 |                 return -ENOMEM;
         |                        ^


vim +1282 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1275	
  1276	static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
  1277					dma_addr_t *dma_handle)
  1278	{
  1279		void *dma_ring;
  1280	
  1281		if (WARN_ON(mtk_use_legacy_sram(eth)))
> 1282			return -ENOMEM;
  1283	
  1284		if (eth->sram_pool) {
  1285			dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
  1286			if (!dma_ring)
  1287				return dma_ring;
  1288			*dma_handle = gen_pool_virt_to_phys(eth->sram_pool, (unsigned long)dma_ring);
  1289		} else {
  1290			dma_ring = dma_alloc_coherent(eth->dma_dev, size, dma_handle,
  1291						      GFP_KERNEL);
  1292		}
  1293	
  1294		return dma_ring;
  1295	}
  1296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

