Return-Path: <netdev+bounces-187812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6F3AA9B9A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6C3B9DD8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE91B0F31;
	Mon,  5 May 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WqZWPkWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81B7145A05
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470073; cv=none; b=hJ+xfyh3wpjJjCRCQcNmJIVRqEPPtZ01gMuPFkQXzaeAHxGUpltAPYWMuybbpOyJRBW0jfpncpyeEkkqTG/2IbRi22go4ke69rAg5gs+OE5/WeQNto+DSrryNYVgp448c2VewRo+jh6W6sFoajm8rdfeliTufwp1gcD4P1FiPRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470073; c=relaxed/simple;
	bh=f35xCXkIPtjSyej61Fz4uSEIrA1FtQTKKNB9LvCHY/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL6+jBKQ+TappoVFclkwp2Y3Umnt8eIBejqtdMBKvjh1d/ep81/e5BqSMDIhKsRixUDXDLf1yghevzVkmW5JWWV/SXh9609L2sgpuvj5uqjVQyxiO4IIN8lUSxICtEkRnIXw4QNdC/AUe55nUxaRf4KBvtGVrVhUZq3bZFJVO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WqZWPkWH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so7077597a12.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746470070; x=1747074870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BuE1lQBMMZbQNYYS4AqQEUBdOfXRYjb3p7Pf3uSwuh4=;
        b=WqZWPkWH1Pl03DBWiS/nPt6bu29t6ud9nWdcI4UjcvZDZSgC6qZPmeG7I8SlhOVIBH
         O/1j08gp/uQC6QR1PpqMnwzj2kPRhe4QAHOYbdln7yOrPAjiQDxrJd8RpOSn9G15Z1Hj
         tcEi719SKXD1IdHNv4agerLdjpaPLI/QM35PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470070; x=1747074870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuE1lQBMMZbQNYYS4AqQEUBdOfXRYjb3p7Pf3uSwuh4=;
        b=s2vbfk2WoAn/3g4sO9BzC/gZ5UuylyIrWC8dXmDYWVXFRxsXgGAoRjmrc4s4fKU96r
         9gJl6a/JAcbDZVWD8ifazqSgmyzMtR6SubIQQrrdYOA/jtGWwxRMaqceYG5w4e4ij7AM
         VvdQbP+HKBN1U5lFzWCskRz8wddQ1ektMrPGG4CakZrENkwc2L9yC55Eynte9QLB7E8X
         oZJyP91H3BoZGX9TWdnN2e6WmIQNhKIO83dhaRDVzGVwdohjjbw61YEqOJiIDDrBfAX5
         /1PyXHLtvhAIt/jsDjzlGcxMg8PGk0GPKhxwC3kSFpgaGRLa2cx3nlHsFsioXIviScHy
         gePA==
X-Forwarded-Encrypted: i=1; AJvYcCX1mkAfXgfH+krDJ3oPhZjsBBdulTgoFl8q+2Ho/MiDo40ivKGNoQSwgGc/9nEa5HKN9HQngPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/O462HTrz7pTTZwZo8hxJc4Vtm0/agT/R8ciia/V8IgEvRu7
	LYLWSlXjlQKMQAWVA3a0K/qUefR3+kVAYsKLNopZhJE0b5TrKepOd3Z4iZhZYJEHaiqajkltaSQ
	fo+CLp6vWfsn8yrACpawWq8xO+0DcMJIrLl7C
X-Gm-Gg: ASbGnctt1djLFaEAqG+PopMAjHdPmav1InUxtHUw2bwGG/xKl3Fa+0dJJ4Lq5CiZS48
	rMEgCpqEDPVSyPPtn1nis5mxeor+lVNFkLgRbKbJ2jc84RbtxhidX7QqndFqcjWAiDyiHByZjGQ
	dpoz6JXgQ2K8orYZ3D2slmpmI=
X-Google-Smtp-Source: AGHT+IGxgsegXWBsg++J1AAcMROWgdNmIVyvZhH465xtVqudeOYGUHoFrFktI1BzynomNQJ/4tpvFGe5lK0J9W+SWjk=
X-Received: by 2002:a05:6402:26d5:b0:5f4:d5d2:dd47 with SMTP id
 4fb4d7f45d1cf-5fab05c25c7mr7538902a12.25.1746470070055; Mon, 05 May 2025
 11:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
 <20250321211639.3812992-3-michael.chan@broadcom.com> <CANn89i+ps_CozfOyRnKav0_LUmSekJ9ExB5JkDbTAVf_ss_98g@mail.gmail.com>
