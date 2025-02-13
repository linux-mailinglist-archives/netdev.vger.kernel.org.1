Return-Path: <netdev+bounces-165894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77DA33A93
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B8188CC1D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF020C488;
	Thu, 13 Feb 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCbMS/HN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC34201034;
	Thu, 13 Feb 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437394; cv=none; b=m6jOJkCseqZ59E7hh0xXv6XQRVzUan/ldHF/vCSsKNLu/F/zPzpZghcmYReJNYD+NAUk44nJJA8SKIj8x+HElVTfMymn7+faeUcZ5ZVvrX/fGyuZKFGKJstE1cr68c4Ud/dwOB9StSkhOSutvTGkk8qjiBFrbzmpWO6X8XPDrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437394; c=relaxed/simple;
	bh=wyVqmKW6qzEXY/2+wreWQuYQKHFVrSv5qadbTzVZLSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CcQ5Z7ZdSD4VeL016Xs+/uOcVDOhflzjVUF/NKR1gUS+A8xYviJ4/zxkvEI8C/wJVdamXmV7T0BEpDBrJGme7+aiI/cUhoFEtHQH88Zr9zeNn4zrtvpAV0AxL5Ht4I4eO7dUuPsgMD58XczX3F8y/0kB+vO2FX71TagCN9V1rR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCbMS/HN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739437393; x=1770973393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyVqmKW6qzEXY/2+wreWQuYQKHFVrSv5qadbTzVZLSY=;
  b=BCbMS/HNHCJQBkE3pmbg8Tj7pqg15FpLV2xdcdye3JOKmfkUwJcHkRIc
   nb6pk6itduYYf5Fsq1+HSFzVac46sqTFEk/mch4zkDPuxF4F6DkpSpSDk
   XBGUzxTeG2nveGslG5I4l9OTxbh4I3d2i2TEIpl+E0txGauWr23v6jDW4
   d4RgCZD7fui04zSvxMQztu+6rLf9Z7vRNFASJwM8RonTL/Mdw+KXfTqcH
   nIL9YBTvWqtw/K4N4Kk9yNLDynu17vYAA4YeX+2qY5s/ldnetAWcR1+UC
   zHtZj3SCdBbGDbDb+rvFHBK2zcEE8f7j0rd86APowFtSuYPdg2o/RpL2K
   A==;
X-CSE-ConnectionGUID: aoLaQNZYSnWMF3To2zvJgQ==
X-CSE-MsgGUID: YppV2PRMSV+Mb22w8jxQRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42964606"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="42964606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 01:03:11 -0800
X-CSE-ConnectionGUID: xLD9b4BYSA2msdlFhvPgzA==
X-CSE-MsgGUID: IVYzpRB/RkKRgnnvJ6SyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112851152"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2025 01:03:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiV7g-0016qp-1x;
	Thu, 13 Feb 2025 09:03:04 +0000
Date: Thu, 13 Feb 2025 17:02:38 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <phasta@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Yanteng Si <si.yanteng@linux.dev>,
	Philipp Stanner <pstanner@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stmmac: Replace deprecated PCI functions
Message-ID: <202502131623.bMnlG9wy-lkp@intel.com>
References: <20250212145831.101719-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212145831.101719-2-phasta@kernel.org>

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc2 next-20250213]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/stmmac-Replace-deprecated-PCI-functions/20250212-230254
base:   linus/master
patch link:    https://lore.kernel.org/r/20250212145831.101719-2-phasta%40kernel.org
patch subject: [PATCH] stmmac: Replace deprecated PCI functions
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250213/202502131623.bMnlG9wy-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131623.bMnlG9wy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131623.bMnlG9wy-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:13:
   In file included from include/linux/pci.h:37:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c:197:28: error: expected ';' after return statement
     197 |                         return PTR_ERR(res.addr)
         |                                                 ^
         |                                                 ;
   3 warnings and 1 error generated.


vim +197 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c

   140	
   141	/**
   142	 * stmmac_pci_probe
   143	 *
   144	 * @pdev: pci device pointer
   145	 * @id: pointer to table of device id/id's.
   146	 *
   147	 * Description: This probing function gets called for all PCI devices which
   148	 * match the ID table and are not "owned" by other driver yet. This function
   149	 * gets passed a "struct pci_dev *" for each device whose entry in the ID table
   150	 * matches the device. The probe functions returns zero when the driver choose
   151	 * to take "ownership" of the device or an error code(-ve no) otherwise.
   152	 */
   153	static int stmmac_pci_probe(struct pci_dev *pdev,
   154				    const struct pci_device_id *id)
   155	{
   156		struct stmmac_pci_info *info = (struct stmmac_pci_info *)id->driver_data;
   157		struct plat_stmmacenet_data *plat;
   158		struct stmmac_resources res = {};
   159		int i;
   160		int ret;
   161	
   162		plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
   163		if (!plat)
   164			return -ENOMEM;
   165	
   166		plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
   167						   sizeof(*plat->mdio_bus_data),
   168						   GFP_KERNEL);
   169		if (!plat->mdio_bus_data)
   170			return -ENOMEM;
   171	
   172		plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
   173					     GFP_KERNEL);
   174		if (!plat->dma_cfg)
   175			return -ENOMEM;
   176	
   177		plat->safety_feat_cfg = devm_kzalloc(&pdev->dev,
   178						     sizeof(*plat->safety_feat_cfg),
   179						     GFP_KERNEL);
   180		if (!plat->safety_feat_cfg)
   181			return -ENOMEM;
   182	
   183		/* Enable pci device */
   184		ret = pcim_enable_device(pdev);
   185		if (ret) {
   186			dev_err(&pdev->dev, "%s: ERROR: failed to enable device\n",
   187				__func__);
   188			return ret;
   189		}
   190	
   191		/* The first BAR > 0 is the base IO addr of our device. */
   192		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
   193			if (pci_resource_len(pdev, i) == 0)
   194				continue;
   195			res.addr = pcim_iomap_region(pdev, i, STMMAC_RESOURCE_NAME);
   196			if (IS_ERR(res.addr))
 > 197				return PTR_ERR(res.addr)
   198			break;
   199		}
   200	
   201		pci_set_master(pdev);
   202	
   203		ret = info->setup(pdev, plat);
   204		if (ret)
   205			return ret;
   206	
   207		res.wol_irq = pdev->irq;
   208		res.irq = pdev->irq;
   209	
   210		plat->safety_feat_cfg->tsoee = 1;
   211		plat->safety_feat_cfg->mrxpee = 1;
   212		plat->safety_feat_cfg->mestee = 1;
   213		plat->safety_feat_cfg->mrxee = 1;
   214		plat->safety_feat_cfg->mtxee = 1;
   215		plat->safety_feat_cfg->epsi = 1;
   216		plat->safety_feat_cfg->edpp = 1;
   217		plat->safety_feat_cfg->prtyen = 1;
   218		plat->safety_feat_cfg->tmouten = 1;
   219	
   220		return stmmac_dvr_probe(&pdev->dev, plat, &res);
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

