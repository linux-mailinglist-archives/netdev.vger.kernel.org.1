Return-Path: <netdev+bounces-204190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C0CAF96CD
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C4B3A8A06
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5071E8331;
	Fri,  4 Jul 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrgRGaal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D51A0BDB;
	Fri,  4 Jul 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642987; cv=none; b=lK2LTjuGPkjWYccuKWJE3HVrtiYz6ptmb6bfrY0fxjEjkktKMSh3WrzguUs7YVTfJ9WsIfGYNzOKsCJCeXTacdN/re/EkC+6RJcAE6/FYDwcTdWpZ+dfmmB7vjdD/ENMr7aO+M2D/NfWRqyv8z+fdupv1zQhMQfMSrVcdGtKsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642987; c=relaxed/simple;
	bh=ZmGClX3pi39sLATEqq1V3liM+p870QCyKMMWLFy68KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj0ZaifIMoaq+JgK7FcrzmSgpJ+3lvgjgzTSrSr8B7NQHs+Cp9OR6GROlTM0uGeT0G1GP3EQ5ZyJDh1pxlkCEz0iL2i+eO7VCrHv3JyOKMy1erhe4a45tUoqacJ8TFF1fodMaveZ9LbNy/JCB3+KafJ7OliO65c8bvFIfw0JMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrgRGaal; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2f937370so3967565ab.3;
        Fri, 04 Jul 2025 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751642985; x=1752247785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJe5vGvBu85hc/W4WnrOg7w/kbOFVgGLIrSkIA646PY=;
        b=IrgRGaal84P5KMDnENAe+xrGyTzza5o0OIX9fZTCNEf7x8juQgL+dR3nBASb2uDaeI
         u0r0+W9bs6+Yj3Rfo4F8B6UkrBbeTSxgB/PwhGeb3nNSuAlri6l0NdcqMhYcl6x72qTS
         G1ocYnHoKv6WHlHHz8wprCTKsBKBdmUnLQJt/sm4ysZIrtPOOSkj90ATNTq9Dqy8Mz90
         hUYRVQYx7lw6MXmWc9S96IRa8gPNQRSaeN9OOUMbV6oljWFJZphb5AS7EeAr4BbBQq7d
         vNrD8BBWM/2bGL1fitFzdPeNWT7P4WXKktggzt4cFAHY8/2iYI+rg7arpgh5cw3dXbGH
         Lp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751642985; x=1752247785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJe5vGvBu85hc/W4WnrOg7w/kbOFVgGLIrSkIA646PY=;
        b=SHHCr6imsSao9RnTKsKXehRczBBiGcWO12lhN9taC+17r+BCAlo/r0Ja16GkylR4uz
         PBs2aW8wkTUijJSGFv9kto0WL15hta1OXypSC2xq7/m7Vv0fd1DMa6RrYZEpP13jpKUt
         DckpDUVrrwc/AKgCqH1HzjDPTe4s5PakEvwKLMBynyfJgJVXeemcymED9qQttcwYaJ4Y
         uby5Vib+bLC4WRLluvNZbhzGICoe70bUxv+/o8K49pMkyh6zDI0EIkmsyHfB0MJQND5z
         TQbau1YDlbFwJ2muBuKKodLuxb5+hptDLy2yQ3YvgEHYvOpuSe7XRZpb6XUzGz4ydB5s
         C65g==
X-Forwarded-Encrypted: i=1; AJvYcCU0ODr/UJ+5CvYeoloNSPWj55ZruO0nKcpetSDOKW4RVhSTVOr9PNqSuLlSLvUBFBz97WoKg+lGOJZxiCk=@vger.kernel.org, AJvYcCVgwT4+Y64pAYz43MVKNLXmPkjU3aQOYTJgsdkXRv3xEt5Uaud1w74jNqZmNe2Cz2jwxd0HzI48@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0g8rSQZtOXOy2sMiPSevHNh40OiApkMb6J1ga3uzUU1pOBL7
	ZinJSZY1xy62FNbkfhYHD6Plru/5jAg/qrf+Msnje3ZME4QUsASWn1svKio3e3yjLoHn5NWEMxZ
	ACkiZhxHvT0ywPWZicufkHkyIorklirWXhlvh
