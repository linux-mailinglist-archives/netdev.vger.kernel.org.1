Return-Path: <netdev+bounces-88536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645F8A79D0
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 02:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B2281D27
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78651851;
	Wed, 17 Apr 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgZ0nPuB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108F184D
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313439; cv=none; b=uVeVPW/rbmkxBVxpUwVHgLj9T5NIGL1H30EIo3VRN0HGEnNYNjc23ph82KAa39JhKRoFKjmGP7X/jqglgTybLGSwuucHdZXdRS91qJ7qD0bu82mZWV6JvFPDqRZw4uDwtOkC+tn9E6b+SwfjU3v2U7wUClUqh6kHICX0Ijnsos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313439; c=relaxed/simple;
	bh=fD1xS3pxyv0C4E2Yw5gjdDgbUasv5z3tB5rFWCyn/EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqncCZGtNKrHQ2VNHXVAdcuKOtliT6xICvpv/t4X1Ud9tERrLE5wvrpkcfRB7EOoJwZt87tVfPkc9xcZy4IQL3sET7CV2qg8GeNM0utWB1zYyAHDg/W4JHBaAVJUDbQAQJh0STb0dmz6x6UjYQm42XYdBgy9iR59Ds0DP0DoZ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgZ0nPuB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51a1c8d931so643052166b.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 17:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713313436; x=1713918236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8AqmzwqziZ2g7Ld3+bkACCa3OihuyBx9NIxRA1qRFs=;
        b=ZgZ0nPuBdHvOJCGxgg0lQDv5OsSjGLwp2Ep5Mf0zf2Kg6qLMptnYv1WpLSY+DCF1a5
         T1/jylV5n49sBuEziLiMpRWvu4M1jhmIpbt9YEmQDhtZH0nbw+4tXHziwaGrv6d5dURh
         d/RSI58jFY3LyOv95DMI3Uw2KeWe03Rc9s4J4ZYPj0ZdmD/BqnEWSunaIZJ/9qNI2UPU
         udfx/AcZiCBafazjH4Ub15Vk/gxtKYM/n6F0xzAxmA7nxGZ2QPAmRGuWy7HFM6ksYXYp
         1vE4oPgAhHlvDduxQcUyk+h3MbyaePByB/3sbpwE5CI398B9YG+UeU4WCUHaSbNJuGC9
         jwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713313436; x=1713918236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8AqmzwqziZ2g7Ld3+bkACCa3OihuyBx9NIxRA1qRFs=;
        b=U95jNSLf8Jqg0ish595szXxhzu+y/UoyYk+NgPaJWZN1dDONSAFWb1QIoj62jhoQRj
         be8iEC7K4oxn+BRhyUReL7cBc9rZqRl2h8XptHNTBLzLHGgRPVna+1HPSZgiQDtsjLyE
         Y40e+wBhfcKEaD6oQReSCDuvUATUOllMTg/O0LLGUc8JRs7v1VBkxoiV7X+i87+oXlGS
         rpBe30doSe7hBwoh1YGkKPQ80U9fUgFf7zpD5YCzAyo62eeMF0Lz0FgabPt3pAEnWSri
         umJ5sJXCJguTuFElyDCmTBCGuS4iZGtUA1o74eQGihpxF6BcpgmK/OEHMGcLhrunK3xs
         HmKA==
X-Forwarded-Encrypted: i=1; AJvYcCXfCxDU4+IjmpqSzikkZZ+oZERFkQiiX+//tcHUYbxxjEEUtAlYIoKq7APbzB3Y5w/drNKIBwl2g7OLoC1SmCuBo/WsiGpk
X-Gm-Message-State: AOJu0YxpUltBR62G6axdz61+mDT3Yfcn0dr9QTQHcA+wxc3xKWcw0rDA
	4hEmnazFaz1H9+w9hG2g7oeoBBTHPS3E9gZNk65TaAzz88WsF+TdQpQ80LXJ9SjatOHifY966mb
	0Dzv9lppCSvdqRtwNkGFWoj0EZTo=
