Return-Path: <netdev+bounces-65778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E628C83BAE7
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF928A95A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57E12E48;
	Thu, 25 Jan 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu+I/kx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE945171AC
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168566; cv=none; b=JYJMqnv28ra/4P+8XVTPwSJ6TvxB7FJ8uzWlcxcq2QHjJlURYwK+9EnsVRtGasf1t3+EtL+/YEPfE/7hFvC1cjV87gi19gCUnRbk/D6WoRIS/mpp1Vg2LZhK4XJJ9L/Yfb8gxmY7gEOWqvgs8pr1A5aTs0GHsoHhffIHew6DYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168566; c=relaxed/simple;
	bh=7xAkom3T2QLILkKiLMsK+HWLk0D4+SUx0hFMjJ1ZuzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxCkUvfNWSHEvZVzDgXX1dsrd+9xh/xf2pKDT80kEU+B+HMbMRS1+4XgaTV8buibvUJQ8bwxqtZABuRJQ/WHDAz6PSlFzonxlBmdU6wdgmBJyKGGgFIHKkZRReMdAHrQsfcy9/MJrbcq6pxNNlrHLsrAJqaGBFk89h/fh6eFVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu+I/kx2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ed218ed1eso1720965e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706168563; x=1706773363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tE0X+WKalimw2YH682/ks5g/NzEBw9mJrvA9GMaew6o=;
        b=Tu+I/kx22Cpl+cI29yXGzi43jZfEjdQqeMlirXTm17Yi+5/haExcuR2jbLtLezx4a7
         BK4uSLZEKGsPYPvrBQwMYFuXFZV5/fgzfCvvaJ44mC77eClEJb44vepCHAmANX0yN1lr
         3Z7eM35yWb6vtwhqSEeJJSCH4T2BCXmtIn7lEaZ/Mi/plJFZakV8vPwJdhf0a4yOEi4W
         Y9nP6ymsggF4YHMrgNIje0tntROoCcN+riqw5ICfB7LXCIv5027zwp7+8Nxo5HcelHiH
         Ud+hW3aIqUxrYoRV4SoqslKonQXW9/5RWcre5ARwAD1gHbF2Q13ljijkHkDnw/+uz+M0
         nDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706168563; x=1706773363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tE0X+WKalimw2YH682/ks5g/NzEBw9mJrvA9GMaew6o=;
        b=YNmmUM3ui/asWlxYpY8mvQAVN47fUGB70kzRf7VwEMXG+01YvZwXgKoRmwF48+gArE
         1MkRoYCVzEQ4fh2wpQJIGcDHAyFwm57ccmPaPnwj+Z0b8akIiAncxieldvvu8sQFzgyz
         ygwXB1FzHLSOmyJv5e+sPT86STIXfJqdcm6DZhHgzFqYTzPYTIQNC/6aOgSAe+pOWJK4
         EKP2WjKogxp43qcQqimJSkO4vS5FKogBBPLxyFNzIQ1Bh+tkR/yvitB0zGgnK7h6yAJ9
         jgd7fdiLd943v+8pKaRrcJuZcjdmYKJm142z5HnigPDiKhehqNHUz79ZhbOXdIsDyPoh
         ZjGQ==
X-Gm-Message-State: AOJu0YwC14qYdoT5fWGYiVci+mxXoY9+AiLZ776oeqVraPLDDhTOYzPe
	HjTdV8unfzDaxzbNugjTtjVG59MhYWZTDWv/MwXU3lRBkbyFWP1N
X-Google-Smtp-Source: AGHT+IGjGhnM96fODwnxylkE0JJtAF/Il3rmcHJhpTe4wuS19DEM1ADuhYIJxq0yvNbjdco7pC0f8w==
X-Received: by 2002:a05:600c:1c1c:b0:40e:66a5:574 with SMTP id j28-20020a05600c1c1c00b0040e66a50574mr208042wms.120.1706168562921;
        Wed, 24 Jan 2024 23:42:42 -0800 (PST)
Received: from [172.27.57.151] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v29-20020adfa1dd000000b0033929310ae4sm12826476wrv.73.2024.01.24.23.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:42:42 -0800 (PST)
Message-ID: <6e17498c-2499-4c91-bc50-33bab8201965@gmail.com>
Date: Thu, 25 Jan 2024 09:42:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 07/15] net/mlx5: SD, Add informative prints in kernel
 log
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-8-saeed@kernel.org> <ZZfySfG4VClzDKTr@nanopsycho>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ZZfySfG4VClzDKTr@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/01/2024 14:12, Jiri Pirko wrote:
> Thu, Dec 21, 2023 at 01:57:13AM CET, saeed@kernel.org wrote:
>> From: Tariq Toukan <tariqt@nvidia.com>
>>
>> Print to kernel log when an SD group moves from/to ready state.
>>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
>> .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
>> 1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 3309f21d892e..f68942277c62 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> @@ -373,6 +373,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
>> 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
>> }
>>
>> +static void sd_print_group(struct mlx5_core_dev *primary)
>> +{
>> +	struct mlx5_sd *sd = mlx5_get_sd(primary);
>> +	struct mlx5_core_dev *pos;
>> +	int i;
>> +
>> +	sd_info(primary, "group id %#x, primary %s, vhca %u\n",
>> +		sd->group_id, pci_name(primary->pdev),
>> +		MLX5_CAP_GEN(primary, vhca_id));
>> +	mlx5_sd_for_each_secondary(i, primary, pos)
>> +		sd_info(primary, "group id %#x, secondary#%d %s, vhca %u\n",
>> +			sd->group_id, i - 1, pci_name(pos->pdev),
>> +			MLX5_CAP_GEN(pos, vhca_id));
>> +}
>> +
>> int mlx5_sd_init(struct mlx5_core_dev *dev)
>> {
>> 	struct mlx5_core_dev *primary, *pos, *to;
>> @@ -410,6 +425,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>> 			goto err_unset_secondaries;
>> 	}
>>
>> +	sd_info(primary, "group id %#x, size %d, combined\n",
>> +		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
> 
> Can't you rather expose this over sysfs or debugfs? I mean, dmesg print
> does not seem like a good idea.
> 
> 

I think that the events of netdev combine/uncombine are important enough 
to be logged in the kernel dmesg.
I can implement a debugfs as an addition, not replacing the print.

>> +	sd_print_group(primary);
>> +
>> 	return 0;
>>
>> err_unset_secondaries:
>> @@ -440,6 +459,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>> 	mlx5_sd_for_each_secondary(i, primary, pos)
>> 		sd_cmd_unset_secondary(pos);
>> 	sd_cmd_unset_primary(primary);
>> +
>> +	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
>> out:
>> 	sd_unregister(dev);
>> 	sd_cleanup(dev);
>> -- 
>> 2.43.0
>>
>>

