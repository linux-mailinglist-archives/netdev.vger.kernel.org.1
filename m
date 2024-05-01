Return-Path: <netdev+bounces-92724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710798B86BE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3143B285016
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25D34D9FB;
	Wed,  1 May 2024 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFTvxtIO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D94CE1F;
	Wed,  1 May 2024 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550790; cv=none; b=dSO4gdKf1X21uS8pmsdkbCSWCjD7vHMEhlD0WnzcrV6aBKcrEuGqeEVwWEwO6GtL4JYVXex4l2dz/1wvW21E+m1rYXsfEWLdMkuw7Ge/ohNkY4XCLUKP0/+ciFFl4mntma6gmySuc+zS8s3bKIQC95TFi55NvcZMeK+kUIC9cAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550790; c=relaxed/simple;
	bh=bBUMYKOIs+2HO77T75AUFFXxEW/yRcAvXE2lRdkSTHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxNiNAyRb7+FxUmtSkvD2CpG8pg2P7skiMsfGnPQ+JQm6eYaxX9Abog3sG6av82GOVOqnH28iQXr256N5Hl9Yna58JnNE5kicUM9Nro3nHZHkPXs0iVQITbA2lqCAw1kWXrJIUOwR+jX9+GHCRW8xvQcsewtUG9uS55YOg4RT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFTvxtIO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714550788; x=1746086788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBUMYKOIs+2HO77T75AUFFXxEW/yRcAvXE2lRdkSTHs=;
  b=PFTvxtIOSHHuxNXX3JPS3ydkaRzQr04j/D2Kjlu4ZOXAQzEidE+ItZrA
   D+jXl63W4MKEl4gErigxY55DVrgKF5lUODxlZXlsUwddKgxfSuvIZWC1I
   txq9KlfSqcUFJtA9nqmrNoasHiwV6KrsU08CzwYTwGIeykR4txRfAU0Gx
   0eADglhOe1230yvoVvsfJSUWZ+sT6bcm/bAuxkotWit5JISvesdzJ5vIE
   dCMJAposl2RRz8uppI7waD0hKRNtyFW+zRUzeuDnYr1yQ1oFWWNV4BQjr
   mCAQ73brZGNbb4Vgm7VBspjTKJquZ0a4eHluWfHd6gx13S7FwZ9IdjQcs
   A==;
X-CSE-ConnectionGUID: AZ+sxXHCSDue+ndMqVijcg==
X-CSE-MsgGUID: KcniQESJQqibmlFWAQD/1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10154652"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="10154652"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 01:06:27 -0700
X-CSE-ConnectionGUID: TgjaYgiSQkCSG0FRiHRLbA==
X-CSE-MsgGUID: 3JREX7qqQnO29AfEg4P5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="26725211"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 May 2024 01:06:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s24yo-0009D8-2B;
	Wed, 01 May 2024 08:06:18 +0000
Date: Wed, 1 May 2024 16:06:15 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202405011418.EYj7bgrd-lkp@intel.com>
References: <20240430173136.15807-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430173136.15807-3-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240501-013413
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240430173136.15807-3-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240501/202405011418.EYj7bgrd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011418.EYj7bgrd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011418.EYj7bgrd-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ethtool/coalesce.c: In function 'ethnl_update_profile':
>> net/ethtool/coalesce.c:453:46: error: 'struct net_device' has no member named 'irq_moder'
     453 |         struct dim_irq_moder *irq_moder = dev->irq_moder;
         |                                              ^~
   net/ethtool/coalesce.c: At top level:
   net/ethtool/coalesce.c:446:12: warning: 'ethnl_update_profile' defined but not used [-Wunused-function]
     446 | static int ethnl_update_profile(struct net_device *dev,
         |            ^~~~~~~~~~~~~~~~~~~~
   net/ethtool/coalesce.c:151:12: warning: 'coalesce_put_profile' defined but not used [-Wunused-function]
     151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
         |            ^~~~~~~~~~~~~~~~~~~~


vim +453 net/ethtool/coalesce.c

   424	
   425	/**
   426	 * ethnl_update_profile - get a profile nest with child nests from userspace.
   427	 * @dev: netdevice to update the profile
   428	 * @dst: profile get from the driver and modified by ethnl_update_profile.
   429	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
   430	 * @extack: Netlink extended ack
   431	 *
   432	 * Layout of nests:
   433	 *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
   434	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
   435	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
   436	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
   437	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
   438	 *     ...
   439	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
   440	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
   441	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
   442	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
   443	 *
   444	 * Return: 0 on success or a negative error code.
   445	 */
   446	static int ethnl_update_profile(struct net_device *dev,
   447					struct dim_cq_moder __rcu **dst,
   448					const struct nlattr *nests,
   449					struct netlink_ext_ack *extack)
   450	{
   451		int len_irq_moder = ARRAY_SIZE(coalesce_irq_moderation_policy);
   452		struct nlattr *tb[ARRAY_SIZE(coalesce_irq_moderation_policy)];
 > 453		struct dim_irq_moder *irq_moder = dev->irq_moder;
   454		struct dim_cq_moder *new_profile, *old_profile;
   455		int ret, rem, i = 0, len;
   456		struct nlattr *nest;
   457	
   458		if (!nests)
   459			return 0;
   460	
   461		if (!*dst)
   462			return -EOPNOTSUPP;
   463	
   464		old_profile = rtnl_dereference(*dst);
   465		len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
   466		new_profile = kmemdup(old_profile, len, GFP_KERNEL);
   467		if (!new_profile)
   468			return -ENOMEM;
   469	
   470		nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
   471					 nests, rem) {
   472			ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
   473					       coalesce_irq_moderation_policy,
   474					       extack);
   475			if (ret)
   476				goto err_out;
   477	
   478			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].usec,
   479						     ETHTOOL_A_IRQ_MODERATION_USEC,
   480						     tb, DIM_COALESCE_USEC,
   481						     extack);
   482			if (ret)
   483				goto err_out;
   484	
   485			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].pkts,
   486						     ETHTOOL_A_IRQ_MODERATION_PKTS,
   487						     tb, DIM_COALESCE_PKTS,
   488						     extack);
   489			if (ret)
   490				goto err_out;
   491	
   492			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].comps,
   493						     ETHTOOL_A_IRQ_MODERATION_COMPS,
   494						     tb, DIM_COALESCE_COMPS,
   495						     extack);
   496			if (ret)
   497				goto err_out;
   498	
   499			i++;
   500		}
   501	
   502		rcu_assign_pointer(*dst, new_profile);
   503		kfree_rcu(old_profile, rcu);
   504	
   505		return 0;
   506	
   507	err_out:
   508		kfree(new_profile);
   509		return ret;
   510	}
   511	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

