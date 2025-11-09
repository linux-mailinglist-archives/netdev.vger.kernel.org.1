Return-Path: <netdev+bounces-237076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D62C4462C
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 20:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D043AE510
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97D21D3F4;
	Sun,  9 Nov 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFJoptCo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D2DF59
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716527; cv=none; b=a8IVChvqGoFfrTuS+SAGP3cKqxaKBP9vFSu+U2mdpRZvsFshDNQOu/UAC2vCJGIlTde5MYWvDWoqOh5+Y3t3wdVAuhukX3UTdRcG5MDvo3ua0BUgGmmsCaRQ3+bfNiW+CmFjtLIXN5gQvMDIKLk6eU2mC9lcZcDBGbHnccYWVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716527; c=relaxed/simple;
	bh=G5ua0NczDZfTvAdhc0G8pUsG2Ce+AVWfPVQh5RcwX6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnIeQ2+5vyd3cIc6fXvlMPrndJ21Xp4o/QzkxHrn8fhraa+HcZXuNxgrHQpAvQZGk+HyHRHZM8rxqYCki0TkGNEW0NXU/uV/lBfBmUgW5x5KU/ZSL3avXMs1BxaqUi2gcFXpqtaGEM7u5I2pruDxZviVt/AnxfcjcCQf+ovMlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFJoptCo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4edade7d5baso10264261cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762716525; x=1763321325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXhfn7O+ipjeh8nL50XCAjdaQuO12W6MKQdymGJsxOE=;
        b=MFJoptCovas1eQGMEagC8w+l2z8dUsuCLRbSMxZ9N/HHjBWKF/YpKqcKkSCtwX2B4B
         ny4pMhi/i4Zh87ebkqBtQUpTyHX8ayRz6sN56mOSSwd/NNh5Db2lhhdMeWMGaG6Di/Sb
         RYRSz33NdVSXhGofuJYnWZQEVXLeeKrD7i4HeqFCSO69HDbkjgV+bRAmT59PSMPw7Ncq
         1Z7qYhIoKlo9/X+2SCNojq4dEh5oUXrdSeKb+Im0WkcnvdNFnpi80bPhgFFoTs4xkjRm
         c8ncWmIqS4pOXNkpXbcIMW7uQJaLwrVjMu5F2RCh5atVCxFXl8DcOgwcUkoGvmQr9Pir
         JN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716525; x=1763321325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mXhfn7O+ipjeh8nL50XCAjdaQuO12W6MKQdymGJsxOE=;
        b=NI9pk2snYPksNtp9P8uGG5T5kxgQLTrkoxxpoPueOdLPXYQ9bGkJharoIhIf1kivJf
         hR0XYdTcqKSCNdMUjdUTaUbhLtfoInfifLt7tpqLCqPviMVbmNJJhlbKGQZis+xugecn
         Yr8473hdKQqiOPbYaOTekIiuLtLvPwbGGgP0DSGj4zahoSfikGgHYlCB5XMlHcenHQBW
         tI5hq2z45KgLlWAeHF/dhPhaGxBcjSX8aiCAf8bXQHwQM542qffhOGmfs+AWKzHPmBfd
         9yzXrupAvtRECVnCuGZCGJ/VX/pRVbQDlZ5KsYkRSGZuT9J3FSoE1yn1e1Xf7GodfC3h
         gaEg==
X-Forwarded-Encrypted: i=1; AJvYcCXo8PRVA7FDwBpLNl3iCpPIwkYaldh3DBe3ThDhWzuJX4kbBlVVsOeFyj81Kqq9wew2eOliNMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxswfd3uqsktEqudCHdPKo4x0urcoP7lEjBHCcXW7YmXjiLMDmT
	2SfX4YekzX0fioObW1PI7YLoSQsa5Y+e1W4TFkPAiIoyZmx9199yPH064gGqQOPpyv3yDP4y0mI
	xY8683Wmif6YwQmNH4CS9cNtchxCHilSXFoc2YF0i
X-Gm-Gg: ASbGncvo8VnqntqcS5MjrUEToIO6FwigL7HR4IMZ9PWJWlZKuGyaYxp8f5ZOhRCRn9J
	UXPWd80KzI5uvMy3vSo1LXYW6HKbVzno6qeagyd+se8cEiuczPIpglxAc+HyXIjpZwVMkgRc3zO
	Dt8LhN6imMlltg2+dpVCW2ED2X4HdMW9BwKnQYmM4ltlx7C2AC3o89m/u0k8DGXP9fCtI/c2N7i
	hNJc0hGrpkS4VPWO+9QKG75DffuBRYOA+3+mwmia8p0GmZtV9EvGtwtXE92NzvUD+4qW3oi
X-Google-Smtp-Source: AGHT+IGbNemdM7Ad/AuvQbc6zRZQYR5c5yQ0DbO2jvahRqOLeO/svCPklQnHhjc5f1mC/n/CKTCNQDEFd0MGqKbVB3E=
X-Received: by 2002:a05:622a:1455:b0:4ed:b671:eae1 with SMTP id
 d75a77b69052e-4edb672ecd9mr29716641cf.30.1762716524541; Sun, 09 Nov 2025
 11:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com>
 <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
 <871pm7np2w.fsf@toke.dk> <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
