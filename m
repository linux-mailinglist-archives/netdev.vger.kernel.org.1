Return-Path: <netdev+bounces-105140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCED90FCDB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA491C21BA2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CD3BBF1;
	Thu, 20 Jun 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxWnHD2B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2283BBC9
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865641; cv=none; b=QtvVT9oE7ccROzltGHASDVOBGMNyFKjHvI90+aBgAcqjD/F9sUxqntsOl8c7D+Q8w3kIOh/vDS4Dyd/xXRfhZFOvMIlGTfNGwUZhBvCYBj+WiuxxKAfjwXe1PYeJWuIz+132i4pMNZ6/yxPl0YFNvN6yFCUPM5uX40P7heeLMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865641; c=relaxed/simple;
	bh=HGIUdK74KQ1gCGAEZoHH0bCMvkFSbrAsO+df+QMfBiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5/KDUHm23yz/D7t1LrGLTnkL3nBXCDquXFv2WsbLTyrmXOxWRPT2McSs7BlKSwX2lN8yhiZs4twnEu1G7XohcLUwCB158PhXh6wnakK6nh78h+ChbGaJbkOfDhwcR5M/tGKE8Ip1+cAWLZ4CnNT91z0iC0oOlenENc0VIw5F+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxWnHD2B; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718865640; x=1750401640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HGIUdK74KQ1gCGAEZoHH0bCMvkFSbrAsO+df+QMfBiY=;
  b=VxWnHD2BM1yA1iSWJz+2RkysJWQpsZxbqqs7p3S5fYpnKic9YiWCVJZI
   KL7s7Ohkivy8MbH4sHMohIBQRowwXWcfBqiRlXTn9nw3mJb/u57Hg8dtS
   ALmOiXTvYf7LXuiM81MpDdfcMOZErkxwBupFEGNdefdhzMmoFb/JAek6g
   /FeEJpUkx6uvLMqabW0xx2F7L6qNiB57DfcDHn8CwYg7h/XxKH5ce+Fo4
   r9Hg52rpaeyfYochPmE+7vuzUOFWdbklg/pvH870IGHSEphGqBQn6Fvcc
   CI08gNxkMv1BQZmkWVWzYGljsZ+w42oyt5oACD2O0+s3ow37mb6DwyF7S
   Q==;
X-CSE-ConnectionGUID: Vv2MJGSHR1ChesumyGk82g==
X-CSE-MsgGUID: saj15dm8TEq/a4UgXsGoiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15962749"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15962749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:40:39 -0700
X-CSE-ConnectionGUID: pyan0ASjQpC+QPVR7chFXg==
X-CSE-MsgGUID: jRYMQxTHQ3qD3wFmesO+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="79615107"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Jun 2024 23:40:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKBTG-0007Oe-1Q;
	Thu, 20 Jun 2024 06:40:34 +0000
Date: Thu, 20 Jun 2024 14:40:03 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 5/5] virtio_net: improve dim command request
 efficiency
Message-ID: <202406201437.JuUEpbZL-lkp@intel.com>
References: <20240619161908.82348-6-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619161908.82348-6-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio_net-passing-control_buf-explicitly/20240620-002212
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240619161908.82348-6-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v4 5/5] virtio_net: improve dim command request efficiency
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240620/202406201437.JuUEpbZL-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201437.JuUEpbZL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201437.JuUEpbZL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_wait_command_response':
>> drivers/net/virtio_net.c:2771:22: warning: unused variable 'tmp' [-Wunused-variable]
    2771 |         unsigned int tmp;
         |                      ^~~


vim +/tmp +2771 drivers/net/virtio_net.c

2bef89a476bb44 Heng Qi   2024-06-20  2767  
2bef89a476bb44 Heng Qi   2024-06-20  2768  static bool virtnet_wait_command_response(struct virtnet_info *vi,
2bef89a476bb44 Heng Qi   2024-06-20  2769  					  struct control_buf *ctrl)
2bef89a476bb44 Heng Qi   2024-06-20  2770  {
2bef89a476bb44 Heng Qi   2024-06-20 @2771  	unsigned int tmp;
2bef89a476bb44 Heng Qi   2024-06-20  2772  	bool ok;
40cbfc37075a2a Amos Kong 2013-01-21  2773  
ff0de8d3002c75 Heng Qi   2024-06-20  2774  	wait_for_completion(&ctrl->completion);
40cbfc37075a2a Amos Kong 2013-01-21  2775  
74b2bc860d5cb5 Heng Qi   2024-06-20  2776  	ok = ctrl->status == VIRTIO_NET_OK;
30636258a7c917 Heng Qi   2024-05-30  2777  	return ok;
40cbfc37075a2a Amos Kong 2013-01-21  2778  }
40cbfc37075a2a Amos Kong 2013-01-21  2779  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

