Return-Path: <netdev+bounces-231882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B024BFE3B2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22603A83E8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4AE2FF678;
	Wed, 22 Oct 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grZ2eskk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B030103C;
	Wed, 22 Oct 2025 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166585; cv=none; b=KmpBvqjAPFDP7ZwRro3sPddbQWbuZrq0jqgjouLOyOoNKgBKkryeYYS9h68tWgbzWRQBde7e9oOOVO2q/nMUavJ8XQFVfuiLGhYfsol/7hcXf3H2E/sN1kjHM+MQ2E3BcWwyuxIxaAbv5FSrhRH3d9+H1UED6IrmjcfAGOXTz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166585; c=relaxed/simple;
	bh=9VV0eNlCO0aKOTNQ0ftSorMsYwugoX6hPbT021Kxr2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYWGEE5igW8VYdTibyqvG0ETsSKOLX32NeslbQVy+bIRfeyWbXCT+1C5gab6T09wLrS4SrdldUDjqsniQ/84Gz32gzer4E+E32R4tFaTv4GLHX2uTNifPFyLsTuJsBunMeyvUAJXdHowm4iewsepr2ivO4vQPv58WR18poS0SHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grZ2eskk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761166583; x=1792702583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VV0eNlCO0aKOTNQ0ftSorMsYwugoX6hPbT021Kxr2g=;
  b=grZ2eskkwKkHzfuCHoWN2xuNDiqio52Li2MY+AFNHIm7gsWrDQlHJluQ
   6jj0L1vbW6+kD7NLu0LTHUz8AuKG2JKUqO7QMZWMiaIEG7EjEFfLaA45x
   KnFFSTkgdj19KCjeNm0xXDsTIsHBSFNJlqAk0H9FXxXYXCdGw8QuS5w4t
   lTGVx/c9pfl31HpLwKnWTthkHuRP3p9oc+XFKrIuuevPhEry45bbHKXBE
   TBkfKAgWMC6TEbLkAqedgDhDEttJH5IzqA7Gr+YtJZawSfOJdIZOMhLZk
   XfkL9+R4DG9lHnZa+Quor6Hi9Z9Mvsnrmyfqpf1J+OJFkrxM7wcepT9Vj
   A==;
X-CSE-ConnectionGUID: b8ByRccjTQOkVvI/pfndMQ==
X-CSE-MsgGUID: Im9wo/KrTEK2A2boHkYhcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73617195"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73617195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 13:56:22 -0700
X-CSE-ConnectionGUID: wQdIDc00StKcB534pCZm8A==
X-CSE-MsgGUID: CAdJFoNHTeOU/x14wMW4WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214628315"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 22 Oct 2025 13:56:19 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBfsX-000Cj7-1P;
	Wed, 22 Oct 2025 20:56:17 +0000
