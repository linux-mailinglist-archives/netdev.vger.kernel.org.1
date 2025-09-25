Return-Path: <netdev+bounces-226145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF6B9CF9C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1619D1B26E60
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22342DCF72;
	Thu, 25 Sep 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2nLoFL2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0521C9F4
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762466; cv=none; b=qD94YSVsnihDA9ldnZWvIG5BxBzhRzZg0ejp4lW/THPXYfsOQQ06FQgbwIQLf+4oZR3rOxrhEPbbH7q4as3LRpgKRLwWVN2/1vjwalLRXzQXYlMQsun9MUuvmR2CbvvwC+0bRFrTYEfuqGnGBi1CrUXYddcJ/GNQAvnr8XxYxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762466; c=relaxed/simple;
	bh=CFlZhPgAxboz1Cv27dcvdJcYS+vH2Myac43V87lcC38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfpZMyyc4aRcGld3hwIHsfNC0SuysFnjYquFL5B+O4Pz/oUzqlPUBIY3WHnGQOYGSR9pcFO+vW1AT+pqsAbKzBgZDdxh22BSx2kLqZ3PmED52HMQKO73DtBqCyBm+BWOxOgfwWTuhm/uxMTQJCLCHHFqOqbe9kpJlPmaWpPyjZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2nLoFL2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758762464; x=1790298464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFlZhPgAxboz1Cv27dcvdJcYS+vH2Myac43V87lcC38=;
  b=d2nLoFL2Xc1ivz3pKdoPdctYSi/faxDC7DN8LU64OkAKc9DGqh4uPvvB
   bRf+aUwYlhfxkqgMvIOnq9kEQjQIOr9woPg3LskfFjQnMXz/Zp+3hmb12
   tnzNP9vFmWXqPM+IfI4qfmq6spLd5cdfi2E1yA4xeoy5jcc2BE4x8AdcW
   0WDEMAacqnNxN4WVO+Nfpx0GOABFkWE+S0Ed6eMM2yaxLq+BuabeiRkty
   ugYScZQZDz7xzZvG0NtLXWufit38QbBIkoY0/BQpRl9G7n8056ZCajD0K
   5u5uFRjrKIgemiiKkjo4xa/J1ktlrVS7kLSgS/fkMnPN2Pbey+RvVmph2
   w==;
X-CSE-ConnectionGUID: L+kj8axOS9K4TA6+FEqlaw==
X-CSE-MsgGUID: Jnq4Jk+aTgOP4mBMfvflQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72499895"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="72499895"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 18:07:43 -0700
X-CSE-ConnectionGUID: xVolhA3PT8epk9iyLHx9ug==
X-CSE-MsgGUID: TpAAOHCwRGiTaLWtNbgzxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="177257941"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 24 Sep 2025 18:07:40 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1aSP-0004mH-23;
	Thu, 25 Sep 2025 01:07:37 +0000
Date: Thu, 25 Sep 2025 09:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	parav@nvidia.com, jerinj@marvell.com, ndabilpuram@marvell.com,
	sburla@marvell.com, schalla@marvell.com
Subject: Re: [PATCH v1 net-next  2/3] virtio_net: enable outer nw header
 offset support.
Message-ID: <202509250856.HoVMjFzw-lkp@intel.com>
References: <20250923202258.2738717-3-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923202258.2738717-3-kshankar@marvell.com>

Hi Kommula,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kommula-Shiva-Shankar/net-implement-virtio-helper-to-handle-outer-nw-offset/20250924-042602
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250923202258.2738717-3-kshankar%40marvell.com
patch subject: [PATCH v1 net-next  2/3] virtio_net: enable outer nw header offset support.
config: x86_64-randconfig-122-20250924 (https://download.01.org/0day-ci/archive/20250925/202509250856.HoVMjFzw-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509250856.HoVMjFzw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509250856.HoVMjFzw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net.c: note: in included file:
>> include/linux/virtio_net.h:389:72: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio16 [usertype] val @@     got restricted __le16 [usertype] outer_nh_offset @@
   include/linux/virtio_net.h:389:72: sparse:     expected restricted __virtio16 [usertype] val
   include/linux/virtio_net.h:389:72: sparse:     got restricted __le16 [usertype] outer_nh_offset
>> include/linux/virtio_net.h:411:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] outer_nh_offset @@     got restricted __virtio16 @@
   include/linux/virtio_net.h:411:39: sparse:     expected restricted __le16 [usertype] outer_nh_offset
   include/linux/virtio_net.h:411:39: sparse:     got restricted __virtio16

vim +389 include/linux/virtio_net.h

a2fb4bc4e2a6a0 Paolo Abeni           2025-07-08  376  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  377  static inline int
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  378  virtio_net_out_net_header_to_skb(struct sk_buff *skb,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  379  				 struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  380  				 bool out_net_hdr_negotiated,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  381  				 bool little_endian)
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  382  {
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  383  	unsigned int out_net_hdr_off;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  384  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  385  	if (!out_net_hdr_negotiated)
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  386  		return 0;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  387  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  388  	if (vhdr->outer_nh_offset) {
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24 @389  		out_net_hdr_off = __virtio16_to_cpu(little_endian, vhdr->outer_nh_offset);
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  390  		skb_set_network_header(skb, out_net_hdr_off);
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  391  	}
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  392  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  393  	return 0;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  394  }
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  395  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  396  static inline int
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  397  virtio_net_out_net_header_from_skb(const struct sk_buff *skb,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  398  				   struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr *vhdr,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  399  				   bool out_net_hdr_negotiated,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  400  				   bool little_endian)
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  401  {
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  402  	unsigned int out_net_hdr_off;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  403  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  404  	if (!out_net_hdr_negotiated) {
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  405  		vhdr->outer_nh_offset = 0;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  406  		return 0;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  407  	}
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  408  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  409  	out_net_hdr_off = skb_network_offset(skb);
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  410  	if (out_net_hdr_off && skb->protocol == htons(ETH_P_IP))
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24 @411  		vhdr->outer_nh_offset = __cpu_to_virtio16(little_endian,
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  412  							  out_net_hdr_off);
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  413  
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  414  	return 0;
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  415  }
1dc49efaeaa4c1 Kommula Shiva Shankar 2025-09-24  416  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

