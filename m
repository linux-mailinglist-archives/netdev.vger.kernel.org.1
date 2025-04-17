Return-Path: <netdev+bounces-183909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE5A92C83
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768AB1B6427B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCF205518;
	Thu, 17 Apr 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xBL/+5MS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16531205ACF
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924077; cv=none; b=TbhvPIsxYN4q+ETUu2HsMyBGcqoa+N6skTBjBHhK3yLeOx2KHELMu2nE92dLarAZqfzeX+73/P6LPvzUGh7ItpNdeQcwD59+HxVKPv4OHoFjULgjlNS44P0pC4Qtsaz3lWdYbV9Hu2R15LrmbZsAdJ93HjhozF9Jyf384bMATJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924077; c=relaxed/simple;
	bh=9mlQV7jXCR5734X2Y8Vfk2EFfOtyPoCEpPTeELEZ4B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXvfgKyhh7DQpNg0LTH+0JQRWCZJd6qfYB/EWM3H3p32Qsw7CWCKdiH/Z8nGqRv5V9VBRRujLe3QQgEWlAHGrhI4La0AkePodw/mEG+hezyCvjroYsUpdP0YJ5GnTzeZkZpmeArfA6xCgJHsyKp8fBP2M/ArVpuNW8TE3Xd7y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xBL/+5MS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so69625ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744924075; x=1745528875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mlQV7jXCR5734X2Y8Vfk2EFfOtyPoCEpPTeELEZ4B0=;
        b=xBL/+5MSB/c9oZLeudzASrrgyjdEPH9o+ghLOX232BuNOCMA13t2fWZOcDTAAGg/Z5
         +Wbda+ZDu13BPYYgO09KDVAkhZpetL60CjU2BpeBRJ69sC6WSr9u0jiTMLhlo8p3VjZw
         oEF4PMtdo0NrhSlgNSWqtuJqBrpwkufbYpNItLKZ1P+8pv3/UuVGu+2pdc3dCH+JPkZ+
         +kU7nPa1M/NdG/aKhOtEV/RiLddpeHIGyIm3wbleoZzsheb3CuREKKAralvlHZsUM6JJ
         XvvvdihT4NAIPEeVdTDuf/Y9tfHYSgaH9pfxTPC4ACHZFoOP3n9EL9uws5PFxeHp2waw
         gpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924075; x=1745528875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mlQV7jXCR5734X2Y8Vfk2EFfOtyPoCEpPTeELEZ4B0=;
        b=qHhwL2ii8kNLqjn4F3S3T18CytjEcmUWT4javRJXxhM8DujLrj4h8HdIeklaBp5vb+
         NdblZyuUL8HfLpgdcmm+f2gaNpPcYcL4Q9HZt2WWiCRPnWNEMqVED9gSObtQlPUg9Mb0
         oCBh/UljK31CVUM0M0d4gndjhS0pRVXntxW/1JloSAcINwHvVrHVPe5256rKzSnNhWEm
         3ic0tr5EjEUWKoc1JTPUcUhyuE1SOjIMIdellvR7i/3umZpqL4pSj4gSUlswiEXBb4XQ
         vl0xM2z+6p7gC91/7WEq7webrP2usmiII2Z4ECUggyr/ZqbyRLac+1D3DZ9ViJgBb2B8
         PAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWokaq/6N/F8gLo9sSs6ixPG6PwLn5wJC4IlnWInpa93oZJdIAxzAXyvC0I/4ciP+r1AbbiEsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH10ebsZ8V/cdcSrmeqGPcedCKlANfUzc/tyVQlN2rtoelBTFZ
	nzuGF3dngnNTb2W7yrc0Nwc8sW3ZfPDTWWYljXy7IhcXXkGENdG95DN6WoM/86aoRzM3eMMjB06
	HfuCOkSwg8pN4AO9CCXi11wiE+accJvY1/Dr7
X-Gm-Gg: ASbGncs60esA5NcxIw/9xOPGycktF16FCaCYbMPwuNpwZ6VTiZYnPMbFklMYfLItFax
	C9zCtBzNvAPuQWkDvO0nj0IKI0uKz9A/QeosGIkrQDakscQ/IXKbnUR7HDzW1p5fOQ56O96fWIT
	t+/eOtu8TuEXxTYkJhNimb+73l16LiiWjpKDkN+eBTOaWmwso7MZiQ
