Return-Path: <netdev+bounces-97688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DF8CCBD8
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 07:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBC1C20D52
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 05:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5713AA37;
	Thu, 23 May 2024 05:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEBGB5gk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833313A878;
	Thu, 23 May 2024 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442982; cv=none; b=kGO8PX2GOy0Rrb6BlfPwTnb7b+MxqyuSkkuCRXNDeiFjZ+p2UlMlWnGBRbtXdoEDf/eoCiaEvVA6dHTMOlDOWRi3IIgZRxqhkfIVIRTJbwV86TnD5tJx8AGgmOSZupQeGlo6WvGc938Ekk56CYYBGHz1DRoblKzbzWL/vM2ru/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442982; c=relaxed/simple;
	bh=88s1vpCBMF+dlHmUmW30fyJu3maxb0biFJmEDoIHHXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/PqP5Ql/v5Ojj3QbC/AY5TTdYpRWOTeiYAffacYxfYtfYasIPNMPGQY86nk53mUTx/9nTja7R2Yax4CpssEg05pz9gPpImBrid3kdPzv8rXdsfNJoqzIT25rT/8ph4ln/MnDkhlfffu+meiZ43311bvadpPvlTZZQl5ChzAJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEBGB5gk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716442981; x=1747978981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88s1vpCBMF+dlHmUmW30fyJu3maxb0biFJmEDoIHHXE=;
  b=DEBGB5gk05MymSyyC0brQ7yBRE/qZZVtUZrrNLnnhh5EQx2+gD07z+rw
   5vL3OQFWJYJ9uder5+XCbw+xBWPdjxipVfXqU5erb9Q4+EtuoSzDkaYum
   I6VztsoUsxH7WMIH4cXkllH4Ctar1ROxshMQekMNKZvdELb3KFkDBFY4w
   Sp8S2lwTISBUqDEwkYPR6k9IZ9qTnagePIdI0pUTiNYJyq3dzYUN4YJYs
   XpkF9p8cEHSizlu0OwMz6I2otAi7eeBVuaDEO05uLiFWl4ZsgpppY7LHD
   Dgxn64uMkT8dYyebUxWPvUIOrPm/PHgRzIVffVoifNCenRJvnG8GcgxQ7
   Q==;
X-CSE-ConnectionGUID: Xb3XaF+URimzB6YUGXrfjg==
X-CSE-MsgGUID: IKv4qjzYQceZmzsycwQuUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="23400268"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="23400268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 22:43:00 -0700
X-CSE-ConnectionGUID: O9DTBlLPQL+d/szWuxD61A==
X-CSE-MsgGUID: UR22QgijQdCddE0wgZ7BIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38126761"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 22 May 2024 22:42:57 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA1E7-0002Ux-0n;
	Thu, 23 May 2024 05:42:55 +0000
Date: Thu, 23 May 2024 13:42:44 +0800
From: kernel test robot <lkp@intel.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Message-ID: <202405231332.bBXpW9Bj-lkp@intel.com>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4b377b4868ef17b040065bd468668c707d2477a5]

