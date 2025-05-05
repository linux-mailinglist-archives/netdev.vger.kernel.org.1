Return-Path: <netdev+bounces-187758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFEAA9893
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197D43B27AE
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E1B19D09C;
	Mon,  5 May 2025 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ssPH/cjs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6D182
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461744; cv=none; b=qiRuOT4u8u6Kw7vWbaYnaT0kTW85PYGORU366kMXj1Lya1KkOeE1f5f4EFvxtAxTD9pyA1uKhGtEYzj2f5tRABXTtiot/Js5gtWd9oZOMGMhpYrMVjgcF+m2EoarPbGbT9WZGu98nS6kh8HVqwj/qpITVIkz4Tku7Dbb0EyvLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461744; c=relaxed/simple;
	bh=RX0/dQkILWgtfe24wxeWKn8PuIXSomVisH7hoYyJatQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXsvMAHucYh7Gp2WZ+ht20ux0Of8P8kzC1BFLOHJIuyrpAjyhDqdR0XTbUfjKQOsk8YuRCMVzGHVMztcqbrypGNRrXbJjuHZJZtalmj6UZjxSznbhVBlbFeBfDH8gWjVy8TnofbuwBvenBfwfbSsNva+trzpIlBNA6X2k6xKbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ssPH/cjs; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tikh5jmWQ3/lk6fBQXDrEBdjIfUJM9dZn/TENNrBMcA=; t=1746461742; x=1747325742; 
	b=ssPH/cjsKtKSL5wtIPMZfT3bddJX95QRcyrjB8EGmmUi0i569yViWzi1UUhHpt12/20AIYQOTYa
	B5e6ouBRM3NKR5e+oaJWnwdJ2TTxK64CHxo6/zzUw6LskpCPJWuAOtGNlE6OzrjA2SGCTtXRVxKIG
	6GH4ab+RkuSKhJpgLlsKAz6UC48ANvBQjPqcykyqgkEPzkBoS9Ee9kELHEB+VtC+Z467nPCcxvLmZ
	Xy5z/DdAtOXBkhNurP7znW8DOLIgC1fwrZrOtm89uQdJfCrh8wamHmTUbWHiLVMUhmTR4GoFygVKz
	l9gq6uwdo08bPWznZqQ1b9HZd+cNRDx+gKsA==;
Received: from mail-oo1-f52.google.com ([209.85.161.52]:44435)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uByTe-0001z1-PF
	for netdev@vger.kernel.org; Mon, 05 May 2025 09:15:35 -0700
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60402c94319so2945809eaf.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 09:15:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yze43+2ksZZoNZ+wfluXOmeBCOajYd59Gzd+XWqNiCZYeJ8GqUA
	2R/wm59UQct1hfaO69I8+PLIYZwve4mxAUC1dDQtzGUiZzjZR7mUdsMM+27MJq8oT4yjGoU6QWH
	27Sl4jh6rQt77+5Au7pfrPM9eLS0=
X-Google-Smtp-Source: AGHT+IHXvUuOJPKhd/Q9uaOU13rY/xsFskynHMn4BONKnIWsZAamAYOmZPUwpya3ej8Z0Hd6yerJjSuZn/BrtoVXzkM=
X-Received: by 2002:a05:6820:188a:b0:607:e15c:be07 with SMTP id
 006d021491bc7-607ee8702e6mr8656437eaf.7.1746461734178; Mon, 05 May 2025
 09:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu> <938931dc-2157-44c8-b192-f6737b69f317@redhat.com>
In-Reply-To: <938931dc-2157-44c8-b192-f6737b69f317@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 5 May 2025 09:14:58 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzqj3V=gubPBAH=zpNmHnW7g2Wk8mQ8=4wGhcJ9AsYb_g@mail.gmail.com>
X-Gm-Features: ATxdqUEEAyCYUvJTQR-DK58qiZTxI9cSMkM0yn5PhK9NVbO8Df5AJo85VkKFqzI
Message-ID: <CAGXJAmzqj3V=gubPBAH=zpNmHnW7g2Wk8mQ8=4wGhcJ9AsYb_g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for Homa
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: cb5916722246bf80bd9488153e8e2604

On Mon, May 5, 2025 at 12:55=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/3/25 1:37 AM, John Ousterhout wrote:
> > +/**
> > + * define HOMA_MAX_BPAGES - The largest number of bpages that will be =
required
> > + * to store an incoming message.
> > + */
> > +#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - =
1) \
> > +             >> HOMA_BPAGE_SHIFT)
>
> Minor nit: the above indentation is somewhat uncommon, the preferred
> style is:
>
> #define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1)
> >> \
>                          HOMA_BPAGE_SHIFT)

Fixed (I only recently learned of this convention and have been fixing
noncompliant code as I find it)

> > +
> > +#if !defined(__cplusplus)
> > +_Static_assert(sizeof(struct homa_sendmsg_args) >=3D 24,
> > +            "homa_sendmsg_args shrunk");
> > +_Static_assert(sizeof(struct homa_sendmsg_args) <=3D 24,
> > +            "homa_sendmsg_args grew");
> > +#endif
>
> I think this assertions don't belong here, should be BUILD_BUG_ON() in c
> files. Even better could be avoided with explicit alignment on the
> message struct.

This is a user-facing header; is BUILD_BUG_ON OK there (ChatGPT
doesn't seem to think so)? Also, what do you mean about "explicit
alignment on the message struct"?
>
> [...]
> > +int     homa_send(int sockfd, const void *message_buf,
> > +               size_t length, const struct sockaddr *dest_addr,
> > +               __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> > +               int flags);
> > +int     homa_sendv(int sockfd, const struct iovec *iov,
> > +                int iovcnt, const struct sockaddr *dest_addr,
> > +                __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> > +                int flags);
> > +ssize_t homa_reply(int sockfd, const void *message_buf,
> > +                size_t length, const struct sockaddr *dest_addr,
> > +                __u32 addrlen,  __u64 id);
> > +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> > +                 int iovcnt, const struct sockaddr *dest_addr,
> > +                 __u32 addrlen,  __u64 id);
>
> I assume the above are user-space functions definition ??? If so, they
> don't belong here.

Yes, these are declarations for user-space functions that wrap the
sendmsg and recvmsg kernel calls. If not here, where should they go?
Are you suggesting a second header file (suggestions for what it
should be called?)? These are very thin wrappers, which I expect
people will almost always use instead of invoking raw sendmsg and
recvmsg, so I thought it would be cleanest to put them here, next to
other info related to the Homa kernel calls.

-John-

