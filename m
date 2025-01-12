Return-Path: <netdev+bounces-157548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E44A0AAB8
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 16:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077561644EB
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3131BC064;
	Sun, 12 Jan 2025 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USkWomwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFF1953A1
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736697557; cv=none; b=pqXHDqV1uvntEIF9W68tTu3IwxZmtWEv233j5JIAxAYdznKad72JcCxi/Jt1QX7PqqAAF2btDDX5e/uwUCKtOx/0ByGbLnuTRsurR+VQMwEhnPxy8GTs8I5DskccOV7R/oYuPJxrJCqWvDDQ0+f57B2qp3L7Huzce9nVHaaPpCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736697557; c=relaxed/simple;
	bh=KKsEKrpc1NAwrSyXr4hKFPByiTeR/gFwqGusWFi7eMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBondVfxTTefu8E36e3U0iqaP7IHkIDu8+XgE6e6tRn8h58l6ZQa7G8LUdxJzGRKl8rV8yXxg1bhS9nl2Xhru3Q7N6U5L6Y2+pBVN3v7NWbxmW3qokAPhTPGruKKwf11YA2i2jWhhdmWfubIbsKOthVodBVEB43f0smoUwx6PWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USkWomwP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4678c9310afso159571cf.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736697554; x=1737302354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XocGpW/rhnHNRcHznyluodqvLbolBlcuVynA3kRd7QM=;
        b=USkWomwPEaTT5INE23dcVNQR7ZZsc4zTbjLxROKxb+ynGe165A/BKPuuosLUhZloS1
         bbQmj4m87gKMpOgMqS4jdUnI1Y8mQCEuIRKihWJYXMZY2D4E/aHmitPEyP/lkHQWfuUr
         arqHPk9rUJbWnKVC3Gbq1XMyfFTYj28OEnnCA6J8WPr55EH7hahyHr1tATkZJxIhrzgN
         W7WxrYXzHA67I3/nqzM82aZIjdQapMYVfUNNseSfq3D3E8TT88d8Mt3g1UoaATXyOoNn
         TIu+G34SGG7X7va6Vin7v+MbuYoMaJd+mJ1Y4APc39m8+6EB6vJuLsnXTrwgKdS6p0eN
         7/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736697554; x=1737302354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XocGpW/rhnHNRcHznyluodqvLbolBlcuVynA3kRd7QM=;
        b=roXudFdzRKtMUNyqhMJW6pWr9vwFVZFbmiiv5vn2M15RbeR1gfBuJKLVQqP4FOZFH6
         ADFOxr+0bQAGo0+L2QVZwoVsQ2ileV49mTxzcOc0QLBeOu7vJLtlHUxP9RxF9kGqCCcY
         i28PUUQN7oXta2gsOZ1J90gktw0S+E2ijqlrLc4ZcQzf+vGTCtSl57038caErSR/I92o
         CL3bXdvtrLKvjbXVXZKSQmu5en3ea+sZcMxboTv1zju4PROZbEQsaD3seTxI3dRqUriQ
         FxxSmIVNunmS3pPytJ3ZBTW0/yBckN+PX/XMJxMXjmrD1d2ZdyHNrr2nWPrYBT3FT3GV
         gG6g==
X-Forwarded-Encrypted: i=1; AJvYcCWkP9sAoizj3EtnUYQfJxj2/iUpItwo8Q0BC8/IPpQQfF2UI9wXJJ3W1RaGvpbUC8JPviZBYYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqinE7bjT5skuZVwcilwaX3tigLx/a7n21qvwp8fyGkZUNG+h
	Gb+hfC95eev9QOvODhrgAlW2aORonn6vZFvQtSUvq7JchL/JR3Kz0oAcIOKBDWkEA8VBUXBzJ6y
	Ac6UQ2bbVitC24anPduRYZkdoqnTsLDGrBWeG
X-Gm-Gg: ASbGncuZr9M06YXcRrL8KcHpxbSYrCghpihWG+7ReXnox0IhfB6qJyaslmwJWb4EG/G
	kKPtta02JvZqu1/cFJe0f/wg2bvsPNjfd35ZcmvGB6kmPGacseG7xsRZMPu2jIyLN8Ygttag=