Date: Thu, 23 Oct 2025 04:55:18 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrey.bokhanko@huawei.com,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 6/8] ipvlan: Support GSO for port -> ipvlan
Message-ID: <202510230401.r4e62ODH-lkp@intel.com>
References: <20251021144410.257905-7-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021144410.257905-7-skorodumov.dmitry@huawei.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Skorodumov/ipvlan-Implement-learnable-L2-bridge/20251021-224923
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251021144410.257905-7-skorodumov.dmitry%40huawei.com
patch subject: [PATCH net-next 6/8] ipvlan: Support GSO for port -> ipvlan
config: i386-buildonly-randconfig-004-20251023 (https://download.01.org/0day-ci/archive/20251023/202510230401.r4e62ODH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510230401.r4e62ODH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510230401.r4e62ODH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ipvlan/ipvlan_main.c:943:27: warning: variable 'ipvlan' is uninitialized when used here [-Wuninitialized]
     943 |                 if (ipvlan_is_learnable(ipvlan->port))
         |                                         ^~~~~~
   drivers/net/ipvlan/ipvlan_main.c:870:25: note: initialize the variable 'ipvlan' to silence this warning
     870 |         struct ipvl_dev *ipvlan, *next;
         |                                ^
         |                                 = NULL
   1 warning generated.


vim +/ipvlan +943 drivers/net/ipvlan/ipvlan_main.c

1fb81b882de575 Dmitry Skorodumov  2025-10-21  863  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  864  static int ipvlan_device_event(struct notifier_block *unused,
2ad7bf3638411c Mahesh Bandewar    2014-11-23  865  			       unsigned long event, void *ptr)
2ad7bf3638411c Mahesh Bandewar    2014-11-23  866  {
61345fab484b97 Petr Machata       2018-12-13  867  	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
61345fab484b97 Petr Machata       2018-12-13  868  	struct netdev_notifier_pre_changeaddr_info *prechaddr_info;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  869  	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  870  	struct ipvl_dev *ipvlan, *next;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  871  	struct ipvl_port *port;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  872  	LIST_HEAD(lst_kill);
61345fab484b97 Petr Machata       2018-12-13  873  	int err;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  874  
1fb81b882de575 Dmitry Skorodumov  2025-10-21  875  	if (event == NETDEV_DOWN && ipvlan_is_valid_dev(dev)) {
1fb81b882de575 Dmitry Skorodumov  2025-10-21  876  		struct ipvl_dev *ipvlan = netdev_priv(dev);
1fb81b882de575 Dmitry Skorodumov  2025-10-21  877  
1fb81b882de575 Dmitry Skorodumov  2025-10-21  878  		ipvlan_addrs_forget_all(ipvlan);
1fb81b882de575 Dmitry Skorodumov  2025-10-21  879  		return NOTIFY_DONE;
1fb81b882de575 Dmitry Skorodumov  2025-10-21  880  	}
1fb81b882de575 Dmitry Skorodumov  2025-10-21  881  
5933fea7aa7237 Mahesh Bandewar    2014-12-06  882  	if (!netif_is_ipvlan_port(dev))
2ad7bf3638411c Mahesh Bandewar    2014-11-23  883  		return NOTIFY_DONE;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  884  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  885  	port = ipvlan_port_get_rtnl(dev);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  886  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  887  	switch (event) {
57fb346cc7d0fc Di Zhu             2021-07-29  888  	case NETDEV_UP:
22978397083888 Venkat Venkatsubra 2024-04-05  889  	case NETDEV_DOWN:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  890  	case NETDEV_CHANGE:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  891  		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
2ad7bf3638411c Mahesh Bandewar    2014-11-23  892  			netif_stacked_transfer_operstate(ipvlan->phy_dev,
2ad7bf3638411c Mahesh Bandewar    2014-11-23  893  							 ipvlan->dev);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  894  		break;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  895  
3133822f5ac13b Florian Westphal   2017-04-20  896  	case NETDEV_REGISTER: {
3133822f5ac13b Florian Westphal   2017-04-20  897  		struct net *oldnet, *newnet = dev_net(dev);
3133822f5ac13b Florian Westphal   2017-04-20  898  
3133822f5ac13b Florian Westphal   2017-04-20  899  		oldnet = read_pnet(&port->pnet);
3133822f5ac13b Florian Westphal   2017-04-20  900  		if (net_eq(newnet, oldnet))
3133822f5ac13b Florian Westphal   2017-04-20  901  			break;
3133822f5ac13b Florian Westphal   2017-04-20  902  
3133822f5ac13b Florian Westphal   2017-04-20  903  		write_pnet(&port->pnet, newnet);
3133822f5ac13b Florian Westphal   2017-04-20  904  
043d5f68d0ccdd Lu Wei             2023-08-17  905  		if (port->mode == IPVLAN_MODE_L3S)
c675e06a98a474 Daniel Borkmann    2019-02-08  906  			ipvlan_migrate_l3s_hook(oldnet, newnet);
3133822f5ac13b Florian Westphal   2017-04-20  907  		break;
3133822f5ac13b Florian Westphal   2017-04-20  908  	}
2ad7bf3638411c Mahesh Bandewar    2014-11-23  909  	case NETDEV_UNREGISTER:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  910  		if (dev->reg_state != NETREG_UNREGISTERING)
2ad7bf3638411c Mahesh Bandewar    2014-11-23  911  			break;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  912  
8230819494b3bf Paolo Abeni        2018-02-28  913  		list_for_each_entry_safe(ipvlan, next, &port->ipvlans, pnode)
2ad7bf3638411c Mahesh Bandewar    2014-11-23  914  			ipvlan->dev->rtnl_link_ops->dellink(ipvlan->dev,
2ad7bf3638411c Mahesh Bandewar    2014-11-23  915  							    &lst_kill);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  916  		unregister_netdevice_many(&lst_kill);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  917  		break;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  918  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  919  	case NETDEV_FEAT_CHANGE:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  920  		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
6df6398f7c8b48 Jakub Kicinski     2022-05-05  921  			netif_inherit_tso_max(ipvlan->dev, dev);
d0f5c7076e01fe Mahesh Bandewar    2020-08-14  922  			netdev_update_features(ipvlan->dev);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  923  		}
2ad7bf3638411c Mahesh Bandewar    2014-11-23  924  		break;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  925  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  926  	case NETDEV_CHANGEMTU:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  927  		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
2ad7bf3638411c Mahesh Bandewar    2014-11-23  928  			ipvlan_adjust_mtu(ipvlan, dev);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  929  		break;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  930  
61345fab484b97 Petr Machata       2018-12-13  931  	case NETDEV_PRE_CHANGEADDR:
61345fab484b97 Petr Machata       2018-12-13  932  		prechaddr_info = ptr;
61345fab484b97 Petr Machata       2018-12-13  933  		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
0413a34ef678c3 Stanislav Fomichev 2025-07-17  934  			err = netif_pre_changeaddr_notify(ipvlan->dev,
61345fab484b97 Petr Machata       2018-12-13  935  							  prechaddr_info->dev_addr,
61345fab484b97 Petr Machata       2018-12-13  936  							  extack);
61345fab484b97 Petr Machata       2018-12-13  937  			if (err)
61345fab484b97 Petr Machata       2018-12-13  938  				return notifier_from_errno(err);
61345fab484b97 Petr Machata       2018-12-13  939  		}
61345fab484b97 Petr Machata       2018-12-13  940  		break;
61345fab484b97 Petr Machata       2018-12-13  941  
32c10bbfe914c7 Mahesh Bandewar    2017-10-11  942  	case NETDEV_CHANGEADDR:
711f25b2660608 Dmitry Skorodumov  2025-10-21 @943  		if (ipvlan_is_learnable(ipvlan->port))
711f25b2660608 Dmitry Skorodumov  2025-10-21  944  			break;
711f25b2660608 Dmitry Skorodumov  2025-10-21  945  
ab452c3ce7bacb Keefe Liu          2018-05-14  946  		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
e35b8d7dbb094c Jakub Kicinski     2021-10-01  947  			eth_hw_addr_set(ipvlan->dev, dev->dev_addr);
ab452c3ce7bacb Keefe Liu          2018-05-14  948  			call_netdevice_notifiers(NETDEV_CHANGEADDR, ipvlan->dev);
ab452c3ce7bacb Keefe Liu          2018-05-14  949  		}
32c10bbfe914c7 Mahesh Bandewar    2017-10-11  950  		break;
32c10bbfe914c7 Mahesh Bandewar    2017-10-11  951  
2ad7bf3638411c Mahesh Bandewar    2014-11-23  952  	case NETDEV_PRE_TYPE_CHANGE:
2ad7bf3638411c Mahesh Bandewar    2014-11-23  953  		/* Forbid underlying device to change its type. */
2ad7bf3638411c Mahesh Bandewar    2014-11-23  954  		return NOTIFY_BAD;
e79a98e68b96a9 Etienne Champetier 2025-01-08  955  
e79a98e68b96a9 Etienne Champetier 2025-01-08  956  	case NETDEV_NOTIFY_PEERS:
e79a98e68b96a9 Etienne Champetier 2025-01-08  957  	case NETDEV_BONDING_FAILOVER:
e79a98e68b96a9 Etienne Champetier 2025-01-08  958  	case NETDEV_RESEND_IGMP:
e79a98e68b96a9 Etienne Champetier 2025-01-08  959  		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
e79a98e68b96a9 Etienne Champetier 2025-01-08  960  			call_netdevice_notifiers(event, ipvlan->dev);
2ad7bf3638411c Mahesh Bandewar    2014-11-23  961  	}
2ad7bf3638411c Mahesh Bandewar    2014-11-23  962  	return NOTIFY_DONE;
2ad7bf3638411c Mahesh Bandewar    2014-11-23  963  }
2ad7bf3638411c Mahesh Bandewar    2014-11-23  964  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

