Return-Path: <netdev+bounces-141658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD29BBEB6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FA12821B6
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B321E3DF1;
	Mon,  4 Nov 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MysYrUtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AE1E3DCF
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751655; cv=none; b=TubVCl/f6qOHgIynM5nsdxd4tZR6pMxcbiC+sMWZPNNqAbI3WWnxYP1XdL2VgRQHr3vhO11jgkODanVJwvbmSiTusxn5N4XL0ngkAb5jpr7u+JmtKF7eA57pCyg2m0mYZ7CdSvtRBSvaZ6UE0Xg7C6bK13KUfp2Ml8AmX4Jt01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751655; c=relaxed/simple;
	bh=G8UM6S47N1hnQwwcxjbdqO/6J6HHccLXABrZTA+EPTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYU3iFJu7K0ZOFO6bSsHDlA8jYuYHzeVCH8J63jJHQ1Gh1E0zQaMPpelXY+AAhcd2RRoqrSnFXA3CXDp7gIrUTABsTLwmg1Y9Chapz4Mb5BlBGnfVMYwCeAR7VO+1VSCY79r7AzTlUWK4K07oJ7RAkl9r2rgDlU3auFxQJBbd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MysYrUtk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so40905ab.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 12:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730751653; x=1731356453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uql/Bw1vcaYh8+NWY2ZEj9oRvcn+EreIycRFoRD4OVw=;
        b=MysYrUtkyTmu7zxzu2II/1nvVCMXbIcUE9hmdCD7Nvf2z4LLNExuRKSjs58DTTpPPL
         NRslZAzS6SIR9nl4E9nqavWmhwDeMWVOY2F5nGcL4dzkO0548/5DnS1peCu+WP59bQBe
         5Ei1nFNTqAajybLmE1H5s1ROndhxzDgnZpUpk5xuXsPf2EQNe3Gg00ciAr7nOk75jBIu
         IxnbRIn5NZKHwsURWBizBohv9IED8CaQ37u+fmtFotmdS/4sF7BJLY/IdJgcEA7TBr9J
         luzYk8yuIE0f/6EPbK9HCIw7tlEi1+VCZiLL5akIRtwFTLAR/of2JGUzhphNmK68w1//
         aUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730751653; x=1731356453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uql/Bw1vcaYh8+NWY2ZEj9oRvcn+EreIycRFoRD4OVw=;
        b=Hijhcmre1ZsfrOhOCRfrXnfw4iPJJiWkKXiKDWpRRetIQ5U9Nl6mxQ8H0RfTZhowb0
         RVLDJmUtHVpjcRfZSLJ/JwExvyCvkFrSDV0rZA22SbmE/phbzWt0UXkLN7tmsSb4caqa
         saXrJKFx8+ZRxplMwqs5Ivudt06mc+ar2QmeCtrckj0sA6HyLetEyjE2qnK4i8pBUdN2
         sATvfybikxXOiCErAmFPevlXUOiPJTNm6tNozc47oB76KOEPO7OlegM3hZfHsqplA5Qi
         minEj87pDByVjAao0BozXpCJFQM92EhR4UHBuLoB3yHouFYSDHZDYkJJINps+mLEa9HS
         TOyA==
X-Forwarded-Encrypted: i=1; AJvYcCWBgmzCNkIAY34yApP1ogKCS5otXZlofwLUjw8bTzD1qe4tUe1x4l7PpPf4KEEJ4/szcTjaY9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYGbFIDjjxGG0wJC/ex7to31abaTIy/0rJ+A2M9UVBTMbecrM
	Bk0eyYMc+JWwV1L0PQ/BBRwJr15Queat31rKr+CMjb3amwi37cZgCBf1k/ICdwG4+kuIkzlQ5YO
	S9bTOnfSVeJSydZQiQkGh/62B0u/Q/4RTN00v
