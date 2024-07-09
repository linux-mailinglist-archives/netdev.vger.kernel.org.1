Return-Path: <netdev+bounces-110124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0592B074
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CDA1C20C40
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACD13BC30;
	Tue,  9 Jul 2024 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbhpIKN0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7632BD05
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507411; cv=none; b=L4eyMrjs4wa3F/VqHz50UCigpDXYh+e6Bbk0ZppsYO8TmYoz5seE9+yqoN7iBshT8HdazudvH12xH8U4J7pXXYiS4gRL0nok8JHTssOpIKMdaHtIcKT0JQaAxcSzLXDIJyYo6xQjvPLnkdGBG7MzeLHUjRI7z//GZGVXRfI4MxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507411; c=relaxed/simple;
	bh=krJMRwyHuvxUsc/WM0jQ0lstmfJcYEtT9EO5RgtMfTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSvIQC4y0iY4/btzXLgBgDLWaE+0EZXqnHnN/KoKAEwiB2ka4pC3UFi5sXD4hDm2xjqMwIJHwsPHg7IFwMtomlshgTClnziYFy7p5PuG1nmYTsycdhHdzAbQ+0A+tbAiSseiaEK9k2LhHTQoO6GeyFpvfz/XzIC0PavK2D1UcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbhpIKN0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c7d3e8bcso462767466b.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720507408; x=1721112208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmc0f4LcG7MrB8GBVrWkEPg/dPxD0VDSCj6GZR2bPX8=;
        b=pbhpIKN0hnz2n1avrLEXGRy+0k627MWynR4v7rEw/q27Or15/n9/n+Ogt1uX18HXMs
         kXo3OghHiA5UPvb3l+hr0VXymauzbCOGr47zaW9V1wR9e4EbruREQjDVR91JSzjK3c/Q
         hwPJHkmnwuIdCnXoDqY0edHXLlx3rlK3FUFxsOGQwIsXChe1uJ7YPlB33QwOpI/hYm28
         au+D8lCy2i6xS0f06BnrxZBpZ3IUjNa7SGExhw/Z/R2XnXp9YOeOMpsUDZpDn20KJQOM
         m9edqHlLDFCxsx4Nb+TxuMD9fjIagA8hZGzpxCHsTTwTa3Hp8YmYPuz5qnAzjvsdRkfK
         2iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720507408; x=1721112208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmc0f4LcG7MrB8GBVrWkEPg/dPxD0VDSCj6GZR2bPX8=;
        b=BD7HduNJrmdw1dB8uki02aB2jNg5yubdExopgEQbmqxjaKE9C32orZRx1nboGGf28C
         rGG3tLybyul8ReHmio7OlHY1WBxytrEbwkOqF1230YQ+pAWlYXnIzA2eDgiBv8Z96jv7
         /RVLGA2Pnwvl0vy3K3ECHuY7233bEsnmZdANZgWokyOtxwb8NAd8T/0OVwkac2v/SUnp
         vQK80vtGY5L81Ya6+WK9Ox16+OCbFScxMYwhJcEMv+WGrYCEhA34PSfimcIWr3byAnXD
         YQXQS9QIevXZC297eUDJkuWTwJ48joc7uyrlatweWO3SZOV31C23lfw7RM8UV6EkZ1Hm
         Cdmg==
X-Gm-Message-State: AOJu0YzDzSHT4FTXf5wk2j/YZoBmiy/KmV/fnR+atbi20ZowKeadEp2R
	cO7qhzhYF/wRicDl5CeIzPGqyHdVpDXz2O6QoGXfNE4rKxTNYdxKpyRHM9Awz4mdE8iYrVUUa+m
	xuzyngKLczxPgzGzyPpbFoaYCUP2wsSbjjQED
X-Google-Smtp-Source: AGHT+IHRHUTg1JfJuwSdrBECyTgds3MyQMwDxeIReZmX1QJOfx99WMUOnu4d5gn16zJgvv+Qa8h+K5g5od7kgS27rPE=
X-Received: by 2002:a17:907:986f:b0:a77:eb34:3b49 with SMTP id
 a640c23a62f3a-a780b705114mr100211366b.37.1720507407653; Mon, 08 Jul 2024
 23:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702084452.2259237-1-yumike@google.com> <20240702084452.2259237-5-yumike@google.com>
 <ZovNzu58oGJv1plS@gauss3.secunet.de>
