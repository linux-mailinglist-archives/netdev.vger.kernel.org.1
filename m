Return-Path: <netdev+bounces-238276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A798AC56DFF
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E713B04B9
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1EE2D5C6C;
	Thu, 13 Nov 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="dGTr30lk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE417555
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030112; cv=none; b=TRE+FMr9TE82uyh8h8f+1zpW0Rwt0ApzLtS3tkf+a/BUvrCjpfBYyKknn7tG9gMP9qtQky9mGFubpoAt1DtBN8MTzCzrQODPJslz7ThFg3r6gI+mHVadQwfSquVwxc6jMufCs+sJASo9g0ikj5S11PK6xDRscxbT1v+ou93m2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030112; c=relaxed/simple;
	bh=fEpGjqSdkbhUo2+Kvfj33lNibTkJptcBr7hRhHJ/nww=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWzaexWuCPPxKA4hfhzs3EluJFS/GFsuwNZh51ouyr/1hpjUIkG1Xn1FQgJxHUr4V6XslchI3CjkssOarqNv4oQ8VAllLq+3vrzohWGZkBhKFtgauRGcjBfmmJaCt7hpINJiVsKokxe+bVHuFpE0iaH9iW6ki3tIKq6W5l8PI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=dGTr30lk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47758595eecso3503845e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1763030108; x=1763634908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VSk9wYIdS49FeqTmP9xwx+9hG8UEAc3l7EBBFVIgArc=;
        b=dGTr30lkxsBtA9Asv7xEmlUhcrLhaAufYttAEKtqFFvMPpiCUbCEcvfsx3Y3SkNLlY
         9k7ZBsNcwJ0aI0lCyG4er/u+2Gv/ZVVa7JqSxjKrGjBThO+/+nrTOwS3fAvCHzLUP53M
         MMWHpf/UDmCt6BR+gWenPuLdj/E5y5eyLLUIigPmUCff09+TO/QGzClxf6i8nXN5k/g4
         x4hKXKHeT5wJwZlpGAok40KxXV36Yta5TfOgHWTkgKJw8lhtMiRHCafjhaQw/O7lRFgv
         HANd+iNlpkxCCBqs5VI1TqFK2GsBQEfvroItfNwBewjRXcI1ZtFdZcsR/+UHR2mP0gDh
         0cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030108; x=1763634908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSk9wYIdS49FeqTmP9xwx+9hG8UEAc3l7EBBFVIgArc=;
        b=ms9gZ+BofDEYJ2J+lyf9hTrg8qUy/AwxvpSSJsD31/SW4AiurFj4xfPEkgmlbFbwsl
         tzMO0qpkBFWQHdqpWS7eph7kJCkDOG10Uj4cCWIsd0B2fNGSAUJzESYXMEcgzEBgHIK5
         O7i2YJ+CX0IQe0fIOYHINeRG2x2eCBd0TmAbjSueDVM/VlHTa9VsKCrDeUp84UBsl8mt
         wFOLsg+bEqhMF0Vbiz55bxp+WZ/SwI03Cro9eQlNeHBKT7iUwkcSoSWOwB+bcYEICyVM
         7UeUtJwVrnytPNHD04jMlpv5ox7AZ7dD1zl8xLTh+XXi1VxubCfncLxDqBJYHwBQYtSo
         DERw==
X-Gm-Message-State: AOJu0YzS1ElljXdg58HfboRR7YYUgVag3Rt6moupGF/BzEUOOopcvRYi
	Y0NJr7i57ULUJJtSuRxfK+L9jI2xErE3EhSORCgCVMnAB1mEZmvyAMiqNxXw3cmyqos=
X-Gm-Gg: ASbGncsrzvCRpJ0+sS2mVsCeZjc4+eMhkDAIQV6ASOuSJE7l/BX557cCNnlK+jUX+ko
	zzZLhLSExRqdLVuqP9UaMSY+kOZ/gNJLvG3pEASQBBqrVPMDPW7vk1b6PvQkqiVDYamnhUBKGql
	CcQ2FSAL5YZQ2ZJ7rQiDW5bmbGwIUpQqLGT3O1+96KwKLOXl5PuUdx5eDqHxgbrf43UgnafsYIF
	2a0FUhkI0aWBEHYbhWzOT4OVkXpM1lGwJTzPxGz47slL33RvyCvc3D/x7qxj/hf44g7LwhWLM7/
	OqrEiIfuJ0BZKu2/WAulvWHvgIzDQhw/qoCd9zu0GIaItI/gkha0GScYJudkizJcvVQEZdWAC9f
	Yve1pRvH2+9g0DzFpoqHEwBMUmj7i2guyFEvJTKyNsXXIH+z0DmGwihnFehNwffeonbx7OTTDaJ
	G3kWNwqm1ja0YmviBbCy1ihY3cK9lZufMqC3dI7Fmf6sXnkFU=
X-Google-Smtp-Source: AGHT+IEEOh1RZmDW1oo/ZlqO1ZCkQsea4l5K+Lo55ZQ/4qH1REua8DEZU+5Q7xd+SbJMYggfuCeUTw==
X-Received: by 2002:a05:600c:1e8c:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-477870b83f4mr55508475e9.23.1763030108320;
        Thu, 13 Nov 2025 02:35:08 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c897bb8sm26460585e9.12.2025.11.13.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:35:08 -0800 (PST)
Message-ID: <7315d47ac4cd7510ad9df7760e04c49bddd92383.camel@mandelbit.com>
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in
 one chunk
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Date: Thu, 13 Nov 2025 11:35:07 +0100
In-Reply-To: <aRS13OqKdhx4aVRo@krikkit>
References: <20251111214744.12479-1-antonio@openvpn.net>
	 <20251111214744.12479-7-antonio@openvpn.net> <aRS13OqKdhx4aVRo@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 17:29 +0100, Sabrina Dubroca wrote:
