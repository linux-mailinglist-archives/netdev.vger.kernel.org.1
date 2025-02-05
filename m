Return-Path: <netdev+bounces-163249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03999A29B44
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EDE7A1184
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04C2135C4;
	Wed,  5 Feb 2025 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QltqqJjJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB7D1FE47E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738787716; cv=none; b=N+S2lPLKZWmXKEtpANQODY0/emtuAr1Ed/zROSNfgQNe2/GOBHZwb2kpf9T889ZOhXaCIeO6QPijdJVPRJY0o1Dnt1bc/q7oCaH9kKfGnhrXPEcJWi+qUDXikzr7GacifL6P8hFEoBdRjtwb9WNKTmbLJd/8Qt639WYk4WevTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738787716; c=relaxed/simple;
	bh=9uhSSymTD+LR1nnU8QBdVXeLHdng7CffiG/jd8nEuew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTmUHP/uyG947V9p7FKczl6sT/B/hW7eMDz2Fx5QWx4lboWco+J+9HIwSw9qF3ieRa1N9N//ny+eIBtY5fkQ684+z3Az9prnf6B/KM7/CfjLgVNCqXJmDcWaBLd5Hvf/vdUqh0lByw32KABiYo8xKMlkMW9JQxvF5DPseum3ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QltqqJjJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361d5730caso12425e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738787712; x=1739392512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urb6xm7/7okcq6czgCjj/E7O2YYcw3FvvhdeOGjtlgc=;
        b=QltqqJjJujpQRLSJy4NfeIxbRFe5WQEfk4PWrhNnAID4nZEKO9QqfL8dzDOy3SLSNg
         deUJMQc2/atoWN6e8DrvGOxL8BM+Weg0+IQ0QiBKUE/klv3JfHADXzlaQ0ByNzrV1WE7
         cIlQz+2sg3wTvx94xp1FxW0gbySXsXKNgnuetyTFDN/nucm6/ppT77q6199UDqjVjm5e
         hWrZU+6l5HBxBN/hkJBSpVk7t/4/5CQXamh+CDM4qHRliaxAbmkIVnsDg14eIx1LDxt1
         veakguVphLUT0RDePirOoVbWKfPXhUZiBFAwwBRFS+UuN2HD3B0nP4Ga/eed7RGMQnxd
         8XHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738787712; x=1739392512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urb6xm7/7okcq6czgCjj/E7O2YYcw3FvvhdeOGjtlgc=;
        b=GEXU7dStxNxOquvHWjL4+zagAdbtPZj23L8yhL71wrSaTkiJ6Yz05QrsbGyF0iEhEL
         9CYhrIR/knfrtngC+yK8Kd7fzwTmWd7FoeF6Id7zUPuQFWzkBtcrHt7dchBkrBtgVitD
         UatleFtUx7PhF/+EC1aIjJmasAyuNZx5kxou/HIj7ynhyfm1NE9IAqrvQ+rLQkHzjROT
         Df06tUtvK/s+1BszMnmwWZIuiWFBR2sykFJSLn4PFcQzv5zthydOOVvGiG1agHYbrbPw
         sOkBxCAnYv1G8uQPy8v+K7BHViOinlwugrh6d07gP2pyc3VCqVp7ijDXG7fIRKXtKA1p
         4RzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHX17x7IAbTnwY9Rr91yozVkOaAKfGWJeNSa2LReIffQRAnIoSgBtc+1N4MuDasqNz2aZEV+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5eEIQjNU3RoSPgeOUz1B9s+TwY9J4NJRgHVi6aeTYpMB26kc
	1dzrnKybmAo/1VB7bKigeLXaKNxTiPIWRYL90PtNdOgGcQ5ocRT/SUp4jNXtp0gvv/p+mxHhiOq
	IYQI/A8B9vCt8Xo71pYrFSAbg91avi3wZ7mlX
X-Gm-Gg: ASbGncsKd1KUW/WodMj7BEK+tm08WijTpjyposwQ8GtcCwyYX15VWs5bkCvLqbyNWSD
	HHn1wgwi7Q1eLcNa8vS9/hr5NUaxpN5rYOw1OE47gGugZI246+cXNSu+LlkKGtA6gZG3lv2fDHv
	HKEH1pS6FFsbYwcqHZDUI7WFd/u77EFw==
X-Google-Smtp-Source: AGHT+IGDVZn64xZrTHrQQthACytag4s3585o+q95RcTObDmG+EPR8F9mmCwO6CmF47Mf9GJcN+25RmNs/HRFBQ8ucH4=
X-Received: by 2002:a05:600c:5116:b0:434:a0fd:95d9 with SMTP id
 5b1f17b1804b1-4391331bb5amr151815e9.5.1738787712035; Wed, 05 Feb 2025
 12:35:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
