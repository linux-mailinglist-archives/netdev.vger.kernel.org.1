Return-Path: <netdev+bounces-193582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB6AC49A6
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42330170E75
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2222655B;
	Tue, 27 May 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJJeJXzs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEC22A4D8
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332367; cv=none; b=K3kq0x+kIaVoIO8Pi7YxFWfblTMCcPrKbiAJoES04fA0T8b3eb0CmRHHnJuxe4kjiDCM/fc9wyiQp5hN3JdFEKvrqTiSIf1gich1UWKQuw+CgmKPvN9P51LM0iBSkqTYJ4Qss6hZOoejg4EUxRN1Qr9Vv72yRrDO/snHB66p2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332367; c=relaxed/simple;
	bh=qw2GQkeeIzLG3xGCKSEEhPdpbiheGul2TtZ2WVSNqQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQArNMu2c0QYuvGiZNa2ZjDKTv2NfiJsTXGtjhi7GVyIEBNTFu93GADhdimKdZN7Iu2ZWguj71hIOa71Z6E0xwvsFGk6oc6h6LUOKvYt0KW/16YWkQHEi27OWszOYp5C9L2xtax6upjMLHyXcmv7W9Y3BW5XE49fV4B79XfGe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJJeJXzs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748332365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxOeHEx725HLRHiV81cg5rWLcCbolT3s1LsCnjE9wGo=;
	b=LJJeJXzse6hFFXGjpyGwrXFEnRLD4dqy6cknlDShyI6xrUTuTMv57WAvivt9qHlvo0gCe+
	qFQW+6FNGGBcOWE2rcnwDM2MuOuk8yrdaCJiFnmhhc+YZJM5p2+Xx17f7h/REqV9EPso9c
	hnSjJYxyFBfkYaoTxIhN8I61kqTpmX8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-b14wBGEQPk6xiMfk2G3S_g-1; Tue, 27 May 2025 03:52:42 -0400
X-MC-Unique: b14wBGEQPk6xiMfk2G3S_g-1
X-Mimecast-MFC-AGG-ID: b14wBGEQPk6xiMfk2G3S_g_1748332362
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442dc6f0138so14323795e9.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332361; x=1748937161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxOeHEx725HLRHiV81cg5rWLcCbolT3s1LsCnjE9wGo=;
        b=NnaDSEww13Wvbu5mUxHgOso+XJ3Etiob2RnJhl02kqkYwUE1v0fhwT0f/qHyEK/u8l
         tImSdawCE91jjD/5uD0a4uudd2uU4NbanNHcKiqVY3/PDyh3Bol9dAyQI+w8BNoL2zVq
         oU0fzskas9g7qnaKLoINq3wBBCtLmfbcEG8gHdkDKGHEbeuKQOlteV23Ih9lvqfUgtXz
         orTfMwszNTR5GYcS3a9xSNV1NVopbwgCAa0WyYczrQ/4xDm3C14uNSbjT9MBs8BHmmE3
         nd307NYs4BJVogz7pv1VBtskrwWGTdlG6NJj3cpeaEqZXdOwtMb1PXhM6mIviRihnEeF
         Mf+g==
X-Gm-Message-State: AOJu0YxYZNyY+4ZKS/bkbtB9zcAv0IB25yop6JzYDcuTKbRKTAP2i7td
	dSi8fGlw+/erKILmG20TDO2YEJW2ap+fd1Pdq3QQ/tnvYmzIlUxGskVIMFIsRsFXDvqqMRF9z4G
	JUAnH7rY3CHCzwvvRCwUamFxgBtT/dL/oUi65T1CXFoE5710SESxCivxGMA==
X-Gm-Gg: ASbGncuW9l6C5lQMF1bVgKCr9l1SspgrIWvk5S8zi2Bn1nJ2qvdUzzErEYabmGTnPuf
	ZiJ5Ey5usYaBSs3CR6hcXPYQI8UbaMjJHuvgRhVw8xrpMf+OY9/akqp5MJctbQQicvovvDsd/HL
	mkmgQPtWd3cPKvzQFrqPS6hlShL0785r6P4GNfsM5NCWNaTplG+Sti6bgw0jle+Ap7uKdPHx9g7
	h7HWc+yyWgefh7p58pYFAwmqvJM0ea9twTm0xQFSgj1MnRVU+OAS7HQyNtJ45lB8v5W7mtDtqsT
	D5D2IQcGd4e4jXJUrF/DTMhyk6kzOKLSd8WTSdTw1bCBtoY5Co1HxOoJy7M=
