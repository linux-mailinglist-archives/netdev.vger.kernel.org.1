Return-Path: <netdev+bounces-117288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59194D7B5
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26401C22A0F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D415F404;
	Fri,  9 Aug 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W5cMk9Zj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24815FCEA
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232883; cv=none; b=LbF72oiYqTgSh6vZmX3ytUkRH38h3ZWSJnz1NCZb7xEKqNHff/7zpSYgQHCfFIS5YVqQQUMi3T/6caXIRu6R9hiSjbkpy6htOjKAqSGmi6v/VuYJCH76DGyyTCQNYN2imKzMYNXJ3zyw007BeZh6nub3kDS1nUXydDugsknqk20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232883; c=relaxed/simple;
	bh=8wSPGIdZxnwTfHD/Au7V+yBg8545cUj6lTBDlq9Zepw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBmcOiTYBRTiiViEERe47vIRvRxIFJojS5nHw/irTGHwI5bZH3F1YvmimNO7ekj8lmatQwEB+oRbpB8Zmx15w6c4+joX8fMOLfTPhNXT7ereOQSMfYy7Kze5Jf7vbvZpLsutlkyZhw2J005VGPw+mdcTL9q01isZehqJiGQ3nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W5cMk9Zj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723232882; x=1754768882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wSPGIdZxnwTfHD/Au7V+yBg8545cUj6lTBDlq9Zepw=;
  b=W5cMk9Zj5wWX0sWtlFNHIfNCK87nt+ZOgCb3yp2LnYNU/mTJ+ymialhW
   X4K+dHR/9GC1eZV2W4XJE+JS3tAULV3lhxbwLP7/zWB/j+JTc/mgMhJ63
   VTJFdy6GW1f7ZdrqChF6aX1LBnlDuaja/EZnHPudN1L6OPcKz3OFHKG3m
   xYJDazCslV6L2i67C0fLHAGPgOlJsZJy8zkhpTl9l+YTwos4xdBm+QNgN
   qW7fkSQER4ep6cEDE4zir0YH9kkJsBrnTfRJ1PwwtGebIoHZVp9s36vJ1
   NIE4BD0CuRNoJ3AcLtRHDx5cRLrc7MHflfcB2gw9GYr83/iGl97EtRSZt
   A==;
X-CSE-ConnectionGUID: 7wl4F3qNTSSumkxibv5AWQ==
X-CSE-MsgGUID: gt173dp3QVSaPS+vNx+OvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32570240"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32570240"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:48:01 -0700
X-CSE-ConnectionGUID: QklwtgzuTPm4cwq3Ex1yIg==
X-CSE-MsgGUID: nqho/MP/TcKiUJSTHtmv1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57571381"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 09 Aug 2024 12:47:55 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scVab-0009DZ-0k;
	Fri, 09 Aug 2024 19:47:53 +0000
Date: Sat, 10 Aug 2024 03:47:22 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	michael.chan@broadcom.com, shuah@kernel.org, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, andrew@lunn.ch,
	willemb@google.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
	gal@nvidia.com, jdamato@fastly.com, donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>, marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk
Subject: Re: [PATCH net-next v4 02/12] eth: mvpp2: implement new RSS context
 API
Message-ID: <202408100303.d5TA9nQp-lkp@intel.com>
References: <20240809031827.2373341-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809031827.2373341-3-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/selftests-drv-net-rss_ctx-add-identifier-to-traffic-comments/20240809-143446
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240809031827.2373341-3-kuba%40kernel.org
patch subject: [PATCH net-next v4 02/12] eth: mvpp2: implement new RSS context API
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240810/202408100303.d5TA9nQp-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100303.d5TA9nQp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100303.d5TA9nQp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5795:3: error: field designator 'rxfh_max_context_id' does not refer to any field in type 'const struct ethtool_ops'
    5795 |         .rxfh_max_context_id    = MVPP22_N_RSS_TABLES,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +5795 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c

  5792	
  5793	static const struct ethtool_ops mvpp2_eth_tool_ops = {
  5794		.cap_rss_ctx_supported	= true,
> 5795		.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,
  5796		.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
  5797					     ETHTOOL_COALESCE_MAX_FRAMES,
  5798		.nway_reset		= mvpp2_ethtool_nway_reset,
  5799		.get_link		= ethtool_op_get_link,
  5800		.get_ts_info		= mvpp2_ethtool_get_ts_info,
  5801		.set_coalesce		= mvpp2_ethtool_set_coalesce,
  5802		.get_coalesce		= mvpp2_ethtool_get_coalesce,
  5803		.get_drvinfo		= mvpp2_ethtool_get_drvinfo,
  5804		.get_ringparam		= mvpp2_ethtool_get_ringparam,
  5805		.set_ringparam		= mvpp2_ethtool_set_ringparam,
  5806		.get_strings		= mvpp2_ethtool_get_strings,
  5807		.get_ethtool_stats	= mvpp2_ethtool_get_stats,
  5808		.get_sset_count		= mvpp2_ethtool_get_sset_count,
  5809		.get_pauseparam		= mvpp2_ethtool_get_pause_param,
  5810		.set_pauseparam		= mvpp2_ethtool_set_pause_param,
  5811		.get_link_ksettings	= mvpp2_ethtool_get_link_ksettings,
  5812		.set_link_ksettings	= mvpp2_ethtool_set_link_ksettings,
  5813		.get_rxnfc		= mvpp2_ethtool_get_rxnfc,
  5814		.set_rxnfc		= mvpp2_ethtool_set_rxnfc,
  5815		.get_rxfh_indir_size	= mvpp2_ethtool_get_rxfh_indir_size,
  5816		.get_rxfh		= mvpp2_ethtool_get_rxfh,
  5817		.set_rxfh		= mvpp2_ethtool_set_rxfh,
  5818		.create_rxfh_context	= mvpp2_create_rxfh_context,
  5819		.modify_rxfh_context	= mvpp2_modify_rxfh_context,
  5820		.remove_rxfh_context	= mvpp2_remove_rxfh_context,
  5821	};
  5822	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

