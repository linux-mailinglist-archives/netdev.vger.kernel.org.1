Return-Path: <netdev+bounces-248008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B9D04490
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F47231608ED
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26663328EC;
	Thu,  8 Jan 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBaY2P0V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="j/Mpn09K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691633123A
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862521; cv=none; b=aTMcC8KejU/naQypJ6dOXQLtMhURKRGwp88TzeYYR0lIg5jetsohCXpttkRILu8tm6v9I8HitdO0yLjtOL9fvoAc+IhTjt2oUO+op+KrZIOJVOnS3Ghhd50uaAv9a0t2j/ZET5HLy4Zk8Y8PDwYsnC3khbAXUt6EeauFEGJgVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862521; c=relaxed/simple;
	bh=bFmLVSAcLFz2S+ZEsibt6MqqAQ0+Kcz/e6Xn5wGq9BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gov92KDOiMoTE2aLNTzwnFClpiulWzNdEkTsTLDWLTjCIf+4w6FOPM1hl6DaVwdLMWY4GdhjbyrdvXMtuo264lvyVL4OV3+Uws4K+09HNzqTfzh4FrqTq0xyMfSn08M56Zs9oLYz1vUlETuCCIjC3E9T3oiM0bi54V6n9qWVGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBaY2P0V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=j/Mpn09K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767862512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
	b=aBaY2P0V3vYJDAElQaHSKD5qkRubewg/EpIclUiCCFHS1a28lMgjNhDaASM50DCXogK4PF
	MPzm0wMEs6yG1hd/ifcsIgFTTOaY+LDos+u3TnaKpMtYVCSsIt8VQd3ksPF4Do+i6jje7B
	uIF4TRP72SU8ZUkE58g8HdFRfZxUdFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-gLN119ONPYyhsysy-AHj6Q-1; Thu, 08 Jan 2026 03:55:11 -0500
X-MC-Unique: gLN119ONPYyhsysy-AHj6Q-1
X-Mimecast-MFC-AGG-ID: gLN119ONPYyhsysy-AHj6Q_1767862510
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3ba3a49cso26161775e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 00:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767862510; x=1768467310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
        b=j/Mpn09Ksl06ge3iPfRKBIsO/2A0A2VvAGI/K46hwkoPVn8gJgJvo6G8sbVpiCn8ZH
         i6j1dWLknVqzfcw01LQEBv3g/BBgN/UsPGJVzDSRg6tVCoENtr3BZ14sWCLm95xhiW87
         02VEErM9RMC/FVM4+3CcIdtOKrVg4bp8+wx346BGP2EAXuGvY9ze+/HYo1PRCju2ibmJ
         sjfa91fNrTBHJtcpKBqngnSVhmk5uSQhIxIHIG/AdyowXCdKA3n32ldXUsOZ+0040Fhi
         DLXx1ynwc9SmO5eX3lLWAauEo/ASSgBPwP2ugBFhMuNx1DzsRMMXUAelcDwzQNR+4z4A
         nz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862510; x=1768467310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eI5c1pIYmm7x1JE+RGB61/I3xmf/iU6ZuwYMsS4kL0I=;
        b=A0/6zYr2SliOcxQJhAAiCrpASElKbpSmA1Yf7TXqPysUO5fHv3TU+MHODE5zwhEIRV
         oeqyosCB04STXDYxjT04Mq0/w5s8R/qgihJpP/RSV4b/aBJb6JnpzG9uZdKb4MbVhZg5
         nQtAHpOymx1NlvM+L1nydek6w3o9XdvPhgz2HHXpboY8Ob5EQrt5tEyunE7AIuOoWSfg
         iqYSeYT9U/O56xINZCFvxRTZs1CXkApGNHfDqDZkN1m89DsDWdnXf3cSPGsCefrkkzbX
         cY5qZ+gDvpDJLasnSxcz/o3b8Op6fdVRmEaljz+MVFeuvceku37Fdl3H+g2Da7j+rJLe
         SbUA==
X-Forwarded-Encrypted: i=1; AJvYcCURzuSB8b+j7XsPrzQ43htUW/Fr4sKU+75oGnorojCN1pLSmjghgc1LaVKN8IRRCUDDLLw7aJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQr+yC9oBWnSXlcMikQfNv4go83vG5fxxjp+4rqbr80T9hAJk
	44utIB1E3qGLc1SErjHM+mh+nHyiDuViPcQKiu6DG9UHDVrcjNUp1PmMAe1YuftS3sO1rlzH8au
	4mFQtGti4i0q0bveocnYZSvL436s03opA6IOg+8Lg2qFzV5j0oJogGKk6rA==
X-Gm-Gg: AY/fxX6ud1QHovp6iRdOM7XUPEykSsenxnm6KHvHxh0WGMTVVo/QC9U7H6UDRR53j0s
	WPNtgEJTlqhfQIg4rawy2oM8gbUq4T4e2r+CGKBpNxk5wwugIZlI2waAPXsVOqNwCXpghHvI5dH
	ZtRMH9giqy0nibKE+2WkVWqeYWE/Ji0u9eSMFKtkpzw6JWdTneY2L0u8DX+1QbJiOD8mZ77HI9+
	6UtBHjVVRs8TRHObH6FKDJ0mDT/LJa+jP4GPe5D1oDYVo7bI1TKRgSPd/JQcBp6JnmF7S0mCJ85
	7ZJY5+wEfB4yUS+C5et9CN6SWcCqYytLXkFkZBtE1oWZugMXZ9FAjC/cpPHtS5ZNcnJUlZ97BNa
	4XbyU6taTk3Cg9A==
X-Received: by 2002:a05:600c:348f:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d84b4113cmr64178075e9.34.1767862510111;
        Thu, 08 Jan 2026 00:55:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaTX6Vb9Xp6nT3BQIbPf9uYgZ4XxnPVNIfnIPI+U4WUs2U6AT0/uTauIZVS1q7u+CvwWYylQ==
X-Received: by 2002:a05:600c:348f:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d84b4113cmr64177785e9.34.1767862509768;
        Thu, 08 Jan 2026 00:55:09 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df90dsm14458469f8f.20.2026.01.08.00.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:55:09 -0800 (PST)
Message-ID: <9f0fffcd-8e2a-4ae1-b89d-ae73dba9e1be@redhat.com>
Date: Thu, 8 Jan 2026 09:55:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260104012125.44003-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/4/26 2:21 AM, Jason Xing wrote:
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 6bf84316e2ad..cd5125b6af53 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -91,7 +91,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>  	INIT_LIST_HEAD(&pool->xsk_tx_list);
>  	spin_lock_init(&pool->xsk_tx_list_lock);
>  	spin_lock_init(&pool->cq_prod_lock);
> -	spin_lock_init(&pool->cq_cached_prod_lock);
> +	spin_lock_init(&xs->cq_tmp->cq_cached_prod_lock);
>  	refcount_set(&pool->users, 1);

Very minor nit: moving the init later, after:

	pool->cq = xs->cq_tmp;

would avoid touching a '_tmp' field, which looks strange.

Please do not resubmit just for this. Waiting a little longer for
Magnus, Maciej or Stanislav ack.

/P


