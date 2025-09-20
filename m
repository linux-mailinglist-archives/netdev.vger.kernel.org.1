Return-Path: <netdev+bounces-224990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97BB8C828
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 14:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A803A61FF
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 12:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416AE2FFF8B;
	Sat, 20 Sep 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThWImpI1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8C2F8BDC
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371218; cv=none; b=aE1vAdO/ZitH4ki1n4HkT9XBFC35+CDM4x2fmLoQMkWpqgvaXA5TcaiJKlK86pJ0X+FAqSWqkZtkR6Z701ZB7AATIwdqMbDipPP/Ol1k0GY5JZVVmNDT/cR2Sa69HfJjXWxW1yNK7bk9HP26nxf92cRUatCZeE/iLAWvW2PduqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371218; c=relaxed/simple;
	bh=0uCuJCa0DIvL7b1TzTkyiorVUTTZkJJNmHbnezsu2Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK5SsyBu9OzfHEnR2hznfcntP4uXPEnCe3WVfnwiIWeuOxKVXylopYLebfIfdWYz5v+GoaZfiEH7jtcrTvjBiw/ONd1MIL/N5UVdubo4JR1laNyErFs1/Loof5VC8jBGnrwoVEvFzDRK297pdD+aV0UKJQKOdzL26MJRjQYfSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThWImpI1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758371216; x=1789907216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uCuJCa0DIvL7b1TzTkyiorVUTTZkJJNmHbnezsu2Pg=;
  b=ThWImpI1JcYfbGO4u0MAdRV6LWS0tmeJYDduEHilzu3tJeo+MrIL8sEu
   iJO9DONO0Fq/5yDc1Po241YA4JbmOgNXY/+4mxoN/L3wOvGVkLbHuXzpB
   hFI7B9EADZzFWpqfJtp7kjDoTFEHgDtzcTh0rNUiPcPMhFd++ztOcDbNv
   DljSR2wsz70lRQdBlU0htSlrU9AxUBA6EtC8VZ349xdCnyCeB8nkmr24f
   qYjSjndVFF3nbVOljzhOoUhfEZkkq6IdePB6o8V+wofA4xpZZ45YjxlHh
   3JJa5Vj7arq44ckyGeJs+BCRvwK6yhnqFzK4qdCa7H0coS9DPuiyRlLY+
   Q==;
X-CSE-ConnectionGUID: neuU+dWdQKOTb2H5PtshLg==
X-CSE-MsgGUID: H6TV7pQYRNiEXaGhBNTY3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="71325394"
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="71325394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2025 05:26:55 -0700
X-CSE-ConnectionGUID: oeUwm1cUSmatUCtaLXJsLA==
X-CSE-MsgGUID: m5Ydmo0IRZetgs2TRDPCTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,280,1751266800"; 
   d="scan'208";a="175977382"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Sep 2025 05:26:54 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzwg0-0005K7-18;
	Sat, 20 Sep 2025 12:26:52 +0000
Date: Sat, 20 Sep 2025 20:26:48 +0800
From: kernel test robot <lkp@intel.com>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	arkadiusz.kubalewski@intel.com
Subject: Re: [Intel-wired-lan] [RESEND PATCH v2 iwl-next] ice: add TS PLL
 control for E825 devices
Message-ID: <202509202023.HY9L56JJ-lkp@intel.com>
References: <20250919165925.1685446-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919165925.1685446-1-grzegorz.nitka@intel.com>

Hi Grzegorz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ff9f8329f189c17549f3fbb5058505fb3e46dd99]

url:    https://github.com/intel-lab-lkp/linux/commits/Grzegorz-Nitka/ice-add-TS-PLL-control-for-E825-devices/20250920-010351
base:   ff9f8329f189c17549f3fbb5058505fb3e46dd99
patch link:    https://lore.kernel.org/r/20250919165925.1685446-1-grzegorz.nitka%40intel.com
patch subject: [Intel-wired-lan] [RESEND PATCH v2 iwl-next] ice: add TS PLL control for E825 devices
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250920/202509202023.HY9L56JJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509202023.HY9L56JJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509202023.HY9L56JJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/intel/ice/ice_tspll.c:688 function parameter 'pf' not described in 'ice_tspll_set_cfg'
--
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:73 Enum value 'ICE_DPLL_PIN_TYPE_INPUT_E825' not described in enum 'ice_dpll_pin_type'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:73 Enum value 'ICE_DPLL_PIN_TYPE_OUTPUT_E825' not described in enum 'ice_dpll_pin_type'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:73 Enum value 'ICE_DPLL_PIN_TYPE_INPUT_TSPLL_E825' not described in enum 'ice_dpll_pin_type'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:73 Enum value 'ICE_DPLL_PIN_TYPE_OUTPUT_TSPLL_E825' not described in enum 'ice_dpll_pin_type'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:694 function parameter 'pf' not described in 'ice_dpll_input_tspll_update_e825c'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

