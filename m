Return-Path: <netdev+bounces-269190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQjJmkdu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:47:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 420002C3207
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 22:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 697C83021958
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4563191CA;
	Wed, 18 Mar 2026 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZANyQvtF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A993101CE;
	Wed, 18 Mar 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870439; cv=none; b=KexJET135thYatU0jkxB4jj8ATT79336ZpiNV2L2RbzN4uHtAJctHWG0bt03OjKeq9BftgtimHvKnikQeif6SoVVzxbmXKM7khjLOujMdzQVpIi7pQlknzkYXn44f9H3/tPO5Ja2aShkXVFHLnuzFBzPvNjSw6WNrzIDtG8aBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870439; c=relaxed/simple;
	bh=RA3j/XD4y2U9A3HxcRzldc4X0XRQzVocw8+hnS/uXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o15KrNywt2AGoxDZE9eSEjEHUG1IsusySDVPrqQTX2UclQCR1D7NCvzFFtHO9bf9aaonysSVpFsuXfbSDU1UyCSJCZnMuoQ/NJQoBU9WCyHU9JWfGMpdrCaRzICd0LFdGquYG7GCMa6w66Ev/4YgiEp3JGH4n+CyXcvKrfAKVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZANyQvtF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773870437; x=1805406437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RA3j/XD4y2U9A3HxcRzldc4X0XRQzVocw8+hnS/uXsY=;
  b=ZANyQvtFVIqaJaTwLHiDIoGx6yLF1K/Ersw54v1EAeaphtPpFc4Xjwsb
   3GwKwnL/fOgL8XyCcGLpPbJ8s3ifGVoN1tS9e3CEnwbEADRKMITkrhNaz
   +b/eNrYOwwL9QeqXwQ8Fo/60buIrKAgfVnknmQL6rBQVW6Ec8xUWmXr8Z
   p9h5gLh88EpxLRH0I9ZoNQvXmcOb/wOgcXz7muwXaOJCymyCqFb7L7TrZ
   p7yGx9N3BfRVsrRPIVmxTBnaS7F6xvasKm/hAVG+uESpS9KXXfieo7o5n
   s99kq4EiUql8/KHyhrG2c+Zp5cY1cO0gkQQEBSM9BgUDpEl2YYvUIMIdU
   Q==;
X-CSE-ConnectionGUID: HiPppBjrQNmzbwqlGzgOWA==
X-CSE-MsgGUID: XP3X8Y21QtapdbHcMMO9Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="100397321"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="100397321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:47:16 -0700
X-CSE-ConnectionGUID: pTbgHy4USm+BLilODy/vkg==
X-CSE-MsgGUID: PZVGTiSlSC+Snu51oRe+ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260655274"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2026 14:47:14 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2yjP-000000004jN-25sy;
	Wed, 18 Mar 2026 21:47:11 +0000
Date: Wed, 18 Mar 2026 22:46:23 +0100
From: kernel test robot <lkp@intel.com>
To: hsuck <hsu.chih.kai@realtek.com>, kuba@kernel.org, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
	pabeni@redhat.com, hsuck <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 2/2] r8152: add helper functions for PHY OCP
 registers
Message-ID: <202603182245.DaTGXbkG-lkp@intel.com>
References: <20260318123313.2313-446-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318123313.2313-446-nic_swsd@realtek.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269190-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 420002C3207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi hsuck,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/hsuck/r8152-add-helper-functions-for-PLA-USB-OCP-registers/20260318-232634
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260318123313.2313-446-nic_swsd%40realtek.com
patch subject: [PATCH net-next 2/2] r8152: add helper functions for PHY OCP registers
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260318/202603182245.DaTGXbkG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260318/202603182245.DaTGXbkG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603182245.DaTGXbkG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/usb/r8152.c: In function 'r8153_init':
>> drivers/net/usb/r8152.c:6864:13: warning: variable 'data' set but not used [-Wunused-but-set-variable]
    6864 |         u16 data;
         |             ^~~~
   drivers/net/usb/r8152.c: In function 'r8153b_init':
   drivers/net/usb/r8152.c:6983:13: warning: variable 'data' set but not used [-Wunused-but-set-variable]
    6983 |         u16 data;
         |             ^~~~
   drivers/net/usb/r8152.c: In function 'r8153c_init':
   drivers/net/usb/r8152.c:7054:13: warning: variable 'data' set but not used [-Wunused-but-set-variable]
    7054 |         u16 data;
         |             ^~~~


