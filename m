Return-Path: <netdev+bounces-81158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5468864FD
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 03:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7651F238F5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA61392;
	Fri, 22 Mar 2024 02:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgvtJ9La"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8165C
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073052; cv=none; b=Rv1sElp0P+LH3Rrq+pv4g5ZUVNu8+Unw9B9yWJf0ntdfG6WBpxCmG3GMdOEjwMoyjjLHWcr6z4mj9KF3z/fW1n73c+uWKzQ4bxbIoudYShHCrSWaDWxc3etM/fzPtq0a23eY9uZIEbYE/vKGoZaMnM6G1uKPQaruMoDi5ZQsPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073052; c=relaxed/simple;
	bh=3uqy2Uppc52InSO3KZVvz8PNc+CPSB6XHBZqlNjTr84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYZBuPCczfI+J1J+r4abK1A1JQMlfYtO38BZzKRziVArqbmIftxiOzWWwE8mHoaUAxV7OIIBM1CUp321D9dUtEahooPgUcI0FY8grjiRe60HyBauDhyxEph1X2r/F7CMNZ/UdmQGS+zqbs5BPaKR9b3ZgFFa7LJQLHJaRKLfFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgvtJ9La; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711073051; x=1742609051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3uqy2Uppc52InSO3KZVvz8PNc+CPSB6XHBZqlNjTr84=;
  b=TgvtJ9La4jzeaXM1zks9BiJhzqwsiUrrS2GfMyMqUbgnt2PXYXdGhhCQ
   8zCAgfkfW4HrpSpiOYLCtSO7yYW6QSvBGm33BVfKFVnT0pR3rB1i1Yhpt
   UcraFJvbZ6QKZawUEezT5FdtIymmLzRzyYsc7/JS+fDjivc5ZStyS/voo
   Fg+SoAvMpEgbM5mizucAJQjnh7rGGB7vM9Mxi7I6rDGVVacR7IBDsoB/i
   JbxH9yst9So0dXI7jhm29raEds19F/7PHZq9wAAnrQ7ORqxOyvnekMBbL
   zW+cOYS4JaYVFKsa3D7esWF1gqF/yGCvqq8GEDq+KkEwOxxRPMlf6YEqN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="23557405"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="23557405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 19:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="45722401"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Mar 2024 19:04:07 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnUGK-000Jvr-0B;
	Fri, 22 Mar 2024 02:04:04 +0000
Date: Fri, 22 Mar 2024 10:03:21 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
Message-ID: <202403220916.cSUxehuW-lkp@intel.com>
References: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20240321]
[cannot apply to v6.8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-fix-possible-dim-status-unrecoverable/20240321-194759
base:   linus/master
patch link:    https://lore.kernel.org/r/1711021557-58116-3-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240322/202403220916.cSUxehuW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240322/202403220916.cSUxehuW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403220916.cSUxehuW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/virtio_net.c:2564: warning: Function parameter or struct member 'vi' not described in 'virtnet_cvq_response'


vim +2564 drivers/net/virtio_net.c

  2552	
  2553	/**
  2554	 * virtnet_cvq_response - get the response for filled ctrlq requests
  2555	 * @poll: keep polling ctrlq when a NULL buffer is obtained.
  2556	 * @dim_oneshot: process a dim cmd then exit, excluding user commands.
  2557	 *
  2558	 * Note that user commands must be processed synchronously
  2559	 *  (poll = true, dim_oneshot = false).
  2560	 */
  2561	static void virtnet_cvq_response(struct virtnet_info *vi,
  2562					 bool poll,
  2563					 bool dim_oneshot)
> 2564	{
  2565		unsigned tmp;
  2566		void *res;
  2567	
  2568		while (true) {
  2569			res = virtqueue_get_buf(vi->cvq, &tmp);
  2570			if (virtqueue_is_broken(vi->cvq)) {
  2571				dev_warn(&vi->dev->dev, "Control vq is broken.\n");
  2572				return;
  2573			}
  2574	
  2575			if (!res) {
  2576				if (!poll)
  2577					return;
  2578	
  2579				cond_resched();
  2580				cpu_relax();
  2581				continue;
  2582			}
  2583	
  2584			/* this does not occur inside the process of waiting dim */
  2585			if (res == ((void *)vi))
  2586				return;
  2587	
  2588			virtnet_process_dim_cmd(vi, res);
  2589			/* When it is a user command, we must wait until the
  2590			 * processing result is processed synchronously.
  2591			 */
  2592			if (dim_oneshot)
  2593				return;
  2594		}
  2595	}
  2596	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

