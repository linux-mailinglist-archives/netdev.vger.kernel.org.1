Return-Path: <netdev+bounces-141832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F39BC7A7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660FD282A46
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBD1FEFB8;
	Tue,  5 Nov 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fXZrQQzg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D111C57B2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730793958; cv=none; b=vEUcw3Gluz8buphqTtW2uj+LcqoOowxQZjk2DHVjDb7m/b1CjleiE8aassGTW0olliNZQTsC4oP95TAA2LUsnD5/qkwIoIcEe3+MSjMYuvSJC39NZaMd9QkBj28B3K6yoZNkVpQmgRTXxDvPxL7Kidyqi1BSlU7tv7Ii2FtXcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730793958; c=relaxed/simple;
	bh=YPaHXVAA/YI+D7uTy+xljhnWRnN8Gd/dLo79RfZ+upo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrrzUyTHWsg8sma2wV1bWPlKLibkpS/C17udDY5PsFPlYxayNG1DwA9dRz5DDO7+ajjaBDBcswiBKJXdYihLZuw6PgWI+tHrB/ZdfwNK4Jsi9pkmxg2uzmBBZqNaQOvyGFVVzLc7VWfT4YiWbvdA3Ms3TQhOPHvurDjSFSJheE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fXZrQQzg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6554D3F18D
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730793952;
	bh=ZOwmbvypNY7SJx9qJfB/HL5HYlEP7KynRr9HfRBtRvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=fXZrQQzgkHySctVkAWdpCi7tOIIAIHyqx8hzoB5gFE4BEhrqwtP/6n1P0Pn7KG8Ft
	 IQTYZTaBtOUEN1YyOQif6lZqzP58uMwSVoFidR0v0/zs0dskCP3N6MdIglvNhVnWIe
	 62IA/Ve8vSLy6rNRDNdPvKPxoQoL0V98KPf+TFO/gaaXXwiRjwkJVqxzDLs1L03uaN
	 09qnhwdWOs0u/yWiIa7yzBr07jzYPQgXeeABkrC6u8G70ImGXdS1vI9eTaYmidu5FK
	 dVacJBRkUOxkVECmW3vyTjEVdIFB5yPOPDQ7kPaxEnksf6V3qRp2BjB9SEyTt6naVE
	 nbtE8UMUok94Q==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4314c6ca114so38081265e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 00:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730793952; x=1731398752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOwmbvypNY7SJx9qJfB/HL5HYlEP7KynRr9HfRBtRvU=;
        b=kFEFC3jeg/aORIptiTzttqauqHySmCITCLcG3OK3M/5pEOiT1nYymqJaJRmp10esyX
         IzwI7T+dzixyWmgZZw4aj9f7XbHP3mV4mztTbts12KhGaMeZ1Sh4vrvAUkst1G+Tg/Wo
         n88jV4bFAE3DuTIjQYe9pgwSSBeAsjag2P5ADHQ12GX+yR446DbBRkC2t/3fwqxWBmly
         Dav3kZYTASnILW+TT5RxTw4WR77skzweS/j0oo6UbqdWm0k5U+tAmTbyQ4uKP79+vyGe
         n+80IhnnmsZ7kva8CGoHeipu0wR1NEj9DxmK4X8394i7uf8zuMzTpp9rqYZa+BBJF9wc
         ESrw==
X-Forwarded-Encrypted: i=1; AJvYcCV15g7SJECqXhIpPSeDTP48awxwL47lYd74cz1RVt+dvae6y3EU4vJrQeCCkTD7B8hn0j6fuUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv+aSaFNoMnyiHJS+lM5fcKrsb/vVmEVfQmPns+DchcC+0KWvq
	lDWcum8CP/NuUah8dFrZYhw+/nIO8XmNEJfWQpPSEPRoaqA50rrSq9KapRQILKRsc3kKH3J+Kys
	sw5F4FkRDooDHCipFHuFyhq9WrrG79L51kmN/TrS8NwRRfavxldBktK4NoKqvo0WDNKcgjEu7Ri
	hIBk1uisw5A2eXua4bvZtDb8rwNzrfgKIFmXjtg08PsnfV
