Return-Path: <netdev+bounces-229364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687D8BDB33C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2BF3A43C5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5130648B;
	Tue, 14 Oct 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTYMvXjj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A78305E08
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760473081; cv=none; b=Kb4PS2U0/wB4KrfVlb4rBpBU542+uPwwW+Aoe0TbTsuen0FKlY3YJuhwOaf7D5um4fCBO1luu+JXsXt3bJCCL5ygo51XsiMNqwgHK1KVstJJQeVPIbJMzv+FiGvFOyxqsYzhI6Jt3XyqUyTUejqX1oCLu7jWXasIjOEsm61EkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760473081; c=relaxed/simple;
	bh=srKo3S0lx/URRHGbZXp1TkwheQoh4KkTklwf9Xdi4pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5oG5GvwiFNJcTHLiLW5RUCwppuvZy74N/polZ3rh3oH7FXdRmRL6q2FofXmlNfYdPsqusI5J/Y0Bo6ZGp3r0GGBYGHHHAmI/pRCrc9mzx4ttGzguLHyYyEkTgtvZjjdaXoHuW17mgq5+D47jLxyg15OGbnh+conOfFuCJPUo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTYMvXjj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-859b2ec0556so832810285a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760473079; x=1761077879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT/7SpttvoyPFfDZkD0MSIyAHcwC7WHYJHOJLI1G790=;
        b=LTYMvXjjsk5yZMqLtZFv1oNQEC6A6bVCAakPhssE187+bc+fEr0LXwuk06TmbzfGpe
         RtL8h7b4pzM8QorMiRrT0Ohiatyzh4XfkPMd5ssVwXvDj5BolNznHQOW0kdSJAwRRnka
         aCIDMw7xxOIlg4m15853s8kYoBFlfOyItCCfUL8NoIvO50X0rHssSekCKqXmpadw5NS3
         kFZHP3x04NJcHjcLR5oCqvS6jf93na+0jNZ6aPD+V7OHt5MeQK8Ml+XvQcjHD03+pks4
         OwXM0acPnZN8Abk6eogZmd6TfrBY1R2IbozIU7CFx+ScFpalCnwQ1XiBF1r5VofL6Ng6
         shWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760473079; x=1761077879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bT/7SpttvoyPFfDZkD0MSIyAHcwC7WHYJHOJLI1G790=;
        b=KnNJ/6cqtB/27cC3jcBKpoI2PbPNPx1/On5Y0vHqalszL76kJ/sOtxGxxrxERJMxgw
         Sv3IPxzhysTxBbRwqAZ5tppobR+AzRfJZTSZGIl5H48hpXPRdA6ZNulnukMalHRR3QbG
         d3FE0o8jq0sUuEjPcMqyLJyBpIPdDzq2fQyM1nU4zTcdAquK8/VWitDPAqNbuoeCBixo
         pXmiOsqfe9HUAnobxXGjsBqh2AF/hi7Uf8Md+cn/DUlBSN6z+iglGjHG1N0YY2Pj/eO1
         IFMf2NmXcjttGrYULumffmAJuK3aLfbN7VsIIz/+q3vAETxpWqTdxIsCPuip7zwjqYlh
         ehrg==
X-Forwarded-Encrypted: i=1; AJvYcCXG49SqrMOqyf7ciTBeqm5nbMEfiJPq04g3jBHJ3d3WZYLZPvaCxe7JtQvqkTHZW0jnEwZsnK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL13iDVMz9uQcEC/M8pjNldOoclsp9Qf/vSK9T/WU4xpALU7oJ
	OCRvBJ9tunNBLl89mtRC4x+C5vWQQyZAN141SU4mj4HMko3PmPLrI5hGsvU4WKZ83qOGRBwsqJQ
	+joV262KVjWv+L9NOpnqYnsHrQChQUyQ=
