Return-Path: <netdev+bounces-105348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 715D69108A6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F4B22B73
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A5B1AE086;
	Thu, 20 Jun 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3y5KnY5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583591AB535;
	Thu, 20 Jun 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894479; cv=none; b=qzjWkzitSEXQP+78L1KSPdsnPN7rjppioPwBkgl2WvRks9IsgYygrFHoaAJoEYSdvPYP+dGNGZYYaFkgU7yFktQvSfL6e2xW4yB6QsopFes9ffpNYt1aJfePGAXtbEOZFU2bhbACxL1DY/yCBCBAVpPWFfEB9fvhsjZ3sdYVWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894479; c=relaxed/simple;
	bh=5ScJcEVT9hBda7ysTACD45tqpz9ZSLw8J/lH+rGCEh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqjfRthoPjGlcedXt1jPyAp8AXjhaw30SQFJPs19yOvqhNoTmwB5j6JC0DY+dV/J/0dx9M2IwHo26RsbixqCSmqCdrp+60M1InOBLy3iuTZZiqv6eFaLfwu6XYB8XS+nZvdtSns8ySyyQjpSKSPGj89M/I+VbCnDQniANKXJ+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3y5KnY5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718894477; x=1750430477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ScJcEVT9hBda7ysTACD45tqpz9ZSLw8J/lH+rGCEh0=;
  b=J3y5KnY58lHxtJRL0pqM5SYmyltXYOv8jQiTEewuf5EXkq+OEq/c+Z4Q
   UNuLpTO8DQUW9ouLxGp7i8HDLSct14FRRwBgYFciNgD2CNDYpuAkqx8PV
   uzgAAjhjXF21MPriD0FJy/Y4Y2mOCyBrW4J4R1MQzIhbDQ9Jc6PtTWsTo
   7XIEHYP8B4Nr9wbdmAhdKgiXqB9thIZP0u5EgDH9UKFl1wDa1E/8Up4k4
   64A9MMopoRqZpty7Jbpd6q+RwzUJSr9Tnzq6vKShIQ4CdyvIFjHzXsVsr
   thMfwcZFzNs6YB8S7QGSPNWN/XQI6qrsqy6ytTbDEaFZVOq9V8OC1Liuk
   A==;
X-CSE-ConnectionGUID: Y0sGUAxjT5K3NTT+T5eezA==
X-CSE-MsgGUID: 3VPEZ4W4Q7m/5mHRMcHHdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="33415610"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="33415610"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 07:41:10 -0700
X-CSE-ConnectionGUID: F04vPV/tToidaLxiCN1z4w==
X-CSE-MsgGUID: bTefi67oRq2jOEwZb0FxVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="73000408"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Jun 2024 07:41:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKIyG-0007gK-2k;
	Thu, 20 Jun 2024 14:41:04 +0000
Date: Thu, 20 Jun 2024 22:40:28 +0800
From: kernel test robot <lkp@intel.com>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Andrew Lunn <andrew@lunn.ch>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
Message-ID: <202406202033.cdjd66Gh-lkp@intel.com>
References: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620002826.213013-1-aryan.srivastava@alliedtelesis.co.nz>

Hi Aryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.10-rc4 next-20240619]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aryan-Srivastava/net-dsa-mv88e6xxx-Add-FID-map-cache/20240620-083100
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240620002826.213013-1-aryan.srivastava%40alliedtelesis.co.nz
patch subject: [PATCH v1] net: dsa: mv88e6xxx: Add FID map cache
config: arm-randconfig-003-20240620 (https://download.01.org/0day-ci/archive/20240620/202406202033.cdjd66Gh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406202033.cdjd66Gh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406202033.cdjd66Gh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/mv88e6xxx/chip.c: In function 'mv88e6xxx_atu_new':
>> drivers/net/dsa/mv88e6xxx/chip.c:1960:13: warning: unused variable 'err' [-Wunused-variable]
    1960 |         int err;
         |             ^~~


vim +/err +1960 drivers/net/dsa/mv88e6xxx/chip.c

  1957	
  1958	static int mv88e6xxx_atu_new(struct mv88e6xxx_chip *chip, u16 *fid)
  1959	{
> 1960		int err;
  1961	
  1962		*fid = find_first_zero_bit(chip->fid_bitmap, MV88E6XXX_N_FID);
  1963		if (unlikely(*fid >= mv88e6xxx_num_databases(chip)))
  1964			return -ENOSPC;
  1965	
  1966		/* Clear the database */
  1967		return mv88e6xxx_g1_atu_flush(chip, *fid, true);
  1968	}
  1969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

