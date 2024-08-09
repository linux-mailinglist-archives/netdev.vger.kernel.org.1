Return-Path: <netdev+bounces-117291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF00294D7C4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A79280FC1
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4619160860;
	Fri,  9 Aug 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8y5ADlh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97161465BA;
	Fri,  9 Aug 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723233482; cv=none; b=UxuNuunQgKADW7fK0i8vIAj0g1JR8RTszIyGzCqIXcYCr0P+Ng274/ZVSxLzJSsW3N0p0A0TEtoGzXsQLCVIJpcJJL2zo7Vu2YCepIWELVyFhTpZQoEKXlS1kRPPs9orTRCSCAEKa9kWSqIS47sAiXtv1Y2q+Asx9WWxlwPTtvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723233482; c=relaxed/simple;
	bh=sg2iS4MgBIyaUcFaJrbtKiFwDQCzucstJIOSUW/GSMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UArNLOFrYkM62BRF/3I49KHEUkbT4+h3SunAGY5sWO+dzei/VyK8yWdllawN5FKm9uS3hEb0OGj23nBHbPvDSO+ebB4AdFAoKjkP5ooldFgdHWDEQzFpdt4yLg3WGknMHPED0QnhMFR+xI1aC8GDlbFtbYrW/rpllFr0eWfH3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8y5ADlh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723233481; x=1754769481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sg2iS4MgBIyaUcFaJrbtKiFwDQCzucstJIOSUW/GSMA=;
  b=m8y5ADlhH0h+NC9lRWGh+7X6b47PWfrCCBQMI47f0PmC1ZLutCQUwNwb
   /PDTN388/n0He9ZmydJPVO9UqzQTGJ2ACi1qWKNbclsE/wh68uff+Llw3
   y2F8rNcNrsjvJkWGdRWXlHyseNCEeWFcXznGlJIHhruWBFE6OfGPGMcCK
   YDKwjRpmH6TE6m7kAmT0kg+dYfinEVID8qVwtQbBbyi/Ktmx3e8XRmaj9
   PTZnFNzeer3Om/SGx8sClQtsSoGOvtz0ClalCA2i3cGz3uI1lRDlRBcyq
   FUIPprYSnH4SSRKSrPLvWvWNn6mhHH2ev266POsX0DVWA/VfoVEjXfMFE
   w==;
X-CSE-ConnectionGUID: tpfJtmv+RT2IgwFdomhswg==
X-CSE-MsgGUID: CSfUeKznS8unoCQ84ZfC7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25191872"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25191872"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:58:00 -0700
X-CSE-ConnectionGUID: Z7dv4MKDTo61cMhltIKGxw==
X-CSE-MsgGUID: q2snOAhcRrObFn1gVT+xkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="58225012"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 09 Aug 2024 12:57:56 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scVkH-0009EJ-2A;
	Fri, 09 Aug 2024 19:57:53 +0000
Date: Sat, 10 Aug 2024 03:57:35 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <202408100348.U6S1jP0z-lkp@intel.com>
References: <20240809072440.3477125-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809072440.3477125-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/phy-Add-Open-Alliance-helpers-for-the-PHY-framework/20240809-172119
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240809072440.3477125-3-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100348.U6S1jP0z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100348.U6S1jP0z-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/open_alliance_helpers.c: In function 'oa_1000bt1_get_ethtool_cable_result_code':
>> drivers/net/phy/open_alliance_helpers.c:34:25: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
      34 |         u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
         |                         ^~~~~~~~~


vim +/FIELD_GET +34 drivers/net/phy/open_alliance_helpers.c

f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  21  
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  22  /**
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  23   * oa_1000bt1_get_ethtool_cable_result_code - Convert TDR status to ethtool
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  24   *					      result code
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  25   * @reg_value: Value read from the TDR register
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  26   *
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  27   * This function takes a register value from the HDD.TDR register and converts
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  28   * the TDR status to the corresponding ethtool cable test result code.
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  29   *
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  30   * Return: The appropriate ethtool result code based on the TDR status
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  31   */
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  32  int oa_1000bt1_get_ethtool_cable_result_code(u16 reg_value)
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  33  {
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09 @34  	u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  35  	u8 dist_val = FIELD_GET(OA_1000BT1_HDD_TDR_DISTANCE_MASK, reg_value);
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  36  
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  37  	switch (tdr_status) {
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  38  	case OA_1000BT1_HDD_TDR_STATUS_CABLE_OK:
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  39  		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  40  	case OA_1000BT1_HDD_TDR_STATUS_OPEN:
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  41  		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  42  	case OA_1000BT1_HDD_TDR_STATUS_SHORT:
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  43  		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  44  	case OA_1000BT1_HDD_TDR_STATUS_NOISE:
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  45  		return ETHTOOL_A_CABLE_RESULT_CODE_NOISE;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  46  	default:
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  47  		if (dist_val == OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE)
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  48  			return ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  49  		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  50  	}
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  51  }
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  52  EXPORT_SYMBOL_GPL(oa_1000bt1_get_ethtool_cable_result_code);
f4eee3aa678aeb0 Oleksij Rempel 2024-08-09  53  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

