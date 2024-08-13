Return-Path: <netdev+bounces-118114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5C79508F1
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF191F244E6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A81A0727;
	Tue, 13 Aug 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sx9yKDBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5819E831
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562603; cv=none; b=VQaNKTPbq7M+1s1CuLzEKpqBCoIsoUQny4vXfjI1jbyM/5MM50GTzqwfQdEn/FSr9dAooLYPUUGpqnGu4HOtxE3FY2I103ZUHt/TC4HPPhU8GIAUcOcLR8ar351Z5Q1aL/HuAMW3ijiiRtA2JS67W9/eEbo/kqaCQz6aCrGnAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562603; c=relaxed/simple;
	bh=WG1lACRR+qCql49N6IQiNP4+jRSBcFOonI9i+h1iUuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4HvemIWVshoyTKNERKzXYSLOCkZcjBXORuwtwN/9Q1U2mti4K6IY/ge/xKaGUfycCewjwuHt2N/iB4d/uqjyFPAvKsT++HW9ZlQFqLArHcCUiOllh0DgFY5CueWnAEzrQuiRSM0ryyRN8JZP5pnTKr1C7IGMfLV45TjC0KUWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sx9yKDBJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-49288fafca9so2079204137.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723562601; x=1724167401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Miefv4SV/AOZaAm2BgeMSlbXp0ABJBsFj1dtUrYnM/A=;
        b=Sx9yKDBJTbqAwGRbxdqlW29FRDmxDOEfKLcyW9nlGPVzYa8VzznCFqlbN3nTuBA0Nw
         aK/2Mu9tTV4A9YTW8bVsLnjEcgKvGXXh13iOHQjNKOw/4T3HLOgQnRCud3gvD9kfzKJI
         GihAdUNGGIyrEvoIVkyB3VmESM5cEt0dbk5JHrn6X5C4HcsqACMwhhJdn9mQ8sBW4OGF
         HC0cFwu+Law2/k9DYaoduteATNcrtPuK45Ni0tUSGCgb5+UA8nbVfwiNcVB9r8nl6Z8Z
         yvBqLgTZtTK8iJmZaUA3l5mw/InMPF3KrxrcamtFgUPbjPKCI7OGE5tqaNknPsujIw/B
         YHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562601; x=1724167401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Miefv4SV/AOZaAm2BgeMSlbXp0ABJBsFj1dtUrYnM/A=;
        b=jmc6cx5g2Bc/48a1bncia8hjV3Q64W5w4TNLRVb8/wgEEesBEvIaBoh8zP/H41Nbi7
         cgYg83Rt2CgUkFxzrgfaTP7EuL34MvuQfuc2rbdr9cVKdde3EVQHOoYwF2yPQC+YpQu2
         dYHnJftA2Xh6MLpqZq3vzehRpL1gyghhtINwXL/UMQj6pdvzBHjywHarc1Jfpl1LGkSG
         DTVowEy5bCBfwa81rSGlBFVQ4qMx+NYOoAjbj+PkaTp4rPuQX2uK+SgFgw4R95UEV3Sq
         ZDND8R1S5Bzc3Jq4//k4s7skLJ7gIINFUGU7roneEz9pekeKptCnsRh/E2a+eoSp3gEN
         sOfw==
X-Forwarded-Encrypted: i=1; AJvYcCWWSHyUPrST1l7AsbScf6hxQ8kGwDY792aPScEhMk8rlwLmTsmzS34XFul+uBUY6FRMCK2W89H8jK0tO1iPCkCmjc3ggmbI
X-Gm-Message-State: AOJu0Ywc4KrcvbLU+jpsn9IDtSv0NjwD9VmKfxhvtjHW0R3a85jMcXjm
	jOYbIMFLM+4nI0ZCaQ85uXTgtfDBI+85SyrsHelzNpWumoVL8ivnTdM+zsq5B9tRjQ5tkIWWKwR
	9XFQF8wxBWxvuacQ9PSmPxyr5WsNtaz9Qyjxw
