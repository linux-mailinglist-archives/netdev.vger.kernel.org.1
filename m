Return-Path: <netdev+bounces-241657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB6C87462
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA2DA4E2B91
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB929B8E0;
	Tue, 25 Nov 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eyd7T9Si"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2401A23B9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764107542; cv=none; b=E9lsd+5n5pdGKHKEfO0msmTJaj+4m372vTLzAz+R2BFf2qBT0wLPYYgUY3CDVLpHyH/t7KvVH0EnA6wVCUmWDyOUUUfuWGQw5J6Sc4QfM4WUXrsH59fQBjGKmduQQCymeRF6GjsQKh0Ye0gbbLO8G/raC2ydpP6qgDv0yDuXpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764107542; c=relaxed/simple;
	bh=TIqxXYgsu3/dkH6vSWbcMrsjlYAOpOsPxicecie+g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4R7XWL795Sb4mRaZK4G/qNpBpq0Qxle+8yrjaEpeXF2X2no/JcFw9CxsAnunTv9hoz9fjQb2Aa8OXp2EoDbe94jbLYSBYFZ7QSuTymQxLW14Grdx10LfbmCUQN8W4Bjgj9eX+2unp6SsOJE20+CkJJOX2HaHDp4mQldYkVtEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eyd7T9Si; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764107540; x=1795643540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TIqxXYgsu3/dkH6vSWbcMrsjlYAOpOsPxicecie+g1c=;
  b=Eyd7T9SinDl3/UXUlmPBLx3+5RiZqE1xtxZ/EDhNoKQR1ncQl0qh3UJc
   aGEQu+j1HXsXz0kDhvYhP39BFMLyubv16qAOpvP6zeyjJECmT0/nlRw43
   upTmz4m5yh5IVfGUOPjBtauzE60OTqV6K8D4Ds7ShCaqGL2yu/U/I+ilU
   tiDw4RKNRxO1185qeaCu+JSkY/qIdZW8DDeRuk92b7M5rpCSfIm5BmZwi
   1ESr5KP4HPimrhkf1eXPihXc4VlCC5iHC0BsPbP0oDLqnxD+5qOEY6AXX
   1SCQftoBUABcbsNF4Rh+cVMiPLR+8fqsSwnbibGKBN4GY6BgiDJMFhEJv
   A==;
X-CSE-ConnectionGUID: l1GqXPSeRHqvOW1xY6RoeQ==
X-CSE-MsgGUID: KlMuA8q2SPSr1DeAPbxLEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="69995385"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="69995385"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 13:52:20 -0800
X-CSE-ConnectionGUID: UOQ2mMBVQLCGq3aQF6OqwQ==
X-CSE-MsgGUID: I6Kj1vkjReGF5tpRavjI+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="191906346"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2025 13:52:18 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO0xL-000000002If-1ZmW;
	Tue, 25 Nov 2025 21:52:15 +0000
Date: Wed, 26 Nov 2025 05:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: test: move TX packetqueue from dst
 to dev
Message-ID: <202511260525.CqYIbVBg-lkp@intel.com>
References: <20251125-dev-mctp-test-tx-queue-v1-1-3a1daa4e99e1@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125-dev-mctp-test-tx-queue-v1-1-3a1daa4e99e1@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e05021a829b834fecbd42b173e55382416571b2c]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-mctp-test-move-TX-packetqueue-from-dst-to-dev/20251125-095938
base:   e05021a829b834fecbd42b173e55382416571b2c
patch link:    https://lore.kernel.org/r/20251125-dev-mctp-test-tx-queue-v1-1-3a1daa4e99e1%40codeconstruct.com.au
patch subject: [PATCH net-next] net: mctp: test: move TX packetqueue from dst to dev
config: arm64-randconfig-003-20251126 (https://download.01.org/0day-ci/archive/20251126/202511260525.CqYIbVBg-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260525.CqYIbVBg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260525.CqYIbVBg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mctp/test/utils.c:96:27: warning: unused variable 'test_pktqueue_magic' [-Wunused-const-variable]
      96 | static const unsigned int test_pktqueue_magic = 0x5f713aef;
         |                           ^~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/test_pktqueue_magic +96 net/mctp/test/utils.c

80bcf05e54e0e2 Jeremy Kerr 2025-07-02  95  
80bcf05e54e0e2 Jeremy Kerr 2025-07-02 @96  static const unsigned int test_pktqueue_magic = 0x5f713aef;
80bcf05e54e0e2 Jeremy Kerr 2025-07-02  97  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

