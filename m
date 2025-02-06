Return-Path: <netdev+bounces-163303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC814A29E06
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4A91660B7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261418052;
	Thu,  6 Feb 2025 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFYYizi3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CFC2C6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 00:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802775; cv=none; b=J/P251CFDLD3o++cj1ZKj98maMgENM1FrT34H6ewqxmg4iOqLXeVk2BR7CKKB/WvPBPyoPqGo1fcuVUjKa3A73dEKMzUggewP9nQDrPzXgnWrTHcKhJA9GtkS9sxPbEcg2aA/4j6kU7qEvaoWBVR9BzHqSgpiAOKpV9HsnrNoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802775; c=relaxed/simple;
	bh=ia+xF/YI9CS7NI/ZTVgfP3MX+JWKdElsExwnF+Hut5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jQCxWAmIRSKZIFKwAdpCQA3HNjSoEA60PIsw5RYAO3E0j1a4bAAYijFvJdIYHKF5EuBV22bUSI/FPiCOjpFx05uorRXcdv0hCvGY9gMXIPu83NJ4YNu8XYuv6IPzmPAG8HxvY/LPnqQm48g7sXziX31C1kRo3djYQ9De+11GZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFYYizi3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso4955e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 16:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738802771; x=1739407571; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDTU9bzR8WidOBG3iuV+DPoLoifQdwmglx/QJC5NzTY=;
        b=mFYYizi3lzDbpPiFhRzFzfWrxgrqnDolrlaihzsfnO8BuqChKpH8RLHrchnS1pXDWk
         4FgWJIEhf1d9k1XMwp4zSzMqIdoFZuqhq3AKzpUcJiuIoLhGvbmTYmR1VGI3ucP9577Y
         iRSXsQxhr+046As7F4SJ9n4otqIw8HEGuWNTI9iMWQUjKiBO6NmtvYRw4mG35V0fgHuR
         n+5s7fpoxi89d4DOa6ewktQBZuHJ9RJERB/svwzBQRwwcWWPzSrvIhq6o89Icou3CD/g
         nO6kFrT4r+fXwKyhX9kdXTUTCEmycwE2okGccYR8kWz9PgPWMvft85+1CM3INB9KrJ5g
         V7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738802771; x=1739407571;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDTU9bzR8WidOBG3iuV+DPoLoifQdwmglx/QJC5NzTY=;
        b=pACHzr/HkGSiThnpczptzz+1fg1JYB6kETK9H9p7K1KRofO8pYzHL1gMKN7E8NZ5+2
         e/OO6VSTy+PJLDVrLeLkUXejqR5hYHdKkW65GVVAUPJ9BFQLUC8Cz+2rx0okNjYe7eeh
         dnM/uKS9MxBtvDmgeaXsQrIRNyrTmumtS6kXmJ4nAx797lIZW06PXfygWuJ4qF3NirOW
         xoZSq1kKeHfnRe+DEcZJIXTGL5XhRP8tI42LZtrXFi8DNMHRIXEVY4CjrmY+tNvxVz4k
         l1i8SyaifhfH7xOtG/GVOZZXIGfWmnbboRBtEaNjq7I9RXdjtvsR9ULlKq163pxr6Rg0
         bVNA==
X-Forwarded-Encrypted: i=1; AJvYcCW6OW74GEk4IuoqhACrZ4uqnfJpXsICu8YVsQITcwupVhm8Ohz080d1a5Xw9MQlwb5dI7eBmHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Y53fy16NmlMgKn/rJlQoubYM/qQUCLN2b0bI46CYi4/qQUXj
	q6mpVTGlKtoBwvBupblsBtvDO0dViKKS2+kLO2eD7Ao6605qSU4eSFX8obGeyxBqOJ9gUPUCfrt
	a9bbKpjS+0mTp2t490B7cLtp52/LdL00TKqxZ
X-Gm-Gg: ASbGncsOG/+3oBX8Csg667LtTHOdB2yTQqQNUpD6HvaPLNkFP4Jdp9UrjDItoYjm7KX
	bpF2hz8g5/r/CW+1Sf6k0ipgokNK6fFAGO7FuX5aG/JRJNdiYBMK3ynHA3hg98ZALaDwYdwgDOX
	JrqhENkaqxq9Y3hAiC2OlYz9wYZQlftA==
