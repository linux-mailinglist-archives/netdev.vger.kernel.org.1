Return-Path: <netdev+bounces-165338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7956A31B36
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A0A3A4C96
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C969339A1;
	Wed, 12 Feb 2025 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUpwbLP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA612AEE3;
	Wed, 12 Feb 2025 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739324010; cv=none; b=Gf11JNYULntg+ceg1EOs/aDqUOtpxeknrniTviFdrrIrCXTd9uAT/r4GXU+kD9JKmSP6Z6ywgr73QgQIg4m/pl8fHPBA86xR14lv0c/t4ZxKr3D9jtHnLS1nddCxKnUhlmURbk8EqMU7SuP9McFynh5TZs3iWsaBiIJBGX61BJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739324010; c=relaxed/simple;
	bh=bt+gsvDLxq5yFDAbBIctYDejdXEGvc9ZUACCqOiEUb0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cUAykrTL+cBfbWz/efN3dst/hsCMuGWgmcOQ5Phb/G5ve/s02ZrvZvP34Kr4X+xyY7jAxaxKPCvLwYozSTXZno2mN8BTi42EBWQp/TV6WoFp63BUdFBaWmm4baHU4g9x6GySmrCLri8Y+92G3537L97n7+4Vpopq4PnGP+Yyvrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUpwbLP2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4679eacf2c5so62923831cf.0;
        Tue, 11 Feb 2025 17:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739324007; x=1739928807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE3GA90GrW0w6tRwYGDghmrthDfVKU/PTEoSDpTx3LI=;
        b=HUpwbLP2qnkX4p1ghWkB18gGzSTNSILe3W2dXO9mLRh0r9vKYxHsJIhlcWTnQrII/V
         tRKWylaTm4l6z5aozdHD/Lizv7hd9JaA7UEqMUEKCfBfeHSLC8HwjfPZcKeKTR6+9rd6
         Wvvh2BkMUbc1joa32ATaJpqIWKQyBv6rcnIKXkMEbwfNUrASwhSHYB6xI1Nwnd9uBl3f
         h9XGT2+FqeJf6tJalfSPyVioN8gGRV152SAjyN8O3p0s6IiSbRKJQo8BvkcQtKcpoW+D
         yxWUjGuvUbUAYX15VSUsGJfJrXSQTnSQUQY1DQuXAGnsRCN+DdUyZowGLQAy09OBF+kx
         l9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739324007; x=1739928807;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tE3GA90GrW0w6tRwYGDghmrthDfVKU/PTEoSDpTx3LI=;
        b=rXQa/QIo1Nl4xhg+DJWYMqrAir2ofAU8wFcvO4vkgtnwUZVX75ocWnl8KUbgy8s2Ii
         WYVvFtHS307cB0XlwT4i/wFLntcGCGNF0LgW8YUwN8A5yIdBXnv2KCfjIZu1ewHB+YD7
         P+cLl3+vCTRedxK++fpf9maY3Rv4rVpQHdLdi/uz3kYd2cbmL1IQBUbbYLY2S3Kcgtwi
         M/Aq97sBu8YQUmaEhYE0LOO7VVFRXjqt8eG1y9Og/CgwhbRD/BhUzmMOjn8QyWq9Ltpb
         pqqyyEOl5jAbX0BXsSzzqMANwRy4l7L5oaS/8ZKJK43Ucsvp/MGiwAOtsq6IBbIwTXmd
         2kzA==
X-Forwarded-Encrypted: i=1; AJvYcCUvzYDijAKkRH/lzRffpvUJDslCzyaNJb8ookDUjs9V/BZWuh0Wcu2XWNCmOHX3WRROEXSEDNnHVrtfCvO6Pac=@vger.kernel.org, AJvYcCW7f9iwmGbxijWJYqG3gjyti32Pk/ewMa3GxuVuXfFKKN1VFC3VDfTaq3dIYonvID3wPYgyOm8y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oY3XMnCCXC6Ghbu6cshcoeNJCjjrcBmbjQ/tljDXTOfwqRAI
	BvUnc847kiRuhVUKGs79aTZV1hnrx2TtX3FpiC0DDVnRmzXWzhZmZTVtpg==