X-Gm-Gg: ASbGncvkyx2UVH/dsxSlSA1YWMINP7ooY1l7OCMM6d5ZxZBYs7/V9iy2SFvYTeXTlT2
	obaZIeQ79XJXOT7wSE9eIMRCW15XY4CnpYG1nKBunr5VUF/yrmiLgZneD3sIQBjeefeCDf0eNVL
	oswI+vXmr+8AHo1TOgdm5VY6U1NuQ1GUvwiPxdEoWd9Df+YGIQ4swOb6yRj1yFKSkAmBQidS0Vb
	wn1kc8UUMQ2oSsIrOToN42sUKanRdBNHncXWvCWZBKxW6sSZ/JVaecqdub4V4wiqm6F
X-Google-Smtp-Source: AGHT+IFH4oKwfJUV2I14NgjtJXb6mfnAhJ8zEp3LCF9Bae6duG9Q+7fuIKrLdNF8ldj1eCYSNIUxprx9xOI5hm+x8qg=
X-Received: by 2002:a05:620a:1aa7:b0:863:42ea:d687 with SMTP id
 af79cd13be357-88352d9a142mr3213016685a.78.1760473078522; Tue, 14 Oct 2025
 13:17:58 -0700 (PDT)
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
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com> <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
In-Reply-To: <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 04:17:44 +0800
X-Gm-Features: AS18NWA_1i8a6vTg05EcWS4a7WFXDki8J6oo80AKS6W-CO7YvxmVpyAKLiA8th8
Message-ID: <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com>
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

On Tue, Oct 14, 2025 at 6:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 14, 2025 at 3:19=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > > >
> > > > >
> > > > > I think you are missing something to control how much memory  can=
 be
> > > > > pushed on each TCP socket ?
> > > > >
> > > > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > > > >
> > > > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> > > >
> > > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > > 524288  1048576 6710886
> > >
> > > Ouch. That is insane tcp_wmem[0] .
> > >
> > > Please stick to 4096, or risk OOM of various sorts.
> > >
> > > >
> > > > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > > > 4294967295
> > > >
> > > > Any thoughts on these settings?
> > >
> > > Please look at
> > > https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> > >
> > > tcp_notsent_lowat - UNSIGNED INTEGER
> > > A TCP socket can control the amount of unsent bytes in its write queu=
e,
> > > thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> > > reports POLLOUT events if the amount of unsent bytes is below a per
> > > socket value, and if the write queue is not full. sendmsg() will
> > > also not add new buffers if the limit is hit.
> > >
> > > This global variable controls the amount of unsent data for
> > > sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> > > to the global variable has immediate effect.
> > >
> > >
> > > Setting this sysctl to 2MB can effectively reduce the amount of memor=
y
> > > in TCP write queues by 66 %,
> > > or allow you to increase tcp_wmem[2] so that only flows needing big
> > > BDP can get it.
> >
> > We obtained these settings from our hardware vendors.
>
> Tell them they are wrong.

Well, we checked Qualcomm and MTK, and it seems both set these values
relatively high. In other words, all the AOSP products we examined also
use high values for these settings. Nobody is using tcp_wmem[0]=3D4096.

We=E2=80=99ll need some time to understand why these are configured this wa=
y in
AOSP hardware.

>
> >
> > It might be worth exploring these settings further, but I can=E2=80=99t=
 quite see
> > their connection to high-order allocations, since high-order allocation=
s are
> > kernel macros.
> >
> > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX_S=
IZE)
> >
> > Is there anything I=E2=80=99m missing?
>
> What is your question exactly ? You read these macros just fine. What
> is your point ?

My question is whether these settings influence how often high-order
allocations occur. In other words, would lowering these values make
high-order allocations less frequent? If so, why?
I=E2=80=99m not a network expert, apologies if the question sounds naive.

>
> We had in the past something dynamic that we removed
>
> commit d9b2938aabf757da2d40153489b251d4fc3fdd18
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Aug 27 20:49:34 2014 -0700
>
>     net: attempt a single high order allocation

Thanks
Barry

