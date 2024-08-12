Return-Path: <netdev+bounces-117773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D414494F21B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5F1F22B8D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6AC186E48;
	Mon, 12 Aug 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+vP+3sR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4381862BB;
	Mon, 12 Aug 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477819; cv=none; b=Ha/XoDXky1Hv6VQWohDvE/bKz/e2lUa4Qx3wTqh26KpngrpikOlse5nkUDpbU8x44q15HqcFphQJkCXTE57fFWLLErXzKciB67kF6t6E2lW+0oGWmX+1QZnG46buQYKc+vkDfx1Kq+Rph1wmnrOUNcUfkzB8qOD3Ok0IMBt826E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477819; c=relaxed/simple;
	bh=tPzxt4/H777G16ixqqD15EZUv69PJ912iUNnIRA/11s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nW4Sbq8JGFGORaHRoyD7E1ntxeBLZQsAgDZmgY7hf/fCZtsk2bcQgyvW4oyBeQF+GkiAwVRfP9T2mOieoBVzL+11brmNYYHGOiuKENt78scRmISD4OFXzk+2XVR4zL+EcM90cvQuIaRF3CN0rYZtUkurmex4LSBhu9+roD8XTGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+vP+3sR; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-396cc82f6d7so15172735ab.0;
        Mon, 12 Aug 2024 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477817; x=1724082617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUbs+IDJtGINX8Ssllhw/FR35ZOMUwTrv0DIBDR8E18=;
        b=O+vP+3sR2NVfOxkJYGsduLEzaD7h7nchzXkS7Nuogr5r9GjTju//mLj51b0A3aVlU1
         PeUWTpsJoRipylvpZ+yjI0SF1XF39DDm8UgYW5YCXwKsww3617HJ+nQzab1kA8f9QQlh
         op8FCbkgyesZ00SVjhb2RckQJPyp7GlgnRWuXZcM7+CZVABI+KrLd6vra+rn7xErB/Px
         fEiVQ/nTuFsSD9jaRUN846BkF92fc2sNRaQ3RYkqIYG4CPMgZ0cUCsMTlPUR2teDMOSt
         CN1mNz2GT5eMniTaQGH30iq0CxSmavifO/sFtrBXiNaliEKC/8WGgDPgFXNA9PWtDIbN
         WFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477817; x=1724082617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUbs+IDJtGINX8Ssllhw/FR35ZOMUwTrv0DIBDR8E18=;
        b=LObyrjGgRWcgwuqAenfmy1gKcog0bacrtJpn/VSe0iiMsxEvjzWEbR2hQpiD5aY1QL
         /DoNOG3XkDoXTHWz4mf5MBb/IpS2DVDlEDHWFyzvHrfu2UjfjW2RMpuyWLkqScR1sgTR
         gQQu6OSIlJDDjl/of6rCpS52xAy3LZX5HtRF44zVk7K2EnR9IWn9SNK7Qma/jCOcF+hS
         KcYnmVn9Q4TehKh74riTrd9XrfHMn9djkpU2vP4Fv/KHhMMUH7I2V41ldgDQj50f6mMY
         o2E3ztfYEgTH/BgljCefrMaB3h62DjRj12s/Ic6a4gxDFOGLtkTVPyA4epcchjy034ro
         TVfg==
X-Forwarded-Encrypted: i=1; AJvYcCViVcYs1Qco54IcnL9l7xKMtTzsvGWhVDcRm2IQ+gWM16XRSemuDy5FPoOxuHrk6ww3hAQpagBClCdh7z6Zb+CntGV0fuVz1gz2p5CgiksvgDxASHAbPp3wW8+7tr+5aAB9oohu
X-Gm-Message-State: AOJu0YzUI2P0hElQ+OfS/gGsE8dYF/HBfw+2tSpD2dwUFWI1omEI947M
	SdgiqhCRjzBLOqrPr7GHCyQIG8OH2TWa1FnbZ7X+RlHN2C4M3iO+JUKHRYU903+RB12UXfsTTjg
	PED/418Vm0cNTrjsWUFtf1hPIQG8=
X-Google-Smtp-Source: AGHT+IEbHhOOHCDcOxlsI+o5NptePUQh/p/xxNKlbMH2+CUpecqtOvnc5voB4cbT3qclyBxjWK8e+jVZZMw1D0PO/NI=
X-Received: by 2002:a05:6e02:1605:b0:39b:3a29:b860 with SMTP id
 e9e14a558f8ab-39c48db507emr436365ab.4.1723477817128; Mon, 12 Aug 2024
 08:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811230029.95258-1-kuniyu@amazon.com> <20240811230836.95914-1-kuniyu@amazon.com>
 <20240812140104.GA21559@breakpoint.cc> <CAL+tcoCyq4Xra97sEhxGQBB8PVtKa5qGj0wW7wM=a9tu-fOumw@mail.gmail.com>
 <20240812150338.GA25936@breakpoint.cc>
In-Reply-To: <20240812150338.GA25936@breakpoint.cc>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 12 Aug 2024 23:49:40 +0800
Message-ID: <CAL+tcoD+8A+eJ2M2mgTw0HSaNEa7YDvakO3Q_CFNn-eeUmVzHQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
To: Florian Westphal <fw@strlen.de>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:03=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Jason Xing <kerneljasonxing@gmail.com> wrote:
> > > I don't see how this helps, we need to wait until 'stolen' twsk
> > > has gone through inet_twsk_kill() and decremented tw_refcount.
> > > Obviously It would be a bit simpler if we had a reliable reproducer :=
-)
> >
> > Allow me to say something irrelevant to this bug report.
> >
> > Do you think that Kuniyuki's patch can solve the race between two
> > 'killers' calling inet_twsk_deschedule_put()->inet_twsk_kill()
> > concurrently at two cores, say, inet_twsk_purge() and tcp_abort()?
>
> I don't think its possible, tcp_abort() calls inet_twsk_deschedule_put,
> which does:
>
>         if (timer_shutdown_sync(&tw->tw_timer))
>                 inet_twsk_kill(tw);
>
> So I don't see how two concurrent callers, working on same tw address,
> would both be able to shut down the timer.
>
> One will shut it down and calls inet_twsk_kill(), other will wait until
> the callback has completed, but it doesn't call inet_twsk_kill().

Oh, thanks. Since timer_shutdown_sync() can be used as a lock, there
is indeed no way to call inet_twsk_kill() concurrently.

>
> > It at least does help avoid decrementing tw_refcount twice in the
> > above case if I understand correctly.
>
> I don't think the refcount is decremented twice.
>
> Problem is one thread is already at the 'final' decrement of
>  WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount=
));
>
> in tcp_sk_exit_batch(), while other thread has not yet called
> refcount_dec() on it (inet_twsk_kill still executing).
>
> So we get two splats, refcount_dec_and_test() returns 1 not expected 0
> and refcount_dec() coming right afterwards from other task observes the
> transition to 0, while it should have dropped down to 1.

I see.

Thanks,
Jason

