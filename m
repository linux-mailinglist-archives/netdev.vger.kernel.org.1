Return-Path: <netdev+bounces-266230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLQJF5xLsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7C2550F3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA938323D4DF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57C3B2FCF;
	Tue, 10 Mar 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5naDtzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFF93B2FC7;
	Tue, 10 Mar 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157531; cv=none; b=KQxAOm+oSb/Ja3tJOGCyi4yGrvCd2EIFEHb9HNIkHSwI85gMWmAU/weGVtSfxPwcHInW2ftM25LH/JHNBXVAbGAliUl+SQSZfx9dIieneMsxNo6DMN+RPYQPsDjhQDcOGEa/u6oAy46vrI+Bk/sfYpK2Aq2INFmkJaI/+jeRMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157531; c=relaxed/simple;
	bh=Cv97Ws/zNwbo6YWXcHsBsuy9O/qYjJBZgOhqLepgki0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ehbj5EtYW8LVPVFwPwxJM9GYxgBJhscZLNxC5YyEE1vQwfBH2OLHVclHExoxXTAPp16IOTuBQWuonv5p6pS+fbDTtRa90vkNbI0f7/q0EkEyS4lKQ7TUj4KiNwnW+ZhZY5Acx0SM4C0NmWUO3hm6dvOAj2r7OnP59w/8L0GWfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5naDtzJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773157530; x=1804693530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cv97Ws/zNwbo6YWXcHsBsuy9O/qYjJBZgOhqLepgki0=;
  b=C5naDtzJtBiIGBZ1+iCj1hq6mnXKOH/B4R1+Rng3O7qF/h+tANxY3NX4
   1BDjbD7amf3vafT9Ag53vkCrb+61j5uIF+PUQcIJei6TIYlDVPyJruynq
   6xSf8hOeo4NfguJ/+dmzZ7F6VEIgZBrqbQlrtrUI+h2p1fpP5Ex2KLUfY
   EMbUcVSbsg4hfWkWDVxA4qNDrf31rz4D0rMZePk5gdbkZI8N1vcUs/dy2
   vWPVxg5XwoEaTj0LQKmO0WMQ5PlflirH/Qxm0WxKantHqQxGz2kJMPIol
   NKK2/vn/qK2U0qbaxvbBjf6vFb9ZMGYuHtXGMCZg1x4+/rTE/ao+TzPkW
   Q==;
X-CSE-ConnectionGUID: Z6Y+7uEGS7WP/+Rvr6K6iw==
X-CSE-MsgGUID: D2ltXs4hQgWMKLjApoi9zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85563507"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85563507"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:45:29 -0700
X-CSE-ConnectionGUID: jEw2x5dgTzGHsXowmShwPw==
X-CSE-MsgGUID: KYAMdssUQ96LnOJT768SxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220337301"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Mar 2026 08:45:23 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzzGp-000000002AS-30bv;
	Tue, 10 Mar 2026 15:45:19 +0000
Date: Tue, 10 Mar 2026 23:45:12 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge
 offloading
Message-ID: <202603102333.SSWo6WNe-lkp@intel.com>
References: <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: 52F7C2550F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266230-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,param.tci:url]
X-Rspamd-Action: no action

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Golle/dsa-tag_mxl862xx-set-dsa_default_offload_fwd_mark/20260310-084425
base:   net-next/main
patch link:    https://lore.kernel.org/r/f6fb8c9c6d38585c0efce72b3d1aebe923277d5a.1773102942.git.daniel%40makrotopia.org
patch subject: [PATCH net-next v2 2/2] net: dsa: mxl862xx: implement bridge offloading
config: x86_64-randconfig-004-20260310 (https://download.01.org/0day-ci/archive/20260310/202603102333.SSWo6WNe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260310/202603102333.SSWo6WNe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603102333.SSWo6WNe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dsa/mxl862xx/mxl862xx.c:655:2: error: call to undeclared function 'ether_addr_copy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     655 |         ether_addr_copy(param.mac, addr);
         |         ^
   drivers/net/dsa/mxl862xx/mxl862xx.c:676:2: error: call to undeclared function 'ether_addr_copy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     676 |         ether_addr_copy(param.mac, addr);
         |         ^
   2 errors generated.


vim +/ether_addr_copy +655 drivers/net/dsa/mxl862xx/mxl862xx.c

   640	
   641	static int mxl862xx_port_fdb_add(struct dsa_switch *ds, int port,
   642					 const unsigned char *addr, u16 vid, struct dsa_db db)
   643	{
   644		struct mxl862xx_mac_table_add param = { };
   645		int fid = mxl862xx_get_fid(ds, db), ret;
   646		struct mxl862xx_priv *priv = ds->priv;
   647	
   648		if (fid < 0)
   649			return fid;
   650	
   651		param.port_id = cpu_to_le32(port);
   652		param.static_entry = true;
   653		param.fid = cpu_to_le16(fid);
   654		param.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, vid));
 > 655		ether_addr_copy(param.mac, addr);
   656	
   657		ret = MXL862XX_API_WRITE(priv, MXL862XX_MAC_TABLEENTRYADD, param);
   658		if (ret)
   659			dev_err(ds->dev, "failed to add FDB entry on port %d\n", port);
   660	
   661		return ret;
   662	}
   663	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

