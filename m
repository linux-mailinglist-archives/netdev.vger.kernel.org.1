Return-Path: <netdev+bounces-163692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A25A2B5D5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A6A18896FD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648E23909E;
	Thu,  6 Feb 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMxNAfht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2222653F
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882168; cv=none; b=BXOu6Ugu/SjtMd5/9M9Tr0kY8Rzz5o4t/BK96PE2Wx7wQ9QDYds5urfJuCm78MTYY32gQrcAyFLfLQSP5lcfTZK6OuSt9Tw+40vxwHR7pZfcByTw2Jl+NeOeoMovR5rhYPIi317i4sT2P/ZJRiUYFUL7mLPbtDnfW/nTXRJbIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882168; c=relaxed/simple;
	bh=KYBZhRL0uVgs5nNcR4HB8mjLUwFw3nDRGkTgm5SfFaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=C5CgAuwa35q5pOcu8gmohM2iWQkVx6CjZR8tBIKdrzSN9+G3Jisix1hVh0/3oQESBYRaULNHpt+Q9UkzsFZoi5hpyF45jr+7Uelh4pOzEcg6qGQGURgRQTTzBjUxkQJhJzjWxYU1hkTsik5gITqalYBpnGbWbO2YLhrBwZrl8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMxNAfht; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4368a290e0dso8675e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 14:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738882161; x=1739486961; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv/X+lznuh2nRVVC3uW1RUEIBgFoAkcDNO5UJEPoPNo=;
        b=GMxNAfhtZSSczCJjRbUri4tDygIsjQIZAwnVdYUEZChsEaZY69e1JI+GxG3pyMDqty
         aChSO+s571Y2wjJTBoFjyfPm9fTQ+68oH0gC15eVKP5LpOLcZc2tIrw7dEYXkq09j4Iz
         X89scZKcUaKC3xv/vvsV9xX7GidJjzS0b39gTfwD9kFmOHiCkDyu1FSZT0zmLVubbPSt
         fx1ClXAOrbn/XF2dzV0+mufEC/ZJTYX3d1T7dEwFqFQboC+LNrNEYqumT62LnVQTAz1H
         wUjaE0iOCcTVINchUzJ9D5uMoqpnVGD5+yeqkkrQBVH3LAPnH1yTVT1DsuWhg8g1D7Vf
         jitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738882161; x=1739486961;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv/X+lznuh2nRVVC3uW1RUEIBgFoAkcDNO5UJEPoPNo=;
        b=HlB6bqCabTpT60v18O7Qkv6k6j0nAFdCYxGivSL4GjaSL3LrlCmamVWqMV70cGW4Pp
         zT2voHQeCg0SWwew6KfCNIHg5iKa8Cy0B78BLpLncZNhnT3nXCoYq+4FYziIEJUt+hdy
         bBdInac474JEftTs1nXMxWBwDeZPgZ65ugMuZ3Bl4QkSKQ8abkZ6p672dGqNY1bPZrat
         kHcc/RBT519ZG/ySMTUpeNjMOQHPIj7yt1TzTKhRmWisg8ByGdozyGEZFjZf9NN9YDZZ
         LeiVE/kAKKvfy4zfNUXE15Nu7zLI8sVymNfzNCD/ZULHhgbECAcMcR3U4jeccawZ4ZA/
         8ETQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2ubxAI4bnts3TOtakk1+bI2LJ+gvmRTvjVERON0kQeMnLtJiaY5vQJTM5oXFQ739P+YUsBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/rQ/Nc94A4LH5aYBIo42FvIrrThTAfaieb9iiIdD+SjT8vNX
	wZiNItpKntX/3+i/6Gc4na9ngh+Cfe+tVDWUk4pLWYO7QTmxcRCs/u4XGzdxBG+HkdtiXA3NzIv
	Q26IfMy/VCnGTNENwar2In8DL2TWssz+ggZ6X
X-Gm-Gg: ASbGncuYsl4fULkjm/XntJCnGieHRTkpzuVuInqadXxmmc78R40MjJyeI8XY6EdnA3e
	uAhWaWOLF01zVLxfzVxt8Z8yi5JGrYTMcEtLGgyKbAiCKTmONb086adysI+/nMlZejdq0dLCg2U
	q40CngnoNYBfeefFO/26SPzlquGkTHWA==
