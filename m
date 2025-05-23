Return-Path: <netdev+bounces-192991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EABAC200F
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84393B35F2
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26246227E9E;
	Fri, 23 May 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGo9IMja"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE6227B88;
	Fri, 23 May 2025 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747993551; cv=none; b=Cjxq/eNsmTaNVSH+7ipY1VtQKkb2nxKj8xMcFOMUVIjJYOs/JAVKfDR8RI3WGWZL/UsOi9AEO38zLHcrtfg4IyLrtfmvMsOPBY9ZPsGxA0mmmeUNbnkeii152bwoQsqxHl2gKxIAvhHnxPvYya9Z1i2Ku3lISX5Se78KVieiGz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747993551; c=relaxed/simple;
	bh=kKOD2Oafk+hlT9ZqnuwStPAAuPkDKIZ5LUIxpVuhGSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzLUtPxNVuf05zZjsdzko4jBtFvZa7ZppnzTGiblynOGFpHPyldYh6jtvD28GojEEM7KsKtF+2bIgkwdnKi/+kDa0ylvMxhTP6CT4ywcM3YHsaO8QOtL+pd1Pewzg4KjRU+rC7f6pg3Crtct+qgzhMmTzcoSC9XfrkCL5dAOuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGo9IMja; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747993550; x=1779529550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kKOD2Oafk+hlT9ZqnuwStPAAuPkDKIZ5LUIxpVuhGSA=;
  b=EGo9IMjacDxchbvr5vbM8AODE0Sjmx6g2mYzhU4Uw4E4xWuZkX5sy/Fy
   40Lu1bu9cRL84JB2S4h1X0vkKHEsV9w+30K3qvtgocZhBfma3jrfAePm1
   tld6ARoW/fBCkXR/6f81mdI50zuuHWQFR+H2SNoYjnR+vzFtZfnCi5yvt
   h9pX1Bbc3Zf/OChzhXTNfEwgP3IpkgFobZMh2BvRqTGZfmXxYOS/XaUfR
   e9KKFnb2cC3m/K2sWnEaLqwVFFoxBXUpZ3iG37otaUFRaKi27oW7UhnbB
   xQxdqLn+WdsXNf30XoM3K3OPU4e/F6n8J4iQE+NL0uo8Bb+QPrlxJiesF
   Q==;
X-CSE-ConnectionGUID: 2GB8EU/tQGqCrd3xaqjpcQ==
X-CSE-MsgGUID: TrUmr1jnQWGyklsEzHAtMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49162388"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49162388"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 02:45:42 -0700
X-CSE-ConnectionGUID: fkYlBhpkStyt3SelK8rBiw==
X-CSE-MsgGUID: q5su1r/yRIOFRYU0HMlPbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="172047497"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 May 2025 02:45:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIOy5-000QGM-1o;
	Fri, 23 May 2025 09:45:33 +0000
Date: Fri, 23 May 2025 17:44:57 +0800
From: kernel test robot <lkp@intel.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	bridge@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH net-next 5/5] net: dsa: forward bridge/switchdev mcast
 active notification
Message-ID: <202505231753.V7E84RiN-lkp@intel.com>
References: <20250522195952.29265-6-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522195952.29265-6-linus.luessing@c0d3.blue>

Hi Linus,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on linus/master v6.15-rc7 next-20250523]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-L-ssing/net-bridge-mcast-explicitly-track-active-state/20250523-040914
base:   net/main
patch link:    https://lore.kernel.org/r/20250522195952.29265-6-linus.luessing%40c0d3.blue
patch subject: [PATCH net-next 5/5] net: dsa: forward bridge/switchdev mcast active notification
config: s390-randconfig-001-20250523 (https://download.01.org/0day-ci/archive/20250523/202505231753.V7E84RiN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505231753.V7E84RiN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505231753.V7E84RiN-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/dsa/user.c: In function 'dsa_user_port_attr_set':
>> net/dsa/user.c:661:3: error: a label can only be part of a statement and a declaration is not a statement
      const bool *handled = ctx;
      ^~~~~
   net/dsa/user.c: In function 'dsa_user_switchdev_event':
   net/dsa/user.c:3770:3: error: a label can only be part of a statement and a declaration is not a statement
      struct switchdev_notifier_port_attr_info *item = ptr;
      ^~~~~~
   net/dsa/user.c: In function 'dsa_user_switchdev_blocking_event':
   net/dsa/user.c:3813:3: error: a label can only be part of a statement and a declaration is not a statement
      struct switchdev_notifier_port_attr_info *item = ptr;
      ^~~~~~


vim +661 net/dsa/user.c

   598	
   599	static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
   600					  const struct switchdev_attr *attr,
   601					  struct netlink_ext_ack *extack)
   602	{
   603		struct dsa_port *dp = dsa_user_to_port(dev);
   604		int ret;
   605	
   606		if (ctx && ctx != dp && attr->id != SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE)
   607			return 0;
   608	
   609		switch (attr->id) {
   610		case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
   611			if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
   612				return -EOPNOTSUPP;
   613	
   614			ret = dsa_port_set_state(dp, attr->u.stp_state, true);
   615			break;
   616		case SWITCHDEV_ATTR_ID_PORT_MST_STATE:
   617			if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
   618				return -EOPNOTSUPP;
   619	
   620			ret = dsa_port_set_mst_state(dp, &attr->u.mst_state, extack);
   621			break;
   622		case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
   623			if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
   624				return -EOPNOTSUPP;
   625	
   626			ret = dsa_port_vlan_filtering(dp, attr->u.vlan_filtering,
   627						      extack);
   628			break;
   629		case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
   630			if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
   631				return -EOPNOTSUPP;
   632	
   633			ret = dsa_port_ageing_time(dp, attr->u.ageing_time);
   634			break;
   635		case SWITCHDEV_ATTR_ID_BRIDGE_MST:
   636			if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
   637				return -EOPNOTSUPP;
   638	
   639			ret = dsa_port_mst_enable(dp, attr->u.mst, extack);
   640			break;
   641		case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
   642			if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
   643				return -EOPNOTSUPP;
   644	
   645			ret = dsa_port_pre_bridge_flags(dp, attr->u.brport_flags,
   646							extack);
   647			break;
   648		case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
   649			if (!dsa_port_offloads_bridge_port(dp, attr->orig_dev))
   650				return -EOPNOTSUPP;
   651	
   652			ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, extack);
   653			break;
   654		case SWITCHDEV_ATTR_ID_VLAN_MSTI:
   655			if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
   656				return -EOPNOTSUPP;
   657	
   658			ret = dsa_port_vlan_msti(dp, &attr->u.vlan_msti);
   659			break;
   660		case SWITCHDEV_ATTR_ID_BRIDGE_MC_ACTIVE:
 > 661			const bool *handled = ctx;
   662	
   663			if (!dsa_port_offloads_bridge_dev(dp, attr->orig_dev))
   664				return -EOPNOTSUPP;
   665	
   666			ret = dsa_port_bridge_mdb_active(dp, attr->u.mc_active, extack,
   667							 *handled);
   668			break;
   669		default:
   670			ret = -EOPNOTSUPP;
   671			break;
   672		}
   673	
   674		return ret;
   675	}
   676	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

