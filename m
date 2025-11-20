Return-Path: <netdev+bounces-240207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C2C717C9
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F40A4E16A7
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86694204E;
	Thu, 20 Nov 2025 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q01i+Muc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB78F7D;
	Thu, 20 Nov 2025 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763596921; cv=none; b=ZcKa4BNWkOn8pFdeC8fqkOblaT/NwwWqY2BalPZcObwvITlawJntZ/p3KbkUOK5pEt3jfw4tuFzsjIEXXJD7cPJHyYikVofs6al+sTD3x1+UJ2VCqPoI+qdKK9BjiOiMrsNa72m5wLzccGEhBIviJNK5PpJrYOhYyQrJBghddFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763596921; c=relaxed/simple;
	bh=MxyulG5TdIie/f2I6AlCTv3CCEbt50rKM7Gaf6i8V+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbQjAGG8AJHOjqDhy6Cq+iH1fpJCTOj+pDQPGhbXJtnfzp2Uht80u3snfqFltpkibZYEcLwCQhL/wTOdUZfai18UuJQyj0sGFqeOK9Cjpl1R7589a2q4MOd29i/lSKU8X6NjyfBj8joduFKQoH73LozK4RvNoV6RyyXrhP9E9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q01i+Muc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763596920; x=1795132920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MxyulG5TdIie/f2I6AlCTv3CCEbt50rKM7Gaf6i8V+Q=;
  b=Q01i+Mucf9t5Yo+aGQZQv9b/I9DiNSTF1ytSkJAuvjb3u4d1ryz7nRZ3
   yn6JTE1xftW+WzB+Fr6QIffJjELQdXCuQUQHiN7zfmpGz9rgs//D7G3uZ
   t/aaErDkStTXravw+nfZ1g3vWjSDrkE/lpBitwXgnKcgnUMD7wPVgftZC
   Wmg8UADt9RA9+iz/AGJEr46uJaSkpcUqD+5x1xyRvgB/rApoHknDGxm34
   bGcHN3u7gbuSgex9FeOoTho3grBFyyr2Fcn/U8Ta7YXHnw8QUne+caMF6
   ESMus63GJS9HCb+8r2LyXLSrMAEAPkOrscVtxQYfr7TxYANnmqeQYmoRW
   Q==;
X-CSE-ConnectionGUID: R1EEhLRdS5O/S+v6WzSp4w==
X-CSE-MsgGUID: +bsoxnESSXOHRoLSJkzwdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65357307"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="65357307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 16:01:59 -0800
X-CSE-ConnectionGUID: ddD+iSXVSOun+Lv1s08Sqw==
X-CSE-MsgGUID: /VnRUlHzRFGeejcosZwI5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="228519626"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Nov 2025 16:01:55 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLs7U-0003R1-1O;
	Thu, 20 Nov 2025 00:01:52 +0000
Date: Thu, 20 Nov 2025 08:01:37 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <202511200752.hGkPwqbU-lkp@intel.com>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118190530.580267-15-vladimir.oltean@nxp.com>

Hi Vladimir,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-dsa-sja1105-let-phylink-help-with-the-replay-of-link-callbacks/20251119-031300
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251118190530.580267-15-vladimir.oltean%40nxp.com
patch subject: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs with xpcs-plat driver
config: s390-randconfig-002-20251120 (https://download.01.org/0day-ci/archive/20251120/202511200752.hGkPwqbU-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251120/202511200752.hGkPwqbU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511200752.hGkPwqbU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:17,
                    from kernel/sched/sched.h:31,
                    from kernel/sched/rq-offsets.c:5:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1623:34: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
     return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
                                     ^~~~~~~~~~~~~~~~~~~~~~~
                                     OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1623:34: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1629:34: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
     return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
                                     ^~~~~~~~~~~~~~~~~~~~~~~
                                     OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1635:34: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
     return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~
                                     OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1641:34: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function); did you mean 'OF_RECONFIG_CHANGE_REMOVE'?
     return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                                     OF_RECONFIG_CHANGE_REMOVE
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1647:34: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function); did you mean 'OF_RECONFIG_CHANGE_REMOVE'?
     return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                                     OF_RECONFIG_CHANGE_REMOVE
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1 shuffle=1571759522
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=1571759522
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=1571759522
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=1571759522
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
   Depends on [n]: OF [=n]
   Selected by [m]:
   - NET_DSA_SJA1105 [=m] && NETDEVICES [=y] && NET_DSA [=m] && SPI [=y] && PTP_1588_CLOCK_OPTIONAL [=m]


vim +1623 include/linux/of.h

2e8fff668dc14e Rob Herring       2023-03-29  1604  
201c910bd6898d Pantelis Antoniou 2014-07-04  1605  #ifdef CONFIG_OF_DYNAMIC
f6892d193fb9d6 Grant Likely      2014-11-21  1606  extern int of_reconfig_notifier_register(struct notifier_block *);
f6892d193fb9d6 Grant Likely      2014-11-21  1607  extern int of_reconfig_notifier_unregister(struct notifier_block *);
f5242e5a883bf1 Grant Likely      2014-11-24  1608  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
f5242e5a883bf1 Grant Likely      2014-11-24  1609  extern int of_reconfig_get_state_change(unsigned long action,
f5242e5a883bf1 Grant Likely      2014-11-24  1610  					struct of_reconfig_data *arg);
f6892d193fb9d6 Grant Likely      2014-11-21  1611  
201c910bd6898d Pantelis Antoniou 2014-07-04  1612  extern void of_changeset_init(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1613  extern void of_changeset_destroy(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1614  extern int of_changeset_apply(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1615  extern int of_changeset_revert(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1616  extern int of_changeset_action(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1617  		unsigned long action, struct device_node *np,
201c910bd6898d Pantelis Antoniou 2014-07-04  1618  		struct property *prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1619  
201c910bd6898d Pantelis Antoniou 2014-07-04  1620  static inline int of_changeset_attach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1621  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1622  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1623  	return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1624  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1625  
201c910bd6898d Pantelis Antoniou 2014-07-04  1626  static inline int of_changeset_detach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1627  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1628  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1629  	return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1630  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1631  
201c910bd6898d Pantelis Antoniou 2014-07-04  1632  static inline int of_changeset_add_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1633  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1634  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1635  	return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1636  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1637  
201c910bd6898d Pantelis Antoniou 2014-07-04  1638  static inline int of_changeset_remove_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1639  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1640  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1641  	return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1642  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1643  
201c910bd6898d Pantelis Antoniou 2014-07-04  1644  static inline int of_changeset_update_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1645  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1646  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1647  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1648  }
b544fc2b8606d7 Lizhi Hou         2023-08-15  1649  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

