Return-Path: <netdev+bounces-114889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F09448FA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA385B2313A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BA172BD0;
	Thu,  1 Aug 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCQ4Pi0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2E2AD25
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506788; cv=none; b=VK5iQvt3is4yfwwJjBGsyR/2wmZj4jlcz/XMoEwu66BVF3aPoPoi8YeOjvJKCC4l9DaYRmVpyeGtOpKk8wvgwhyAI1YcIKM4n/ngXqJT+bmdqy5odp8fDZVZrun/hS+5q+HLcEnbaG3tzDEHgINdKSH9QLMM9V2qo1bNw7M3uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506788; c=relaxed/simple;
	bh=78GCO7001p1Z4AdZN/L4EK09KQGIWs+65BAPHbj2Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSNRcLJViapX4IkGpNbLmL14xW6Zb0q4jMUazOWx2Zh0vJIgKrRZnbC9RLdWhwrs3eCWh3HItIaNy1fcGr7nmME7gEv14+ixfJTpO4af/W2eNWauOfnjcZaz2KfxU4oyyFwwCPxC8k1FF6QVpSHxDwj4pOY6B+wdePZ0pcstkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCQ4Pi0Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-427fc9834deso126015e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722506785; x=1723111585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucSuz2+BJ40EcFeojNsNUdZ6Hywb8x8i+wNMTVWW1kI=;
        b=fCQ4Pi0ZABfDOZglgqpmyF2bcACYdv0kBExMx9l9EdfMEJcl6EVaoyQwQrexeY46KZ
         j5sHflGr6JzIb2LmIA5eNWV2cTevx5uxMp1ouJ4VGm4zGe1ih96mvqzu+ZoZdYLFMFo6
         rw62AE1wjgBNL255UhDQ9bWfoyrc5V6/zB+U8l4LSJlciw+eUC4KqXSmdrIHwNnC9/nQ
         3Mr17qer9gLVpShX+tvEOLNAjqZiDBaL7qQIJfuOdZcIbZqDSmKGkXU9y2HVsjnD2fNb
         stvMJl1FFpegldx86aIY3qV1UqsMKJIwqPIqYEBytiBlm2Xm+GVTwf1WKrXK+YQCTUwO
         Pgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722506785; x=1723111585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucSuz2+BJ40EcFeojNsNUdZ6Hywb8x8i+wNMTVWW1kI=;
        b=I8DFZggsfoPqZVciesfChC4QvBe3v67VjqOrjcBs7CGZFmP1lAgoZ6IvkPIh08VqUR
         bKMM/gtBe/uwVHoD9/JqnkG4E73TZ941pPiCTdgm9r8d4LS+aHZUkBXdD6TI/Ur8sSCm
         FG6vDYjD7hSjxNINQsorD5kgLXJwZLHcUhLC4q1lT+F9/rRbCCjLAs+EY0l+QSyrTPCa
         Wv4iB3o20xRfcnoTh5jylvWSiSSLGU3+Kbx63USpI4KXnxcPUeImUGC547723YEXwG5x
         LvrgdFRSa0mbhXtXiRZ1HLga2K9DQl1AobArrZ2lKG8dsLFsLKk9tOuavlXwLAXfBxRv
         WJmg==
X-Forwarded-Encrypted: i=1; AJvYcCW+G+bxYkbmlKIPOYpfWJp1TnJVchgbAgoMf7Vndmmt5GLyrA8BVFsAxb/NQmps3NhFd71QqslDqRKFUgiqCDCbsxsaEWEn
X-Gm-Message-State: AOJu0YxJLssVhRAAPdoTomPQj9aMdvxf5LKLBHh2xn/XfgZH5TUupBu/
	MrFlCE25h+wyjzVuXvJglZQF2IxAiPkUS5aAzr4Ms0I7JIP18mZRj+num1WBhxMyEL+m28L7xFI
	DO6Af2XLPJ8AWoc3BC64b4Wj95sHEJk2V4VOL