X-Gm-Gg: ASbGncuk5x802bYUg3F+S/4LNXOHllrSEnz97zp9ivJou8NxVdduPyo/C1EruLUaD1u
	R9350ENVuAkXWCY0DZggGdfSqSEi1S6yi73/zBHbicbbqnzi2KeSr8Jo6XmGHid8WG3HBlBRopr
	ogtgtVDWDZ7BuPBMlq886AXjbpNmS9Qq4NafNDxfj7SA==
X-Google-Smtp-Source: AGHT+IFnvRxRMFtAPy8NbJs68ZLxYQ9l52SIzZ17A9A4jOaodofC1i9bSlnn3z5Sr6fvyYtbPwCpRoyFBkiciIG44jE=
X-Received: by 2002:a05:6e02:1c06:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3e135576383mr23416355ab.14.1751642984636; Fri, 04 Jul 2025
 08:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>
 <aDnX3FVPZ3AIZDGg@mini-arch> <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
 <CAL+tcoAk3X2qM7gkeBw60hQ6VKd0Pv0jMtKaEB9uFw0DE=OY2A@mail.gmail.com> <aGfKRK2tcnf9WzNp@boxer>
In-Reply-To: <aGfKRK2tcnf9WzNp@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 4 Jul 2025 23:29:08 +0800
X-Gm-Features: Ac12FXw8ZbPvzkYZ5b09gw3GnpxOz1Cft1jdj2I23F0miMiSNqAKbjI1vsBkBDg
Message-ID: <CAL+tcoCAH+LN0HtL3wR3+Xw_GggMJS2JZwrKryuWo3f21YMVkA@mail.gmail.com>
Subject: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in __xsk_generic_xmit()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: e.kubanski@partner.samsung.com, Stanislav Fomichev <stfomichev@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 8:35=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jul 04, 2025 at 07:37:22AM +0800, Jason Xing wrote:
> > On Mon, Jun 2, 2025 at 5:28=E2=80=AFPM Eryk Kubanski
> > <e.kubanski@partner.samsung.com> wrote:
> > >
> > > > I'm not sure I understand what's the issue here. If you're using th=
e
> > > > same XSK from different CPUs, you should take care of the ordering
> > > > yourself on the userspace side?
> > >
> > > It's not a problem with user-space Completion Queue READER side.
> > > Im talking exclusively about kernel-space Completion Queue WRITE side=
.
> > >
> > > This problem can occur when multiple sockets are bound to the same
> > > umem, device, queue id. In this situation Completion Queue is shared.
> > > This means it can be accessed by multiple threads on kernel-side.
> > > Any use is indeed protected by spinlock, however any write sequence
> > > (Acquire write slot as writer, write to slot, submit write slot to re=
ader)
> > > isn't atomic in any way and it's possible to submit not-yet-sent pack=
et
> > > descriptors back to user-space as TX completed.
> > >
> > > Up untill now, all write-back operations had two phases, each phase
> > > locks the spinlock and unlocks it:
> > > 1) Acquire slot + Write descriptor (increase cached-writer by N + wri=
te values)
> > > 2) Submit slot to the reader (increase writer by N)
> > >
> > > Slot submission was solely based on the timing. Let's consider situat=
ion,
> > > where two different threads issue a syscall for two different AF_XDP =
sockets
> > > that are bound to the same umem, dev, queue-id.
> > >
> > > AF_XDP setup:
> > >
> > >                              kernel-space
> > >
> > >            Write   Read
> > >             +--+   +--+
> > >             |  |   |  |
> > >             |  |   |  |
> > >             |  |   |  |
> > >  Completion |  |   |  | Fill
> > >  Queue      |  |   |  | Queue
> > >             |  |   |  |
> > >             |  |   |  |
> > >             |  |   |  |
> > >             |  |   |  |
> > >             +--+   +--+
> > >             Read   Write
> > >                              user-space
> > >
> > >
> > >    +--------+         +--------+
> > >    | AF_XDP |         | AF_XDP |
> > >    +--------+         +--------+
> > >
> > >
> > >
> > >
> > >
> > > Possible out-of-order scenario:
> > >
> > >
> > >                               writer         cached_writer1          =
            cached_writer2
> > >                                  |                 |                 =
                  |
> > >                                  |                 |                 =
                  |
> > >                                  |                 |                 =
                  |
> > >                                  |                 |                 =
                  |
> > >                   +--------------|--------|--------|--------|--------=
|--------|--------|----------------------------------------------+
> > >                   |              |        |        |        |        =
|        |        |                                              |
> > >  Completion Queue |              |        |        |        |        =
|        |        |                                              |
> > >                   |              |        |        |        |        =
|        |        |                                              |
> > >                   +--------------|--------|--------|--------|--------=
|--------|--------|----------------------------------------------+
> > >                                  |                 |                 =
                  |
