Return-Path: <netdev+bounces-215002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071EB2C8D7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B07D5A5BCF
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B12820CE;
	Tue, 19 Aug 2025 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARxOULYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB01798F;
	Tue, 19 Aug 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618902; cv=none; b=Txptx5VQyVaCqM4rNRsbJXjeKIeegfvb3rTnfXZ/yQtsFMxxWMoD30k5Bmh30OwCHpNutNCuz/e2wWUUiAdZwxkfV19svwsVNfJrGI10Gwme59S1DWiYfMPZlNymR5ZZPJjsfXvk8HXvho+DtuAWOOb//qdxLWc9/JHX3X0FqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618902; c=relaxed/simple;
	bh=aN4wSQvxgVWsQnuQDou4l6pbUNbzNYYHYVEuvzrGA6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj1+tV27JqiArgyykw+mxHMhLFb59NY3fSgqIajLPkvxAddAK3Dy3uiNi5BYWPNX55jjeRg+txoE4Cq+Vg1V17tYnUIwnqeY7eR6rpEIpAlO6YryglLi15TkFnkmK/4CFZZXtrNX9qnUCNYAdxhHaaTzL3yoFESsh6pxHFkiUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARxOULYx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso2932730f8f.0;
        Tue, 19 Aug 2025 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755618900; x=1756223700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNUzf2G7kKNpAXKJCAerjqIGRd9dtlAt73xMvDg+GZQ=;
        b=ARxOULYxIY+zYD9WXizKZsCYnuy3tIG1ycMMWfBQP3GkDKG6Q7xgER6hbuHC/ogYnK
         74KLPLPLzyRR0KS2MgOn2ysZQ011CtLZaUhOg/56BhExv+C1/1c9rDqvjDmE3BDsjl0m
         BHcYFjpOYQEmnDkps7Y4k7i0doFeT1DyUTbGvI+stn9VT6zWTR8mNAgic6ocilysvCJE
         uBCdVBuw73YoicX3ZtWOUIALmc0qW/NKRL6ZhZ0LOuDh78BHLdwBTbzCREkSy9oqUebG
         A8jQwgxG2290G9up5cSV8diPWibHkrDCodHDzwqJvM2Rxwdiszvx7SXE5HbdaFldiA6d
         sgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755618900; x=1756223700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNUzf2G7kKNpAXKJCAerjqIGRd9dtlAt73xMvDg+GZQ=;
        b=Ql7wH+JsfPqB9mX6emjlKAuOvIqv6rhhFsqyacVARn3xeylHHCZWzzuefMhdOrVqsL
         xLhQPxT96Ue7FAO2BHiWuicSFoSYWXrFqLt1nsM5B9j8yQyL/2ACvUx43eW5c063sjAM
         TFaTY8tZO7Hw7npuZarfLO0jrbUKr4fCLT8nu9w+YjtEkSJ1om6dcyGdhScz9kb1u5Bv
         9ktOp06Yiumpq+myW0jiesaarrMbBz/MuawwyzhyxdsutRXjOQ61CqoXHt5S7/zAuQxi
         ZrFuEn7w4BgxxxrrriSWGPqBP8otxZLhf1gIX50GH9GhSirAC3dpMJ98sLlI/HBOffD+
         3zXw==
X-Forwarded-Encrypted: i=1; AJvYcCUbDPFz5AH9SbMZYIgGRO9XojnenEQeySeFcfdrPSeUzQPu9K3NVV7/2om3HUMf2Nm04zy3uuSM@vger.kernel.org, AJvYcCWaWoDrVWmDEotOcL/HDFsd5RK8FWDqmCjsGiYOztyiJTvGf8F+9C/F6i7vhbAj+6aECKecsEKbDeQFHSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsAfsf5sgqQ+S35GEj06+HVGClI5zM1mQ10xd5FkkHZv2Hij4
	IbeHz1OVR7bUROQweg5ztOEsFK4u/zAhiDJEkFQvA94RNyYeDR0bwJ4+
X-Gm-Gg: ASbGncvh2wApso65GYG3cmNdpC4aHMvpZbuteNAMjEq8ayX8r3SHLfX0cwK1csaN7S7
	PE+AIO15jfl6w1wiSSOzYvK68J7SbCVyXhCAwfdVL0h/mETjlltahH/pjuE/ACLMBeJhoSg7+er
	6gkrBbUQz8ojQJghp9m1s8hBp7IeEbxQTvbd1uVpKGkdYyk0fO0rF1K8XoH+yZ6ydIAhjiLY2b8
	EWbAeO8gOKtpDoaCukBtQsrA6iEjb6DlcxJaGf7K3/ojDt4wXv5TVPUoAS/Vo5ykvOsI2uF0zh0
	A4Enzl1vl4OPdQghKbn1O5HdH2Xfh5L9SmhDpht+zKe+fgWeyJqzAPh3npwAwUMQ07Zbyt7QkRz
	hbMcitnT/cnajxj4MAM5B+CdZRFCcQQ==
X-Google-Smtp-Source: AGHT+IHY2/I9aiAU5F/I/46LB20ry5t79Ta01gC4xXrwAOhhztkKPvsO+X1FpThf9Ght7JbbkyQwGw==
X-Received: by 2002:a5d:5d0c:0:b0:3b8:d15d:933e with SMTP id ffacd0b85a97d-3c0ed6c32e8mr2413607f8f.56.1755618899571;
        Tue, 19 Aug 2025 08:54:59 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d439adsm4255024f8f.21.2025.08.19.08.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:54:59 -0700 (PDT)
Message-ID: <4739e642-7fb9-46e2-bef4-77646d343455@gmail.com>
Date: Tue, 19 Aug 2025 16:56:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
To: Dragos Tatulea <dtatulea@nvidia.com>, almasrymina@google.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-3-dtatulea@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250815110401.2254214-3-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 12:03, Dragos Tatulea wrote:
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> - Scalable Function netdevs [1] have the DMA device in the grandparent.
> - For Multi-PF netdevs [2] queues can be associated to different DMA
> devices.
> 
> This patch introduces the a queue based interface for allowing drivers
> to expose a different DMA device for zerocopy.
> 
> [1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
> [2] Documentation/networking/multi-pf-netdev.rst
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>   include/net/netdev_queues.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Assuming it'll be moved and uninlined

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


