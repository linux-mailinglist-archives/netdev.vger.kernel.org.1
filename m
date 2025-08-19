Return-Path: <netdev+bounces-215049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56252B2CE61
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D5D5C08C6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470A311974;
	Tue, 19 Aug 2025 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV6AT49z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715483101AA;
	Tue, 19 Aug 2025 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637810; cv=none; b=c6wdSXdcLfZloqk58jQX/JWkz1NYkVfSMOgazQ20qjNr2yg1kq3+LRd08gzSDUzKKS423ysi1ijORrYwLBq2ho45ilVulq95kkrv1a0ngiteGB3jy8SOGo8Ewh57L0G1kdRqn5f/gv4jOu9JHo4xRanlHCRKSne8msVMBTMI++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637810; c=relaxed/simple;
	bh=lAs7kHreBtRFM5BmhN+uVj7cvYVrE9W4cw3bVA+6RCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbjDhQjlYikbh3kCyr4YgRbw2mvU7HudbXkk616tBLLgN1+mLWFle8YHSupe4lIk937fH9D1Mjb7TrgMFy9jfN3fheR+paFzRWNpJIMDEtjbYHTMUNnufprD7c7E8nZkwYcChtycbLmAhcPMo26uiEJolMjen6+JksLMdVBT5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV6AT49z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755637809; x=1787173809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lAs7kHreBtRFM5BmhN+uVj7cvYVrE9W4cw3bVA+6RCw=;
  b=kV6AT49zh8Ga4td68vmfVc6MLXTSojIvyD1YeCthtqCze69n0Tl/5w74
   vIqMV/H2Yg36Et/7dTglt5WxXmKPqicWvEFOFvRzfHw9A5lTNJpWESyMX
   qLsLzMN8GRbFTfS9uQY5dnDrY3jAh69S4B63Z8U1qqmVGGT/zP6CDzpQK
   yFaUSbLrO2bkrqw2SXAo6Aj9hyuCSIcYEJ9nVixTWcVv0o+O6f/8DGD4X
   nP44Q79GWGHYFCBs9I+ogs1fUiHQST4nRMEshPlF9+MwasaERFFanwlX5
   E18kHexkliWPg489v4NJgYzvsZA2/1ghCWsVC82EZn5wo4adhKtvRY/PL
   A==;
X-CSE-ConnectionGUID: bUXcFjrWSuGFPqwD9rzM+Q==
X-CSE-MsgGUID: sDQHuh75THGSNfn+ASX2Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61728038"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61728038"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 14:10:08 -0700
X-CSE-ConnectionGUID: OjuMbXC3RGq+9bUgCgDQ/g==
X-CSE-MsgGUID: q7vuU89HTWytl+PGKm8Z7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173315511"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Aug 2025 14:10:04 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoTai-000HVT-2v;
	Tue, 19 Aug 2025 21:10:00 +0000
Date: Wed, 20 Aug 2025 05:09:30 +0800
From: kernel test robot <lkp@intel.com>
To: Artur Rojek <contact@artur-rojek.eu>, Rob Landley <rob@landley.net>,
	Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <202508200456.GIhKD5qv-lkp@intel.com>
References: <20250815194806.1202589-4-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815194806.1202589-4-contact@artur-rojek.eu>

Hi Artur,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.17-rc2 next-20250819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artur-Rojek/dt-bindings-vendor-prefixes-Document-J-Core/20250816-042354
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250815194806.1202589-4-contact%40artur-rojek.eu
patch subject: [PATCH 3/3] net: j2: Introduce J-Core EMAC
config: m68k-randconfig-r113-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200456.GIhKD5qv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250820/202508200456.GIhKD5qv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200456.GIhKD5qv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/jcore_emac.c: In function 'jcore_emac_set_rx_mode':
>> drivers/net/ethernet/jcore_emac.c:230:1: error: label at end of compound statement
    next_ha:
    ^~~~~~~


vim +230 drivers/net/ethernet/jcore_emac.c

   192	
   193	static void jcore_emac_set_rx_mode(struct net_device *ndev)
   194	{
   195		struct jcore_emac *priv = netdev_priv(ndev);
   196		struct netdev_hw_addr *ha;
   197		unsigned int reg, i, idx = 0, set_mask = 0, clear_mask = 0, addr = 0;
   198	
   199		if (ndev->flags & IFF_PROMISC)
   200			set_mask |= JCORE_EMAC_PROMISC;
   201		else
   202			clear_mask |= JCORE_EMAC_PROMISC;
   203	
   204		if (ndev->flags & IFF_ALLMULTI)
   205			set_mask |= JCORE_EMAC_MCAST;
   206		else
   207			clear_mask |= JCORE_EMAC_MCAST;
   208	
   209		regmap_update_bits(priv->map, JCORE_EMAC_CONTROL, set_mask | clear_mask,
   210				   set_mask);
   211	
   212		if (!(ndev->flags & IFF_MULTICAST))
   213			return;
   214	
   215		netdev_for_each_mc_addr(ha, ndev) {
   216			/* Only the first 3 octets are used in a hardware mcast mask. */
   217			memcpy(&addr, ha->addr, 3);
   218	
   219			for (i = 0; i < idx; i++) {
   220				regmap_read(priv->map, JCORE_EMAC_MCAST_MASK(i), &reg);
   221				if (reg == addr)
   222					goto next_ha;
   223			}
   224	
   225			regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(idx), addr);
   226			if (++idx >= JCORE_EMAC_MCAST_ADDRS) {
   227				netdev_warn(ndev, "Multicast list limit reached\n");
   228				break;
   229			}
 > 230	next_ha:
   231		}
   232	
   233		/* Clear the remaining mask entries. */
   234		for (i = idx; i < JCORE_EMAC_MCAST_ADDRS; i++)
   235			regmap_write(priv->map, JCORE_EMAC_MCAST_MASK(i), 0);
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

