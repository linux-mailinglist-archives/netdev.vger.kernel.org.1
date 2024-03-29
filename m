Return-Path: <netdev+bounces-83228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D497F8916AC
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8901E287075
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189039FD1;
	Fri, 29 Mar 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6FuZ+g6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EE535A2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707768; cv=none; b=VHkvOqJSoMbM3WWWNtP1CdoLdL3hr2plIN95xJle39kd2kLoXcoh3d6y0OplapbJRilwxeGBUFQM4WjL65TMZUERaf6x6gA2Jc6qRYeBq6ANXWzxzA6Z1v8QXEFvaJLxj6DeM21VZxLkdPZ3PjUOucid9Q57EnjObU3Su2UYn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707768; c=relaxed/simple;
	bh=+5wXt4+/Em+mn2ApV4CiN73adT99edRHUIRApjU5DLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQPHJ9dKI1pTBfk2mTyroCMCdJw8ZkvYM5KxiOIPLUCaOfaCHNQOO2w1e4c63kGFvlJe2C4u01iyndU/WuhbFezaG8yIyeEU8Pyc8fLlVDdtVf+BR7/h4BuN1jU9cSrp+e8MWU8LwlETK6WyHLukNgjPUL+l83Nemc9tApw0DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6FuZ+g6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711707765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G7GgaWRRqIRLJ0komZKKWyE2KUjwa8x//9k2GvXwNas=;
	b=d6FuZ+g6ZR0JHrU8tC9/7LkmiVamTMWqo8erfE423Zl7KgdR4SXaRyWpm1SdYU/NX/osm1
	fSigV2bV8pnsGxz1pD8xaMo6f9RVzUnRnudknz/CFEq6R5IUnVzFn8puu+FU/cHAZ+11r5
	DgR/oZjkLpwrDELAyw0jGG1fwppLe78=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-BeMEt3jePEiA4mJHPsFtsg-1; Fri, 29 Mar 2024 06:22:44 -0400
X-MC-Unique: BeMEt3jePEiA4mJHPsFtsg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-341c449d7beso399006f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711707763; x=1712312563;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7GgaWRRqIRLJ0komZKKWyE2KUjwa8x//9k2GvXwNas=;
        b=EFjJKkT2nCQ47QEazM1FKUF5uz1X6Ma8j8Muv5TqE0o3EzKybBqsXRDD6z7C1edWGn
         n2IjXk3a5XPTu7usrsRq7bz8jnr9ct211sNt20cXp2JpNQo2KzxibxhivULSzJEtKgBG
         0JhWG6OoyZCKYSrwcHjJhxE6G/Vn7mtiPy/ZToeJiNcrzi1oDfcVrds29KN/ErbD2xj8
         d001RbE53XtQKC6+qXwL8sjEkGs9cEFOF/DpdW0AGdQ6EpPnm1q8yL/6USyAd0Q/Ifuf
         r3m1MP+2nrATIgaUP/8pVpjJsHbo+FOjBfi82kHFb3RiSiHof4iCvmFvqJ+XwcaMpqP2
         gf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXobJE8fNHvukcLAOVw4GJUxi+d/7qkqIDUMEs5UBe8j8Nc2FK15A2n7NxrZAHVvdvCHRy1gZ8wCYPzXk/vnZXYw75iM7SS
X-Gm-Message-State: AOJu0YyivCXrOJCjBIrKFPhPgIL2ldL/rvcJ6etDNo7R+mTRsE7FA+zM
	cfIOACxQ5wFvJFwfHjaPH31/6PlSi6IVZAlT+CM1ELGT7Zj132mzkrPpsuR9XkGFzXg+LvZVmSy
	C/D69SZTrRqqg6Vw4rxmqLnk2KzsBF4GqKsuTwu/2O4snY4dDPKxvrg==
X-Received: by 2002:a05:6000:186a:b0:343:3cf0:c7bd with SMTP id d10-20020a056000186a00b003433cf0c7bdmr463160wri.5.1711707762993;
        Fri, 29 Mar 2024 03:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1HJWPUilcRiVeswO4GRl1/QYO1aFUO27mtxQajBNs+LhuIvcu7TkirN8BE98PRcuB1zmXYA==
X-Received: by 2002:a05:6000:186a:b0:343:3cf0:c7bd with SMTP id d10-20020a056000186a00b003433cf0c7bdmr463148wri.5.1711707762627;
        Fri, 29 Mar 2024 03:22:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-47.dyn.eolo.it. [146.241.249.47])
        by smtp.gmail.com with ESMTPSA id dn2-20020a0560000c0200b0033e25c39ac3sm3844404wrb.80.2024.03.29.03.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:22:42 -0700 (PDT)
Message-ID: <db5a01a1256d4cc5cf418cd6cb5b076fc959ae21.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] udp: avoid calling sock_def_readable() if
 possible
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Date: Fri, 29 Mar 2024 11:22:40 +0100
In-Reply-To: <20240328144032.1864988-4-edumazet@google.com>
References: <20240328144032.1864988-1-edumazet@google.com>
	 <20240328144032.1864988-4-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 14:40 +0000, Eric Dumazet wrote:
> sock_def_readable() is quite expensive (particularly
> when ep_poll_callback() is in the picture).
>=20
> We must call sk->sk_data_ready() when :
>=20
> - receive queue was empty, or
> - SO_PEEK_OFF is enabled on the socket, or
> - sk->sk_data_ready is not sock_def_readable.
>=20
> We still need to call sk_wake_async().
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/udp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index d2fa9755727ce034c2b4bca82bd9e72130d588e6..5dfbe4499c0f89f94af9ee1fb=
64559dd672c1439 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1492,6 +1492,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, str=
uct sk_buff *skb)
>  	struct sk_buff_head *list =3D &sk->sk_receive_queue;
>  	int rmem, err =3D -ENOMEM;
>  	spinlock_t *busy =3D NULL;
> +	bool becomes_readable;
>  	int size, rcvbuf;
> =20
>  	/* Immediately drop when the receive queue is full.
> @@ -1532,12 +1533,19 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
>  	 */
>  	sock_skb_set_dropcount(sk, skb);
> =20
> +	becomes_readable =3D skb_queue_empty(list);
>  	__skb_queue_tail(list, skb);
>  	spin_unlock(&list->lock);
> =20
> -	if (!sock_flag(sk, SOCK_DEAD))
> -		INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
> -
> +	if (!sock_flag(sk, SOCK_DEAD)) {
> +		if (becomes_readable ||
> +		    sk->sk_data_ready !=3D sock_def_readable ||
> +		    READ_ONCE(sk->sk_peek_off) >=3D 0)
> +			INDIRECT_CALL_1(sk->sk_data_ready,
> +					sock_def_readable, sk);
> +		else
> +			sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> +	}

I understood this change showed no performances benefit???

I guess the atomic_add_return() MB was hiding some/most of
sock_def_readable() cost?

Thanks!

Paolo


