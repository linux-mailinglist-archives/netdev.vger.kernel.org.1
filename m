Return-Path: <netdev+bounces-237077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43EC446B4
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15CD0345E07
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C423EA98;
	Sun,  9 Nov 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z47eFo0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C921885A
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762719500; cv=none; b=eC9axmrVSrKVIClkxnPJlMuTJvCFfyuob+zDirSpTq04xX16nY9aCDue8KJi9aZ3regCcgxLKHWYC/8Ha7dRHTH0/T34FRDGhMvSsnCZv0HaQsmhwSFEfIZs7/BXiWmnUsJYo6+z+4SXA2HwyoCHvm6hWDPcCJ4xPcUIRV5T1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762719500; c=relaxed/simple;
	bh=gvdNpu85ytBqYJvhPtGQX9v0QopOZc18zkAUWi7YVhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/vFluy5npapmrkga5NXpmnihnOBX9HinHP9bSyYyMdASnR/y9fUzbJY/wTlZlngBrZE8jXbhEC5w4XvEt/DEnGodQd8UNQaJz11ae0iTZyFyuli4DW89k91NwOi/81O3sqexb8ciWpxaEulFNL9drFNY0UxgEu/oX20vD6y4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z47eFo0T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed811820faso12498561cf.1
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762719497; x=1763324297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REQavMkav3io51gXkKqCE+w7BgxHS341+4uThVnOUyM=;
        b=Z47eFo0Tr9bjmRX1bvX7HmExOAk6JDVbzBaDEwdykhA7id6PdD+qrEy1XxRij1LFFd
         yQ7seiU7czjGqGK/QpB72dmCFsoct7ymQ3id8Yx5TXZT+HkYkve2SHWiHpklyypSOdZ3
         3HZuqWKW1CwgPZ4amewu9TLvcLFQF+DCBgqXiTKYdxlsbcIIYZrEyU6/nCzUeCCt6uvp
         h+ndm1RDYfGt54kR7TCJU4OM92nxleVk97iN8G3aAJofjcjIPZv2gspczg8fwOPL1j+h
         AQMZxzLev7Uuliat+YWEyGoMMz8j7FOv0Y8BIdi3uq4BjlZtpo3SwaESa5b3TgdTywVK
         ac3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762719497; x=1763324297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=REQavMkav3io51gXkKqCE+w7BgxHS341+4uThVnOUyM=;
        b=hiX5ulfZhU1wPpahFEviz88oNYljy4A6PfF4P5iZgH2SWmQy0egxPwhXtbx/boUw7g
         xgVsnOZwQxlZQUEztSOBm8uDKXGyoTP7Z0IxDUugQzQ6kq0/rvHuyybJNBXMHyQYCXvI
         yQa3xEXCDzDYoxfcVyfV1cGVm7yi+wgtIrfKsd7XFrc+u/lLScE5XVkUNV+Ct16am97E
         dedMC4lH1uwtAIMIwod3pUYEwtkHUuM64oKSjraCb3lkdFJOl2XqVdRtoRfBf6ENIFTm
         xATcA8NqJE2+9mUYWkiqJrs8vmWk9SWZHSiCmJAxQgurVh+vyzgHykPgR7ALsWA0m9yL
         uCLA==
X-Forwarded-Encrypted: i=1; AJvYcCXhDTlI8pOyEsPDM0HUh9jlYmbvQIb8AxdACGhsIarnM3GhfVp7cxFP4ojkYOtpzKVE6hTGL8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2iL8UlQX6eu6uTVQIAklUFkNIWs+kmkaQ/+kILGiXjyupsAi
	vW0/lt2SDOfCgEd2Wt7sPrFPHVf2JpJIR4xcUO0AybLXhqv0p+qnsCf243v6NxqV1aQxznzjncf
	f/rUpg1Gm0Zpwh+imGyfL2bPtiCfaz7e+IxoraHhG
X-Gm-Gg: ASbGncuOwFcqylO3bVCBPjqkquQkUFR13yuw4nveVgz5PuUlREox3E01Er6HlmqAV4W
	OOfF6BUPnPvRjbjFRKZZ1GNhsl2F3ERv2keBsLvhAHp1U6ZVgQUC+QNeMIpb5jGvX0fggUFMMaU
	qXzEfXrRnA6N65ZlUZhR+nAptk32rY1FlmpLQyrMzOJUoUO98AL69GkxMckODW0GHj/vHqHvK1N
	/60uguMZc1hNqgnbF+dnumdVITPJUYvxV5vfIZ1nCMNd5w1PGdn8G+rsNIAm+nivx/Pm0PI
X-Google-Smtp-Source: AGHT+IGlAY/I4fj+P9cuQngjS9j2SatrqDUFUnmtOS8u7HM7fSu7isQG5Xhiuc2uPi4Wgkff9EBuMDz/jmLdwtJImoc=
X-Received: by 2002:a05:622a:2d5:b0:4eb:a53e:847f with SMTP id
 d75a77b69052e-4eda4ec66cbmr74783061cf.33.1762719497009; Sun, 09 Nov 2025
 12:18:17 -0800 (PST)
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
 <871pm7np2w.fsf@toke.dk> <ef601e55-16a0-4d3e-bd0d-536ed9dd29cd@tu-berlin.de> <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
