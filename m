Return-Path: <netdev+bounces-197435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3682AD8A70
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157573A7BC4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE292D6626;
	Fri, 13 Jun 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzsMSLwM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF6326B745;
	Fri, 13 Jun 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814120; cv=none; b=l4qfUiz55DCBS+jGQlRoRdPJihcA5vepIRQtw8cSPiokiK4cvxogpp6OjOxGFstHoV8sZQNjnIegL7/RK9Od3LXUotJAXzdQSevTvX1cASHfxsCOk8k0g1dcjbs0qVBgKIShv67vZSU4lGp/i0BJbXwyfhAtxdEE2Vg6fNqy3f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814120; c=relaxed/simple;
	bh=2t2S6tvF/xUOL2GECElMuB0CWljksOt/fSHi+W0ZL0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDjVIb+al94OEAafbxrNwHLTPCNg4BO8sY1LYK+nTQIXEHCDqeQ6wdMBCs2KMHOMr29jV2VKjL6912fxiY/I7wRSI0f6RSRIvvpc1JZqdDDfq9Aawt/eCG8vvrX6Jppa3wHaQ31WBl1NzYyyaJC2HISLPDbhcWYfm9p+A8VbnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzsMSLwM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749814118; x=1781350118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2t2S6tvF/xUOL2GECElMuB0CWljksOt/fSHi+W0ZL0Q=;
  b=ZzsMSLwMF6RYdiQ7yrYq0JSCfybRw7wuzlRIrCIpLYxXWhE4vHV5NeaS
   4YUs0BmFqmzz91bEtRP0VsXDKRFLMyjuMqcNPj4G++pVwLbE9hAqUk0yZ
   zA36TkPO62STSWJke3N4jJI3V+L9nB/htPs+DAeidpL+wgJe3lDhou/qp
   yuIvH5RaXRvquLG/K56p9RJkc9UjfoCMoU7W9Ay+8Pf4n6pmcdZEsUXXK
   UCjPc1saXPtjX/43BwcRuMOLHm72xeaH9wj9R037nsFuZYuLZhQwwR7fX
   E2nHe1yHWkOrBWFLXNg2FU8ORXO4tHKaCyeW6n81Cm4l7k/8QLgWeujh/
   w==;
X-CSE-ConnectionGUID: 5Ty9qCXRTjKhRCz0G4MTOg==
X-CSE-MsgGUID: q5awSXmcQL+Xt5+oxEzvHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="39637041"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="39637041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 04:28:28 -0700
X-CSE-ConnectionGUID: Dh5BDUCwQoySXBEVLy2I/A==
X-CSE-MsgGUID: klS17deCSPic8RUjdG0OyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152769468"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jun 2025 04:28:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ2a3-000CWY-16;
	Fri, 13 Jun 2025 11:28:19 +0000
