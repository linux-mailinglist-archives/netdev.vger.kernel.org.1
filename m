Return-Path: <netdev+bounces-155503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EFA0286F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378E43A4B2A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCA1DF723;
	Mon,  6 Jan 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDUQKZNz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977CF1DF736
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174731; cv=none; b=ALTB2TxhuhxqRY6r46oO7OJ+PmmJU4ER+yh2YrBvOM35iIoy4KAmKOlkf8sFPGbTea9l6Tr8sApVWIqNFjFIx7TordKGt8r4IGlKTrpaIQwqeTXl8jgRwm4ALBc5ZwhvUyD1Va8rP4XJT8s+RF/SCgYtRflecoNgIH9LVEynas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174731; c=relaxed/simple;
	bh=zVDWJzSnctihyM0o8lol5bnO1vGY5u2mEoevwhbrBUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY0jBPQGW6RooK8bif8v3R9/3n91TxRCPp965WOEnGhPy8x72jTOd/t2z26K08NGgTBr6bWl5oB4s/QHZcy92FZ1lEKnkU+Y+34bH25nPocNUS3NFa3uGD4Iv30XEcugWhZCCC7aEYn2SS2GwUD/V4Ciwwohr1kWRDmsZGJLwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDUQKZNz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863703258fso9017649f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 06:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736174726; x=1736779526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOH3jiFhSJqOAZX1YAJhl0eFuAamNnU7YXi10iDB3vk=;
        b=FDUQKZNzsmERw6su7jgjfpBnPv1FZlw4Qv1jcGaFhWUi/0qslQrgst3nvHxitZ26p/
         rrkpmi0PaiRhhhSOCaT0q5gEOyU0odpsnYoRkXneY8GMfuAl6YnNp/wr8KfiuJ16uN4E
         00PR0U57dN0961DGgIGeNLPtrfDAj1Am0dG1SV0q/boaHtR4mtysz/IyO2ieWb/G+CEs
         zM5VWItqSSqZRtGvyAJN9+fVm/cOCrEa/gbjtGmV8MVsUn5ab4KyHARE3S49+JSSBok/
         /2hocyhNGuNJQot/+2pu/TraCgBCYFD5181Drx1HUiyAsemUjGyGhhUb1KTxM9OK7CFS
         HUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174726; x=1736779526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOH3jiFhSJqOAZX1YAJhl0eFuAamNnU7YXi10iDB3vk=;
        b=nkhDAvitiIkSEAfwhpQEb5Ma81auAkbOwgI3js5iKDMl6jI5+VDHtTRWzzJaumYowz
         CL2SCSwocxZcZ5aWqTHL8os2prlwoZ0c4oXaDT+xWDNVaZLpSC9piogSdRgbbO5rPLax
         F9kW/3iTdOkkIcsQv3Skr1PeoAKve8uB2GBntE54+AKz9q5+wFs02ybVv3+xd/Yr7i3u
         mfFHWDgKfjf7Et4NJiOXI21SdWbUAkDBw2t2hSUpQLxrRaxiJ3ppXQyB/ZKoAzvF3tFq
         p/QsZJmb1zfPsV6RMOn8xVqH/CND0ERi2kgO+iQKsdX2LNhRXph/RgaH6KRsZynz++w7
         UEZg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ImBzVMciSUk04UqydzeXk1IICgVfo2bQY8GaygcoaKlOJKtCrLajAZkJZ1g9ETCEHtBL75Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgLgp31moL6AOl2BNoxkRRa0vCcOTbhFMClj94pYd0FowMzFJ
	c6ZCZBxyl4VQIF2pzlmQE4ro+mVMBkzWy/FUTC0RRyVO48vqxGLN
X-Gm-Gg: ASbGncszvsAps0RYKORV58h9W50ssPKc5Ar8cyKEXiked2P9F4baiEk5BgZ+UC+3ICW
	h4pzQbm7/AKWIsi2hZkSP7zvtVY5G+nc7Eq8UJNvWUuk03yyCoPwNeYOZITegiszIRTo6mIgJwp
	H5ZuNKLX15eQ8DPfy3gzNqGfmHe1f2Z7EYpD2g8wNNsz0QhTMMd4dQqe2PxpuXh9suaNvIsselZ
	BIZ/f+Hp2NAa7I1+AekuddRAMZ82g67EDQjIugikVPkMbCMiAW74FNqSU9vmPB1EKO7xGua8Xb7
X-Google-Smtp-Source: AGHT+IFLbg4LaKsPyLyNd9RdEfvWjBcYrcC9SEh9XM9mku7DuUK704CRJULOsLoT7PGKZCjmskzUEA==
X-Received: by 2002:a5d:5f91:0:b0:386:37f8:450b with SMTP id ffacd0b85a97d-38a1a1f6f4emr52117122f8f.5.1736174725586;
        Mon, 06 Jan 2025 06:45:25 -0800 (PST)
Received: from [172.27.48.82] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea47asm569856565e9.4.2025.01.06.06.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:45:25 -0800 (PST)
Message-ID: <837e39b7-0e95-4f6d-b2cb-8dbefa9eb696@gmail.com>
Date: Mon, 6 Jan 2025 16:45:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>
References: <20241217195738.743391-1-vadfed@meta.com>
 <D6IAG0OM4BCI.1SCL62SCI2UAY@nvidia.com>
 <6c9730b3-b35d-47d9-9cd6-ec2e05e4e8e5@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <6c9730b3-b35d-47d9-9cd6-ec2e05e4e8e5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/01/2025 0:25, Vadim Fedorenko wrote:
