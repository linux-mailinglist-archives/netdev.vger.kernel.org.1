Return-Path: <netdev+bounces-216039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346AB31A90
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AB618902CA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E93054E7;
	Fri, 22 Aug 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s01JzASr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BD3054CF
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870978; cv=none; b=r+Vp2Qo6JHxqOwqGD3DOLaX99yjYdhGPugVrHyhKBpYXslqHX6v/FSbOkHZSgPwHUJlab9bT3Ab2Wg0+IOPqc567TphaHalsfh3rC0/WXyrkfiYw5LdRzASW0wZ5/DvydwtTwIB+UdOo1YI3AEyJ96UtZUhdObz3fnO06KYPPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870978; c=relaxed/simple;
	bh=jNxvkaweliXwMMfpjl3PBnJUBeD4v2FJL9Sc8EVjwcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP+uNRpPDKBm63m/Xz4kOZNpbcepkz3K+Y7Goe6KHjzsArxr9oA/Sa2C9cfWGR5/45wumFsDZ1vmi4pNb6GB2xdslEDjve+Mz7uTtITngmASVcVrq3uB3Cj76YloVjgwcnu3TXVcq7bJq+2qo94fMQWclVlJ8dJmktd/bcBqusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s01JzASr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109914034so23393641cf.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755870975; x=1756475775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orr0vaCQMuUXevixrauGvIg9fy+Ajsx09bEeAR/E9Ds=;
        b=s01JzASr4yJBOmaJZfn9L4Ha0Lx0iQYzbF2dZShzU0Is0hxrlgazu+2SaBKz7Xpy8h
         C6YK/wAZPiLMSDcJZ2uFXXBy6s8a2tQC4HwfddH76ihlxDh7MWqhrU93T/RlxyaCZdA1
         C622ytm76cjgaep9mB3rK3hnKTR5Fuzf72fdoJtJoQ5gbWqEPdCIsT8WxHh7huO3M3QQ
         K5pwbutISpGYQtoiaByX5Uzy/nXbxIGojt80xR29zFVbZUaaLML+nQPIQHtV/QXKtnRT
         3k3oWFJN7WkxdD1Lm3ezxsqKD4vMsqI1UM2XTuZepiDL2IOl8Pnhv1gk/vVo962U4MLO
         b7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870975; x=1756475775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orr0vaCQMuUXevixrauGvIg9fy+Ajsx09bEeAR/E9Ds=;
        b=VeNuQwFCtxKRNPf+VT9xY+GkOCCFq9Ax5J/0paXHTL5pVmeadMWmJrrmfzrfuGjpno
         4OIJA3Cg0ttouEfl8DJyR1uc3mnxh/m1feDI3OqyJ3wx+aiAlOgqplJMoNGj/1+qyS9d
         rgPF7ULO3JMbYHPjcaZ/8ENNbCoQmHegi2+Q5yYjNV9EcjJEBfAlNtDrG9/visQjMhop
         mcDumSvPKBw+juIxVASfKspwngVwfidn4waupdeaa7l9QbP+KXM5vSrTcPjIAxpaTaEA
         73nQOxPC5rvoImzj95tmSGQB0OvY6FyF6DoHp4yJbCgQ/o+o0xeakBd0f7jRZlNmunaH
         ZcDQ==
X-Gm-Message-State: AOJu0Yw7n/TiSnx4KqmE2PhquPFNTapTcXXpsDefD+I4hQMIgoXczkpH
	MuqqGLeNmA/1xhJSvH9KQIWzb/DO6Rwaf5aOmjqgNpsDErVwxgsZp89DyRPAXS6PPCB3uoJYAzG
	A9FVhgvY9+6WPy+6iEYJQ/O/b9ZTnCmt1A1qjZrf+
X-Gm-Gg: ASbGncuhQQgalCQ+01bMTiIYRnuJnFnJ31ZBYuq8+I0TyHShunBf3Lz3lFU4ANmtHRV
	SPXXmLXRmVwNZjG6c8cNunKIYVCBtVa3gOLxSRYAK4mESsZbZExzzGDLFM01Eh/tpFhnIsONuUr
	HHfPuYl1/8EED9oYTuA2QIwuaaJAix92Xmje7Txxs368zQGppf5dQatdibMUC8mEnpVP8e4r5SL
	q1MXo7zn6ouGi8=