In-Reply-To: <ZovNzu58oGJv1plS@gauss3.secunet.de>
From: Mike Yu <yumike@google.com>
Date: Tue, 9 Jul 2024 14:43:11 +0800
Message-ID: <CAHktDpMAms8-Vx=XT-fMJgd1ZXCvvy0wLp0GFw4q3e+ekHtdvQ@mail.gmail.com>
Subject: Re: [PATCH ipsec 4/4] xfrm: Support crypto offload for outbound IPv4
 UDP-encapsulated ESP packet
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fixed the comment style and sent v2 patchset.


Mike

Mike


On Mon, Jul 8, 2024 at 7:30=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Tue, Jul 02, 2024 at 04:44:51PM +0800, Mike Yu wrote:
> > esp_xmit() is already able to handle UDP encapsulation through the call=
 to
> > esp_output_head(). The missing part in esp_xmit() is to correct the out=
er
> > IP header.
> >
> > Test: Enabled both dir=3Din/out IPsec crypto offload, and verified IPv4
> >       UDP-encapsulated ESP packets on both wifi/cellular network
> > Signed-off-by: Mike Yu <yumike@google.com>
> > ---
> >  net/ipv4/esp4.c         |  7 ++++++-
> >  net/ipv4/esp4_offload.c | 14 +++++++++++++-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index 3968d3f98e08..cd4b52e131ce 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -349,6 +349,7 @@ static struct ip_esp_hdr *esp_output_udp_encap(stru=
ct sk_buff *skb,
> >  {
> >       struct udphdr *uh;
> >       unsigned int len;
> > +     struct xfrm_offload *xo =3D xfrm_offload(skb);
> >
> >       len =3D skb->len + esp->tailen - skb_transport_offset(skb);
> >       if (len + sizeof(struct iphdr) > IP_MAX_MTU)
> > @@ -360,7 +361,11 @@ static struct ip_esp_hdr *esp_output_udp_encap(str=
uct sk_buff *skb,
> >       uh->len =3D htons(len);
> >       uh->check =3D 0;
> >
> > -     *skb_mac_header(skb) =3D IPPROTO_UDP;
> > +     // For IPv4 ESP with UDP encapsulation, if xo is not null, the sk=
b is in the crypto offload
> > +     // data path, which means that esp_output_udp_encap is called out=
side of the XFRM stack.
> > +     // In this case, the mac header doesn't point to the IPv4 protoco=
l field, so don't set it.
>
> Please use networking style comments.
>
> > +     if (!xo || encap_type !=3D UDP_ENCAP_ESPINUDP)
> > +             *skb_mac_header(skb) =3D IPPROTO_UDP;
> >
> >       return (struct ip_esp_hdr *)(uh + 1);
> >  }
> > diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
> > index b3271957ad9a..ccfc466ddf6c 100644
> > --- a/net/ipv4/esp4_offload.c
> > +++ b/net/ipv4/esp4_offload.c
> > @@ -264,6 +264,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk=
_buff *skb,  netdev_features_
> >       struct esp_info esp;
> >       bool hw_offload =3D true;
> >       __u32 seq;
> > +     int encap_type =3D 0;
> >
> >       esp.inplace =3D true;
> >
> > @@ -296,8 +297,10 @@ static int esp_xmit(struct xfrm_state *x, struct s=
k_buff *skb,  netdev_features_
> >
> >       esp.esph =3D ip_esp_hdr(skb);
> >
> > +     if (x->encap)
> > +             encap_type =3D x->encap->encap_type;
> >
> > -     if (!hw_offload || !skb_is_gso(skb)) {
> > +     if (!hw_offload || !skb_is_gso(skb) || (hw_offload && encap_type =
=3D=3D UDP_ENCAP_ESPINUDP)) {
> >               esp.nfrags =3D esp_output_head(x, skb, &esp);
> >               if (esp.nfrags < 0)
> >                       return esp.nfrags;
> > @@ -324,6 +327,15 @@ static int esp_xmit(struct xfrm_state *x, struct s=
k_buff *skb,  netdev_features_
> >
> >       esp.seqno =3D cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
> >
> > +     if (hw_offload && encap_type =3D=3D UDP_ENCAP_ESPINUDP) {
> > +             // In the XFRM stack, the encapsulation protocol is set t=
o iphdr->protocol by
> > +             // setting *skb_mac_header(skb) (see esp_output_udp_encap=
()) where skb->mac_header
> > +             // points to iphdr->protocol (see xfrm4_tunnel_encap_add(=
)).
> > +             // However, in esp_xmit(), skb->mac_header doesn't point =
to iphdr->protocol.
> > +             // Therefore, the protocol field needs to be corrected.
>
> Same here.
>

