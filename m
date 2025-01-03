Return-Path: <netdev+bounces-155101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CECA0103A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 23:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027B03A41EE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C91C07D8;
	Fri,  3 Jan 2025 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hg8poIm0"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D21BD51B
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735943151; cv=none; b=SnFpGP5fGboJkFhl+EJ51gBx/eOtlOUBsMsS6xYAqdQo0Stkpmm3fBohy0iofejmnSKZhkxEA+6IBSMzAlMRB5YNdb46CAy38FQ627hMWlaWJRSnjaGwYK9j6jh9uuVtkOO3rjoKCV+w0ze3yhgXdyDslPGjSK+hqy3z/9lHr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735943151; c=relaxed/simple;
	bh=nTYfNGUXwYm8UtySRXGdzrXLBE6xU82oBDsk7x+HUpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNlxwB1vfjuF64ss4R9oa57b1/FEmMk0LBRLdTh5k5FX5RK+Nl5Lc8IU8b6u+BRqR33q1iE7bKz3TZRCr5ouQ+NVYCRenSPttx6tLVzALQuVKRCq+Dx9qsksYh0cNvQFYcDPHGdMnh5dfOr8/gkzwcy9nkWsXM2aLP5PLhoeHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hg8poIm0; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c9730b3-b35d-47d9-9cd6-ec2e05e4e8e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735943146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysrMqZaaTuXeA/dUUuop2a52EXcx5SGD0Nmx8mj9xM4=;
	b=Hg8poIm0FcFETGwdAOjbk8KCkQxfmctTvsDugO+xD1oNWjfeJLBGxKNH+T/qTiHOdqcH50
	JNhQCV0y/zMAkpuX2zyjuJbfRAKQZ9BfOlCgdxdWhARVNRdv27G2JELLwBGs6/Nr+7E+ZA
	xp0Qw+kzHTBZ7cpA9JgzJhU/MrTRHTc=
Date: Fri, 3 Jan 2025 22:25:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx5: use do_aux_work for PHC overflow
 checks
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Carolina Jubran <cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Gal Pressman <gal@nvidia.com>
References: <20241217195738.743391-1-vadfed@meta.com>
 <D6IAG0OM4BCI.1SCL62SCI2UAY@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <D6IAG0OM4BCI.1SCL62SCI2UAY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/12/2024 14:10, Dragos Tatulea wrote:
> On Tue Dec 17, 2024 at 8:57 PM CET, Vadim Fedorenko wrote:
>> The overflow_work is using system wq to do overflow checks and updates
>> for PHC device timecounter, which might be overhelmed by other tasks.
>> But there is dedicated kthread in PTP subsystem designed for such
>> things. This patch changes the work queue to proper align with PTP
>> subsystem and to avoid overloading system work queue.
>> The adjfine() function acts the same way as overflow check worker,
>> we can postpone ptp aux worker till the next overflow period after
>> adjfine() was called.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 25 +++++++++++--------
>>   include/linux/mlx5/driver.h                   |  1 -
>>   2 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index 4822d01123b4..ff3780331273 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -322,17 +322,16 @@ static void mlx5_pps_out(struct work_struct *work)
>>   	}
>>   }
>>   
>> -static void mlx5_timestamp_overflow(struct work_struct *work)
>> +static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
>>   {
>> -	struct delayed_work *dwork = to_delayed_work(work);
>>   	struct mlx5_core_dev *mdev;
>>   	struct mlx5_timer *timer;
>>   	struct mlx5_clock *clock;
>>   	unsigned long flags;
>>   
>> -	timer = container_of(dwork, struct mlx5_timer, overflow_work);
>> -	clock = container_of(timer, struct mlx5_clock, timer);
>> +	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
>>   	mdev = container_of(clock, struct mlx5_core_dev, clock);
>> +	timer = &clock->timer;
>>   
>>   	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
>>   		goto out;
>> @@ -343,7 +342,7 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
>>   	write_sequnlock_irqrestore(&clock->lock, flags);
>>   
>>   out:
>> -	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
>> +	return timer->overflow_period;
>>   }
>>   
>>   static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
>> @@ -517,6 +516,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>>   	timer->cycles.mult = mult;
>>   	mlx5_update_clock_info_page(mdev);
>>   	write_sequnlock_irqrestore(&clock->lock, flags);
>> +	ptp_schedule_worker(clock->ptp, timer->overflow_period);
>>   
>>   	return 0;
>>   }
>> @@ -852,6 +852,7 @@ static const struct ptp_clock_info mlx5_ptp_clock_info = {
>>   	.settime64	= mlx5_ptp_settime,
>>   	.enable		= NULL,
>>   	.verify		= NULL,
>> +	.do_aux_work	= mlx5_timestamp_overflow,
>>   };
>>   
>>   static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
>> @@ -1052,12 +1053,12 @@ static void mlx5_init_overflow_period(struct mlx5_clock *clock)
>>   	do_div(ns, NSEC_PER_SEC / HZ);
>>   	timer->overflow_period = ns;
>>   
>> -	INIT_DELAYED_WORK(&timer->overflow_work, mlx5_timestamp_overflow);
>> -	if (timer->overflow_period)
>> -		schedule_delayed_work(&timer->overflow_work, 0);
>> -	else
>> +	if (!timer->overflow_period) {
>> +		timer->overflow_period = HZ;
>>   		mlx5_core_warn(mdev,
>> -			       "invalid overflow period, overflow_work is not scheduled\n");
>> +			       "invalid overflow period,"
>> +			       "overflow_work is scheduled once per second\n");
>> +	}
>>   
>>   	if (clock_info)
>>   		clock_info->overflow_period = timer->overflow_period;
>> @@ -1172,6 +1173,9 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
>>   
>>   	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
>>   	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
>> +
>> +	if (clock->ptp)
>> +		ptp_schedule_worker(clock->ptp, 0);
>>   }
>>   
>>   void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>> @@ -1188,7 +1192,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
>>   	}
>>   
>>   	cancel_work_sync(&clock->pps_info.out_work);
>> -	cancel_delayed_work_sync(&clock->timer.overflow_work);
>>   
>>   	if (mdev->clock_info) {
>>   		free_page((unsigned long)mdev->clock_info);
>> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
>> index fc7e6153b73d..3ac2fc1b52cf 100644
>> --- a/include/linux/mlx5/driver.h
>> +++ b/include/linux/mlx5/driver.h
>> @@ -690,7 +690,6 @@ struct mlx5_timer {
>>   	struct timecounter         tc;
>>   	u32                        nominal_c_mult;
>>   	unsigned long              overflow_period;
>> -	struct delayed_work        overflow_work;
>>   };
>>   
>>   struct mlx5_clock {
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> 

Hi Saeed, Tariq, Leon!

We need explicit Ack-by from official mlx5 maintainer here to let this
patch go directly to net-next. Could you please check it?

Thanks,
Vadim


