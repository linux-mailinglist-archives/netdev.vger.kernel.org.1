Return-Path: <netdev+bounces-162874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A6BA28409
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771443A5E0D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3FA21481B;
	Wed,  5 Feb 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fghZ+65S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644228399
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735455; cv=none; b=uM5W3aPYqRKvxzALr5KY2iIMd2V2htK8uf4B11jNL+/XG9fniHIZgb2Zn2Zj0Jsbsh9/p6Nlms59fcFf59Yhj2BP+SuPVprff42u+TwwTuoZPtVa7AdSSB9oPXTPyuaDgI4Mej7vjYcoh6E9958UNzEQSAKuig5lFFaF7JBd95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735455; c=relaxed/simple;
	bh=Fjl5Q7YWZeZsiv4ZXEaX8m/fwqwiy/XpvogQofyQQRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRFoAiFcspHpt1BL8xXsJo+WSol6T57PcoJID4BekRRZZMQMCGNr8/xd/s7tTZ/vrGBkbQvcLkbAQwc6jaiC0OW8UX+m4x0bbMaa9+pHgMyljosrZplHqskl1o/sUmBVAu8d8kMmyubv+kSMs6BoZqbmvegb/w0S4ZYL9z0GF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fghZ+65S; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso47016445e9.2
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738735452; x=1739340252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HnMlfOdD14Sm9UYvF0es2APCWtIqtuvxni3GXjH4TY=;
        b=fghZ+65SmhElNgQMi4ALq5ul/4RFlSHlvqT21OPj02wygwBKLgC2Pyug+yzrdlwqVu
         sWPHdQQIot3qwA3kWDJyoFZJB9SxlIP5VnprEygj9+KFfX5XfABnrEGlOoM+PVtfP9mA
         ZCFXo6EnCdhbTOq2Q0E9aizY8PZBYDPo1nDyD8coemJPpfBkM1RBQGP6o74tn0B/v7dV
         vfOXoq95NlmjGptdSf4tjZ3OsLj5vnFFB9UjLoZYJVCkIa6kmzofHxtZSLv/HfQCfTAg
         J2okoaj8L/BJpiudcsgvee0EfB8KBuIy1hnNcRRcCn/GIRs1mh2ktCYrP2pS+uSJFSoT
         8fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738735452; x=1739340252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HnMlfOdD14Sm9UYvF0es2APCWtIqtuvxni3GXjH4TY=;
        b=ZzPDVEprYRnLrLmPUnhsPwX8QdOJ9FrcgveURf3gxD2HPA7OJUi4f5iOSv2blCacfb
         RsnWbAgDipqzT3WYghuaTfxcVdybNRww6KfnunFZRwSxldhgRK2FoeW8MaAwMGL9eV5+
         tG6pSuLwxQSGhz+7J2U6qhr1H3ZausxyOmrDX5CxV07RfoovoSHTNNxYgQ/dUN/mGwOP
         CvVVhJPcPN3HpT9UQ5Tv/E1KiqxH8Fl6gyGewWrixpWs5IOCUCPv19C3kR7pTdZSyHgS
         iQivYALV4MRbUQUYVGz/bbUvgMWG0KrbCGH/g6fsZoheEFq0wLAn82k5ICshEMiQiHyo
         4VfA==
X-Gm-Message-State: AOJu0Yymn0Cq7dWqdd7QpGgLGFrAyeD0pQ0slEuu6okJfpI8VdU//yuX
	WYcdesxHpCvTm4iNsgftIrPktIOxWj9YeZSSLahPsbdg6xnc9w/L
X-Gm-Gg: ASbGnctP1omCgV+1oYf4geCWkNYwa8vyioZ0vZEkH5eT8N5UAxAloa6hMptYVbDcFMF
	xD7vJzx7wnagWxcKaGCYR6dGBhB9szuQA5ORK9GgAogS9ocdQVRngqyA6iH6bI/NiDrlo8f2+EY
	anAAweN7WnvtyhXdHXR+jE/CJVNFbropykY24ME0ohJ9cUJjw9aho3b8fnJoaR7Dk2APFopr0Zf
	3QQ0iNzC6OkyklmqIrwhfUlngYpXCf+3ORZc8zRJd3BZCm0KwORpMsrP8HJKNJx9xQ+R3c8ct28
	yV0tp7+Wv+5Yt0fROinA4tTZMz1TbXW58SfJ
X-Google-Smtp-Source: AGHT+IF16lYs9CTfvgaXex3lPCF8OxzPbApHCzznY96exgXvMlpUnj8vtAWcsBNQmpFK3RhyrlOj9Q==
X-Received: by 2002:a05:6000:4025:b0:38c:5c0a:b15c with SMTP id ffacd0b85a97d-38db48cb515mr953567f8f.28.1738735451291;
        Tue, 04 Feb 2025 22:04:11 -0800 (PST)
Received: from [172.27.21.225] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b5780sm17935682f8f.67.2025.02.04.22.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:04:10 -0800 (PST)
Message-ID: <6b2f7d72-a268-4dd8-9721-f1c2901ef316@gmail.com>
Date: Wed, 5 Feb 2025 08:04:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net/mlx5: Add helper functions for PTP
 callbacks
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
 <20250203213516.227902-2-tariqt@nvidia.com>
 <63be4b0d-4cff-45d9-90b3-a318ac6e28c1@intel.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <63be4b0d-4cff-45d9-90b3-a318ac6e28c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/02/2025 10:43, Mateusz Polchlopek wrote:
> 
> 
> On 2/3/2025 10:35 PM, Tariq Toukan wrote:
>> From: Jianbo Liu <jianbol@nvidia.com>
>>
>> The PTP callback functions should not be used directly by internal
>> callers. Add helpers that can be used internally and externally.
>>
>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 +++++++++++++------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index d61a1a9297c9..eaf343756026 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -119,6 +119,13 @@ static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
>>              ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
>>   }
> 
> [...]
> 
>> +static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct 
>> timespec64 *ts)
>> +{
>> +    struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, 
>> ptp_info);
>> +    struct mlx5_core_dev *mdev;
>> +
>> +    mdev = container_of(clock, struct mlx5_core_dev, clock);
>> +
> 
> Maybe just oneliner for mdev instead of dividing it into two lines? But
> it's up to you
> 

We'll keep it as is.
This also maintains the reversed Christmas tree.

>> +    return  mlx5_clock_settime(mdev, clock, ts);
>> +}
>> +
>>   static
>>   struct timespec64 mlx5_ptp_gettimex_real_time(struct mlx5_core_dev 
>> *mdev,
>>                             struct ptp_system_timestamp *sts)
>> @@ -1129,7 +1141,7 @@ static void mlx5_init_timer_clock(struct 
>> mlx5_core_dev *mdev)
>>           struct timespec64 ts;
>>           ktime_get_real_ts64(&ts);
>> -        mlx5_ptp_settime(&clock->ptp_info, &ts);
>> +        mlx5_clock_settime(mdev, clock, &ts);
>>       }
>>   }
> 
> Only one small nitpick, overall the code looks good, nice rework.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 

Thanks for your review.


