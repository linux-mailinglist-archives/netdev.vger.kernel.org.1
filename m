Return-Path: <netdev+bounces-136472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF99A1E19
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723741F278BA
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418481D88DB;
	Thu, 17 Oct 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMUQ6d+4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D251D7E2F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156818; cv=none; b=ldzfPmDP7Hc3PWNfSBsuTvVEDhoNVhZSgEmRvI2KNfHOC9EtkR4mWM8m9gSHLXCUKshVSpUhKGUJ2vxWSlPCdXuz3bntw/tZl94yveVuM50uPPQIWBK02x4OSlzAHBgT0VPpuUTWDWj9cYDQxTXBXYOFYwBKZ1ezZcDEm0jwpWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156818; c=relaxed/simple;
	bh=dL/q81voIw/hA86cex62NW2gq3JOfCm/3IhNTYeq/W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuvNP+47UvA4k+umZFlELJ5YqwjSHjoYq9Z8xiwAxO4XgdM9e5fapn8p2tK1kPKmCPXYhYs2f94O+mv0KJqI71gSUy75YAEoLZmmTbKiO6kfJRFMBPTYBtcu9/g3RCl02tohUOa8gyqVriLZYf6BMeT037sBoDN0xl79A0ejttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMUQ6d+4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729156815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3KUmt1l4UdBp5K1uOtxJcFzZDFqB+86zXPZMY0rO1w=;
	b=NMUQ6d+4+1s3wNO13NnN+BShlkTAiINd/PpVtsNUZA0BG5YG6ielK2gfiQnGjFHkUzDkKi
	snvb3DJ69itHsuaxtCQJ8ypi+6x3GidU2ong6C7ngbIDdJ9Nynr5v9mohfgdaGwJZBTVlO
	ubAvvZItinc6nmpfzbLHH7BAV4x8oRU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-9tbaJr9RN4uQpp64uy-0mg-1; Thu, 17 Oct 2024 05:20:14 -0400
X-MC-Unique: 9tbaJr9RN4uQpp64uy-0mg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4922d8c7so293012f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156813; x=1729761613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3KUmt1l4UdBp5K1uOtxJcFzZDFqB+86zXPZMY0rO1w=;
        b=LVnAlle5dxtyLvHCdwErrr2z7hB4IIZ3uWZzFtJ529Ffc4K+noJHPXa2/S3c5K9K/7
         An3gzdVhcoote0TgdgXnsENbb4aZWxUnfmXgnD2v3eFeLb+wwWvaqVyrgDxdHjTNJOo9
         RilCIKtiXHeEQj5Ndx9A8DxDM8CDfMh3Q70aAHGJdwID5aolbnl6c2tyaKic33eVHEtB
         BlrSAMq814THVpJf2BA1zuXGSu2/xxwa5mJAwFQCs/qENQbK2SbjT+dxY9Z9DxuFbIFx
         uU0eN8frUmNJk9joujNX0/rLtlz85dL8IFstDNn9Q6RWeOYltfxomvapoSi93g497F4G
         7I0A==
X-Forwarded-Encrypted: i=1; AJvYcCWrHcGnPW9YXFqEpjsHCM0lrKBqEaM2sZvaPqRMZ5MRq5QxuRLSwtyP2e3djrCxuKxKY37tCWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Do4xWbid1XeiiD8uvO7D7pvTNU+gY5vcvkAUqfaiB4tsGQ4h
	J0P7uE0kPTfCplVpPBiUdPm6vq9Hnh+SMEkTsx0T0f2BqjesCq+31SAl3OsynX1kIY+YA67pE5H
	5mefN8/ff37ozAGU20kCplni+9HQnJ0Iwhny66SqbKe9vds3w0iTmig==
