Return-Path: <netdev+bounces-192988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC3EAC1FB7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 11:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53886A40DA0
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78B1A0731;
	Fri, 23 May 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkN4RQBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C7225768;
	Fri, 23 May 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992342; cv=none; b=IunCNwBg1n+1saM574R0M1TFNOrADYTVoy4o9OuNZRAl1+tfWunfJjnLYxbH0x81uBnEty6H90fu2n1tvXaKs2EIz96OJ5LCXPXfZsRnXSzEJdefvEDCi2HggvzqEHvBqrsXMLm0Ayqc93L3RoDIfAzp2pNUSFyPQxTWkQx48lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992342; c=relaxed/simple;
	bh=xIx2bwVUtQ3huZmlIbwcfn+SKmsSoHtb+xhBVD3NCgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCzvKDDgx0KMjdrd4NlNY9cU1Rgc8fbtpURbJXjJvUsDJ7e0sdENtBuA+bbTBfV3Nmgd8m4im6v5o6Ux5UPq+QGzXMCJDPodr3GGX3hPvY6Vyx0n5aVsfo8rIUBPA9B5MpOCfb478nK1pHfSFT5bRCrRQldQKzX/LnL0eEt175s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkN4RQBQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747992341; x=1779528341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIx2bwVUtQ3huZmlIbwcfn+SKmsSoHtb+xhBVD3NCgs=;
  b=fkN4RQBQfYMZBDO04oNZmdE535oEqER86oZeV7IiroAOUVy1mVet5ZGy
   XI2jHiffWfq42Euc3NqiJ+rKaBgUes2JVqCjIp3DPRAxcwG6GIZ7YmoFS
   PhhpdrhY59ZWiEGxSVnITyARt6Xk/oFjZBbpv9K+vqn2ATQ92eZ2SWlAm
   EKxS6knLiA1YQ0MTdNrDsHyPhHH0u5X3pPEbMTWttys4kwVcCQtjUw9RF
   vhJHNM4guUpGkwbJsVf/hBxDFUXmtrysEZjaVxQO+UTieDMlbPPhh3Kr9
   5nTTNiyP1j8pzQWTp732lI7VcJDrTDPOO6xeAeuRbnQK+i7lY4AiipXXZ
   w==;
X-CSE-ConnectionGUID: t+vhbWDVTzms+7mzOvfzoQ==
X-CSE-MsgGUID: il2Bnsd2TTumSvAh+duNIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49298634"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49298634"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 02:25:40 -0700
X-CSE-ConnectionGUID: 95iuNjHwQEuZE2QF0x84ig==
X-CSE-MsgGUID: imtu0mmaSreNQztWv5IOWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="145027350"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 May 2025 02:25:33 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIOeh-000QFc-2V;
	Fri, 23 May 2025 09:25:31 +0000
Date: Fri, 23 May 2025 17:24:35 +0800
From: kernel test robot <lkp@intel.com>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
	bridge@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
Message-ID: <202505231706.fkxIDjje-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v6.15-rc7 next-20250522]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linus-L-ssing/net-bridge-mcast-explicitly-track-active-state/20250523-040914
base:   net/main
patch link:    https://lore.kernel.org/r/20250522195952.29265-6-linus.luessing%40c0d3.blue
patch subject: [PATCH net-next 5/5] net: dsa: forward bridge/switchdev mcast active notification
config: i386-randconfig-001-20250523 (https://download.01.org/0day-ci/archive/20250523/202505231706.fkxIDjje-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505231706.fkxIDjje-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505231706.fkxIDjje-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/dsa/user.c:661:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     661 |                 const bool *handled = ctx;
         |                 ^
   net/dsa/user.c:3770:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3770 |                 struct switchdev_notifier_port_attr_info *item = ptr;
         |                 ^
   net/dsa/user.c:3813:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3813 |                 struct switchdev_notifier_port_attr_info *item = ptr;
         |                 ^
   3 warnings generated.


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

