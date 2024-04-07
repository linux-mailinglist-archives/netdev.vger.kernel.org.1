Return-Path: <netdev+bounces-85480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E689889AEEC
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 08:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBBD282059
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F9D6FC3;
	Sun,  7 Apr 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxzwPAJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFBB63B8
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472754; cv=none; b=ayFTX7COLNR1aiiEKxfvtuizcS5FafxhKs6NHLdND+Mne6CINYnObs5BGLkzk4coL9bbOrLRBYeoV8k850PHx9Y5i9iCyO3OPxlG5nnV0dRFzb4iDwjyTp8C0HCUKuc/wU1ebFJIrTkoR6wp4Ls/Jo4O5JdpnQiLbc7beA2zs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472754; c=relaxed/simple;
	bh=NfGut4SkVRroqbQufJ3dllJjWQO2VYkxAWgwWRKpuYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl1KJ2WY/x40aJx66AoMk4Ig+LpUpbc5V+pyp/vxRZuaAUl8oJcKLJpzVwmoZ2Vt9C/uPn2ZQrbpHqgirxgaZ6LbS4ka5ioOveF/y47bE+S/LdHgKryTvBmBTRX8O087+fxjqpUQxkfIt/ssg8Y3taBg29TYJZ5CCEDqKwhjNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxzwPAJV; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d718efedb2so61148521fa.0
        for <netdev@vger.kernel.org>; Sat, 06 Apr 2024 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712472751; x=1713077551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAyXqvt9U8fHKk0W6h9uw+yrsIp/DxsfeA5YNrlsGVw=;
        b=bxzwPAJVTuu/jfRCfSuouQNuWfeBCk5eP6Nq8pSwsVXssdnyjUB2BVUmVIshB2qYQt
         aneNM5ysMDSSodQbecdYHgaEFAu1RRKLHg9htfhab6M4dKYL+P0znkkfwPh3lxBUTCDT
         z8xGTAdWa/WoJdXTNRltZRy9v+uV3kpe+OGvWDsJwz4YQFPZG07z7ieYt+QK6+KuZod4
         bw/uhZgv3fYVgu8SLIzEaO3Q6fdVxD1UeKxVi/K/zFlpv0M+cwb0CGC84QFMS4eXDQj+
         i7yEBVnlSP28twYue/jc+sJ577r+YRpyXAfSl9pUp1QcC7AXfP1FWS8N/xis9h56rsqJ
         nFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712472751; x=1713077551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAyXqvt9U8fHKk0W6h9uw+yrsIp/DxsfeA5YNrlsGVw=;
        b=f1R9+qPgCR+cz9cHWvAyC5CIedjeSfjoutyVCeaiW6tVaNpvFVtmiXFYO2O8+P3X/v
         UA3mpamneAYAvaTvDnmW1/32y1AxxjPBIeNyhj971hiesqZzD/+gWh/HCrC/PYIPm8AK
         XG/gWOWPIvEzTEkgWzZZ8iBsG5eUzEL3/MXvywnBsiwN8sr48KFVGmIUoRz2E5q99+XQ
         kTKHty7+llMCCWkGiWiNQmXwpR8HNobqzRlxpyEXcn+BFT9b0ym/Des+efkIgW+ZLGJw
         HqzURbB/kSJaidbDb9cC5kv116I8bY7gzb7wwLFD84h7cIAdRgyj1v/cZC4qqtTwu7e/
         Kz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRpmUd/Kuvc0WJaxB4tOYiOIAgBPkPjjvvDau+XwgnCX04XKDHnBVY/1TVNV2ASG1BlW7bC6LrmFXmaIUMkcShdUpJEMgs
X-Gm-Message-State: AOJu0YyKKxuAUCXM8Ji8cYQR9wR71htnewjjrfhfxI/RDcHebZbQOnwZ
	Swsp1JShJxTZ9foywsSsoCoK4KYTjJ5AUcgJHs+kYLb3bbmKCGk4Zyh5f6fPlICJiql9jCigilc
	tMfoZXMYlFoj+ShCRYdtpr7LvSbw=
X-Google-Smtp-Source: AGHT+IEJ996UMY19e4Z8jgo/X/gDlHqevvLbWrco9JNElM8yycbUya6s5V0k+yRgnnZPZHbmv6z/dOXf4YtXlZc0VXo=
X-Received: by 2002:a2e:b162:0:b0:2d8:75df:6163 with SMTP id
 a2-20020a2eb162000000b002d875df6163mr2727438ljm.17.1712472750366; Sat, 06 Apr
 2024 23:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406182107.261472-1-jmaloy@redhat.com> <20240406182107.261472-3-jmaloy@redhat.com>
 <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
