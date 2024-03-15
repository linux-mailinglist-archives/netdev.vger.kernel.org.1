Return-Path: <netdev+bounces-80072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD2387CE40
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728EE2815AA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4F28E3C;
	Fri, 15 Mar 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XSRZKClB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E514A98
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510539; cv=none; b=t7KL9l1FnQAOeiEpInssCZ0y6QZ4UnE+NjTILJOzaR//OjFOyEWn0g9trlY/asjGQJUTQUWmsSv1nS7QW0Bdq+ysZ9mHo/hEB2qTqO8yjfoypzAeor4MdtevEXKuYkPsRBfrBk7GyJ56ko/c3SC/yLBHXbtuCmEzkD1ueXg7g0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510539; c=relaxed/simple;
	bh=Ik2WOAkACxLmzL9QXEtEzb/8o7O11BmD4GsGeAkfg4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1P3r06kuB4tUqFd5knT49D/wnYxrX91A6fHZtdTKXP/uzFdUbLcbjqUWYXt1LbZs+6YfyA990Ud4JD1Id4sWtGbcEyWIsd+YTZEMbEiomYN6XclcFVhI0kka9NP0qsJgfXM1iHh/x6A2N9P6V7SNaSNCDyXCYp5dGikWd/71/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XSRZKClB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-414037f37cfso3081255e9.0
        for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1710510536; x=1711115336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bbfg32DxruRxjiS5DMV5w5pA3Tzfj6YrIDyFMS/1lEI=;
        b=XSRZKClBNTBIisA0W6lXuQxjM23Yv6aKjsIrLQ/wTri3pnK1DhbNVBMsOlahY6DASP
         84q051ZgD2OXuvIPHYPvkOpl8r2RH9rDSBPcDJKG92NnZTSezlmH5glY/B+sgR3nC4MM
         Y0xBeE/v2SSZyBC/Pbw+hgioqZvx9UT5+15zrgOFWdvFDgO5BcWbTOGNbecCwZtukqiE
         ig6bHkk2qDlRvU+svtcvTHcqoEN0YC/YNLa8biEuuFGWgSAZsD4u3S8j2CX9odMymu6Q
         MopiTTFNcyMPyrTDl5zuBK9PLoJI5PIEkkD9IVZP+ES28nbQee/jYsrFXMoxsNmQ/2D+
         tQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510536; x=1711115336;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbfg32DxruRxjiS5DMV5w5pA3Tzfj6YrIDyFMS/1lEI=;
        b=atcmp07Nn+MU8/oYZLKwjHIEsjeRvLAKpWJsBviNMHNYY/r0oeRrs+49eEJumbY7CV
         lhuslCDRlAlAhQZ3uI9OcqeeyfCmCUO42hQ0w03QT6UmEMf7CiPxaUlBtCb/BtEcgn7I
         l5iXaIG1AQta6zbcP6EJ2zgRTNb3SbxhFfRibmnGbYDFQdD/uO0yfX7zzvdHw03Qu2/G
         5JoR885B6G5E7/EAHFzsJ8M3laV8yOPGKftwsFMjYjakkbTnKhI30VoE5XxyoyjsW/N0
         ZuAM7Cw1HMsQaaEe0DuKJZbJiT2ukCJWWfrc/ZO5mjCO2RxaC639vG22VKvHRHDU6zOc
         40Og==
X-Gm-Message-State: AOJu0YzKUPNAnyK54b2kUlqV4mmenZ+Wm40yThrj5lPmmvcAxj6n+279
	ZGwAUFFCC64qwP2F2kyxB1WMqDGbVPZ6fIQAqiAtZufGaqcMMzdkywKqhdtO408Nox1q3mRnIxo
	J
X-Google-Smtp-Source: AGHT+IHwWiaMEmsXzxNEKq9ic9f4RIHNQfj2SE+MAr9aZepgjfvIX3cPuMrO22DV3s9HHRNEjT39vQ==
X-Received: by 2002:adf:f20b:0:b0:33e:1ee1:ef92 with SMTP id p11-20020adff20b000000b0033e1ee1ef92mr3493634wro.67.1710510535673;
        Fri, 15 Mar 2024 06:48:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:2c5d:5e13:2999:a734? ([2a01:e0a:b41:c160:2c5d:5e13:2999:a734])
        by smtp.gmail.com with ESMTPSA id w21-20020adf8bd5000000b0033e0ed396bdsm3233982wra.106.2024.03.15.06.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:48:54 -0700 (PDT)
Message-ID: <6cb11d93-fb10-4ca0-a5b2-93513ccefd60@6wind.com>
Date: Fri, 15 Mar 2024 14:48:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ipv4: raw: Fix sending packets from raw sockets via
 IPsec tunnels
Content-Language: en-US
To: Tobias Brunner <tobias@strongswan.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <4f0d0955-8bfc-486e-a44f-0e12af8a403f@strongswan.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <4f0d0955-8bfc-486e-a44f-0e12af8a403f@strongswan.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/03/2024 à 13:25, Tobias Brunner a écrit :
> Since the referenced commit, the xfrm_inner_extract_output() function
> uses the skb's protocol field to determine the address family.  So not
> setting it for IPv4 raw sockets meant that such packets couldn't be
> tunneled via IPsec anymore.
> 
> IPv6 raw sockets are not affected as they already set the protocol since
> 9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
> genereated skbs").
> 
> Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")This is the input part, I presume you were thinking to the output part:
Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")


> Signed-off-by: Tobias Brunner <tobias@strongswan.org>
> ---
>  net/ipv4/raw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 42ac434cfcfa..322e389021c3 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -357,6 +357,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  		goto error;
>  	skb_reserve(skb, hlen);
>  
> +	skb->protocol = htons(ETH_P_IP);
>  	skb->priority = READ_ONCE(sk->sk_priority);
>  	skb->mark = sockc->mark;
>  	skb->tstamp = sockc->transmit_time;
For !ipsec packet, dst_output()/ ip_output() is called. This last function set
skb->protocol to htons(ETH_P_IP).
What about doing the same in xfrm4_output() to avoid missing another path?


Regards,
Nicolas

