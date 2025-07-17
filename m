Return-Path: <netdev+bounces-207830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A010B08B64
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A6162A63
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C61529C343;
	Thu, 17 Jul 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm02R3gE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2C29A327
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749759; cv=none; b=LiQmQ5BOo/9B/Pkeg4KxrrkuJasR6730C3kfOq7PxelEPWpVzesR1zXscodDG8YKiMAKSkUsVaYGcz9rpqj6cAFuNLqlJf7LF1Ir/Bh2Ki8Vm0GogZAaRE/fmreHIN5KNgzw4oEBtUYXOqNPIK8P6pW/mYjcExqFr0zEwDI3zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749759; c=relaxed/simple;
	bh=gSxihFMQdPhp7IfEUpVtWMpenx++JDqChT8iAbuth6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFCZNxXgxooMT5G4M9Ts3xqvUw95o0vTvMhYjRzJBMy9kHvzyFLzB16Q4vmK15j2CCOSRPUeTXoEfjTO8J7EOYf0/fRQ66QAAsJ73t0mo10rObYIcWEGMtNA0Bof2QkR7vO9WwoYnVoAqGCRfIqM/1iKUPFejkKOhZR56llhXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tm02R3gE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752749757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
	b=Tm02R3gER4fpTgQy7CQgMuYvmxZs8k6ZznzYC2WmgFXdQM3nmnZ9jqOQSkTT4pUzCHG+gU
	UUCHy3GKz9ca3D6tW2EAyo5ljNoL/4hb6DMH6q7AxCiw3nzGtu0wZdtPnOPLA4JhKLfZLx
	w0P8PlyggRqROH4ojEZ1oDbgq8yIg20=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-VTAAzPu4OCilUsJZ9yloXw-1; Thu, 17 Jul 2025 06:55:55 -0400
X-MC-Unique: VTAAzPu4OCilUsJZ9yloXw-1
X-Mimecast-MFC-AGG-ID: VTAAzPu4OCilUsJZ9yloXw_1752749754
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626e0d3e1so6553965e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752749754; x=1753354554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayOJzRkHPyVA0X2izytcAplXmRZn6T5HJvLKOLJn4i8=;
        b=gTDd7zdjyT4qZYhCxnjYMRpMZDdoNf9/iQRAAS37M9xsmuRyWDknf9HUrIs/wxRHYt
         EyuGWv93H0OAX7hhkYKQ8LC+PiUaNf+iPdtvhZOstPM9I/IS3Axjyjemab95vZnlhrU2
         uv3mCY9Osm0IPmEHl6zkj7TvtPCauPvQYchTxJdKqu8C3BEriR9PYUCdUrE/IA9A1jZk
         +2C29aSvT6q6SjbTYHDCSyC0ZitBdlvw9bzt6MKls6sfozC2rkpyHzFya9Kjd45Brv9k
         kR7ZJDyo4+5ewwjtXlSisAn26ZcEsDmQLTjWBq/WH52PoGNFPSjGy4qOHpX/kQQjwxG0
         kMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUqNBMZNF7z9v9JuxPrvhAU3ITcJybjwkL16vHiBaHyx4dR0O1cSFJaNEll53wuUp62jOVV4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSqaeWldwNz8+9+elN6QKe1d7ICe4wIE2m0TKQXt6K2XVrWBy
	vtP9lMjEjK/OYcmpHhIluAJ2Fpfuk7Af0Mq2vRbFL8NKudSwhlzJwZlWWxIZ2bLdYelXebVcRHo
	ndpcZbIvsXnsxHBJcOXNoY3lp5n0/8ivNc0TWJU4TKNCgUbU/dFidFmLDvA==
X-Gm-Gg: ASbGncvDEyYiRVKIMrM3MFj5SnqTnEyzsAGnAEI5tuC+tEFhW5JVzBYqhRy4YL9xqp9
	+eREP5Dhn0mZhj6JWKWqKP/5meBFcuCfVHAKun0HgZ8kbrmlxN4bHvjV7dl1Ik3aQHWFsoaNUGw
	EwKkrmd3jE2PXm0bmppVDgdf1PgLUhvQ+4rDQwmxCkDLPvhP5bGrRMW49YnDpu4kSZlR5YfL0bK
	dLU3kz7Ul5OBpw3OOFhbEOAqMVCQ7Pb0KfQa1W8u+48XV0QTzPYzr32ToeXqjToFqjLBUAAQah0
	Rk4aLqvzc9EyQ+QPPUG+InQBxx6PdhqDKyn0Pn7CStUISz02AOiY/WX+K76lun1cCwSI8Na3kDO
	m4a48eKK8aoY=
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983245e9.23.1752749754320;
        Thu, 17 Jul 2025 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9hmzgeO6mfBS8jGYj9rG77mwI5Itg2IPeN3BeV/EmE/d7ghhRi3L/99no/15vSa70B3AChg==
X-Received: by 2002:a05:600c:3b97:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-4562e3a29e9mr48983105e9.23.1752749753937;
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f4c34dsm18920425e9.6.2025.07.17.03.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 03:55:53 -0700 (PDT)
Message-ID: <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
Date: Thu, 17 Jul 2025 12:55:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/25 7:15 AM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
> expose the device’s raw free-running counter.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index b1e2deeefc0c..2f75726674a9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>  	return 0;
>  }
>  
> +static int
> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
> +				struct system_counterval_t *sys_counterval,
> +				void *ctx)
> +{
> +	struct mlx5_core_dev *mdev = ctx;
> +	u64 device;
> +	int err;
> +
> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
> +	if (err)
> +		return err;
> +	*device_time = ns_to_ktime(device);

If the goal is providing a raw cycle counter, why still using a timespec
to the user space? A plain u64 would possibly be less ambiguous.

/P


