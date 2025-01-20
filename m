Return-Path: <netdev+bounces-159873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 212EDA17412
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229B53A76F3
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFF1EF0AE;
	Mon, 20 Jan 2025 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekNZDxZm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376919A28D
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408235; cv=none; b=Fp21a6t8zIVDHA0MJE2w69BU1HsKrP8QA5dF/5NdPzxyN/lldbFLtkuJsW86Ht5kxro+K13wFOLBMrjglP9rOZmF+QJcXKQETeXW/AVT5RNFFXsSk6fxdO4e+nu3M8k5lP1GSf6ToVViq+7dsN/29Es4pg45Oiapz5jnhDnCck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408235; c=relaxed/simple;
	bh=ic1YrMkJxR4nE3jNr5cjpGoYV6GC29ktrDXoEPyUpKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+a01b9S9yRBAhGNHn/EproI8L+997MFu7JB16g4CbvIbqzOvUl/9sYUu2siGFWUxs1LSa0/6VuApJjotv2g6FrFjoPWIBoLW0Q+l1MrkjZmbl5u3TLDvPxv2ckGd+hRe9qW8xNpEKc467fVj3WcsJ6F6Womk3fg+2TqdpKbPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekNZDxZm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737408234; x=1768944234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ic1YrMkJxR4nE3jNr5cjpGoYV6GC29ktrDXoEPyUpKc=;
  b=ekNZDxZmfQTdSjpDbWQ6ntpJF2Mp5yEmQE56HQz9PYmZDo7wQY+0pH5B
   7ILp/ls3s6rgtUPxxgdCsRH2RsfklRA85OcIw9hcd9E5KnYJbCBhA1qMT
   OytjVURGTZNG/LzdR5Fl+Nm4Xv4G8xMTf9k8GHjy/EOaD9LY6Kq8aCDYc
   ooTSVFdwk/659IbUdWEHiB5EOqQe9IvdiJ2xI1GPvKaNUU4Ojk1OpeKhQ
   mJR7O6odSgl5IH3AZdNZ+0k058YoUbjsoYpgDEtTVsic5kzngvezc+Hqb
   OsOFACd4ia464GBHpV6O9vFjaB7ABtBCgfnIiXFvNWMnSQTpWjwq5b6If
   g==;
X-CSE-ConnectionGUID: QLBPh8z6SBKUcXjlKaXsFg==
X-CSE-MsgGUID: iF1aZ1x/T6eTcGmpjis8jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48475920"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="48475920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 13:23:53 -0800
X-CSE-ConnectionGUID: Vp8efN4qTyCwHtM32NumhA==
X-CSE-MsgGUID: AfvhZqVxR/O+qnBqFlRZrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; 
   d="scan'208";a="106434227"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2025 13:23:51 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZzFM-000Wz1-2D;
	Mon, 20 Jan 2025 21:23:48 +0000
Date: Tue, 21 Jan 2025 05:23:05 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, xudu@redhat.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
	jmaxwell@redhat.com, magnus.karlsson@intel.com
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net 3/3] ice: stop storing XDP
 verdict within ice_rx_buf
Message-ID: <202501210750.KInYtrPt-lkp@intel.com>
References: <20250120155016.556735-4-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120155016.556735-4-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/ice-put-Rx-buffers-after-being-done-with-current-frame/20250120-235320
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250120155016.556735-4-maciej.fijalkowski%40intel.com
patch subject: [Intel-wired-lan] [PATCH v3 iwl-net 3/3] ice: stop storing XDP verdict within ice_rx_buf
config: arc-randconfig-001-20250121 (https://download.01.org/0day-ci/archive/20250121/202501210750.KInYtrPt-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250121/202501210750.KInYtrPt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501210750.KInYtrPt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_txrx.c:539: warning: Excess function parameter 'rx_buf' description in 'ice_run_xdp'


vim +539 drivers/net/ethernet/intel/ice/ice_txrx.c

cdedef59deb020 Anirudh Venkataramanan 2018-03-20  523  
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  524  /**
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  525   * ice_run_xdp - Executes an XDP program on initialized xdp_buff
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  526   * @rx_ring: Rx ring
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  527   * @xdp: xdp_buff used as input to the XDP program
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  528   * @xdp_prog: XDP program to run
eb087cd828648d Maciej Fijalkowski     2021-08-19  529   * @xdp_ring: ring to be used for XDP_TX action
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  530   * @rx_buf: Rx buffer to store the XDP action
d951c14ad237b0 Larysa Zaremba         2023-12-05  531   * @eop_desc: Last descriptor in packet to read metadata from
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  532   *
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  533   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  534   */
55a1a17189d7a5 Maciej Fijalkowski     2025-01-20  535  static u32
e72bba21355dbb Maciej Fijalkowski     2021-08-19  536  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  537  	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
55a1a17189d7a5 Maciej Fijalkowski     2025-01-20  538  	    union ice_32b_rx_flex_desc *eop_desc)
efc2214b6047b6 Maciej Fijalkowski     2019-11-04 @539  {
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  540  	unsigned int ret = ICE_XDP_PASS;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  541  	u32 act;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  542  
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  543  	if (!xdp_prog)
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  544  		goto exit;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  545  
d951c14ad237b0 Larysa Zaremba         2023-12-05  546  	ice_xdp_meta_set_desc(xdp, eop_desc);
d951c14ad237b0 Larysa Zaremba         2023-12-05  547  
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  548  	act = bpf_prog_run_xdp(xdp_prog, xdp);
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  549  	switch (act) {
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  550  	case XDP_PASS:
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  551  		break;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  552  	case XDP_TX:
22bf877e528f68 Maciej Fijalkowski     2021-08-19  553  		if (static_branch_unlikely(&ice_xdp_locking_key))
22bf877e528f68 Maciej Fijalkowski     2021-08-19  554  			spin_lock(&xdp_ring->tx_lock);
055d0920685e53 Alexander Lobakin      2023-02-10  555  		ret = __ice_xmit_xdp_ring(xdp, xdp_ring, false);
22bf877e528f68 Maciej Fijalkowski     2021-08-19  556  		if (static_branch_unlikely(&ice_xdp_locking_key))
22bf877e528f68 Maciej Fijalkowski     2021-08-19  557  			spin_unlock(&xdp_ring->tx_lock);
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  558  		if (ret == ICE_XDP_CONSUMED)
89d65df024c599 Magnus Karlsson        2021-05-10  559  			goto out_failure;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  560  		break;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  561  	case XDP_REDIRECT:
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  562  		if (xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog))
89d65df024c599 Magnus Karlsson        2021-05-10  563  			goto out_failure;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  564  		ret = ICE_XDP_REDIR;
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  565  		break;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  566  	default:
c8064e5b4adac5 Paolo Abeni            2021-11-30  567  		bpf_warn_invalid_xdp_action(rx_ring->netdev, xdp_prog, act);
4e83fc934e3a04 Bruce Allan            2020-01-22  568  		fallthrough;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  569  	case XDP_ABORTED:
89d65df024c599 Magnus Karlsson        2021-05-10  570  out_failure:
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  571  		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
4e83fc934e3a04 Bruce Allan            2020-01-22  572  		fallthrough;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  573  	case XDP_DROP:
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  574  		ret = ICE_XDP_CONSUMED;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  575  	}
1dc1a7e7f4108b Maciej Fijalkowski     2023-01-31  576  exit:
55a1a17189d7a5 Maciej Fijalkowski     2025-01-20  577  	return ret;
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  578  }
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  579  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

