Return-Path: <netdev+bounces-216306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169CB3303D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3601207C67
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC32D97A6;
	Sun, 24 Aug 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0AdDhPw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E519D087;
	Sun, 24 Aug 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043735; cv=none; b=tmzKy6VyjtPp6C3NKy0t+Lsb7XPcp8cTVDsna9kmo3BHBy9XwwihXGg2D7ido8B34R6uDnR5v1r2YfIAWLt+QIv7IJzNUE5nJaPxF0a8uE3f2vW+5c0P1r1AGpsb7ryD7V/eh6gFgxbSOJlewkEA+DRRpnFTtqC/0axu21aIR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043735; c=relaxed/simple;
	bh=tRR9MyECgQnxIAhwjUJDzfOTWJ0KYyOEo9ZLiAihSC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdCacz0nkhCEcI3NVEkosrFwqc0BiDJfjI+Khzm4+8Lth5XhcBvAw0OihrCr3lk88TW53L8SfIJAnp0aiWD7bFw2l3r2JLydypf6Cty1Xfo0wL5LAfkUvbmzokkiVnKSy7uNKZZ9splS88iqOKVbL1CoctIbrXDd+UrAhoKadW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0AdDhPw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756043733; x=1787579733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRR9MyECgQnxIAhwjUJDzfOTWJ0KYyOEo9ZLiAihSC8=;
  b=U0AdDhPwgpgqs4MqdQmNGR23z4aNV8V6xwtkD1QZ6zEUfaJfD/nZGi+S
   q1z8dyusnLoI7zbZZOVbe1PWthTWhR2QzGz3/8oOWVoamVb+keEXLcT/N
   fibhYWMbwbktP4cofWQXPJlmXVSA1ut2jJER0P11PmDkrqgDww6uiIgyK
   gGToJ9W23IMoyPocJ+1mmMbyUqQtq/diym9cwjHxPdZYweBHVoB/UDgg7
   D+ckkXFmCsyaFzz4/Pn282xQMOh69IqEIvcTZBZqawu+/EVVevgalQZP/
   aLMBHkn/zdU3TgE2oreVNXgBncnkIvTWbdPFe4SCoISWVZmw7/2v/0plY
   w==;
X-CSE-ConnectionGUID: T5MKq5FJTHmnYb0ynNh0oA==
X-CSE-MsgGUID: NJwdfpa5RsCIz+ZMW2WAYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58194674"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58194674"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 06:55:33 -0700
X-CSE-ConnectionGUID: lZS25PmNS0mlzOzvmF41nA==
X-CSE-MsgGUID: 1dU9X9LgQGWtYRIZwKMHyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="199978241"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 24 Aug 2025 06:55:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uqBBv-000N0l-1T;
	Sun, 24 Aug 2025 13:55:27 +0000
Date: Sun, 24 Aug 2025 21:54:43 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Alexei Lazar <alazar@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH net 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
Message-ID: <202508242120.QljNCAgz-lkp@intel.com>
References: <20250824083944.523858-10-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824083944.523858-10-mbloch@nvidia.com>

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-Bloch/net-mlx5-HWS-Fix-memory-leak-in-hws_pool_buddy_init-error-path/20250824-164938
base:   ec79003c5f9d2c7f9576fc69b8dbda80305cbe3a
patch link:    https://lore.kernel.org/r/20250824083944.523858-10-mbloch%40nvidia.com
patch subject: [PATCH net 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
config: um-randconfig-002-20250824 (https://download.01.org/0day-ci/archive/20250824/202508242120.QljNCAgz-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d26ea02060b1c9db751d188b2edb0059a9eb273d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508242120.QljNCAgz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508242120.QljNCAgz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlx5/core/en_main.c:34:
   In file included from include/net/tc_act/tc_gact.h:5:
   In file included from include/net/act_api.h:10:
   In file included from include/net/flow_offload.h:6:
   In file included from include/linux/netlink.h:7:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/mellanox/mlx5/core/en_main.c:52:
>> drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h:79:12: warning: declaration of 'struct ieee_pfc' will not be visible outside of this function [-Wvisibility]
      79 |                                 struct ieee_pfc *pfc,
         |                                        ^
   2 warnings generated.


vim +79 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h

    68	
    69	#ifdef CONFIG_MLX5_CORE_EN_DCB
    70	int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
    71					    u32 change, unsigned int mtu,
    72					    struct ieee_pfc *pfc,
    73					    u32 *buffer_size,
    74					    u8 *prio2buffer);
    75	#else
    76	static inline int
    77	mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
    78					u32 change, unsigned int mtu,
  > 79					struct ieee_pfc *pfc,
    80					u32 *buffer_size,
    81					u8 *prio2buffer)
    82	{
    83		return 0;
    84	}
    85	#endif
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