In-Reply-To: <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 12:18:06 -0800
X-Gm-Features: AWmQ_bkegbORf9wsc8tVOeY7P5Ar8u8RigMnAnhJggQGxYNYcivVGq15hH7DmIo
Message-ID: <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
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

On Sun, Nov 9, 2025 at 11:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Nov 9, 2025 at 11:18=E2=80=AFAM Jonas K=C3=B6ppeler <j.koeppeler@=
tu-berlin.de> wrote:
> >
> > On 11/9/25 5:33 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > > Not sure why there's this difference between your setup or mine; some
> > > .config or hardware difference related to the use of atomics? Any oth=
er
> > > ideas?
> >
> > Hi Eric, hi Toke,
> >
> > I observed a similar behavior where CAKE's throughput collapses after t=
he patch.
> >
> > Test setup:
> > - 4 queues CAKE root qdisc
>
> Please send
>
> tc -s -d qd sh
>
>
> > - 64-byte packets at ~21 Mpps
> > - Intel Xeon Gold 6209U + 25GbE Intel XXV710 NIC
> > - DuT forwards incoming traffic back to traffic generator through cake
> >
> > Throughput over 10 seconds before/after patch:
> >
> > Before patch:
> > 0.475   mpps
> > 0.481   mpps
> > 0.477   mpps
> > 0.478   mpps
> > 0.478   mpps
> > 0.477   mpps
> > 0.479   mpps
> > 0.481   mpps
> > 0.481   mpps
> >
> > After patch:
> > 0.265  mpps
> > 0.035  mpps
> > 0.003  mpps
> > 0.002  mpps
> > 0.001  mpps
> > 0.002  mpps
> > 0.002  mpps
> > 0.002  mpps
> > 0.002  mpps
> >
> > ---
> >
> >
> >  From the qdisc I also see a large number of drops. Running:
> >
> >      perf record -a -e skb:kfree_skb
> >
> > shows `QDISC_OVERLIMIT` and `CAKE_FLOOD` as the drop reasons.
>
>
> Cake drops packets from dequeue() while the qdisc spinlock is held,
> unfortunately.
>
> So it is quite possible that feeding more packets to the qdisc than befor=
e
> enters a mode where dequeue() has to drop more packets and slow down
> the whole thing.
>
> Presumably cake enqueue() should 'drop' the packet when the queue is
> under high pressure,
> because enqueue() can drop the packet without holding the qdisc spinlock.
>
>
> >
> > `tc` statistics before/after the patch:
> >
> > Before patch:
> > - drops: 32
> > - packets: 4,786,109
> > - memory_used: 8,916,480
> > - requeues: 254
> >
> > After patch:
> > - drops: 13,601,075
> > - packets: 322,540
> > - memory_used: 15,504,576
> > - requeues: 273
> >
> > ---
> >
> > Call graph of `__dev_queue_xmit` after the patch (CPU time percentages)=
:
> >
> > 53.37%  __dev_queue_xmit
> >    21.02%  __qdisc_run
> >      13.79%  sch_direct_xmit
> >        12.01%  _raw_spin_lock
> >          11.30%  do_raw_spin_lock
> >            11.06%  __pv_queued_spin_lock_slowpath
> >      0.73%  _raw_spin_unlock
> >        0.58%  lock_release
> >      0.69%  dev_hard_start_xmit
> >      6.91%  cake_dequeue
> >        1.82%  sk_skb_reason_drop
> >          1.10%  skb_release_data
> >          0.65%  kfree_skbmem
> >            0.61%  kmem_cache_free
> >        1.64%  get_random_u32
> >        0.97%  ktime_get
> >          0.86%  seqcount_lockdep_reader_access.constprop.0
> >        0.91%  cake_dequeue_one
> >    16.49%  _raw_spin_lock
> >      15.71%  do_raw_spin_lock
> >        15.54%  __pv_queued_spin_lock_slowpath
> >    10.00%  dev_qdisc_enqueue
> >      9.94%  cake_enqueue
> >        4.90%  cake_hash
> >        2.85%  __skb_flow_dissect
> >          1.08%  lock_acquire
> >          0.65%  lock_release
> >        1.17%  __siphash_unaligned
> >        2.20%  ktime_get
> >          1.94%  seqcount_lockdep_reader_access.constprop.0
> >        0.69%  cake_get_flow_quantum / get_random_u16
> >    1.99%  netdev_core_pick_tx
> >      1.79%  i40e_lan_select_queue
> >      1.62%  netdev_pick_tx
> >        0.78%  lock_acquire
> >        0.52%  lock_release
> >      0.82%  lock_acquire
> >    0.76%  kfree_skb_list_reason
> >      0.52%  skb_release_data
> >    1.02%  lock_acquire
> >      0.63%  lock_release
> >
> > ---
> >
> > The `_raw_spin_lock` portion under `__qdisc_run -> sch_direct_xmit` is =
slightly higher after the patch compared to before (from 5.68% to 12.01%).
> > It feels like once sch_cake starts dropping packets it (due to overlimi=
t and cobalt-drops) the throughput collapses. Could it be that the overlimi=
t
> > is reached "faster" when there are more CPUs trying to enqueue packets,=
 thus reaching cake's queue limit due to the "batch" enqueue behavior,
> > which then leads to cake starting to drop packets?
> >
>
> Yes, probably.

I think the issue is really about TCQ_F_ONETXQUEUE :


Perhaps we should not accept q->limit packets in the ll_list, but a
much smaller limit.

