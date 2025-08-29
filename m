Return-Path: <netdev+bounces-218359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE07B3C299
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B428B566645
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B92338F55;
	Fri, 29 Aug 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoD+cWto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B320F08C
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492968; cv=none; b=evHOHsXA9wcteEvql9N/gflxuCgTwacQlm+eNbT+HJfk/fVv12924cT/uL1fa8LAys7d+ZH6gTa8BR4d5w+241ysjXdt2GIDbBFkUM5RXoLpKev9IXxfSfIA5ZcE2EMBfeslSkm2jcvT30Xwe4VQCDQLk+0CsYFEHe+WKTid8Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492968; c=relaxed/simple;
	bh=bQPsmOm3QBLsbFjIqS0TbG7lNE+artjJ9G8PwC9tBow=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xb1SIGGINYm7cFQPzxFffTnMkQ4Zsy7YX4Rgh9kA3OZChOdoNQMkR8DZkejOfgCmMyH7OvPjyl+lW1E2sFyG1MDpGHd8VDkw3StLn6F0WNCE5pOf5z41kETvx+C8Tseuc59sH0lHoAT1aWIj6LCBwrcdHLPRaHzs9wiEwoFxe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoD+cWto; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b2979628f9so25721501cf.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 11:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756492965; x=1757097765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1OGL35uiJeQK4+j1UvPO0VhBY1NZXvtwoEMsbSV3Q0=;
        b=UoD+cWtoRwk0vVqTB2VYDn5m+dhYKSsWWis1C+S/U+sUUvqX9C1g4y9p8wZXBI/Mdd
         WppUVpjisPU9kKXbp23xCKp14kRr5mMmQ/SjL1LSI9v+AcZZKZdS1PiEpmVtDKmrsVOY
         Cw2feNO37NGc25qk2kHhS2zzFz3nUnmx7aETZvwm9/+mS23IYqTIBMF5gQkOjLCCb5mi
         AvOw54skJJlVemqAC75q8nFtbHY7D3vDOcn3srOs86TdQ9XyYI11Wl3PtvggfzHA7aXJ
         K9n4iPeOM/2xTLY7LnOU2we2qSR5sKrojEt/SLyC9AIx+zdb1aX4VIPio4H71SqTivav
         ta4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492965; x=1757097765;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1OGL35uiJeQK4+j1UvPO0VhBY1NZXvtwoEMsbSV3Q0=;
        b=HtvBZwtnbCJqQVlqS9Nyl3It0vp6x0ayhWx5I2XXLGtCWeYnDRoyy+4HRZvPTnkNW9
         +VYsgM4pmFtm0dX0t98FAjUWr4Pxuh4Vrga3h4PxkWdp+mi20HMpfx4aeFNHz5PI2vgd
         2WIQICo3FjC514V2gqXOc3dEB0MNWSFJOSPsGHrxIYdbQJca6CZ4tjpAW3WHnEAgnxd8
         4LrU/4uBwCYDXsjDLdiSI07qiieDyEoLJEXKaAKvHeZnfiWcBpshCj1h3u6obwu14eQ3
         d/UeysJDcn98dIljNlk8u3XIQNeESRNfuhedA5v2uIjnFsafPkUAzMF7o1p+36KGNbO1
         fPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxGz8pNTZ8F43TPJVggJYVs6583QWAYCbBYRk/bOyqN65/Ki3XlKwyjBsydYnT1Rd8s0rNFEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS28h/QwdL1ADB6B0IKdo+HM3/v0KaDb7Hw1Jc+cqBhssV1Dmv
	ow0FJBMObZU3lCDVe+VtNWfGV9oPDNtgS2IvCds7ONFYys4OxW73i4et
X-Gm-Gg: ASbGncsy/orbJf94+3dcAqbBCSRvFRgCLlF3U45lg147EPwxlkjuEaIF+IEfvPfmIJJ
	4AafClKO6FhOYDeJms7+AJt2t1B3xi6shd7sbfiaxZZYSRjU3iAhzLpk02ci6wh4XyHVnN9uLR9
	PbWbT7yceKzLUC9Vi34JLPi4box0S3Bd3BRZOFK7PFJl6KswS/Cbe37a1kYMJLlgRfLSU7Rsrzp
	bnfnfjV4PMChED4VTFtPJf6sLwjautzvN4VYDutLV1JBMEaUNn0R+Spn/g+hm8LRMrp/Vq3e3o8
	XwujrI2veUJFNJ1kNHKc/C7RQ98XiwzUhZjvLvThWGCEs2MjIkIgQ/egBAha6K72nyYUdOpQYs5
	ze6xB1Ppjp2hsb7YmO9V4uvWVKPBw+fF/tFMmw5c95BAurWVVIXoSt74BWZDd7T/IQd9h4Kf/oe
	qduNd29rStnA6m
