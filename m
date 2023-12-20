Return-Path: <netdev+bounces-59261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102581A1CE
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE021C20B24
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4833D973;
	Wed, 20 Dec 2023 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgjVxUuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C9C3E47A
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42791adefa8so1207171cf.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 07:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703084800; x=1703689600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmyvHNRcStJ2HNYfzMVwSeWjxQjNvKR/i25itJAPOSs=;
        b=GgjVxUuTe8W76iTG38r1rWLf3lknpJwYgwZRsH3VJQm0+0jtCrZ/4cIGf06VMD2e5T
         ucqq1W5mhgsNhJKmvWXc7lmIryyqBJOiskxF2+YIg+/zxgI0oo8id+q2ZXuFiJ1+wc1F
         pErfRBMWzFSni1PR76ayhy/zWm7TMj4tmCt+U3W03Ca2q/v+mDoDB+eRjoDnUfoV3jyl
         pyxtKiRRBLyhJJ/Lq32AO7DQRut7FplG0s6Aey4Mzq4oolpC1cSFQEgpRV1OP+gtXBxA
         xmcvA3tGMo6ejyYC8tmotke91XmWVbidJXme/cqnXycagj6f9ReTaeC4pN9b7Gg3KAeo
         dbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703084800; x=1703689600;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmyvHNRcStJ2HNYfzMVwSeWjxQjNvKR/i25itJAPOSs=;
        b=HwqKHLbXHXlqIWDiDkY5tfvTbhaWPpKAzQn0AXHMHHFZQ75Ot7owWzxLS4Fqlbe9H/
         SHXCAuZIhk1IFZcF3Wv/wWJ7lZ/vzWTFa9nHLlJRKoKTyXovXcgcM2DothhYyjPslfWW
         Ai8j6+1r9CntaGBQpWnlEmg0ka2I6kR65CfJV24KsF14aM+Nkc+5IhBIgFUHL/4g6Zq1
         k+7fCxssvygGVn0myyPovXh515BQa1EWwPj8BtxOR9dyv0DpbocWDpQkylUqEnQ9x+Wi
         GMx5//bce+rneONIHBm1UH7oF4+HLD8obMsdml53vTt0GHJSmiHrlab2tlcD8mvLWhl9
         NF0A==
X-Gm-Message-State: AOJu0YwlCEBxg+p1PcqOorZX1HnGgcl7KjiHbbGAYdCa+q/0s+DTp51c
	RhKZblocH5Zi1Y3y1mfrIQk=
X-Google-Smtp-Source: AGHT+IHmk8rVBPE0/lzCs4uKbXUQzN+Huku7wKEg6wsv0q7HGS9LNB93PJ21/2vuVksFfYc4qU7Uhg==
X-Received: by 2002:ac8:5d94:0:b0:425:9e14:3f1e with SMTP id d20-20020ac85d94000000b004259e143f1emr4526132qtx.29.1703084799652;
        Wed, 20 Dec 2023 07:06:39 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05622a22aa00b00425b98c08dcsm9741812qtb.37.2023.12.20.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:06:39 -0800 (PST)
Date: Wed, 20 Dec 2023 10:06:39 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Thomas Lange <thomas@corelatus.se>, 
 Netdev <netdev@vger.kernel.org>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Message-ID: <658302ffea24_1a4df629443@willemb.c.googlers.com.notmuch>
In-Reply-To: <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
 <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
 <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> J=C3=B6rn-Thorben Hinz wrote:
> > Hi Arnd,
> > =

> > thanks for indirectly pinging me here about the unfinished patches. I=

> > kinda forgot about them over other things happening.
> > =

> > Happy to look back into them, it looks like it would be helpful to
> > apply them. Is it fine to just answer the remarks from earlier this
> > year, after a few months, in the same mail thread? Or preferable to
> > resubmit the series[1] first?
> =

> Please resubmit instead of reviving the old thread. Thanks for reviving=

> that.
> =

> IIRC the only open item was to limit the new BPF user to the new API?
> That only applies to patch 2/2.
> =

> The missing sk_getsockopt SO_TIMESTAMPING_NEW might be breaking users,
> so is best sent stand-alone to net, rather than net-next.
> =

> > Thorben
> > =

> > [1]
> > https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.t=
u-berlin.de/
> > =

> > On Wed, 2023-12-20 at 09:43 +0000, Arnd Bergmann wrote:
> > > On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> > > > Thomas Lange wrote:
> > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > index 16584e2dd648..a56ec1d492c9 100644
> > > > > --- a/net/core/sock.c
> > > > > +++ b/net/core/sock.c
> > > > > @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk,
> > > > > struct cmsghdr *cmsg,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockc->mark =3D *(u32 *)CMSG_DATA(cmsg)=
;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMEST=
AMPING_OLD:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING_NEW:=

> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof=
(u32)))
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > > > =

> > > > > However, looking through the module, it seems that
> > > > > sk_getsockopt() has no
> > > > > support for SO_TIMESTAMPING_NEW either, but sk_setsockopt() has=
.
> > > > =

> > > > Good point. Adding the author to see if this was a simple oversig=
ht
> > > > or
> > > > there was a rationale at the time for leaving it out.
> > > =

> > > I'm fairly sure this was just a mistake on our side. For the cmsg
> > > case,
> > > I think we just missed it because there is no corresponding
> > > SO_TIMESTAMP{,NS}
> > > version of this, so it fell through the cracks.
> > > =

> > > In the patch above, I'm not entirely sure about what needs to happe=
n
> > > with the old/new format, i.e. the
> > > =

> > > =C2=A0=C2=A0 sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D
> > > SO_TIMESTAMPING_NEW)
> > > =

> > > from setsockopt(). Is __sock_cmsg_send() allowed to turn on
> > > timestamping
> > > without it being first enabled using setsockopt()? If so, I think
> > > we need to set the flag here the same way that setsockopt does. If
> > > not, then I think we instead should check that the old/new format
> > > in the option sent via cmsg is the same that was set earlier with
> > > setsockopt.
> =

> __sock_cmsg_send can only modify a subset of the bits in the
> timestamping feature bitmap, so a call to setsockopt is still needed
> =

> But there is no ordering requirement, so the __sock_cmsg_send call can
> come before the setsockopt call. It would be odd, but the API allows it=
.

But no timestamp is returned unless setsockopt is called. So we can
continue to rely on that for selecting SOCK_TSTAMP_NEW.

Only question is whether the kernel needs to enfornce the two
operations to be consistent in their choice between NEW and OLD. I
don't think so. If they are not, this would be a weird, likely
deliberate, edge case. It only affects the data returned to the
process, not kernel integrity.

