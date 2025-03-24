Return-Path: <netdev+bounces-177116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDD2A6DF5D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1BE3B1535
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D62620DF;
	Mon, 24 Mar 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzTLm1bl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6816261599
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832824; cv=none; b=jz+eR47LjH/TivLmkJzv7GVm8+QCIPzekaa3I/o7sWS1T7iePAc4kJxABHnJVclqIKwlh3F7lThoKskD4b5IUXMurG17gENeb4VAkbZMCgJiQczQr/eVIYl+DFjdfx+QZQ3h+bQ3yWTVj1KO/ayZLPp1RBecLmGgT+XnALIS5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832824; c=relaxed/simple;
	bh=ZBtOfr6N3EgQLV0iSa+TCG8FnMFYHlSlCnoT7UnJSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYInGrmTkOamUbKFrX+wN5BK4fHneTyCaSWH5lPpLwjYQor/u1RPDBqBWxOVdhTQrdQwjt3nOQyECHB4I8caMcgE3jNxBO7Ln4EMBE0ipZ7/0jhPRVjssXECNlAUGBMQ9J0KfQTvFiI7tNKF2xI/w+5UbHpRnpvlaeIvfYVTboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzTLm1bl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742832822; x=1774368822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZBtOfr6N3EgQLV0iSa+TCG8FnMFYHlSlCnoT7UnJSX8=;
  b=VzTLm1blBxz8Q+9cIyTznbquYsv4KPHFn3ejxWabgKvNvm/VQ3Lzb8ve
   +kCoKrBCNdiNlOWB/XNtSPjwFYwk5WzeE5hM0QED0ZUa0Ujw9dYiaYoVB
   zoEqHqnsKrY4QylR/IP8eClsyAThFfVNg+ExDRiZd6hxK2wmEG9BqD5IG
   mZryUM1zDeRaNoJjW6MrbQDpiMTB2PqO6nfa6gQQ8vCQ9gU+OlChYYaQQ
   VGh2NGOmxNC7dKIfYFy3eZYVt+KrSHOS218M30X4P2DghC72Yzm2goa/J
   hZbd43i//X8EVX9QGNsOHhpyaqaL10GDfjF2JOyvZiwgPd+OcT7loNOik
   w==;
X-CSE-ConnectionGUID: g4KGZKYBSWmwN0zSUinsQg==
X-CSE-MsgGUID: kGQnzVJvQWCyuEfxdN9PAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="61573610"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="61573610"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 09:13:41 -0700
X-CSE-ConnectionGUID: 1N+JwocdSlmh653H49vtvQ==
X-CSE-MsgGUID: bEEFwdAmSSypA8syF3vJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124109766"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Mar 2025 09:13:37 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twkQh-0003kH-0N;
	Mon, 24 Mar 2025 16:13:35 +0000
Date: Tue, 25 Mar 2025 00:13:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	willemb@google.com, Ahmed Zaki <ahmed.zaki@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] idpf: add flow steering
 support
Message-ID: <202503250010.XVQgpcvH-lkp@intel.com>
References: <20250324134939.253647-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324134939.253647-3-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/virtchnl2-add-flow-steering-support/20250324-215138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250324134939.253647-3-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next 2/2] idpf: add flow steering support
config: i386-buildonly-randconfig-003-20250324 (https://download.01.org/0day-ci/archive/20250325/202503250010.XVQgpcvH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250325/202503250010.XVQgpcvH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503250010.XVQgpcvH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3532:6: error: conflicting types for 'idpf_vport_is_cap_ena'; have 'bool(struct idpf_vport *, u16)' {aka '_Bool(struct idpf_vport *, short unsigned int)'}
    3532 | bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u16 flag)
         |      ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/idpf/idpf.h:24,
                    from drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:6:
   drivers/net/ethernet/intel/idpf/idpf_virtchnl.h:108:6: note: previous declaration of 'idpf_vport_is_cap_ena' with type 'bool(struct idpf_vport *, u64)' {aka '_Bool(struct idpf_vport *, long long unsigned int)'}
     108 | bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u64 flag);
         |      ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c: In function 'idpf_sideband_flow_type_ena':
>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3560:77: error: expected ')' before ';' token
    3560 |                 return !!(supp_ftypes & cpu_to_le64(VIRTCHNL2_FLOW_IPV4_UDP);
         |                          ~                                                  ^
>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3562:30: error: expected ';' before '}' token
    3562 |                 return false;
         |                              ^
         |                              ;
    3563 |         }
         |         ~                     
>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3564:1: error: control reaches end of non-void function [-Werror=return-type]
    3564 | }
         | ^
   cc1: some warnings being treated as errors


vim +3532 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

  3524	
  3525	/**
  3526	 * idpf_vport_is_cap_ena - Check if vport capability is enabled
  3527	 * @vport: Private data struct
  3528	 * @flag: flag(s) to check
  3529	 *
  3530	 * Return true if the capability is supported, false otherwise
  3531	 */
> 3532	bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u16 flag)
  3533	{
  3534		struct virtchnl2_create_vport *vport_msg;
  3535	
  3536		vport_msg = vport->adapter->vport_params_recvd[vport->idx];
  3537	
  3538		return !!(vport_msg->vport_flags & le16_to_cpu(flag));
  3539	}
  3540	
  3541	/**
  3542	 * idpf_sideband_flow_type_ena - Check if steering is enabled for flow type
  3543	 * @vport: Private data struct
  3544	 * @flow_type: flow type to check (from ethtool.h)
  3545	 *
  3546	 * Return true if sideband filters are allowed for @flow_type, false otherwise
  3547	 */
  3548	bool idpf_sideband_flow_type_ena(struct idpf_vport *vport, u32 flow_type)
  3549	{
  3550		struct virtchnl2_create_vport *vport_msg;
  3551		__le64 supp_ftypes;
  3552	
  3553		vport_msg = vport->adapter->vport_params_recvd[vport->idx];
  3554		supp_ftypes = vport_msg->sideband_flow_types;
  3555	
  3556		switch (flow_type) {
  3557		case TCP_V4_FLOW:
  3558			return !!(supp_ftypes & cpu_to_le64(VIRTCHNL2_FLOW_IPV4_TCP));
  3559		case UDP_V4_FLOW:
> 3560			return !!(supp_ftypes & cpu_to_le64(VIRTCHNL2_FLOW_IPV4_UDP);
  3561		default:
> 3562			return false;
  3563		}
> 3564	}
  3565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

