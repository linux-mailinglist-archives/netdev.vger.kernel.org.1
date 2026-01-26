Return-Path: <netdev+bounces-253594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGfLJBnQd2mxlQEAu9opvQ
	(envelope-from <netdev+bounces-253594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACE8D1D9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2833014974
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A22D6E6C;
	Mon, 26 Jan 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvcht4Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629A2D541B
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459735; cv=none; b=KtUXvlkmnwgqC7JSd+JlPbynSjkeYMjM+N8jTAhc4V/HAXZHfLM/rd4VySmqsrQ+6CXImIe4way1v6s2EbC+UTsKnkUJD1DbfZp0ngASMDGYYemNbom1y9TeYvq+ISDtyISaB83aDV7NeM1BOWMNYclBGsb4RNgrhsdZFpqZqLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459735; c=relaxed/simple;
	bh=Hv73xovg7rs+ED9F7z8l/VwWVkfiGm/GSqfIJQSKT6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmGPV2dTucJ2rBrX1qM7azPr5nY718yxtuw8qNc9uiW/K2uAwEGfIt4hByrJS2+Hs6Hi+30XRthdkWFIL/HR9yiEKSoDShnGJi2dnutnzboii8xy8VVeGY4e+P5MUI/Gucbd/GK6oB/kt09L17J24OiXZOJG0M4vHP1ljVXAobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvcht4Ht; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769459734; x=1800995734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hv73xovg7rs+ED9F7z8l/VwWVkfiGm/GSqfIJQSKT6M=;
  b=hvcht4Ht9cb2SvSp3r/zPn2cOxXSiFezycdz2VcQewmz1lCwbLVxhFZZ
   4Vb3KcsyPkxaemAa9VPtbI6KX3MCNBiFeR+7KfbWXJ07gizIA0L+YA9PQ
   7pqoDZm8xk3Ad2zbHsRnnz5xj+ocPmLQQtY0+/m7L1zKriTD/VxK7iFgh
   pTCx58LhV6xz+zKoS6eRXI+SmoJcZ29N3kL1sRXfTFWXStehwqpmBfhSN
   IFtXNf0X4IW/QGk62gPKV0DLHFjsjKdpfZGMhfnQilmPeBsRWwBLdTlta
   0+RUJJ3OzJllS0PpgttfzLKN5fY5wTyU1Ej5fs46AvjX29a6gX7+hTN++
   g==;
X-CSE-ConnectionGUID: aYUnXCCGS8u823I0YGhToQ==
X-CSE-MsgGUID: 7EpVI3LWTbOY7li1rQWtJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70548995"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70548995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 12:35:33 -0800
X-CSE-ConnectionGUID: sagnajPzQ5CRUn3YbCDE2w==
X-CSE-MsgGUID: nd9RHMb/SPikWc1P17fuuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="208125486"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jan 2026 12:35:30 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkTJ2-00000000XfO-2ljl;
	Mon, 26 Jan 2026 20:35:28 +0000
Date: Tue, 27 Jan 2026 04:34:49 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: report active PHY interface
Message-ID: <202601270450.IAoLETfq-lkp@intel.com>
References: <E1vkLXO-00000005uxQ-31ZV@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vkLXO-00000005uxQ-31ZV@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253594-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AACE8D1D9
X-Rspamd-Action: no action

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-report-active-PHY-interface/20260126-201908
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1vkLXO-00000005uxQ-31ZV%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next] net: stmmac: report active PHY interface
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20260127/202601270450.IAoLETfq-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601270450.IAoLETfq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601270450.IAoLETfq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c:41:10: warning: 'PHY_INTF_RGMII' macro redefined [-Wmacro-redefined]
      41 | #define  PHY_INTF_RGMII                 FIELD_PREP(PHY_INTF_MASK, 1)
         |          ^
   drivers/net/ethernet/stmicro/stmmac/common.h:328:9: note: previous definition is here
     328 | #define PHY_INTF_RGMII          1
         |         ^
   1 warning generated.


vim +/PHY_INTF_RGMII +41 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c

33a1a01e3afa724 Jisheng Zhang 2024-11-03  18  
33a1a01e3afa724 Jisheng Zhang 2024-11-03  19  #define GMAC_CLK_EN			0x00
33a1a01e3afa724 Jisheng Zhang 2024-11-03  20  #define  GMAC_TX_CLK_EN			BIT(1)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  21  #define  GMAC_TX_CLK_N_EN		BIT(2)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  22  #define  GMAC_TX_CLK_OUT_EN		BIT(3)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  23  #define  GMAC_RX_CLK_EN			BIT(4)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  24  #define  GMAC_RX_CLK_N_EN		BIT(5)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  25  #define  GMAC_EPHY_REF_CLK_EN		BIT(6)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  26  #define GMAC_RXCLK_DELAY_CTRL		0x04
33a1a01e3afa724 Jisheng Zhang 2024-11-03  27  #define  GMAC_RXCLK_BYPASS		BIT(15)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  28  #define  GMAC_RXCLK_INVERT		BIT(14)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  29  #define  GMAC_RXCLK_DELAY		GENMASK(4, 0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  30  #define GMAC_TXCLK_DELAY_CTRL		0x08
33a1a01e3afa724 Jisheng Zhang 2024-11-03  31  #define  GMAC_TXCLK_BYPASS		BIT(15)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  32  #define  GMAC_TXCLK_INVERT		BIT(14)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  33  #define  GMAC_TXCLK_DELAY		GENMASK(4, 0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  34  #define GMAC_PLLCLK_DIV			0x0c
33a1a01e3afa724 Jisheng Zhang 2024-11-03  35  #define  GMAC_PLLCLK_DIV_EN		BIT(31)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  36  #define  GMAC_PLLCLK_DIV_NUM		GENMASK(7, 0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  37  #define GMAC_GTXCLK_SEL			0x18
33a1a01e3afa724 Jisheng Zhang 2024-11-03  38  #define  GMAC_GTXCLK_SEL_PLL		BIT(0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  39  #define GMAC_INTF_CTRL			0x1c
33a1a01e3afa724 Jisheng Zhang 2024-11-03  40  #define  PHY_INTF_MASK			BIT(0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03 @41  #define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  42  #define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  43  #define GMAC_TXCLK_OEN			0x20
33a1a01e3afa724 Jisheng Zhang 2024-11-03  44  #define  TXCLK_DIR_MASK			BIT(0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  45  #define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  46  #define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
33a1a01e3afa724 Jisheng Zhang 2024-11-03  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

