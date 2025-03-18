Return-Path: <netdev+bounces-175629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684BA66F4D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2B34220B0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA292045A1;
	Tue, 18 Mar 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqmXqnJS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA19205E18
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742288857; cv=none; b=aTI54E9axUYGMwBDobWBvgC6RnDeNM2o2xlTVGLVaKwJBgzE43QijI3G74YrIONpbBWXxPmrOjDbvLH0auo5aeL2S7F8LGTnQhdLy+58diQwvZvHQq4Wk3FukYGjgyfe1LbbOeEMJkOFGQF6TNRpAqtHdkOBRWD3Ht0ZV2rpbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742288857; c=relaxed/simple;
	bh=l6B0jqIHL2vDeFSEeY70bKvuB+xpl/z8cjYjqfbVpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RotzM/yXxxEB5J4N/ypxbJzgV5kxfiEJzjl3An117Rizb8CujxMQeeVtNdZ8TG4pYDB3SuMk0M+c486o/eUCA9lBhG6qI+fVzAxhFGeUQb4y9YaaBI0IR7BIG2OxND9wwdRJQxiwPl8tSJbzOIe9H8ekWUqQeTi2TqG55lKZ+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqmXqnJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742288851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yo+g6Y5JYSvYovYBPUfkeXwiqEKq7sb5tQYJYO0t0so=;
	b=VqmXqnJSHIvKoBf5dsVR7kFJR4KqpPEvGpdNnnHOdJwvVh6n2CMxhqKZcNqDTzBeJLOEfF
	QBiT4fpRMNzPsFPn1n62BgjAWep+MPH5y0swp8XIbCNqfWNm2EUCm+FNWDn07FF7MBjbWO
	Nda/fhGIcBHeC/nZxLOY3YvByMicGOI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-dnFS-CVAOVmFzjCjP85Rvw-1; Tue, 18 Mar 2025 05:07:29 -0400
X-MC-Unique: dnFS-CVAOVmFzjCjP85Rvw-1
X-Mimecast-MFC-AGG-ID: dnFS-CVAOVmFzjCjP85Rvw_1742288848
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceed237efso24557955e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742288848; x=1742893648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo+g6Y5JYSvYovYBPUfkeXwiqEKq7sb5tQYJYO0t0so=;
        b=He6Uh5bKzZDasmAOFtKBNmJCfCO8wjoQzxiBqS8wdi+tX4sYgq2hLnmtKI88J8+5he
         /7MEtlDT9XDUu+B3Ifa42PJt3Ci6rjgmzwkCg/1bIZXITdDqshONpWNoBIgxEi/yXeah
         ZYcSOz7H7Zzn6HINjWtILanSY9Yzrt8N/5VUUPa4Gyg83m1V+05nC7IeeygfUEx9iVn/
         Ww47jAhqt425KFA8I9rESDNNJQcBQtFYh7kzSHYDq2JKUE65RUe8WRPYpvajRyVXQioA
         QwdmwGOM/RwmaKHAThVkm7MWzsldgVsdF3O/ljlkdeG63J2q3sDCTcbO/EoVjRTcX6JW
         BH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXauAkSL1JSzdVSOwt0syRoNrgApr5EOFpCeMUVODXFxE3EJk2Hyx1nqdAbI5BCyaubtnOkIxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29EBzzNGLXOhc5zLHLZGIjgo83KAznR4nDl3UWsjCbChnBmnR
	iZbuwZkPI+ZxZcP4rh2olC6bId1IJ4gzIN6DvQb5RwZe4eH3FevdOM5gYp/TUO62wBmbihfmGOW
	msD6OFjm/5GES8eKqIqSw/97xa+C1N3bimzVduskT+aj/CAx9nebbUw==
X-Gm-Gg: ASbGncseAYX6GM+MO9wapcGv8rhG0jC3F2gTpcAvQ3TcP4q9VdqzuRkyqDDPuEz4lxz
	rl2gVsyqb6kcqdSDm0xSGySAtWCkoJPiOUNIRV1y2jcAqIpsZDw1J8NroUYm1Rn6a6OESGbyPBF
	OeVj545uqMYAMmBswHdx6FN36IokEd3b3v9cFeDG1eniGkH2ITg1mtZQykL0yoVDAitfUiiVJCA
	rsFbAj27ENK7fS9UK678ZbZO7scAZK9qMS2ZgtFLArbM4q3QJFf3akym0sIYAslpCN+a0ATUu0z
	jDFOamsMUcKTpB4XNygJZM0aEc0h278bja+UF8U254kSGg==
X-Received: by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43d3b9865c2mr14528155e9.9.1742288848126;
        Tue, 18 Mar 2025 02:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAP9H22AYJdj0uDbu4gvGZP7VOolQZFkTSYP0cEoj9MX1qc8v/6DxYVuY8HV3lO4ZO3iRAsw==
X-Received: by 2002:a05:600c:3ca6:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-43d3b9865c2mr14527775e9.9.1742288847761;
        Tue, 18 Mar 2025 02:07:27 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe6a567sm130212415e9.40.2025.03.18.02.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:07:27 -0700 (PDT)
Message-ID: <0a221514-c150-4939-af40-220a7aaac1ec@redhat.com>
Date: Tue, 18 Mar 2025 10:07:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ipv6: sr: factor seg6_hmac_init_algo()'s per-algo
 code into separate function
To: Nicolai Stange <nstange@suse.de>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310165857.3584612-1-nstange@suse.de>
 <20250310165857.3584612-4-nstange@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250310165857.3584612-4-nstange@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/25 5:58 PM, Nicolai Stange wrote:
> In order to prepare for ignoring certain instantiation failures and
> continue with the remaining supported algorithms, factor the per-algo
> initialization code into a separate function:
> - rename seg6_hmac_init_algo() to seg6_hmac_init_algos() and
> - move its per-algo initialization code into a new function,
>   seg6_hmac_init_algo().
> 
> This is a refactoring only, there is no change in behaviour.
> 
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  net/ipv6/seg6_hmac.c | 88 ++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index 2d7a400e074f..85e90d8d8050 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -380,51 +380,61 @@ static void seg6_hmac_free_algo(struct seg6_hmac_algo *algo)
>  	}
>  }
>  
> -static int seg6_hmac_init_algo(void)
> +static int seg6_hmac_init_algo(struct seg6_hmac_algo *algo)
>  {
> -	struct seg6_hmac_algo *algo;
> -	struct crypto_shash *tfm;
> +	struct crypto_shash *tfm, **p_tfm;
>  	struct shash_desc *shash;
> -	int i, alg_count, cpu;
> +	int cpu, shsize;
>  	int ret = -ENOMEM;

Please respect the reverse christmas tree order above.

>  
> +	algo->tfms = alloc_percpu(struct crypto_shash *);
> +	if (!algo->tfms)
> +		goto error_out;

Could be simply:
		return ret;

/P


