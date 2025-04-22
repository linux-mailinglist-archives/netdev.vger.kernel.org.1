Return-Path: <netdev+bounces-184558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D10A96362
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21127189BC47
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0423AE96;
	Tue, 22 Apr 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYgKdKYi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7225523A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311760; cv=none; b=m5WR4pWLH9+FfRUXn1Kt09QZDzJz4Mh76jdckUcLpkL2pqCgkmN/WUsAFoTUg/acJ7XRumKIxwZUPtktiMiybYHmuGaRdKGMZts5rhreVK1FKC/4hyb001TFb5JZ0hEZ0bsnJCdzdcFwzgnWNi4TesVDhSsReZ9QAdl6HvcepKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311760; c=relaxed/simple;
	bh=0ym9KKbNUHfNJ3Wam2dzzQBS4YrCEs/UQxiazDPFamA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxTvSRCE5AWYNz7j4LOmnXyNRQeReDSFhJpC+cG4GS1eULN3YX6UXMwbPOp9g6mKFlGSocxdcS5o1IsszaYjEtZzfU4nXQOwR51BNadNWNI/TJMQV+vkhB6xJ3jjdl/d6WHm6PfoAB8r/5YT8pnMrMpTNvEzN7kE0XUxpJOfOxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYgKdKYi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745311757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gzlco4/QQ+XOtfKlhZMKwWiFJ7K53bODuhX3nxwrYo=;
	b=WYgKdKYiWXdXgVuzCMkuVTH3eKLUC5QWd364rrVzW6G+6pn6L72rCkUnRO/KcgVy7glqvR
	acGo0qxqpUewimlMtH5rOcEFkSbJob4j+Y7s/LuMj+4RtF0rge9OJ7IJx4bmXaHkzSy9/c
	UhInQMfgq3ivrceZqZKj/33SIIpCU4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-20Hdi982NT2qGFUosP32pw-1; Tue, 22 Apr 2025 04:49:16 -0400
X-MC-Unique: 20Hdi982NT2qGFUosP32pw-1
X-Mimecast-MFC-AGG-ID: 20Hdi982NT2qGFUosP32pw_1745311755
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39ee54d5a00so1601842f8f.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 01:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311755; x=1745916555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gzlco4/QQ+XOtfKlhZMKwWiFJ7K53bODuhX3nxwrYo=;
        b=DZBvL1BYHphJ3PT1Nf97P0C9O44hqdL3xc1PJOjgOyQej3F0xakmpVKHLhmOJpCgtH
         /bEHitC5+Zq2BbRoNdPeBmBZ+O7IicwBetEmT6VQx4pBKN1VCNKAg8iQjtgXGFmBmh0o
         NxLY/Rj3y6Y6sSX2r/hyLOA/VcwXiHGQW7B2t1zCkBthwbTpHUO89k66OR8HjwZ3MM8z
         IJqSZPmndlD9BmEoxXsAfacDYrLYQR8EXOaSMvQLPwB5Do/YZPE2CyR3/IiyXMEPD/qP
         zFU+5Hp589skTVMLq9X8OUZeYWv0i6lNl/dGU8fRJaY5taB0tR2BeQPMSva2O0FcFVq4
         OXHg==
X-Forwarded-Encrypted: i=1; AJvYcCXlVflaYUPxCQfEy3KJD0ZRZUXasEXT5izFij7U4ZQx1xgRHxyvuvOHIazHPg3/+t9NJ9yBoIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xPBmvyXX6pKo4yIBC60SRgWfgO7Llov2dOM6rSfKZNAi15fG
	PJWH4wDLsLP0FuOEj2eEOFsYyldfQhFLl+H0ARC84A5lidSCUqGruLXw+qIrZK2dKCOkEEmPGYM
	H4i4boF8fJsaRI5IuLHU/X3ME1cM496+ssCHMe2x9UOBbcHYkvJmwPg==
