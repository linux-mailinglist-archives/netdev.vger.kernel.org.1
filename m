Return-Path: <netdev+bounces-177835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D2EA7200B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60251670C0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7B217F36;
	Wed, 26 Mar 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpOmmimI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE861A2541
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021286; cv=none; b=kuSBA42He9q7CSwagiQy/sEi9tJk8JsH7L05wupJFYQL38kHIOeSZ2BcRYRzcEQq38RqxZR77JMRgwBfQaPOJl7ri4JDDDOiFQ+ch3XKylzj3hgspQei4QoQrmCso0ChOb0sWfOnf7eJj2R/2NqdHQubznFvF4gS1DV6nEyXc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021286; c=relaxed/simple;
	bh=4jI7BPOWxCFJZt69ClErP/iLRGP1r6tfCjpgLD8azAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRIM1Hf9N1IfAqRtbyLQL5IzZucg1hbK2GdaW3viEgn0DBk4EMBlddLHGs8VpEP+Kpi8w52akRqBcpBHc4ykWdThpBzUmfqe81GB6D8//s55J22H7xpnhGAwk31a1y/wMrpIvPn82ILS7HvxafGnCCbVI5ry04ZNA31zU/xJV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpOmmimI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so62555ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743021283; x=1743626083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q9fdOzJIcQKZQnYODOVoJPDaxhtubiEVgPHEqA0OHQ=;
        b=rpOmmimIkvt3eVoFvgheIRQrF7Zycp1ZgccZRVSetp+UhbSAfxtqFZEwVzdMNMhlRD
         fCiTLAyMWZwmksMWHdOuiguNdIq02oWAVa+4c7SLdG2kXvB210ZVyKLzpbryAdZQ/tWh
         6dV10cGTnC9VRG5v92vlQgMQr0i0IfJAc/uo+n1m9yfMHAH+2GucxB5iYeTt7CAhgXx0
         Bc7ZUNvEnxLl/dwAw/Vxpq6Tah5tMjqE4qGxpVvH7vFd9yrMkpiW0YM9Vpas46k6F1B1
         Qm7F4jliFnl+PZPbYnN2NnsdmXuW9RlYocZfmwfRX91ue0qf2cg2r1I22F+14Kje2KxT
         TRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743021283; x=1743626083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q9fdOzJIcQKZQnYODOVoJPDaxhtubiEVgPHEqA0OHQ=;
        b=M4v8c67gJz1aVLXh6E7ZC44qGvs13i2zDsiv/9NPIcQ+HpHMwpPeaDSE8SX2JsH9uT
         pGAsXqTmaa33gi0cl6zLC6FuPZN3Jhc9QFBoeWRnuWCOXht4iHKV1+byN5k3643l7Lxm
         Xy68SyJxMBW/palYBEruCEDERuEGZklWiM80O7eWDzpbwnWssuSg8Q1+810aok7MvARw
         pegG30gJP8/bY4Y+dJ5ETY6bsx9vqeCkh1hOfn1KGtQj/VTUSf6VS7seaFhX/F0df28G
         ZJPF+mKUNAE9GudEmCZsegB2+qdMrufncgkagVCt3jSvAbthG1tC2emN9t/UIwFj1oLu
         qAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbBdcN+oNwWKul2kEa/4lRmCVQayLZ46g+/vcG/QZkGtO9U7dOTyVnWdxRbnn7upbptiF0AoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXh3/yNEzC3EZnLc57JU7UAcbmRRN2M9c1TzhGgxemYuH+RAB
	GZH3LDjWFmcnGZfv3nPrrbjql0i7TBbWPzuyi5SwGnYgjs/MCuZ8DJnqDFWQCUtCmSLM3CxPA3+
	qA0Ga9PtRqJ8t+QF777h2AEu4VLsRTP9kdL8r
X-Gm-Gg: ASbGnctLdrFRLO6I1/1cjB2XAlKbt0ePkNNELwo1L/C+vay3KIysQxq6NX/hI9OHD6+
	8w83tLS7daVfzKDn8X554b/JHn9U7grYGtUIX6gn59++qEQbDx82LJsOf4JIMNVfbbjPxVshS2r
	USf8miX1QisiMWLuXmFuSjIuLJYLVAGDdrBUG2kJyCZ6vXudxjEVeKHb7Bpg==
