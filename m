Return-Path: <netdev+bounces-117735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F294EF95
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211E81C20BDD
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4317E44F;
	Mon, 12 Aug 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVpM3Bw9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB016B38D;
	Mon, 12 Aug 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473065; cv=none; b=dCQNE2bZxCXoxtFtWURFWCHhIpckWsJ0DKXnlIh4ZENHYqKHWerivIDMbWorXANBAyXr/YFbeJD5hOvZVBkNusCTWYSI9o5CI4zfqFgjAUrBhJrYUx0wxS/RNsQ/a3DLS4phG/ihZFNHVCNWPNKiBFt7F0rybur4NMtBhwjpjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473065; c=relaxed/simple;
	bh=+lGB1nUEVVA7esqNPkyaO/r3t9LgW0p3dWFyGVV0s2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/wqjW/qa239YsDnLBg87WkZm3lq0mSMWSGhJUHCHawXMuQkUHy0PGIg3M4eWypF1yx4LC/qcGK+N48bsbsF4cd57/db+IQlPR8MLv8938x0+Lu/69B2X/1RN7BGt1wQ5utZS+i82Sm8C5l9xJGm4DXzGG60qw42YVEEBfePPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVpM3Bw9; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b4f847a5eso14469995ab.1;
        Mon, 12 Aug 2024 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723473063; x=1724077863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xw3acn4+txaoOaW/DAlL/mFLwqYjsFnhae1GSCFNUDQ=;
        b=nVpM3Bw9Mdp8nmBn7TAIDkMtmAB2pZ0suvrHuMJzhQx7w8705zEDkqv5rDC+qcVqfW
         0iCR74ptoiHXAxLMPAyC2M02OmgDpnCknMEz+l/KlQnjEmuKgLvPyes02WZ8niqoOxw6
         WeqZZ5qy2mTM78CGchp3UzxwspKrp6g9WhyryyJpM14KhX8RepwKy7uEPrRGZAa3nLVp
         gK6Lu4gfCeJsCNYqHxbxhaCaGSxTWeA4jZK8wse+M9CjEhXB9jjg9R5T9+O8f3f2Cm9P
         uHdt6GX/IVFkCP32aPDOGMFKav+3LkJEL0ucQxMWqmbhILNATqx5TEA2J9CslBf24+TH
         GBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473063; x=1724077863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xw3acn4+txaoOaW/DAlL/mFLwqYjsFnhae1GSCFNUDQ=;
        b=JIS2oQt6w9efeDHbeehOPrAlUagGEvV4TGI+0rhTaPs/6um8n3XU/5TpjYGI3flA9Q
         kxOgABg0twTECfS/9hQqyAeVMhc8MFlu8T6AhE1tpY8+Tud7NyZZjyeTjlF5cvtlEp/r
         x6FCqJv8eTIjZG4BChami7D1VoNZZ5Z5WToPLgEZTG6VZM1g3QGpsE9HkXZK49xapjzN
         wFOUGOA2RarLmDA0iBsi5y5jm9pm/cpJkMR0p+wx7dHkY/C+YlhTUdWGdQ+VZoKY5CvU
         wzSfP0t2lGJ/F4JNxIr5dVnXAUKHMSnza//7rs7cX252Ma3rCw2jxwyf4va6DjWTR6VF
         i0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXSfJfDzs0+J4ReU42iPlME+EmoXKVVHJ8Rn/+mRFdLXBryuD5STjVeggHcZqMcqKDVTG88J6RYUn7ok4tPU7bPhqqtPUhEb8MZfRidaorfLQKZxgSX7CBqhnzmLbPCG+hHNNbv
X-Gm-Message-State: AOJu0YxFpzROdGUz9cxemrlAODJBLh77yeFq0RailBbIYcMqBtyB9gGr
	QlfeHQVIRY4HtRuaMMcTFp+AP6O8WZ1jDi9ouV2KMa41O4hyiQGcc5oSknChcB3U4y6HT6HyEHP
	O/DNGbUZ11/KotJX6I3GPJjv5WIY=
