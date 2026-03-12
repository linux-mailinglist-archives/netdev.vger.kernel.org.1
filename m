Return-Path: <netdev+bounces-266954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGwmDYWFsml4NQAAu9opvQ
	(envelope-from <netdev+bounces-266954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829826F792
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4F353022F81
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A434282F1C;
	Thu, 12 Mar 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d//vKsPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6987223BD05
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307266; cv=none; b=Gk+Y7AoiUmPqZVyzh2VkZiBH2DILPi6v3OoGqrOZbjwb93II8F8NNgT8PlCZJySKBeukQ5tPBL2+X/k+TJfkAaY1VGgQHTAKF6/BtRJjjnHM9aHA1plgcPMmWa1qTj8eHerW/yiLAQeQoHGedJGjBWa25apcnp23TnE5VbTal+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307266; c=relaxed/simple;
	bh=PSfQXHav3C0tSuD/OTS61QwfCk1GGT0dCfZRYWKuC3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNv9gt0478mROm0nUlfe6k15/PIaLl7nTvp9KvvIptDK7hGYYTK8ULvghOHYrQj+otfJ8o6ALQ4ySX7lKIwpsYmezKJO8/8bGc7WMSvQe9jXN/i4othCHpJ0kwi1fWoJkerNMOoC5I7eQE5g02VFBQk9ND1gE0yINfZ8aRe9TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d//vKsPQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773307263; x=1804843263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSfQXHav3C0tSuD/OTS61QwfCk1GGT0dCfZRYWKuC3s=;
  b=d//vKsPQsrPhKudfnr0ADdl3ZBVSB292TRnMBqtTlj8mtcuYbV55LnSs
   p3H3k/aQW+hk2kIZRIwmwahTgFbjvqBXbutXMGlR1Wd8+EdyvyQ0W6144
   p+/47WzW4yobxbj7m1ldgjnvE84kuhW7jwgt+0gTRgIGp0oyHY5vUZBBX
   /2/VcvmVygT5at6W5TJ//acvnqsS3AOhPTro3ehC+VvKZFwD3flUXBAYk
   R15CWJSOYZfUSNmg9hxVd/UEgK/u40oZY0NplimmJaQ56U4aX+hpCFUO5
   di2nmzQNVyvLn1ewgBC3NJ9ISZ5UIGwi9iTH6imBCxnTjqDerosB5dM0S
   w==;
X-CSE-ConnectionGUID: TJ0dYkTaSyK2WHsZBp8c5A==
X-CSE-MsgGUID: mMcIT9z/TVuqyrn4eeTQYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85478516"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85478516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:21:03 -0700
X-CSE-ConnectionGUID: KlaPLjGcSM6py3Ba7wFbdw==
X-CSE-MsgGUID: YJ3xSlcyQd6LMZoc7uWdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251253771"
Received: from lkp-server01.sh.intel.com (HELO 418530b1a366) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Mar 2026 02:21:00 -0700
Received: from kbuild by 418530b1a366 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w0cDw-000000002Ih-3QFC;
	Thu, 12 Mar 2026 09:20:56 +0000
Date: Thu, 12 Mar 2026 17:20:12 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Wei Wang <weibunny@fb.com>
Subject: Re: [PATCH v4 net-next 3/5] psp: add a new netdev event for dev
 unregister
Message-ID: <202603121737.vPEHjYAG-lkp@intel.com>
References: <20260311235904.2392010-4-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311235904.2392010-4-weibunny.kernel@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266954-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 8829826F792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Wei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Wang/psp-add-admin-non-admin-version-of-psp_device_get_locked/20260312-080310
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260311235904.2392010-4-weibunny.kernel%40gmail.com
patch subject: [PATCH v4 net-next 3/5] psp: add a new netdev event for dev unregister
config: x86_64-randconfig-014-20260312 (https://download.01.org/0day-ci/archive/20260312/202603121737.vPEHjYAG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260312/202603121737.vPEHjYAG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603121737.vPEHjYAG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/psp/psp_main.c: In function 'psp_init':
>> net/psp/psp_main.c:449:13: warning: unused variable 'err' [-Wunused-variable]
     449 |         int err;
         |             ^~~


vim +/err +449 net/psp/psp_main.c

   446	
   447	static int __init psp_init(void)
   448	{
 > 449		int err;
   450	
   451		mutex_init(&psp_devs_lock);
   452	
   453		return genl_register_family(&psp_nl_family);
   454	}
   455	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

