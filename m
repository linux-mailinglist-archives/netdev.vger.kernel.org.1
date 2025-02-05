Return-Path: <netdev+bounces-163276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAE0A29C51
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B34B37A10DF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD91FECB9;
	Wed,  5 Feb 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DKKQxncj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D61DD526
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793199; cv=none; b=gKwt6/TCgoaOg1H3EKztiWQeloRMWNCwNjbse8Z0aBSa9S/tPlB9WkSMLHe9XCUepAS+dYt+W1llWaRD6/aCoHTomLmdbmf4/UYJ+4st7zW5d8jDWFogVGZpdwtUki4E21AdBY7BJFe/UbkKrg6oJuxvDPW1jPZQ8KddeE4wzIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793199; c=relaxed/simple;
	bh=O/FNmeqI2jisIOHW6rdtZBvyOH704y1aD1Y09MDyd6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyp9DRxckCVgw+KMc5CVjVSt6YhgJq655ttk1lH/RqJglQNwE2xhiT6ht36/1rXu67amrTGyTEj9xt8DOb4vxP9DXxwLZWETttuCKNgc1YEQ8ZvC9KudMsZtpeoMe4+PbwYgg19LRcyuDGsvfwsY4ALbZkJvNjJaQlLJStw8mBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DKKQxncj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d5e0e365so269063a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738793196; x=1739397996; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdk/HaKNaahf0t/S5M7mcWC1tBmnYjS8E64jc5RnDK0=;
        b=DKKQxncjYKN16d0par9InjCbrccpBth1nZIYAVgWL2yMTuA3QZj6PyldaFWPeQnPI2
         vq3qf7iRZo8St6RSqXhUI/X2FLxdizXecMUrQYYEVZJXyYGmnGZz9LmxulrgkDiFwzxC
         HtjzTfePbTIFms7wJesnXFDpAr2QBWBu+W2YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793196; x=1739397996;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdk/HaKNaahf0t/S5M7mcWC1tBmnYjS8E64jc5RnDK0=;
        b=nuKJ00SWtoJhrYYS5VfpoUtYV1Fo1N4d0O0G2Z5/E21zZJNEinxOCBB8p9JNhFJFT0
         0g0+GvE4xRmWXJyHUb2N7zs58EItFC81+dosYwdXN1Z6p6lAm38FSeXrsnloQMnGi6Ni
         NhbXddj+FZUvYjZ0Nt7miZ0VUEjNlkcuBkrNSqa0p78VO7nGPizGZgl9GE5aJZ+dLh18
         O4sy0QAeQtC9kMB7snsbIak2iHIP/WQUmKevxGBTNamfOSbcxvdGpImBDJoXI0lVmvlv
         NvHqYm6P//njPnkCFobzPO+wC+vJOywVJv4a3TXmN15TSIflKflNXxHhd54LRw+Qienc
         VdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Vh0HeCgvhIqLqg7uFaGme9W7EzX651auWAHRzYN6I5a3mi8vHN/osvq8oyxKt/LPJmNiAIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywEAYA/C90cK9RySlfSUDRvfRQkKuh/t2zpsPjjVoUYeERzPOF
	+dx01zEUTeuWIIFu7SUopsO20vbqs0FygfZq8Q380t5Jio/TZifCzM68iHwNalg=
X-Gm-Gg: ASbGncvvG2a8VtTfV6vZPrqefhK6pD2sR+p5rFNHSLwfVVy11BNqIsg9JYeYhep/6NP
	PfppiDXqkyeMXsr9ntxS1R4v+bpYxL7/xoUXcQaH+KPVNkqrdI8PSxYZ0zUCvv/2o4Zz/VzL+1p
	iA1QS/zdaNc6LV+newtpAs7cWC1XHfDjy+fv9ICP7aNzqryeCqwEof0dExNlAtpzshsfewn7ZsJ
	z+YOYliTDJCvtXiJaTfJ89rjrMPHipBTCgpn91ayn8Qs8x9sDV7tivt34nSarINsPxTH67vNf7E
	4lUgXLX9o3YL/oulx8jDbWdCI35epMgde7kvuji6QO53coSfQPdYjdpeEQ==
X-Google-Smtp-Source: AGHT+IHulBtud1ctbkoE3F/lY+v/drNsIZDFljDjipknPtvcW8F4J0lYmUwq/rAaQhugJiHXvUwjaw==
X-Received: by 2002:a17:90b:1e43:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-2f9e0784f39mr6939379a91.20.1738793196014;
        Wed, 05 Feb 2025 14:06:36 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0392e416sm85475a91.48.2025.02.05.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 14:06:35 -0800 (PST)