X-Google-Smtp-Source: AGHT+IH4iOLFTGMlsFy2wCe1l7TOTBOMz+6gtQnjXCTPWN5dhRgaPZxEw1RKqYqgCYhpigpLOWS8yVcLtdoMSlxNSy8=
X-Received: by 2002:a05:622a:2c1:b0:460:491e:d2a2 with SMTP id
 d75a77b69052e-46c89dad5a8mr7437841cf.17.1736697554334; Sun, 12 Jan 2025
 07:59:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com>
 <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
 <2046438615.4484034.1736328888690@mail.yahoo.com> <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com>
 <1815460239.6961054.1736660842181@mail.yahoo.com>
In-Reply-To: <1815460239.6961054.1736660842181@mail.yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 12 Jan 2025 10:58:58 -0500
X-Gm-Features: AbW1kva3VDsafbyWcRsi7vO6_KWlBVD8HekXYyLX7eV1vTGsE0oueBbRIJm-3dE
Message-ID: <CADVnQy=J+mse5Zx2gfctxDa4h-JHjW885RjtfVZ7DbSr_Hy9Lw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 12:47=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
>
>  Hi,
> Thank you for your email.
> Following your suggestion, I downloaded the latest packetdrill tests for =
CUBIC. Attached is a new script to test the HYSTART-ACK-TRAIN detection mec=
hanism.

Great. Thanks for attaching your test.

> Additionally, it=E2=80=99s a good idea to set the hystart_detect paramete=
r to 2 (instead of 3) in the "cubic-hystart-delay-*.pkt" files.

I would argue that:

(1) Ideally, Hystart-delay tests should be run with both of the
following configurations: (a)
/sys/module/tcp_cubic/parameters/hystart_detect set to only enable
Hystart-delay; (b) /sys/module/tcp_cubic/parameters/hystart_detect set
to enable both Hystart-delay and Hystart-ack-train. (Since those are
both supported configurations of the kernel, and we want to make sure
they function correctly (the two flavors of Hystart don't interfere
with each other, and don't crash or have races or violate memory
safety invariants, etc). Running both (a) and (b) is how we run them
internally, but there's no support yet in the public packetdrill test
harness to run tests in two different configurations like that.

(2) If Hystart-delay tests are only run in one configuration, then
IMHO they should be run with
/sys/module/tcp_cubic/parameters/hystart_detect set to enable both
Hystart-delay and Hystart-ack-train, since that is the default
configuration of the kernel, and the one that the vast majority of
users will thus use.

> I recompiled the Linux kernel with the patch we both agreed on in the pre=
vious emails. However, I found that the fix passes all tests except for the=
 following:
> 1) tcp/cubic/cubic-bulk-166k-idle-restart.pkt
> 2) tcp/cubic/cubic-bulk-166k.pkt
>
> This is because these two tests assume that slow-start ends when cwnd =3D=
 48, which is not correct. I will work on these two tests and get back to y=
ou soon.

Sounds great.

Do you mind sharing your patch as well (either as an attachment or
directly to the list via "git send-email", whichever you prefer at
this stage)? That way we can start offering feedback on the kernel
patch itself.

thanks,
neal



