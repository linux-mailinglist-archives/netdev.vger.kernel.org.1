Return-Path: <netdev+bounces-115459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0860946688
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51A21F21D7F
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197004687;
	Sat,  3 Aug 2024 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU/Xi2+H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAA380
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645501; cv=none; b=Zn7fHzus9KzmaZPPtKBqvHjj46XCK2eq8r1gLPmmMgP0uR/U8EexK9NaFj7UrDLn7AfP9cv6Vm5GKsM5YBM0WWGceY37PPb+FSmX/SC2+IVQb799FXjaV6W1XPUEm9/Q0hBKKA4Kx3Rp5boN9BNggCIxkpatASb4jRYebc5q1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645501; c=relaxed/simple;
	bh=Ta+ZUXznjXU9N09+5dDO48gPUVR2yUVdotk8x9uYHxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ciu3rG+rFQgQLGC7Iauy/9fzGJX0gIpUFgNOnNZeYRo/YfMqrDO8/XNAWLPLcQNurVEPsfEbifR7ZRRJ5Kx4kmv96kuaxO0LnrtfYvYMaPGGm0CUWTQvOtmlQDuuGTsZEOaVRjQ5sTk36Hn3vPkNGJd6QzsVzjFpZlvOjqOergM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU/Xi2+H; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722645498; x=1754181498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ta+ZUXznjXU9N09+5dDO48gPUVR2yUVdotk8x9uYHxA=;
  b=YU/Xi2+HfEJfji5LfPT6VSf0a0cuALocYn9FdwiwNRqxYmOXyORVSc9a
   3mk+nar/xp48lglNdh0Z0LSQNM6eiEkEx3Qf2BLYkrG8ZtlAQ9XcN4C0d
   y/JiQJDaCqfIE92um3zZCpRNQK/d5ICAG8lf42Ul5lgRArb8/n/Yi8i6J
   M84TIMpJqQzxHv4wfBku561XSxqyySYQz2coIH8qnSSzu6Xr7hfOAzCvw
   nfrS2MyacVC2QCSIa1EM4K9GyBiC8opyqlQYWBkro8Y07koas543ruJEd
   AGev9rr+aJeBoJXwqh/3NORyKv20fcvCbUyuM5SbGzLFhFBzXO4WPE9c1
   A==;
X-CSE-ConnectionGUID: 2kzsoXEkTc6twuMIYxgpKA==
X-CSE-MsgGUID: uzbcokCDQ4OxCCB6/Q3t2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20852602"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="20852602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 17:38:17 -0700
X-CSE-ConnectionGUID: cSeISrtbR2iDamonOEKdtw==
X-CSE-MsgGUID: h5qq0JQ8SiGrcn5lF0JVhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="60572725"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Aug 2024 17:38:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa2mj-000xck-1k;
	Sat, 03 Aug 2024 00:38:13 +0000
Date: Sat, 3 Aug 2024 08:38:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v7 12/16] xfrm: iptfs: handle received
 fragmented inner packets
Message-ID: <202408030834.THon2krt-lkp@intel.com>
References: <20240801080314.169715-13-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801080314.169715-13-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on netfilter-nf/main linus/master v6.11-rc1 next-20240802]
[cannot apply to klassert-ipsec/master nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240802-185628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240801080314.169715-13-chopps%40chopps.org
patch subject: [PATCH ipsec-next v7 12/16] xfrm: iptfs: handle received fragmented inner packets
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408030834.THon2krt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030834.THon2krt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030834.THon2krt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/xfrm/xfrm_iptfs.c:37: warning: expecting prototype for IP(). Prototype was for IPTFS_DEFAULT_DROP_TIME_USECS() instead
   net/xfrm/xfrm_iptfs.c:49: warning: bad line: 
   net/xfrm/xfrm_iptfs.c:58: warning: expecting prototype for IP(). Prototype was for IPTFS_DEFAULT_INIT_DELAY_USECS() instead


vim +37 net/xfrm/xfrm_iptfs.c

    26	
    27	/**
    28	 * IP-TFS default SA values (tunnel egress/dir-in)
    29	 *
    30	 * IPTFS_DEFAULT_DROP_TIME_USECS
    31	 *        The default IPTFS drop time in microseconds. The drop time is the amount
    32	 *        of time before a missing out-of-order IPTFS tunnel packet is considered
    33	 *        lost. See also the reorder window.
    34	 *
    35	 *        Default 1s (1000000).
    36	 */
  > 37	#define IPTFS_DEFAULT_DROP_TIME_USECS	(1000000000ull) /* 1s */
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

