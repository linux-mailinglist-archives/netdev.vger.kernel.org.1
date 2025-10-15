Return-Path: <netdev+bounces-229469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5FFBDCB14
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACADD19A65A0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 06:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2630FF02;
	Wed, 15 Oct 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZAwUJ3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219030F555
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509242; cv=none; b=hNwzWXlSV1jOs+jUlZvd2Pwlylny5J5QmxLjcZL/SsSOhIr5ZdT47QqurkJxFfxQExFgM+Gdhy7WUtOz5wiyBmB6cix72Ygl3gb33pQrEzdbM3KgvlEBuQ7R9Cpbo6IqQVJKgdjsyye+AJRrkkCmUCKea/CUCyDyC9DKcZqPEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509242; c=relaxed/simple;
	bh=1lKaQqUZjUzDbHS8PmbxS7OqmbyDLWnmkwvvT60TcTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyhsYHIivLQis39ZCubhlJJWoeznfDLLoxZt7GH+55ipcKXVbEKNX4DLmIvz3EGUJCsiQja+PwqSDJxqCuleeZKQ78KlfRe5UmqpW/g1YvMeCl7HvRYIQaNKJoHqzq7RaOlsbkhZ/NeuayAg2sE/yLfavBAfkELHVXd/Gg/zt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZAwUJ3S; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5403629a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760509233; x=1761114033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzrwS8ryiuJVtyzXXWbsrpdz1CnybRNV797vv2uBqVE=;
        b=LZAwUJ3Scms6/E1DMQ9eOfabAyTcQYMQnVpS2o5tQeosnpBXorUVQSN59VKV8n4Qao
         ipjm0RmJB77Hde1b7UQvlNjAjTcNoWt2E9N0DnbiU9n+A64pF/OWgBKUMdMenj5yHr2B
         zQalx0AJ5xRWw1NpfA6dCn1q4kcVpZH+h3oFODObH1bbRamiwECAkIep66yc8nTmzOVr
         56WfD23Mo4MQhPz+0y8b5zK19wTAiYOM03XHwcf36v521PwB0DK4VkXMwiOdsRu/mXUg
         cM0LSUFXCjKZ9M1H641zFwmQCYxrVFZJnIL+V2FFQU/H9HtRqO5PzBAMCAvl4NcWXXEm
         B25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760509233; x=1761114033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzrwS8ryiuJVtyzXXWbsrpdz1CnybRNV797vv2uBqVE=;
        b=gQ411md/0W1kCE3Y9pqgCm8/h7ueY6IUpRiTppd9Brbinku8djwNq9fJc73VOdqGt/
         4F3D3S/4259yTDog3KZyZ8nrWtxyfW2erNFTRH2zQQ4HPS6zIJfYZZKACPE6M58WcBif
         rh+jQwwva4kcVD/fku0gzOFuIBjI/JidJtHmM/6K+Q1yHgOvFNq5NBjK/7kcHLY649Xa
         84V+L1XM4fb7nrqYVT65eXU1FHP4I+vFPpxCQ/331TvZbmxGe/JDFl9oJwPSXBbCXPAu
         XktIZjdTSd64n34QtJlcPbUanXTdocwnkTcu5ibtl1M1qVNa95k6UId10LnWxDfpitMu
         QGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8sMjVrGI6HCaKmpc0o4vn2Q1WWuvJ6lLo8H4znO+QJcehnt5SuEcyi33WWqpkZDA5xdsvXh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDV3u7tST/YE7o1PvldZz9MrHkHG2vajSmIrU2seU8i3MeZT3J
	A+ra3uD9ubmGj3njLMrpQGCFu0QB5EpksuWCniIu4ZWI84Tial8YJInwnP/9WpoGw17Bnl/fTVr
	sf7sM9UtxeXXlMUHZpYZYMxx5j40+6/vM/O7VqkUa
X-Gm-Gg: ASbGncsGWxYPWqdwQX0BS4BY4JdpCOq/E/muCGISiDI88JEYSwbaxQKcdE38yfuplUa
	o3JLbYb+DS673yy6csAIGQDky7MIjUUD1XrAR9iktykgb2CWJTIWGrPbCUKTbaRoz4GsbF1tTyo
	15MZnuPwU4vMFu92S0sUwjf4bfcQpl4KSXS9Cfkr/ecMyVRX7EXncz+PRxcD3r8z3xTMYbyoaeY
	NHh27a00GYL9qlEhJqF98tSzX7XfE0SqhPfj9gPcd2x2c10hJScR91CLTjogJamX/KbpDW/gAg=
X-Google-Smtp-Source: AGHT+IE0lMOaO8VGl+LKQcQ9BRVeGylaxQ//a7TH5TqyAFWnw7YaAFVUrwb3Y8pkSrwaOeXlLTWXoTvoHb6rDFdIg7c=
X-Received: by 2002:a17:903:2c05:b0:24e:95bb:88b1 with SMTP id
 d9443c01a7336-290273ede89mr364080145ad.34.1760509233124; Tue, 14 Oct 2025
 23:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-7-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 23:20:21 -0700
