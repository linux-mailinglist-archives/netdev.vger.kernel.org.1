Return-Path: <netdev+bounces-87253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB3A8A2495
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59A5283735
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005B17C64;
	Fri, 12 Apr 2024 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNpW/YIv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB03199B4
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712894187; cv=none; b=OeVsArzk1Ao1T3uUyYu07smUs7gFkYCuTDevleXeZeKwjhmZZaZSn2E5hLSbr+uFhNFpDbksnYUVE5gUlIq8PGzHPpxKBbChaBi3KAL7rICOQ80zrGTyYFKn1ORXpRCkQ+mcWaq7UK302mRAHzJPoFFbKHeXEyo3kO8/qnbnKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712894187; c=relaxed/simple;
	bh=6bVxiN3USagUuzO5BLKsWlH28OHE2BRSci11hbQPqIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVRh52qx3zPXG+tOQLJe1SeqQS02yrjm/xyoFH3RKx3JvFYUxdbs6rzFnVP4V44LpFHV0JGWnruQ7PQKmvd66tccvwnd69bxz6oPveWtIbwmNYeAQb2UbfA42/nCYHqTUkaJMZuCQ4qIW6bPEfVViAWiPNNcLxkb6B3Xk4MZ/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNpW/YIv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712894184; x=1744430184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bVxiN3USagUuzO5BLKsWlH28OHE2BRSci11hbQPqIE=;
  b=KNpW/YIvwRVcoGP42haUdIPpBD4Sg7aYMLrTxSTJQ6UO3p/aa3NIZwNA
   JyvG8v9xfSB2TLQIm2K47BLDK3o1c8aRZIgFnenbWOuYijxsWqz5V8Z2t
   4jHLWp3cPTpGRYliHz38lYKDFaMb/00UKPsDRsU7WRmEumouU0/siBV3s
   Ffss89wkKcGuce6eM3Tol9R1T8o+jKC8s2dCd9A+1zm9y+RyO0dAeL73N
   7XZwp5uLut8vc6+x1NN8WjtxWZeqqOzyYRb87TplZvGXsph1vsKFYE3jd
   8hlzRLClBVPuuIeIZQC/cZCmeNH0oHWFCKVLMD59TNemx0pyLmd8uCJMI
   g==;
X-CSE-ConnectionGUID: t5Xv/XC9RxyncXlgB/kHjA==
X-CSE-MsgGUID: d5eMJ69mQiqebvPVSwWEUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8513911"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8513911"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 20:56:23 -0700
X-CSE-ConnectionGUID: vyANzUghRqmRw77D2sqeCQ==
X-CSE-MsgGUID: GEcp8UnSTz224quQ9ev1vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21166752"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Apr 2024 20:56:20 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv81S-0009LZ-1H;
	Fri, 12 Apr 2024 03:56:18 +0000
Date: Fri, 12 Apr 2024 11:56:15 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202404121112.lymscQm1-lkp@intel.com>
References: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240411-221400
base:   net-next/main
patch link:    https://lore.kernel.org/r/1712844751-53514-3-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v6 2/4] ethtool: provide customized dim profile management
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240412/202404121112.lymscQm1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8b3b4a92adee40483c27f26c478a384cd69c6f05)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404121112.lymscQm1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404121112.lymscQm1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ethtool/coalesce.c:373: warning: Function parameter or struct member 'dev' not described in 'ethnl_update_profile'
>> net/ethtool/coalesce.c:373: warning: Excess function parameter 'mod' description in 'ethnl_update_profile'


vim +373 net/ethtool/coalesce.c

   347	
   348	/**
   349	 * ethnl_update_profile - get a nla nest with four child nla nests from userspace.
   350	 * @dst: data get from the driver and modified by ethnl_update_profile.
   351	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_*QE_PROFILE to set driver's profile.
   352	 * @mod: whether the data is modified
   353	 * @extack: Netlink extended ack
   354	 *
   355	 * Layout of nests:
   356	 *   Nested ETHTOOL_A_COALESCE_*X_*QE_PROFILE attr
   357	 *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
   358	 *       ETHTOOL_A_MODERATION_USEC attr
   359	 *       ETHTOOL_A_MODERATION_PKTS attr
   360	 *       ETHTOOL_A_MODERATION_COMPS attr
   361	 *     ...
   362	 *     Nested ETHTOOL_A_MODERATIONS_MODERATION attr
   363	 *       ETHTOOL_A_MODERATION_USEC attr
   364	 *       ETHTOOL_A_MODERATION_PKTS attr
   365	 *       ETHTOOL_A_MODERATION_COMPS attr
   366	 *
   367	 * Returns 0 on success or a negative error code.
   368	 */
   369	static inline int ethnl_update_profile(struct net_device *dev,
   370					       struct dim_cq_moder *dst,
   371					       const struct nlattr *nests,
   372					       struct netlink_ext_ack *extack)
 > 373	{
   374		struct nlattr *tb_moder[ARRAY_SIZE(coalesce_set_profile_policy)];
   375		struct dim_cq_moder profile[NET_DIM_PARAMS_NUM_PROFILES];
   376		struct nlattr *nest;
   377		int ret, rem, i = 0;
   378	
   379		if (!nests)
   380			return 0;
   381	
   382		if (!dst)
   383			return -EOPNOTSUPP;
   384	
   385		nla_for_each_nested_type(nest, ETHTOOL_A_MODERATIONS_MODERATION, nests, rem) {
   386			ret = nla_parse_nested(tb_moder,
   387					       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
   388					       nest, coalesce_set_profile_policy,
   389					       extack);
   390			if (ret)
   391				return ret;
   392	
   393			if (NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_USEC) ||
   394			    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_PKTS) ||
   395			    NL_REQ_ATTR_CHECK(extack, nest, tb_moder, ETHTOOL_A_MODERATION_COMPS))
   396				return -EINVAL;
   397	
   398			profile[i].usec = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_USEC]);
   399			profile[i].pkts = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_PKTS]);
   400			profile[i].comps = nla_get_u16(tb_moder[ETHTOOL_A_MODERATION_COMPS]);
   401	
   402			if ((dst[i].usec != profile[i].usec && !(dev->priv_flags & IFF_PROFILE_USEC)) ||
   403			    (dst[i].pkts != profile[i].pkts && !(dev->priv_flags & IFF_PROFILE_PKTS)) ||
   404			    (dst[i].comps != profile[i].comps && !(dev->priv_flags & IFF_PROFILE_COMPS)))
   405				return -EOPNOTSUPP;
   406	
   407			i++;
   408		}
   409	
   410		memcpy(dst, profile, sizeof(profile));
   411	
   412		return 0;
   413	}
   414	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

