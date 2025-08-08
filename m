Return-Path: <netdev+bounces-212112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD1B1DFE4
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BF05615F5
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5152E36EE;
	Fri,  8 Aug 2025 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhVniutn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8C2E36E7
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754611323; cv=none; b=Af+DVVmuHYkalOYasN96MpzReD+xwzL6wj/4Snmr5HrgLzgSPCAvN08XEAchjmjDTrJKi6L41A4Iipzn9Ce8anLmdHUCvqUTLDGkNnnXLzNbOB2U0G1Iih/vNgfjspTkpv6Pqu+iB3CvTPIaMZ04TTsf9C7O60op6VUrojiX2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754611323; c=relaxed/simple;
	bh=OVvKRnCZPCkUikFXoenXFVKIrczw+FKb6AEftfO2P4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWaApskS+prf6Vq5mdUAM8gohuIJnsX36EZN6QprE71LAga6QX+V7UW3ltGfhhiTp7fGgWFgKWI2Dz5fuOYDuaPH4NKkDYB5ikqoRvyIFe3iCujIJ757nRuJHRP4kniYVsN12MCdJG7ehFvvfY11UhyV1cubW128tPnZboCyStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhVniutn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754611323; x=1786147323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVvKRnCZPCkUikFXoenXFVKIrczw+FKb6AEftfO2P4w=;
  b=GhVniutntO7O1vzG948mOEMMSVl9vWick/3Qpr5W0mNmO2ENrrDeQImA
   qHHzi1zNTyPO2tphcmG17Vf42jkwPDdZYvpTqh2O+QyxHyjZW5lJVYc1M
   HOoN1dHtS4VFlu43FeBtdyKq67a00108lQxAuVVpgQ0MlqortBxIzu3Fm
   +UFAOl9hy2CwkK6csdSjwjC6DrQ0nGPWzWo6C2dYUnpZP+tpEdmW4/2N1
   ndzlEmtRhVFEcOV5XFb6E3Po4nJ7Yi0piA/ERcAxunM14HDX0g0ikGzVj
   8E6I5oKzSu/gKoGeD1VZFP2LJKuUw/Q1ohO+rcHX5hNeyOqTnigqiq/9/
   w==;
X-CSE-ConnectionGUID: YoiADrq3QbG/lYw5Z5pBJQ==
X-CSE-MsgGUID: +xl66YYTR0KKGuyCKk752w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="74414989"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="74414989"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 17:02:00 -0700
X-CSE-ConnectionGUID: K9G9rRQIT+mYRaMSHQtB3w==
X-CSE-MsgGUID: q4VJ23B+QR6CUoOx9V79fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202356501"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 07 Aug 2025 17:01:55 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukAYS-0003NS-0k;
	Fri, 08 Aug 2025 00:01:52 +0000
Date: Fri, 8 Aug 2025 08:00:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, David Wu <david.wu@rock-chips.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: stmmac: rk: put the PHY clock on remove
Message-ID: <202508080746.BIDlKMy5-lkp@intel.com>
References: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ujwIY-007qKa-Ka@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-rk-put-the-PHY-clock-on-remove/20250807-165054
base:   net/main
patch link:    https://lore.kernel.org/r/E1ujwIY-007qKa-Ka%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net] net: stmmac: rk: put the PHY clock on remove
config: arm-defconfig (https://download.01.org/0day-ci/archive/20250808/202508080746.BIDlKMy5-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7b8dea265e72c3037b6b1e54d5ab51b7e14f328b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250808/202508080746.BIDlKMy5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508080746.BIDlKMy5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:1774:6: error: use of undeclared identifier 'plat'
    1774 |         if (plat->phy_node && bsp_priv->integrated_phy)
         |             ^~~~
   1 error generated.


vim +/plat +1774 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

  1765	
  1766	static void rk_gmac_remove(struct platform_device *pdev)
  1767	{
  1768		struct rk_priv_data *bsp_priv = get_stmmac_bsp_priv(&pdev->dev);
  1769	
  1770		stmmac_dvr_remove(&pdev->dev);
  1771	
  1772		rk_gmac_powerdown(bsp_priv);
  1773	
> 1774		if (plat->phy_node && bsp_priv->integrated_phy)
  1775			clk_put(bsp_priv->clk_phy);
  1776	}
  1777	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

