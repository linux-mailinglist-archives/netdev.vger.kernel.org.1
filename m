Return-Path: <netdev+bounces-220571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86519B46A1C
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048C55A73BE
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD002C11E9;
	Sat,  6 Sep 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh31fXBl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE169279DC9;
	Sat,  6 Sep 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757146819; cv=none; b=pYUw0W0OhAAPya07nGWwp/dUhedck6Z7OlkbAzRYwjfpdTosygjgMnJnnJise0t6XnCrJ/aSEkmES69679tw3wM3raojYIXAeDgihfJ8ew1yKjT/rynEiPuiW/XCtufG3KzBbqDxBy0Zs3I49xVmHZ0uBnWITpy7zC0lmaclDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757146819; c=relaxed/simple;
	bh=65fgzL9aHcehB8e5Ro0jhg/HmeW0MW9yg6xKlGR8tkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBRqwrjOxmaqfIHp2ug8zTz1q6w4O7JYhcuftM+hihWToqAamBiQfhgDdO1fVpvIT6cXKmwk55297i1XAgm+VakasdbcSPwkHeg5wdsqAYdxsUMYspEsBIJ/YlffX1hoQwyING1gxJTJO5vXgbVEPFxVEJ6RMpn9ZjV9c3s6Zsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh31fXBl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757146817; x=1788682817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=65fgzL9aHcehB8e5Ro0jhg/HmeW0MW9yg6xKlGR8tkQ=;
  b=lh31fXBlsZdsWDz3ySDJ6a2z77gZvg04GnjGPIC8Y1O10A79b7GdVCQN
   xmDADsOnPvBmtLOyCLF+Idh92gkpvTTcWE/16ADz9r1yBO1YsCKnSRg6A
   g7ffA/qY+Yr47W0KHcTLQPsj9/L6BSu+D48WEzmmbKA6BcK277rwVEcx8
   9CnRka9SAEHroNPzRJMR5f41oon16SguTefe3xAISBiJKVehQM0YtAHXs
   2MddytSFZCTsAH5erHaaAhdDgpN4yf4TqeghU4Y3FNFENnRrlMzn+CGj0
   VbEnog0hspUHX5FByB79EPYOtbZqeTwQG1LbnTCQNeTfl3H5u5sySiiXR
   w==;
X-CSE-ConnectionGUID: rbaJTDt0SRSMxB8QpR1gYw==
X-CSE-MsgGUID: 61VXh3izRNGJZH7yUK1uxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="69742522"
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="69742522"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 01:20:16 -0700
X-CSE-ConnectionGUID: qteZDaMqTdO2363FcPHQyg==
X-CSE-MsgGUID: 3lvupHIER/qUGBAs2Rx60w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,243,1751266800"; 
   d="scan'208";a="176671344"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Sep 2025 01:20:12 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuo9a-0001J1-1Q;
	Sat, 06 Sep 2025 08:20:10 +0000
Date: Sat, 6 Sep 2025 16:19:34 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <202509061559.nSYmNbyV-lkp@intel.com>
References: <20250905181728.3169479-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905181728.3169479-4-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v6.17-rc4 next-20250905]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/dt-bindings-net-dsa-yt921x-Add-Motorcomm-YT921x-switch-support/20250906-021942
base:   net/main
patch link:    https://lore.kernel.org/r/20250905181728.3169479-4-mmyangfl%40gmail.com
patch subject: [PATCH net-next v7 3/3] net: dsa: yt921x: Add support for Motorcomm YT921x
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250906/202509061559.nSYmNbyV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250906/202509061559.nSYmNbyV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509061559.nSYmNbyV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/yt921x.c: In function 'yt921x_set_eee':
>> drivers/net/dsa/yt921x.c:1045:24: warning: unused variable 'dev' [-Wunused-variable]
    1045 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_change_mtu':
   drivers/net/dsa/yt921x.c:1110:24: warning: unused variable 'dev' [-Wunused-variable]
    1110 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_mirror_add':
   drivers/net/dsa/yt921x.c:1161:24: warning: unused variable 'dev' [-Wunused-variable]
    1161 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_fdb_dump':
   drivers/net/dsa/yt921x.c:1579:24: warning: unused variable 'dev' [-Wunused-variable]
    1579 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_set_ageing_time':
   drivers/net/dsa/yt921x.c:1611:24: warning: unused variable 'dev' [-Wunused-variable]
    1611 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_fdb_del':
   drivers/net/dsa/yt921x.c:1636:24: warning: unused variable 'dev' [-Wunused-variable]
    1636 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_fdb_add':
   drivers/net/dsa/yt921x.c:1651:24: warning: unused variable 'dev' [-Wunused-variable]
    1651 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_mdb_del':
   drivers/net/dsa/yt921x.c:1668:24: warning: unused variable 'dev' [-Wunused-variable]
    1668 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_mdb_add':
   drivers/net/dsa/yt921x.c:1686:24: warning: unused variable 'dev' [-Wunused-variable]
    1686 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_vlan_filtering':
   drivers/net/dsa/yt921x.c:1849:24: warning: unused variable 'dev' [-Wunused-variable]
    1849 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_vlan_del':
   drivers/net/dsa/yt921x.c:1867:24: warning: unused variable 'dev' [-Wunused-variable]
    1867 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_vlan_add':
   drivers/net/dsa/yt921x.c:1900:24: warning: unused variable 'dev' [-Wunused-variable]
    1900 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_bridge_flags':
   drivers/net/dsa/yt921x.c:2148:24: warning: unused variable 'dev' [-Wunused-variable]
    2148 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_bridge_join':
   drivers/net/dsa/yt921x.c:2187:24: warning: unused variable 'dev' [-Wunused-variable]
    2187 |         struct device *dev = to_device(priv);
         |                        ^~~
   drivers/net/dsa/yt921x.c: In function 'yt921x_dsa_port_setup':
   drivers/net/dsa/yt921x.c:2557:24: warning: unused variable 'dev' [-Wunused-variable]
    2557 |         struct device *dev = to_device(priv);
         |                        ^~~


vim +/dev +1045 drivers/net/dsa/yt921x.c

  1041	
  1042	static int
  1043	yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee *e)
  1044	{
> 1045		struct device *dev = to_device(priv);
  1046		bool enable = e->eee_enabled;
  1047		u16 new_mask;
  1048		int res;
  1049	
  1050		/* Enable / disable global EEE */
  1051		new_mask = priv->eee_ports_mask;
  1052		new_mask &= ~BIT(port);
  1053		new_mask |= !enable ? 0 : BIT(port);
  1054	
  1055		if (!!new_mask != !!priv->eee_ports_mask) {
  1056			res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_FUNC,
  1057						     YT921X_PON_STRAP_EEE, !!new_mask);
  1058			if (res)
  1059				return res;
  1060			res = yt921x_reg_toggle_bits(priv, YT921X_PON_STRAP_VAL,
  1061						     YT921X_PON_STRAP_EEE, !!new_mask);
  1062			if (res)
  1063				return res;
  1064		}
  1065	
  1066		priv->eee_ports_mask = new_mask;
  1067	
  1068		/* Enable / disable port EEE */
  1069		res = yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
  1070					     YT921X_EEE_CTRL_ENn(port), enable);
  1071		if (res)
  1072			return res;
  1073		res = yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
  1074					     YT921X_EEE_VAL_DATA, enable);
  1075		if (res)
  1076			return res;
  1077	
  1078		return 0;
  1079	}
  1080	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

