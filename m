Return-Path: <netdev+bounces-178503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BC5A775BB
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D4316238F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E21E47CA;
	Tue,  1 Apr 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbS+WIjQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5378F4F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743494186; cv=none; b=IcxxdUHPhEZbowFu2fc0Pql/+gi4rfsDhH2DsQyNqqxqEPX7hEgh3AD7Eu+Zmqxd1KzmV4DHQ3px7hqBl/AkiYf2hgTTclV/bK02Dg8gASZhN94WD/4hJKPMi5WoeYGgyQEALEzI/+H3NWvkEfF4EDFiMPrdXuxKOUpjnDsdIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743494186; c=relaxed/simple;
	bh=X6qgeS0xM+XYTRsqh64yeBywgfHt7rqHpnGr3FF/KmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7TdcOU5HtuLY82Iyc4Ryr0LwWqoT5s0kjmdNBwTMs9AsJtG29/rBPYTDJ/wC+yrxxjOAwxGeGGgRm3vLBzt1S5moPBP7wMCfdqZD8UYDqGMUexP08OLK5OjhF4056rd5T9FDuIjyWw9+1ENEmY7ZSoYHsG/qljQ47zeDnManlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbS+WIjQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743494184; x=1775030184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6qgeS0xM+XYTRsqh64yeBywgfHt7rqHpnGr3FF/KmM=;
  b=VbS+WIjQR5UntmfOgpOObtzv9snW2OzwmmAI501Cn8Nv/81TxOCfNxpW
   9uiBpYx3QOvNck6Ea5LTcxxsIVTIzn+AwwurgRb5CUKJ35DBA4OYGwwJK
   TQa8TLnym2iEy11RbXmfD6tcG7PD69vTcFge33jcyafEqpi1CmLsl3okl
   FyaMmAVaGo7GxVoisijaGMTnlV2n5zOuN4lqbVO3wIPEM5GxSpbffu9z9
   6GvFiXn0gBR33y/7+oZJyDrqplhJHPoi1CqmYKJOGaoQMt5BF59UvGe8z
   ZascsM9jvGWRYfKQtanPSVbaQ7qOrhubtSBBi/jEn0K5kebkDVTGYzkPG
   Q==;
X-CSE-ConnectionGUID: yoMyLhoVT8myx0xEVhOxEg==
X-CSE-MsgGUID: rllJ/IUhQ+KaNBvhzNMG1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44695339"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44695339"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 00:56:24 -0700
X-CSE-ConnectionGUID: juAFEvahQHykdk93/H+5lw==
X-CSE-MsgGUID: p4cFyYq8QWGDp7tSEDhruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="131525352"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Apr 2025 00:56:21 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tzWTj-0009iM-1e;
	Tue, 01 Apr 2025 07:56:13 +0000
Date: Tue, 1 Apr 2025 15:55:50 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v7 01/14] net: homa: define user-visible API for
 Homa
Message-ID: <202504011506.UcytJuoU-lkp@intel.com>
References: <20250331234548.62070-2-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331234548.62070-2-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20250401-080339
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250331234548.62070-2-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v7 01/14] net: homa: define user-visible API for Homa
config: i386-buildonly-randconfig-002-20250401 (https://download.01.org/0day-ci/archive/20250401/202504011506.UcytJuoU-lkp@intel.com/config)
compiler: clang version 20.1.1 (https://github.com/llvm/llvm-project 424c2d9b7e4de40d0804dd374721e6411c27d1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250401/202504011506.UcytJuoU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504011506.UcytJuoU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> usr/include/linux/homa.h:179: userspace cannot reference function or variable defined in the kernel
   usr/include/linux/homa.h:183: userspace cannot reference function or variable defined in the kernel

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

