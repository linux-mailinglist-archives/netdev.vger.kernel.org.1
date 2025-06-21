Return-Path: <netdev+bounces-200045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BDEAE2C88
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA38189A284
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B762271443;
	Sat, 21 Jun 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmKXWqnM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D127055E
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750540008; cv=none; b=VZ5q2YHP7FMfGJzFve4gy4ymPjc56P8BNM+uMeBUUfMa0AEwtsbeSsEmEfxv3ELB9S6b3yJFNCvZwNcyFLLVnKWQL2UfzErce3Ltp/MQtYKwjPrMdUqS61W4IsY86JWnG41cyOILyeL7duGNPVqE6KQTsxEPh7NglEoBmL5I3mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750540008; c=relaxed/simple;
	bh=nkXstz1C3clyLM3MvPPtHM/8r/K4NXJ2Fa434t+fCeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf5bpZDdBo/SZdPygbeBH4EJRVDtBiBdRzYjBDTFi67nsz3LCfdOd8MNr6r/PlL7IJw/QcwdBIbyIj+wa7GNN3iq3vUCj+lmWNqdmiiP63pVQfcxxRBBT5C8inRwr0NET5ARRFYPhdo7NY2WkHGwlZ5xBhmaQ8oK+bUU1QA+/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmKXWqnM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750540007; x=1782076007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nkXstz1C3clyLM3MvPPtHM/8r/K4NXJ2Fa434t+fCeM=;
  b=KmKXWqnMz5QiEFR9vxcdn3blxFJHDg9h5DtK3swe+Ehz29wqE/3lBjSi
   wCTkK8VWk9YW5fM6XiBZnzh2qCp8GzlNWAapWadfd9zf0zVrJedZQ3KV1
   vt+mXxOXoIJBUwfVGJ5SbYXMFPfhnUtZpVj932axXEw+ii1k+pOEIhHRL
   I07Agu6Bur0AaBy5jf6HvTDJ6J0+7emyBoDyE1Rip3vPrvethhSnGR7Tb
   1ymnmtmKuQPNynMnm7Bfv51rmb5GH0hHkKMqol66fUM5tTKdq20I9Rb3O
   +UkPy7ph/pHh+gW7nESrg/UtKH5bZoqajm6VxgFwLhAbtxifAZ4NNnb9Q
   w==;
X-CSE-ConnectionGUID: shBAcYeYQl6zPPUTUQzRmg==
X-CSE-MsgGUID: 3w2hpRi7R7CfFdDkFaHKVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11470"; a="63046069"
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="63046069"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 14:06:46 -0700
X-CSE-ConnectionGUID: wTQNmEfFTuiKDELw2780IQ==
X-CSE-MsgGUID: 5iQF6TNIRLqOgmSkQY+A5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,254,1744095600"; 
   d="scan'208";a="150694433"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Jun 2025 14:06:43 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uT5Q8-000Mrm-1h;
	Sat, 21 Jun 2025 21:06:40 +0000
Date: Sun, 22 Jun 2025 05:06:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com, sdf@fomichev.me, jdamato@fastly.com,
	ecree.xilinx@gmail.com, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 6/9] net: ethtool: rss: add notifications
Message-ID: <202506220435.3mOsIoqI-lkp@intel.com>
References: <20250621171944.2619249-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621171944.2619249-7-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/netlink-specs-add-the-multicast-group-name-to-spec/20250622-012137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250621171944.2619249-7-kuba%40kernel.org
patch subject: [PATCH net-next 6/9] net: ethtool: rss: add notifications
config: i386-buildonly-randconfig-004-20250622 (https://download.01.org/0day-ci/archive/20250622/202506220435.3mOsIoqI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250622/202506220435.3mOsIoqI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506220435.3mOsIoqI-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/ethtool/ioctl.o: in function `ethtool_set_rxfh':
>> ioctl.c:(.text+0x6ede): undefined reference to `ethtool_rss_notify'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

