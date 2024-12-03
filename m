Return-Path: <netdev+bounces-148336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228389E1289
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 05:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C13B22199
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8015C140;
	Tue,  3 Dec 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhiYJSgI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D513D521;
	Tue,  3 Dec 2024 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733201443; cv=none; b=P9LDe+F7PwHwffJbONrlXpOR0lpxdE98uM1yQzXqKNF57AQSIEYwALyGDOn55QGOvGzOSyM4Ssl4TTcTM9XhbgjTLIgl/yUwLIG5YvpbDaZwggUiosUDRqLb4Gkxn95MxOIJA+0tWUSV5mJhypy80+jMebAhNMTIphxtzjs1+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733201443; c=relaxed/simple;
	bh=WrgtmSKQRKNhctD+2fMFzQTqOOQkxRBM8FwVH04r7QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE9CdEVPTtWPmlALzSvgkR64FfN0wVb3Ntgw/4FQ/rZisOKDuh4R7qH1Fp6Gy2flfksR4LsMlz+WgI1vo33AieKB2+b8ZY0HeGyOMI7dPFx11n6+r5lV8e+S0SgPPooc9mLpRfUuAiFAApiD4eUj8tvcZb8yYHnYjeuAc5cHDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhiYJSgI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733201441; x=1764737441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WrgtmSKQRKNhctD+2fMFzQTqOOQkxRBM8FwVH04r7QA=;
  b=QhiYJSgIqm0GVzIwSR1QXBgqiK121tNKQmZmWNfa/XNBqkVdeSC5mJ8g
   LR0ZrRW1XsV9tsw6teCyoMHyYkUmIb/luWOMzRLu0Kzjrt2YeDJrpnhdD
   NFY6eloNFr3QBsMxE/Uxllb2kCmuzv5COMbvQ9jGkTImAnoTadfQpzgsp
   lC1lfGRjWMyfCxpiu/Ub7PRUdzdRErRy3D8BJaK026U2QII3lJc9YPthH
   6lirW/6PL9StQegwfRm/IRXSNMjW29EQM0bQmw/Au2BX/dNq6or2kY7B2
   TkZfxwqz0kiJYADtmsuHc33eYRjxwh04ey0681L5IhnEtkkgXbta+8lGF
   A==;
X-CSE-ConnectionGUID: MwZ3GphQS0euPzOcirqvDA==
X-CSE-MsgGUID: aWLxlYibSG28hk4CON2QyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37172938"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="37172938"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:50:40 -0800
X-CSE-ConnectionGUID: IiphBCTkROGTxvo2q/8iTg==
X-CSE-MsgGUID: HLDjWRr2Q4iQhQTGhMv6Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124152615"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 20:50:35 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIKro-00007n-1h;
	Tue, 03 Dec 2024 04:50:32 +0000
Date: Tue, 3 Dec 2024 12:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 03/28] cxl: add capabilities field to cxl_dev_state
 and cxl_port
Message-ID: <202412031236.IUDQVzW6-lkp@intel.com>
References: <20241202171222.62595-4-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-4-alejandro.lucero-palau@amd.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e70140ba0d2b1a30467d4af6bcfe761327b9ec95]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/cxl-add-type2-device-basic-support/20241203-031134
base:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
patch link:    https://lore.kernel.org/r/20241202171222.62595-4-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v6 03/28] cxl: add capabilities field to cxl_dev_state and cxl_port
config: arm-randconfig-001-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031236.IUDQVzW6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031236.IUDQVzW6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031236.IUDQVzW6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/regs.c:42: warning: Function parameter or struct member 'caps' not described in 'cxl_probe_component_regs'
>> drivers/cxl/core/regs.c:125: warning: Function parameter or struct member 'caps' not described in 'cxl_probe_device_regs'


vim +42 drivers/cxl/core/regs.c