X-Received: by 2002:a5d:6382:0:b0:37d:3e8c:f6fa with SMTP id ffacd0b85a97d-37d5ff6a2d7mr10434495f8f.31.1729156812816;
        Thu, 17 Oct 2024 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIAClTlpAwt5BHo4hd9KKBogmmHmQpTZdawNZVX2lLZnG3shEAo7FftnZUd8n0fDVcOhJJ9A==
X-Received: by 2002:a5d:6382:0:b0:37d:3e8c:f6fa with SMTP id ffacd0b85a97d-37d5ff6a2d7mr10434480f8f.31.1729156812357;
        Thu, 17 Oct 2024 02:20:12 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8228sm6641014f8f.81.2024.10.17.02.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 02:20:11 -0700 (PDT)
Message-ID: <33e1fcd2-af99-4c8c-bab5-20fe98922452@redhat.com>
Date: Thu, 17 Oct 2024 11:20:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 1/3] mlx4: introduce the time_cache into the
 mlx4 PTP implementation
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Mahesh Bandewar <mahesh@bandewar.net>
References: <20241012114751.2508834-1-maheshb@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241012114751.2508834-1-maheshb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/24 13:47, Mahesh Bandewar wrote:
> The mlx4_clock_read() function, when invoked by cycle_counter->read(),
> previously returned only the raw cycle count. However, for PTP helpers
> like gettimex64(), which require both pre- and post-timestamps,
> returning just the raw cycles is insufficient; the necessary
> timestamps must also be provided.
> 
> This patch introduces the time_cache into the implementation. As a
> result, mlx4_en_read_clock() is now responsible for reading and
> updating the clock_cache. This allows the function
> mlx4_en_read_clock_cache() to serve as the cycle reader for
> cycle_counter->read(), maintaining the same interface
> 
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_clock.c | 28 +++++++++++++++----
>   drivers/net/ethernet/mellanox/mlx4/main.c     |  1 -
>   drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
>   3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> index cd754cd76bde..cab9221a0b26 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> @@ -36,15 +36,22 @@
>   
>   #include "mlx4_en.h"
>   
> -/* mlx4_en_read_clock - read raw cycle counter (to be used by time counter)
> +/* mlx4_en_read_clock_cache - read cached raw cycle counter (to be
> + * used by time counter)
>    */
> -static u64 mlx4_en_read_clock(const struct cyclecounter *tc)
> +static u64 mlx4_en_read_clock_cache(const struct cyclecounter *tc)
>   {
>   	struct mlx4_en_dev *mdev =
>   		container_of(tc, struct mlx4_en_dev, cycles);
> -	struct mlx4_dev *dev = mdev->dev;
>   
> -	return mlx4_read_clock(dev) & tc->mask;
> +	return READ_ONCE(mdev->clock_cache) & tc->mask;
> +}
> +
> +static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
> +{
> +	u64 cycles = mlx4_read_clock(mdev->dev);
> +
> +	WRITE_ONCE(mdev->clock_cache, cycles);
>   }
>   
>   u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe)
> @@ -109,6 +116,9 @@ void mlx4_en_ptp_overflow_check(struct mlx4_en_dev *mdev)
>   
>   	if (timeout) {
>   		write_seqlock_irqsave(&mdev->clock_lock, flags);
> +		/* refresh the clock_cache */
> +		mlx4_en_read_clock(mdev);

It looks like you could make patch 2/3 much smaller introducing an 
explit cache_refresh() helper, that will not take the 2nd argument and 
using it where needed.

Possibly even more importantly, why do you need a cache at all? I guess 
you could use directly mlx4_read_clock() in mlx4_en_phc_gettimex(), and 
implement mlx4_en_read_clock as:

static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
{
	return mlx4_read_clock(mdev->dev, NULL);
}

Does the cache give some extra gain I can't see? If so, it should be 
explained somewhere in the commit message.
> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
> index febeadfdd5a5..9408313b0f4d 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
> @@ -1946,7 +1946,6 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(mlx4_read_clock);
>   
> -

Please don't introduce unrelated whitespace changes

Thanks,

Paolo


