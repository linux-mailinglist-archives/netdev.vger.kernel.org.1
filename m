Return-Path: <netdev+bounces-164867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49AA2F7A0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608CA164389
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89194257AD5;
	Mon, 10 Feb 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9UBJTM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF0257AD1;
	Mon, 10 Feb 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213034; cv=none; b=iNL3guPZdwmnADTWfNXTMcfmfJ10JwGESSR94G/J1mfSFFv5Hr7/1aG+chHYwJpu5HZ2oaFKLj02KmBwxF1LF+jkDsyYJr46x8RyHt8g8Vdil0GECPXJa0GZr/psyM3ZxN4/No2GCanqT52Na1CrVU5WciKHhgniey2bZ+7pVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213034; c=relaxed/simple;
	bh=XhK3OLlcLWNWDA3qQSdFIe3vDR9ZGFK8sgmbAI5y7U8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DsSHc1QcnLuetbiu7mmmcUGLH/GREompuxxYHpPwP2zFbuZN1GN4YysiA1V1RMhXqKQIC+GOzYbnJC348YWjfxBGAdM8xBb5F5KSDl7zqaFAF54G07SHwJbWZ3HRpS2iaowiTJfCb/STIj4InzI+m/Lj5JcIH0gdil8P3aJaStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9UBJTM7; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f28172dso270143185a.3;
        Mon, 10 Feb 2025 10:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739213031; x=1739817831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtlmTITvrL/HM7c4CD4TNJZiyPBgo70mv6ukMqGoTpE=;
        b=W9UBJTM7IkhQXs+XY0FFILasIT5dS3PpNjvTt957UytzIdHGxCxkxJgbybjBbLgTIL
         u2x/X4taWaP7x6U1+C/XENOC82SGlNYN7gQVWR9O/oZmp3OSX5KH8+so9TGXMWeOrRAl
         CCyvkd59zcM8VEjcJ9F4imS6OnQ+9/u+0+YTu8V7uzcQDn37c5Ypb09yWvwUbg2QtGfC
         axu74S5QPXVoJ6T+YYLbtejyfQJIt4oPRBLeOMiZGohz1YrwlGefHKmEezMtNMslo49n
         ZDLzCUOTTwmQcq5WZqYXqD+rA2+2WeKSUZBEglhiqUR8gj9A6xwnHyI8O4xK7G8OqlHP
         e0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739213031; x=1739817831;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LtlmTITvrL/HM7c4CD4TNJZiyPBgo70mv6ukMqGoTpE=;
        b=onNCi30325HxkNT2qByHA9zlUScEEwEZo8FwLS4pYu3jCthh9B/i265gtwzeqYaZVr
         y4Z4cdDg1FmWTWbhMk7jUs+0v9s6XpGTNIrwDM/ztfSehm4HolMeE8oeF8zq9FMZqrWZ
         /AY1npXc+0NkgSYi34Rvvkw2R1vm6yHz14mGm4GUaF2csKi0T6PDMUww/QFsPwXZyDsc
         t+LqddKfRda20Tah7KHt3hmR7IMB44V60OmJultCDbUMX3IUE3q3Is3Ug5pcTUd+/dq2
         gXcLPY0iCFZn8h2I4kFAZh4W/cZBeAuRIojWVIKSY0CzOpTMMmomiMjtueK5fs8q8PQg
         xfAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTi5000CjukSDMcLziv4iWgm53z6aPVPfC9zAuL3h/5X34sfC02KFCZrQxJDZfsyGfpmSdbNZI@vger.kernel.org, AJvYcCWZEBCNfk2heC4GZWq6CVMQpOXr8LzjZ92tmAHMlKXtAuXtnXkQ0lRFCFKbwLBDeS8j34s6gOwW2P5UfdG78N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7n18WlIhw8dOVeoTolF6ay9JTRCfZLStB4DCGXwXgJA+pZ4I
	W9kvkPj81U6ugVCtxZRQWMdKmBxur+OwrcyQEV2Rg0YB2WfVKAnH
X-Gm-Gg: ASbGncuyK9XV8Y/PdBhtdUU6gIlzomyOuJQshA0szdFxZhpePBvYZpjB3R4Q7sPcFlF
	5dOEusQPyDhDGgWWdRUHEiNbqEk3YKQ7sBwCy37IjqJFgzeV9hl6b57Ni80r9vk157IN+xEWPtU
	hnF1LQBlDch5k6PvyBa/IygOyPHsclMM2s/nvTMhBqH/x6nrk1NT2xsTinYM2acg2rI+j0JTWy9
	SjanD+tfRH0PXKui/Q1L1445ZOvRi4KzVSX3NKuVNheo+caPql/CFyOkLT3CZdNsKFCK4gT2z1l
	g13KucFkN+C6fWoGwoe4VOWmC3B6z+mlGJ2V54rm+PnA2a7tx8t6a6XfY6qK1WA=
