Return-Path: <netdev+bounces-188548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2FAAD4A2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4652C1BA719F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D95C1D8E07;
	Wed,  7 May 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCBYDu8o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EA71CCB4B
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593759; cv=none; b=LjZKf0P0b/cOf0GNMOOSeJ6DCLuAldMGyD/qs6EebgEoHIhhGQbfwpARqngg//PySDvPxsz4W8U8d/UsCgBApNR002qPntfLBUNZI1ykaBnMpFZDm5ymaTprcl79l+YL3KWmA7vpXATmsPhsDLy2BMDka1PY/RBg1KOxUKztk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593759; c=relaxed/simple;
	bh=1r1xSJkLVHQf0qBoxkgFF271MkROdUBJRavtLRhm4wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWJIMBppjYmEzxzQ4zO4H7R7176+Y3phOJriWxJPbYAFo/vzL9kF0df9JDs9Ww/K11FAWe4I5UihpZd2aVHk3oxJTvW/aoU/ujROQE7SMCZuWIiK6IGXhU0GPSXtgzQgUERe8Z+R8hL8ivA/TsJ1hXNHPD7xZy3i4lJfxzm/ieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCBYDu8o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbf29d0ff1so257427a12.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746593756; x=1747198556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIXb84AI6REv64D0Hg8TlF/Rz/6umpvzbQF067/KzT0=;
        b=iCBYDu8oQsl5oZ16QO3ddtf16Y0Ea4ZSP+qc8iE2d+9YSwGn1awLrZx+/IccdJ+2hU
         g/IVHh2bklN4zdJq+SXK7y7gsPpH8UX89/AEhqosheA6DflxDvDiDdvXu52CfGGfOnFl
         CpG0/+gqqgI77UpVP06pVvdaxqTT4nOlOSl5xgAVe3HVR3Bx9MZcrhWjQeKZbq3v76Xj
         cpBM7SiImpXs0s9veTHA9vflwksA2LwRerXrEABW+IVFltum/yY6yt5NXTEf24p1MjN0
         RBgm8HI6eITLYJYJT2Mye4kMg2CO7DCfvXtCHppROk611q3Ahe/9ew0IwmRVZ43eyNFI
         QiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746593756; x=1747198556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIXb84AI6REv64D0Hg8TlF/Rz/6umpvzbQF067/KzT0=;
        b=GBEIkzpaEF199L4aLegit/WHw4MW14rPHg5QZNkrvnzzj593WsDja2qPtUsjfax0Lm
         jaTREYRF37wxNnbA2GB1FQaC2x8HRsLq36xviC/UyKYwV+AHFIhWdjYaShruGXeyhUu8
         2+IlmPSJ5/jsAo9WxWyWifTUWORoQQAyDgClePNgefOMvgcH+o9EbsIGoKIpJVz4vMA8
         oquqE/X+eklfr1m+r4pW0K9R6aEM6BFEova0xUFHUDhzDYOKT5M0UJQgviQNj+LDRi8d
         KIM3+MN44McldUjQfngBvDkptiiBQ9aKkoOGIxyStANWMrgjbTHYNlcSBKGO4lmd2F+s
         VrMA==
X-Forwarded-Encrypted: i=1; AJvYcCUvD007cLJvMTEnb/rv+7Pzg4MRMl/NogRW6RRqnbcmEXDGr+NHdPZNtTLdatqsq9qCLIcYMC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1f1TEaehG3QXU2SWBMVzyC7h6DHE8rq2NuAGbiqTSK38TgE5L
	bnrX76R+pC2RTJ8+R3sDymSQOY3IXfoDrAtu/ksMnjRbSDUVxqp4gfAGbGkrtJxhuw1WImY3atN
	BpFvo8jhEZ4uX2QxZTRxShojvNPg=
X-Gm-Gg: ASbGncvLh79oivWwOb5P73n3Q5PMQ6Lj7bjUVAjbuKgGQys/RHt9bEUbPILJFkpioxN
	ieUcBno+rOAOv3EUjhh9jeF95vKexBoUOq0/ATZQEsQIVpUpLp16ECvUyKrg0qIPqvhI7azSdqH
	kMbNmdtcMPwKnE8vUoarrXjSg=
X-Google-Smtp-Source: AGHT+IF0JghBmq2QnJYhLMxmt3Qfy2ByU/N6BAqNldbrHYUAcOtGLbUDtlJUxK+dbbYT32LwlwB112c29eItL2EUMb0=
X-Received: by 2002:a05:6402:2348:b0:5f7:f52e:ec93 with SMTP id
 4fb4d7f45d1cf-5fbe9f6a37cmr1259482a12.31.1746593755722; Tue, 06 May 2025
 21:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506140858.2660441-1-ap420073@gmail.com> <20250506195526.2ab7c15b@kernel.org>
In-Reply-To: <20250506195526.2ab7c15b@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 7 May 2025 13:55:44 +0900
X-Gm-Features: ATxdqUHXy8izfvK4qlrOa-P9UAWmOGKFQnwqDebpDDpI423pq0VyNN-PtbD9tvE
Message-ID: <CAMArcTUx5cK2kh2M8BirtQRG5Qt+ArwZ_a=xwi_bTHyKJ7E+og@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com, 
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com, 
	dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 11:55=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  6 May 2025 14:08:58 +0000 Taehee Yoo wrote:
> > +     mutex_lock(&binding->priv->lock);
> >       xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
> >               if (bound_rxq =3D=3D rxq) {
> >                       xa_erase(&binding->bound_rxqs, xa_idx);
> > +                     if (xa_empty(&binding->bound_rxqs))
> > +                             binding->dev =3D NULL;
> >                       break;
> >               }
> >       }
> > +     mutex_unlock(&binding->priv->lock);
>
> Why do we need to lock the socket around the while loop?
> binding->bound_rxqs have its own lock, and add/del are also
> protected by the netdev instance lock. The only thing we
> must lock is the write to binding->dev I think ?

I intended to protect both binding->bound_rxq and binding->dev.
But you're right, xarray API internally acquires a lock.
Only binding->dev is protected by socket lock here.

>
> Would it be cleaner to move that write and locking to a helper
> which would live in netdev-genl.c?

You mean that the socket lock is not required to cover whole loop
because bound_rxq is safe itself.
So, it acquires a socket lock only for setting binding->dev to NULL,
right? It makes sense to me.
Making a helper in netdev-genl.c would be good, I will make it.

>
> Similarly could we move:
>
>         if (binding->list.next)
>                 list_del(&binding->list);
>
> from net_devmem_unbind_dmabuf() to its callers?
> The asymmetry of list_add() being directly in netdev_nl_bind_rx_doit()
> not net_devmem_bind_dmabuf(), and list_del() being in
> net_devmem_unbind_dmabuf() always confuses me.

I agree with you. I will change it in the next version, too.

>
> >+      mutex_lock(&priv->lock);
> >+      binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv, info-=
>extack);
>
> We shouldn't have to lock the net_devmem_bind_dmabuf(), we have the
> instance lock so the device can't go away, and we haven't listed
> the binding on the socket, yet. Locking around list_add() should
> be enough?

I agree with it.
If binding is not listed, it doesn't have to be protected by lock.
As you mentioned, I will try doing just locking around list_add()
in the netdev_nl_bind_rx_doit().

Thanks a lot!
Taehee Yoo