> 2025-11-11, 22:47:39 +0100, Antonio Quartulli wrote:
> > diff --git a/drivers/net/ovpn/crypto_aead.c
> > b/drivers/net/ovpn/crypto_aead.c
> > index cb6cdf8ec317..9ace27fc130a 100644
> > --- a/drivers/net/ovpn/crypto_aead.c
> > +++ b/drivers/net/ovpn/crypto_aead.c
> > @@ -36,6 +36,105 @@ static int ovpn_aead_encap_overhead(const struct
> > ovpn_crypto_key_slot *ks)
> > =C2=A0		crypto_aead_authsize(ks->encrypt);	/* Auth Tag
> > */
> > =C2=A0}
> > =C2=A0
> > +/*
>=20
> nit: missing a 2nd * to make it kdoc?
>=20

ACK.
>=20

> > + * ovpn_aead_crypto_tmp_size - compute the size of a temporary
> > object containing
> > + *			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 an AEAD request structure wi=
th extra
> > space for SG
> > + *			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and IV.
> > + * @tfm: the AEAD cipher handle
> > + * @nfrags: the number of fragments in the skb
> > + *
> > + * This function calculates the size of a contiguous memory block
> > that includes
> > + * the initialization vector (IV), the AEAD request, and an array
> > of scatterlist
> > + * entries. For alignment considerations, the IV is placed first,
> > followed by
> > + * the request, and then the scatterlist.
> > + * Additional alignment is applied according to the requirements of
> > the
> > + * underlying structures.
> > + *
> > + * Return: the size of the temporary memory that needs to be
> > allocated
> > + */
> > +static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead
> > *tfm,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned int
> > nfrags)
> > +{
> > +	unsigned int len =3D crypto_aead_ivsize(tfm);
> > +
> > +	if (likely(len)) {
>=20
> Is that right?
>=20
> Previously iv was reserved with a constant size (OVPN_NONCE_SIZE), and
> we're always going to write some data into ->iv via
> ovpn_pktid_aead_write, but now we're only reserving the crypto
> algorithm's IV size (which appear to be 12, ie OVPN_NONCE_SIZE, for
> both chachapoly and gcm(aes), so maybe it doesn't matter).

Exactly, I checked and both gcm-aes and chachapoly return an IV size
equal to OVPN_NONCE_SIZE, as you noted. I just thought it wouldn't hurt
to make the function a bit more generic in case we ever support
algorithms without an IV in the future, knowing that OVPN_NONCE_SIZE
matches ivsize for all current cases.

Also, there's a check in ovpn_aead_init to ensure that
crypto_aead_ivsize returns the expected value, so we're covered if
anything changes unexpectedly.

> > @@ -71,13 +171,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer,
> > struct ovpn_crypto_key_slot *ks,
> > =C2=A0	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
> > =C2=A0		return -ENOSPC;
> > =C2=A0
> > -	/* sg may be required by async crypto */
> > -	ovpn_skb_cb(skb)->sg =3D kmalloc(sizeof(*ovpn_skb_cb(skb)-
> > >sg) *
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (nfrags + 2), GFP_ATOMIC);
> > -	if (unlikely(!ovpn_skb_cb(skb)->sg))
> > +	/* allocate temporary memory for iv, sg and req */
> > +	tmp =3D kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt,
> > nfrags),
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_ATOMIC);
> > +	if (unlikely(!tmp))
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > -	sg =3D ovpn_skb_cb(skb)->sg;
> > +	iv =3D ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
> > +	req =3D ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
> > +	sg =3D ovpn_aead_crypto_req_sg(ks->encrypt, req);
> > =C2=A0
> > =C2=A0	/* sg table:
> > =C2=A0	 * 0: op, wire nonce (AD,
> > len=3DOVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
> > @@ -105,13 +207,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer,
> > struct ovpn_crypto_key_slot *ks,
> > =C2=A0	if (unlikely(ret < 0))
> > =C2=A0		return ret;
> > =C2=A0
> > -	/* iv may be required by async crypto */
> > -	ovpn_skb_cb(skb)->iv =3D kmalloc(OVPN_NONCE_SIZE,
> > GFP_ATOMIC);
> > -	if (unlikely(!ovpn_skb_cb(skb)->iv))
> > -		return -ENOMEM;
> > -
> > -	iv =3D ovpn_skb_cb(skb)->iv;
> > -
> > =C2=A0	/* concat 4 bytes packet id and 8 bytes nonce tail into 12
> > bytes
> > =C2=A0	 * nonce
> > =C2=A0	 */
> > @@ -130,11 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer,
> > struct ovpn_crypto_key_slot *ks,
> > =C2=A0	/* AEAD Additional data */
> > =C2=A0	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
> > =C2=A0
> > -	req =3D aead_request_alloc(ks->encrypt, GFP_ATOMIC);
> > -	if (unlikely(!req))
> > -		return -ENOMEM;
> > -
> > -	ovpn_skb_cb(skb)->req =3D req;
> > +	ovpn_skb_cb(skb)->crypto_tmp =3D tmp;
>=20
> That should be done immediately after the allocation, so that any
> failure before this (skb_to_sgvec_nomark, ovpn_pktid_xmit_next) will
> not leak this blob? ovpn_aead_encrypt returns directly and lets
> ovpn_encrypt_post handle the error and free the memory, but only after
> =C2=A0->crypto_tmp has been set.
>=20
> (same thing on the decrypt path)

Right, will fix both paths.

--=20
Ralf Lici
Mandelbit Srl

