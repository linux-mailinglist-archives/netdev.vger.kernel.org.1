Return-Path: <netdev+bounces-224128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0412CB810C3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802955466B5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCE2F9C2D;
	Wed, 17 Sep 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="siZDxkuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0242F9C2C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126739; cv=none; b=PPiUEO2cgTNlAYM4ei/Nc9u6xggw407LtYWTwnpzkN/7h7bsB8HNMhlz5ux2BK1gZ7AqDFBwg5nS7EsuLSd5fQY6im6AkOKHa5ArIlADT/jLIlbvEVsg1I/kM/kK3SczK5kF6/iSOAkcgstNW23CpPWc5s7/wJ+RvoSKW3Ya6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126739; c=relaxed/simple;
	bh=Un+9g+L/7ZP91dJ6hB/3ySAumhzF3IwwiYnLRkiB6e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShbnDXKJa5+4actgDIME1fZEWzZV2YOOrYwyvftZR+SLBGRHY1OqL5DaJDvoC2X/YFPH78OMri2S9g9yVJ/WkF+cyugBbfBEiP48Bjr2owQXTbr8NTUj2Bl3S0bvISxO8xDLoURfO8CvmJyCPLDlygp5+rTsIzWKUlHXVofmwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=siZDxkuV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5f3e06ba9so13269251cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758126736; x=1758731536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3qQ65i3nkIDs2RFgW9Rcb5c5Ul+ypuelx66UiyYnHs=;
        b=siZDxkuVOIms7pxsDFEj2/ZXxXO5CGfwQaolFcGGqmy8ESBM5t88IFV3SAhw38t93A
         LppEk8tIJqzAhdOV4mSTDnrD1zPdusaQOieuxMQd96CwOCh1s/vaD3ABTTQxiGwuKgJV
         CW5qwPm3MeISqG3wJVxAt8aKfDAjCEMDoh2zHN9gxyOGOvcBjrritShAp2dYGXOeAVp+
         i8k4Dyiq1rWvVF5NTQwWKa+8jT4Z5FECL6NO2104EitWTFB563kAe7n1DkBAAPJJ6t9R
         /WZ4R4E81yCf1HDMKIwKAuEDlmZk6UYDtG/uggL8m87HgrkhILfmFdDX492Z9BeXj+sN
         R/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126736; x=1758731536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3qQ65i3nkIDs2RFgW9Rcb5c5Ul+ypuelx66UiyYnHs=;
        b=ePxIiheqiBsi610QtGmDp4WeRS1yBp8blkXy+v7w+9T/umjE9uO7eBQxCcoABgBYsx
         D3KySb4kTIHQ26pj3Wj2LXkS1VkOsAzB1VGTTzsen8THPbG7m5Qwl/+o+c27fygfNjsk
         b3XCLtRQUHziJGXqIgvBs17MJ6vQILZgINId4aqNGuZ07rEGhGOQlEVoQ9f85Ry9iX8w
         EUaM+No18Dy7nw2nCyfz4kQu2SNmruQwA0+DBv7Ps2WFGL2Ue2N7iQhfPulbp1fdzwaY
         YUkqdwl8jAexK82SU/qZW9Q8u+2B1xNrmQLnm92LLB4QAgMw2BG305dZTDMIen7kgPee
         Wb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUVD9YoY2f5Pe6I7AkV4utQJ5XuPVtm0AnfuruOodKeXKNE5/JEQlY9lVmVz4SqhXaJvT+3ChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXtzWEC0WNW6Y+ISIi2e2TEZN95GgJIZC9gUKEnF4xeNB9t/E
	Rh8ld/b6mfNPVv52nNJgJk09XZZ6AxzA6E1o5ZJNDzMSb/4Uh5O8gYLhXuXtfnvXxqi33a3NRK8
	cvkZqdiXle1mvPwJt8EloHAEou9zpEcwVmtLaucYH
X-Gm-Gg: ASbGncszOJBE8E0BxU3xPqhXvi2zliSYFNOJjMhFurzTVQcKCHySgEu/hIFv59YGkgi
	xUjnQskbAbAUUnhIcPNH5h9HbVBX8E7pVK+FOyYmPfavzwEsRL3q16tH0gIBvB+wJzFrQ6QVcGP
	ze7dxLAJYasjjX4WhJKRZTZX3pQdB3pfWSIegeqvIHof5ZPJypF9BeQrPJAdSuGPlCmVZW2ZqrV
	5l9K73+PhopXm8jGWs6ORA=
X-Google-Smtp-Source: AGHT+IFcH8AL7+omhrxnSYuSBcV48wAVPmZVShBA7z6yp8ZEXmpgwtoLDrSUsnI4LxjiBY+dlnSYFGO4bD66FBOgQfI=
X-Received: by 2002:a05:622a:610:b0:4b2:8ac4:f098 with SMTP id
 d75a77b69052e-4bdaee61facmr2803961cf.34.1758126736189; Wed, 17 Sep 2025
 09:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-11-edumazet@google.com>
 <513d3647-55a8-45ed-8c61-b7bf61eec9f4@redhat.com>
In-Reply-To: <513d3647-55a8-45ed-8c61-b7bf61eec9f4@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 09:32:05 -0700
X-Gm-Features: AS18NWAXgLSO3DHDiF_55EZxf3ysPsRQPwDW0s91TE7toSwHHBjzVCkdLMy0l-c
Message-ID: <CANn89iJLC=sAS_9=dOaRv0P69+8cG8ZEW5boq9f4JxeXYDeBzQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/10] udp: use skb_attempt_defer_free()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
>
>
> On 9/16/25 6:09 PM, Eric Dumazet wrote:
> > Move skb freeing from udp recvmsg() path to the cpu
> > which allocated/received it, as TCP did in linux-5.17.
> >
> > This increases max thoughput by 20% to 30%, depending
> > on number of BH producers.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 7d1444821ee51a19cd5fd0dd5b8d096104c9283c..0c40426628eb2306b609881=
341a51307c4993871 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1825,6 +1825,13 @@ void skb_consume_udp(struct sock *sk, struct sk_=
buff *skb, int len)
> >       if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset)))
> >               sk_peek_offset_bwd(sk, len);
> >
> > +     if (!skb_shared(skb)) {
> > +             if (unlikely(udp_skb_has_head_state(skb)))
> > +                     skb_release_head_state(skb);
> > +             skb_attempt_defer_free(skb);
> > +             return;
> > +     }
> > +
> >       if (!skb_unref(skb))
> >               return;
>
> What about consolidating the release path with something alternative
> like the following, does the skb_unref()/additional smp_rmb() affects
> performances badly?
>
> Thanks,
>
> Paolo
> ---
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index cc3ce0f762ec..ed2e370ad4de 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1836,7 +1836,7 @@ void skb_consume_udp(struct sock *sk, struct
> sk_buff *skb, int len)
>          */
>         if (unlikely(udp_skb_has_head_state(skb)))
>                 skb_release_head_state(skb);
> -       __consume_stateless_skb(skb);
> +       skb_attempt_defer_free(skb);

This will not work, skb_attempt_defer_free(skb) wants to perform an skb_unr=
ef(),
from skb_defer_free_flush()

while (skb !=3D NULL) {
     next =3D skb->next;
     napi_consume_skb(skb, 1);
     skb =3D next;
}

MSG_PEEK support for UDP adds this complexity, unfortunately.

