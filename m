Return-Path: <netdev+bounces-81364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04834887689
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 03:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECA71F22012
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C568A31;
	Sat, 23 Mar 2024 02:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Th2/ZZP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455DEDE
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159337; cv=none; b=CmGA7cu6uVJvPCqRs5ojp4RvIwjkgkvfj+6hUeyiNkvt5/rwRxaHt7JRB6Tyq2nY7Qkfstt0SIzttf73lDbHHlD12Y6fEPgU3WjTEjNzToVKI1LvrdM0+0Sct8hytihGEHFRp2MR4GjrBkOgPgrLYK8Lm910xGyLx62CN3eZMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159337; c=relaxed/simple;
	bh=kjQK/ZXJeuufuWKUqTmtrVb3RiT09PzKuAhVluGT+go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIJDiLrLQVtIDrKN2W5DdQujjwDABYxv4RqaH3fGglE3ledR5Fg1eYWo09SYXQscQX4hR39uAoMm+b0tXAWYuPmc2QwI0FgV5HC/AWaq9SqTOc8GyzAo0PLNgevCq+KUQsQairMdG0j+0Pqk8e15Sn7Q6dvcjHNRbRnDiZ6LML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Th2/ZZP5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso366532366b.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711159334; x=1711764134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=Th2/ZZP5sfW7yYwdEB9kKPKe2ZEgP8l3WruK+7IkwBzFdPxlX/g+SVdYemdVtDjFyC
         2zZEePDIChlyKqGtSPF3yvm3NEEPdmvB48Z/IvmClr4xwUYaV/XZpPe/h0VebglO1oJj
         ZycMb+zFvakcYLLGYpuKKRitAOBIUz72AqkDIow9zt1L6rkIT+VKxmo/9GaUoPB6brsR
         CYdcZHZV8T8v5yOPHJjeKKSYZCtx0UuMh4rC5MZUAFcAHh8JWBs1aOyNPNX6fy6xDJbS
         wWKBtzZVeClTa0PduraQBpY40SqZlMIPsygl48/86za6Gd7btjQC9xmtXoLv2nMivwUc
         U4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159334; x=1711764134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDrtS3kmmAHBfczwt+9v+j8bPsXytsIEzAPUfRDLktk=;
        b=jKeGfhU+ibVJPX2LRCZiBXwcHhdri61/UqD3iRA5l+7nzdTMFR0vcwQBkjq8JH4EnG
         dS41TWDoJHWmfbvwVlLWpKi0sL2q9jFKTaELWA+RcxAvvObchxqEqeg8r1yLn2+hTj9P
         hNHGUzPRXMc69/Nxcgqd8+CZPqIh6foF+5qNVgMVMNqCYMFSF8qG6oeZhLfRiXYhp4b+
         bvTs9J+2xDfS+XqqWMeqOSYfitLMD1m3Puh6qKYYbjcec2Vr8eYaBRtEC+5xr4chSO6J
         UJEMJIcGHDxC3vfRbXSH4KuXgqPJJzmRpfdGjzR3TrWaPQr9n1xdHV5etpSxtvj2kNTS
         zbsg==
X-Forwarded-Encrypted: i=1; AJvYcCXR425Lu5Vkg6addogLOyfdPOEs2gJ+kHxU1Im/BEbOOA4BjjNYOn7m2ELfdQTPD6mv9rBS8ejy4Zv0PNNqYIIw6NL5FuOP
X-Gm-Message-State: AOJu0YxpWYLPzMLrEr/t8yV9zwdcc0bH09t5f7BTb4z5hTda8ekwDq5X
	cJBE/z1Zqqollg0saycVS6610fAg7JoNaGwoB9LegGtffU5/xBI5QbLKWf77MkW7nZlShAzOJlc
	Zt0EUluiS77pHGhI7EC6eA9NS4+igNWNKh6WmFQ==
X-Google-Smtp-Source: AGHT+IFilYtLpWhQMZrvvCHnCL+cWrm27JI38D0QFqame+iNQqNKz8aOz9QXGy0lw2uDZ/Nj6Ill05uOw4ImUyjck/s=
X-Received: by 2002:a17:906:81c8:b0:a46:a712:3972 with SMTP id
 e8-20020a17090681c800b00a46a7123972mr797745ejx.11.1711159334004; Fri, 22 Mar
 2024 19:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710877680.git.yan@cloudflare.com> <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de> <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
In-Reply-To: <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 22 Mar 2024 21:02:02 -0500
Message-ID: <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	Joel Fernandes <joel@joelfernandes.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:31=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote=
:
> > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT ker=
nels would
> > > + * have more chance to invoke schedule() calls and provide necessary=
 quiescent
> > > + * states. As a contrast, calling cond_resched() only won't achieve =
the same
> > > + * effect because cond_resched() does not provide RCU-Tasks quiescen=
t states.
> > > + */
> >
> > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > Why does RT have more scheduling points?
>
> In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> RCU Tasks.
>
By "more chance to invoke schedule()", my thought was that
cond_resched becomes no op on RT or PREEMPT kernel. So it will not
call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
normal irq exit like timer, when NEED_RESCHED is on,
schedule()/__schedule(0) can be called time by time then.
__schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.

But I think this code comment does not take into account frequent
preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
When returning to these busy kthreads, irqentry_exit_cond_resched is
in fact called now, not schedule(). So likely __schedule(PREEMPT) is
still called frequently, or even more frequently. So the code comment
looks incorrect on the RT argument part. We probably should remove the
"IS_ENABLED" condition really. Paul and Sebastian, does this sound
reasonable to you?

Yan

