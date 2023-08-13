Return-Path: <netdev+bounces-27180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1FB77AA27
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018CE280992
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D38F65;
	Sun, 13 Aug 2023 16:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F052564
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D98C433C7;
	Sun, 13 Aug 2023 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691945693;
	bh=GtksutdwWQqILgbjQciqv0DjEEChnt/FUIitCik4EPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIS4xTwAgXo5b81Dl6AwKthfy2l0m5YuPIKPlz8PCPllJlzRN6Gg82bPPj4LGh4C0
	 7fLT4fTpofWZhMcrm+RGVvj6XywjdSxVoWFhDfRlIGmm1RgXDAuoA/vBXN7WHbTx+F
	 mgH1JysUt9TjCtbQtVtjS3gxqrCD6HPBBBPuK+MX1J8BFZdUdTdiCWOOUN1x9ga9Be
	 e68bU2Lg/ni/cL8onPeUbvD/HB6+4UNbcmRtIsElEeo4Q/Bb02bgOSiAvPMw/OGKfe
	 JLcfOFMk+WsNM/GIdCzl4MGZx23odhN9aRxhHMZ/n2kXcP3IlGh6cea0lu93hZb7HN
	 SfWVOzrWRTUMQ==
Date: Sun, 13 Aug 2023 19:54:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Message-ID: <20230813165449.GL7707@unreal>
References: <20230813145127.10653-1-petr.pavlu@suse.com>
 <20230813145127.10653-4-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813145127.10653-4-petr.pavlu@suse.com>

On Sun, Aug 13, 2023 at 04:51:20PM +0200, Petr Pavlu wrote:
> Use a notifier to implement mlx4_dispatch_event() in preparation to
> switch mlx4_en and mlx4_ib to be an auxiliary device.
> 
> A problem is that if the mlx4_interface.event callback was replaced with
> something as mlx4_adrv.event then the implementation of
> mlx4_dispatch_event() would need to acquire a lock on a given device
> before executing this callback. That is necessary because otherwise
> there is no guarantee that the associated driver cannot get unbound when
> the callback is running. However, taking this lock is not possible
> because mlx4_dispatch_event() can be invoked from the hardirq context.
> Using an atomic notifier allows the driver to accurately record when it
> wants to receive these events and solves this problem.
> 
> A handler registration is done by both mlx4_en and mlx4_ib at the end of
> their mlx4_interface.add callback. This matches the current situation
> when mlx4_add_device() would enable events for a given device
> immediately after this callback, by adding the device on the
> mlx4_priv.list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c            | 41 +++++++++++++-------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h         |  2 +
>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 27 +++++++++----
>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 24 ++++++++----
>  drivers/net/ethernet/mellanox/mlx4/main.c    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  2 +
>  include/linux/mlx4/driver.h                  |  8 +++-
>  8 files changed, 77 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index 7dd70d778b6b..0761c465120b 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -82,6 +82,8 @@ static const char mlx4_ib_version[] =
>  static void do_slave_init(struct mlx4_ib_dev *ibdev, int slave, int do_init);
>  static enum rdma_link_layer mlx4_ib_port_link_layer(struct ib_device *device,
>  						    u32 port_num);
> +static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
> +			 void *ptr);
>  
>  static struct workqueue_struct *wq;
>  
> @@ -2836,6 +2838,12 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
>  				do_slave_init(ibdev, j, 1);
>  		}
>  	}
> +
> +	/* register mlx4 core notifier */
> +	ibdev->mlx_nb.notifier_call = mlx4_ib_event;
> +	err = mlx4_register_event_notifier(dev, &ibdev->mlx_nb);
> +	WARN(err, "failed to register mlx4 event notifier (%d)", err);
> +
>  	return ibdev;
>  
>  err_notif:
> @@ -2953,6 +2961,8 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
>  	int p;
>  	int i;
>  
> +	mlx4_unregister_event_notifier(dev, &ibdev->mlx_nb);
> +
>  	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_IB)
>  		devlink_port_type_clear(mlx4_get_devlink_port(dev, i));
>  	ibdev->ib_active = false;
> @@ -3173,11 +3183,14 @@ void mlx4_sched_ib_sl2vl_update_work(struct mlx4_ib_dev *ibdev,
>  	}
>  }
>  
> -static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
> -			  enum mlx4_dev_event event, unsigned long param)
> +static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
> +			 void *ptr)
>  {
> +	struct mlx4_ib_dev *ibdev =
> +		container_of(this, struct mlx4_ib_dev, mlx_nb);
> +	struct mlx4_dev *dev = ibdev->dev;
> +	unsigned long param = *(unsigned long *)ptr;

You don't need this assignment here as later, you will cast param again,
in your next patches:

  3227         if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
  3228                 eqe = (struct mlx4_eqe *)param;
  3229         else
  3230                 p = (int) param;

so use ptr directly:

         if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
                 eqe = param;
         else
                 p = *(int *) param;

Thanks