X-Gm-Gg: ASbGncvOtQ+xeVt73/6MM70cC+2/8TT3nHea4q5KtM8t4hB0jgSRKxByNH/P85YGaIO
	tfslj4p+fkqQ37dQRmsuB/6psYSYGjlf6A/sTMGvYObdswVJ51PUMxmZ5Cdt6jVa6/PE3Ktk634
	ZzvoCf5Sjubx6/02/3OlW0sS4JWsZQZCKKNof07Jw8MTZ3zXCaWO4DwJQjFHSq9MB8TOY5k7TAH
	IADPoqngeO/t9HrLim+MMIbQiX3Vq40fS+ZM48apn4E8yLJ8vpBmdLYUqsCYtzNyD1aIeMRhv9C
	KzHGfj4qsoyL4HBegVDVaYesrI5t2XbLKZIElQattIfAtNAMYCADqe+q9qHBPXg=
X-Google-Smtp-Source: AGHT+IG+bfzCvJjk9A6j0ujipKYo1yWj4wSoJmLekPiAvZd8cI3bWU37LxOZOatiXlqXaQ6Do2O2QQ==
X-Received: by 2002:a05:6214:b6a:b0:6e1:afcf:8748 with SMTP id 6a1803df08f44-6e46eda2de1mr27857346d6.19.1739324007269;
        Tue, 11 Feb 2025 17:33:27 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4564086ccsm45498346d6.17.2025.02.11.17.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 17:33:26 -0800 (PST)
Date: Tue, 11 Feb 2025 20:33:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org
Message-ID: <67abfa65cce76_155892294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABBYNZJvP6mZoE4L5XME=kDkDTKiFdX=36VXGDAfHyLi7tJKdw@mail.gmail.com>
References: <cover.1739097311.git.pav@iki.fi>
 <71b88f509237bcce4139c152b3f624d7532047fd.1739097311.git.pav@iki.fi>
 <67a972a6e2704_14761294b0@willemb.c.googlers.com.notmuch>
 <0c86c0db795e1571143539ec7b3ea73d21f521a5.camel@iki.fi>
 <67aa48e647f87_74092294e9@willemb.c.googlers.com.notmuch>
 <CABBYNZJvP6mZoE4L5XME=kDkDTKiFdX=36VXGDAfHyLi7tJKdw@mail.gmail.com>
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

Luiz Augusto von Dentz wrote:
> Hi Willem,
> =

> On Mon, Feb 10, 2025 at 1:43=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Pauli Virtanen wrote:
> > > Hi,
> > >
> > > su, 2025-02-09 kello 22:29 -0500, Willem de Bruijn kirjoitti:
> > > > Pauli Virtanen wrote:
> > > > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software t=
imestamp
> > > > > when hardware reports a packet completed.
> > > > >
> > > > > Completion tstamp is useful for Bluetooth, where hardware tx ti=
mestamps
> > > > > cannot be obtained except for ISO packets, and the hardware has=
 a queue
> > > > > where packets may wait.  In this case the software SND timestam=
p only
> > > > > reflects the kernel-side part of the total latency (usually sma=
ll) and
> > > > > queue length (usually 0 unless HW buffers congested), whereas t=
he
> > > > > completion report time is more informative of the true latency.=

> > > > >
> > > > > It may also be useful in other cases where HW TX timestamps can=
not be
> > > > > obtained and user wants to estimate an upper bound to when the =
TX
> > > > > probably happened.
> > > >
> > > > Getting the completion timestamp may indeed be useful more broadl=
y.
> > > >
> > > > Alternatively, the HW timestamp is relatively imprecisely defined=
 so
> > > > you could even just use that. Ideally, a hw timestamp conforms to=
 IEEE
> > > > 1588v2 PHY: first symbol on the wire IIRC. But in many cases this=
 is
> > > > not the case. It is not feasible at line rate, or the timestamp i=
s
> > > > only taken when the completion is written over PCI, which may be
> > > > subject to PCI backpressure and happen after transmission on the =
wire.
> > > > As a result, the worst case hw tstamp must already be assumed not=
 much
> > > > earlier than a completion timestamp.
> > >
> > > For BT ISO packets, in theory hw-provided TX timestamps exist, and =
we
> > > might want both (with separate flags for enabling them). I don't re=
ally
> > > know, last I looked Intel HW didn't support them, and it's not clea=
r to
> > > which degree they are useful.
> >
> > That's reason enough to separate these measurement types.
> >
> > If we don't do it properly now, we won't be able to update drivers
> > later once users depend on requesting hw timestamps when they mean to=

