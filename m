Return-Path: <netdev+bounces-162877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D9A28418
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 07:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC03A287A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE0221D8E;
	Wed,  5 Feb 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG/TGxGi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17C21E0AE
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735737; cv=none; b=iTVvbp5jcmOC+KqbFRibKDxItljSQL5nwgGBdpqbYo/Xg9GUEFAsFBWCxj6D8WjqITjWl7KpybP4EkxTRZYqJC5gXvmz8gtbOKP74Ck5sYn8K2HbyK6jSUWKewkmSp7chwshquMGYV5UfLPzjjwsVJUqwvpW5EFDAzDBoRSJPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735737; c=relaxed/simple;
	bh=b6m3D3iJf0xaQAYG3mW0GtRrE9351nTqK/antwaYxHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8z9hK0RG8Rh6BIbtduQVg7dOETiToiGgPKdnMZlLHVqtyMazFaSkUsqryGfFK8VahfeFZesmmSKW3+Tp/uOAkg1Xzd0TsxePicWntox0vZnP6na84UCLDYnX3WmLT3p9SP1eNtrwQ7/I7RjQ4oQoQnIf8BaW2uAAtDw+Hs0ABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG/TGxGi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so10534845a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 22:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738735734; x=1739340534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXtJLSlJgJ4G4q93Z+euJbUEjqI7MN6Jsckf2WTj26Q=;
        b=BG/TGxGiHzQWnsQM7U+0cOv3F82UsFzyvZejhnwQuhA/kQ2aa9er9y8snxPwOdekCO
         0rlQCG/+JSuFDRmcnwBR/is3te3hCzWnkoNzOTXHND9TVgpoWMDYxf1KMHlsRXQS1o8l
         wg5IA+6S6DDSl+PtD+OiGYvcPgftW/QMFUp4gJKe9FwoNXi+OqcJDyKM5ylYu+KzTxKZ
         xkzKUjLmSUq2BzSjtWS4+9+1rc8iqE+s76FyHQawr/x2eNugjGMBmBVM8LHRIye3LXRY
         nfSPZyS8n4nRJSNFL/BiJ97L45OYTSmDxDl4/mbjQBUDbcYsZ8PUovMi8H80sFZnjhpH
         drVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738735734; x=1739340534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXtJLSlJgJ4G4q93Z+euJbUEjqI7MN6Jsckf2WTj26Q=;
        b=xAjUs/TJOHXufw3sg3udpKEHxVJ42i2JFXeXxoMb5G68QRED/hav42Rnw5SNfujpqx
         aFoIoa8ZfK2LE5/Ieatxo9S+mrz7LxAZSCV4qYJn1vS5lTPvU1dl21k7NMo/LbvnWB93
         RwMejjiNJju3xmxB99iQa/yBvKmRR5f/gjyW2frXsgArq8EqVpVBJ2Czxe3isjbmmo8X
         VMYe5rFnZHRG6UnMR3Eixo9QIDFnbdd7zOYy/kCwkv4RbS3Ua2e6lVR/lbTn8nbncw8F
         P2anRsA0Ql/RVnmfKUIW3/lI1PsNS9Xgl8V1FKidU0FdqJqUw52rwLsyJAsknd4nolCd
         nhhw==
X-Gm-Message-State: AOJu0YxTBRbT3u7VEinELiwSQD1xksqGTQwc6rwYlg3FiR/YAlsTPRaj
	dWWpDvV4U3N57gXs688Tv8GnecGQ8jX0lv608u+ysXP3/CRcuiMj
X-Gm-Gg: ASbGncv+8/tzOQb3a9k6S8p0b/Xs1V3kTv+tt7Yv3wcT5xS4+t6tO0SMAtWzYf+dkog
	tuKn+ohc2C9gude6O2lH/3groVEvKHzjr58j/BScba2sJoeRYwY1bxzN7xA/zmOHKTQhgIyYs00
	ACM4adL4TcsHAtAgnA4p8PVMHfv/sqQZuv2lmq2SOSaiwUKw4fl4gAr8f62AOZqVcCgb9xWzEsx
	w2SFsfwDdLxBn5Hea6xafBSSyMzrxhnD3JnW7Hn9+rMoNRpYhFSHa8FZILYheTWJvTiKhSE8coa
	M1GMfHZg4Um1oaDncnBSm4FqiD1JEaVd7PUt
X-Google-Smtp-Source: AGHT+IEArB2sfdXgnFB457/S0G0aroUphudM5j/8kcCDNCrEksEELjrt5NydybGDF4JkZD7OWvmlWA==
X-Received: by 2002:a05:6402:27c6:b0:5dc:cfc5:9324 with SMTP id 4fb4d7f45d1cf-5dcdb775e4amr4605659a12.30.1738735733312;
        Tue, 04 Feb 2025 22:08:53 -0800 (PST)
