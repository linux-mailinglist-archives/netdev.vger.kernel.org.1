Return-Path: <netdev+bounces-252185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA8uIvuhcWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:05:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169D61959
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BC6F525BEF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C942883A;
	Thu, 22 Jan 2026 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdFzkJjz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17522759C;
	Thu, 22 Jan 2026 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054384; cv=none; b=kHfhqEudPHMU4D7YNGDaU6F/krtiSk8IKjdP5QG3w++cNAgcH5ZL2DE5tqxD7y6KJQEB6T4VHUfI4kq037wLOpU3CJxpPHf+JadGtbOZENbtcIqN70yS2PlXlM53/l/VRjqoyMG3vvkeQNoP8gAQJzAw+6Af9rpKF6y703pxh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054384; c=relaxed/simple;
	bh=9uDRZ11ItCsXw/1zlEuqjTf0Q6HKRQqnxidEsk6dUtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+mPcRQh6l4v5uCvQiplYQ7EGotKBDOG8dD+PnAdMObYYXwlvBQdY2KQj76fkPBa5J4JTYW031PFpgjMMwTbNnkEu+CPly8oYwBqb4m31LKxxk+SvDmkh/uVVl9VM6w7V+xLpqQPHaDITNnhNLog+PhHv+1jAx9aNjhGxLYqCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdFzkJjz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769054380; x=1800590380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uDRZ11ItCsXw/1zlEuqjTf0Q6HKRQqnxidEsk6dUtE=;
  b=CdFzkJjz6A/o0YEgLbsvgV+Ev9Fdym7Csso7KfJkXl2v6IpQJBDpMp4H
   0B2y/zcnSFikdgK8H4bt1HmTPx7RHfJTflzWS5p8vItX8ZsThxvrAtSmj
   b8WKX7vX1BszPM0umMM8kjfxKiWmVWtYCsUPdAvOFRldA+u+K/r3gJA0D
   wprzGy49ZPhmbzfpNwloUdwamtddO1c4m9faZ7mwvPWOab+KMY/aZdgyi
   PPBuRAbpJ4Qgbqc6ukZ040BXLYhvBdNUOzVFT+qy6ffoEtSB8UvT1m9d1
   8p85HFb+l1oQHz6esdY1yRFuuuif2oUomuruBjH0/FGQ2o4thPbX8UcSH
   A==;
X-CSE-ConnectionGUID: BawPkwM+TTmNmmTtjRVRRg==
X-CSE-MsgGUID: g8YLZ/lxTbyjRGk18URqtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69307133"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="69307133"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 19:59:36 -0800
X-CSE-ConnectionGUID: W2pn3YLJQb24F6bQHeSW1w==
X-CSE-MsgGUID: UBnnffqWQNiaFqA/QeBXTQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jan 2026 19:59:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vilr1-00000000SPH-2A6h;
	Thu, 22 Jan 2026 03:59:31 +0000
Date: Thu, 22 Jan 2026 11:58:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <dskr99@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 3/3] ipvlan: common code to handle ipv6/ipv4 address
 events
Message-ID: <202601221123.nqHDZ5VS-lkp@intel.com>
References: <20260120161852.639238-4-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120161852.639238-4-skorodumov.dmitry@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252185-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,huawei.com,fomichev.me,google.com];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3169D61959
X-Rspamd-Action: no action

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-const-specifier-for-functions-that-use-iaddr/20260121-021651
base:   net/main
patch link:    https://lore.kernel.org/r/20260120161852.639238-4-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net 3/3] ipvlan: common code to handle ipv6/ipv4 address events
config: csky-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260122/202601221123.nqHDZ5VS-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
smatch version: v0.5.0-8985-g2614ff1a
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221123.nqHDZ5VS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601221123.nqHDZ5VS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ipvlan/ipvlan_main.c:975:30: warning: 'ipvlan_addr6_vtor_notifier_block' defined but not used [-Wunused-variable]
     975 | static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ipvlan/ipvlan_main.c:971:30: warning: 'ipvlan_addr6_notifier_block' defined but not used [-Wunused-variable]
     971 | static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ipvlan_addr6_notifier_block +971 drivers/net/ipvlan/ipvlan_main.c

2ad7bf3638411c Mahesh Bandewar   2014-11-23  970  
2ad7bf3638411c Mahesh Bandewar   2014-11-23 @971  static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
125ac7e42e5f15 Dmitry Skorodumov 2026-01-20  972  	.notifier_call = ipvlan_addr_event_cb,
2ad7bf3638411c Mahesh Bandewar   2014-11-23  973  };
2ad7bf3638411c Mahesh Bandewar   2014-11-23  974  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