In-Reply-To: <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 7 Apr 2024 14:51:53 +0800
Message-ID: <CAL+tcoC8LBQGe7ES01bxKFkU15GoFpEgT5jx1tnwb2Yb_BOKfw@mail.gmail.com>
Subject: Re: [net-next 2/2] tcp: correct handling of extreme menory squeeze
To: Eric Dumazet <edumazet@google.com>
Cc: jmaloy@redhat.com, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, menglong8.dong@gmail.com, 
	dongmenglong.8@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 2:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Sat, Apr 6, 2024 at 8:21=E2=80=AFPM <jmaloy@redhat.com> wrote:
> >
> > From: Jon Maloy <jmaloy@redhat.com>
> >
> > Testing of the previous commit ("tcp: add support for SO_PEEK_OFF")
> > in this series along with the pasta protocol splicer revealed a bug in
> > the way tcp handles window advertising during extreme memory squeeze
> > situations.
> >
> > The excerpt of the below logging session shows what is happeing:
> >
> > [5201<->54494]:     =3D=3D=3D=3D Activating log @ tcp_select_window()/2=
68 =3D=3D=3D=3D
> > [5201<->54494]:     (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) -=
-> TRUE
> > [5201<->54494]:   tcp_select_window(<-) tp->rcv_wup: 2812454294, tp->rc=
v_wnd: 5812224, tp->rcv_nxt 2818016354, returning 0
> > [5201<->54494]:   ADVERTISING WINDOW SIZE 0
> > [5201<->54494]: __tcp_transmit_skb(<-) tp->rcv_wup: 2812454294, tp->rcv=
_wnd: 5812224, tp->rcv_nxt 2818016354
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window n=
ow: 250164, qlen: 83
> >
> > [...]
>
> I would prefer a packetdrill test, it is not clear what is happening...
>
> In particular, have you used SO_RCVBUF ?
>
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window n=
ow: 250164, qlen: 1
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     (win_now: 250164, new_win: 262144 >=3D (2 * win_now=
): 500328))? --> time_to_ack: 0
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window no=
w: 250164, qlen: 0
> >
> > [5201<->54494]: tcp_recvmsg_locked(->)
> > [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]:     NOT calling tcp_send_ack()
> > [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->r=
cv_wnd: 5812224, tp->rcv_nxt 2818016354
> > [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now:=
 250164, qlen: 0
> >
> > We can see that although we are adverising a window size of zero,
> > tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
> > between this side's and the peer's view of the current window size.
> > - The peer thinks the window is zero, and stops sending.
> > - This side ends up in a cycle where it repeatedly caclulates a new
> >   window size it finds too small to advertise.
> >
> > Hence no messages are received, and no acknowledges are sent, and
> > the situation remains locked even after the last queued receive buffer
> > has been consumed.
> >
> > We fix this by setting tp->rcv_wnd to 0 before we return from the
> > function tcp_select_window() in this particular case.
> > Further testing shows that the connection recovers neatly from the
> > squeeze situation, and traffic can continue indefinitely.
> >
> > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> > ---
> >  net/ipv4/tcp_output.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 9282fafc0e61..57ead8f3c334 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -263,11 +263,15 @@ static u16 tcp_select_window(struct sock *sk)
> >         u32 cur_win, new_win;
> >
> >         /* Make the window 0 if we failed to queue the data because we
> > -        * are out of memory. The window is temporary, so we don't stor=
e
> > -        * it on the socket.
> > +        * are out of memory. The window needs to be stored in the sock=
et
> > +        * for the connection to recover.
> >          */
> > -       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
> > -               return 0;
> > +       if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) =
{
> > +               new_win =3D 0;
> > +               tp->rcv_wnd =3D 0;
> > +               tp->rcv_wup =3D tp->rcv_nxt;
> > +               goto out;
> > +       }
> >
> >         cur_win =3D tcp_receive_window(tp);
> >         new_win =3D __tcp_select_window(sk);
> > @@ -301,7 +305,7 @@ static u16 tcp_select_window(struct sock *sk)
> >
> >         /* RFC1323 scaling applied */
> >         new_win >>=3D tp->rx_opt.rcv_wscale;
> > -
> > +out:
> >         /* If we advertise zero window, disable fast path. */
> >         if (new_win =3D=3D 0) {
> >                 tp->pred_flags =3D 0;
> > --
> > 2.42.0
> >
>
> Any particular reason to not cc Menglong Dong ?
> (I just did)

He is not working at Tencent any more. Let me CC here one more time.