In-Reply-To: <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 11:28:33 -0800
X-Gm-Features: AWmQ_bnSahQmKHTgxX27zB6TOjbmVqxoIFext3st7amAcsr4KMbTSlQ4P_hw4Rg
Message-ID: <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:18=E2=80=AFAM Jonas K=C3=B6ppeler <j.koeppeler@tu=
-berlin.de> wrote:
>
> On 11/9/25 5:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Not sure why there's this difference between your setup or mine; some
> > .config or hardware difference related to the use of atomics? Any other
> > ideas?
>
> Hi Eric, hi Toke,
>
> I observed a similar behavior where CAKE's throughput collapses after the=
 patch.
>
> Test setup:
> - 4 queues CAKE root qdisc

Please send

tc -s -d qd sh


> - 64-byte packets at ~21 Mpps
> - Intel Xeon Gold 6209U + 25GbE Intel XXV710 NIC
> - DuT forwards incoming traffic back to traffic generator through cake
>
> Throughput over 10 seconds before/after patch:
>
> Before patch:
> 0.475   mpps
> 0.481   mpps
> 0.477   mpps
> 0.478   mpps
> 0.478   mpps
> 0.477   mpps
> 0.479   mpps
> 0.481   mpps
> 0.481   mpps
>
> After patch:
> 0.265  mpps
> 0.035  mpps
> 0.003  mpps
> 0.002  mpps
> 0.001  mpps
> 0.002  mpps
> 0.002  mpps
> 0.002  mpps
> 0.002  mpps
>
> ---
>
>
>  From the qdisc I also see a large number of drops. Running:
>
>      perf record -a -e skb:kfree_skb
>
> shows `QDISC_OVERLIMIT` and `CAKE_FLOOD` as the drop reasons.


Cake drops packets from dequeue() while the qdisc spinlock is held,
unfortunately.

So it is quite possible that feeding more packets to the qdisc than before
enters a mode where dequeue() has to drop more packets and slow down
the whole thing.

Presumably cake enqueue() should 'drop' the packet when the queue is
under high pressure,
because enqueue() can drop the packet without holding the qdisc spinlock.


>
> `tc` statistics before/after the patch:
>
> Before patch:
> - drops: 32
> - packets: 4,786,109
> - memory_used: 8,916,480
> - requeues: 254
>
> After patch:
> - drops: 13,601,075
> - packets: 322,540
> - memory_used: 15,504,576
> - requeues: 273
>
> ---
>
> Call graph of `__dev_queue_xmit` after the patch (CPU time percentages):
>
> 53.37%  __dev_queue_xmit
>    21.02%  __qdisc_run
>      13.79%  sch_direct_xmit
>        12.01%  _raw_spin_lock
>          11.30%  do_raw_spin_lock
>            11.06%  __pv_queued_spin_lock_slowpath
>      0.73%  _raw_spin_unlock
>        0.58%  lock_release
>      0.69%  dev_hard_start_xmit
>      6.91%  cake_dequeue
>        1.82%  sk_skb_reason_drop
>          1.10%  skb_release_data
>          0.65%  kfree_skbmem
>            0.61%  kmem_cache_free
>        1.64%  get_random_u32
>        0.97%  ktime_get
>          0.86%  seqcount_lockdep_reader_access.constprop.0
>        0.91%  cake_dequeue_one
>    16.49%  _raw_spin_lock
>      15.71%  do_raw_spin_lock
>        15.54%  __pv_queued_spin_lock_slowpath
>    10.00%  dev_qdisc_enqueue
>      9.94%  cake_enqueue
>        4.90%  cake_hash
>        2.85%  __skb_flow_dissect
>          1.08%  lock_acquire
>          0.65%  lock_release
>        1.17%  __siphash_unaligned
>        2.20%  ktime_get
>          1.94%  seqcount_lockdep_reader_access.constprop.0
>        0.69%  cake_get_flow_quantum / get_random_u16
>    1.99%  netdev_core_pick_tx
>      1.79%  i40e_lan_select_queue
>      1.62%  netdev_pick_tx
>        0.78%  lock_acquire
>        0.52%  lock_release
>      0.82%  lock_acquire
>    0.76%  kfree_skb_list_reason
>      0.52%  skb_release_data
>    1.02%  lock_acquire
>      0.63%  lock_release
>
> ---
>
> The `_raw_spin_lock` portion under `__qdisc_run -> sch_direct_xmit` is sl=
ightly higher after the patch compared to before (from 5.68% to 12.01%).
> It feels like once sch_cake starts dropping packets it (due to overlimit =
and cobalt-drops) the throughput collapses. Could it be that the overlimit
> is reached "faster" when there are more CPUs trying to enqueue packets, t=
hus reaching cake's queue limit due to the "batch" enqueue behavior,
> which then leads to cake starting to drop packets?
>

Yes, probably.

