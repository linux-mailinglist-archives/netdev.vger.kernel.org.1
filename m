Return-Path: <netdev+bounces-229473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDE0BDCC3A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92C3403B6D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E773128DD;
	Wed, 15 Oct 2025 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jE3xKu67"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD73128D9
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510355; cv=none; b=PvIsG0r6Vq5N5T/9AblbgoiykUSxbWznHMxsqIQ0CSExE873eweCaNjF5vYTYMOBL8Js/l/73RuCLy+x6naUI8juQyyhcUl6gUzM21ynABUTDw3R888Ce2n6f5xrDj12T8iSNFQ2rMgiHkcM/PCzeJad7B92xdJmbQNVgcH9kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510355; c=relaxed/simple;
	bh=u8e4JWFCFnh7H9/29cWjqArFxpug4mrQezkIEidS3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pm+ZYSjZSDsb6D7CfiE+bjt1qvRNY2vFoGSVnKDeELHMfz+73LJa7UAG3ZpOoUuxx8cM45ltSJXJm7DbzlqYyqEkI7iZZC6ArDwPWGW1WcOpZnxyqtewRW9RsPEofdy6eKxFa0Sxin+nfY+Mj3BqIMoG8EDleYCt0Sr3zkthtxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jE3xKu67; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87a092251eeso11378486d6.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760510351; x=1761115151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsukMYa0AUCqYEvcLXRhuapsU2hd6Y80454Ux1AAjL4=;
        b=jE3xKu67I8l7hnrtOK2eT11G8SXY9iP93v+Af2PO/YaQoNBGITcg2MpnpnS+qAKCiq
         FaDoYj19a8hlUbQZV5mCYIItZ3iMurOoyMww13fC828qFYpJkbGTmsvMNOEGD+d40DLe
         kUp0hV3ELWOIjDoCScx68YCvV+RCpaM5UyX3dwRehoIeuNpMYjuyV9fcZfYh/O7SyDfY
         onh6GkjEcjIgLggnzs3optEDl+KorDFecPxh6IEdxV17IXKwqxdLRqzXE7VS5vWQ2P3R
         J+QEMr2fh9wapgquSvBC1MCWV2qABApfHHtRghy7gf862xTtxK+jnLv8trcS4ys6WaHD
         xqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510351; x=1761115151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsukMYa0AUCqYEvcLXRhuapsU2hd6Y80454Ux1AAjL4=;
        b=brU6KsUIRqIpJ+XrXHzMHUjZ77HY4bjeWhpntohmPmdqh0ybfp7YWlTFDRqc6JP2PM
         yWxIuaXHuvfXNHVAutTgBwKjxCjzogcdD8Lz3M0sQ7sBIu8IVb4m9aiP1+ouzPi2H9wB
         o2BpMQEX3694fss3/fC/R/8zudgPj2kd7Dj5js9mXZ6ODEZU1XNy2uPOJfc39vmOPIEE
         o5+mtWcEN78gdGXEIkVmeZuMsLuxX9lROA7YLKCqdXsDCawkQkV1a44CVnt7LIy/2tzL
         dQwslZn0qNpG2sAQjYjqrz5JAiX3xCTfK8ujLqpHtxLwL1g/5/VlyE5wJx59fFCz867l
         zqBg==
X-Forwarded-Encrypted: i=1; AJvYcCWkVV3rMPsYrbaiZhiAFLjrTbWcVGl8K8omizcan1SKFXssJcMbUwqF25Nunh+DNVdS2DjoXys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHaP4OBkcG3qz031Y+bXwsus3iqvOvCeIWlgAO4UE0czazMHw
	nvVem9TYbMWmBk1upw7mwhl0lrOgEDXPAMYn2atu7VWSw/RrCoR7csY8I+kas1YP5/ltQDLINCA
	XH0LI9MjbMruPhoWE7zf68vooGM7CydDLAEuHcy3b
X-Gm-Gg: ASbGncs65BSV0Jd6REgOrkxMV1+S+giLKonNxtxHi8oKI7hXkVeifyr6w7kxMECxCUy
	LWYkj14V4efQMKGbXCY6VZBXJp8C+0oKREna1ZiMve/Hhd2YIlYlCNkyuHuuWrn3Vyh8ehhYrpI
	tl6wbYlic7vxwDsUSVTJCr5bp0n35dUbcXrTusm1VM/a/mUWcOQ9hrf1r3rIBm8lZB0y6T3j9kF
	UYGZ6qFTkyffpZrzLusPZ+46TNiTQCWEg==
