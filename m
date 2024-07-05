Return-Path: <netdev+bounces-109326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283EC927F67
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ADC28530D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 00:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56DA8F5C;
	Fri,  5 Jul 2024 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9ccfED7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C632579
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720139743; cv=none; b=X83Lcu7NwlKwvnLUm6Dc8O7444oL8vq3dj90h6l+mAElpJlCqeqyk9sKoEijqde9+rDvN7hXpv9um91zdd4jyt+niKVsG5uZTqfWkAB7Kd3GQO0w4i53LZinv7A+S55KEfgSl1K2TQbYNrDMMYrA20IwSFtAMWud8e/5jk3UF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720139743; c=relaxed/simple;
	bh=ESRu75PZfHTwhmWAMpJ3Cd8UDiHk4XIG90Zs4ZpZJhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLzNK/CsputkUwwm3kjhldgUhCv/YCGJ8m+D2cikXkTQ/z4U7oFwpA3GgQBrrYuIs/TTBbVnbzT0sm+glztZJ3bHTlcXdYbwi42ce3V5XF9UCIrKwmPreBdQGZWf2YlQK0ZnnKkVSxMYZWsaxelPkrhHXrAk8Us8b3Ka8v5PiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9ccfED7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720139743; x=1751675743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESRu75PZfHTwhmWAMpJ3Cd8UDiHk4XIG90Zs4ZpZJhE=;
  b=X9ccfED79RcWsiGgFgLS4YYbC2mQvDwvVX9HyPrVElhcoXs4abrZtYi4
   EOe3Q2YlQ2BtUhNtm835+yjmw5lKlIjX8lkyxrXHMdmhnLIBB6wNK2Puk
   VjrzNrnyUaU/AJkz3h0Vrvi3HInfhaPxC0lE1XS5pmgZ/1A055Tc6fk/7
   1LTzKWt17SMnF0DEv+56+PsjGZfSaXXLf8MP30miOHGDQvdkB1fJDUdRu
   6wfuazOCltWV/5POtj0BwwfifmAkAGoGctpKaHDGsWKE0xN9YqqbBspdK
   MIa/JbFg108yIesTQo+vsaeNNFN53+/4zKT/+syAtxRqawym/KTgtuzA0
   A==;
X-CSE-ConnectionGUID: GuQ+rmeMTEmm0hZnsuMRyw==
X-CSE-MsgGUID: tssp8Q5pSReR9O62oQkAFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28823105"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="28823105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 17:35:39 -0700
X-CSE-ConnectionGUID: kmymRiqhRJyyimou4yQGWA==
X-CSE-MsgGUID: U3iAhdboR9eUDuHwSb5PpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77867361"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2024 17:35:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPWvG-000RhI-2r;
	Fri, 05 Jul 2024 00:35:34 +0000
Date: Fri, 5 Jul 2024 08:34:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
	michael.chan@broadcom.com, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to
 .create_rxfh_context and friends
Message-ID: <202407050831.3SjQAiZw-lkp@intel.com>
References: <20240702234757.4188344-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702234757.4188344-6-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/net-ethtool-let-drivers-remove-lost-RSS-contexts/20240703-163816
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240702234757.4188344-6-kuba%40kernel.org
patch subject: [PATCH net-next 04/11] eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
config: csky-randconfig-r063-20240704 (https://download.01.org/0day-ci/archive/20240705/202407050831.3SjQAiZw-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407050831.3SjQAiZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407050831.3SjQAiZw-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/net/ethernet/broadcom/bnxt/bnxt.o: in function `__bnxt_open_nic':
>> bnxt.c:(.text+0x11e32): undefined reference to `ethtool_rxfh_context_lost'
>> csky-linux-ld: bnxt.c:(.text+0x11f0c): undefined reference to `ethtool_rxfh_context_lost'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

