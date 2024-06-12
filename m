Return-Path: <netdev+bounces-102869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2AE9053D3
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5601C20C3B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2B1D54D;
	Wed, 12 Jun 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn25JWmf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A54688
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199057; cv=none; b=C+DjJfHSdcF4pVYnY50IHS9tfrYb0s9q1PHi2rZNIblQEVz+inrw53K0LwB8lxpvCJUu4zloHMh8pb3A49QWDpDPvN+mu4UOasFJpdhZcIH/3LDajN7YoJr+5UqI3PPWJhejXwVZqJA1HDXnA5O4zs/2uIKpEZE4ur0Wue7qFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199057; c=relaxed/simple;
	bh=YKCnmaly7da2RQ/Tiqem1euR/n3G/om0EGAwBlZfkqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOG7eYDuXsB7wdIopWLgR8Ix6ccLNPYXNKIRp/1Oa2WsZGNQKVMNALmc+YLruloPY42hA5/v4ORtAXKJf0azki6EWQd1rznaOsThhnh5Orsq8VSUO6uXwQqpLmyX+CkNEqho8ICd6gQwqGmOcsqdVsKWxPEm8q3mSYu0I10Tkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn25JWmf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718199054; x=1749735054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YKCnmaly7da2RQ/Tiqem1euR/n3G/om0EGAwBlZfkqs=;
  b=bn25JWmf8pDqiDiJdbykAHbJunK5ZR3pfhq+UvFZ58eTleJEqQv/00Mo
   /BQkxQSg9gcHsVbP7Mp1umwzaql2/7vQT6hgaljnhctyf+/s3qc1iECcs
   zYUNIsGCLaHFLzZ06/eK5l3peuo/tKm+5A1YZvk3xmAb7OdGs/IYBeEFf
   mNe+ZgdBCA8bNvuwquzkcAf7yhVycie6skfl9Z4a30YUbMuLKTM/exnLL
   ISseD5prjHD1YEhCPyVChOeISKHDFecttQBmXBIzcOEuXpb8aG4w63zGf
   AwzSPz+cf6dVz/iCet3RZWCVGnlwQQlQqwR7ttUkHRrbKSFObBOjyAzf0
   w==;
X-CSE-ConnectionGUID: J04+65IaSleWRI9ot5/zWw==
X-CSE-MsgGUID: d7PzzegLQomj+QPqWeOxZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18788622"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="18788622"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 06:30:54 -0700
X-CSE-ConnectionGUID: gUzMOZelQu238V3NyFXr6w==
X-CSE-MsgGUID: AekiXcSxSSSQLBsPi/m4tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40488637"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2024 06:30:50 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHO3s-0001Yk-1U;
	Wed, 12 Jun 2024 13:30:48 +0000
Date: Wed, 12 Jun 2024 21:30:01 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jianbo Liu <jianbol@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH ipsec] xfrm: Fix unregister netdevice hang on hardware
 offload.
Message-ID: <202406122125.fzbXlLhC-lkp@intel.com>
References: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>

Hi Steffen,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on klassert-ipsec/master net/main net-next/main linus/master v6.10-rc3 next-20240612]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Klassert/xfrm-Fix-unregister-netdevice-hang-on-hardware-offload/20240612-171414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/ZmlmTTYL6AkBel4P%40gauss3.secunet.de
patch subject: [PATCH ipsec] xfrm: Fix unregister netdevice hang on hardware offload.
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20240612/202406122125.fzbXlLhC-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240612/202406122125.fzbXlLhC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406122125.fzbXlLhC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/xfrm/xfrm_state.c:688:6: error: redefinition of 'xfrm_dev_state_delete'
     688 | void xfrm_dev_state_delete(struct xfrm_state *x)
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from net/xfrm/xfrm_state.c:19:
   include/net/xfrm.h:2022:20: note: previous definition of 'xfrm_dev_state_delete' with type 'void(struct xfrm_state *)'
    2022 | static inline void xfrm_dev_state_delete(struct xfrm_state *x)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   net/xfrm/xfrm_state.c: In function 'xfrm_dev_state_delete':
>> net/xfrm/xfrm_state.c:694:20: error: 'struct net_device' has no member named 'xfrmdev_ops'
     694 |                 dev->xfrmdev_ops->xdo_dev_state_delete(x);
         |                    ^~
   net/xfrm/xfrm_state.c: At top level:
>> net/xfrm/xfrm_state.c:701:6: error: redefinition of 'xfrm_dev_state_free'
     701 | void xfrm_dev_state_free(struct xfrm_state *x)
         |      ^~~~~~~~~~~~~~~~~~~
   include/net/xfrm.h:2026:20: note: previous definition of 'xfrm_dev_state_free' with type 'void(struct xfrm_state *)'
    2026 | static inline void xfrm_dev_state_free(struct xfrm_state *x)
         |                    ^~~~~~~~~~~~~~~~~~~
   net/xfrm/xfrm_state.c: In function 'xfrm_dev_state_free':
   net/xfrm/xfrm_state.c:706:23: error: 'struct net_device' has no member named 'xfrmdev_ops'
     706 |         if (dev && dev->xfrmdev_ops) {
         |                       ^~
   net/xfrm/xfrm_state.c:712:24: error: 'struct net_device' has no member named 'xfrmdev_ops'
     712 |                 if (dev->xfrmdev_ops->xdo_dev_state_free)
         |                        ^~
   net/xfrm/xfrm_state.c:713:28: error: 'struct net_device' has no member named 'xfrmdev_ops'
     713 |                         dev->xfrmdev_ops->xdo_dev_state_free(x);
         |                            ^~


vim +/xfrm_dev_state_delete +688 net/xfrm/xfrm_state.c

   687	
 > 688	void xfrm_dev_state_delete(struct xfrm_state *x)
   689	{
   690		struct xfrm_dev_offload *xso = &x->xso;
   691		struct net_device *dev = READ_ONCE(xso->dev);
   692	
   693		if (dev) {
 > 694			dev->xfrmdev_ops->xdo_dev_state_delete(x);
   695			spin_lock_bh(&xfrm_state_dev_gc_lock);
   696			hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
   697			spin_unlock_bh(&xfrm_state_dev_gc_lock);
   698		}
   699	}
   700	
 > 701	void xfrm_dev_state_free(struct xfrm_state *x)
   702	{
   703		struct xfrm_dev_offload *xso = &x->xso;
   704		struct net_device *dev = READ_ONCE(xso->dev);
   705	
   706		if (dev && dev->xfrmdev_ops) {
   707			spin_lock_bh(&xfrm_state_dev_gc_lock);
   708			if (!hlist_unhashed(&x->dev_gclist))
   709				hlist_del(&x->dev_gclist);
   710			spin_unlock_bh(&xfrm_state_dev_gc_lock);
   711	
   712			if (dev->xfrmdev_ops->xdo_dev_state_free)
   713				dev->xfrmdev_ops->xdo_dev_state_free(x);
   714			WRITE_ONCE(xso->dev, NULL);
   715			xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
   716			netdev_put(dev, &xso->dev_tracker);
   717		}
   718	}
   719	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

