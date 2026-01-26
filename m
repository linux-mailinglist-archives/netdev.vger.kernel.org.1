Return-Path: <netdev+bounces-253606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKqZMIPod2mwmQEAu9opvQ
	(envelope-from <netdev+bounces-253606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:19:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEA8DE6B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 428CE3004683
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD11C862F;
	Mon, 26 Jan 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXDN6svr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579B32F99BD
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465982; cv=none; b=jGjNcBhVKwWHLEOOBSSNI4P/JqXe9Fg3m68nKyUpRkqb+ODKnkx4kw/+nbe6nVDO6g1MexJhBxD5Zt/LB2LbJAMJ2cPWWSyokZT9+Y4OorCo+fD0FVpntwx2racpbYPHAmByr2UpdZG4rSHiAAkXtXqeaXnq8EQiuWWcEZfjoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465982; c=relaxed/simple;
	bh=MfG5mNjjM2G02N3+AWG0P0JkfwOAvfM7VEWe3256V5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYEHva1SdIihKXKCdFm7EyJS9x9YGytPMxJYguyDoJh1HztQlbZp3B0UlacLNiQzQGsrfJq5EJbgbKd2AHH3n/jj7k3uamiCXiVaS+LuQYMIXmxf2Ki5k0Y7Y7hIDVQC9JJ93dGC1MKYihPugkOBBmmjqmdFpLlDr/JHwzEoVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iXDN6svr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769465980; x=1801001980;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MfG5mNjjM2G02N3+AWG0P0JkfwOAvfM7VEWe3256V5c=;
  b=iXDN6svrT9SE18gIoKHKbdQjiAqMdHdLvJn7/2woqeWfXtyiwq8GZ/q/
   imcv0jihDY4/rDYChdBSBL2c05TpbC08Qxs2nJgrZfLQOr31aCCsB9AN3
   ESVsXnOYRcxGmUaJXhAQb6n1GOcqVOeN1fU7QTKgWjQelLOmpMJFjMfi/
   lKPlokgJ6zQ0oMqAfdPxrwDoPVeS/47iWgL02DohQP+VHbQSGYIUagRpG
   rulaFHuY+/txTpIpDM+X0oiVZ38vOFM8Twsr41jFaqjW3RWCzdP6xTwSN
   KuYyLbMecjHMZrFrMkP25j7q8CfuZ9u4YghksJnYCZShXIuFLQpyhZCUf
   Q==;
X-CSE-ConnectionGUID: qNnXQ2CrSWyhb//g+0cS4g==
X-CSE-MsgGUID: J+3FiU+6RkaDvbzuYy3Z1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82020728"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82020728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 14:19:40 -0800
X-CSE-ConnectionGUID: g4hHWet8R1qn9oh1nF18gQ==
X-CSE-MsgGUID: tuyl5+JHQhyy8v27GXZOhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="245405233"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jan 2026 14:19:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkUvl-00000000Xjy-2AbJ;
	Mon, 26 Jan 2026 22:19:33 +0000
Date: Tue, 27 Jan 2026 06:19:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 08/22] net: stmmac: rk: convert rk3588 to
 mask-based interface mode config
Message-ID: <202601270652.AmCxSo3f-lkp@intel.com>
References: <E1vkL2I-00000005usu-42Hy@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vkL2I-00000005usu-42Hy@rmk-PC.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253606-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: EBEEA8DE6B
X-Rspamd-Action: no action

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-stmmac-rk-avoid-phy_power_on/20260126-234820
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1vkL2I-00000005usu-42Hy%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next v2 08/22] net: stmmac: rk: convert rk3588 to mask-based interface mode config
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260127/202601270652.AmCxSo3f-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601270652.AmCxSo3f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601270652.AmCxSo3f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c: In function 'rk_write_gmac_grf_reg':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:132:24: warning: variable 'regmap' set but not used [-Wunused-but-set-variable]
     132 |         struct regmap *regmap;
         |                        ^~~~~~


vim +/regmap +132 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

   129	
   130	static int rk_write_gmac_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
   131	{
 > 132		struct regmap *regmap;
   133	
   134		if (bsp_priv->ops->gmac_grf_reg_in_php)
   135			regmap = bsp_priv->php_grf;
   136		else
   137			regmap = bsp_priv->grf;
   138	
   139		return regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

