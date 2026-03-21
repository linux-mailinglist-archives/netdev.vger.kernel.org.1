Return-Path: <netdev+bounces-270173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH86NF1DvmnPLAMAu9opvQ
	(envelope-from <netdev+bounces-270173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:06:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5482E3EA1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 08:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B5563020E8A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1D2FCC0E;
	Sat, 21 Mar 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuCaMmKA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F59364038;
	Sat, 21 Mar 2026 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774076762; cv=none; b=SJ4Mr3POQhk35jv6XeOcutSeTzSzMHvsjyv/ysndp8g7Vb6AlyDXxzEmoUzDkDgu5gk8kjVn4QJWYEZnRg32KtCOGBdVwZUFn0zeqmL7HARHH12UmSzAlNyDEIkY53p1W1qFqWCdxab3rsRcB+Kjn3PYy1eYIJb1c/ucxKxRSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774076762; c=relaxed/simple;
	bh=KRqBK57FGkee0BfVjeta0eb/i8eNKPuBr2r211bnX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeYCtYBN9NyGrTtAYrGgxyYnGmEMAoo8kliT6D5ooWzsOHbMLKxJr1MLX4pim7dtLxHyAnFpK3tpvDj8spRTQD6i7IsdCreOD0Hh5EFj8Sc6B2eB0w/H0XG5IKF7wO1wDUd3iFPvLGRL2G6dSJe6yvoCz64dM2arNjfFfiOPff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuCaMmKA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774076758; x=1805612758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KRqBK57FGkee0BfVjeta0eb/i8eNKPuBr2r211bnX4U=;
  b=UuCaMmKAVy1/Qofk8kElKOvWvwnJPZdQu3pn9bGN6QUGrHxqqaND8DGz
   J7iky9MwcHblrlo+JHyQSkvlZoHDwq3Xz9GRursL/9G2mdv6xxT7l7SE4
   2+t3SNlvTJUP2ZQJD0U6ctgxLsVJ/tzjYb523AGJ/KY7DwkxeU/59Nski
   uTIOAOUDixAAoO23GrJ35SaLDX32vbhXfmZatT3MUQOIU1n0LHAwjT2ju
   LHHoKdMRnyuHKSd2Yg8ZDhe4ZqCrLx0UIi/NjqGscIIUj1BdWbYPnoJp0
   jGhc+Z5BVcw5Johd2RhPklkZLK1qTl+4Vp66XN34UYS8CXQWgV3dGLPfu
   Q==;
X-CSE-ConnectionGUID: J0TDljGdQw26mEM0zRpBbQ==
X-CSE-MsgGUID: 0cZmO72XSruSBf0VghNsEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74338737"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="74338737"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 00:05:57 -0700
X-CSE-ConnectionGUID: JQwQrktiTg6CUfv2HTFRGg==
X-CSE-MsgGUID: uOKWvGm5S4++I0z4efNWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="247507726"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Mar 2026 00:05:53 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3qOn-000000000Pl-1vlC;
	Sat, 21 Mar 2026 07:05:34 +0000
Date: Sat, 21 Mar 2026 15:05:18 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sgoutham@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com,
	jiri@resnulli.us, chuck.lever@oracle.com, matttbe@kernel.org,
	cjubran@nvidia.com, shshitrit@nvidia.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH v6 net-next 2/5] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <202603211533.2z2Lepl1-lkp@intel.com>
References: <20260319055533.1720093-3-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319055533.1720093-3-rkannoth@marvell.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-270173-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D5482E3EA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ratheesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/octeontx2-af-npc-cn20k-debugfs-enhancements/20260320-133513
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260319055533.1720093-3-rkannoth%40marvell.com
patch subject: [PATCH v6 net-next 2/5] devlink: Implement devlink param multi attribute nested data values
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20260321/202603211533.2z2Lepl1-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211533.2z2Lepl1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211533.2z2Lepl1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c: In function 'mlx5e_pcie_cong_get_thresh_config':
>> drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c:279:1: warning: the frame size of 1320 bytes is larger than 1280 bytes [-Wframe-larger-than=]
     279 | }
         | ^


vim +279 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c

8890ee6dcf6e3d Dragos Tatulea 2025-07-15  250  
f4053490a6f651 Dragos Tatulea 2025-09-07  251  static int
f4053490a6f651 Dragos Tatulea 2025-09-07  252  mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
f4053490a6f651 Dragos Tatulea 2025-09-07  253  				  struct mlx5e_pcie_cong_thresh *config)
f4053490a6f651 Dragos Tatulea 2025-09-07  254  {
f4053490a6f651 Dragos Tatulea 2025-09-07  255  	u32 ids[4] = {
f4053490a6f651 Dragos Tatulea 2025-09-07  256  		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
f4053490a6f651 Dragos Tatulea 2025-09-07  257  		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
f4053490a6f651 Dragos Tatulea 2025-09-07  258  		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
f4053490a6f651 Dragos Tatulea 2025-09-07  259  		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
f4053490a6f651 Dragos Tatulea 2025-09-07  260  	};
f4053490a6f651 Dragos Tatulea 2025-09-07  261  	struct devlink *devlink = priv_to_devlink(dev);
f4053490a6f651 Dragos Tatulea 2025-09-07  262  	union devlink_param_value val[4];
f4053490a6f651 Dragos Tatulea 2025-09-07  263  
f4053490a6f651 Dragos Tatulea 2025-09-07  264  	for (int i = 0; i < 4; i++) {
f4053490a6f651 Dragos Tatulea 2025-09-07  265  		u32 id = ids[i];
f4053490a6f651 Dragos Tatulea 2025-09-07  266  		int err;
f4053490a6f651 Dragos Tatulea 2025-09-07  267  
f4053490a6f651 Dragos Tatulea 2025-09-07  268  		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
f4053490a6f651 Dragos Tatulea 2025-09-07  269  		if (err)
f4053490a6f651 Dragos Tatulea 2025-09-07  270  			return err;
f4053490a6f651 Dragos Tatulea 2025-09-07  271  	}
f4053490a6f651 Dragos Tatulea 2025-09-07  272  
f4053490a6f651 Dragos Tatulea 2025-09-07  273  	config->inbound_low = val[0].vu16;
f4053490a6f651 Dragos Tatulea 2025-09-07  274  	config->inbound_high = val[1].vu16;
f4053490a6f651 Dragos Tatulea 2025-09-07  275  	config->outbound_low = val[2].vu16;
f4053490a6f651 Dragos Tatulea 2025-09-07  276  	config->outbound_high = val[3].vu16;
f4053490a6f651 Dragos Tatulea 2025-09-07  277  
f4053490a6f651 Dragos Tatulea 2025-09-07  278  	return 0;
f4053490a6f651 Dragos Tatulea 2025-09-07 @279  }
f4053490a6f651 Dragos Tatulea 2025-09-07  280  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