> > get completion timestamps.
> >
> > > > That said, +1 on adding explicit well defined measurement point
> > > > instead.
> > > >
> > > > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > > > ---
> > > > >  Documentation/networking/timestamping.rst | 9 +++++++++
> > > > >  include/linux/skbuff.h                    | 6 +++++-
> > > > >  include/uapi/linux/errqueue.h             | 1 +
> > > > >  include/uapi/linux/net_tstamp.h           | 6 ++++--
> > > > >  net/ethtool/common.c                      | 1 +
> > > > >  net/socket.c                              | 3 +++
> > > > >  6 files changed, 23 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/networking/timestamping.rst b/Docume=
ntation/networking/timestamping.rst
> > > > > index 61ef9da10e28..de2afed7a516 100644
> > > > > --- a/Documentation/networking/timestamping.rst
> > > > > +++ b/Documentation/networking/timestamping.rst
> > > > > @@ -140,6 +140,15 @@ SOF_TIMESTAMPING_TX_ACK:
> > > > >    cumulative acknowledgment. The mechanism ignores SACK and FA=
CK.
> > > > >    This flag can be enabled via both socket options and control=
 messages.
> > > > >
> > > > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > > > +  Request tx timestamps on packet tx completion.  The completi=
on
> > > > > +  timestamp is generated by the kernel when it receives packet=
 a
> > > > > +  completion report from the hardware. Hardware may report mul=
tiple
> > > > > +  packets at once, and completion timestamps reflect the timin=
g of the
> > > > > +  report and not actual tx time. The completion timestamps are=

> > > > > +  currently implemented only for: Bluetooth L2CAP and ISO.  Th=
is
> > > > > +  flag can be enabled via both socket options and control mess=
ages.
> > > > > +
> > > >
> > > > Either we should support this uniformly, or it should be possible=
 to
> > > > query whether a driver supports this.
> > > >
> > > > Unfortunately all completion callbacks are driver specific.
> > > >
> > > > But drivers that support hwtstamps will call skb_tstamp_tx with
> > > > nonzero hwtstamps. We could use that also to compute and queue
> > > > a completion timestamp if requested. At least for existing NIC
> > > > drivers.
> > >
> > > Ok. If possible, I'd like to avoid changing the behavior of the non=
-
> > > Bluetooth parts of net/ here, as I'm not familiar with those.
> > >
> > > I guess a simpler solution could be that sock_set_timestamping() ch=
ecks
> > > the type of the socket, and gives EINVAL if the flag is set for non=
-
> > > Bluetooth sockets?
> >
> > Actually, I'd prefer to have this completion timestamp ability for al=
l
> > drivers. And avoid creating subsystem private mechanisms.
> >
> > I suppose we can punt on the get_ts_info control API if need be.
> =

> I guess that it is reasonable if we don't have to do the work for
> drivers other than Bluetooth otherwise I'd say you are probably asking
> too much here,

I was mainly agreeing to Pauli's implementation in this series.
Not asking to do any work irrelevant to BT.

> also doesn't this land on the TSN space if one needs to
> tightly control timings? I suspect if this sort of change was not
> necessary for TSN then perhaps it wouldn't be of much value to try to
> generalize this.

I don't fully follow. But in general SO_TIMESTAMPING is not limited to
TSN.

> =

> > > One could then postpone having to invent how to check the driver
> > > support, and user would know non-supported status from setsockopt
> > > failing.
> > >
> > > > >  1.3.2 Timestamp Reporting
> > > > >  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > > index bb2b751d274a..3707c9075ae9 100644
> > > > > --- a/include/linux/skbuff.h
> > > > > +++ b/include/linux/skbuff.h
> > > > > @@ -489,10 +489,14 @@ enum {
> > > > >
> > > > >   /* generate software time stamp when entering packet scheduli=
ng */
> > > > >   SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > > > > +
> > > > > + /* generate software time stamp on packet tx completion */
> > > > > + SKBTX_COMPLETION_TSTAMP =3D 1 << 7,
> > > > >  };
> > > > >
> > > > >  #define SKBTX_ANY_SW_TSTAMP      (SKBTX_SW_TSTAMP    | \
> > > > > -                          SKBTX_SCHED_TSTAMP)
> > > > > +                          SKBTX_SCHED_TSTAMP | \
> > > > > +                          SKBTX_COMPLETION_TSTAMP)
> > > >
> > > > These fields are used in the skb_shared_info tx_flags field.
> > > > Which is a very scarce resource. This takes the last available bi=
t.
> > > > That is my only possible concern: the opportunity cost.
> > >
> > > If doing it per-protocol sounds ok, it could be put in bt_skb_cb
> > > instead.
> > >
> > > Since the completion timestamp didn't already exist, it maybe means=