X-Google-Smtp-Source: AGHT+IFK/RWWMbmryZERBFoMRzd6/kz9EwXNSWCusWT0Lc+3vQtZfacIx3bleY22OD0BqECfDUYhjeSl5kCs+LlgdPM=
X-Received: by 2002:ac8:4799:0:b0:4d1:212f:6689 with SMTP id
 d75a77b69052e-4e6eb068d71mr314051311cf.41.1760510351122; Tue, 14 Oct 2025
 23:39:11 -0700 (PDT)
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
 <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com> <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com>
In-Reply-To: <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 23:39:00 -0700
X-Gm-Features: AS18NWDMOlh0tBS4TlU64c6PgouY_kRH71v_bFl3FqJI9-6cAzN_kZLryiaCnBA
Message-ID: <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
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

On Tue, Oct 14, 2025 at 1:17=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 6:39=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 14, 2025 at 3:19=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > > >
> > > > > >
> > > > > > I think you are missing something to control how much memory  c=
an be
> > > > > > pushed on each TCP socket ?
> > > > > >
> > > > > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > > > > >
> > > > > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> > > > >
> > > > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > > > 524288  1048576 6710886
> > > >
> > > > Ouch. That is insane tcp_wmem[0] .
> > > >
> > > > Please stick to 4096, or risk OOM of various sorts.
> > > >
> > > > >
> > > > > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > > > > 4294967295
> > > > >
> > > > > Any thoughts on these settings?
> > > >
> > > > Please look at
> > > > https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> > > >
> > > > tcp_notsent_lowat - UNSIGNED INTEGER
> > > > A TCP socket can control the amount of unsent bytes in its write qu=
eue,
> > > > thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> > > > reports POLLOUT events if the amount of unsent bytes is below a per
> > > > socket value, and if the write queue is not full. sendmsg() will
> > > > also not add new buffers if the limit is hit.
> > > >
> > > > This global variable controls the amount of unsent data for
> > > > sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> > > > to the global variable has immediate effect.
> > > >
> > > >
> > > > Setting this sysctl to 2MB can effectively reduce the amount of mem=
ory
> > > > in TCP write queues by 66 %,
> > > > or allow you to increase tcp_wmem[2] so that only flows needing big
> > > > BDP can get it.
> > >
> > > We obtained these settings from our hardware vendors.
> >
> > Tell them they are wrong.
>
> Well, we checked Qualcomm and MTK, and it seems both set these values
> relatively high. In other words, all the AOSP products we examined also
> use high values for these settings. Nobody is using tcp_wmem[0]=3D4096.
>

The (fine and safe) default should be PAGE_SIZE.

Perhaps they are dealing with systems with PAGE_SIZE=3D65536, but then
the skb_page_frag_refill() would be a non issue there, because it would
only allocate order-0 pages.

> We=E2=80=99ll need some time to understand why these are configured this =
way in
> AOSP hardware.
>
> >
> > >
> > > It might be worth exploring these settings further, but I can=E2=80=
=99t quite see
> > > their connection to high-order allocations, since high-order allocati=
ons are
> > > kernel macros.
> > >
> > > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MAS=
K)
> > > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX=
_SIZE)
> > >
> > > Is there anything I=E2=80=99m missing?
> >
> > What is your question exactly ? You read these macros just fine. What
> > is your point ?
>
> My question is whether these settings influence how often high-order
> allocations occur. In other words, would lowering these values make
> high-order allocations less frequent? If so, why?

Because almost all of the buffers stored in TCP write queues are using
order-3 pages
on arches with 4K pages.

I am a bit confused because you posted a patch changing skb_page_frag_refil=
l()
without realizing its first user is TCP.

Look for sk_page_frag_refill() in tcp_sendmsg_locked()

> I=E2=80=99m not a network expert, apologies if the question sounds naive.
>
> >
> > We had in the past something dynamic that we removed
> >
> > commit d9b2938aabf757da2d40153489b251d4fc3fdd18
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:   Wed Aug 27 20:49:34 2014 -0700
> >
> >     net: attempt a single high order allocation
>
> Thanks
> Barry