X-Google-Smtp-Source: AGHT+IF3nMM+J2uVrOypFKhanXfGc21DFJdvsfBzaOi+xk5fQyd7zBxGzSTi2KZNuCESOL7/Q0gV/ct4NhWRC59dkUo=
X-Received: by 2002:a05:600c:6c59:b0:436:ed00:9e3 with SMTP id
 5b1f17b1804b1-439252abd19mr347875e9.6.1738882160437; Thu, 06 Feb 2025
 14:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com> <772affea-8d44-43ab-81e6-febaf0548da1@uwaterloo.ca>
 <CAAywjhQM4BLXX55Kh0XQ_NqYv8sJVWBfPfSZMb7724_3DrsjjA@mail.gmail.com>
 <Z6Pg6Ye5ZbzMlBeP@LQ3V64L9R2> <CAAywjhTYF3YXM0hKbSwnrV02dXXTO6Eeq=iX0UFRO9p0FGSFVQ@mail.gmail.com>
 <Z6S8Q0ZLfjxrzh7m@LQ3V64L9R2>
In-Reply-To: <Z6S8Q0ZLfjxrzh7m@LQ3V64L9R2>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 6 Feb 2025 14:49:08 -0800
X-Gm-Features: AWEUYZlobN_MF1E4DVfcBH8lBccijUuZA9EUl9Mwq-Csay1S-VvHdVAwGu3xNCw
Message-ID: <CAAywjhR3BCJx6DuH2NTgm_66ZkBXYTyKoMBx5k-J-UkCsh6_iQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Joe Damato <jdamato@fastly.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 5:42=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Wed, Feb 05, 2025 at 04:45:59PM -0800, Samiullah Khawaja wrote:
> > On Wed, Feb 5, 2025 at 2:06=E2=80=AFPM Joe Damato <jdamato@fastly.com> =
wrote:
> > >
> > > On Wed, Feb 05, 2025 at 12:35:00PM -0800, Samiullah Khawaja wrote:
> > > > On Tue, Feb 4, 2025 at 5:32=E2=80=AFPM Martin Karsten <mkarsten@uwa=
terloo.ca> wrote:
> > > > >
> > > > > On 2025-02-04 19:10, Samiullah Khawaja wrote:
> > > > > > Extend the already existing support of threaded napi poll to do=
 continuous
> > > > > > busy polling.
> > > > >
> > > > > [snip]
> > > > >
> > > > > > Setup:
> > > > > >
> > > > > > - Running on Google C3 VMs with idpf driver with following conf=
igurations.
> > > > > > - IRQ affinity and coalascing is common for both experiments.
> > > > > > - There is only 1 RX/TX queue configured.
> > > > > > - First experiment enables busy poll using sysctl for both epol=
l and
> > > > > >    socket APIs.
> > > > > > - Second experiment enables NAPI threaded busy poll for the ful=
l device
> > > > > >    using sysctl.
> > > > > >
> > > > > > Non threaded NAPI busy poll enabled using sysctl.
> > > > > > ```
> > > > > > echo 400 | sudo tee /proc/sys/net/core/busy_poll
> > > > > > echo 400 | sudo tee /proc/sys/net/core/busy_read
> > > > > > echo 2 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> > > > > > echo 15000  | sudo tee /sys/class/net/eth0/gro_flush_timeout
> > > > > > ```
> > > > > >
> > > > > > Results using following command,
> > > > > > ```
> > > > > > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onloa=
d -v \
> > > > > >               --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 400 =
-T 1 -F 50 \
> > > > > >               -p 50,90,99,999 -H <IP> -l 10
> > > > > >
> > > > > > ...
> > > > > > ...
> > > > > >
> > > > > > num_transactions=3D2835
> > > > > > latency_min=3D0.000018976
> > > > > > latency_max=3D0.049642100
> > > > > > latency_mean=3D0.003243618
> > > > > > latency_stddev=3D0.010636847
> > > > > > latency_p50=3D0.000025270
> > > > > > latency_p90=3D0.005406710
> > > > > > latency_p99=3D0.049807350
> > > > > > latency_p99.9=3D0.049807350
> > > > > > ```
> > > > > >
> > > > > > Results with napi threaded busy poll using following command,
> > > > > > ```
> > > > > > sudo EF_NO_FAIL=3D0 EF_POLL_USEC=3D100000 taskset -c 3-10 onloa=
d -v \
> > > > > >                  --profile=3Dlatency ./neper/tcp_rr -Q 200 -R 4=
00 -T 1 -F 50 \
> > > > > >                  -p 50,90,99,999 -H <IP> -l 10
> > > > > >
> > > > > > ...
> > > > > > ...
> > > > > >
> > > > > > num_transactions=3D460163
> > > > > > latency_min=3D0.000015707
> > > > > > latency_max=3D0.200182942
> > > > > > latency_mean=3D0.000019453
> > > > > > latency_stddev=3D0.000720727
> > > > > > latency_p50=3D0.000016950
> > > > > > latency_p90=3D0.000017270
> > > > > > latency_p99=3D0.000018710
> > > > > > latency_p99.9=3D0.000020150
> > > > > > ```
> > > > > >
> > > > > > Here with NAPI threaded busy poll in a separate core, we are ab=
le to
> > > > > > consistently poll the NAPI to keep latency to absolute minimum.=
 And also