Date: Wed, 5 Feb 2025 14:06:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
Message-ID: <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org
References: <20250205001052.2590140-1-skhawaja@google.com>
 <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>

On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> On Tue, Feb 4, 2025 at 5:32 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> >
> > On 2025-02-04 19:10, Samiullah Khawaja wrote:
> > > Extend the already existing support of threaded napi poll to do continuous
> > > busy polling.
> >
> > [snip]
> >
> > > Setup:
> > >
> > > - Running on Google C3 VMs with idpf driver with following configurations.
> > > - IRQ affinity and coalascing is common for both experiments.
> > > - There is only 1 RX/TX queue configured.
> > > - First experiment enables busy poll using sysctl for both epoll and
> > >    socket APIs.
> > > - Second experiment enables NAPI threaded busy poll for the full device
> > >    using sysctl.
> > >
> > > Non threaded NAPI busy poll enabled using sysctl.
> > > ```
> > > echo 400 | sudo tee /proc/sys/net/core/busy_poll
> > > echo 400 | sudo tee /proc/sys/net/core/busy_read
> > > echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> > > echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > > ```
> > >
> > > Results using following command,
> > > ```
> > > sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
> > >               --profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
> > >               -p 50,90,99,999 -H <IP> -l 10
> > >
> > > ...
> > > ...
> > >
> > > num_transactions=2835
> > > latency_min=0.000018976
> > > latency_max=0.049642100
> > > latency_mean=0.003243618
> > > latency_stddev=0.010636847
> > > latency_p50=0.000025270
> > > latency_p90=0.005406710
> > > latency_p99=0.049807350
> > > latency_p99.9=0.049807350
> > > ```
> > >
> > > Results with napi threaded busy poll using following command,
> > > ```
> > > sudo EF_NO_FAIL=0 EF_POLL_USEC=100000 taskset -c 3-10 onload -v \
> > >                  --profile=latency ./neper/tcp_rr -Q 200 -R 400 -T 1 -F 50 \
> > >                  -p 50,90,99,999 -H <IP> -l 10
> > >
> > > ...
> > > ...
> > >
> > > num_transactions=460163
> > > latency_min=0.000015707
> > > latency_max=0.200182942
> > > latency_mean=0.000019453
> > > latency_stddev=0.000720727
> > > latency_p50=0.000016950
> > > latency_p90=0.000017270
> > > latency_p99=0.000018710
> > > latency_p99.9=0.000020150
> > > ```
> > >
> > > Here with NAPI threaded busy poll in a separate core, we are able to
> > > consistently poll the NAPI to keep latency to absolute minimum. And also
> > > we are able to do this without any major changes to the onload stack and
> > > threading model.
> >
> > As far as I'm concerned, this is still not sufficient information to
> > fully assess the experiment. The experiment shows an 162-fold decrease
> > in latency and a corresponding increase in throughput for this
> > closed-loop workload (which, btw, is different from your open-loop fixed
> > rate use case). This would be an extraordinary improvement and that
> > alone warrants some scrutiny. 162X means either the base case has a lot
> > of idle time or wastes an enormous amount of cpu cycles. How can that be
> > explained? It would be good to get some instruction/cycle counts to
> > drill down further.
> The difference is much more apparent (and larger) when I am using more
> sockets (50) in this case. I have noticed that the situation gets
> worse if I add much more sockets in the mix, but I think this here is
> enough to show the effect.

Can you be more precise? What does "the situation" refer to? Are you
saying that the latency decrease is larger than 162x as the number
of sockets increases? 

It would be helpful to include that data in the cover letter showing
the latency differences amongst various socket counts.

> The processing of packets on a core and
> then going back to userspace to do application work (or protocol
> processing in case of onload) is not ok for this use case.

Why is it not OK? I assume because there is too much latency? If
so... the data for that configuration should be provided so it can
be examined and compared.

> If you look at P50, most of the time there is not much difference,
> but the tail latencies add up in the P90 case. I want the
> descriptors to be pulled from the NIC queues and handed over right
> away for processing to a separate core.

Sure; it's a trade off between CPU cycles and latency, right? I
think that data should be provided so that it is more clear what the
actual trade-off is; how many cycles am I trading for the latency
reduction at p90+ ?