Received: from [172.27.21.225] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcc28a4c29sm2575986a12.23.2025.02.04.22.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:08:52 -0800 (PST)
Message-ID: <c6ab4404-bcc3-40c4-bf86-1fa9c5770202@gmail.com>
Date: Wed, 5 Feb 2025 08:08:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/15] net/mlx5: Change parameters for PTP
 internal functions
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
 <20250203213516.227902-3-tariqt@nvidia.com>
 <fcac69dd-d579-4f8b-bd0d-30cb6c2455eb@intel.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <fcac69dd-d579-4f8b-bd0d-30cb6c2455eb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/02/2025 10:51, Mateusz Polchlopek wrote:
> 
> 
> On 2/3/2025 10:35 PM, Tariq Toukan wrote:
>> From: Jianbo Liu <jianbol@nvidia.com>
>>
>> In later patch, the mlx5_clock will be allocated dynamically, its
>> address can be obtained from mlx5_core_dev struct, but mdev can't be
>> obtained from mlx5_clock because it can be shared by multiple
>> interfaces. So change the parameter for such internal functions, only
>> mdev is passed down from the callers.
>>
>> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index eaf343756026..e7e4bdba02a3 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -878,10 +878,8 @@ static int mlx5_query_mtpps_pin_mode(struct 
>> mlx5_core_dev *mdev, u8 pin,
>>                       mtpps_size, MLX5_REG_MTPPS, 0, 0);
>>   }
>> -static int mlx5_get_pps_pin_mode(struct mlx5_clock *clock, u8 pin)
>> +static int mlx5_get_pps_pin_mode(struct mlx5_core_dev *mdev, u8 pin)
>>   {
>> -    struct mlx5_core_dev *mdev = container_of(clock, struct 
>> mlx5_core_dev, clock);
>> -
>>       u32 out[MLX5_ST_SZ_DW(mtpps_reg)] = {};
>>       u8 mode;
>>       int err;
>> @@ -900,8 +898,9 @@ static int mlx5_get_pps_pin_mode(struct mlx5_clock 
>> *clock, u8 pin)
>>       return PTP_PF_NONE;
>>   }
>> -static void mlx5_init_pin_config(struct mlx5_clock *clock)
>> +static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
>>   {
>> +    struct mlx5_clock *clock = &mdev->clock;
>>       int i;
>>       if (!clock->ptp_info.n_pins)
>> @@ -922,7 +921,7 @@ static void mlx5_init_pin_config(struct mlx5_clock 
>> *clock)
>>                sizeof(clock->ptp_info.pin_config[i].name),
>>                "mlx5_pps%d", i);
>>           clock->ptp_info.pin_config[i].index = i;
>> -        clock->ptp_info.pin_config[i].func = 
>> mlx5_get_pps_pin_mode(clock, i);
>> +        clock->ptp_info.pin_config[i].func = 
>> mlx5_get_pps_pin_mode(mdev, i);
>>           clock->ptp_info.pin_config[i].chan = 0;
>>       }
>>   }
>> @@ -1041,10 +1040,10 @@ static void mlx5_timecounter_init(struct 
>> mlx5_core_dev *mdev)
>>                ktime_to_ns(ktime_get_real()));
>>   }
>> -static void mlx5_init_overflow_period(struct mlx5_clock *clock)
>> +static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
>>   {
>> -    struct mlx5_core_dev *mdev = container_of(clock, struct 
>> mlx5_core_dev, clock);
>>       struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
>> +    struct mlx5_clock *clock = &mdev->clock;
>>       struct mlx5_timer *timer = &clock->timer;
> 
> It seems that because of the refactor the RCT rule has been violated.
> I think you have to split *timer into two lines.
> 

This is an existing line of code.
Due to dependency, clock had to come before.
I wouldn't split 'timer' just for this reason. Readability is not hurt.
Let's keep it as is.

>>       u64 overflow_cycles;
>>       u64 frac = 0;
>> @@ -1135,7 +1134,7 @@ static void mlx5_init_timer_clock(struct 
>> mlx5_core_dev *mdev)
>>       mlx5_timecounter_init(mdev);
>>       mlx5_init_clock_info(mdev);
>> -    mlx5_init_overflow_period(clock);
>> +    mlx5_init_overflow_period(mdev);
>>       if (mlx5_real_time_mode(mdev)) {
>>           struct timespec64 ts;
>> @@ -1147,13 +1146,11 @@ static void mlx5_init_timer_clock(struct 
>> mlx5_core_dev *mdev)
>>   static void mlx5_init_pps(struct mlx5_core_dev *mdev)
>>   {
>> -    struct mlx5_clock *clock = &mdev->clock;
>> -
>>       if (!MLX5_PPS_CAP(mdev))
>>           return;
>>       mlx5_get_pps_caps(mdev);
>> -    mlx5_init_pin_config(clock);
>> +    mlx5_init_pin_config(mdev);
>>   }
>>   void mlx5_init_clock(struct mlx5_core_dev *mdev)
> 
> Overall if you fix that RCT issue then feel free to add my RB tag,
> thanks.
> 

Thanks for your review.

