Return-Path: <netdev+bounces-217523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D7B38FA7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB98460632
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CC2E63C;
	Thu, 28 Aug 2025 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMlbIePx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1330CDA0
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340144; cv=none; b=Pkh5XtvRYPfGeTgrtrKhSb12+rF/TU9s7y4uj9IkM2kE92sLyMqN7Sp8huwKl1nALKsHeockfWcdOc1CIRvCH+7HiGgPiIO0UJox2lnbIf3RheoPT9OyYBtbknFo17oly0uKTQvblg+j3KXGWzQtEOTBOZuQS0TNexMUocSrJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340144; c=relaxed/simple;
	bh=X15jxw1bjDxbXh3rtpDUG6dcAg8RmRvouUgXO1Lx1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seu/nt4DBRvGnpbf6xztRtpXZsxbFvacog2CvdwZVxJB1Ck+98nFz3iUST0h/2OOi0czzy3LhVWhz9nKg8MZoUk44+hT5p3QToqSZxvB6DSmOaWdCcyv4PNbI11ltw/Wt3dqLJdjKJY+8daYFhyc8E9XMv6qiHunDG9IaJWMfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMlbIePx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756340142; x=1787876142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X15jxw1bjDxbXh3rtpDUG6dcAg8RmRvouUgXO1Lx1nc=;
  b=OMlbIePx0ytDAHe/PdZqJNfCYZVVcA5DHV6evliF5287JJ1/zmUD7rvk
   PLT3gCKozNJA89Fq5YxrerFLok8SvgA47UczneWC3zodgngrEWL9Kz56P
   cV2G8Vus+aTys+z03nZI/yjJeev71n3+weluOXMG7lntu14QmMaxLfSho
   Hm7aOTAGmBYxvXRHarh/SFVtQg0k6XCGu9fvd0AtV7aT4zK3ub5Ep/jde
   zfv7VWVuOCCDseA+/ebjAztaFp4aczeAXYB8vFeiI+yWwNFNdf6AajOAO
   HIOxPvVK2iFBIDNthiAHAUMXsdnmo2nnqBaW/mANe1zmJh4vREXwG25un
   g==;
X-CSE-ConnectionGUID: s0Pq+V4mS7+sW7hZ0ArCSQ==
X-CSE-MsgGUID: MlO12tU8RTuDqSmCEwiBRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58666236"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58666236"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 17:15:42 -0700
X-CSE-ConnectionGUID: iXetU8geRCSmxvhjry4N3g==
X-CSE-MsgGUID: muBJXXgoTNaRGb7JiqWu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170360066"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 17:15:39 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urQIi-000TIN-2k;
	Thu, 28 Aug 2025 00:15:36 +0000
Date: Thu, 28 Aug 2025 08:15:14 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 04/11] virtio_net: Query and set flow filter caps
Message-ID: <202508280749.JlXoz9Mz-lkp@intel.com>
References: <20250827183852.2471-5-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183852.2471-5-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250828-024128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827183852.2471-5-danielj%40nvidia.com
patch subject: [PATCH net-next 04/11] virtio_net: Query and set flow filter caps
config: i386-buildonly-randconfig-002-20250828 (https://download.01.org/0day-ci/archive/20250828/202508280749.JlXoz9Mz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508280749.JlXoz9Mz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508280749.JlXoz9Mz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/virtio_net_ff.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/linux/virtio_net_ff.h] Error 1 shuffle=2238678394
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1380: headers] Error 2 shuffle=2238678394
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=2238678394
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=2238678394
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

