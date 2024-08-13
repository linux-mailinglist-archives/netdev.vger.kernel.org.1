Return-Path: <netdev+bounces-118051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61995065B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B842B25BE3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199619B3C4;
	Tue, 13 Aug 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge1LNCQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE419ADBE;
	Tue, 13 Aug 2024 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555361; cv=none; b=QARWn6tP7DH2xuFKeUrc8DNU6bY6pJ/HHg1NJdHfiNm16svK4kZsqwqISMc5dqjHD55wTKytwM/WrLZa30ygrsQItdY5ydAfXvuoiGpJjebVo6ZA9dGYh7xUTE26sypWY0zRiCxVncoqQT/8zuuVMaFQfWU9ww0/2rcWxG0Lwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555361; c=relaxed/simple;
	bh=t37IbrI0SmClR4kXYdS8rSEW9SNNFFJf+Irl+n7NehE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OLuOEhZbBpMDFwtElb5bkD1Y7fxn84GAb+L4unAyGlGn7x+YYPJNx+cm2Gmc15fjef8JTvGuvs00zTo1xIOhGzgSL9hXYLq8sP9XXRQYbvGmf9x7BFyPnhvz0Tw3ScUZ47Sd1IhUXagjXyMEBm2EeHFfajacSydswnUfLXYRNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge1LNCQt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7094468d392so3168001a34.0;
        Tue, 13 Aug 2024 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723555359; x=1724160159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t37IbrI0SmClR4kXYdS8rSEW9SNNFFJf+Irl+n7NehE=;
        b=Ge1LNCQttmlQpNR514CwW/lTRghp79izuVkK6ErCZsXk9jw8bdgL+KPDjXZd+FU2YJ
         rFVGRklsS+k5HlPgi6Hspn7x3r3dee8iUK/pTOqgHzGkLjR1vE2iyQN0VAO3RPfEtZ/n
         HObr6Vd6qpTEJi/zEdZ6OK1dKRvdGkXNMlkkGA0J/nC3wBaFEZScDEK/cXAXel0jLYqV
         zjx3FxDNUe/eDVXCzghgTn409mfHq7QCWgq+Srg4OnmnlcCMGnntdlGqbJsbI4Ib5SiJ
         Elu2BZKLyQ+pAVzVu8NFYdA38T+dcJrX1dsWmT27aKqfXacYX8Atd0bAyGtrHQmfu7h8
         GlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555359; x=1724160159;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t37IbrI0SmClR4kXYdS8rSEW9SNNFFJf+Irl+n7NehE=;
        b=ZuIpZEzJ8eW90tHQM/OJz4sS6qeEahQhWeviUE1lnJYeRKrdpJiEeg+hQkQuFGxhIN
         TKNtwiqJ37sc/LAgSh5ohMwctMvb6ZehPsCoF85NkQ1IzQoe2jkeEgu4x88/M/TOdM1P
         6HUUMmtahp96IlCOEoMTaxuOrVva/DBVTU/TwG1+mJK2yNse6NesadIw50x9l3YuvY3O
         CYxxvJgXu3gjFgW51ROzqzgIiojoNVPuHJOlEF2Eic9cG9wP4lOuHYl6HbwKbROdu85D
         qIUhvQYpG8GrxbRGudcvINBu0eyHBRNsjnkGvUa5js3sQcHcaB3sNtQN29NmMoDpEOy7
         F13g==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ/2nFq8PsNOP3bkoXmwhYEZoQS863rgnh3vdJ1jKyZnRC4WNxKbqJ73D4av1dkJcnvS/Z8tFlhIfOcrYDACAlhzxEtM8eAPtMxYwMxdWa9I0G2qQT8Db+FM133tWK6PZb33I
X-Gm-Message-State: AOJu0Ywet/TukCSS7zshg8X4MT10axL4lx71ZeffBwI6CmbTcc6GqU4E
	+oZtI/dtpkyx5s0rrcikksN72QRc0QGK7Wgr1KeffH3YRBIrK2z3
X-Google-Smtp-Source: AGHT+IH/Qf0k+m2iDASHI3SyiGgcxfMIpa9nxLKjcPsxqqH2z1dqv+idi8LfQ5+2St8Nx0gIy5dVLA==
X-Received: by 2002:a05:6358:4195:b0:1aa:b9f2:a0c4 with SMTP id e5c5f4694b2df-1b19d2c578bmr442506955d.11.1723555358669;
        Tue, 13 Aug 2024 06:22:38 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d6e49bsm340232085a.32.2024.08.13.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:22:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:22:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: ayaka <ayaka@soulik.info>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org
Message-ID: <66bb5e1dbf778_6ef1329466@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEt0QF0vnyCM5H8LDywG+gnrq_sf7O8+uYr=_Ko8ncUh3g@mail.gmail.com>
References: <CAF=yD-JVs3h1PUqHaJAOFGXQQz-c36v_tP4vOiHpfeRhKh-UpA@mail.gmail.com>
 <9C79659E-2CB1-4959-B35C-9D397DF6F399@soulik.info>
 <66b62df442a85_3bec1229461@willemb.c.googlers.com.notmuch>
 <CACGkMEsw-B5b-Kkx=wfW=obMuj-Si3GPyr_efSeCoZj+FozWmA@mail.gmail.com>
 <66ba421ee77f4_48f70294e@willemb.c.googlers.com.notmuch>
 <CACGkMEt0QF0vnyCM5H8LDywG+gnrq_sf7O8+uYr=_Ko8ncUh3g@mail.gmail.com>
Subject: Re: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue
 index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Tue, Aug 13, 2024 at 1:11=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Wang wrote:
> > > On Fri, Aug 9, 2024 at 10:55=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > ayaka wrote:
> > > > >
> > > > > Sent from my iPad
> > > >
> > > > Try to avoid ^^^
> > > >
> > >
> > > [...]
> > >
> > > > > 2. Does such a hash operation happen to every packet passing th=
rough?
> > > >
> > > > For packets with a local socket, the computation is cached in the=

> > > > socket.
> > > >
> > > > For these tunnel packets, see tun_automq_select_queue. Specifical=
ly,
> > > > the call to __skb_get_hash_symmetric.
> > > >
> > > > I'm actually not entirely sure why tun has this, rather than defe=
r
> > > > to netdev_pick_tx, which call skb_tx_hash.
> > >
> > > Not sure I get the question, but it needs to use a consistent hash =
to
> > > match the flows stored before.
> >
> > This is a bit tangential to Randy's original thread, but I would like=

> > to understand this part a bit better, if you don't mind.
> =

> Comments are more than welcomed. The code is written more than 10
> years, it should have something that can be improved.
> =

> >
> > Tun automq calls __skb_get_hash_symmetric instead of the
> > non-symmetrical skb_get_hash of netdev_pick_tx. That makes sense.
> >
> > Also, netdev_pick_tx tries other things first, like XPS.
> =

> Right, using XPS may conflict with the user expected behaviour (e.g
> the automatic steering has been documented in the virtio spec, though
> it's best effort somehow).
> =

> >
> > Why does automq have to be stateful, keeping a table. Rather than
> > always computing symmetrical_hash % reciprocal_scale(txq, numqueues)
> > directly, as is does when the flow is not found?
> >
> > Just curious, thanks.
> =

> You are right, I think we can avoid the hash calculation and depend on
> the fallback in netdev_pick_tx().
> =

> Have put this in my backlog.

Great. Thanks for taking a look at that Jason.

It may very well be that standard netdev_pick_tx does not conform to
the virtio spec behavior. But if it does, nice simplification.

If we have to create a variant that takes a bool skip_xps, that's
totally worth it.

