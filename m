Return-Path: <netdev+bounces-192570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8810FAC06D4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5589E10C5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC68D262FEA;
	Thu, 22 May 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS9j2jWV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1925486F
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901904; cv=none; b=s0jfylVxyvmdqvpROWQF1/cfqSVTq1uoCzFe7CFjICiqKkRq+xK2EdkqrfvESv5L8J7NiDPPb0tc4aZqAKCtT+jsV9ifd+OVDxyaii62VxeyiODi+8YDQtV8mVuWhdtCkhpt2SFSHS7DGUxrIGVgb7/NdrJd8r9HTztuY1xjBK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901904; c=relaxed/simple;
	bh=Jii8DnROvN5RU5vMD8/YqabKiAH1HBT7oUkPtkeEBJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw2vUI9wlNiivP31rF/UEb5Xt98UT6xX2p5KzHXeckK3RSZdinHMaJEv02sBhpwYQp5nuHHj6iR433RDZJz23P+91uW7Biw/Y0BV6OzXpoteNabGzQ5uy7dcHn/H2BGYxuxf5T1r25NgWSi+MjTOriKas6CHkWHK6fhrpAmV2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS9j2jWV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747901903; x=1779437903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jii8DnROvN5RU5vMD8/YqabKiAH1HBT7oUkPtkeEBJk=;
  b=LS9j2jWVsET+ZM0cyan1RaR+IhrhoG6wl1tUHB7xgD08BZyIpCdkVdue
   Mky7Wl9RdKISeVS0CBpxi3J2ow7/nAwK1o3OVR2LwumufZtmCLD7yFKse
   PtYoVD/dRsDzWDZ2dQixyARQFvV+KdpOagPR9hq65HkYh/aDxfOQ9zKjL
   cu6uYuZWYeB5Q6NVajKXV0qFcNOT0RCL7192t6E3pVTAatZmdpXZkLjXz
   cFhy1GhZdOiCatHOIGApNRe2eHTwrULEqjIEAz6V6aChQKtOHrhso0sin
   OMR0CNgTluT4kJfqNaSuZHqWxqqSWzV+tyZJrSJzfNS21f/QFuxpK2bg+
   g==;
X-CSE-ConnectionGUID: 415KHB5zT5yFRjHj5Lbxeg==
X-CSE-MsgGUID: Oh8mQSRLQomqgWVfUZCcYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53718799"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="53718799"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:18:23 -0700
X-CSE-ConnectionGUID: Tl/CSLl0SdGl4/VFYAnrCg==
X-CSE-MsgGUID: +qfZfjn6QQW0k58uiDjvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="145628796"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 22 May 2025 01:18:19 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI185-000P5c-0Q;
	Thu, 22 May 2025 08:18:17 +0000
Date: Thu, 22 May 2025 16:17:42 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
Message-ID: <202505221621.MhvgnFni-lkp@intel.com>
References: <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/virtio-introduce-virtio_features_t/20250521-183700
base:   net-next/main
patch link:    https://lore.kernel.org/r/9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni%40redhat.com
patch subject: [PATCH net-next 1/8] virtio: introduce virtio_features_t
config: x86_64-buildonly-randconfig-001-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221621.MhvgnFni-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221621.MhvgnFni-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221621.MhvgnFni-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/remoteproc/remoteproc_virtio.c:328:18: error: incompatible function pointer types initializing 'virtio_features_t (*)(struct virtio_device *)' (aka 'unsigned __int128 (*)(struct virtio_device *)') with an expression of type 'u64 (struct virtio_device *)' (aka 'unsigned long long (struct virtio_device *)') [-Wincompatible-function-pointer-types]
     328 |         .get_features   = rproc_virtio_get_features,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +328 drivers/remoteproc/remoteproc_virtio.c

ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  326  
9350393239153c drivers/remoteproc/remoteproc_virtio.c Stephen Hemminger 2013-02-10  327  static const struct virtio_config_ops rproc_virtio_config_ops = {
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20 @328  	.get_features	= rproc_virtio_get_features,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  329  	.finalize_features = rproc_virtio_finalize_features,
b49503eaf9c74c drivers/remoteproc/remoteproc_virtio.c Jiri Pirko        2024-07-08  330  	.find_vqs	= rproc_virtio_find_vqs,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  331  	.del_vqs	= rproc_virtio_del_vqs,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  332  	.reset		= rproc_virtio_reset,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  333  	.set_status	= rproc_virtio_set_status,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  334  	.get_status	= rproc_virtio_get_status,
92b38f851470f8 drivers/remoteproc/remoteproc_virtio.c Sjur Brændeland   2013-02-21  335  	.get		= rproc_virtio_get,
92b38f851470f8 drivers/remoteproc/remoteproc_virtio.c Sjur Brændeland   2013-02-21  336  	.set		= rproc_virtio_set,
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  337  };
ac8954a413930d drivers/remoteproc/remoteproc_rpmsg.c  Ohad Ben-Cohen    2011-10-20  338  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