url:    https://github.com/intel-lab-lkp/linux/commits/Parthiban-Veerasooran/net-usb-smsc95xx-configure-external-LEDs-function-for-EVB-LAN8670-USB/20240522-221645
base:   4b377b4868ef17b040065bd468668c707d2477a5
patch link:    https://lore.kernel.org/r/20240522140817.409936-1-Parthiban.Veerasooran%40microchip.com
patch subject: [PATCH] net: usb: smsc95xx: configure external LEDs function for EVB-LAN8670-USB
config: i386-randconfig-062-20240523 (https://download.01.org/0day-ci/archive/20240523/202405231332.bBXpW9Bj-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231332.bBXpW9Bj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405231332.bBXpW9Bj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/usb/smsc95xx.c:1017:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/usb/smsc95xx.c:1018:34: sparse: sparse: restricted __le16 degrades to integer

vim +1017 drivers/net/usb/smsc95xx.c

   878	
   879	static int smsc95xx_reset(struct usbnet *dev)
   880	{
   881		struct smsc95xx_priv *pdata = dev->driver_priv;
   882		u32 read_buf, write_buf, burst_cap;
   883		int ret = 0, timeout;
   884	
   885		netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
   886	
   887		ret = smsc95xx_write_reg(dev, HW_CFG, HW_CFG_LRST_);
   888		if (ret < 0)
   889			return ret;
   890	
   891		timeout = 0;
   892		do {
   893			msleep(10);
   894			ret = smsc95xx_read_reg(dev, HW_CFG, &read_buf);
   895			if (ret < 0)
   896				return ret;
   897			timeout++;
   898		} while ((read_buf & HW_CFG_LRST_) && (timeout < 100));
   899	
   900		if (timeout >= 100) {
   901			netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
   902			return -ETIMEDOUT;
   903		}
   904	
   905		ret = smsc95xx_set_mac_address(dev);
   906		if (ret < 0)
   907			return ret;
   908	
   909		netif_dbg(dev, ifup, dev->net, "MAC Address: %pM\n",
   910			  dev->net->dev_addr);
   911	
   912		ret = smsc95xx_read_reg(dev, HW_CFG, &read_buf);
   913		if (ret < 0)
   914			return ret;
   915	
   916		netif_dbg(dev, ifup, dev->net, "Read Value from HW_CFG : 0x%08x\n",
   917			  read_buf);
   918	
   919		read_buf |= HW_CFG_BIR_;
   920	
   921		ret = smsc95xx_write_reg(dev, HW_CFG, read_buf);
   922		if (ret < 0)
   923			return ret;
   924	
   925		ret = smsc95xx_read_reg(dev, HW_CFG, &read_buf);
   926		if (ret < 0)
   927			return ret;
   928	
   929		netif_dbg(dev, ifup, dev->net,
   930			  "Read Value from HW_CFG after writing HW_CFG_BIR_: 0x%08x\n",
   931			  read_buf);
   932	
   933		if (!turbo_mode) {
   934			burst_cap = 0;
   935			dev->rx_urb_size = MAX_SINGLE_PACKET_SIZE;
   936		} else if (dev->udev->speed == USB_SPEED_HIGH) {
   937			burst_cap = DEFAULT_HS_BURST_CAP_SIZE / HS_USB_PKT_SIZE;
   938			dev->rx_urb_size = DEFAULT_HS_BURST_CAP_SIZE;
   939		} else {
   940			burst_cap = DEFAULT_FS_BURST_CAP_SIZE / FS_USB_PKT_SIZE;
   941			dev->rx_urb_size = DEFAULT_FS_BURST_CAP_SIZE;
   942		}
   943	
   944		netif_dbg(dev, ifup, dev->net, "rx_urb_size=%ld\n",
   945			  (ulong)dev->rx_urb_size);
   946	
   947		ret = smsc95xx_write_reg(dev, BURST_CAP, burst_cap);
   948		if (ret < 0)
   949			return ret;
   950	
   951		ret = smsc95xx_read_reg(dev, BURST_CAP, &read_buf);
   952		if (ret < 0)
   953			return ret;
   954	
   955		netif_dbg(dev, ifup, dev->net,
   956			  "Read Value from BURST_CAP after writing: 0x%08x\n",
   957			  read_buf);
   958	
   959		ret = smsc95xx_write_reg(dev, BULK_IN_DLY, DEFAULT_BULK_IN_DELAY);
   960		if (ret < 0)
   961			return ret;
   962	
   963		ret = smsc95xx_read_reg(dev, BULK_IN_DLY, &read_buf);
   964		if (ret < 0)
   965			return ret;
   966	
   967		netif_dbg(dev, ifup, dev->net,
   968			  "Read Value from BULK_IN_DLY after writing: 0x%08x\n",
   969			  read_buf);
   970	
   971		ret = smsc95xx_read_reg(dev, HW_CFG, &read_buf);
   972		if (ret < 0)
   973			return ret;
   974	
   975		netif_dbg(dev, ifup, dev->net, "Read Value from HW_CFG: 0x%08x\n",
   976			  read_buf);
   977	
   978		if (turbo_mode)
   979			read_buf |= (HW_CFG_MEF_ | HW_CFG_BCE_);
   980	
   981		read_buf &= ~HW_CFG_RXDOFF_;
   982	
   983		/* set Rx data offset=2, Make IP header aligns on word boundary. */
   984		read_buf |= NET_IP_ALIGN << 9;
   985	
   986		ret = smsc95xx_write_reg(dev, HW_CFG, read_buf);
   987		if (ret < 0)
   988			return ret;
   989	
   990		ret = smsc95xx_read_reg(dev, HW_CFG, &read_buf);
   991		if (ret < 0)
   992			return ret;
   993	
   994		netif_dbg(dev, ifup, dev->net,
   995			  "Read Value from HW_CFG after writing: 0x%08x\n", read_buf);
   996	
   997		ret = smsc95xx_write_reg(dev, INT_STS, INT_STS_CLEAR_ALL_);
   998		if (ret < 0)
   999			return ret;
  1000	
  1001		ret = smsc95xx_read_reg(dev, ID_REV, &read_buf);
  1002		if (ret < 0)
  1003			return ret;
  1004		netif_dbg(dev, ifup, dev->net, "ID_REV = 0x%08x\n", read_buf);
  1005	
  1006		/* Configure GPIO pins as LED outputs */
  1007		write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
  1008			LED_GPIO_CFG_FDX_LED;
  1009	
  1010		/* Set LED Select (LED_SEL) bit for the external LED pins functionality
  1011		 * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which
  1012		 * uses the below LED function.
  1013		 * nSPD_LED -> Speed Indicator
  1014		 * nLNKA_LED -> Link Indicator
  1015		 * nFDX_LED -> Activity Indicator
  1016		 */
> 1017		if (dev->udev->descriptor.idVendor == 0x184F &&
  1018		    dev->udev->descriptor.idProduct == 0x0051)
  1019			write_buf |= LED_GPIO_CFG_LED_SEL;
  1020	
  1021		ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
  1022		if (ret < 0)
  1023			return ret;
  1024	
  1025		/* Init Tx */
  1026		ret = smsc95xx_write_reg(dev, FLOW, 0);
  1027		if (ret < 0)
  1028			return ret;
  1029	
  1030		ret = smsc95xx_write_reg(dev, AFC_CFG, AFC_CFG_DEFAULT);
  1031		if (ret < 0)
  1032			return ret;
  1033	
  1034		/* Don't need mac_cr_lock during initialisation */
  1035		ret = smsc95xx_read_reg(dev, MAC_CR, &pdata->mac_cr);
  1036		if (ret < 0)
  1037			return ret;
  1038	
  1039		/* Init Rx */
  1040		/* Set Vlan */
  1041		ret = smsc95xx_write_reg(dev, VLAN1, (u32)ETH_P_8021Q);
  1042		if (ret < 0)
  1043			return ret;
  1044	
  1045		/* Enable or disable checksum offload engines */
  1046		ret = smsc95xx_set_features(dev->net, dev->net->features);
  1047		if (ret < 0) {
  1048			netdev_warn(dev->net, "Failed to set checksum offload features\n");
  1049			return ret;
  1050		}
  1051	
  1052		smsc95xx_set_multicast(dev->net);
  1053	
  1054		ret = smsc95xx_read_reg(dev, INT_EP_CTL, &read_buf);
  1055		if (ret < 0)
  1056			return ret;
  1057	
  1058		/* enable PHY interrupts */
  1059		read_buf |= INT_EP_CTL_PHY_INT_;
  1060	
  1061		ret = smsc95xx_write_reg(dev, INT_EP_CTL, read_buf);
  1062		if (ret < 0)
  1063			return ret;
  1064	
  1065		ret = smsc95xx_start_tx_path(dev);
  1066		if (ret < 0) {
  1067			netdev_warn(dev->net, "Failed to start TX path\n");
  1068			return ret;
  1069		}
  1070	
  1071		ret = smsc95xx_start_rx_path(dev);
  1072		if (ret < 0) {
  1073			netdev_warn(dev->net, "Failed to start RX path\n");
  1074			return ret;
  1075		}
  1076	
  1077		netif_dbg(dev, ifup, dev->net, "smsc95xx_reset, return 0\n");
  1078		return 0;
  1079	}
  1080	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

