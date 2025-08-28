Return-Path: <netdev+bounces-217999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F421DB3AC06
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915CA3A6781
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 20:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96041299927;
	Thu, 28 Aug 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAR4ffAL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1592777E8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414384; cv=none; b=RjDnz0xOJ/F1BArKSrKNv2TIHJSnRqGIIKVaVoU+YzCw2cO7ih0ZeSo5i4IvNhA4/qJOJXuY2ZBK05hGxSrIYnkr1cn5O0KE+1oBl/fgGRoZIkDhTyxULpe9CQRyEqzbRxwk3vtJoQG0dt9oQqKvvhFo2TepLi7NfxdF4zOxp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414384; c=relaxed/simple;
	bh=5k4UXkTHLn8z4Oqhg0CbDCeOCFaMpfeezWZxNb6d5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvVSkxqbOq2gmnXe5emd3T5RPraiFr+JX1oxlV4nO4mqJ6e+0RZRsQLqd0oy7Aw0AeOv+VuSJXlSNc1/69KCYW/TI4mInJWdnvJB1zVvT03VwkyT6MANX/QM9AcSWZC0kvK/RgLzY7TFTusL1VZamEsSqRsOcCCMSOrGSLwg/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAR4ffAL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756414383; x=1787950383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5k4UXkTHLn8z4Oqhg0CbDCeOCFaMpfeezWZxNb6d5ms=;
  b=gAR4ffALhpK2+6E8g+FmmQBfH4l9d6QYZQ3Drw1oGR5MmNcR2AYXizM8
   Gh56Qt77+prlPRFMVYGntmBY3kQ8amF1lcaK17rXGXIKXdYEUq1eooDYG
   3inxWgzIVjx5otPBbVaWinrlEcG4FZlkpODrjmvflNz9ZMSMW0URA2pUN
   i2lf3w2amKMwMpkXaUzuS4UZyiTYWtDc5GaRGnB+8xywdiMaQBh5gf3Au
   GGA6Aa9XNq0iFwQweJoBMkqPrpvLaOYkiqmQQqG5rdBCjJYfuca0w5pNp
   pRYjK5fB+O32Kw62bJdDa1ZRnk5kQv3Vcd1+7z5/JHiryIlUzaFnL2wx1
   w==;
X-CSE-ConnectionGUID: QELcau+cTIWGk2v4jXAGTQ==
X-CSE-MsgGUID: 3Moy/D0TQMGjZjipCoALKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76297159"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76297159"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 13:53:02 -0700
X-CSE-ConnectionGUID: jWEef5B0T1mlNZdvLmY8QQ==
X-CSE-MsgGUID: QpkpGfHbQ/WmTKACR6Ey1g==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 28 Aug 2025 13:52:59 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urjc9-000U3L-1H;
	Thu, 28 Aug 2025 20:52:57 +0000
Date: Fri, 29 Aug 2025 04:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com,
	virtualization@lists.linux.dev, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
	yohadt@nvidia.com, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net-next 05/11] virtio_net: Create a FF group for ethtool
 steering
Message-ID: <202508290458.9QTyiC0K-lkp@intel.com>
References: <20250827183852.2471-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827183852.2471-6-danielj@nvidia.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Jurgens/virtio-pci-Expose-generic-device-capability-operations/20250828-024128
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827183852.2471-6-danielj%40nvidia.com
patch subject: [PATCH net-next 05/11] virtio_net: Create a FF group for ethtool steering
config: x86_64-randconfig-121-20250828 (https://download.01.org/0day-ci/archive/20250829/202508290458.9QTyiC0K-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250829/202508290458.9QTyiC0K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508290458.9QTyiC0K-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/virtio_net/virtio_net_ff.c: note: in included file (through include/linux/virtio_admin.h):
   include/uapi/linux/virtio_net_ff.h:45:48: sparse: sparse: array of flexible structures
>> drivers/net/virtio_net/virtio_net_ff.c:99:13: sparse: sparse: restricted __le32 degrades to integer
>> drivers/net/virtio_net/virtio_net_ff.c:99:13: sparse: sparse: cast to restricted __le32
>> drivers/net/virtio_net/virtio_net_ff.c:103:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] groups_limit @@     got int @@
   drivers/net/virtio_net/virtio_net_ff.c:103:35: sparse:     expected restricted __le32 [usertype] groups_limit
   drivers/net/virtio_net/virtio_net_ff.c:103:35: sparse:     got int

