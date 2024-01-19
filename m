Return-Path: <netdev+bounces-64355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99102832AAE
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 14:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2653C1F2530C
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1850A52F70;
	Fri, 19 Jan 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnfeSmic"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AC537E8
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671849; cv=none; b=OKXgoyp0KxydjXPTvOSrVX/0ZhkgWrYIB6UCfI13F6kdW42jeCvKvDClZUKAYusGSNMjrbes5mZiXjmnZ7j3dxUoAARizE+1a8VbLkNeBadepcOq7+y1xTLI7h9qnK/ByEr9ZZgZCkBnc32IzCnMCCJ9R/a9YTN8YeM3KvRg6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671849; c=relaxed/simple;
	bh=yekP/n1ePUQSKMBD5aaHMh0r+i3mnvJ1rjeCYWvngJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XohtsiLTpSN51rlgvgV2GHdz6jkPkEnBwo/Qjq18afu3WrEGHsukPopwz9Nh1qShJSg5Ee9j9AIhO/7MtrT+cYDSgLLcDWf6K8vfYiQtN5yjraB7cCBDxz5zo3H9qdgZj9hrvrlVqUCYDGX1scy0fox8DZ0Ty4TjCO+6IkN1Amc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnfeSmic; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671846; x=1737207846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yekP/n1ePUQSKMBD5aaHMh0r+i3mnvJ1rjeCYWvngJg=;
  b=JnfeSmicKgrU3208eV00yQKnv/5F2GICX7SriT4YN2qS/y6kVbHVTE3h
   Le19b6+2T40xSdB4WmZNb4mDVI+pGkKVyOwrTmEaZObeNV+wqwYxPO7bM
   FnUfhorrxl7qPevJ75zs1a+Joy+vRRZIi6L+O/E6/zFNlUnYt/lyMdL9i
   5ZtVFytNDXSONXBlLBFPb1eVPpmrQjGxdWwzDmad1/s2ahdkfNJhFaD7J
   JZkLw1Wg/LNX/lhRydbF6IgJDMWHejSuYK74LunE9mnphTHRNjSIfN/mD
   Baizm1uXXeuOlxjTZgpkUSbzDJsvaraYsw3gdPpkz0cxpX31vd4bc+qmn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="8120164"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="8120164"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:44:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="777993696"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="777993696"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Jan 2024 05:44:02 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQpA8-00046u-1i;
	Fri, 19 Jan 2024 13:44:00 +0000
Date: Fri, 19 Jan 2024 21:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] virtio-net: reduce the CPU consumption of
 dim worker
Message-ID: <202401192156.ZUNUJmuA-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240119 (https://download.01.org/0day-ci/archive/20240119/202401192156.ZUNUJmuA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240119/202401192156.ZUNUJmuA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401192156.ZUNUJmuA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/virtio_net.c: In function 'virtnet_add_dim_command':
>> drivers/net/virtio_net.c:3590:48: error: invalid application of 'sizeof' to incomplete type 'struct virtnet_coal_entry'
    3590 |                     ctrl->num_entries * sizeof(struct virtnet_coal_entry));
         |                                                ^~~~~~
   drivers/net/virtio_net.c: In function 'virtnet_rx_dim_work':
   drivers/net/virtio_net.c:3658:62: error: invalid application of 'sizeof' to incomplete type 'struct virtnet_coal_entry'
    3658 |                                 vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
         |                                                              ^~~~~~
   drivers/net/virtio_net.c: In function 'virtnet_alloc_queues':
   drivers/net/virtio_net.c:4544:52: error: invalid application of 'sizeof' to incomplete type 'struct virtnet_coal_entry'
    4544 |                       vi->max_queue_pairs * sizeof(struct virtnet_coal_entry)), GFP_KERNEL);
         |                                                    ^~~~~~
   drivers/net/virtio_net.c:4551:62: error: invalid application of 'sizeof' to incomplete type 'struct virtnet_coal_entry'
    4551 |                                 vi->max_queue_pairs * sizeof(struct virtnet_coal_entry));
         |                                                              ^~~~~~


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