X-Google-Smtp-Source: AGHT+IHfKVHof05jOt0n+1aMQU2lspEgjP6ZsKd7ahPP920bbcyObiUISa2rIT7lFUyL0dlebej29z7fYvSW8zu/qzg=
X-Received: by 2002:a17:903:1a0f:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-22c543bd948mr190135ad.1.1744924074972; Thu, 17 Apr 2025
 14:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
 <CAHS8izNUi1v3sjODWYm4jNEb6uOq44RD0d015G=7aXEYMvrinQ@mail.gmail.com> <20250416172711.0c6a1da8@kernel.org>
In-Reply-To: <20250416172711.0c6a1da8@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 17 Apr 2025 14:07:42 -0700
X-Gm-Features: ATxdqUFe-SVhJnOj_kjIbJNoJO2VKzbYn-RGHq_mHmvmP-RjXviJ2JDMtLz25NI
Message-ID: <CAHS8izMV=0jVnn5KO1ZrDc2kUsF43Re=8e7otmEe=NKw7fMmJw@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 5:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 16 Apr 2025 08:47:14 -0700 Mina Almasry wrote:
> > > Right, tho a bit of work and tricky handling will be necessary to get
> > > that right. We're not holding a ref on binding->dev.
> > >
> > > I think we need to invert the socket mutex vs instance lock ordering.
> > > Make the priv mutex protect the binding->list and binding->dev.
> > > For that to work the binding needs to also store a pointer to its
> > > owning socket?
> > >
> > > Then in both uninstall paths (from socket and from netdev unreg) we c=
an
> > > take the socket mutex, delete from list, clear the ->dev pointer,
> > > unlock, release the ref on the binding.
> >
> > I don't like that the ref obtained by the socket can be released by
> > both the socket and the netdev unreg :( It creates a weird mental
> > model where the ref owned by the socket can actually be dropped by the
> > netdev unreg path and then the socket close needs to detect that
> > something else dropped its ref. It also creates a weird scenario where
> > the device got unregistered and reregistered (I assume that's
> > possible? Or no?) and the socket is alive and the device is registered
> > but actually the binding is not active.
>
> I agree. But it's be best I could come up with (and what we ended up
> with in io-uring)...
>
> > > The socket close path would probably need to lock the socket, look at
> > > the first entry, if entry has ->dev call netdev_hold(), release the
> > > socket, lock the netdev, lock the socket again, look at the ->dev, if
> > > NULL we raced - done. If not NULL release the socket, call unbind.
> > > netdev_put(). Restart this paragraph.
> > >
> > > I can't think of an easier way.
> > >
> >
> > How about, roughly:
> >
> > - the binding holds a ref on dev, making sure that the dev is alive
> > until the last ref on the binding is dropped and the binding is freed.
> > - The ref owned by the socket is only ever dropped by the socket close.
> > - When we netdev_lock(binding->dev) to later do a
> > net_devmem_dmabuf_unbind, we must first grab another ref on the
> > binding->dev, so that it doesn't get freed if the unbind drops the
> > last ref.
>
> Right now you can't hold a reference on a netdevice forever.
> You have to register a notifier and when NETDEV_UNREGISTER triggers
> you must give up the reference you took. Also, fun note, it is illegal
> to take an "additional reference". You must re-lookup the device or
> otherwise safely ensure device is not getting torn down.
>
> See netdev_wait_allrefs_any(), that blocks whoever called unregister
> until all refs are reclaimed.
>
> > I think that would work too?
> >
> > Can you remind me why we do a dev_memory_provider_uninstall on a
> > device unregister? If the device gets unregistered then re-registered
> > (again, I'm kinda assuming that is possible, I'm not sure)
>
> It's not legal right now. I think there's a BUG_ON() somewhere.
>

Thanks, if re-registering is not possible, that makes this a lot simpler.

> > I expect it
> > to still be memory provider bound, because the netlink socket is still
> > alive and the userspace is still expecting a live binding. Maybe
> > delete the dev_memory_provider_uninstall code I added on unregister,
> > and sorry I put it there...? Or is there some reason I'm forgetting
> > that we have to uninstall the memory provider on unregister?
>
> IIRC bound_rxqs will point to freed memory once the netdev is gone.
> If we had a ref on the netdev then yeah we could possibly potentially
> keep the queues around. But holding refs on a netdev is.. a topic for
> another time. I'm trying to limit amount of code we'd need to revert
> if the instance locking turns out to be fundamentally broken :S

OK, no need to hold a reference, please ignore that suggestion. Thanks
for the detailed explanation.

There are a lot of suggestions flying around at the moment as you
noted so I'll refrain from adding more and I'll just review the next
version. Agree with what Jakub says below, please do send Taehee even
if it's not perfect, this may need some iteration.

--=20
Thanks,
Mina

