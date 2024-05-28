Return-Path: <netdev+bounces-98715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2397F8D22BF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCA11F226D5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02179376E1;
	Tue, 28 May 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0c3Cjwx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D31B806
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716918340; cv=none; b=oDwbdzlT0GZjK1fiBdxbkmFlzc8/NlYx4MNYyOooKj7RhViBSYadDsniiGcN7qY0dR5+1dZK0TYy7PDKCKn64kPLTgsUwqWoq9ghI06QDhGef0HzYi4YL5+cn+ijg0WawSQNxItzB77N1ti8QdMxeRYKKZQNkccJEsSWhbwfMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716918340; c=relaxed/simple;
	bh=9vOcETVh+eilOe61R58LgMPUxUJOYEm8medA2diVors=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXyAhQNh3m+Rw101pCjOwfZyg8Oerv8xBsIjeDkHuEV2eEpc0Le2ZWBzxQvcNgOWBqkSC/fKZxvFd/kg4exY8xEb6ncNNTorM1PESHRAw6ZKlBFY86ZrPGllQ3gQXJrbsTD9o7EiaEWVGnyffoS/gioYZ+DLcoNwrn00bT5DpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0c3Cjwx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716918339; x=1748454339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vOcETVh+eilOe61R58LgMPUxUJOYEm8medA2diVors=;
  b=e0c3Cjwx3dEdFhUoFZQSHJqVzOR3vuybGYkzFhaBxOvdZ99RE4A0RNjV
   GR8zqSFXLN6zYpAsKlhNcr0lJgSZ4AMdpUBoniLpqzo/30ZzWc1Bfs+q7
   U7a3AODhlhN+GxQt8FIHad3LVlJob6ilvcfusiqC0j/fqfKVMbAijOTNp
   i4XsweBp/FAsc0ZkM1X9PNdALGrulcxyKn/9rwxYFUwm4QYoU9wrxlAIi
   FCEHW3ZBsdJ9x+mDnk/NSg5IczncHLjP3MEfbeEk+XHzv6rF3ZXfWl9jA
   FppiYHltfvF3Awb0w4MJWcgpDIDrdwpblZCcWIevbHlNX8e+YbBUsEGpA
   g==;
X-CSE-ConnectionGUID: 4I4syBUdSkqDo8YusA+X8A==
X-CSE-MsgGUID: Kpa3WiQ0TWmTCvHBGTpIwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13505882"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13505882"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 10:45:38 -0700
X-CSE-ConnectionGUID: x3/T6SLIRtCoYgVeoKLVUA==
X-CSE-MsgGUID: fhQL5Qx1StCvGMJZkuVQMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39564722"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 10:45:35 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC0tB-000CYt-2R;
	Tue, 28 May 2024 17:45:33 +0000
Date: Wed, 29 May 2024 01:44:58 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	larysa.zaremba@intel.com, netdev@vger.kernel.org,
	michal.kubiak@intel.com, anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 06/11] ice: improve updating
 ice_{t, r}x_ring::xsk_pool
Message-ID: <202405290101.PV6Uluyq-lkp@intel.com>
References: <20240528131429.3012910-7-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528131429.3012910-7-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/ice-respect-netif-readiness-in-AF_XDP-ZC-related-ndo-s/20240528-211914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20240528131429.3012910-7-maciej.fijalkowski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-net 06/11] ice: improve updating ice_{t, r}x_ring::xsk_pool
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240529/202405290101.PV6Uluyq-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290101.PV6Uluyq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290101.PV6Uluyq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_xsk.c:476: warning: Function parameter or struct member 'xsk_pool' not described in '__ice_alloc_rx_bufs_zc'
>> drivers/net/ethernet/intel/ice/ice_xsk.c:525: warning: Function parameter or struct member 'xsk_pool' not described in 'ice_alloc_rx_bufs_zc'
>> drivers/net/ethernet/intel/ice/ice_xsk.c:980: warning: Function parameter or struct member 'xsk_pool' not described in 'ice_xmit_pkt'
>> drivers/net/ethernet/intel/ice/ice_xsk.c:1005: warning: Function parameter or struct member 'xsk_pool' not described in 'ice_xmit_pkt_batch'
>> drivers/net/ethernet/intel/ice/ice_xsk.c:1038: warning: Function parameter or struct member 'xsk_pool' not described in 'ice_fill_tx_hw_ring'


vim +476 drivers/net/ethernet/intel/ice/ice_xsk.c

