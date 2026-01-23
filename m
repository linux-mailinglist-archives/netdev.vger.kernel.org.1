Return-Path: <netdev+bounces-252951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA0kJqzQc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:49:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085B87A4BB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE4D3002F9A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE52BE644;
	Fri, 23 Jan 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhYByutZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756E27470;
	Fri, 23 Jan 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197589; cv=none; b=saaP1VTPAfrhe/xhYobZEn/xhYISmkkNyLLXJCg5ey3reJp/MEzCWDI/zTvUPmMpdT80ymqG4/T729vW1ONQ3gsi3+UUnyz9h3ySITpj9xuhl6ivjhzXYMl45veujX2IcNIExbcYHVmIfEc7f81YX9WOzWdt5HwCIfXXRgduAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197589; c=relaxed/simple;
	bh=d3m3qkp7Crw1fXc7BZpUNEFl9fOZsoenMG9dlCWiOV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM7xz54xTEANW+42E6Zgt15gnFP6R9wuB+euuzIVtTb1kkrqy9dIVQQQNmtBOfrm3vWPXy8YKT86AyasBJU8CTn+5T7GgvzDz5v8De/gGmyxThC0DbLi+n+G0PeGRKnYw3FSYC5Y9dpOseZdxDHSTnKOp60to/TyANiphzqTkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhYByutZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769197587; x=1800733587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d3m3qkp7Crw1fXc7BZpUNEFl9fOZsoenMG9dlCWiOV4=;
  b=NhYByutZtubu67HYjCnvhVXKWd3DKg8atm6XdldxXjWmzkcSlzB3BLeV
   CqGjXBo5pWi7Kj9cPQkmxfr4YpVm/+BBzjcUol6+69DtD4Klh5mlyUqLH
   48ed1VB9o18PLNvmJ19bf2sX8yiOGUF+3+suHEwzqIMdXnQ3Yb10rL4/P
   pcFhFHv2V/vyRy9RjQbozFezO+8iWuH/VBUeItHxZGMA1ZnNtwG9daLOi
   C8qO/ms/JzfDPbhqeE7uroEESruj92x/DHOcdzCV9XruuLLyLLFNaLPAX
   v/NgEj6QF30A4f87PFdcXMsW4IGleyE6cKFkNXEM8HmtH7R0eyPZ2uMhu
   g==;
X-CSE-ConnectionGUID: Tf8lXVnxTJCwugZabjKaIA==
X-CSE-MsgGUID: VQm6WF/tS++OLc1OVtcYcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="74087693"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74087693"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 11:46:26 -0800
X-CSE-ConnectionGUID: aWY7Lm4UTaWGiZHolVkAmw==
X-CSE-MsgGUID: KNKQHEf3TmG4l9dMqAdT7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207161750"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jan 2026 11:46:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjN6o-00000000UOM-0BQg;
	Fri, 23 Jan 2026 19:46:18 +0000
Date: Sat, 24 Jan 2026 03:45:56 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 net-next 11/15] net: dsa: sja1105: fill device tree
 with ethernet-pcs sub-devices under "regs" node
Message-ID: <202601240325.L4Ejl6qH-lkp@intel.com>
References: <20260122105654.105600-12-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122105654.105600-12-vladimir.oltean@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[lists.linux.dev,lunn.ch,gmail.com,armlinux.org.uk,google.com,kernel.org,redhat.com,vger.kernel.org,linux.intel.com,bootlin.com,trustnetic.com];
	TAGGED_FROM(0.00)[bounces-252951-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 085B87A4BB
X-Rspamd-Action: no action

Hi Vladimir,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vladimir-Oltean/net-mdio-regmap-permit-working-with-non-MMIO-regmaps/20260122-192934
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260122105654.105600-12-vladimir.oltean%40nxp.com
patch subject: [PATCH v2 net-next 11/15] net: dsa: sja1105: fill device tree with ethernet-pcs sub-devices under "regs" node
config: mips-randconfig-r112-20260123 (https://download.01.org/0day-ci/archive/20260124/202601240325.L4Ejl6qH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240325.L4Ejl6qH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240325.L4Ejl6qH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:26:
   In file included from include/linux/kvm_host.h:5:
   In file included from include/linux/entry-virt.h:10:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:19:
>> include/linux/of.h:1645:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1645 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1620:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1620 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1651:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1651 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1620:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1620 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1657:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1657 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1663:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1663 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1669:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1669 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
   5 errors generated.
   make[3]: *** [scripts/Makefile.build:182: arch/mips/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1314: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
   Depends on [n]: OF [=n]
   Selected by [m]:
   - NET_DSA_SJA1105 [=m] && NETDEVICES [=y] && NET_DSA [=m] && SPI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]


vim +1645 include/linux/of.h

201c910bd6898d Pantelis Antoniou 2014-07-04  1618  
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1619  enum of_reconfig_change {
b53a2340d0d304 Pantelis Antoniou 2014-10-28 @1620  	OF_RECONFIG_NO_CHANGE = 0,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1621  	OF_RECONFIG_CHANGE_ADD,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1622  	OF_RECONFIG_CHANGE_REMOVE,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1623  };
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1624  
2e8fff668dc14e Rob Herring       2023-03-29  1625  struct notifier_block;
2e8fff668dc14e Rob Herring       2023-03-29  1626  
201c910bd6898d Pantelis Antoniou 2014-07-04  1627  #ifdef CONFIG_OF_DYNAMIC
f6892d193fb9d6 Grant Likely      2014-11-21  1628  extern int of_reconfig_notifier_register(struct notifier_block *);
f6892d193fb9d6 Grant Likely      2014-11-21  1629  extern int of_reconfig_notifier_unregister(struct notifier_block *);
f5242e5a883bf1 Grant Likely      2014-11-24  1630  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
f5242e5a883bf1 Grant Likely      2014-11-24  1631  extern int of_reconfig_get_state_change(unsigned long action,
f5242e5a883bf1 Grant Likely      2014-11-24  1632  					struct of_reconfig_data *arg);
f6892d193fb9d6 Grant Likely      2014-11-21  1633  
201c910bd6898d Pantelis Antoniou 2014-07-04  1634  extern void of_changeset_init(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1635  extern void of_changeset_destroy(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1636  extern int of_changeset_apply(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1637  extern int of_changeset_revert(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1638  extern int of_changeset_action(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1639  		unsigned long action, struct device_node *np,
201c910bd6898d Pantelis Antoniou 2014-07-04  1640  		struct property *prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1641  
201c910bd6898d Pantelis Antoniou 2014-07-04  1642  static inline int of_changeset_attach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1643  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1644  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1645  	return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1646  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1647  
201c910bd6898d Pantelis Antoniou 2014-07-04  1648  static inline int of_changeset_detach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1649  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1650  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1651  	return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1652  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1653  
201c910bd6898d Pantelis Antoniou 2014-07-04  1654  static inline int of_changeset_add_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1655  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1656  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1657  	return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1658  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1659  
201c910bd6898d Pantelis Antoniou 2014-07-04  1660  static inline int of_changeset_remove_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1661  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1662  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1663  	return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1664  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1665  
201c910bd6898d Pantelis Antoniou 2014-07-04  1666  static inline int of_changeset_update_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1667  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1668  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1669  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1670  }
b544fc2b8606d7 Lizhi Hou         2023-08-15  1671  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

