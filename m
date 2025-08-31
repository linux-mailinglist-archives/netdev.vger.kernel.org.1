Return-Path: <netdev+bounces-218559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC16CB3D3D4
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C3D164FA6
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF5C265298;
	Sun, 31 Aug 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJbvMsBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFA263F43;
	Sun, 31 Aug 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756649478; cv=none; b=aDfBOqeGaEFD05NhCO132jyrTGoQ+RV62XwnYmt929ZPra94wC+JYnolmG8As+X2uBmC9NRsOWGOmmVHAYfEnkz61HMOk/piRJ1VTjoSnfJCWXfFRZf+lsEbUq+BVbGGqT40Ojf3++4AU0ZWajGbv9JfCC9BspUSsnO0uqsomqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756649478; c=relaxed/simple;
	bh=RHLB6SbhJ6NwlIcJN+U0qOt1DNSxNE6wDis/g760GdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5XV+BOTsyKbl/97QRHJiEE/p/D/TmUyJsNjnOe2AsUb9ZnUP4EgkU1ME36AJRK2lT7INxNg52mRRYuAWWgW3tDYdliwoGl19bJ7PQU8DAydL8j2tmveTwKSQNg6SWo1euCfdG0eIqaKaozTrnEIvOQZTTIK7GIDBlbbIutcI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJbvMsBZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756649477; x=1788185477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RHLB6SbhJ6NwlIcJN+U0qOt1DNSxNE6wDis/g760GdA=;
  b=nJbvMsBZK7UOBiLDYtJ3Xy05ANtu1AX6vdF0ml4gZNv711Nhjk45MNPz
   HoMqiaUkeVKENeMu9PYnRI/eJtn+VB11OU3C1Sx4oWEbgEOQsNDFT6aaY
   S2MKowCRrsnYAJ2rfETInivY4hljGji9yi7rfY+maUOHkET7uBXutDnLN
   esn9pB1ZF2t7PNqqx7SIIDg5Mlx6xHlG0Y/8PRvAEBVgzxPa0iG0QqGkF
   LZI9KeLjwczcayBaHpBzSoZDuameGGa6YDnfZep6u9p2SqW5Lrv1Ofp/E
   wjgWtP8kbVBYXNnHShmCiZ5coADi0X2M3fI+Eha6uYrDZ2p9Vlj5d6EPC
   Q==;
X-CSE-ConnectionGUID: Ygcx7cj0RHmOFVssA62CQA==
X-CSE-MsgGUID: AI7p4XqlSZuPHh41194BGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62706092"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62706092"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 07:11:16 -0700
X-CSE-ConnectionGUID: 5+1nmxwsQNKT8tp6ZRSkXg==
X-CSE-MsgGUID: eV10036mSVWJ8jR5YWddlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201676250"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 31 Aug 2025 07:11:13 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usilz-000W9n-1S;
	Sun, 31 Aug 2025 14:11:11 +0000
Date: Sun, 31 Aug 2025 22:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Tran <alex.t.tran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: Re: [PATCH net v1] Fixes: xircom auto-negoation timer
Message-ID: <202508312115.rbF0CO44-lkp@intel.com>
References: <20250825012821.492355-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825012821.492355-1-alex.t.tran@gmail.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Tran/Fixes-xircom-auto-negoation-timer/20250825-093026
base:   net/main
patch link:    https://lore.kernel.org/r/20250825012821.492355-1-alex.t.tran%40gmail.com
patch subject: [PATCH net v1] Fixes: xircom auto-negoation timer
config: i386-randconfig-r073-20250831 (https://download.01.org/0day-ci/archive/20250831/202508312115.rbF0CO44-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508312115.rbF0CO44-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/xircom/xirc2ps_cs.c:1643 init_mii() warn: inconsistent indenting

Old smatch warnings:
drivers/net/ethernet/xircom/xirc2ps_cs.c:1208 xirc2ps_tx_timeout_task() warn: inconsistent indenting
drivers/net/ethernet/xircom/xirc2ps_cs.c:1685 init_mii() warn: inconsistent indenting

vim +1643 drivers/net/ethernet/xircom/xirc2ps_cs.c

  1633	
  1634	/****************
  1635	 * Initialize the Media-Independent-Interface
  1636	 * Returns: True if we have a good MII
  1637	 */
  1638	static int
  1639	init_mii(struct net_device *dev)
  1640	{
  1641	    struct local_info *local = netdev_priv(dev);
  1642	    unsigned int ioaddr = dev->base_addr;
> 1643		unsigned int control, status;
  1644	
  1645	    if (if_port == 4 || if_port == 1) { /* force 100BaseT or 10BaseT */
  1646		dev->if_port = if_port;
  1647		local->probe_port = 0;
  1648		return 1;
  1649	    }
  1650	
  1651	    status = mii_rd(ioaddr,  0, 1);
  1652	    if ((status & 0xff00) != 0x7800)
  1653		return 0; /* No MII */
  1654	
  1655	    local->new_mii = (mii_rd(ioaddr, 0, 2) != 0xffff);
  1656	    
  1657	    if (local->probe_port)
  1658		control = 0x1000; /* auto neg */
  1659	    else if (dev->if_port == 4)
  1660		control = 0x2000; /* no auto neg, 100mbs mode */
  1661	    else
  1662		control = 0x0000; /* no auto neg, 10mbs mode */
  1663	    mii_wr(ioaddr,  0, 0, control, 16);
  1664	    udelay(100);
  1665	    control = mii_rd(ioaddr, 0, 0);
  1666	
  1667	    if (control & 0x0400) {
  1668		netdev_notice(dev, "can't take PHY out of isolation mode\n");
  1669		local->probe_port = 0;
  1670		return 0;
  1671	    }
  1672	
  1673	    if (local->probe_port) {
  1674		/* according to the DP83840A specs the auto negotiation process
  1675		 * may take up to 3.5 sec, so we use this also for our ML6692
  1676		 */
  1677		local->dev = dev;
  1678		local->autoneg_attempts = 0;
  1679		init_completion(&local->autoneg_done);
  1680		timer_setup(&local->timer, autoneg_timer, 0);
  1681		local->timer.expires = RUN_AT(AUTONEG_TIMEOUT); /* 100msec intervals*/
  1682		add_timer(&local->timer);
  1683		}
  1684	
  1685		return 1;
  1686	}
  1687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

