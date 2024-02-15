Return-Path: <netdev+bounces-72212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA482857179
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 00:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A491F226FB
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 23:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC119146900;
	Thu, 15 Feb 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWmBxf0h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B481468EB
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708039056; cv=none; b=EphRxRCEYTCHWqqHizTCvMJ1Jseitn2KqdQtuyv8F/I+YjfUvLqGvQpKFr5dxOZ/uSFi3O9rvzfT6bYZ5yF4qthI//3eedkElWGutnnR3eRe0ZN+02tYY7zC/yZ1eHOxbnAKrz+13bs/LltgZBrv5r4kb8QiJApW+XXH09rgToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708039056; c=relaxed/simple;
	bh=8iz3iHnGRxiUKfj5L/4fnfvrXq+9vUPqa+o2j+uH9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNhKZBHsnVZsdIaD+FnYFo2TRPSye0NQG89xDN4ClNj/gUpKWQsxcgHeMZ2Pu/ONwq2bIP5/5uBzbhZUx45ldflDO4A4nT45xhWYyGEirXj7vjbBvoWc5/gWOoNLEfuyYRiNxnjBY09lxveFujPiQYDCa69lO8qDulbmsLPD5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWmBxf0h; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708039054; x=1739575054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8iz3iHnGRxiUKfj5L/4fnfvrXq+9vUPqa+o2j+uH9RE=;
  b=cWmBxf0h6NPk1BbiqqibcXH4VAsTYv9771lqjlzAvnCDUqIQUIjfbDd0
   Ift6rMZp015fI2qPO9C0kjrBs7h5NaPKonBj9Xvy4dcg1KWDPVHZQaJNq
   ZfcAQ7BACm4UhxHEo4iZRCdqcntDt+s5+6EAGUg27vjf/ONCrGhcTX6df
   LS1GZe4c2nWkovjTmOa1VxAY2s0JeyAEmRrkaoYnQi2DuRKiPCjykKlxH
   W33v7Uq1Q0dSKHTxG50vVUGoQog1/bvHJKA4QA+EBxsYHDpHDhrLp4Zvq
   L0cSel4sii6sdyJYWSdODzAnd9sIAle7YQoZ3EBjHo8HHzPRQoGGX3pnl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="12876548"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="12876548"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="8372965"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 15 Feb 2024 15:17:25 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rakyo-0000qA-0m;
	Thu, 15 Feb 2024 23:17:22 +0000
Date: Fri, 16 Feb 2024 07:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3
 support to xgbe_pci_probe()
