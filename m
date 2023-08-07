Return-Path: <netdev+bounces-24984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CC7726DA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B60B2812FC
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78D107BE;
	Mon,  7 Aug 2023 13:58:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1A443A
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 13:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353EDC433CC;
	Mon,  7 Aug 2023 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691416718;
	bh=ldo/PfwX1/YEJAZBSBXdjfdco2obKz6ExqpCyGI1fKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwcjSfUcWBuI5yDy5LmbY+EIciLl56lQYS52ul5UgTv4C5Jptkmhiz9Ig2IYczl9R
	 8BfGC6kitScsZ2gEfKbYTA8vruAwZFdqjbu1xwmCjXeZIulzGrwpdLDHL3blOy0N1l
	 pyg2zgG0Rdoqf1QOnN0yFAa/IQHN3in4uMv+ixNxiN8D8D9MdBSbaQQt/5xL5nhCls
	 S1JHGCdb8mYAjRXz2gkuwCdvyxxTF+Ke+lAvt3tL8zVxl7tk5xtsApFXOsrOtlf5dG
	 kVNiZOzJ82XQ4ipLR1qAkIwhiIsmF20z+gaNK7707B/FMghpau8Os+uxeqW1bmPMjj
	 2dKSRAQjVMr/A==
Date: Mon, 7 Aug 2023 15:58:33 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Message-ID: <ZND4iQMbv5LWNaZA@vergenet.net>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-4-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-4-petr.pavlu@suse.com>

On Fri, Aug 04, 2023 at 05:05:20PM +0200, Petr Pavlu wrote:

...

> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c

...

> @@ -326,6 +333,11 @@ static void *mlx4_en_add(struct mlx4_dev *dev)
>  	mutex_init(&mdev->state_lock);
>  	mdev->device_up = true;
>  
> +	/* register mlx4 core notifier */
> +	mdev->mlx_nb.notifier_call = mlx4_en_event;
> +	err = mlx4_register_event_notifier(dev, &mdev->mlx_nb);

Hi Petr.

This fails to build because err isn't declared in this context.

> +	WARN(err, "failed to register mlx4 event notifier (%d)", err);
> +
>  	return mdev;
>  
>  err_mr:

...

