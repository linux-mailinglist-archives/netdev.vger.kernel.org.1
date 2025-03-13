Return-Path: <netdev+bounces-174567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A1A5F4CE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0006E19C1484
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE223A99E;
	Thu, 13 Mar 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iObXkpO8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2942052
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870000; cv=none; b=RdUi9wpc3yG5K9hhzN3uo1Df4iLxeY+oRMxgWvox0DOs8YEKshotI/E5dm7M2wRHux5N+aH/ywK90NrmWgejg2CwI5bByI/Hg9jWkxGsLbBsuimBjRTQLjduZ5vtH5ShlIwzXfnQv5a7DJDH198rkHgRM0ZBqXPhHxceXu7jy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870000; c=relaxed/simple;
	bh=HZdC8hAhsKO36sqGIobEiWzHKZRWTsiC8wKs3ood/5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QapxdnD50Ic87AAPglleVDvpk810Q1ENPOkNpmAMEhIVBN5ItiqzhqBzILG/5qvqRygHr4DVZReOJle8+Xx5fMUjW7F8kK+rG4HugXJc7jVCEDCTCCT6Kbo2aUoqr3rKUW5oij16/CxLrXw08kQLdgZUARy7TJylxIOECHlx0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iObXkpO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741869997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7j7B6aBzFfMyjq/8d6IwwdGZA5IokJvAlUfMQ9BSyqM=;
	b=iObXkpO8DZJKO4bp4L60PH/edUolYqCuQUOt0rCQ46tG1d/Wapc1y/pHF/O/iMoHXmAkMn
	1t6StlAVGYKiFg2BSdfHFcLGGgkx8Q533aGIftIuGoX71hKK13PV3XpXL74vRr+6nJi4H4
	/jH7DzEgMPFVYKnVmYGe9wAh9ny5HM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-IOxe9GQTOlCRojE3vSu50g-1; Thu, 13 Mar 2025 08:46:36 -0400
X-MC-Unique: IOxe9GQTOlCRojE3vSu50g-1
X-Mimecast-MFC-AGG-ID: IOxe9GQTOlCRojE3vSu50g_1741869995
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so6665855e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 05:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741869995; x=1742474795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7j7B6aBzFfMyjq/8d6IwwdGZA5IokJvAlUfMQ9BSyqM=;
        b=eQ1aLg/R9rOfeXINcDitOSTP8xeSVBRtyJfr+NsO5fpWOt2Z540UPkZ3n0ScyL1TS6
         1znjQzbqv0JXKZgFaSQfv0/SN9TH3r/1AIkay5A+TywV32ufs4wQFT0Q8hMhETsUEhtf
         gCcuQom4I89hFw4kc8oQw/HwnjrEkYIt8Ydf7Klpe2sOJ/hKSQDQyxSLN0CSpaHArWtT
         bFt5x5XONGpI4Eb16suCYL957gbdfpPKkHP+teJGxCo0KsPKxox8q3i+KVxtuVKEyV0l
         au/3CdPXfLqaARQpD4OGZYC6ZL5TRxKh5PAVPe9Uza6mqkXV1FYss0vMzqspuohk0zZK
         1K/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3AFvMpZqoSNIsD1qRZGfpM94JELiYWD0SWFo4UhS9jOoNACrMuJVahwdn7NHJMAwOQsbteAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnJAQ4z1eVvfOsfW9oS/uLm2NM+N3qGBgGidEgbRmFE2SSsnZ
	51bMhUM/XXPsPWoMXA3tr1iTl2wPyGj3K5OMrCZbC3W0qWFHNnnO1s34MHBRUfUwjwucr0DNYov
	yP2tyROhYsT28QZVZnHlktHu8flcfqCm7/0fAXWfwDt0wHUmd1Yn+tw==
X-Gm-Gg: ASbGncvVM5JrxnJrM1IvwslSCa2jtPPY9pYEIqUkenzvTWGK+tHy2P0gsypYJuVOMyy
	O07XY0tkWHqZEcNS/u+gAhT6KZYfy+xcsMVWAdb/shDS72vCLmqdUS+u8fcFSDnSj5vIO8wBQy2
	I5Wg1t1wJ/38sPmbT5wddWWuE0/PVkAGY0aUaqRM/at6/pkN5toorG9IBG0R3UR3sAwtEh7Ob9A
	ky3i63PbngegDGnNo6IrzcFfRCsJSEFK0HAS2U3/5u1i65RNGIZb5Y+TK8jAtAs7MPNMwYvqGvV
	P6mpiVc5uKu4eCpiKrskPE6ridIJ6hVrqsnJg2Vg
X-Received: by 2002:a05:600c:da:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43cf62968b0mr151746475e9.18.1741869995137;
        Thu, 13 Mar 2025 05:46:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJbAMCTiimdishw2fvz9p4/IyKadJ/DP1jaHBUozNYyrf6kKqZC+X2Y2rP8EHjSjMsD8lCoQ==
X-Received: by 2002:a05:600c:da:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-43cf62968b0mr151746205e9.18.1741869994746;
        Thu, 13 Mar 2025 05:46:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318af0sm2019392f8f.73.2025.03.13.05.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:46:34 -0700 (PDT)
Message-ID: <de0104f3-2a2c-44ee-a3e9-8acc927cbfc6@redhat.com>
Date: Thu, 13 Mar 2025 13:46:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/7] net: ipv6: ila: fix lwtunnel_output() loop
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Tom Herbert <tom@herbertland.com>,
 Ido Schimmel <idosch@nvidia.com>
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-6-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311141238.19862-6-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:12 PM, Justin Iurman wrote:
> diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
> index 7d574f5132e2..67f7c7015693 100644
> --- a/net/ipv6/ila/ila_lwt.c
> +++ b/net/ipv6/ila/ila_lwt.c
> @@ -96,6 +96,14 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  		}
>  	}
>  
> +	/* avoid lwtunnel_output() reentry loop when destination is the same
> +	 * after transformation
> +	 */
> +	if (orig_dst->lwtstate == dst->lwtstate) {
> +		dst_release(dst);
> +		return orig_dst->lwtstate->orig_output(net, sk, skb);
> +	}
> +
>  	skb_dst_drop(skb);
>  	skb_dst_set(skb, dst);
>  	return dst_output(net, sk, skb);

Even this pattern is repeated verbatim in patch 3, and I think it should
deserve a shared helper. Also a bit of a pity there are a few variations
that do not fit cleanly a common helper, but I guess there is little to
do about that for 'net'.

Thanks,

Paolo


