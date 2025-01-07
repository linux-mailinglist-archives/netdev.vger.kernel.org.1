Return-Path: <netdev+bounces-155734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF507A037D5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA21885736
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31900155335;
	Tue,  7 Jan 2025 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqTkbltr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDA6A009
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230908; cv=none; b=EPDcFRXrkZAKPrKA6B0SP75P0kA7bMambAXenQBV5D+bQkeUbHjB+nJg4O0DREwdAtkOEItLHN0A+G6p0v5svw8Vsb8oEsQpwcdsfybig0G+da5s9HCmZOTNO4FSUp99Ez6Ti9co+atDmHWXZ84Nc/dmsMMzjhNxHI3zIGsjCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230908; c=relaxed/simple;
	bh=JFGZOy88RseiDXjRAAkqALg03k9Nl17D98QJIrDvUjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPeqQd8rZq6tEUJxNHpKPPDGFzSsI1PN73d4mTB5OHXxW/X3khbkFJVGyf1jl/+3+YIgPU2DKvwBcpYPlU66O77P9yKTMe7VOQqG/fSm/WY7SK+yM8sdGx7zeA4RS1rrXws48jnB34ZWjRvzgmxGytW9PzglvzXQnQM5sjran2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqTkbltr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso153594185e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 22:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736230903; x=1736835703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgYQbPKn9h8WNe1+gQZlOS+PsjSxSO0q8ziq0/pmZNg=;
        b=YqTkbltrI2kJdeDQ41B6ts2Q16rtS9o3xGpUwmId0SYF9O8piNs5jCiv4v2q7N8xmS
         ld2EQl32WDEO5WIlr7h/mfeMdJBp2fuf4waXIKG4aGs3/R63Xlp3E0WicFoq3kW3SsH5
         F5fRstrEyp3iauJh4FpL076jk1/5UE0SYv72xfEwq+z/V3FR+VHTPd46pAWgJ/ArEnEU
         5xou2m3Gl2puh0Pwu4qjhq14mkRhzs22ION68CJbHucStCFESO3PunpH15ZfTcsDUgEZ
         zUKmcZ/iSAMwrInvGyUdtASENAawpiw8NrE2X++rabPxASZ5lupAh5FDNAFnJWinPN5R
         2zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736230903; x=1736835703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgYQbPKn9h8WNe1+gQZlOS+PsjSxSO0q8ziq0/pmZNg=;
        b=l/eUMbgEyZX+3LjjeGXQU89NbQ+SQNBajLQ1As7rwCgQMtobBz5VNVm+2QnZOpiVli
         KmqYMOLDykFqPqisDx3yrJymvo7ilwx10DSM/LaTnI4VBFTL3fFtVJg2q14GWTCeV2Fu
         LirbwVntxkI0Niu/h8eSx/3JglHWBC8byqKnLdsCG5Nit7jKwm3Feo45mlWyuNRLoX1v
         61ZylinAABgkgzwmHDFkdJPptWFyl76mje3m191HkURvfGiDT4XclK/5rD4JXAIF//Oz
         1r1XdaHKAoWkLEYssGz5e6TeSyoDo5Ni3a4Ck3YIgpC+k5OoG/L7SBX9dhX+aQJV14Th
         jhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4VoJxeQpr08ILt5nSsYaPItKpiKrJxgFNNIZV+lfMeyTJdZQ4OB6R8D7ozx+yZtbFmBG8GKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIu+n01AjwqXRE6XhlbCB8J+xqvX+YLnBerSe0YY8i42XmrAnV
	9NdHdXn/EetPLF81dNiFZpXjlGMljSk4ziI8awENFIxof1+GHGq/
X-Gm-Gg: ASbGncuGGpSCc7pJjokflJ9hYsVZGMHO4UOWKPmGAslPoVB1yd1Wjn8ZiA4lXNSh/47
	1YWZgx7i5V5zJpRpNne7A7XLYN7MdcsgbbM08SvPELrdqe6NFWuxTHQk5sp/n7D5w82A4+lvGrx
	Z18EeTK7s9zcIQr6lirsNxVLVUQR/hycbQPsKyi2wo7y2BNK0ihZohmNRqF2XoUx/ZJTE2HM7qE
	okokmW+i6P2X/GWHX7x2ErigQlHXD7yN5rShQaXx8JysIYX58HLNttKuGVb50d1F7Xu/GeEWKek
X-Google-Smtp-Source: AGHT+IHYdAcY5GeMFA8HkQlTiarqkTo88lQlrPIPGkrPbzr6Re57u2SJcIG3lE0TZqRkyHHJ6AJfkQ==
X-Received: by 2002:a05:600c:3110:b0:434:ffb2:f9df with SMTP id 5b1f17b1804b1-43668646bb5mr550008785e9.17.1736230902676;
        Mon, 06 Jan 2025 22:21:42 -0800 (PST)
Received: from [172.27.48.82] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a636asm50859208f8f.88.2025.01.06.22.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 22:21:42 -0800 (PST)
Message-ID: <113b74ba-5d1e-471a-8783-376fb75b13e2@gmail.com>
Date: Tue, 7 Jan 2025 08:21:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
To: Vadim Fedorenko <vadfed@meta.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Bar Shapira <bshapira@nvidia.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>
References: <20241217195738.743391-1-vadfed@meta.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20241217195738.743391-1-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/12/2024 21:57, Vadim Fedorenko wrote:
> The overflow_work is using system wq to do overflow checks and updates
> for PHC device timecounter, which might be overhelmed by other tasks.
> But there is dedicated kthread in PTP subsystem designed for such
> things. This patch changes the work queue to proper align with PTP
> subsystem and to avoid overloading system work queue.
> The adjfine() function acts the same way as overflow check worker,
> we can postpone ptp aux worker till the next overflow period after
> adjfine() was called.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 25 +++++++++++--------
>   include/linux/mlx5/driver.h                   |  1 -
>   2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index 4822d01123b4..ff3780331273 100644
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
> @@ -1052,12 +1053,12 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
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
> +			       "invalid overflow period,"
> +			       "overflow_work is scheduled once per second\n");

Same-line strings are preferable (unless they're really 
ugly/non-readable..).
They ease find/grep operations.

> +	}
>   
>   	if (clock_info)
>   		clock_info->overflow_period = timer->overflow_period;
> @@ -1172,6 +1173,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
>   
>   	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
>   	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
> +
> +	if (clock->ptp)
> +		ptp_schedule_worker(clock->ptp, 0);
>   }
>   
>   void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>   	}
>   
>   	cancel_work_sync(&clock->pps_info.out_work);
> -	cancel_delayed_work_sync(&clock->timer.overflow_work);
>   
>   	if (mdev->clock_info) {
>   		free_page((unsigned long)mdev->clock_info);
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index fc7e6153b73d..3ac2fc1b52cf 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -690,7 +690,6 @@ struct mlx5_timer {
>   	struct timecounter         tc;
>   	u32                        nominal_c_mult;
>   	unsigned long              overflow_period;
> -	struct delayed_work        overflow_work;
>   };
>   
>   struct mlx5_clock {


