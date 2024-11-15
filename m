Return-Path: <netdev+bounces-145148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8799CD5A0
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA632834E7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FC14386D;
	Fri, 15 Nov 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1UxsYNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592488460;
	Fri, 15 Nov 2024 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639022; cv=none; b=jVoMX98PUJM5wOiBaUkK50xUR0Qkg/9ccnfU0lCrAGk/bqcbP78/z+qZOwK3X956n2xWxsdxZssDtV2Di47oevFvT7qa/GbTkYdz0RW0wgGRe86NVyTrt4frbzxHU32GSEZ4HBra9puLWcSAuHuMswkT3zzivR1k9fmQhC/BNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639022; c=relaxed/simple;
	bh=K6s/PRkevbmzyv/QBvS4ipbvc73J6GgJUPnWGm+o330=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APSeVtgVi1PtdholD+URvqDCp/EdoUuyw81Cts3iX1IqZMrQ49HsaHHR7Nj3L5xkX/rLP83ej+FdewELFyT/6/X1JC2LobEeB+WKTDHQ2RJMiBSskYLj+T9miIy7jTziYADPVFyMytRlXwAPDRZxNUMG90Jrp6tdh6Q5LhV33sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1UxsYNu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so13639161fa.2;
        Thu, 14 Nov 2024 18:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731639017; x=1732243817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/FvAjM3kKWcDw/G/Aj2vN5gtXIQ2JzC4rf8vr/gza0=;
        b=a1UxsYNu5pUqs8pRUL7a6TaloSRod+/5z5bifhZU+r15Lz4HlZ6oUb896W8bf7nVcr
         ptxe6W87tEMT+wkpjZ286zoxltaZMnlgJDUrzLEazidEm1hnWRbG2x76F73GV4y4Jd+9
         Jsp5rWgp9+m1Hh7cgLrxe3YrXzSwK5neOE3HIpv1YgCGcn3wfpH1kKOHChWaql46+3dd
         sBp3GzVfv2bCP8Ine4KsjsoqiKZu6G50J9E4vd77IH78B2rDQiX1JUfCiZE5L5D6yJaK
         RD7otdW9E24E8+mQ0ufvXlkrI+e1YdQHcRlXSkzkOZpZ68YorwkicgIQWIz6Zv4FUoL+
         mPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731639017; x=1732243817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/FvAjM3kKWcDw/G/Aj2vN5gtXIQ2JzC4rf8vr/gza0=;
        b=YNNNpHdNCKU/DNvOS4AYFRyn0oh89/op8qKAmaUJ68N4MHmWLXstmm0CQVImpoiS0l
         Eqk6AijVr26+JfEjDrNN3volByW0BHMSlOqLzO9mk+Z0J1umfYRiaR2VzVFXE9SqYVuZ
         XCvurodz8e+W1FarcVrVAtaaDRiwiEUUEPjLUvSQVKBxvpCwqekAe83P8Qy+IHI23bg4
         QlZ0/tlJruDCHu0X8ajV9Ouk+ZtP8BHf7pYO2K9jdyc5F/g0UM+/1Uxa3a4NCq2lU8Zy
         rF0DCLzhm/L8pGlsQ/Fajow8ZJXrV/l6OQbIJu4RQp6O/qiHDeU2Fs7ZXVuIX3rYcUcy
         OpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsAAOatCZ0SQ08IqWoi4uQaUwQjfs3H7wlvIWi8CVlBg1PL2z7TfRwoxYqROBdzEQLvb1rXhj+PBPIE2V3YJk=@vger.kernel.org, AJvYcCXQEmdI77jMSugFgEXTJdYWjxHc293n6g9rqxY3g8kzd5w7ICVtBJwN/P0m4hZTMXX85h30hEF1@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvkTGffnl6ssuq4yVzgYBziS3lG2Lz0O19HvJpm93GV4Tg931
	9RasVwlMwkSgWxL4y3EHucs7oWn4TR6MHT0NYpppGIqkYVZbVtg/fjTCiKBSOzM42cpeBfP2BNy
	nrwT3ub10ipMX4xXyFqOiIFqMNkk=