X-Google-Smtp-Source: AGHT+IGCokd5jEMojc8ot2TmvnBJ4j201lMil9VdMw0GLFhDIqJ8F2JhdpKek4TIXD0AhbbGjgtlYA==
X-Received: by 2002:a05:620a:469e:b0:7e1:4bec:9769 with SMTP id af79cd13be357-7ea10ffd167mr3057301885a.29.1756492964862;
        Fri, 29 Aug 2025 11:42:44 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7fc0d86d143sm229276585a.11.2025.08.29.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:42:44 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:42:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com, 
 Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.338f6ae18246c@gmail.com>
In-Reply-To: <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
References: <20250829011607.396650-1-skhawaja@google.com>
 <9cc83ec9-2c71-4269-86ec-8a7063af354f@uwaterloo.ca>
 <CAAywjhTx7v8fNiimqU7OiBv-8F23k2efXMTsRbXCi0iF3SDQKQ@mail.gmail.com>
 <d2d02181-9299-4554-b641-1a74386b211b@uwaterloo.ca>
Subject: Re: [PATCH net-next v8 0/2] Add support to do threaded napi busy poll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin Karsten wrote:
> On 2025-08-29 13:50, Samiullah Khawaja wrote:
> > On Thu, Aug 28, 2025 at 8:15=E2=80=AFPM Martin Karsten <mkarsten@uwat=
erloo.ca> wrote:
> >>
> >> On 2025-08-28 21:16, Samiullah Khawaja wrote:
> >>> Extend the already existing support of threaded napi poll to do con=
tinuous
> >>> busy polling.
> >>>
> >>> This is used for doing continuous polling of napi to fetch descript=
ors
> >>> from backing RX/TX queues for low latency applications. Allow enabl=
ing
> >>> of threaded busypoll using netlink so this can be enabled on a set =
of
> >>> dedicated napis for low latency applications.
> >>>
> >>> Once enabled user can fetch the PID of the kthread doing NAPI polli=
ng
> >>> and set affinity, priority and scheduler for it depending on the
> >>> low-latency requirements.
> >>>
> >>> Extend the netlink interface to allow enabling/disabling threaded
> >>> busypolling at individual napi level.
> >>>
> >>> We use this for our AF_XDP based hard low-latency usecase with usec=
s
> >>> level latency requirement. For our usecase we want low jitter and s=
table
> >>> latency at P99.
> >>>
> >>> Following is an analysis and comparison of available (and compatibl=
e)
> >>> busy poll interfaces for a low latency usecase with stable P99. Thi=
s can
> >>> be suitable for applications that want very low latency at the expe=
nse
> >>> of cpu usage and efficiency.
> >>>
> >>> Already existing APIs (SO_BUSYPOLL and epoll) allow busy polling a =
NAPI
> >>> backing a socket, but the missing piece is a mechanism to busy poll=
 a
> >>> NAPI instance in a dedicated thread while ignoring available events=
 or
> >>> packets, regardless of the userspace API. Most existing mechanisms =
are
> >>> designed to work in a pattern where you poll until new packets or e=
vents
> >>> are received, after which userspace is expected to handle them.
> >>>
> >>> As a result, one has to hack together a solution using a mechanism
> >>> intended to receive packets or events, not to simply NAPI poll. NAP=
I
> >>> threaded busy polling, on the other hand, provides this capability
> >>> natively, independent of any userspace API. This makes it really ea=
sy to
> >>> setup and manage.
> >>>
> >>> For analysis we use an AF_XDP based benchmarking tool `xsk_rr`. The=

