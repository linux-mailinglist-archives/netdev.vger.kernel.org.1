Return-Path: <netdev+bounces-144623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D359C7F21
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD45B21B06
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EC5163;
	Thu, 14 Nov 2024 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2VBO5gO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18502A32
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 00:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542760; cv=none; b=cs6oa+y6yIh46OwAlfgs41B28BwDZZ4HmobEd8DpIl3sgnRwNDeXIDeFEA8hq9XEk5IqqbkQT15Mf6EwTSMfzcItPtMT6w5B+s05Xj0nCAtHQnk4PBTa4Fs2mejjpuPn1Ilmv9aP+tFLEf7Xhi0jvt72S/xfojXKCmjD/5xTC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542760; c=relaxed/simple;
	bh=s+n9agMRQodyDQHFb11MsBM/v53EXdmTWLA7SKsDftw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO7QWpIFvsqSYz60S6gcbWRwGRH/JxKhYwlgNZXV5h+8GeWGWwnBKL9/q5gNQKYCil+59wXaK1sTJwqKfOeZkXVlwol0/gP2rAIaZgJLNGKQoL+MSZL4L52QNYP0y4HH0s1H1pcHzNAXK0P0X7apFbgZhpff/t8t7FfmqsJkryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2VBO5gO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731542758; x=1763078758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+n9agMRQodyDQHFb11MsBM/v53EXdmTWLA7SKsDftw=;
  b=C2VBO5gO9dHn7lO+XkWv28u8Xh2i1SGcZ8qleW+ZwTw4zVlj6gEYkgzF
   0PAizb65pNgxtPNsEraocSmUNqBP91TRwaLajj2pimPXawOwLJMpWYjh6
   rLtrrkujFxHG7ie78Q5ZWxhkIPGUAG94vjv8a730HAKRSEmpKhZx7ly+Z
   rKzweKf2fnpelbX5DviLYRUxs759ooogCzEWaRgrfaFiiDxpgVkIzvn1r
   T0Q3wswM8Kzf5HWYQIj4h5L7+w0M8Tj8FAa1n35Ortib0OZ3UeNZbf4Ng
   dkW9tFYWyKkeci7QJoUFuITGpEaXW3DCDGHARymw2Bx5FMK9lGi3VZB5q
   Q==;
X-CSE-ConnectionGUID: 24ccF0zySn6TG+iyrEk+PQ==
X-CSE-MsgGUID: cEHb+7g7TpWvmBKi1PAyJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42073480"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="42073480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:05:57 -0800
X-CSE-ConnectionGUID: 6BkhJuwHRAm75yIsyW+3Xg==
X-CSE-MsgGUID: zNnfp3TiRKCsvPob4SOkEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="111341295"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 13 Nov 2024 16:05:54 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBNMt-0000uP-1w;
	Thu, 14 Nov 2024 00:05:51 +0000
Date: Thu, 14 Nov 2024 08:05:07 +0800
From: kernel test robot <lkp@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <202411140704.LBU1Zf9c-lkp@intel.com>
References: <20241113180034.714102-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113180034.714102-4-tariqt@nvidia.com>

Hi Tariq,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tariq-Toukan/net-mlx5-DR-expand-SWS-STE-callbacks-and-consolidate-common-structs/20241114-022031
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241113180034.714102-4-tariqt%40nvidia.com
patch subject: [PATCH net-next 3/8] devlink: Extend devlink rate API with traffic classes bandwidth management
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20241114/202411140704.LBU1Zf9c-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140704.LBU1Zf9c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140704.LBU1Zf9c-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/dsa.h:22,
                    from net/core/flow_dissector.c:9:
>> include/net/devlink.h:121:19: error: 'IEEE_8021QAZ_MAX_TCS' undeclared here (not in a function)
     121 |         u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
         |                   ^~~~~~~~~~~~~~~~~~~~


vim +/IEEE_8021QAZ_MAX_TCS +121 include/net/devlink.h

   100	
   101	struct devlink_rate {
   102		struct list_head list;
   103		enum devlink_rate_type type;
   104		struct devlink *devlink;
   105		void *priv;
   106		u64 tx_share;
   107		u64 tx_max;
   108	
   109		struct devlink_rate *parent;
   110		union {
   111			struct devlink_port *devlink_port;
   112			struct {
   113				char *name;
   114				refcount_t refcnt;
   115			};
   116		};
   117	
   118		u32 tx_priority;
   119		u32 tx_weight;
   120	
 > 121		u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
   122	};
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