X-Gm-Gg: ASbGncvAqUAtCfIGUat2hLlsMk0HBLSDUkW8+cgeyN2rMjgyNpeyTo9ojTctk4Yozb+
	h7D+1xyyyqa5szkVutvVP/qytQ74q5ghFlIt7RXcHfMibodqpQtSF7QD0LJObbXJQk3FPKzYU1R
	blj9ZdoSryKF8VZG/54xzJY76Rh+/94R0cAKxopjifGnC8OACgJs1qoj9Ny0z0cKvYs/0mI8lp5
	EIJkRteddR2C0j45OM5q6Ts7Y8A6aMNVozRr5bDWVrbQHMs2gIOqa0p5VCrKrGJiFzEu/KVdJjf
	yTtOfk3akog2bLsFJphhV2Qc801q9GG7CUVK
X-Received: by 2002:a05:6000:4310:b0:39c:119f:27c4 with SMTP id ffacd0b85a97d-39efba5b778mr10216203f8f.30.1745311755151;
        Tue, 22 Apr 2025 01:49:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+gLkGS+6Wrm379R48X9cvL/z6DBrmMhR3MGHsf9z0rua1cILetwfdD72djlIQhjDMQI/h0g==
X-Received: by 2002:a05:6000:4310:b0:39c:119f:27c4 with SMTP id ffacd0b85a97d-39efba5b778mr10216180f8f.30.1745311754665;
        Tue, 22 Apr 2025 01:49:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493446sm14410193f8f.74.2025.04.22.01.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:49:14 -0700 (PDT)
Message-ID: <2c7972c1-ffcf-4d28-83ec-1dfe5dceb8d2@redhat.com>
Date: Tue, 22 Apr 2025 10:49:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/15] vxlan: Do not treat dst cache
 initialization errors as fatal
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 razor@blackwall.org
References: <20250415121143.345227-1-idosch@nvidia.com>
 <20250415121143.345227-14-idosch@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415121143.345227-14-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 2:11 PM, Ido Schimmel wrote:
> FDB entries are allocated in an atomic context as they can be added from
> the data path when learning is enabled.
> 
> After converting the FDB hash table to rhashtable, the insertion rate
> will be much higher (*) which will entail a much higher rate of per-CPU
> allocations via dst_cache_init().
> 
> When adding a large number of entries (e.g., 256k) in a batch, a small
> percentage (< 0.02%) of these per-CPU allocations will fail [1]. This
> does not happen with the current code since the insertion rate is low
> enough to give the per-CPU allocator a chance to asynchronously create
> new chunks of per-CPU memory.
> 
> Given that:
> 
> a. Only a small percentage of these per-CPU allocations fail.
> 
> b. The scenario where this happens might not be the most realistic one.
> 
> c. The driver can work correctly without dst caches. The dst_cache_*()
> APIs first check that the dst cache was properly initialized.
> 
> d. The dst caches are not always used (e.g., 'tos inherit').
> 
> It seems reasonable to not treat these allocation failures as fatal.
> 
> Therefore, do not bail when dst_cache_init() fails and suppress warnings
> by specifying '__GFP_NOWARN'.
> 
> [1] percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc failed, no space left
> 
> (*) 97% reduction in average latency of vxlan_fdb_update() when adding
> 256k entries in a batch.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 2846c8c5234e..5c0752161529 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -619,10 +619,10 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
>  	if (rd == NULL)
>  		return -ENOMEM;
>  
> -	if (dst_cache_init(&rd->dst_cache, GFP_ATOMIC)) {
> -		kfree(rd);
> -		return -ENOMEM;
> -	}
> +	/* The driver can work correctly without a dst cache, so do not treat
> +	 * dst cache initialization errors as fatal.
> +	 */
> +	dst_cache_init(&rd->dst_cache, GFP_ATOMIC | __GFP_NOWARN);

Note for a possible follow-up: AFAICS, when the allocation fail the
user-space will have no way to detect it, except for slow down on tx
using this specific FDB entry, which could be surprising/hard to debug
or investigate. What about adding an explicit pr_info() message here?

Thanks,

Paolo

>  
>  	rd->remote_ip = *ip;
>  	rd->remote_port = port;