X-Google-Smtp-Source: AGHT+IGo98d4C43aBTNjHXJB0XsvieNQhuzWoVFCaiKJUbOjDSqxbdc2sNU9OrZLrX15iE1Zavpt/Q==
X-Received: by 2002:a05:620a:414a:b0:7c0:6139:8f78 with SMTP id af79cd13be357-7c0613992d7mr686184785a.36.1739213031046;
        Mon, 10 Feb 2025 10:43:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c05ffeacbdsm139971285a.110.2025.02.10.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 10:43:50 -0800 (PST)
Date: Mon, 10 Feb 2025 13:43:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org
Message-ID: <67aa48e647f87_74092294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <0c86c0db795e1571143539ec7b3ea73d21f521a5.camel@iki.fi>
References: <cover.1739097311.git.pav@iki.fi>
 <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
 <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
 <0c86c0db795e1571143539ec7b3ea73d21f521a5.camel@iki.fi>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pauli Virtanen wrote:
> Hi,
> =

> su, 2025-02-09 kello 22:29 -0500, Willem de Bruijn kirjoitti:
> > Pauli Virtanen wrote:
> > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software times=
tamp
> > > when hardware reports a packet completed.
> > > =

> > > Completion tstamp is useful for Bluetooth, where hardware tx timest=
amps
> > > cannot be obtained except for ISO packets, and the hardware has a q=
ueue
> > > where packets may wait.  In this case the software SND timestamp on=
ly
> > > reflects the kernel-side part of the total latency (usually small) =
and
> > > queue length (usually 0 unless HW buffers congested), whereas the
> > > completion report time is more informative of the true latency.
> > > =

> > > It may also be useful in other cases where HW TX timestamps cannot =
be
> > > obtained and user wants to estimate an upper bound to when the TX
> > > probably happened.
> > =

> > Getting the completion timestamp may indeed be useful more broadly.
> > =

> > Alternatively, the HW timestamp is relatively imprecisely defined so
> > you could even just use that. Ideally, a hw timestamp conforms to IEE=
E
> > 1588v2 PHY: first symbol on the wire IIRC. But in many cases this is
> > not the case. It is not feasible at line rate, or the timestamp is
> > only taken when the completion is written over PCI, which may be
> > subject to PCI backpressure and happen after transmission on the wire=
.
> > As a result, the worst case hw tstamp must already be assumed not muc=
h
> > earlier than a completion timestamp.
> =

> For BT ISO packets, in theory hw-provided TX timestamps exist, and we
> might want both (with separate flags for enabling them).=C2=A0I don't r=
eally
> know, last I looked Intel HW didn't support them, and it's not clear to=

> which degree they are useful.

That's reason enough to separate these measurement types.

If we don't do it properly now, we won't be able to update drivers
later once users depend on requesting hw timestamps when they mean to
get completion timestamps.

> > That said, +1 on adding explicit well defined measurement point
> > instead.
> >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > >  include/linux/skbuff.h                    | 6 +++++-
> > >  include/uapi/linux/errqueue.h             | 1 +
> > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > >  net/ethtool/common.c                      | 1 +
> > >  net/socket.c                              | 3 +++
> > >  6 files changed, 23 insertions(+), 3 deletions(-)
> > > =

> > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > index 61ef9da10e28..de2afed7a516 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > >    cumulative acknowledgment. The mechanism ignores SACK and FACK.
> > >    This flag can be enabled via both socket options and control mes=
sages.
> > >  =

> > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > +  Request tx timestamps on packet tx completion.  The completion
> > > +  timestamp is generated by the kernel when it receives packet a
> > > +  completion report from the hardware. Hardware may report multipl=
e
> > > +  packets at once, and completion timestamps reflect the timing of=
 the
> > > +  report and not actual tx time. The completion timestamps are
> > > +  currently implemented only for: Bluetooth L2CAP and ISO.  This
> > > +  flag can be enabled via both socket options and control messages=
.
> > > +
> > =

> > Either we should support this uniformly, or it should be possible to
> > query whether a driver supports this.
> > =

> > Unfortunately all completion callbacks are driver specific.
> > =

> > But drivers that support hwtstamps will call skb_tstamp_tx with
> > nonzero hwtstamps. We could use that also to compute and queue
> > a completion timestamp if requested. At least for existing NIC
> > drivers.
> =

> Ok. If possible, I'd like to avoid changing the behavior of the non-
> Bluetooth parts of net/ here, as I'm not familiar with those.
> =

> I guess a simpler solution could be that sock_set_timestamping() checks=