X-Google-Smtp-Source: AGHT+IFHCjHopxUmKmzfQOeEf7zO23FaT61GsLYwC9FBVMT9BhfwvYkCQoWSbBFi9aF2l8XP42asHmtdC6cfqfV+1Ro=
X-Received: by 2002:a05:600c:3ca5:b0:434:9e1d:44ef with SMTP id
 5b1f17b1804b1-4391a37fc8bmr175305e9.7.1738802770878; Wed, 05 Feb 2025
 16:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com> <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
In-Reply-To: <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 5 Feb 2025 16:45:59 -0800
X-Gm-Features: AWEUYZl9GSYiWkuhLu6oLCfXt8mRykQ_52976ahc0jdjJhCvE7RySZXZ3J2JC3A
Message-ID: <CAAywjhTYF3YXM0hKbSwnrV02dXXTO6Eeq=iX0UFRO9p0FGSFVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 2:06=E2=80=AFPM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> > On Tue, Feb 4, 2025 at 5:32=E2=80=AFPM Martin Karsten <mkarsten@uwaterl=
oo.ca> wrote:
> > >
> > > On 2025-02-04 19:10, Samiullah Khawaja wrote:
> > > > Extend the already existing support of threaded napi poll to do con=
tinuous
> > > > busy polling.
> > >
> > > [snip]
> > >
> > > > Setup:
> > > >
> > > > - Running on Google C3 VMs with idpf driver with following configur=
ations.
> > > > - IRQ affinity and coalascing is common for both experiments.
> > > > - There is only 1 RX/TX queue configured.
> > > > - First experiment enables busy poll using sysctl for both epoll an=
d
> > > >    socket APIs.
> > > > - Second experiment enables NAPI threaded busy poll for the full de=
vice
> > > >    using sysctl.
> > > >
> > > > Non threaded NAPI busy poll enabled using sysctl.
> > > > ```
> > > > echo 400 | sudo tee /proc/sys/net/core/busy_poll
> > > > echo 400 | sudo tee /proc/sys/net/core/busy_read
> > > > echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> > > > echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > > > ```
> > > >
> > > > Results using following command,
> > > > ```
> > > > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v=
 \
> > > >               --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -T 1=
 -F 50 \
> > > >               -p 50,90,99,999 -H <IP> -l 10
> > > >
> > > > ...
> > > > ...
> > > >
> > > > num_transactions=3D2835
> > > > latency_min=3D0.000018976
> > > > latency_max=3D0.049642100
> > > > latency_mean=3D0.003243618
> > > > latency_stddev=3D0.010636847
> > > > latency_p50=3D0.000025270
> > > > latency_p90=3D0.005406710
> > > > latency_p99=3D0.049807350
> > > > latency_p99.9=3D0.049807350
> > > > ```
> > > >
> > > > Results with napi threaded busy poll using following command,
> > > > ```
> > > > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onload -v=
 \
> > > >                  --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 -=
T 1 -F 50 \
> > > >                  -p 50,90,99,999 -H <IP> -l 10
> > > >
> > > > ...
> > > > ...
> > > >
> > > > num_transactions=3D460163
> > > > latency_min=3D0.000015707
> > > > latency_max=3D0.200182942
> > > > latency_mean=3D0.000019453
> > > > latency_stddev=3D0.000720727
> > > > latency_p50=3D0.000016950
> > > > latency_p90=3D0.000017270
> > > > latency_p99=3D0.000018710
> > > > latency_p99.9=3D0.000020150
> > > > ```
> > > >
> > > > Here with NAPI threaded busy poll in a separate core, we are able t=
o
> > > > consistently poll the NAPI to keep latency to absolute minimum. And=
 also
> > > > we are able to do this without any major changes to the onload stac=
k and
> > > > threading model.
> > >
> > > As far as I'm concerned, this is still not sufficient information to
> > > fully assess the experiment. The experiment shows an 162-fold decreas=
e
> > > in latency and a corresponding increase in throughput for this
> > > closed-loop workload (which, btw, is different from your open-loop fi=
xed
> > > rate use case). This would be an extraordinary improvement and that
> > > alone warrants some scrutiny. 162X means either the base case has a l=
ot
> > > of idle time or wastes an enormous amount of cpu cycles. How can that=
 be
