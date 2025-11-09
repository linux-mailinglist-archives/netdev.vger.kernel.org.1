Return-Path: <netdev+bounces-237064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D404EC44388
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E98188507E
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008BB30505B;
	Sun,  9 Nov 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLgIsTkO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D522836C
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708478; cv=none; b=sHZr7NX7A4HO2rKUdD5sYCdUvIQHkg4jmtujQbSDufrTowW3BV6bdY4DoXJ0Bzv0Snp9VQ64SdrIwdjFS/Zyhv6NqnKGqQ7ctW/GsYaCkop+Ahn+a46HZQ8JLSAPFmUcvGNOpmzt/97jVEJ1eZZveCxqEgIC0u2D8UrpoOyjKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708478; c=relaxed/simple;
	bh=cXYDlnOcJbr6lMgzkL3U8kgDFspjsQCPUs4Jb6AT94k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhc3uyKRJkR4XVsxMB7zl3NUN3gdPqT1ESY/RteaMLhta/+mYsFd/ndeJ/gkFOYmJqEGikM9uYBi44GFqKXoR6W4dKOp0Z44Hkmids8uS0lUN/3Wi4hiIbf+c9wGv4iZteypI+bJmlfoFgGW746q2l9Yjj7vpYoP1Zx0eNoS4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLgIsTkO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4eda26a04bfso20047871cf.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762708476; x=1763313276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr1lUAnFZGlsHD54+AxELQ78EmMa3JgPHit5j+6Xino=;
        b=FLgIsTkOY38GOkvOAXric5PFXZ44EhhP/tMOdhNLmQUee+HvodBobVLbpf/vGFT2Ot
         ARrs3pN1C3+AbpwevsvdsRPj6jpV+wZf3Rm/7XYf2TO3tNRxaYs1k9nM0eRJD25a1mDO
         eMuXOoTs+u7s3Mww3nNXw2grtaJCJOmmf+CWWl10WQASwMSvuMM/VsYClBx2c1AeisFB
         nfi8ezf2kEno9V646udDjFQLRulpIlFeGgs2nvi/QV68GIc5dtTl50K2YhjiOpQCANkV
         MdmHaihP591UaBKQGVXJkNk7DWGwbw6D8EJqUpUwVvfslJd9PMryGr1rBJVjvW/o6kGW
         oIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708476; x=1763313276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr1lUAnFZGlsHD54+AxELQ78EmMa3JgPHit5j+6Xino=;
        b=Manf66BV9We8YCj4/uuWaZJ+GL9dRaUUMpeFQePYItvDmYTjbsravE8HrxeB0WMpj2
         A/3jSjyhMeLTStk6QgDrEfZ7S8LA9dn2u/sYBz2zort7s5SKWnRoLagBYAL0rbe9hEMc
         /VYHoHp+ns2+8AlfvCKSe/qnQH0VllZvPgudnDjfMwBrvz3L1rqUIfhi4uTmDx9AO8Ny
         zQHxycCxAigxujJMF80jOY/V+LTpYx11DwrqnnDPOyToEIVs9yr9dUkPAA/uWlY2jcIu
         1TW8hjnjvBp1iwlO6TZr2zi3UdC//gPLCfr7wAvF720HBFMkmLeaXIKgxpI8BWPXxzqq
         3pJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20OL0klgwa85RwNInT60Hoj63YAXtYLNjqU2ltBToDgDOFQFLdhQPER24GnES7EWfft4+3uU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkpe58vc5xH+tHXfu8IT+PWYSwJURri5tFtG0yLYrPingEnGS6
	u+SizMwxF9QI006h2H8IVK2Jlm1+GoP6dnAJhevdxeV2fmr+c8Y/iT6d2s3RnEor5tG6Uef5HzF
	Oxxjl7YeHcIfRfbNQiknr716M60FN9pabfZiuLJlo
X-Gm-Gg: ASbGnctjhtMbXukBQzuXHBsLdEqJ4l2vHr3svxmijfWe15BN0x7EJuGYsQWO5AY4FEZ
	OH/t1d/BVPVdEc1KuvjV0ZNsFzlxugP9/m0YeM5uL7cQtH3PzNBvYrywZhkFntIaiYDM6xtFM7l
	tUPCWjss6zUXGIOtWbN19WqAzIH856YZ2V+ToUuzFI2qbXiHAU2Q3Vx2g8ps5Hg62p87z5nQb2I
	v7n8SyxztXJPKyo+gTsKFgUdsl3SCmbLqN1uGOQC6k3n3uWq/0VQcd5QegFbYCfy3WZfxzc
