Return-Path: <netdev+bounces-223208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B9CB58513
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C95A1AA7DF2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A56D27E041;
	Mon, 15 Sep 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmTAglxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222B27B342
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962918; cv=none; b=S0L4BsmY3K/M6tdLEdayXiiMEo+EtHqlWKAonb/eLlZdnG/s7wAOZqe4LGEJpi9uWlfXZNIjmLQvgBwOJ7ASQIXrCJlcDnYok5GbSWkV49md9g+Oe8+vlKxu2utbnXiH8wm/79kIBKWGW5xpDdfyTAIXgdszrFiQ4FCTLRLFq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962918; c=relaxed/simple;
	bh=YRpBAFnnIRuEb3oy0SZIyuAqhZMm8c11TrU0CWPoX4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j818sUHGgm+lTjnrB5l9OJB9bbR+JPjJYM57i9yQdH1rLqVXh5EkXXbOPFHjQpGE3dF3oQsav2A4/YRIwJMJAgsqyRc/iSC+7/z0a8i2aCvZEYxXzWmaEADPtL0Q7jYzk5DC0wVs6jBhKScJFX8DPPOGNNBUJ1HogMTzuEsuDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmTAglxN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-424077143d9so26895ab.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757962916; x=1758567716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pQfTHpMoN7M293Xi97naoDAIH6/B/0Fb96Hyp8R4aE=;
        b=rmTAglxNvfNjyNed7m1Nw6nsTKuFrnsVUMDt4jsM4qtFAAjZfVem/5Wi71gFTyk1Xz
         ehMLqiWyHVUZuqwaVLR6F48BJjhNjoTKqQJY+e9OVEjmGKduPaivWq3egBRAAGVBQvdV
         HE1x/ne8ZfCevdJCatgjN2xluXApYGSXNV8sv9TdtaWONXlVGTKIXLzNe97/N7lr47zx
         FeHeY1Mqj+vvnolEAYsesbjK6oqdNwYYv/MIflqhV/bTZ+HM2XwbHP0NqDMYaPS2+PaX
         502yhXZftp/vlRdCq+kgGYgL95cm7pJyOJu2g6I79bsvulStylwO52eb0h+LO9DaTFIP
         XxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962916; x=1758567716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pQfTHpMoN7M293Xi97naoDAIH6/B/0Fb96Hyp8R4aE=;
        b=Ie6HwICY2AoobIZuIG4FKpF4zrldv0QB5l5e3CdDJFpljdXwMEI9eu7rHT58dTdxNO
         X4JITkmbOWlzB2yGhNE1ZvtwbJOJq/i9xDpPRxNf4hYNrE91Ye7UAzqofubth+KOMhM+
         Zhtu5bT525nryEn8V9BGWGa0ylXQiPkuulBcN4Qsd/7kSV3aWCjxRxRUw4haIaQk9oG2
         YWrhvO3YaMuyUCNwTk9+af4Oc1yN+ONRwzwkiNrT3EPjFNl0VD1CyMD0OpVZgQMTHthX
         iOPXA+PbITMIa769e/03WAtzg39ZIl8VyOS8K9lsWoiEwGsyixroQnjdyzmHOHvHNhWX
         G0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXKbmBbsWui8DH1Br9EFRG9o2keI5fi/+ROGD6ADxnTAdQssv6G9Ob/4TWMdI464gzgZBby9mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGESv2K/Qv/s7FnqPT5R81KJYKVgRCcwQgs87CjR+ACmnDz7f
	c56XW4crremEbiWFauFE5dWCDCbCkdUu+CornjGJ5RMCcT6lUZsSXSu2VksjvpWd/Je5R7ndKQ+
	WGoKcypx9IglwKmmYrO+dqCxm40tocLQe3PEh+deG
X-Gm-Gg: ASbGnctn9/veP03yxtBOikoKYXjRh6Jj/rrMauSFBxay1OvliSGLO+CmzZxRF5QtmLz
	eWU8UH1uGbhTl+8qv7/vL9PBVWHOXkjeBoDFk+whbrCXD19zhu76/GPhmvvtZF4Eu4N8WL5eld5
	uGJivZZaUrBpM1mzCHcjDlNBHlPIFQMkRtZkh0tQP9FfCcqDKGO+7JPk9TS2zZV+IMRCzwnZXBZ
	Ig1pqPuD/4dCSSEnnKBje6Pyw==
X-Google-Smtp-Source: AGHT+IH5o5NepROzxdqAlVME3viPv/J8ThdmUajt6m6We7loCG/BuasL4zggVpmB+t+m7RF4AlSX/aUqas4bmxtK5M8=
X-Received: by 2002:a05:6e02:1907:b0:3f1:44a3:755 with SMTP id
 e9e14a558f8ab-4240e84e5a4mr1154645ab.10.1757962915486; Mon, 15 Sep 2025
 12:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902183603.740428-1-edumazet@google.com> <aMhX-VnXkYDpKd9V@google.com>
 <CANn89iJOHzk+Sj+3c2PRywQaOMrqpxyodeSbkZ4++5E9xvnTpA@mail.gmail.com>
In-Reply-To: <CANn89iJOHzk+Sj+3c2PRywQaOMrqpxyodeSbkZ4++5E9xvnTpA@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Mon, 15 Sep 2025 12:01:44 -0700
X-Gm-Features: AS18NWCKBTZ1JhOeleBKKOHT-DfUJIMyQmi0zpH-fmAP64e-ljdED2UBv6m0-6g
Message-ID: <CAEWA0a6ze-zrcOsY60ibovQDWYYKY4haEgQi=M-qu8Og8c=QcQ@mail.gmail.com>
Subject: Re: [PATCH net] net: lockless sock_i_ino()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+50603c05bbdf4dfdaffa@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Sep 15, 2025 at 11:16=E2=80=AFAM Andrei Vagin <avagin@google.com>=
 wrote:
> >
> > On Tue, Sep 02, 2025 at 06:36:03PM +0000, Eric Dumazet wrote:
> > > @@ -2056,6 +2058,10 @@ static inline int sk_rx_queue_get(const struct=
 sock *sk)
> > >  static inline void sk_set_socket(struct sock *sk, struct socket *soc=
k)
> > >  {
> > >       sk->sk_socket =3D sock;
> > > +     if (sock) {
> > > +             WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
> > > +             WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
> > > +     }
> >
> > Hi Eric.
> >
> > This change breaks CRIU [1]. The issue is that socket_diag reports two
> > sockets with the same inode number. It seems inet_csk_clone_lock copies
> > sk->sk_ino to child sockets, but sk_set_socket doesn=E2=80=99t reset it=
 to zero
> > when sock is NULL.
>
> Hi Andrei, thanks for the report.
>
> Could you test this patch ?
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 0fd465935334160eeda7c1ea608f5d6161f02cb1..36e11b2afb223bf18ff0596d6=
34e885cca549d0f
> 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2063,6 +2063,9 @@ static inline void sk_set_socket(struct sock
> *sk, struct socket *sock)
>         if (sock) {
>                 WRITE_ONCE(sk->sk_uid, SOCK_INODE(sock)->i_uid);
>                 WRITE_ONCE(sk->sk_ino, SOCK_INODE(sock)->i_ino);
> +       } else {
> +               /* Note: sk_uid is unchanged. */
> +               WRITE_ONCE(sk->sk_ino, 0);

It fixes the issue. Thanks!

