Return-Path: <netdev+bounces-156821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6404A07EAE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDC216555C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580318B482;
	Thu,  9 Jan 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDvWW7Jy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4BB644
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443439; cv=none; b=TdEf5e6CZTP7MQb7EfiADPpueGL4jZlSNpCXeCZPXrCkvgqZYaqpGEVYQYViykRyFZLOppIl/uRxbhe6hqmkwKdPWuDkC2zmLpivQDIU3bdfPX+afJlWUnORa0bwZnVTBTF7bGYNNiIuetGuLEEbIiZrnl2hb216ZfuklFwcCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443439; c=relaxed/simple;
	bh=wkU5vrtjJ0iBbh5cxTqnJAM3GJpTK5uIVH3kE8O3SQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U77BOkqsDB3s/qLE+4ZvSsUvLJRRXV7ZDMKh35R9FI6NAITTbLarbAHS8tYmzp1q0lSliA/F8zgwH/ms9M7krjzSxGFAHovHuXoUpsYbYEizqynswNuBuVzjAHwZrdT8QutKqhkkQoC00BqvzaK498b0J0TbcGMq1BUdaVX8bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDvWW7Jy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679b5c66d0so272671cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736443436; x=1737048236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRMjIgQWUIwN6QpFn0RcgfGqNDmO4zkkZ/imQKoaR4U=;
        b=hDvWW7JyI/6X5OqCunty9ymz7vzBDo4JynkI1fFMUcs1gILOsyl9cQdkGjPq246D8Q
         +3/18KvpBucvz9cMBfRhf/B7oAnNNfzDc+DRGxQyL5/MgDv60mQ0sFnsef8cToI+UZLt
         aq7JJxae9eh5b7vF7wF1rGiuUav9XafAR+MSNv65b1lf2FHNWXWb8KfY4hzxMuaiUbv2
         xytOpf3bhYfgFn0YBNU9iDVBENgvAYEIulMdVCkCItsf1asdMuClHE9AFsqFVA4DhyoF
         NXj2RPhtdJsHOWX7q2h5Hob03awSn++AEBH2VSMkOmdGpiKYNEnJq6XHOGo2bwucLQYG
         1kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736443436; x=1737048236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRMjIgQWUIwN6QpFn0RcgfGqNDmO4zkkZ/imQKoaR4U=;
        b=iNkTMuvJoX/5oRyaWlozIhyCs3OgtY8Nx1IOrfxjvLytaWr3mFYrbY42LafdPX1ZAN
         Wwu443973tn4rJfVY3VVjOqAQ75CtL8+qnBnhEgDuh/JrWGFgC+HHoQVwdLcvLPk3dYh
         FP5C/3KKFarU02HWCOdc8YUGkyHW6wcrYSZ7oSwbd2IZBgH7pdn9W4bRRTQNQ3VpTa8W
         HFmDDGgVJN7XwuJTjL0rzG7BoK9lLvJ9rW0KVBYr9GR8qHQAcW62GCPZXpVqypB5lL2b
         RHH3uWbiATfsBeZBIUgicqVwWlgDM8R36CuSSb5WLZu5sagn5Q8ouYcIJHoCtdRqG/rJ
         yiFg==
X-Forwarded-Encrypted: i=1; AJvYcCUlq7XHnT2KG30YEY5lnUyVz+Kf4135tIpHIUpRZIrbbVgEn9iC0ykRN5Vuczzwag6OV7/UXMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WKDnPEetijGeVJuMgoRyQl4fWrjyq4XEilOjYVd7G3HtYHUR
	VHMWDaIy4s04h1DnbLE8nFHXGzsCyXHHrfgPcujliMoIZUnFqrQy7agqQY4SNw8iAXV5dvCkzzy
	SfGnDTxuR5hXa91x5DRy244Hqh7hZ3e+LLbVp
X-Gm-Gg: ASbGncsRsqW+XVczcxAYym5f4Al20w8ZzBaGNHqWswTkqzdXzqJuXudgHCa+sTb119u
	o67EhTC1tqYt8ZuJfKuW9JHsOWTDsasivsGvM2SeY9LvOQ/wv6UR6alkYvPvgl6+O57IG9g==
