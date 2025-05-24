Return-Path: <netdev+bounces-193199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4308AAC2E42
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 10:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9863B13C9
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2AF3C0C;
	Sat, 24 May 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A12o1EYe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAED29A9;
	Sat, 24 May 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748074902; cv=none; b=B/78mVE5C0y5cy+Mccx8tQcwdwy7UAUA+cajTcK24XXlhW8LxLOR0vzbm9nDsfDCVLbsBcYyHBi+T6R83mAo1VqYDa9aGH6/rTqH0UUQ748cB/Tttl/qa3ZXpoZfEr0c7HrMkZ/Rur2JPy/bmsOXvuw+V2yBQ9rZumb6thqhI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748074902; c=relaxed/simple;
	bh=f9sbU8KiPXi1mKYA5KacKV3bnw+W+YAO+AwFqrTYyvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhs0NfhBXgJJaTjsg2Ml2tyLTPyrEdYOUov+U6yIKg4SS75ngwdqDrXhz68QRkT4sKfBGnoUEc4jsicc6AdtjRmqdam3twLxmmiZmfmzGcazaep4I5zQUS62ENTY75oIhQaFWjOpI6lT7JDp9nEu/dDr/1OHMcJmiyPi1IUqHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A12o1EYe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748074901; x=1779610901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9sbU8KiPXi1mKYA5KacKV3bnw+W+YAO+AwFqrTYyvQ=;
  b=A12o1EYelyyKH/JU6OrJ2Qo/YkSfCJ4+FzXdReS3O5TI2fEoarcH/5Fv
   QvTiAaRcIMmlufOzkyXhznOtI+vS6KiDrV+XaJwcpxzaN3eo82hMpAxl2
   rf9DMHLAxncr7+7NFxajZJQRnxG+DZWK+7mIuVnibyRczIh+HDEjrN+MK
   0oGn2FoHMiszFTTiGYkD7KMcPqAExsoVFnoQerDlqlMVIYet1dkglWB/U
   eLkeOBCPhjP1+4u5/VRx/cfkHAHW19hwsN0bvm1vqwRpDiKQsaJMgNnDg
   yvoPeMoOgEeVSP7HWTXmcL7vzVInI+epFeV5tYIqkxUTo/X/pLBm3rMBm
   g==;
X-CSE-ConnectionGUID: zLQO3mKSRRyVNmWdJ16ZUw==
X-CSE-MsgGUID: ii3jkB8hR+W3NhoKx0lvjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50005311"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="50005311"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 01:21:39 -0700
X-CSE-ConnectionGUID: duR0nArKRb2BC59cL46Qaw==
X-CSE-MsgGUID: BtDtXxCOQTezcn0WOZ8Fzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146205958"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 24 May 2025 01:21:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIk8K-000R3I-0b;
	Sat, 24 May 2025 08:21:32 +0000
