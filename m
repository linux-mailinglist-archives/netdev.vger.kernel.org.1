Return-Path: <netdev+bounces-115466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0412E946710
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 05:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42D3281A91
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1514F519;
	Sat,  3 Aug 2024 03:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXtY5/50"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690BE546
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655627; cv=none; b=tmbR6lZGMN+ejstUNJle1Qj6gxkbtRwxl0Ugi/wNnC3UTMJxVYOLvffyjR43ufwcYtRxCrgadDfZMH9FJzLFul4KYaSGUIQk/KiWEjDs5Ytmpow2KhrExU954qyMrQ6Bc9pCyXW9llTyY7x3cvg7n07L+HS6IlqqwfAb/t36BwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655627; c=relaxed/simple;
	bh=t2g+cy/OjgVWTqCGmKuJZhUjGvTSGuqpZ6cCB8REBgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfYqe2UmDKLZ2x+5bnzDOQIsCCkH1iregmrSiiISb1MIq7KPvcWB8w87kpO5ur/DXOB5GdUxLCsEyoMHKIagGugt+A+fOF2MbyjYOr1rV/Q9xCPNJ9QpAgO+P5+NgOFnGKGQbYQ2NNKiXTw2DSFrBOEjhcPvEupQhZqvxBfupPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXtY5/50; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722655626; x=1754191626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t2g+cy/OjgVWTqCGmKuJZhUjGvTSGuqpZ6cCB8REBgQ=;
  b=aXtY5/500c+x3A3uT2xIhBdv24wKBXYe64pUdnFCSAGY2FmIC2kl2hZO
   erVSqA/8odgTT/pLcCbCH8eXKUtwlfP4yDFPCDoqhaZtQDVmnLUOmaYQr
   nfyEeue8P5WSkv/FLQEh9qkwk20A8IugKBQMhHYUJXSj1ss1wHMZ/fLh3
   Sq48hVgY+JR8Q6PZG+aQcjcUgYUw2Vrl7HQJbuOymywsT61dhwtcYfsPX
   KuCzsi7TAoWPBj1Gj8cnUGRk1p2DV7Mot0tHe1GECqLzIlBCf9HB9PSry
   uBhsNlL25IOLGE202c00XLbFlp3ZzvlckjLV+H3RM2SlfOE8W86dWjgNE
   A==;
X-CSE-ConnectionGUID: VvIpMYSYS8e8tNHnsEtdqw==
X-CSE-MsgGUID: MIYN/Jw2RzaRy/wl+xgrTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20267040"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="20267040"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 20:27:05 -0700
X-CSE-ConnectionGUID: rbqBfRUrRgiFVmVIqy1xHw==
X-CSE-MsgGUID: p6nMtJlYSXiU1nlVEpmJpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="60603074"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 02 Aug 2024 20:27:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa5Q5-000xxB-0e;
	Sat, 03 Aug 2024 03:27:01 +0000
Date: Sat, 3 Aug 2024 11:26:17 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org, felipe@sipanda.io
Cc: oe-kbuild-all@lists.linux.dev, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH 07/12] flow_dissector: Parse vxlan in UDP
Message-ID: <202408031144.ln4wxJc4-lkp@intel.com>
References: <20240731172332.683815-8-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731172332.683815-8-tom@herbertland.com>

Hi Tom,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.11-rc1 next-20240802]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Herbert/skbuff-Unconstantify-struct-net-argument-in-flowdis-functions/20240802-084418
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240731172332.683815-8-tom%40herbertland.com
patch subject: [PATCH 07/12] flow_dissector: Parse vxlan in UDP
config: i386-randconfig-062-20240802 (https://download.01.org/0day-ci/archive/20240803/202408031144.ln4wxJc4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408031144.ln4wxJc4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408031144.ln4wxJc4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/flow_dissector.c:780:16: sparse: sparse: restricted __be32 degrades to integer
   net/core/flow_dissector.c: note: in included file (through include/linux/if_pppox.h):
   include/uapi/linux/if_pppox.h:153:29: sparse: sparse: array of flexible structures

vim +780 net/core/flow_dissector.c

   760	
   761	static enum flow_dissect_ret
   762	__skb_flow_dissect_vxlan(const struct sk_buff *skb,
   763				 struct flow_dissector *flow_dissector,
   764				 void *target_container, const void *data,
   765				 __be16 *p_proto, int *p_nhoff, int hlen,
   766				 unsigned int flags)
   767	{
   768		struct vxlanhdr *hdr, _hdr;
   769		__be16 protocol;
   770	
   771		hdr = __skb_header_pointer(skb, *p_nhoff, sizeof(_hdr), data, hlen,
   772					   &_hdr);
   773		if (!hdr)
   774			return FLOW_DISSECT_RET_OUT_BAD;
   775	
   776		/* VNI flag always required to be set */
   777		if (!(hdr->vx_flags & VXLAN_HF_VNI))
   778			return FLOW_DISSECT_RET_OUT_BAD;
   779	
 > 780		if (hdr->vx_flags & VXLAN_F_GPE) {
   781			struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
   782	
   783			/* Need to have Next Protocol set for interfaces in GPE mode. */
   784			if (!gpe->np_applied)
   785				return FLOW_DISSECT_RET_OUT_BAD;
   786	
   787			/* The initial version is 0 */
   788			if (gpe->version != 0)
   789				return FLOW_DISSECT_RET_OUT_GOOD;
   790	
   791			/* "When the O bit is set to 1, the packet is an OAM packet and
   792			 * OAM so ignore
   793			 */
   794			if (gpe->oam_flag)
   795				return FLOW_DISSECT_RET_OUT_GOOD;
   796	
   797			protocol = tun_p_to_eth_p(gpe->next_protocol);
   798			if (!protocol)
   799				return FLOW_DISSECT_RET_OUT_GOOD;
   800		} else {
   801			protocol = htons(ETH_P_TEB);
   802		}
   803	
   804		*p_nhoff += sizeof(struct vxlanhdr);
   805		*p_proto = protocol;
   806	
   807		return FLOW_DISSECT_RET_PROTO_AGAIN;
   808	}
   809	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