> the type of the socket, and gives EINVAL if the flag is set for non-
> Bluetooth sockets?

Actually, I'd prefer to have this completion timestamp ability for all
drivers. And avoid creating subsystem private mechanisms.

I suppose we can punt on the get_ts_info control API if need be.
 =

> One could then postpone having to invent how to check the driver
> support, and user would know non-supported status from setsockopt
> failing.
> =

> > >  1.3.2 Timestamp Reporting
> > >  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index bb2b751d274a..3707c9075ae9 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -489,10 +489,14 @@ enum {
> > >  =

> > >  	/* generate software time stamp when entering packet scheduling *=
/
> > >  	SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > > +
> > > +	/* generate software time stamp on packet tx completion */
> > > +	SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
> > >  };
> > >  =

> > >  #define SKBTX_ANY_SW_TSTAMP	(SKBTX_SW_TSTAMP    | \
> > > -				 SKBTX_SCHED_TSTAMP)
> > > +				 SKBTX_SCHED_TSTAMP | \
> > > +				 SKBTX_COMPLETION_TSTAMP)
> > =

> > These fields are used in the skb_shared_info tx_flags field.
> > Which is a very scarce resource. This takes the last available bit.
> > That is my only possible concern: the opportunity cost.
> =

> If doing it=C2=A0per-protocol sounds ok, it could be put in bt_skb_cb
> instead.
> =

> Since the completion timestamp didn't already exist, it maybe means
> it's probably not that important for other parts of net/

I can see its value especially for hardware that does not support
hardware timestamps, or hw timestamps at line rate.

This gives a reasonable estimation of transmission time and
measure of device delay.

It is device specific whether it will be an over- or under-estimation,
depending on whether the completion is queued to the host after or
before the data is written on the wire. But either way, it will
include the delay in processing the tx queue, which on multi-queue
NICs and with TSO may be substantial (even before considering HW
rate limiting).

> > >  #define SKBTX_ANY_TSTAMP	(SKBTX_HW_TSTAMP | \
> > >  				 SKBTX_HW_TSTAMP_USE_CYCLES | \
> > >  				 SKBTX_ANY_SW_TSTAMP)
> > > diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/err=
queue.h
> > > index 3c70e8ac14b8..1ea47309d772 100644
> > > --- a/include/uapi/linux/errqueue.h
> > > +++ b/include/uapi/linux/errqueue.h
> > > @@ -73,6 +73,7 @@ enum {
> > >  	SCM_TSTAMP_SND,		/* driver passed skb to NIC, or HW */
> > >  	SCM_TSTAMP_SCHED,	/* data entered the packet scheduler */
> > >  	SCM_TSTAMP_ACK,		/* data acknowledged by peer */
> > > +	SCM_TSTAMP_COMPLETION,	/* packet tx completion */
> > >  };
> > >  =

> > >  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> > > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/n=
et_tstamp.h
> > > index 55b0ab51096c..383213de612a 100644
> > > --- a/include/uapi/linux/net_tstamp.h
> > > +++ b/include/uapi/linux/net_tstamp.h
> > > @@ -44,8 +44,9 @@ enum {
> > >  	SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> > >  	SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> > >  	SOF_TIMESTAMPING_OPT_RX_FILTER =3D (1 << 17),
> > > +	SOF_TIMESTAMPING_TX_COMPLETION =3D (1 << 18),
> > >  =

> > > -	SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_RX_FILTER,
> > > +	SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_TX_COMPLETION,
> > >  	SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
> > >  				 SOF_TIMESTAMPING_LAST
> > >  };
> > > @@ -58,7 +59,8 @@ enum {
> > >  #define SOF_TIMESTAMPING_TX_RECORD_MASK	(SOF_TIMESTAMPING_TX_HARDW=
ARE | \
> > >  					 SOF_TIMESTAMPING_TX_SOFTWARE | \
> > >  					 SOF_TIMESTAMPING_TX_SCHED | \
> > > -					 SOF_TIMESTAMPING_TX_ACK)
> > > +					 SOF_TIMESTAMPING_TX_ACK | \
> > > +					 SOF_TIMESTAMPING_TX_COMPLETION)
> > >  =

> > >  /**
> > >   * struct so_timestamping - SO_TIMESTAMPING parameter
> > > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > > index 2bd77c94f9f1..75e3b756012e 100644
> > > --- a/net/ethtool/common.c
> > > +++ b/net/ethtool/common.c
> > > @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING=
_LEN] =3D {
> > >  	[const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
> > >  	[const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",=

> > >  	[const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-filt=
er",
> > > +	[const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "completion-tra=
nsmit",
> > =

> > just "tx-completion"?
> =

> Ok.
> =

> -- =

> Pauli Virtanen



