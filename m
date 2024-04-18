Return-Path: <netdev+bounces-89432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B88AA42F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095BF1F22011
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD13190693;
	Thu, 18 Apr 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GNTnUIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430019068F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472820; cv=none; b=irxieRNCldSe9ohgQ5N3lVPE4NucNhE61JC4HBGzmoHaXPS6AlfygrouUgzNBv4yjUBgZ7zvVa1xDo2TFT4aL01vxbodWwOAtDJ/Vmvdx39914g8+SsFbKkNiCPyhbdju9jw8VbpuFyzQBf3DTGnexD7KoUtfC4Ot9vyEksj58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472820; c=relaxed/simple;
	bh=TvHDhStGMQ0UOSySjq/PFonA1j7hVWZ/FBuw6OxGTus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuNOUJxZaPKOWv1sO5PxhM0g71nHkF17FOHDrxZWISffrdSIAEqS8YM0PAgb47shuxADxsPjgB90sbXuS8kgZ1md9ypIR/hD8EtDWeqQtBua/Nta7X7g+VTn0djdw3xtFDveVgfyqBRnrTl3nSGHsiNh5wWBb7EBPHLNkNYP44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GNTnUIY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346b146199eso906271f8f.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472818; x=1714077618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djyBKRlGRpWDdeJHGkQSaOnuWsBmFhDAvHccO4EOJ1k=;
        b=2GNTnUIYIcYY0TihbJJ8ApbXq88uLWKaHsADRuuYY4wQxj7MrJPT9yIM74u5G7B644
         nYSZQ9xFeecE9ile3y6+la2NK/42797hCwqbhsIWAp4zXv08ptietT2EbBVYBtauE1Jj
         sYccCLovgQeUOH4t9yOvWH5z6oqYBxPtBt46//IMQxG0iXdIcXVderYZFxXr8G0kbeZI
         LZLvKWiANt+0PFrYYce+jXUJvT9HqGO4Eh9h/yHB6Yp7aMIMiQVz/O9YOknvCfXMlbMy
         0mffzMIj826Cy2pvT7Ph/ODPZ8eisdSsP5toWEsEU2az+k8VRUQL2iiCCBBzAo3R6xMF
         zh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472818; x=1714077618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djyBKRlGRpWDdeJHGkQSaOnuWsBmFhDAvHccO4EOJ1k=;
        b=uSWoA89CR9/Qs4n2FOusUcda/9Nu40PJ3ugQfyyvtR+5jrBxnASsWJ6EA+HLtZollZ
         zN4lWoRG6ncFsb5afuwQZ98cRrobxG5lJndyRgOAIc9AtUk6otMvydhIsR9lO7ddRxTh
         NzFnxuz9OwzaDX3KBhKi3OE9opx9P22g54WDL5hWP2Ti5Z8798ETHRj8HE/YlsTbr6S7
         l/ip4qDSenmyhWurOKkxdPIy+qnIFAiqkQlZkfRynWm9rdSLFd3VPXI0ZUGMR0EBCFOW
         L6i4+zocpYQuTNkZE7mRlO08vzPrNAfA63dc0yhhEJSK68FcpToFaX9S1HTaNnJ6M2xs
         ew/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEedzCkXTyTyGJcVnOP4cq39AkvSwrSuVm1bKAiWduawEm+7Azw/2J0+okq4XGyOZT8idG8vcVCQ+rmHyMnG1MNvGEX4wi
X-Gm-Message-State: AOJu0YzG5Nvul6EPejc9bM0naS/8kAqN5b2QC09IPEQlEtbB+7RMYGuY
	DHsfM+4M0sQQyu4Uu/ABimlPXTC+lnRItYomaEZbCMZln40WCErjHLUwVKz+Y0dL8on8Ss7oKrf
	D3WYsEpouHwcHwKemCUM4YWbit8S7SeP3rWH3
X-Google-Smtp-Source: AGHT+IFo6JA2vkoE/3eFV5S2YO4dqACxa+eCURTAtQHQybTEc66uavOtkJHCgKt+OL7C5O/wtn3rtinJvDxEQsoIiOI=
X-Received: by 2002:a5d:6a07:0:b0:343:77f4:e663 with SMTP id
 m7-20020a5d6a07000000b0034377f4e663mr37716wru.18.1713472817454; Thu, 18 Apr
 2024 13:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org> <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
In-Reply-To: <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 13:39:41 -0700
Message-ID: <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 7:49=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Apr 18, 2024 at 11:02:06AM +0200, Jesper Dangaard Brouer wrote:
> >
> >
> > On 18/04/2024 04.19, Yosry Ahmed wrote:
> [...]
> > >
> > > I will keep the high-level conversation about using the mutex here in
> > > the cover letter thread, but I am wondering why we are keeping the
> > > lock dropping logic here with the mutex?
> > >
> >
> > I agree that yielding the mutex in the loop makes less sense.
> > Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> > will be a preemption point for my softirq.   But I kept it because, we
> > are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> > there was no sched point for other userspace processes while holding th=
e
> > mutex, but I don't fully know the sched implication when holding a mute=
x.
> >
>
> Are the softirqs you are interested in, raised from the same cpu or
> remote cpu? What about local_softirq_pending() check in addition to
> need_resched() and spin_needbreak() checks? If softirq can only be
> raised on local cpu then convert the spin_lock to non-irq one (Please
> correct me if I am wrong but on return from hard irq and not within bh
> or irq disabled spin_lock, the kernel will run the pending softirqs,
> right?). Did you get the chance to test these two changes or something
> similar in your prod environment?

I tried making the spinlock a non-irq lock before, but Tejun objected [1].

Perhaps we could experiment with always dropping the lock at CPU
boundaries instead?

[1]https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/

