Return-Path: <netdev+bounces-224113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E11B80F33
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205B617E7F4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04062D73BF;
	Wed, 17 Sep 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Evnwn9hK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207822E090A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125255; cv=none; b=fpQ40HtwdhO6WFqfB7EC7vPKJCNYY5/zYfSE5b4A1SBfm4Oj/uPv0kRKRMUwVynTPZ743qfaTi1o1wU0IGuGN6ECGZXh6YqAPr4GwMpLasqRBxyf+PPo+19w1vzzfc294t90G+sePg/1EpgWd+zQBJEUgb35tbz2YniAEj9tXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125255; c=relaxed/simple;
	bh=FN93WUXPlWsN5fMrt007QMiWIPoCXRAkHLgrSLTkEDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bx/irKFAaoX21gkHusZN1/yDPVrAA7yAI4LBQjaP9xVWwh00yX3ZpIJeP88L1k9OXocV6MosBL9dyCcy0DjiEGHkOxa62CGRNdoNKgye3bvzGPV+cWJ8DXwfCqOvrNYaI3+BxgFnCj2muiFOD9ORZ27QtLJMLOpV4gNk0OLMvQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Evnwn9hK; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7b3202dceso24595971cf.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758125252; x=1758730052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCZ01hMsb1ZkykEb3V7NOHp2GN4zjY827aswLlXkpPU=;
        b=Evnwn9hKOdL2Tcec0lzOKvJTCdkfTKBQ0B9SKOLdk/hargyx0HWKXeQMHxI8UFA1sD
         26kBU9RQzKkbVbvS521uBRgOffF0W1CGffDAVA5DmES30SiHi52HBUflandFq1bXuPUL
         vpKNTL/3YuOx+HV++AX/YntZomdflK0egIO6XRtHMhPntr/EeTOa9/PDY3xCAHzwf6DQ
         Nja4mV+29Uk420av7j57iDg9+r5B7zPdA6lW2wd5WVGOyNWpAMeKD+ivuvkLNErogixK
         NwKzBmKdttmTFr03H1X8+bo8HuliWlMNEQlvobcdi9kTwnba53ecpTXmWawpDtMZ4Vm2
         tpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125252; x=1758730052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCZ01hMsb1ZkykEb3V7NOHp2GN4zjY827aswLlXkpPU=;
        b=tWscDlV5PXTVe7+SY7z3aE5g5ZNeAEjvG2iVXNvij7JNkafABmLh9mJZ1N5Z/7+3G7
         7O3sebm9V3jVgsdtVIsl9PPiQjHK4uMl5DMHCEigydguPUrk3Ff6FqPgiRRtNKKlxqb/
         XFwahl0o+Gblj5V4XVm594lJv3CrVX5u7FIqFDA4RMpvqlrejLYZp52LAaMrPs8XNvfr
         5X/gHutfdaaDJ0BJh2E+qOXokIsAOxrC7O9+D2pTz+YNGtFIcRPVbYdNxA3tanHrCb+z
         2aBjEsfitGGnEB2Jpj17gZ9MmIXmc7QWKBtB7gH0ddu3z0qAi0XshlBo7+eo1JJZNrCr
         iJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYxnlrAJ8vTZHtT6hiRVyydBDWwwRxZATyn9TxH/Qgwv0xWtRPOnlxSy2OSBJTuLGXxZijQY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TUftxlTvtjrC0jBb40Gh3ZCR8wjte2F9riRp8kGSUAQVLBLg
	m/vlOSDrmq+YYFg2xgnVfO0LJJB5QthQjWLRrkX7eQT9zYIQo2ydHWLTqgdfR2tvdEQGGe0iBaM
	c/hMDCPjia0wU5AYGR3bp4tSZvU1YNnUffD9hfi2y
X-Gm-Gg: ASbGncsI87Gk4HQu5npLsdKpseLQ2wpKXEOcNKUO+3SLpKcjQ7t5XTor8RHB6DWPNVo
	s/mwUXlxplS1YI/vBZ9qDHdPzpx6aUoCjLAXCMQZ/82WxDvE14fP2ZN0WvZWkfz8XKel4A0exbZ
	Z5mgr3KqseyklcuFhYmeUUIGtwrsl4tENoaalOgP3nfdv70KOt7jKXBy0pYXO0OFBJzx1P2k2nq
	97V2V/9h79k1V+xkLxlv9U=
X-Google-Smtp-Source: AGHT+IHNa9WTbust4czZ1sEl37kS31Rv1r3ZXG+7YD7lUc+J+P9W+aFOZsIWupWEOvH78JNz8moXmwVl6ZGC2fsOuHs=
X-Received: by 2002:a05:622a:124f:b0:4b7:adf0:eeb8 with SMTP id
 d75a77b69052e-4ba66f01bcamr31891931cf.19.1758125252120; Wed, 17 Sep 2025
 09:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-7-edumazet@google.com>
 <willemdebruijn.kernel.111bed09b8999@gmail.com>
In-Reply-To: <willemdebruijn.kernel.111bed09b8999@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 09:07:21 -0700
X-Gm-Features: AS18NWCJm4g7g1BE_VOt6liZLebORQQmXPAPf86fjvl0qsLeZSIiBkrnvsADVTo
Message-ID: <CANn89iK-iPeGNVP5zKq4t+0vPhTsqCFeP715Z5XSfW6KdfhzKg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock acquisition
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:01=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Avoid piling too many producers on the busylock
> > by updating sk_rmem_alloc before busylock acquisition.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index edd846fee90ff7850356a5cb3400ce96856e5429..658ae87827991a78c25c217=
2d52e772c94ea217f 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1753,13 +1753,16 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> >       if (rmem > (rcvbuf >> 1)) {
> >               skb_condense(skb);
> >               size =3D skb->truesize;
> > +             rmem =3D atomic_add_return(size, &sk->sk_rmem_alloc);
> > +             if (rmem > rcvbuf)
> > +                     goto uncharge_drop;
>
> This does more than just reorganize code. Can you share some context
> on the behavioral change?

Sure : If we update sk_rmem_alloc sooner, before waiting 50usec+ on the bus=
ylock
other cpus trying to push packets might see sk_rmem_alloc being too
big already and exit early,
before even trying to acquire the spinlock.

Say you have many cpus coming there.

Before the patch :

They all spin on busylock, then update sk_rmem_alloc one at a time
(while they hold busylock)

After :

They update sk_rmem_alloc :
if too big, they immediately drop and return, no need to take any lock.

If not too big, then they acquire the busylock.


>
> >               busy =3D busylock_acquire(sk);
> > +     } else {
> > +             atomic_add(size, &sk->sk_rmem_alloc);
> >       }
> >
> >       udp_set_dev_scratch(skb);
> >
> > -     atomic_add(size, &sk->sk_rmem_alloc);
> > -
> >       spin_lock(&list->lock);
> >       err =3D udp_rmem_schedule(sk, size);
> >       if (err) {
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
>