X-Google-Smtp-Source: AGHT+IG+X30YZBwojbi4Kt3B1IbwB55meKVtn2eks7YDYJiw3G7aafqU2Dv4SX6I+DXH+1kaeoJcbhBay6zPwvlySyM=
X-Received: by 2002:a17:902:b20f:b0:21f:465d:c588 with SMTP id
 d9443c01a7336-22806c48d0amr207615ad.14.1743021282246; Wed, 26 Mar 2025
 13:34:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com> <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
In-Reply-To: <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 26 Mar 2025 13:34:30 -0700
X-Gm-Features: AQ5f1JpHSc3-3gGWlspKYfIzKoq497l3mqVDlJf8eP3wzcPSMzEqm-AQo3OHndw
Message-ID: <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:47=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo=
.ca> wrote:
>
> On 2025-03-25 12:40, Samiullah Khawaja wrote:
> > On Sun, Mar 23, 2025 at 7:38=E2=80=AFPM Martin Karsten <mkarsten@uwater=
loo.ca> wrote:
> >>
> >> On 2025-03-20 22:15, Samiullah Khawaja wrote:
> >>> Extend the already existing support of threaded napi poll to do conti=
nuous
> >>> busy polling.
> >>>
> >>> This is used for doing continuous polling of napi to fetch descriptor=
s
> >>> from backing RX/TX queues for low latency applications. Allow enablin=
g
> >>> of threaded busypoll using netlink so this can be enabled on a set of
> >>> dedicated napis for low latency applications.
> >>>
> >>> Once enabled user can fetch the PID of the kthread doing NAPI polling
> >>> and set affinity, priority and scheduler for it depending on the
> >>> low-latency requirements.
> >>>
> >>> Currently threaded napi is only enabled at device level using sysfs. =
Add
> >>> support to enable/disable threaded mode for a napi individually. This
> >>> can be done using the netlink interface. Extend `napi-set` op in netl=
ink
> >>> spec that allows setting the `threaded` attribute of a napi.
> >>>
> >>> Extend the threaded attribute in napi struct to add an option to enab=
le
> >>> continuous busy polling. Extend the netlink and sysfs interface to al=
low
> >>> enabling/disabling threaded busypolling at device or individual napi
> >>> level.
> >>>
> >>> We use this for our AF_XDP based hard low-latency usecase with usecs
> >>> level latency requirement. For our usecase we want low jitter and sta=
ble
> >>> latency at P99.
> >>>
> >>> Following is an analysis and comparison of available (and compatible)
> >>> busy poll interfaces for a low latency usecase with stable P99. Pleas=
e
> >>> note that the throughput and cpu efficiency is a non-goal.
> >>>
> >>> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> >>> description of the tool and how it tries to simulate the real workloa=
d
> >>> is following,
> >>>
> >>> - It sends UDP packets between 2 machines.
> >>> - The client machine sends packets at a fixed frequency. To maintain =
the
> >>>     frequency of the packet being sent, we use open-loop sampling. Th=
at is
> >>>     the packets are sent in a separate thread.
> >>> - The server replies to the packet inline by reading the pkt from the
> >>>     recv ring and replies using the tx ring.
> >>> - To simulate the application processing time, we use a configurable
> >>>     delay in usecs on the client side after a reply is received from =
the
> >>>     server.
> >>>
> >>> The xdp_rr tool is posted separately as an RFC for tools/testing/self=
test.
> >>
> >> Thanks very much for sending the benchmark program and these specific
> >> experiments. I am able to build the tool and run the experiments in
> >> principle. While I don't have a complete picture yet, one observation
> >> seems already clear, so I want to report back on it.
> > Thanks for reproducing this Martin. Really appreciate you reviewing
> > this and your interest in this.
> >>
> >>> We use this tool with following napi polling configurations,
> >>>
> >>> - Interrupts only
> >>> - SO_BUSYPOLL (inline in the same thread where the client receives th=
e
> >>>     packet).
> >>> - SO_BUSYPOLL (separate thread and separate core)
> >>> - Threaded NAPI busypoll
> >>
> >> The configurations that you describe as SO_BUSYPOLL here are not using
> >> the best busy-polling configuration. The best busy-polling strictly
> >> alternates between application processing and network polling. No
> >> asynchronous processing due to hardware irq delivery or softirq
> >> processing should happen.
> >>
> >> A high-level check is making sure that no softirq processing is report=
ed
> >> for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1)=
.
> >> In addition, interrupts can be counted in /proc/stat or /proc/interrup=
ts.
> >>
> >> Unfortunately it is not always straightforward to enter this pattern. =
In
> >> this particular case, it seems that two pieces are missing:
> >>
> >> 1) Because the XPD socket is created with XDP_COPY, it is never marked
> >> with its corresponding napi_id. Without the socket being marked with a
> >> valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes
> >> napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs
> >> softirq loop controls packet delivery.
> > Nice catch. It seems a recent change broke the busy polling for AF_XDP
> > and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
> > broken and seems in my experiments I didn't pick that up. During my
> > experimentation I confirmed that all experiment modes are invoking the
> > busypoll and not going through softirqs. I confirmed this through perf
> > traces. I sent out a fix for XDP_COPY busy polling here in the link
> > below. I will resent this for the net since the original commit has
> > already landed in 6.13.
> > https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=3Doxa164_vT=
fk+3P43H60qwQ@mail.gmail.com/T/#t
> >>
> >> I found code at the end of xsk_bind in xsk.c that is conditional on xs=
->zc:
> >>
> >>          if (xs->zc && qid < dev->real_num_rx_queues) {
> >>                  struct netdev_rx_queue *rxq;
> >>
> >>                  rxq =3D __netif_get_rx_queue(dev, qid);
> >>                  if (rxq->napi)
> >>                          __sk_mark_napi_id_once(sk, rxq->napi->napi_id=
);
> >>          }
> >>
> >> I am not an expert on XDP sockets, so I don't know why that is or what
> >> would be an acceptable workaround/fix, but when I simply remove the
> >> check for xs->zc, the socket is being marked and napi_busy_loop is bei=
ng
> >> called. But maybe there's a better way to accomplish this.
> > +1
> >>
> >> 2) SO_PREFER_BUSY_POLL needs to be set on the XDP socket to make sure
> >> that busy polling stays in control after napi_busy_loop, regardless of
> >> how many packets were found. Without this setting, the gro_flush_timeo=
ut
> >> timer is not extended in busy_poll_stop.
> >>
> >> With these two changes, both SO_BUSYPOLL alternatives perform noticeab=
ly
> >> better in my experiments and come closer to Threaded NAPI busypoll, so=
 I
