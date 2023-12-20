Return-Path: <netdev+bounces-59258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516681A183
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B01C21554
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235AB3D965;
	Wed, 20 Dec 2023 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxUHrDF6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE893D96B
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bb6e8708b7so621465b6e.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 06:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703083988; x=1703688788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/3mth73fxZlPywUOcj4ecaZ1hAZDVRVEaS8BXpK9jI=;
        b=GxUHrDF6GDZoks+q9+gqjrPsBgkLZsitQGy7CQOk3l/dU8rsGqTYKwcEg51Mw9ZqgM
         RvTY/frWha+ZQf1D4RC5PRE6z4EPMFURxCYz1AtuLIlUjk2uUZeeHcgkN5h1i//EvLZe
         Sbc6s8Dr37knfhQTQ5o/27DKk2VjSC9H0TRwYiHBNDq4HRY9ZS6MBwCOBLlWLcAXnEQo
         HSMua6ukMwN843RQZsDYi0bgjbpxuwjyZDUT7WKp3idyf3OELtgCZoQyJ3QAZdZDECt/
         5W6HJFLq86nN0mMvwDK2wFlERgfysCkjkMQRXbofTBrZuTn3+juZE+bwPp7I45E/Jjbz
         EZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083988; x=1703688788;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/3mth73fxZlPywUOcj4ecaZ1hAZDVRVEaS8BXpK9jI=;
        b=hqRoEhu+f+VrFQkCynYuavNMDHg6PvS9nmUAX8gA5HU6M8Y7Wp5fl99x9P3OJ+hlpP
         6pyPOrFT5T2SSOmEwI2yLda/Ghr4r+y019FNniO6Q+g19giZDUuXPZttcX4lJL5X6ufs
         FAKHeSszTw5kJGP79gOQHKpVSR9lYTTtY2I1Cjbj+GamWVpdj+RRVxULN9NgSBoVGFKy
         aKTufJQRZOZE+8z7f7/bQPM0Zu36/CreESWt4ZKaBZavxQoazgMq9ucXp2K2acDxB65B
         JiKPT73M3osq5Aue7oYglzw5RbI2lSlgQgyEY0CApuyb9lKSSxDcTLBp8Hjp387EZNxk
         lzQg==
X-Gm-Message-State: AOJu0Yxm+NqvFfCusQZVq7Hc0a/9M7i4uxa5FnQbpEfpoQF5DpJrmFMO
	dOr5NpRyHXmceC+bNFInlMo=
X-Google-Smtp-Source: AGHT+IFRC60in3pJ2ocmxpSKr96iOaTvVsnpN3Dy2rYAL5qEN8jkdT+ouTEIiP4ZhyJiTE1iQ9zfug==
X-Received: by 2002:a05:6808:16a4:b0:3b8:b063:a1c9 with SMTP id bb36-20020a05680816a400b003b8b063a1c9mr23400350oib.83.1703083988627;
        Wed, 20 Dec 2023 06:53:08 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id n4-20020a0ce944000000b0067f6ef0a8d5sm561517qvo.115.2023.12.20.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 06:53:08 -0800 (PST)
Date: Wed, 20 Dec 2023 09:53:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Thomas Lange <thomas@corelatus.se>, 
 Netdev <netdev@vger.kernel.org>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Message-ID: <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
In-Reply-To: <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
 <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B6rn-Thorben Hinz wrote:
> Hi Arnd,
> =

> thanks for indirectly pinging me here about the unfinished patches. I
> kinda forgot about them over other things happening.
> =

> Happy to look back into them, it looks like it would be helpful to
> apply them. Is it fine to just answer the remarks from earlier this
> year, after a few months, in the same mail thread? Or preferable to
> resubmit the series[1] first?

Please resubmit instead of reviving the old thread. Thanks for reviving
that.

IIRC the only open item was to limit the new BPF user to the new API?
That only applies to patch 2/2.

The missing sk_getsockopt SO_TIMESTAMPING_NEW might be breaking users,
so is best sent stand-alone to net, rather than net-next.

> Thorben
> =

> [1]
> https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-=
berlin.de/
> =

> On Wed, 2023-12-20 at 09:43 +0000, Arnd Bergmann wrote:
> > On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> > > Thomas Lange wrote:
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index 16584e2dd648..a56ec1d492c9 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk,
> > > > struct cmsghdr *cmsg,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockc->mark =3D *(u32 *)CMSG_DATA(cmsg);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAM=
PING_OLD:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING_NEW:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof(u3=
2)))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > > > =

> > > > However, looking through the module, it seems that
> > > > sk_getsockopt() has no
> > > > support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has.
> > > =

> > > Good point. Adding the author to see if this was a simple oversight=

> > > or
> > > there was a rationale at the time for leaving it out.
> > =

> > I'm fairly sure this was just a mistake on our side. For the cmsg
> > case,
> > I think we just missed it because there is no corresponding
> > SO_TIMESTAMP{,NS}
> > version of this, so it fell through the cracks.
> > =

> > In the patch above, I'm not entirely sure about what needs to happen
> > with the old/new format, i.e. the
> > =

> > =C2=A0=C2=A0 sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D
> > SO_TIMESTAMPING_NEW)
> > =

> > from setsockopt(). Is __sock_cmsg_send() allowed to turn on
> > timestamping
> > without it being first enabled using setsockopt()? If so, I think
> > we need to set the flag here the same way that setsockopt does. If
> > not, then I think we instead should check that the old/new format
> > in the option sent via cmsg is the same that was set earlier with
> > setsockopt.

__sock_cmsg_send can only modify a subset of the bits in the
timestamping feature bitmap, so a call to setsockopt is still needed

But there is no ordering requirement, so the __sock_cmsg_send call can
come before the setsockopt call. It would be odd, but the API allows it.
> > =

> > For the missing getsockopt, there was even a patch earlier this year
> > by J=C3=B6rn-Thorben Hinz [1], but I failed to realize that we need p=
atch
> > 1/2 from his series regardless of patch 2/2.
> > =

> > =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
> > =

> > [1]
> > https://lore.kernel.org/lkml/20230703175048.151683-2-jthinz@mailbox.t=
u-berlin.de/
> =