X-Google-Smtp-Source: AGHT+IFH33KRLI/jKC6+X+xc0HWQ+wUuyJYeRGUcvFaG1SK7bZne6z9Izh+7oNA9UZLT7tsWwtTYLJiKaULZWg9Umvg=
X-Received: by 2002:ac8:59c9:0:b0:4b1:2457:54a3 with SMTP id
 d75a77b69052e-4b2aab38d65mr30324971cf.42.1755870975049; Fri, 22 Aug 2025
 06:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgnLcw6yzq78CIP@bzorp3> <CANn89iLy4znFBLK2bENWMfhPyjTc_gkLRswAf92uV7KY3bTdYg@mail.gmail.com>
 <aKg1Qgtw-QyE8bLx@bzorp3> <CANn89i+GMqF91FkjxfGp3KGJ-dC6-Snu3DoBdGuxZqrq=iOOcQ@mail.gmail.com>
 <aKho5v5VwxdNstYy@bzorp3> <CANn89i+S1hyPbo5io2khLk_UTfoQgEtnjYUUJTzreYufmbii+A@mail.gmail.com>
 <aKhxpuawARQlCj29@bzorp3>
In-Reply-To: <aKhxpuawARQlCj29@bzorp3>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Aug 2025 06:56:03 -0700
X-Gm-Features: Ac12FXwoksplNPMuGomWn_DAYdNQKmO16HKf-sCFjBFzKi5R2YjaX5NT4dJEMqs
Message-ID: <CANn89iK5-WQ-geM6nzz_WOBwc8_jt7HQUqXbm_eDceydvf0FJQ@mail.gmail.com>
Subject: Re: [RFC, RESEND] UDP receive path batching improvement
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 6:33=E2=80=AFAM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> On Fri, Aug 22, 2025 at 06:10:28AM -0700, Eric Dumazet wrote:
> > On Fri, Aug 22, 2025 at 5:56=E2=80=AFAM Balazs Scheidler <bazsi77@gmail=
.com> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 02:37:28AM -0700, Eric Dumazet wrote:
> > > > On Fri, Aug 22, 2025 at 2:15=E2=80=AFAM Balazs Scheidler <bazsi77@g=
mail.com> wrote:
> > > > >
> > > > > On Fri, Aug 22, 2025 at 01:18:36AM -0700, Eric Dumazet wrote:
> > > > > > On Fri, Aug 22, 2025 at 1:15=E2=80=AFAM Balazs Scheidler <bazsi=
77@gmail.com> wrote:
> > > > > > > The condition above uses "sk->sk_rcvbuf >> 2" as a trigger wh=
en the update is
> > > > > > > done to the counter.
> > > > > > >
> > > > > > > In our case (syslog receive path via udp), socket buffers are=
 generally
> > > > > > > tuned up (in the order of 32MB or even more, I have seen 256M=
B as well), as
> > > > > > > the senders can generate spikes in their traffic and a lot of=
 senders send
> > > > > > > to the same port. Due to latencies, sometimes these buffers t=
ake MBs of data
> > > > > > > before the user-space process even has a chance to consume th=
em.
> > > > > > >
> > > > > >
> > > > > >
> > > > > > This seems very high usage for a single UDP socket.
> > > > > >
> > > > > > Have you tried SO_REUSEPORT to spread incoming packets to more =
sockets
> > > > > > (and possibly more threads) ?
> > > > >
> > > > > Yes.  I use SO_REUSEPORT (16 sockets), I even use eBPF to distrib=
ute the
> > > > > load over multiple sockets evenly, instead of the normal load bal=
ancing
> > > > > algorithm built into SO_REUSEPORT.
> > > > >
> > > >
> > > > Great. But if you have many receive queues, are you sure this choic=
e does not
> > > > add false sharing ?
> > >
> > > I am not sure how that could trigger false sharing here.  I am using =
a
> > > "socket" filter, which generates a random number modulo the number of
> > > sockets:
> > >
> > > ```
> > > #include "vmlinux.h"
> > > #include <bpf/bpf_helpers.h>
> > >
> > > int number_of_sockets;
> > >
> > > SEC("socket")
> > > int random_choice(struct __sk_buff *skb)
> > > {
> > >   if (number_of_sockets =3D=3D 0)
> > >     return -1;
> > >
> > >   return bpf_get_prandom_u32() % number_of_sockets;
> > > }
> > > ```
> >
> > How many receive queues does your NIC have (ethtool -l eth0) ?
> >
> > This filter causes huge contention on the receive queues and various
> > socket fields, accessed by different cpus.
> >
> > You should instead perform a choice based on the napi_id (skb->napi_id)
>
> I don't have ssh access to the box, unfortunately.  I'll look into napi_i=
d,
> my historical knowledge of the IP stack is that we are using a single thr=
ead
> to handle incoming datagrams, but I have to realize that information did =
not
> age well. Also, the kernel is ancient, 4.18 something, RHEL8 (no, I didn'=
t
> have a say in that...).
>
> This box is a VM, but I am not even sure about the virtualization stack u=
sed, I
> am finding it out the number of receive queues.

I think this is the critical part. The optimal eBPF program depends on this=
.

In anycase, the 25% threshold makes the usable capacity smaller,
so I would advise setting bigger SO_RCVBUF values.

