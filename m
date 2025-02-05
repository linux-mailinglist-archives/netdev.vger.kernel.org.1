Return-Path: <netdev+bounces-162858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393DA282E5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671B63A1CC4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C07213E61;
	Wed,  5 Feb 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt/W6TUB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEA20C039;
	Wed,  5 Feb 2025 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726343; cv=none; b=BWMpXH0YkXGonfSsj1rpGL5WBk5dSSok4kHNyNsZ7Gcj40GsdMsXOvQC2cUn1g8KTNWa1CxrPsMBgqf3ue5QyehREPwbt36ndFsDkMN/gPu6C4y5u+ymrZRxbjeb684So0RByGB61dgiItskmGm/sFfBvQwYUCi3nG+9t1r81Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726343; c=relaxed/simple;
	bh=klYJIl0+wvehpCEm5K9mQSdweoz4f9zZumsx06HXCCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvwyJSx32tWYlz71i34BJvwJS6tXKVXAo/jhPit6/0yGFP11EXB35HSGFevNyCnxAl24RIgcUsXqG6LjzxE/xPSymG/yfk+blkKd/5kbsjOIPUTAdnis64y21duh2gpfSEn+N90KHwJBFc5y+OrZBygEObUt/ff794kgD5DoG0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt/W6TUB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738726342; x=1770262342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=klYJIl0+wvehpCEm5K9mQSdweoz4f9zZumsx06HXCCU=;
  b=Jt/W6TUB/FBL0Jme1VW9xY8MsVnqWz5pTHz/Uwg9gJBNE8P7FiXStbTl
   qekkX8pz5L09TMQspuwpWxXwQGKgaG4pctanG9dzTNWPq78VPcmqY0LoA
   a1JoLlWnmz5VHxTObttRw/ATSNAvcQg4ixUaAALvmCy9lsHD9I1Kn5kVk
   YoB7FNX+DcGuOxhaRqKH1KgKyUZdd9NVHhysv/apNRsaFf0FCtOPlOt05
   k112iNXsKnTRKiUcbVMMDWz0Tupgd6sWdBE/6udFjFc6OzfE65ZeigzAI
   M7s+aKGZLLLi3r7SaKC3hBo92BFSHBTnIvO1ewhPMK7inxlQMLVEeO7+j
   Q==;
X-CSE-ConnectionGUID: MMb78fT6SjOG6SF1/PUhkg==
X-CSE-MsgGUID: QTbqVhamSzmx9hkl+fMCdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38510535"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38510535"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 19:32:21 -0800
X-CSE-ConnectionGUID: XnCdLGk0SNysb2QuXHZiHA==
X-CSE-MsgGUID: ksosj32ARK2da/OeFaYFxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115390045"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Feb 2025 19:30:37 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tfW7W-000tMp-37;
	Wed, 05 Feb 2025 03:30:34 +0000
Date: Wed, 5 Feb 2025 11:29:49 +0800
From: kernel test robot <lkp@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 6/6] ice: enable LLDP TX
 for VFs through tc
Message-ID: <202502051116.UJMCGQWA-lkp@intel.com>
References: <20250204115111.1652453-7-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204115111.1652453-7-larysa.zaremba@intel.com>

Hi Larysa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Larysa-Zaremba/ice-fix-check-for-existing-switch-rule/20250204-200839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250204115111.1652453-7-larysa.zaremba%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v2 6/6] ice: enable LLDP TX for VFs through tc
config: csky-randconfig-r132-20250205 (https://download.01.org/0day-ci/archive/20250205/202502051116.UJMCGQWA-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250205/202502051116.UJMCGQWA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502051116.UJMCGQWA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_tc_lib.c:848:18: sparse: sparse: Initializer entry defined twice
   drivers/net/ethernet/intel/ice/ice_tc_lib.c:854:18: sparse:   also defined here

vim +848 drivers/net/ethernet/intel/ice/ice_tc_lib.c

   843	
   844	int ice_drop_vf_tx_lldp(struct ice_vsi *vsi, bool init)
   845	{
   846		struct ice_rule_query_data rule_added;
   847		struct ice_adv_rule_info rinfo = {
 > 848			.sw_act = {
   849				.fltr_act = ICE_DROP_PACKET,
   850				.flag = ICE_FLTR_TX,
   851			},
   852			.priority = 7,
   853			.flags_info.act_valid = true,
   854			.sw_act.src = vsi->idx,
   855			.src_vsi = vsi->idx,
   856			.sw_act.vsi_handle = vsi->idx,
   857		};
   858		struct ice_adv_lkup_elem list[3];
   859		struct ice_pf *pf = vsi->back;
   860		int err;
   861	
   862		if (!init && !vsi->vf->lldp_tx_ena)
   863			return 0;
   864	
   865		ice_rule_add_direction_metadata(&list[0]);
   866		ice_rule_add_src_vsi_metadata(&list[1]);
   867		list[2].type = ICE_ETYPE_OL;
   868		list[2].h_u.ethertype.ethtype_id = htons(ETH_P_LLDP);
   869		list[2].m_u.ethertype.ethtype_id = htons(0xFFFF);
   870	
   871		err = ice_add_adv_rule(&pf->hw, list, ARRAY_SIZE(list), &rinfo,
   872				       &rule_added);
   873		if (err) {
   874			dev_err(&pf->pdev->dev,
   875				"Failed to add an LLDP rule to VSI 0x%X: %d\n",
   876				vsi->idx, err);
   877		} else {
   878			vsi->vf->lldp_recipe_id = rule_added.rid;
   879			vsi->vf->lldp_rule_id = rule_added.rule_id;
   880			vsi->vf->lldp_tx_ena = false;
   881		}
   882	
   883		return err;
   884	}
   885	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

