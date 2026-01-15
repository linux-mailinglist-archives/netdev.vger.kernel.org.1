Return-Path: <netdev+bounces-250107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C0D24148
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 252D2300079C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591AF374196;
	Thu, 15 Jan 2026 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkK/MOS3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="me1jRuz8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1596276028
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475413; cv=none; b=J0Zm+vYl/gYmMhbaiMA+28jFi3rkPGrlBhc316EXj4KPtppfQflg1GmnM/oTImeizL1mYhhaO7tniXpjNde1MLRoaTO4ykRnTq6YYnECyQvM8nbqWwwSw3KtWxX7oQpL0EhhM6ycHBdc3ncRdRcagpIKq4SD7KwG4SOfQdPlG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475413; c=relaxed/simple;
	bh=zPFszo3HT9Yy7sF0LNtKtWYewN4gd3s2FdJr79SjUwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgVkCTQwhTDafyZFkxDc2nCbCsOlhGRKq3EBEAY2FtmpusDCoA/wBgbgaqEhSOO/EGYRX7Mtbb3/luNGbuWNZWPmxodVoRstLuo2Z/iett6PCFwQMEFH6CPJuIpPqpzaeuzr3+1q6ivg8/kX6ArrpLWv2zDBVxOUJkxUsj5P2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkK/MOS3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=me1jRuz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768475411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvQHEODSLYLAT5LewcJsTFZrabJtU7Rj3q8lz4ejEQo=;
	b=GkK/MOS3Z0eVxGjF3E3t6o53i6onApNcrCMLcXZTT92GFunpHDsJp4OPndPtzoJPRAXAWS
	Na9+98YDlDcbq6LNUfWW9P6Mm8zCyfxR1gGVwJOvhhlT7XR9UfqEASoJDciA8LspOqI/Ht
	7XZd3N9YeiYYmQCzwIq0V2dTRQkRq/M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-kWcVLUsUMRSE18VS6QQf1g-1; Thu, 15 Jan 2026 06:10:09 -0500
X-MC-Unique: kWcVLUsUMRSE18VS6QQf1g-1
X-Mimecast-MFC-AGG-ID: kWcVLUsUMRSE18VS6QQf1g_1768475409
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso4910735e9.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768475408; x=1769080208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvQHEODSLYLAT5LewcJsTFZrabJtU7Rj3q8lz4ejEQo=;
        b=me1jRuz8RnSFbsp0oVFbdU37zbZlK2UvYl2cR8tUeO8k2iAvRs5BufOM9jVP+EWkXG
         nbWlhfI9lJmKGQMTl59qAKMUZi2y7BSunBrz1hJuIcN9/6JoMNsXJL8XqHgqAV309aon
         +wlGZDjs1deXn8HZGITBxmcHFYRqr7pegsH5hcdddvG53AT4PV6Y5FHioQCJw1cS7omE
         YM2b3yIn+Wwjo+6TKt8gejpHpzsNMi1aFojH+CwO49hywaOuLv617ica49jJjLfBc/ZF
         M4uZg1kXXfN47a9UTyRJldNoMTxisgcPS/DheuK/Z2KP9CxcaoBHMnrSFaUcUikBs1S/
         3ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475408; x=1769080208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvQHEODSLYLAT5LewcJsTFZrabJtU7Rj3q8lz4ejEQo=;
        b=ZE6D3fB1SzJui4TI3OUyLbt010WNs9vgK8jpZHnfLM32iaV+F9oAMLbBtmEAuH8Gzf
         6o8UMuU6+Yl3WC1NIOnc2LHD4x2UyQLl9yWuwJeCd4iRkgWjN3wwOqPHGlqZAlYlZnRw
         A48K4UYLOxfHGVG2X4BvmBzOGHpUVtE7RWopghqq80tr7E25fXQMB0BJcMSp22Y2xrCB
         Q8cWb19vX63lZ0wsMOtaRY1wHkBRkkCM5vr64heWXRG5DsmWD4NtH6KcQEzJLy9bskM5
         Wqf3XPBZgkKa5A4iXhSgKiYvoS7cgX+cm25KsX9e7U5bQcSIQqnWu0xgy0UfhxjAnhjy
         6WnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYMB3+lHciNyxg7Y5FdclXrmAnCHcDPKo3RgoOkBQwXT1Ag/YujdgM9lfV7ru49Q48x9MQaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhDZxGxUVo8oCg9u87DyIZk+izdxecyOi5g3+joWuGNq0zU9l
	6fyVxEm13qNpEHw9vml2YxJK+vlO4vQax3d99lFb5DS3NOxf+zJxAQjZ3W7rzt2hC4PxcO08C64
	GG+3cdR6MV0BA9R5NtvUBvm7nCfOmhumeuUnup4Trb1K1YRTdDn8RZHKbNA==
X-Gm-Gg: AY/fxX757H19hASqijgJdfyhWsd0My31pfF+EeJP6RVeP6MRf+RQnDJakFmTBxyvtJP
	ALykpJpFcR6HEybsCawX9kNQEO9ZfwVtvP7SBE6tRORZvyTyF77uyfBkFyXFPJIUPexiXNELraN
	IAKAQOLBBhqGFMVa6q+/a6JtGPiHF3hdoX8Ds7JF/BfXotjA22SbE+PJMlrsfWQ9eXr4H/dFsM5
	onMpVtxznd4p8u0amzz2xm246VnZF65998zWKXCy9YyFnDST7sN7+Nj4DIjhxdvafSvTwX28c3u
	wZHOZJ7fEMsig7F1pK56TSlpgTgf7nXlyI1F7oMSfHOd0MPQ+wQ3Tph7h7ehM/mOYwHQTasF6cX
	QySZxSo67IUlcAA==
X-Received: by 2002:a05:600c:528a:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4801c858b45mr9421425e9.27.1768475408676;
        Thu, 15 Jan 2026 03:10:08 -0800 (PST)
X-Received: by 2002:a05:600c:528a:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-4801c858b45mr9420935e9.27.1768475408214;
        Thu, 15 Jan 2026 03:10:08 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm41097655e9.9.2026.01.15.03.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 03:10:07 -0800 (PST)
Message-ID: <f3ba7469-21f3-45fa-b367-d5ee999262cd@redhat.com>
Date: Thu, 15 Jan 2026 12:10:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Initialize bulk for single flow
 counters
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
 <1768210825-1598472-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1768210825-1598472-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 10:40 AM, Tariq Toukan wrote:
> @@ -220,8 +221,16 @@ static void mlx5_fc_stats_work(struct work_struct *work)
>  	mlx5_fc_stats_query_all_counters(dev);
>  }
>  
> +static void mlx5_fc_bulk_init(struct mlx5_fc_bulk *fc_bulk, u32 base_id)
> +{
> +	fc_bulk->base_id = base_id;
> +	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
> +	mutex_init(&fc_bulk->hws_data.lock);
> +}

Not worthy a repost, but you could have avoided moving this function
placing it here in patch 1/3.

/P