fa89248e669d589 Robert Richter   2022-10-18   13  
2b922a9d064f8e8 Dan Williams     2021-09-03   14  /**
2b922a9d064f8e8 Dan Williams     2021-09-03   15   * DOC: cxl registers
2b922a9d064f8e8 Dan Williams     2021-09-03   16   *
2b922a9d064f8e8 Dan Williams     2021-09-03   17   * CXL device capabilities are enumerated by PCI DVSEC (Designated
2b922a9d064f8e8 Dan Williams     2021-09-03   18   * Vendor-specific) and / or descriptors provided by platform firmware.
2b922a9d064f8e8 Dan Williams     2021-09-03   19   * They can be defined as a set like the device and component registers
2b922a9d064f8e8 Dan Williams     2021-09-03   20   * mandated by CXL Section 8.1.12.2 Memory Device PCIe Capabilities and
2b922a9d064f8e8 Dan Williams     2021-09-03   21   * Extended Capabilities, or they can be individual capabilities
2b922a9d064f8e8 Dan Williams     2021-09-03   22   * appended to bridged and endpoint devices.
2b922a9d064f8e8 Dan Williams     2021-09-03   23   *
2b922a9d064f8e8 Dan Williams     2021-09-03   24   * Provide common infrastructure for enumerating and mapping these
2b922a9d064f8e8 Dan Williams     2021-09-03   25   * discrete capabilities.
2b922a9d064f8e8 Dan Williams     2021-09-03   26   */
2b922a9d064f8e8 Dan Williams     2021-09-03   27  
0f06157e0135f55 Dan Williams     2021-08-03   28  /**
0f06157e0135f55 Dan Williams     2021-08-03   29   * cxl_probe_component_regs() - Detect CXL Component register blocks
0f06157e0135f55 Dan Williams     2021-08-03   30   * @dev: Host device of the @base mapping
0f06157e0135f55 Dan Williams     2021-08-03   31   * @base: Mapping containing the HDM Decoder Capability Header
0f06157e0135f55 Dan Williams     2021-08-03   32   * @map: Map object describing the register block information found
0f06157e0135f55 Dan Williams     2021-08-03   33   *
0f06157e0135f55 Dan Williams     2021-08-03   34   * See CXL 2.0 8.2.4 Component Register Layout and Definition
0f06157e0135f55 Dan Williams     2021-08-03   35   * See CXL 2.0 8.2.5.5 CXL Device Register Interface
0f06157e0135f55 Dan Williams     2021-08-03   36   *
0f06157e0135f55 Dan Williams     2021-08-03   37   * Probe for component register information and return it in map object.
0f06157e0135f55 Dan Williams     2021-08-03   38   */
0f06157e0135f55 Dan Williams     2021-08-03   39  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
b98956b0195863f Alejandro Lucero 2024-12-02   40  			      struct cxl_component_reg_map *map,
b98956b0195863f Alejandro Lucero 2024-12-02   41  			      unsigned long *caps)
0f06157e0135f55 Dan Williams     2021-08-03  @42  {
0f06157e0135f55 Dan Williams     2021-08-03   43  	int cap, cap_count;
74b0fe804097330 Jonathan Cameron 2022-02-01   44  	u32 cap_array;
0f06157e0135f55 Dan Williams     2021-08-03   45  
0f06157e0135f55 Dan Williams     2021-08-03   46  	*map = (struct cxl_component_reg_map) { 0 };
0f06157e0135f55 Dan Williams     2021-08-03   47  
0f06157e0135f55 Dan Williams     2021-08-03   48  	/*
0f06157e0135f55 Dan Williams     2021-08-03   49  	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
0f06157e0135f55 Dan Williams     2021-08-03   50  	 * CXL 2.0 8.2.4 Table 141.
0f06157e0135f55 Dan Williams     2021-08-03   51  	 */
0f06157e0135f55 Dan Williams     2021-08-03   52  	base += CXL_CM_OFFSET;
0f06157e0135f55 Dan Williams     2021-08-03   53  
74b0fe804097330 Jonathan Cameron 2022-02-01   54  	cap_array = readl(base + CXL_CM_CAP_HDR_OFFSET);
0f06157e0135f55 Dan Williams     2021-08-03   55  
0f06157e0135f55 Dan Williams     2021-08-03   56  	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, cap_array) != CM_CAP_HDR_CAP_ID) {
9474d586819940f Coly Li          2024-10-21   57  		dev_dbg(dev,
d621bc2e7282f99 Dan Williams     2022-01-23   58  			"Couldn't locate the CXL.cache and CXL.mem capability array header.\n");
0f06157e0135f55 Dan Williams     2021-08-03   59  		return;
0f06157e0135f55 Dan Williams     2021-08-03   60  	}
0f06157e0135f55 Dan Williams     2021-08-03   61  
0f06157e0135f55 Dan Williams     2021-08-03   62  	/* It's assumed that future versions will be backward compatible */
0f06157e0135f55 Dan Williams     2021-08-03   63  	cap_count = FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_array);
0f06157e0135f55 Dan Williams     2021-08-03   64  
0f06157e0135f55 Dan Williams     2021-08-03   65  	for (cap = 1; cap <= cap_count; cap++) {
0f06157e0135f55 Dan Williams     2021-08-03   66  		void __iomem *register_block;
af2dfef854aa6af Dan Williams     2022-11-29   67  		struct cxl_reg_map *rmap;
0f06157e0135f55 Dan Williams     2021-08-03   68  		u16 cap_id, offset;
af2dfef854aa6af Dan Williams     2022-11-29   69  		u32 length, hdr;
0f06157e0135f55 Dan Williams     2021-08-03   70  
0f06157e0135f55 Dan Williams     2021-08-03   71  		hdr = readl(base + cap * 0x4);
0f06157e0135f55 Dan Williams     2021-08-03   72  
0f06157e0135f55 Dan Williams     2021-08-03   73  		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
0f06157e0135f55 Dan Williams     2021-08-03   74  		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
0f06157e0135f55 Dan Williams     2021-08-03   75  		register_block = base + offset;
af2dfef854aa6af Dan Williams     2022-11-29   76  		hdr = readl(register_block);
0f06157e0135f55 Dan Williams     2021-08-03   77  
af2dfef854aa6af Dan Williams     2022-11-29   78  		rmap = NULL;
0f06157e0135f55 Dan Williams     2021-08-03   79  		switch (cap_id) {
af2dfef854aa6af Dan Williams     2022-11-29   80  		case CXL_CM_CAP_CAP_ID_HDM: {
af2dfef854aa6af Dan Williams     2022-11-29   81  			int decoder_cnt;
af2dfef854aa6af Dan Williams     2022-11-29   82  
0f06157e0135f55 Dan Williams     2021-08-03   83  			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
0f06157e0135f55 Dan Williams     2021-08-03   84  				offset);
0f06157e0135f55 Dan Williams     2021-08-03   85  
0f06157e0135f55 Dan Williams     2021-08-03   86  			decoder_cnt = cxl_hdm_decoder_count(hdr);
0f06157e0135f55 Dan Williams     2021-08-03   87  			length = 0x20 * decoder_cnt + 0x10;
af2dfef854aa6af Dan Williams     2022-11-29   88  			rmap = &map->hdm_decoder;
b98956b0195863f Alejandro Lucero 2024-12-02   89  			*caps |= BIT(CXL_DEV_CAP_HDM);
0f06157e0135f55 Dan Williams     2021-08-03   90  			break;
af2dfef854aa6af Dan Williams     2022-11-29   91  		}
bd09626b39dff97 Dan Williams     2022-11-29   92  		case CXL_CM_CAP_CAP_ID_RAS:
bd09626b39dff97 Dan Williams     2022-11-29   93  			dev_dbg(dev, "found RAS capability (0x%x)\n",
bd09626b39dff97 Dan Williams     2022-11-29   94  				offset);
bd09626b39dff97 Dan Williams     2022-11-29   95  			length = CXL_RAS_CAPABILITY_LENGTH;
bd09626b39dff97 Dan Williams     2022-11-29   96  			rmap = &map->ras;
b98956b0195863f Alejandro Lucero 2024-12-02   97  			*caps |= BIT(CXL_DEV_CAP_RAS);
0f06157e0135f55 Dan Williams     2021-08-03   98  			break;
0f06157e0135f55 Dan Williams     2021-08-03   99  		default:
0f06157e0135f55 Dan Williams     2021-08-03  100  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
0f06157e0135f55 Dan Williams     2021-08-03  101  				offset);
0f06157e0135f55 Dan Williams     2021-08-03  102  			break;
0f06157e0135f55 Dan Williams     2021-08-03  103  		}
af2dfef854aa6af Dan Williams     2022-11-29  104  
af2dfef854aa6af Dan Williams     2022-11-29  105  		if (!rmap)
af2dfef854aa6af Dan Williams     2022-11-29  106  			continue;
af2dfef854aa6af Dan Williams     2022-11-29  107  		rmap->valid = true;
a1554e9cac5ea04 Dan Williams     2022-11-29  108  		rmap->id = cap_id;
af2dfef854aa6af Dan Williams     2022-11-29  109  		rmap->offset = CXL_CM_OFFSET + offset;
af2dfef854aa6af Dan Williams     2022-11-29  110  		rmap->size = length;
0f06157e0135f55 Dan Williams     2021-08-03  111  	}
0f06157e0135f55 Dan Williams     2021-08-03  112  }
affec782742e08a Dan Williams     2021-11-12  113  EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
0f06157e0135f55 Dan Williams     2021-08-03  114  
0f06157e0135f55 Dan Williams     2021-08-03  115  /**
0f06157e0135f55 Dan Williams     2021-08-03  116   * cxl_probe_device_regs() - Detect CXL Device register blocks
0f06157e0135f55 Dan Williams     2021-08-03  117   * @dev: Host device of the @base mapping
0f06157e0135f55 Dan Williams     2021-08-03  118   * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
0f06157e0135f55 Dan Williams     2021-08-03  119   * @map: Map object describing the register block information found
0f06157e0135f55 Dan Williams     2021-08-03  120   *
0f06157e0135f55 Dan Williams     2021-08-03  121   * Probe for device register information and return it in map object.
0f06157e0135f55 Dan Williams     2021-08-03  122   */
0f06157e0135f55 Dan Williams     2021-08-03  123  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
b98956b0195863f Alejandro Lucero 2024-12-02  124  			   struct cxl_device_reg_map *map, unsigned long *caps)
0f06157e0135f55 Dan Williams     2021-08-03 @125  {
0f06157e0135f55 Dan Williams     2021-08-03  126  	int cap, cap_count;
0f06157e0135f55 Dan Williams     2021-08-03  127  	u64 cap_array;
0f06157e0135f55 Dan Williams     2021-08-03  128  
0f06157e0135f55 Dan Williams     2021-08-03  129  	*map = (struct cxl_device_reg_map){ 0 };
0f06157e0135f55 Dan Williams     2021-08-03  130  
0f06157e0135f55 Dan Williams     2021-08-03  131  	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
0f06157e0135f55 Dan Williams     2021-08-03  132  	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
0f06157e0135f55 Dan Williams     2021-08-03  133  	    CXLDEV_CAP_ARRAY_CAP_ID)
0f06157e0135f55 Dan Williams     2021-08-03  134  		return;
0f06157e0135f55 Dan Williams     2021-08-03  135  
0f06157e0135f55 Dan Williams     2021-08-03  136  	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
0f06157e0135f55 Dan Williams     2021-08-03  137  
0f06157e0135f55 Dan Williams     2021-08-03  138  	for (cap = 1; cap <= cap_count; cap++) {
af2dfef854aa6af Dan Williams     2022-11-29  139  		struct cxl_reg_map *rmap;
0f06157e0135f55 Dan Williams     2021-08-03  140  		u32 offset, length;
0f06157e0135f55 Dan Williams     2021-08-03  141  		u16 cap_id;
0f06157e0135f55 Dan Williams     2021-08-03  142  
0f06157e0135f55 Dan Williams     2021-08-03  143  		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
0f06157e0135f55 Dan Williams     2021-08-03  144  				   readl(base + cap * 0x10));
0f06157e0135f55 Dan Williams     2021-08-03  145  		offset = readl(base + cap * 0x10 + 0x4);
0f06157e0135f55 Dan Williams     2021-08-03  146  		length = readl(base + cap * 0x10 + 0x8);
0f06157e0135f55 Dan Williams     2021-08-03  147  
af2dfef854aa6af Dan Williams     2022-11-29  148  		rmap = NULL;
0f06157e0135f55 Dan Williams     2021-08-03  149  		switch (cap_id) {
0f06157e0135f55 Dan Williams     2021-08-03  150  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
0f06157e0135f55 Dan Williams     2021-08-03  151  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
af2dfef854aa6af Dan Williams     2022-11-29  152  			rmap = &map->status;
b98956b0195863f Alejandro Lucero 2024-12-02  153  			*caps |= BIT(CXL_DEV_CAP_DEV_STATUS);
0f06157e0135f55 Dan Williams     2021-08-03  154  			break;
0f06157e0135f55 Dan Williams     2021-08-03  155  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
0f06157e0135f55 Dan Williams     2021-08-03  156  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
af2dfef854aa6af Dan Williams     2022-11-29  157  			rmap = &map->mbox;
b98956b0195863f Alejandro Lucero 2024-12-02  158  			*caps |= BIT(CXL_DEV_CAP_MAILBOX_PRIMARY);
0f06157e0135f55 Dan Williams     2021-08-03  159  			break;
0f06157e0135f55 Dan Williams     2021-08-03  160  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
0f06157e0135f55 Dan Williams     2021-08-03  161  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
0f06157e0135f55 Dan Williams     2021-08-03  162  			break;
0f06157e0135f55 Dan Williams     2021-08-03  163  		case CXLDEV_CAP_CAP_ID_MEMDEV:
0f06157e0135f55 Dan Williams     2021-08-03  164  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
af2dfef854aa6af Dan Williams     2022-11-29  165  			rmap = &map->memdev;
b98956b0195863f Alejandro Lucero 2024-12-02  166  			*caps |= BIT(CXL_DEV_CAP_MEMDEV);
0f06157e0135f55 Dan Williams     2021-08-03  167  			break;
0f06157e0135f55 Dan Williams     2021-08-03  168  		default:
0f06157e0135f55 Dan Williams     2021-08-03  169  			if (cap_id >= 0x8000)
0f06157e0135f55 Dan Williams     2021-08-03  170  				dev_dbg(dev, "Vendor cap ID: %#x offset: %#x\n", cap_id, offset);
0f06157e0135f55 Dan Williams     2021-08-03  171  			else
0f06157e0135f55 Dan Williams     2021-08-03  172  				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
0f06157e0135f55 Dan Williams     2021-08-03  173  			break;
0f06157e0135f55 Dan Williams     2021-08-03  174  		}
af2dfef854aa6af Dan Williams     2022-11-29  175  
af2dfef854aa6af Dan Williams     2022-11-29  176  		if (!rmap)
af2dfef854aa6af Dan Williams     2022-11-29  177  			continue;
af2dfef854aa6af Dan Williams     2022-11-29  178  		rmap->valid = true;
a1554e9cac5ea04 Dan Williams     2022-11-29  179  		rmap->id = cap_id;
af2dfef854aa6af Dan Williams     2022-11-29  180  		rmap->offset = offset;
af2dfef854aa6af Dan Williams     2022-11-29  181  		rmap->size = length;
0f06157e0135f55 Dan Williams     2021-08-03  182  	}
0f06157e0135f55 Dan Williams     2021-08-03  183  }
affec782742e08a Dan Williams     2021-11-12  184  EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
0f06157e0135f55 Dan Williams     2021-08-03  185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

