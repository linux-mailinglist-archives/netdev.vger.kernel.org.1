Return-Path: <netdev+bounces-173468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77FA591EB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0937A3D40
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6B227EB1;
	Mon, 10 Mar 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRG5z+v9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD4227E81
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603841; cv=none; b=W2bNOmKb6cBdVOTvBN1QAT2jHE2qL9u3jPklOdKZ4g5okLeP7wWC6Dn2DHPQOByt2appKxQCFSXnq0iOLFeSSdZusNe80RlorUCuJqGwLx0WiYizORnI4V/EwdgZDmd76BP6rfvjG2AvhlaJ17fT4vf3Ygtn1TslnqESNFQ1PJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603841; c=relaxed/simple;
	bh=8Ke5r5EWzcOxUSC+3fnaQfDYZktH68rkRSOJseUUTRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=negSrqMs3GnzmalzGwqe7q5RdZq+G1qHVYHNSn6TacHUoSgpWEwcBwSCS73DJiOd2sSYslF1CiGTSEU9jz5bn9rScyzfhARXrdpR5i6GilkSA+IbUwoiFQKtZySMk2ehqkqSr0UdXI4sMVfU0jM+84CN/Wg9XH+nSz+mWOb8bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRG5z+v9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741603836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8MDkm0T3YtIhnU9EfRl2HAFi+SIIpJRBoztoRpFsoLM=;
	b=iRG5z+v9FpKfZRJqO/CraQdhEweidtPb5y5QrnaDJXAWyZyeTXdTZdGXrvPb5mkDdwTsmj
	Vglr8JThxNEZMf6uTy0csU+eq3zKcGACUS661R6CGndGbahATkU9pOmuy8HlnHC9klsoV5
	OV1dIGCBfuuQisSnCc0ErTN0ergdask=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-cwY9sPzTPFmQTOXzDA1-0g-1; Mon, 10 Mar 2025 06:50:32 -0400
X-MC-Unique: cwY9sPzTPFmQTOXzDA1-0g-1
X-Mimecast-MFC-AGG-ID: cwY9sPzTPFmQTOXzDA1-0g_1741603831
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac21697a8ebso335155266b.1
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 03:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603831; x=1742208631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MDkm0T3YtIhnU9EfRl2HAFi+SIIpJRBoztoRpFsoLM=;
        b=vaoL22fcO4+RczN+qGq164X/oy57JVoG1cx/B3JqOOQ/2UO1mEVSwmjag+AQQfLDvY
         LZ7nwkulmV3aOxQlbFlP1WBYUfF393plgnxImLRbQu39SJfjtWdQ3FXdWF30aLCjmpdd
         ZVRgJt3OgRk0QFjDeZJ4bCbo9Z2YMxhaPKaSFDvRFNbG8MUQz4M7j0lhdmPXXs8oHwTT
         mX7D4QicaVmcN7U5+UNgbTQ2jFGBGjMXeSoKYPh/L5tafXI0n+7QIQmicWP5TYeA/XvP
         iPbi6lZqZbUHA3lYV5vbIZ8OeRDlcLl7Tc+WHnDC0Fn9CBVmC7pNhp24ajwwiQxY9H0A
         i8tw==
X-Gm-Message-State: AOJu0Yz7sG9a2qS3zLThdXEBgwark+cvfAnQNOy4ZSpMu/8tuSjF8fDs
	WYzcjy0bB/MFcNy2oia452y68TizHdEqnJrW6ZCK8/JH3LiKIp+R4R6iftjJDvE+NZh5X3bJSDt
	nCisN3x50nCU3xg/LdMo4wj4kT6YNxKmxI8K2Bh0OR4iRcUCUkLJ35ojptP2rPQ==
X-Gm-Gg: ASbGnctsRSCYFIU9xdZfGIkFndAuZcU2DVSgJejPsj8eOMwOtI/oHaMXukQ2AOYwwMS
	kZZC2q83BqDO1Sj+teG+qDN+LFBv1dpDGVgSY0wyPNBGZHe7yDsS7nbArAB87ZsxjP9Ep7Altzf
	ZnztE1pN+DsA96iZG0kswoN8ENy2UyRFRJOkEdqglQWXynMjECq9XURnc7V+/K75lSK8BCz9Hla
	obwG6IIy2fO0IG4kU+BO53NaS7IrAdc0mwzbM7p6bX51BmbN/h4FcS2ldQTJjvoxvT1Bm8rLRMh
	9xcxmnyLghTpaC6+9i2/+8UV3YnQdDw3qYqwJJn7XUxz71Jtlzw5zR3rsk+kfs0=
