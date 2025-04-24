Return-Path: <netdev+bounces-185441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE8A9A5B9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A13A6F81
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC01207DF4;
	Thu, 24 Apr 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfq6RVfV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD7433B1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482911; cv=none; b=XbyoA78y1Y4p016tfPYTEpUone6Vm3VBfGxrFT2VYugVUBCvMmWAKC4KiaFiIwPs8AMYEnTxboABPSiC7D/HqhwenHqfhv5TBqqokTgbInq4KAE1ttT6fZAeGoX0EtNowddwyx7OpK/CpXu/TrN4c7zVRO4Lmsfgmh72Pq3LvDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482911; c=relaxed/simple;
	bh=OoRz6+XMxP7avmpWQ8rrAGV7dkXnoxI+asYjYstk7xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hz6La+s5cSbIB6FGSJ3YzsssUVDx550/xQ+7C4wx39gfX+bj/it1eQsXrKwHpWhu3DNp9w2x7UXxZIu5GeSJgnY2hyKYxf1qzmVT2YCixc99hHLj4q/x/M/7HUUP+w/M+NkHpN6aQgwmVhbPa8LoZI3ThOaNeqV6Bn689V1AyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfq6RVfV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745482909; x=1777018909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OoRz6+XMxP7avmpWQ8rrAGV7dkXnoxI+asYjYstk7xE=;
  b=bfq6RVfVlPWp8qxOX0FX6cUC74aTLT7KqUbXQxvrfL7Nv6ttuRsx8U7K
   6zXfZjnaeX5MpQMXPuH1AUlgkSJoI/UxGACjgCTe5MaqElsJWDjRLJVG0
   qX30KNguIJXfRLAP5kGjf4FWyJsXGy8tRNjebEo45ugL6FWxFm9AaoQkH
   b09AurRpGGnZzKNvc4Zu1oJ/hqSNglL4NaKuHzu8NYhSI8pUK1Cuh9siC
   4yTpKE3XBH3OFwM4m2Y686nEypAvKCAObXz9EWeulkweCOWGNs/Wbb9zS
   zkObOd1Cy3GDuCLTBUUi/0RCI+dDJ6whVnytrEFggOAJcwuNcRhV1SaK3
   g==;
X-CSE-ConnectionGUID: pkX/jwO2TNCfVzZmizm7vQ==
X-CSE-MsgGUID: U7/pycs3Q9+gtCh/HWk76Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50925930"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="50925930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 01:21:48 -0700
X-CSE-ConnectionGUID: paPdllX6RPC0crGe4+bHOQ==
X-CSE-MsgGUID: xKPshazXSOqFCwOwJiMWsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="155778203"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Apr 2025 01:21:47 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7rq4-0003yZ-0a;
	Thu, 24 Apr 2025 08:21:44 +0000
Date: Thu, 24 Apr 2025 16:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] bnxt_en: improve TX timestamping FIFO
 configuration
Message-ID: <202504241656.J2g5XHHz-lkp@intel.com>
References: <20250423103351.868959-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423103351.868959-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bnxt_en-improve-TX-timestamping-FIFO-configuration/20250423-185028
base:   net/main
patch link:    https://lore.kernel.org/r/20250423103351.868959-1-vadfed%40meta.com
patch subject: [PATCH net v3] bnxt_en: improve TX timestamping FIFO configuration
config: i386-buildonly-randconfig-004-20250424 (https://download.01.org/0day-ci/archive/20250424/202504241656.J2g5XHHz-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250424/202504241656.J2g5XHHz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504241656.J2g5XHHz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1129:6: warning: unused variable 'i' [-Wunused-variable]
    1129 |         int i;
         |             ^
   1 warning generated.


vim +/i +1129 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c

118612d519d83b Michael Chan 2021-06-27  1125  
118612d519d83b Michael Chan 2021-06-27  1126  void bnxt_ptp_clear(struct bnxt *bp)
118612d519d83b Michael Chan 2021-06-27  1127  {
118612d519d83b Michael Chan 2021-06-27  1128  	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
8aa2a79e9b95ea Pavan Chebbi 2024-06-28 @1129  	int i;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

