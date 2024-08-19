Return-Path: <netdev+bounces-119861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597D957455
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA77E1C23976
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AFC1DB45A;
	Mon, 19 Aug 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpdeO09h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5114BFA2
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095505; cv=none; b=j+P8S8Vnf1iUqNKdhW72tUFFIOiWkLRDOtgDNj2/hhv1B9N8o6/8a3ISwOTq3RHepZKK+j/ZJqCs3Ag4F1+KzTbrH23uKm2+ybR9DLNX/gx9C2gARFs5l8i1+OH9P4INX2s9+pNzC+JYzqjHK/SB20trvR5ToCTToBdkz6BXm78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095505; c=relaxed/simple;
	bh=qfUR7vvncyY/nvJgzTKH0x93pYYNUabDNfjgSdXX8e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgz4ZfTLnoMoTiDWhcrOGMQoOICjy9YOwAjFVSD0BEpCxw2nJdOE1gsMBqYNEGN6yO+jcKgsp/fx1k8o1//fhN4TMAwDmno1z9DVGWlpBvWCjZTG+Z0v+aWvfYbMQ8Tzd5+MoewxMqDD61vBj6VCBwtHRzxFJQI9CJd0l0Aky4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpdeO09h; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724095503; x=1755631503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qfUR7vvncyY/nvJgzTKH0x93pYYNUabDNfjgSdXX8e8=;
  b=IpdeO09h8Gxsw1EiOs3Hdu0BEJdPeecZoHncaYN9LUk2dACROOiYGVGT
   zLWIEo7oNTGF9+AsAK0+Mdv85ppW+Qgnlqs0ZY9Tqde2FxTb6a55jzT+r
   kPqZ/G8QYC1xt+50WoaJiJEMgsWYLL/d5m3roqicJOHxcNZNm5+Tv2LIg
   2v4KPqNMg15x0n2WBLOOREGsMnag9jlWlqY4hjRJaN4c0QdJr4qKVKEm8
   uWgojr4wYy+Ze6ZNgUHuYZsHUheNKPwoW2vmYewmvF1+MYls4U9zblXzA
   iH4gdmDTkPRzfqquj3bkFd3dIZHtzgf97ZPaZQ3AbxiZTn2CPBG72NYGV
   g==;
X-CSE-ConnectionGUID: CWUkJAPgTniM4wGh2zTvJg==
X-CSE-MsgGUID: ruWLhbNnTlCEeY3tltVlqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22507569"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22507569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 12:25:02 -0700
X-CSE-ConnectionGUID: xhfA93DATMWfkYkH6DYYSQ==
X-CSE-MsgGUID: 6EPH3wpwTrip7SNVeoZdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="65294940"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2024 12:25:00 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg7zs-0009MG-2Y;
	Mon, 19 Aug 2024 19:24:56 +0000
Date: Tue, 20 Aug 2024 03:24:25 +0800
From: kernel test robot <lkp@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <202408200327.ab8Ea0y8-lkp@intel.com>
References: <20240819075334.236334-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819075334.236334-2-liuhangbin@gmail.com>

Hi Hangbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangbin-Liu/bonding-add-common-function-to-check-ipsec-device/20240819-195504
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240819075334.236334-2-liuhangbin%40gmail.com
patch subject: [PATCHv2 net-next 1/3] bonding: add common function to check ipsec device
config: x86_64-buildonly-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408200327.ab8Ea0y8-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200327.ab8Ea0y8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200327.ab8Ea0y8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/bonding/bond_main.c:434:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
     434 |                 return NULL;
         |                        ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
   drivers/net/bonding/bond_main.c:442:10: error: returning 'void *' from a function with incompatible result type 'struct net_device'
     442 |                 return NULL;
         |                        ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
>> drivers/net/bonding/bond_main.c:446:9: error: returning 'struct net_device *' from a function with incompatible result type 'struct net_device'; dereference with *
     446 |         return real_dev;
         |                ^~~~~~~~
         |                *
>> drivers/net/bonding/bond_main.c:630:11: error: assigning to 'struct net_device *' from incompatible type 'struct net_device'
     630 |         real_dev = bond_ipsec_dev(xs);
         |                  ^ ~~~~~~~~~~~~~~~~~~
   4 errors generated.