X-Received: by 2002:a17:906:d552:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ac252a866b6mr1232132166b.26.1741603830851;
        Mon, 10 Mar 2025 03:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGADYNhHzwZIzPXp6bWzsZ5qWlfyUFSyr/MLaLS1nArAA9uovbFqyO+deUUGlUpnOt+OH1Vww==
X-Received: by 2002:a17:906:d552:b0:ac1:ea29:4e63 with SMTP id a640c23a62f3a-ac252a866b6mr1232129566b.26.1741603830418;
        Mon, 10 Mar 2025 03:50:30 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485bf3sm755327266b.63.2025.03.10.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:50:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:50:28 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: arthur@arthurfabre.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com,
	hawk@kernel.org, yan@cloudflare.com, jbrandeburg@cloudflare.com,
	thoiland@redhat.com, lbiancon@redhat.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next 05/20] trait: Replace memcpy calls with
 inline copies
Message-ID: <Z87D9GblwWBZjwE-@lore-desk>
References: <20250305-afabre-traits-010-rfc2-v1-0-d0ecfb869797@cloudflare.com>
 <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8LdxVSwL0xr9PrwX"
Content-Disposition: inline
In-Reply-To: <20250305-afabre-traits-010-rfc2-v1-5-d0ecfb869797@cloudflare.com>


--8LdxVSwL0xr9PrwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Arthur Fabre <afabre@cloudflare.com>
>=20
> When copying trait values to or from the caller, the size isn't a
> constant so memcpy() ends up being a function call.
>=20
> Replace it with an inline implementation that only handles the sizes we
> support.
>=20
> We store values "packed", so they won't necessarily be 4 or 8 byte
> aligned.
>=20
> Setting and getting traits is roughly ~40% faster.

Nice! I guess in a formal series this patch can be squashed with patch 1/20
(adding some comments).

Regards,
Lorenzo

>=20
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---
>  include/net/trait.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/trait.h b/include/net/trait.h
> index 536b8a17dbbc091b4d1a4d7b4b21c1e36adea86a..d4581a877bd57a32e2ad03214=
7c906764d6d37f8 100644
> --- a/include/net/trait.h
> +++ b/include/net/trait.h
> @@ -7,6 +7,7 @@
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include <linux/bitops.h>
> +#include <linux/unaligned.h>
> =20
>  /* Traits are a very limited KV store, with:
>   * - 64 keys (0-63).
> @@ -145,23 +146,23 @@ int trait_set(void *traits, void *hard_end, u64 key=
, const void *val, u64 len, u
>  			memmove(traits + off + len, traits + off, traits_size(traits) - off);
>  	}
> =20
> -	/* Set our value. */
> -	memcpy(traits + off, val, len);
> -
> -	/* Store our length in header. */
>  	u64 encode_len =3D 0;
> -
>  	switch (len) {
>  	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)(traits + off) =3D *(u16 *)val;
>  		encode_len =3D 1;
>  		break;
>  	case 4:
> +		put_unaligned(*(u32 *)val, (u32 *)(traits + off));
>  		encode_len =3D 2;
>  		break;
>  	case 8:
> +		put_unaligned(*(u64 *)val, (u64 *)(traits + off));
>  		encode_len =3D 3;
>  		break;
>  	}
> +
>  	h->high |=3D (encode_len >> 1) << key;
>  	h->low |=3D (encode_len & 1) << key;
>  	return 0;
> @@ -201,7 +202,19 @@ int trait_get(void *traits, u64 key, void *val, u64 =
val_len)
>  	if (real_len > val_len)
>  		return -ENOSPC;
> =20
> -	memcpy(val, traits + off, real_len);
> +	switch (real_len) {
> +	case 2:
> +		/* Values are least two bytes, so they'll be two byte aligned */
> +		*(u16 *)val =3D *(u16 *)(traits + off);
> +		break;
> +	case 4:
> +		*(u32 *)val =3D get_unaligned((u32 *)(traits + off));
> +		break;
> +	case 8:
> +		*(u64 *)val =3D get_unaligned((u64 *)(traits + off));
> +		break;
> +	}
> +
>  	return real_len;
>  }
> =20
>=20
> --=20
> 2.43.0
>=20
>=20

--8LdxVSwL0xr9PrwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87D9AAKCRA6cBh0uS2t
rKiHAP4ig6AB4OYPje30z4tiswFLGKvRQKjJfOWR/9sexp8ODgEA3c2LJVAALxka
vA6BEzSCv3QLZX1Pd1LJJjsBU766WAQ=
=iMCa
-----END PGP SIGNATURE-----

--8LdxVSwL0xr9PrwX--


