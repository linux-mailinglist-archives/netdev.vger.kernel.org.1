Return-Path: <netdev+bounces-114892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F0D944941
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066321F22ED1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1805170A2C;
	Thu,  1 Aug 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVU4Nyju"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE2216F0C6
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507881; cv=none; b=Jqf4c1QZXAVWIPb6f+EWB7k4E9E2RBHZQOrjtprsDU+S92TMGIVvQP5N8PuxoKk9IJ8T82Wc0vd3U1c7f/f8+mCAKa02kGy0BeBjcKuF5IRe+O1lGnma0+1KeXPInUmaNOZDL+TUKdXbdO4QrEG7o1LZjEXncJmHJfd5B8NqUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507881; c=relaxed/simple;
	bh=eoczUhjvKaebHrhTOzNxLQHK7+yF/DYV+WF54o+LF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh0pJm3SmcFexCnm/Eh2M4WV2zIaG1LySldkGgsg7HIDKo3iU01mLEqU8PDBXCFqggHPLz2bnNNR1JvoSZOkBeYVIlA33rXNUUeABZbRnj8qIZFh5pq2MQ1hgwaviFX3u4Ad9MGYDCmn+xXhJuikBznMtBPy+dNipGLN0y6GNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVU4Nyju; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so312207a12.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722507878; x=1723112678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4s+e3Vln63+Feo3Cd8w3f1WuBICejnKkcOl/8lFuL8=;
        b=bVU4Nyju4A1BiDum+/AUvj0mNCuGCmCnC1YcQsL+xLw7s4sWxLQDa/45o96dRVuqqt
         V1jW5Dr/Xj++HugfRAksf/FUUyaYXt4n3TUEeFor3Nh0Q70hcLtcS2hnYAkVPCHbCkHe
         WTbFNamr5pqfdHueTBcpe7/VGc6bZdTgejy1ntc6c/ODU17dz/N99vc0JxrePZX9I6xB
         pPiyS040dk4R7DO45iSui+vDqdUDjdEUMzYYJ+FSzf9GLhN8iSYkNzmb4DxZR+vR9QGv
         26UmO4nJTC/ZFE3Ceh0FGNZhCYMN3IlNR5OgN18EWpwVEfpu6o92lAXPqtgUXOL6ABcW
         +CFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507878; x=1723112678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4s+e3Vln63+Feo3Cd8w3f1WuBICejnKkcOl/8lFuL8=;
        b=GYIx2fb8Nwn0Q5igZzQonJ7nrl1bAnJ9DeHWdZdNosBoPwQ91QjtGINy7sEuEIM3hf
         4FYYUqSqTOxkfJy2CazWnsieoS6KncAD7kAipxaWfnPe7dteInPd5sAh4ROEMpc3wEzw
         v+Qwm3B5MaAhV+3sD6CP7Ei63a4g4kxJ0cY2EqNsf9GCwgXR0nrERDW+WwUY53+v70tS
         QEoA5Bg9IondWS5zENjaWpl4U4toQ4Ikvf72Ix4JGpgrg4pt2RF9voYY/yYx+jfLqlxF
         U+RKmUlZXFUXtuVRioLYJ8H9/dR6vPYsxpczrWV6fUMAVtpy6MCkMhhbhxj5NAmwfm63
         l4bg==
X-Forwarded-Encrypted: i=1; AJvYcCU5T03dOMOZ662ZpGptX+MtcGeB1LkOyDwYu0nYK9d2vx5PTOnK8EifIhsPfPpnqa3Dt9VdggGSYBILCUCDanTMgQ+Fcd3z
X-Gm-Message-State: AOJu0YxVgtRkNTKRz/2IANrIFuB4e9sjJhS9/ffvOoRn99MU8XgyFGxF
	AIGqujZRwlwy2bvsPEivKLpRQxbBdcW1e92kf8LayujsfWV6xqIZkL+AxBZUMR6lppZoXO0GkOV
	ODuuD4FZyI/C95FQozoc9C4hFRm8=
X-Google-Smtp-Source: AGHT+IGnI12gHtQV0/7MoC47U94008Pg5Xxa1bDhXLH/1RjsgUWk6qi/Q5BfEM2Zt8u2hn2XgAeob0Nvc1sNcztNBvU=
X-Received: by 2002:a50:ed95:0:b0:5a2:2fa5:f146 with SMTP id
 4fb4d7f45d1cf-5b7003d20d9mr1057733a12.28.1722507878024; Thu, 01 Aug 2024
 03:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731120955.23542-1-kerneljasonxing@gmail.com>
 <20240731120955.23542-5-kerneljasonxing@gmail.com> <CANn89iJGco0f2RLBm4bW3QpRHwscwZhc287RX+mWA0Q_=hfTYA@mail.gmail.com>
 <CAL+tcoD5OK6usHhJUGLn0WogBxVDJV8HF209ZBkd=xNLP34SfQ@mail.gmail.com> <CANn89i+wO+g=2UReRv1uFuQNBSKJBgjMEKAV8z2=7SipKsyEkw@mail.gmail.com>