In-Reply-To: <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 5 Feb 2025 12:35:00 -0800
X-Gm-Features: AWEUYZknxfm_a-dBgI6Ld3ERDYTBM0AThjBoXIOSqOKXMotBn0-c7JwIFPx4Hwg
Message-ID: <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:32=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.c=
a> wrote:
>
> On 2025-02-04 19:10, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continu=
ous
> > busy polling.
>
> [snip]
>
> > Setup:
> >
> > - Running on Google C3 VMs with idpf driver with following configuratio=
ns.
> > - IRQ affinity and coalascing is common for both experiments.
> > - There is only 1 RX/TX queue configured.
> > - First experiment enables busy poll using sysctl for both epoll and
> >    socket APIs.
> > - Second experiment enables NAPI threaded busy poll for the full device
> >    using sysctl.
> >
> > Non threaded NAPI busy poll enabled using sysctl.
> > ```
> > echo 400 | sudo tee /proc/sys/net/core/busy_poll
> > echo 400 | sudo tee /proc/sys/net/core/busy_read
> > echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> > echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > ```
> >
> > Results using following command,
> > ```
> > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v \
> >               --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F =
50 \
> >               -p 50,90,99,999 -H <IP> -l 10
> >
> > ...
> > ...
> >
> > num_transactions=3D2835
> > latency_min=3D0.000018976
> > latency_max=3D0.049642100
> > latency_mean=3D0.003243618
> > latency_stddev=3D0.010636847
> > latency_p50=3D0.000025270
> > latency_p90=3D0.005406710
> > latency_p99=3D0.049807350
> > latency_p99.9=3D0.049807350
> > ```
> >
> > Results with napi threaded busy poll using following command,
> > ```
> > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v \
> >                  --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -T 1 =
-F 50 \
> >                  -p 50,90,99,999 -H <IP> -l 10
> >
> > ...
> > ...
> >
> > num_transactions=3D460163
> > latency_min=3D0.000015707
> > latency_max=3D0.200182942
> > latency_mean=3D0.000019453
> > latency_stddev=3D0.000720727
> > latency_p50=3D0.000016950
> > latency_p90=3D0.000017270
> > latency_p99=3D0.000018710
> > latency_p99.9=3D0.000020150
> > ```
> >
> > Here with NAPI threaded busy poll in a separate core, we are able to
> > consistently poll the NAPI to keep latency to absolute minimum. And als=
o
> > we are able to do this without any major changes to the onload stack an=
d
> > threading model.
>
> As far as I'm concerned, this is still not sufficient information to
> fully assess the experiment. The experiment shows an 162-fold decrease
> in latency and a corresponding increase in throughput for this
> closed-loop workload (which, btw, is different from your open-loop fixed
> rate use case). This would be an extraordinary improvement and that
> alone warrants some scrutiny. 162X means either the base case has a lot
> of idle time or wastes an enormous amount of cpu cycles. How can that be
> explained? It would be good to get some instruction/cycle counts to
> drill down further.
The difference is much more apparent (and larger) when I am using more
sockets (50) in this case. I have noticed that the situation gets
worse if I add much more sockets in the mix, but I think this here is
enough to show the effect. The processing of packets on a core and
then going back to userspace to do application work (or protocol
processing in case of onload) is not ok for this use case. If you look
at P50, most of the time there is not much difference, but the tail
latencies add up in the P90 case. I want the descriptors to be pulled
from the NIC queues and handed over right away for processing to a
separate core.
>
> The server process invocation and the actual irq routing is not
> provided. Just stating its common for both experiments is not
> sufficient. Without further information, I still cannot rule out that:
>
> - In the base case, application and napi processing execute on the same
> core and trample on each other. I don't know how onload implements
> epoll_wait, but I worry that it cannot align application processing
> (busy-looping?) and napi processing (also busy-looping?).
>
> - In the threaded busy-loop case, napi processing ends up on one core,
> while the application executes on another one. This uses two cores
> instead of one.
>
> Based on the above, I think at least the following additional scenarios
> need to be investigated:
>
> a) Run the server application in proper fullbusy mode, i.e., cleanly
> alternating between application processing and napi processing. As a
> second step, spread the incoming traffic across two cores to compare
> apples to apples.
This is exactly what is being done in the experiment I posted and it
shows massive degradation of latency when the core is shared between
application processing and napi processing. The busy_read setup above
that I mentioned, makes onload do napi processing when xsk_recvmsg is
called. Also onload spins in the userspace to handle the AF_XDP
queues/rings in memory.
>
> b) Run application and napi processing on separate cores, but simply by
> way of thread pinning and interrupt routing. How close does that get to
> the current results? Then selectively add threaded napi and then busy
> polling.
This was the base case with which we started looking into this work.
And this gives much worse latency because the packets are only picked
from the RX queue on interrupt wakeups (and BH). In fact moving them
to separate cores in this case makes the core getting interrupts be
idle and go to sleep if the frequency of packets is low.
>
> c) Run the whole thing without onload for comparison. The benefits
> should show without onload as well and it's easier to reproduce. Also, I
> suspect onload hurts in the base case and that explains the atrociously
> high latency and low throughput of it.
>
> Or, even better, simply provide a complete specification / script for
> the experiment that makes it easy to reproduce.
That would require setting up onload on the platform you use, provided
it has all the AF_XDP things needed to bring it up. I think I have
provided everything that you would need to set this up on your
platform. I have provided the onload repo, it is open source and it
has README with steps to set it up. I have provided the sysctls
configuration I am using. I have also provided the exact command with
all the arguments I am using to run onload with neper (configuration
and environment including cpu affinity setup).
>
> Note that I don't dismiss the approach out of hand. I just think it's
> important to properly understand the purported performance improvements.
I think the performance improvements are apparent with the data I
provided, I purposefully used more sockets to show the real
differences in tail latency with this revision.

Also one thing that you are probably missing here is that the change
here also has an API aspect, that is it allows a user to drive napi
independent of the user API or protocol being used. I mean I can
certainly drive the napi using recvmsg, but the napi will only be
driven if there is no data in the recv queue. The recvmsg will check
the recv_queue and if it is not empty it will return. This forces the
application to drain the socket and then do napi processing, basically
introducing the same effect of alternating between napi processing and
application processing. The use case to drive the napi in a separate
core (or a couple of threads sharing a single core) is handled cleanly
with this change by enabling it through netlink.
> At the same time, I don't think it's good for the planet to burn cores
> with busy-looping without good reason.
>
> Thanks,
> Martin
>

