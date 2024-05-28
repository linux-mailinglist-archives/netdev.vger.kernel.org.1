Return-Path: <netdev+bounces-98488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3C8D1964
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A75281F90
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82ED16C684;
	Tue, 28 May 2024 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2k2eeg6O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE4182B3
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895681; cv=none; b=qZ/Kz4hvzbkbFija+8mHPv4Ze3z1g7XRzspMPm0ffRUT6e/TiYhoqG/ZmA0cmIwO2y2XZKUpHGqwXeRHJM9VsN8TfMrrxdt7RXB7hugtqN1xVE2W0y4A7C2SO47nETbn5IkiI8ImWM5DR+uRtkiK1NfYqQ1LwvyL92uLSOsV3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895681; c=relaxed/simple;
	bh=gT0wOBcsnBOHm+12Oq9ERzURyIX2UV+/gv+87nNwFaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrzbVKy7xR1hE0xcKIMS6nOJ+f3x6RRL3xmKVy55cry4ptiaem89a7Prr+swn8tQxjhNwUl1XGDSefvChv56NmMOh2h0UylKRJDNGWZ0+UxieW9WWC0hliSfuX3Wb5oEbffkznnuxkO4/6x/YYDDbXwGnbQ34GYoHOB+vW/sFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2k2eeg6O; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so27327a12.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716895678; x=1717500478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcOs7aWhKuWkRGBu1QsCf2UxmMDJEzNbk4usBhwm4V4=;
        b=2k2eeg6Oe0LgO4ovAU7SEwlJCMhkyESm/cYIJG2Rs5XCI+CIoc7cnwqI8DbyK83GC8
         hr4Z/jKrixvQmK+dUhxA8A7cSQEve9jFTfJnfHvLGDefLxu+rHIBPnFPgC3+RAlFGVbe
         9GAPWiVFWJWwmO8sXcEyvDFTrKb92YVJVplxWwupMEkuHVeblOPjsg4nqPrq3GDh6iYG
         yM3bn24QKCQw5TxBJLy4h0CPKF/wdvfaJySk6rr6vf47NHSYiwfJ0v+surVYiKR1IwwV
         G4QzVHE4C2mWDClg+vHRbm5kFOYvDEzHc8YAVvcX1msDUod0KGv/Ojv/2fKR6yGW79qk
         wVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895678; x=1717500478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcOs7aWhKuWkRGBu1QsCf2UxmMDJEzNbk4usBhwm4V4=;
        b=b7N2qyGjWMFitvChMYv+0hsBONICQBR5n6+kgn2f33OszYU3hf5menszQfdNFDwSHr
         yjcCHJv+7Kek745hXettRaALHUC+6KTmNiY7c7BM2bgirYCgYa/nL+zzt8oa/od9229U
         DHjSsz6ow0/In7VSQsUf7S7K44/FZ97k/+u9d70kTn5grNC3lG25A9wM6JUs4gqVoyL8
         6RdOc8Db7PP9a280A5kt5iX8LRsn5f2T4IDbD3bNVncbtWJ/Xcz3Gslsam7hZreWA68v
         QwW0zYjwsOqTzV6lXv1WZlNtnmZEWncIS2dWFM2Zj3BttUVFOTrzC/pnXsdEHZBfWPa6
         E5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULEGNQouBS4ybyybfDW/Yh9iiZ+UAbwjnTcD20jDwAzOfEeIL6Ue6msxbhwhlX4FcqvQ761lLYQs7Ya9zqsfxVVfZkMgPq
X-Gm-Message-State: AOJu0YyetoT0G4BsWLYpLmIChVDKyhYWYSnVzKu9vy+sbPJUDRrlbPd1
	B3fhE91UzP4DHOuBJ5BylbcZCBOGr40nuG2dZ32YE6ISoy6HOaiujRCg4brmbLZP4ZPqjLYayad
	P3DpMOmTfkXV2EbuJpi1JruyovR1AviLNNlbn
X-Google-Smtp-Source: AGHT+IG06KbD8naAgTu55ochegQJ8gBMdkWhz6xZEfoPqExKgRsF/Mj3tDaI8P2gIlruGZhC/FvntKGthICO+K2duug=
X-Received: by 2002:aa7:c58b:0:b0:579:c2f3:f826 with SMTP id
 4fb4d7f45d1cf-579c2f3fa49mr317219a12.4.1716895677997; Tue, 28 May 2024
 04:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-3-edumazet@google.com>
 <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
In-Reply-To: <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 May 2024 13:27:42 +0200
Message-ID: <CANn89iJikmmxMVs5oYT=ZV0ae_tydYHpft99mkNWEhyWkjMM0g@mail.gmail.com>
Subject: Re: [PATCH net 2/4] tcp: fix race in tcp_write_err()
To: David Laight <David.Laight@aculab.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:20=E2=80=AFAM David Laight <David.Laight@aculab.=
com> wrote:
>
> From: Eric Dumazet
> > Sent: 24 May 2024 20:36
> >
> > I noticed flakes in a packetdrill test, expecting an epoll_wait()
> > to return EPOLLERR | EPOLLHUP on a failed connect() attempt,
> > after multiple SYN retransmits. It sometimes return EPOLLERR only.
> >
> > The issue is that tcp_write_err():
> >  1) writes an error in sk->sk_err,
> >  2) calls sk_error_report(),
> >  3) then calls tcp_done().
> >
> > tcp_done() is writing SHUTDOWN_MASK into sk->sk_shutdown,
> > among other things.
> >
> > Problem is that the awaken user thread (from 2) sk_error_report())
> > might call tcp_poll() before tcp_done() has written sk->sk_shutdown.
> >
> > tcp_poll() only sees a non zero sk->sk_err and returns EPOLLERR.
> >
> > This patch fixes the issue by making sure to call sk_error_report()
> > after tcp_done().
>
> Isn't there still the potential for a program to call poll() at
> 'just the wrong time' and still see an unexpected status?

This patch does not cope with poll() results being volatile.

Only epoll, because epoll logic intercepts sk_error_report() and wakes
up a thread,
this thread is calling back tcp_poll() shortly after.

The 'after' starts really at sk_error_report().

>
> ...
> >       WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
> > -     sk_error_report(sk);
> >
> > -     tcp_write_queue_purge(sk);
> > -     tcp_done(sk);
> > +     tcp_done_with_error(sk);
>
> Is there scope for moving the write to sk->sk_err inside the function?
> Looks like it'll need a larger change to tcp_reset().

This seems feasible, yes.

