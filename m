Return-Path: <netdev+bounces-82840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76488FE73
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1CA1C28717
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230227E588;
	Thu, 28 Mar 2024 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IqM4DXPx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED85474B
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627146; cv=none; b=lVpvViJBqidrKbd6PwXS8EVJNwmZ76a7Rb+NoTdypYT6KgIUkLKQGvdDZmWhEwaJsfLtYGgxzo0cnkF+oqouF6PhFUroh7ThI7byYgl2o4l0YTWMnHlMDm9UUPmrERueuwHxByS1DAxyX5XW4Kar6RFSUMUZihlycN5F+JVNebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627146; c=relaxed/simple;
	bh=ddX5onw4cCopIj/detwClWh2ePa/16RsF6h/9WQDnoA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7o77DSXzcYBLM2DdI3wyHVUT+nyGvLp4Z8T1TN0abBL1l0ST1XYljvYdBprC4NoTQvxA29XTEYbP89UcXHEcW3Y5uErTmmsCC3qtrQFhni7DqUbO8oI31hmYOJfltAJ7m9gSkxfWeJeHcyt7ggH1EFhDTfv/nDXiGY4qEW54Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IqM4DXPx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SA18SA031467;
	Thu, 28 Mar 2024 04:58:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=SPuGj3Vj+m2uM6xXcCE9R9
	zOgGLHs1Bzpe+FV3SbOFg=; b=IqM4DXPxtLZQN1jZln1FF7CYhVFL6qQN4hPswk
	hUcSsf67CBDYtxq9i2iiB4dN17c6b1T5aHrFV8l2JLNL53+nugW8Gsk+TnbeKsht
	5Fd0F8GS0p94sI/aQCnz+vxV4o7oA0ccQD8LQjPU41G0SNyAKcB0vBG2lFS/iHI+
	1xCZ+CUsKcYO2Xz+LjmY57tcoZqiw700SReUDELpGdOWnfssQC+MJ0v+XjKv6sLz
	1KmfRxHcih1Athn95ZWKejwYvzxHDAPhly/Rfbx5qHhxeW6vABBimjVdc6hB20gC
	1fULPjJBvnuxLImTnkWvZdpwIv1zthedtaSdawgwsy4lTxAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x4jd1q1v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 04:58:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 28 Mar 2024 04:58:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 28 Mar 2024 04:58:55 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DE10F3F708A;
	Thu, 28 Mar 2024 04:58:52 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:28:51 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Denis Kirjanov <kirjanov@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, Denis Kirjanov <dkirjanov@suse.de>,
        <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 net] RDMA/core: fix UAF in ib_get_eth_speed
Message-ID: <20240328115851.GA1560813@maili.marvell.com>
References: <20240328113233.21388-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240328113233.21388-1-dkirjanov@suse.de>
X-Proofpoint-GUID: 2yMoDeJ3jI-C9VvUEjRV7TW3qcD-g0HX
X-Proofpoint-ORIG-GUID: 2yMoDeJ3jI-C9VvUEjRV7TW3qcD-g0HX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_11,2024-03-27_01,2023-05-22_02

On 2024-03-28 at 17:02:33, Denis Kirjanov (kirjanov@gmail.com) wrote:
> A call to ib_device_get_netdev from ib_get_eth_speed
> may lead to a race condition while accessing a netdevice
> instance since we don't hold the rtnl lock while checking
> the registration state:
> 	if (res && res->reg_state != NETREG_REGISTERED) {
>
> v2: unlock rtnl on error patch
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/verbs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..9c09d8c328b4 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
>  	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
>  		return -EINVAL;
>
> +	rtnl_lock();
>  	netdev = ib_device_get_netdev(dev, port_num);
ib_device_get_netdev() hold ref to dev before checking reg_state, isn't it enough ?

> -	if (!netdev)
> +	if (!netdev) {
> +		rtnl_unlock()
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