X-Google-Smtp-Source: AGHT+IGZ5NYyr+slEcp3iBGo7cprjl6N5lyrBgd/zecXjn6nPDpMQ55Q7b4dJ0ZDVS9+asWKV60XLtW3XVNywetb0vc=
X-Received: by 2002:a05:6102:94c:b0:493:b0c2:ad3c with SMTP id
 ada2fe7eead31-497599acb5fmr45036137.22.1723562601012; Tue, 13 Aug 2024
 08:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808230640.1384785-1-quic_subashab@quicinc.com> <40795735-028e-4838-8275-958407f1305d@redhat.com>
In-Reply-To: <40795735-028e-4838-8275-958407f1305d@redhat.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 13 Aug 2024 11:23:02 -0400
Message-ID: <CADVnQy=_x2TJjSZB_zLuvHyNHiWXM1mS_1GG8sDHUTjjh=ga9w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Update window clamping condition
To: Paolo Abeni <pabeni@redhat.com>
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, edumazet@google.com, soheil@google.com, 
	yyd@google.com, ycheng@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, dsahern@kernel.org, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 5:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/9/24 01:06, Subash Abhinov Kasiviswanathan wrote:
> > This patch is based on the discussions between Neal Cardwell and
> > Eric Dumazet in the link
> > https://lore.kernel.org/netdev/20240726204105.1466841-1-quic_subashab@q=
uicinc.com/
> >
> > It was correctly pointed out that tp->window_clamp would not be
> > updated in cases where net.ipv4.tcp_moderate_rcvbuf=3D0 or if
> > (copied <=3D tp->rcvq_space.space). While it is expected for most
> > setups to leave the sysctl enabled, the latter condition may
> > not end up hitting depending on the TCP receive queue size and
> > the pattern of arriving data.
> >
> > The updated check should be hit only on initial MSS update from
> > TCP_MIN_MSS to measured MSS value and subsequently if there was
> > an update to a larger value.
> >
> > Fixes: 05f76b2d634e ("tcp: Adjust clamping window for applications spec=
ifying SO_RCVBUF")
> > Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
> > Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.co=
m>
> > ---

Acked-by: Neal Cardwell <ncardwell@google.com>

> >   net/ipv4/tcp_input.c | 28 ++++++++++++----------------
> >   1 file changed, 12 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e2b9583ed96a..e37488d3453f 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -238,9 +238,14 @@ static void tcp_measure_rcv_mss(struct sock *sk, c=
onst struct sk_buff *skb)
> >                */
> >               if (unlikely(len !=3D icsk->icsk_ack.rcv_mss)) {
> >                       u64 val =3D (u64)skb->len << TCP_RMEM_TO_WIN_SCAL=
E;
> > +                     u8 old_ratio =3D tcp_sk(sk)->scaling_ratio;
> >
> >                       do_div(val, skb->truesize);
> >                       tcp_sk(sk)->scaling_ratio =3D val ? val : 1;
> > +
> > +                     if (old_ratio !=3D tcp_sk(sk)->scaling_ratio)
>
> Should we do this only for sk->sk_userlocks & SOCK_RCVBUF_LOCK ?

No, I'm pretty sure all TCP sockets need to do this, regardless of
their (or sk->sk_userlocks & SOCK_RCVBUF_LOCK) status, because no
matter whether sk->sk_rcvbuf is autotuned or locked to a fixed value,
every socket ideally should have an up-to-date tp->scaling_ratio value
so that it can accurately translate the sk->sk_rcvbuf into a receive
window.

This is basically what I was arguing here:
  https://lore.kernel.org/netdev/CADVnQynKT7QEhm1WksrNQv3BbYhTd=3DwWaxueybP=
BQDPtXbJu-A@mail.gmail.com/

> I think that explicitly checking for an ratio increase would be safer:
> even if len increased I guess the ratio could decrease in some edge
> scenarios.

I agree that the ratio could decrease in some edge scenarios (e.g., if
traffic shifts to arriving via NIC with a less space-efficient buffer
allocation strategy). But, in such scenarios, wouldn't it be better to
have the window clamp to adjust to the correct value?

FWIW, this current version of the patch looks good to me. :-)

Thanks!

neal