> >
> > The server process invocation and the actual irq routing is not
> > provided. Just stating its common for both experiments is not
> > sufficient. Without further information, I still cannot rule out that:
> >
> > - In the base case, application and napi processing execute on the same
> > core and trample on each other. I don't know how onload implements
> > epoll_wait, but I worry that it cannot align application processing
> > (busy-looping?) and napi processing (also busy-looping?).
> >
> > - In the threaded busy-loop case, napi processing ends up on one core,
> > while the application executes on another one. This uses two cores
> > instead of one.
> >
> > Based on the above, I think at least the following additional scenarios
> > need to be investigated:
> >
> > a) Run the server application in proper fullbusy mode, i.e., cleanly
> > alternating between application processing and napi processing. As a
> > second step, spread the incoming traffic across two cores to compare
> > apples to apples.
> This is exactly what is being done in the experiment I posted and it
> shows massive degradation of latency when the core is shared between
> application processing and napi processing.

It's not clear from the cover letter that this is what the base case
is testing. I am not doubting that you are testing this; I'm
commenting that the cover letter does not clearly explain this
because I also didn't follow that.

> The busy_read setup above that I mentioned, makes onload do napi
> processing when xsk_recvmsg is called. Also onload spins in the
> userspace to handle the AF_XDP queues/rings in memory.

This detail would be useful to explain in the cover letter; it was
not clear to me why busy_read would be used, as you'll see in my
response.

If onload spins in userspace, wouldn't a test case of running
userspace on one core so it can spin and doing NAPI processing on
another core be a good test case to include in the data?

> >
> > b) Run application and napi processing on separate cores, but simply by
> > way of thread pinning and interrupt routing. How close does that get to
> > the current results? Then selectively add threaded napi and then busy
> > polling.
> This was the base case with which we started looking into this work.
> And this gives much worse latency because the packets are only picked
> from the RX queue on interrupt wakeups (and BH). In fact moving them
> to separate cores in this case makes the core getting interrupts be
> idle and go to sleep if the frequency of packets is low.

Two comments here:

1. If it was the base case which motivated the work, should an
explanation of this and data about it be provided so it can be
examined?

2. If PPS is low, wouldn't you _want_ the core to go idle?

> >
> > c) Run the whole thing without onload for comparison. The benefits
> > should show without onload as well and it's easier to reproduce. Also, I
> > suspect onload hurts in the base case and that explains the atrociously
> > high latency and low throughput of it.
> >
> > Or, even better, simply provide a complete specification / script for
> > the experiment that makes it easy to reproduce.
> That would require setting up onload on the platform you use, provided
> it has all the AF_XDP things needed to bring it up. I think I have
> provided everything that you would need to set this up on your
> platform. I have provided the onload repo, it is open source and it
> has README with steps to set it up. I have provided the sysctls
> configuration I am using. I have also provided the exact command with
> all the arguments I am using to run onload with neper (configuration
> and environment including cpu affinity setup).

Respectfully, I disagree.

I think the cover letter lacks a significant amount of detail, test
data, and test setup information which makes reproducing the results
a lot more work for a reviewer.

> >
> > Note that I don't dismiss the approach out of hand. I just think it's
> > important to properly understand the purported performance improvements.
> I think the performance improvements are apparent with the data I
> provided, I purposefully used more sockets to show the real
> differences in tail latency with this revision.

Respectfully, I don't agree that the improvements are "apparent." I
think my comments and Martin's comments both suggest that the cover
letter does not make the improvements apparent.

> Also one thing that you are probably missing here is that the change
> here also has an API aspect, that is it allows a user to drive napi
> independent of the user API or protocol being used.

I'm not missing that part; I'll let Martin speak for himself but I
suspect he also follows that part.

If some one were missing that part, though, it'd probably suggest a
more thorough approach to documenting the change in the cover
letter, right?

> I mean I can certainly drive the napi using recvmsg, but the napi
> will only be driven if there is no data in the recv queue. The
> recvmsg will check the recv_queue and if it is not empty it will
> return. This forces the application to drain the socket and then
> do napi processing, basically introducing the same effect of
> alternating between napi processing and application processing.
> The use case to drive the napi in a separate core (or a couple of
> threads sharing a single core) is handled cleanly with this change
> by enabling it through netlink.

Why not provide the numbers for this and many other test cases (as
mentioned above) so that this can be evaluated more clearly?

> > At the same time, I don't think it's good for the planet to burn cores
> > with busy-looping without good reason.

I think the point Martin makes here is subtle, but extremely
important.

Introducing a general purpose mechanism to burn cores at 100% CPU,
potentially doing nothing if network traffic is very low, should not
be taken lightly and, IMHO, very rigorous data should be provided so
that anyone who decides to turn this on knows what trade-off is.

As it stands presently, it's not clear to me how many CPU cycles I
am trading to get the claim of a 162X latency improvement at the
tail (which, like Martin, is a claim I find quite odd and worth
investigating in and of itself as to _why_ it is so large).

