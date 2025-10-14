Return-Path: <netdev+bounces-229042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C8BD770D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF64EB66C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F3296BBD;
	Tue, 14 Oct 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AItdC9qr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7928727C
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420116; cv=none; b=lDgouZEyZdQQNP3F3DiQRoAW11AJ8yV1Ig6+ofMj5fgPQYBCPRyCNooC/Uqap3TOZLcrMqIy6/DejXV4/cWXrsoM+k56rvB78H4GpYUCZ8ts1wrnTJmwHuwa0AOrCHLLk5jshJbDuOLkGyX/lOZbs5hiLunz+uh2znGMCLpV1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420116; c=relaxed/simple;
	bh=wvn8CM5LXYun0vdXHMxoU4ZtILqmL0vMJS+JvrBjifY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CejF0y5S6tfcpUNEKEMGpqHZrYWjHfXhqTIdbMz6WFJrF/Z+HpiKCvVgIgsqbfeq+pxcW00BUVr3+UNPZ4BI9Vlk6B4v0mswID6B7W925xo4Y8LjQ6XsffNXjTSElHym1Nwm/soWk16aJs9lhYvsL0nDNoAMVQOQCWqPeitZ/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AItdC9qr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760420114; x=1791956114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvn8CM5LXYun0vdXHMxoU4ZtILqmL0vMJS+JvrBjifY=;
  b=AItdC9qrLUlqzpR6nY7Vx2Ywqrd56mmvLYkw4trPreROfeNfPmyANa2s
   ZJdlFiAtRb0k7hus4w2XWk7ECbhwvIFBE+HZVW+gOQ7owTUlU+/63uKfg
   wXdf5RiAb4c06jyeREUSCLg4KcOcRWTP/zWwKReEgHRcAT87dSfScYlxd
   o7AXNLq/GgSaU/OkFV6C9kLSFTs+7BTvCifxYdcF9Fz+dDLfrN1ABGXGz
   EIXwkkuzqwau5TCPQ84HO1TttItLnnmRkL9Ofjpr4tE5OCm4GzbwzWwba
   8i4aUKZ9LH677nBF7rv506/f24jh+t5SWhMq+zdREKOpkyIvssTfl4udJ
   A==;
X-CSE-ConnectionGUID: FpiwwnMKSa2HTjuXdU+5Cw==
X-CSE-MsgGUID: TXWBa2kURgudYYFteWpHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62607772"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62607772"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 22:35:13 -0700
X-CSE-ConnectionGUID: 3OHmFtQLTaOU8AUdGPdWFw==
X-CSE-MsgGUID: +YnTXWAXRxyO/QtXh2txIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="186041594"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 13 Oct 2025 22:35:09 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8Xgg-0002P9-0l;
	Tue, 14 Oct 2025 05:35:06 +0000
Date: Tue, 14 Oct 2025 13:28:10 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca,
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	edumazet@google.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next v4 01/12] virtio_pci: Remove supported_cap size
 build assert
Message-ID: <202510141339.ne1O8cPc-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio_pci-Remove-supported_cap-size-build-assert/20251014-004146
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251013152742.619423-2-danielj%40nvidia.com
patch subject: [PATCH net-next v4 01/12] virtio_pci: Remove supported_cap size build assert
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251014/202510141339.ne1O8cPc-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510141339.ne1O8cPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141339.ne1O8cPc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/qrwlock_types.h:6,
                    from arch/x86/include/asm/spinlock_types.h:7,
                    from include/linux/spinlock_types_raw.h:7,
                    from include/linux/ratelimit_types.h:7,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:103,
                    from arch/x86/include/asm/alternative.h:9,
                    from arch/x86/include/asm/segment.h:6,
                    from arch/x86/include/asm/ptrace.h:5,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from include/linux/sched.h:13,
                    from include/linux/delay.h:13,
                    from drivers/virtio/virtio_pci_modern.c:17:
   drivers/virtio/virtio_pci_modern.c: In function 'virtio_pci_admin_cmd_cap_init':
   drivers/virtio/virtio_pci_modern.c:326:33: error: 'struct virtio_admin_cmd_query_cap_id_result' has no member named 'support_caps'; did you mean 'supported_caps'?
     326 |         if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
         |                                 ^~~~~~~~~~~~
   include/uapi/linux/byteorder/little_endian.h:33:51: note: in definition of macro '__le64_to_cpu'
      33 | #define __le64_to_cpu(x) ((__force __u64)(__le64)(x))
         |                                                   ^
   drivers/virtio/virtio_pci_modern.c:326:15: note: in expansion of macro 'le64_to_cpu'
     326 |         if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
         |               ^~~~~~~~~~~
>> drivers/virtio/virtio_pci_modern.c:307:35: warning: unused variable 'vp_dev' [-Wunused-variable]
     307 |         struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
         |                                   ^~~~~~


vim +/vp_dev +307 drivers/virtio/virtio_pci_modern.c

bfcad518605d92 Yishai Hadas   2024-11-13  304  
bfcad518605d92 Yishai Hadas   2024-11-13  305  static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
bfcad518605d92 Yishai Hadas   2024-11-13  306  {
bfcad518605d92 Yishai Hadas   2024-11-13 @307  	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
bfcad518605d92 Yishai Hadas   2024-11-13  308  	struct virtio_admin_cmd_query_cap_id_result *data;
bfcad518605d92 Yishai Hadas   2024-11-13  309  	struct virtio_admin_cmd cmd = {};
bfcad518605d92 Yishai Hadas   2024-11-13  310  	struct scatterlist result_sg;
bfcad518605d92 Yishai Hadas   2024-11-13  311  	int ret;
bfcad518605d92 Yishai Hadas   2024-11-13  312  
bfcad518605d92 Yishai Hadas   2024-11-13  313  	data = kzalloc(sizeof(*data), GFP_KERNEL);
bfcad518605d92 Yishai Hadas   2024-11-13  314  	if (!data)
bfcad518605d92 Yishai Hadas   2024-11-13  315  		return;
bfcad518605d92 Yishai Hadas   2024-11-13  316  
bfcad518605d92 Yishai Hadas   2024-11-13  317  	sg_init_one(&result_sg, data, sizeof(*data));
bfcad518605d92 Yishai Hadas   2024-11-13  318  	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
16c22c56d42825 Daniel Jurgens 2025-03-04  319  	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
bfcad518605d92 Yishai Hadas   2024-11-13  320  	cmd.result_sg = &result_sg;
bfcad518605d92 Yishai Hadas   2024-11-13  321  
bfcad518605d92 Yishai Hadas   2024-11-13  322  	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
bfcad518605d92 Yishai Hadas   2024-11-13  323  	if (ret)
bfcad518605d92 Yishai Hadas   2024-11-13  324  		goto end;
bfcad518605d92 Yishai Hadas   2024-11-13  325  
c1e3216169ec0d Daniel Jurgens 2025-10-13 @326  	if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
bfcad518605d92 Yishai Hadas   2024-11-13  327  		goto end;
bfcad518605d92 Yishai Hadas   2024-11-13  328  
bfcad518605d92 Yishai Hadas   2024-11-13  329  	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
bfcad518605d92 Yishai Hadas   2024-11-13  330  end:
bfcad518605d92 Yishai Hadas   2024-11-13  331  	kfree(data);
bfcad518605d92 Yishai Hadas   2024-11-13  332  }
bfcad518605d92 Yishai Hadas   2024-11-13  333  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