In-Reply-To: <CANn89i+ps_CozfOyRnKav0_LUmSekJ9ExB5JkDbTAVf_ss_98g@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 5 May 2025 11:34:17 -0700
X-Gm-Features: ATxdqUFMFNFoi3Xs-M94okOM5w-hzcpw7AorzUYBt2n8zD1IC1g4qTG8Ad1ab_I
Message-ID: <CACKFLikb0+uBshZvdNadKTbD0bRrH1XvrTchjuv5Kty0T4+Zsg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Linearize TX SKB if the fragments exceed
 the max
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com, 
	andrew.gospodarek@broadcom.com, osk@google.com, 
	Somnath Kotur <somnath.kotur@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002a8e3a063467c010"

--0000000000002a8e3a063467c010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Fri, Mar 21, 2025 at 2:17=E2=80=AFPM Michael Chan <michael.chan@broadc=
om.com> wrote:
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++++++
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index 158e9789c1f4..2cd79b59cf00 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -485,6 +485,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >         txr =3D &bp->tx_ring[bp->tx_ring_map[i]];
> >         prod =3D txr->tx_prod;
> >
> > +#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
> > +       if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
> > +               netdev_warn_once(dev, "SKB has too many (%d) fragments,=
 max supported is %d.  SKB will be linearized.\n",
> > +                                skb_shinfo(skb)->nr_frags, TX_MAX_FRAG=
S);
> > +               if (skb_linearize(skb)) {
> > +                       dev_kfree_skb_any(skb);
> > +                       dev_core_stats_tx_dropped_inc(dev);
> > +                       return NETDEV_TX_OK;
> > +               }
> > +       }
> > +#endif
>
> Hi Michael
>
> Sorry for the delay. I just saw your patch.
>
> GSO would be more efficient and less likely to fail under memory pressure=
.
>
> Could you test the following patch for me ?
>
> Thanks !

The patch works.  I forced a smaller TX_MAX_FRAGS to easily test it.
But we now skip the warn_once() above since we intercept it earlier.
 Should we add a warn_once() here also?  Thanks.

>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 3a9ffaaf60ae810bf8772b0cad0da45bc4ec9a05..c2a831efa969742711f5afdc7=
b24ba2c450cc595
> 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -13787,6 +13787,10 @@ static netdev_features_t
> bnxt_features_check(struct sk_buff *skb,
>         u8 *l4_proto;
>
>         features =3D vlan_features_check(skb, features);
> +#if MAX_SKB_FRAGS > TX_MAX_FRAGS
> +       if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS)
> +               features &=3D ~NETIF_F_GSO_MASK;
> +#endif
>         switch (vlan_get_protocol(skb)) {
>         case htons(ETH_P_IP):
>                 if (!skb->encapsulation)

--0000000000002a8e3a063467c010
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJgMIIC
XAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJa1HB5aMJ3Pegxkn2/NJriKQT+KIPJs
zpbxCiXqZ+l0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDUw
NTE4MzQzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAHIt50mPAxef09dypme0LEjfh+0tJWv1hx0b8kzWZnnhucltSolUobNPyuheLI7pLaX2
2u00JzRXTBneG8OxDba4P2lfrTMTHiRM9HaaA8+OKQ7qV+ssAgkD+8iwYQEnZ9Lw/54siVNe0Wx6
ZsuZkLgRLooXzKYmO78zJp+uLxwzwv+pGPEVJuNTqB49W+1eSpW90jtuBJ73CJq4WzgKF5lcDgQ6
mRk9qMq3vywzidiCS6TEI/ewFCQQKNDbzgB7CsNnOKfTVsI62hklZ0Dnz6Ucmzn49tsNtQRXiRdK
vjjkjvqN4Tu7lvtUTGwGPi917/t6gKDBK+qrB6IeZjAUpaI=
--0000000000002a8e3a063467c010--