vim +99 drivers/net/virtio_net/virtio_net_ff.c

    29	
    30	void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
    31	{
    32		struct virtio_admin_cmd_query_cap_id_result *cap_id_list __free(kfree) = NULL;
    33		size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
    34				      sizeof(struct virtio_net_ff_selector) *
    35				      VIRTIO_NET_FF_MASK_TYPE_MAX;
    36		struct virtio_net_resource_obj_ff_group ethtool_group = {};
    37		struct virtio_net_ff_selector *sel;
    38		int err;
    39		int i;
    40	
    41		cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
    42		if (!cap_id_list)
    43			return;
    44	
    45		err = virtio_device_cap_id_list_query(vdev, cap_id_list);
    46		if (err)
    47			return;
    48	
    49		if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
    50					 VIRTIO_NET_FF_RESOURCE_CAP) &&
    51		      VIRTIO_CAP_IN_LIST(cap_id_list,
    52					 VIRTIO_NET_FF_SELECTOR_CAP) &&
    53		      VIRTIO_CAP_IN_LIST(cap_id_list,
    54					 VIRTIO_NET_FF_ACTION_CAP)))
    55			return;
    56	
    57		ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
    58		if (!ff->ff_caps)
    59			return;
    60	
    61		err = virtio_device_cap_get(vdev,
    62					    VIRTIO_NET_FF_RESOURCE_CAP,
    63					    ff->ff_caps,
    64					    sizeof(*ff->ff_caps));
    65	
    66		if (err)
    67			goto err_ff;
    68	
    69		/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
    70		for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
    71			ff_mask_size += get_mask_size(i);
    72	
    73		ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
    74		if (!ff->ff_mask)
    75			goto err_ff;
    76	
    77		err = virtio_device_cap_get(vdev,
    78					    VIRTIO_NET_FF_SELECTOR_CAP,
    79					    ff->ff_mask,
    80					    ff_mask_size);
    81	
    82		if (err)
    83			goto err_ff_mask;
    84	
    85		ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
    86						VIRTIO_NET_FF_ACTION_MAX,
    87						GFP_KERNEL);
    88		if (!ff->ff_actions)
    89			goto err_ff_mask;
    90	
    91		err = virtio_device_cap_get(vdev,
    92					    VIRTIO_NET_FF_ACTION_CAP,
    93					    ff->ff_actions,
    94					    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
    95	
    96		if (err)
    97			goto err_ff_action;
    98	
  > 99		if (le32_to_cpu(ff->ff_caps->groups_limit < VIRTNET_FF_MAX_GROUPS)) {
   100			err = -ENOSPC;
   101			goto err_ff_action;
   102		}
 > 103		ff->ff_caps->groups_limit = VIRTNET_FF_MAX_GROUPS;
   104	
   105		err = virtio_device_cap_set(vdev,
   106					    VIRTIO_NET_FF_RESOURCE_CAP,
   107					    ff->ff_caps,
   108					    sizeof(*ff->ff_caps));
   109		if (err)
   110			goto err_ff_action;
   111	
   112		ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
   113		sel = &ff->ff_mask->selectors[0];
   114	
   115		for (int i = 0; i < ff->ff_mask->count; i++) {
   116			ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
   117			sel = (struct virtio_net_ff_selector *)((u8 *)sel + sizeof(*sel) + sel->length);
   118		}
   119	
   120		err = virtio_device_cap_set(vdev,
   121					    VIRTIO_NET_FF_SELECTOR_CAP,
   122					    ff->ff_mask,
   123					    ff_mask_size);
   124		if (err)
   125			goto err_ff_action;
   126	
   127		err = virtio_device_cap_set(vdev,
   128					    VIRTIO_NET_FF_ACTION_CAP,
   129					    ff->ff_actions,
   130					    sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
   131		if (err)
   132			goto err_ff_action;
   133	
   134		ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
   135	
   136		/* Use priority for the object ID. */
   137		err = virtio_device_object_create(vdev,
   138						  VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
   139						  VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
   140						  &ethtool_group,
   141						  sizeof(ethtool_group));
   142		if (err)
   143			goto err_ff_action;
   144	
   145		ff->vdev = vdev;
   146		ff->ff_supported = true;
   147	
   148		return;
   149	
   150	err_ff_action:
   151		kfree(ff->ff_actions);
   152	err_ff_mask:
   153		kfree(ff->ff_mask);
   154	err_ff:
   155		kfree(ff->ff_caps);
   156	}
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

