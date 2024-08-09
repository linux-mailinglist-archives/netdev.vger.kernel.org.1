Return-Path: <netdev+bounces-117274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72794D5F9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA641F228D4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45571142E7C;
	Fri,  9 Aug 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXCHqmx3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728423DE
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226755; cv=none; b=QaxZuHnEkODNDLx0n0ggJMWpq0yOYikJXtlcZv/7Srt/EqLt8HIHTdd0N+KPq4tvd69/BmTnlMAlrOKXDSsiWsGOf00k2m01AmE94S5pyrANJ5hySdcS+O1EGcDkYVx4VAlCDeebYbzsY0rYo6FH1DSfJq3ypbwue8V5D9aPkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226755; c=relaxed/simple;
	bh=U+8p2XQWzOSn82RI3uPeiSNnth2GFIazQt1LDwJQW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI+zDJ9+po5MC7MVYNfFs70BDoXFuY46vjW/8mGssam4WIkRp7VmxbAAWfa20XYJQi+vtLNB636F6vF7aY1yFFiEFHHU8DV9MEmLeYglsu/P1SSp3hvbw0mHuR8mdOXUbZMm5fmHrQ9NaGqJuIP3pHE42at6fUqK4EMYjmqeej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXCHqmx3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723226753; x=1754762753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+8p2XQWzOSn82RI3uPeiSNnth2GFIazQt1LDwJQW5o=;
  b=iXCHqmx3GRVUd3uIL4muoNlByzAtYzF5CZE2rd+Wrx3DA0tLr2ysShkJ
   SDzsOhtbnEu81lvUeZuC8SWPuaImGWOpGjEdKq3EcDZaX7P2dI3uFL5J0
   5KmGKkP1/mJgGgJpdQxU6gpwxwoZylH0MUMXDpLnTFHUlrbxQnYI4Lr12
   V0TPfgHiRUmJ+WbcqgM1cn2VH/g/Ow7PE2WYsWNai+Q3SHV80bKlNLsNj
   SJgeiHyhKNCvoiTRttR+PFmMPrNIkisDXwEjtdSzrzRMPLUgKoE9Cn0JG
   ahs85D9lzZrpzpnc4FjCBcd5pWqYxK2grH3/6dcwdlwfwo92560UybiI6
   g==;
X-CSE-ConnectionGUID: K/Fqy3tRSZ2VmHZQn84jUA==
X-CSE-MsgGUID: kyZGRdbbQv29N2F5T7WJ2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="38861376"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="38861376"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 11:05:53 -0700
X-CSE-ConnectionGUID: +ne3HH0pTx6BCn4dNCYlzw==
X-CSE-MsgGUID: 2GM/PCVfRIWod0pwmC2hEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="61775340"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 09 Aug 2024 11:05:48 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scTzl-00099b-2t;
	Fri, 09 Aug 2024 18:05:45 +0000
Date: Sat, 10 Aug 2024 02:05:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, michael.chan@broadcom.com,
	shuah@kernel.org, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com, andrew@lunn.ch,
	willemb@google.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
	gal@nvidia.com, jdamato@fastly.com, donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>, marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk
Subject: Re: [PATCH net-next v4 02/12] eth: mvpp2: implement new RSS context
 API
Message-ID: <202408100156.UZVR13Wy-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240810/202408100156.UZVR13Wy-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408100156.UZVR13Wy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408100156.UZVR13Wy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5795:10: error: 'const struct ethtool_ops' has no member named 'rxfh_max_context_id'; did you mean 'rxfh_max_num_contexts'?
    5795 |         .rxfh_max_context_id    = MVPP22_N_RSS_TABLES,
         |          ^~~~~~~~~~~~~~~~~~~
         |          rxfh_max_num_contexts
   In file included from drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:42:
>> drivers/net/ethernet/marvell/mvpp2/mvpp2.h:859:41: warning: unsigned conversion from 'int' to 'unsigned char:1' changes value from '8' to '0' [-Woverflow]
     859 | #define MVPP22_N_RSS_TABLES             8
         |                                         ^
   drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5795:35: note: in expansion of macro 'MVPP22_N_RSS_TABLES'
    5795 |         .rxfh_max_context_id    = MVPP22_N_RSS_TABLES,
         |                                   ^~~~~~~~~~~~~~~~~~~


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

