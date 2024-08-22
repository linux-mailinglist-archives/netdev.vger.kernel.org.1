Return-Path: <netdev+bounces-120837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D674195AFB1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C08283F9B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F5B15F3F0;
	Thu, 22 Aug 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AB3I+5+R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248F1581FC;
	Thu, 22 Aug 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313304; cv=none; b=UYl3KstgdHZuGOt3LI7ShtvAnbiM2XITqPxQMKV1CYWPBCqiJcnDjzrq2OtvUQADxMlQv0jC998sHsEirnl7rQEeVkjk3T2VN9nkpj11X+IuDsriJu5X/ovKOOPPnFt5r8dl3sKVbwGHS5fW8Tc0VXKRCHkoWazljEJnnNnbB9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313304; c=relaxed/simple;
	bh=ViUfJqkCgiSdclTAphoY6s/d6BvM+78Ag9hyB9sZj7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFGRebs6jPj4NJTgMrykhnKycPtopZGMhdgKs7PV4YYlk4vgQ89L+kdBx+mPI6twXxdmOyTH6lLRlZkCDGYl1Nv+YuEGFESFtcOfrNS438JAZRrhEI+cqR1WEtM8NO1v705K4HimoA2BI2DZhDFz/sQV/eLc3yrbM+PD/N8Qr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AB3I+5+R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724313302; x=1755849302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViUfJqkCgiSdclTAphoY6s/d6BvM+78Ag9hyB9sZj7w=;
  b=AB3I+5+R2uOZCxuH9MoW1Rc8gRtRol2nH7PGJPpwFV4iiLylRnkL5VUJ
   b79kG3gPaj3KE/jB75Oh3uUF2NrDm8ZRh9QcC27+nw+tQejL5GxANkouz
   FTPCj9gI12rrvcNwWmp53JKZK227kRRyjWhM+UdEDn/QUsGPhGe+jgqIs
   lj6ABfbTJwwYeQZVsq9j7hIUnBfvLsjxmoNSJo/LnwCfClJK+36JLKV7g
   xyIbaqRaVzq20a7fsUxUjkalOZiPT8hjl54TOXqO0Zxwm+CIDIejT2uoW
   GEvIV/Fvyuxy+/MlJoS9PrUYQhkXl2CdigvWCm2ZSinlqwiJXmf2nOoVT
   Q==;
X-CSE-ConnectionGUID: /7stmtSyTzqNpAjpzg+3KA==
X-CSE-MsgGUID: FHMJhBxURqy8y/PK7UYPGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="26578722"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="26578722"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:55:00 -0700
X-CSE-ConnectionGUID: doF4OM9ERTyaDprtUtBxJg==
X-CSE-MsgGUID: 44kQgOCfRYOHC3KNUiZtiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61028250"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2024 00:54:56 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sh2ek-000CYS-2L;
	Thu, 22 Aug 2024 07:54:54 +0000
Date: Thu, 22 Aug 2024 15:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of
 MDI pairs
Message-ID: <202408221537.gmrL3l3n-lkp@intel.com>
References: <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel@makrotopia.org>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/net-phy-aquantia-allow-forcing-order-of-MDI-pairs/20240821-210717
base:   net-next/main
patch link:    https://lore.kernel.org/r/ed46220cc4c52d630fc481c8148fc749242c368d.1724244281.git.daniel%40makrotopia.org
patch subject: [PATCH net-next 2/2] net: phy: aquantia: allow forcing order of MDI pairs
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240822/202408221537.gmrL3l3n-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221537.gmrL3l3n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221537.gmrL3l3n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/aquantia/aquantia_main.c:483:5: warning: no previous prototype for 'aqr107_config_mdi' [-Wmissing-prototypes]
     483 | int aqr107_config_mdi(struct phy_device *phydev)
         |     ^~~~~~~~~~~~~~~~~


vim +/aqr107_config_mdi +483 drivers/net/phy/aquantia/aquantia_main.c

   482	
 > 483	int aqr107_config_mdi(struct phy_device *phydev)
   484	{
   485		struct device_node *np = phydev->mdio.dev.of_node;
   486		bool force_normal, force_reverse;
   487	
   488		force_normal = of_property_read_bool(np, "marvell,force-mdi-order-normal");
   489		force_reverse = of_property_read_bool(np, "marvell,force-mdi-order-reverse");
   490	
   491		if (force_normal && force_reverse)
   492			return -EINVAL;
   493	
   494		if (force_normal)
   495			return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
   496					      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
   497					      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
   498	
   499		if (force_reverse)
   500			return phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, PMAPMD_RSVD_VEND_PROV,
   501					      PMAPMD_RSVD_VEND_PROV_MDI_CONF,
   502					      PMAPMD_RSVD_VEND_PROV_MDI_REVERSE |
   503					      PMAPMD_RSVD_VEND_PROV_MDI_FORCE);
   504	
   505		return 0;
   506	}
   507	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

