Return-Path: <netdev+bounces-93816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36068BD463
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68851283CAB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECF15884B;
	Mon,  6 May 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YTbykoZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72015821F
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018973; cv=none; b=orJ+/LZJ8iqWyNPWlscBVrMR3qao3+Ofdcd6IqTiNhFckX8rH9KT+2vo8au2/6H8VD6YMJ4OGe7DW0IsnBHr+Slw7F9qO66f1Ps2C2GO6lRDZdRvuWgiB0Lau/qb0qA58cC8c+iJsag7edirCxV9y8/1FVKGUVRXVTxhCa8U9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018973; c=relaxed/simple;
	bh=vjvYLgTzcc86uw4ILDCJTniSskT6r6RFn/s25BUPKEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MldAZL1dO2tOkC/DHulowww/1VGayCggXY9CRgQ1IRc7uFafHkpzjG+z1TAl+3GF4P7e0meLO+ZKKFDJ28oXm0GdgOvpUIWaP2vuRnYFhNOqLQ6kAzLAPokk7p+gKh25C2BI3HU76Wsx2l0I4AxR7Qw7ZwXIqBk7Ik2TJymjVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YTbykoZZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44390e328so2174121b3a.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715018970; x=1715623770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/dUDMvsOI/Ti2v4wdVfv8mJEdc+bOO/D3aB84SO6W0=;
        b=YTbykoZZG9Rh96jKgC8rTnOGIb6mkMsVSMiKclcR2N98a03OFMeo+hmC9NE8e6+zFj
         unwymOBHpPBicd34Noan7RP4j0zP9d38i92aFfVNl3g1CFpk5hcpDR8R5ZX2Pir6p2F/
         TDXvr3Byr/yyzSjbT7MFqCUTGIUZBFyoQ/psY/99ZQfpk2c4/br9cD7P60QQkfwueeDD
         5ra9lStNzHU+ppTrdJ3RbHLxx2CPs45+lZ5uOIxtaiAMXCw/KWXLuYnOBDRm1qviBy88
         qHibkm8fLvrSoP08tT8iqpy5b64K0BNI35TbIWCZtIc67KVdQiKBnFCzfQwnTMYUy/6F
         /jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018970; x=1715623770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/dUDMvsOI/Ti2v4wdVfv8mJEdc+bOO/D3aB84SO6W0=;
        b=ffBETo/bsz/VAA/OKEBKqVHgev8gjJ912JvDxm+7Sed6MCUqrGLALcX2rTDcltM9Fd
         9l1UyQ6xXXwS61ywVtdFfrcl4B0vpfdrnH3TzCQwUyqpuJsVbi/YYil9Mt/iEnczScHE
         UjdFw7+cWQCw+WZMNoTnRENh3FCv8jkxVtALc1o1WP1/m5zPAL4YXUmO2B06iCDWkKdp
         vr/hrqJq6F1XTcArSMF95r0I8yVwDgm8B95hLxNZS/Iwq+bUucyg9T+Az2hRp47kNzq5
         fAav/xOa51elSP/9esNyhOwGfYyHSsws3aBot687onUI9zUlqwfVfHcf5kaQujHXkwni
         porA==
X-Forwarded-Encrypted: i=1; AJvYcCVd/p8SdW1cfhaAvG9kHq719i/C+KChmxLOpKodC/6Fe8cQJAa6LJTEzo81fTupVWb6CmeuZIYwfJye2dJ4m+YuxkKEISTR
X-Gm-Message-State: AOJu0Yy9RjbIo+GdSwyAU5LyLdJl6BjAtqCHcVljnC6JlaFOOTkm0sUz
	1Q3CFpG6bNCFZuxYINPqm4TlXGg+mrNcFiitVKAnIWsWXHqTh/XnLfrSpCoNHSU=
X-Google-Smtp-Source: AGHT+IGFrq6u9fgjNQK+Jwu6qpUF7NHAxK0zHpwcDB79D9PK6F76yW7DaoCeoOjJSxQROf5crbGZHA==
X-Received: by 2002:a05:6a20:9c8f:b0:1af:ae5e:db89 with SMTP id mj15-20020a056a209c8f00b001afae5edb89mr5835921pzb.61.1715018970124;
        Mon, 06 May 2024 11:09:30 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::7:3726])
        by smtp.gmail.com with ESMTPSA id b185-20020a6334c2000000b0061f42afa8d0sm5502653pga.6.2024.05.06.11.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 11:09:29 -0700 (PDT)
Message-ID: <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk>
Date: Mon, 6 May 2024 11:09:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] gve: Implement queue api
To: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com,
 hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org,
 pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com,
 willemb@google.com, ziweixiao@google.com
References: <20240501232549.1327174-1-shailend@google.com>
 <20240501232549.1327174-11-shailend@google.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240501232549.1327174-11-shailend@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-01 16:25, Shailend Chand wrote:
> The new netdev queue api is implemented for gve.
> 
> Tested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by:  Mina Almasry <almasrymina@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Shailend Chand <shailend@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>  drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++--
>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>  5 files changed, 189 insertions(+), 24 deletions(-)
> 

[...]

> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
> +	.ndo_queue_mem_size	=	sizeof(struct gve_rx_ring),
> +	.ndo_queue_mem_alloc	=	gve_rx_queue_mem_alloc,
> +	.ndo_queue_mem_free	=	gve_rx_queue_mem_free,
> +	.ndo_queue_start	=	gve_rx_queue_start,
> +	.ndo_queue_stop		=	gve_rx_queue_stop,
> +};

Shailend, Mina, do you have code that calls the ndos somewhere?