X-Google-Smtp-Source: AGHT+IEiz2qvJOE51Kzk0HFhFqtWFaKI72WxDNqHutAxsMarX+MJIplKe5wA6perYH8DR7HRwJ7dkKd3NM1Ob5W+6QI=
X-Received: by 2002:ac8:7d0a:0:b0:4b5:f7d4:39fa with SMTP id
 d75a77b69052e-4eda4e7ac76mr77836631cf.12.1762708475741; Sun, 09 Nov 2025
 09:14:35 -0800 (PST)
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
 <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com> <871pm7np2w.fsf@toke.dk>
In-Reply-To: <871pm7np2w.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 09:14:23 -0800
X-Gm-Features: AWmQ_bmPdDcSEme1iBAAMKp16ctu1pOWXu9M3I6mw1K4GyQdez6jkwybgHKFapQ
Message-ID: <CANn89iJG=EszxP0GDd_jO9db6WxajRQ03gzVYZGF1CM8Dng90Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 8:33=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Sun, Nov 9, 2025 at 2:09=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >>
> >> This might be something related to XDP, because I ran the following
> >> test (IDPF, 32 TX queues)
> >>
> >> tc qd replace dev eth1 root cake
> >> ./super_netperf 16 -H tjbp27 -t UDP_STREAM -l 1000 -- -m 64 -Nn &
> >>
> >> Before my series : ~360 Kpps
> >> After my series : ~550 Kpps
> >
> > Or ... being faster uncovered an old qdisc bug.
> >
> > I mentioned the 'requeues' because I have seen this counter lately,
> > and was wondering if this could
> > be a driver bug.
> >
> > It seems the bug is in generic qdisc code: try_bulk_dequeue_skb() is
> > trusting BQL, but can not see the driver might block before BQL.
> >
> >  I am testing the following patch, it would be great if this solution
> > works for you.
>
> That does not seem to make any difference. I am not really seeing any
> requeues either, just a whole bunch of drops:
>
> qdisc cake 8001: dev ice0p1 root refcnt 37 bandwidth unlimited diffserv3 =
triple-isolate nonat nowash no-ack-filter split-gso rtt 100ms raw overhead =
0
>  Sent 9633155852 bytes 13658545 pkt (dropped 36165260, overlimits 0 reque=
ues 42)
>
> Tried with 16 netperf UDP_STREAMs instead of xdp-trafficgen, and with
> that it's even worse (down to less than 100 PPS). A single netperf
> instance gets me back to the ~600k PPS range, so definitely something to
> do with contention.
>
> The drops seem to come from mainly two places:
>
> # dropwatch -l kas
> Initializing kallsyms db
> dropwatch> start
> Enabling monitoring...
> Kernel monitoring activated.
> Issue Ctrl-C to stop monitoring
> 1 drops at __netif_receive_skb_core.constprop.0+160 (0xffffffff87272de0) =
[software]
> 2132 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
> 1 drops at skb_queue_purge_reason+100 (0xffffffff8724e130) [software]
> 52901 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
> 153583 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
> 1 drops at __netif_receive_skb_core.constprop.0+160 (0xffffffff87272de0) =
[software]
> 93968 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
> 212982 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
> 239359 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
> 108219 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
> 191163 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
> 93300 drops at __dev_xmit_skb+3f5 (0xffffffff8726d475) [software]
> 131201 drops at __dev_xmit_skb+13c (0xffffffff8726d1bc) [software]
>
> +13c corresponds to the defer_count check in your patch:
>
>                         defer_count =3D atomic_long_inc_return(&q->defer_=
count);
>                         if (unlikely(defer_count > q->limit)) {
>                                 kfree_skb_reason(skb, SKB_DROP_REASON_QDI=
SC_DROP);
>                                 return NET_XMIT_DROP;
>                         }
>
> and +3f5 is the to_free drop at the end of the function:
>
> unlock:
>         spin_unlock(root_lock);
>         if (unlikely(to_free))
>                 kfree_skb_list_reason(to_free,
>                                       tcf_get_drop_reason(to_free));
>
> Not sure why there's this difference between your setup or mine; some
> .config or hardware difference related to the use of atomics? Any other
> ideas?

I would think atomics do not depend on .config.

Hmmm... maybe some CONFIG_PREEMPT_RT stuff ?

Cpu who won the race can not make progress for some reason.

Qdisc can be restarted from ksoftirqd, and it might compete with your
user threads,
because why not :)

