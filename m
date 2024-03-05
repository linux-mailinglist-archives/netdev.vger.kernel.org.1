Return-Path: <netdev+bounces-77437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA56871C58
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE051B2459F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7FC59B46;
	Tue,  5 Mar 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SUmWJNUM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5F59166
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635846; cv=none; b=XpRc39EfjsdLSzyrT6z1/oLb2sxyEXG+iyMeeNgVrqVQX1EL39vI5c6sOA0tyJ2ae46ESFYq8UZhctaorY4DXbJKcO/SkV3Sarqokw0pPthtsez/tu+O3arjGqSkgTJEqVzz2fq6vP5b9Ag8UmpqdC2q8cI9SSeFHd84kQ2cs68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635846; c=relaxed/simple;
	bh=nBrUXBdUCj8+tBqi/8EvBy7hpwGTCEMFWpnietkJZ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCE6trLT75LL5l4QmuwZEhBlZ9Oy0EUxBZprfZZ4UL8YnePJ287rUdNXE412Kc+tSgFaAPslOPezJCF0H0yB3peOOIYRm1z8h9h6XkYsmRXg7IwzvOSItGeCOoW06Q5TJznJscozAyRab5PmvwBl1XQu4uolspMekYTZks1zhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SUmWJNUM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709635844; x=1741171844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBrUXBdUCj8+tBqi/8EvBy7hpwGTCEMFWpnietkJZ6c=;
  b=SUmWJNUM0PILQY6p2RYR8Mu4fqgpg6SXdT7Q9XG16/91SxhJs4lvXq7W
   Hl89pAlLFHPFXeEUC1QrQ6L77/38EDLa9W9KHThnwx1GSQ9/QtbO9T4tr
   7tQPK0X89MdMJZNozaKMVybWtcARQ6R2ypN56vfOpF995P/xuW5AoaJzi
   o7nPT1pWSgnYht9v1CMjRbyAEpr23BoOYu9hwzKIA2jccJDf4FY4vNVj3
   i+69pwOR5/feW7UdkCJSeWr2Q7WwJvcD1bbxJCx8Fwp8SOPHxn/2DeWix
   7TkRIqWNeBjXl50vwDL4z7Vzc3GTuVCTMRmZziuMNNfwqnPb8gyLMjHlu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4345513"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4345513"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13824052"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Mar 2024 02:50:41 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhSNb-0003FR-0o;
	Tue, 05 Mar 2024 10:50:39 +0000
Date: Tue, 5 Mar 2024 18:49:49 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: Re: [PATCH net-next v2 03/22] ovpn: add basic netlink support
Message-ID: <202403051838.YHYbFiGD-lkp@intel.com>
References: <20240304150914.11444-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-4-antonio@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20240304-232835
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240304150914.11444-4-antonio%40openvpn.net
patch subject: [PATCH net-next v2 03/22] ovpn: add basic netlink support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240305/202403051838.YHYbFiGD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240305/202403051838.YHYbFiGD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403051838.YHYbFiGD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ovpn/netlink.c:82: warning: Function parameter or struct member 'net' not described in 'ovpn_get_dev_from_attrs'
>> drivers/net/ovpn/netlink.c:82: warning: Function parameter or struct member 'attrs' not described in 'ovpn_get_dev_from_attrs'
>> drivers/net/ovpn/netlink.c:181: warning: Function parameter or struct member 'nb' not described in 'ovpn_nl_notify'
>> drivers/net/ovpn/netlink.c:181: warning: Function parameter or struct member 'state' not described in 'ovpn_nl_notify'
>> drivers/net/ovpn/netlink.c:181: warning: Function parameter or struct member '_notify' not described in 'ovpn_nl_notify'
>> drivers/net/ovpn/netlink.c:193: warning: Function parameter or struct member 'ovpn' not described in 'ovpn_nl_init'


