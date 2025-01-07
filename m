Return-Path: <netdev+bounces-156004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC05A049AA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D680018803C7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05B1F3D2B;
	Tue,  7 Jan 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbKF4qhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F218C937
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276044; cv=none; b=LFKel7IDQ7dPI6J0V2Xy2d2r/FCsb+ZCVR+tqZJ+ROZ3SxhBjra9v0bhUx+oNtxt2FoaFmp+jfRAkyym48359SJindiOauKqNIhggH3W5crO3D3rBKHhiDctQLxNOmPvZGWYsGIVgIQLYux3pqXGIGZ9Umcg5soeBGBJ8kzN8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276044; c=relaxed/simple;
	bh=cE9ZVQDyhnsdh8xK6MyKX9UOet4ZzOzNQl1mZ8M0Nmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FB6LUWRzNR57siK/nkpq+5JaVgPvBPVojzCDnGZbXTySdaikofRrKmqQx3yCUAcpwmtMbySo3oa4ZVN8YNAOuZ7qk3qL/19gTJyektazzgpLD07nyeIAhJTUPni8ehdEwKBSRlKD/dX1AOHuJVexqVNiGpBaPTQEomJvj+Du3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbKF4qhL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f796586so163862135e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736276039; x=1736880839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZVlHIaT403QMKjGQWfwbQFVFdKfQJj3aWrYqLZeIf0=;
        b=QbKF4qhLoggS3RIIgBurEocEg3SrzI/n+PdfBCMHpFysXR/7ExHcaOwAqzbdQ+Kqqv
         cvFJ3zPGqiu1v9U1Er2DQp/DQ/5T7u84b6vpVSruyIyecX2P/TvveHYz1la9yWnLq5xK
         LwzRNoIT2bP9hpG+exjX7ES0+dkEUlTZ0KoPCo6ZpCXZ/uVcWddWZ36ItkN74dWUSpso
         f20prkwX+p8VQXW4naA6nfhe+/zcXxg7Jf2anFKiE4fR7gluJch9YbF8U1uoXSaCQZfN
         ewdAHbBN+8r8Y4xwwCpUU/+qZlkLA43SjXYHepDlgm25vgJf8IyIxk+6cYI4jcoDjqSR
         4xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736276039; x=1736880839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZVlHIaT403QMKjGQWfwbQFVFdKfQJj3aWrYqLZeIf0=;
        b=s/HO5qX6NvW5Ll41pCNHWBVYR3ofWiA5xFOxGO1KP6aUjzyRIBItOe0BmVOJJIRbTx
         bOXqUiQErVlR5pkB/QqaaCYmceG0iCMseEbsFLdtbWUmslgAEYJmaN5RpdCps+q39k8Q
         3UzBo1SZqkyjzcfkPyFQODha2+KxC5zTUh3rffug47VzPx8fybS1m+05M7XZWrWpdxTO
         V0vSoUaeeDXvKAFi8JYDsDtprG8odZtwYvr9nFpchWy/Y2WhStwP/1Es6ugJjbNK2bSe
         TWeBoakAgat9wUPWJBKdF0rfw1+92OUqkO3X6CsXj1FgxcM40bA9rIVMDBcovBI/v+YR
         a0fA==
X-Forwarded-Encrypted: i=1; AJvYcCXu2ew/hK7AsLxroEOw4KegH93TSeWtcCLR4+GVQiodaKZpUkEWkbVkRhHz4dF9aVc0QtgKiK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8dgJScX2LUEX5FYROcTzaQWGMZZNK+bXq1Sppfiwa6oLgQGC
	swX+/tp2RcqSsnFldRy9Mzfor//ci0qAQreVUS4OSD3Y58puipdY
X-Gm-Gg: ASbGnct1RdXDsOxxsfenmxPa4wuN48qvIMWZEy4Tl653cPII5j/lzGOhIpiu+XalVwT
	Aj+ePtgsF6Tc1/5a1iVJpXxMFuUASJa4MubsYlJ9+WxMZpL0sMOPzaquTrBFqSSYegbfNRlE+4V
	QQIq3gZ6wJRI8A+CsFgA0HnrmubjlbYzT94yXNDyFqRDe+9F0oo9cDDECr18lXYGamNKt9mLgF0
	m9ux+6+0pqV0FTy+tZ8ZnWVj5v9Pn00mvZbp9AZ85ts7OGUehVepI1BY18XBoftMWHbmckhfwru
