Return-Path: <netdev+bounces-192580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F55AC0751
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2159E443C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03927F194;
	Thu, 22 May 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ4xXI6e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4D279792
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903167; cv=none; b=LK8Myei9EYDQusl7Syb6G41FEtH2EgMUTxf8NStvSCbC1K3dxOJgi90kryMAxcjr8gDadxU8Y9/5oBC1/uvQ7VTGB5Fp3iJoRJvPHstAd256Et8q6EknG6/iWym2RIFCetxVxumgk1MnlwgzO/n1L0jgcj6iWwPME/YJjOzsm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903167; c=relaxed/simple;
	bh=9flE0QZImSW576+7I7BBU3UGpRsywlbNGBPZ1xv0BkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/iK4EZXoyJ6SqdyvJ0pSzyLtFuPWWwspB1fJsgEthxxGIouBJDjFlp32CFW3mEwI2T2j6vjg9Mtz28Ca9JsrIeDV4I97wCN4KSlBb6eAinsfOm2/+CscfAml/aM9A0eUzTtqCxwePUAc/t1OmUqZ7WukPm7J5u0lZeV1Ihhkuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ4xXI6e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747903165; x=1779439165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9flE0QZImSW576+7I7BBU3UGpRsywlbNGBPZ1xv0BkI=;
  b=VZ4xXI6e1D2zNhP2HLENM6b9OhNwd5ksrhp8/Jo3LaYeKP2Th1t44CMZ
   26xTXu+HN1I89wN3alTHvOZ/mvW3uWJ9LjSnkii+9+/+HGSxALDji1r6g
   QBaqbmCeeXzyLUII2jWUAZpr2g4Numct17o47P/STskq/bSN68SWZ436q
   yuArzqdS8Ne4J0Rvbyb7IPPivHjFg8eS5Tjwv2H8ftJgY/iaxMiwLN6c0
   p/J/qO6xywK0bUjzWYv6BWfR8Xv6jJ1ROE/EVgfI3iRhy5jBDjwnvetXi
   /KCo3I6CvspvTmzhkGRfzydYrtXNxSJivi63eQ/N5d4RoUTAgTyC6r1ZM
   Q==;
X-CSE-ConnectionGUID: hQTwids8TaqVtJnIf+9urw==
X-CSE-MsgGUID: A76+KXwPRJm43NB6h7wcsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="37533993"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="37533993"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:39:24 -0700
X-CSE-ConnectionGUID: bBKy2rUhSF2IwwJ3cEGYFQ==
X-CSE-MsgGUID: w2QEMPdUQIK9iojHz7bxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140262545"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 22 May 2025 01:39:22 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI1SR-000P6q-1B;
	Thu, 22 May 2025 08:39:19 +0000
Date: Thu, 22 May 2025 16:38:59 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 6/8] virtio_net: enable gso over UDP tunnel
 support.
Message-ID: <202505221624.32GrJRU2-lkp@intel.com>
References: <239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/virtio-introduce-virtio_features_t/20250521-183700
base:   net-next/main
patch link:    https://lore.kernel.org/r/239bacdac9febd6f604f43fa8571aa2c44fd0f0b.1747822866.git.pabeni%40redhat.com
patch subject: [PATCH net-next 6/8] virtio_net: enable gso over UDP tunnel support.
config: i386-randconfig-011-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221624.32GrJRU2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221624.32GrJRU2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221624.32GrJRU2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function '__virtio_test_bit',
       inlined from 'virtio_has_feature' at include/linux/virtio_config.h:204:9,
       inlined from 'virtnet_probe' at drivers/net/virtio_net.c:6805:7:
>> include/linux/compiler_types.h:557:45: error: call to '__compiletime_assert_792' declared with attribute error: BUILD_BUG_ON failed: fbit >= VIRTIO_FEATURES_MAX
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:538:25: note: in definition of macro '__compiletime_assert'
     538 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:557:9: note: in expansion of macro '_compiletime_assert'
     557 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/virtio_config.h:152:17: note: in expansion of macro 'BUILD_BUG_ON'
     152 |                 BUILD_BUG_ON(fbit >= VIRTIO_FEATURES_MAX);
         |                 ^~~~~~~~~~~~


vim +/__compiletime_assert_792 +557 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  543  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  544  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  545  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  546  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  547  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  548   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  549   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  550   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  551   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  552   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  553   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  554   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  555   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  556  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @557  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

