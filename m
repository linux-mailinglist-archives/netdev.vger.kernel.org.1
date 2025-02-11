Return-Path: <netdev+bounces-165290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34932A317E8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FF1883A00
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293F2676FE;
	Tue, 11 Feb 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FneSO8zk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EB263F57;
	Tue, 11 Feb 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309693; cv=none; b=Hn/of9dl0ZOQ2beiPjUQTJGwTcfRdPWqCXgIvrsrCVu65Nd/k7lRIpIoPMA5oZFCBVROMHxH8uwfV51RQWDd0puTz8DeuqZx2Veiez+U6rb0vtE6I5oGm3hKQ0CGI8q3kfAfetGV/qzmJkEIapL/tiCXTpo0a5ZI5o6UuZ8kyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309693; c=relaxed/simple;
	bh=YVUvHiuf07Kq9Gp0lrjDGrczhf03O7jGZ8iWWswzAKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG3O78ryXv4BjGNv6c5uv4Tq8YnXXrvuNlC/MqCEtMvW5j1EuhgbyJOdH0JeA2hIYm17UEXAHmy7xtbDfWYhUHz1zYVzyRVLJJT92sN/micZT/BmT55xS918Zl3P9SDe0gCPIUkJpCc0OZrdfYSnFw5Sg6p8NgwJUD07UNtuk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FneSO8zk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30227c56b11so62719011fa.3;
        Tue, 11 Feb 2025 13:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739309689; x=1739914489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC9wZ13v5O/tYUI3QMvGTI8AuigNKAtjzyiIZ20urX4=;
        b=FneSO8zkYVdOduqpEoWw4bM08uw+JrJIrPu0x2mUj8yQRcgexVS+2/TDFFu1m4Zy0H
         ojV89DxJHlOzDeFyn+JEHd2929e5ciJs6Mi90PSF6sjAcq4KEh5BvgAn2NcYtm6NlYwv
         1IE1XtGoAMZOuEuzZXSXxjDQtnhPMG3Y/+YnqcjRddtqzJKvzeKeQu5zZuyt+SCnNSq+
         0kQ9lXSIfP8o8L61X7W0hFZCR452a/H2UCQ+hxfdVSTy1o4c3tWoAckkv62Y9lVfcu9N
         dO5VayqHQ/OsqVoWE2tM0u1Y41l8uTEjtyyNPNGGMYX+a7XqIx3TvTx2rJRXhBr023fJ
         yXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309689; x=1739914489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jC9wZ13v5O/tYUI3QMvGTI8AuigNKAtjzyiIZ20urX4=;
        b=FHtVfrrvsqucwOA4iZTQ+eNaRFGgotCjloVdmxYGy+2l7JwcSxhrk1f2hIEUOJ4BNe
         KA+sVLA+gPnDiwVAPm5AjJl8hZiUpJum9mFv6fJtdnfCzNxQxsokvKyBR/s7CSOMk5tC
         xlnix4XxtlwDOsMYwlMCEl+7FVao3EUZbLtiOcGnAHRvCMQwR7vj+GllnWOIDt4dlFrs
         nhLjCTGa8JIHsbPZkh4QRtB/o8yyeWCyb4JPS71qqxE4bS4Sjf6InptDQF5DUKWvz1yB
         HWa7G0oh359L9jgEN2Wt6RzXrGJwyVen5idwO2IgBLo95ynDX9ZHVRhgIObHhWwL80tk
         KpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf0xgfknowGBGXB8gLBHAz5d7ePp+MnxdI0gbttuCrZI1r49N//2ZMR0GR/gdoSHfu6rw1FAl6c8bNrVfj0Kw=@vger.kernel.org, AJvYcCX4ePM5bUy+8vmmL+2Mfv1914BVz4r3BAdAar7J+PDYeVQAjGrFLXPVvIEshsReXSYNq/Xrn/QK@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaU47t9m6MlU7Qa6X7oQoHZJm4WOZSE/lJXlSraGxzsLEC9NM
	pu0emajSG3Gs7Wn36KFe1Sn3rYoSnsdWImwmL3sWbcXQpg/1HIW6uHY3WNdJNwg4hIRjNNdq7Gn
	OH2N/Uy9H0sC0T0WmhJzd+V6nNgY+s5Ab
X-Gm-Gg: ASbGnctzWRomGV+mLBg3tgaIrbgQRTKO5pytI1W+FQCO8sIqMXtppfeeIcD8v3mmQGa
	L95KTFL2feYJyBGWxNr1jlW0qedSbZAkRzdcCZX+iIlH3pc8p4GpxEBdk2DM6GdAiTy1bPcSOog
	==
X-Google-Smtp-Source: AGHT+IFnEa97sObH7CoqXAFSJ2ieiEVx90TWK1UaeQtnOMWUdSswIb+4UbsBoXWXPuEZpafHRLmxP+fBDhtoHdxlpV0=
X-Received: by 2002:a05:651c:1508:b0:302:1861:6df8 with SMTP id
 38308e7fff4ca-309050bd85bmr675611fa.33.1739309688718; Tue, 11 Feb 2025
 13:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739097311.git.pav@iki.fi> <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
 <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch> <0c86c0db795e1571143539ec7b3ea73d21f521a5.camel@iki.fi>
 <67aa48e647f87_74092294e9@willemb.c.googlers.com.notmuch>
