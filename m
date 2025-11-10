Return-Path: <netdev+bounces-237190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0986C46E5E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965A63B47A5
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCB310779;
	Mon, 10 Nov 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Wg3a1TF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF503303C9A
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781232; cv=none; b=iEt0roQMDURB+7ClWQK1SHqtefu2McJ8cD3WIZREE0UcmAjwTOCCJ1ec3WEu6y2GiD+n/ginKOM2fSojHrj0sLvJyRzynpeLFaGSTzatMoMdqBmu1ZKqak9EYfvw34JM+GwWGPZFh6/X5gjDsJn0bbL6q50XLzqNhFkIJ72eLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781232; c=relaxed/simple;
	bh=2aXGNVpxhVmfupqogvC6dM4y8k5HV5qZkteDttzeRdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRPweuaY66L/bttiL9G8k4jLmuFDbAqTg4sbUWWNreLgldkGZTnfI1+FMYw26H3LXJ4DobrBbo+E0qbPXAPyO6F8xDxotd+6x/yS/rBwKM4qGHAshLGk0Mpim5tmfX6ddJ8X6rWyB+SQS/j0X6//d8csepkaxFLuDEvYsLY07ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Wg3a1TF; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb166b4e3so12142221cf.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 05:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762781229; x=1763386029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xee5l4N6FJIM7FO7vccKhBoIWKmlm9A57xHd9dkVcuI=;
        b=3Wg3a1TFzqTXSYSbLYAisHbDqOrm4i1jfUlR1XRDZQyVWI1aLs7KUsuOi4cAEq5msL
         7TDfxXsYOoPXvYCCAGH/+n8x76RPktoZvQYYCVBb0YP9tp9K9/+C5dIMCf6NMiN6FqVn
         GOCtmXK6hWBnsrrLU6I2tDUH3mMUlaFJHTZTbn/IT3rXOkFqlXN/2RbWiiw36ttdWgl3
         nlv/7lXext5VYxtdx+JFf9YICwiEZKINbljvtdNQCjglT+LMnVHoHCqS7ehCYxR2bjZO
         9am+nztfLUjfxtyYNQ02DHhtxSgzOLU5ouPZPAfqp5oWwpavRrkKtN+AXHdfs7qQsO8e
         zRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781229; x=1763386029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xee5l4N6FJIM7FO7vccKhBoIWKmlm9A57xHd9dkVcuI=;
        b=PcmS2tOevs0lQXgp5u9HLmzBhbqMFAGiY47eNnTsCfH0KB+Dp1eWbmUVtyj6149Tww
         7A/30X9MyU6zaAdcVT28VwyVCQkTFFWm64Y603Ekfx8r9mPF5hJGE0iJx33Cnm72PG0g
         0yV8+Uki1BrA3B2PUukyokJwnBwbesbV9bf59+sysGA8NGoc8+HIW8+MimoogVLIhtBG
         /ncLGHyMr/GdVimhASFGqnv7PM5Cn7n7ReA+YcQLzmcwlDNyhx4hY7c7Rc7SChctYQrM
         PDcV6Ykf9H1lMwUofSgIWOmEyf0rPimC52GpKzyLHKWT4lwyzDclLN8ABkDx/GVtKUhd
         GsHg==
X-Forwarded-Encrypted: i=1; AJvYcCXj5Uvotf1ZAOVzkRjyq8rlyPSmlIWFVlDCVSAHyiZ/fdh//Q9ACh52E3vmCOQ6oLDG0AzZR0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww0Cs+V2PAesMGdKgZR+9O5wTBfZCTkwqTn7s/PfOcsF9Gd4pD
	V62HLdpWNQw0ryFs6c+hTUq1crJ/gXE6EiSx4M8xYBAI+FnpTf0+x5/W4gLRhIEg1Kg5W6WdIx8
	vyaL7DVTNA6JWcR8eG1Q5f0jRfbusqJMTfBQd9YdC
X-Gm-Gg: ASbGncuk91TUTHzjiLymj7ZlMact+y86zZucDpxE1YSCwuLQ8AOTTynl3ZODiDbwULC
	Yo1vcHThqGOLPBnX2MhkZxdLdCb8WlAIAlHihFsNMLexM4xfB53EOoNiJTA3Np3SaNnbEocl1Yp
	yooqvOMYTTBGPPmCWwWFAMV2A+ovSdqs55hqwwdbq421JEl92PyjjE+BqqtZuyHwO08kGTx778N
	viJcLhFe/sjP75csQak2bM5Zuhg+s7q9gSa7X9pmvUMTH7jFlQR8NjqBAYqMFjPNwcHBwY=
