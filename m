Return-Path: <netdev+bounces-169635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C124A44ED5
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DF171872
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498120C476;
	Tue, 25 Feb 2025 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+ZbVft9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B3B18DB2E
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518881; cv=none; b=B4CwDHGRMJb9KOLGER+CKIMpYbJ2sBQF8m4StL7+SWnDoSxdvyaS04YV/93MQElhT4cyFuoN3T4Mul8Yp5Er94TlUZgs8dWimf6rGupurZqC3yd5bPnMSPYNNQr/0UKi8lKZlgZzKKYvMq7PNwmN42EhP7496r0iF5R9yJihrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518881; c=relaxed/simple;
	bh=mHtexZIWhP733gfukHNRKtZLR0AZlEi0tEpTlNqDts4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEVFwPMsoQx4efpT+2c4Xvl9yIuNrtXqi/3zJ+R6u1ulQkmrxL5Ot1cuoSwXeLlN6Fih6gv6xl6Y+1nS3m6FUVt1LXDEMa35dUJIFrKBbRzVvqbG2jpNU/sVRE8Xiq5wwXOwpN0YzVRzA+xKVD0sPWySZ8cJ4MqsMod1CfVPPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+ZbVft9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740518879; x=1772054879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mHtexZIWhP733gfukHNRKtZLR0AZlEi0tEpTlNqDts4=;
  b=i+ZbVft9zqHPko+bpIJRJD1mpr/bRwdAfi3eUb47SByGmFMMGU4vVbxH
   S0nxMF0eAkNnPFb4jdZ9yITjsttuXI/n4N2+wOTGroi5FZ6P0e9hOSvJf
   aHu/wKFNmt3DI8V6BmKeCtHaSwxG/NcT4uqQsqXKpS7inlH/B6758+WIf
   kbUiyGd5D5JkibDwjEcIcXn8jw7zC3z43MC/AqMeIv8WjjxB2/qyhq0vT
   98k5a6m8Iw6BgAiuCXHxukn1THEZAT+fPkCYMFwE0N5LBJuiaf9JKuLYK
   gMkkj/w7gPvl6snqkLjiInTEG+ryU0pXrzHSKqKcuTbqlXGQkhBN0hkHh
   g==;
X-CSE-ConnectionGUID: HDlqYGppSQik8VG0xhz9yQ==
X-CSE-MsgGUID: l39G+VR4Tj2i35b9Ni6dQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41550866"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41550866"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 13:27:59 -0800
X-CSE-ConnectionGUID: N/qjuDE/TmiVQqv3PlIh3g==
X-CSE-MsgGUID: eumm2o4SQX6+T6sIxiXnUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121756092"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 25 Feb 2025 13:27:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tn2Su-000An9-11;
	Tue, 25 Feb 2025 21:27:46 +0000
