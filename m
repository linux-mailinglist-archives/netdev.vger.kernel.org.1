Return-Path: <netdev+bounces-137008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4579A3FA7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C20E283D67
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E391F4260;
	Fri, 18 Oct 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CA/pTXyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7A9476
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258223; cv=none; b=pmItUy9WaOYIGJzNJed/FOORL0lzQJnxDb221chEyMepfs/hN842T5rEIih5o86i1EfSez2o6GGQxOxBOdTsoKIiiSjfOa2/QKTCi+1Wu7q87EjTZnp1mWyDaZar1iVV3AXCM+3bizB3kWtnddZ5SP8IUVPDLvvPmNzw+J3dUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258223; c=relaxed/simple;
	bh=p3DTc4O8vInbNPSupIvHX0R53UKRk87fWs5iJU5kRpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHurn65So0AVHrwZUnjlbkULtqUmyVDqGMWbAfOAOH2NVUE8rJVXfx/Z3a/vWCHIQnbHwZURgpvX0FC41oF3Hhs39XFduhO0eQfyYOmJk3JdH7zfqrQhljbC/nPAxH8jBzjtKggyt8fmH8P/nqt6JADx4+GtBJ9BCwi3f9wznGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CA/pTXyo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 40C7A4120C
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1729257717;
	bh=Z5nbekklhuEu06YT3tciT7nnVcLbYF0ZUP641zijrpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=CA/pTXyoTwF+099LHrcaotEcNoaRD5pvIZFoJ9NeLZANeuf+FEOzdck7HvYTB+6On
	 BMhAA3Fjms/QD0tiA5opNYLcBQkwgJZvqycfocyNGhRaPuyDd2UgfHEL7o3z7OM+w9
	 H9QqGZUeIurvENNrtBx8hrkzHjM5I7iwsgoVxNKDteBOTflY/mYKPhRqJgc2tCE4Ql
	 2NjKoPk9Isy9HGlZ2OC6LObCs/1Mgby/Ep3R6RNExpOu9OxEss388rNm5LOODzb4hV
	 SHqUTCDQUSW5sCVVJUUwZ8A4CZNsVqGKTgq8oZMrVzWYzrSGh/Nh1pPsvCRjbQICcs
	 ganH1/EM1/inw==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d47fdbbd6so1163405f8f.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257715; x=1729862515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5nbekklhuEu06YT3tciT7nnVcLbYF0ZUP641zijrpg=;
        b=n3ZDcmTk10s95ONu38S6UjYGhwmLJgOau+u9y+YfEJZAHF9M0CDOp7FQW7siQKPEs3
         Mby3+v62602WGUiBnadYwj7dW2L2/pyN7I9Z1bxlGEuVcZ9SRWHUYl+YI9Gp7voP1qxg
         cSASPMdwZ/nySkCYzbGyF4pBkmrs0c31WPvxkRb+87S6ELxeDu8nLm09TtzapBMuKOBg
         ZCql+e4vUC9IHUNpBrjlOFvfYLC1KlxrgOjJpr3nY0bjHZtcqWtZRB/masbB1HfJuaSN
         x95wzrniG4RMfDMRyyamaZ4TAqOqqVAS+03DTBHP9XNRXcWBAnGNxQ5evv9ZrNhidY1u
         AGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnboFxHLk2ekPQIlilC2CHkkZUJidjTFAp7kW7LSGtV80Mfykmj3WmYcm0oTmlCHH4r9OvR0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOr4qfnM9UCme9QjyrfyQryXHVQnS6Vq8e2Ig++xv6hPxPxIrC
	7hpFleCzGzPsozgyRRaENLoejT9FJpJ3ZBwC2w38uGXh/KzOT3gI1XaSfRlnbe4dTHTF9EtW7yW
	BWKBrrXDECcK3gTuYbD0JgrP8EwEY9P96NAS3bbRzN0K8s77zSWWxeJ0XK5oo/G59j6zG5TJK5E
	SRK2CFQ8DR08TVhMnhywSsMozqpUFn3tYJIjHU4nGvtlC+
X-Received: by 2002:a5d:6801:0:b0:37d:4e59:549a with SMTP id ffacd0b85a97d-37eab6edd1fmr1692937f8f.16.1729257714669;
        Fri, 18 Oct 2024 06:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvqVis6AOhAKHGQ0jRLkpLbn5cO2x+TXp7Dkwd5xfWMTZeQul3F0FXVsek1XUcmw0usZznNWbYyTZlznmrbGs=
X-Received: by 2002:a5d:6801:0:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-37eab6edd1fmr1692913f8f.16.1729257714273; Fri, 18 Oct 2024
 06:21:54 -0700 (PDT)
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
 <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com> <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
In-Reply-To: <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Fri, 18 Oct 2024 15:21:43 +0200
Message-ID: <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
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

> Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> ~0U.
I believe it's the root cause.

My concern is that if we put something like:
+       if (!skb_mac_header_was_set(skb)) {
+               DEBUG_NET_WARN_ON_ONCE(1);
+               skb->mac_len =3D 0;
in skb_reset_mac_len(), it may degrade the RX path a bit.

Catching the bug in xfrm4_remove_tunnel_encap() and
xfrm6_remove_tunnel_encap() (the original patch) is nice because it
won't affect the systems which are not using the xfrm.

Kind Regards,
En-Wei.

On Mon, 14 Oct 2024 at 22:06, En-Wei WU <en-wei.wu@canonical.com> wrote:
>
> Hi, sorry for the late reply.
>
> I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
> and the DEBUG_NET_WARN_ON_ONCE never got triggered.
>
> Thanks.
>
> On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.=
com> wrote:
> > >
> > > Hi,
> > >
> > > I would kindly ask if there is any progress :)
> >
> > Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d=
505869526c566f132
> > 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -2909,9 +2909,19 @@ static inline void
> > skb_reset_inner_headers(struct sk_buff *skb)
> >         skb->inner_transport_header =3D skb->transport_header;
> >  }
> >
> > +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > +{
> > +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > +}
> > +
> >  static inline void skb_reset_mac_len(struct sk_buff *skb)
> >  {
> > -       skb->mac_len =3D skb->network_header - skb->mac_header;
> > +       if (!skb_mac_header_was_set(skb)) {
> > +               DEBUG_NET_WARN_ON_ONCE(1);
> > +               skb->mac_len =3D 0;
> > +       } else {
> > +               skb->mac_len =3D skb->network_header - skb->mac_header;
> > +       }
> >  }
> >
> >  static inline unsigned char *skb_inner_transport_header(const struct s=
k_buff
> > @@ -3014,11 +3024,6 @@ static inline void
> > skb_set_network_header(struct sk_buff *skb, const int offset)
> >         skb->network_header +=3D offset;
> >  }
> >
> > -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> > -{
> > -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> > -}
> > -
> >  static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
> >  {
> >         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> > @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> > sk_buff *skb)
> >
> >  static inline void skb_reset_mac_header(struct sk_buff *skb)
> >  {
> > +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
> >         skb->mac_header =3D skb->data - skb->head;
> >  }
> >
> > @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> > sk_buff *skb, const int offset)
> >  {
> >         skb_reset_mac_header(skb);
> >         skb->mac_header +=3D offset;
> > +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
> >  }
> >
> >  static inline void skb_pop_mac_header(struct sk_buff *skb)

