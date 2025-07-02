Return-Path: <netdev+bounces-203535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D8AF650D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDF34A0694
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE09242D84;
	Wed,  2 Jul 2025 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRb+stCx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E23A99E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751494949; cv=none; b=dcHIY5HVYFamasLpgYIic6jx/yC8pmPunLJ99svf5gWOa38ryBWSVslL4QBBUo1Rb40nQiBqQzm6wIcbDXS5vX9hm5oOF+OZk5cilI50xBJOoVCi6D/OEdG9hxnnQxPMThnl0B9QFUBdZIRrhdrwiLaVeN5rGxg9UDJzMxlz58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751494949; c=relaxed/simple;
	bh=FSBB74AWOzBuoVgHVSZx4QTMQgURBguTlendXQ0fTd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKM1qIGaX0dXOnnvahqrXmumTwAFrb76KIR2AwS/NKZ+FOOqPcMqSjpNLRqrHdUMwg4aqqcvfX+OA2bHEeIJqyvGUbBCcVWycHRK46KwULTi9zsErm/GcfAzjb/5Ikzr1zmGOAy+9lqjIHNNpm0c0dOeIOBwiudHvZmbFaNKmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRb+stCx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751494947; x=1783030947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FSBB74AWOzBuoVgHVSZx4QTMQgURBguTlendXQ0fTd4=;
  b=HRb+stCx1jh+tYI850c17vLmxbM9QdVk+aWkMV3cOC6vtm392NR8v94F
   423k8rKTcnFYmcCD42DU9UcgrKRKbSDI+/4Py1p4SszeJZvtnDGv1mHQ6
   kgFjFqNvpZVkq7JFjQsnOaDC18vxbNJculqxOFvLV3izVTT06OlzOCrYy
   IbhDFNQhqg2oeuHTc/Is/F5GmdnnMPGHohMzyoJPp12PGTIHRIoNlxPHK
   sfuEtHmHFo96XfVs9kNBSznq8SZlqytLbcaAOt6qP+QfUau7IGqqrjoZp
   XKtmRSBkthXwHKsNHcjwBm4kwl/YFlZSEBa2FteFi29k1JXLVIi3KO6nv
   w==;
X-CSE-ConnectionGUID: wJ5mjWcyRtOkm9gMx1P+Ug==
X-CSE-MsgGUID: w1D99WWgT5a+5x83KjbPEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53532784"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53532784"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 15:22:27 -0700
X-CSE-ConnectionGUID: RnXJ9GouQQejLFyP6bGFRg==
X-CSE-MsgGUID: 6sHkjv7uSva8Ssp+ID+dWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="153644133"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2025 15:22:25 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uX5qQ-000187-2m;
	Wed, 02 Jul 2025 22:22:22 +0000
Date: Thu, 3 Jul 2025 06:21:50 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/8] net:
 s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Message-ID: <202507030614.bVvnbuna-lkp@intel.com>
References: <20250630164222.712558-5-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630164222.712558-5-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-s-dev_get_stats-netif_get_stats/20250701-004408
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250630164222.712558-5-sdf%40fomichev.me
patch subject: [PATCH net-next v2 4/8] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
config: i386-randconfig-002-20250702 (https://download.01.org/0day-ci/archive/20250703/202507030614.bVvnbuna-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250703/202507030614.bVvnbuna-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507030614.bVvnbuna-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module bridge uses symbol netif_pre_changeaddr_notify from namespace NETDEV_INTERNAL, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

