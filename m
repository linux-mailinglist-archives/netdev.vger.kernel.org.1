Return-Path: <netdev+bounces-64335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D48327B3
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB76D1F2248B
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A897482C0;
	Fri, 19 Jan 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEPE5F0t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19E481C6
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660321; cv=none; b=DzpSrm+HY3F/cUDc9iTrZl65UwBWN+3wDqeRlU9CpeSbA7GeXeJZqo9sdnwZSOHIZUUfe3u24QK+DBxYhoxq0JZID0KauEmXStySnQAuYtl+yOf4jmlhczSQl5AC5GWlXKORNy7/PCFOBSYM/zAByUyurjSPSmuwToS5Oa08OXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660321; c=relaxed/simple;
	bh=ugbG3rsqUiWrBnnSNz7P6Oi4cdnkEG1z83KyGg6hLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovCanD6HlFmoPflPJ76cwNWZGDN4ujOjXGIvvrvDIZ+BeG+HgK2wSJ36Lc6NakABfMeP4th5RYkDoORzfCRmcyvQ5UDfROmfMBO3msABxL3s3ezfEmF1y+KkFLnM4xwWYzUX894P9nsPdlyRYkcuhlfXoN+gSrnz6WYdfmu5RP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEPE5F0t; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705660319; x=1737196319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ugbG3rsqUiWrBnnSNz7P6Oi4cdnkEG1z83KyGg6hLZc=;
  b=oEPE5F0tEsD7eRbWX0FPlPlbLqM2LTpk5/GIZKzzudxFgY020rwDqsQz
   uRocyM7EFVUjDEbwPHrbuwXNpKO0CNHZCQON8Rx4BoeXxOkG/hXjL7WJn
   OJwwdX7VFuVHUGvFMxMCndTuHOcHNYnS2ekALEcHyzMsdH0yZdZVLGja4
   uCxzDBeFcoQZnqrsHkJ9yFC6fq62Egt77HuFRJgFTWjI1Ws02EQu1PKx3
   /HFT8tjhWz4XLlTaTeekcSyQ1Atqmz2pWQh+F7BBlBVI3TzTxzrNJLjbT
   zqpyFN2QjMIbUKxiMVULCoR8BS6j2EAl8z8BZbGAFmT85YPOsLb7U4JQq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7407071"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7407071"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 02:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="908295072"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="908295072"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2024 02:31:55 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQmAC-0003uy-37;
	Fri, 19 Jan 2024 10:31:52 +0000
Date: Fri, 19 Jan 2024 18:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of
 dim worker
Message-ID: <202401191807.RIhMHJ4U-lkp@intel.com>
References: <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/virtio-net-fix-possible-dim-status-unrecoverable/20240116-211306
base:   net-next/main
patch link:    https://lore.kernel.org/r/1705410693-118895-4-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of dim worker
config: i386-randconfig-012-20240119 (https://download.01.org/0day-ci/archive/20240119/202401191807.RIhMHJ4U-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240119/202401191807.RIhMHJ4U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401191807.RIhMHJ4U-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/virtio_net.c:3590:27: error: invalid application of 'sizeof' to an incomplete type 'struct virtnet_coal_entry'
    3590 |                     ctrl->num_entries * sizeof(struct virtnet_coal_entry));
         |                                         ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:3590:41: note: forward declaration of 'struct virtnet_coal_entry'
    3590 |                     ctrl->num_entries * sizeof(struct virtnet_coal_entry));
         |                                                       ^
   drivers/net/virtio_net.c:3658:27: error: invalid application of 'sizeof' to an incomplete type 'struct virtnet_coal_entry'
    3658 |                                 vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
         |                                                       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:3658:41: note: forward declaration of 'struct virtnet_coal_entry'
    3658 |                                 vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
         |                                                                     ^
   drivers/net/virtio_net.c:4544:31: error: invalid application of 'sizeof' to an incomplete type 'struct virtnet_coal_entry'
    4544 |                       vi->max_queue_pairs * sizeof(struct virtnet_coal_entry)), GFP_KERNEL);
         |                                             ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:4544:45: note: forward declaration of 'struct virtnet_coal_entry'
    4544 |                       vi->max_queue_pairs * sizeof(struct virtnet_coal_entry)), GFP_KERNEL);
         |                                                           ^
   drivers/net/virtio_net.c:4551:27: error: invalid application of 'sizeof' to an incomplete type 'struct virtnet_coal_entry'
    4551 |                                 vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
         |                                                       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/virtio_net.c:4544:45: note: forward declaration of 'struct virtnet_coal_entry'
    4544 |                       vi->max_queue_pairs * sizeof(struct virtnet_coal_entry)), GFP_KERNEL);
         |                                                           ^
   4 errors generated.


vim +3590 drivers/net/virtio_net.c

  3570	
  3571	static bool virtnet_add_dim_command(struct virtnet_info *vi,
  3572					    struct virtnet_batch_coal *ctrl)
  3573	{
  3574		struct scatterlist *sgs[4], hdr, stat, out;
  3575		unsigned out_num = 0;
  3576		int ret;
  3577	
  3578		/* Caller should know better */
  3579		BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
  3580	
  3581		ctrl->hdr.class = VIRTIO_NET_CTRL_NOTF_COAL;
  3582		ctrl->hdr.cmd = VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET;
  3583	
  3584		/* Add header */
  3585		sg_init_one(&hdr, &ctrl->hdr, sizeof(ctrl->hdr));
  3586		sgs[out_num++] = &hdr;
  3587	
  3588		/* Add body */
  3589		sg_init_one(&out, &ctrl->num_entries, sizeof(ctrl->num_entries) +
> 3590			    ctrl->num_entries * sizeof(struct virtnet_coal_entry));
  3591		sgs[out_num++] = &out;
  3592	
  3593		/* Add return status. */
  3594		ctrl->status = VIRTIO_NET_OK;
  3595		sg_init_one(&stat, &ctrl->status, sizeof(ctrl->status));
  3596		sgs[out_num] = &stat;
  3597	
  3598		BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
  3599		ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, ctrl, GFP_ATOMIC);
  3600		if (ret < 0) {
  3601			dev_warn(&vi->vdev->dev, "Failed to add sgs for command vq: %d\n.", ret);
  3602			return false;
  3603		}
  3604	
  3605		virtqueue_kick(vi->cvq);
  3606	
  3607		ctrl->usable = false;
  3608		vi->cvq_cmd_nums++;
  3609	
  3610		return true;
  3611	}
  3612	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