In-Reply-To: <67aa48e647f87_74092294e9@willemb.c.googlers.com.notmuch>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Feb 2025 16:34:36 -0500
X-Gm-Features: AWEUYZmZogBpnqJdKeXT1TJtUI0VPDX1Zs2V-vWheWsi2PIabs-0mY3C8eNlk1I
Message-ID: <CABBYNZJvP6mZoE4L5XME=kDkDTKiFdX=36VXGDAfHyLi7tJKdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] net-timestamp: COMPLETION timestamp on packet tx completion
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willem,

On Mon, Feb 10, 2025 at 1:43=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Pauli Virtanen wrote:
> > Hi,
> >
> > su, 2025-02-09 kello 22:29 -0500, Willem de Bruijn kirjoitti:
> > > Pauli Virtanen wrote:
> > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software times=
tamp
> > > > when hardware reports a packet completed.
> > > >
> > > > Completion tstamp is useful for Bluetooth, where hardware tx timest=
amps
> > > > cannot be obtained except for ISO packets, and the hardware has a q=
ueue
> > > > where packets may wait.  In this case the software SND timestamp on=
ly
> > > > reflects the kernel-side part of the total latency (usually small) =
and
> > > > queue length (usually 0 unless HW buffers congested), whereas the
> > > > completion report time is more informative of the true latency.
> > > >
> > > > It may also be useful in other cases where HW TX timestamps cannot =
be
> > > > obtained and user wants to estimate an upper bound to when the TX
> > > > probably happened.
> > >
> > > Getting the completion timestamp may indeed be useful more broadly.
> > >
> > > Alternatively, the HW timestamp is relatively imprecisely defined so
> > > you could even just use that. Ideally, a hw timestamp conforms to IEE=
E
> > > 1588v2 PHY: first symbol on the wire IIRC. But in many cases this is
> > > not the case. It is not feasible at line rate, or the timestamp is
> > > only taken when the completion is written over PCI, which may be
> > > subject to PCI backpressure and happen after transmission on the wire=
.
> > > As a result, the worst case hw tstamp must already be assumed not muc=
h
> > > earlier than a completion timestamp.
> >
> > For BT ISO packets, in theory hw-provided TX timestamps exist, and we
> > might want both (with separate flags for enabling them). I don't really
> > know, last I looked Intel HW didn't support them, and it's not clear to
> > which degree they are useful.
>
> That's reason enough to separate these measurement types.
>
> If we don't do it properly now, we won't be able to update drivers
> later once users depend on requesting hw timestamps when they mean to
> get completion timestamps.
>
> > > That said, +1 on adding explicit well defined measurement point
> > > instead.
> > >
> > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > ---
> > > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > > >  include/linux/skbuff.h                    | 6 +++++-
> > > >  include/uapi/linux/errqueue.h             | 1 +
> > > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > >  net/ethtool/common.c                      | 1 +
> > > >  net/socket.c                              | 3 +++
> > > >  6 files changed, 23 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > > index 61ef9da10e28..de2afed7a516 100644
> > > > --- a/Documentation/networking/timestamping.rst
> > > > +++ b/Documentation/networking/timestamping.rst
> > > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > > >    cumulative acknowledgment. The mechanism ignores SACK and FACK.
> > > >    This flag can be enabled via both socket options and control mes=
sages.
> > > >
> > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > +  Request tx timestamps on packet tx completion.  The completion
> > > > +  timestamp is generated by the kernel when it receives packet a
> > > > +  completion report from the hardware. Hardware may report multipl=
e
> > > > +  packets at once, and completion timestamps reflect the timing of=
 the
> > > > +  report and not actual tx time. The completion timestamps are
> > > > +  currently implemented only for: Bluetooth L2CAP and ISO.  This
> > > > +  flag can be enabled via both socket options and control messages=
.
> > > > +
> > >
> > > Either we should support this uniformly, or it should be possible to
> > > query whether a driver supports this.
> > >
> > > Unfortunately all completion callbacks are driver specific.
> > >
> > > But drivers that support hwtstamps will call skb_tstamp_tx with
> > > nonzero hwtstamps. We could use that also to compute and queue
> > > a completion timestamp if requested. At least for existing NIC
> > > drivers.
> >
> > Ok. If possible, I'd like to avoid changing the behavior of the non-
> > Bluetooth parts of net/ here, as I'm not familiar with those.
> >
> > I guess a simpler solution could be that sock_set_timestamping() checks
> > the type of the socket, and gives EINVAL if the flag is set for non-
> > Bluetooth sockets?
>
> Actually, I'd prefer to have this completion timestamp ability for all
> drivers. And avoid creating subsystem private mechanisms.
>
> I suppose we can punt on the get_ts_info control API if need be.

