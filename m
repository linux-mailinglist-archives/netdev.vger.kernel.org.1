Return-Path: <netdev+bounces-94317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED78BF19F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C7281944
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1717D143C5C;
	Tue,  7 May 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0KEDMGR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FECF142E79;
	Tue,  7 May 2024 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123344; cv=none; b=jRS5ZOecUdWhEecLYMgHcCMa6Xk+pPokAYTx6Vd7MBtEfBC75Aqo+oNMYlr1RJGWR6p0KPl9Vfxt49MqtK/toyKj6Yb6sJYehB59D0+X1SQLkzJDonNPee+Xxz2NapfDr4poKGwR2HovPrlMX+7p0NqzZPBEENB20QCgMAYHfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123344; c=relaxed/simple;
	bh=sbBCo2A1xLZ0vOXmtjRmskZzILCS1fwj9Xtelg+/+co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0k5Epvj9PlxM623iB1nfjIgB4KEz9LfhkFxWwRw9jnhYjZ9kYFRwZ+EmgbeBZ+uZeeQNI5tyPTyu+DKh8SHGi217DfOqyOD+Igv/oe0dlA23Jmx2bIfrsTsuMIl3rY7D1089R6SFUwwcJQQAKP312Jv8cZKi/IHQ+vRD6QFd90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0KEDMGR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715123341; x=1746659341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sbBCo2A1xLZ0vOXmtjRmskZzILCS1fwj9Xtelg+/+co=;
  b=X0KEDMGRgyzKg8DoCh4Rp18rOYNySsYSKplat1Ez+uU9KoSh0BM4Zfxu
   3Oh1y2jSjyzXzE2pqzTJmub/22yXbQI+ZqlJNWlM0vVnvud/erblqancR
   wBPbvOoIUT865fni+SWMk///aSulPo/W4+bOW6k7FIedo2Mi7r5tAZREz
   mXBFY4vV3GB+IGnYX6OShQN79RqGWMiKjkMfRDbiChZfKyhtzVopEu3Il
   D0LIM3S08TFr7ECbqf9R45dgtd2NdlrNzqCw7RX06+Am8vZr2hRLzvc4Z
   e93+DNWJW94lxSXKZ3YkrEfz6svwJuWI2lzONQ/Ouj86d4FDlTSYYx1PO
   A==;
X-CSE-ConnectionGUID: Jq1kagcoT7+Dwi0wMNgi1Q==
X-CSE-MsgGUID: HUMzRYzXQXORvj9PeU1D+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11113109"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11113109"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 16:09:00 -0700
X-CSE-ConnectionGUID: dGaliaqjQ72/tYjH1V1Nfg==
X-CSE-MsgGUID: pJeQw4WkSaSxWq4X0sagaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="66110058"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 May 2024 16:08:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4TvY-0002iq-0A;
	Tue, 07 May 2024 23:08:52 +0000
Date: Wed, 8 May 2024 07:08:43 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next 2/2] net: phy: phy_link_topology:
 Lazy-initialize the link topology
Message-ID: <202405080732.pSwJSarc-lkp@intel.com>
References: <20240507102822.2023826-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507102822.2023826-3-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-phy_link_topology-Pass-netdevice-to-phy_link_topo-helpers/20240507-183130
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240507102822.2023826-3-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 2/2] net: phy: phy_link_topology: Lazy-initialize the link topology
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240508/202405080732.pSwJSarc-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080732.pSwJSarc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080732.pSwJSarc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/core/dev.c:10276:13: warning: 'netdev_free_phy_link_topology' defined but not used [-Wunused-function]
   10276 | static void netdev_free_phy_link_topology(struct net_device *dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/netdev_free_phy_link_topology +10276 net/core/dev.c

 10275	
 10276	static void netdev_free_phy_link_topology(struct net_device *dev)
 10277	{
 10278		struct phy_link_topology *topo = dev->link_topo;
 10279	
 10280		if (!topo)
 10281			return;
 10282	
 10283		xa_destroy(&topo->phys);
 10284		kfree(topo);
 10285		dev->link_topo = NULL;
 10286	}
 10287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

