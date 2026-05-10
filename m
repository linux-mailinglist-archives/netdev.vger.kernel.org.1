Return-Path: <netdev+bounces-286246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKs7EJQaAGo3DAEAu9opvQ
	(envelope-from <netdev+bounces-286246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 07:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD79502B5B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 07:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9795F300D6B0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 05:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFDA355F53;
	Sun, 10 May 2026 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr6zAKhQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A33246EC;
	Sun, 10 May 2026 05:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391696; cv=none; b=RF17QBnPSyR9MOFXhAw7wPzehnmalqEIW1lwYYsUZhdU9M2A4CXXrw/lA1J4hNt+4OQhQZmFmFl8SB2U9Sk5g2B7poQjSkLH27xAiHY0+M1ksP60W3QcACgLBtGHlQR7X6aDV/F8qXiqwiCeXnQvp1yBuxALFRYBZ6If9ZaAKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391696; c=relaxed/simple;
	bh=3/cBV5AN1XLyEk9dRTOiyr96+0xqZLMWKK07nBoRzqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQwERmEZ6BulruTYeAQ8ILNXcY46gyQNr63bqdsdyoNUtL7hxMFJnIiWyQeyk+KjIXrcLckFCrHfG1KTpilaLC97YGRmu0vzdk3VKCR3adspjCtSkNbr4NYnoXDDDxQE/o6LK87lJGyDHJozeHTEuiDP85sLOtK/Cgkc1aG6/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr6zAKhQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778391694; x=1809927694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3/cBV5AN1XLyEk9dRTOiyr96+0xqZLMWKK07nBoRzqA=;
  b=mr6zAKhQl4dXIaTkrKUjDKjDuD3/nhdl/aotB7Hwbc1mjGBMLQOzJo6X
   3VoHpE3GfGS9z4cLJ90Q8MfjZdk/LP9Wp51zWNNtRTLxf/JFXQ6pJd2yk
   oCak4787TpDAiAzzbhNVVg/ErD/yJKXYXVbOCb6jA+lZH0ZZQQK7iqV0p
   FJlrPvzjUCnAnuNF9mZpQ2O7ga3UJEt+DUR7cn7hka6o2sdlkIQSg4lOk
   ywv06fkX2YdjxPtmF7MOJQBrvQhq1Thn4Hv3ChSJe++c4SzbzJnOP8k7F
   1WY3sOfY44y5Rvc0Xn4pL7t3QATUoSBT/KbMDuO1DS+usp66SUz4H5Kn3
   Q==;
X-CSE-ConnectionGUID: 2kxJ6MlwQmC+t2YYMQbewA==
X-CSE-MsgGUID: 53VX6PQoRM6dRwutKKS+Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="82930679"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="82930679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 22:41:34 -0700
X-CSE-ConnectionGUID: 00cOE35qRx6bZhiJ1dnfyg==
X-CSE-MsgGUID: Mx5aEHAvTyKZ++zOVUtDWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237247196"
Received: from lkp-server01.sh.intel.com (HELO 82327192134e) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 May 2026 22:41:31 -0700
Received: from kbuild by 82327192134e with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wLwuu-000000001nV-3WB9;
	Sun, 10 May 2026 05:41:28 +0000
Date: Sun, 10 May 2026 13:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: Re: [PATCH] netdevsim: Fix task hung by releasing bus lock before
 device ops
Message-ID: <202605101318.qbesSR5H-lkp@intel.com>
References: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
X-Rspamd-Queue-Id: 2DD79502B5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-286246-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url,git-scm.com:url]
X-Rspamd-Action: no action

Hi Jiakai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.1-rc2 next-20260508]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiakai-Xu/netdevsim-Fix-task-hung-by-releasing-bus-lock-before-device-ops/20260510-070550
base:   linus/master
patch link:    https://lore.kernel.org/r/20260509092837.3432281-1-xujiakai24%40mails.ucas.ac.cn
patch subject: [PATCH] netdevsim: Fix task hung by releasing bus lock before device ops
config: riscv-randconfig-001 (https://download.01.org/0day-ci/archive/20260510/202605101318.qbesSR5H-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260510/202605101318.qbesSR5H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605101318.qbesSR5H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/netdevsim/bus.c: In function 'new_device_store':
   drivers/net/netdevsim/bus.c:192:3: error: implicit declaration of function 'nsim_bus_dev_del'; did you mean 'nsim_bus_dev_new'? [-Werror=implicit-function-declaration]
      nsim_bus_dev_del(nsim_bus_dev);
      ^~~~~~~~~~~~~~~~
      nsim_bus_dev_new
   drivers/net/netdevsim/bus.c: At top level:
>> drivers/net/netdevsim/bus.c:206:13: warning: conflicting types for 'nsim_bus_dev_del'
    static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
                ^~~~~~~~~~~~~~~~
   drivers/net/netdevsim/bus.c:206:13: error: static declaration of 'nsim_bus_dev_del' follows non-static declaration
   drivers/net/netdevsim/bus.c:192:3: note: previous implicit declaration of 'nsim_bus_dev_del' was here
      nsim_bus_dev_del(nsim_bus_dev);
      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nsim_bus_dev_del +206 drivers/net/netdevsim/bus.c

f9d9db47d3ba873 Jiri Pirko 2019-04-25  205  
e05b2d141fef22c Jiri Pirko 2019-04-25 @206  static void nsim_bus_dev_del(struct nsim_bus_dev *nsim_bus_dev);
e05b2d141fef22c Jiri Pirko 2019-04-25  207  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