> >>> description of the tool and how it tries to simulate the real workl=
oad
> >>> is following,
> >>>
> >>> - It sends UDP packets between 2 machines.
> >>> - The client machine sends packets at a fixed frequency. To maintai=
n the
> >>>     frequency of the packet being sent, we use open-loop sampling. =
That is
> >>>     the packets are sent in a separate thread.
> >>> - The server replies to the packet inline by reading the pkt from t=
he
> >>>     recv ring and replies using the tx ring.
> >>> - To simulate the application processing time, we use a configurabl=
e
> >>>     delay in usecs on the client side after a reply is received fro=
m the
> >>>     server.
> >>>
> >>> The xsk_rr tool is posted separately as an RFC for tools/testing/se=
lftest.
> >>>
> >>> We use this tool with following napi polling configurations,
> >>>
> >>> - Interrupts only
> >>> - SO_BUSYPOLL (inline in the same thread where the client receives =
the
> >>>     packet).
> >>> - SO_BUSYPOLL (separate thread and separate core)
> >>> - Threaded NAPI busypoll
> >>>
> >>> System is configured using following script in all 4 cases,
> >>>
> >>> ```
> >>> echo 0 | sudo tee /sys/class/net/eth0/threaded
> >>> echo 0 | sudo tee /proc/sys/kernel/timer_migration
> >>> echo off | sudo tee  /sys/devices/system/cpu/smt/control
> >>>
> >>> sudo ethtool -L eth0 rx 1 tx 1
> >>> sudo ethtool -G eth0 rx 1024
> >>>
> >>> echo 0 | sudo tee /proc/sys/net/core/rps_sock_flow_entries
> >>> echo 0 | sudo tee /sys/class/net/eth0/queues/rx-0/rps_cpus
> >>>
> >>>    # pin IRQs on CPU 2
> >>> IRQS=3D"$(gawk '/eth0-(TxRx-)?1/ {match($1, /([0-9]+)/, arr); \
> >>>                                print arr[0]}' < /proc/interrupts)"
> >>> for irq in "${IRQS}"; \
> >>>        do echo 2 | sudo tee /proc/irq/$irq/smp_affinity_list; done
> >>>
> >>> echo -1 | sudo tee /proc/sys/kernel/sched_rt_runtime_us
> >>>
> >>> for i in /sys/devices/virtual/workqueue/*/cpumask; \
> >>>                        do echo $i; echo 1,2,3,4,5,6 > $i; done
> >>>
> >>> if [[ -z "$1" ]]; then
> >>>     echo 400 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>> fi
> >>>
> >>> sudo ethtool -C eth0 adaptive-rx off adaptive-tx off rx-usecs 0 tx-=
usecs 0
> >>>
> >>> if [[ "$1" =3D=3D "enable_threaded" ]]; then
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_poll
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>>     echo 2 | sudo tee /sys/class/net/eth0/threaded
> >>>     NAPI_T=3D$(ps -ef | grep napi | grep -v grep | awk '{ print $2 =
}')
> >>>     sudo chrt -f  -p 50 $NAPI_T
> >>>
> >>>     # pin threaded poll thread to CPU 2
> >>>     sudo taskset -pc 2 $NAPI_T
> >>> fi
> >>>
> >>> if [[ "$1" =3D=3D "enable_interrupt" ]]; then
> >>>     echo 0 | sudo tee /proc/sys/net/core/busy_read
> >>>     echo 0 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> >>>     echo 15000 | sudo tee /sys/class/net/eth0/gro_flush_timeout
> >>> fi
> >>> ```
> >>
> >> The experiment script above does not work, because the sysfs paramet=
er
> >> does not exist anymore in this version.
> >>
> >>> To enable various configurations, script can be run as following,
> >>>
> >>> - Interrupt Only
> >>>     ```
> >>>     <script> enable_interrupt
> >>>     ```
> >>>
> >>> - SO_BUSYPOLL (no arguments to script)
> >>>     ```
> >>>     <script>
> >>>     ```
> >>>
> >>> - NAPI threaded busypoll
> >>>     ```
> >>>     <script> enable_threaded
> >>>     ```
> >>>
> >>> If using idpf, the script needs to be run again after launching the=

