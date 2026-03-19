Return-Path: <netdev+bounces-269722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOE7MfWMvGnz0QIAu9opvQ
	(envelope-from <netdev+bounces-269722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:55:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 202472D4511
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A6630F6B05
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7230C3F23DB;
	Thu, 19 Mar 2026 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgFHFled"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275B3F0AAB;
	Thu, 19 Mar 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964511; cv=none; b=D5SzV2HH440Bnl+wsgmJ6tiLd6lhcZJYkaWalfCygn/fpsJl5hkYZUb1kT9yMW2RbTLlN1phR2c51P71R1gg2KkjYTT7hbc1XBjCAw+UgnAS/1Mux8I2YofvWgD0G6l4J70UN3zcGq41SQ7ZXvKYMMzvZDwVGpWO6p31GeNtG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964511; c=relaxed/simple;
	bh=rfnWg8dzig0kPp2J7aT0TNOUIX/ZW/F/iLBP2iW4MKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUaq7cMxJy7T6Rx3m0FXXY3PNDkHVvPGMZfklC5rNME80K8649ZkwM6hpltnl1mvGcWW2/ercW/iM5RI1reUu/zIVhQne7uRSf0/wqNXSuNjPEmbI0MqK8YPTB2pTMIcBPw2dZb9nnp81Z6JgiR0fl4mTKyHY89zZ4izyBavyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgFHFled; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773964510; x=1805500510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rfnWg8dzig0kPp2J7aT0TNOUIX/ZW/F/iLBP2iW4MKc=;
  b=UgFHFledeaNnB41Z7RNc5zBcWnIBeUtJ0+RYX7Ve/wUvRBQ51A1b6WiN
   e74XQ7HSjW6BwFZ4FDFhpc1Bt930V+uVJ3pbMME4p0OiGyMvJb4S19a1q
   zU9N6Z0mh02oh9w2Cywb0xN2Oa5WL1Jz3og/Gj+q6fe/8c3CTh8ubMG/p
   ECfGloV0eeLon1jOZGtTrf5731yzUvHWQtvZWYg14u+kog8iRkFy7uWkJ
   Yc9R2U5xqjlJpyIm0QrXykxbDDLhXfcgkj/RNwDYoQKYMZ0gLL4hxrQKC
   j0iP/jPdLhQKyIO2IH0HMRcfSYj0tPiwQTAUn7uSaJKUmEZnLx202qY3Z
   Q==;
X-CSE-ConnectionGUID: dLO14oqmR56lXv9saDn+xg==
X-CSE-MsgGUID: sOrc7xDVS5qrJ5/9O2qMpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="62612638"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="62612638"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 16:55:08 -0700
X-CSE-ConnectionGUID: GgdTcTliSWyMr7ZNBVsncA==
X-CSE-MsgGUID: 7on148F1QvWrtQc5bixMsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261016757"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Mar 2026 16:55:03 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3NCe-000000001nL-2XpZ;
	Thu, 19 Mar 2026 23:55:00 +0000
Date: Fri, 20 Mar 2026 07:53:39 +0800
From: kernel test robot <lkp@intel.com>
To: Anand Moon <linux.amoon@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and
 improve error reporting during probe
Message-ID: <202603200758.vueafhDW-lkp@intel.com>
References: <20260317061700.7734-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317061700.7734-1-linux.amoon@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,arm.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-269722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.940];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 202472D4511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Anand,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 95c541ddfb0815a0ea8477af778bb13bb075079a]

