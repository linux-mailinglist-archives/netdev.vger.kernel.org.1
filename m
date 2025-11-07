Return-Path: <netdev+bounces-236707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 018BDC3F1E5
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8FAF4E43AB
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796B28030E;
	Fri,  7 Nov 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmIb4O7M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EE2AD04
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507214; cv=none; b=upGAs/w2z0Fdb/79xBYbKzw0KZ7ohS9TyTWu7UmxIs0KhA/7OsDFJjXGQlW0UngjNr+vgo9ir2nciaiCdWAG7LgqjhqN8NejmiNhJ8RoN14Zr7AhHAgQ4FMN5kh387U6RtSGo3T18yuE+ZquT99GeLcrbTistpPuz1V5AnT2ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507214; c=relaxed/simple;
	bh=3MosL8TNsl+fh5+ZP1UUipe2sd2rgEv/ZSWiLJR94IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwxJCNwSi2lUiqP1Svu6VRuNxsCoNp1TpreqFw7ZUmTtu0+aQGJf4MJM3B4KVdbutu1TqFP6bxF9LW7ILKVy46JCxi5e5YbN4iVU1q0Mg0VltoD4rN8d2Aw3EbdhryDs2TnT/rLNqaictmU6LHPV4kq4L36Njfud7v4ChwQZJp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmIb4O7M; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7869dee42cdso5881677b3.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762507211; x=1763112011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoqLCX1qiItMDiutWIth5zGqvXX6r/EG8mt1uDZRz6Q=;
        b=KmIb4O7MoOZsrxfjHw1u+NyNciHaCmEgxfJAtGhydUyyOfpQ6EG84AeP2RLijBmJMg
         3OgxIzZ6S1L1RR0bR7tA70YYxkQUsJz/lPCCyjJ7Lp3qDPq/EORCRFMQvZxqYLaHlSsw
         kVm11ll/PvvWWeEGpW2o0DWe2VLgUMrWtHtsXKLw+IR9OOb4hB4X1HxxCmrKbLGk+9pL
         HbVhUAImHNYSct42DStIXlZsXYoTI8CkNki6Vq1NQzHDAChzRxJ7lxYYAD6DkXiETfLM
         t+H3gfwAQCsSJws6cAnVIaEo9jVFLq9cVhpmSjvLT/Qf4wN01ZeI5EmLleZ7TbaPVCVW
         KQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507211; x=1763112011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uoqLCX1qiItMDiutWIth5zGqvXX6r/EG8mt1uDZRz6Q=;
        b=W9R1FRNkb8kkvhnBedJ7vohJNzTaAqtM+VQsYse6QRiqDez+uKqhfw1bnri7Vm3sKb
         ijoyb0d+avBa1uhIPlSpF9FUplNNgSTUoKcSJNEXkGEN/nyrXSTPxigYznaflsHIi1WQ
         XpRPgiUEwkhOkTrSPPicmvPOrpTLmMwvJvzFEks90sGbL/escba4+ZNTnkr2RJq3DkHe
         aT1G6Rrk9jzWw0sQFZqOSvbMhF5v8Ex1o81wjMTq2J0oQ+3X+9X9OGNGB56cNuHVs8tC
         W3XYN/80FPLQ6tLjboDopDmGqz6sg85vNMp1kgK5JeyN7HflbunRgRf6FtBatOWR4by6
         ZFFA==
X-Forwarded-Encrypted: i=1; AJvYcCVHRntkqfuO9asF6Ezm/lzt5Wkmc9rQjXR4rQVH9kFqUjAkacvA5M+RrNo7T/isDzatCOIkbX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2bLv/lndrNC7f75LEMQpL0MwaPC0NKN+obS6jtrRa2O+NM6t
	NWMbrzkNj+fcdoF8yZr3QzPVhhokCv9dvK8NasxckA+6Jkt2s/uII5jd4yrOUI4JvDFnlLRTqzW
	vqleMPfN+qZy9vKiKVa+sxEh9KkfVKsA1iG/kxmS0
X-Gm-Gg: ASbGncuQn9HET8C2v+ZZjGDxWlriODjahsALsW93gjRk0qdEnM0p2RqZG9YVEAZLJsl
	PSFddu+1GavRIcVWhfJ9aZSQsj+LawTlHquEUjxwS+Fv1tJXAernfj9K+r1vf9WSdxDpn+fxN6f
	iSg7a1aYy4ZNMV95qeHTGJHVTs5M7GAKRGIj0M0p1rI/1sQECalU++BnAPk6mAE5oQEwZmJ6/FL
	3lHorJ1hBe4otcVQgZGEBm4uxVSp9R3ysbgqlFeD7r7TZe8nlY5PxXtBCZoHWK3z6IIk6aK
X-Google-Smtp-Source: AGHT+IG8VpET8emZXcMKB+hCY1i1Mi69eoCVSFJn32lzvkOPHES+Qy9iKFaFJEBLMPv7m4TU1GKbOfxalwq+URtOtYk=
X-Received: by 2002:a05:690e:248a:b0:63e:336c:20e1 with SMTP id
 956f58d0204a3-640c9d909ddmr502053d50.25.1762507210883; Fri, 07 Nov 2025
 01:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106155008.879042-1-nhudson@akamai.com> <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com> <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
 <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