> >>> workload just to make sure that the configurations are not reverted=
. As
> >>> idpf reverts some configurations on software reset when AF_XDP prog=
ram
> >>> is attached.
> >>>
> >>> Once configured, the workload is run with various configurations us=
ing
> >>> following commands. Set period (1/frequency) and delay in usecs to
> >>> produce results for packet frequency and application processing del=
ay.
> >>>
> >>>    ## Interrupt Only and SO_BUSYPOLL (inline)
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 =
-h -v
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 =
\
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v
> >>> ```
> >>>
> >>>    ## SO_BUSYPOLL(done in separate core using recvfrom)
> >>>
> >>> Argument -t spawns a seprate thread and continuously calls recvfrom=
.
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 =
\
> >>>        -h -v -t
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 =
\
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -t
> >>> ```
> >>>
> >>>    ## NAPI Threaded Busy Poll
> >>>
> >>> Argument -n skips the recvfrom call as there is no recv kick needed=
.
> >>>
> >>> - Server
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -D <IP-dest> -S <IP-src> -M <MAC-dst> -m <MAC-src> -p 54321 =
\
> >>>        -h -v -n
> >>> ```
> >>>
> >>> - Client
> >>> ```
> >>> sudo chrt -f 50 taskset -c 3-5 ./xsk_rr -o 0 -B 400 -i eth0 -4 \
> >>>        -S <IP-src> -D <IP-dest> -m <MAC-src> -M <MAC-dst> -p 54321 =
\
> >>>        -P <Period-usecs> -d <Delay-usecs>  -T -l 1 -v -n
> >>> ```
> >>
> >> I believe there's a bug when disabling busy-polled napi threading af=
ter
> >> an experiment. My system hangs and needs a hard reset.
> >>
> >>> | Experiment | interrupts | SO_BUSYPOLL | SO_BUSYPOLL(separate) | N=
API threaded |
> >>> |---|---|---|---|---|
> >>> | 12 Kpkt/s + 0us delay | | | | |
> >>> |  | p5: 12700 | p5: 12900 | p5: 13300 | p5: 12800 |
> >>> |  | p50: 13100 | p50: 13600 | p50: 14100 | p50: 13000 |
> >>> |  | p95: 13200 | p95: 13800 | p95: 14400 | p95: 13000 |
> >>> |  | p99: 13200 | p99: 13800 | p99: 14400 | p99: 13000 |
> >>> | 32 Kpkt/s + 30us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13100 | p5: 12800 |
> >>> |  | p50: 21100 | p50: 17000 | p50: 13700 | p50: 13000 |
> >>> |  | p95: 21200 | p95: 17100 | p95: 14000 | p95: 13000 |
> >>> |  | p99: 21200 | p99: 17100 | p99: 14000 | p99: 13000 |
> >>> | 125 Kpkt/s + 6us delay | | | | |
> >>> |  | p5: 14600 | p5: 17100 | p5: 13300 | p5: 12900 |
> >>> |  | p50: 15400 | p50: 17400 | p50: 13800 | p50: 13100 |
> >>> |  | p95: 15600 | p95: 17600 | p95: 14000 | p95: 13100 |
> >>> |  | p99: 15600 | p99: 17600 | p99: 14000 | p99: 13100 |
> >>> | 12 Kpkt/s + 78us delay | | | | |
> >>> |  | p5: 14100 | p5: 16700 | p5: 13200 | p5: 12600 |
> >>> |  | p50: 14300 | p50: 17100 | p50: 13900 | p50: 12800 |
> >>> |  | p95: 14300 | p95: 17200 | p95: 14200 | p95: 12800 |
> >>> |  | p99: 14300 | p99: 17200 | p99: 14200 | p99: 12800 |
> >>> | 25 Kpkt/s + 38us delay | | | | |
> >>> |  | p5: 19900 | p5: 16600 | p5: 13000 | p5: 12700 |
> >>> |  | p50: 21000 | p50: 17100 | p50: 13800 | p50: 12900 |
> >>> |  | p95: 21100 | p95: 17100 | p95: 14100 | p95: 12900 |
> >>> |  | p99: 21100 | p99: 17100 | p99: 14100 | p99: 12900 |
> >>
> >> On my system, routing the irq to same core where xsk_rr runs results=
 in
> >> lower latency than routing the irq to a different core. To me that m=
akes
> >> sense in a low-rate latency-sensitive scenario where interrupts are =
not
> >> causing much trouble, but the resulting locality might be beneficial=
. I
> >> think you should test this as well.
> >>
> >> The experiments reported above (except for the first one) are
> >> cherry-picking parameter combinations that result in a near-100% loa=
d
> >> and ignore anything else. Near-100% load is a highly unlikely scenar=
io
> >> for a latency-sensitive workload.
> >>
> >> When combining the above two paragraphs, I believe other interesting=

> >> setups are missing from the experiments, such as comparing to two pa=
irs
> >> of xsk_rr under high load (as mentioned in my previous emails).
> > This is to support an existing real workload. We cannot easily modify=

> > its threading model. The two xsk_rr model would be a different
> > workload.
> =

> That's fine, but:
> =

> - In principle I don't think it's a good justification for a kernel =

> change that an application cannot be rewritten.

It's not as narrow as one application. It's a way to scale processing
using pipelining instead of sharding. Both are reasonable approaches.

Especially for XDP, doing this first stage in the kernel makes sense
to me, as it makes XDP closer to hardware descriptor queue based
polling architectures such as DPDK or Google's SPIN. The OS abstracts
away the hardware format and the format translation entirely.

> - I believe it is your responsibility to more comprehensively document =

> the impact of your proposed changes beyond your one particular workload=
.
>
> Also, I do believe there's a bug as mentioned before. I can't quite pin=
 =

> it down, but every time after running a "NAPI threaded" experiment, my =

> servers enters a funny state and eventually becomes largely unresponsiv=
e =

> without much useful output and needs a hard reset. For example:
> =

> 1) Run "NAPI threaded" experiment
> 2) Disabled "threaded" parameter in NAPI config
> 3) Run IRQ experiment -> xsk_rr hangs and apparently holds a lock, =

> because other services stop working successively.
> =

> Do you not have this problem?
> =

> Thanks,
> Martin
> =




