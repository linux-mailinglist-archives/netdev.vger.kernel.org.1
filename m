Return-Path: <netdev+bounces-123433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458E964D88
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF0C1F21EAD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2C1B81D1;
	Thu, 29 Aug 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+j9ymxn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CB1B5EC8;
	Thu, 29 Aug 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955278; cv=none; b=tOjHiHL5iAf90KEF4FaWnW6ga2j7gZJR7/kyLCZGxTWFqXCWIj/IKkz+cZYucmyZafOWB71o7cpzymCzStYt51qzbk3n2DP5GplYYqtmUp2hKT7L5s0UPVZHFKbjFDIFMFjjIDozHJwmfQ2RQySxfK6UTS8SdM/mfqKZfbKPE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955278; c=relaxed/simple;
	bh=M6mcSUoRdzWYWfsq9ko3pBxTfVmKKSZdqyPPcJZrNAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKtcgOMMFN46tfcgv3dLTydsaq6tLveSVeSqazQfNf1R1LH9Knu9exD1soapJ7pZyCI2GZtlvewjGXrBMxdquJvif54VM2in68gkHNAQgqW7IFfiguxoCn+K7SQWsQY2mZQAzTa6fTiyL0FrMuunV0GsvAqwcsBCdd/7TC+jQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+j9ymxn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955277; x=1756491277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M6mcSUoRdzWYWfsq9ko3pBxTfVmKKSZdqyPPcJZrNAs=;
  b=Y+j9ymxn9nNLn0hwWk4XwbI8XIvKa3uiaqcSZjf46KHpzEfucYCkEl0H
   nIyyY1hHOiWpSCSTPUtYt4gYF38QPWx99Buk3Yb/1kpT2ldfcOmhVH8FF
   6imxg/3Ub7F2r3gj9hbHBD/jygjgA463YrKRd3pwhVsyovZvzC3Xn8+Bk
   Q9hbMocUtMhX4g7iH5FPGxxgWaR2aLgHkfuKopQyIxoNgmfTulQ3MqZpB
   6i5VSXskVl45LNYpzLzACQ+Wm3Lijq4REAHhWGybLssBogTNOqV37HioH
   PuxqzKccYFb01po5hW2QWFJQlutFfPJoGsJ21yx1x6T8wIkQhtSycWDxY
   A==;
X-CSE-ConnectionGUID: EkcG6H0HQoi4hi/i8ZW7mA==
X-CSE-MsgGUID: IqF8Qxu2TrawIWM4taBJLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27449781"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27449781"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:36 -0700
X-CSE-ConnectionGUID: pmq6Ev5yQ7+8FRlvx2DKvg==
X-CSE-MsgGUID: xeAV+TSSR5SOooeaHQAGCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94399996"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Aug 2024 11:14:35 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjjfE-0000ao-0L;
	Thu, 29 Aug 2024 18:14:32 +0000
Date: Fri, 30 Aug 2024 02:14:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wan Junjie <junjie.wan@inceptio.ai>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"junjie.wan" <junjie.wan@inceptio.ai>
Subject: Re: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <202408300142.EN2CiiIs-lkp@intel.com>
References: <20240827110855.3186502-1-junjie.wan@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827110855.3186502-1-junjie.wan@inceptio.ai>

Hi Wan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc5 next-20240829]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wan-Junjie/dpaa2-switch-fix-flooding-domain-among-multiple-vlans/20240827-191121
base:   linus/master
patch link:    https://lore.kernel.org/r/20240827110855.3186502-1-junjie.wan%40inceptio.ai
patch subject: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240830/202408300142.EN2CiiIs-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300142.EN2CiiIs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300142.EN2CiiIs-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: In function 'dpaa2_switch_fdb_set_egress_flood':
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:179:18: warning: unused variable 'i' [-Wunused-variable]
     179 |         int err, i;
         |                  ^
   drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: In function 'dpaa2_switch_port_flood':
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:1782:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1782 |         if (err)
         |         ^~
   drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:1784:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1784 |                 return err;
         |                 ^~~~~~


vim +/i +179 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c

   175	
   176	static int dpaa2_switch_fdb_set_egress_flood(struct ethsw_core *ethsw, u16 fdb_id)
   177	{
   178		struct dpsw_egress_flood_cfg flood_cfg;
 > 179		int err, i;
   180	
   181		/* Setup broadcast flooding domain */
   182		dpaa2_switch_fdb_get_flood_cfg(ethsw, fdb_id, DPSW_BROADCAST, &flood_cfg);
   183		err = dpsw_set_egress_flood(ethsw->mc_io, 0, ethsw->dpsw_handle,
   184					    &flood_cfg);
   185		if (err) {
   186			dev_err(ethsw->dev, "dpsw_set_egress_flood() = %d\n", err);
   187			return err;
   188		}
   189	
   190		/* Setup unknown flooding domain */
   191		dpaa2_switch_fdb_get_flood_cfg(ethsw, fdb_id, DPSW_FLOODING, &flood_cfg);
   192		err = dpsw_set_egress_flood(ethsw->mc_io, 0, ethsw->dpsw_handle,
   193					    &flood_cfg);
   194		if (err) {
   195			dev_err(ethsw->dev, "dpsw_set_egress_flood() = %d\n", err);
   196			return err;
   197		}
   198	
   199		return 0;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

