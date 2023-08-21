Return-Path: <netdev+bounces-29439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E06A78340C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C316280F2E
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346E1173B;
	Mon, 21 Aug 2023 20:52:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59454C9E
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25334C433C7;
	Mon, 21 Aug 2023 20:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692651118;
	bh=ecMqphkvm4vlLe7IPHvpzub8d2SqyoBthIxSY81dEe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGVspEm+tpcI2Cf6GXSokRReQ9oB8WKZXUDTzxgSI/gCs/PH7EqSh+vxtfx+OcKMH
	 SOlvVjsT5L86sTZg/WGQYc40f9SVc1/BKEjzYrzKwYEGi75NhrvhahY+5dLmviqqHG
	 t0q5c5KxrzY/iZiqnAFitjbnsx7y3pXHGLNgTIEfra9/0oxnKuRR3w2Z/ol5DoThQu
	 CY7aM30LtI8a6klmOdzAKGdR1zir4vqlj4T0h1UqL9kuJNRNrq6eJIu4eKdbeu4KnV
	 kspNooKZf9vnbXY65SErIiMkAT01JAv/ZEbDAA7nDYtUagPjM5NLpgXh0+FupKVwQr
	 YdSGxNBhuBjYg==
Date: Mon, 21 Aug 2023 13:51:56 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, moshe@nvidia.com,
	leon@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com
Subject: Re: [PATCH net] net/mlx5: Avoid MMIO when the error is detected
Message-ID: <ZOPObNv+GcdzRplA@x130>
References: <20230807083205.18557-1-ganeshgr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230807083205.18557-1-ganeshgr@linux.ibm.com>

On 07 Aug 14:02, Ganesh Goudar wrote:
>When the drivers are notfied about the pci error, All
>the IO to the card must be stopped, Else the recovery would
>fail, Avoid memory-mapped IO until the device recovers
>from pci error.
>
>Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>index 932fbc843c69..010dee4eec14 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>@@ -221,10 +221,13 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
> 	clock = container_of(timer, struct mlx5_clock, timer);
> 	mdev = container_of(clock, struct mlx5_core_dev, clock);
>
>+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
>+		goto out;
> 	write_seqlock_irqsave(&clock->lock, flags);
> 	timecounter_read(&timer->tc);
> 	mlx5_update_clock_info_page(mdev);
> 	write_sequnlock_irqrestore(&clock->lock, flags);
>+out:
> 	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
> }
>

Another version of this fix was already submitted and accepted:

https://patchwork.kernel.org/project/netdevbpf/patch/20230807212607.50883-10-saeed@kernel.org/

>-- 
>2.40.1
>
>