In-Reply-To: <CANn89i+wO+g=2UReRv1uFuQNBSKJBgjMEKAV8z2=7SipKsyEkw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 1 Aug 2024 18:24:00 +0800
Message-ID: <CAL+tcoAaQtNdD_9=CSqRPbEPBZ7jB47BPOm66skjF28Rh_ZrAA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/6] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Thu, Aug 1, 2024 at 6:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Aug 1, 2024 at 11:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Thu, Aug 1, 2024 at 2:56=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 2:10=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Introducing a new type TCP_STATE to handle some reset conditions
> > > > appearing in RFC 793 due to its socket state. Actually, we can look
> > > > into RFC 9293 which has no discrepancy about this part.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > V2
> > > > Link: https://lore.kernel.org/all/20240730200633.93761-1-kuniyu@ama=
zon.com/
> > > > 1. use RFC 9293 instead of RFC 793 which is too old (Kuniyuki)
> > > > ---
> > > >  include/net/rstreason.h | 6 ++++++
> > > >  net/ipv4/tcp.c          | 4 ++--
> > > >  net/ipv4/tcp_timer.c    | 2 +-
> > > >  3 files changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> > > > index eef658da8952..bbf20d0bbde7 100644
> > > > --- a/include/net/rstreason.h
> > > > +++ b/include/net/rstreason.h
> > > > @@ -20,6 +20,7 @@
> > > >         FN(TCP_ABORT_ON_CLOSE)          \
> > > >         FN(TCP_ABORT_ON_LINGER)         \
> > > >         FN(TCP_ABORT_ON_MEMORY)         \
> > > > +       FN(TCP_STATE)                   \
> > > >         FN(MPTCP_RST_EUNSPEC)           \
> > > >         FN(MPTCP_RST_EMPTCP)            \
> > > >         FN(MPTCP_RST_ERESOURCE)         \
> > > > @@ -102,6 +103,11 @@ enum sk_rst_reason {
> > > >          * corresponding to LINUX_MIB_TCPABORTONMEMORY
> > > >          */
> > > >         SK_RST_REASON_TCP_ABORT_ON_MEMORY,
> > > > +       /**
> > > > +        * @SK_RST_REASON_TCP_STATE: abort on tcp state
> > > > +        * Please see RFC 9293 for all possible reset conditions
> > > > +        */
> > > > +       SK_RST_REASON_TCP_STATE,
> > > >
> > > >         /* Copy from include/uapi/linux/mptcp.h.
> > > >          * These reset fields will not be changed since they adhere=
 to
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index fd928c447ce8..64a49cb714e1 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -3031,7 +3031,7 @@ int tcp_disconnect(struct sock *sk, int flags=
)
> > > >                 /* The last check adjusts for discrepancy of Linux =
wrt. RFC
> > > >                  * states
> > > >                  */
> > > > -               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_=
NOT_SPECIFIED);
> > > > +               tcp_send_active_reset(sk, gfp_any(), SK_RST_REASON_=
TCP_STATE);
> > >
> > > I disagree with this. tcp_disconnect() is initiated by the user.
> > >
> > > You are conflating two possible conditions :
> > >
> > > 1) tcp_need_reset(old_state)
> >
> > For this one, I can keep the TCP_STATE reason, right?
>
> What does it mean ?

I mean I wonder if I can use the TCP_STATE reason in tcp_abort() and
tcp_disconnect() when tcp_need_reset() returns true?

>
> >
> > > 2) (tp->snd_nxt !=3D tp->write_seq && (1 << old_state) & (TCPF_CLOSIN=
G |
> > > TCPF_LAST_ACK)))
> > >
> >
> > For this one, I wonder if I need to separate this condition with
> > 'tcp_need_reset()' and put it into another 'else-if' branch?
> > I decided to name it as 'CLOSE_WITH_DATA' because it can reflect that
> > the write queue of the socket is not empty (at this time the user may
> > think he has more data to send) but it stays in the active close
> > state.
> > How about it?
>
> This is not CLOSE_WITH_DATA, but a disconnect() operation, initiated
> by user space.
> If we add RST reasons, can we please be careful about the chosen names ?

Yes, I know, but like old days, I'm struggling with the English name. Sorry=
.

>
> man connect
>
> <quote>
>        Some  protocol  sockets  (e.g., TCP sockets as well as datagram
> sockets in the UNIX and Internet domains) may dissolve the association
> by connecting to an address with the sa_family member of sockaddr set
> to AF_UNSPEC; thereafter, the socket can be connected to another ad=E2=80=
=90
>        dress.  (AF_UNSPEC is supported since Linux 2.2.)
> </quote>
>
> Very different from close()...

Oh, I see. What I was talking about 'CLOSE' is the socket state, but
you are right: the name will finally be displayed to users, which must
clearly reflect the real meaning of the underlying behavior.

I will use "TCP_DISCONNECT_WITH_DATA" instead under this condition.
And then, I will put it into a new patch since it's a different reason
name.

Thanks for your help!

Jason

