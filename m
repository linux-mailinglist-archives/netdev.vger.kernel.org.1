Return-Path: <netdev+bounces-163549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80577A2AABB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F9B1880811
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74D1C7001;
	Thu,  6 Feb 2025 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="EvwlJNc8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A81624C3
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850905; cv=none; b=Id5ZbSUgJInFOeDWSPJtMNGK05NmzYkpKejaXcTN6lz+pme80oSgriuiB4qf+C1AVS1VyC+73DzWM0REUXDuQEySS+I4BoDM5u0w4ITEFSQ1qCsm4nmrShA8N7KObf6DgGY+BTFZbb/bFsIasYnUpntt1koerc4+j8PioKtaMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850905; c=relaxed/simple;
	bh=MYppyGN3b1joEEFsDv5cM76oJFawOM1YBlnKV8wqDV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSHdQcofpMj1Z6H0mnsd1SrPQ+xHC44eOeg6Tmv/FhzQjoKtWpR7S609XPV2YDXpWEOG43E3VQKgoV31jgZj2x4o6MTKN/gG3KA+hC48eFYVFQxfFzGt9uYHcHxGDFaljeFalEs64xbBWB6mGKWJpTzIBUBU/4wyk5k+DY6a5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=EvwlJNc8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-306007227d3so9204411fa.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738850901; x=1739455701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aesyA9mQLnv62usCtFMWdFGxniThJe7uzHkT8xPkntA=;
        b=EvwlJNc8JfW2lR1hxzVTkGwEroDlxtBj3uWZu8BMnc0GA5fdSpmJ5QcMV8N3UCTFOC
         DSRdCGD5q0WikshnUDUbIsH/Hzwo0xZVoqpLD9FBa+XqcQt8A5yBt+wtNKtVOm/lILkc
         cucOhp4wVqW8YHIHPztid8rsUae7BYLCGgkE5mJB9uP8F2NNM0kVcQ4OvTfn5wB1yb95
         2iwAb+fhvK0ooxhtawoUyC9wIDb7YfcOw73IhWMCK2FuuowDTVbQNjorHUKG6aPsuPvu
         Ewx+PPM7Dj7AcfdVtq9I3/q4iusyhVm3lv+lPj2yxTD4ad6YmTRYkntTiDVKakq3NodH
         byLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850901; x=1739455701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aesyA9mQLnv62usCtFMWdFGxniThJe7uzHkT8xPkntA=;
        b=Z0lQFUPWHzr6b0EMJ2ypr0u9Z5MyrxSKmIJPyEHWB5j5NyFMhfJrNscp7lWAcmrC+o
         vJB7zayrZ8Ubr71165Fu+V2ZuyIQjUFqYPpHQ0agGcvqmVMneNQOYgOVH/0HDq0pFR2q
         aBjQd+ce8pKfhBBgRRVXjiIkWFZnK90MTPAgRxsl60lTITJDxKBOoiW/RbhNTNrcSnJK
         cO8B805Y8h+1KKRuny5gB+m9TjjD1UDsRJ2Wz3NPYUG3MG2b7S1ODGDA8N1nFGJ7PMEK
         Cs99hRxjzDS3tybK5rEJkyM9fp/v7HCz7qT17+fwUwaidieXB/j+bLJyr4kklw8wMsCn
         nHgw==
X-Gm-Message-State: AOJu0YxAcQtS1M8BLU7ig4YZZc2rpQhF92L6aeDcA6w734Z1h5neumJ1
	YS+hT9MVGCue12jER5ecbN9F2XYbJ3GCWLqYnrUClyzsD5LXQf3CmV0ClxbIUK2is41JnyK0pa2
	O
X-Gm-Gg: ASbGncsy+lZrohi6+MLi4Mj0A1M9GL07IisWF7JUdzULYXbTmAGBajn8TVT+TcOj20Y
	vZ0BqgWVgWPLxcUl22fAu1ZN88CVh6noE3PxI9WwQzwt4uTMGGNU4veo8XupBUal6tMxcHgINXi
	1KuzDFLhh05BIS8Z5nSbILnAip5cuSXtG3gRdpz+5eqQqzM9hVhUgrOXuEJGYknFk+hglQF22h8
	BqEAyWUq+lzTi+u0/FCGG7rtOsGLLpccUtnXATEKgqIkKazz4ikFv2w22OeBcB4PGLpSJxwaahC
	wc2sUq295i5UpFvla7K9/gVB+6mFR82+MvIU0i3rnf0mW5A=
X-Google-Smtp-Source: AGHT+IG7mwTAsalN+5JYH+Ft4nHwUVITCqo6Tbtcj79yTMc1Ijc0clGlPE0NsngqjaTubXymbiqKnA==
X-Received: by 2002:a05:651c:1992:b0:306:501:4772 with SMTP id 38308e7fff4ca-307cf3875c2mr27094371fa.37.1738850901199;
        Thu, 06 Feb 2025 06:08:21 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f48495sm103542666b.26.2025.02.06.06.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:08:20 -0800 (PST)
Message-ID: <6c13ec89-66dd-4597-9400-8a1282a9c657@blackwall.org>
Date: Thu, 6 Feb 2025 16:08:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] vxlan: Remove unnecessary comments for
 vxlan_rcv() and vxlan_err_lookup()
To: Ted Chen <znscnchen@gmail.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@idosch.org>
References: <20250206140002.116178-1-znscnchen@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250206140002.116178-1-znscnchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 16:00, Ted Chen wrote:
> Remove the two unnecessary comments around vxlan_rcv() and
> vxlan_err_lookup(), which indicate that the callers are from
> net/ipv{4,6}/udp.c. These callers are trivial to find. Additionally, the
> comment for vxlan_rcv() missed that the caller could also be from
> net/ipv6/udp.c.
> 
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
> v2: removed the comments for vxlan_rcv() and vxlan_err_lookup().
>     (Nikolay, Ido)
> v1: https://lore.kernel.org/all/20250205114448.113966-1-znscnchen@gmail.com
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index ece5415f9013..44eba7aa831a 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1670,7 +1670,6 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>  	return err <= 1;
>  }
>  
> -/* Callback from net/ipv4/udp.c to receive packets */
>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct vxlan_vni_node *vninode = NULL;
> @@ -1840,7 +1839,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  	return 0;
>  }
>  
> -/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
>  static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct vxlan_dev *vxlan;

LGTM,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