X-Google-Smtp-Source: AGHT+IFQi0YrWSTf+XX43CkPygYY5XMUR1ByblGG0z00MVNJXWHyYTCc88Kto6pl5wFXxpVZ6c5KdydaV7kLI4bejpI=
X-Received: by 2002:ac8:5ac5:0:b0:46c:78e4:a9cc with SMTP id
 d75a77b69052e-46c7cf066c0mr4034621cf.25.1736443435933; Thu, 09 Jan 2025
 09:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <408334417.4436448.1736139157134.ref@mail.yahoo.com>
 <408334417.4436448.1736139157134@mail.yahoo.com> <CANn89iLzo0Wk7p=dtUQ4Q2-pCAsjSxXZw71ngNTw6NZbEEvoDA@mail.gmail.com>
 <2046438615.4484034.1736328888690@mail.yahoo.com>
In-Reply-To: <2046438615.4484034.1736328888690@mail.yahoo.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 9 Jan 2025 12:23:39 -0500
X-Gm-Features: AbW1kvZ9-T34UzKVXc1osW1TrOgeUgxI4NO7FRpiLmfgDpzIsdoCGkbVR8J_QV8
Message-ID: <CADVnQymzCpJozeF-wMPbppizg0SUAUufgyQEeD7AB5DZDNBTEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: Fix for bug in HyStart implementation in
 the Linux kernel
To: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Eric Dumazet <edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Haibo Zhang <haibo.zhang@otago.ac.nz>, David Eyers <david.eyers@otago.ac.nz>, 
	Abbas Arghavani <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:36=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yahoo.=
com> wrote:
>
> Dear Eric and Neal,
>
> Thank you for the email.

Please use plain text email so that your emails will be forwarded by
the netdev mail server. :-)

> >>> Am I right to say you are referring to
> commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
>
> Yes. The issue arises as a side effect of the changes introduced in this =
commit.
>
> >>> Please provide a packetdrill test, this will be the most efficient wa=
y to demonstrate the issue.
>
> Below are two different methods of demonstrating the issue:
> A) Demonstrating via the source code
> The changes introduced in commit 8165a9 move the caller of the `bictcp_hy=
start_reset` function inside the `hystart_update` function.
> This modification adds an additional condition for triggering the caller,=
 requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also be sat=
isfied before invoking `bictcp_hystart_reset`.

Thanks for the nice analysis.

Looks like 8165a96f6b7122f25bf809aecf06f17b0ec37b58  is a stable
branch fix, and the original commit is:
4e1fddc98d2585ddd4792b5e44433dcee7ece001

So the ultimate patch to fix this can use a Fixes tag like:

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train
detections for not-cwnd-limited flows")

Please also move the "hystart triggers when cwnd is larger than some
threshold" comment to the line above where you have moved the logic:

So the patch reads something like:

@@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 delay)
        if (after(tp->snd_una, ca->end_seq))
                bictcp_hystart_reset(sk);

+      /* hystart triggers when cwnd is larger than some threshold */
+       if (tcp_snd_cwnd(tp) < hystart_low_window)
+               return;
+
...
-       /* hystart triggers when cwnd is larger than some threshold */
-       if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-           tcp_snd_cwnd(tp) >=3D hystart_low_window)
+       if (!ca->found && tcp_in_slow_start(tp) && hystart)
                hystart_update(sk, delay);
 }

> B) Demonstrating via a test
> Unfortunately, I was unable to directly print the value of `ca->round_sta=
rt` (a variable defined in `tcp_cubic.c`) using packetdrill and provide you=
 with the requested script.
> Instead, I added a few lines of code to log the status of TCP variables u=
pon packet transmission and ACK reception.
> To reproduce the same output on your Linux system, you need to apply the =
changes I made to `tcp_cubic.c` and `tcp_output.c` (see the attached files)=
 and recompile the kernel.
> I used the attached packetdrill script "only" to emulate data transmissio=
n for the test.
> Below are the logs accumulated in kern.log after running the packetdrill =
script:
>
> In Line01, the start of the first round is marked by the cubictcp_init fu=
nction. However, the second round is marked by the reception of the 7th ACK=
 when cwnd is 16 (see Line20).