url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/r8169-Fix-PHY-lookup-for-mdiobus_get_phy-and-improve-error-reporting-during-probe/20260317-183327
base:   95c541ddfb0815a0ea8477af778bb13bb075079a
patch link:    https://lore.kernel.org/r/20260317061700.7734-1-linux.amoon%40gmail.com
patch subject: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and improve error reporting during probe
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260320/202603200758.vueafhDW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260320/202603200758.vueafhDW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603200758.vueafhDW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/r8169_main.c:5467:17: warning: variable 'phydev' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
    5467 |         for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
         |                        ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/realtek/r8169_main.c:5476:7: note: uninitialized use occurs here
    5476 |         if (!phydev) {
         |              ^~~~~~
   drivers/net/ethernet/realtek/r8169_main.c:5467:17: note: remove the condition if it is always true
    5467 |         for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
         |                        ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/realtek/r8169_main.c:5430:27: note: initialize the variable 'phydev' to silence this warning
    5430 |         struct phy_device *phydev;
         |                                  ^
         |                                   = NULL
   1 warning generated.


vim +5467 drivers/net/ethernet/realtek/r8169_main.c

  5425	
  5426	static int r8169_mdio_register(struct rtl8169_private *tp)
  5427	{
  5428		struct pci_dev *pdev = tp->pci_dev;
  5429		struct mii_bus *new_bus;
  5430		struct phy_device *phydev;
  5431		int ret, addr;
  5432	
  5433		/* On some boards with this chip version the BIOS is buggy and misses
  5434		 * to reset the PHY page selector. This results in the PHY ID read
  5435		 * accessing registers on a different page, returning a more or
  5436		 * less random value. Fix this by resetting the page selector first.
  5437		 */
  5438		if (tp->mac_version == RTL_GIGA_MAC_VER_25 ||
  5439		    tp->mac_version == RTL_GIGA_MAC_VER_26)
  5440			r8169_mdio_write(tp, 0x1f, 0);
  5441	
  5442		new_bus = devm_mdiobus_alloc(&pdev->dev);
  5443		if (!new_bus)
  5444			return -ENOMEM;
  5445	
  5446		new_bus->name = "r8169";
  5447		new_bus->priv = tp;
  5448		new_bus->parent = &pdev->dev;
  5449		new_bus->irq[0] = PHY_MAC_INTERRUPT;
  5450		new_bus->phy_mask = GENMASK(31, 1);
  5451		snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
  5452			 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
  5453	
  5454		new_bus->read = r8169_mdio_read_reg;
  5455		new_bus->write = r8169_mdio_write_reg;
  5456	
  5457		if (tp->mac_version >= RTL_GIGA_MAC_VER_40) {
  5458			new_bus->read_c45 = r8169_mdio_read_reg_c45;
  5459			new_bus->write_c45 = r8169_mdio_write_reg_c45;
  5460		}
  5461	
  5462		ret = devm_mdiobus_register(&pdev->dev, new_bus);
  5463		if (ret)
  5464			return ret;
  5465	
  5466		/* find the first (lowest address) PHY on the current MAC's MII bus */
> 5467		for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
  5468			struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
  5469	
  5470			if (tmp) {
  5471				phydev = tmp;
  5472				break;
  5473			}
  5474		}
  5475	
  5476		if (!phydev) {
  5477			dev_err(&pdev->dev, "no PHY found on bus\n");
  5478			return -ENODEV;
  5479		}
  5480	
  5481		/* Most chip versions fail with the genphy driver.
  5482		 * Therefore ensure that the dedicated PHY driver is loaded.
  5483		 */
  5484		if (!phydev->drv) {
  5485			dev_err(&pdev->dev, "no dedicated PHY driver found for PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
  5486				phydev->phy_id);
  5487			return -EUNATCH;
  5488		}
  5489	
  5490		tp->phydev = phydev;
  5491		tp->phydev->mac_managed_pm = true;
  5492		if (rtl_supports_eee(tp))
  5493			phy_support_eee(tp->phydev);
  5494		phy_support_asym_pause(tp->phydev);
  5495	
  5496		/* mimic behavior of r8125/r8126 vendor drivers */
  5497		if (tp->mac_version == RTL_GIGA_MAC_VER_61)
  5498			phy_disable_eee_mode(tp->phydev,
  5499					     ETHTOOL_LINK_MODE_2500baseT_Full_BIT);
  5500	
  5501		/* PHY will be woken up in rtl_open() */
  5502		phy_suspend(tp->phydev);
  5503	
  5504		return 0;
  5505	}
  5506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

