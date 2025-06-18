Return-Path: <netdev+bounces-199219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9FADF78F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C384C3BD535
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDE215077;
	Wed, 18 Jun 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmbqJwA5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F8C3085BA;
	Wed, 18 Jun 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277877; cv=none; b=L+8Pncrt7wQqX5xFfinDv/GLorZsffm/8aJvJINhNzKnBGnw+jydu85ixuhWAiYhBPU0wGCsnENfOAigdY7mWGRQErv9PG4hWBz5spDfs39rOgvI1CceTvGVUVVwQaUA+YlziCMJl5ELZFLxu8ph9UZ3u5CEXX+xR2UBMCBxrlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277877; c=relaxed/simple;
	bh=eIm31ulfxb/iodvSgzs4HeeUc/QBLhrVAgBlSL3l1Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSNGo5b3f0ONSmliDfszpTTSwxix9vQAulKcEbcGcj4fHwV25vjQ+RgM0gz8A9gxjIM2tUM/EF4SNgCEdd36qgXJJjK6AyuiQHEMnUP1hQYfwtWqz6YK2oWSxZEfSYz0Er2kolHSO/DCrN10dDnCE/sXa1jr6qyU0vMTRyz6cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmbqJwA5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750277876; x=1781813876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIm31ulfxb/iodvSgzs4HeeUc/QBLhrVAgBlSL3l1Y0=;
  b=BmbqJwA5Xc2BL8VzMl5jh73mRe63jQbzS4MxNwnif5FvRCYBZPOxyjrr
   Q5x3r6kAhOmUlQUxsMOnBGE218l+/H3mAjtEXfH3MqjeXBr8UQayCml0r
   shxU2pBczHwFKfFYMbDioYcoSeIdXz4mp/jEwPkmyaLOhGBeqvMZUyrIp
   4SfRLt3VNaiD+1iagNKEHavORKDfe3WYQSxyX+dSITbw+p5fsBXEn4M70
   NQ0Am+B80Oeiwec9T6Gag9sGxbWUQk05lC7pYzLAMtWcVXnLFv+ItHeTd
   Gz6QBnE5VkA6XQC1G5YUL7qQnpRB6r0K64c+ETkIB8eg2Idu3u+u6CBLn
   g==;
X-CSE-ConnectionGUID: 2f2Mg5mnRFiiP6Aeuzf0dQ==
X-CSE-MsgGUID: 6ba/qYFsQp+NcTDcwUQpCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52663565"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52663565"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 13:17:37 -0700
X-CSE-ConnectionGUID: vVtGXGxpSoiWUDzCKCU8FQ==
X-CSE-MsgGUID: w55BZNQfQ8WmNHo73rQ5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="154888280"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2025 13:17:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRzDt-000K8U-0T;
	Wed, 18 Jun 2025 20:17:29 +0000
Date: Thu, 19 Jun 2025 04:16:33 +0800
From: kernel test robot <lkp@intel.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next, 09/10] bng_en: Initialize default configuration
Message-ID: <202506190321.0HgmyniP-lkp@intel.com>
References: <20250618144743.843815-10-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618144743.843815-10-vikas.gupta@broadcom.com>

Hi Vikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc2 next-20250618]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bng_en-Add-PCI-interface/20250618-173130
base:   linus/master
patch link:    https://lore.kernel.org/r/20250618144743.843815-10-vikas.gupta%40broadcom.com
patch subject: [net-next, 09/10] bng_en: Initialize default configuration
config: i386-randconfig-012-20250619 (https://download.01.org/0day-ci/archive/20250619/202506190321.0HgmyniP-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506190321.0HgmyniP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506190321.0HgmyniP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnge/bnge_resc.c:533:15: warning: result of comparison of constant -19 with expression of type 'u16' (aka 'unsigned short') is always true [-Wtautological-constant-out-of-range-compare]
     533 |         if (rc && rc != -ENODEV)
         |                   ~~ ^  ~~~~~~~
   drivers/net/ethernet/broadcom/bnge/bnge_resc.c:542:16: warning: result of comparison of constant -19 with expression of type 'u16' (aka 'unsigned short') is always true [-Wtautological-constant-out-of-range-compare]
     542 |                 if (rc && rc != -ENODEV)
         |                           ~~ ^  ~~~~~~~
   2 warnings generated.


vim +533 drivers/net/ethernet/broadcom/bnge/bnge_resc.c

   511	
   512	static int bnge_net_init_dflt_rings(struct bnge_dev *bd, bool sh)
   513	{
   514		u16 dflt_rings, max_rx_rings, max_tx_rings, rc;
   515	
   516		if (sh)
   517			bd->flags |= BNGE_EN_SHARED_CHNL;
   518	
   519		dflt_rings = netif_get_num_default_rss_queues();
   520	
   521		rc = bnge_get_dflt_rings(bd, &max_rx_rings, &max_tx_rings, sh);
   522		if (rc)
   523			return rc;
   524		bd->rx_nr_rings = min_t(u16, dflt_rings, max_rx_rings);
   525		bd->tx_nr_rings_per_tc = min_t(u16, dflt_rings, max_tx_rings);
   526		if (sh)
   527			bnge_trim_dflt_sh_rings(bd);
   528		else
   529			bd->nq_nr_rings = bd->tx_nr_rings_per_tc + bd->rx_nr_rings;
   530		bd->tx_nr_rings = bd->tx_nr_rings_per_tc;
   531	
   532		rc = bnge_reserve_rings(bd);
 > 533		if (rc && rc != -ENODEV)
   534			dev_warn(bd->dev, "Unable to reserve tx rings\n");
   535		bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
   536		if (sh)
   537			bnge_trim_dflt_sh_rings(bd);
   538	
   539		/* Rings may have been reduced, re-reserve them again */
   540		if (bnge_need_reserve_rings(bd)) {
   541			rc = bnge_reserve_rings(bd);
   542			if (rc && rc != -ENODEV)
   543				dev_warn(bd->dev, "Fewer rings reservation failed\n");
   544			bd->tx_nr_rings_per_tc = bd->tx_nr_rings;
   545		}
   546		if (rc) {
   547			bd->tx_nr_rings = 0;
   548			bd->rx_nr_rings = 0;
   549		}
   550	
   551		return rc;
   552	}
   553	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

