Return-Path: <netdev+bounces-145353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8009CF340
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 18:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584111F23B6B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98A1D90A2;
	Fri, 15 Nov 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwS2yo5g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56331D79B7
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692913; cv=none; b=m1yAyZgCOP5PNa3A1TxhdW2bUCpjLMH0Ux6YyxLKCMuChw5R2POrD0CWMkI1wDHx2BHSsoPN9J3eUHx5wtCCNpQ9CthvqCRpsjLBSbHfQiIP9Znjlh0fgtxs3rsL5OGe1nduKHjbsobnvv8BiArB+BK7qNjm/L5Rzs7nW9PzCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692913; c=relaxed/simple;
	bh=his/n+Cf7j+P/5eUq9/zy7V4xxkG7u0tTDOMlYS9NBo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=robeMauSpNKzbulwXCgL8xRiqWxzI7uVAUbIt0yxjMM29aL3znIGf6cLl6RsiALyqh3BM0/Aa013CNoU37VtGCgYqm3kZXT55t2bAqf6VNsaRfcWcYMBYE4OrUf6f/XRhfvbzaA+tu8fR84+yUL83J0lkoduSbCTaGsx6S58Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwS2yo5g; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460d2571033so14075651cf.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731692910; x=1732297710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfbdvu9q8+COLO4nJOJZipPjxGRTN1HcmJai9SXvC3w=;
        b=kwS2yo5gvjjowBCpxUzYXlTgf2nUXNNI0ph8gCpLgGsewOsVjdwgePVPc9Ak5BaHUW
         JNHqT63MzphYGjQYyMGMlnB1ZTCk9y7TDfUTspQrPqVf4wWMIzxQjMavLB+350h8Xm3D
         Jc48IPWanA2v+bKd8y2oUiMaDBfxcJhp5go4D8snChMi5yvPHM995uVa3xZZ29xp3JKP
         TMZv3GVlvWeq+r19yM2iHY4F56iEAnDRRrl9WVZ554YV+1GuJSiR4wu5fnoWedv7xD0P
         s1h3vZ5RneHemz5H+aKNMxoD61FLkAul8+5xD35bWa6wpBod0yQv0sQypAQztQeCYSAR
         mHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692910; x=1732297710;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pfbdvu9q8+COLO4nJOJZipPjxGRTN1HcmJai9SXvC3w=;
        b=QcQYagrMpNXNeKA3Kh40KzLhRSe360/NnS3UvBi2U4wH4b3Ly5AhpeZ5uMsxvl0oNi
         ReVoJpM8pVUD93OOthmK9IXJeQfMTqzSSElKHE68kHYt+eeP58e58z2FQmCjeo59XqqS
         tiaht5jFPGevs4N0+kkcRe+Wm5pfDdU5BEsIp3p7IDSKnlZqJkAomMd1V0qTijIrwSq5
         ouZ9VRIKtvWRSfXqW3P3AlKzAXrTjFKwWxE6aEQX4Xnj0VRvH7m9QwmHmj6rBBRxOD1/
         kd5Bza9zzrhqS6lgd4XHtYWdxAygdNbO1NMLD2XUVeFuMCfy1Ez0x6dVB67SKkeXlSm4
         pp6A==
X-Gm-Message-State: AOJu0YxM+1EUViGP/HWbNXa+eWOhjlnq4JE3ryFv4fCsOzByDhUkDY32
	yzM9n55BeT3qFrXwJe9vMR3pvJN7Jkss1XPQqJpBJHYL0kvvtbqP
X-Google-Smtp-Source: AGHT+IFHrudcKezB7t+nCvyt8ZkHZgLv1QaKIZCoO6tyZDhV8UcZx061tGDBTg1pnwm+X3/e2Dp0PA==
X-Received: by 2002:a05:622a:4b15:b0:460:a3fc:f7b0 with SMTP id d75a77b69052e-46363e39af2mr47974761cf.27.1731692910327;
        Fri, 15 Nov 2024 09:48:30 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c9acaacsm180270785a.56.2024.11.15.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 09:48:29 -0800 (PST)
Date: Fri, 15 Nov 2024 12:48:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 Mike Manning <mmanning@vyatta.att-mail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Ed Santiago <santiago@redhat.com>, 
 Paul Holzinger <pholzing@redhat.com>
Message-ID: <6737896d3b97b_3d5f2c29459@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241114215414.3357873-2-sbrivio@redhat.com>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
 <20241114215414.3357873-2-sbrivio@redhat.com>
Subject: Re: [PATCH RFC net 1/2] datagram: Rehash sockets only if local
 address changed for their family
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stefano Brivio wrote:
> It makes no sense to rehash an IPv4 socket when we change
> sk_v6_rcv_saddr, or to rehash an IPv6 socket as inet_rcv_saddr is set:
> the secondary hash (including the local address) won't change, because
> ipv4_portaddr_hash() and ipv6_portaddr_hash() only take the address
> matching the socket family.

Even if this is correct, it sounds like an optimization.
If so, it belongs in net-next.

Avoid making a fix (to net and eventually stable kernels) conditional
on optimizations that are not suitable for stable cherry-picks.

> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  net/ipv4/datagram.c | 2 +-
>  net/ipv6/datagram.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
> index cc6d0bd7b0a9..d52333e921f3 100644
> --- a/net/ipv4/datagram.c
> +++ b/net/ipv4/datagram.c
> @@ -65,7 +65,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
>  		inet->inet_saddr = fl4->saddr;	/* Update source address */
>  	if (!inet->inet_rcv_saddr) {
>  		inet->inet_rcv_saddr = fl4->saddr;
> -		if (sk->sk_prot->rehash)
> +		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
>  			sk->sk_prot->rehash(sk);

When is sk_family != AF_INET in __ip4_datagram_connect?


>  	}
>  	inet->inet_daddr = fl4->daddr;
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index fff78496803d..5c28a11128c7 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -211,7 +211,7 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
>  		    ipv6_mapped_addr_any(&sk->sk_v6_rcv_saddr)) {
>  			ipv6_addr_set_v4mapped(inet->inet_rcv_saddr,
>  					       &sk->sk_v6_rcv_saddr);
> -			if (sk->sk_prot->rehash)
> +			if (sk->sk_prot->rehash && sk->sk_family == AF_INET6)
>  				sk->sk_prot->rehash(sk);

Even if this is a v4mappedv6 address, sk_family will be AF_INET6.


