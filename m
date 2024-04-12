Return-Path: <netdev+bounces-87502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44E8A3510
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4092E1C21434
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D714B08C;
	Fri, 12 Apr 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTiDXDmQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101614D457
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943865; cv=none; b=FZsXIhaYLEaSB5ClQPw5TihJqP/62v+Ua/MkTLssqdgGozZhmBw9JCyvlHsjt8RWHIeOLolFsI3xZGsdSWeRTG4jmrRwAZ7JfxOPehgH764NHRZSeaLwkj7CTNP2HuMx98V/Paq6PELR48MJ9L99ezHP4aw0JxjPJuXEcEOdIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943865; c=relaxed/simple;
	bh=cU9Zld5y/dB0PlW8Dnjr2/jnvo4ka3aIv5MoEQUiuz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNQzuJQU5ww2SbitRN8vFaw7rF2BXd+QTanPFQgiYfO6oe85B7cq+PljSx9yV0rjhn/Bl/9MDIswSJz06DulwcE5iXtmj25WLIpe7BENvh7vaXW7dyQYhXXtaoL5NNWXDu6Bq6qHZuoKC62zBhoA0auCpiXmsDac7uW/7g8TldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTiDXDmQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712943863; x=1744479863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cU9Zld5y/dB0PlW8Dnjr2/jnvo4ka3aIv5MoEQUiuz8=;
  b=dTiDXDmQSJyYjIYE1i8cfweScOtDT8JeZ5gQAHs1qTtQFLdM0HxPCp6L
   Gz+iyU+vwq6qbAHhg50BN/5GRSqwuqfHwE5R5v3PeN1iqL644gfRBfWwE
   EHPO+pMdVkq3dyj+Uw3fxsFj71VRGF7RfmPDNJTQMXnXld6jZg9BfzNlw
   8S1MXv+LWvZG+NNfEzjWw3/AfquYhyRmCkaivgr+CWlByQw8IGfECfsNr
   YjxAi/rfN5w8/gVjgmqVcKcdnoo9ncp6gQkswVsJiXhQkp7wUkyKaU1Vj
   iovYBEUagJAaeei/VwzwgP4XwfniuqKUCrfrIUUVbdtIMkNqKqJTZMdal
   g==;
X-CSE-ConnectionGUID: bH5l3IyEScW6qR63uXikXg==
X-CSE-MsgGUID: lue6wKMWTVuXas+tjw8AsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="18967213"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="18967213"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:44:22 -0700
X-CSE-ConnectionGUID: 7+/W9m2zR/aGaDs07cu5sw==
X-CSE-MsgGUID: cV7k5dlHRxeOm70S4pAnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21209324"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 12 Apr 2024 10:44:19 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvKwi-0000Pg-2s;
	Fri, 12 Apr 2024 17:44:16 +0000
Date: Sat, 13 Apr 2024 01:44:00 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202404130138.7jOMaraz-lkp@intel.com>
References: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240411-221400
base:   net-next/main
patch link:    https://lore.kernel.org/r/1712844751-53514-3-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v6 2/4] ethtool: provide customized dim profile management
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240413/202404130138.7jOMaraz-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240413/202404130138.7jOMaraz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404130138.7jOMaraz-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/dev.c: In function 'dev_dim_profile_init':
>> net/core/dev.c:10235:63: error: 'struct net_device' has no member named 'rx_eqe_profile'
   10235 |         int length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*dev->rx_eqe_profile);
         |                                                               ^~
   net/core/dev.c:10242:20: error: 'struct net_device' has no member named 'rx_eqe_profile'
   10242 |                 dev->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
         |                    ^~
   net/core/dev.c:10243:25: error: 'struct net_device' has no member named 'rx_eqe_profile'
   10243 |                 if (!dev->rx_eqe_profile)
         |                         ^~
   net/core/dev.c:10245:27: error: 'struct net_device' has no member named 'rx_eqe_profile'
   10245 |                 memcpy(dev->rx_eqe_profile, rx_profile[0], length);
         |                           ^~
>> net/core/dev.c:10248:20: error: 'struct net_device' has no member named 'rx_cqe_profile'
   10248 |                 dev->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
         |                    ^~
   net/core/dev.c:10249:25: error: 'struct net_device' has no member named 'rx_cqe_profile'
   10249 |                 if (!dev->rx_cqe_profile)
         |                         ^~
   net/core/dev.c:10251:27: error: 'struct net_device' has no member named 'rx_cqe_profile'
   10251 |                 memcpy(dev->rx_cqe_profile, rx_profile[1], length);
         |                           ^~
>> net/core/dev.c:10254:20: error: 'struct net_device' has no member named 'tx_eqe_profile'
   10254 |                 dev->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
         |                    ^~
   net/core/dev.c:10255:25: error: 'struct net_device' has no member named 'tx_eqe_profile'
   10255 |                 if (!dev->tx_eqe_profile)
         |                         ^~
   net/core/dev.c:10257:27: error: 'struct net_device' has no member named 'tx_eqe_profile'
   10257 |                 memcpy(dev->tx_eqe_profile, tx_profile[0], length);
         |                           ^~
