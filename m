Return-Path: <netdev+bounces-177171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE159A6E279
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2263B1D95
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DEE257448;
	Mon, 24 Mar 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c783lp/K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1C264A97
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841257; cv=none; b=qnu+JMl17nwO4UWDxfv1a70Fz6Bg29oSb4M3dm7UPPty80J2VymNa78hlndTfjNbWj6nHEBEMMBaukkYseHmOvUNFoiaYfzRdSEWmvkcLhomDgFA9yHwdADPMyIDx7FDlEfoPCnMu3A8L2/oT0ruT2B5TIzxuKKagnhPhrYwrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841257; c=relaxed/simple;
	bh=QkioRVw7TRFRDmFV8kPpFQmYnT0X9PvxxTgJT1b6bEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evNAA42lw5JnuZjhqC805m/WAFwB6FYRIgnUZ/JxpEl4oQd3rpHtjy+1XXYSi6NliK5CsO/NL93zdpyip+cWhPXDSXxf+D0Dri7UXE+xYIm6HfolyW51FevBLrwUjUjKwEnHWExmpZlXyRRWM2JXwtPAa7zVFp4AsHT6Qo8UIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c783lp/K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742841256; x=1774377256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QkioRVw7TRFRDmFV8kPpFQmYnT0X9PvxxTgJT1b6bEc=;
  b=c783lp/Ki1d3OW9UoS5eq5GSw2vbMuWPUWsFOgI9VbLsTIIGIWRsDCF6
   up5bLoFjoH0miaAF2jTl4NrkoH8LM7AwX943nRpoKvmnW8GMlJqM4haEu
   ppOACa0n2eZ7jlJYEWfuW2YDdKBpCgDJegBoQqX0xgQ1HhD6KJji11rGn
   Lzs3b54JkKdNoGjJWKs19CZ4zqrP00c3RecijcyIKncZjFCbsaesEBt/R
   EO2if7kPkYWboELG47dsS6QzIDjlcI5d/xhti+MCuDW+kcOrHsnybXJmN
   2V3Y1lNUsjk6oyMI4JiF334aabXcUv7WCci/bfpNS2IzZfGF4i++VFLql
   g==;
X-CSE-ConnectionGUID: xwrLJZBZRbewWopg+OG67g==
X-CSE-MsgGUID: Rtcsl4uPSvKzi8d3kmX0UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="54702726"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="54702726"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 11:34:15 -0700
X-CSE-ConnectionGUID: 0FRpxUlUQ9q7rT29U8ALZQ==
X-CSE-MsgGUID: 8JkvYv9PSjGQS/WsvmAUxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124591694"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 24 Mar 2025 11:34:12 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1twmcj-0003rx-2g;
	Mon, 24 Mar 2025 18:34:09 +0000
Date: Tue, 25 Mar 2025 02:33:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, almasrymina@google.com, willemb@google.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] idpf: add flow steering
 support
Message-ID: <202503250234.USFLMuAQ-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250325/202503250234.USFLMuAQ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250325/202503250234.USFLMuAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503250234.USFLMuAQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3532:6: error: conflicting types for 'idpf_vport_is_cap_ena'
    3532 | bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u16 flag)
         |      ^
   drivers/net/ethernet/intel/idpf/idpf_virtchnl.h:108:6: note: previous declaration is here
     108 | bool idpf_vport_is_cap_ena(struct idpf_vport *vport, u64 flag);
         |      ^
>> drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3560:63: error: expected ')'
    3560 |                 return !!(supp_ftypes & cpu_to_le64(VIRTCHNL2_FLOW_IPV4_UDP);
         |                                                                             ^
   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3560:12: note: to match this '('
    3560 |                 return !!(supp_ftypes & cpu_to_le64(VIRTCHNL2_FLOW_IPV4_UDP);
         |                          ^
   2 errors generated.


vim +/idpf_vport_is_cap_ena +3532 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c

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
  3562			return false;
  3563		}
  3564	}
  3565	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

