Return-Path: <netdev+bounces-180020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241F3A7F21C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB859167F05
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AF20A5EE;
	Tue,  8 Apr 2025 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moBlTtLi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DFB35948
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744075145; cv=none; b=NQhqTICvfkIuKWyyNp3AnQLj5GIcXTQ7FQ7sFDeVHZs1z2bXVeXIHOpWkgZV4/Z+0ia7ecTfFY/QkSRwsUsADfiQkXX/NA7Pjk1HR3quyUkiof6Gornhb/H4XYuB3jHjR4An1jjykBgEnqR3XLiYYhZg7h/2qLQN+ZszbdZqw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744075145; c=relaxed/simple;
	bh=VSkeGd5PncgxVjARyO1AavA2/8kZvt6nM30o6o8hmGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwDMLAyJbfhy8CJ8/IxnSneYqiJLNklaU0qeD09J41+xWHnijbpjn8MlGA2WAIpBSroJVjt7Jhn0eOhSaxQ9quT9+qO54lTZHqK8i3oIm6TqM9KjUn2BxOvhX5rRrxeQ4ggctjQkcrigf8H4h6Mez3yvuMxqz/x9JOJJW3lSk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moBlTtLi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744075143; x=1775611143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VSkeGd5PncgxVjARyO1AavA2/8kZvt6nM30o6o8hmGQ=;
  b=moBlTtLiVnqPefzqeIB79D3T5CYbqnwTplS99G4Mk8sIK3H/J48xNQiW
   CU67aQ6bmj7TmK1TyUoF6NbLf90dS1a1BXX8nk04qqN4teUGszxc1Ctdh
   QztB4zO4W8Kae+hHxrWXq9aMJ8FT7akUBGCYLxn9chfeGj1COPKFZCkJe
   dAQGbcCNbZ5WPFFT77EjRdTr6pe2M0/wcUnhdI1Y7gewEXbR2xai2t1Fx
   TOor/BF5eFjmfXgPLmUI4SDepqLCml7gLagTBL0KgTI7o6m8buy2O4woR
   EsmNwox9Sit99nX7w3O2W0fo7DVMQNEx0fRg8FD6gygyocUj5BAJ+Y4n8
   Q==;
X-CSE-ConnectionGUID: CW8jswePSmKrj7tfaIs97A==
X-CSE-MsgGUID: lmGNhc//QOqGGoFgK/5mRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44633269"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="44633269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 18:19:02 -0700
X-CSE-ConnectionGUID: EaTb4HsKRsWnO+emHoT0pw==
X-CSE-MsgGUID: QnH/JVTfQqOKqzGwswK6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="132837744"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 Apr 2025 18:19:00 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1xc9-0003xj-2a;
	Tue, 08 Apr 2025 01:18:57 +0000
Date: Tue, 8 Apr 2025 09:18:33 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <202504080803.VFV0rtz6-lkp@intel.com>
References: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407112005.85468-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/ice-use-DSN-instead-of-PCI-BDF-for-ice_adapter-index/20250407-192849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20250407112005.85468-1-przemyslaw.kitszel%40intel.com
patch subject: [PATCH iwl-net v2] ice: use DSN instead of PCI BDF for ice_adapter index
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20250408/202504080803.VFV0rtz6-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250408/202504080803.VFV0rtz6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504080803.VFV0rtz6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_adapter.c: In function 'ice_adapter_index':
>> drivers/net/ethernet/intel/ice/ice_adapter.c:21:27: error: expected expression before 'u32'
      21 |         return (u32)dsn ^ u32(dsn >> 32);
         |                           ^~~
   drivers/net/ethernet/intel/ice/ice_adapter.c:23:1: warning: control reaches end of non-void function [-Wreturn-type]
      23 | }
         | ^


vim +/u32 +21 drivers/net/ethernet/intel/ice/ice_adapter.c

    15	
    16	static unsigned long ice_adapter_index(u64 dsn)
    17	{
    18	#if BITS_PER_LONG == 64
    19		return dsn;
    20	#else
  > 21		return (u32)dsn ^ u32(dsn >> 32);
    22	#endif
    23	}
    24	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

