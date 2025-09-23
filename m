Return-Path: <netdev+bounces-225722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C773DB97856
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D4C3A7B2C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28856280004;
	Tue, 23 Sep 2025 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dh5OxCMr"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655E1D798E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660512; cv=none; b=TE52hkgrUHD9MYDTbRj2geQFaA3q5NCLGwmmqGRVyEH9zp6R8Q0oG6/7VQFxlJQokN2wkNBOHjnWThcy6LoboQtXbH4PEBZ5qt6MeEvqCPwBJEbwyVG/ih/jF0hocxISfG3cjKZsOFVHO3hhg0eLzxhO4P/qfOJmnKLR0aOcOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660512; c=relaxed/simple;
	bh=WoRIuCI/ZYo+FAPzp36f3oE/lfOFVVqJgoA0ByqYDN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfeEAxjqmy0No0n+x7PvUQObqZF0RLtARufMUMHlvQRZc85VhNfFbb3tgMoNBgDjg4Cy4LHfU3ke1RA01+Sy+gDy2F2UUgc+XXBIZQZH6n6oQSDgo7YL3beyHGuBSwBUIQWXRFeK8AIomcGSKffjU1YoytU8qNmYL+vf2xVkLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dh5OxCMr; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a6ce0da-9f3f-4630-8c01-43ae980828d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758660506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLOK08KsNyE+Atee9Sw6ZH5oINchnh99jP6cC9VKOuY=;
	b=Dh5OxCMru65KgbEUXoptbfoczFbiVY9aCGv7nkD+fDJ3vEVeGML5/WEYm9goLdg/ylFp0P
	szEQK0aQNtIT1mta7OtnrnLJ2D3wBr6NSWop1k5xoS0BAFvufk7pOTEf2V7995CExZQmQl
	6rQDVYYKfF7zqs4QiuVQ+iiUMv2Ezjc=
Date: Tue, 23 Sep 2025 21:48:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] mlx5: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Carolina Jubran <cjubran@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev>
 <20250922165118.10057-4-vadim.fedorenko@linux.dev>
 <5b42dbf4-cc20-4cf7-bad5-fbe3e9055c0c@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5b42dbf4-cc20-4cf7-bad5-fbe3e9055c0c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 23/09/2025 18:44, Carolina Jubran wrote:
> 
> On 22/09/2025 19:51, Vadim Fedorenko wrote:
> Hi Vadim, thanks for the patch!
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 5e007bb3bad1..74a63371ab69 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -4755,9 +4755,11 @@ static int mlx5e_hwstamp_config_ptp_rx(struct 
>> mlx5e_priv *priv, bool ptp_rx)
>>                       &new_params.ptp_rx, true);
>>   }
>> -int mlx5e_hwstamp_set(struct mlx5e_priv *priv, struct ifreq *ifr)
>> +int mlx5e_hwstamp_set(struct net_device *dev,
>> +              struct kernel_hwtstamp_config *config,
>> +              struct netlink_ext_ack *extack)
>>   {
>> -    struct hwtstamp_config config;
>> +    struct mlx5e_priv *priv = netdev_priv(dev);
>>       bool rx_cqe_compress_def;
>>       bool ptp_rx;
>>       int err;
>> @@ -4766,11 +4768,8 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, 
>> struct ifreq *ifr)
>>           (mlx5_clock_get_ptp_index(priv->mdev) == -1))
> 
> 
> I would add an |extack| message here.

Yeah, but the !MLX5_CAP_GEN(priv->mdev, device_frequency_khz) check
looks redundant as mdev->clock->ptp will be null in case of absent of
device_frequency_khz, according to mlx5_init_clock()

> 
>> @@ -4814,47 +4813,34 @@ int mlx5e_hwstamp_set(struct mlx5e_priv *priv, 
>> struct ifreq *ifr)
>>       if (!mlx5e_profile_feature_cap(priv->profile, PTP_RX))
>>           err = mlx5e_hwstamp_config_no_ptp_rx(priv,
>> -                             config.rx_filter != HWTSTAMP_FILTER_NONE);
>> +                             config->rx_filter != HWTSTAMP_FILTER_NONE);
>>       else
>>           err = mlx5e_hwstamp_config_ptp_rx(priv, ptp_rx);
>>       if (err)
>>           goto err_unlock;
>> -    memcpy(&priv->tstamp, &config, sizeof(config));
>> +    memcpy(&priv->tstamp, config, sizeof(*config));
> 
> 
> A direct assignment would be cleaner.

Just wanted to follow original style. I'll change it in the next ver

> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
>> index 79ae3a51a4b3..ff8ffd997b17 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
>> @@ -52,7 +52,8 @@ static const struct net_device_ops mlx5i_netdev_ops = {
>>       .ndo_init                = mlx5i_dev_init,
>>       .ndo_uninit              = mlx5i_dev_cleanup,
>>       .ndo_change_mtu          = mlx5i_change_mtu,
>> -    .ndo_eth_ioctl            = mlx5i_ioctl,
>> +    .ndo_hwtstamp_get        = mlx5e_hwstamp_get,
>> +    .ndo_hwtstamp_set        = mlx5e_hwstamp_set,
>>   };
>>   /* IPoIB mlx5 netdev profile */
>> @@ -557,20 +558,6 @@ int mlx5i_dev_init(struct net_device *dev)
>>       return 0;
>>   }
>> -int mlx5i_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>> -{
>> -    struct mlx5e_priv *priv = mlx5i_epriv(dev);
>> -
> 
> 
> mlx5i_epriv should still be used here. on IPoIB netdev_priv gives you a
> struct mlx5i_priv .

Oh, I see... we have to have slightly different hwstamp functions for
mlx5i and mlx5e because of different netdev->priv type. Let me see how
it can be factorized.

