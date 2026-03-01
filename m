Return-Path: <netdev+bounces-262367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKYvOTuwo2lZKAUAu9opvQ
	(envelope-from <netdev+bounces-262367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 04:19:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5E1CE632
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 04:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89ED3035A95
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 02:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F030B50D;
	Sun,  1 Mar 2026 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2ri9Y7J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041811DF736;
	Sun,  1 Mar 2026 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333082; cv=none; b=taHfTekBfzZ8gyNMEqV4ZlMzbO9xJBL2nlzTlBM5XiO6DYPZkzTAlsVPWC6/t16d5KDWmgBMAC0Btnv3X6awVvzADuVEIL9AU46WCe0XVvXRrlKU3MWg0juad1gEYExems7snoHH1Mj1NQmq7S0nadBWzLmNdJK4jZwkgEfCuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333082; c=relaxed/simple;
	bh=Lcvsy1/nFMPntqrLdhtQADgDpVMjx7JQ9RpemuAbrIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TelJMpJZeY73lrvJz4coP6XC0UHQgJZxeGOqFS7YDTA1cWk79SibRAyTBPXP2x3F8jh+uooZmfVU9l7HNaPIuWxiinHv2lvaP6vhmc9Mll2ot3RIkb6lxzgd7ivraexNDjMeGDjBJQZjCz5Pa775yklLUd/LMwn1VVLf5io+TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2ri9Y7J; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772333081; x=1803869081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lcvsy1/nFMPntqrLdhtQADgDpVMjx7JQ9RpemuAbrIg=;
  b=L2ri9Y7Jgf7YSjmUM+YD8OYqxiBQ/OAfQ9/XxyXkuEHf0r5Yd/yrz/it
   5WThv2eeG2ymgywPokliFGYtr+0+PzLZQELBhRyJbfLCw9xjgFK70rY19
   Pl67AUZ/UvJbh0IlGSAVJkEnXi8gLw8aKF7TBxab8CX+IuKVSZr/Vh1Iw
   obB7NckskbSb3hzRLbraYYeLFZTDgrybeIk7WW6wj++PgkQ40b5vXTFoK
   AaydMRdtoi5zdQ3PKoSFVKaOZVFej3cRuswn/kVdkc+p61Y4yBkmz5Yuc
   2OrqAzJjGBZ6t1B3SDLKMY3dPG5cL6Jg0Oj/JfHEc8XsAJmvgvteqgajt
   g==;
X-CSE-ConnectionGUID: Kx4sn0oRRfKtGBXSzRSyUg==
X-CSE-MsgGUID: nZPAwLXuSBasJhgepxvRJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="90955170"
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="90955170"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 18:44:40 -0800
X-CSE-ConnectionGUID: YbvMI+g9RtCkRDyd7EJBwA==
X-CSE-MsgGUID: rP2G94vzTP6C1525oYLZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,317,1763452800"; 
   d="scan'208";a="216415922"
Received: from lkp-server01.sh.intel.com (HELO 59784f1c7b2a) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 28 Feb 2026 18:44:38 -0800
Received: from kbuild by 59784f1c7b2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwWnK-0000000018X-1CkV;
	Sun, 01 Mar 2026 02:44:34 +0000
Date: Sun, 1 Mar 2026 10:43:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Subject: Re: [PATCH net-next v2 5/5] net: phy: motorcomm: yt8821: Disable
 MDIO broadcast
Message-ID: <202603011047.rzQIXPzJ-lkp@intel.com>
References: <20260228232241.1274236-6-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228232241.1274236-6-linuxtardis@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262367-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,lunn.ch,gmail.com,armlinux.org.uk,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: 42A5E1CE632
X-Rspamd-Action: no action

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Van-k/net-mdiobus-Scan-buses-in-reverse-order-31-0/20260301-072526
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260228232241.1274236-6-linuxtardis%40gmail.com
patch subject: [PATCH net-next v2 5/5] net: phy: motorcomm: yt8821: Disable MDIO broadcast
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20260301/202603011047.rzQIXPzJ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603011047.rzQIXPzJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603011047.rzQIXPzJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/phy/phy_common_fixups.c:16 function parameter 'phydev' not described in 'yt8821_disable_broadcast'
>> Warning: drivers/net/phy/phy_common_fixups.c:16 function parameter 'phydev' not described in 'yt8821_disable_broadcast'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