X-Gm-Gg: ASbGncvVXJd8xSRHApA5/0QIPel9ZG8FDaRdUxhoNOJotipBYlQdhesl2S2WlDZ2MNn
	nB96Uuq+7Zs4ctuLY2kKaZbA6vnxL/mv5+X0GYJeoyu+Ft9n6R82dV/iGVjhGyg==
X-Google-Smtp-Source: AGHT+IFzSkcrUS2LnkOi2cTsx/E8EjUnf3mipQEN/gZ5HS1tCJDpCOnfzB4nfSUr8CDBFueEK+2x9JATC18GABaEGjI=
X-Received: by 2002:a05:6e02:12b4:b0:3a6:b318:3b99 with SMTP id
 e9e14a558f8ab-3a6daa9e751mr547355ab.27.1730751653363; Mon, 04 Nov 2024
 12:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029230521.2385749-1-dw@davidwei.uk> <20241029230521.2385749-5-dw@davidwei.uk>
 <CAHS8izPZ3bzmPx=geE0Nb0q8kG8fvzsGT2YgohoFJbSz2r21Zw@mail.gmail.com> <5b928f0e-f3f8-4eaa-b750-e3f445d2fa46@gmail.com>
In-Reply-To: <5b928f0e-f3f8-4eaa-b750-e3f445d2fa46@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 4 Nov 2024 12:20:41 -0800
Message-ID: <CAHS8izMTuEMS2hyHs0cit0Wvo3DcuHxReE1WS-crJ8zDTs=_Wg@mail.gmail.com>
Subject: Re: [PATCH v7 04/15] net: prepare for non devmem TCP memory providers
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:41=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
> ...
> >> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >> index e928efc22f80..31e01da61c12 100644
> >> --- a/net/ipv4/tcp.c
> >> +++ b/net/ipv4/tcp.c
> >> @@ -277,6 +277,7 @@
> >>   #include <net/ip.h>
> >>   #include <net/sock.h>
> >>   #include <net/rstreason.h>
> >> +#include <net/page_pool/types.h>
> >>
> >>   #include <linux/uaccess.h>
> >>   #include <asm/ioctls.h>
> >> @@ -2476,6 +2477,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, =
const struct sk_buff *skb,
> >>                          }
> >>
> >>                          niov =3D skb_frag_net_iov(frag);
> >> +                       if (net_is_devmem_page_pool_ops(niov->pp->mp_o=
ps)) {
> >> +                               err =3D -ENODEV;
> >> +                               goto out;
> >> +                       }
> >> +
> >
> > I think this check needs to go in the caller. Currently the caller
> > assumes that if !skb_frags_readable(), then the frag is dma-buf, and
>
> io_uring originated netmem that are marked unreadable as well
> and so will end up in tcp_recvmsg_dmabuf(), then we reject and
> fail since they should not be fed to devmem TCP. It should be
> fine from correctness perspective.
>
> We need to check frags, and that's the place where we iterate
> frags. Another option is to add a loop in tcp_recvmsg_locked
> walking over all frags of an skb and doing the checks, but
> that's an unnecessary performance burden to devmem.
>

Checking each frag in tcp_recvmsg_dmabuf (and the equivalent io_uring
function) is not ideal really. Especially when you're dereferencing
nio->pp to do the check which IIUC will pull a cache line not normally
needed in this code path and may have a performance impact.

We currently have a check in __skb_fill_netmem_desc() that makes sure
all frags added to an skb are pages or dmabuf. I think we need to
improve it to make sure all frags added to an skb are of the same type
(pages, dmabuf, iouring). sending it to skb_copy_datagram_msg or
tcp_recvmsg_dmabuf or error.

I also I'm not sure dereferencing ->pp to check the frag type is ever
OK in such a fast path when ->pp is not usually needed until the skb
is freed? You may have to add a flag to the niov to indicate what type
it is, or change the skb->unreadable flag to a u8 that determines if
it's pages/io_uring/dmabuf.


--=20
Thanks,
Mina