Date: Sat, 24 May 2025 16:21:27 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <202505241550.xuPguGhB-lkp@intel.com>
References: <20250523203339.1993685-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523203339.1993685-6-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250524-043901
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250523203339.1993685-6-sean.anderson%40linux.dev
patch subject: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO driver
config: hexagon-randconfig-001-20250524 (https://download.01.org/0day-ci/archive/20250524/202505241550.xuPguGhB-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505241550.xuPguGhB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241550.xuPguGhB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/i2c/i2c-core-base.c:24:
   In file included from include/linux/i2c.h:21:
   In file included from include/linux/irqdomain.h:36:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
   5 errors generated.
--
   In file included from drivers/i2c/i2c-core-of-prober.c:14:
   In file included from include/linux/i2c.h:21:
   In file included from include/linux/irqdomain.h:36:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
>> drivers/i2c/i2c-core-of-prober.c:146:2: error: call to undeclared function 'of_get_next_child_with_prefix'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^
   include/linux/of.h:1478:7: note: expanded from macro 'for_each_child_of_node_with_prefix'
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ^
>> drivers/i2c/i2c-core-of-prober.c:146:47: error: incompatible integer to pointer conversion initializing 'struct device_node *' with an expression of type 'int' [-Wint-conversion]
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/of.h:1477:27: note: expanded from macro 'for_each_child_of_node_with_prefix'
    1477 |         for (struct device_node *child __free(device_node) =            \
         |                                  ^
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/i2c/i2c-core-of-prober.c:146:2: error: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
     146 |         for_each_child_of_node_with_prefix(i2c_node, node, type)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:1480:13: note: expanded from macro 'for_each_child_of_node_with_prefix'
    1480 |              child = of_get_next_child_with_prefix(parent, child, prefix))
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c:161:47: error: incompatible integer to pointer conversion initializing 'struct device_node *' with an expression of type 'int' [-Wint-conversion]
     161 |         for_each_child_of_node_with_prefix(i2c_node, node, type) {
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/of.h:1477:27: note: expanded from macro 'for_each_child_of_node_with_prefix'
    1477 |         for (struct device_node *child __free(device_node) =            \
         |                                  ^
    1478 |              of_get_next_child_with_prefix(parent, NULL, prefix);       \
         |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i2c/i2c-core-of-prober.c:161:2: error: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
     161 |         for_each_child_of_node_with_prefix(i2c_node, node, type) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/of.h:1480:13: note: expanded from macro 'for_each_child_of_node_with_prefix'
    1480 |              child = of_get_next_child_with_prefix(parent, child, prefix))
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   10 errors generated.
--
   In file included from drivers/spi/spi-bcm-qspi.c:17:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/spi/spi-bcm-qspi.c:21:
   In file included from include/linux/spi/spi.h:17:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:35:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:24: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
--
   In file included from drivers/spi/spi.c:25:
   In file included from include/linux/of_irq.h:8:
   In file included from include/linux/irqdomain.h:36:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
>> drivers/spi/spi.c:4806:9: error: call to undeclared function 'of_register_spi_device'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    4806 |                 spi = of_register_spi_device(ctlr, rd->dn);
         |                       ^
   drivers/spi/spi.c:4806:9: note: did you mean 'of_register_spi_devices'?
   drivers/spi/spi.c:2554:13: note: 'of_register_spi_devices' declared here
    2554 | static void of_register_spi_devices(struct spi_controller *ctlr) { }
         |             ^
>> drivers/spi/spi.c:4806:7: error: incompatible integer to pointer conversion assigning to 'struct spi_device *' from 'int' [-Wint-conversion]
    4806 |                 spi = of_register_spi_device(ctlr, rd->dn);
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7 errors generated.
--
   In file included from drivers/dma/mmp_pdma.c:18:
   In file included from include/linux/of_dma.h:13:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
   drivers/dma/mmp_pdma.c:1104:27: warning: shift count >= width of type [-Wshift-count-overflow]
    1104 |                 dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 5 errors generated.
--
   In file included from drivers/dma/altera-msgdma.c:22:
   In file included from include/linux/of_dma.h:13:
>> include/linux/of.h:1616:34: error: use of undeclared identifier 'OF_RECONFIG_ATTACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1616 |         return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1622:34: error: use of undeclared identifier 'OF_RECONFIG_DETACH_NODE'; did you mean 'OF_RECONFIG_NO_CHANGE'?
    1622 |         return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                                         OF_RECONFIG_NO_CHANGE
   include/linux/of.h:1591:2: note: 'OF_RECONFIG_NO_CHANGE' declared here
    1591 |         OF_RECONFIG_NO_CHANGE = 0,
         |         ^
>> include/linux/of.h:1628:34: error: use of undeclared identifier 'OF_RECONFIG_ADD_PROPERTY'
    1628 |         return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1634:34: error: use of undeclared identifier 'OF_RECONFIG_REMOVE_PROPERTY'
    1634 |         return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
         |                                         ^
>> include/linux/of.h:1640:34: error: use of undeclared identifier 'OF_RECONFIG_UPDATE_PROPERTY'
    1640 |         return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
         |                                         ^
   drivers/dma/altera-msgdma.c:895:46: warning: shift count >= width of type [-Wshift-count-overflow]
     895 |         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
         |                                                     ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^ ~~~
   1 warning and 5 errors generated.
..

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_DYNAMIC
   Depends on [n]: OF [=n]
   Selected by [y]:
   - FSL_FMAN [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_FREESCALE [=y] && (FSL_SOC || ARCH_LAYERSCAPE || COMPILE_TEST [=y])


vim +1616 include/linux/of.h

201c910bd6898d Pantelis Antoniou 2014-07-04  1589  
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1590  enum of_reconfig_change {
b53a2340d0d304 Pantelis Antoniou 2014-10-28 @1591  	OF_RECONFIG_NO_CHANGE = 0,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1592  	OF_RECONFIG_CHANGE_ADD,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1593  	OF_RECONFIG_CHANGE_REMOVE,
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1594  };
b53a2340d0d304 Pantelis Antoniou 2014-10-28  1595  
2e8fff668dc14e Rob Herring       2023-03-29  1596  struct notifier_block;
2e8fff668dc14e Rob Herring       2023-03-29  1597  
201c910bd6898d Pantelis Antoniou 2014-07-04  1598  #ifdef CONFIG_OF_DYNAMIC
f6892d193fb9d6 Grant Likely      2014-11-21  1599  extern int of_reconfig_notifier_register(struct notifier_block *);
f6892d193fb9d6 Grant Likely      2014-11-21  1600  extern int of_reconfig_notifier_unregister(struct notifier_block *);
f5242e5a883bf1 Grant Likely      2014-11-24  1601  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
f5242e5a883bf1 Grant Likely      2014-11-24  1602  extern int of_reconfig_get_state_change(unsigned long action,
f5242e5a883bf1 Grant Likely      2014-11-24  1603  					struct of_reconfig_data *arg);
f6892d193fb9d6 Grant Likely      2014-11-21  1604  
201c910bd6898d Pantelis Antoniou 2014-07-04  1605  extern void of_changeset_init(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1606  extern void of_changeset_destroy(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1607  extern int of_changeset_apply(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1608  extern int of_changeset_revert(struct of_changeset *ocs);
201c910bd6898d Pantelis Antoniou 2014-07-04  1609  extern int of_changeset_action(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1610  		unsigned long action, struct device_node *np,
201c910bd6898d Pantelis Antoniou 2014-07-04  1611  		struct property *prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1612  
201c910bd6898d Pantelis Antoniou 2014-07-04  1613  static inline int of_changeset_attach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1614  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1615  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1616  	return of_changeset_action(ocs, OF_RECONFIG_ATTACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1617  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1618  
201c910bd6898d Pantelis Antoniou 2014-07-04  1619  static inline int of_changeset_detach_node(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1620  		struct device_node *np)
201c910bd6898d Pantelis Antoniou 2014-07-04  1621  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1622  	return of_changeset_action(ocs, OF_RECONFIG_DETACH_NODE, np, NULL);
201c910bd6898d Pantelis Antoniou 2014-07-04  1623  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1624  
201c910bd6898d Pantelis Antoniou 2014-07-04  1625  static inline int of_changeset_add_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1626  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1627  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1628  	return of_changeset_action(ocs, OF_RECONFIG_ADD_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1629  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1630  
201c910bd6898d Pantelis Antoniou 2014-07-04  1631  static inline int of_changeset_remove_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1632  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1633  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1634  	return of_changeset_action(ocs, OF_RECONFIG_REMOVE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1635  }
201c910bd6898d Pantelis Antoniou 2014-07-04  1636  
201c910bd6898d Pantelis Antoniou 2014-07-04  1637  static inline int of_changeset_update_property(struct of_changeset *ocs,
201c910bd6898d Pantelis Antoniou 2014-07-04  1638  		struct device_node *np, struct property *prop)
201c910bd6898d Pantelis Antoniou 2014-07-04  1639  {
201c910bd6898d Pantelis Antoniou 2014-07-04 @1640  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
201c910bd6898d Pantelis Antoniou 2014-07-04  1641  }
b544fc2b8606d7 Lizhi Hou         2023-08-15  1642  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

