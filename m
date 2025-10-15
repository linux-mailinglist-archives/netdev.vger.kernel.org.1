Return-Path: <netdev+bounces-229575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF6BDE6EE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E0C1892A1D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CB324B35;
	Wed, 15 Oct 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LTA0F2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316353233ED
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530579; cv=none; b=b4viBXy5FPgQTH4EJUWMszbNkz+bHgKP8rvX5Yuvu+z/6iN9IMe/+d5yXJkl6+vDZEQaDNpBLuY9Dxi7AEyGtLO4OtZTjNG71sPfOv1oZBVrCCic7Ed1gRjGwh9FhmcXVwvAKyeK5YH6oY+CC7X4EBVkF4jmCl+xLKVQ2kiKnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530579; c=relaxed/simple;
	bh=I6aVCi7f2ZWNY1D07gaI6jMcb/diB37Oic1WNyMWztw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbZN0F0wcMQXvu0PXuvBwlrtcmYc976ieA/hiS9o8TLu27P+Tpr0cRmwzRvGYgtfeULhjhFo9hc/DZK/m0uqk2xU3oPVN2TErrUCOP/vwJ7f29HI6k+ujJfAKovayH0FogjiP4O/xFy+JOsTLJsdYKDpJlCZH5FpbboCtG19JNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LTA0F2H; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e371e3cbfso97119785a.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760530577; x=1761135377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSVCrGyRjQqtVmtsJINep86VKescl2tsr/Drto9ANgM=;
        b=0LTA0F2HDV0/xQ+2jV6qNmRmnMUZqjNSdSfFnuOZ/89uhGZWVk8Aq5Cf8Hg0TuUWfk
         S4IHvLBie7GfBZvhb0YMJE3Ici0RhxoOauxPcHueRGeY8wWgX/UAYnggJAhchWB0P66v
         Z4TRmmHXgYh+QeqR2OKtWMhDKk9PsZx8f8KvaHbBKkK7OkHFWrCH/rpSTuCuhBunF4Bn
         GyznjIoWmOIadro1zVXmHxaFQ9N/Z0Umq7OQBruBvgsrXg8yfy7fBacHw+VixRncX37o
         c9fVNouo6CxPfPpmww8ZWxNgcmpFbHjj4XgYQoum1O9dE3S8pnjLIjFc2aBOwcflWL4g
         3XmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530577; x=1761135377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSVCrGyRjQqtVmtsJINep86VKescl2tsr/Drto9ANgM=;
        b=NOETypF+PnBGN/J2NKWB/yaDAizBbQk3cSvNLnSdEJ485EmrUhY4aZd/KM2Q+Vv32f
         4iNxpjMDjH5Sm3nsh7/46jYX1zmbtOQx3uyj9EvOOrflNFYW5px5HXDMhQlouveuUwuj
         3hipof8iEvj0A5SWMwFGPFl8hbjkmMbHHavFsY+1kGmdurT9nGfwKDErRzv8pHabqLJT
         pCpjFVioubMPDPDMLnaLdqHymv5mYYFUg9ODflvG+nUnUKLjzkdM6vmsixWLPNrMplVd
         LqPXgSibsj7XBQF9FG6mAHlqv3/hzbNIaZZWCEZS7PcMOZDlNOz91lAsD3VeEaqLq0gb
         VxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhoMs92TChsC2cXBLBGbpiRMrmWvdMnJ32ub3a3EE8IzfygI5q2Q09X0euHwMbeC38wfAt+yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bOe8uS2PuNKje9RwSlI/ZAhCqMbtc6ptQkP2zNrHgvuEmfor
	UHCkHm0PBXTjW9fZZs8MU/3Jm4e0zpTikbjIxS6dHhkajBm3nkObkqR5Ls6idujd9qxNVS6B9oa
	j9/b0bDpk2YbiSB43SwHhbNG1h792K5XgipwEN0Ra
X-Gm-Gg: ASbGnctnbfb9ympTiUFJFnsBRZTJtDuWSoph7Oo4oLnpvZHws1KXor2u2wVK7IjcnsA
	iXaUaUrO8q3kZeEFVe3U5MkzSk0qNJsaMGocH16QfeCDp3M6Lw/aUQLu6Q8yjmp2tufxcSma9m3
	NB0nd7/6Zp/jNRvZXPTUJ3KatCcTm7KcumEBEQL5ffNXGgyJau59uE5wWblV7dwfoLPEUIkTVa4
	a8SQYTZ5EwTeVY3wqPNVuPGRQbcYcPemNm7BaYOEZje
X-Google-Smtp-Source: AGHT+IFkGS6Z1JhutnJSzFtyNc82aKsGxa17JQH6riHblKrB7mfs/1jFRZdEolO+GMZLjcebJ5B62jmBCdxsv/e4CVo=
X-Received: by 2002:a05:622a:1884:b0:4b3:ca6b:fbaa with SMTP id
 d75a77b69052e-4e88de77962mr7862241cf.4.1760530576260; Wed, 15 Oct 2025
 05:16:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
In-Reply-To: <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 05:16:05 -0700
X-Gm-Features: AS18NWC_RVw6jQy6Qu61ZE_SAG3BpUKSNbztKU8iU9K3uKPc31XvbmPaTEAXDyg
Message-ID: <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:02=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 14 Oct 2025 17:19:03 +0000
>
> > While stress testing UDP senders on a host with expensive indirect
> > calls, I found cpus processing TX completions where showing
> > a very high cost (20%) in sock_wfree() due to
> > CONFIG_MITIGATION_RETPOLINE=3Dy.
> >
> > Take care of TCP and UDP TX destructors and use INDIRECT_CALL_3() macro=
.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/core/skbuff.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index bc12790017b0..692e3a70e75e 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1136,7 +1136,16 @@ void skb_release_head_state(struct sk_buff *skb)
> >       skb_dst_drop(skb);
> >       if (skb->destructor) {
> >               DEBUG_NET_WARN_ON_ONCE(in_hardirq());
> > -             skb->destructor(skb);
> > +#ifdef CONFIG_INET
> > +             INDIRECT_CALL_3(skb->destructor,
> > +                             tcp_wfree, __sock_wfree, sock_wfree,
> > +                             skb);
> > +#else
> > +             INDIRECT_CALL_1(skb->destructor,
> > +                             sock_wfree,
> > +                             skb);
> > +
> > +#endif
>
> Is it just me or seems like you ignored the suggestion/discussion under
> v1 of this patch...
>

I did not. Please send a patch when you can demonstrate the difference.

We are not going to add all the possible destructors unless there is eviden=
ce.

