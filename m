Return-Path: <netdev+bounces-145132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34619CD547
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F228DB22C9A
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9C2E414;
	Fri, 15 Nov 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4IJZFVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7D10F2;
	Fri, 15 Nov 2024 02:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731636955; cv=none; b=RXnhaGal23Bu8FftG2nwJ5uxQokAQdNzbukpkuaVcga1KNRNe64MbcEjIeNDladZssF+bWhJJs5z0Co50MWSEOZzdAUqavIVdUjjxjcCbrYYvRvlSLo+qxO5TqmnQpyQpEhqzcdG3ZZp46Of/fc4tBNlQyLAtrYH7hjpykzUicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731636955; c=relaxed/simple;
	bh=0e+N3+/Rsp2tV5GwCYO79NhtdRtJat6VYstk/st7UQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGC6XmiKfgft6ErxRAA7d4DWix8eJuHUuwSLhLM5zW+t+XRkINUK4z0byK4TZ/U7ruaQlVJt6ltw+vu/vFtmgndF5mPtNQrbm9rydAotm6URzYB1wZrnPx42gry/qBrprV1P0TkvZ/li0dIniJ8RiJ70RYvODDueEOkmpQjABtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4IJZFVo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53da24e9673so1320876e87.2;
        Thu, 14 Nov 2024 18:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731636951; x=1732241751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ippxyC1ssto08XSgY7z8EqhqA5JTUkFz85no0waffM0=;
        b=m4IJZFVoi9jGU9XXvh61c+yuIUMqy0H8iyK6yHzZsrI1rMFs7N38YcfSX0fGtoLN/j
         imKscFfayjDxhKm/5z8j4Ex/KJH9DKwRo25kVDPPj7LhkF2oLEj8dIIQHmDI/6erNFMa
         Hkgei35zlrRkfZzeO3+EkmdumsLgA/vtUwREOQZQMM4nL9fuEwVFJ/POHtgGmxHtiaLv
         YLFKP6upIiAIW7tlecb2KIY5qzacHkPq0s4bzWj4ARTr36BnAUjBZpdp1n9jcaMOXP/4
         mj+XpFy08v0tec9nn6I1G9PBBZ0EjDE0e6qs3qxq+rjWf0XM44h540EjuoV3Lj6UrO1C
         Qbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731636951; x=1732241751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ippxyC1ssto08XSgY7z8EqhqA5JTUkFz85no0waffM0=;
        b=Tpb9MdzRqTnTs3iivvOscuKS5hsqlLsPp/0ek/bUdgNsM09A+kStPIvj6I+BUT1WeT
         dStPQjydEqFp1RhyPFCY0KWrFG1IRv2nupfDOW+8qah0kn67W2Hrq9lx8hJg2PiE2+bi
         hbk3VJOFSIIa77cpQPwdkCkdKxd3qcbXjAdG3FqN/tUgyW6HGpEfgzFqfXbFwq9lrMB2
         kKuc7Jd/SavJ2q5dc4w/yOhvmtqB2mFY8nOrtPyjJqhIMUeR+fJol5CwF/g3CoEcXxg+
         884/1mMrb2ibQrkvgxIs9gsc6SBYEBJBpWgrJajckCdOYU3QvdO+zTfSQCYTUt4YczwN
         ZQPw==
X-Forwarded-Encrypted: i=1; AJvYcCVhIr79B6fDfRChOdbHG2fONhmtg7zdiMNThoTtzdWFLyXi6BfdEydvlN1gt4dRNuqL6bP+rvv1fO0Gpi+K32w=@vger.kernel.org, AJvYcCWX0aIDN8S0o6f6pLhtkldAvCCz5zfI3oEszhfzuCFJ9LhTQwWGU5k3rHQ07QCrv5m2vqc+qsI0@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsuDbusjr5ofZHu+8hKNGBEcDdx+ZsHvKnTDu629MBb374pzp
	Y/BoQZjyOi9hsEWMnsro5+SN3dqS5FoT7DXNvDuuPhlGVYxRO/LSOOembntE4Y+nMhdyDoSFXkC
	Lr1R5oqdmfL7QDveKbmzeQ+rjr78=
X-Google-Smtp-Source: AGHT+IGec/+eQEuADDAF4XHCOSRzs5rnpKkoYFiK33Kqo560i8muQqdhYW3bBEy6l7LYxLk96WibNEGaNf5KGCB5/1A=
X-Received: by 2002:ac2:4e06:0:b0:53b:1f14:e11a with SMTP id
 2adb3069b0e04-53dab29c89cmr266722e87.15.1731636951193; Thu, 14 Nov 2024
 18:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co> <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
In-Reply-To: <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Nov 2024 21:15:38 -0500
Message-ID: <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
To: David Wei <dw@davidwei.uk>
Cc: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Thu, Nov 14, 2024 at 7:42=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-11-14 15:27, Michal Luczaj wrote:
> > The bt_copy_from_sockptr() return value is being misinterpreted by most
> > users: a non-zero result is mistakenly assumed to represent an error co=
de,
> > but actually indicates the number of bytes that could not be copied.
> >
> > Remove bt_copy_from_sockptr() and adapt callers to use
> > copy_safe_from_sockptr().
> >
> > For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr(=
) to
> > scrub parts of uninitialized buffer.
> >
> > Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old(=
)
> > and hci_sock_setsockopt().
> >
> > Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt use=
r input")
> > Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt =
user input")
> > Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt u=
ser input")
> > Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt use=
r input")
> > Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockop=
t user input")
> > Signed-off-by: Michal Luczaj <mhal@rbox.co>
> > ---
> >  include/net/bluetooth/bluetooth.h |  9 ---------
> >  net/bluetooth/hci_sock.c          | 14 +++++++-------
> >  net/bluetooth/iso.c               | 10 +++++-----
> >  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
> >  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
> >  net/bluetooth/sco.c               | 11 ++++++-----
> >  6 files changed, 33 insertions(+), 40 deletions(-)
> >
> ...
> > diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> > index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3e=
a9041770ede4f27b8 100644
> > --- a/net/bluetooth/rfcomm/sock.c
> > +++ b/net/bluetooth/rfcomm/sock.c
> > @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socke=
t *sock, int optname,
> >
> >       switch (optname) {
> >       case RFCOMM_LM:
> > -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optle=
n)) {
> > -                     err =3D -EFAULT;
> > +             err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optval,=
 optlen);
> > +             if (err)
> >                       break;
> > -             }
>
> This will return a positive integer if copy_safe_from_sockptr() fails.

What are you talking about copy_safe_from_sockptr never returns a
positive value:

 * Returns:
 *  * -EINVAL: @optlen < @ksize
 *  * -EFAULT: access to userspace failed.
 *  * 0 : @ksize bytes were copied

> Shouldn't this be:
>
> err =3D -EFAULT;
> if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
>         break;



--=20
Luiz Augusto von Dentz