> Best Wishes,
> Mahdi Arghavani
>
>
>
> On Friday, January 10, 2025 at 06:23:58 AM GMT+13, Neal Cardwell <ncardwe=
ll@google.com> wrote:
>
>
> On Wed, Jan 8, 2025 at 4:36=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
> >
> > Dear Eric and Neal,
> >
> > Thank you for the email.
>
> Please use plain text email so that your emails will be forwarded by
> the netdev mail server. :-)
>
> > >>> Am I right to say you are referring to
> > commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> >
> > Yes. The issue arises as a side effect of the changes introduced in thi=
s commit.
> >
> > >>> Please provide a packetdrill test, this will be the most efficient =
way to demonstrate the issue.
> >
> > Below are two different methods of demonstrating the issue:
> > A) Demonstrating via the source code
> > The changes introduced in commit 8165a9 move the caller of the `bictcp_=
hystart_reset` function inside the `hystart_update` function.
> > This modification adds an additional condition for triggering the calle=
r, requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also be s=
atisfied before invoking `bictcp_hystart_reset`.
>
> Thanks for the nice analysis.
>
> Looks like 8165a96f6b7122f25bf809aecf06f17b0ec37b58  is a stable
> branch fix, and the original commit is:
> 4e1fddc98d2585ddd4792b5e44433dcee7ece001
>
> So the ultimate patch to fix this can use a Fixes tag like:
>
> Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
> detections for not-cwnd-limited flows")
>
> Please also move the "hystart triggers when cwnd is larger than some
> threshold" comment to the line above where you have moved the logic:
>
> So the patch reads something like:
>
> @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay=
)
>         if (after(tp->snd_una, ca->end_seq))
>                 bictcp_hystart_reset(sk);
>
> +      /* hystart triggers when cwnd is larger than some threshold */
> +      if (tcp_snd_cwnd(tp) < hystart_low_window)
> +              return;
> +
> ...
> -      /* hystart triggers when cwnd is larger than some threshold */
> -      if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> -          tcp_snd_cwnd(tp) >=3D hystart_low_window)
> +      if (!ca->found && tcp_in_slow_start(tp) && hystart)
>                 hystart_update(sk, delay);
> }
>
> > B) Demonstrating via a test
> > Unfortunately, I was unable to directly print the value of `ca->round_s=
tart` (a variable defined in `tcp_cubic.c`) using packetdrill and provide y=
ou with the requested script.
> > Instead, I added a few lines of code to log the status of TCP variables=
 upon packet transmission and ACK reception.
> > To reproduce the same output on your Linux system, you need to apply th=
e changes I made to `tcp_cubic.c` and `tcp_output.c` (see the attached file=
s) and recompile the kernel.
> > I used the attached packetdrill script "only" to emulate data transmiss=
ion for the test.
> > Below are the logs accumulated in kern.log after running the packetdril=
l script:
> >
> > In Line01, the start of the first round is marked by the cubictcp_init =
function. However, the second round is marked by the reception of the 7th A=
CK when cwnd is 16 (see Line20).
> > This is incorrect because the 2nd round is started upon receiving the f=
irst ACK.
> > This means that `ca->round_start` is updated at t=3D720994842, while it=
 should have been updated 15.5 ms earlier, at t=3D720979320.