vim +434 drivers/net/bonding/bond_main.c

   419	
   420	#ifdef CONFIG_XFRM_OFFLOAD
   421	/**
   422	 * bond_ipsec_dev - return the device for ipsec offload, or NULL if not exist
   423	 *                  caller must hold rcu_read_lock.
   424	 * @xs: pointer to transformer state struct
   425	 **/
   426	static struct net_device bond_ipsec_dev(struct xfrm_state *xs)
   427	{
   428		struct net_device *bond_dev = xs->xso.dev;
   429		struct net_device *real_dev;
   430		struct bonding *bond;
   431		struct slave *slave;
   432	
   433		if (!bond_dev)
 > 434			return NULL;
   435	
   436		bond = netdev_priv(bond_dev);
   437		slave = rcu_dereference(bond->curr_active_slave);
   438		real_dev = slave ? slave->dev : NULL;
   439	
   440		if ((BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) ||
   441		    !slave || !real_dev || !xs->xso.real_dev)
   442			return NULL;
   443	
   444		WARN_ON(xs->xso.real_dev != slave->dev);
   445	
 > 446		return real_dev;
   447	}
   448	
   449	/**
   450	 * bond_ipsec_add_sa - program device with a security association
   451	 * @xs: pointer to transformer state struct
   452	 * @extack: extack point to fill failure reason
   453	 **/
   454	static int bond_ipsec_add_sa(struct xfrm_state *xs,
   455				     struct netlink_ext_ack *extack)
   456	{
   457		struct net_device *bond_dev = xs->xso.dev;
   458		struct bond_ipsec *ipsec;
   459		struct bonding *bond;
   460		struct slave *slave;
   461		int err;
   462	
   463		if (!bond_dev)
   464			return -EINVAL;
   465	
   466		rcu_read_lock();
   467		bond = netdev_priv(bond_dev);
   468		slave = rcu_dereference(bond->curr_active_slave);
   469		if (!slave) {
   470			rcu_read_unlock();
   471			return -ENODEV;
   472		}
   473	
   474		if (!slave->dev->xfrmdev_ops ||
   475		    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
   476		    netif_is_bond_master(slave->dev)) {
   477			NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
   478			rcu_read_unlock();
   479			return -EINVAL;
   480		}
   481	
   482		ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);
   483		if (!ipsec) {
   484			rcu_read_unlock();
   485			return -ENOMEM;
   486		}
   487		xs->xso.real_dev = slave->dev;
   488	
   489		err = slave->dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
   490		if (!err) {
   491			ipsec->xs = xs;
   492			INIT_LIST_HEAD(&ipsec->list);
   493			spin_lock_bh(&bond->ipsec_lock);
   494			list_add(&ipsec->list, &bond->ipsec_list);
   495			spin_unlock_bh(&bond->ipsec_lock);
   496		} else {
   497			kfree(ipsec);
   498		}
   499		rcu_read_unlock();
   500		return err;
   501	}
   502	
   503	static void bond_ipsec_add_sa_all(struct bonding *bond)
   504	{
   505		struct net_device *bond_dev = bond->dev;
   506		struct bond_ipsec *ipsec;
   507		struct slave *slave;
   508	
   509		rcu_read_lock();
   510		slave = rcu_dereference(bond->curr_active_slave);
   511		if (!slave)
   512			goto out;
   513	
   514		if (!slave->dev->xfrmdev_ops ||
   515		    !slave->dev->xfrmdev_ops->xdo_dev_state_add ||
   516		    netif_is_bond_master(slave->dev)) {
   517			spin_lock_bh(&bond->ipsec_lock);
   518			if (!list_empty(&bond->ipsec_list))
   519				slave_warn(bond_dev, slave->dev,
   520					   "%s: no slave xdo_dev_state_add\n",
   521					   __func__);
   522			spin_unlock_bh(&bond->ipsec_lock);
   523			goto out;
   524		}
   525	
   526		spin_lock_bh(&bond->ipsec_lock);
   527		list_for_each_entry(ipsec, &bond->ipsec_list, list) {
   528			ipsec->xs->xso.real_dev = slave->dev;
   529			if (slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
   530				slave_warn(bond_dev, slave->dev, "%s: failed to add SA\n", __func__);
   531				ipsec->xs->xso.real_dev = NULL;
   532			}
   533		}
   534		spin_unlock_bh(&bond->ipsec_lock);
   535	out:
   536		rcu_read_unlock();
   537	}
   538	
   539	/**
   540	 * bond_ipsec_del_sa - clear out this specific SA
   541	 * @xs: pointer to transformer state struct
   542	 **/
   543	static void bond_ipsec_del_sa(struct xfrm_state *xs)
   544	{
   545		struct net_device *bond_dev = xs->xso.dev;
   546		struct bond_ipsec *ipsec;
   547		struct bonding *bond;
   548		struct slave *slave;
   549	
   550		if (!bond_dev)
   551			return;
   552	
   553		rcu_read_lock();
   554		bond = netdev_priv(bond_dev);
   555		slave = rcu_dereference(bond->curr_active_slave);
   556	
   557		if (!slave)
   558			goto out;
   559	
   560		if (!xs->xso.real_dev)
   561			goto out;
   562	
   563		WARN_ON(xs->xso.real_dev != slave->dev);
   564	
   565		if (!slave->dev->xfrmdev_ops ||
   566		    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
   567		    netif_is_bond_master(slave->dev)) {
   568			slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_delete\n", __func__);
   569			goto out;
   570		}
   571	
   572		slave->dev->xfrmdev_ops->xdo_dev_state_delete(xs);
   573	out:
   574		spin_lock_bh(&bond->ipsec_lock);
   575		list_for_each_entry(ipsec, &bond->ipsec_list, list) {
   576			if (ipsec->xs == xs) {
   577				list_del(&ipsec->list);
   578				kfree(ipsec);
   579				break;
   580			}
   581		}
   582		spin_unlock_bh(&bond->ipsec_lock);
   583		rcu_read_unlock();
   584	}
   585	
   586	static void bond_ipsec_del_sa_all(struct bonding *bond)
   587	{
   588		struct net_device *bond_dev = bond->dev;
   589		struct bond_ipsec *ipsec;
   590		struct slave *slave;
   591	
   592		rcu_read_lock();
   593		slave = rcu_dereference(bond->curr_active_slave);
   594		if (!slave) {
   595			rcu_read_unlock();
   596			return;
   597		}
   598	
   599		spin_lock_bh(&bond->ipsec_lock);
   600		list_for_each_entry(ipsec, &bond->ipsec_list, list) {
   601			if (!ipsec->xs->xso.real_dev)
   602				continue;
   603	
   604			if (!slave->dev->xfrmdev_ops ||
   605			    !slave->dev->xfrmdev_ops->xdo_dev_state_delete ||
   606			    netif_is_bond_master(slave->dev)) {
   607				slave_warn(bond_dev, slave->dev,
   608					   "%s: no slave xdo_dev_state_delete\n",
   609					   __func__);
   610			} else {
   611				slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
   612			}
   613			ipsec->xs->xso.real_dev = NULL;
   614		}
   615		spin_unlock_bh(&bond->ipsec_lock);
   616		rcu_read_unlock();
   617	}
   618	
   619	/**
   620	 * bond_ipsec_offload_ok - can this packet use the xfrm hw offload
   621	 * @skb: current data packet
   622	 * @xs: pointer to transformer state struct
   623	 **/
   624	static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
   625	{
   626		struct net_device *real_dev;
   627		int err;
   628	
   629		rcu_read_lock();
 > 630		real_dev = bond_ipsec_dev(xs);
   631		if (!real_dev) {
   632			err = false;
   633			goto out;
   634		}
   635	
   636		if (!real_dev->xfrmdev_ops ||
   637		    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
   638		    netif_is_bond_master(real_dev)) {
   639			err = false;
   640			goto out;
   641		}
   642	
   643		err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
   644	out:
   645		rcu_read_unlock();
   646		return err;
   647	}
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

