Return-Path: <netdev+bounces-25505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E84774661
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6298028175A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58063154A3;
	Tue,  8 Aug 2023 18:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72C15494
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D04C433C8;
	Tue,  8 Aug 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691520930;
	bh=R5Fhz0qGwQOWhsrhVGmrP+MpvVx3YvZ5RnnE5y8itYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrPxPnSJ8FhjfTtvt4i6zc4G7BFK8yYVK78FiTtMyo+3Y8AN7n3QoscAGfH5vvq1D
	 63VGMnXkZbK5ohAA/keDcPBYAZizWj3RE7966xb69rLMjtDvGYn4Sjzau5q7uEh6hh
	 8KGsKS0zlgtriyi8wCxP2/ui4F40JDwUGjXH+ctVohzNR+F3wxZQ1HqfUp4gvswg89
	 muZUQVwK749RzBnSI0KJQjgCHXQ/L6rlNsWKBC9aK1rulcCHWqO3aHEpoazlfcCSlq
	 lIcYgTMHOqGJ1dMU1EnGGzCRr/WB1HJ4dSnm3c686oLJEVdrXEg4vlGHYvizBVOAz/
	 oc5YkikwYKTjw==
Date: Tue, 8 Aug 2023 21:55:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/10] mlx4: Get rid of the
 mlx4_interface.get_dev callback
Message-ID: <20230808185517.GG94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-2-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:18PM +0200, Petr Pavlu wrote:
> Simplify the mlx4 driver interface by removing mlx4_get_protocol_dev()
> and the associated mlx4_interface.get_dev callbacks. This is done in
> preparation to use an auxiliary bus to model the mlx4 driver structure.
> 
> The change is motivated by the following situation:
> * The mlx4_en interface is being initialized by mlx4_en_add() and
>   mlx4_en_activate().
> * The latter activate function calls mlx4_en_init_netdev() ->
>   register_netdev() to register a new net_device.
> * A netdev event NETDEV_REGISTER is raised for the device.
> * The netdev notififier mlx4_ib_netdev_event() is called and it invokes
>   mlx4_ib_scan_netdevs() -> mlx4_get_protocol_dev() ->
>   mlx4_en_get_netdev() [via mlx4_interface.get_dev].
> 
> This chain creates a problem when mlx4_en gets switched to be an
> auxiliary driver. It contains two device calls which would both need to
> take a respective device lock.
> 
> Avoid this situation by updating mlx4_ib_scan_netdevs() to no longer
> call mlx4_get_protocol_dev() but instead to utilize the information
> passed in net_device.parent and net_device.dev_port. This data is
> sufficient to determine that an updated port is one that the mlx4_ib
> driver should take care of and to keep mlx4_ib_dev.iboe.netdevs up to
> date.
> 
> Following that, update mlx4_ib_get_netdev() to also not call
> mlx4_get_protocol_dev() and instead scan all current netdevs to find
> find a matching one. Note that mlx4_ib_get_netdev() is called early from
> ib_register_device() and cannot use data tracked in
> mlx4_ib_dev.iboe.netdevs which is not at that point yet set.
> 
> Finally, remove function mlx4_get_protocol_dev() and the
> mlx4_interface.get_dev callbacks (only mlx4_en_get_netdev()) as they
> became unused.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 89 ++++++++++----------
>  drivers/net/ethernet/mellanox/mlx4/en_main.c |  8 --
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 21 -----
>  include/linux/mlx4/driver.h                  |  3 -
>  4 files changed, 43 insertions(+), 78 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

