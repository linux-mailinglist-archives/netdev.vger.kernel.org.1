Return-Path: <netdev+bounces-188642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D225EAAE053
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93F63BAC4C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8C289E1A;
	Wed,  7 May 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QsHv9C0J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B92798EB
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623384; cv=none; b=sszglC67+2BxXbP/wcAoNZfKYrB3TeMLST3kuILvAW44hK/Kt4TRjQlIwnzAdcTSKc0U7/YxfzugeSOqpzQXeIR3rtBUhPHA+Ct6s5YuwF6Mc8w71429AAWsGazoT+0LvU22myHLNTdf/otMukzhDx2E4CiyTi+lF0Y61YDtYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623384; c=relaxed/simple;
	bh=sUsJqVsBiX36KFyM8w57PKkgxwx4UZqG6pHyRD50O4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmLBXINiy5xhJWvDuQURSIE+kUQyTAZfRMfhJ/WaFEIWTJ5jgTR1t+d0+mdLnzCBC08EZ4VhWpze7D/huufSVsjh5qymdD2CtF9Uum5Fx7DyB4MpFj4SwrPkDiYmElxiKR0+8f4LAyyOtW2pC/6gaA8tJSe6vfsxRv7kvkHo+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QsHv9C0J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746623382; x=1778159382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUsJqVsBiX36KFyM8w57PKkgxwx4UZqG6pHyRD50O4w=;
  b=QsHv9C0JuamRtQdlvO/2kagNmpVJFGmPdMPM7iaYBKpsTPlOwmKuu7lh
   XErEw4eo0P8P0TYeTuQBZydc8ieeLiY/RmVc/YDqPEhvkCKFg2NPWmOxC
   ZbpS0hvFXuho2KrFgA6wEh5Y4/uQfwmBrbjG02QWXHvBvpqTph+9MQfcP
   yo5hQIWU7jS2ogkUXfryknZioBd56NgBJ2VeU10plvhVhGySrWd/5CV6O
   3jppxxxDrCVvwJ6lY8iaxr7JxlafzPDig1l8mzh3L0bLTk6y1RkqfQOFP
   hk511SWu3LBD7cq/pV7tWkZMqoSMK4DERzJYf6m71QEPOeAeKPEAnYkto
   Q==;
X-CSE-ConnectionGUID: e+tQBz+DQciMut8o7xOMsA==
X-CSE-MsgGUID: FfLyV28XQ/O36/sK2txZ2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48253256"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48253256"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:09:41 -0700
X-CSE-ConnectionGUID: q5wI3BwXRXyQdAVvtwKEpQ==
X-CSE-MsgGUID: JANjWtvwTiC1od6Y+mQvbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136346223"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 May 2025 06:09:38 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCeWl-0007qb-0v;
	Wed, 07 May 2025 13:09:35 +0000
Date: Wed, 7 May 2025 21:08:36 +0800
From: kernel test robot <lkp@intel.com>
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org, almasrymina@google.com, sdf@fomichev.me,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	asml.silence@gmail.com, dw@davidwei.uk, skhawaja@google.com,
	willemb@google.com, jdamato@fastly.com, ap420073@gmail.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <202505072001.RHUTj8Jo-lkp@intel.com>
References: <20250506140858.2660441-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506140858.2660441-1-ap420073@gmail.com>

Hi Taehee,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Taehee-Yoo/net-devmem-fix-kernel-panic-when-socket-close-after-module-unload/20250506-221010
base:   net/main
patch link:    https://lore.kernel.org/r/20250506140858.2660441-1-ap420073%40gmail.com
patch subject: [PATCH net v2] net: devmem: fix kernel panic when socket close after module unload
config: i386-defconfig (https://download.01.org/0day-ci/archive/20250507/202505072001.RHUTj8Jo-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505072001.RHUTj8Jo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505072001.RHUTj8Jo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/netdev-genl.c:879:60: error: too many arguments to function call, expected 3, have 4
     879 |         binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);
         |                   ~~~~~~~~~~~~~~~~~~~~~~                          ^~~~~~~~~~~~
   net/core/devmem.h:132:1: note: 'net_devmem_bind_dmabuf' declared here
     132 | net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
         | ^                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     133 |                        struct netlink_ext_ack *extack)
         |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +879 net/core/netdev-genl.c

   827	
   828	int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
   829	{
   830		struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
   831		struct net_devmem_dmabuf_binding *binding;
   832		u32 ifindex, dmabuf_fd, rxq_idx;
   833		struct netdev_nl_sock *priv;
   834		struct net_device *netdev;
   835		struct sk_buff *rsp;
   836		struct nlattr *attr;
   837		int rem, err = 0;
   838		void *hdr;
   839	
   840		if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
   841		    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD) ||
   842		    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_QUEUES))
   843			return -EINVAL;
   844	
   845		ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
   846		dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
   847	
   848		priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
   849		if (IS_ERR(priv))
   850			return PTR_ERR(priv);
   851	
   852		rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
   853		if (!rsp)
   854			return -ENOMEM;
   855	
   856		hdr = genlmsg_iput(rsp, info);
   857		if (!hdr) {
   858			err = -EMSGSIZE;
   859			goto err_genlmsg_free;
   860		}
   861	
   862		err = 0;
   863		netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
   864		if (!netdev) {
   865			err = -ENODEV;
   866			goto err_genlmsg_free;
   867		}
   868		if (!netif_device_present(netdev))
   869			err = -ENODEV;
   870		else if (!netdev_need_ops_lock(netdev))
   871			err = -EOPNOTSUPP;
   872		if (err) {
   873			NL_SET_BAD_ATTR(info->extack,
   874					info->attrs[NETDEV_A_DEV_IFINDEX]);
   875			goto err_unlock;
   876		}
   877	
   878		mutex_lock(&priv->lock);
 > 879		binding = net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info->extack);
   880		if (IS_ERR(binding)) {
   881			err = PTR_ERR(binding);
   882			goto err_unlock_sock;
   883		}
   884	
   885		nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
   886				       genlmsg_data(info->genlhdr),
   887				       genlmsg_len(info->genlhdr), rem) {
   888			err = nla_parse_nested(
   889				tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
   890				netdev_queue_id_nl_policy, info->extack);
   891			if (err < 0)
   892				goto err_unbind;
   893	
   894			if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
   895			    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE)) {
   896				err = -EINVAL;
   897				goto err_unbind;
   898			}
   899	
   900			if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
   901				NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
   902				err = -EINVAL;
   903				goto err_unbind;
   904			}
   905	
   906			rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
   907	
   908			err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding,
   909							      info->extack);
   910			if (err)
   911				goto err_unbind;
   912		}
   913	
   914		list_add(&binding->list, &priv->bindings);
   915	
   916		nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
   917		genlmsg_end(rsp, hdr);
   918	
   919		err = genlmsg_reply(rsp, info);
   920		if (err)
   921			goto err_unbind;
   922	
   923		mutex_unlock(&priv->lock);
   924		netdev_unlock(netdev);
   925	
   926		return 0;
   927	
   928	err_unbind:
   929		net_devmem_unbind_dmabuf(binding);
   930	err_unlock_sock:
   931		mutex_unlock(&priv->lock);
   932	err_unlock:
   933		netdev_unlock(netdev);
   934	err_genlmsg_free:
   935		nlmsg_free(rsp);
   936		return err;
   937	}
   938	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

