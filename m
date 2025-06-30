Return-Path: <netdev+bounces-202633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CFDAEE6AA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756901BC0491
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44B1C5D57;
	Mon, 30 Jun 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KLrTKwf0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4A19994F;
	Mon, 30 Jun 2025 18:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307663; cv=none; b=QOVFEHMzK/kLWXuuqzwk/lJLpw1guXHTiH8bEB6QJOAsMi/aosGsyIIV9fFKecRMIJKIW/YRTwJsxlVzMY8/nkJ9XZs7BvJ1gaCPi2s6OlHus9O2LfPISA5p/ck0XY07toKGzuqTBTcFRvMXXXH05Zl+K2W3jB4FRGmWaVtaFk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307663; c=relaxed/simple;
	bh=Lgf/Zp57oxC6IVL49i2ZecSD8F0BlRkSlJFL62870mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqhYsUgA1qr13JKCDmNLt9fZ866fuI+hokDIDvhFxX2WrsFQeferKLNmaPknZwagt1AH1xcOeAWUrktgJJ0lSue46vo7C8xc/HNnpJiInoQMoQp3DNGJ5QILqlOPVp2108kUV5IJAIFbj97PWr9eXZ6Nxo+2S/M2nIGKnc/JQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KLrTKwf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD01C4CEEB;
	Mon, 30 Jun 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KLrTKwf0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1751307659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vcud2s8VTA3+hSxYjYnz7VrL5QewcVNdaIoQvLPWP0A=;
	b=KLrTKwf080fIOPgFw0krZaHpANarj7eJ7xkQ6SymhISxr+BDnB0ZzijLjLPm2hECRATOU7
	7YpfI9BJH+z56DCZzdgim3Kk455KO7zFiwvBhfhwlfv0hFI0/0VWoyT5tx86m0UDFxM9B4
	J/T1wBXcEOekiFXRWmQ7gPedbq6GjRE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3f9a052 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Jun 2025 18:20:59 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2eb6c422828so2977010fac.1;
        Mon, 30 Jun 2025 11:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVm6Q7aWBnJpw6wPNrjv+LPOgTJt+Ns7jz/U9E0XPWRr4hCynnz8LSLtGMLS6yYquT+/8GieRrWr1JRNyI=@vger.kernel.org, AJvYcCWN7MUcLpIo0rS7boal7MRgGW4arM68+SoWS1c8zggqvUUDkcHjWh/PXGGVIqrTqS1s2cNH01AY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9JfWw3LGl51FopCNW+AbVQAi1lLzJwWl5bU9LcrTSdTCZ6uu
	WNgNX+m7VGwMhkGYnZjLBMDWG0Ujv9OL8ecX3e0hG9BNf19XoPGvwPetLcs+mTDNPborv5mWfhA
	2/7oo1DLwBuTlvX4wcCS8xA605pvBnss=
X-Google-Smtp-Source: AGHT+IGwwyAVQF0CQ8i/A2dRuHN6UYKbWYAZ+GKGA8nGabLqXNX247OAz3qBgd0LkNOBitvtC4d1k9dqFaKtLs7wki4=
X-Received: by 2002:a05:6871:781e:b0:2eb:9fe5:d06c with SMTP id
 586e51a60fabf-2f3c01e635dmr466422fac.3.1751307658258; Mon, 30 Jun 2025
 11:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619145501.351951-1-yury.norov@gmail.com> <aGLIUZXHyBTG4zjm@zx2c4.com>
 <aGLKcbR6QmrQ7HE8@yury> <aGLLepPzC0kp9Ou1@zx2c4.com> <aGLPOWUQeCxTPDix@yury>
 <CAHmME9rjm3k1hw4yMd8Fe9WHxC48ruqFOGJp68Hm6keuondzuQ@mail.gmail.com>
 <aGLQc5JGGpMdfbln@yury> <aGLUKg8uNvNtimW0@yury>
In-Reply-To: <aGLUKg8uNvNtimW0@yury>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 30 Jun 2025 20:20:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9qLiyWEhU6DrK+QWu5wo7Hmq-YjftmqGagCmEp3bjy4DQ@mail.gmail.com>
X-Gm-Features: Ac12FXxFSQUXkdwDxgafxU0ofHFL9rHhi0yU11Z9Fww3EWToyA3LkXXBfAxK00I
Message-ID: <CAHmME9qLiyWEhU6DrK+QWu5wo7Hmq-YjftmqGagCmEp3bjy4DQ@mail.gmail.com>
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 8:15=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> > > > From fbdce972342437fb12703cae0c3a4f8f9e218a1b Mon Sep 17 00:00:00 2=
001
> > > > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > > Date: Mon, 30 Jun 2025 13:47:49 -0400
> > > > Subject: [PATCH] workqueue: relax condition in __queue_work()
> > > >
> > > > Some cpumask search functions may return a number greater than
> > > > nr_cpu_ids when nothing is found. Adjust __queue_work() to it.
> > > >
> > > > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > > ---
> > > >  kernel/workqueue.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > > index 9f9148075828..abacfe157fe6 100644
> > > > --- a/kernel/workqueue.c
> > > > +++ b/kernel/workqueue.c
> > > > @@ -2261,7 +2261,7 @@ static void __queue_work(int cpu, struct work=
queue_struct *wq,
> > > >         rcu_read_lock();
> > > >  retry:
> > > >         /* pwq which will be used unless @work is executing elsewhe=
re */
> > > > -       if (req_cpu =3D=3D WORK_CPU_UNBOUND) {
> > > > +       if (req_cpu >=3D WORK_CPU_UNBOUND) {
> > > >                 if (wq->flags & WQ_UNBOUND)
> > > >                         cpu =3D wq_select_unbound_cpu(raw_smp_proce=
ssor_id());
> > > >                 else
> > > >
> > >
> > > Seems reasonable to me... Maybe submit this to Tejun and CC me?
> >
> > Sure, no problem.
>
> Hmm... So, actually WORK_CPU_UNBOUND is NR_CPUS, which is not the same
> as nr_cpu_ids. For example, on my Ubuntu machine, the CONFIG_NR_CPUS
> is 8192, and nr_cpu_ids is 8.
>
> So, for the wg_cpumask_next_online() to work properly, we need to
> return the WORK_CPU_UNBOUND in case of nothing is found.

Or just try again? Could just make your if into a while.