Date: Wed, 26 Feb 2025 05:25:54 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
Message-ID: <202502260536.BzRJ7jGr-lkp@intel.com>
References: <20250224171055.15951-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224171055.15951-1-fw@strlen.de>

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.14-rc4 next-20250225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/xfrm-remove-hash-table-alloc-free-helpers/20250225-011758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20250224171055.15951-1-fw%40strlen.de
patch subject: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
config: x86_64-buildonly-randconfig-004-20250226 (https://download.01.org/0day-ci/archive/20250226/202502260536.BzRJ7jGr-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250226/202502260536.BzRJ7jGr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502260536.BzRJ7jGr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/xfrm/xfrm_state.c:165:26: warning: variable 'ohashmask' set but not used [-Wunused-but-set-variable]
     165 |         unsigned int nhashmask, ohashmask;
         |                                 ^
   1 warning generated.


vim +/ohashmask +165 net/xfrm/xfrm_state.c

f034b5d4efdfe0 David S. Miller  2006-08-24  160  
63082733858502 Alexey Dobriyan  2008-11-25  161  static void xfrm_hash_resize(struct work_struct *work)
f034b5d4efdfe0 David S. Miller  2006-08-24  162  {
63082733858502 Alexey Dobriyan  2008-11-25  163  	struct net *net = container_of(work, struct net, xfrm.state_hash_work);
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  164  	struct hlist_head *ndst, *nsrc, *nspi, *nseq, *odst, *osrc, *ospi, *oseq;
f034b5d4efdfe0 David S. Miller  2006-08-24 @165  	unsigned int nhashmask, ohashmask;
ef6562fb0dcb1a Florian Westphal 2025-02-24  166  	unsigned long nsize;
f034b5d4efdfe0 David S. Miller  2006-08-24  167  	int i;
f034b5d4efdfe0 David S. Miller  2006-08-24  168  
63082733858502 Alexey Dobriyan  2008-11-25  169  	nsize = xfrm_hash_new_size(net->xfrm.state_hmask);
44e36b42a8378b David S. Miller  2006-08-24  170  	ndst = xfrm_hash_alloc(nsize);
f034b5d4efdfe0 David S. Miller  2006-08-24  171  	if (!ndst)
0244790c8ad240 Ying Xue         2014-08-29  172  		return;
44e36b42a8378b David S. Miller  2006-08-24  173  	nsrc = xfrm_hash_alloc(nsize);
f034b5d4efdfe0 David S. Miller  2006-08-24  174  	if (!nsrc) {
ef6562fb0dcb1a Florian Westphal 2025-02-24  175  		xfrm_hash_free(ndst);
0244790c8ad240 Ying Xue         2014-08-29  176  		return;
f034b5d4efdfe0 David S. Miller  2006-08-24  177  	}
44e36b42a8378b David S. Miller  2006-08-24  178  	nspi = xfrm_hash_alloc(nsize);
f034b5d4efdfe0 David S. Miller  2006-08-24  179  	if (!nspi) {
ef6562fb0dcb1a Florian Westphal 2025-02-24  180  		xfrm_hash_free(ndst);
ef6562fb0dcb1a Florian Westphal 2025-02-24  181  		xfrm_hash_free(nsrc);
0244790c8ad240 Ying Xue         2014-08-29  182  		return;
f034b5d4efdfe0 David S. Miller  2006-08-24  183  	}
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  184  	nseq = xfrm_hash_alloc(nsize);
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  185  	if (!nseq) {
ef6562fb0dcb1a Florian Westphal 2025-02-24  186  		xfrm_hash_free(ndst);
ef6562fb0dcb1a Florian Westphal 2025-02-24  187  		xfrm_hash_free(nsrc);
ef6562fb0dcb1a Florian Westphal 2025-02-24  188  		xfrm_hash_free(nspi);
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  189  		return;
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  190  	}
f034b5d4efdfe0 David S. Miller  2006-08-24  191  
283bc9f35bbbcb Fan Du           2013-11-07  192  	spin_lock_bh(&net->xfrm.xfrm_state_lock);
e88add19f68191 Ahmed S. Darwish 2021-03-16  193  	write_seqcount_begin(&net->xfrm.xfrm_state_hash_generation);
f034b5d4efdfe0 David S. Miller  2006-08-24  194  
f034b5d4efdfe0 David S. Miller  2006-08-24  195  	nhashmask = (nsize / sizeof(struct hlist_head)) - 1U;
c8406998b80183 Florian Westphal 2016-08-09  196  	odst = xfrm_state_deref_prot(net->xfrm.state_bydst, net);
63082733858502 Alexey Dobriyan  2008-11-25  197  	for (i = net->xfrm.state_hmask; i >= 0; i--)
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  198  		xfrm_hash_transfer(odst + i, ndst, nsrc, nspi, nseq, nhashmask);
f034b5d4efdfe0 David S. Miller  2006-08-24  199  
c8406998b80183 Florian Westphal 2016-08-09  200  	osrc = xfrm_state_deref_prot(net->xfrm.state_bysrc, net);
c8406998b80183 Florian Westphal 2016-08-09  201  	ospi = xfrm_state_deref_prot(net->xfrm.state_byspi, net);
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  202  	oseq = xfrm_state_deref_prot(net->xfrm.state_byseq, net);
63082733858502 Alexey Dobriyan  2008-11-25  203  	ohashmask = net->xfrm.state_hmask;
f034b5d4efdfe0 David S. Miller  2006-08-24  204  
c8406998b80183 Florian Westphal 2016-08-09  205  	rcu_assign_pointer(net->xfrm.state_bydst, ndst);
c8406998b80183 Florian Westphal 2016-08-09  206  	rcu_assign_pointer(net->xfrm.state_bysrc, nsrc);
c8406998b80183 Florian Westphal 2016-08-09  207  	rcu_assign_pointer(net->xfrm.state_byspi, nspi);
fe9f1d8779cb47 Sabrina Dubroca  2021-04-25  208  	rcu_assign_pointer(net->xfrm.state_byseq, nseq);
63082733858502 Alexey Dobriyan  2008-11-25  209  	net->xfrm.state_hmask = nhashmask;
f034b5d4efdfe0 David S. Miller  2006-08-24  210  
e88add19f68191 Ahmed S. Darwish 2021-03-16  211  	write_seqcount_end(&net->xfrm.xfrm_state_hash_generation);
283bc9f35bbbcb Fan Du           2013-11-07  212  	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
f034b5d4efdfe0 David S. Miller  2006-08-24  213  
df7274eb70b7c8 Florian Westphal 2016-08-09  214  	synchronize_rcu();
df7274eb70b7c8 Florian Westphal 2016-08-09  215  
ef6562fb0dcb1a Florian Westphal 2025-02-24  216  	xfrm_hash_free(odst);
ef6562fb0dcb1a Florian Westphal 2025-02-24  217  	xfrm_hash_free(osrc);
ef6562fb0dcb1a Florian Westphal 2025-02-24  218  	xfrm_hash_free(ospi);
ef6562fb0dcb1a Florian Westphal 2025-02-24  219  	xfrm_hash_free(oseq);
f034b5d4efdfe0 David S. Miller  2006-08-24  220  }
f034b5d4efdfe0 David S. Miller  2006-08-24  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

