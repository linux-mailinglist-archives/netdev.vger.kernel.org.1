Return-Path: <netdev+bounces-221867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACBB522F9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20BF583A11
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBB307AEA;
	Wed, 10 Sep 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG+6dqf1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A408306480
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537348; cv=none; b=jTMvCl7oXgF9SSpvXCz87X6weSmdj9W+JLKAH8LfwtkJTv+T2bsHFxPrS0v1YL2Z9DQ9lIcmsBXQHIfnWLe0XbpndvQIw1vHWZepdBf4vvPblG4l/i8/6VfJEYHftCubKs05YFrrJrjmjB/dsPOMRs6dGGvvQ4ZRaGXUI62UMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537348; c=relaxed/simple;
	bh=WtcGnhGSlqX1dPRofkZYf6H49sJDwaITH4VnJPQAxlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2dffnZPRasFS3h8z3PyeopoYMzwbLkpQbq9ZzjBPvqLlEFVIihoWZs3PceqscE2Ptsvw1HHbhvbEShxzOyxRMEuOSAFSEAIBWx6YDEL80M1rRRoH06paIzDKgxMJX2k4JUPrF2CCsOPAIbdM8AeAZB/O7S12+XSi6C28w3jTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG+6dqf1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757537346; x=1789073346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtcGnhGSlqX1dPRofkZYf6H49sJDwaITH4VnJPQAxlY=;
  b=cG+6dqf1W8BNn+UMZ9yR4OXm40GTfTP0RDIW++DET8EwdOccFdu/6rw4
   htwrjAvFZOntzRptmn/YSbBy7IUxNU9ZlusfafLeCn72qqm6+64JcLH3o
   6sVIG54cqap2vLp097HWTIoIz20iMmC94BIYN221lMizo9naUJiFTMzFA
   tabfIFZ7Csrfhpqq2STPQ3f+XIDwrm4pEwfBckeX2fHIlSJzSkfHNuvq5
   ienmGNRqgDQFgsXapl4qkrNf/0j9IYH+ipatuUNfvuJ87+PTEDPZAvRax
   hwVMtrTJwddwQinpUPP53TnOCvwgg0eScc2qLg9dcuY4I7xh+0LKhqvJ5
   g==;
X-CSE-ConnectionGUID: nO0hnguzSPOd8ZNTer8msg==
X-CSE-MsgGUID: 8YFdBt1kS2WFBzvfntr+9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59807502"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59807502"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 13:49:05 -0700
X-CSE-ConnectionGUID: 8g6kfFo3QeKOlWx6LJzulQ==
X-CSE-MsgGUID: JuRMgH9WTI6tqmwLpGnPFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="173573317"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Sep 2025 13:49:02 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwRkS-0006HD-03;
	Wed, 10 Sep 2025 20:49:00 +0000
