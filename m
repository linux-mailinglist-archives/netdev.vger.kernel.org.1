Return-Path: <netdev+bounces-140329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F19B5FD9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FF8B2218C
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A41E32B0;
	Wed, 30 Oct 2024 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hu9cKlyC"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6651E231B
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283479; cv=none; b=auZ0zQpC0ECNtr1ZS6iH59fL5H3i6gFvyY/1wd6sEyJeX3OVDODj17mK2Pe8V9GOFEC7mQcRGiTqakjgmkssM1g5IbYy0ekaiIdUa1N83rgybdjSOSiYqCyP4iz4LaY3zq4VfD5TJ22YYWMHu93IHh73CsR80eJTa9FS9uC1lJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283479; c=relaxed/simple;
	bh=PdxWNT1jcWBWmUB9Z91Kg6NXoTGc/mkTshntdWivX1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWLMK21D6eVZaga3UkdFD6xvDveyoiDf+ZaczwfynaBuq5W6azdnpLsRxAmf9qr2mnNN5VjtJ61qdVD2s/9G9aRWW86qU2ohYqTj0hOp0D2ZxvEIimH4qWlHrho5z6JweeBKPK07vcPvFRTs1qRVAqNsA3OFMbLr+1yYr+CmhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hu9cKlyC; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8c889b0-828d-48c8-ba0d-47a0fcafc616@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730283475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2yANmFTkkjh+6oMzRT7nI2MJw1gamY3r4/y28tsV7E=;
	b=Hu9cKlyCs6oZ9W5TZYutoa3lV0PgusecsMkG06VHKf97Ta4ZtTAUXILe0kxYL7/c90tIqR
	ZTPg5KVqai3vbggzsWBwomQuPAGUCeDkOIsXQEE20BUY9mfKi20Wgba8LSNPhvkffNK562
	a+/siE/95ysJU2Gw29XyOKHNIaZe3dU=
Date: Wed, 30 Oct 2024 10:17:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] mlx5_en: use read sequence for gettimex64
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20241014170103.2473580-1-vadfed@meta.com>
 <87wmi6njda.fsf@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <87wmi6njda.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/10/2024 05:08, Rahul Rameshbabu wrote:
> On Mon, 14 Oct, 2024 10:01:03 -0700 Vadim Fedorenko <vadfed@meta.com> wrote:
>> The gettimex64() doesn't modify values in timecounter, that's why there
>> is no need to update sequence counter. Reduce the contention on sequence
>> lock for multi-thread PHC reading use-case.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index b306ae79bf97..4822d01123b4 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -402,9 +402,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
>>   			     struct ptp_system_timestamp *sts)
>>   {
>>   	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
>> -	struct mlx5_timer *timer = &clock->timer;
>>   	struct mlx5_core_dev *mdev;
>> -	unsigned long flags;
>>   	u64 cycles, ns;
>>   
>>   	mdev = container_of(clock, struct mlx5_core_dev, clock);
>> @@ -413,10 +411,8 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
>>   		goto out;
>>   	}
>>   
>> -	write_seqlock_irqsave(&clock->lock, flags);
>>   	cycles = mlx5_read_time(mdev, sts, false);
>> -	ns = timecounter_cyc2time(&timer->tc, cycles);
>> -	write_sequnlock_irqrestore(&clock->lock, flags);
>> +	ns = mlx5_timecounter_cyc2time(clock, cycles);
>>   	*ts = ns_to_timespec64(ns);
>>   out:
>>   	return 0;
> 
> The patch seems like a good cleanup to me. Like Vadim mentioned, we
> should not need to update the timecounter since this simply a read
> operation.
> 
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Rahul, Tariq,

will you take it through mlx5-next, or should it go directly to
net-next?

Thanks!