> > > > > > we are able to do this without any major changes to the onload =
stack and
> > > > > > threading model.
> > > > >
> > > > > As far as I'm concerned, this is still not sufficient information=
 to
> > > > > fully assess the experiment. The experiment shows an 162-fold dec=
rease
> > > > > in latency and a corresponding increase in throughput for this
> > > > > closed-loop workload (which, btw, is different from your open-loo=
p fixed
> > > > > rate use case). This would be an extraordinary improvement and th=
at
> > > > > alone warrants some scrutiny. 162X means either the base case has=
 a lot
> > > > > of idle time or wastes an enormous amount of cpu cycles. How can =
that be
> > > > > explained? It would be good to get some instruction/cycle counts =
to
> > > > > drill down further.
> > > > The difference is much more apparent (and larger) when I am using m=
ore
> > > > sockets (50) in this case. I have noticed that the situation gets
> > > > worse if I add much more sockets in the mix, but I think this here =
is
> > > > enough to show the effect.
> > >
> > > Can you be more precise? What does "the situation" refer to? Are you
> > > saying that the latency decrease is larger than 162x as the number
> > > of sockets increases?
> > Yes the latency with higher percentiles would degrade since with more
> > sockets there will be longer queues with more work and more time spent
> > in doing application processing.
>
> Why not capture that in the cover letter and show that, for all test
> cases? It seems like it would be pretty useful to see and
> understand.
>
> > >
> > > It would be helpful to include that data in the cover letter showing
> > > the latency differences amongst various socket counts.
> > I just fetched some new data without the napi threaded busy poll and
> > pasted below, notice the change in P90. But I think the result is
> > pretty intuitive (wrt to extra queueing with more traffic and more
> > things to do in application processing) and also apparent with 1
> > socket data I posted earlier.
> >
> > 20 Socket data:
> > num_transactions=3D2345
> > latency_min=3D0.000018449
> > latency_max=3D0.049824327
> > latency_mean=3D0.003838511
> > latency_stddev=3D0.012978531
> > latency_p50=3D0.000024950
> > latency_p90=3D0.000122870
> > latency_p99=3D0.049807350
> > latency_p99.9=3D0.049807350
> >
> > 30 Socket data:
> > num_transactions=3D2098
> > latency_min=3D0.000018519
> > latency_max=3D0.049794902
> > latency_mean=3D0.004295050
> > latency_stddev=3D0.013671535
> > latency_p50=3D0.000025270
> > latency_p90=3D0.000174070
> > latency_p99=3D0.049807350
> > latency_p99.9=3D0.049807350
>
> Why not generate this data for the non-busy poll case and provide it
> as well so that it cane be compared side-by-side with the busy poll
> case?
>
> > > > The processing of packets on a core and
> > > > then going back to userspace to do application work (or protocol
> > > > processing in case of onload) is not ok for this use case.
> > >
> > > Why is it not OK? I assume because there is too much latency? If
> > > so... the data for that configuration should be provided so it can
> > > be examined and compared.
> > The time taken to do the application processing of the packets on the
> > same core would take time away from the napi processing, introducing
> > latency difference at tail with packets getting queued. Now for some
> > use cases this would be acceptable, they can certainly set affinity of
> > this napi thread equal to the userspace thread or maybe use
> > epoll/recvmsg to drive it. For my use case, I want it to have a solid
> > P90+ in sub 16us. A couple of microseconds spent doing application
> > processing pushes it to 17-18us and that is unacceptable for my use
> > case.
>
> Right, so the issue is that sharing a core induces latency which you
> want to avoid.
>
> It seems like this data should be provided to highlight the concern?
The 2 data points I provided are exactly that, Basically I am
comparing 2 mechanisms of enabling busy polling with one (socket/epoll
based) sharing a core (or doing work in sequence because of API
design) and the other that drives napi in a separate thread (in my
case also a separate core) independent of application. Different
message sizes, number of sockets, hops between clients/server etc that
would magnify the problem are all orthogonal issues that are
irrelevant to this comparison I am trying to do here. Some of the
points that you raised are certainly important, like the small value
of interrupts being deferred and that maybe causes some interference
with the socket/epoll based busypolling approach. But beyond that, I
think the variety of experiments and results you are asking for might
be interesting but are irrelevant to the scope of what I am proposing
here,
- The first experiment runs busypolling using busy_read, that is by
design a mechanism that shares cpu core (or time as the userspace
would be waiting) between application processing and napi processing.
- The second experiment enables threaded napi busypoll and allows
doing it on a separate core (on a separate core in my case).
>
> > >
> > > > If you look at P50, most of the time there is not much difference,
> > > > but the tail latencies add up in the P90 case. I want the
> > > > descriptors to be pulled from the NIC queues and handed over right
> > > > away for processing to a separate core.
> > >
> > > Sure; it's a trade off between CPU cycles and latency, right? I
> > > think that data should be provided so that it is more clear what the
> > > actual trade-off is; how many cycles am I trading for the latency
> > > reduction at p90+ ?
> > I think the tradeoff depends on the use case requirements and the
> > amount of work done in application processing, please see my reply
> > above.
>
> I respectfully disagree; you can show the numbers you are getting
> for CPU consumption in exchange for the latency numbers you are
> seeing for each test case with varying numbers of sockets.
>
> This is what Martin and I did in our series and it makes the
> comparison for reviewers much easier, IMHO.
>
>
> > >
> > > > >
> > > > > The server process invocation and the actual irq routing is not
> > > > > provided. Just stating its common for both experiments is not
> > > > > sufficient. Without further information, I still cannot rule out =
that:
> > > > >
> > > > > - In the base case, application and napi processing execute on th=
e same
> > > > > core and trample on each other. I don't know how onload implement=
s
> > > > > epoll_wait, but I worry that it cannot align application processi=
ng
> > > > > (busy-looping?) and napi processing (also busy-looping?).
> > > > >
> > > > > - In the threaded busy-loop case, napi processing ends up on one =
core,
> > > > > while the application executes on another one. This uses two core=
s
> > > > > instead of one.
> > > > >
> > > > > Based on the above, I think at least the following additional sce=
narios
> > > > > need to be investigated:
> > > > >
> > > > > a) Run the server application in proper fullbusy mode, i.e., clea=
nly
> > > > > alternating between application processing and napi processing. A=
s a
> > > > > second step, spread the incoming traffic across two cores to comp=
are
> > > > > apples to apples.
> > > > This is exactly what is being done in the experiment I posted and i=
t
> > > > shows massive degradation of latency when the core is shared betwee=
n
> > > > application processing and napi processing.
> > >
> > > It's not clear from the cover letter that this is what the base case
> > > is testing. I am not doubting that you are testing this; I'm
> > > commenting that the cover letter does not clearly explain this
> > > because I also didn't follow that.
> > >
> > > > The busy_read setup above that I mentioned, makes onload do napi
> > > > processing when xsk_recvmsg is called. Also onload spins in the
> > > > userspace to handle the AF_XDP queues/rings in memory.
> > >
> > > This detail would be useful to explain in the cover letter; it was
> > > not clear to me why busy_read would be used, as you'll see in my
> > > response.
> > >
> > > If onload spins in userspace, wouldn't a test case of running
> > > userspace on one core so it can spin and doing NAPI processing on
> > > another core be a good test case to include in the data?
> > That is what kthread based napi busy polling does. And this gives me
> > the best numbers. I run the napi processing in a separate core and
> > onload spinning in userspace on a separate thread. Now this ties into
> > my comment about the API aspect of this change. Doing napi processing
> > on a separate core with this change is super flexible regardless of
> > the UAPI you use.
>
> None of this was clear to me in the cover letter.
>
> > > > >
> > > > > b) Run application and napi processing on separate cores, but sim=
ply by
> > > > > way of thread pinning and interrupt routing. How close does that =
get to
> > > > > the current results? Then selectively add threaded napi and then =
busy
> > > > > polling.
> > > > This was the base case with which we started looking into this work=
.
> > > > And this gives much worse latency because the packets are only pick=
ed
> > > > from the RX queue on interrupt wakeups (and BH). In fact moving the=
m
> > > > to separate cores in this case makes the core getting interrupts be
> > > > idle and go to sleep if the frequency of packets is low.
> > >
> > > Two comments here:
> > >
> > > 1. If it was the base case which motivated the work, should an
> > > explanation of this and data about it be provided so it can be
> > > examined?
> > >
> > > 2. If PPS is low, wouldn't you _want_ the core to go idle?
> > Not really, if the core goes idle then the latency of a packet that
> > arrives after core goes idle will suffer due to wakeups.
>
> Again: can you quantify what that "suffering" is numerically?
>
> > This is what happens with interrupts also, but it could be
> > acceptable for a different use case. I am guessing/maybe with
> > large message sizes, one would not care since after the wakeup for
> > first descriptor remaining packets can be processed in a batch.
>
> To me that suggests the test cases should be expanded to include:
>   - More thorough and clear descriptions of each experimental case
>     being tested
>   - Different message sizes
>   - Different socket counts
>   - CPU / cycle consumption information
>
> Then it would be much easier for a reviewer to determine the impact
> of this change.
>
> I think what Martin and I are calling for is a more rigorous
> approach to gathering, comparing, and analyzing the data.
>
> See the below responses from the my previous email.
>
> > >
> > > > >
> > > > > c) Run the whole thing without onload for comparison. The benefit=
s
> > > > > should show without onload as well and it's easier to reproduce. =
Also, I
> > > > > suspect onload hurts in the base case and that explains the atroc=
iously
> > > > > high latency and low throughput of it.
> > > > >
> > > > > Or, even better, simply provide a complete specification / script=
 for