Date: Fri, 13 Jun 2025 19:27:27 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v6 05/10] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <202506131905.gKLnNnsQ-lkp@intel.com>
References: <20250610233134.3588011-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610233134.3588011-6-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250611-143544
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250610233134.3588011-6-sean.anderson%40linux.dev
patch subject: [net-next PATCH v6 05/10] net: pcs: lynx: Convert to an MDIO driver
config: parisc-randconfig-002-20250613 (https://download.01.org/0day-ci/archive/20250613/202506131905.gKLnNnsQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250613/202506131905.gKLnNnsQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506131905.gKLnNnsQ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/regulator/mt6358-regulator.c:8:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1616:41: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1616:41: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1622:41: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1628:41: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function)
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1634:41: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function)
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1640:41: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function)
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/regulator/pbias-regulator.c:27:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1616:41: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1616:41: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1622:41: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1628:41: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function)
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1634:41: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function)
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1640:41: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function)
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/pbias-regulator.c: At top level:
   drivers/regulator/pbias-regulator.c:136:34: warning: 'pbias_of_match' defined but not used [-Wunused-const-variable=]
     136 | static const struct of_device_id pbias_of_match[] = {
         |                                  ^~~~~~~~~~~~~~
--
   In file included from drivers/regulator/twl-regulator.c:14:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1616:41: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1616:41: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1622:41: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1628:41: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function)
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1634:41: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function)
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1640:41: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function)
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/twl-regulator.c: At top level:
   drivers/regulator/twl-regulator.c:552:34: warning: 'twl_of_match' defined but not used [-Wunused-const-variable=]
     552 | static const struct of_device_id twl_of_match[] = {
         |                                  ^~~~~~~~~~~~
--
   In file included from drivers/regulator/twl6030-regulator.c:15:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1616:41: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1616:41: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1622:41: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1628:41: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function)
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1634:41: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function)
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1640:41: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function)
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/regulator/twl6030-regulator.c: At top level:
   drivers/regulator/twl6030-regulator.c:645:34: warning: 'twl_of_match' defined but not used [-Wunused-const-variable=]
     645 | static const struct of_device_id twl_of_match[] = {
         |                                  ^~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:14,
                    from include/linux/i2c.h:21,
                    from drivers/i2c/i2c-core-of-prober.c:14:
   include/linux/of.h: In function 'of_changeset_attach_node':
>> include/linux/of.h:1616:41: error: 'OF_RECONFIG_ATTACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1616:41: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/of.h: In function 'of_changeset_detach_node':
>> include/linux/of.h:1622:41: error: 'OF_RECONFIG_DETACH_NODE' undeclared (first use in this function); did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h: In function 'of_changeset_add_property':
>> include/linux/of.h:1628:41: error: 'OF_RECONFIG_ADD_PROPERTY' undeclared (first use in this function)
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_remove_property':
>> include/linux/of.h:1634:41: error: 'OF_RECONFIG_REMOVE_PROPERTY' undeclared (first use in this function)
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h: In function 'of_changeset_update_property':
>> include/linux/of.h:1640:41: error: 'OF_RECONFIG_UPDATE_PROPERTY' undeclared (first use in this function)
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c: In function 'i2c_of_probe_component':
>> include/linux/of.h:1478:14: error: implicit declaration of function 'of_get_next_child_with_prefix' [-Werror=implicit-function-declaration]
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c:146:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1478:14: warning: initialization of 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c:146:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1477:9: error: declaration of non-variable 'of_get_next_child_with_prefix' in 'for' loop initial declaration
    1477 |         for (struct device_node *child __free(device_node) =            \
         |         ^~~
   drivers/i2c/i2c-core-of-prober.c:146:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1480:20: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1480 |              child = of_get_next_child_with_prefix(parent, child, prefix))
         |                    ^
   drivers/i2c/i2c-core-of-prober.c:146:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1478:14: warning: initialization of 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c:161:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     161 |         for_each_child_of_node_with_prefix(i2c_node, node, type) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1477:9: error: declaration of non-variable 'of_get_next_child_with_prefix' in 'for' loop initial declaration
    1477 |         for (struct device_node *child __free(device_node) =            \
         |         ^~~
   drivers/i2c/i2c-core-of-prober.c:161:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     161 |         for_each_child_of_node_with_prefix(i2c_node, node, type) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/of.h:1480:20: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1480 |              child = of_get_next_child_with_prefix(parent, child, prefix))
         |                    ^
   drivers/i2c/i2c-core-of-prober.c:161:9: note: in expansion of macro 'for_each_child_of_node_with_prefix'
     161 |         for_each_child_of_node_with_prefix(i2c_node, node, type) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
   Depends on [n]: OF [=n]
   Selected by [y]:
   - FSL_FMAN [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_FREESCALE [=y] && (FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST [=y])


vim +1616 include/linux/of.h

e7a00e4210e4cc Sebastian Reichel         2014-04-06  1430  
f623ce95a51bae Joerg Roedel              2016-04-04  1431  #define of_for_each_phandle(it, err, np, ln, cn, cc)			\
f623ce95a51bae Joerg Roedel              2016-04-04  1432  	for (of_phandle_iterator_init((it), (np), (ln), (cn), (cc)),	\
f623ce95a51bae Joerg Roedel              2016-04-04  1433  	     err = of_phandle_iterator_next(it);			\
f623ce95a51bae Joerg Roedel              2016-04-04  1434  	     err == 0;							\
f623ce95a51bae Joerg Roedel              2016-04-04  1435  	     err = of_phandle_iterator_next(it))
f623ce95a51bae Joerg Roedel              2016-04-04  1436  
9722c3b66e21ff Luca Ceresoli             2024-07-24  1437  #define of_property_for_each_u32(np, propname, u)			\
9c63fea9acd077 Rob Herring (Arm          2024-10-10  1438) 	for (struct {const struct property *prop; const __be32 *item; } _it =	\
9722c3b66e21ff Luca Ceresoli             2024-07-24  1439  		{of_find_property(np, propname, NULL),			\
9722c3b66e21ff Luca Ceresoli             2024-07-24  1440  		 of_prop_next_u32(_it.prop, NULL, &u)};			\
9722c3b66e21ff Luca Ceresoli             2024-07-24  1441  	     _it.item;							\
9722c3b66e21ff Luca Ceresoli             2024-07-24  1442  	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1443  
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1444  #define of_property_for_each_string(np, propname, prop, s)	\
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1445  	for (prop = of_find_property(np, propname, NULL),	\
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1446  		s = of_prop_next_string(prop, NULL);		\
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1447  		s;						\
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1448  		s = of_prop_next_string(prop, s))
2adfffa223500b Sebastian Andrzej Siewior 2013-06-17  1449  
662372e42e46d9 Rob Herring               2014-02-03  1450  #define for_each_node_by_name(dn, name) \
662372e42e46d9 Rob Herring               2014-02-03  1451  	for (dn = of_find_node_by_name(NULL, name); dn; \
662372e42e46d9 Rob Herring               2014-02-03  1452  	     dn = of_find_node_by_name(dn, name))
662372e42e46d9 Rob Herring               2014-02-03  1453  #define for_each_node_by_type(dn, type) \
662372e42e46d9 Rob Herring               2014-02-03  1454  	for (dn = of_find_node_by_type(NULL, type); dn; \
662372e42e46d9 Rob Herring               2014-02-03  1455  	     dn = of_find_node_by_type(dn, type))
662372e42e46d9 Rob Herring               2014-02-03  1456  #define for_each_compatible_node(dn, type, compatible) \
662372e42e46d9 Rob Herring               2014-02-03  1457  	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
662372e42e46d9 Rob Herring               2014-02-03  1458  	     dn = of_find_compatible_node(dn, type, compatible))
662372e42e46d9 Rob Herring               2014-02-03  1459  #define for_each_matching_node(dn, matches) \
662372e42e46d9 Rob Herring               2014-02-03  1460  	for (dn = of_find_matching_node(NULL, matches); dn; \
662372e42e46d9 Rob Herring               2014-02-03  1461  	     dn = of_find_matching_node(dn, matches))
662372e42e46d9 Rob Herring               2014-02-03  1462  #define for_each_matching_node_and_match(dn, matches, match) \
662372e42e46d9 Rob Herring               2014-02-03  1463  	for (dn = of_find_matching_node_and_match(NULL, matches, match); \
662372e42e46d9 Rob Herring               2014-02-03  1464  	     dn; dn = of_find_matching_node_and_match(dn, matches, match))
662372e42e46d9 Rob Herring               2014-02-03  1465  
662372e42e46d9 Rob Herring               2014-02-03  1466  #define for_each_child_of_node(parent, child) \
662372e42e46d9 Rob Herring               2014-02-03  1467  	for (child = of_get_next_child(parent, NULL); child != NULL; \
662372e42e46d9 Rob Herring               2014-02-03  1468  	     child = of_get_next_child(parent, child))
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1469  
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1470  #define for_each_child_of_node_scoped(parent, child) \
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1471  	for (struct device_node *child __free(device_node) =		\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1472  	     of_get_next_child(parent, NULL);				\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1473  	     child != NULL;						\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1474  	     child = of_get_next_child(parent, child))
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1475  
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06  1476  #define for_each_child_of_node_with_prefix(parent, child, prefix)	\
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06 @1477  	for (struct device_node *child __free(device_node) =		\
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06 @1478  	     of_get_next_child_with_prefix(parent, NULL, prefix);	\
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06  1479  	     child != NULL;						\
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06 @1480  	     child = of_get_next_child_with_prefix(parent, child, prefix))
1fcc67e3a35486 Chen-Yu Tsai              2024-11-06  1481  
662372e42e46d9 Rob Herring               2014-02-03  1482  #define for_each_available_child_of_node(parent, child) \
662372e42e46d9 Rob Herring               2014-02-03  1483  	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
662372e42e46d9 Rob Herring               2014-02-03  1484  	     child = of_get_next_available_child(parent, child))
28c5d4e40752fc Kuninori Morimoto         2024-01-10  1485  #define for_each_reserved_child_of_node(parent, child)			\
28c5d4e40752fc Kuninori Morimoto         2024-01-10  1486  	for (child = of_get_next_reserved_child(parent, NULL); child != NULL; \
28c5d4e40752fc Kuninori Morimoto         2024-01-10  1487  	     child = of_get_next_reserved_child(parent, child))
662372e42e46d9 Rob Herring               2014-02-03  1488  
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1489  #define for_each_available_child_of_node_scoped(parent, child) \
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1490  	for (struct device_node *child __free(device_node) =		\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1491  	     of_get_next_available_child(parent, NULL);			\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1492  	     child != NULL;						\
34af4554fb0ce1 Jonathan Cameron          2024-02-25  1493  	     child = of_get_next_available_child(parent, child))
662372e42e46d9 Rob Herring               2014-02-03  1494  
f1f207e43b8a49 Rob Herring               2018-08-22  1495  #define for_each_of_cpu_node(cpu) \
f1f207e43b8a49 Rob Herring               2018-08-22  1496  	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
f1f207e43b8a49 Rob Herring               2018-08-22  1497  	     cpu = of_get_next_cpu_node(cpu))
f1f207e43b8a49 Rob Herring               2018-08-22  1498  
662372e42e46d9 Rob Herring               2014-02-03  1499  #define for_each_node_with_property(dn, prop_name) \
662372e42e46d9 Rob Herring               2014-02-03  1500  	for (dn = of_find_node_with_property(NULL, prop_name); dn; \
662372e42e46d9 Rob Herring               2014-02-03  1501  	     dn = of_find_node_with_property(dn, prop_name))
662372e42e46d9 Rob Herring               2014-02-03  1502  
662372e42e46d9 Rob Herring               2014-02-03  1503  static inline int of_get_child_count(const struct device_node *np)
662372e42e46d9 Rob Herring               2014-02-03  1504  {
662372e42e46d9 Rob Herring               2014-02-03  1505  	struct device_node *child;
662372e42e46d9 Rob Herring               2014-02-03  1506  	int num = 0;
662372e42e46d9 Rob Herring               2014-02-03  1507  
662372e42e46d9 Rob Herring               2014-02-03  1508  	for_each_child_of_node(np, child)
662372e42e46d9 Rob Herring               2014-02-03  1509  		num++;
662372e42e46d9 Rob Herring               2014-02-03  1510  
662372e42e46d9 Rob Herring               2014-02-03  1511  	return num;
662372e42e46d9 Rob Herring               2014-02-03  1512  }
662372e42e46d9 Rob Herring               2014-02-03  1513  
662372e42e46d9 Rob Herring               2014-02-03  1514  static inline int of_get_available_child_count(const struct device_node *np)
662372e42e46d9 Rob Herring               2014-02-03  1515  {
662372e42e46d9 Rob Herring               2014-02-03  1516  	struct device_node *child;
662372e42e46d9 Rob Herring               2014-02-03  1517  	int num = 0;
662372e42e46d9 Rob Herring               2014-02-03  1518  
662372e42e46d9 Rob Herring               2014-02-03  1519  	for_each_available_child_of_node(np, child)
662372e42e46d9 Rob Herring               2014-02-03  1520  		num++;
662372e42e46d9 Rob Herring               2014-02-03  1521  
662372e42e46d9 Rob Herring               2014-02-03  1522  	return num;
662372e42e46d9 Rob Herring               2014-02-03  1523  }
662372e42e46d9 Rob Herring               2014-02-03  1524  
67a066b35765d1 Dmitry Osipenko           2021-06-10  1525  #define _OF_DECLARE_STUB(table, name, compat, fn, fn_type)		\
67a066b35765d1 Dmitry Osipenko           2021-06-10  1526  	static const struct of_device_id __of_table_##name		\
67a066b35765d1 Dmitry Osipenko           2021-06-10  1527  		__attribute__((unused))					\
67a066b35765d1 Dmitry Osipenko           2021-06-10  1528  		 = { .compatible = compat,				\
67a066b35765d1 Dmitry Osipenko           2021-06-10  1529  		     .data = (fn == (fn_type)NULL) ? fn : fn }
67a066b35765d1 Dmitry Osipenko           2021-06-10  1530  
71f50c6d9a2276 Masahiro Yamada           2016-01-22  1531  #if defined(CONFIG_OF) && !defined(MODULE)
54196ccbe0ba1f Rob Herring               2014-05-08  1532  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
54196ccbe0ba1f Rob Herring               2014-05-08  1533  	static const struct of_device_id __of_table_##name		\
33def8498fdde1 Joe Perches               2020-10-21  1534  		__used __section("__" #table "_of_table")		\
5812b32e01c6d8 Johan Hovold              2020-11-23  1535  		__aligned(__alignof__(struct of_device_id))		\
54196ccbe0ba1f Rob Herring               2014-05-08  1536  		 = { .compatible = compat,				\
54196ccbe0ba1f Rob Herring               2014-05-08  1537  		     .data = (fn == (fn_type)NULL) ? fn : fn  }
54196ccbe0ba1f Rob Herring               2014-05-08  1538  #else
54196ccbe0ba1f Rob Herring               2014-05-08  1539  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
67a066b35765d1 Dmitry Osipenko           2021-06-10  1540  	_OF_DECLARE_STUB(table, name, compat, fn, fn_type)
54196ccbe0ba1f Rob Herring               2014-05-08  1541  #endif
54196ccbe0ba1f Rob Herring               2014-05-08  1542  
54196ccbe0ba1f Rob Herring               2014-05-08  1543  typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
c35d9292fee047 Daniel Lezcano            2016-04-18  1544  typedef int (*of_init_fn_1_ret)(struct device_node *);
54196ccbe0ba1f Rob Herring               2014-05-08  1545  typedef void (*of_init_fn_1)(struct device_node *);
54196ccbe0ba1f Rob Herring               2014-05-08  1546  
54196ccbe0ba1f Rob Herring               2014-05-08  1547  #define OF_DECLARE_1(table, name, compat, fn) \
54196ccbe0ba1f Rob Herring               2014-05-08  1548  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1)
c35d9292fee047 Daniel Lezcano            2016-04-18  1549  #define OF_DECLARE_1_RET(table, name, compat, fn) \
c35d9292fee047 Daniel Lezcano            2016-04-18  1550  		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
54196ccbe0ba1f Rob Herring               2014-05-08  1551  #define OF_DECLARE_2(table, name, compat, fn) \
54196ccbe0ba1f Rob Herring               2014-05-08  1552  		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
54196ccbe0ba1f Rob Herring               2014-05-08  1553  
201c910bd6898d Pantelis Antoniou         2014-07-04  1554  /**
201c910bd6898d Pantelis Antoniou         2014-07-04  1555   * struct of_changeset_entry	- Holds a changeset entry
201c910bd6898d Pantelis Antoniou         2014-07-04  1556   *
201c910bd6898d Pantelis Antoniou         2014-07-04  1557   * @node:	list_head for the log list
201c910bd6898d Pantelis Antoniou         2014-07-04  1558   * @action:	notifier action
201c910bd6898d Pantelis Antoniou         2014-07-04  1559   * @np:		pointer to the device node affected
201c910bd6898d Pantelis Antoniou         2014-07-04  1560   * @prop:	pointer to the property affected
201c910bd6898d Pantelis Antoniou         2014-07-04  1561   * @old_prop:	hold a pointer to the original property
201c910bd6898d Pantelis Antoniou         2014-07-04  1562   *
201c910bd6898d Pantelis Antoniou         2014-07-04  1563   * Every modification of the device tree during a changeset
201c910bd6898d Pantelis Antoniou         2014-07-04  1564   * is held in a list of of_changeset_entry structures.
201c910bd6898d Pantelis Antoniou         2014-07-04  1565   * That way we can recover from a partial application, or we can
201c910bd6898d Pantelis Antoniou         2014-07-04  1566   * revert the changeset
201c910bd6898d Pantelis Antoniou         2014-07-04  1567   */
201c910bd6898d Pantelis Antoniou         2014-07-04  1568  struct of_changeset_entry {
201c910bd6898d Pantelis Antoniou         2014-07-04  1569  	struct list_head node;
201c910bd6898d Pantelis Antoniou         2014-07-04  1570  	unsigned long action;
201c910bd6898d Pantelis Antoniou         2014-07-04  1571  	struct device_node *np;
201c910bd6898d Pantelis Antoniou         2014-07-04  1572  	struct property *prop;
201c910bd6898d Pantelis Antoniou         2014-07-04  1573  	struct property *old_prop;
201c910bd6898d Pantelis Antoniou         2014-07-04  1574  };
201c910bd6898d Pantelis Antoniou         2014-07-04  1575  
201c910bd6898d Pantelis Antoniou         2014-07-04  1576  /**
201c910bd6898d Pantelis Antoniou         2014-07-04  1577   * struct of_changeset - changeset tracker structure
201c910bd6898d Pantelis Antoniou         2014-07-04  1578   *
201c910bd6898d Pantelis Antoniou         2014-07-04  1579   * @entries:	list_head for the changeset entries
201c910bd6898d Pantelis Antoniou         2014-07-04  1580   *
201c910bd6898d Pantelis Antoniou         2014-07-04  1581   * changesets are a convenient way to apply bulk changes to the
201c910bd6898d Pantelis Antoniou         2014-07-04  1582   * live tree. In case of an error, changes are rolled-back.
201c910bd6898d Pantelis Antoniou         2014-07-04  1583   * changesets live on after initial application, and if not
201c910bd6898d Pantelis Antoniou         2014-07-04  1584   * destroyed after use, they can be reverted in one single call.
201c910bd6898d Pantelis Antoniou         2014-07-04  1585   */
201c910bd6898d Pantelis Antoniou         2014-07-04  1586  struct of_changeset {
201c910bd6898d Pantelis Antoniou         2014-07-04  1587  	struct list_head entries;
201c910bd6898d Pantelis Antoniou         2014-07-04  1588  };
201c910bd6898d Pantelis Antoniou         2014-07-04  1589  
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1590  enum of_reconfig_change {
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1591  	OF_RECONFIG_NO_CHANGE = 0,
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1592  	OF_RECONFIG_CHANGE_ADD,
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1593  	OF_RECONFIG_CHANGE_REMOVE,
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1594  };
b53a2340d0d304 Pantelis Antoniou         2014-10-28  1595  
2e8fff668dc14e Rob Herring               2023-03-29  1596  struct notifier_block;
2e8fff668dc14e Rob Herring               2023-03-29  1597  
201c910bd6898d Pantelis Antoniou         2014-07-04  1598  #ifdef CONFIG_OF_DYNAMIC
f6892d193fb9d6 Grant Likely              2014-11-21  1599  extern int of_reconfig_notifier_register(struct notifier_block *);
f6892d193fb9d6 Grant Likely              2014-11-21  1600  extern int of_reconfig_notifier_unregister(struct notifier_block *);
f5242e5a883bf1 Grant Likely              2014-11-24  1601  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
f5242e5a883bf1 Grant Likely              2014-11-24  1602  extern int of_reconfig_get_state_change(unsigned long action,
f5242e5a883bf1 Grant Likely              2014-11-24  1603  					struct of_reconfig_data *arg);
f6892d193fb9d6 Grant Likely              2014-11-21  1604  
201c910bd6898d Pantelis Antoniou         2014-07-04  1605  extern void of_changeset_init(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou         2014-07-04  1606  extern void of_changeset_destroy(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou         2014-07-04  1607  extern int of_changeset_apply(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou         2014-07-04  1608  extern int of_changeset_revert(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou         2014-07-04  1609  extern int of_changeset_action(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1610  		unsigned long action, struct device_node *np,
201c910bd6898d Pantelis Antoniou         2014-07-04  1611  		struct property *prop);
201c910bd6898d Pantelis Antoniou         2014-07-04  1612  
201c910bd6898d Pantelis Antoniou         2014-07-04  1613  static inline int of_changeset_attach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1614  		struct device_node *np)
201c910bd6898d Pantelis Antoniou         2014-07-04  1615  {
201c910bd6898d Pantelis Antoniou         2014-07-04 @1616  	return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou         2014-07-04  1617  }
201c910bd6898d Pantelis Antoniou         2014-07-04  1618  
201c910bd6898d Pantelis Antoniou         2014-07-04  1619  static inline int of_changeset_detach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1620  		struct device_node *np)
201c910bd6898d Pantelis Antoniou         2014-07-04  1621  {
201c910bd6898d Pantelis Antoniou         2014-07-04 @1622  	return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou         2014-07-04  1623  }
201c910bd6898d Pantelis Antoniou         2014-07-04  1624  
201c910bd6898d Pantelis Antoniou         2014-07-04  1625  static inline int of_changeset_add_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1626  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou         2014-07-04  1627  {
201c910bd6898d Pantelis Antoniou         2014-07-04 @1628  	return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou         2014-07-04  1629  }
201c910bd6898d Pantelis Antoniou         2014-07-04  1630  
201c910bd6898d Pantelis Antoniou         2014-07-04  1631  static inline int of_changeset_remove_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1632  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou         2014-07-04  1633  {
201c910bd6898d Pantelis Antoniou         2014-07-04 @1634  	return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou         2014-07-04  1635  }
201c910bd6898d Pantelis Antoniou         2014-07-04  1636  
201c910bd6898d Pantelis Antoniou         2014-07-04  1637  static inline int of_changeset_update_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou         2014-07-04  1638  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou         2014-07-04  1639  {
201c910bd6898d Pantelis Antoniou         2014-07-04 @1640  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou         2014-07-04  1641  }
b544fc2b8606d7 Lizhi Hou                 2023-08-15  1642  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

