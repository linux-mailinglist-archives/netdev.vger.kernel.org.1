Return-Path: <netdev+bounces-117273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CCC94D5E5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA471C21401
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA31014B94A;
	Fri,  9 Aug 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0zgXt6m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25BD14883B;
	Fri,  9 Aug 2024 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226151; cv=none; b=SAi7QS65P9h8Rw0iTymyukR91gvBJkoHAZ2ApGNpvGoZZCmstfz7zYHeuX5mwazRtWPEujZfi6NqHqEx01sBBJ6aJQCdZzzIOgcbU6txIsOrxzevQnBmkwdwT07uawA6oMf9LXJK5KyHrFCAEa51UU0Gq8U2JStnxEYVO2XL324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226151; c=relaxed/simple;
	bh=lZ+RBQBmLrdgxulilt9piDrRQT9wvO+NFi9nGvNqpJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX4X4yJVi8pYhOoO1rvpis75aXuvuzsxzgGwAABdf+3VCN/iYM7FPK2OMCYNkbQofNt/gYe2C65cMSAq9k3xulefJDv8KMUERXqQ9qDUvlR8P1B4NWkOKEixI+/r2Khkfkj4lh92KCOGSJpRT74Kz77h5lkzh3dkdvusjldaXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0zgXt6m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723226150; x=1754762150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lZ+RBQBmLrdgxulilt9piDrRQT9wvO+NFi9nGvNqpJo=;
  b=Y0zgXt6mMU8VDNrlecEoB6dvgoK6sTchsqnsCE5glirwNeQUsdkqrnn7
   o6ASiU4USq9TW3zFUC9XBy/C3LpZUHfYiR2ZHNPAR6nCzq0gTw3BRY24J
   W8IRcUo/2kd41+LZT9o8ldMVzg0tnVfynRigfUwFF+e5XcnZZv7zDTECm
   tNl2Asyu5n3ZNEv+u+kY2VbWjCBgEER0PRJb8ogAO5dPh9fqxb7YSWPBp
   JDdVfhUegH4vHikR25F02fThnoxDSGhv7P4ADvrRt6XmHMOSs8FQDVE31
   aJ/xk4FSN+RQ8YTymV9IUNBiMfZ0KmyqZmgreJKo6E9dUR590cctPbreH
   w==;
X-CSE-ConnectionGUID: 5fN3ESOoRsScA9M5AFq3fA==
X-CSE-MsgGUID: tlw0MfFgSPWZJ3i1k6CK1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21268498"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21268498"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:55:49 -0700
X-CSE-ConnectionGUID: NiZaaY8zTdOet7QTygHTvg==
X-CSE-MsgGUID: Ohk5d/AqS1GSWL9/wy713g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88278913"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Aug 2024 10:55:46 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scTq3-000981-2R;
	Fri, 09 Aug 2024 17:55:43 +0000
Date: Sat, 10 Aug 2024 01:55:19 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <202408100138.gwg3Yuur-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240809 (https://download.01.org/0day-ci/archive/20240810/202408100138.gwg3Yuur-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100138.gwg3Yuur-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100138.gwg3Yuur-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/open_alliance_helpers.c:34:18: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      34 |         u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
         |                         ^
   drivers/net/phy/open_alliance_helpers.c:69:16: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      69 |         u8 dist_val = FIELD_GET(OA_1000BT1_HDD_TDR_DISTANCE_MASK, reg_value);
         |                       ^
   2 errors generated.


vim +/FIELD_GET +34 drivers/net/phy/open_alliance_helpers.c

f4eee3aa678aeb Oleksij Rempel 2024-08-09  21  
f4eee3aa678aeb Oleksij Rempel 2024-08-09  22  /**
f4eee3aa678aeb Oleksij Rempel 2024-08-09  23   * oa_1000bt1_get_ethtool_cable_result_code - Convert TDR status to ethtool
f4eee3aa678aeb Oleksij Rempel 2024-08-09  24   *					      result code
f4eee3aa678aeb Oleksij Rempel 2024-08-09  25   * @reg_value: Value read from the TDR register
f4eee3aa678aeb Oleksij Rempel 2024-08-09  26   *
f4eee3aa678aeb Oleksij Rempel 2024-08-09  27   * This function takes a register value from the HDD.TDR register and converts
f4eee3aa678aeb Oleksij Rempel 2024-08-09  28   * the TDR status to the corresponding ethtool cable test result code.
f4eee3aa678aeb Oleksij Rempel 2024-08-09  29   *
f4eee3aa678aeb Oleksij Rempel 2024-08-09  30   * Return: The appropriate ethtool result code based on the TDR status
f4eee3aa678aeb Oleksij Rempel 2024-08-09  31   */
f4eee3aa678aeb Oleksij Rempel 2024-08-09  32  int oa_1000bt1_get_ethtool_cable_result_code(u16 reg_value)
f4eee3aa678aeb Oleksij Rempel 2024-08-09  33  {
f4eee3aa678aeb Oleksij Rempel 2024-08-09 @34  	u8 tdr_status = FIELD_GET(OA_1000BT1_HDD_TDR_STATUS_MASK, reg_value);
f4eee3aa678aeb Oleksij Rempel 2024-08-09  35  	u8 dist_val = FIELD_GET(OA_1000BT1_HDD_TDR_DISTANCE_MASK, reg_value);
f4eee3aa678aeb Oleksij Rempel 2024-08-09  36  
f4eee3aa678aeb Oleksij Rempel 2024-08-09  37  	switch (tdr_status) {
f4eee3aa678aeb Oleksij Rempel 2024-08-09  38  	case OA_1000BT1_HDD_TDR_STATUS_CABLE_OK:
f4eee3aa678aeb Oleksij Rempel 2024-08-09  39  		return ETHTOOL_A_CABLE_RESULT_CODE_OK;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  40  	case OA_1000BT1_HDD_TDR_STATUS_OPEN:
f4eee3aa678aeb Oleksij Rempel 2024-08-09  41  		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  42  	case OA_1000BT1_HDD_TDR_STATUS_SHORT:
f4eee3aa678aeb Oleksij Rempel 2024-08-09  43  		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  44  	case OA_1000BT1_HDD_TDR_STATUS_NOISE:
f4eee3aa678aeb Oleksij Rempel 2024-08-09  45  		return ETHTOOL_A_CABLE_RESULT_CODE_NOISE;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  46  	default:
f4eee3aa678aeb Oleksij Rempel 2024-08-09  47  		if (dist_val == OA_1000BT1_HDD_TDR_DISTANCE_RESOLUTION_NOT_POSSIBLE)
f4eee3aa678aeb Oleksij Rempel 2024-08-09  48  			return ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  49  		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
f4eee3aa678aeb Oleksij Rempel 2024-08-09  50  	}
f4eee3aa678aeb Oleksij Rempel 2024-08-09  51  }
f4eee3aa678aeb Oleksij Rempel 2024-08-09  52  EXPORT_SYMBOL_GPL(oa_1000bt1_get_ethtool_cable_result_code);
f4eee3aa678aeb Oleksij Rempel 2024-08-09  53  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