> > > > > the experiment that makes it easy to reproduce.
> > > > That would require setting up onload on the platform you use, provi=
ded
> > > > it has all the AF_XDP things needed to bring it up. I think I have
> > > > provided everything that you would need to set this up on your
> > > > platform. I have provided the onload repo, it is open source and it
> > > > has README with steps to set it up. I have provided the sysctls
> > > > configuration I am using. I have also provided the exact command wi=
th
> > > > all the arguments I am using to run onload with neper (configuratio=
n
> > > > and environment including cpu affinity setup).
> > >
> > > Respectfully, I disagree.
> > >
> > > I think the cover letter lacks a significant amount of detail, test
> > > data, and test setup information which makes reproducing the results
> > > a lot more work for a reviewer.
> > >
> > > > >
> > > > > Note that I don't dismiss the approach out of hand. I just think =
it's
> > > > > important to properly understand the purported performance improv=
ements.
> > > > I think the performance improvements are apparent with the data I
> > > > provided, I purposefully used more sockets to show the real
> > > > differences in tail latency with this revision.
> > >
> > > Respectfully, I don't agree that the improvements are "apparent." I
> > > think my comments and Martin's comments both suggest that the cover
> > > letter does not make the improvements apparent.
> > >
> > > > Also one thing that you are probably missing here is that the chang=
e
> > > > here also has an API aspect, that is it allows a user to drive napi
> > > > independent of the user API or protocol being used.
> > >
> > > I'm not missing that part; I'll let Martin speak for himself but I
> > > suspect he also follows that part.
> > >
> > > If some one were missing that part, though, it'd probably suggest a
> > > more thorough approach to documenting the change in the cover
> > > letter, right?
> > >
> > > > I mean I can certainly drive the napi using recvmsg, but the napi
> > > > will only be driven if there is no data in the recv queue. The
> > > > recvmsg will check the recv_queue and if it is not empty it will
> > > > return. This forces the application to drain the socket and then
> > > > do napi processing, basically introducing the same effect of
> > > > alternating between napi processing and application processing.
> > > > The use case to drive the napi in a separate core (or a couple of
> > > > threads sharing a single core) is handled cleanly with this change
> > > > by enabling it through netlink.
> > >
> > > Why not provide the numbers for this and many other test cases (as
> > > mentioned above) so that this can be evaluated more clearly?
> > >
> > > > > At the same time, I don't think it's good for the planet to burn =
cores
> > > > > with busy-looping without good reason.
> > >
> > > I think the point Martin makes here is subtle, but extremely
> > > important.
> > >
> > > Introducing a general purpose mechanism to burn cores at 100% CPU,
> > > potentially doing nothing if network traffic is very low, should not
> > > be taken lightly and, IMHO, very rigorous data should be provided so
> > > that anyone who decides to turn this on knows what trade-off is.
> > >
> > > As it stands presently, it's not clear to me how many CPU cycles I
> > > am trading to get the claim of a 162X latency improvement at the
> > > tail (which, like Martin, is a claim I find quite odd and worth
> > > investigating in and of itself as to _why_ it is so large).