> > > it's probably not that important for other parts of net/
> >
> > I can see its value especially for hardware that does not support
> > hardware timestamps, or hw timestamps at line rate.
> >
> > This gives a reasonable estimation of transmission time and
> > measure of device delay.
> >
> > It is device specific whether it will be an over- or under-estimation=
,
> > depending on whether the completion is queued to the host after or
> > before the data is written on the wire. But either way, it will
> > include the delay in processing the tx queue, which on multi-queue
> > NICs and with TSO may be substantial (even before considering HW
> > rate limiting).
> >
> > > > >  #define SKBTX_ANY_TSTAMP (SKBTX_HW_TSTAMP | \
> > > > >                            SKBTX_HW_TSTAMP_USE_CYCLES | \
> > > > >                            SKBTX_ANY_SW_TSTAMP)
> > > > > diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux=
/errqueue.h
> > > > > index 3c70e8ac14b8..1ea47309d772 100644
> > > > > --- a/include/uapi/linux/errqueue.h
> > > > > +++ b/include/uapi/linux/errqueue.h
> > > > > @@ -73,6 +73,7 @@ enum {
> > > > >   SCM_TSTAMP_SND,         /* driver passed skb to NIC, or HW */=

> > > > >   SCM_TSTAMP_SCHED,       /* data entered the packet scheduler =
*/
> > > > >   SCM_TSTAMP_ACK,         /* data acknowledged by peer */
> > > > > + SCM_TSTAMP_COMPLETION,  /* packet tx completion */
> > > > >  };
> > > > >
> > > > >  #endif /* _UAPI_LINUX_ERRQUEUE_H */
> > > > > diff --git a/include/uapi/linux/net_tstamp.h b/include/uapi/lin=
ux/net_tstamp.h
> > > > > index 55b0ab51096c..383213de612a 100644
> > > > > --- a/include/uapi/linux/net_tstamp.h
> > > > > +++ b/include/uapi/linux/net_tstamp.h
> > > > > @@ -44,8 +44,9 @@ enum {
> > > > >   SOF_TIMESTAMPING_BIND_PHC =3D (1 << 15),
> > > > >   SOF_TIMESTAMPING_OPT_ID_TCP =3D (1 << 16),
> > > > >   SOF_TIMESTAMPING_OPT_RX_FILTER =3D (1 << 17),
> > > > > + SOF_TIMESTAMPING_TX_COMPLETION =3D (1 << 18),
> > > > >
> > > > > - SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_OPT_RX_FILTER,
> > > > > + SOF_TIMESTAMPING_LAST =3D SOF_TIMESTAMPING_TX_COMPLETION,
> > > > >   SOF_TIMESTAMPING_MASK =3D (SOF_TIMESTAMPING_LAST - 1) |
> > > > >                            SOF_TIMESTAMPING_LAST
> > > > >  };
> > > > > @@ -58,7 +59,8 @@ enum {
> > > > >  #define SOF_TIMESTAMPING_TX_RECORD_MASK  (SOF_TIMESTAMPING_TX_=
HARDWARE | \
> > > > >                                    SOF_TIMESTAMPING_TX_SOFTWARE=
 | \
> > > > >                                    SOF_TIMESTAMPING_TX_SCHED | =
\
> > > > > -                                  SOF_TIMESTAMPING_TX_ACK)
> > > > > +                                  SOF_TIMESTAMPING_TX_ACK | \
> > > > > +                                  SOF_TIMESTAMPING_TX_COMPLETI=
ON)
> > > > >
> > > > >  /**
> > > > >   * struct so_timestamping - SO_TIMESTAMPING parameter
> > > > > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > > > > index 2bd77c94f9f1..75e3b756012e 100644
> > > > > --- a/net/ethtool/common.c
> > > > > +++ b/net/ethtool/common.c
> > > > > @@ -431,6 +431,7 @@ const char sof_timestamping_names[][ETH_GST=
RING_LEN] =3D {
> > > > >   [const_ilog2(SOF_TIMESTAMPING_BIND_PHC)]     =3D "bind-phc",
> > > > >   [const_ilog2(SOF_TIMESTAMPING_OPT_ID_TCP)]   =3D "option-id-t=
cp",
> > > > >   [const_ilog2(SOF_TIMESTAMPING_OPT_RX_FILTER)] =3D "option-rx-=
filter",
> > > > > + [const_ilog2(SOF_TIMESTAMPING_TX_COMPLETION)] =3D "completion=
-transmit",
> > > >
> > > > just "tx-completion"?
> > >
> > > Ok.
> > >
> > > --
> > > Pauli Virtanen
> >
> >
> =

> =

> -- =

> Luiz Augusto von Dentz