X-Gm-Features: AS18NWAbg9zWj1ag8Egld2lX2wgF4s8p3jXSIcta1Tex-iKfLH4aAhN1IqfJnEw
Message-ID: <CAAVpQUCp3W6J29LV0xkvYBvUV-Uys_RVt843D2TU6jqiF5f3zg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 6/6] net: dev_queue_xmit() llist adoption
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Remove busylock spinlock and use a lockless list (llist)
> to reduce spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this patch, we get a 300 % improvement on heavy TX workloads.
> - Sending twice the number of packets per second.
> - While consuming 50 % less cycles.
>
> Note that this also allows in the future to submit batches
> to various qdisc->enqueue() methods.
>
> Tested:
>
> - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contenti=
on in mm)
> - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>
> Before:
>
> 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
>
> vmstat 2 5
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
> 243  0      0 2368988672  51036 1100852    0    0   146     1  242   60  =
0  9 91  0  0
> 244  0      0 2368988672  51036 1100852    0    0   536    10 487745 1471=
8  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   512     0 503067 4603=
3  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   512     0 494807 1210=
7  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   702    26 492845 1011=
0  0 52 48  0  0
>
> Lock contention (1 second sample taken on 8 cores)
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>     442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_hard=
_start_xmit+0xcd
>       5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev_qu=
eue_xmit+0x3a0
>        244    560.63 us      7.63 us      2.30 us     spinlock   do_softi=
rq+0x5b
>         13     25.09 us      3.21 us      1.93 us     spinlock   net_tx_a=
ction+0xf8
>
> If netperf threads are pinned, spinlock stress is very high.
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>     964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_hard=
_start_xmit+0xcd
>        201    268.05 us      4.65 us      1.33 us     spinlock   __dev_qu=
eue_xmit+0x3a0
>         12     26.05 us      3.84 us      2.17 us     spinlock   do_softi=
rq+0x5b
>
> @__dev_queue_xmit_ns:
> [256, 512)            21 |                                               =
     |
> [512, 1K)            631 |                                               =
     |
> [1K, 2K)           27328 |@                                              =
     |
> [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                               =
     |
> [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                     =
     |
> [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ =
     |
> [32K, 64K)         19055 |@                                              =
     |
> [64K, 128K)        17240 |@                                              =
     |
> [128K, 256K)       25633 |@                                              =
     |
> [256K, 512K)           4 |                                               =
     |
>
> After:
>
> 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
>
> vmstat 2 5
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
> 78  0      0 2369573632  32896 1350988    0    0    22     0  331  254  0=
  8 92  0  0
> 75  0      0 2369573632  32896 1350988    0    0    22    50 425713 28019=
9  0 23 76  0  0
> 104  0      0 2369573632  32896 1350988    0    0   290     0 430238 2982=
47  0 23 76  0  0
> 86  0      0 2369573632  32896 1350988    0    0   132     0 428019 29186=
5  0 24 76  0  0
> 90  0      0 2369573632  32896 1350988    0    0   502     0 422498 27867=
2  0 23 76  0  0
>
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>       2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev_qu=
eue_xmit+0x55b
>       5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_hard=
_start_xmit+0xcd
>       2377      9.73 ms     35.86 us      4.09 us     spinlock   ___slab_=
alloc+0x4e0
>        923      5.74 ms     20.91 us      6.22 us     spinlock   ___slab_=
alloc+0x5c9
>        121      3.42 ms    193.05 us     28.24 us     spinlock   net_tx_a=
ction+0xf8
>          6    564.33 us    167.60 us     94.05 us     spinlock   do_softi=
rq+0x5b
>
> If netperf threads are pinned (~54 Mpps)
> perf lock record -C0-7 sleep 1; perf lock contention
>      32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_hard=
_start_xmit+0xcd
>       4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev_qu=
eue_xmit+0x554
>       2781     23.53 ms     40.03 us      8.46 us     spinlock   ___slab_=
alloc+0x5c9
>       3554     18.94 ms     34.69 us      5.33 us     spinlock   ___slab_=
alloc+0x4e0
>        233      9.09 ms    215.70 us     38.99 us     spinlock   do_softi=
rq+0x5b
>        153    930.66 us     48.67 us      6.08 us     spinlock   net_tx_a=
ction+0xfd
>         84    331.10 us     14.22 us      3.94 us     spinlock   ___slab_=
alloc+0x5c9
>        140    323.71 us      9.94 us      2.31 us     spinlock   ___slab_=
alloc+0x4e0
>
> @__dev_queue_xmit_ns:
> [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             =
     |
> [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [512, 1K)         483936 |@@@@@@@@@@                                     =
     |
> [1K, 2K)          265345 |@@@@@@                                         =
     |
> [2K, 4K)          145463 |@@@                                            =
     |
> [4K, 8K)           54571 |@                                              =
     |
> [8K, 16K)          10270 |                                               =
     |
> [16K, 32K)          9385 |                                               =
     |
> [32K, 64K)          7749 |                                               =
     |
> [64K, 128K)        26799 |                                               =
     |
> [128K, 256K)        2665 |                                               =
     |
> [256K, 512K)         665 |                                               =
     |
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Thanks for big improvement!

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

