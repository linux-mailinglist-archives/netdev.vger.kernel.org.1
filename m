Return-Path: <netdev+bounces-241708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5947C8788C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 987634E06AD
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC72F1FE9;
	Tue, 25 Nov 2025 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf0ajQpz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7B27990A
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764115048; cv=none; b=EZ4Qghjg/wDmhuq74zHzUP0mKCtjnYFX4Z0zgkks37V+9Q8T4RoQZSJrl1ktm2LNdA2P8RHHpBM4XAdF1zRnz5fQZV552BtaxEGNqp/ydVF6t6qY0DOcaoRQdEpaELf4af7RuoHTnHp3vAbpnDrRyqEYw/f+Zt+bJO9o7DbP4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764115048; c=relaxed/simple;
	bh=E7Vhxuxnd5dJfb3+F6Sp1aDAooveiAzLlYqO8i1/WjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfov1c/ci14Y5WTde2oyjupLaYb35g9CVMzidRtdtqVHeNL1um/lFrlNcBdpfq8GzcyP3qmSAi2EhmnnhiyvhEtEJNjnxDElNwDuUMSv75FWuzcdRjSeRCLqSG1Tp32avzcCjqXSW0hLrIWH9Le/rjLo78uMmy+6WmfjImzEgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf0ajQpz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764115047; x=1795651047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E7Vhxuxnd5dJfb3+F6Sp1aDAooveiAzLlYqO8i1/WjU=;
  b=Gf0ajQpzrcCuGclMWJsINoLoeQNRpd4FVclvBrKQKRUXbyavP3IThl9P
   pEMAuBa7peYIUuuuilQlGBe4G/5po7ORHpjjGMiwFUzFmeeoAO/+kaD4c
   h4bzOYWJrdzRsLldY6HGpJC2SyTRQCa7tdlB69X3gUVUyhFv1xrcqVU5/
   QgTEwymJn5Y/QlwsJ4gnAXER0StRUIwXBG4SozBLtLD0sAk5K4YPcNLFo
   S7Y+H+wx3p9uvsafDoOKcXk/fyAbaw8sKGXnzzIZtG3kBNUkEpPuC6AR8
   vI3IKLL48lLMMGn/sF96DG+uiIX8IzIFCITyJ0JnV9+npCCB44pcu/H/B
   Q==;
X-CSE-ConnectionGUID: VqMLDfezQ4OrLZ/jTo6auA==
X-CSE-MsgGUID: peHVb+SNSfGEwATRCct+0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66305315"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66305315"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 15:57:26 -0800
X-CSE-ConnectionGUID: /6d2zgObRySKi6hiZ4qTgQ==
X-CSE-MsgGUID: h3doMYfGSZq97NwrlfMlhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="192041245"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Nov 2025 15:57:23 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO2uP-000000002Mz-185N;
	Tue, 25 Nov 2025 23:57:21 +0000
Date: Wed, 26 Nov 2025 07:56:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next v1 4/5] net: bonding: add the
 READ_ONCE/WRITE_ONCE for outside lock accessing
Message-ID: <202511260755.PsI0heoq-lkp@intel.com>
References: <20251125084451.11632-5-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125084451.11632-5-tonghao@bamaicloud.com>

Hi Tonghao,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Tonghao-Zhang/net-bonding-use-workqueue-to-make-sure-peer-notify-updated-in-lacp-mode/20251125-164825
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251125084451.11632-5-tonghao%40bamaicloud.com
patch subject: [PATCH net-next v1 4/5] net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20251126/202511260755.PsI0heoq-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260755.PsI0heoq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260755.PsI0heoq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/bonding/bond_main.c:1207:2: error: unterminated function-like macro invocation
    1207 |         WRITE_ONCE(bond->send_peer_notif,
         |         ^
   include/asm-generic/rwonce.h:58:9: note: macro 'WRITE_ONCE' defined here
      58 | #define WRITE_ONCE(x, val)                                              \
         |         ^
>> drivers/net/bonding/bond_main.c:6585:37: error: expected '}'
    6585 | MODULE_IMPORT_NS("NETDEV_INTERNAL");
         |                                     ^
   drivers/net/bonding/bond_main.c:1206:1: note: to match this '{'
    1206 | {
         | ^
   2 errors generated.


vim +1207 drivers/net/bonding/bond_main.c

  1203	
  1204	/* Peer notify update handler. Holds only RTNL */
  1205	static void bond_peer_notify_reset(struct bonding *bond)
  1206	{
> 1207		WRITE_ONCE(bond->send_peer_notif,
  1208			   bond->params.num_peer_notif *
  1209			   max(1, bond->params.peer_notif_delay);
  1210	}
  1211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