> This is incorrect because the 2nd round is started upon receiving the fir=
st ACK.
> This means that `ca->round_start` is updated at t=3D720994842, while it s=
hould have been updated 15.5 ms earlier, at t=3D720979320.
> In this test, the length of the ACK train in the second round is calculat=
ed to be 15.5 ms shorter, which renders one of HyStart's criteria ineffecti=
ve.
>
> Line01. 2025-01-08T08:16:23.321839+00:00 h1a kernel: New round is started=
. t=3D720873683 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300
> Line02. 2025-01-08T08:16:23.321842+00:00 h1a kernel: Pkt sending. t=3D720=
873878 Sport=3D36895 cwnd=3D10 inflight=3D0 RTT=3D100300 nextSeq=3D39151834=
79
> Line03. 2025-01-08T08:16:23.321845+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D2 RTT=3D100300 nextSeq=3D39151854=
79
> Line04. 2025-01-08T08:16:23.321847+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D4 RTT=3D100300 nextSeq=3D39151874=
79
> Line05. 2025-01-08T08:16:23.321849+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D6 RTT=3D100300 nextSeq=3D39151894=
79
> Line06. 2025-01-08T08:16:23.427777+00:00 h1a kernel: Pkt sending. t=3D720=
873896 Sport=3D36895 cwnd=3D10 inflight=3D8 RTT=3D100300 nextSeq=3D39151914=
79
> Line07. 2025-01-08T08:16:23.427787+00:00 h1a kernel: Ack receiving. t=3D7=
20979320 Sport=3D36895 cwnd=3D10 inflight=3D9 RTT=3D100942 acked=3D1
> Line08. 2025-01-08T08:16:23.427790+00:00 h1a kernel: Pkt sending. t=3D720=
979335 Sport=3D36895 cwnd=3D11 inflight=3D9 RTT=3D100942 nextSeq=3D39151934=
79
> Line09. 2025-01-08T08:16:23.427792+00:00 h1a kernel: Ack receiving. t=3D7=
20979421 Sport=3D36895 cwnd=3D11 inflight=3D10 RTT=3D101517 acked=3D1
> Line10. 2025-01-08T08:16:23.432773+00:00 h1a kernel: Pkt sending. t=3D720=
979431 Sport=3D36895 cwnd=3D12 inflight=3D10 RTT=3D101517 nextSeq=3D3915195=
479
> Line11. 2025-01-08T08:16:23.432785+00:00 h1a kernel: Ack receiving. t=3D7=
20984502 Sport=3D36895 cwnd=3D12 inflight=3D11 RTT=3D102654 acked=3D1
> Line12. 2025-01-08T08:16:23.432788+00:00 h1a kernel: Pkt sending. t=3D720=
984514 Sport=3D36895 cwnd=3D13 inflight=3D11 RTT=3D102654 nextSeq=3D3915197=
479
> Line13. 2025-01-08T08:16:23.432790+00:00 h1a kernel: Ack receiving. t=3D7=
20984585 Sport=3D36895 cwnd=3D13 inflight=3D12 RTT=3D103658 acked=3D1
> Line14. 2025-01-08T08:16:23.437774+00:00 h1a kernel: Pkt sending. t=3D720=
984594 Sport=3D36895 cwnd=3D14 inflight=3D12 RTT=3D103658 nextSeq=3D3915199=
479
> Line15. 2025-01-08T08:16:23.437783+00:00 h1a kernel: Ack receiving. t=3D7=
20989668 Sport=3D36895 cwnd=3D14 inflight=3D13 RTT=3D105172 acked=3D1
> Line16. 2025-01-08T08:16:23.437785+00:00 h1a kernel: Pkt sending. t=3D720=
989679 Sport=3D36895 cwnd=3D15 inflight=3D13 RTT=3D105172 nextSeq=3D3915201=
479
> Line17. 2025-01-08T08:16:23.437787+00:00 h1a kernel: Ack receiving. t=3D7=
20989747 Sport=3D36895 cwnd=3D15 inflight=3D14 RTT=3D106507 acked=3D1
> Line18. 2025-01-08T08:16:23.442773+00:00 h1a kernel: Pkt sending. t=3D720=
989757 Sport=3D36895 cwnd=3D16 inflight=3D14 RTT=3D106507 nextSeq=3D3915203=
479
> Line19. 2025-01-08T08:16:23.442780+00:00 h1a kernel: Ack receiving. t=3D7=
20994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312 acked=3D1
>
> Line20. 2025-01-08T08:16:23.442782+00:00 h1a kernel: New round is started=
. t=3D720994842 Sport=3D36895 cwnd=3D16 inflight=3D15 RTT=3D108312
>
> Line21. 2025-01-08T08:16:23.442783+00:00 h1a kernel: Pkt sending. t=3D720=
994857 Sport=3D36895 cwnd=3D17 inflight=3D15 RTT=3D108312 nextSeq=3D3915205=
479
> Line22. 2025-01-08T08:16:23.442785+00:00 h1a kernel: Ack receiving. t=3D7=
20994927 Sport=3D36895 cwnd=3D17 inflight=3D16 RTT=3D109902 acked=3D1
> Line23. 2025-01-08T08:16:23.448788+00:00 h1a kernel: Pkt sending. t=3D720=
994936 Sport=3D36895 cwnd=3D18 inflight=3D16 RTT=3D109902 nextSeq=3D3915207=
479
> Line24. 2025-01-08T08:16:23.448805+00:00 h1a kernel: Ack receiving. t=3D7=
21000016 Sport=3D36895 cwnd=3D18 inflight=3D17 RTT=3D111929 acked=3D1
> Line25. 2025-01-08T08:16:23.448807+00:00 h1a kernel: Pkt sending. t=3D721=
000026 Sport=3D36895 cwnd=3D19 inflight=3D17 RTT=3D111929 nextSeq=3D3915209=
479
> Line26. 2025-01-08T08:16:23.448808+00:00 h1a kernel: Ack receiving. t=3D7=
21000100 Sport=3D36895 cwnd=3D19 inflight=3D18 RTT=3D113713 acked=3D1
> Line27. 2025-01-08T08:16:23.496807+00:00 h1a kernel: Pkt sending. t=3D721=
000110 Sport=3D36895 cwnd=3D20 inflight=3D18 RTT=3D113713 nextSeq=3D3915211=
479

