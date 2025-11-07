Return-Path: <netdev+bounces-236851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C267EC40B9A
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAF04F232C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4811F4174;
	Fri,  7 Nov 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrZAY3hi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BC1A3179
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531241; cv=none; b=u2G6lpbve7fu9J9iAXDNSFhM40/JaMonDXLKHPnQaju/IQFhH4M1PEM8BVEFCIWLaxowXPIizClf246n4ajs4tr4RH7mgVJdgBQmPwa5hBtv6+IbofKf6ZbEN6F8OeDICimW0cQ2K+i3CAB2fHUaJdQDic/RpBYhj9a9zU3Afyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531241; c=relaxed/simple;
	bh=erRiwf/H0DJobTUclpjvrIKXSICoT7jx0oxAMM1hJaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+tRXNAwL7Ov1AHqWOPDNjVy7kNpPTRGwV8ieOPtJy8xffITsLKUiRe48K33PXfbLeEGA1OAVzmoHvFOtAfJPV+sbIWGbIZG7p+CfXoyZc73rT1la0CIly9var4FuupDlsg4ytrSyO0yg2AFiqPMqtbQr6UDPG20d8WkbD9zn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrZAY3hi; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8801f4e308dso8607656d6.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762531238; x=1763136038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erRiwf/H0DJobTUclpjvrIKXSICoT7jx0oxAMM1hJaQ=;
        b=CrZAY3hi34ZiAFwEMgQHbE6HqV2NKhEHzEnxaYGRg/15UpvPqCzf+g++W1n9/1+H1C
         KFlU/NUprywgs7bstTdremdmX+5qfvIrjuIEtDMXCv7JVgqozywdT8u/m87LCUm5E8cs
         M2HWZdnNR0aeM4yFpymUkjxQz8kJA41JpsluaaovpuUhhT/Hd5Ap9EPuUJL7773gJ3Oj
         ATFgXj+m9vIfYEByWCiurywHyT0jggUjcdcnbv+wiSNU2zSudpqf6LP02e0V/5LQSTzi
         lYrcYeHb6Ok7Oz5P6YlMTJONF6taY7kBR4YGFu48qV15H2yJQUjmihL3SKHjPXhKc9eB
         kDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531238; x=1763136038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erRiwf/H0DJobTUclpjvrIKXSICoT7jx0oxAMM1hJaQ=;
        b=h/ertIojPBpOP0/fLZgEYc2s3oZ0lubNAB1Tombq0rEen8ZO6CkH5ry/qUk7+/tFS0
         iS+7d/hFdhiX/iJlbmLPA2LBTvlcMhmdAXin2HiJbeJ7FZ1X8XvH1kEoP9lbzx8h2ajU
         Oa1BqfxZFQGxYhv/tvygqM1W+4VXyiGcR5CkR46cmMMv7vjUtMwU5EgpUpf1Od/3S0vi
         1hGEWneT6tk9goV6hYUwD+w7amdhzbu6u/b/9IlHPsXX5K1tojsClGVJWj8FdJumiJ8P
         QLUUUeZ/KAnS1/Q9bxF8XP6J/e+Gp5fl//n+GajIenkmutLkwJDKJpW2wFjcPyvXhSEU
         bGKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuXR2V1txainAGZxeJ1edyVwTHSzk8FGPZSJSzFeq7KAQ6KSQJAxM0HIkEXypueeJi/t3l6jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iXKFj8BMaWEMsZgJVBnoK25++ylBeat85tR4K4e3XEL14FZ0
	PMNycXBVTkbtZufWL9z7W7iwRAntvF1u69LnXoHsPmX+8uoGGooVmfnrqFhNUmpxDZaUvQlyl8i
	ZfwzlD7N9Msy0WLb2l+KQ15y6uSB9kmEaD+ltm8SI
X-Gm-Gg: ASbGncu5Eo8OTWu2pP/CN2bnbwT/OgGkklA4MH7POxFT7qw54VOi8tYRxvwZBrXOUvJ
	VCfaObwTLMwl8hnGjEm+JsKb41ycHwEvNtFhzRUWlmoRD1HoX+VxE7GztWkMJ4FFbsY1wH/FIq/
	hTl6QI5YuM+WVcvHlPvZGlS87bB+Yz0a0fLTRBYSnMaxeFgPJwyvO8o3rue57ggk68njOECKHG7
	tP5BPblSS6kqezk29i16BsXlttpdvHzqfvRioTRpNmjwKwEjfx4Me1GrJWH
X-Google-Smtp-Source: AGHT+IHIuHahaG1lyHk02T9VszvlGamnHMHGuqMQ4MKUDQap3agaUlf0rUwO9dXShO3EqF24cTvgJA2eAKBmGpVnwwk=
X-Received: by 2002:ad4:5d62:0:b0:880:4f0d:e07c with SMTP id
 6a1803df08f44-881766cd890mr48619956d6.30.1762531237958; Fri, 07 Nov 2025
 08:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
 <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
 <CANn89i+fN=Qda_J52dEZGtXbD-hwtVdTQmQGhNW_m_Ys-JFJSA@mail.gmail.com> <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
In-Reply-To: <CAL+tcoBGSvdoHUO6JD2ggxx3zUY=Mgms+wKSp3GkLN-pLO3=RA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 08:00:26 -0800
X-Gm-Features: AWmQ_bmUxjn6W-PH_Q2Gg1QihCKipVhKodHuqRUzwPh6gicr-N4dfCv99dRU9mw
Message-ID: <CANn89iJcWc+Qi7xVcsnLOA1q9qjtqZLL5W4YQg=SND3tX=sLgw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:50=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Nov 7, 2025 at 11:47=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Nov 7, 2025 at 7:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > skb_defer_max value is very conservative, and can be increased
> > > > to avoid too many calls to kick_defer_list_purge().
> > > >
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 128 as
> > > well since the freeing skb happens in the softirq context, which I
> > > came up with when I was doing the optimization for af_xdp. That is
> > > also used to defer freeing skb to obtain some improvement in
> > > performance. I'd like to know your opinion on this, thanks in advance=
!
> >
> > Makes sense. I even had a patch like this in my queue ;)
>
> Great to hear that. Look forward to seeing it soon :)

Oh please go ahead !