X-Received: by 2002:a05:600c:218b:b0:442:f44f:65b with SMTP id 5b1f17b1804b1-44c930191b1mr61322695e9.32.1748332361551;
        Tue, 27 May 2025 00:52:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERmPsXwH93AqVjalbGse8xoO6q6eKOT6A8auaWUx7r1bzC6CSRXPraUYdfDDcfgwx9575l8Q==
X-Received: by 2002:a05:600c:218b:b0:442:f44f:65b with SMTP id 5b1f17b1804b1-44c930191b1mr61322545e9.32.1748332361061;
        Tue, 27 May 2025 00:52:41 -0700 (PDT)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0ab8sm257981885e9.13.2025.05.27.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 00:52:40 -0700 (PDT)
Date: Tue, 27 May 2025 09:52:39 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Marios Makassikis <mmakassikis@freebox.fr>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, mcroce@microsoft.com,
	marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [REPOST PATCH] drivers: net: mvpp2: attempt to refill rx before
 allocating skb
Message-ID: <aDVvR8XXPMEUzztC@lore-desk>
References: <20250515080039.12c47bd3@kernel.org>
 <20250521171021.2978273-2-mmakassikis@freebox.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v5CvJe1XMYPGtXSg"
Content-Disposition: inline
In-Reply-To: <20250521171021.2978273-2-mmakassikis@freebox.fr>


--v5CvJe1XMYPGtXSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> on mvpp2_rx_refill() failure, the freshly allocated skb is freed,
> the rx error counter is incremented and the descriptor currently
> being processed is rearmed through mvpp2_bm_pool_put().
>=20
> the logic is that the system is low on memory so it's not possible
> to allocate both a rx descriptor and an skb, so we might as well
> drop the skb and return the descriptor to the rx pool to avoid
> draining it (and preventing any future packet reception).

Hi Marios,

Can we just run the mvpp2_rx_refill() when the skb has been already
successfully sent to the networking stack? Doing so, if the skb allocation
fails, we will refill the in-flight rx descriptor (the one consumed by the
skb) to the descriptor ring, reducing the pressure on it.
What do you think?

Regards,
Lorenzo

>=20
> the skb freeing is unfortunate, as build_skb() takes ownership
> of the 'data' buffer:
>  - build_skb() calls  __finalize_skb_around() which sets skb->head
>  and skb->data to point to 'data'
>  - dev_free_skb_any() may call skb_free_frag() on skb->head
>=20
> thus, the final mvpp2_bm_pool_put() rearms a descriptor that was
> just freed.
>=20
> call mvpp2_rx_refill() first, so there's no skb to free.
>=20
> incidentally, doing rx refill prior to skb allocation is what is
> done in marvell's mvneta driver for armada 370 (mvneta_rx_hwbm() in
> mvneta.c)
>=20
> Fixes: d6526926de739 ("net: mvpp2: fix memory leak in mvpp2_rx")
> Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index 416a926a8281..e13055ec4483 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4003,6 +4003,12 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  			metasize =3D xdp.data - xdp.data_meta;
>  		}
> =20
> +		err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
> +		if (err) {
> +			netdev_err(port->dev, "failed to refill BM pools\n");
> +			goto err_drop_frame;
> +		}
> +
>  		if (frag_size)
>  			skb =3D build_skb(data, frag_size);
>  		else
> @@ -4021,13 +4027,6 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  					 skb_hwtstamps(skb));
>  		}
> =20
> -		err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
> -		if (err) {
> -			netdev_err(port->dev, "failed to refill BM pools\n");
> -			dev_kfree_skb_any(skb);
> -			goto err_drop_frame;
> -		}
> -
>  		if (pp)
>  			skb_mark_for_recycle(skb);
>  		else
> --=20
> 2.49.0
>=20
>=20

--v5CvJe1XMYPGtXSg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaDVvRwAKCRA6cBh0uS2t
rGAsAP4juNM2CCGS4mpdTIUDn8UqB+xKBicm9RMTsgyg4rfDOwEA0WoSzG9mkygB
rOtmVdC/ktPn36v84yVnmg0MJQxLfAg=
=g54o
-----END PGP SIGNATURE-----

--v5CvJe1XMYPGtXSg--


