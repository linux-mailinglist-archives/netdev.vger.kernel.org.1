Return-Path: <netdev+bounces-83750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C1893B7F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8D1F21FBF
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E722209F;
	Mon,  1 Apr 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GRs7LLHX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D5F9DF
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978547; cv=none; b=CyoBEp2viML+Wmo+TXarCzf131LBrdD7BiXJaJQP0W6xyfVwXxHb2V6gunKmdEeXQAT/cIWKWZlOnuiEY9ATgdX8HAK7ZCAblyX8NnzVWMfTLCUfVwjnkF3EmaIMvUF+iLHI7oxbV515EWJReJ/B0KRUAov/djsrE/jx/135Pr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978547; c=relaxed/simple;
	bh=iRuf3HR/Q6lUBt8jMnfPN27pWYNg+B5rAXrRiiQjEw4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3YPL2t+Qio+fT8P6N+NT6FE4533/tyPy+pqsOGGiolMoYtwJEoVFw3iT/5Y2Nkx/sXc/Sq1TbAnI/8Yahi71/01VHngfQAfB9G7hhnYbCEWOBFXV3pfbVOYlj6r9Pe/swwJfxUBd54FlvJ3XQ4vUZsATBVX5VZaXGrt3xrXF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GRs7LLHX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4318ioTV012328;
	Mon, 1 Apr 2024 06:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=p/PPmGH9cVxut1DMXeVrhg
	7sIvZEe0sk1qOsyNThMDU=; b=GRs7LLHXiWVfy/x+/+XaryYTuS2u6XR3NBRO41
	zwzRWyqX7x6jszEMhFrGHvJ7y6TBOgugmibk+nyWpcFfgQkvfQl0keHICRrFlrT2
	gjCSPb8bbzarr/7ep1twI9/Qz2u+LPUCHNSi51sy2VbWD319zy34cWM0NaxLb6ee
	eZjEGSzeXfWmzi1pVdHSw8Kz3YU0tPe3ldAHTWdwMUn8Gb1y8DGdUV3lOGcS/mi7
	hdLL1QrgJjOey0a4U9d/YsqdA+RVY9ORJcDdc6xmVmvIvc+qygtlRrKrHNDT4g1y
	00xMoS325q80OfMGVsG7Lt71bwZo2Bf7QpIu9Rs5gbzofd9A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x7spe8psp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 06:35:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Apr 2024 06:35:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Apr 2024 06:35:21 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 60C613F703F;
	Mon,  1 Apr 2024 06:35:19 -0700 (PDT)
Date: Mon, 1 Apr 2024 19:05:18 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Denis Kirjanov <kirjanov@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, Denis Kirjanov <dkirjanov@suse.de>,
        <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Subject: Re: [PATCH 4 net] RDMA/core: fix UAF with ib_device_get_netdev()
Message-ID: <20240401133518.GA1642209@maili.marvell.com>
References: <20240401100005.1799-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240401100005.1799-1-dkirjanov@suse.de>
X-Proofpoint-GUID: P3vXSHtq0-zaoBRhfjJt5jbFYv48Eepc
X-Proofpoint-ORIG-GUID: P3vXSHtq0-zaoBRhfjJt5jbFYv48Eepc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_09,2024-04-01_01,2023-05-22_02

On 2024-04-01 at 15:30:05, Denis Kirjanov (kirjanov@gmail.com) wrote:
> A call to ib_device_get_netdev may lead to a race condition
> while accessing a netdevice instance since we don't hold
> the rtnl lock while checking
> the registration state:
> 	if (res && res->reg_state != NETREG_REGISTERED) {
>
> v2: unlock rtnl on error path
> v3: update remaining callers of ib_device_get_netdev
> v4: don't call a cb with rtnl lock in ib_enum_roce_netdev
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/cache.c  |  2 ++
>  drivers/infiniband/core/device.c | 15 ++++++++++++---
>  drivers/infiniband/core/nldev.c  |  3 +++
>  drivers/infiniband/core/verbs.c  |  6 ++++--
>  4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index c02a96d3572a..cf9c826cd520 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1461,7 +1461,9 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>  		if (rdma_protocol_iwarp(device, port)) {
>  			struct net_device *ndev;
>
> +			rtnl_lock();
>  			ndev = ib_device_get_netdev(device, port);
> +			rtnl_unlock();
Why dont you move the rtnl_lock()/_unlock() inside ib_device_get_netdev().
ib_device_get_netdev() hold ref to dev, so can access ndev safely here.

>  			if (!ndev)
>  				continue;
>  			RCU_INIT_POINTER(gid_attr.ndev, ndev);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 07cb6c5ffda0..25edb50d2b64 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2026,9 +2026,12 @@ static int iw_query_port(struct ib_device *device,
>
>  	memset(port_attr, 0, sizeof(*port_attr));
>
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(device, port_num);
> -	if (!netdev)
> +	if (!netdev) {
> +		rtnl_unlock();
>  		return -ENODEV;
> +	}
>
>  	port_attr->max_mtu = IB_MTU_4096;
>  	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
> @@ -2052,6 +2055,7 @@ static int iw_query_port(struct ib_device *device,
>  		rcu_read_unlock();
>  	}
>
> +	rtnl_unlock();
>  	dev_put(netdev);
>  	return device->ops.query_port(device, port_num, port_attr);
>  }
> @@ -2220,6 +2224,8 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
>  	struct ib_port_data *pdata;
>  	struct net_device *res;
>
> +	ASSERT_RTNL();
> +
>  	if (!rdma_is_port_valid(ib_dev, port))
>  		return NULL;
>
> @@ -2306,8 +2312,11 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
>
>  	rdma_for_each_port (ib_dev, port)
>  		if (rdma_protocol_roce(ib_dev, port)) {
> -			struct net_device *idev =
> -				ib_device_get_netdev(ib_dev, port);
> +			struct net_device *idev;
> +
> +			rtnl_lock();
> +			idev = ib_device_get_netdev(ib_dev, port);
> +			rtnl_unlock();
>
>  			if (filter(ib_dev, port, idev, filter_cookie))
>  				cb(ib_dev, port, idev, cookie);
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index 4900a0848124..5cf7cdae8925 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -360,7 +360,9 @@ static int fill_port_info(struct sk_buff *msg,
>  	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
>  		return -EMSGSIZE;
>
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(device, port);
> +
>  	if (netdev && net_eq(dev_net(netdev), net)) {
>  		ret = nla_put_u32(msg,
>  				  RDMA_NLDEV_ATTR_NDEV_INDEX, netdev->ifindex);
> @@ -371,6 +373,7 @@ static int fill_port_info(struct sk_buff *msg,
>  	}
>
>  out:
> +	rtnl_unlock();
>  	dev_put(netdev);
>  	return ret;
>  }
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..6a3757b00c93 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>  		return -EINVAL;
>
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(dev, port_num);
> -	if (!netdev)
> +	if (!netdev) {
> +		rtnl_unlock();
>  		return -ENODEV;
> +	}
>
> -	rtnl_lock();
>  	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
>  	rtnl_unlock();
>
> --
> 2.30.2
>