Date: Thu, 11 Sep 2025 04:48:44 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] ethtool: add FEC bins histogramm report
Message-ID: <202509110407.uPUiJk7j-lkp@intel.com>
References: <20250909184216.1524669-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909184216.1524669-2-vadim.fedorenko@linux.dev>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/ethtool-add-FEC-bins-histogramm-report/20250910-025057
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250909184216.1524669-2-vadim.fedorenko%40linux.dev
patch subject: [PATCH net-next 1/4] ethtool: add FEC bins histogramm report
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20250911/202509110407.uPUiJk7j-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110407.uPUiJk7j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110407.uPUiJk7j-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c:1842:43: error: initialization of 'void (*)(struct net_device *, struct ethtool_fec_stats *, struct ethtool_fec_hist *)' from incompatible pointer type 'void (*)(struct net_device *, struct ethtool_fec_stats *)' [-Wincompatible-pointer-types]
    1842 |         .get_fec_stats                  = fbnic_get_fec_stats,
         |                                           ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c:1842:43: note: (near initialization for 'fbnic_ethtool_ops.get_fec_stats')
   drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c:1661:1: note: 'fbnic_get_fec_stats' declared here
    1661 | fbnic_get_fec_stats(struct net_device *netdev,
         | ^~~~~~~~~~~~~~~~~~~


vim +1842 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c

6913e873e7b2e4 Mohsin Bashir   2025-06-10  1805  
bd2557a554a0d6 Mohsin Bashir   2024-09-02  1806  static const struct ethtool_ops fbnic_ethtool_ops = {
f7d4c21667cc1a Jakub Kicinski  2025-06-24  1807  	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS |
7b5b7a597fbc19 Mohsin Bashir   2025-02-17  1808  					  ETHTOOL_COALESCE_RX_MAX_FRAMES,
2b30fc01a6c788 Mohsin Bashir   2025-08-13  1809  	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
2b30fc01a6c788 Mohsin Bashir   2025-08-13  1810  					  ETHTOOL_RING_USE_HDS_THRS,
260676ebb1f3b1 Daniel Zahka    2025-02-06  1811  	.rxfh_max_num_contexts		= FBNIC_RPC_RSS_TBL_COUNT,
bd2557a554a0d6 Mohsin Bashir   2024-09-02  1812  	.get_drvinfo			= fbnic_get_drvinfo,
3d12862b216d39 Mohsin Bashir   2024-11-12  1813  	.get_regs_len			= fbnic_get_regs_len,
3d12862b216d39 Mohsin Bashir   2024-11-12  1814  	.get_regs			= fbnic_get_regs,
fb9a3bb7f7f23b Alexander Duyck 2025-06-18  1815  	.get_link			= ethtool_op_get_link,
7b5b7a597fbc19 Mohsin Bashir   2025-02-17  1816  	.get_coalesce			= fbnic_get_coalesce,
7b5b7a597fbc19 Mohsin Bashir   2025-02-17  1817  	.set_coalesce			= fbnic_set_coalesce,
6cbf18a05c0609 Jakub Kicinski  2025-03-06  1818  	.get_ringparam			= fbnic_get_ringparam,
6cbf18a05c0609 Jakub Kicinski  2025-03-06  1819  	.set_ringparam			= fbnic_set_ringparam,
e9faf4db5f2612 Mohsin Bashir   2025-08-25  1820  	.get_pause_stats		= fbnic_get_pause_stats,
eb4c27edb4d8db Alexander Duyck 2025-06-18  1821  	.get_pauseparam			= fbnic_phylink_get_pauseparam,
eb4c27edb4d8db Alexander Duyck 2025-06-18  1822  	.set_pauseparam			= fbnic_phylink_set_pauseparam,
79da2aaa08ee99 Sanman Pradhan  2024-11-14  1823  	.get_strings			= fbnic_get_strings,
79da2aaa08ee99 Sanman Pradhan  2024-11-14  1824  	.get_ethtool_stats		= fbnic_get_ethtool_stats,
79da2aaa08ee99 Sanman Pradhan  2024-11-14  1825  	.get_sset_count			= fbnic_get_sset_count,
7cb06a6a777cf5 Alexander Duyck 2024-12-19  1826  	.get_rxnfc			= fbnic_get_rxnfc,
c23a1461bfee0a Alexander Duyck 2024-12-19  1827  	.set_rxnfc			= fbnic_set_rxnfc,
7cb06a6a777cf5 Alexander Duyck 2024-12-19  1828  	.get_rxfh_key_size		= fbnic_get_rxfh_key_size,
7cb06a6a777cf5 Alexander Duyck 2024-12-19  1829  	.get_rxfh_indir_size		= fbnic_get_rxfh_indir_size,
7cb06a6a777cf5 Alexander Duyck 2024-12-19  1830  	.get_rxfh			= fbnic_get_rxfh,
31ab733e999edb Alexander Duyck 2024-12-19  1831  	.set_rxfh			= fbnic_set_rxfh,
2a34007ba9773e Jakub Kicinski  2025-06-11  1832  	.get_rxfh_fields		= fbnic_get_rss_hash_opts,
2a34007ba9773e Jakub Kicinski  2025-06-11  1833  	.set_rxfh_fields		= fbnic_set_rss_hash_opts,
260676ebb1f3b1 Daniel Zahka    2025-02-06  1834  	.create_rxfh_context		= fbnic_create_rxfh_context,
260676ebb1f3b1 Daniel Zahka    2025-02-06  1835  	.modify_rxfh_context		= fbnic_modify_rxfh_context,
260676ebb1f3b1 Daniel Zahka    2025-02-06  1836  	.remove_rxfh_context		= fbnic_remove_rxfh_context,
3a481cc72673b2 Jakub Kicinski  2024-12-19  1837  	.get_channels			= fbnic_get_channels,
3a481cc72673b2 Jakub Kicinski  2024-12-19  1838  	.set_channels			= fbnic_set_channels,
be65bfc957eb70 Vadim Fedorenko 2024-10-08  1839  	.get_ts_info			= fbnic_get_ts_info,
96f358f75d1a4e Vadim Fedorenko 2024-10-08  1840  	.get_ts_stats			= fbnic_get_ts_stats,
fb9a3bb7f7f23b Alexander Duyck 2025-06-18  1841  	.get_link_ksettings		= fbnic_phylink_ethtool_ksettings_get,
33c493791bc058 Mohsin Bashir   2025-08-25 @1842  	.get_fec_stats			= fbnic_get_fec_stats,
fb9a3bb7f7f23b Alexander Duyck 2025-06-18  1843  	.get_fecparam			= fbnic_phylink_get_fecparam,
33c493791bc058 Mohsin Bashir   2025-08-25  1844  	.get_eth_phy_stats		= fbnic_get_eth_phy_stats,
4eb7f20bcf0614 Mohsin Bashir   2024-09-02  1845  	.get_eth_mac_stats		= fbnic_get_eth_mac_stats,
6913e873e7b2e4 Mohsin Bashir   2025-06-10  1846  	.get_eth_ctrl_stats		= fbnic_get_eth_ctrl_stats,
6913e873e7b2e4 Mohsin Bashir   2025-06-10  1847  	.get_rmon_stats			= fbnic_get_rmon_stats,
bd2557a554a0d6 Mohsin Bashir   2024-09-02  1848  };
bd2557a554a0d6 Mohsin Bashir   2024-09-02  1849  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