> >> was wondering if you could try that in your environment? While this
> >> might not change the big picture, I think it's important to fully
> >> understand and document the trade-offs.
> > I agree. In my experiments the SO_BUSYPOLL works properly, please see
> > the commit I mentioned above. But I will experiment with
> > SO_PREFER_BUSY_POLL to see whether it makes any significant change.
>
> I'd like to clarify: Your original experiments cannot have used
> busypoll, because it was broken for XDP_COPY. Did you rerun the
On my idpf test platform the AF_XDP support is broken with the latest
kernel, so I didn't have the original commit that broke AF_XDP
busypoll for zerocopy and copy mode. So in the experiments that I
shared XDP_COPY busy poll has been working. Please see the traces
below. Sorry for the confusion.
> experiments with the XDP_COPY fix but without SO_PREFER_BUSY_POLL and
I tried with SO_PREFER_BUSY_POLL as you suggested, I see results
matching the previous observation:

12Kpkts/sec with 78usecs delay:

INLINE:
p5: 16700
p50: 17100
p95: 17200
p99: 17200

> see the same latency numbers as before? Also, can you provide more
> details about the perf tracing that you used to see that busypoll is
> invoked, but softirq is not?
I used the following command to record the call graph and could see
the calls to napi_busy_loop going from xsk_rcvmsg. Confirmed with
SO_PREFER_BUSY_POLL also below,
```
perf record -o prefer.perf -a -e cycles -g sleep 10
perf report --stdio -i prefer.perf
```

```
 --1.35%--entry_SYSCALL_64
            |
             --1.31%--do_syscall_64
                       __x64_sys_recvfrom
                       __sys_recvfrom
                       sock_recvmsg
                       xsk_recvmsg
                       __xsk_recvmsg.constprop.0.isra.0
                       napi_busy_loop
                       __napi_busy_loop
```

I do see softirq getting triggered occasionally, when inline the
busy_poll thread is not able to pick up the packets. I used following
command to find number of samples for each in the trace,

```
perf report -g -n -i prefer.perf
```

Filtered the results to include only the interesting symbols
```
<
Children      Self       Samples  Command          Shared Object
          Symbol
+    1.48%     0.06%            46  xsk_rr           [idpf]
            [k] idpf_vport_splitq_napi_poll

+    1.28%     0.11%            86  xsk_rr           [kernel.kallsyms]
            [k] __napi_busy_loop

+    0.71%     0.02%            17  xsk_rr           [kernel.kallsyms]
            [k] net_rx_action

+    0.69%     0.01%             6  xsk_rr           [kernel.kallsyms]
            [k] __napi_poll
```

>
> Thanks,
> Martin
>

