Return-Path: <netdev+bounces-232571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CF3C06B39
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF66A1C04E55
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFE986340;
	Fri, 24 Oct 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soIPUykz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29F233D85
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316226; cv=none; b=I2pTaokZPPjEy6QVvp+DM/z2KlTElDoeAa0Aq4/8MVvpXTCDzDN29bvkq9WqbrglybLs0/ShfdSa6q/8nfIjTnK6/6DyY2qP9EODMJ18fcxsm7dgUr6C5nzsTF6BjY+EQqL/ri8b3G7t22Q+IrPTqXl+ctIunEgFiF1Qynfquh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316226; c=relaxed/simple;
	bh=p/xf7KMTfxm0KEZFxjOxDZEmEkR9tnZ/y6kdde27JIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdPH/NsAX9coZZmlVBpncRrx2Ei3nqSZJan1/JWM3vCVom+n7M+LjFIhRZy+pS+LgrscxdGFR/KHmJllLOpT/PlT0/N4GH3IkEVtaqhTBpYX59qe0njU/66xelswWuHOd0ttHca4uHlBTDvVcc0Y+8Lpd3nZg341shXGLP8ROik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soIPUykz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4e88dbe8b77so17944261cf.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761316223; x=1761921023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZRS8ogbAbtnlzUHEG4A6rZZc8ic0t1+H+wsUdoDXT4=;
        b=soIPUykz1IqtWnsYA/N8zT+zBqmsFZ6KayfXGd+9Gz6CxUXidi2MgvvTRcRq3GEZh0
         2eLLVH4oLLJ5kh2/nDTnuxL2MmdFe8Jib3FXzTrYVuV0bMsxuSu3jGxO+JSngGtWsh8O
         Gzvar+EqlQjEwnAQph6vmu6yEKW67CtUGAF8LUhy3NTVprKTx7CExAdyJhgPm3rcHCIv
         ud23RJDmYLV1ivhjtiYKWyzbCCK4/9cLPXJ0DW6zYF8U3qgZ3umpWYPTU0rOZbQ7qR1i
         lQJEYvah1UD2Zo8XZTFkhWSVpqrqIhqCf5utY1pkgzi/PuOcLWfYzqwf/BsuT/gQZ/Rv
         60cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316223; x=1761921023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZRS8ogbAbtnlzUHEG4A6rZZc8ic0t1+H+wsUdoDXT4=;
        b=xL9QK23oHjPO+6oyj7WsIsLZ4QRWDQaPxh4H538h7mOfnV8pU6mIPguEG1RRssq97c
         w/6r5mdqltFk3RMT8Yn06u36o4kD13S+jxKqC0DVc9gmp4NtLd6miCwxFjyfSw2+xa3w
         3WxGLBW9XpqQy86SoNiaz5lR1PU1nuVRDBx6+2WNnPWXWqjYyQTS3wkzjAgPq1PjlE8Q
         zFscnpmNy5q1xiY6T+//pZiX6LAbfCAbHya28SrFHVcBbN2p2yxY7CSocg6G6QthEUj6
         zst0G3ACLS5PGYxAZYCnDEiRugmsJf4b51/7XvfiSo/dKiBRy6rfCJKPjUqhHJACR1oC
         We4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbcFJOj4445JvBhXJ6rsDsjdp7+cFYxzV6tT+/3Gg8KCuW9YeKjrMDdSe4GeoX5biAUlBvBLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1XA2XG7jbTL9A8SNtTUO2h6F71XcP+BNKMetjWNcSWZ6J9dA
	pog3IQJO1uccy9o+/2QENjrAybB1wO0LeVQ9Gv2EshQsRnqyMPSK5wiEzb1WEBlNY9ucfWh+fOb
	UTf0MF7++aVjidcEdPxg0Innh3N8DopgHRgDH7e1R
X-Gm-Gg: ASbGncs3ZFil0RqJkzh+WGTeeD6j4Freb97Udu0N4ElSpELEyolh/qFeav+ssR2ff2u
	0MmWUPLDZ+jI/BqRIlR68fic7m2IJEoLP5BQcX8OEEjJRtUyafFg0knsMeTAM4CMuHnmAfC6Ikv
	UozxXT/7pLaDqtTpgsR1f80gyk0ySctSqXGLEgYb4ElT4VdvWOFzIxV+pbeOi2fUJGYb8Dqq9Kj
	5CYCQESd8DFh647XV7xKfgoZSoxO2mSJcsTr0VHYJdwAwDiPHJRItFKfOU=