> On 22/12/2024 14:10, Dragos Tatulea wrote:
>> On Tue Dec 17, 2024 at 8:57 PM CET, Vadim Fedorenko wrote:
>>> The overflow_work is using system wq to do overflow checks and updates
>>> for PHC device timecounter, which might be overhelmed by other tasks.
>>> But there is dedicated kthread in PTP subsystem designed for such
>>> things. This patch changes the work queue to proper align with PTP
>>> subsystem and to avoid overloading system work queue.
>>> The adjfine() function acts the same way as overflow check worker,
>>> we can postpone ptp aux worker till the next overflow period after
>>> adjfine() was called.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 25 +++++++++++--------
>>>   include/linux/mlx5/driver.h                   |  1 -
>>>   2 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/ 
>>> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> index 4822d01123b4..ff3780331273 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> @@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
>>>       }
>>>   }
>>> -static void mlx5_timestamp_overflow(struct work_struct *work)
>>> +static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
>>>   {
>>> -    struct delayed_work *dwork = to_delayed_work(work);
>>>       struct mlx5_core_dev *mdev;
>>>       struct mlx5_timer *timer;
>>>       struct mlx5_clock *clock;
>>>       unsigned long flags;
>>> -    timer = container_of(dwork, struct mlx5_timer, overflow_work);
>>> -    clock = container_of(timer, struct mlx5_clock, timer);
>>> +    clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
>>>       mdev = container_of(clock, struct mlx5_core_dev, clock);
>>> +    timer = &clock->timer;
>>>       if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
>>>           goto out;
>>> @@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct 
>>> work_struct *work)
>>>       write_sequnlock_irqrestore(&clock->lock, flags);
>>>   out:
>>> -    schedule_delayed_work(&timer->overflow_work, timer- 
>>> >overflow_period);
>>> +    return timer->overflow_period;
>>>   }
>>>   static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
>>> @@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info 
>>> *ptp, long scaled_ppm)
>>>       timer->cycles.mult = mult;
>>>       mlx5_update_clock_info_page(mdev);
>>>       write_sequnlock_irqrestore(&clock->lock, flags);
>>> +    ptp_schedule_worker(clock->ptp, timer->overflow_period);
>>>       return 0;
>>>   }
>>> @@ -852,6 +852,7 @@ static const struct ptp_clock_info 
>>> mlx5_ptp_clock_info = {
>>>       .settime64    = mlx5_ptp_settime,
>>>       .enable        = NULL,
>>>       .verify        = NULL,
>>> +    .do_aux_work    = mlx5_timestamp_overflow,
>>>   };
>>>   static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 
>>> pin,
>>> @@ -1052,12 +1053,12 @@ static void mlx5_init_overflow_period(struct 
>>> mlx5_clock *clock)
>>>       do_div(ns, NSEC_PER_SEC / HZ);
>>>       timer->overflow_period = ns;
>>> -    INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
>>> -    if (timer->overflow_period)
>>> -        schedule_delayed_work(&timer->overflow_work, 0);
>>> -    else
>>> +    if (!timer->overflow_period) {
>>> +        timer->overflow_period = HZ;
>>>           mlx5_core_warn(mdev,
>>> -                   "invalid overflow period, overflow_work is not 
>>> scheduled\n");
>>> +                   "invalid overflow period,"
>>> +                   "overflow_work is scheduled once per second\n");
>>> +    }
>>>       if (clock_info)
>>>           clock_info->overflow_period = timer->overflow_period;
>>> @@ -1172,6 +1173,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
>>>       MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
>>>       mlx5_eq_notifier_register(mdev, &clock->pps_nb);
>>> +
>>> +    if (clock->ptp)
>>> +        ptp_schedule_worker(clock->ptp, 0);
>>>   }
>>>   void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>>> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev 
>>> *mdev)
>>>       }
>>>       cancel_work_sync(&clock->pps_info.out_work);
>>> -    cancel_delayed_work_sync(&clock->timer.overflow_work);
>>>       if (mdev->clock_info) {
>>>           free_page((unsigned long)mdev->clock_info);
>>> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>>> index fc7e6153b73d..3ac2fc1b52cf 100644
>>> --- a/include/linux/mlx5/driver.h
>>> +++ b/include/linux/mlx5/driver.h
>>> @@ -690,7 +690,6 @@ struct mlx5_timer {
>>>       struct timecounter         tc;
>>>       u32                        nominal_c_mult;
>>>       unsigned long              overflow_period;
>>> -    struct delayed_work        overflow_work;
>>>   };
>>>   struct mlx5_clock {
>>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>
> 
> Hi Saeed, Tariq, Leon!
> 
> We need explicit Ack-by from official mlx5 maintainer here to let this
> patch go directly to net-next. Could you please check it?
> 
> Thanks,
> Vadim
> 
> 

Hi,

Back after a long vacation.
I'll reply shortly.

Regards,
Tariq