vim +/data +6864 drivers/net/usb/r8152.c

195aae321c829d Hayes Wang       2021-04-16  6861  
195aae321c829d Hayes Wang       2021-04-16  6862  static void r8153_init(struct r8152 *tp)
195aae321c829d Hayes Wang       2021-04-16  6863  {
195aae321c829d Hayes Wang       2021-04-16 @6864  	u16 data;
195aae321c829d Hayes Wang       2021-04-16  6865  	int i;
195aae321c829d Hayes Wang       2021-04-16  6866  
715f67f33af45c Douglas Anderson 2023-10-20  6867  	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
195aae321c829d Hayes Wang       2021-04-16  6868  		return;
195aae321c829d Hayes Wang       2021-04-16  6869  
195aae321c829d Hayes Wang       2021-04-16  6870  	r8153_u1u2en(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6871  
195aae321c829d Hayes Wang       2021-04-16  6872  	for (i = 0; i < 500; i++) {
195aae321c829d Hayes Wang       2021-04-16  6873  		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
195aae321c829d Hayes Wang       2021-04-16  6874  		    AUTOLOAD_DONE)
195aae321c829d Hayes Wang       2021-04-16  6875  			break;
195aae321c829d Hayes Wang       2021-04-16  6876  
195aae321c829d Hayes Wang       2021-04-16  6877  		msleep(20);
715f67f33af45c Douglas Anderson 2023-10-20  6878  		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
195aae321c829d Hayes Wang       2021-04-16  6879  			break;
195aae321c829d Hayes Wang       2021-04-16  6880  	}
195aae321c829d Hayes Wang       2021-04-16  6881  
195aae321c829d Hayes Wang       2021-04-16  6882  	data = r8153_phy_status(tp, 0);
195aae321c829d Hayes Wang       2021-04-16  6883  
195aae321c829d Hayes Wang       2021-04-16  6884  	if (tp->version == RTL_VER_03 || tp->version == RTL_VER_04 ||
195aae321c829d Hayes Wang       2021-04-16  6885  	    tp->version == RTL_VER_05)
195aae321c829d Hayes Wang       2021-04-16  6886  		ocp_reg_write(tp, OCP_ADC_CFG, CKADSEL_L | ADC_EN | EN_EMI_L);
195aae321c829d Hayes Wang       2021-04-16  6887  
b520efeb0a4573 hsuck            2026-03-18  6888  	r8152_mdio_test_and_clr_bit(tp, MII_BMCR, BMCR_PDOWN);
195aae321c829d Hayes Wang       2021-04-16  6889  
195aae321c829d Hayes Wang       2021-04-16  6890  	data = r8153_phy_status(tp, PHY_STAT_LAN_ON);
195aae321c829d Hayes Wang       2021-04-16  6891  
195aae321c829d Hayes Wang       2021-04-16  6892  	r8153_u2p3en(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6893  
195aae321c829d Hayes Wang       2021-04-16  6894  	if (tp->version == RTL_VER_04) {
ce600d52ace5a4 hsuck            2026-03-18  6895  		ocp_word_w0w1(tp, MCU_TYPE_USB, USB_SSPHYLINK2,
ce600d52ace5a4 hsuck            2026-03-18  6896  			      pwd_dn_scale_mask, pwd_dn_scale(96));
ce600d52ace5a4 hsuck            2026-03-18  6897  
ce600d52ace5a4 hsuck            2026-03-18  6898  		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_USB2PHY,
ce600d52ace5a4 hsuck            2026-03-18  6899  				  USB2PHY_L1 | USB2PHY_SUSPEND);
195aae321c829d Hayes Wang       2021-04-16  6900  	} else if (tp->version == RTL_VER_05) {
ce600d52ace5a4 hsuck            2026-03-18  6901  		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_DMY_REG0, ECM_ALDPS);
195aae321c829d Hayes Wang       2021-04-16  6902  
195aae321c829d Hayes Wang       2021-04-16  6903  		if (ocp_read_word(tp, MCU_TYPE_USB, USB_BURST_SIZE) == 0)
ce600d52ace5a4 hsuck            2026-03-18  6904  			ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
ce600d52ace5a4 hsuck            2026-03-18  6905  					  DYNAMIC_BURST);
195aae321c829d Hayes Wang       2021-04-16  6906  		else
ce600d52ace5a4 hsuck            2026-03-18  6907  			ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
ce600d52ace5a4 hsuck            2026-03-18  6908  					  DYNAMIC_BURST);
195aae321c829d Hayes Wang       2021-04-16  6909  	} else if (tp->version == RTL_VER_06) {
195aae321c829d Hayes Wang       2021-04-16  6910  		if (ocp_read_word(tp, MCU_TYPE_USB, USB_BURST_SIZE) == 0)
ce600d52ace5a4 hsuck            2026-03-18  6911  			ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
ce600d52ace5a4 hsuck            2026-03-18  6912  					  DYNAMIC_BURST);
195aae321c829d Hayes Wang       2021-04-16  6913  		else
ce600d52ace5a4 hsuck            2026-03-18  6914  			ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY1,
ce600d52ace5a4 hsuck            2026-03-18  6915  					  DYNAMIC_BURST);
195aae321c829d Hayes Wang       2021-04-16  6916  
195aae321c829d Hayes Wang       2021-04-16  6917  		r8153_queue_wake(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6918  
195aae321c829d Hayes Wang       2021-04-16  6919  		if (rtl8152_get_speed(tp) & LINK_STATUS)
ce600d52ace5a4 hsuck            2026-03-18  6920  			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
ce600d52ace5a4 hsuck            2026-03-18  6921  					  CUR_LINK_OK | POLL_LINK_CHG);
195aae321c829d Hayes Wang       2021-04-16  6922  		else
ce600d52ace5a4 hsuck            2026-03-18  6923  			ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_EXTRA_STATUS,
ce600d52ace5a4 hsuck            2026-03-18  6924  				      CUR_LINK_OK, POLL_LINK_CHG);
195aae321c829d Hayes Wang       2021-04-16  6925  	}
195aae321c829d Hayes Wang       2021-04-16  6926  
ce600d52ace5a4 hsuck            2026-03-18  6927  	ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_CSR_DUMMY2, EP4_FULL_FC);
195aae321c829d Hayes Wang       2021-04-16  6928  
ce600d52ace5a4 hsuck            2026-03-18  6929  	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_WDT11_CTRL, TIMER11_EN);
195aae321c829d Hayes Wang       2021-04-16  6930  
ce600d52ace5a4 hsuck            2026-03-18  6931  	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_LED_FEATURE, LED_MODE_MASK);
195aae321c829d Hayes Wang       2021-04-16  6932  
195aae321c829d Hayes Wang       2021-04-16  6933  	if (tp->version == RTL_VER_04 && tp->udev->speed < USB_SPEED_SUPER)
ce600d52ace5a4 hsuck            2026-03-18  6934  		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_LPM_CTRL,
ce600d52ace5a4 hsuck            2026-03-18  6935  				  FIFO_EMPTY_1FB | ROK_EXIT_LPM |
ce600d52ace5a4 hsuck            2026-03-18  6936  				  LPM_TIMER_500MS);
195aae321c829d Hayes Wang       2021-04-16  6937  	else
ce600d52ace5a4 hsuck            2026-03-18  6938  		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_LPM_CTRL,
ce600d52ace5a4 hsuck            2026-03-18  6939  				  FIFO_EMPTY_1FB | ROK_EXIT_LPM |
ce600d52ace5a4 hsuck            2026-03-18  6940  				  LPM_TIMER_500US);
195aae321c829d Hayes Wang       2021-04-16  6941  
ce600d52ace5a4 hsuck            2026-03-18  6942  	ocp_word_w0w1(tp, MCU_TYPE_USB, USB_AFE_CTRL2, SEN_VAL_MASK,
ce600d52ace5a4 hsuck            2026-03-18  6943  		      SEN_VAL_NORMAL | SEL_RXIDLE);
195aae321c829d Hayes Wang       2021-04-16  6944  
195aae321c829d Hayes Wang       2021-04-16  6945  	ocp_write_word(tp, MCU_TYPE_USB, USB_CONNECT_TIMER, 0x0001);
195aae321c829d Hayes Wang       2021-04-16  6946  
195aae321c829d Hayes Wang       2021-04-16  6947  	r8153_power_cut_en(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6948  	rtl_runtime_suspend_enable(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6949  	r8153_mac_clk_speed_down(tp, false);
195aae321c829d Hayes Wang       2021-04-16  6950  	r8153_u1u2en(tp, true);
195aae321c829d Hayes Wang       2021-04-16  6951  	usb_enable_lpm(tp->udev);
195aae321c829d Hayes Wang       2021-04-16  6952  
ce600d52ace5a4 hsuck            2026-03-18  6953  	ocp_byte_set_bits(tp, MCU_TYPE_PLA, PLA_CONFIG6, LANWAKE_CLR_EN);
195aae321c829d Hayes Wang       2021-04-16  6954  
ce600d52ace5a4 hsuck            2026-03-18  6955  	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, LANWAKE_PIN);
195aae321c829d Hayes Wang       2021-04-16  6956  
195aae321c829d Hayes Wang       2021-04-16  6957  	/* rx aggregation */
ce600d52ace5a4 hsuck            2026-03-18  6958  	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
ce600d52ace5a4 hsuck            2026-03-18  6959  			  RX_AGG_DISABLE | RX_ZERO_EN);
195aae321c829d Hayes Wang       2021-04-16  6960  
ce600d52ace5a4 hsuck            2026-03-18  6961  	if (tp->dell_tb_rx_agg_bug)
ce600d52ace5a4 hsuck            2026-03-18  6962  		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
ce600d52ace5a4 hsuck            2026-03-18  6963  				  RX_AGG_DISABLE);
195aae321c829d Hayes Wang       2021-04-16  6964  
195aae321c829d Hayes Wang       2021-04-16  6965  	rtl_tally_reset(tp);
195aae321c829d Hayes Wang       2021-04-16  6966  
195aae321c829d Hayes Wang       2021-04-16  6967  	switch (tp->udev->speed) {
195aae321c829d Hayes Wang       2021-04-16  6968  	case USB_SPEED_SUPER:
195aae321c829d Hayes Wang       2021-04-16  6969  	case USB_SPEED_SUPER_PLUS:
195aae321c829d Hayes Wang       2021-04-16  6970  		tp->coalesce = COALESCE_SUPER;
195aae321c829d Hayes Wang       2021-04-16  6971  		break;
195aae321c829d Hayes Wang       2021-04-16  6972  	case USB_SPEED_HIGH:
195aae321c829d Hayes Wang       2021-04-16  6973  		tp->coalesce = COALESCE_HIGH;
195aae321c829d Hayes Wang       2021-04-16  6974  		break;
195aae321c829d Hayes Wang       2021-04-16  6975  	default:
195aae321c829d Hayes Wang       2021-04-16  6976  		tp->coalesce = COALESCE_SLOW;
195aae321c829d Hayes Wang       2021-04-16  6977  		break;
195aae321c829d Hayes Wang       2021-04-16  6978  	}
195aae321c829d Hayes Wang       2021-04-16  6979  }
195aae321c829d Hayes Wang       2021-04-16  6980  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