vim +82 drivers/net/ovpn/netlink.c

    76	
    77	/**
    78	 * ovpn_get_dev_from_attrs() - retrieve the netdevice a netlink message is targeting
    79	 */
    80	static struct net_device *
    81	ovpn_get_dev_from_attrs(struct net *net, struct nlattr **attrs)
  > 82	{
    83		struct net_device *dev;
    84		int ifindex;
    85	
    86		if (!attrs[OVPN_A_IFINDEX])
    87			return ERR_PTR(-EINVAL);
    88	
    89		ifindex = nla_get_u32(attrs[OVPN_A_IFINDEX]);
    90	
    91		dev = dev_get_by_index(net, ifindex);
    92		if (!dev)
    93			return ERR_PTR(-ENODEV);
    94	
    95		if (!ovpn_dev_is_valid(dev))
    96			goto err_put_dev;
    97	
    98		return dev;
    99	
   100	err_put_dev:
   101		dev_put(dev);
   102	
   103		return ERR_PTR(-EINVAL);
   104	}
   105	
   106	/**
   107	 * ovpn_pre_doit() - Prepare ovpn genl doit request
   108	 * @ops: requested netlink operation
   109	 * @skb: Netlink message with request data
   110	 * @info: receiver information
   111	 *
   112	 * Return: 0 on success or negative error number in case of failure
   113	 */
   114	static int ovpn_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
   115				 struct genl_info *info)
   116	{
   117		struct net *net = genl_info_net(info);
   118		struct net_device *dev;
   119	
   120		/* the OVPN_CMD_NEW_IFACE command is different from the rest as it
   121		 * just expects an IFNAME, while all the others expect an IFINDEX
   122		 */
   123		if (info->genlhdr->cmd == OVPN_CMD_NEW_IFACE) {
   124			if (!info->attrs[OVPN_A_IFNAME]) {
   125				GENL_SET_ERR_MSG(info, "no interface name specified");
   126				return -EINVAL;
   127			}
   128			return 0;
   129		}
   130	
   131		dev = ovpn_get_dev_from_attrs(net, info->attrs);
   132		if (IS_ERR(dev))
   133			return PTR_ERR(dev);
   134	
   135		info->user_ptr[0] = netdev_priv(dev);
   136	
   137		return 0;
   138	}
   139	
   140	/**
   141	 * ovpn_post_doit() - complete ovpn genl doit request
   142	 * @ops: requested netlink operation
   143	 * @skb: Netlink message with request data
   144	 * @info: receiver information
   145	 */
   146	static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
   147				   struct genl_info *info)
   148	{
   149		struct ovpn_struct *ovpn;
   150	
   151		ovpn = info->user_ptr[0];
   152		/* in case of OVPN_CMD_NEW_IFACE, there is no pre-stored device */
   153		if (ovpn)
   154			dev_put(ovpn->dev);
   155	}
   156	
   157	static const struct genl_small_ops ovpn_nl_ops[] = {
   158	};
   159	
   160	static struct genl_family ovpn_nl_family __ro_after_init = {
   161		.hdrsize = 0,
   162		.name = OVPN_NL_NAME,
   163		.version = 1,
   164		.maxattr = NUM_OVPN_A + 1,
   165		.policy = ovpn_nl_policy,
   166		.netnsok = true,
   167		.pre_doit = ovpn_pre_doit,
   168		.post_doit = ovpn_post_doit,
   169		.module = THIS_MODULE,
   170		.small_ops = ovpn_nl_ops,
   171		.n_small_ops = ARRAY_SIZE(ovpn_nl_ops),
   172		.mcgrps = ovpn_nl_mcgrps,
   173		.n_mcgrps = ARRAY_SIZE(ovpn_nl_mcgrps),
   174	};
   175	
   176	/**
   177	 * ovpn_nl_notify() - react to openvpn userspace process exit
   178	 */
   179	static int ovpn_nl_notify(struct notifier_block *nb, unsigned long state,
   180				  void *_notify)
 > 181	{
   182		return NOTIFY_DONE;
   183	}
   184	
   185	static struct notifier_block ovpn_nl_notifier = {
   186		.notifier_call = ovpn_nl_notify,
   187	};
   188	
   189	/**
   190	 * ovpn_nl_init() - perform any ovpn specific netlink initialization
   191	 */
   192	int ovpn_nl_init(struct ovpn_struct *ovpn)
 > 193	{
   194		return 0;
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