To create a packetdrill test, you don't need to print round_start. You
can simply construct a packetdrill scenario and assert that
tcpi_snd_cwnd and tcpi_snd_ssthresh change in the expected ways over
the course of the test, as packetdrill injects ACKs into your kernel
under test.

I have upstreamed our packetdrill tests for TCP CUBIC today, so you
can have some examples to look at. I recommend looking at the
gtests/net/tcp/cubic/cubic-hystart-delay-rtt-jumps-upward.pkt file in
this patch:

https://github.com/google/packetdrill/commit/8d63bbc7d6273f86e826ac16dbc3c3=
8d4a41b129#diff-d7a68a37bc59309d374f8b97abcd406e263980415dd5af5c68db23f90f2=
d21a6

Before sending your patch to the list, please:

+ Download and build packetdrill. For tips on using packetdrill, you
can start with:

https://github.com/google/packetdrill

+ run all cubic packetdrill tests, to help test that your commit does
not introduce any bugs:

cd ~/packetdrill/gtests/net/
./packetdrill/run_all.py -S -v -L -l tcp/cubic/

+ read: https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.htm=
l

+ run something like the following to verify the format of the patch

git format-patch --subject-prefix=3D'PATCH net' HEAD~1..HEAD
./scripts/checkpatch.pl 00*patch

When all the warnings have been resolved, you can send the patch to
the list. :-)

> >>> Note that we are still waiting for an HyStart++ implementation for li=
nux, you may be interested in working on it.
>
> Thank you for the suggestion. I would be happy to work on the HyStart++ i=
mplementation for Linux. Could you kindly provide more details on the speci=
fic requirements, workflow, and expected outcomes to help me get started?

The specific requirements are in the Hystart++ RFC:
  https://datatracker.ietf.org/doc/html/rfc9406

The workflow would be to develop the code, run your kernel to test it
with packetdrill and test transfers in a controlled setting, then send
the patches to the netdev list for review.