> > > explained? It would be good to get some instruction/cycle counts to
> > > drill down further.
> > The difference is much more apparent (and larger) when I am using more
> > sockets (50) in this case. I have noticed that the situation gets
> > worse if I add much more sockets in the mix, but I think this here is
> > enough to show the effect.
>
> Can you be more precise? What does "the situation" refer to? Are you
> saying that the latency decrease is larger than 162x as the number
> of sockets increases?
Yes the latency with higher percentiles would degrade since with more
sockets there will be longer queues with more work and more time spent
in doing application processing.
>
> It would be helpful to include that data in the cover letter showing
> the latency differences amongst various socket counts.
I just fetched some new data without the napi threaded busy poll and
pasted below, notice the change in P90. But I think the result is
pretty intuitive (wrt to extra queueing with more traffic and more
things to do in application processing) and also apparent with 1
socket data I posted earlier.

20 Socket data:
num_transactions=3D2345
latency_min=3D0.000018449
latency_max=3D0.049824327
latency_mean=3D0.003838511
latency_stddev=3D0.012978531
latency_p50=3D0.000024950
latency_p90=3D0.000122870
latency_p99=3D0.049807350
latency_p99.9=3D0.049807350

30 Socket data:
num_transactions=3D2098
latency_min=3D0.000018519
latency_max=3D0.049794902
latency_mean=3D0.004295050
latency_stddev=3D0.013671535
latency_p50=3D0.000025270
latency_p90=3D0.000174070
latency_p99=3D0.049807350
latency_p99.9=3D0.049807350
>
> > The processing of packets on a core and
> > then going back to userspace to do application work (or protocol
> > processing in case of onload) is not ok for this use case.
>
> Why is it not OK? I assume because there is too much latency? If
> so... the data for that configuration should be provided so it can
> be examined and compared.
The time taken to do the application processing of the packets on the
same core would take time away from the napi processing, introducing
latency difference at tail with packets getting queued. Now for some
use cases this would be acceptable, they can certainly set affinity of
this napi thread equal to the userspace thread or maybe use
epoll/recvmsg to drive it. For my use case, I want it to have a solid
P90+ in sub 16us. A couple of microseconds spent doing application
processing pushes it to 17-18us and that is unacceptable for my use
case.
>
> > If you look at P50, most of the time there is not much difference,
> > but the tail latencies add up in the P90 case. I want the
> > descriptors to be pulled from the NIC queues and handed over right
> > away for processing to a separate core.
>
> Sure; it's a trade off between CPU cycles and latency, right? I
> think that data should be provided so that it is more clear what the
> actual trade-off is; how many cycles am I trading for the latency
> reduction at p90+ ?
I think the tradeoff depends on the use case requirements and the
amount of work done in application processing, please see my reply
above.
>
> > >
> > > The server process invocation and the actual irq routing is not
> > > provided. Just stating its common for both experiments is not
> > > sufficient. Without further information, I still cannot rule out that=
:
> > >
> > > - In the base case, application and napi processing execute on the sa=
me
> > > core and trample on each other. I don't know how onload implements
> > > epoll_wait, but I worry that it cannot align application processing
> > > (busy-looping?) and napi processing (also busy-looping?).
> > >
> > > - In the threaded busy-loop case, napi processing ends up on one core=
,
> > > while the application executes on another one. This uses two cores
> > > instead of one.
> > >
> > > Based on the above, I think at least the following additional scenari=
os
> > > need to be investigated:
> > >
> > > a) Run the server application in proper fullbusy mode, i.e., cleanly
> > > alternating between application processing and napi processing. As a
> > > second step, spread the incoming traffic across two cores to compare
> > > apples to apples.
> > This is exactly what is being done in the experiment I posted and it
> > shows massive degradation of latency when the core is shared between
> > application processing and napi processing.
>
> It's not clear from the cover letter that this is what the base case
> is testing. I am not doubting that you are testing this; I'm
> commenting that the cover letter does not clearly explain this
> because I also didn't follow that.
>
> > The busy_read setup above that I mentioned, makes onload do napi
> > processing when xsk_recvmsg is called. Also onload spins in the
> > userspace to handle the AF_XDP queues/rings in memory.
>
> This detail would be useful to explain in the cover letter; it was
> not clear to me why busy_read would be used, as you'll see in my
> response.
>
> If onload spins in userspace, wouldn't a test case of running
> userspace on one core so it can spin and doing NAPI processing on
> another core be a good test case to include in the data?
That is what kthread based napi busy polling does. And this gives me
the best numbers. I run the napi processing in a separate core and
onload spinning in userspace on a separate thread. Now this ties into
my comment about the API aspect of this change. Doing napi processing
on a separate core with this change is super flexible regardless of
the UAPI you use.
>
> > >
> > > b) Run application and napi processing on separate cores, but simply =
by
> > > way of thread pinning and interrupt routing. How close does that get =
to
> > > the current results? Then selectively add threaded napi and then busy
> > > polling.
> > This was the base case with which we started looking into this work.
> > And this gives much worse latency because the packets are only picked
> > from the RX queue on interrupt wakeups (and BH). In fact moving them
> > to separate cores in this case makes the core getting interrupts be
> > idle and go to sleep if the frequency of packets is low.
>
> Two comments here:
>
> 1. If it was the base case which motivated the work, should an
> explanation of this and data about it be provided so it can be
> examined?
>
> 2. If PPS is low, wouldn't you _want_ the core to go idle?
Not really, if the core goes idle then the latency of a packet that
arrives after core goes idle will suffer due to wakeups. This is what
happens with interrupts also, but it could be acceptable for a
different use case. I am guessing/maybe with large message sizes, one
would not care since after the wakeup for first descriptor remaining
packets can be processed in a batch.
>
> > >
> > > c) Run the whole thing without onload for comparison. The benefits
> > > should show without onload as well and it's easier to reproduce. Also=
, I
> > > suspect onload hurts in the base case and that explains the atrocious=
ly
> > > high latency and low throughput of it.
> > >
> > > Or, even better, simply provide a complete specification / script for
> > > the experiment that makes it easy to reproduce.
> > That would require setting up onload on the platform you use, provided
> > it has all the AF_XDP things needed to bring it up. I think I have
> > provided everything that you would need to set this up on your
> > platform. I have provided the onload repo, it is open source and it
> > has README with steps to set it up. I have provided the sysctls
> > configuration I am using. I have also provided the exact command with
> > all the arguments I am using to run onload with neper (configuration
> > and environment including cpu affinity setup).
>
> Respectfully, I disagree.
>
> I think the cover letter lacks a significant amount of detail, test
> data, and test setup information which makes reproducing the results
> a lot more work for a reviewer.
>
> > >
> > > Note that I don't dismiss the approach out of hand. I just think it's
> > > important to properly understand the purported performance improvemen=
ts.
> > I think the performance improvements are apparent with the data I
> > provided, I purposefully used more sockets to show the real
> > differences in tail latency with this revision.
>
> Respectfully, I don't agree that the improvements are "apparent." I
> think my comments and Martin's comments both suggest that the cover
> letter does not make the improvements apparent.
>
> > Also one thing that you are probably missing here is that the change
> > here also has an API aspect, that is it allows a user to drive napi
> > independent of the user API or protocol being used.
>
> I'm not missing that part; I'll let Martin speak for himself but I
> suspect he also follows that part.
>
> If some one were missing that part, though, it'd probably suggest a
> more thorough approach to documenting the change in the cover
> letter, right?
>
> > I mean I can certainly drive the napi using recvmsg, but the napi
> > will only be driven if there is no data in the recv queue. The
> > recvmsg will check the recv_queue and if it is not empty it will
> > return. This forces the application to drain the socket and then
> > do napi processing, basically introducing the same effect of
> > alternating between napi processing and application processing.
> > The use case to drive the napi in a separate core (or a couple of
> > threads sharing a single core) is handled cleanly with this change
> > by enabling it through netlink.
>
> Why not provide the numbers for this and many other test cases (as
> mentioned above) so that this can be evaluated more clearly?
>
> > > At the same time, I don't think it's good for the planet to burn core=
s
> > > with busy-looping without good reason.
>
> I think the point Martin makes here is subtle, but extremely
> important.
>
> Introducing a general purpose mechanism to burn cores at 100% CPU,
> potentially doing nothing if network traffic is very low, should not
> be taken lightly and, IMHO, very rigorous data should be provided so
> that anyone who decides to turn this on knows what trade-off is.
>
> As it stands presently, it's not clear to me how many CPU cycles I
> am trading to get the claim of a 162X latency improvement at the
> tail (which, like Martin, is a claim I find quite odd and worth
> investigating in and of itself as to _why_ it is so large).