X-Google-Smtp-Source: AGHT+IFTbyKtWlcvEUNTF5LcG833KbXubWcOZCxDv7mMNPxHbOxqlXRg3Dey3lTNrDiwTEA3adL+Tv/lIlPL+D4yj1I=
X-Received: by 2002:a05:600c:3c9c:b0:426:66fd:5fac with SMTP id
 5b1f17b1804b1-428e163921cmr762135e9.2.1722506784713; Thu, 01 Aug 2024
 03:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
 <20240731120955.23542-5-kerneljasonxing@gmail.com> <CANn89iJGco0f2RLBm4bW3QpRHwscwZhc287RX+mWA0Q_=hfTYA@mail.gmail.com>
 <CAL+tcoD5OK6usHhJUGLn0WogBxVDJV8HF209ZBkd=xNLP34SfQ@mail.gmail.com>
In-Reply-To: <CAL+tcoD5OK6usHhJUGLn0WogBxVDJV8HF209ZBkd=xNLP34SfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 1 Aug 2024 12:06:11 +0200
Message-ID: <CANn89i+wO+g=2UReRv1uFuQNBSKJBgjMEKAV8z2=7SipKsyEkw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Thu, Aug 1, 2024 at 2:56=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Introducing a new type TCP_STATE to handle some reset conditions
> > > appearing in RFC 793 due to its socket state. Actually, we can look
> > > into RFC 9293 which has no discrepancy about this part.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > V2
> > > Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@amazo=
n.com/
> > > 1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
> > > ---
> > >  include/net/rstreason.h | 6 ++++++
> > >  net/ipv4/tcp.c          | 4 ++--
> > >  net/ipv4/tcp_timer.c    | 2 +-
> > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > > index eef658da8952..bbf20d0bbde7 100644
> > > --- a/include/net/rstreason.h
> > > +++ b/include/net/rstreason.h
> > > @@ -20,6 +20,7 @@
> > >         FN(TCP_ABORT_ON_CLOSE)          \
> > >         FN(TCP_ABORT_ON_LINGER)         \
> > >         FN(TCP_ABORT_ON_MEMORY)         \
> > > +       FN(TCP_STATE)                   \
> > >         FN(MPTCP_RST_EUNSPEC)           \
> > >         FN(MPTCP_RST_EMPTCP)            \
> > >         FN(MPTCP_RST_ERESOURCE)         \
> > > @@ -102,6 +103,11 @@ enum sk_rst_reason {
> > >          * corresponding to LINUX_MIB_TCPABORTONMEMORY
> > >          */
> > >         SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> > > +       /**
> > > +        * @SK_RST_REASON_TCP_STATE: abort on tcp state
> > > +        * Please see RFC 9293 for all possible reset conditions
> > > +        */
> > > +       SK_RST_REASON_TCP_STATE,
> > >
> > >         /* Copy from include/uapi/linux/mptcp.h.
> > >          * These reset fields will not be changed since they adhere t=
o
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index fd928c447ce8..64a49cb714e1 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -3031,7 +3031,7 @@ int tcp_disconnect(struct sock *sk, int flags)
> > >                 /* The last check adjusts for discrepancy of Linux wr=
t. RFC
> > >                  * states
> > >                  */
> > > -               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_NO=
T_SPECIFIED);
> > > +               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_TC=
P_STATE);
> >
> > I disagree with this. tcp_disconnect() is initiated by the user.
> >
> > You are conflating two possible conditions :
> >
> > 1) tcp_need_reset(old_state)
>
> For this one, I can keep the TCP_STATE reason, right?

What does it mean ?

>
> > 2) (tp->snd_nxt !=3D tp->write_seq && (1 << old_state) & (TCPF_CLOSING =
|
> > TCPF_LAST_ACK)))
> >
>
> For this one, I wonder if I need to separate this condition with
> 'tcp_need_reset()' and put it into another 'else-if' branch?
> I decided to name it as 'CLOSE_WITH_DATA' because it can reflect that
> the write queue of the socket is not empty (at this time the user may
> think he has more data to send) but it stays in the active close
> state.
> How about it?

This is not CLOSE_WITH_DATA, but a disconnect() operation, initiated
by user space.
If we add RST reasons, can we please be careful about the chosen names ?

man connect

<quote>
       Some  protocol  sockets  (e.g., TCP sockets as well as datagram
sockets in the UNIX and Internet domains) may dissolve the association
by connecting to an address with the sa_family member of sockaddr set
to AF_UNSPEC; thereafter, the socket can be connected to another ad=E2=80=
=90
       dress.  (AF_UNSPEC is supported since Linux 2.2.)
</quote>

Very different from close()...

