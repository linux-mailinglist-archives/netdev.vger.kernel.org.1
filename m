Return-Path: <netdev+bounces-187807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE83AA9B13
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583AD17E5C8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687326C3A4;
	Mon,  5 May 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Hg3jJaIL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD0199931
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467591; cv=none; b=urLeAzkDGxwxvMugmvXmEQNsjKaGvmqF2YjQLnt+NDKdp2qvcJMlj7hZWkZELo27f5XqObt4mmTgN1juLfYx258IGjLCMARWdlU6epHoPWQT2PUaSifN7+DOEpLYPgJMs8+i0dn7bYZdp1lcfqu0CcSKqSLBuksD4jdopJevngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467591; c=relaxed/simple;
	bh=efNZquut4+9lZQufvATWrejGTyXtxT8Ei34p0JEOSrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ka9TPu8zI0ubt3/ZAvSpjp9bZrTjjHWHvodz2KP3S8i3JT4egpdNjxXKuycG+FJZoboqYE4Iuh2Buc6s2CDwjtrW2KC18i4AFzq2F3ykhQwksh1+aJAZU+K2ZpgAVEpZ9BIDfRtzThU2QQcQYFYbg6blwJIImp9ofdPs3pXxyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Hg3jJaIL; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bYnPpxrMlH6TUUSukQ5Al2s5BnBkDvWVQ6bEwFo6Csk=; t=1746467590; x=1747331590; 
	b=Hg3jJaIL0NjYKlFRg/+rzVd/MyOcNcOEw/cSHBJOaWAfgSHPrUb3gTKW+f6eM45j3yZ8QVXplAV
	F+P4ym+u0suAR6Mj0XWy12oKYywHssR0NtQTaPVVUr6TywXqHesvU6e3O4bXeAILGDi3ltIwNHsaX
	AoU6i3lZlQyaiXkPUHT5LG1UEyvduuQHMZ8AhL+3QSysBdBCF/bPXs4siGSstkPRbjr6u/5G/Y3ml
	OelXfDvPeUuYuikMMJxTW+LjPeHNuYCT99a/d29Otb7gE6fKc9hLidNUmMwbo9gCN7CQOpW39F+wb
	n4aQTjl3xpFxkgTXVYuV/iUGCDvSZjRBQm7w==;
Received: from mail-oo1-f43.google.com ([209.85.161.43]:54625)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uC004-0007Vo-RA
	for netdev@vger.kernel.org; Mon, 05 May 2025 10:53:09 -0700
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60634f82c77so1296380eaf.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 10:53:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpbg0EBh1UZocmWeawpIfJ8M2lKaUF0kmMMfRyzBMv360XzWUg+QhgcLbbNdtrp4uIGTJQhf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0BgFEXqUtXq/tTFqrt0IZNG2m6uAJLf1uxb9oTTMt9QYDZEL
	6SOBS/2oCEG5y4VIskgKRyaC7K+RhCqwhqgXTcbyn38gh2Ku2MOXFYdvmW60zZJHlpl9v4wTTu9
	BmHk0yF3B32Jrt394zUlXfSko524=
X-Google-Smtp-Source: AGHT+IHERwajXBBpROgo8vZtiz1kufhrc3t2uzXB7yurCE15f17QMrLzfWUPuopRY/Y+r4VKc351ElhYj+WK+shWi5M=
X-Received: by 2002:a05:6820:4c87:b0:603:f191:a93b with SMTP id
 006d021491bc7-608002bc780mr6730847eaf.1.1746467588273; Mon, 05 May 2025
 10:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu> <938931dc-2157-44c8-b192-f6737b69f317@redhat.com>
 <CAGXJAmzqj3V=gubPBAH=zpNmHnW7g2Wk8mQ8=4wGhcJ9AsYb_g@mail.gmail.com> <56dfa989-92b9-42c6-afbd-c5eefcca42cf@lunn.ch>
In-Reply-To: <56dfa989-92b9-42c6-afbd-c5eefcca42cf@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 5 May 2025 10:52:30 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxNsvfdJP9QYwR+8mQesSvNpKKpMW4H8J1ELmi0i9jn5A@mail.gmail.com>
X-Gm-Features: ATxdqUGGHJFlqNZaUsOKWkKKCnP49PC_VgCCyqHietEpLgLfBHyS8mZZI-OOwQQ
Message-ID: <CAGXJAmxNsvfdJP9QYwR+8mQesSvNpKKpMW4H8J1ELmi0i9jn5A@mail.gmail.com>
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for Homa
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 078eb853d78558c6c655f7b6c94b391a

On Mon, May 5, 2025 at 9:48=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +int     homa_send(int sockfd, const void *message_buf,
> > > > +               size_t length, const struct sockaddr *dest_addr,
> > > > +               __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> > > > +               int flags);
> > > > +int     homa_sendv(int sockfd, const struct iovec *iov,
> > > > +                int iovcnt, const struct sockaddr *dest_addr,
> > > > +                __u32 addrlen,  __u64 *id, __u64 completion_cookie=
,
> > > > +                int flags);
> > > > +ssize_t homa_reply(int sockfd, const void *message_buf,
> > > > +                size_t length, const struct sockaddr *dest_addr,
> > > > +                __u32 addrlen,  __u64 id);
> > > > +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> > > > +                 int iovcnt, const struct sockaddr *dest_addr,
> > > > +                 __u32 addrlen,  __u64 id);
> > >
> > > I assume the above are user-space functions definition ??? If so, the=
y
> > > don't belong here.
> >
> > Yes, these are declarations for user-space functions that wrap the
> > sendmsg and recvmsg kernel calls. If not here, where should they go?
> > Are you suggesting a second header file (suggestions for what it
> > should be called?)? These are very thin wrappers, which I expect
> > people will almost always use instead of invoking raw sendmsg and
> > recvmsg, so I thought it would be cleanest to put them here, next to
> > other info related to the Homa kernel calls.
>
> Maybe put the whole library into tools/lib/homa.

After thinking about this some more, I think I'm going to just delete
these functions. They don't add much value and they create some
awkwardness (e.g. there would need to be a new user-level library with
their code).

-John-

