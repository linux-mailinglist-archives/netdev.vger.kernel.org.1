Return-Path: <netdev+bounces-238216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B852C56113
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 003D534FDA1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9280326D77;
	Thu, 13 Nov 2025 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWBe60xv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897130E83A;
	Thu, 13 Nov 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019056; cv=none; b=OKn59Xlz6aV57aI5Sgt+TXltLrYV4/7R6XCKN8M2SHJ90CPwRQk4EZGYdne8mBalDg8GBBvEI6budDX5jxYuGCqVbFp9rnLZwDitydH0RSoo4TF4PgH5ciBKuC5gmhM5P9h2A9gN4rfiQEe/3rmkus3B1DHeDc9iszb9honIC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019056; c=relaxed/simple;
	bh=GzIg5amColquUoTMfwOgoFFIoLUisEfS5Vm7rZSUjWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY9pZOOJCQZ9Ir1nGjI9mLmbiClNFP94fHT7cwsJKTECDBCexsyuot8vidALWnyIXErWVuehxEErBxeUFUg9ujpZ+IP76inaTH1SqM6WOsaXuoR+5qDQylBmwQrpO8UT7/TLVB6YnR9AKlxjdJAIUM/sloqqSNMcjNFtMa8C/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWBe60xv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763019046; x=1794555046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GzIg5amColquUoTMfwOgoFFIoLUisEfS5Vm7rZSUjWo=;
  b=RWBe60xvmdSDxfVHY+Gj5WU8lc5hyAGXDVePvx0ZTxU4Wa9PlJGdjHLq
   KomZleZq9rqALNrJbrOAMq1ZME60RFFUf+9kjvRUKaO9s855mRui3/1it
   +4PDpUGLebRaG+hH33i8aWNAz/4zKQ1AHMwIGuTF3TWF+zNWJDbhFphJT
   g3AnA4+IP3mwyaWq3RE6UM0yu5CZzIgibaMVlCeqKhSe04NhdRmxfy9Ji
   nk7y8zH0l0Opu1RAQkwFeW5gGnIGElzCZzszN1faum4aBYF9ajq+qvgt7
   53aKbltuJ9ajYAvSmkS7P+5Lh62OPlmwvRByjXcPiC6dUd5IlF/KMW4ye
   Q==;
X-CSE-ConnectionGUID: DWg9Gz8NQyOqbVDvtSWWGA==
X-CSE-MsgGUID: waPdV/KZReyOpgHO/4oOJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76437988"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="76437988"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 23:30:39 -0800
X-CSE-ConnectionGUID: WW3GQ4FnQOugtCfe4hw6Zg==
X-CSE-MsgGUID: d7e/EL1MQNSVnXMXiUQEFQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2025 23:30:36 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJRms-00051f-0B;
	Thu, 13 Nov 2025 07:30:34 +0000
Date: Thu, 13 Nov 2025 15:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: Re: [net-next 06/12] bng_en: Add support to handle AGG events
Message-ID: <202511131515.DHkaAel4-lkp@intel.com>
References: <20251111205829.97579-7-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111205829.97579-7-bhargava.marreddy@broadcom.com>

Hi Bhargava,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhargava-Marreddy/bng_en-Query-PHY-and-report-link-status/20251112-050616
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251111205829.97579-7-bhargava.marreddy%40broadcom.com
patch subject: [net-next 06/12] bng_en: Add support to handle AGG events
config: arc-randconfig-r122-20251113 (https://download.01.org/0day-ci/archive/20251113/202511131515.DHkaAel4-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251113/202511131515.DHkaAel4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511131515.DHkaAel4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/broadcom/bnge/bnge_txrx.c:931:11: sparse: sparse: symbol 'bnge_lhint_arr' was not declared. Should it be static?
   drivers/net/ethernet/broadcom/bnge/bnge_txrx.c: note: in included file (through drivers/net/ethernet/broadcom/bnge/bnge_resc.h, drivers/net/ethernet/broadcom/bnge/bnge.h):
>> drivers/net/ethernet/broadcom/bnge/bnge_netdev.h:524:34: sparse: sparse: marked inline, but without a definition

vim +524 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h

   515	
   516	u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
   517	u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr);
   518	void bnge_fill_hw_rss_tbl(struct bnge_net *bn, struct bnge_vnic_info *vnic);
   519	int bnge_alloc_rx_data(struct bnge_net *bn, struct bnge_rx_ring_info *rxr,
   520			       u16 prod, gfp_t gfp);
   521	inline int bnge_alloc_rx_page(struct bnge_net *bn,
   522				      struct bnge_rx_ring_info *rxr,
   523				      u16 prod, gfp_t gfp);
 > 524	inline u16 bnge_find_next_agg_idx(struct bnge_rx_ring_info *rxr, u16 idx);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