X-Google-Smtp-Source: AGHT+IGKu4HZwBumdD+5CAwSQ0ZZ+aqAiM8ugezAOpTCcu7ht99y808pwq6tLhKRDXv9UvVdmCZ1Ajl7oEWVKcc1UCU=
X-Received: by 2002:ac8:5714:0:b0:4e8:979d:c224 with SMTP id
 d75a77b69052e-4eb94800f59mr31326221cf.18.1761316222137; Fri, 24 Oct 2025
 07:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024090517.3289181-1-edumazet@google.com> <willemdebruijn.kernel.249e3b8331c2c@gmail.com>
In-Reply-To: <willemdebruijn.kernel.249e3b8331c2c@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 07:30:09 -0700
X-Gm-Features: AS18NWAC-vJL-v7Gu83eh-HpEmgTlZLyRBRX_7ctUWfzDRlBFYNbP-zumIWgcSE
Message-ID: <CANn89iLidq+WTYkg2-U6g8tK5W=squKoQcYECc=RjF_h7-g-wg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: optimize enqueue_to_backlog() for the fast path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:03=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Add likely() and unlikely() clauses for the common cases:
> >
> > Device is running.
> > Queue is not full.
> > Queue is less than half capacity.
> >
> > Add max_backlog parameter to skb_flow_limit() to avoid
> > a second READ_ONCE(net_hotdata.max_backlog).
> >
> > skb_flow_limit() does not need the backlog_lock protection,
> > and can be called before we acquire the lock, for even better
> > resistance to attacks.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > ---
> >  net/core/dev.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 378c2d010faf251ffd874ebf0cc3dd6968eee447..d32f0b0c03bbd069d3651f5=
a6b772c8029baf96c 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5249,14 +5249,15 @@ void kick_defer_list_purge(unsigned int cpu)
> >  int netdev_flow_limit_table_len __read_mostly =3D (1 << 12);
> >  #endif
> >
> > -static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen)
> > +static bool skb_flow_limit(struct sk_buff *skb, unsigned int qlen,
> > +                        int max_backlog)
> >  {
> >  #ifdef CONFIG_NET_FLOW_LIMIT
> > -     struct sd_flow_limit *fl;
> > -     struct softnet_data *sd;
> >       unsigned int old_flow, new_flow;
> > +     const struct softnet_data *sd;
> > +     struct sd_flow_limit *fl;
> >
> > -     if (qlen < (READ_ONCE(net_hotdata.max_backlog) >> 1))
> > +     if (likely(qlen < (max_backlog >> 1)))
> >               return false;
> >
> >       sd =3D this_cpu_ptr(&softnet_data);
>
> I assume sd is warm here. Else we could even move skb_flow_limit
> behind a static_branch seeing how rarely it is likely used.

this_cpu_ptr(&ANY_VAR) only loads very hot this_cpu_off. In modern
kernels this is

DEFINE_PER_CPU_CACHE_HOT(unsigned long, this_cpu_off);

rest is in the offsets used in the code.

>
> > @@ -5301,19 +5302,19 @@ static int enqueue_to_backlog(struct sk_buff *s=
kb, int cpu,
> >       u32 tail;
> >
> >       reason =3D SKB_DROP_REASON_DEV_READY;
> > -     if (!netif_running(skb->dev))
> > +     if (unlikely(!netif_running(skb->dev)))
> >               goto bad_dev;
>
> Isn't unlikely usually predicted for branches without an else?

I am not sure this is a hardcoded rule that all compilers will stick with.
Do you have a reference ?

>
> And that is ignoring both FDO and actual branch prediction hardware
> improving on the simple compiler heuristic.

Lets not assume FDO is always used, and close the gap.
This will allow us to iterate faster.
FDO brings its own class of problems...

>
> No immediately concerns. Just want to avoid precedence for others
> to sprinkle code with likely/unlikely with abandon. As is sometimes
> seen.

Sure.

I have not included a change on the apparently _very_ expensive

if (!__test_and_set_bit(NAPI_STATE_SCHED,
                                    &sd->backlog.state))

btsq   $0x0,0x160(%r13)

I tried to test the bit, then set it if needed, but got no
improvement, for some reason
(This was after the other patch making sure to group the dirtied
fields in a single cache line)

