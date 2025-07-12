Return-Path: <netdev+bounces-206354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADFB02BC4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EC33BFC44
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910471F4262;
	Sat, 12 Jul 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cM8yVtXo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366815747D;
	Sat, 12 Jul 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752336064; cv=none; b=B9RBAtamnYKhsRISYABrN3LMHG7b7Mjt1NOsdh4ewGdVY2zrW3UpK1FXvJMZ9rf75ED1opDTxmCCIHszPSl3rToe6epxRVHIpDbHwPUyIr5qle6qVuf+E9/fBXTMzHfwBZRfBKoaQAb8NouzoXDDmJERnyiK72YdUdK2sAnlF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752336064; c=relaxed/simple;
	bh=IAsLt5gJX7GimfSXXigvqI3Hksp6cZ5+YGLB7ni1MM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZKGJi9i+0S6nXa8pFzRYC7yj2+YZcBOIqdq5qojwVxWxVYHQfVBtsU1qENRKhp5KyrRt9/QxZ6vt/jM7Vvb+fXVRkEV3LgOgLiiBd4Ey1++NKBYKmE7xEr4TIjjzcdr7a2ApaDOv32JgediZk6gwYJ8/zGBHmht6ojGtSzdyqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cM8yVtXo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752336061; x=1783872061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IAsLt5gJX7GimfSXXigvqI3Hksp6cZ5+YGLB7ni1MM8=;
  b=cM8yVtXo/e9Lsihnl/GVSfGWJ8aTyR1q3PGVfZxxnb74tMfLoGOiRJCs
   u582GI96NfKGXlUNRr5m9AD2CUFYcGmn8fWzALS62qGCa3cZzw8oUoVBy
   A2R5tEJ1MYepRwo2zhkyzUogtRQc6Z2ROthTh1WG79kaeEnmIqDhTDIhv
   dqdp87mobY1vjWeX6kTGiCX8qKlUOq9tBHn+DAbqOFFnnlZm+B9c+4qQP
   QRrR5j4iSEF/wbxhgdo/4zjKue5Hk8EjQyf1URaVSPRYa82JR+aUUBQgO
   qemhJVXKWelMA8uhnhZQ//5KWXWkSvFxjm1qsmrJGgXQsBB5z5Zeal/Aw
   g==;
X-CSE-ConnectionGUID: 52TAaQR5TOu38wby3o9GLQ==
X-CSE-MsgGUID: /+M8nkkBT0GtHySxOR1dnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77140612"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="77140612"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 09:01:00 -0700
X-CSE-ConnectionGUID: ipkAhyDGQkaPDg2NByqd5w==
X-CSE-MsgGUID: yzHMuttuTSSa3KuXEPSYxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="160897750"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2025 09:00:55 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uacej-0007Rn-0B;
	Sat, 12 Jul 2025 16:00:53 +0000
Date: Sun, 13 Jul 2025 00:00:26 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 03/12] ptp: netc: add PPS support
Message-ID: <202507122351.c9ut0TEq-lkp@intel.com>
References: <20250711065748.250159-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-4-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/dt-bindings-ptp-add-bindings-for-NETC-Timer/20250711-152311
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250711065748.250159-4-wei.fang%40nxp.com
patch subject: [PATCH net-next 03/12] ptp: netc: add PPS support
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250712/202507122351.c9ut0TEq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250712/202507122351.c9ut0TEq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507122351.c9ut0TEq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ptp_clock_event
   >>> referenced by ptp_netc.c
   >>>               drivers/ptp/ptp_netc.o:(netc_timer_isr) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

