Return-Path: <netdev+bounces-142045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058339BD367
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77E7FB212AD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449B1D5AB2;
	Tue,  5 Nov 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N76BPzJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0B1B394F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827830; cv=none; b=UniuElWSFFJsnzaw0rvgBKkZkREO3YyawXVi53u+BFRDlhgm5sReCMrCRSj1U0Ao94hkjU5ARSZmCuUv8THo9B8dZ3oXMrY1u4TMvih3ckCGbXfKnKReueo40Xk4JB/sPZe6/OKPzBSSBqWtLUU8Ka2XIO3s88uTKVefaa+kSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827830; c=relaxed/simple;
	bh=mi8/QSnpMswTsdUShzY2GIh90Jrq6Q1/kuyDGpRRYM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6wgGajvVDsCaFMSVo8JRBp62SO1+vQwLFwqCknHS5CxVSQgA65yb/O26Db6L2YnMt/EHM3xGZ3mA3/ySgIdXZ+WsGevxdSfugwl2sKcHYeO8hz5iATnrIffySltBVuUUiiENcJFAV2FT130PIU0HVPues8VASzPHm3bkyxuPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N76BPzJ1; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so5985483a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730827827; x=1731432627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7kBLb0HEUCF+kXAWY5ZbDoQO5QBWctw70Rl6hf1pDs=;
        b=N76BPzJ1RgXZ7Onl/TWwesj0dH8C/8UAa+wfqYdBkmJVOrPQHthYhOxpL2cmzWcj9w
         XBzza0JuLuN5z8aJa7dVTWaBouyLloEdU+636Gwge+IiyLAjHuqIaq/k8QCoVLjDKod6
         D0bzRBQcnM1eF3Me5tAwJpU9A4OiboUjvx9Rfpfo+UiJXAmFuSF448TPb2bEomGGa7mi
         XEwsZyblVapVv1S+jkaVP7b/fFGJv1V9NA3W29N1oOBqyHoeuBkTbBef5sq0ryKmD/96
         ZbSxN0flF7xcPl+75JP2EN4+A9sPGZpn0TDt0v1pvGaa1pZ5+wR3qsQKW53oRUxorqQ4
         yBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827827; x=1731432627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d7kBLb0HEUCF+kXAWY5ZbDoQO5QBWctw70Rl6hf1pDs=;
        b=WXFow32k4uTjDXv3A7LwnanJioBRx4zgNOYX/FgOjEG8f4/Q03WXnYOOQn/jCcYUFI
         E6J21MMxrteQrfb7tGSxh605rxR34rUuQMkcZrn2BTY4VJpVhCbjRnTAZ+XfyN+pNeGU
         hEUT12cBVf4rxap5Iew/i0Y12qMWiO98mrBvA1lWu2r4TvVLW9EdH33E67WZfJN7hrHv
         cOwBo3lrx4S90H+UdCSpbE0SScKT/YKI2YNKvTh+GdDH1I0KDl4g5oe4BS87uZdgpa0I
         Q14wRlxepy63Kf7nhubOgfL8PqasfDI/8fT/JO5E2l8D0PyCbNVROEUmfKU19MJEikQG
         6NCw==
X-Forwarded-Encrypted: i=1; AJvYcCUgKkRVs7VmG8FWoXZRMZXJVNoO/QGQVuXJHG0X1t5J72dSq+cGtZztAxfZ1hyfsrD0YVdYXdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9X0NojQJMxrmT2StmQeu0dZMWOEPCM8wF5WWxlLUqSA8BreOr
	WX75riSij/JH87xiTcmA3XJ2HF8KtWMfcHO3cq7gnrPSrq52+hmh
X-Google-Smtp-Source: AGHT+IERzQ6ykMmyYfW/z8DfXaVOtDpxgss52+4tKOxbuwEg+UTGRIGTtbSLW07CD//X3YZEbFwsLQ==
X-Received: by 2002:a05:6402:27d4:b0:5ce:b82f:c4f3 with SMTP id 4fb4d7f45d1cf-5ceb82fcb9emr15297034a12.10.1730827826352;
        Tue, 05 Nov 2024 09:30:26 -0800 (PST)
Received: from [172.27.60.131] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6b0fac0sm1555424a12.79.2024.11.05.09.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 09:30:25 -0800 (PST)
Message-ID: <b357da67-7dae-40f7-952e-1472d3df3919@gmail.com>
Date: Tue, 5 Nov 2024 19:30:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlx5_en: use read sequence for gettimex64
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20241014170103.2473580-1-vadfed@meta.com>
 <87wmi6njda.fsf@nvidia.com> <c8c889b0-828d-48c8-ba0d-47a0fcafc616@linux.dev>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <c8c889b0-828d-48c8-ba0d-47a0fcafc616@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/10/2024 12:17, Vadim Fedorenko wrote:
> On 18/10/2024 05:08, Rahul Rameshbabu wrote:
>> On Mon, 14 Oct, 2024 10:01:03 -0700 Vadim Fedorenko <vadfed@meta.com> 
>> wrote:
>>> The gettimex64() doesn't modify values in timecounter, that's why there
>>> is no need to update sequence counter. Reduce the contention on sequence
>>> lock for multi-thread PHC reading use-case.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/ 
>>> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> index b306ae79bf97..4822d01123b4 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>>> @@ -402,9 +402,7 @@ static int mlx5_ptp_gettimex(struct 
>>> ptp_clock_info *ptp, struct timespec64 *ts,
>>>                    struct ptp_system_timestamp *sts)
>>>   {
>>>       struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, 
>>> ptp_info);
>>> -    struct mlx5_timer *timer = &clock->timer;
>>>       struct mlx5_core_dev *mdev;
>>> -    unsigned long flags;
>>>       u64 cycles, ns;
>>>       mdev = container_of(clock, struct mlx5_core_dev, clock);
>>> @@ -413,10 +411,8 @@ static int mlx5_ptp_gettimex(struct 
>>> ptp_clock_info *ptp, struct timespec64 *ts,
>>>           goto out;
>>>       }
>>> -    write_seqlock_irqsave(&clock->lock, flags);
>>>       cycles = mlx5_read_time(mdev, sts, false);
>>> -    ns = timecounter_cyc2time(&timer->tc, cycles);
>>> -    write_sequnlock_irqrestore(&clock->lock, flags);
>>> +    ns = mlx5_timecounter_cyc2time(clock, cycles);
>>>       *ts = ns_to_timespec64(ns);
>>>   out:
>>>       return 0;
>>
>> The patch seems like a good cleanup to me. Like Vadim mentioned, we
>> should not need to update the timecounter since this simply a read
>> operation.
>>
>> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Rahul, Tariq,
> 
> will you take it through mlx5-next, or should it go directly to
> net-next?
> 
> Thanks!
> 

Hi,

Sorry for the late response, I missed this question previously.

Acked-by: Tariq Toukan <tariqt@nvidia.com>

Should go to net-next.

Regards,
Tariq


