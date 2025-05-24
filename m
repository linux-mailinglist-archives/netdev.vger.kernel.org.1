Return-Path: <netdev+bounces-193224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE2AC2FE0
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0859E3C98
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF61C1F02;
	Sat, 24 May 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2a8gPFN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295E1A23A6;
	Sat, 24 May 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748093705; cv=none; b=f4raGyvPqhqarMbXL7AJjoKitfLEzR8uj7HiXzPVkhhf4DMixLhDCHcL2qfVHUpXK5++E/Tw/SLt5aw2b6oeE2Hn+MLhnSiwAnzOaoYh6XB7xkCGweCUwG33hpxphaFINsOmYLg3kU9TSc2ghW/JSW8HlV4YKW2zf8iP3AxD7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748093705; c=relaxed/simple;
	bh=qcL491bXMJZ+O+gsTZNeVomr5uwF83cd6pWDzZAReO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxYDL8LhUDBSP966tcfrukDUYdmgTIjQpe4WieeR5Djs1h3aj2hjEAops3foOJIvx4mKYdq4rD8Km9kYlO6mlzAGC0Skr8OsxJ8JlkqBdcaX8URhsL+vtTDVWXC3PEmUwRxvDxNybkw680R81e/HxauiqXbKvw/3N/wUWaeQQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2a8gPFN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748093705; x=1779629705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qcL491bXMJZ+O+gsTZNeVomr5uwF83cd6pWDzZAReO4=;
  b=X2a8gPFN47FpwHOPEZLAw3OExi7ukSDyHHUVGUKU5EzjoRM9XxknVXUm
   v62MH9gsyGhk+EtL1Q0V05L66ffgO22oXyHozrlOD5tSpBlvz8r9i2uQr
   1lLZM8pm3SFPUh21f7yZEHOfRTHW1tTgO9NAhAHpPZMhLJGptx+E+k06E
   NEUyD623DSgChWxtK9N2gSDmUmk4HbGuEJVmZAwy6/9c5wm1blB1pravm
   JJFaLqz6hXfR+2h6sw+MgKGiNk/oK+1QoZTG9/zQ+qeHcwkqjbh96v0gn
   fAQfDaBgRv/gRJgKitvl7Pr/8IhmgPNyyCATR0mh6nyd+HFh5VtyMDY5c
   w==;
X-CSE-ConnectionGUID: pu/HJrAtSluZtG+LBXcSAA==
X-CSE-MsgGUID: NqbCi5TzT3Sl7bpt0CVdvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="50290713"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="50290713"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 06:35:04 -0700
X-CSE-ConnectionGUID: Hm0pHqY8QqeFxidCs1ibYg==
X-CSE-MsgGUID: DQo3Dxt/SMuMBg2vQW1Svg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146431096"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2025 06:34:58 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIp1c-000RDw-1k;
	Sat, 24 May 2025 13:34:56 +0000
Date: Sat, 24 May 2025 21:34:33 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, Lei Wei <quic_leiwei@quicinc.com>,
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
Message-ID: <202505242145.RKJGzoHX-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250524-043901
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250523203339.1993685-6-sean.anderson%40linux.dev
patch subject: [net-next PATCH v5 05/10] net: pcs: lynx: Convert to an MDIO driver
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505242145.RKJGzoHX-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/pcs/pcs-lynx.c: linux/phylink.h is included more than once.

vim +8 drivers/net/pcs/pcs-lynx.c

   > 8	#include <linux/phylink.h>
     9	#include <linux/of.h>
    10	#include <linux/pcs.h>
    11	#include <linux/pcs-lynx.h>
  > 12	#include <linux/phylink.h>
    13	#include <linux/property.h>
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

