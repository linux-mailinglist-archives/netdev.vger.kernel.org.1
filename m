Return-Path: <netdev+bounces-118407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50670951806
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760A31C20EBB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25B219FA7B;
	Wed, 14 Aug 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhER+9k8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41233993
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628826; cv=none; b=Qe97MUhos0m/ZDG3JRTnnu9HmedB7NVhOwARtCBS5sjGqVDogMjBZHf+yJpaYzNGUBSbbKpBKHePwFxsXC1eVCM7FqXvdDfRoJFcUt0KFoLF1ToSGpagrq4KR63Jnl+FnCehRO4zWsivkVm2sbbS3dGMeMZDe9y4PSPKm/C1+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628826; c=relaxed/simple;
	bh=ABY1x6sxl1QCD2ZmbgauMPAw6KjnYOlPdeDmjjCTGLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDyxL7PqFcsApN3DS7LPt/fnrysfW2BKwMiPJZM2E3Wh4VAHP/xsgjBaDAOrnKw/bDIWc05rXgpLEukzgA21vWELHIJ/T3SVgnTDQ2kXgZRzgGtrxgFvc0TZfg5H+HFaXazviPJaoHAunSlF9CYq+1uIOCGoalDSeYt05PW2rZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhER+9k8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723628823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ux9480T4lZwP0+48c2aKFUdxUHos8w8kFYz/XONyms=;
	b=ZhER+9k89dKvrCc0XOYc98M1X+VwK8x9Rr3RacGMVtzF4uo4lgGfvDNYkwlHAs0YfG6W5u
	zgwD2LDMvoDuVDzpwvyKjbUlUcn+GZWCRqMaQFZOywP/b3Ra6m72iF/f7Da+GJ5xgEvK3U
	F5ohF9ijHvgFBSpVwwnfhpHqOi7Ikuk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-hU4dxqcyMUGarhckKPeZ4w-1; Wed, 14 Aug 2024 05:47:02 -0400
X-MC-Unique: hU4dxqcyMUGarhckKPeZ4w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b24ec7bso923795e9.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628821; x=1724233621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ux9480T4lZwP0+48c2aKFUdxUHos8w8kFYz/XONyms=;
        b=BOUwiUQW1HvFbMyfLJdTY7SkQ58wXVA4mkqAMLLotGfKY5fsSKjI7MzrueEgXjBTq4
         ic+2bzoMmJENFv8qfXzl7oke1qt3ebXdA9HJmzG0NtCCPDRBtBianwggmxRa1esftlGd
         b7DLvdg6IajIVPswN6rCeYKwF1c6QdL8WuHbrRh7UEFThJ7Fp/zuYUiDMTHnEmLhzApw
         KI/Ba2CQ5eb1RcipvzjxP5FvH8dyfbtRsaXGUWd1w6Lctdic96ZTDYiilthQV5PQl+nl
         BsW8fDbcMshwTqZNAEZp8ALdoGBZJ9ayLDt0xArhAO0Ii3Fn6jUW1he5H5CbqAyU90rb
         +PkA==
X-Forwarded-Encrypted: i=1; AJvYcCXz/LPU4zh3dkInooLIIiSRLWi34cyXOHTQtE/xl4VREWZ1yGKX75Zb7sC9eRlFTCfJlxbp8/HlB0aq589VjC3xe3/rW8Ks
X-Gm-Message-State: AOJu0Yy/VvNAQJTNbSUFdiS6rZREUXA68XvCDKIYiL5/Rm50r3EJnfcf
	UeiBWahsmohqo3EgkG0itiV/LyJ31jvnC37cHmQ7oQNdGmSA00OvkqoObSxEy0pRapbw9z13cyz
	nXJasKobr+CTSLbA5+m7VWfblh6ekvI7IhOsXxjU1k/4i1wJbSTRxnw==
X-Received: by 2002:a05:6000:1f8b:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3717765359fmr1039505f8f.0.1723628821046;
        Wed, 14 Aug 2024 02:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqkzXd1ASi68pe/ska9Hhzc2dVDAvAYSsmgAIOkieTYIoZ/heQrXE0NQATFRTZWCEP6ZDRA==
X-Received: by 2002:a05:6000:1f8b:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-3717765359fmr1039492f8f.0.1723628820554;
        Wed, 14 Aug 2024 02:47:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c937b6esm12409389f8f.32.2024.08.14.02.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 02:47:00 -0700 (PDT)
Message-ID: <567fc2d7-63bf-4953-a4c0-e4aedfe6e917@redhat.com>
Date: Wed, 14 Aug 2024 11:46:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next v2 1/2] net: refactor common skb header copy
 code for re-use
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Florian Westphal <fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>,
 Simon Horman <horms@kernel.org>, Antony Antony <antony@phenome.org>,
 Christian Hopps <chopps@labn.net>
References: <20240809083500.2822656-1-chopps@chopps.org>
 <20240809083500.2822656-2-chopps@chopps.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809083500.2822656-2-chopps@chopps.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 10:34, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Factor out some common skb header copying code so that it can be re-used
> outside of skbuff.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>   include/linux/skbuff.h | 1 +
>   net/core/skbuff.c      | 8 +++++++-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 29c3ea5b6e93..8626f9a343db 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1374,6 +1374,7 @@ struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);
>   void skb_headers_offset_update(struct sk_buff *skb, int off);
>   int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask);
>   struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t priority);
> +void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old);
>   void skb_copy_header(struct sk_buff *new, const struct sk_buff *old);
>   struct sk_buff *skb_copy(const struct sk_buff *skb, gfp_t priority);
>   struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d1..da5a47d2c9ab 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1515,7 +1515,7 @@ EXPORT_SYMBOL(napi_consume_skb);
>   	BUILD_BUG_ON(offsetof(struct sk_buff, field) !=		\
>   		     offsetof(struct sk_buff, headers.field));	\
>   
> -static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> +void ___copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>   {
>   	new->tstamp		= old->tstamp;
>   	/* We do not copy old->sk */
> @@ -1524,6 +1524,12 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
>   	skb_dst_copy(new, old);
>   	__skb_ext_copy(new, old);
>   	__nf_copy(new, old, false);
> +}
> +EXPORT_SYMBOL_GPL(___copy_skb_header);
> +
> +static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> +{
> +	___copy_skb_header(new, old); >
>   	/* Note : this field could be in the headers group.
>   	 * It is not yet because we do not want to have a 16 bit hole

Could you please point where/how are you going to use this helper? 
factoring out this very core bits of skbuff copy looks quite bug prone - 
and exporting the helper could introduce additional unneeded function 
calls in the core code.

Thanks,

Paolo