Message-ID: <202402160711.PlBR8NLf-lkp@intel.com>
References: <20240214154842.3577628-5-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214154842.3577628-5-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-reorganize-the-code-of-XPCS-access/20240215-000248
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240214154842.3577628-5-Raju.Rangoju%40amd.com
patch subject: [PATCH v5 net-next 4/5] amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240216/202402160711.PlBR8NLf-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 1c10821022f1799452065fb57474e894e2562b7f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240216/202402160711.PlBR8NLf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402160711.PlBR8NLf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/amd/xgbe/xgbe-pci.c:119:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/amd/xgbe/xgbe-pci.c:119:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/amd/xgbe/xgbe-pci.c:119:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/amd/xgbe/xgbe-pci.c:312:18: warning: variable 'reg' is uninitialized when used here [-Wuninitialized]
     312 |                                  XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
         |                                              ^~~
   drivers/net/ethernet/amd/xgbe/xgbe-common.h:1682:12: note: expanded from macro 'XP_GET_BITS'
    1682 |         GET_BITS((_var),                                                \
         |                   ^~~~
   drivers/net/ethernet/amd/xgbe/xgbe-common.h:1454:5: note: expanded from macro 'GET_BITS'
    1454 |         (((_var) >> (_index)) & ((0x1 << (_width)) - 1))
         |            ^~~~
   drivers/net/ethernet/amd/xgbe/xgbe-pci.c:212:34: note: initialize the variable 'reg' to silence this warning
     212 |         unsigned int port_addr_size, reg;
         |                                         ^
         |                                          = 0
   13 warnings generated.


vim +/reg +312 drivers/net/ethernet/amd/xgbe/xgbe-pci.c

   208	
   209	static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
   210	{
   211		void __iomem * const *iomap_table;
   212		unsigned int port_addr_size, reg;
   213		struct device *dev = &pdev->dev;
   214		struct xgbe_prv_data *pdata;
   215		unsigned int ma_lo, ma_hi;
   216		struct pci_dev *rdev;
   217		int bar_mask, ret;
   218		u32 address;
   219	
   220		pdata = xgbe_alloc_pdata(dev);
   221		if (IS_ERR(pdata)) {
   222			ret = PTR_ERR(pdata);
   223			goto err_alloc;
   224		}
   225	
   226		pdata->pcidev = pdev;
   227		pci_set_drvdata(pdev, pdata);
   228	
   229		/* Get the version data */
   230		pdata->vdata = (struct xgbe_version_data *)id->driver_data;
   231	
   232		ret = pcim_enable_device(pdev);
   233		if (ret) {
   234			dev_err(dev, "pcim_enable_device failed\n");
   235			goto err_pci_enable;
   236		}
   237	
   238		/* Obtain the mmio areas for the device */
   239		bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
   240		ret = pcim_iomap_regions(pdev, bar_mask, XGBE_DRV_NAME);
   241		if (ret) {
   242			dev_err(dev, "pcim_iomap_regions failed\n");
   243			goto err_pci_enable;
   244		}
   245	
   246		iomap_table = pcim_iomap_table(pdev);
   247		if (!iomap_table) {
   248			dev_err(dev, "pcim_iomap_table failed\n");
   249			ret = -ENOMEM;
   250			goto err_pci_enable;
   251		}
   252	
   253		pdata->xgmac_regs = iomap_table[XGBE_XGMAC_BAR];
   254		if (!pdata->xgmac_regs) {
   255			dev_err(dev, "xgmac ioremap failed\n");
   256			ret = -ENOMEM;
   257			goto err_pci_enable;
   258		}
   259		pdata->xprop_regs = pdata->xgmac_regs + XGBE_MAC_PROP_OFFSET;
   260		pdata->xi2c_regs = pdata->xgmac_regs + XGBE_I2C_CTRL_OFFSET;
   261		if (netif_msg_probe(pdata)) {
   262			dev_dbg(dev, "xgmac_regs = %p\n", pdata->xgmac_regs);
   263			dev_dbg(dev, "xprop_regs = %p\n", pdata->xprop_regs);
   264			dev_dbg(dev, "xi2c_regs  = %p\n", pdata->xi2c_regs);
   265		}
   266	
   267		pdata->xpcs_regs = iomap_table[XGBE_XPCS_BAR];
   268		if (!pdata->xpcs_regs) {
   269			dev_err(dev, "xpcs ioremap failed\n");
   270			ret = -ENOMEM;
   271			goto err_pci_enable;
   272		}
   273		if (netif_msg_probe(pdata))
   274			dev_dbg(dev, "xpcs_regs  = %p\n", pdata->xpcs_regs);
   275	
   276		/* Set the PCS indirect addressing definition registers */
   277		rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
   278		if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
   279			switch (rdev->device) {
   280			case XGBE_RV_PCI_DEVICE_ID:
   281				pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
   282				pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
   283				break;
   284			case XGBE_YC_PCI_DEVICE_ID:
   285				pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
   286				pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
   287	
   288				/* Yellow Carp devices do not need cdr workaround */
   289				pdata->vdata->an_cdr_workaround = 0;
   290	
   291				/* Yellow Carp devices do not need rrc */
   292				pdata->vdata->enable_rrc = 0;
   293				break;
   294			case XGBE_RN_PCI_DEVICE_ID:
   295				pdata->xpcs_window_def_reg = PCS_V3_RN_WINDOW_DEF;
   296				pdata->xpcs_window_sel_reg = PCS_V3_RN_WINDOW_SELECT;
   297				break;
   298			default:
   299				pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
   300				pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
   301				break;
   302			}
   303		} else {
   304			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
   305			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
   306		}
   307		pci_dev_put(rdev);
   308	
   309		/* Configure the PCS indirect addressing support */
   310		if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
   311			port_addr_size = PCS_RN_PORT_ADDR_SIZE *
 > 312					 XP_GET_BITS(reg, XP_PROP_0, PORT_ID);
   313			pdata->smn_base = PCS_RN_SMN_BASE_ADDR + port_addr_size;
   314	
   315			address = pdata->smn_base + (pdata->xpcs_window_def_reg);
   316			reg = XP_IOREAD(pdata, XP_PROP_0);
   317			amd_smn_read(0, address, &reg);
   318		} else {
   319			reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
   320		}
   321	
   322		pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
   323		pdata->xpcs_window <<= 6;
   324		pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, SIZE);
   325		pdata->xpcs_window_size = 1 << (pdata->xpcs_window_size + 7);
   326		pdata->xpcs_window_mask = pdata->xpcs_window_size - 1;
   327		if (netif_msg_probe(pdata)) {
   328			dev_dbg(dev, "xpcs window def  = %#010x\n",
   329				pdata->xpcs_window_def_reg);
   330			dev_dbg(dev, "xpcs window sel  = %#010x\n",
   331				pdata->xpcs_window_sel_reg);
   332			dev_dbg(dev, "xpcs window      = %#010x\n",
   333				pdata->xpcs_window);
   334			dev_dbg(dev, "xpcs window size = %#010x\n",
   335				pdata->xpcs_window_size);
   336			dev_dbg(dev, "xpcs window mask = %#010x\n",
   337				pdata->xpcs_window_mask);
   338		}
   339	
   340		pci_set_master(pdev);
   341	
   342		/* Enable all interrupts in the hardware */
   343		XP_IOWRITE(pdata, XP_INT_EN, 0x1fffff);
   344	
   345		/* Retrieve the MAC address */
   346		ma_lo = XP_IOREAD(pdata, XP_MAC_ADDR_LO);
   347		ma_hi = XP_IOREAD(pdata, XP_MAC_ADDR_HI);
   348		pdata->mac_addr[0] = ma_lo & 0xff;
   349		pdata->mac_addr[1] = (ma_lo >> 8) & 0xff;
   350		pdata->mac_addr[2] = (ma_lo >> 16) & 0xff;
   351		pdata->mac_addr[3] = (ma_lo >> 24) & 0xff;
   352		pdata->mac_addr[4] = ma_hi & 0xff;
   353		pdata->mac_addr[5] = (ma_hi >> 8) & 0xff;
   354		if (!XP_GET_BITS(ma_hi, XP_MAC_ADDR_HI, VALID) ||
   355		    !is_valid_ether_addr(pdata->mac_addr)) {
   356			dev_err(dev, "invalid mac address\n");
   357			ret = -EINVAL;
   358			goto err_pci_enable;
   359		}
   360	
   361		/* Clock settings */
   362		pdata->sysclk_rate = XGBE_V2_DMA_CLOCK_FREQ;
   363		pdata->ptpclk_rate = XGBE_V2_PTP_CLOCK_FREQ;
   364	
   365		/* Set the DMA coherency values */
   366		pdata->coherent = 1;
   367		pdata->arcr = XGBE_DMA_PCI_ARCR;
   368		pdata->awcr = XGBE_DMA_PCI_AWCR;
   369		pdata->awarcr = XGBE_DMA_PCI_AWARCR;
   370	
   371		/* Read the port property registers */
   372		pdata->pp0 = XP_IOREAD(pdata, XP_PROP_0);
   373		pdata->pp1 = XP_IOREAD(pdata, XP_PROP_1);
   374		pdata->pp2 = XP_IOREAD(pdata, XP_PROP_2);
   375		pdata->pp3 = XP_IOREAD(pdata, XP_PROP_3);
   376		pdata->pp4 = XP_IOREAD(pdata, XP_PROP_4);
   377		if (netif_msg_probe(pdata)) {
   378			dev_dbg(dev, "port property 0 = %#010x\n", pdata->pp0);
   379			dev_dbg(dev, "port property 1 = %#010x\n", pdata->pp1);
   380			dev_dbg(dev, "port property 2 = %#010x\n", pdata->pp2);
   381			dev_dbg(dev, "port property 3 = %#010x\n", pdata->pp3);
   382			dev_dbg(dev, "port property 4 = %#010x\n", pdata->pp4);
   383		}
   384	
   385		/* Set the maximum channels and queues */
   386		pdata->tx_max_channel_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   387							  MAX_TX_DMA);
   388		pdata->rx_max_channel_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   389							  MAX_RX_DMA);
   390		pdata->tx_max_q_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   391						    MAX_TX_QUEUES);
   392		pdata->rx_max_q_count = XP_GET_BITS(pdata->pp1, XP_PROP_1,
   393						    MAX_RX_QUEUES);
   394		if (netif_msg_probe(pdata)) {
   395			dev_dbg(dev, "max tx/rx channel count = %u/%u\n",
   396				pdata->tx_max_channel_count,
   397				pdata->rx_max_channel_count);
   398			dev_dbg(dev, "max tx/rx hw queue count = %u/%u\n",
   399				pdata->tx_max_q_count, pdata->rx_max_q_count);
   400		}
   401	
   402		/* Set the hardware channel and queue counts */
   403		xgbe_set_counts(pdata);
   404	
   405		/* Set the maximum fifo amounts */
   406		pdata->tx_max_fifo_size = XP_GET_BITS(pdata->pp2, XP_PROP_2,
   407						      TX_FIFO_SIZE);
   408		pdata->tx_max_fifo_size *= 16384;
   409		pdata->tx_max_fifo_size = min(pdata->tx_max_fifo_size,
   410					      pdata->vdata->tx_max_fifo_size);
   411		pdata->rx_max_fifo_size = XP_GET_BITS(pdata->pp2, XP_PROP_2,
   412						      RX_FIFO_SIZE);
   413		pdata->rx_max_fifo_size *= 16384;
   414		pdata->rx_max_fifo_size = min(pdata->rx_max_fifo_size,
   415					      pdata->vdata->rx_max_fifo_size);
   416		if (netif_msg_probe(pdata))
   417			dev_dbg(dev, "max tx/rx max fifo size = %u/%u\n",
   418				pdata->tx_max_fifo_size, pdata->rx_max_fifo_size);
   419	
   420		/* Configure interrupt support */
   421		ret = xgbe_config_irqs(pdata);
   422		if (ret)
   423			goto err_pci_enable;
   424	
   425		/* Configure the netdev resource */
   426		ret = xgbe_config_netdev(pdata);
   427		if (ret)
   428			goto err_irq_vectors;
   429	
   430		netdev_notice(pdata->netdev, "net device enabled\n");
   431	
   432		return 0;
   433	
   434	err_irq_vectors:
   435		pci_free_irq_vectors(pdata->pcidev);
   436	
   437	err_pci_enable:
   438		xgbe_free_pdata(pdata);
   439	
   440	err_alloc:
   441		dev_notice(dev, "net device not enabled\n");
   442	
   443		return ret;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