The expected outcome would be to come up with working patches that are
readable, pass ./scripts/checkpatch.pl, compile and pass packetdrill
cubic tests, and produce improved behavior in at least some test
(probably a test where the Hystart++ implementation prevents a
spurious exit of slow-start when min_rtt jumps upward, which is common
in cellular/wifi cases).

thanks,
neal

> Best wishes,
> Mahdi Arghavani
>
> On Monday, January 6, 2025 at 09:24:49 PM GMT+13, Eric Dumazet <edumazet@=
google.com> wrote:
>
>
> On Mon, Jan 6, 2025 at 5:53=E2=80=AFAM Mahdi Arghavani <ma.arghavani@yaho=
o.com> wrote:
> >
> > Hi,
> >
> > While refining the source code for our project (SUSS), I discovered a b=
ug in the implementation of HyStart in the Linux kernel, starting from vers=
ion v5.15.6. The issue, caused by incorrect marking of round starts, result=
s in inaccurate measurement of the length of each ACK train. Since HyStart =
relies on the length of ACK trains as one of two key criteria to stop expon=
ential cwnd growth during Slow-Start, this inaccuracy renders the criterion=
 ineffective, potentially degrading TCP performance.
> >
>
> Hi Mahdi
>
> netdev@ mailing list does not accept HTML messages.
>
> Am I right to say you are referring to
>
> commit 8165a96f6b7122f25bf809aecf06f17b0ec37b58
> Author: Eric Dumazet <edumazet@google.com>
> Date:  Tue Nov 23 12:25:35 2021 -0800
>
>     tcp_cubic: fix spurious Hystart ACK train detections for
> not-cwnd-limited flows
>
>     [ Upstream commit 4e1fddc98d2585ddd4792b5e44433dcee7ece001 ]
>
>
>
> > Issue Description: The problem arises because the hystart_reset functio=
n is not called upon receiving the first ACK (when cwnd=3Diw=3D10, see the =
attached figure). Instead, its invocation is delayed until the condition cw=
nd >=3D hystart_low_window is satisfied. In each round, this delay causes:
> >
> > 1) A postponed marking of the start of a new round.
> >
> > 2) An incorrect update of ca->end_seq, leading to incorrect marking of =
the subsequent round.
> >
> > As a result, the ACK train length is underestimated, which adversely af=
fects HyStart=E2=80=99s first criterion for stopping cwnd exponential growt=
h.
> >
> > Proposed Solution: Below is a tested patch that addresses the issue by =
ensuring hystart_reset is triggered appropriately:
> >
>
>
>
> Please provide a packetdrill test, this will be the most efficient way
> to demonstrate the issue.
>
> In general, ACK trains detection is not useful in modern networks,
> because of TSO and GRO.
>
> Reference : https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dede656e8465839530c3287c7f54adf75dc2b9563
>
> Note that we are still waiting for an HyStart++ implementation for linux,
> you may be interested in working on it.
>
> Thank you.
>
>
> >
> >
> > diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> >
> > index 5dbed91c6178..78d9cf493ace 100644
> >
> > --- a/net/ipv4/tcp_cubic.c
> >
> > +++ b/net/ipv4/tcp_cubic.c
> >
> > @@ -392,6 +392,9 @@ static void hystart_update(struct sock *sk, u32 del=
ay)
> >
> >        if (after(tp->snd_una, ca->end_seq))
> >
> >                bictcp_hystart_reset(sk);
> >
> >
> >
> > +      if (tcp_snd_cwnd(tp) < hystart_low_window)
> >
> > +              return;
> >
> > +
> >
> >        if (hystart_detect & HYSTART_ACK_TRAIN) {
> >
> >                u32 now =3D bictcp_clock_us(sk);
> >
> >
> >
> > @@ -468,8 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock =
*sk, const struct ack_sample
> >
> >                ca->delay_min =3D delay;
> >
> >
> >
> >        /* hystart triggers when cwnd is larger than some threshold */
> >
> > -      if (!ca->found && tcp_in_slow_start(tp) && hystart &&
> >
> > -          tcp_snd_cwnd(tp) >=3D hystart_low_window)
> >
> > +      if (!ca->found && tcp_in_slow_start(tp) && hystart)
> >
> >                hystart_update(sk, delay);
> >
> >  }
> >
> > Best wishes,
> > Mahdi Arghavani

