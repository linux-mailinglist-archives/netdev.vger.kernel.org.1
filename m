Return-Path: <netdev+bounces-232947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ACCC0A123
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 01:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899FD4E581A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D022E6135;
	Sat, 25 Oct 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V5QiEJRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BA2BE7A0
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761435680; cv=none; b=hKDNA+hNM53rqcpTKgluDwsNbzxXwc8xFSE7OXX7cs7fYWhfFySQZEqeXbHirCqQCuz/4zc0HaYCm3rFa3fIOqybUR0/oM3dbNLhX9N2/wXNIJRRkEd6btEg+ErJW/l07/al1KeEZ22lZC27CYYbDDcVAwd9k/pcD+j2M2sUy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761435680; c=relaxed/simple;
	bh=UWwXy6UzhIRLinQQbmwb1KG/M2Yo7LauXWQNdG35s04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScX9p4G4H6yXOQdCUSdCay0LaY6U6R3yYQ2i1wVacpovPE9iWWfY0HgJ8K+13THCa42XGQOpblEmCpOKNjGmlcvr2JB8/gLF8tvaOBmCRO8xLLKEAW/JhUBoiXHJb7GhfAltAuVBAC1JmD7QRCncmIOz402pcUOl7911dHelcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V5QiEJRy; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-938bf212b72so141494239f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761435677; x=1762040477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+1U0oWnvhmV3gcT58peg4jR0wCVhjayAqtKoI/J3O8=;
        b=V5QiEJRyTQ4qVEUcp/DLt9gynTeF/fqc1LAyGNVPl2ZKlDY5BRFCMT4cc/B3QX0/mf
         3vgNPoYf3kRUo8udXEY43114NUnjV3NO3jx458+7W5oTuRoQBpPISJPhRfgaWVCJBDlU
         t9EuyXo1Bn4/hJ2qpCx4/8eD31gYfMEH2sNmzdUUWBxIWmXxoxtbRSi6pTSMr1a4X4i+
         9KYBbA6EEOcsr/WhbWL7SekaNHuMGf8LDWVIljP5tyyy3/hckDGvmEXd1qAA0fnCyo10
         wcweBFmoxVKYAfBUOuRg9j7v1+Pn2x426ZVOtvU8CtkEKr7l5c1/LbwKpxkneZc/cu5y
         cuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761435677; x=1762040477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+1U0oWnvhmV3gcT58peg4jR0wCVhjayAqtKoI/J3O8=;
        b=FuUGuNfsxYeNmmHiNVnF/UmWj0nWD8f1KsUiLxOsTKIBp3fmzdyN9ZbVjF6uJOxDVJ
         kNESTljMWmfRFDc7KpgVxeIkG3iZkUFpoVZZC88hXbj3lcC16ArW9SEnGH2ADSFDaMLS
         OBsNRaY8ZHHimZIIbDaRuf7fyMrFIqs/9NTPjZGjfmelhGdm/hqffC/tuefDK8blMsfU
         KYIk+IgLDSdvPBVaWVkV6BWMZ57F24wBXa3pTopqBV6rehVYvX19EnY9e8yniGrir19A
         nnoqkZY9/HVI+nmhCQ0RPuBQdri6y7WgDKjCc4UUTkHSDiT+/5xk0UOurrFxr3/P8YGq
         qPPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGgKHnnEXpPy0mOnKc6RswmXQkxgP4ZAgrDxZ24JBsUi/BdHpRkEysCXJQLJV9pQ0NSG6JLvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfhW69owoH+g7v8WjPrjYo47S9IFTDsLuGIr5QAWlVCigZbGT
	oUilee/2sr8jWwtXds1MlatvrX5MEwJcDN+6ergOjdMXvGmMddptdyl6fuHg6+2Yeu0=
