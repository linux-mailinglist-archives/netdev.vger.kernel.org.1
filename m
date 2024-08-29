Return-Path: <netdev+bounces-123143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8771C963D08
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24DC7B23248
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F02B16CD32;
	Thu, 29 Aug 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lj3cc1JP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7916C873
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916654; cv=none; b=KLBe/UT5efjpF43cGOCSqw+KMiwE3PVQ6FKoWCrcqqgU1SSshy64+Sj2PJRa/FnuUpBUhLcgUfxtanC8R5odZ0JXx+6t5AaygPELgiPdCgfRfnlpOJvjXIPJERX8ma+dhMtVAniTV+2GQdMrxMZ3yAON2WG+FuGhhl7YiFziz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916654; c=relaxed/simple;
	bh=br5YSHH2dpsgd6ZsbLMoQl+gzHFga1+L7uA0e08Xg/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HceY4zca0JKhyrmakc3xiOySO+d9mwSNziv2LVCiXUXSpP8I5WKlWUTiqM1G0JZ3LUdGO/F1f3BMlyyBM5O9ltO5lalPdwcL/tiMaP8sG2uEfnrZUAihc8BEEusrvtSJyfFkfiVldhal4fQMvLOv/zV0tvVaqG5o6wy4khrLOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lj3cc1JP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724916653; x=1756452653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=br5YSHH2dpsgd6ZsbLMoQl+gzHFga1+L7uA0e08Xg/E=;
  b=Lj3cc1JPQMSo++udepTez5Fnv0fTkEdOjshmz+J9tNh/OkesvDhftS+U
   PvCgoWkdWsjSyn/fcypKQ2vH+yBzHiP2wczYkkvhRJe2NMq1NHCQuc3dF
   5SvFoZDDw5m7l30e5nm0RDNbuRBhd84+ukb8mKUtmxuDimEa2mYHhzrm5
   6j8zExSE4LuVKWme4hjpIJRPKw1DG8qz48/tLpm5ylRSKIrvf23+Z0a3J
   BELz+49n6luXsgQZNvR4lTvnZTJYTF+pH7xL1aZay3SHjkXHqsdQdHLGv
   lJyjlCJyZy+2DFdJrb+zTrKlLDLN7d6WQn8qrva8hdoZK26r0RXYJwKKq
   A==;
X-CSE-ConnectionGUID: LfHjCtWYTfyiBkHQnPy4iQ==
X-CSE-MsgGUID: 1uEPka8SSbCKBNFHIgvB4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23648921"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23648921"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 00:30:52 -0700
X-CSE-ConnectionGUID: 7Dk5lrEtSiCF1bpsASUzqw==
X-CSE-MsgGUID: l4XClNB/T3yBV4mscdRnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63173591"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 Aug 2024 00:30:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjZcG-000Lqw-10;
	Thu, 29 Aug 2024 07:30:48 +0000
Date: Thu, 29 Aug 2024 15:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>, jk@codeconstruct.com.au
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: mctp-serial: Add kunit test for
 next_chunk_len()
Message-ID: <202408291542.2o5GOBhQ-lkp@intel.com>
References: <20240827020803.957250-2-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827020803.957250-2-matt@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/net-mctp-serial-Add-kunit-test-for-next_chunk_len/20240827-101656
base:   net/main
patch link:    https://lore.kernel.org/r/20240827020803.957250-2-matt%40codeconstruct.com.au
patch subject: [PATCH net 1/2] net: mctp-serial: Add kunit test for next_chunk_len()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240829/202408291542.2o5GOBhQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408291542.2o5GOBhQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408291542.2o5GOBhQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/mctp/mctp-serial.c:541:24: error: initializing 'struct test_chunk_tx *' with an expression of type 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     541 |         struct test_chunk_tx *params = test->param_value;
         |                               ^        ~~~~~~~~~~~~~~~~~
   1 error generated.


vim +541 drivers/net/mctp/mctp-serial.c

   534	
   535	static void test_next_chunk_len(struct kunit *test)
   536	{
   537		struct mctp_serial devx;
   538		struct mctp_serial *dev = &devx;
   539		int next;
   540	
 > 541		struct test_chunk_tx *params = test->param_value;
   542	
   543		memset(dev, 0x0, sizeof(*dev));
   544		memcpy(dev->txbuf, params->input, params->input_len);
   545		dev->txlen = params->input_len;
   546	
   547		for (size_t i = 0; i < MAX_CHUNKS; i++) {
   548			next = next_chunk_len(dev);
   549			dev->txpos += next;
   550			KUNIT_EXPECT_EQ(test, next, params->chunks[i]);
   551	
   552			if (next == 0) {
   553				KUNIT_EXPECT_EQ(test, dev->txpos, dev->txlen);
   554				return;
   555			}
   556		}
   557	
   558		KUNIT_FAIL_AND_ABORT(test, "Ran out of chunks");
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