3876ff525de70ae Maciej Fijalkowski     2022-01-25  462  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  463  /**
3876ff525de70ae Maciej Fijalkowski     2022-01-25  464   * __ice_alloc_rx_bufs_zc - allocate a number of Rx buffers
3876ff525de70ae Maciej Fijalkowski     2022-01-25  465   * @rx_ring: Rx ring
3876ff525de70ae Maciej Fijalkowski     2022-01-25  466   * @count: The number of buffers to allocate
3876ff525de70ae Maciej Fijalkowski     2022-01-25  467   *
3876ff525de70ae Maciej Fijalkowski     2022-01-25  468   * Place the @count of descriptors onto Rx ring. Handle the ring wrap
3876ff525de70ae Maciej Fijalkowski     2022-01-25  469   * for case where space from next_to_use up to the end of ring is less
3876ff525de70ae Maciej Fijalkowski     2022-01-25  470   * than @count. Finally do a tail bump.
3876ff525de70ae Maciej Fijalkowski     2022-01-25  471   *
3876ff525de70ae Maciej Fijalkowski     2022-01-25  472   * Returns true if all allocations were successful, false if any fail.
3876ff525de70ae Maciej Fijalkowski     2022-01-25  473   */
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  474  static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  475  				   struct xsk_buff_pool *xsk_pool,  u16 count)
3876ff525de70ae Maciej Fijalkowski     2022-01-25 @476  {
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  477  	u32 nb_buffs_extra = 0, nb_buffs = 0;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  478  	union ice_32b_rx_flex_desc *rx_desc;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  479  	u16 ntu = rx_ring->next_to_use;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  480  	u16 total_count = count;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  481  	struct xdp_buff **xdp;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  482  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  483  	rx_desc = ICE_RX_DESC(rx_ring, ntu);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  484  	xdp = ice_xdp_buf(rx_ring, ntu);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  485  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  486  	if (ntu + count >= rx_ring->count) {
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  487  		nb_buffs_extra = ice_fill_rx_descs(xsk_pool, xdp, rx_desc,
3876ff525de70ae Maciej Fijalkowski     2022-01-25  488  						   rx_ring->count - ntu);
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  489  		if (nb_buffs_extra != rx_ring->count - ntu) {
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  490  			ntu += nb_buffs_extra;
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  491  			goto exit;
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  492  		}
3876ff525de70ae Maciej Fijalkowski     2022-01-25  493  		rx_desc = ICE_RX_DESC(rx_ring, 0);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  494  		xdp = ice_xdp_buf(rx_ring, 0);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  495  		ntu = 0;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  496  		count -= nb_buffs_extra;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  497  		ice_release_rx_desc(rx_ring, 0);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  498  	}
3876ff525de70ae Maciej Fijalkowski     2022-01-25  499  
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  500  	nb_buffs = ice_fill_rx_descs(xsk_pool, xdp, rx_desc, count);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  501  
db804cfc21e969a Magnus Karlsson        2021-09-22  502  	ntu += nb_buffs;
8b51a13c37c24c0 Maciej Fijalkowski     2021-12-13  503  	if (ntu == rx_ring->count)
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  504  		ntu = 0;
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  505  
d1fc4c6feac18f8 Maciej Fijalkowski     2022-03-17  506  exit:
3876ff525de70ae Maciej Fijalkowski     2022-01-25  507  	if (rx_ring->next_to_use != ntu)
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  508  		ice_release_rx_desc(rx_ring, ntu);
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  509  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  510  	return total_count == (nb_buffs_extra + nb_buffs);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  511  }
3876ff525de70ae Maciej Fijalkowski     2022-01-25  512  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  513  /**
3876ff525de70ae Maciej Fijalkowski     2022-01-25  514   * ice_alloc_rx_bufs_zc - allocate a number of Rx buffers
3876ff525de70ae Maciej Fijalkowski     2022-01-25  515   * @rx_ring: Rx ring
3876ff525de70ae Maciej Fijalkowski     2022-01-25  516   * @count: The number of buffers to allocate
3876ff525de70ae Maciej Fijalkowski     2022-01-25  517   *
3876ff525de70ae Maciej Fijalkowski     2022-01-25  518   * Wrapper for internal allocation routine; figure out how many tail
3876ff525de70ae Maciej Fijalkowski     2022-01-25  519   * bumps should take place based on the given threshold
3876ff525de70ae Maciej Fijalkowski     2022-01-25  520   *
3876ff525de70ae Maciej Fijalkowski     2022-01-25  521   * Returns true if all calls to internal alloc routine succeeded
3876ff525de70ae Maciej Fijalkowski     2022-01-25  522   */
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  523  bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  524  			  struct xsk_buff_pool *xsk_pool, u16 count)
3876ff525de70ae Maciej Fijalkowski     2022-01-25 @525  {
3876ff525de70ae Maciej Fijalkowski     2022-01-25  526  	u16 rx_thresh = ICE_RING_QUARTER(rx_ring);
b3056ae2b57858b Maciej Fijalkowski     2022-09-01  527  	u16 leftover, i, tail_bumps;
3876ff525de70ae Maciej Fijalkowski     2022-01-25  528  
b3056ae2b57858b Maciej Fijalkowski     2022-09-01  529  	tail_bumps = count / rx_thresh;
b3056ae2b57858b Maciej Fijalkowski     2022-09-01  530  	leftover = count - (tail_bumps * rx_thresh);
3876ff525de70ae Maciej Fijalkowski     2022-01-25  531  
3876ff525de70ae Maciej Fijalkowski     2022-01-25  532  	for (i = 0; i < tail_bumps; i++)
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  533  		if (!__ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, rx_thresh))
3876ff525de70ae Maciej Fijalkowski     2022-01-25  534  			return false;
290b7dad8f9f257 Maciej Fijalkowski     2024-05-28  535  	return __ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, leftover);
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  536  }
2d4238f55697221 Krzysztof Kazimierczak 2019-11-04  537  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

