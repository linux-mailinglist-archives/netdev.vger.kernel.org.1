Return-Path: <netdev+bounces-230712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3631CBEDE8A
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 07:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 043F24E1AAA
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 05:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0421A434;
	Sun, 19 Oct 2025 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnEb356I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65427139D
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760852559; cv=none; b=girmk7nNnF5oio59NYwdNntKD2dvOWZ7nJuTlZqU1Q32TMhUQZt+VV36ptf6a8bTh3nrcvhaU9D26lFwRXaFRkbepngv2lqCR8GQUdmBEf43zVaalqK/elDLnwLt5nWHnwGcDkDy+MQwWRlq46ExliDljSNJNzM4UyrsI95Lz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760852559; c=relaxed/simple;
	bh=JwvyXEk5u7W/dNhcRhuFNYkPJTG9KPcmeDQEyLfTKwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK2hFeuLM0C8tNT/+3sE2ugzB3fBwylRCahomZ+gRiDdzBCHgxhn5WoNHGsFlX05E/1tjPhYoGBB+3RC4pOQx14EsEHD8Q7cj5sbYiLsQe0EEapwWpRnrrYsyChrGJ6UB7PomJyGmJkinPeNHVbro2VyCOMFRx6cmWhSnowgfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnEb356I; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760852558; x=1792388558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JwvyXEk5u7W/dNhcRhuFNYkPJTG9KPcmeDQEyLfTKwM=;
  b=ZnEb356IwaAYfQEp1mWoHj++8ICz4QHMsKIdxZsOlZXa6Z0O69r3RoTY
   XEf7K9Qa/Qvucc1HVAmUrQoxM0jpsGZje5WDurs2mqDTEXHn0CaWSq4FQ
   nphCu0UjNKS4GLAMq8EfAGn8nu5q7hG6cJfMe/c0giI1X2KLT1rvmJpLE
   AMqN4L5Imfi95PZefAP0j3kU6De2HHLu3WdPmTGlSw5mYDJEALO5o09Py
   aAD9+ZskiEBkpGtP3Duq6mS7ZMi8HQa+Iw/bpAsGfkOHv833rORjPxln7
   uSwFzZvOUeOzHKBa2JZrIFgg7zgpVGh/ap6wKJFNyMNNAeGo4OY91ObBX
   A==;
X-CSE-ConnectionGUID: etD/LFUHRHCkBGrZd5WBYw==
X-CSE-MsgGUID: tDvLF/3XRSa67nfaSzgdrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66844700"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66844700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:42:37 -0700
X-CSE-ConnectionGUID: Cr2lA1C4S4ukm6k8N8sLbQ==
X-CSE-MsgGUID: fFsTQQWeSlyZep3EjYx+nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="188159912"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 18 Oct 2025 22:42:35 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAMBc-0008sT-1e;
	Sun, 19 Oct 2025 05:42:32 +0000
Date: Sun, 19 Oct 2025 13:42:21 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam-sundar.S-k@amd.com, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: Re: [PATCH net-next v2 1/4] amd-xgbe: introduce support ethtool
 selftest
Message-ID: <202510191317.AG2Qwfkm-lkp@intel.com>
References: <20251017064704.3911798-2-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017064704.3911798-2-Raju.Rangoju@amd.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/amd-xgbe-introduce-support-ethtool-selftest/20251017-151230
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251017064704.3911798-2-Raju.Rangoju%40amd.com
patch subject: [PATCH net-next v2 1/4] amd-xgbe: introduce support ethtool selftest
config: xtensa-randconfig-002-20251019 (https://download.01.org/0day-ci/archive/20251019/202510191317.AG2Qwfkm-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510191317.AG2Qwfkm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510191317.AG2Qwfkm-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/net/ethernet/amd/xgbe/xgbe-selftest.o: in function `xgbe_test_loopback_validate':
>> xgbe-selftest.c:(.text+0x250): undefined reference to `ip_send_check'
   xtensa-linux-ld: drivers/net/ethernet/amd/xgbe/xgbe-selftest.o: in function `xgbe_test_mac_loopback':
   xgbe-selftest.c:(.text+0x4c2): undefined reference to `ip_send_check'
   xtensa-linux-ld: drivers/net/ethernet/amd/xgbe/xgbe-selftest.o: in function `xgbe_test_loopback_validate':
>> xgbe-selftest.c:(.text+0x260): undefined reference to `udp4_hwcsum'
   xtensa-linux-ld: drivers/net/ethernet/amd/xgbe/xgbe-selftest.o: in function `xgbe_test_mac_loopback':
   xgbe-selftest.c:(.text+0x5b2): undefined reference to `udp4_hwcsum'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