> > In this test, the length of the ACK train in the second round is calcul=
ated to be 15.5 ms shorter, which renders one of HyStart's criteria ineffec=
tive.
> >
> > Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is start=
ed. t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300
> > Line02. 2025-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D7=
20873878 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D391518=
3479
> > Line03. 2025-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=3D391518=
5479
> > Line04. 2025-01-08T08:16:23.321847+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100300 nextSeq=3D391518=
7479
> > Line05. 2025-01-08T08:16:23.321849+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D6 RTT=3D100300 nextSeq=3D391518=
9479
> > Line06. 2025-01-08T08:16:23.427777+00:00 h1a kernel: Pkt sending. t=3D7=
20873896 Sport=3D36895 cwnd=3D10 inflight=3D8 RTT=3D100300 nextSeq=3D391519=
1479
> > Line07. 2025-01-08T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=
=3D720979320 Sport=3D36895 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1
> > Line08. 2025-01-08T08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D7=
20979335 Sport=3D36895 cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D391519=
3479
> > Line09. 2025-01-08T08:16:23.427792+00:00 h1a kernel: Ack receiving. t=
=3D720979421 Sport=3D36895 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1
> > Line10. 2025-01-08T08:16:23.432773+00:00 h1a kernel: Pkt sending. t=3D7=
20979431 Sport=3D36895 cwnd=3D12 inflight=3D10 RTT=3D101517 nextSeq=3D39151=
95479
> > Line11. 2025-01-08T08:16:23.432785+00:00 h1a kernel: Ack receiving. t=
=3D720984502 Sport=3D36895 cwnd=3D12 inflight=3D11 RTT=3D102654 acked=3D1
> > Line12. 2025-01-08T08:16:23.432788+00:00 h1a kernel: Pkt sending. t=3D7=
20984514 Sport=3D36895 cwnd=3D13 inflight=3D11 RTT=3D102654 nextSeq=3D39151=
97479
> > Line13. 2025-01-08T08:16:23.432790+00:00 h1a kernel: Ack receiving. t=
=3D720984585 Sport=3D36895 cwnd=3D13 inflight=3D12 RTT=3D103658 acked=3D1
> > Line14. 2025-01-08T08:16:23.437774+00:00 h1a kernel: Pkt sending. t=3D7=
20984594 Sport=3D36895 cwnd=3D14 inflight=3D12 RTT=3D103658 nextSeq=3D39151=
99479
> > Line15. 2025-01-08T08:16:23.437783+00:00 h1a kernel: Ack receiving. t=
=3D720989668 Sport=3D36895 cwnd=3D14 inflight=3D13 RTT=3D105172 acked=3D1
> > Line16. 2025-01-08T08:16:23.437785+00:00 h1a kernel: Pkt sending. t=3D7=
20989679 Sport=3D36895 cwnd=3D15 inflight=3D13 RTT=3D105172 nextSeq=3D39152=
01479
> > Line17. 2025-01-08T08:16:23.437787+00:00 h1a kernel: Ack receiving. t=
=3D720989747 Sport=3D36895 cwnd=3D15 inflight=3D14 RTT=3D106507 acked=3D1
> > Line18. 2025-01-08T08:16:23.442773+00:00 h1a kernel: Pkt sending. t=3D7=
20989757 Sport=3D36895 cwnd=3D16 inflight=3D14 RTT=3D106507 nextSeq=3D39152=
03479
> > Line19. 2025-01-08T08:16:23.442780+00:00 h1a kernel: Ack receiving. t=
=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312 acked=3D1
> >
> > Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New round is start=
ed. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312
> >
> > Line21. 2025-01-08T08:16:23.442783+00:00 h1a kernel: Pkt sending. t=3D7=
20994857 Sport=3D36895 cwnd=3D17 inflight=3D15 RTT=3D108312 nextSeq=3D39152=
05479
> > Line22. 2025-01-08T08:16:23.442785+00:00 h1a kernel: Ack receiving. t=
=3D720994927 Sport=3D36895 cwnd=3D17 inflight=3D16 RTT=3D109902 acked=3D1
> > Line23. 2025-01-08T08:16:23.448788+00:00 h1a kernel: Pkt sending. t=3D7=
20994936 Sport=3D36895 cwnd=3D18 inflight=3D16 RTT=3D109902 nextSeq=3D39152=
07479
> > Line24. 2025-01-08T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=
=3D721000016 Sport=3D36895 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1
> > Line25. 2025-01-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D7=
21000026 Sport=3D36895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D39152=
09479
> > Line26. 2025-01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=
=3D721000100 Sport=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1
> > Line27. 2025-01-08T08:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D7=
21000110 Sport=3D36895 cwnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D39152=
11479
>
> To create a packetdrill test, you don't need to print round_start. You
> can simply construct a packetdrill scenario and assert that
> tcpi_snd_cwnd and tcpi_snd_ssthresh change in the expected ways over
> the course of the test, as packetdrill injects ACKs into your kernel
> under test.
>
> I have upstreamed our packetdrill tests for TCP CUBIC today, so you
> can have some examples to look at. I recommend looking at the
> gtests/net/tcp/cubic/cubic-hystart-delay-rtt-jumps-upward.pkt file in
> this patch:
>
> https://github.com/google/packetdrill/commit/8d63bbc7d6273f86e826ac16dbc3=
c38d4a41b129#diff-d7a68a37bc59309d374f8b97abcd406e263980415dd5af5c68db23f90=
f2d21a6
>
> Before sending your patch to the list, please:
>
> + Download and build packetdrill. For tips on using packetdrill, you
> can start with:
>
> https://github.com/google/packetdrill
>
> + run all cubic packetdrill tests, to help test that your commit does
> not introduce any bugs:
>
> cd ~/packetdrill/gtests/net/
> ./packetdrill/run_all.py -S -v -L -l tcp/cubic/
>
> + read: https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.h=
tml
>
> + run something like the following to verify the format of the patch
>
> git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD
> ./scripts/checkpatch.pl 00*patch
>
> When all the warnings have been resolved, you can send the patch to
> the list. :-)
>
> > >>> Note that we are still waiting for an HyStart++ implementation for =
linux, you may be interested in working on it.
> >
> > Thank you for the suggestion. I would be happy to work on the HyStart++=
 implementation for Linux. Could you kindly provide more details on the spe=