> > >                                  |                 |                 =
                  |
> > >                                  |-----------------|                 =
                  |
> > >                                   A) T1 syscall    |                 =
                  |
> > >                                   writes 2         |                 =
                  |
> > >                                   descriptors      |-----------------=
------------------|
> > >                                                     B) T2 syscall wri=
tes 4 descriptors
> > >
> >
> > Hi ALL,
> >
> > Since Maciej posted a related patch to fix this issue, it took me a
> > little while to trace back to this thread. So here we are.
> >
> > >                  Notes:
> > >                  1) T1 and T2 AF_XDP sockets are two different socket=
s,
> > >                     __xsk_generic_xmit will obtain two different mute=
xes.
> > >                  2) T1 and T2 can be executed simultaneously, there i=
s no
> > >                     critical section whatsoever between them.
> > >                  3) T1 and T2 will obtain Completion Queue Lock for a=
cquire + write,
> > >                     only slot acquire + write are under lock.
> > >                  4) T1 and T2 completion (skb destructor)
> > >                     doesn't need to be the same order as A) and B).
> > >                  5) What if T1 fails after T2 acquires slots?
> >
> > What does it mean by 'fails'. Could you point out the accurate
> > function you said?
> >
> > >                     cached_writer will be decreased by 2, T2 will
> > >                     submit failed descriptors of T1 (they shall be
> > >                     retransmitted in next TX).
> > >                     Submission of writer will move writer by 4 slots
> > >                     2 of these slots have failed T1 values. Last two
> > >                     slots of T2 will be missing, descriptor leak.
> >
> > I wonder why the leak problem happens? IIUC, in the
> > __xsk_generic_xmit() + copy mode, xsk only tries to send the
> > descriptor from its own tx ring to the driver, like virtio_net as an
> > example. As you said, there are two xsks running in parallel. Why
> > could T2 send the descriptors that T1 puts into the completion queue?
> > __dev_direct_xmit() only passes the @skb that is built based on the
> > addr from per xsk tx ring.
>
>  I admit it is non-trivial case.
>
> Per my understanding before, based on Eryk's example, if T1 failed xmit
> and reduced the cached_prod, T2 in its skb destructor would release two T=
1
> umem addresses and two T2 addrs instead of 4 T2 addrs.
>
> Putting this aside though, we had *correct* behavior before xsk
> multi-buffer support, we should not let that change make it into kernel i=
n
> the first place. Hence my motivation to restore it.$
>
> >
> > Here are some maps related to the process you talked about:
> > case 1)
> > // T1 writes 2 descs in cq
> > [--1--][--2--][-null-][-null-][-null-][-null-][-null-]
> >                       |
> >                       cached_prod
> >
> > // T1 fails because of NETDEV_TX_BUSY, and cq.cached_prod is decreased =
by 2.
> > [-null-][-null-][-null-][-null-][-null-][-null-][-null-]
> >      |
> >      cached_prod
> >
> > // T2 starts to write at the first unused descs
> > [--1--][--2--][--3--][--4--][-null-][-null-][-null-]
> >                                         |
> >                                         cached_prod
> > So why can T2 send out the descs belonging to T1? In
> > __xsk_generic_xmit(), xsk_cq_reserve_addr_locked() initialises the
> > addr of acquired desc so it overwrites the invalid one previously
> > owned by T1. The addr is from per xsk tx ring... I'm lost. Could you
> > please share the detailed/key functions to shed more lights on this?
> > Thanks in advance.
>
> Take another look at Eryk's example. The case he was providing was when t=
1
> produced smaller amount of addrs followed by t2 with bigger count. Then
> due to t1 failure, t2 was providing addrs produced by t1.
>
> Your example talks about immediate failure of t1 whereas Eryk talked
> about:
> 1. t1 produces addrs to cq
> 2. t2 produces addrs to cq
> 3. t2 starts xmit
> 4. t1 fails for some reason down in __xsk_generic_xmit()
> 4a. t1 reduces cached_prod
> 5. t2 completes, updates global state of cq's producer and exposing addrs
>    produced by t1 and misses part of addrs produced by t2

Wow, thanks for sharing your understanding on this. It's very clear
and easy to understand to me.

Thanks,
Jason

