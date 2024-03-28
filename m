Return-Path: <netdev+bounces-83104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FB890CC9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5651E28F70D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A813B5BC;
	Thu, 28 Mar 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeFHU05B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330813173E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663108; cv=none; b=Vd+b/Y5TTuBkUQSBmL7WoM+cujZTsP0R2D7k9hqjWMmF028OdUBN1QFvSo6qsuTwM8NAt8e5eBVuZJpiee67GjY2mCF7kN5nj8DiTUfZjyYPCdyR13bFMB2ro38urCSWW3aTgbqBfk23GNmaFpob/I6LBaG62h+UWAPpbbq7sbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663108; c=relaxed/simple;
	bh=6BeKv7cynE9jXeLrlEUYf6ErJw5ak51OkXd65W8K8/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvBhHy5p3gdxUHEKOXB1LEC9mqS3lkdZsS0Kd3n7fcCuQ69oLViqMto5ilWTeajsQ/L/9kpJ36C9Xk/882TJSCx0zrhF8cioGp55d1W9wNlF1pvEvM2R07VqR0wK16k2A3/gikoGD2OZsE+O+Dqh8sb4SmlfDDh+5rJDLMqC88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeFHU05B; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711663106; x=1743199106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6BeKv7cynE9jXeLrlEUYf6ErJw5ak51OkXd65W8K8/M=;
  b=JeFHU05B0ARVPaZ/d268GtqzQOAHgBYaLoJuF36wLy7qKqzuyrZHA2Io
   mCv3n9USxO9S9YNortDmtlQrYSI7tMyPIxvLG7S9/bAf1DLpjwUqzG/AO
   seTXICJG3D8E0a/d6AajUb/hOdA+tvUrZm50WTUKxE8CdXc+T4jvoqWuL
   kP8XQGVptX2MSnS299iyNZTFYtrG8Tdwo7nysPXyUu64kCmWTuyKvMjyp
   snb6YIHDFxvBDeQQtdYcuZ3tqSocd7mO4Y+EWuptMvzenCLcl9FMXh1bB
   a6Cfbi87HVrmBzscuzYyARNHIcGepmLMJHVnonq7msGZbgNQzC3GQkTDY
   A==;
X-CSE-ConnectionGUID: kYwyjF7WSd6Hk5PkflKhVw==
X-CSE-MsgGUID: F0HabNYKT7mbyQN0fyQrAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24296237"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24296237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 14:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16817273"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Mar 2024 14:58:22 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpxlM-0002YA-2a;
	Thu, 28 Mar 2024 21:58:20 +0000
Date: Fri, 29 Mar 2024 05:58:14 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jiri@nvidia.com,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v2 2/6] virtio_net: Remove command data from
 control_buf
Message-ID: <202403290542.gM5D7hMG-lkp@intel.com>
References: <20240328044715.266641-3-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328044715.266641-3-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_net-Store-RSS-setting-in-virtnet_info/20240328-125022
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240328044715.266641-3-danielj%40nvidia.com
patch subject: [PATCH net-next v2 2/6] virtio_net: Remove command data from control_buf
config: x86_64-randconfig-122-20240328 (https://download.01.org/0day-ci/archive/20240329/202403290542.gM5D7hMG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403290542.gM5D7hMG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290542.gM5D7hMG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/virtio_net.c:3978:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __virtio64 @@
   drivers/net/virtio_net.c:3978:20: sparse:     expected unsigned long long [usertype]
   drivers/net/virtio_net.c:3978:20: sparse:     got restricted __virtio64

vim +3978 drivers/net/virtio_net.c

  3968	
  3969	static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
  3970	{
  3971		u64 *_offloads __free(kfree) = NULL;
  3972		struct scatterlist sg;
  3973	
  3974		_offloads = kzalloc(sizeof(*_offloads), GFP_KERNEL);
  3975		if (!_offloads)
  3976			return -ENOMEM;
  3977	
> 3978		*_offloads = cpu_to_virtio64(vi->vdev, offloads);
  3979	
  3980		sg_init_one(&sg, _offloads, sizeof(*_offloads));
  3981	
  3982		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
  3983					  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
  3984			dev_warn(&vi->dev->dev, "Fail to set guest offload.\n");
  3985			return -EINVAL;
  3986		}
  3987	
  3988		return 0;
  3989	}
  3990	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

