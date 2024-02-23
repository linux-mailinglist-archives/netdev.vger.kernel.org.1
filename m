Return-Path: <netdev+bounces-74317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BD860E11
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FAE286435
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CF25C8F1;
	Fri, 23 Feb 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YX/q6T4D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177D1A731
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680961; cv=none; b=EiO1ncg11vKfLqnSt0BFgNFFkiV90XGKmShMKvVtVbANeuTFOGWzbDxUxrEkxpA0s6hE7aOgTOouU9qa1h7ufCIM6pvVeWRhu7vGTsf3VcitsuqkIiWCgXdMMHirwlcuouYZf6O4EQoaJUSc3E6FC072zBEnM5rxApLIU+KkiNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680961; c=relaxed/simple;
	bh=P62c/gW3qUy4OC1LLVXVfdGjVFXf5PvIZI0YSta30b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOdHw7jFi0fsHmSahvFlB9kc62E6dr6zwxEViTsd7WGTMyqMylVy0xPVewh69/rskDv8PcFIBw8GrlKUkTqHtVg6lnlRSGGoow8jwCbkUu80xnW2cYfaDopiEapMUzm4St+xummROtshEWfXhEc65jUR9fU+0JdsU/kUkKoRRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YX/q6T4D; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708680960; x=1740216960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P62c/gW3qUy4OC1LLVXVfdGjVFXf5PvIZI0YSta30b4=;
  b=YX/q6T4DhEakC9ULfFPKRLUfmBdlCsIZJR+wCCK6R2lXKSiOUWlzSh5o
   5JfIbLa9Tx5R94Bgy8bjMFeOxRXHDEx7NpcFsbw/OFcuxETCptKH0INOG
   PtTKlEoWficinYsfwZ8/a7fJ7MMq/g6ID8136NWttn8UxTByDSi2HGMNK
   WajAfIkpOmvRmC2Ku23JQ5o6X9YVtqtiBRCVX6zc0g6uwAvDT3+6cf7SQ
   Vm2BAgr/dFnxp3fU5G6++XXVifvu1FC0YpY9jSc9h/NbZsP0J7VU32usM
   gEwwwvvjoOjIT3BwU5zDTs9P/NHWrdRixjkUG57fXdcVhiAdX4mLqViCf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6799479"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6799479"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 01:35:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="29019500"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 23 Feb 2024 01:35:57 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rdRxh-0007Hc-1J;
	Fri, 23 Feb 2024 09:35:33 +0000
Date: Fri, 23 Feb 2024 17:35:12 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH iwl-next 2/3] ice: avoid unnecessary devm_ usage
Message-ID: <202402231718.8mWcBppj-lkp@intel.com>
References: <20240222145025.722515-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222145025.722515-3-maciej.fijalkowski@intel.com>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.8-rc5]
[also build test WARNING on linus/master next-20240223]
[cannot apply to tnguy-next-queue/dev-queue tnguy-net-queue/dev-queue horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Fijalkowski/ice-do-not-disable-Tx-queues-twice-in-ice_down/20240222-225134
base:   v6.8-rc5
patch link:    https://lore.kernel.org/r/20240222145025.722515-3-maciej.fijalkowski%40intel.com
patch subject: [PATCH iwl-next 2/3] ice: avoid unnecessary devm_ usage
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240223/202402231718.8mWcBppj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240223/202402231718.8mWcBppj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402231718.8mWcBppj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_common.c: In function 'ice_update_link_info':
>> drivers/net/ethernet/intel/ice/ice_common.c:3242:32: warning: variable 'hw' set but not used [-Wunused-but-set-variable]
    3242 |                 struct ice_hw *hw;
         |                                ^~
--
   drivers/net/ethernet/intel/ice/ice_ethtool.c: In function 'ice_loopback_test':
>> drivers/net/ethernet/intel/ice/ice_ethtool.c:947:24: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
     947 |         struct device *dev;
         |                        ^~~


vim +/hw +3242 drivers/net/ethernet/intel/ice/ice_common.c

fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3221  
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3222  /**
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3223   * ice_update_link_info - update status of the HW network link
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3224   * @pi: port info structure of the interested logical port
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3225   */
5e24d5984c805c Tony Nguyen            2021-10-07  3226  int ice_update_link_info(struct ice_port_info *pi)
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3227  {
092a33d4031205 Bruce Allan            2019-04-16  3228  	struct ice_link_status *li;
5e24d5984c805c Tony Nguyen            2021-10-07  3229  	int status;
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3230  
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3231  	if (!pi)
d54699e27d506f Tony Nguyen            2021-10-07  3232  		return -EINVAL;
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3233  
092a33d4031205 Bruce Allan            2019-04-16  3234  	li = &pi->phy.link_info;
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3235  
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3236  	status = ice_aq_get_link_info(pi, true, NULL, NULL);
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3237  	if (status)
092a33d4031205 Bruce Allan            2019-04-16  3238  		return status;
092a33d4031205 Bruce Allan            2019-04-16  3239  
092a33d4031205 Bruce Allan            2019-04-16  3240  	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
092a33d4031205 Bruce Allan            2019-04-16  3241  		struct ice_aqc_get_phy_caps_data *pcaps;
092a33d4031205 Bruce Allan            2019-04-16 @3242  		struct ice_hw *hw;
092a33d4031205 Bruce Allan            2019-04-16  3243  
092a33d4031205 Bruce Allan            2019-04-16  3244  		hw = pi->hw;
f8543c3af0dcb2 Maciej Fijalkowski     2024-02-22  3245  		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
092a33d4031205 Bruce Allan            2019-04-16  3246  		if (!pcaps)
d54699e27d506f Tony Nguyen            2021-10-07  3247  			return -ENOMEM;
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3248  
d6730a871e68f1 Anirudh Venkataramanan 2021-03-25  3249  		status = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_TOPO_CAP_MEDIA,
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3250  					     pcaps, NULL);
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3251  
f8543c3af0dcb2 Maciej Fijalkowski     2024-02-22  3252  		kfree(pcaps);
092a33d4031205 Bruce Allan            2019-04-16  3253  	}
092a33d4031205 Bruce Allan            2019-04-16  3254  
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3255  	return status;
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3256  }
fcea6f3da546b9 Anirudh Venkataramanan 2018-03-20  3257  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