X-Gm-Gg: ASbGncshUK0YWDonWVBB/8GZs2PV5BEPOu7qE5MXvMQDhTlmkmO8lCJDM3bqZWaTULS
	mdzrj84MDi0UUdkjd55p21eSOcZM2sI0LCp12awkjRm2sGutQstpkYORduX7BwW+u5mey0+ZXud
	sAfX20HFgFpPgsipzqJOJrpcibkERRlqKNtKfD4a20cuVd/O1YwAUj42FuSurb5uObTF2NhGfnX
	EqqNNQ9pmpu5D2oBYsFAfU5wEpqVAu0wZM9l1LqP8JypN1uA3gmcqQ9gYL5lgp8QDCthtn9+R1J
	1WU1MlW90uae6qgZ+RAwMq5oPEY0DTsIveLXeiHAUguukUIkwFXs06yFkz3WuJ+DsX/Am/oY4Hg
	WvNGqdCrQKvM3j0D1InGueM5a1Tnhs7OzNdMn3qzuKvdXhf6ZpFB1n7uVnK8456URLZi1QVVvmg
	==
X-Google-Smtp-Source: AGHT+IFpdI2tMF+arhoPCj90UOHrR1Z3J5OwTfJEWoq7vT59d1IQXp8f5M40xtA+2iJq460pdjdcYA==
X-Received: by 2002:a05:6602:1651:b0:940:d1b4:1089 with SMTP id ca18e2360f4ac-940d1b41221mr3943054439f.1.1761435677214;
        Sat, 25 Oct 2025 16:41:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e35f77sm1280344173.55.2025.10.25.16.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 16:41:16 -0700 (PDT)
Message-ID: <f1fa5543-c637-435d-a189-5d942b1c7ebc@kernel.dk>
Date: Sat, 25 Oct 2025 17:41:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring/zcrx: share an ifq between rings
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>
References: <20251025191504.3024224-1-dw@davidwei.uk>
 <20251025191504.3024224-4-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251025191504.3024224-4-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 1:15 PM, David Wei wrote:
> @@ -541,6 +541,74 @@ struct io_mapped_region *io_zcrx_get_region(struct io_ring_ctx *ctx,
>  	return ifq ? &ifq->region : NULL;
>  }
>  
> +static int io_proxy_zcrx_ifq(struct io_ring_ctx *ctx,
> +			     struct io_uring_zcrx_ifq_reg __user *arg,
> +			     struct io_uring_zcrx_ifq_reg *reg)
> +{
> +	struct io_zcrx_ifq *ifq, *src_ifq;
> +	struct io_ring_ctx *src_ctx;
> +	struct file *file;
> +	int src_fd, ret;
> +	u32 src_id, id;
> +
> +	src_fd = reg->if_idx;
> +	src_id = reg->if_rxq;
> +
> +	file = io_uring_register_get_file(src_fd, false);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	src_ctx = file->private_data;
> +	if (src_ctx == ctx)
> +		return -EBADFD;
> +
> +	mutex_unlock(&ctx->uring_lock);
> +	io_lock_two_rings(ctx, src_ctx);
> +
> +	ret = -EINVAL;
> +	src_ifq = xa_load(&src_ctx->zcrx_ctxs, src_id);
> +	if (!src_ifq || src_ifq->proxy)
> +		goto err_unlock;
> +
> +	percpu_ref_get(&src_ctx->refs);
> +	refcount_inc(&src_ifq->refs);
> +
> +	ifq = kzalloc(sizeof(*ifq), GFP_KERNEL);

This still needs a:

	if (!ifq)
		handle error

addition, like mentioned for v1. Would probably make sense to just
assume that everything is honky dory and allocate it upfront/early, and
just kill it in the error path. Would probably help remove one of the
goto labels.

> +	ifq->proxy = src_ifq;

For this, since the ifq is shared and reference counted, why don't they
just point at the same memory here? Would avoid having this ->proxy
thing and just skipping to that in other spots where the actual
io_zcrx_ifq is required?

-- 
Jens Axboe

