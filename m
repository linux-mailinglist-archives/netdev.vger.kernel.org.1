Return-Path: <netdev+bounces-190969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B2AB98E8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761A7171E06
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3A0230D0D;
	Fri, 16 May 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lm/ba+Fa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B9230D01
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387948; cv=none; b=TKUXYlSmr/a9uRNm7xchL5tvLOLiI61u33QndvYnVIZsGLw9QCjoYBjVYkeKBKl3VGUmSXBdVMkUty5+b99H69pdN750g1pqghmVfBxPvvAXjcq82sEQi49YFBsS0ni9RQgRi5M/NY2Br4JC3C+GO65SqLxyQFqjbJVciLPrKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387948; c=relaxed/simple;
	bh=Bq93ZRkwfbKb+bfr4gy6lr3T9Y2SIheBEM/PcIPkYoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYiy2tVBEP7b0DLB0G43QpiMVxECgsOLnv72n0yOTynr86VG+cei1UQryCZVTWQOh2FG1NG86JNj/x7gT8ldariVfMtf0JgKq+lR7cgmD5+bN4MP6wt6fTb8UqUCVUDtJY30K67tsNCwn6YUBPHQ1uvKauVdLl4nmVIy5E+Pjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lm/ba+Fa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747387947; x=1778923947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bq93ZRkwfbKb+bfr4gy6lr3T9Y2SIheBEM/PcIPkYoc=;
  b=lm/ba+FazGCm5SQb/QoFikCWxeM0bXbPhmrobjN2p0D1vR5qVN9GvbIe
   hG/8p158lM1DD6n/q5fpW/Z8I8b/hk/mAciUlYLUfAD6aRqCnPycU9lSR
   rRTPv7+Y8MXnFK8H8W9kdT4Jty2TjXGJxf8rwoeDbyKSuVx0DhVWvpRN/
   MRBFC/Sdt+PVBBn6mTzVaXEitLecpsLCqu2IGEjfCS846mB/XAlHCmviS
   IzvvEkhDrywZr9XUFTl0wLkTzMNPZXUtZaX6SGfIc0CeePljnYRJf8iF0
   q5bLPHkJ15TIOQhIszYyYE0ZXT/hxNOMewTUPFMQ8IXOy+tFiB7xsBICq
   w==;
X-CSE-ConnectionGUID: Tql7mYSoTmWtfDg28UocFQ==
X-CSE-MsgGUID: kzIof6OhROOYCPHQX2Z5zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66757849"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="66757849"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:32:26 -0700
X-CSE-ConnectionGUID: Gfpp87wxRhiOD2H06y8eug==
X-CSE-MsgGUID: pPvL/h0nQ0e7X+wJSj1vHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="169695633"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 02:32:23 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFrQT-000JBb-27;
	Fri, 16 May 2025 09:32:21 +0000
Date: Fri, 16 May 2025 17:31:50 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: make mdio consumer / device layer a
 separate module
Message-ID: <202505161753.e2B0R1Th-lkp@intel.com>
References: <9a284c3d-73d4-402c-86ba-c82aabe9c44e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a284c3d-73d4-402c-86ba-c82aabe9c44e@gmail.com>

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/net-phy-make-mdio-consumer-device-layer-a-separate-module/20250515-134852
base:   net-next/main
patch link:    https://lore.kernel.org/r/9a284c3d-73d4-402c-86ba-c82aabe9c44e%40gmail.com
patch subject: [PATCH net-next] net: phy: make mdio consumer / device layer a separate module
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250516/202505161753.e2B0R1Th-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250516/202505161753.e2B0R1Th-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505161753.e2B0R1Th-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mdio_device_bus_match" [drivers/net/phy/libphy.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