In-Reply-To: <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 01:19:59 -0800
X-Gm-Features: AWmQ_bnb_GwEQ90Aj9uGel-5UqTxeVbMOegx7XOiPmv--Ak3uxj5EftZZVfCkO4
Message-ID: <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
To: "Hudson, Nick" <nhudson@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 1:16=E2=80=AFAM Hudson, Nick <nhudson@akamai.com> wr=
ote:
>
>
>
> > On 7 Nov 2025, at 09:11, Eric Dumazet <edumazet@google.com> wrote:
> >
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Fri, Nov 7, 2025 at 12:41=E2=80=AFAM Hudson, Nick <nhudson@akamai.co=
m> wrote:
> >>
> >>
> >>
> >>> On 7 Nov 2025, at 02:21, Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> !-------------------------------------------------------------------|
> >>> This Message Is From an External Sender
> >>> This message came from outside your organization.
> >>> |-------------------------------------------------------------------!
> >>>
> >>> On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson <nhudson@akamai.c=
om> wrote:
> >>>>
> >>>> On a 640 CPU system running virtio-net VMs with the vhost-net driver=
, and
> >>>> multiqueue (64) tap devices testing has shown contention on the zone=
 lock
> >>>> of the page allocator.
> >>>>
> >>>> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker t=
hreads run shows
> >>>>
> >>>>   # perf report -i perf.data.vhost --stdio --sort overhead  --no-chi=
ldren | head -22
> >>>>   ...
> >>>>   #
> >>>>      100.00%
> >>>>               |
> >>>>               |--9.47%--queued_spin_lock_slowpath
> >>>>               |          |
> >>>>               |           --9.37%--_raw_spin_lock_irqsave
> >>>>               |                     |
> >>>>               |                     |--5.00%--__rmqueue_pcplist
> >>>>               |                     |          get_page_from_freelis=
t
> >>>>               |                     |          __alloc_pages_noprof
> >>>>               |                     |          |
> >>>>               |                     |          |--3.34%--napi_alloc_=
skb
> >>>>   #
> >>>>
> >>>> That is, for Rx packets
> >>>> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
> >>>> - vhost-net threads float across CPUs do SKB free.
> >>>>
> >>>> One method to avoid this contention is to free SKB allocations on th=
e same
> >>>> CPU as they were allocated on. This allows freed pages to be placed =
on the
> >>>> per-cpu page (PCP) lists so that any new allocations can be taken di=
rectly
> >>>> from the PCP list rather than having to request new pages from the p=
age
> >>>> allocator (and taking the zone lock).
> >>>>
> >>>> Fortunately, previous work has provided all the infrastructure to do=
 this
> >>>> via the skb_attempt_defer_free call which this change uses instead o=
f
> >>>> consume_skb in tun_do_read.
> >>>>
> >>>> Testing done with a 6.12 based kernel and the patch ported forward.
> >>>>
> >>>> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
> >>>> Load generator: iPerf2 x 1200 clients MSS=3D400
> >>>>
> >>>> Before:
> >>>> Maximum traffic rate: 55Gbps
> >>>>
> >>>> After:
> >>>> Maximum traffic rate 110Gbps
> >>>> ---
> >>>> drivers/net/tun.c | 2 +-
> >>>> net/core/skbuff.c | 2 ++
> >>>> 2 files changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 8192740357a0..388f3ffc6657 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct *=
tun, struct tun_file *tfile,
> >>>>               if (unlikely(ret < 0))
> >>>>                       kfree_skb(skb);
> >>>>               else
> >>>> -                       consume_skb(skb);
> >>>> +                       skb_attempt_defer_free(skb);
> >>>>       }
> >>>>
> >>>>       return ret;
> >>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>>> index 6be01454f262..89217c43c639 100644
> >>>> --- a/net/core/skbuff.c
> >>>> +++ b/net/core/skbuff.c
> >>>> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
> >>>>       DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
> >>>>       DEBUG_NET_WARN_ON_ONCE(skb->destructor);
> >>>>       DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> >>>> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
> >>>
> >>> I may miss something but it looks there's no guarantee that the packe=
t
> >>> sent to TAP is not shared.
> >>
> >> Yes, I did wonder.
> >>
> >> How about something like
> >>
> >> /**
> >> * consume_skb_attempt_defer - free an skbuff
> >> * @skb: buffer to free
> >> *
> >> * Drop a ref to the buffer and attempt to defer free it if the usage c=
ount
> >> * has hit zero.
> >> */
> >> void consume_skb_attempt_defer(struct sk_buff *skb)
> >> {
> >> if (!skb_unref(skb))
> >> return;
> >>
> >> trace_consume_skb(skb, __builtin_return_address(0));
> >>
> >> skb_attempt_defer_free(skb);
> >> }
> >> EXPORT_SYMBOL(consume_skb_attempt_defer);
> >>
> >> and an inline version for the !CONFIG_TRACEPOINTS case
> >
> > I will take care of the changes, have you seen my recent series ?
>
> Great, thanks. I did see your series and will evaluate the improvement in=
 our test setup.
>
> >
> >
> > I think you are missing a few points=E2=80=A6.
>
> Sure, still learning.

Sure !

Make sure to add in your dev .config : CONFIG_DEBUG_NET=3Dy

