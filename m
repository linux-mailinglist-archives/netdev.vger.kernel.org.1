Return-Path: <netdev+bounces-196755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADECCAD645D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE91BC33E7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D355258;
	Thu, 12 Jun 2025 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XncBIGu1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E638B;
	Thu, 12 Jun 2025 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687295; cv=none; b=P2AYvGmxDNhDvNgyrC6ooZOmU3vzrnmg8BA2yHx7o+m02ijTLo1tH+lcofBSRM6g//tFta3+wmMn+NAf7SgVyU5ymIicdNDs/3q0A0ksHnQqSoWFyw5lm1R4iWQ98Tbh0ercDqfO1w4zUo7naQg9tzJZKqYiaXLRD/Rya8PPemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687295; c=relaxed/simple;
	bh=3+i/qQYgvBYTLJ9rk46HeDginwQWUDS8zT4mmWEEUrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsZnLWSNpCQcEcnUR0vj3YW/MfN8vpzA4MzWnjEk7yvZrK6HQDH+j9qyiyiGKV0lfA/+Egv0eftK/Zkg3YqhCkAOJo1OWhzktpLZJJXfVeSdmnUj5YTP99S3TpaZ6lZ88uOq2KEvX0PeHMuLR297q3lirxkgVkxT04K+66nrkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XncBIGu1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749687293; x=1781223293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3+i/qQYgvBYTLJ9rk46HeDginwQWUDS8zT4mmWEEUrE=;
  b=XncBIGu1SREir3faycrrnQsT4ZjGpxzPRFdmSwRKqFmPWKl9SOg6EGq2
   zupDldq756YW5ol87VGNm2/fIn/dV1s8h63tNh2wNfPTDUK0sJhsub86O
   f/qn5IET3c8+/CxxWc3AqJ9simrY+Tw4ISofZ+Fi0ZPnSSR3oZccgqVpG
   7+BtpjBdtajkf32XZl3+4pI32oNhKsPNrlJH1z6FadI55UHuckoYeS6a8
   7qCem+QPxgMq+qrtUBnUv1z+diYkScGMF3ncnCzkBn7tHU8WsKC4OxCVH
   OQjEoeTum0OPWXJxZqGn1oKeIDCt8qd1sSKGiU/sjAhKTFwn25X5MKNwN
   g==;
X-CSE-ConnectionGUID: 4AIsD6q7TnWHZWg/j6D5DA==
X-CSE-MsgGUID: Z4TUn9f5TVC4ktVZoNGnoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51727344"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51727344"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 17:14:52 -0700
X-CSE-ConnectionGUID: 1f0u85CwQt2U7n5U0sxH2w==
X-CSE-MsgGUID: +x7J175lRBSblLkppAz+cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147842871"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2025 17:14:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPVae-000Ax0-2r;
	Thu, 12 Jun 2025 00:14:44 +0000
Date: Thu, 12 Jun 2025 08:14:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Michal Simek <monstr@monstr.eu>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next PATCH v6 06/10] net: pcs: Add Xilinx PCS driver
Message-ID: <202506120722.o7HB1e60-lkp@intel.com>
References: <20250610233134.3588011-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610233134.3588011-7-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/dt-bindings-net-Add-Xilinx-PCS/20250611-143544
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250610233134.3588011-7-sean.anderson%40linux.dev
patch subject: [net-next PATCH v6 06/10] net: pcs: Add Xilinx PCS driver
config: sh-kismet-CONFIG_COMMON_CLK-CONFIG_PCS_XILINX-0-0 (https://download.01.org/0day-ci/archive/20250612/202506120722.o7HB1e60-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250612/202506120722.o7HB1e60-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506120722.o7HB1e60-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for COMMON_CLK when selected by PCS_XILINX
   WARNING: unmet direct dependencies detected for COMMON_CLK
     Depends on [n]: !HAVE_LEGACY_CLK [=y]
     Selected by [y]:
     - PCS_XILINX [=y] && NETDEVICES [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