X-Google-Smtp-Source: AGHT+IFmkWXRBl7Fab7EdpXLwMBcn31kV/W3d53R7TPKcOM148k86Xl2b9dA7ZouZl1oNu8z3rcr0dfJy4YHR0guHSE=
X-Received: by 2002:a05:6e02:20e9:b0:39a:e86b:a76a with SMTP id
 e9e14a558f8ab-39c4791c13dmr4162065ab.26.1723473062593; Mon, 12 Aug 2024
 07:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811230029.95258-1-kuniyu@amazon.com> <20240811230836.95914-1-kuniyu@amazon.com>
 <20240812140104.GA21559@breakpoint.cc>
In-Reply-To: <20240812140104.GA21559@breakpoint.cc>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 12 Aug 2024 22:30:26 +0800
Message-ID: <CAL+tcoCyq4Xra97sEhxGQBB8PVtKa5qGj0wW7wM=a9tu-fOumw@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
To: Florian Westphal <fw@strlen.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Mon, Aug 12, 2024 at 10:02=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Sun, 11 Aug 2024 16:00:29 -0700
> > > From: Florian Westphal <fw@strlen.de>
> > > Date: Sun, 11 Aug 2024 18:28:50 +0200
> > > > Florian Westphal <fw@strlen.de> wrote:
> > > > > https://syzkaller.appspot.com/x/log.txt?x=3D117f3182980000
> > > > >
> > > > > ... shows at two cores racing:
> > > > >
> > > > > [ 3127.234402][ T1396] CPU: 3 PID: 1396 Comm: syz-executor.3 Not
> > > > > and
> > > > > [ 3127.257864][   T13] CPU: 1 PID: 13 Comm: kworker/u32:1 Not tai=
nted 6.9.0-syzkalle (netns cleanup net).
> > > > >
> > > > >
> > > > > first splat backtrace shows invocation of tcp_sk_exit_batch() fro=
m
> > > > > netns error unwinding code.
> > > > >
> > > > > Second one lacks backtrace, but its also in tcp_sk_exit_batch(),
> > > >
> > > > ... which doesn't work.  Does this look like a plausible
> > > > theory/exlanation?
> > >
> > > Yes!  The problem here is that inet_twsk_purge() operates on twsk
> > > not in net_exit_list, but I think such a check is overkill and we
> > > can work around it in another way.
>
> I'm not so sure.  Once 'other' inet_twsk_purge() found the twsk and
> called inet_twsk_kill(), 'our' task has to wait for that to complete.
>
> We need to force proper ordering so that all twsk found
>
> static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
> {
>         struct net *net;
>
> /*HERE*/tcp_twsk_purge(net_exit_list);
>
>         list_for_each_entry(net, net_exit_list, exit_list) {
>                 inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinf=
o);
>
> .... have gone through inet_twsk_kill() so tw_refcount managed to
> drop back to 1 before doing
>                 WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_=
row.tw_refcount));
> .
>
> > > We need to sync two inet_twsk_kill(), so maybe give up one
> > > if twsk is not hashed ?
>
> Not sure, afaiu only one thread enters inet_twsk_kill()
> (the one that manages to deactivate the timer).
>
> > > ---8<---
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_s=
ock.c
> > > index 337390ba85b4..51889567274b 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -52,7 +52,10 @@ static void inet_twsk_kill(struct inet_timewait_so=
ck *tw)
> > >     struct inet_bind_hashbucket *bhead, *bhead2;
> > >
> > >     spin_lock(lock);
> > > -   sk_nulls_del_node_init_rcu((struct sock *)tw);
> > > +   if (!sk_nulls_del_node_init_rcu((struct sock *)tw)) {
> > > +           spin_unlock(lock);
> > > +           return false;
> >
> > forgot to remove false, just return :)
>
> I don't see how this helps, we need to wait until 'stolen' twsk
> has gone through inet_twsk_kill() and decremented tw_refcount.
> Obviously It would be a bit simpler if we had a reliable reproducer :-)

Allow me to say something irrelevant to this bug report.

Do you think that Kuniyuki's patch can solve the race between two
'killers' calling inet_twsk_deschedule_put()->inet_twsk_kill()
concurrently at two cores, say, inet_twsk_purge() and tcp_abort()?

It at least does help avoid decrementing tw_refcount twice in the
above case if I understand correctly.

Thanks,
Jason