X-Google-Smtp-Source: AGHT+IGaoiOg/6+0rZWHD3aXc4nNnf2nPZcg9dwkw8xHd7TBkegb/9sqVfdcqDNia1I+fPdB+pE+w2/kS+XRNUhfrrE=
X-Received: by 2002:a2e:bc05:0:b0:2ff:55fb:e5f2 with SMTP id
 38308e7fff4ca-2ff607cd679mr5261781fa.0.1731639017221; Thu, 14 Nov 2024
 18:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co> <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
 <CABBYNZLbR22cWaXA4YNwtE8=+VfdGYR5oN6TSJ-MwXCuP3=6hw@mail.gmail.com> <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
In-Reply-To: <970c7945-3dc4-4f07-94d5-19080efb2f21@davidwei.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Nov 2024 21:50:04 -0500
Message-ID: <CABBYNZL_awaZOKpsAyOaAbtnJLobJ1bQpF_9JNxpiyQg5P5q1Q@mail.gmail.com>
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

On Thu, Nov 14, 2024 at 9:30=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-11-14 18:15, Luiz Augusto von Dentz wrote:
> > Hi David,
> >
> > On Thu, Nov 14, 2024 at 7:42=E2=80=AFPM David Wei <dw@davidwei.uk> wrot=
e:
> >>
> >> On 2024-11-14 15:27, Michal Luczaj wrote:
> >>> The bt_copy_from_sockptr() return value is being misinterpreted by mo=
st
> >>> users: a non-zero result is mistakenly assumed to represent an error =
code,
> >>> but actually indicates the number of bytes that could not be copied.
> >>>
> >>> Remove bt_copy_from_sockptr() and adapt callers to use
> >>> copy_safe_from_sockptr().
> >>>
> >>> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockpt=
r() to
> >>> scrub parts of uninitialized buffer.
> >>>
> >>> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_ol=
d()
> >>> and hci_sock_setsockopt().
> >>>
> >>> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt u=
ser input")
> >>> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockop=
t user input")
> >>> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt=
 user input")
> >>> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt u=
ser input")
> >>> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsock=
opt user input")
> >>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >>> ---
> >>>  include/net/bluetooth/bluetooth.h |  9 ---------
> >>>  net/bluetooth/hci_sock.c          | 14 +++++++-------
> >>>  net/bluetooth/iso.c               | 10 +++++-----
> >>>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
> >>>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
> >>>  net/bluetooth/sco.c               | 11 ++++++-----
> >>>  6 files changed, 33 insertions(+), 40 deletions(-)
> >>>
> >> ...
> >>> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.=
c
> >>> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd=
3ea9041770ede4f27b8 100644
> >>> --- a/net/bluetooth/rfcomm/sock.c
> >>> +++ b/net/bluetooth/rfcomm/sock.c
> >>> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct soc=
ket *sock, int optname,
> >>>
> >>>       switch (optname) {
> >>>       case RFCOMM_LM:
> >>> -             if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, opt=
len)) {
> >>> -                     err =3D -EFAULT;
> >>> +             err =3D copy_safe_from_sockptr(&opt, sizeof(opt), optva=
l, optlen);
> >>> +             if (err)
> >>>                       break;
> >>> -             }
> >>
> >> This will return a positive integer if copy_safe_from_sockptr() fails.
> >
> > What are you talking about copy_safe_from_sockptr never returns a
> > positive value:
> >
> >  * Returns:
> >  *  * -EINVAL: @optlen < @ksize
> >  *  * -EFAULT: access to userspace failed.
> >  *  * 0 : @ksize bytes were copied
>
> Isn't this what this series is about? copy_from_sockptr() returns 0 on
> success, or a positive integer for number of bytes NOT copied on error.
> Patch 4 even updates the docs for copy_from_sockptr().
>
> copy_safe_from_sockptr()
>         -> copy_from_sockptr()
>         -> copy_from_sockptr_offset()
>         -> memcpy() for kernel to kernel OR
>         -> copy_from_user() otherwise

Well except the safe version does check what would otherwise cause a
positive return by the likes of copy_from_user and returns -EINVAL
instead, otherwise the documentation of copy_safe_from_sockptr is just
wrong and shall state that it could return positive as well but I
guess that would just make it as inconvenient so we might as well
detect when a positive value would be returned just return -EFAULT
instead.

> And copy_from_user() follows the same 0 for success or N > 0 for
> failure. It does not EFAULT on its own AFAIK.
>
> The docs for copy_safe_from_sockptr() that you've linked contains the
> exact misunderstanding that Michal is correcting.
>
> >
> >> Shouldn't this be:
> >>
> >> err =3D -EFAULT;
> >> if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
> >>         break;
> >
> >
> >



--=20
Luiz Augusto von Dentz