I guess that it is reasonable if we don't have to do the work for
drivers other than Bluetooth otherwise I'd say you are probably asking
too much here, also doesn't this land on the TSN space if one needs to
tightly control timings? I suspect if this sort of change was not
necessary for TSN then perhaps it wouldn't be of much value to try to
generalize this.

> > One could then postpone having to invent how to check the driver
> > support, and user would know non-supported status from setsockopt
> > failing.
> >
> > > >  1.3.2 Timestamp Reporting
> > > >  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > index bb2b751d274a..3707c9075ae9 100644
> > > > --- a/include/linux/skbuff.h
> > > > +++ b/include/linux/skbuff.h
> > > > @@ -489,10 +489,14 @@ enum {
> > > >
> > > >   /* generate software time stamp when entering packet scheduling *=
/
> > > >   SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > > > +
> > > > + /* generate software time stamp on packet tx completion */
> > > > + SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
> > > >  };
> > > >
> > > >  #define SKBTX_ANY_SW_TSTAMP      (SKBTX_SW_TSTAMP    | \
> > > > -                          SKBTX_SCHED_TSTAMP)
> > > > +                          SKBTX_SCHED_TSTAMP | \
> > > > +                          SKBTX_COMPLETION_TSTAMP)
> > >
> > > These fields are used in the skb_shared_info tx_flags field.
> > > Which is a very scarce resource. This takes the last available bit.
> > > That is my only possible concern: the opportunity cost.
> >
> > If doing it per-protocol sounds ok, it could be put in bt_skb_cb
> > instead.
> >
> > Since the completion timestamp didn't already exist, it maybe means
> > it's probably not that important for other parts of net/
>
> I can see its value especially for hardware that does not support
> hardware timestamps, or hw timestamps at line rate.
>
> This gives a reasonable estimation of transmission time and
> measure of device delay.
>
> It is device specific whether it will be an over- or under-estimation,
> depending on whether the completion is queued to the host after or
> before the data is written on the wire. But either way, it will
> include the delay in processing the tx queue, which on multi-queue
> NICs and with TSO may be substantial (even before considering HW
> rate limiting).
>
> > > >  #define SKBTX_ANY_TSTAMP (SKBTX_HW_TSTAMP | \
> > > >                            SKBTX_HW_TSTAMP_USE_CYCLES | \
> > > >                            SKBTX_ANY_SW_TSTAMP)
> > > > diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/err=
queue.h
> > > > index 3c70e8ac14b8..1ea47309d772 100644
> > > > --- a/include/uapi/linux/errqueue.h
> > > > +++ b/include/uapi/linux/errqueue.h
> > > > @@ -73,6 +73,7 @@ enum {
> > > >   SCM_TSTAMP_SND,         /* driver passed skb to NIC, or HW */
> > > >   SCM_TSTAMP_SCHED,       /* data entered the packet scheduler */
> > > >   SCM_TSTAMP_ACK,         /* data acknowledged by peer */
> > > > + SCM_TSTAMP_COMPLETION,  /* packet tx completion */
> > > >  };
> > > >
> > > >  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> > > > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/linux/n=
et_tstamp.h
> > > > index 55b0ab51096c..383213de612a 100644
> > > > --- a/include/uapi/linux/net_tstamp.h
> > > > +++ b/include/uapi/linux/net_tstamp.h
> > > > @@ -44,8 +44,9 @@ enum {
> > > >   SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> > > >   SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> > > >   SOF_TIMESTAMPING_OPT_RX_FILTER =3D (1 << 17),
> > > > + SOF_TIMESTAMPING_TX_COMPLETION =3D (1 << 18),
> > > >
> > > > - SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_RX_FILTER,
> > > > + SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_TX_COMPLETION,
> > > >   SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
> > > >                            SOF_TIMESTAMPING_LAST
> > > >  };
> > > > @@ -58,7 +59,8 @@ enum {
> > > >  #define SOF_TIMESTAMPING_TX_RECORD_MASK  (SOF_TIMESTAMPING_TX_HARD=
WARE | \
> > > >                                    SOF_TIMESTAMPING_TX_SOFTWARE | \
> > > >                                    SOF_TIMESTAMPING_TX_SCHED | \
> > > > -                                  SOF_TIMESTAMPING_TX_ACK)
> > > > +                                  SOF_TIMESTAMPING_TX_ACK | \
> > > > +                                  SOF_TIMESTAMPING_TX_COMPLETION)
> > > >
> > > >  /**
> > > >   * struct so_timestamping - SO_TIMESTAMPING parameter
> > > > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > > > index 2bd77c94f9f1..75e3b756012e 100644
> > > > --- a/net/ethtool/common.c
> > > > +++ b/net/ethtool/common.c
> > > > @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GSTRING=
_LEN] =3D {
> > > >   [const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
> > > >   [const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-tcp",
> > > >   [const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-filt=
er",
> > > > + [const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "completion-tra=
nsmit",
> > >
> > > just "tx-completion"?
> >
> > Ok.
> >
> > --
> > Pauli Virtanen
>
>


--=20
Luiz Augusto von Dentz