>> net/core/dev.c:10260:20: error: 'struct net_device' has no member named 'tx_cqe_profile'
   10260 |                 dev->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
         |                    ^~
   net/core/dev.c:10261:25: error: 'struct net_device' has no member named 'tx_cqe_profile'
   10261 |                 if (!dev->tx_cqe_profile)
         |                         ^~
   net/core/dev.c:10263:27: error: 'struct net_device' has no member named 'tx_cqe_profile'
   10263 |                 memcpy(dev->tx_cqe_profile, tx_profile[1], length);
         |                           ^~
   net/core/dev.c: In function 'netif_free_profile':
   net/core/dev.c:11063:26: error: 'struct net_device' has no member named 'rx_eqe_profile'
   11063 |                 kfree(dev->rx_eqe_profile);
         |                          ^~
   net/core/dev.c:11066:26: error: 'struct net_device' has no member named 'rx_cqe_profile'
   11066 |                 kfree(dev->rx_cqe_profile);
         |                          ^~
   net/core/dev.c:11069:26: error: 'struct net_device' has no member named 'tx_eqe_profile'
   11069 |                 kfree(dev->tx_eqe_profile);
         |                          ^~
   net/core/dev.c:11072:26: error: 'struct net_device' has no member named 'tx_cqe_profile'
   11072 |                 kfree(dev->tx_cqe_profile);
         |                          ^~
--
   net/ethtool/coalesce.c: In function 'coalesce_fill_reply':
>> net/ethtool/coalesce.c:268:37: error: 'struct net_device' has no member named 'rx_eqe_profile'
     268 |                                  dev->rx_eqe_profile, supported) ||
         |                                     ^~
>> net/ethtool/coalesce.c:270:37: error: 'struct net_device' has no member named 'rx_cqe_profile'
     270 |                                  dev->rx_cqe_profile, supported) ||
         |                                     ^~
>> net/ethtool/coalesce.c:272:37: error: 'struct net_device' has no member named 'tx_eqe_profile'
     272 |                                  dev->tx_eqe_profile, supported) ||
         |                                     ^~
>> net/ethtool/coalesce.c:274:37: error: 'struct net_device' has no member named 'tx_cqe_profile'
     274 |                                  dev->tx_cqe_profile, supported))
         |                                     ^~
   net/ethtool/coalesce.c: In function '__ethnl_set_coalesce':
   net/ethtool/coalesce.c:479:44: error: 'struct net_device' has no member named 'rx_eqe_profile'
     479 |         ret = ethnl_update_profile(dev, dev->rx_eqe_profile,
         |                                            ^~
   net/ethtool/coalesce.c:484:44: error: 'struct net_device' has no member named 'rx_cqe_profile'
     484 |         ret = ethnl_update_profile(dev, dev->rx_cqe_profile,
         |                                            ^~
   net/ethtool/coalesce.c:489:44: error: 'struct net_device' has no member named 'tx_eqe_profile'
     489 |         ret = ethnl_update_profile(dev, dev->tx_eqe_profile,
         |                                            ^~
   net/ethtool/coalesce.c:494:44: error: 'struct net_device' has no member named 'tx_cqe_profile'
     494 |         ret = ethnl_update_profile(dev, dev->tx_cqe_profile,
         |                                            ^~


vim +10235 net/core/dev.c

 10232	
 10233	static int dev_dim_profile_init(struct net_device *dev)
 10234	{
 10235		int length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*dev->rx_eqe_profile);
 10236		u32 supported = dev->ethtool_ops->supported_coalesce_params;
 10237	
 10238		if (!(dev->priv_flags & (IFF_PROFILE_USEC | IFF_PROFILE_PKTS | IFF_PROFILE_COMPS)))
 10239			return 0;
 10240	
 10241		if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
 10242			dev->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
 10243			if (!dev->rx_eqe_profile)
 10244				return -ENOMEM;
 10245			memcpy(dev->rx_eqe_profile, rx_profile[0], length);
 10246		}
 10247		if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
 10248			dev->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
 10249			if (!dev->rx_cqe_profile)
 10250				return -ENOMEM;
 10251			memcpy(dev->rx_cqe_profile, rx_profile[1], length);
 10252		}
 10253		if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
 10254			dev->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
 10255			if (!dev->tx_eqe_profile)
 10256				return -ENOMEM;
 10257			memcpy(dev->tx_eqe_profile, tx_profile[0], length);
 10258		}
 10259		if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
 10260			dev->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
 10261			if (!dev->tx_cqe_profile)
 10262				return -ENOMEM;
 10263			memcpy(dev->tx_cqe_profile, tx_profile[1], length);
 10264		}
 10265	
 10266		return 0;
 10267	}
 10268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

