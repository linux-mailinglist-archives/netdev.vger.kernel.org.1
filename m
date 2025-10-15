Return-Path: <netdev+bounces-229509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AACBDD1CC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B255352B35
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7B2C3768;
	Wed, 15 Oct 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjwe29+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C62727E2
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513715; cv=none; b=WPSqIq2GEyZl4FpjxDaCThnuAshGYJJyC0jH5puduCWqZ62HallsBICcMicfjcXaVWB5xjov1PlyTyacDXsutC1+6+N4xsFXeEVi+h9mIf4XoJ2zppiJ+k+X69m7z1iuGE8BsV27EinVOYHyRwgMJeAHU34x1V1Bn9UDI2DuoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513715; c=relaxed/simple;
	bh=IFw0y3HFIK1S4mkksxahSnq3lwF6loF4/RY4O+5S2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1ZZlsa7KsmmuLvlKNl4w18RhmIhkf9Q2zwZ64t4m7gTgvlbmyfk+c965Y/iyCbgJwxNhTcZ1LG6tIRQyQQaqFT8ivS6lMQaRh0AGtui/iT0kvcnd6ARo9jgSm+EI5tOE5TA9pxzLxnilliB0hVbXM2NdTQSf97j+5ikjL1VMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjwe29+4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-862cbf9e0c0so788487685a.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760513712; x=1761118512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA3o1cHbuC0FFSVH6LGwTjiyg5Fjt24vDKqsTK1XeKk=;
        b=jjwe29+4qmJsV84FQDy6csUxIAZD0pT0J6kHJC/UbOV0BMdELqMhhAe8ajWGNJUKge
         wmmewbooap7ypZpybealvtsGslHYecWfsW7BSjjKIm3AUy8Qucc/YEJFm74OnZsopEcq
         k5WUsQ7UNCINTVIZe2Ajd+Ca5xZ8PTZP0t47gtyFawr4V15M3LNo8Khy3VgkBPBz9COM
         IeGizAYCHg6qx/MGRgFIBS331Iu4RcdboAnjvweBCY05z3je2ie/FpuXHLGD+ql8HwAF
         Pdp/J0qLu9G3EpII8k3+a46YD42gCvOKn5FcvbX6i7p8AveQBu/ovRRkfoTIi28weK05
         POgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513712; x=1761118512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA3o1cHbuC0FFSVH6LGwTjiyg5Fjt24vDKqsTK1XeKk=;
        b=MpkfTs8G2NSoNoWziFqhR0BQa8DNaSa/ho3dV3Pb8qZ464oBC2VtC2JcdIuxY2nCQt
         JmQ8p0ouggVX3ENlA0rwfrv+Alprzm1j8b0UFqNWPlvFHEvz0bhR4MF4E7rE2dFT/6qX
         lHgqLmqEtb+eddEWqXrPJiAmBgWzzP/jC4HQIVJLXN969L6Gz5w6g8jd32O7qiXRIuGK
         tOCGFM6p9HMe6aL+AZEKosCfUA8Pm7DdEJ7w0abGFLVUa1RCAyFdlT15AiGxC5m2KmPQ
         8uQ71HR46x7nSI75fG/sh4t+/Y+W2pRdcKkjBWC8nGmaeVCG0tXPY9tUzM/lyXxvtSM9
         Gb6A==
X-Forwarded-Encrypted: i=1; AJvYcCXlL++/6oX9ev+ZoQl7zPu0Pd3jnmsnE6FPm96PPyhTb5Wygm5P+E8wSFyA8H/pfM+uF+T4ND0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3HQgix4KYH/RSmRR93O4H5ugFL2AuoiJy99/1xIv8v3Je5oX
	EX2w8COgvWirs6jez6bFWXCJbH/pa6m8T8WsvpHbgRgGyFr3kwt9DkL4C3KqJgMN74oiS0eLdQC
	70kAUcFyG6RlSFjUDjvPWR43G9V8y3Dc=
X-Gm-Gg: ASbGncuD7FoPUDc7TNCB8EbF5Sr5bFAqqVdoBgSSQfHXZIGrbmed5PbPjaM9hXa+/BZ
	oRU3p0W77TlPDfP0g/TekdmU/T+LAu2/FH8U0nwLjCgU3z1EaNwLIkwOK6LC9DItz1xOKSfhXrM
	hvsCEHzIuEKQTD2vKXvZ1rKASfonMH/1OkhrczqrBC8q68hHZDbADGBTipOMD/Ut9AgdfI7YTpF
	4zk9MWxgMpQeDe6CPtx242/Y2KAv016gRQ50ibb4AnwPBTnqOIywag9nU3FtO06DBcp
X-Google-Smtp-Source: AGHT+IEKuviABuf8paTr2eaaeUlS/nUOTJ25Ra9gag22Alb6I0Md3LX7r3aaI+eo4s+XoFak3t65ds9W83VxSzBmJiE=
X-Received: by 2002:a05:620a:f13:b0:812:c6e3:6663 with SMTP id
 af79cd13be357-88350c678bdmr3682430585a.34.1760513711989; Wed, 15 Oct 2025
 00:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
 <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
 <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com> <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com>
In-Reply-To: <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 15:35:00 +0800
X-Gm-Features: AS18NWAHXtYVOjzGMsZVpeCyed9cBDk9Qc-GpblFolpgSoSOaZV2-smc5Nm5TAA
Message-ID: <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:

> > >
> > > Tell them they are wrong.
> >
> > Well, we checked Qualcomm and MTK, and it seems both set these values
> > relatively high. In other words, all the AOSP products we examined also
> > use high values for these settings. Nobody is using tcp_wmem[0]=3D4096.
> >
>
> The (fine and safe) default should be PAGE_SIZE.
>
> Perhaps they are dealing with systems with PAGE_SIZE=3D65536, but then
> the skb_page_frag_refill() would be a non issue there, because it would
> only allocate order-0 pages.

I am 100% sure that all of them handle PAGE_SIZE=3D4096. Google is working =
on
16KB page size for Android, but it is not ready yet(Please correct me
if 16KB has been
ready, Suren).

>
> > We=E2=80=99ll need some time to understand why these are configured thi=
s way in
> > AOSP hardware.
> >
> > >
> > > >
> > > > It might be worth exploring these settings further, but I can=E2=80=
=99t quite see
> > > > their connection to high-order allocations, since high-order alloca=
tions are
> > > > kernel macros.
> > > >
> > > > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > > > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_M=
ASK)
> > > > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_M=
AX_SIZE)
> > > >
> > > > Is there anything I=E2=80=99m missing?
> > >
> > > What is your question exactly ? You read these macros just fine. What
> > > is your point ?
> >
> > My question is whether these settings influence how often high-order
> > allocations occur. In other words, would lowering these values make
> > high-order allocations less frequent? If so, why?
>
> Because almost all of the buffers stored in TCP write queues are using
> order-3 pages
> on arches with 4K pages.
>
> I am a bit confused because you posted a patch changing skb_page_frag_ref=
ill()
> without realizing its first user is TCP.
>
> Look for sk_page_frag_refill() in tcp_sendmsg_locked()

Sure. Let me review the code further. The problem was observed on the MM
side, causing over-reclamation and phone heating, while the source of the
allocations lies in network activity. I am not a network expert and may be
missing many network details, so I am raising this RFC to both lists to see
if the network and MM folks can discuss together to find a solution.

As you can see, the discussion has absolutely forked into two branches. :-)

Thanks
Barry