X-Received: by 2002:a5d:6c68:0:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-381bea1bfc4mr15826496f8f.45.1730793951682;
        Tue, 05 Nov 2024 00:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX/dSSZILHuK3uVDEXge5/gJUupfGp22dMkdum7U3ygcz4rT9yxy5cRYzjNB2z/aX/ElvjbgmclkkYIl4wslQ=
X-Received: by 2002:a5d:6c68:0:b0:381:b68f:d14b with SMTP id
 ffacd0b85a97d-381bea1bfc4mr15826465f8f.45.1730793951234; Tue, 05 Nov 2024
 00:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com>
 <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
 <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
 <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com> <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
In-Reply-To: <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 5 Nov 2024 16:05:40 +0800
Message-ID: <CAMqyJG2UKG_P5Dbp6t=K98HAhBVHu-iuCrTjUx+NqzUJHTDA0w@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Can I kindly ask if there is any progress?

Thanks,
Regards.

On Fri, 18 Oct 2024 at 21:21, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> > Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> > the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> > ~0U.
> I believe it's the root cause.
>
> My concern is that if we put something like:
> +       if (!skb_mac_header_was_set(skb)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               skb->mac_len =3D 0;
> in skb_reset_mac_len(), it may degrade the RX path a bit.
>
> Catching the bug in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() (the original patch) is nice because it
> won't affect the systems which are not using the xfrm.
>
> Kind Regards,
> En-Wei.
>
> On Mon, 14 Oct 2024 at 22:06, En-Wei WU <en-wei.wu@canonical.com> wrote:
> >
> > Hi, sorry for the late reply.
> >
> > I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
> > and the DEBUG_NET_WARN_ON_ONCE never got triggered.
> >
> > Thanks.
> >
> > On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonica=
l.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I would kindly ask if there is any progress :)
> > >
> > > Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
> > >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d9263=
4d505869526c566f132
> > > 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -2909,9 +2909,19 @@ static inline void
> > > skb_reset_inner_headers(struct sk_buff *skb)
> > >         skb->inner_transport_header =3D skb->transport_header;
> > >  }
> > >
> > > +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > > +{
> > > +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > > +}
> > > +
> > >  static inline void skb_reset_mac_len(struct sk_buff *skb)
> > >  {
> > > -       skb->mac_len =3D skb->network_header - skb->mac_header;
> > > +       if (!skb_mac_header_was_set(skb)) {
> > > +               DEBUG_NET_WARN_ON_ONCE(1);
> > > +               skb->mac_len =3D 0;
> > > +       } else {
> > > +               skb->mac_len =3D skb->network_header - skb->mac_heade=
r;
> > > +       }
> > >  }
> > >
> > >  static inline unsigned char *skb_inner_transport_header(const struct=
 sk_buff
> > > @@ -3014,11 +3024,6 @@ static inline void
> > > skb_set_network_header(struct sk_buff *skb, const int offset)
> > >         skb->network_header +=3D offset;
> > >  }
> > >
> > > -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > > -{
> > > -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > > -}
> > > -
> > >  static inline unsigned char *skb_mac_header(const struct sk_buff *sk=
b)
> > >  {
> > >         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> > > @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> > > sk_buff *skb)
> > >
> > >  static inline void skb_reset_mac_header(struct sk_buff *skb)
> > >  {
> > > +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
> > >         skb->mac_header =3D skb->data - skb->head;
> > >  }
> > >
> > > @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> > > sk_buff *skb, const int offset)
> > >  {
> > >         skb_reset_mac_header(skb);
> > >         skb->mac_header +=3D offset;
> > > +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
> > >  }
> > >
> > >  static inline void skb_pop_mac_header(struct sk_buff *skb)

