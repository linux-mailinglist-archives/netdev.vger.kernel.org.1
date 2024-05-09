Return-Path: <netdev+bounces-95172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A578C19CD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B2E1C21A1C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1112212FF9F;
	Thu,  9 May 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJfe4iAy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4A12D74D;
	Thu,  9 May 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296238; cv=none; b=rfkS+AxnnwwaShroBIA6rcZF3Y4R49yeeotz7K09JrA2BXEkflSpBzvTW+P2iedb4Ncwtc2mTMDN5mSEkoSoRcPGy9KxdHfkPtk8sfdDcSK057/ZTbh/QOIBAd55f2bCfSgksGQGwUVgq6SGbbL3X9a3jsm9S8Q0Wp8XukyrrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296238; c=relaxed/simple;
	bh=iiYqaRLoWKNSifFPh2hXuPTM8AiJ9lhpKkeJ1QnZqJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou11PHY7AQ1QdyEmYhoyMATg7nsQtj8saxAzOW7atzmlDiJr3HIlCSMOf1Nem85IVVItrwy9D0bu2RmFMbBKIrDs0t4xc8UvO+snb7tbVgjamWNCr/mGYXQD5hh+nN/k1O4/sdasS+aYEfbSO+xFAyL2cqGqrqzQ3rwSeuvdsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJfe4iAy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715296235; x=1746832235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiYqaRLoWKNSifFPh2hXuPTM8AiJ9lhpKkeJ1QnZqJM=;
  b=QJfe4iAy+h16sUw4FueipAhlW4ZZpmoJZkLCoeOVfhk0VhO7RjwV/WEi
   DE/SgjYRTUJ5weDdsH0c7biwVY5pR26jLxn0X8xzQMYIbx5+MuQ0E1UeC
   VNiB/AvJKZcZzDwnT8vQOymn9QTxgeLLec+NP5jqHQGrwFxHme9RP+0uA
   sL9irbUgniSqMb37X+wAb3NOTlUarwOuKdqDEx4Nz7Iy9WLT8YNbR9Z1D
   T6rQXvIrhz39x4/VkOe2fDznChS38tnITKgqMWetZeGjWhSQAgI6R4Ot2
   tX0obXX8697KfEfksmaGOJNQS1vfkp51mlH+Nfk8SK+hpObTpHhYPmCfk
   Q==;
X-CSE-ConnectionGUID: MHBhHDiEThyUif9eQAJT2w==
X-CSE-MsgGUID: 0R5nSjUDTHiNY4uHPJzzMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22658912"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="22658912"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:10:35 -0700
X-CSE-ConnectionGUID: peb8aCUlSw+MT1IsNjA38g==
X-CSE-MsgGUID: j/6MzvdCQwandplxoHjdVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34192718"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 May 2024 16:10:28 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5CuA-0005Tl-0L;
	Thu, 09 May 2024 23:10:26 +0000
Date: Fri, 10 May 2024 07:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	donald.hunter@gmail.com
Subject: Re: [PATCH net-next v13 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202405100654.5PbLQXnL-lkp@intel.com>
References: <20240509044747.101237-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509044747.101237-3-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240509-125007
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240509044747.101237-3-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v13 2/4] ethtool: provide customized dim profile management
config: arm-randconfig-002-20240510 (https://download.01.org/0day-ci/archive/20240510/202405100654.5PbLQXnL-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240510/202405100654.5PbLQXnL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405100654.5PbLQXnL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: lockdep_rtnl_is_held
   >>> referenced by net_dim.c
   >>>               lib/dim/net_dim.o:(net_dim_free_irq_moder) in archive vmlinux.a
   >>> referenced by net_dim.c
   >>>               lib/dim/net_dim.o:(net_dim_free_irq_moder) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