X-Google-Smtp-Source: AGHT+IFDiCZx4RdB14J2crLz9i17HFc5mBQrAN4sn344YQGtgcp+AyJM+WfqaHZd65wNvqgVu5N05g==
X-Received: by 2002:a05:600c:1c95:b0:434:a1d3:a321 with SMTP id 5b1f17b1804b1-4366835c1b0mr586510145e9.3.1736276038876;
        Tue, 07 Jan 2025 10:53:58 -0800 (PST)
Received: from [172.27.48.82] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365d116d8fsm613500155e9.17.2025.01.07.10.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 10:53:58 -0800 (PST)
Message-ID: <81614c72-6320-4159-9032-d822dc9f0599@gmail.com>
Date: Tue, 7 Jan 2025 20:53:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/mlx5: use do_aux_work for PHC overflow
 checks
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>
References: <20250107104812.380225-1-vadfed@meta.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250107104812.380225-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2025 12:48, Vadim Fedorenko wrote:
> The overflow_work is using system wq to do overflow checks and updates
> for PHC device timecounter, which might be overhelmed by other tasks.
> But there is dedicated kthread in PTP subsystem designed for such
> things. This patch changes the work queue to proper align with PTP
> subsystem and to avoid overloading system work queue.
> The adjfine() function acts the same way as overflow check worker,
> we can postpone ptp aux worker till the next overflow period after
> adjfine() was called.
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2
> * make warning string in one line
> ---
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 24 ++++++++++---------
>   include/linux/mlx5/driver.h                   |  1 -
>   2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 4822d01123b4..d61a1a9297c9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
>   	}
>   }
>   
> -static void mlx5_timestamp_overflow(struct work_struct *work)
> +static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
>   {
> -	struct delayed_work *dwork = to_delayed_work(work);
>   	struct mlx5_core_dev *mdev;
>   	struct mlx5_timer *timer;
>   	struct mlx5_clock *clock;
>   	unsigned long flags;
>   
> -	timer = container_of(dwork, struct mlx5_timer, overflow_work);
> -	clock = container_of(timer, struct mlx5_clock, timer);
> +	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
>   	mdev = container_of(clock, struct mlx5_core_dev, clock);
> +	timer = &clock->timer;
>   
>   	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
>   		goto out;
> @@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
>   	write_sequnlock_irqrestore(&clock->lock, flags);
>   
>   out:
> -	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
> +	return timer->overflow_period;
>   }
>   
>   static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
> @@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>   	timer->cycles.mult = mult;
>   	mlx5_update_clock_info_page(mdev);
>   	write_sequnlock_irqrestore(&clock->lock, flags);
> +	ptp_schedule_worker(clock->ptp, timer->overflow_period);
>   
>   	return 0;
>   }
> @@ -852,6 +852,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
>   	.settime64	= mlx5_ptp_settime,
>   	.enable		= NULL,
>   	.verify		= NULL,
> +	.do_aux_work	= mlx5_timestamp_overflow,
>   };
>   
>   static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
> @@ -1052,12 +1053,11 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
>   	do_div(ns, NSEC_PER_SEC / HZ);
>   	timer->overflow_period = ns;
>   
> -	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
> -	if (timer->overflow_period)
> -		schedule_delayed_work(&timer->overflow_work, 0);
> -	else
> +	if (!timer->overflow_period) {
> +		timer->overflow_period = HZ;
>   		mlx5_core_warn(mdev,
> -			       "invalid overflow period, overflow_work is not scheduled\n");
> +			       "invalid overflow period, overflow_work is scheduled once per second\n");
> +	}
>   
>   	if (clock_info)
>   		clock_info->overflow_period = timer->overflow_period;
> @@ -1172,6 +1172,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
>   
>   	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
>   	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
> +
> +	if (clock->ptp)
> +		ptp_schedule_worker(clock->ptp, 0);
>   }
>   
>   void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
> @@ -1188,7 +1191,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>   	}
>   
>   	cancel_work_sync(&clock->pps_info.out_work);
> -	cancel_delayed_work_sync(&clock->timer.overflow_work);
>   
>   	if (mdev->clock_info) {
>   		free_page((unsigned long)mdev->clock_info);
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index ea48eb879a0f..fed666c5bd16 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -691,7 +691,6 @@ struct mlx5_timer {
>   	struct timecounter         tc;
>   	u32                        nominal_c_mult;
>   	unsigned long              overflow_period;
> -	struct delayed_work        overflow_work;
>   };
>   
>   struct mlx5_clock {

Thanks for your patch.

Acked-by: Tariq Toukan <tariqt@nvidia.com>


