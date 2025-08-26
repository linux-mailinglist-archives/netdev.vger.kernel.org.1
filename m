Return-Path: <netdev+bounces-217030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3359B371EF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69D5188ACEE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B5E285C91;
	Tue, 26 Aug 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4q1b9iaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9C186342
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231622; cv=none; b=ddtbCAm/fjQ2dz8OlXE21vWFQ5i+nUHhOdtfI5gtva8c9FP28hfp5qSmBqUziJNAm38eA1vU+0LydQWWNKi7QbzUw9rLE/Uf08HVthyftf0B+uwrljTZ5uo/B7S8hNaKhzfKQdFzG0tremy+OwK0Wr0E28msaQUnJ5yulJqkp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231622; c=relaxed/simple;
	bh=EnX01OLUuc+yzPnZPkeoq0zaca2F9JGgwvOt0kFRrIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBXj7loCngGKwErL/SBYhj2iE2dXPxxwKsVI/aZYgrl0IgN/l6R7A4waT6BACSTCKjHZdEC6anOdqF9ScX87v9/j0x4Tc76qiqfhybI05tMNMNzU8QyJ47kBSmNVEqtwwn/H8mv9Cl1/j8VgDk/+HA5gHSQ8RlRll6RbODN9YiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4q1b9iaV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b2979628f9so66017211cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756231619; x=1756836419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibMTiBcEBRmyz4e92SkcKXMJ6u+MAE4amn3aIITkG0o=;
        b=4q1b9iaVVQJO1cYOZYOpoD2llUZTMobZit4ibvAV/c/bEYhtxhYjlAwpPmdanm1miU
         el7QKQHIDs08wXSJZiRhB+tAo+BoQoWvZ8WvGdMRghrx5u5LSP3uAM+HnzpqJtWEg1gC
         i54n9nb+W3qs7XUXs6/htfFtJ5h0cW2Lj8f0QytLm3LNDpSRhdN6ipsMIRROhlx51EgG
         PuY9okmQtaKNtmq8Jd4v/37pol5daB54GtRTdFf8L5JPP0q67qtm+N3MPPepIcJQk1fl
         ZZVoqqrRCoEoR37oS2tmn2RxgFuFOnAhqXQ0Y69v6lpafd914kdOt1L8jKVDey0dRbfL
         hZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231619; x=1756836419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibMTiBcEBRmyz4e92SkcKXMJ6u+MAE4amn3aIITkG0o=;
        b=CXlXsgwd2PcIPgwfxTygR/Yt71U01Wn9ef8S3YXqQ38b55K1dx62nrKdDR0HW4HHTt
         E/cw6B0nLrCtY6jPkFWBPBmjUwYYi4+bCSp4RwdOI9LPt651D0Q8eq8ONVaStFJTEDmr
         JcuES5lT0w9f4EmnZGz2BszQHl0uh4iM6VRVVmxNN5qq4QHVGFPQQ+R0sjqRSGgaf+Ai
         EB8gu0ceH9zg+YbgaE+LmGnuJTjmGq6uI05Fay6kukSYXS+ySrwUp5wbcC1hp2zW+kR6
         XiQtS/fFBqDuu9ewbOgx02ekD6kKQ6cWcoVdgvjbupBRJZB9Go26Lw2CGIZk4e5aRjWp
         pc4Q==
X-Forwarded-Encrypted: i=1; AJvYcCURvtI4aj5MbDXNzLiI0usDDJGkAT+dEEBTAas3bMM1Q+UO5pfjOxbdzGo8BEw2lb4aFiZDZcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFwy+zpD7Uu/F2LC33kkWCq8/Q7PGNezqx40eJtl2JNo8AVHn
	wfevAw/CxbBqib5JtZREhl2GQ1dfHi2PXYO4c1UiXlyRV/dRt2NdEjfnO0ZzX8NEhNvFSvIs/M0
	cRkcKEMgE2X2T5jP6LEtQC5jEExqYpzgBhmZbWMfI
X-Gm-Gg: ASbGncs3jTLw9Apid0C14zHCAOVxdGLttoptGAaDxRauJpGp6DpQ3/qh+RGt1txE0WW
	r9c4b3dfEsQmJgNp+YBZ2hJ4hEUeuQBvX4mtaqkOhyGVUFrbCibSAVyNQsxj2mu2ne4TWJbPz0E
	iciGEwhhHBW9b8yN8YetasMhPhfq4ysfKo/vmeRrKuzfClsYdbZi9U+BOJl1Gnks7IxuG+eWNoZ
	yyZK9v+FhttVR3t8tP9KAk=
X-Google-Smtp-Source: AGHT+IEeavW/rzTQD7nsTPc4jinsPKkeP4oZTsst4VZyUdIVzFFZA1c21PkVxIf/cg8m6Ta7J8VnXs52M+gSIFydaf4=
X-Received: by 2002:a05:622a:1f15:b0:4ab:37bd:5aa9 with SMTP id
 d75a77b69052e-4b2aaa561edmr178483301cf.17.1756231618822; Tue, 26 Aug 2025
 11:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826180508.2141197-1-edumazet@google.com>
In-Reply-To: <20250826180508.2141197-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Aug 2025 11:06:47 -0700
X-Gm-Features: Ac12FXyGcI6_SqOoaoL6F2OS7iiu7enbTiX-t6n2zekluc6PY_igF_Zmst8WWBI
Message-ID: <CANn89iJgfe4ONBJ4emeWRAk1W_pO5HTMKcO6dHLt9zO-kZhbTw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: gen_estimator:
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:05=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> syzbot reported a WARNING in est_timer() [1]
>
> Problem here is that with CONFIG_PREEMPT_RT=3Dy, timer callbacks
> can be preempted.
>
> Adopt preempt_disable_nested()/preempt_enable_nested() to fix this.
>

Patch title is messed up.

It should read :

net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=3Dy

> [1]
>  WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 __seqprop_asser=
t include/linux/seqlock.h:221 [inline]
>  WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 est_timer+0x6dc=
/0x9f0 net/core/gen_estimator.c:93
> Modules linked in:
> CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{R=
T,(full)}
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
>  RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
>  RIP: 0010:est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
> Call Trace:
>  <TASK>
>   call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
>   expire_timers kernel/time/timer.c:1798 [inline]
>   __run_timers kernel/time/timer.c:2372 [inline]
>   __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
>   run_timer_base kernel/time/timer.c:2393 [inline]
>   run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
>   handle_softirqs+0x22c/0x710 kernel/softirq.c:579
>   __do_softirq kernel/softirq.c:613 [inline]
>   run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
>   smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
>   kthread+0x70e/0x8a0 kernel/kthread.c:463
>   ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/68adf6fa.a70a0220.3cafd4.0000.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/core/gen_estimator.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
> index 7d426a8e29f30b67655cf706060bfc6c478f3123..f112156db587ba54a995a68ea=
d5a35fe0cb16230 100644
> --- a/net/core/gen_estimator.c
> +++ b/net/core/gen_estimator.c
> @@ -90,10 +90,12 @@ static void est_timer(struct timer_list *t)
>         rate =3D (b_packets - est->last_packets) << (10 - est->intvl_log)=
;
>         rate =3D (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
>
> +       preempt_disable_nested();
>         write_seqcount_begin(&est->seq);
>         est->avbps +=3D brate;
>         est->avpps +=3D rate;
>         write_seqcount_end(&est->seq);
> +       preempt_enable_nested();
>
>         est->last_bytes =3D b_bytes;
>         est->last_packets =3D b_packets;
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