cific requirements, workflow, and expected outcomes to help me get started?
>
> The specific requirements are in the Hystart++ RFC:
>   https://datatracker.ietf.org/doc/html/rfc9406
>
> The workflow would be to develop the code, run your kernel to test it
> with packetdrill and test transfers in a controlled setting, then send
> the patches to the netdev list for review.
>
> The expected outcome would be to come up with working patches that are
> readable, pass ./scripts/checkpatch.pl, compile and pass packetdrill
> cubic tests, and produce improved behavior in at least some test
> (probably a test where the Hystart++ implementation prevents a
> spurious exit of slow-start when min_rtt jumps upward, which is common
> in cellular/wifi cases).
>
> thanks,
> neal
>
>
> > Best wishes,
> > Mahdi Arghavani
> >
> > On Monday, January 6, 2025 at 09:24:49 PM GMT+13, Eric Dumazet <edumaze=
t@google.com> wrote:
> >
> >
> > On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@ya=
hoo.com> wrote:
> > >
> > > Hi,
> > >
> > > While refining the source code for our project (SUSS), I discovered a=
 bug in the implementation of HyStart in the Linux kernel, starting from ve=
rsion v5.15.6. The issue, caused by incorrect marking of round starts, resu=
lts in inaccurate measurement of the length of each ACK train. Since HyStar=
t relies on the length of ACK trains as one of two key criteria to stop exp=
onential cwnd growth during Slow-Start, this inaccuracy renders the criteri=
on ineffective, potentially degrading TCP performance.
> > >
> >
> > Hi Mahdi
> >
> > netdev@ mailing list does not accept HTML messages.
> >
> > Am I right to say you are referring to
> >
> > commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> > Author: Eric Dumazet <edumazet@google.com>
> > Date:  Tue Nov 23 12:25:35 2021 -0800
> >
> >    tcp_cubic: fix spurious Hystart ACK train detections for
> > not-cwnd-limited flows
> >
> >    [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]
> >
> >
> >
> > > Issue Description: The problem arises because the hystart_reset funct=
ion is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see th=
e attached figure). Instead, its invocation is delayed until the condition =
cwnd >=3D hystart_low_window is satisfied. In each round, this delay causes=
:
> > >
> > > 1) A postponed marking of the start of a new round.
> > >
> > > 2) An incorrect update of ca->end_seq, leading to incorrect marking o=
f the subsequent round.
> > >
> > > As a result, the ACK train length is underestimated, which adversely =
affects HyStart=E2=80=99s first criterion for stopping cwnd exponential gro=
wth.
> > >
> > > Proposed Solution: Below is a tested patch that addresses the issue b=
y ensuring hystart_reset is triggered appropriately:
> > >
> >
> >
> >
> > Please provide a packetdrill test, this will be the most efficient way
> > to demonstrate the issue.
> >
> > In general, ACK trains detection is not useful in modern networks,
> > because of TSO and GRO.
> >
> > Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563
> >
> > Note that we are still waiting for an HyStart++ implementation for linu=
x,
> > you may be interested in working on it.
> >
> > Thank you.
> >
> >
> > >
> > >
> > > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> > >
> > > index 5dbed91c6178..78d9cf493ace 100644
> > >
> > > --- a/net/ipv4/tcp_cubic.c
> > >
> > > +++ b/net/ipv4/tcp_cubic.c
> > >
> > > @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 d=
elay)
> > >
> > >        if (after(tp->snd_una, ca->end_seq))
> > >
> > >                bictcp_hystart_reset(sk);
> > >
> > >
> > >
> > > +      if (tcp_snd_cwnd(tp) < hystart_low_window)
> > >
> > > +              return;
> > >
> > > +
> > >
> > >        if (hystart_detect & HYSTART_ACK_TRAIN) {
> > >
> > >                u32 now =3D bictcp_clock_us(sk);
> > >
> > >
> > >
> > > @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct soc=
k *sk, const struct ack_sample
> > >
> > >                ca->delay_min =3D delay;
> > >
> > >
> > >
> > >        /* hystart triggers when cwnd is larger than some threshold */
> > >
> > > -      if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> > >
> > > -          tcp_snd_cwnd(tp) >=3D hystart_low_window)
> > >
> > > +      if (!ca->found && tcp_in_slow_start(tp) && hystart)
> > >
> > >                hystart_update(sk, delay);
> > >
> > >  }
> > >
> > > Best wishes,
> > > Mahdi Arghavani

