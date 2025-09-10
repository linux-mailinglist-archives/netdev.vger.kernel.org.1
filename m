Return-Path: <netdev+bounces-221635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF6B5149C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574A84E53FD
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF13148BB;
	Wed, 10 Sep 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV6v2x5h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD316905
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501770; cv=none; b=M5uKA0hGjvDXQ0a+Oo1+VDhyXW+Hm04QRH9ewgkZC19AP2WU9PZEgSnx/KPosGfiCLzgfOTKTduAHjkb+ZOTq1eoeaOKRX9JMO6Mo4T+852oI2SepIWzUmO/bYCya5QLTqVkOdYwYtceU9q2rCevA89YoGNSOR/GjV+2jisEHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501770; c=relaxed/simple;
	bh=pHpswxtRWQi3EOsPFZZJeb/sThV2Fod/Xfxn9Br6Mpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKwM+V6yP9kcRWg7FNhGHmmON+4+PAAveZF9tuq13FnM7VtzmAXKtw0IETi8GMQqcL5MrMMOZsYEztDoJPswV7cA43XLxkLaigvBwE7vuA3xPalR9xwnIyaXDIvKX949gtDaZ9C+0i0oG27aDGWbhx3qSSvf9sAfpuoPtb8A3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV6v2x5h; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757501769; x=1789037769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pHpswxtRWQi3EOsPFZZJeb/sThV2Fod/Xfxn9Br6Mpo=;
  b=DV6v2x5hBzrcmsV4BF49Ar8lzwtmkAG2j/7YrBtIXvFIOArM2NQCJutV
   s1UHzHzQ4sJqYx1kT/lIr/JLXzwL99WBCc/VOoz7wl3I4cQsts6SHPZld
   MGAmCU/5bONDlN3t3hSif7l39SrM7xUGpCvQPmTRzmKdPlDmWEalitlHg
   rn4AssJ10TcgdNp5iP/Y1HIhAfLZABoMsRKB7cvh7ILGHaMYzwV37BfgS
   aO0usjKTzPG4Ud9xED3vCixyXLh2Qg4M57IxpCt2iyi14Ac2akMQqbddm
   cLqW8m6U1jPRT4u8dykNw74YT4HxsRb826J65nzFDOIqbPVQuRSgZd6rO
   w==;
X-CSE-ConnectionGUID: G3sW6kCNRx6VVF7xWHZ9uQ==
X-CSE-MsgGUID: SBekzg++QzKCcw6kSrIpMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="47379712"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="47379712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 03:56:08 -0700
X-CSE-ConnectionGUID: K/bl4HYrR/qVZ5g0g3sg4A==
X-CSE-MsgGUID: XnovDimTScqFoaCXKYjltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="204121209"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Sep 2025 03:56:05 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwIUc-0005r9-2l;
	Wed, 10 Sep 2025 10:56:02 +0000
Date: Wed, 10 Sep 2025 18:55:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove
 chip->evcap_config
Message-ID: <202509101826.aERYSElG-lkp@intel.com>
References: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-dsa-mv88e6xxx-remove-mv88e6250_ptp_ops/20250910-034838
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1uw0Xk-00000004IOC-1EJd%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove chip->evcap_config
config: i386-buildonly-randconfig-004-20250910 (https://download.01.org/0day-ci/archive/20250910/202509101826.aERYSElG-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101826.aERYSElG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101826.aERYSElG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dsa/mv88e6xxx/ptp.c:182:2: error: use of undeclared identifier 'evcap_config'; did you mean 'evap_config'?
     182 |         evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
         |         ^~~~~~~~~~~~
         |         evap_config
   drivers/net/dsa/mv88e6xxx/ptp.c:178:6: note: 'evap_config' declared here
     178 |         u16 evap_config;
         |             ^
   drivers/net/dsa/mv88e6xxx/ptp.c:185:3: error: use of undeclared identifier 'evcap_config'; did you mean 'evap_config'?
     185 |                 evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
         |                 ^~~~~~~~~~~~
         |                 evap_config
   drivers/net/dsa/mv88e6xxx/ptp.c:178:6: note: 'evap_config' declared here
     178 |         u16 evap_config;
         |             ^
   drivers/net/dsa/mv88e6xxx/ptp.c:187:53: error: use of undeclared identifier 'evcap_config'; did you mean 'evap_config'?
     187 |         err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
         |                                                            ^~~~~~~~~~~~
         |                                                            evap_config
   drivers/net/dsa/mv88e6xxx/ptp.c:178:6: note: 'evap_config' declared here
     178 |         u16 evap_config;
         |             ^
   3 errors generated.


vim +182 drivers/net/dsa/mv88e6xxx/ptp.c

   168	
   169	/* mv88e6352_config_eventcap - configure TAI event capture
   170	 * @event: PTP_CLOCK_PPS (internal) or PTP_CLOCK_EXTTS (external)
   171	 * @rising: zero for falling-edge trigger, else rising-edge trigger
   172	 *
   173	 * This will also reset the capture sequence counter.
   174	 */
   175	static int mv88e6352_config_eventcap(struct mv88e6xxx_chip *chip, int event,
   176					     int rising)
   177	{
   178		u16 evap_config;
   179		u16 cap_config;
   180		int err;
   181	
 > 182		evcap_config = MV88E6XXX_TAI_CFG_CAP_OVERWRITE |
   183			       MV88E6XXX_TAI_CFG_CAP_CTR_START;
   184		if (!rising)
   185			evcap_config |= MV88E6XXX_TAI_CFG_EVREQ_FALLING;
   186	
   187		err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_CFG, evcap_config);
   188		if (err)
   189			return err;
   190	
   191		if (event == PTP_CLOCK_PPS) {
   192			cap_config = MV88E6XXX_TAI_EVENT_STATUS_CAP_TRIG;
   193		} else if (event == PTP_CLOCK_EXTTS) {
   194			/* if STATUS_CAP_TRIG is unset we capture PTP_EVREQ events */
   195			cap_config = 0;
   196		} else {
   197			return -EINVAL;
   198		}
   199	
   200		/* Write the capture config; this also clears the capture counter */
   201		err = mv88e6xxx_tai_write(chip, MV88E6XXX_TAI_EVENT_STATUS,
   202					  cap_config);
   203	
   204		return err;
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