X-Google-Smtp-Source: AGHT+IHek9VXnuWzsUEVcu0cEgK/e+ASKJsOcuhabZ7YYV/nACdu8/o4YlEWbBFseSCG9fyNzP5Z22V6jNTBxkJqj1o=
X-Received: by 2002:ac8:5704:0:b0:4ed:62f2:8f03 with SMTP id
 d75a77b69052e-4eda4fd8b85mr117075031cf.81.1762781229175; Mon, 10 Nov 2025
 05:27:09 -0800 (PST)
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
 <CANn89iKDx52BnKZhw=hpCCG1dHtXOGx8pbynDoFRE0h_+a7JhQ@mail.gmail.com>
 <CANn89iKhPJZGWUBD0-szseVyU6-UpLWP11ZG0=bmqtpgVGpQaw@mail.gmail.com>
 <CANn89iL9XR=NA=_Bm-CkQh7KqOgC4f+pjCp+AiZ8B7zeiczcsA@mail.gmail.com> <87seemm8eb.fsf@toke.dk>
In-Reply-To: <87seemm8eb.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Nov 2025 05:26:58 -0800
X-Gm-Features: AWmQ_bkBvORX6xXI9vBC6hqT-32s605UvZvB5zdrzTAPAIW_N7_MF3tRgoYd3Y4
Message-ID: <CANn89iLWsYDErNJNVhTOk7PfmMjV53kLa720RYXOBCu3gjvS=w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: =?UTF-8?Q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:31=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Sun, Nov 9, 2025 at 12:18=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >
> >> I think the issue is really about TCQ_F_ONETXQUEUE :
> >
> > dequeue_skb() can only dequeue 8 packets at a time, then has to
> > release the qdisc spinlock.
>
> So after looking at this a bit more, I think I understand more or less
> what's going on in the interaction between cake and your llist patch:
>
> Basically, the llist patch moves the bottleneck from qdisc enqueue to
> qdisc dequeue (in this setup that we're testing where the actual link
> speed is not itself a bottleneck). Before, enqueue contends with dequeue
> on the qdisc lock, meaning dequeue has no trouble keeping up, and the
> qdisc never fills up.
>
> With the llist patch, suddenly we're enqueueing a whole batch of packets
> every time we take the lock, which means that dequeue can no longer keep
> up, making it the bottleneck.
>
> The complete collapse in throughput comes from the way cake deals with
> unresponsive flows once the qdisc fills up: the BLUE part of its AQM
> will drive up its drop probability to 1, where it will stay until the
> flow responds (which, in this case, it never does).
>
> Turning off the BLUE algorithm prevents the throughput collapse; there's
> still a delta compared to a stock 6.17 kernel, which I think is because
> cake is simply quite inefficient at dropping packets in an overload
> situation. I'll experiment with a variant of the bulk dropping you
> introduced to fq_codel and see if that helps. We should probably also
> cap the drop probability of BLUE to something lower than 1.
>
> The patch you sent (below) does not in itself help anything, but
> lowering the constant to to 8 instead of 256 does help. I'm not sure
> we want something that low, though; probably better to fix the behaviour
> of cake, no?

Presumably codel has a similar issue ?

We can add to dequeue() a mechanism to queue skbs that need to be dropped
after the spinlock and running bit are released.

We did something similar in 2016 for the enqueue part [1]

In 2025 this might be a bit more challenging because of eBPF qdisc.

Instead of adding a new parameter, perhaps add in 'struct Qdisc' a
*tofree pointer.

I can work on a patch today.

[1]
commit 520ac30f45519b0a82dd92117c181d1d6144677b
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jun 21 23:16:49 2016 -0700

    net_sched: drop packets after root qdisc lock is released

    Qdisc performance suffers when packets are dropped at enqueue()
    time because drops (kfree_skb()) are done while qdisc lock is held,
    delaying a dequeue() draining the queue.

    Nominal throughput can be reduced by 50 % when this happens,
    at a time we would like the dequeue() to proceed as fast as possible.

    Even FQ is vulnerable to this problem, while one of FQ goals was
    to provide some flow isolation.

    This patch adds a 'struct sk_buff **to_free' parameter to all
    qdisc->enqueue(), and in qdisc_drop() helper.

    I measured a performance increase of up to 12 %, but this patch
    is a prereq so that future batches in enqueue() can fly.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>




>
> -Toke
>
> >> Perhaps we should not accept q->limit packets in the ll_list, but a
> >> much smaller limit.
> >
> > I will test something like this
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 69515edd17bc6a157046f31b3dd343a59ae192ab..e4187e2ca6324781216c073=
de2ec20626119327a
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4185,8 +4185,12 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >         first_n =3D READ_ONCE(q->defer_list.first);
> >         do {
> >                 if (first_n && !defer_count) {
> > +                       unsigned long total;
> > +
> >                         defer_count =3D atomic_long_inc_return(&q->defe=
r_count);
> > -                       if (unlikely(defer_count > q->limit)) {
> > +                       total =3D defer_count + READ_ONCE(q->q.qlen);
> > +
> > +                       if (unlikely(defer_count > 256 || total >
> > READ_ONCE(q->limit))) {
> >                                 kfree_skb_reason(skb,
> > SKB_DROP_REASON_QDISC_DROP);
> >                                 return NET_XMIT_DROP;
> >                         }
>

