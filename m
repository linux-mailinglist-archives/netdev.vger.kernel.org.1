Return-Path: <netdev+bounces-158088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E88A10709
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F0D1643F4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98720F99F;
	Tue, 14 Jan 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0LmrXx7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295F1E489
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858815; cv=none; b=jyaLT9ZdHSo7Mp6YvfEKGMMekD/b32NTufu1W1tI+6EgCNQ35kI0Po87nJJ1oD0FZs73+vnGselGyn23zL/9gdkfKDrP8ai7Ta4viiOZ7OAM95UnP6v6+um346Ld7TciAwMMoQanahRv4zThO7nh/ouWyNc9ggjtS1yVqrCVcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858815; c=relaxed/simple;
	bh=Uin1dOmwdUP+SHUBgd6PscEgsxreyrFU/vwVc8g8y7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h1YLzrq/zxrtIxm1UaNBsgzwLiPujuKpiyNsnk+TvJpd5zbwy8CLi7Og4FW+RTCwUw6E69sdQxIocKJw3gII1ejjpnF3IPxfXnN2W5PaVjhP17FN4x8Z/AI7AKc1KC8r9zfA/efnbrYbbitZY5VYdEmx16mws0EB2FWpjUUlAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0LmrXx7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736858812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH/iRgPgE7A5Fhhf2p8dKe9HdDfKM5Ah+Fq/yovw5X4=;
	b=T0LmrXx7ia/DwHp3WdAoYMtcxB7cE7yXUAZEBcSz0xpqMQuG0UxsAbVozogH0/cHNpBCw/
	MZH8qrSstSGlwMIAJAqul/bprabAsa1mrwfEVxiq61/JhUyoeqrTODVNIT/15ITmLii9a+
	cWdK23ULDdfZlAbw3xyfzQeV15R9nfg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-gUBuFkt6Nkm0H_cCOGiYWw-1; Tue, 14 Jan 2025 07:46:51 -0500
X-MC-Unique: gUBuFkt6Nkm0H_cCOGiYWw-1
X-Mimecast-MFC-AGG-ID: gUBuFkt6Nkm0H_cCOGiYWw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38639b4f19cso1358446f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 04:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736858810; x=1737463610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kH/iRgPgE7A5Fhhf2p8dKe9HdDfKM5Ah+Fq/yovw5X4=;
        b=C7v6Xa1EvW168Z3hpaaim81QC3Z7GfVNXpYXuHbo9dUI9l4GLJCrZdZQTma58sMgul
         8B7QeZzQcbvV1OoFJG6D9FtS2zpGNQRJJpeHP3sCczodVCDkejkOsz64mQq505u/fmXP
         zqfskCQ4dvd84u+6yuNnCm8AUF+eL8xjTqlPnQ2j7WjroBAxLrZPKaPKQ3oUJ29FryJ4
         0PZb4sUvKD1th2RgmjTmIE1NbqyH8z258O/9cWlD/Qj5a52QU5paV99BbSsKH+DbBL9p
         49gc9g10mm+EyC7a1vhCMCU8TBGIz5sxpbeCR4K9XwX5Vbo4ULXIILhsZbGzu4NVFlgC
         Otew==
X-Forwarded-Encrypted: i=1; AJvYcCU9LrSpoxnOiZgPRE0IQlzOozhHkaojfStqDKPaquvSF2KwHOBharg67oDTQGiJ0GQpTZq18sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZcqgHHTx/WmQwQNtxZy8i7nerHWvd6FI03xfFkSEZzxJ/c3C
	0mDOyuPIi5uuM2uTWlWE3RS81h96TXTycD8X6kUn4KvySDPg2iU7j4tva+B5+t9pMFfzOIUDhY3
	XOkr/HKLXjII8RuoomyXg3WOhSUrvXK4yoONRBD9nja1p9yeqaerRvA==
X-Gm-Gg: ASbGnct3RNJXNPD5m4LTcBfkz6IBAAqv5bTXk1b/shlODqidI0wAO81YS5riaCeB2Gq
	xtywpD+0AkO1mrmj9V6ZpxTqKz9rWbELnWyvYhCcZCaS1qE6NLCYwcodFy6bzJuKKADddDFjFnf
	Nry2YE5mvbgMIjMf6utpwCvLyUR77vs6bq9sFSdB4g1c0SlBmbViF7n4hcaEKfUER71pjC22+Os
	+sFPgGu0Zbhdn45miz9VVZRyXChd/3Vt9NVRR6V3Y2kDhJiY6PsVi5Fz80XRM97n+9y9mkPoxip
	Fp5gQOEbjos=
X-Received: by 2002:a05:6000:4a06:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38a87338df5mr20454025f8f.36.1736858810319;
        Tue, 14 Jan 2025 04:46:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+9v10x1N2wFoQ1EghG8MZMb2tc7d0Q08/8q5FSV+ZT6GN8dur266nKm/Vs31WmKlGP+I9ZA==
X-Received: by 2002:a05:6000:4a06:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-38a87338df5mr20453986f8f.36.1736858809912;
        Tue, 14 Jan 2025 04:46:49 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d26a7bsm180090335e9.0.2025.01.14.04.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 04:46:49 -0800 (PST)
Message-ID: <49043623-f34e-4274-ab4d-494d8319cb32@redhat.com>
Date: Tue, 14 Jan 2025 13:46:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 3/6] octeontx2-pf: AF_XDP zero copy receive
 support
To: Suman Ghosh <sumang@marvell.com>, horms@kernel.org, sgoutham@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lcherian@marvell.com,
 jerinj@marvell.com, john.fastabend@gmail.com, bbhushan2@marvell.com,
 hawk@kernel.org, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org
References: <20250110093807.2451954-1-sumang@marvell.com>
 <20250110093807.2451954-4-sumang@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250110093807.2451954-4-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 10:38 AM, Suman Ghosh wrote:
> @@ -1337,8 +1358,12 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
>  		pool = &pfvf->qset.pool[pool_id];
>  		qmem_free(pfvf->dev, pool->stack);
>  		qmem_free(pfvf->dev, pool->fc_addr);
> -		page_pool_destroy(pool->page_pool);
> -		pool->page_pool = NULL;
> +		if (pool->page_pool) {
> +			page_pool_destroy(pool->page_pool);
> +			pool->page_pool = NULL;
> +		}

It looks like the above delta is not needed: page_pool_destroy() handles
correctly NULL value for the page pool.

/P


