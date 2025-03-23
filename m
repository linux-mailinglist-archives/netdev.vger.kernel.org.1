Return-Path: <netdev+bounces-176976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB01A6D0CE
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 20:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EEA3B20BD
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55A113D53B;
	Sun, 23 Mar 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5UJOiTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AD136E;
	Sun, 23 Mar 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758543; cv=none; b=suOy5qTvpbkDqcWaKVYvO6Hzw7u8PbL7Jl6+tJn8vCKf9RS68eGF0OkV7nE4C+LPRIJfDma0HZLQ6jQiJe7GNdRyGCwWmPyp44ECaXWUtV5Rbouq/RAD+9XE+dMZoNipfTXsrean3oXygBUbgRA8unslmEkKfwTFIko0Y3+z5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758543; c=relaxed/simple;
	bh=2UCcZ2z+WikQItgg7mozyoqmNVXp3AQoB2U+RLyVJDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpEqTdc9ORfNxaU6QeVlgUUcyPg6+GuNe5EnnDDCXqki9CAsRQTa5VBH84FDU9GH0a73MQt1XSJT/5XkobgBVlYxPR/AIU4tBBmlt2ya4gMltuXOC/piDQp3qHcm36VIntqz3Q0d2zb+QGR7G002LLotzyBH9tgsKZOdg9VAHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5UJOiTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE1AC4CEE2;
	Sun, 23 Mar 2025 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742758543;
	bh=2UCcZ2z+WikQItgg7mozyoqmNVXp3AQoB2U+RLyVJDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5UJOiTmj+V/fsLHOFdi+zI/dqUras/Eaur29tIdHEk/gQed77Ere4QBtKF53h5pa
	 LuiFtY3Cf7KQ+MHfq1TWC6URHZtOReGILKapUDujGOiLzAfJAaaLw+f5mvlQePKjJ0
	 AaTjrKt7PaKPWLIX0mYk4i1W5MhlQHr65maen1jhpmkFcRdcNttpQX6tGRoPdatHNI
	 mNFr1iI7vyiQ9QiiSk9BSMmYHk5EPod59NAc3SxBazKYp+H/36uun6Z18UTnwMuJYf
	 g81mD9fPHnDXaNWHaqKg1t84nJ2F0lQabk9bAB1s2aecaHrWfmdggV/LuuIpye9/pw
	 sIbb5ZOqw6LTA==
Date: Sun, 23 Mar 2025 19:35:38 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	gnault@redhat.com, daniel@iogearbox.net, fw@strlen.de,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: fix NULL pointer dereference in l3mdev_l3_rcv
Message-ID: <20250323193538.GD892515@horms.kernel.org>
References: <20250321090353.1170545-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321090353.1170545-1-wangliang74@huawei.com>

On Fri, Mar 21, 2025 at 05:03:53PM +0800, Wang Liang wrote:
> When delete l3s ipvlan:
> 
>     ip link del link eth0 ipvlan1 type ipvlan mode l3s
> 
> This may cause a null pointer dereference:
> 
>     Call trace:
>      ip_rcv_finish+0x48/0xd0
>      ip_rcv+0x5c/0x100
>      __netif_receive_skb_one_core+0x64/0xb0
>      __netif_receive_skb+0x20/0x80
>      process_backlog+0xb4/0x204
>      napi_poll+0xe8/0x294
>      net_rx_action+0xd8/0x22c
>      __do_softirq+0x12c/0x354
> 
> This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
> ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
> like this:
> 
>     (CPU1)                     | (CPU2)
>     l3mdev_l3_rcv()            |
>       check dev->priv_flags:   |
>         master = skb->dev;     |
>                                |
>                                | ipvlan_l3s_unregister()
>                                |   set dev->priv_flags
>                                |   dev->l3mdev_ops = NULL;
>                                |
>       visit master->l3mdev_ops |
> 
> To avoid this by do not set dev->l3mdev_ops when unregister l3s ipvlan.
> 
> Suggested-by: David Ahern <dsahern@kernel.org>
> Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


