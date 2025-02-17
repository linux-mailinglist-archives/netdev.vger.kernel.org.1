Return-Path: <netdev+bounces-166895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12400A37D05
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EB83B0E16
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23719CD13;
	Mon, 17 Feb 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqUJMTiz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B154155C82;
	Mon, 17 Feb 2025 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780409; cv=none; b=p3v3SOlxLzk97Vs53siL/U8h4NeJONd4nnIadRidTuZWq7bOoOPzhneJyxh78S7ZZUfWK1B2PD13I9jaBL8Oj7iFR31dyrMk2OsTGTQQ2Wyn+EArSfURY2wmh/BHqnay1ocVRie0G/hcycfB8rdeTm00Tp+In9rO4gvjmjZ5FpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780409; c=relaxed/simple;
	bh=oPkuHL9Dy3/UxnFwaQibKWWo5ejIr+ylnjV+e/PO7Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkdD9iaPldQt2MDwTtKM5dGiLn4TcwKYznJFCHFcJoXXsLZ9zGC5E5PlNe0B022QsLUgkcvJvTaHCBljXv3oISGFtX0+/0xpfmGM9Vj2XBJ28nalWorVhZJB9gnxe85h4nTglcblEtA4fZeUf2A0SzHcMzXAAN2J8EMNms9vnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqUJMTiz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739780408; x=1771316408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oPkuHL9Dy3/UxnFwaQibKWWo5ejIr+ylnjV+e/PO7Mc=;
  b=QqUJMTiz+ztUKgqipZU9B1H/oNnixNoD6fmVFRhxFv3NosbXSibU7hg3
   1ANbLpj9By2kKWR+Pp1Fd7YM+uinY5Q3IHGd3QWlWkGNcqn4tEaUsv5Kb
   8wszyQQ9YRLr30wwPmZRcDJbfVDIDmEhfZoeOf6HfjwvS2iMtuzZ85eb7
   X4/eKM3g1Z/NRZyQ8sOef3cGTzfEftwWo5vycphh67eNCqwvJajbf202O
   JsvnXfxI1Wll/M3MZQaEUSNWaBGu7XH5rZCY70WtqksnyDCfjTcs3VN9b
   /xFdooevdeO6/Y2/JXZOzQLHLLN4WX+qZiS1DieDGMruhoo4QI2hodGja
   w==;
X-CSE-ConnectionGUID: exyO+C9FTsaorUEvfBrKRA==
X-CSE-MsgGUID: yAIWtOQZT/+C79lDZZDrRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40377392"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40377392"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 00:20:07 -0800
X-CSE-ConnectionGUID: psU11MIcQB+yvaheySR5bA==
X-CSE-MsgGUID: OMcPVd88Qeai6K8lHCZInQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118977219"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 00:20:04 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjwMD-001CmY-1A;
	Mon, 17 Feb 2025 08:20:01 +0000
Date: Mon, 17 Feb 2025 16:19:59 +0800
From: kernel test robot <lkp@intel.com>
To: Qingfang Deng <dqfext@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: ethernet: mediatek: add EEE support
Message-ID: <202502171610.TU1Cuzq5-lkp@intel.com>
References: <20250217033954.3698772-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217033954.3698772-1-dqfext@gmail.com>

Hi Qingfang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Qingfang-Deng/net-ethernet-mediatek-add-EEE-support/20250217-114148
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250217033954.3698772-1-dqfext%40gmail.com
patch subject: [PATCH net-next v3] net: ethernet: mediatek: add EEE support
config: arm64-randconfig-001-20250217 (https://download.01.org/0day-ci/archive/20250217/202502171610.TU1Cuzq5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502171610.TU1Cuzq5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502171610.TU1Cuzq5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_mac_enable_tx_lpi':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:860:1: warning: control reaches end of non-void function [-Wreturn-type]
     860 | }
         | ^


vim +860 drivers/net/ethernet/mediatek/mtk_eth_soc.c

   826	
   827	static int mtk_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
   828					 bool tx_clk_stop)
   829	{
   830		struct mtk_mac *mac = container_of(config, struct mtk_mac,
   831						   phylink_config);
   832		struct mtk_eth *eth = mac->hw;
   833		u32 val;
   834	
   835		/* Tx idle timer in ms */
   836		timer = DIV_ROUND_UP(timer, 1000);
   837	
   838		/* If the timer is zero, then set LPI_MODE, which allows the
   839		 * system to enter LPI mode immediately rather than waiting for
   840		 * the LPI threshold.
   841		 */
   842		if (!timer)
   843			val = MAC_EEE_LPI_MODE;
   844		else if (FIELD_FIT(MAC_EEE_LPI_TXIDLE_THD, timer))
   845			val = FIELD_PREP(MAC_EEE_LPI_TXIDLE_THD, timer);
   846		else
   847			val = MAC_EEE_LPI_TXIDLE_THD;
   848	
   849		if (tx_clk_stop)
   850			val |= MAC_EEE_CKG_TXIDLE;
   851	
   852		/* PHY Wake-up time, this field does not have a reset value, so use the
   853		 * reset value from MT7531 (36us for 100M and 17us for 1000M).
   854		 */
   855		val |= FIELD_PREP(MAC_EEE_WAKEUP_TIME_1000, 17) |
   856		       FIELD_PREP(MAC_EEE_WAKEUP_TIME_100, 36);
   857	
   858		mtk_w32(eth, val, MTK_MAC_EEECR(mac->id));
   859		mtk_m32(eth, 0, MAC_MCR_EEE100M | MAC_MCR_EEE1G, MTK_MAC_MCR(mac->id));
 > 860	}
   861	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

