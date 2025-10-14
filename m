Return-Path: <netdev+bounces-229062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC05BD7CC7
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 158914ED322
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E62D3733;
	Tue, 14 Oct 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuY3hCJF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599216DC28
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425513; cv=none; b=R/ZsVjQV5ZUyd1CWQ4pogcmply22Fbcup9yWFWsL2VJOW4Tr1g9Mj5YZi3qMXEN0FAGBRvl2G62Bwi5gWrTAz+QTFBK3JsHHGQx/BcBH8cDMAXqowo0bR2C121Uw7oK5veIkQZZ7UguPPZxv0HESopRbGpCSQbrlYm5hOli6RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425513; c=relaxed/simple;
	bh=cTS3kltvXa9vuH/ZPoAtdRrh6V8hozTmr0+a02pB0xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEKsNXmJNkb1MV7vT1xgmc+pjHyJ8/ZfKLrAkHuG6bHZg9JpuxtdfXtZGOMCF35wR/cATTAjufexhpU3hs+NqgG8C20iHlrTwBXdg+PUaUCQG2BzN/yaMm3hwmUSPynCImEtf9IbLmMTPSWM9JftC8clcD6SC+JDJZzcx/yf7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuY3hCJF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760425512; x=1791961512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTS3kltvXa9vuH/ZPoAtdRrh6V8hozTmr0+a02pB0xI=;
  b=DuY3hCJF16S/lc2+zv148cZwNXRN0uei4Iwg80qWp588fZEpg4djnRHl
   2wm+jzZSjfyB20tDNx/hE9THTK8pcpsh8A3qDmhLFedWfFB08DF11J7g8
   4msCElrTGx+Edn3zp8TrBwrzSXooBoBWLt+Qg45HoefUbHaa3m2ftEub9
   aeQsoMade8YOkFgLdY2yWG4fvF8y7RJxivp57zK8kHZOZzX62KRgrRE9/
   AzwBuOnyc1WfTtRQtCRu4E95oZUsqNukIFrtpiSjB4rUYHEYJKmg9gPa3
   Qnau2qlduA7IMZFRf4gQpKEeiGezOdshZEbzsayjx5d8IKY31bC8jpNIO
   Q==;
X-CSE-ConnectionGUID: JZFecYtiSwihp2h5PfNg/A==
X-CSE-MsgGUID: EQuhBEs6T0WGpFIomsYOeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="74025358"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="74025358"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 00:05:11 -0700
X-CSE-ConnectionGUID: WcM7V1zjTdKxrl3caqohVw==
X-CSE-MsgGUID: 3bnlC+fmRfOlz/9DRmfxgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="185828237"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 14 Oct 2025 00:05:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8Z5R-0002V1-2g;
	Tue, 14 Oct 2025 07:04:54 +0000
Date: Tue, 14 Oct 2025 15:04:09 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v4 01/12] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <202510141404.P5SMiruH-lkp@intel.com>
References: <20251013152742.619423-2-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013152742.619423-2-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20251014-004146
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251013152742.619423-2-danielj%40nvidia.com
patch subject: [PATCH net-next v4 01/12] virtio_pci: Remove supported_cap size build assert
config: s390-randconfig-001-20251014 (https://download.01.org/0day-ci/archive/20251014/202510141404.P5SMiruH-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 39f292ffa13d7ca0d1edff27ac8fd55024bb4d19)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141404.P5SMiruH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141404.P5SMiruH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/virtio/virtio_pci_modern.c:326:26: error: no member named 'support_caps' in 'struct virtio_admin_cmd_query_cap_id_result'
     326 |         if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
         |                           ~~~~  ^
   include/linux/byteorder/generic.h:87:21: note: expanded from macro 'le64_to_cpu'
      87 | #define le64_to_cpu __le64_to_cpu
         |                     ^
   1 error generated.


vim +326 drivers/virtio/virtio_pci_modern.c

   304	
   305	static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
   306	{
   307		struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
   308		struct virtio_admin_cmd_query_cap_id_result *data;
   309		struct virtio_admin_cmd cmd = {};
   310		struct scatterlist result_sg;
   311		int ret;
   312	
   313		data = kzalloc(sizeof(*data), GFP_KERNEL);
   314		if (!data)
   315			return;
   316	
   317		sg_init_one(&result_sg, data, sizeof(*data));
   318		cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
   319		cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
   320		cmd.result_sg = &result_sg;
   321	
   322		ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
   323		if (ret)
   324			goto end;
   325	
 > 326		if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
   327			goto end;
   328	
   329		virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
   330	end:
   331		kfree(data);
   332	}
   333	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