X-Google-Smtp-Source: AGHT+IGXtrX2mQnWmbGCoulolkVYLMFHDMnEFiKJMv5OVmxET8frN+SwCd1LGVmwGhZNLHb0R2A35go4M9agLjX+3gg=
X-Received: by 2002:a17:907:c29:b0:a51:9304:19fa with SMTP id
 ga41-20020a1709070c2900b00a51930419famr10442368ejc.70.1713313436199; Tue, 16
 Apr 2024 17:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-5-kerneljasonxing@gmail.com> <CANn89iKbBuEqsjyJ-di3e-cF1zv000YY1HEeYq-Ah5x7nX5ppg@mail.gmail.com>
 <CAL+tcoB=Hr8s+j7Sm8viF-=3aHwhEevZZcpn5ek0RYmNowAtoQ@mail.gmail.com>
 <CAL+tcoDVFtvg6+Kio9frU5W=2e2n7qrCJkitXUxNjsouAG+iGg@mail.gmail.com> <c64c8a6c-2e24-43ca-8ee7-7e15547ed2d1@kernel.org>
In-Reply-To: <c64c8a6c-2e24-43ca-8ee7-7e15547ed2d1@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Apr 2024 08:23:19 +0800
Message-ID: <CAL+tcoArkeBSW=1c=e+JoCr2bRDwUFHcYMAsv84BjKfBsC8pAA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/6] tcp: support rstreason for passive reset
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, dsahern@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthieu,

On Wed, Apr 17, 2024 at 4:23=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Jason,
>
> 16 Apr 2024 14:25:13 Jason Xing <kerneljasonxing@gmail.com>:
>
> > On Tue, Apr 16, 2024 at 3:45=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >>
> >> On Tue, Apr 16, 2024 at 2:34=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> >>>
> >>> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> >>>>
> >>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>
> >>>> Reuse the dropreason logic to show the exact reason of tcp reset,
> >>>> so we don't need to implement those duplicated reset reasons.
> >>>> This patch replaces all the prior NOT_SPECIFIED reasons.
> >>>>
> >>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>> ---
> >>>> net/ipv4/tcp_ipv4.c | 8 ++++----
> >>>> net/ipv6/tcp_ipv6.c | 8 ++++----
> >>>> 2 files changed, 8 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> >>>> index 441134aebc51..863397c2a47b 100644
> >>>> --- a/net/ipv4/tcp_ipv4.c
> >>>> +++ b/net/ipv4/tcp_ipv4.c
> >>>> @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >>>>         return 0;
> >>>>
> >>>> reset:
> >>>> -       tcp_v4_send_reset(rsk, skb, SK_RST_REASON_NOT_SPECIFIED);
> >>>> +       tcp_v4_send_reset(rsk, skb, (u32)reason);
> >>>> discard:
> >>>>         kfree_skb_reason(skb, reason);
> >>>>         /* Be careful here. If this function gets more complicated a=
nd
> >>>> @@ -2278,7 +2278,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >>>>                 } else {
> >>>>                         drop_reason =3D tcp_child_process(sk, nsk, s=
kb);
> >>>>                         if (drop_reason) {
> >>>> -                               tcp_v4_send_reset(nsk, skb, SK_RST_R=
EASON_NOT_SPECIFIED);
> >>>> +                               tcp_v4_send_reset(nsk, skb, (u32)dro=
p_reason);
> >>>
> >>> Are all these casts really needed ?
> >>
> >> Not really. If without, the compiler wouldn't complain about it.
> >
> > The truth is mptcp CI treats it as an error (see link[1]) when I
> > submitted the V5 patchset but my machine works well. I wonder whether
> > I should not remove all the casts or ignore the warnings?
>
> Please do not ignore the warnings, they are not specific to the
> MPTCP CI, they are also visible on the Netdev CI, and avoidable:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20240416114003.62110=
-5-kerneljasonxing@gmail.com/

Thanks for the information. Will add back the casts in V6 soon :)

Thanks,
Jason

